Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE684109DBF
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2019 13:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbfKZMSq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Nov 2019 07:18:46 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36489 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727615AbfKZMSp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Nov 2019 07:18:45 -0500
Received: by mail-ot1-f65.google.com with SMTP id f10so15700345oto.3;
        Tue, 26 Nov 2019 04:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GPjIoPKAdBU2rhij0XkCzvo+ahx+quTsSMqV7wK7Go4=;
        b=kXH19YTYWBb/zAuzTG2D+tFgg9MZ74NGM3I9FEiCDfBIv4BipMdk0YtT7FQh0nx5du
         5PsAvauJPiHo77O5deZ5/3NbsAg0+Gdmezpq8R3AStdJGmuATFgOVZok7YMKr9sqs8bm
         HXUzJ+zkd2cmITUiWpjDt4aoRMoDG4XqMfmhVeppEEFlKLejOy8ykHb+qo0LUaA7+U1s
         M+CvJ/EWC9H+Teu1OtUwbORx5axg9qB3wN8xa2iq7JvgnMsGc/itO705yS1BuWj/YNDJ
         OhokstKZZ0/DL6vn1/DLgvxJ0tVhmUCiFP8sb881PmusrfoU0XCHQQcFCCDncHkUSvLB
         UDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GPjIoPKAdBU2rhij0XkCzvo+ahx+quTsSMqV7wK7Go4=;
        b=OuiOdAB3QuTdKju8C9ULQ6Piio2kcFmVMxD6n7Yvns2JJzt7in5FBI2Y8plKeYIIXZ
         D0lZbe7JERm35e83Zga8YWm9bDLUyaKVt+Dd5ZYcfA8zIjdhLSnDSDhEWrq5ktxZLSFT
         WjAP/akxXkeAW/rP8wLy5Askc4rAyynt9QCRH04hT1CNCg+MYlnU5e2x5kx46a5v5fqj
         sYJ4qanj9Stt1lxG2y8bmZ5Ptb1wl34zlkSQOa8Ko5UeEd4yGp5SXanpyY8rniW5XaMy
         sv0WDlh+Ph9qmPwf360ahrzFyDoZguRJ1RfvDw1tpOukZux3+dyNTAD5rYQkY5cHGLSP
         Uo8w==
X-Gm-Message-State: APjAAAWYGWGsaGqoUdZ1dkbbiCvgjitPsMCe/NGo2asnyhY9aFaPExID
        PNSchz1T/WbkiwUk2GSa9sc=
X-Google-Smtp-Source: APXvYqz/ELJmUcs3pP92+oVmdlJk7E+Dzm6ctuvIFTGCxQmgLgtcI9qH8dxQ7s2bJR6TaZ355x0psQ==
X-Received: by 2002:a9d:470f:: with SMTP id a15mr24541053otf.290.1574770724780;
        Tue, 26 Nov 2019 04:18:44 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j8sm3567921otj.42.2019.11.26.04.18.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Nov 2019 04:18:43 -0800 (PST)
Subject: Re: [PATCH v1 2/4] watchdog: populate reboot mode node in toprgu node
 of MTK RGU (Reset Generation Unit)
To:     freddy.hsin@mediatek.com, sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, wim@linux-watchdog.org,
        matthias.bgg@gmail.com, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org
Cc:     Chang-An.Chen@mediatek.com, wsd_upstream@mediatek.com
References: <1574746490-625-1-git-send-email-freddy.hsin@mediatek.com>
 <1574746490-625-3-git-send-email-freddy.hsin@mediatek.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <ca66e52e-df80-388e-3018-7bf35aef5f43@roeck-us.net>
Date:   Tue, 26 Nov 2019 04:18:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1574746490-625-3-git-send-email-freddy.hsin@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/25/19 9:34 PM, freddy.hsin@mediatek.com wrote:
> From: Freddy Hsin <freddy.hsin@mediatek.com>
> 
> of_platform_population should be added in the probe function of
> toprgu driver, or the reboot mode driver will not be probed
> 
> Signed-off-by: Freddy Hsin <freddy.hsin@mediatek.com>
> ---
>   drivers/watchdog/mtk_wdt.c |    3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
> index 9c3d003..2fb2614 100644
> --- a/drivers/watchdog/mtk_wdt.c
> +++ b/drivers/watchdog/mtk_wdt.c
> @@ -20,6 +20,7 @@
>   #include <linux/types.h>
>   #include <linux/watchdog.h>
>   #include <linux/delay.h>
> +#include <linux/of_platform.h>
>   
>   #define WDT_MAX_TIMEOUT		31
>   #define WDT_MIN_TIMEOUT		1
> @@ -167,6 +168,8 @@ static int mtk_wdt_probe(struct platform_device *pdev)
>   	if (IS_ERR(mtk_wdt->wdt_base))
>   		return PTR_ERR(mtk_wdt->wdt_base);
>   
> +	of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
> +

This seems just wrong. Such a driver should not be a child of the watchdog driver.

Guenter

>   	mtk_wdt->wdt_dev.info = &mtk_wdt_info;
>   	mtk_wdt->wdt_dev.ops = &mtk_wdt_ops;
>   	mtk_wdt->wdt_dev.timeout = WDT_MAX_TIMEOUT;
> 

