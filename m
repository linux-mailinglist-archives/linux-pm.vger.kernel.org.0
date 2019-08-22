Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C910298B22
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2019 08:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731570AbfHVGB6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Aug 2019 02:01:58 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41984 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730569AbfHVGB5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Aug 2019 02:01:57 -0400
Received: by mail-pg1-f195.google.com with SMTP id p3so2867073pgb.9
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2019 23:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IGOK/aeV6wllM58ymB1HOVxByK2+4raXwd9FqZiG31g=;
        b=A6wBWaxdm4l0kPg3WfejXZYMtZSZkafevVrK68W4QcP39sJ+oJ3ScykX9C6MMenFI9
         AAGksjnnQmDD8Sm6eTz9jIrMjeqN02yrRa4m7Nb6In1ryQa3OGETXk1XMXgbjYuEgmRt
         Fd6rjqCxGNiBqSxHFhVFX+xzxUM2yhpqsVsqi1weXRzFmZv5RN6JBCSuQ6UR77OnGdQ0
         SkSwPHRHVM1Gob6a18uzwN1D4MTA05jQ8aNqUShPb3SVBm25EgljzfSrE84Atp07O3jv
         lBaTY1FCIcOfOji/B2qAxZjw6zDg5mNcxEnu+YIeVbDNZRJYJ0wcsKCxQVvrtaZyQ39C
         pxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IGOK/aeV6wllM58ymB1HOVxByK2+4raXwd9FqZiG31g=;
        b=uan7FFAcVFQ+VwYJVqaCR8tuh2IclJTAGn2EFyF9yjAuYbsHVBoq1RrOr82a1dYMxA
         MrM23PFd7pNoEIRJEBeXQj40utszaLMPoiotcIH29i87gzqUDRHi2itj555ICx8/ZtmV
         Z5thv3KncaBNi/Se8erSnjNkOXQncgktyTokMqEgCwK0GEu3Nw3nx73EuJ/o0kxpFgr0
         suSeQAtrTac/MzUap3OhxWvFsUt6Svs4oI2D4EnCup0UxXxovYP33NYMKThqwU7IGQJI
         m5zpTZEaO/LGkfNAiUKbNlky0q/QK7QUsJr3zFo+RvdLUazgbzQPid9WmaIa7ax3zCB7
         WFAQ==
X-Gm-Message-State: APjAAAWxSIl3dWsg7B8dZE0GsKZMqMJtDKdnaZWn5LELVMtcuKHhbP8X
        ZWBrem2u0IMebmoWU5DTqXA+fA==
X-Google-Smtp-Source: APXvYqxv4NVeiFvjfAZaGPzviWL08bYWazxBVM3wDB/0/GBKJdrmVajkKdL44cHCfgPLd9Kxn9tb6A==
X-Received: by 2002:a63:6901:: with SMTP id e1mr31280923pgc.390.1566453716840;
        Wed, 21 Aug 2019 23:01:56 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id q10sm31712808pfl.8.2019.08.21.23.01.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2019 23:01:55 -0700 (PDT)
Date:   Thu, 22 Aug 2019 11:31:53 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     YueHaibing <yuehaibing@huawei.com>, agross@kernel.org,
        rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH -next] cpufreq: qcom-hw: remove set but not used variable
 'prev_cc'
Message-ID: <20190822060153.gasv4okmeuvbtmbi@vireshk-i7>
References: <20190821121445.72588-1-yuehaibing@huawei.com>
 <20190822024051.eubzzxh3b2ip2gzv@vireshk-i7>
 <6c485d00652f873b98664ff211e496cd@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c485d00652f873b98664ff211e496cd@codeaurora.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 22-08-19, 10:25, Sibi Sankar wrote:
> @YueHaibing thanks for the patch.
> 
> On 2019-08-22 08:10, Viresh Kumar wrote:
> > On 21-08-19, 20:14, YueHaibing wrote:
> > > drivers/cpufreq/qcom-cpufreq-hw.c: In function
> > > qcom_cpufreq_hw_read_lut:
> > > drivers/cpufreq/qcom-cpufreq-hw.c:89:38: warning:
> > >  variable prev_cc set but not used [-Wunused-but-set-variable]
> > > 
> > > It is not used since commit 3003e75a5045 ("cpufreq:
> > > qcom-hw: Update logic to detect turbo frequency")
> > > 
> > > Reported-by: Hulk Robot <hulkci@huawei.com>
> > > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > > ---
> > >  drivers/cpufreq/qcom-cpufreq-hw.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c
> > > b/drivers/cpufreq/qcom-cpufreq-hw.c
> > > index 3eea197..a9ae2f8 100644
> > > --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> > > +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> > > @@ -86,7 +86,7 @@ static int qcom_cpufreq_hw_read_lut(struct device
> > > *cpu_dev,
> > >  				    struct cpufreq_policy *policy,
> > >  				    void __iomem *base)
> > >  {
> > > -	u32 data, src, lval, i, core_count, prev_cc = 0, prev_freq = 0,
> > > freq;
> > > +	u32 data, src, lval, i, core_count, prev_freq = 0, freq;
> > >  	u32 volt;
> > >  	struct cpufreq_frequency_table	*table;
> > > 
> > > @@ -139,7 +139,6 @@ static int qcom_cpufreq_hw_read_lut(struct
> > > device *cpu_dev,
> > >  			break;
> > >  		}
> > > 
> > > -		prev_cc = core_count;
> > >  		prev_freq = freq;
> > >  	}
> > 
> > @Sibi, you fine with this change ? I will merge it with the original
> > patch then.
> 
> yes the changes seem fine, I missed
> removing prev_cc.

Thanks. Merged into the original patch itself.

-- 
viresh
