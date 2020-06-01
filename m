Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49EA1EA7FF
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jun 2020 18:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgFAQxl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jun 2020 12:53:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:45714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgFAQxl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 1 Jun 2020 12:53:41 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 729B22074B;
        Mon,  1 Jun 2020 16:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591030420;
        bh=xmv/f5eGirB8fUS6lcgTndhc1UmtLqQcJkH+IofOU3k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gu5I+6KzKFX9qkx8ID6woUBgrQk4ql3Mm3EQfOfzK64SrJ9+Pd91NkKmbqe6SfXvA
         1CUusM5TGYgfSWWrUbEdWHI9ByWMID5P2X9wRXvkJ7FoBDmXJTLus0wIk84rLLIy10
         LgwSBsQfCUMBURHOzleAT7sA3buGPCbFMNX5aOTQ=
Received: by mail-ot1-f52.google.com with SMTP id v17so8579281ote.0;
        Mon, 01 Jun 2020 09:53:40 -0700 (PDT)
X-Gm-Message-State: AOAM531N4MXCptI7r/m3R53pfycmnSuSrADnvHiZma1ZRCOMeHpY4SNQ
        lXXWJNxGOBDAiCo4Tj5P6Q3wVv4iwVbJ4qfTBg==
X-Google-Smtp-Source: ABdhPJzTdRozJFtS2QadieFl00Z2eb48JRe1aEC6vVpfSGBDf5v19ZTdHqjzjD9h4kDdLt4/RGtjMjEp2jwbslBrhiE=
X-Received: by 2002:a9d:c29:: with SMTP id 38mr10211809otr.107.1591030419784;
 Mon, 01 Jun 2020 09:53:39 -0700 (PDT)
MIME-Version: 1.0
References: <1590982520-5437-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1590982520-5437-1-git-send-email-Anson.Huang@nxp.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 1 Jun 2020 10:53:27 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKVL4J=-aLPsSYgGVdnx3qjA=J8M08ztzv9=0V9gY=14A@mail.gmail.com>
Message-ID: <CAL_JsqKVL4J=-aLPsSYgGVdnx3qjA=J8M08ztzv9=0V9gY=14A@mail.gmail.com>
Subject: Re: [PATCH V2] dt-bindings: thermal: Convert qoriq to json-schema
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>,
        Jia Hongtao <hongtao.jia@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, May 31, 2020 at 9:45 PM Anson Huang <Anson.Huang@nxp.com> wrote:
>
> Convert the qoriq thermal binding to DT schema format using json-schema
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V1:
>         - add 'maxItems' for 'fsl,tmu-range' property;
>         - add 'minItems'/'maxItems' and items descriptions for 'fsl,tmu-calibration' property;
>         - remove description for common property '#thermal-sensor-cells';
>         - refine 'fsl,tmu-calibration' format in example.
> ---
>  .../devicetree/bindings/thermal/qoriq-thermal.txt  |  71 -------------
>  .../devicetree/bindings/thermal/qoriq-thermal.yaml | 112 +++++++++++++++++++++
>  2 files changed, 112 insertions(+), 71 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
>  create mode 100644 Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml

[...]

> diff --git a/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml b/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
> new file mode 100644
> index 0000000..c5df999
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
> @@ -0,0 +1,112 @@
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

This email is bouncing. Should be @nxp.com?

Rob
