Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A25DD2CA37B
	for <lists+linux-pm@lfdr.de>; Tue,  1 Dec 2020 14:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgLANLR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Dec 2020 08:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgLANLQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Dec 2020 08:11:16 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1268FC0613D6
        for <linux-pm@vger.kernel.org>; Tue,  1 Dec 2020 05:10:36 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id r3so2554735wrt.2
        for <linux-pm@vger.kernel.org>; Tue, 01 Dec 2020 05:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=tD7lW8WjSrRAwrauSTkItu7q0mgGf77gOj0uFtLmfHc=;
        b=kidd5nkR1gcHW5NLYjMY7MiUA15JI8OL4z3O4/TU2FAOB/VULuO0Hm4tRTMRVykScE
         PvvWilLHI3TxbdWV7k5OL7p2yxy80Ex+Gkc9geaATPtulSsV4pDoBtY7nlVKZxgD7Zc5
         VM8ZB9clHq7RhlKr4nqkyewcwLKal9K/Kt8gncaQm+rDZ4siAKVfshlUa6JrcgGUX2X1
         kf0qoC3Np9pZrrDfL1luK1OUfEJtpmiaB3cE9yqqVJcVIr5ISswF0AP7hFqCnFq26JWn
         XengzQ4JH1dXIQndC6gNT/FakRwBhH/5H1vzED/DuFHRTjCvgEoXIoE34ZpHXOlIKmWf
         Kq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tD7lW8WjSrRAwrauSTkItu7q0mgGf77gOj0uFtLmfHc=;
        b=MMxACtnIVOGNuT7+Nw2h3Cpb9UkoENcaNaBhDcwoXsgBy0fCAl/P2lMeqxwrPgGRUB
         r8YyIQ+I6kLB2GElmSScs4EjpiXQ0HlgwmVeofG0N6y52OooaNR7zsP6FlUj28dVb86N
         AGatyZjVjYha4w3dSBur/UJej6PL3tTQb9JKLwoxjNE6D5Fhf2sm4iq/IpDs60GS1ddd
         PJMVYzAxSFmdrqemAX+TSTOBkLKJPGF/LgB1Uekp3GTrRruhtaB+y8cJr7/Q/kFT6RxQ
         HEvt0250iHTR8PemfzdsDR8UZubHaL8W/TqkOPznDZPY9jzmksSqS0sZ30gciewIGd1u
         yGmw==
X-Gm-Message-State: AOAM532ESQEhgUS6g8TrBfqihRMG13cqxp6FNMTrLekhaoFoE1ys7ySZ
        6UthJDG00sBiYa6JNf/MfbPfsKfi4QziHg==
X-Google-Smtp-Source: ABdhPJyoKaXp94oxtZFzKE6AUzgI8hcGm4c3/RCkF1rQPUlrMMoXAY1tc6etaO39l7cymIYuLnuN/A==
X-Received: by 2002:a05:6000:45:: with SMTP id k5mr3929976wrx.108.1606828234332;
        Tue, 01 Dec 2020 05:10:34 -0800 (PST)
Received: from MacBook-Pro.local ([212.45.64.13])
        by smtp.googlemail.com with ESMTPSA id o67sm3046825wmo.31.2020.12.01.05.10.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Dec 2020 05:10:33 -0800 (PST)
Subject: Re: [PATCH v2 7/7] arm64: defconfig: Enable interconnect for imx8mq
To:     Martin Kepplinger <martin.kepplinger@puri.sm>, robh@kernel.org,
        shawnguo@kernel.org, festevam@gmail.com, catalin.marinas@arm.com,
        will@kernel.org, cdleonard@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, kernel@puri.sm,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20201201123932.12312-1-martin.kepplinger@puri.sm>
 <20201201123932.12312-8-martin.kepplinger@puri.sm>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Message-ID: <cb498c2c-e052-390a-c64a-2be44d1d2b42@linaro.org>
Date:   Tue, 1 Dec 2020 15:10:32 +0200
MIME-Version: 1.0
In-Reply-To: <20201201123932.12312-8-martin.kepplinger@puri.sm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1.12.20 14:39, Martin Kepplinger wrote:
> Enable INTERCONNECT_IMX8MQ in order to make interconnect more widely
> available for testing.

I hope that it's not just for testing, but using it.

> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>   arch/arm64/configs/defconfig | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 1fed16950a7c..830c26a95b3d 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1023,7 +1023,8 @@ CONFIG_OPTEE=y
>   CONFIG_MUX_MMIO=y
>   CONFIG_SLIM_QCOM_CTRL=m
>   CONFIG_SLIM_QCOM_NGD_CTRL=m
> -CONFIG_INTERCONNECT=y

Why are you removing this line?

Thanks,
Georgi

> +CONFIG_INTERCONNECT_IMX=m
> +CONFIG_INTERCONNECT_IMX8MQ=m
>   CONFIG_INTERCONNECT_QCOM=y
>   CONFIG_INTERCONNECT_QCOM_MSM8916=m
>   CONFIG_INTERCONNECT_QCOM_SDM845=m
> 

