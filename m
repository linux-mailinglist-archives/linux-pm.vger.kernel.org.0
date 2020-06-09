Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA601F426F
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 19:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731838AbgFIRf6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 13:35:58 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39682 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729986AbgFIRf5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 13:35:57 -0400
Received: by mail-io1-f66.google.com with SMTP id c8so23740036iob.6;
        Tue, 09 Jun 2020 10:35:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UemfyzL4CDaIbSMWhLIN31hIuc2Yr7jCv1si14uauIA=;
        b=tmGfN4p1CL8o5qxW8yh+rwztXiV1NjYc9c26Re9MhaiitcRki6mbS1A1HLZqRV1hxv
         t0t7C3BcrKdbHgYbAFAmeA3crFl6UpE7d7fuGLl2NLxj9JrhHEJh30CUK8jOh2yNKMeG
         GGd0e4oC/FU5n0rBO+O0XFk0CdScGpR+tgjecVF9ppnf0fIlJ5UaoZNN/GdgY1917x8Q
         ihKt+utSbm12vcSsyYTvOpYxswFES2Af+Vz/Lk3ab3JJNw5+a+XySKqWR4jUqvri9xJa
         eA6f9k5UwL1ZNuNSYgT2z1upmTTvfKBmVviSSYY5c113blyeeZAcJ2F4FKVVgnaC46vy
         zapQ==
X-Gm-Message-State: AOAM530PO431tyvvHaZn8bv3g4bNFsLr+33ebsx4FzK4diMlmcDqUm80
        4UCCmRn3XJdLKhKH/01RYA==
X-Google-Smtp-Source: ABdhPJyHA9bqkWZOLvk/hYOQV0AQki68RB2uY7Ob2Db2LSH4HMdre46KjSCiZoV+zVZ26b+BnZ/s9A==
X-Received: by 2002:a6b:1745:: with SMTP id 66mr12153914iox.151.1591724156628;
        Tue, 09 Jun 2020 10:35:56 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id z4sm7599577iot.24.2020.06.09.10.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 10:35:56 -0700 (PDT)
Received: (nullmailer pid 1125416 invoked by uid 1000);
        Tue, 09 Jun 2020 17:35:54 -0000
Date:   Tue, 9 Jun 2020 11:35:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Roger Lu <roger.lu@mediatek.com>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        YT Lee <yt.lee@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v9 1/4] dt-bindings: power: avs: add mtk svs dt-bindings
Message-ID: <20200609173554.GA1119852@bogus>
References: <20200609104534.29314-1-roger.lu@mediatek.com>
 <20200609104534.29314-2-roger.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609104534.29314-2-roger.lu@mediatek.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jun 09, 2020 at 06:45:31PM +0800, Roger Lu wrote:
> Document the binding for enabling mtk svs on MediaTek SoC.
> 
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> ---
>  .../bindings/power/avs/mtk_svs.yaml           | 141 ++++++++++++++++++
>  1 file changed, 141 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/avs/mtk_svs.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/avs/mtk_svs.yaml b/Documentation/devicetree/bindings/power/avs/mtk_svs.yaml
> new file mode 100644
> index 000000000000..f16f4eb56ee3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/avs/mtk_svs.yaml
> @@ -0,0 +1,141 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/avs/mtk_svs.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Introduce SVS engine
> +
> +maintainers:
> +  - Kevin Hilman <khilman@kernel.org>
> +  - Nishanth Menon <nm@ti.com>
> +
> +description: |+
> +  The Smart Voltage Scaling(SVS) engine is a piece of hardware
> +  which has several controllers(banks) for calculating suitable
> +  voltage to different power domains(CPU/GPU/CCI) according to
> +  chip process corner, temperatures and other factors. Then DVFS
> +  driver could apply SVS bank voltage to PMIC/Buck.
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt8183-svs
> +
> +  reg:
> +    description: Address range of the MTK SVS controller.
> +    maxItems: 1
> +
> +  interrupts:
> +    description: IRQ for the MTK SVS controller.
> +    maxItems: 1
> +
> +  clocks:
> +    description: Main clock for svs controller to work.
> +
> +  clock-names:
> +    const: main
> +
> +  nvmem-cells:
> +    maxItems: 2
> +    description:
> +      Phandle to the calibration data provided by a nvmem device.
> +
> +  nvmem-cell-names:
> +    items:
> +      - const: svs-calibration-data
> +      - const: calibration-data
> +
> +patternProperties:
> +  "^svs-(cpu-little|cpu-big|cci|gpu)$":
> +    type: object
> +    description:
> +      Each subnode represents one SVS bank.
> +        - svs-cpu-little (SVS bank device node of little CPU)
> +        - svs-cpu-big (SVS bank device node of big CPU)
> +        - svs-cci (SVS bank device node of CCI)
> +        - svs-gpu (SVS bank device node of GPU)

As I've said before, I don't think these child nodes make sense. All 
this data should already be available elsewhere in the DT.

Rob
