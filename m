Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED5311D724A
	for <lists+linux-pm@lfdr.de>; Mon, 18 May 2020 09:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgERHxN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 May 2020 03:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbgERHxN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2020 03:53:13 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B265C05BD09
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2020 00:53:13 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id w19so2116592ply.11
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2020 00:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H+nmyXbDTXJaw998d7ykbBQgRq7RD9hlm9DkRAd6Oi8=;
        b=XEsclj/ATCKjjChaY7dp1vWB6dOCospxZ+RYHwj7BOG9gu2C8VLYpFsj/b9Yh60abK
         Sh2tEsX9dA/ucWzJ1AEqUpUuFS06DoMcCQaZ+NJsR+/Wq2NLdJxOOa+PvtKJFNGFCTYi
         ZS3HHLfN5UFx21uBY5KCKabCzkfJTlmoKqSgeIlCaoweaZcJ89GHRuQWRFqhrqLiw6VE
         kcw0PQgMgo33VUislPbGaCOoCW0Hm8cSUEnePkBRdO+zUfOpbpn0swg2oSt61Oxx3nj5
         MXtXVmMH3GXeFsn0n7gmZDfnNZA8JM0cCGhoraOfJu4b3UTrKdUG13K3I8E/LA7fqTWy
         8W1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H+nmyXbDTXJaw998d7ykbBQgRq7RD9hlm9DkRAd6Oi8=;
        b=AE9NOaehXqIjyQpv5N0KfXn8mpUgdulgmNIThKGF2iCPepq68BD4TTefzpKXC7zJUj
         nJGP5Fp2kuW9LGIzOKpgXy3i5UMU6JHS8O0oM6pkf0Lmb2/sX/CYY8n+NA6foRCXrgcE
         fZnlOaXIdH+8cAQZhnbwK13JSZBwePB2DvemccTo7KikOGLAheL9Kzl/Tgg+evITU797
         PiX4C/bqgoSusVNxKFv9I1w/qcWktF2y6v6vkkm75NAUwoKPi/D4arCfN7haLQr07/Dq
         RN96GzhweLcysppepprTfXfzorTbNOXP26BVZDd8wksgg2hwL016qA0KYQ53KsQC9foy
         RkmQ==
X-Gm-Message-State: AOAM532R+l2WN0GZULaTQJOBJRTL/rfewHFA7G/Ih2/DQeC+kjVwpjfi
        oBIE6dqoSF3hnTp5lMVZ9iMLJg==
X-Google-Smtp-Source: ABdhPJzZsQBojStaYWOlvkhb83DhqJGkkOJWtVW7yvxly47MohiSAENvpRiIsgnA+if2xPLVqJgcwg==
X-Received: by 2002:a17:90a:7309:: with SMTP id m9mr17795943pjk.235.1589788392533;
        Mon, 18 May 2020 00:53:12 -0700 (PDT)
Received: from localhost ([122.167.130.103])
        by smtp.gmail.com with ESMTPSA id y8sm8234037pfg.216.2020.05.18.00.53.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2020 00:53:11 -0700 (PDT)
Date:   Mon, 18 May 2020 13:23:09 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Souvik.Chakravarty@arm.com, Thanu.Rangarajan@arm.com,
        Sudeep.Holla@arm.com, guohanjun@huawei.com, john.garry@huawei.com,
        jonathan.cameron@huawei.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] cpufreq: Add SW BOOST support for drivers
 without frequency table
Message-ID: <20200518075309.xoon4vyfjywmteww@vireshk-i7>
References: <1588929064-30270-1-git-send-email-wangxiongfeng2@huawei.com>
 <1588929064-30270-3-git-send-email-wangxiongfeng2@huawei.com>
 <5858421.kfVlu25t0p@kreacher>
 <7325b64c-85f7-21fe-3860-faa10ab1cf21@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7325b64c-85f7-21fe-3860-faa10ab1cf21@huawei.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sorry for the delay from my side in replying to this thread.

On 15-05-20, 09:49, Xiongfeng Wang wrote:
> On 2020/5/14 22:16, Rafael J. Wysocki wrote:
> > On Friday, May 8, 2020 11:11:03 AM CEST Xiongfeng Wang wrote:
> >> Software-managed BOOST get the boost frequency by check the flag
> >> CPUFREQ_BOOST_FREQ at driver's frequency table. But some cpufreq driver
> >> don't have frequency table and use other methods to get the frequency
> >> range, such CPPC cpufreq driver.
> >>
> >> To add SW BOOST support for drivers without frequency table, we add
> >> members in 'cpufreq_policy.cpufreq_cpuinfo' to record the max frequency
> >> of boost mode and non-boost mode. The cpufreq driver initialize these two
> >> members when probing.
> >>
> >> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> >> ---
> >>  drivers/cpufreq/cpufreq.c | 23 +++++++++++++++--------
> >>  include/linux/cpufreq.h   |  2 ++
> >>  2 files changed, 17 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> >> index 475fb1b..a299426 100644
> >> --- a/drivers/cpufreq/cpufreq.c
> >> +++ b/drivers/cpufreq/cpufreq.c
> >> @@ -2508,15 +2508,22 @@ static int cpufreq_boost_set_sw(int state)
> >>  	int ret = -EINVAL;
> >>  
> >>  	for_each_active_policy(policy) {
> >> -		if (!policy->freq_table)
> >> -			continue;
> >> -
> >> -		ret = cpufreq_frequency_table_cpuinfo(policy,
> >> +		if (policy->freq_table) {
> >> +			ret = cpufreq_frequency_table_cpuinfo(policy,
> >>  						      policy->freq_table);
> >> -		if (ret) {
> >> -			pr_err("%s: Policy frequency update failed\n",
> >> -			       __func__);
> >> -			break;
> >> +			if (ret) {
> >> +				pr_err("%s: Policy frequency update failed\n",
> >> +				       __func__);
> >> +				break;
> >> +			}
> >> +		} else if (policy->cpuinfo.boost_max_freq) {
> >> +			if (state)
> >> +				policy->max = policy->cpuinfo.boost_max_freq;
> >> +			else
> >> +				policy->max = policy->cpuinfo.nonboost_max_freq;
> >> +			policy->cpuinfo.max_freq = policy->max;
> >> +		} else {
> >> +			continue;
> >>  		}
> > 
> > Why do you need to update this function?
> 
> My original thought is to reuse the current SW BOOST code as possible, but this
> seems to change the cpufreq core too much.
> 
> Thanks for your advice. This is better. I will provide a '->set_boost' callback
> for CPPC driver. But I will need to export 'cpufreq_policy_list' and make the
> macro 'for_each_active_policy' public.

This can and should be avoided, I will rather move the for-each-policy
loop in cpufreq_boost_trigger_state() and call ->set_boost() for each
policy and pass policy as argument as well. You would be required to
update existing users of sw boost.

-- 
viresh
