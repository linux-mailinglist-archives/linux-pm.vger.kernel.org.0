Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9CE5332B0E
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 16:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhCIPyK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 10:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbhCIPxn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Mar 2021 10:53:43 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CBBC06174A;
        Tue,  9 Mar 2021 07:53:43 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso5427531pjb.3;
        Tue, 09 Mar 2021 07:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XTQS0aC3ey6iJ5CioVwvjyd2BBYlfManBKXsa0QRx38=;
        b=N2VU1bE2NI0JllfDLBDTjxn6GpHBmKr1208qsPb2633LxmyDpjKeFG87S8ZLoXw5W1
         NeOErweovjja04p9BUE1j+U8LlD1JXTQdZn0EWbl72ZsyM2LLkjLNUw+vLn63kOupDbn
         cH/HjFSRLdUJz8dALKkOjrZJVSiV6f2W7NNEABSEYeinPNDM9gC8kMLQ8YdFHCInNbBI
         voIpfXkrPj/UNndN6u0ODW7XJzKvboiDwzJeC9bMtlseMOByOXif50B4cCVRLaksPSfB
         MPQ29b9kC6vls/8UDDf4OVMl4TN6r6KQjmaIMXyso8vO6cBvr1uuS/UVgv7ugSHk+mUe
         aA1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XTQS0aC3ey6iJ5CioVwvjyd2BBYlfManBKXsa0QRx38=;
        b=Ma8enpBRHGTtOWpxuEWS6ITVS2LQEQVunYrQRXbFUTV5sabfjnqPtpvXsw0A4oLNl+
         U78vu5hd23WgDmDUC621SsBiMwlELPGTIBxJPV7HussPi08OrGekZhR+2GDpBxNxNIKp
         w5y2R+mHkUV+3sgNsO6hcZdZS+ahP2JTQlseBTkSf2NDmdnCgoH0GWeOjv4fGUmGNqLk
         RmemWaO6CcRWFGnYkH4uUB4qcFVL7xILLfrL6jp0CsPv9u/L9Y/XYO5C5Tf6vTPg3ADU
         JocZ2/hLtvwNmrJwajdD+lO1WQtvTfrzLXi4hPh3x8JAOMU5f9Q7kbB9xZmR0vnLBPBx
         whcg==
X-Gm-Message-State: AOAM533g6LGHfhaitaUcJ5Y17NNCIfkbFLoXVXFwS8MZRcPD54/HfuIF
        XrW1jE39OIfsKMMqVBlGy1w=
X-Google-Smtp-Source: ABdhPJwSX8n16QaBIIKFvWEyLq3CvrFuMfoFjsnbbRN31EnAPKwunPWxeewBvXTHkj6XyqkVrEdwIA==
X-Received: by 2002:a17:90b:344c:: with SMTP id lj12mr5490610pjb.208.1615305222453;
        Tue, 09 Mar 2021 07:53:42 -0800 (PST)
Received: from [172.30.1.19] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id x9sm3313983pjp.29.2021.03.09.07.53.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 07:53:41 -0800 (PST)
Subject: Re: [PATCH 05/11] PM / devfreq: use more accurate returned new_freq
 as resume_freq
To:     Dong Aisheng <aisheng.dong@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     dongas86@gmail.com, kernel@pengutronix.de, shawnguo@kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, abel.vesa@nxp.com
References: <1615294733-22761-1-git-send-email-aisheng.dong@nxp.com>
 <1615294733-22761-6-git-send-email-aisheng.dong@nxp.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <83240e9d-383a-74a9-3222-68cf42d3d0e1@gmail.com>
Date:   Wed, 10 Mar 2021 00:53:35 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1615294733-22761-6-git-send-email-aisheng.dong@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21. 3. 9. 오후 9:58, Dong Aisheng wrote:
> Use the more accurate returned new_freq as resume_freq.
> It's the same as how devfreq->previous_freq was updated.
> 
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>   drivers/devfreq/devfreq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 6e80bf70e7b3..ce569bd9adfa 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -390,7 +390,7 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
>   	devfreq->previous_freq = new_freq;
>   
>   	if (devfreq->suspend_freq)
> -		devfreq->resume_freq = cur_freq;
> +		devfreq->resume_freq = new_freq;
>   
>   	return err;
>   }
> 

This patch fixes the previous patch[1]. So that you need to
add 'Fixes' tag as following:

Fixes: 83f8ca45afbf0 ("PM / devfreq: add support for suspend/resume of a 
devfreq device")

commit 83f8ca45afbf041e312909f442128b99657d90b7
Refs: v4.20-rc6-2-g83f8ca45afbf
Author:     Lukasz Luba <lukasz.luba@arm.com>
AuthorDate: Wed Dec 5 12:05:53 2018 +0100
Commit:     MyungJoo Ham <myungjoo.ham@samsung.com>
CommitDate: Tue Dec 11 11:09:47 2018 +0900

     PM / devfreq: add support for suspend/resume of a devfreq device


-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
