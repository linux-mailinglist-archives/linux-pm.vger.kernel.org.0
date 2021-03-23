Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 593E3346236
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 16:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbhCWPCW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Mar 2021 11:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbhCWPB7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Mar 2021 11:01:59 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82A2C061574;
        Tue, 23 Mar 2021 08:01:58 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 32so5846295pgm.1;
        Tue, 23 Mar 2021 08:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bFOCHFJPloDw67NJ81ewTedNKNKxkohzX66rmLNB7iY=;
        b=RiK4mI43iBOwcJFD830zdBAQvtsQL6RKQyzwygB5BSKNCtzCroVFkdV0E+b8ir6Tb8
         5xNoKmQ5i184YkjK/3vnwQfnfrW8TerXr58g1jBDCS0/O4YLfe+JEH8cKGhsPUnnq0vR
         e1zKQC7yrk07xo2TbjS9GM9NnSEjEQzNHGm7FgOscVE+n++7+6S2hD0kqgwJSKHe+cdX
         k4XG3qWRdg6XBuI73mSJqtJfEslXwdmpLT4+/T7eagBRr4OQPBSU2PQPurlZAZvBfBrA
         okEut89QTzuYM9yPU5dBkKvhfne5ycYq5H2z05uNT8zAhy5UGH4mQ+36I/Hy6ZujGfyd
         PIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bFOCHFJPloDw67NJ81ewTedNKNKxkohzX66rmLNB7iY=;
        b=tpRx9MY2tQoHH+KVZGJovfszHVXR/L0/Stu6jqxqXGIf4EiqN0kpxNxwHKTtGt4HuV
         C7Y1GRB/L0kefFxxFoOWnH1Xg08qLbf+UrEH8+OHhgnGHuK7vvu+NGWxChliFyu2EYEr
         8kglgVlZbMYtBHRupzzJ9pZj9yQbU+UiW06F5iV1LOsMI0xI7dGCxaylWEiMI2ZGpV0w
         Nv0woTvWQdhipNZh0S8ipcQycRgvVgY9z7qTuGyMxnIUwkR8LOeY6Jev9nEPMDIaxEXD
         G3kDLEymy/ynP/5tglFI1g0yvaweIEf2wMCl5+YAGyBm15bFoouqaxxZffFyelXN+3Eo
         Kunw==
X-Gm-Message-State: AOAM532gBifU6RCxbdLIlqViy6m0Y5Dp12rJR5Jrlftc2eyIIDV1CQnQ
        AHyBxDO20Cm7gzW0dcc4gs4=
X-Google-Smtp-Source: ABdhPJypvTczi9H9pjX/yUizgXNlAQSbIMDgC5hFSEfxEnNKElrQpeR2AIl5QvN6XFjZsxplfQU1ig==
X-Received: by 2002:a62:1594:0:b029:1f1:5ede:5245 with SMTP id 142-20020a6215940000b02901f15ede5245mr5361892pfv.6.1616511718242;
        Tue, 23 Mar 2021 08:01:58 -0700 (PDT)
Received: from [172.30.1.19] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id e65sm18316419pfe.9.2021.03.23.08.01.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 08:01:57 -0700 (PDT)
Subject: Re: [PATCH V2 RESEND 3/4] PM / devfreq: bail out early if no freq
 changes in devfreq_set_target
To:     Dong Aisheng <aisheng.dong@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     dongas86@gmail.com, kernel@pengutronix.de, shawnguo@kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, abel.vesa@nxp.com
References: <1616484011-26702-1-git-send-email-aisheng.dong@nxp.com>
 <1616484011-26702-4-git-send-email-aisheng.dong@nxp.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <3054611c-4f43-8432-bd14-1733ab82804b@gmail.com>
Date:   Wed, 24 Mar 2021 00:01:52 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1616484011-26702-4-git-send-email-aisheng.dong@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21. 3. 23. 오후 4:20, Dong Aisheng wrote:
> It's unnecessary to set the same freq again and run notifier calls.
> 
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>   drivers/devfreq/devfreq.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 85927bd7ee76..a6ee91dd17bd 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -352,13 +352,16 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
>   {
>   	struct devfreq_freqs freqs;
>   	unsigned long cur_freq;
> -	int err = 0;
> +	int err;
>   
>   	if (devfreq->profile->get_cur_freq)
>   		devfreq->profile->get_cur_freq(devfreq->dev.parent, &cur_freq);
>   	else
>   		cur_freq = devfreq->previous_freq;
>   
> +	if (new_freq == cur_freq)
> +		return 0;

cur_freq is one of the OPP frequencies. But, new_freq is calculated from
governor algorithm. It means that new_freq is not one of the
frequencies. Actually, it is not efficient.

After devfreq->profile->target() which almost uses
devfreq_recommended_opp(), new_freq is one of OPP frequencies.

> +
>   	freqs.old = cur_freq;
>   	freqs.new = new_freq;
>   	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_PRECHANGE);
> @@ -375,7 +378,7 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
>   	 * and DEVFREQ_POSTCHANGE because for showing the correct frequency
>   	 * change order of between devfreq device and passive devfreq device.
>   	 */
> -	if (trace_devfreq_frequency_enabled() && new_freq != cur_freq)
> +	if (trace_devfreq_frequency_enabled())
>   		trace_devfreq_frequency(devfreq, new_freq, cur_freq);
>   
>   	freqs.new = new_freq;
> @@ -390,7 +393,7 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
>   	if (devfreq->suspend_freq)
>   		devfreq->resume_freq = new_freq;
>   
> -	return err;
> +	return 0;
>   }
>   
>   /**
> 


-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
