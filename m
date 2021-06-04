Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA5C39BF8E
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jun 2021 20:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbhFDS1j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Jun 2021 14:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhFDS1j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Jun 2021 14:27:39 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102DAC061766
        for <linux-pm@vger.kernel.org>; Fri,  4 Jun 2021 11:25:53 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id n12so8500863pgs.13
        for <linux-pm@vger.kernel.org>; Fri, 04 Jun 2021 11:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1iutjXdzSDz60yK5yptwcO1OWCtwl1Aaa7EE0plXKis=;
        b=fhiFntph4mOYbFmSmBRTur3N3GngTOQPeFdW4RU1cqSS3TmgChIytiQITQSy8Kz0l6
         Orsw2S2aifH0d++5sVtbgHnSfllw2O0thKp5MUq1+7Skdlc+86iC9BnmS4DupRiRKT7l
         mvKPCc0rvp+H7JQtsr+tBxcV1Gbm4iE2ywm7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1iutjXdzSDz60yK5yptwcO1OWCtwl1Aaa7EE0plXKis=;
        b=EN5XXpNbfe/Bz4Hvaq1brJ3ckrZNQKzA0hrBfp2BLK0LwL6xONe9sFUimurPgZ4wXw
         Skl7ytN3COTR62oaBhzXh73Gl1P5nNHD5JeBdyvCglNnVioY8AnhiOs+HFzcFS0rbM/T
         cGHY2i1rBXMLmp2MevAMulqNtREgF8RtNBW3JzLCbCBzGvzpbghcRn5Dqr9u2X8BwWud
         P6jBAUeGMrlhv4Nq011CUZCwovOqNP4NfcLNYjT/UcPoWuGAw0LmpsWqoJCkVzDfOb7M
         9+encxKnPWAmBSctTwdMQ6NschixOcQdOXhAEXY5KJv0/FMLWyuT1dzEI2zXdl5FRJXm
         Qd4Q==
X-Gm-Message-State: AOAM532MfYqWm3nC2KII7NbmmJvEbuknCyftprQa28cDfr89rwWLNjAS
        wwB7ly4AkxC1lTRJ8D9JkWLEwA==
X-Google-Smtp-Source: ABdhPJyx56utoABxrtPwrftR5F4VhsO0O9lI9cy89divnxJxqdCL0kaTpdjFiyLMPAXDXfP/TXGowg==
X-Received: by 2002:a05:6a00:1a4f:b029:2e0:754b:88c2 with SMTP id h15-20020a056a001a4fb02902e0754b88c2mr5931377pfv.65.1622831152526;
        Fri, 04 Jun 2021 11:25:52 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:1cfa:4a0b:c513:8c09])
        by smtp.gmail.com with UTF8SMTPSA id g8sm2491177pgo.10.2021.06.04.11.25.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 11:25:52 -0700 (PDT)
Date:   Fri, 4 Jun 2021 11:25:50 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com
Subject: Re: [PATCH v3 4/6] cpufreq: Skip inefficient frequencies in
 cpufreq_driver_resolve_freq()
Message-ID: <YLpwLuXdO3QIbAHn@google.com>
References: <1622804761-126737-1-git-send-email-vincent.donnefort@arm.com>
 <1622804761-126737-5-git-send-email-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1622804761-126737-5-git-send-email-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 04, 2021 at 12:05:59PM +0100, Vincent Donnefort wrote:
> Avoid using frequencies marked as inefficient. This change affects
> schedutil, which is the only in-tree governor using the function
> cpufreq_driver_resolve_freq().
> 
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 802abc9..7431f40a 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -546,6 +546,10 @@ unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
>  
>  		idx = cpufreq_frequency_table_target(policy, target_freq,
>  						     CPUFREQ_RELATION_L);
> +
> +		/* Replace the target with an efficient one */
> +		idx = cpufreq_frequency_find_efficient(policy, idx);
> +
>  		policy->cached_resolved_idx = idx;
>  		return policy->freq_table[idx].frequency;
>  	}
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index d10784c..0ca4c9a 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -994,6 +994,17 @@ static inline int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
>  	}
>  }
>  
> +static inline unsigned int
> +cpufreq_frequency_find_efficient(struct cpufreq_policy *policy,
> +				 unsigned int idx)
> +{
> +	struct cpufreq_frequency_table *table = policy->freq_table;
> +	unsigned int efficient_idx = table[idx].efficient;
> +
> +	return table[efficient_idx].frequency <= policy->max ? efficient_idx :
> +							       idx;
> +}
> +
>  static inline int cpufreq_table_count_valid_entries(const struct cpufreq_policy *policy)
>  {
>  	struct cpufreq_frequency_table *pos;

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
