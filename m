Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8560346204
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 15:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbhCWOz6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Mar 2021 10:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbhCWOzo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Mar 2021 10:55:44 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF39DC061574;
        Tue, 23 Mar 2021 07:55:43 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id s21so10210455pjq.1;
        Tue, 23 Mar 2021 07:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Pg9T2MTEN35QjvsDZjp1LyYPIImInS7zlj/2/HkUfNU=;
        b=teMQr5Fcd/UwSGILs5LErs+LpR2TdrOqbLw1FyqRVh/ln/ts5Pti0tt8xX5QKWfdj3
         usEH3Qh0XEzcZP0XMNWJEgh7A4B7zydYSlvXTlcWz3jNFDrbKUDYZdFWenxEJ5CCPRk1
         cJ2ckhIIXYuBK1OyHpbtbgdcBlOjBJ9l056kQrW8ZOBlFffnAprwfZ7on2P1ITTGNU8P
         vawOkD+Y4S2p7SOHFKsXMzWcOE/EUnZNcTRoy+hFWKrhL1EZ9BqAXg+yemvFaJK1naWv
         6HD7zP9p8CD0Ei/GQQTt2zjKuLpUUtLWvpr7dsKsoEfAnEFjZNCxz3gr50GiNkE1T/oo
         RT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Pg9T2MTEN35QjvsDZjp1LyYPIImInS7zlj/2/HkUfNU=;
        b=d/i6p//3RJKPZpzRjFp2AV+b3bzjNM2hphYO/rlQw+5XNfsB3v9nObZCbY6wy2dSF/
         7YQZq3zr9ODWbF8U2LkV/sRyxJuwZwv3KuHLLRFgnORVOhqinyN/HaKmDlApf0Te9qYi
         khh8Sp1lFd+ENNxqGmgG1f2YMewg9SjJrX6r05pGgzLftskpqv9ypiSbOlXv+4DHLmYf
         dsrF9KYZXHV7Ea5V4UinLSVYBObf3w/x13zrO61iN2feWfXx1DKt8alzWb3f48O/dP77
         XU3SBYQvfnaBawEafD+bG3kidwMlyYmrvuQE8gXph8xQj5QkWjYtIbc851gSlQwC1th/
         sQtg==
X-Gm-Message-State: AOAM531TaVdZ71GfaAukFnPA0PKOl84s+2N4pap6fIDgI7kF81nqKdkc
        dr3n7t7i6CfIM/oHp1xj08s=
X-Google-Smtp-Source: ABdhPJyxFiJrgCyjQEDE253x6kG2zm9pSYy9DgFzXowidPQ6wIgHswHb9G6SgMAnhaGtFxkXm1mTsw==
X-Received: by 2002:a17:90a:5d09:: with SMTP id s9mr4757401pji.172.1616511343106;
        Tue, 23 Mar 2021 07:55:43 -0700 (PDT)
Received: from [172.30.1.19] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id v18sm17567538pfn.117.2021.03.23.07.55.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 07:55:42 -0700 (PDT)
Subject: Re: [PATCH V2 RESEND 1/4] PM / devfreq: Use more accurate returned
 new_freq as resume_freq
To:     Dong Aisheng <aisheng.dong@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     dongas86@gmail.com, kernel@pengutronix.de, shawnguo@kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, abel.vesa@nxp.com
References: <1616484011-26702-1-git-send-email-aisheng.dong@nxp.com>
 <1616484011-26702-2-git-send-email-aisheng.dong@nxp.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <c7242528-42a3-a799-c542-66867486c330@gmail.com>
Date:   Tue, 23 Mar 2021 23:55:37 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1616484011-26702-2-git-send-email-aisheng.dong@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21. 3. 23. 오후 4:20, Dong Aisheng wrote:
> Use the more accurate returned new_freq as resume_freq.
> It's the same as how devfreq->previous_freq was updated.
> 
> Fixes: 83f8ca45afbf0 ("PM / devfreq: add support for suspend/resume of a
> devfreq device")
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>   drivers/devfreq/devfreq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index b6d3e7db0b09..85927bd7ee76 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -388,7 +388,7 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
>   	devfreq->previous_freq = new_freq;
>   
>   	if (devfreq->suspend_freq)
> -		devfreq->resume_freq = cur_freq;
> +		devfreq->resume_freq = new_freq;
>   
>   	return err;
>   }
> 

Applied it.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
