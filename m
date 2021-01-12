Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B30D22F3336
	for <lists+linux-pm@lfdr.de>; Tue, 12 Jan 2021 15:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbhALOtY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Jan 2021 09:49:24 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:36768 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbhALOtY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2021 09:49:24 -0500
Received: by mail-ot1-f51.google.com with SMTP id d20so2482248otl.3;
        Tue, 12 Jan 2021 06:49:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R65jgJ9ZXA6KLRUaL143AJzdpFEYKDU6ZEDoHXUUWuk=;
        b=WKLfL0IGoZ95VBhxdscMxzsP6g+H50HF0Xtr89dmjE20KnEMONPufI87oif7xdQHpz
         zDm8U9d6ff/r7hyH/+Th4ENtzbHEzms5wGukLX8sE6RkGlzoXIGZnMEUzM8HOPeAXUXc
         6+WOaWULHqHetUbtlWxim2hnqQPFeVf0goOIKJBG2BLK8uviOxAFWs6+kppt2VYhzXEl
         dDhEps9M//FX9AB6KWMp8BW1w5RLseSqSqB/PIao6khDM6Ff/3T92HWX2vUMRICIKWrq
         PpAWsDvmHqSBdFcZt+1QAmeIMaMxLOQGvTfcU2QRH/o9EXJo82FPuI1PX0ok1q+enLTD
         zqwg==
X-Gm-Message-State: AOAM532CpNAL4o0f6hvznov56GbbO0rJL0KaVsv6wlqxD+8Wpry6lZeh
        qoAF1Snba638srXcIANw2g==
X-Google-Smtp-Source: ABdhPJz47DeFCqd1oQBxWpdz0vtjnHrb9OMZhE+QbK/kAhF8YobPG+Mkx0lWOxRC/NuYKWzUBCBJpQ==
X-Received: by 2002:a9d:71cf:: with SMTP id z15mr2992431otj.259.1610462923140;
        Tue, 12 Jan 2021 06:48:43 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n13sm654071otk.58.2021.01.12.06.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 06:48:42 -0800 (PST)
Received: (nullmailer pid 329242 invoked by uid 1000);
        Tue, 12 Jan 2021 14:48:41 -0000
Date:   Tue, 12 Jan 2021 08:48:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Roger Lu <roger.lu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        YT Lee <yt.lee@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v11 5/7] dt-bindings: soc: mediatek: add mt8192 svs
 dt-bindings
Message-ID: <20210112144841.GA327919@robh.at.kernel.org>
References: <20210107024356.583-1-roger.lu@mediatek.com>
 <20210107024356.583-6-roger.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107024356.583-6-roger.lu@mediatek.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jan 07, 2021 at 10:43:54AM +0800, Roger Lu wrote:
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> ---
>  .../devicetree/bindings/soc/mediatek/mtk-svs.yaml        | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml b/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
> index bb8c345a0c0a..2e61b07921aa 100644
> --- a/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
> +++ b/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
> @@ -22,6 +22,7 @@ properties:
>    compatible:
>      enum:
>        - mediatek,mt8183-svs
> +      - mediatek,mt8192-svs
>  
>    reg:
>      description: Address range of the MTK SVS controller.
> @@ -47,6 +48,14 @@ properties:
>        - const: svs-calibration-data
>        - const: t-calibration-data
>  
> +  resets:
> +    description:
> +      svs reset control.

How many?

And you can drop the description given there's only 1.

> +
> +  reset-names:
> +    items:
> +      - const: svs_rst
> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.18.0
> 
