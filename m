Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0643112C5
	for <lists+linux-pm@lfdr.de>; Fri,  5 Feb 2021 21:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbhBETDb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Feb 2021 14:03:31 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:45722 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbhBETBY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Feb 2021 14:01:24 -0500
Received: by mail-oi1-f178.google.com with SMTP id m7so8853053oiw.12;
        Fri, 05 Feb 2021 12:43:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=afmn48XmJAf5UHtknLL+vZ43WdJumPw28Jtuqw8EJAI=;
        b=RAqYTzVtCDjNFrUykaiNB/rN2lJ77nD+YF8IbPCibNLgcZC9cNDBMWIJE/1Wgct7QB
         ZEusWgMD/6Y9PSaEfSyikPsYCVa3FpILJ++WfAy5YtIe2ggGNH56VtFkH60gn2nYQPC3
         Y/eFzGtknkfZ++raXQtz3ryQna2sx0Od5HGWiCXIVx+BeZHQF77leexlspt8AccogqA1
         C8unOUgDUMWn1nIfcTL/nc9NDHqMPf8jMjPa9OR4trOZVdvhhPPg03uxIImqjt/rtLh+
         ybBOxU3HDE2W8/cFQ3ekt8Byg3eCFptUY5jH4Z+881GDuzQCZMhom6lUcx8C9pSNNVsW
         aY8g==
X-Gm-Message-State: AOAM532XVuM2u1HULq0UDHXJiHX/pLrj5XScLOl3w2nRadHWPV4+7Jal
        J8fRuXCVdcecEHnKK+b1yQ==
X-Google-Smtp-Source: ABdhPJwyCaAFj5u9ICufn3AaMqQoT2FLq45wljxNPZVfVlhr1bm4C38Uek+pFLCPFShGkrSA6BtPaw==
X-Received: by 2002:aca:4e13:: with SMTP id c19mr4336663oib.66.1612557789168;
        Fri, 05 Feb 2021 12:43:09 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a188sm2013782oif.11.2021.02.05.12.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 12:43:08 -0800 (PST)
Received: (nullmailer pid 3696812 invoked by uid 1000);
        Fri, 05 Feb 2021 20:43:06 -0000
Date:   Fri, 5 Feb 2021 14:43:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Henry Chen <henryc.chen@mediatek.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        Fan Chen <fan.chen@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Arvin Wang <arvin.wang@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH V8 01/12] dt-bindings: soc: Add dvfsrc driver bindings
Message-ID: <20210205204306.GA3692875@robh.at.kernel.org>
References: <1611648234-15043-1-git-send-email-henryc.chen@mediatek.com>
 <1611648234-15043-2-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611648234-15043-2-git-send-email-henryc.chen@mediatek.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jan 26, 2021 at 04:03:43PM +0800, Henry Chen wrote:
> Document the binding for enabling dvfsrc on MediaTek SoC.
> 
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> ---
>  .../devicetree/bindings/soc/mediatek/dvfsrc.yaml   | 67 ++++++++++++++++++++++
>  include/dt-bindings/interconnect/mtk,mt8183-emi.h  | 21 +++++++
>  2 files changed, 88 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/dvfsrc.yaml
>  create mode 100644 include/dt-bindings/interconnect/mtk,mt8183-emi.h
> 
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/dvfsrc.yaml b/Documentation/devicetree/bindings/soc/mediatek/dvfsrc.yaml
> new file mode 100644
> index 0000000..0b746a8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/mediatek/dvfsrc.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/soc/mediatek/dvfsrc.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: MediaTek dynamic voltage and frequency scaling resource collector (DVFSRC)
> +
> +description: |
> +  The Dynamic Voltage and Frequency Scaling Resource Collector (DVFSRC) is a
> +  HW module which is used to collect all the requests from both software and
> +  hardware and turn into the decision of minimum operating voltage and minimum
> +  DRAM frequency to fulfill those requests.
> +
> +maintainers:
> +  - henryc.chen <henryc.chen@mediatek.com>
> +
> +properties:
> +  reg:
> +    description: DVFSRC common register address and length.

maxItems: 1

> +
> +  compatible:
> +    enum:
> +      - mediatek,mt6873-dvfsrc
> +      - mediatek,mt8183-dvfsrc
> +      - mediatek,mt8192-dvfsrc
> +
> +  '#interconnect-cells':
> +    const: 1
> +
> +patternProperties:
> +  dvfsrc-vcore:

Not a pattern. Move to 'properties'.

> +    type: object
> +    description:
> +      The DVFSRC regulator is modelled as a subdevice of the DVFSRC.
> +      Because DVFSRC can request power directly via register read/write, likes
> +      vcore which is a core power of mt8183. As such, the DVFSRC regulator
> +      requires that DVFSRC nodes be present.
> +    $ref: /schemas/regulator/regulator.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#interconnect-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interconnect/mtk,mt8183-emi.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        dvfsrc@10012000 {
> +            compatible = "mediatek,mt8183-dvfsrc";
> +            reg = <0 0x10012000 0 0x1000>;
> +            #interconnect-cells = <1>;
> +            dvfsrc_vcore: dvfsrc-vcore {
> +                    regulator-name = "dvfsrc-vcore";
> +                    regulator-min-microvolt = <725000>;
> +                    regulator-max-microvolt = <800000>;
> +                    regulator-always-on;
> +            };
> +        };
> +    };
> diff --git a/include/dt-bindings/interconnect/mtk,mt8183-emi.h b/include/dt-bindings/interconnect/mtk,mt8183-emi.h
> new file mode 100644
> index 0000000..dfd143f
> --- /dev/null
> +++ b/include/dt-bindings/interconnect/mtk,mt8183-emi.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * Copyright (c) 2021 MediaTek Inc.
> + */
> +
> +#ifndef __DT_BINDINGS_INTERCONNECT_MTK_MT8183_EMI_H
> +#define __DT_BINDINGS_INTERCONNECT_MTK_MT8183_EMI_H
> +
> +#define MT8183_SLAVE_DDR_EMI			0
> +#define MT8183_MASTER_MCUSYS			1
> +#define MT8183_MASTER_GPU			2
> +#define MT8183_MASTER_MMSYS			3
> +#define MT8183_MASTER_MM_VPU			4
> +#define MT8183_MASTER_MM_DISP			5
> +#define MT8183_MASTER_MM_VDEC			6
> +#define MT8183_MASTER_MM_VENC			7
> +#define MT8183_MASTER_MM_CAM			8
> +#define MT8183_MASTER_MM_IMG			9
> +#define MT8183_MASTER_MM_MDP			10
> +
> +#endif
> -- 
> 1.9.1
> 
