Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1496CF32A
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 11:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfD3Jim (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Apr 2019 05:38:42 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51688 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfD3Jil (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Apr 2019 05:38:41 -0400
Received: by mail-wm1-f67.google.com with SMTP id 4so3013890wmf.1
        for <linux-pm@vger.kernel.org>; Tue, 30 Apr 2019 02:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/3wYlyhZbzBchlLSDGrVadmzpXmhvNCDqzSIes7t9Xo=;
        b=AoMCDGf6Pz/18jweYn9G/WqvtFatGH1A42LYdtTWRpPP8a0EzPkJqbtGrmHo+Metsg
         ctD/JqgQshldExK9dSZkYeX1sKToBT90GGD15pjqy2KJrZ6OUVXnQvDh7RwqIPfdjpT0
         b/SV3J/iTbkNEjvgREHSpHTSv7IkYL2bUWa2gCCHsdZo2F2FOxq0X4zJjMVxf+zqE9N6
         U8rywCQaxccXnGkgb6m+WKOe9idNRDPrnXGFLpvJpxi7Un7hsqsAkwsh24LLkAIV2naD
         BlWie8jxVSDLGuK0mx5jWqYRmmeRAZIcLarfseYbOmsLMylIfDoV1I5rKImv3gxA7GBS
         sbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/3wYlyhZbzBchlLSDGrVadmzpXmhvNCDqzSIes7t9Xo=;
        b=SGmQHF0DzsFcVo/jaI+VTATCTV2QHkoZEvYzAj6NyQR5Kd7doyff+EaFMRYIBVLOE3
         GGssty5BHt3+YsGfE+LYHGBz8T4YX12prUaxsqo4vNMoLH+rB7Kf1DH31XNbnxBWc+sV
         ufbM2QkpKaUeoly8eoFKZHaSuplSbN+pUgoCEk8NE7L2YfSSBH9WFHrwbTsTr0ftE0/5
         /8M40URSOjlnbWSXcIzi/waK3Y9gCQA/CubhmxP5nL1pPydnxMx4li0PEbekt0q3P8Ay
         6yVO/hMbknjwVoKeCCBOMXauQ8C8/0J6oAhIVibZB4IQaXPbuEteyXEoij6PUesaaEic
         DTug==
X-Gm-Message-State: APjAAAV7RNK7nEv0cg97G8AOz5vKY1ioQPNu4lPOM/tNLIaK1XK+EjK8
        1JwtvAVJBqn9qQAiI6BcfpNULQ==
X-Google-Smtp-Source: APXvYqwA1tdKPbjEX/wGxyTccXMnxi6VQhfIahH0tLx5f+45ERi5G5jDL7MjOgs5pGS8hNAUJI3hjg==
X-Received: by 2002:a1c:d1c1:: with SMTP id i184mr2539346wmg.35.1556617119678;
        Tue, 30 Apr 2019 02:38:39 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id y197sm1933495wmd.34.2019.04.30.02.38.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 02:38:39 -0700 (PDT)
Subject: Re: [PATCH -next] mlxsw: Remove obsolete dependency on THERMAL=m
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Jiri Pirko <jiri@mellanox.com>, Ido Schimmel <idosch@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>, linux-pm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190430092832.7376-1-geert+renesas@glider.be>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <6e72de15-f507-fb86-f806-9b1647f2dfe2@linaro.org>
Date:   Tue, 30 Apr 2019 11:38:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430092832.7376-1-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30/04/2019 11:28, Geert Uytterhoeven wrote:
> The THERMAL configuration option was changed from tristate to bool, but
> a dependency on THERMAL=m was forgotten, leading to a warning when
> running "make savedefconfig":
> 
>     boolean symbol THERMAL tested for 'm'? test forced to 'n'
> 
> Fixes: be33e4fbbea581ea ("thermal/drivers/core: Remove the module Kconfig's option")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks!

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  drivers/net/ethernet/mellanox/mlxsw/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/Kconfig b/drivers/net/ethernet/mellanox/mlxsw/Kconfig
> index b6b3ff0fe17f5c4e..7ccb950aa7d4aa30 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/Kconfig
> +++ b/drivers/net/ethernet/mellanox/mlxsw/Kconfig
> @@ -22,7 +22,6 @@ config MLXSW_CORE_HWMON
>  config MLXSW_CORE_THERMAL
>  	bool "Thermal zone support for Mellanox Technologies Switch ASICs"
>  	depends on MLXSW_CORE && THERMAL
> -	depends on !(MLXSW_CORE=y && THERMAL=m)
>  	default y
>  	---help---
>  	 Say Y here if you want to automatically control fans speed according
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

