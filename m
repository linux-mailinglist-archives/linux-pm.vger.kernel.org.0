Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010BE274D25
	for <lists+linux-pm@lfdr.de>; Wed, 23 Sep 2020 01:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgIVXOx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Sep 2020 19:14:53 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:45357 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIVXOx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Sep 2020 19:14:53 -0400
Received: by mail-il1-f193.google.com with SMTP id h2so18987079ilo.12;
        Tue, 22 Sep 2020 16:14:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AOMIrv105VAQ5jLvYFtagW/T9+P98LUmqEIXqmLJvlI=;
        b=JzuXdbW7hMR/9qdvF9YPIsKE1jqFPT600a8OMVlvgIQptYSjxze9ZROdkbr2a5kw4b
         5Yhlnn3B+MxSY9ICNuA9PhZe4LDnHkveKq/rFnrHW7qnpjokqiMAj23/sqYrZD7pKddM
         /TYceNfwyy6oPsLfRI3/m5SdqQixu7vGykTsPfMfhRvKF4dRejd8UIXELTh93J/Qea2n
         nWYChXnna4s9Hrk15ShqSeAW8ZgDlNlyHGlSst/OBZcLQzV1Bh4wqiA3nEh3FI+SBMRH
         WpSBKYmA9Fz00hve4H9IMauY54luCM42HOL/PMHjj6DPd8au1SQlX+cy8GK+CSmMTl1B
         nniw==
X-Gm-Message-State: AOAM530sjyTjPRUn4vbzHa6tzHADGHkvowB4Yf5xtP4Du7hn0+SIOzNP
        zMLS3dLkcBE8TFVzhh7MAw==
X-Google-Smtp-Source: ABdhPJwfHoRB8beetX5qcoNEpJvmy4qrDYFw16WBeEUrgkDGw6+w4fvp+4aNkkYoNJBxhUGlAGxZnQ==
X-Received: by 2002:a92:cbcd:: with SMTP id s13mr5969567ilq.306.1600816492469;
        Tue, 22 Sep 2020 16:14:52 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id s1sm9776540iln.22.2020.09.22.16.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 16:14:51 -0700 (PDT)
Received: (nullmailer pid 3446962 invoked by uid 1000);
        Tue, 22 Sep 2020 23:14:50 -0000
Date:   Tue, 22 Sep 2020 17:14:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Henry Chen <henryc.chen@mediatek.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        Fan Chen <fan.chen@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Arvin Wang <arvin.wang@mediatek.com>,
        Mike Turquette <mturquette@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH V5 01/17] dt-bindings: soc: Add dvfsrc driver bindings
Message-ID: <20200922231450.GA3433939@bogus>
References: <1600052684-21198-1-git-send-email-henryc.chen@mediatek.com>
 <1600052684-21198-2-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600052684-21198-2-git-send-email-henryc.chen@mediatek.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 14, 2020 at 11:04:28AM +0800, Henry Chen wrote:
> Document the binding for enabling dvfsrc on MediaTek SoC.
> 
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

I did, but bindings are in DT schema format now. We had a grace 
period for some time, but please convert this to DT schema.

Rob

> ---
>  .../devicetree/bindings/soc/mediatek/dvfsrc.txt    | 25 ++++++++++++++++++++++
>  include/dt-bindings/soc/mtk,dvfsrc.h               | 14 ++++++++++++
>  2 files changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt
>  create mode 100644 include/dt-bindings/soc/mtk,dvfsrc.h
> 
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt b/Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt
> new file mode 100644
> index 0000000..d5a47d8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt
> @@ -0,0 +1,25 @@
> +MediaTek DVFSRC
> +
> +The Dynamic Voltage and Frequency Scaling Resource Collector (DVFSRC) is a
> +HW module which is used to collect all the requests from both software and
> +hardware and turn into the decision of minimum operating voltage and minimum
> +DRAM frequency to fulfill those requests.
> +
> +Required Properties:
> +- compatible: Should be one of the following
> +	- "mediatek,mt6873-dvfsrc": For MT6873 SoC
> +	- "mediatek,mt8183-dvfsrc": For MT8183 SoC
> +	- "mediatek,mt8192-dvfsrc": For MT8192 SoC
> +- reg: Address range of the DVFSRC unit
> +- clock-names: Must include the following entries:
> +	"dvfsrc": DVFSRC module clock
> +- clocks: Must contain an entry for each entry in clock-names.
> +
> +Example:
> +
> +	dvfsrc@10012000 {
> +		compatible = "mediatek,mt8183-dvfsrc";
> +		reg = <0 0x10012000 0 0x1000>;
> +		clocks = <&infracfg CLK_INFRA_DVFSRC>;
> +		clock-names = "dvfsrc";
> +	};
> diff --git a/include/dt-bindings/soc/mtk,dvfsrc.h b/include/dt-bindings/soc/mtk,dvfsrc.h
> new file mode 100644
> index 0000000..a522488
> --- /dev/null
> +++ b/include/dt-bindings/soc/mtk,dvfsrc.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * Copyright (c) 2018 MediaTek Inc.
> + */
> +
> +#ifndef _DT_BINDINGS_POWER_MTK_DVFSRC_H
> +#define _DT_BINDINGS_POWER_MTK_DVFSRC_H
> +
> +#define MT8183_DVFSRC_LEVEL_1	1
> +#define MT8183_DVFSRC_LEVEL_2	2
> +#define MT8183_DVFSRC_LEVEL_3	3
> +#define MT8183_DVFSRC_LEVEL_4	4
> +
> +#endif /* _DT_BINDINGS_POWER_MTK_DVFSRC_H */
> -- 
> 1.9.1
