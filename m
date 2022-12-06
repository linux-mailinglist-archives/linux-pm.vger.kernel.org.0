Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4BC643EF8
	for <lists+linux-pm@lfdr.de>; Tue,  6 Dec 2022 09:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbiLFIqH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Dec 2022 03:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234126AbiLFIqE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Dec 2022 03:46:04 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD36F13D38
        for <linux-pm@vger.kernel.org>; Tue,  6 Dec 2022 00:46:01 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id s7so13264391plk.5
        for <linux-pm@vger.kernel.org>; Tue, 06 Dec 2022 00:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YNugA1dDnZOIsMxbNikeZbANX/9zzf6iXTiRTinSnsE=;
        b=pVLtitn4WZlEcvI0w0IpMlREEGKinwcZ+1JGfNvUXjUIgf0BsFunlv5ORK2xrDCmCk
         meYvKucjxEhAUxVPDuAw+ljqYHf5yXIkwrnvs1L0PPMlhOE0OUiNJa1iXV1j0aSJerD0
         lN7oOmoGNppfFAGyFf5+N2E41+t20iM5I2vXPtSc+asWUXM7B4laH+dAUGiGuvbpB6C5
         LslK0LwxpRH2Pg+9OjUCrE4szeiO9I47XcUXLMdw1agyS7yjLN19AMJsgezv0iTPXAKC
         oFXrUmMVgooYuIDB2HzWQxbe3EXdFWgADnXR1ZUwj8Kneyh2F0KVhmXQOurDw7uF4+jt
         epRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNugA1dDnZOIsMxbNikeZbANX/9zzf6iXTiRTinSnsE=;
        b=Z0lGSSud/v9qSzewiAGsD6E3f8XuZN5SvEXybhsNZoUWodVMHTTee+vDtrvh7eUWYV
         pRJu1Oih+NMLWvcFYX5X8cBX0hknxiigOcQIy4Smx+9+tknuWXme37StU/gJUP+9cocf
         EY9yYeSzR6cPgYNycdYHzfKLfNh4LEi35/QPa8eC9OywBYIErb9GxYqpMhIxFyb9Vk5L
         +Jln9vkQ/eIaPDLSkVnnvA0UJz8JyjiS8W2XSqShV7NhXn0tdyexwDJwkmOOCPz7/izl
         CLkydf4727yb5BJwNFBbuB91XZhJWXX6lqqhwr6YFRktVQF9XMLC6oyOZl9ZzxLLdzXf
         RtOw==
X-Gm-Message-State: ANoB5pnjo8hE9KVP81J4lyAdD61yjPgn29j4KEWSAnx7xNIhxHaI9c5w
        pDpBggPB1NFjUVRVgJOK+S04vg==
X-Google-Smtp-Source: AA0mqf554BXo9LhSwbmQV6pGZWqvO7gXMYaurJFSx9l4cZBzAhs5CeWw0d3DrqbbO9gLX3bcBNc1Dw==
X-Received: by 2002:a17:902:f70c:b0:189:bee:65ee with SMTP id h12-20020a170902f70c00b001890bee65eemr70941927plo.107.1670316361248;
        Tue, 06 Dec 2022 00:46:01 -0800 (PST)
Received: from localhost ([122.172.87.149])
        by smtp.gmail.com with ESMTPSA id k1-20020a170902c40100b001869ba04c83sm12045165plk.245.2022.12.06.00.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 00:46:00 -0800 (PST)
Date:   Tue, 6 Dec 2022 14:15:58 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     ye.xingchen@zte.com.cn
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: stats: Convert to use sysfs_emit_at() API
Message-ID: <20221206084558.kv7y4mmkuccrojgg@vireshk-i7>
References: <202212061615227896127@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202212061615227896127@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06-12-22, 16:15, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> should only use sysfs_emit() or sysfs_emit_at() when formatting the
> value to be returned to user space.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/cpufreq/cpufreq_stats.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> index 1570d6f3e75d..55c7ffd37d1c 100644
> --- a/drivers/cpufreq/cpufreq_stats.c
> +++ b/drivers/cpufreq/cpufreq_stats.c
> @@ -128,25 +128,23 @@ static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
>  	ssize_t len = 0;
>  	int i, j, count;
> 
> -	len += scnprintf(buf + len, PAGE_SIZE - len, "   From  :    To\n");
> -	len += scnprintf(buf + len, PAGE_SIZE - len, "         : ");
> +	len += sysfs_emit_at(buf, len, "   From  :    To\n");
> +	len += sysfs_emit_at(buf, len, "         : ");
>  	for (i = 0; i < stats->state_num; i++) {
>  		if (len >= PAGE_SIZE)
>  			break;
> -		len += scnprintf(buf + len, PAGE_SIZE - len, "%9u ",
> -				stats->freq_table[i]);
> +		len += sysfs_emit_at(buf, len, "%9u ", stats->freq_table[i]);
>  	}
>  	if (len >= PAGE_SIZE)
>  		return PAGE_SIZE;
> 
> -	len += scnprintf(buf + len, PAGE_SIZE - len, "\n");
> +	len += sysfs_emit_at(buf, len, "\n");
> 
>  	for (i = 0; i < stats->state_num; i++) {
>  		if (len >= PAGE_SIZE)
>  			break;
> 
> -		len += scnprintf(buf + len, PAGE_SIZE - len, "%9u: ",
> -				stats->freq_table[i]);
> +		len += sysfs_emit_at(buf, len, "%9u: ", stats->freq_table[i]);
> 
>  		for (j = 0; j < stats->state_num; j++) {
>  			if (len >= PAGE_SIZE)
> @@ -157,11 +155,11 @@ static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
>  			else
>  				count = stats->trans_table[i * stats->max_state + j];
> 
> -			len += scnprintf(buf + len, PAGE_SIZE - len, "%9u ", count);
> +			len += sysfs_emit_at(buf, len, "%9u ", count);
>  		}
>  		if (len >= PAGE_SIZE)
>  			break;
> -		len += scnprintf(buf + len, PAGE_SIZE - len, "\n");
> +		len += sysfs_emit_at(buf, len, "\n");
>  	}
> 
>  	if (len >= PAGE_SIZE) {

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
