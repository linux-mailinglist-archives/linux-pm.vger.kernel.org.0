Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94613401A1
	for <lists+linux-pm@lfdr.de>; Thu, 18 Mar 2021 10:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhCRJOl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 05:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhCRJOe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Mar 2021 05:14:34 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B3FC06174A
        for <linux-pm@vger.kernel.org>; Thu, 18 Mar 2021 02:14:27 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id t9so4659146wrn.11
        for <linux-pm@vger.kernel.org>; Thu, 18 Mar 2021 02:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:references:from:subject:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Uiv09UGTwFa3RRLsvY7QxQvxRJLPKqm4niX7REF+uBI=;
        b=coPhGBtIDCp11up6qLgepezHxSY9MAu+TIL4HmsjE1SENNt1EVWlXvVyN4/KFhHvND
         ZWEfg4iOZxb5sdttHrJQyfNcNKxiLHvhk5SHivOpsOaL+s1XROwwR79ZZn3g+Al3BusC
         DbUooT4K6XGJXBE+wAqn1msIvpva4OwXZEQeW1c3vFRKBxJ5MIX2/0Nj2m4XHNrzqLot
         XANEtb6ctkGxDim4PP3+ZcTUIhSTGgg0FxsHBJckeSgQwEQO2g+RDstg+VOeGVTv2WIX
         3ITK+0hRnIW4P4n7Gr+Zy+1rY7qWgmc+efNrUw3q6ceHH1f3lqU1GXZUpYRcB4SpDVBa
         oDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Uiv09UGTwFa3RRLsvY7QxQvxRJLPKqm4niX7REF+uBI=;
        b=rQuZTo+NiRjwr6BSnZRGxUy4QlyEju5pWv/HgcDAUS2iJjdRFpPaMF4Moy4KVfMz+8
         Ian+PUH48g56vCYpVCxSnjZsNdrRP1L3+98OP/UPgUlPtHuR99vN8Yin3mVfAQZ1p3rI
         4ZmH9ri1SY8dtiveB62oPb6ofHjPQ6087jgWiWkKu6am6VUBEUvYaop5CfiQH6lAA1q6
         Zo80XGh91Rxr4Kpw1GvyExzXjThvAq+dqXQI19i/S79wpU6+KUaS1V6w5hiFh2Xwz9+3
         z6M/Z3VTMp/MFkur8rBaTwaZV1TLu3CcMi76d/JiiRuQ1n+jkY/u1lm9jn5fRO6LJhx6
         ub3A==
X-Gm-Message-State: AOAM530Rw/UO2/rwc5xFoF4TQ/8ai7hFs3Y+i4sISj+otP+6LVD2fAWm
        cYJUNc+F+4s1fsszuG0vpPCPgojFq0QWpQ==
X-Google-Smtp-Source: ABdhPJwCAE5GuLxhwuncmpoKP2i/ihcBTLpoW7+Qpnjtwc5szQ26Ujm9zCiwDkLrmji6uToHNGYY1w==
X-Received: by 2002:adf:c64a:: with SMTP id u10mr8561102wrg.412.1616058866201;
        Thu, 18 Mar 2021 02:14:26 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id l8sm2122201wrx.83.2021.03.18.02.14.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 02:14:25 -0700 (PDT)
To:     Henry Chen <henryc.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        Fan Chen <fan.chen@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Arvin Wang <arvin.wang@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <1614656863-8530-1-git-send-email-henryc.chen@mediatek.com>
 <1614656863-8530-4-git-send-email-henryc.chen@mediatek.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH V9 03/12] soc: mediatek: add driver for dvfsrc support
Message-ID: <c1c96a65-b322-44ad-39ad-5f9f27fdc4a4@linaro.org>
Date:   Thu, 18 Mar 2021 11:14:22 +0200
MIME-Version: 1.0
In-Reply-To: <1614656863-8530-4-git-send-email-henryc.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Henry,

