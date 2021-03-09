Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B01332AFA
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 16:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbhCIPsG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 10:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbhCIPrq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Mar 2021 10:47:46 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB1FC06174A;
        Tue,  9 Mar 2021 07:47:46 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id w7so3284014pll.8;
        Tue, 09 Mar 2021 07:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SdbWLauHZPc6u4Mx3ysIBEeU7QGCIx7AKGpPTrmJ2E8=;
        b=dgeqe78ksFCHm0AeSIQvZRcc2aFaU8fG+MkkEGnfiD27B0RiMcutVkm4UOxJ7aaPAt
         EyoEa+megMMCmPYPH6xXnE4dqeqOkpdfp3OaA6dnxaFvjzGUbv+vDJ7w/8LSktscmLNy
         8cy9FrgaeuAt0LTNZQ4bL8RX3AC2Gj2DUcl6aJaZKp7tdzzNcdy+4AlFVgCqfutp2gQ0
         rNxmg6+Iat1pVHFZvMs/Hm77fUGfSBoUr0l5lNSNYrp7ZJYka7Vgz2XwROZx9lDAT9D8
         FcBfEpxpDrf9Gp0Oowur60Sn6yyKOLQg/ERnmeKcTkqUV5HCTsdMM5jIEBWFN4GCpd4M
         9L7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SdbWLauHZPc6u4Mx3ysIBEeU7QGCIx7AKGpPTrmJ2E8=;
        b=uc8W6qDjLGpPwx2jQ0Yy99KMiBiSSMophcUFuzGRVkBtDKU8wELlmkFAbUiJUkjEDa
         z34g72eSWRSRm0I9pm6/OZ8wy8obrGrfiZJSDBT1HzuPcznuUJMeoim1nDjOIjo9kV/J
         TPbPxhD9bq2dBlE8Pr62CixcdOiPW3kimj6euZnbkefjTua2obu2yVoG3vPLxWARVF3c
         y67zMGZvvFvRMqCZ1F+Bwt+wZm7Hb23uBLtW3H/J0EFEyYyzmVab55iqoUFDKciA+vg/
         nMVg027TLKypuMNTqCaNfj0GC+IW7gfgYMXaE5f9QWE3bFoWPO5hP5ymz1OSgBuamtxm
         CsrA==
X-Gm-Message-State: AOAM531eZgQYPVVIAbndSB8JIb47sQ34BamjBivP00dejX2gjivFBqxo
        d0To6jbFecUcZ4K+X8bFcBw=
X-Google-Smtp-Source: ABdhPJzCQ9iSADJ6pw37Q4ShFb6QS8konk8Lyxo/7WHyubZZ3LpshUbzYh0qlp0OooUCrjN6N9lATA==
X-Received: by 2002:a17:90b:4b87:: with SMTP id lr7mr5007612pjb.5.1615304865772;
        Tue, 09 Mar 2021 07:47:45 -0800 (PST)
Received: from [172.30.1.19] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id w18sm3280866pjh.19.2021.03.09.07.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 07:47:43 -0800 (PST)
Subject: Re: [PATCH 04/11] PM / devfreq: bail out early if no freq changes in
 devfreq_set_target
To:     Dong Aisheng <aisheng.dong@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     dongas86@gmail.com, kernel@pengutronix.de, shawnguo@kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, abel.vesa@nxp.com
References: <1615294733-22761-1-git-send-email-aisheng.dong@nxp.com>
 <1615294733-22761-5-git-send-email-aisheng.dong@nxp.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <b6de03c9-8744-90b2-11fe-914ef016fa1f@gmail.com>
Date:   Wed, 10 Mar 2021 00:47:39 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1615294733-22761-5-git-send-email-aisheng.dong@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21. 3. 9. 오후 9:58, Dong Aisheng wrote:
> It's unnecessary to set the same freq again and run notifier calls.
> 
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>   drivers/devfreq/devfreq.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index bf3047896e41..6e80bf70e7b3 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -358,6 +358,9 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
>   	else
>   		cur_freq = devfreq->previous_freq;
>   
> +	if (new_freq == cur_freq)
> +		return 0;
> +
>   	freqs.old = cur_freq;
>   	freqs.new = new_freq;
>   	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_PRECHANGE);
> @@ -374,7 +377,7 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
>   	 * and DEVFREQ_POSTCHANGE because for showing the correct frequency
>   	 * change order of between devfreq device and passive devfreq device.
>   	 */
> -	if (trace_devfreq_frequency_enabled() && new_freq != cur_freq)
> +	if (trace_devfreq_frequency_enabled())
>   		trace_devfreq_frequency(devfreq, new_freq, cur_freq);
>   
>   	freqs.new = new_freq;
> 

I'd like you to squash patch4 with patch6 because actually patch6
is too minor clean-up. I think it is possible.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
