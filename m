Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4921A9898A
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2019 04:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730075AbfHVCk6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Aug 2019 22:40:58 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39289 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbfHVCk6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Aug 2019 22:40:58 -0400
Received: by mail-pg1-f196.google.com with SMTP id u17so2553454pgi.6
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2019 19:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=43GEvCft8nMJFLB+nTdZDz3Ku9zd5Z0S8EKkYV/XwO8=;
        b=nsTgn0i3Th/wy8FgI5cIWRJ4TK9B9ZcN5ZwBL5RTrHOzfv+tJ5DkHxxh2Y2MfFXTS6
         9qSzMul1OGxVPEZRkFJwbvwTc2isJuuCndRh5LOSsLMPqA6kQwdWzVg/jHcjy7kBBAXc
         520tVw6i9X1ejfuKZX32ui11PRTrfLx2VkluXpjUhOXjB8q3CRg+/0jrOUujInsBefNG
         y4xntkRWLpSJxiV9wjTPLXCBwirDSzEK/FkyKj00buDKYJ9Y/imSyqsznneVMfeX9fa7
         zmSlxGz2oQkaxvaGGE5u+ZLrZeYpcXjfQC+dlLxbNy+S7ABCQQMdjV+3qUILX/X9tOji
         /+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=43GEvCft8nMJFLB+nTdZDz3Ku9zd5Z0S8EKkYV/XwO8=;
        b=bmjCwwn/GGPHEYE0Aa3aebjFVgHawZTEer4GYNAbn6nuGhf64OcnMVBd9412r7wKlq
         2nVA7i2m34sqPGk4RxX/G1fB+dekFr8qL0KkXyt80ezt7JlDHLGfTes00sn9EgunulOP
         9IQoIRlzPmVJ65Zr7nhyFYW3MbsbTmRW00eCUNm19/K9V+O7GQUevvhAiV1KZbkccP9w
         RXj1XXpb4FJXA1aBxXoV8MSXSFpoWJmDhmnub5ZG3IBOHv12ara6ItK8xKPGh/guL3TV
         JMrMjyca+rHXNHSGAQr1Xkw7etMRNYc/uBebqlaRcM+637Ffn8k1UiBg52z0kbFrcz5q
         Cy6g==
X-Gm-Message-State: APjAAAUvivmthKbnx2hD4oqfmOCpni1J1N8Ue0gEkKYswwAq7olgYjcJ
        UcfLOIRpTKA8R0hPc+ciYegsUg==
X-Google-Smtp-Source: APXvYqzHtyT3YDd/cLPhVSy+7THC/RtNzvd5nFbExS+j6Yto5pGt1hjPPyeXgBC1QiP5G65qQlOQ/Q==
X-Received: by 2002:a63:ab08:: with SMTP id p8mr404210pgf.340.1566441657106;
        Wed, 21 Aug 2019 19:40:57 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id h42sm1186807pjb.24.2019.08.21.19.40.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2019 19:40:56 -0700 (PDT)
Date:   Thu, 22 Aug 2019 08:10:51 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     agross@kernel.org, rjw@rjwysocki.net, sibis@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH -next] cpufreq: qcom-hw: remove set but not used variable
 'prev_cc'
Message-ID: <20190822024051.eubzzxh3b2ip2gzv@vireshk-i7>
References: <20190821121445.72588-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821121445.72588-1-yuehaibing@huawei.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21-08-19, 20:14, YueHaibing wrote:
> drivers/cpufreq/qcom-cpufreq-hw.c: In function qcom_cpufreq_hw_read_lut:
> drivers/cpufreq/qcom-cpufreq-hw.c:89:38: warning:
>  variable prev_cc set but not used [-Wunused-but-set-variable]
> 
> It is not used since commit 3003e75a5045 ("cpufreq:
> qcom-hw: Update logic to detect turbo frequency")
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index 3eea197..a9ae2f8 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -86,7 +86,7 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
>  				    struct cpufreq_policy *policy,
>  				    void __iomem *base)
>  {
> -	u32 data, src, lval, i, core_count, prev_cc = 0, prev_freq = 0, freq;
> +	u32 data, src, lval, i, core_count, prev_freq = 0, freq;
>  	u32 volt;
>  	struct cpufreq_frequency_table	*table;
>  
> @@ -139,7 +139,6 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
>  			break;
>  		}
>  
> -		prev_cc = core_count;
>  		prev_freq = freq;
>  	}

@Sibi, you fine with this change ? I will merge it with the original patch then.

-- 
viresh