On 3/2/21 05:47, Henry Chen wrote:
> Add dvfsrc driver for MT6873/MT8183/MT8192
> 
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> ---
>  drivers/soc/mediatek/Kconfig            |  11 +
>  drivers/soc/mediatek/Makefile           |   1 +
>  drivers/soc/mediatek/mtk-dvfsrc.c       | 421 ++++++++++++++++++++++++++++++++
>  include/linux/soc/mediatek/mtk_dvfsrc.h |  35 +++
>  4 files changed, 468 insertions(+)
>  create mode 100644 drivers/soc/mediatek/mtk-dvfsrc.c
>  create mode 100644 include/linux/soc/mediatek/mtk_dvfsrc.h
> 
> diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> index fdd8bc0..2dcf023 100644
> --- a/drivers/soc/mediatek/Kconfig
> +++ b/drivers/soc/mediatek/Kconfig
> @@ -26,6 +26,17 @@ config MTK_DEVAPC
>  	  The violation information is logged for further analysis or
>  	  countermeasures.
>  
> +config MTK_DVFSRC
> +	tristate "MediaTek DVFSRC Support"
> +	depends on ARCH_MEDIATEK
I'm wondering whether adding COMPILE_TEST would make sense here, but it's
also fine as is.

> +	help
> +	  Say yes here to add support for the MediaTek DVFSRC (dynamic voltage
> +	  and frequency scaling resource collector) found
> +	  on different MediaTek SoCs. The DVFSRC is a proprietary
> +	  hardware which is used to collect all the requests from
> +	  system and turn into the decision of minimum Vcore voltage
> +	  and minimum DRAM frequency to fulfill those requests.
> +
>  config MTK_INFRACFG
>  	bool "MediaTek INFRACFG Support"
>  	select REGMAP
> diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
> index b6908db..4ead103 100644
> --- a/drivers/soc/mediatek/Makefile
> +++ b/drivers/soc/mediatek/Makefile
[..]
> +void mtk_dvfsrc_send_request(const struct device *dev, u32 cmd, u64 data)
> +{
> +	int ret, state;
> +	struct mtk_dvfsrc *dvfsrc = dev_get_drvdata(dev);
> +
> +	dev_dbg(dvfsrc->dev, "cmd: %d, data: %llu\n", cmd, data);
> +
> +	switch (cmd) {
> +	case MTK_DVFSRC_CMD_BW_REQUEST:
> +		dvfsrc->dvd->set_dram_bw(dvfsrc, data);
> +		return;
> +	case MTK_DVFSRC_CMD_PEAK_BW_REQUEST:
> +		if (dvfsrc->dvd->set_dram_peak_bw)
> +			dvfsrc->dvd->set_dram_peak_bw(dvfsrc, data);
> +		return;
> +	case MTK_DVFSRC_CMD_OPP_REQUEST:
> +		if (dvfsrc->dvd->set_opp_level)
> +			dvfsrc->dvd->set_opp_level(dvfsrc, data);
> +		break;
> +	case MTK_DVFSRC_CMD_VCORE_REQUEST:
> +		dvfsrc->dvd->set_vcore_level(dvfsrc, data);
> +		break;
> +	case MTK_DVFSRC_CMD_HRTBW_REQUEST:
> +		if (dvfsrc->dvd->set_dram_hrtbw)
> +			dvfsrc->dvd->set_dram_hrtbw(dvfsrc, data);
> +		else
> +			return;
> +		break;
> +	case MTK_DVFSRC_CMD_VSCP_REQUEST:
> +		dvfsrc->dvd->set_vscp_level(dvfsrc, data);
> +		break;
> +	default:
> +		dev_err(dvfsrc->dev, "unknown command: %d\n", cmd);
> +		return;
> +	}
> +
> +	/* DVFSRC need to wait at least 2T(~196ns) to handle request
> +	 * after recieving command

Nit: s/recieving/receiving/

Thanks,
Georgi
