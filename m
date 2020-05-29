Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3801E89CC
	for <lists+linux-pm@lfdr.de>; Fri, 29 May 2020 23:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbgE2VQ3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 May 2020 17:16:29 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:42243 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbgE2VQ3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 May 2020 17:16:29 -0400
Received: by mail-il1-f196.google.com with SMTP id 18so3861541iln.9;
        Fri, 29 May 2020 14:16:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pSGt5dmuUU28vDxK4zPLzl3TRx4uQnayx4LAotp4cO0=;
        b=iwMvOXkQXlU9ld20eBC5rjQap4euRdZ1z/xgw3IojgnsaBRX341m9DpeYRuZ/xRcXI
         +ETqcmi1JQf8Aq/JWMXpyMgF69OQmxja9BpYPS3eHELdPeohLZnQvkzI+KNqJaJn8QgM
         EtQTSNa7c3CFa9skf4E+MEKXDHYlSUjsSfUuuC1LOdrc76JT+ppHhIoyrR95/fUOImtl
         X4+IK4Te1YSFSEPW23N+AKSgkCaUcDmG/ltLggqcigIcyAQlJZY6Y7FdUQCY0vncTLWv
         Ce9g2mPGi9zE/9jDRp/QFovZCoTNAQq7XPCHOdNooUnZCXk8TYv7bOpeAq/8Sw4BKa+9
         EgkA==
X-Gm-Message-State: AOAM531jrfzZtdl8kSO1eZpk7frFwB3K+yWkDGxxRcfpnLLVKCjEHGn4
        B1vYHfEQKY5aFZHiLT3mBEjFkgX4KA==
X-Google-Smtp-Source: ABdhPJyuZDHup+UkrEvAmBbqVUf8q+Q4vGDpucAjS3nA0NOW5GnHSS927aWlUpo8Sco3jwRwP6gvyg==
X-Received: by 2002:a92:ba46:: with SMTP id o67mr9302315ili.66.1590786987972;
        Fri, 29 May 2020 14:16:27 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id d10sm5395647ils.69.2020.05.29.14.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 14:16:27 -0700 (PDT)
Received: (nullmailer pid 2980688 invoked by uid 1000);
        Fri, 29 May 2020 21:16:26 -0000
Date:   Fri, 29 May 2020 15:16:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, hongtao.jia@freescale.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] dt-bindings: thermal: Convert qoriq to json-schema
Message-ID: <20200529211626.GA2965031@bogus>
References: <1590737338-7318-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590737338-7318-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 29, 2020 at 03:28:58PM +0800, Anson Huang wrote:
> Convert the qoriq thermal binding to DT schema format using json-schema
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  .../devicetree/bindings/thermal/qoriq-thermal.txt  |  71 -------------
>  .../devicetree/bindings/thermal/qoriq-thermal.yaml | 111 +++++++++++++++++++++
>  2 files changed, 111 insertions(+), 71 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
>  create mode 100644 Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml


> diff --git a/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml b/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
> new file mode 100644
> index 0000000..bfbfa04
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
> @@ -0,0 +1,111 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/thermal/qoriq-thermal.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Thermal Monitoring Unit (TMU) on Freescale QorIQ SoCs
> +
> +maintainers:
> +  - Hongtao Jia <hongtao.jia@freescale.com>
> +
> +properties:
> +  compatible:
> +    description: |
> +      The version of the device is determined by the TMU IP Block Revision
> +      Register (IPBRR0) at offset 0x0BF8.
> +      Table of correspondences between IPBRR0 values and example chips:
> +            Value           Device
> +            ----------      -----
> +            0x01900102      T1040
> +    enum:
> +      - fsl,qoriq-tmu
> +      - fsl,imx8mq-tmu
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  fsl,tmu-range:
> +    $ref: '/schemas/types.yaml#/definitions/uint32-array'
> +    description: |
> +      The values to be programmed into TTRnCR, as specified by the SoC
> +      reference manual. The first cell is TTR0CR, the second is TTR1CR, etc.

Is there a maximum number?

> +
> +  fsl,tmu-calibration:
> +    $ref: '/schemas/types.yaml#/definitions/uint32-array'
> +    description: |
> +      A list of cell pairs containing temperature calibration data, as
> +      specified by the SoC reference manual. The first cell of each pair
> +      is the value to be written to TTCFGR, and the second is the value
> +      to be written to TSCFGR.

That's a uint32-matrix, not an array:

minItmes: ??
maxItems: ??
items:
  items:
    - description: value for TTCFGR
    - description: value for TSCFGR

> +
> +  little-endian:
> +    description: |
> +      boolean, if present, the TMU registers are little endian. If absent,
> +      the default is big endian.
> +    type: boolean
> +
> +  clocks:
> +    maxItems: 1
> +
> +  "#thermal-sensor-cells":
> +    const: 1
> +    description: |
> +      Number of cells required to uniquely identify the thermal sensors. This
> +      is set to 1 for multiple sensors.

No need to redefine common properties.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - fsl,tmu-range
> +  - fsl,tmu-calibration
> +  - '#thermal-sensor-cells'
> +
> +examples:
> +  - |
> +    tmu@f0000 {
> +        compatible = "fsl,qoriq-tmu";
> +        reg = <0xf0000 0x1000>;
> +        interrupts = <18 2 0 0>;
> +        fsl,tmu-range = <0x000a0000 0x00090026 0x0008004a 0x0001006a>;
> +        fsl,tmu-calibration = <0x00000000 0x00000025
> +                               0x00000001 0x00000028
> +                               0x00000002 0x0000002d
> +                               0x00000003 0x00000031
> +                               0x00000004 0x00000036
> +                               0x00000005 0x0000003a
> +                               0x00000006 0x00000040
> +                               0x00000007 0x00000044
> +                               0x00000008 0x0000004a
> +                               0x00000009 0x0000004f
> +                               0x0000000a 0x00000054
> +
> +                               0x00010000 0x0000000d
> +                               0x00010001 0x00000013
> +                               0x00010002 0x00000019
> +                               0x00010003 0x0000001f
> +                               0x00010004 0x00000025
> +                               0x00010005 0x0000002d
> +                               0x00010006 0x00000033
> +                               0x00010007 0x00000043
> +                               0x00010008 0x0000004b
> +                               0x00010009 0x00000053
> +
> +                               0x00020000 0x00000010
> +                               0x00020001 0x00000017
> +                               0x00020002 0x0000001f
> +                               0x00020003 0x00000029
> +                               0x00020004 0x00000031
> +                               0x00020005 0x0000003c
> +                               0x00020006 0x00000042
> +                               0x00020007 0x0000004d
> +                               0x00020008 0x00000056
> +
> +                               0x00030000 0x00000012
> +                               0x00030001 0x0000001d>;
> +        #thermal-sensor-cells = <1>;
> +    };
> -- 
> 2.7.4
> 
