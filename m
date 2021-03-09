Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98421332BE0
	for <lists+linux-pm@lfdr.de>; Tue,  9 Mar 2021 17:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhCIQXX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 11:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbhCIQXN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Mar 2021 11:23:13 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E11C06174A;
        Tue,  9 Mar 2021 08:23:13 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id ba1so6844410plb.1;
        Tue, 09 Mar 2021 08:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=spUY8lyLrO5xdVbAHEgZwfYUMMR7eoWtx3a0hWF14KY=;
        b=sRkVb8sM0kdiaK+Pgzbm64V8G2smL5F6eKgu2SfEqARNDY7oPuOEZIAlOhBX/5xvKT
         +qfvsuc0YGxH3aXUuXOA4iVD2Aum/kd00Rquct/oBweu3o7yhcO7iKKp3Qw1MgkF7iDc
         PAk737R/m0l4ujLF/s61g/qcPhZbPGuszbbsAT+hsSoJWVHoyeLe/Yu3N7vba/+JK1Y7
         /T+47SC8XCxbzF6KjwKUXbPVHqLS4RTZPQgU4N2YQ2MuLzxh1T3tQGEa7FKa5+sWxsAs
         kJOnzj7T94eSxU6IExaFgLcjDIR9Rsg3o53Yz/AHkCFUA5uSGQBL7UNUryJFAuNK6TF+
         i0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=spUY8lyLrO5xdVbAHEgZwfYUMMR7eoWtx3a0hWF14KY=;
        b=E8wWlYKlTly90rzftal7kAxJUQP04BNZeyHP1C3YvCYk0WSJBxakpAgyhEPM/sfzWP
         gZyQthpuREchN/MZ0f+7gIpe0p2tHguhgtOc+/RImHFBgEFV2B8hhQJAvb3Hyd1XG/Or
         Oc28+gZZFan0RRFhuGIJTgvsh9ADuMyOYxhw7GLqqoLPIce/4bPrpOFQFd/8H9KKcPej
         xrHyS+a8BM/Fq7AukXKOVxpxOXuO61cx30E/tmA44K0rNr9N8/1HOyulOCwJssSzxwf/
         AsgN1QcNpTSoY3CHb1NCNsL6y3/KC7S5BvxjLp0bNP1/YrYUvETgE3lal+sg4m2EQWGW
         qWKg==
X-Gm-Message-State: AOAM532KxD8H+UYXsUbIQz8ERoc4XMh9Sh7XJ99V0ZBsxNC/iT1uwkpA
        N1mSQCp6JMA3NqcXBRkBk24=
X-Google-Smtp-Source: ABdhPJxngpt9MZlizCIEUN4dMgj6xsEBIcgOzK/B95vpNyZtwVDhi4bz41KFp7v0yST4Q7hem8/7Jg==
X-Received: by 2002:a17:903:31c4:b029:e1:8840:8ab9 with SMTP id v4-20020a17090331c4b02900e188408ab9mr4547205ple.70.1615306992982;
        Tue, 09 Mar 2021 08:23:12 -0800 (PST)
Received: from [172.30.1.19] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id i20sm13127547pgg.65.2021.03.09.08.23.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 08:23:12 -0800 (PST)
Subject: Re: [PATCH 11/11] PM / devfreq: imx8m-ddrc: drop polling_ms
To:     Dong Aisheng <aisheng.dong@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     dongas86@gmail.com, kernel@pengutronix.de, shawnguo@kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, abel.vesa@nxp.com
References: <1615294733-22761-1-git-send-email-aisheng.dong@nxp.com>
 <1615294733-22761-12-git-send-email-aisheng.dong@nxp.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <89ce7e90-55d9-872a-59d3-48c3dcadfc9d@gmail.com>
Date:   Wed, 10 Mar 2021 01:23:06 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1615294733-22761-12-git-send-email-aisheng.dong@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21. 3. 9. 오후 9:58, Dong Aisheng wrote:
> polling_ms is only used by simple ondemand governor which
> this driver can't support. Drop it to avoid confusing.
> 
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>   drivers/devfreq/imx8m-ddrc.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/devfreq/imx8m-ddrc.c b/drivers/devfreq/imx8m-ddrc.c
> index 0a6b7a1c829d..ecb9375aa877 100644
> --- a/drivers/devfreq/imx8m-ddrc.c
> +++ b/drivers/devfreq/imx8m-ddrc.c
> @@ -417,7 +417,6 @@ static int imx8m_ddrc_probe(struct platform_device *pdev)
>   	if (ret < 0)
>   		goto err;
>   
> -	priv->profile.polling_ms = 1000;
>   	priv->profile.target = imx8m_ddrc_target;
>   	priv->profile.exit = imx8m_ddrc_exit;
>   	priv->profile.get_cur_freq = imx8m_ddrc_get_cur_freq;
> 

You can squash this patch with patch10 because polling_ms
is related to .get_dev_status.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
