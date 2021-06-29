Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9880E3B6E2E
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jun 2021 08:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbhF2GU3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Jun 2021 02:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbhF2GU3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Jun 2021 02:20:29 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA737C061574
        for <linux-pm@vger.kernel.org>; Mon, 28 Jun 2021 23:18:01 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso1338928pjx.1
        for <linux-pm@vger.kernel.org>; Mon, 28 Jun 2021 23:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hI1DeZ2pRK8aek3pSY+ZixxRt/uy7BhVNJwpyrPvK4U=;
        b=kVGPtew0Kx8eTy5szjyeACr/mtbC6DaMpT7oBhHleodDrSuAeIPnJJRJg/8ULx/Ug4
         miyM9Y33Nk8kTSd2gcZOEIK+yD2NbSqh1RWOiZCs1+2FjnZrn/UXhe7gt/OSDAcpS5iE
         gjWx5+xrYvSW8yx7Px8yi5+1T2pdpX7XR1E9lqBBhZZj9oI8vSih+hYfMSWylFGsdnl6
         1c/pZREkNYk7Hza1b1ZEw3wzjm5ou/k7B6cmPI0b+6O8dlCBOKJa6TembetnP+L8Ewoy
         DGIp5sYYtPHfcBSEY8iUzYqovqxQsAjPVoaoUUEMInLIGzvI848yhX7Ot/W4dQgJJxiE
         jQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hI1DeZ2pRK8aek3pSY+ZixxRt/uy7BhVNJwpyrPvK4U=;
        b=M5L648BK5iz3b9rXWH9FWVvEP/pojOaEpnNvGjkpjr2DAOopoRNwbZZHexyott/oBU
         F88t8Mj35/s55Gr05ZkovBAXfXb20vKct1jJanHjJ1Kis5S3vOHa6KvsPW4F9zSTIGLx
         CpE7i97tH/yjadgFiGKZwaj/kXi2XHDPE4wKIQXC4wDm/za163zWDz7EiAxGO7PwS+fL
         +h3aglB4pZXizrtYrEgVAn57z1v3/s0NTAR5ilZSLcDuNBrolNZaZnvhi8i4t/WmJB8x
         pe+8t2YoILQHaduwncg8BPA0SAKeZ2gONCvKFbRNNqgv2lTMgue5suWmzToEitfYYRJF
         6pgg==
X-Gm-Message-State: AOAM5332SyJ7XY2fcBGTMeUiyJ2ndqzlJEpsFB2PLcRPUh95wiGr7lrH
        eOoupEo7dphj/lxdhtKR1NsAWw==
X-Google-Smtp-Source: ABdhPJyfVA20O8oNr9ThebtXXkg4YVGPQnBLR6jQoWQ0+A/rjn+bS5SKjwFuYmN2Dc2Yxk82ratFFw==
X-Received: by 2002:a17:90a:ba91:: with SMTP id t17mr43507438pjr.89.1624947481144;
        Mon, 28 Jun 2021 23:18:01 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id fv8sm17093546pjb.21.2021.06.28.23.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 23:18:00 -0700 (PDT)
Date:   Tue, 29 Jun 2021 11:47:58 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     TungChen Shih <tung-chen.shih@mediatek.com>
Cc:     rjw@rjwysocki.net, matthias.bgg@gmail.com,
        wsd_upstream@mediatek.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 1/1] cpufreq: fix the target freq not in the range of
 policy->min & max
Message-ID: <20210629061758.wdavb2a4bpklmqi3@vireshk-i7>
References: <20210626162324.8236-1-tung-chen.shih@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210626162324.8236-1-tung-chen.shih@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27-06-21, 00:23, TungChen Shih wrote:
>     The function cpufreq_driver_resolve_freq() should return the lowest

Don't add extra spaces at the beginning of paragraphs here.

> supported freq greater than or equal to the given target_freq, subject
> to policy (min/max) and driver limitations. However, the index returned
> by cpufreq_frequency_table_target() won't subject to policy min/max in
> some cases.
> 
>     In cpufreq_frequency_table_target(), this function will try to find
> an index for @target_freq in freq_table, and the frequency of selected
> index should be in the range [policy->min, policy->max], which means:
> 
>     policy->min <= policy->freq_table[idx].frequency <= policy->max
> 
>     Though "clamp_val(target_freq, policy->min, policy->max);" would
> have been called to check this condition, when policy->max or min is
> not exactly one of the frequency in the frequency table,
> policy->freq_table[idx].frequency may still go out of the range
> 
>     For example, if our sorted freq_table is [3000, 2000, 1000], and
> suppose we have:
> 
>     @target_freq = 2500
>     @policy->min = 2000
>     @policy->max = 2200
>     @relation = CPUFREQ_RELATION_L
> 
> 1. After clamp_val(target_freq, policy->min, policy->max); @target_freq
> becomes 2200
> 2. Since we use CPUFREQ_REALTION_L, final selected freq will be 3000 which
> beyonds policy->max

Right so the problem does exist, and not only with
cpufreq_driver_resolve_freq(), but __cpufreq_driver_target() as well.
I have a sent a patchset to update both of these to start sharing some
code and we need to fix this for both now.

> Signed-off-by: TungChen Shih <tung-chen.shih@mediatek.com>
> ---
>  drivers/cpufreq/cpufreq.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 802abc925b2a..8e3a17781618 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -544,8 +544,23 @@ unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
>  	if (cpufreq_driver->target_index) {
>  		unsigned int idx;
>  
> +		/*  to find the frequency >= target_freq */
>  		idx = cpufreq_frequency_table_target(policy, target_freq,
>  						     CPUFREQ_RELATION_L);
> +
> +		/* frequency should subject to policy (min/max) */
> +		if (policy->freq_table[idx].frequency > policy->max) {
> +			if (policy->freq_table_sorted == CPUFREQ_TABLE_SORTED_ASCENDING)
> +				idx--;
> +			else
> +				idx++;
> +		} else if (policy->freq_table[idx].frequency < policy->min) {
> +			if (policy->freq_table_sorted == CPUFREQ_TABLE_SORTED_ASCENDING)
> +				idx++;
> +			else
> +				idx--;
> +		}

This doesn't look clean to be honest.

Rafael, does it make sense to update cpufreq_frequency_table_target()
(and its internal routines) to take policy bounds in consideration, or
something else ?

-- 
viresh
