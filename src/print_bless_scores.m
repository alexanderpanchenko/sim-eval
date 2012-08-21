function print_bless_scores(p10, p20, p50, f50, k_p80, r_p80, f_p80, map20, map50, r50, n10, n20, n50)
% This function prints in a formatted way the scores provided by the function get_bless_scores
    %if(nargin < 14) c = 1; end
        
    fprintf('Precision(10)=%f\nPrecision(20)=%f\nPrecision(50)=%f\nFmeasure(50)=%f\nRecall(50)=%f\n',...
        p10, p20, p50, f50, r50);        
    %fprintf('k@Precision80=%f\nRecall@Precision80=%f\nFmeasure@Precision80=%f\n',...
    %    k_p80, r_p80, f_p80);      
    fprintf('MAP(20)=%f\nMAP(50)=%f\n', map20, map50);        
    fprintf('Number(10)=%.0f\nNumber(20)=%.0f\nNumber(50)=%.0f\n', n10, n20, n50);
end