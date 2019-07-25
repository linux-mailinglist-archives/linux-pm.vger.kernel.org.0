Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD23750EB
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 16:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfGYOYY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jul 2019 10:24:24 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44475 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfGYOYY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2019 10:24:24 -0400
Received: by mail-lj1-f193.google.com with SMTP id k18so48176513ljc.11;
        Thu, 25 Jul 2019 07:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=QHpELRpBKO7EZIccXTfwOcj2Dzu6DQ0ve/foH0WRfeg=;
        b=T3qvU+3Tb5TRK8AacfmISB0gOegIgKcyPLouaLtrAcRljhhQMWsVclxH8Ye/OGwc1y
         FW2YGzEKdD4l66HhGY+YdLSQ8X+oqdu58DZ69ACt00NnHHlINMTc6fl2V135qEGPmGK5
         0uFE1bOa4AGnDAAWD6z8Ffenp1fj4Ck9Ms5v3Octgp9x60b92ZroNI4RtI8FGyFwSM1F
         UjlHmmCXXM5VscLwiEqZOxVTZkOyFuvgGmsOVHbeKx67sl7V3ZsaN9+VXQ+u1J3k7fwN
         byklpgBBHHGjF74sTRKkgdpbOHNcsAgdwuwXRNJxxunkYoh6YblJ8RQ9E+jxzygshf5U
         4LwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=QHpELRpBKO7EZIccXTfwOcj2Dzu6DQ0ve/foH0WRfeg=;
        b=GzbbHEhhHBDVNnZfwq8PLnfZAhFt0mjqfy53m8vc8sJNddHGn8/Dehc+B/MawuMkmm
         S4mSo/WRyHxXWGSTeigIiEdONi4FMo2P9HwdzylwuHvNXvgi89LYWmQlJG9VlCnuFWfY
         Mzii7dd1gcXdGkp0jmVb8c2PyXw6y2Bi0/dWZwaEoKw2n5vRp0gQLSKmWYimcxVZhDzk
         H8gX51aURa6zbzUmIXEdswyztoGJnZnbneb8Ffy+l/f4MdRYkp0BVEvhbveqzxkVMguR
         dcRk25KtXGoIGOlH9SW/RNpQZBflkcGlHCWcTGSDctvVjXeRqc5pG+MPuSEMh1WH20id
         HmYA==
X-Gm-Message-State: APjAAAWcmGnokaKKhJbmISycyjsBwRppYOUb13LN7NcaBvYrdEj1pS5G
        TPHiGS6MHRh7aD+Y0J9EtRRiVxHAaR+b+f1+38Y=
X-Google-Smtp-Source: APXvYqwEmzwuMqkOxr0aEHUwLmVQUEfqpgOv3BdVEQRWVSDRdsMreLUPZUh2LA5quQUjw8nMqzF9mEmTZ8nQFxNF6Pc=
X-Received: by 2002:a2e:3008:: with SMTP id w8mr47159184ljw.13.1564064661345;
 Thu, 25 Jul 2019 07:24:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1563971855.git.leonard.crestez@nxp.com> <93df6e7d81a404a43af684e2f96bdb6561ed87fe.1563971855.git.leonard.crestez@nxp.com>
In-Reply-To: <93df6e7d81a404a43af684e2f96bdb6561ed87fe.1563971855.git.leonard.crestez@nxp.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Thu, 25 Jul 2019 23:23:44 +0900
Message-ID: <CAGTfZH2UzvOVE-hKHLLGa7-ZF6DqsXvZiHcMy4O9qpohYLGbDA@mail.gmail.com>
Subject: Re: [RFCv3 1/3] dt-bindings: devfreq: Add initial bindings for i.MX
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Will Deacon <will@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Li <Frank.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

2019=EB=85=84 7=EC=9B=94 24=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 10:36, =
Leonard Crestez <leonard.crestez@nxp.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
>
> Add initial dt bindings for the interconnects inside i.MX chips.
> Multiple external IPs are involved but SOC integration means the
> software controllable interfaces are very similar.
>
> This is initially only for imx8mm but add an "fsl,imx-bus" fallback
> similar to exynos-bus.
>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  .../devicetree/bindings/devfreq/imx.yaml      | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/imx.yaml
>
> diff --git a/Documentation/devicetree/bindings/devfreq/imx.yaml b/Documen=
tation/devicetree/bindings/devfreq/imx.yaml
> new file mode 100644
> index 000000000000..87f90cddfd29
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/devfreq/imx.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/devfreq/imx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Generic i.MX bus frequency device
> +
> +maintainers:
> +  - Leonard Crestez <leonard.crestez@nxp.com>
> +
> +description: |
> +  The i.MX SoC family has multiple buses for which clock frequency (and =
sometimes
> +  voltage) can be adjusted.
> +
> +  Some of those buses expose register areas mentioned in the memory maps=
 as GPV
> +  ("Global Programmers View") but not all. Access to this area might be =
denied for
> +  normal world.
> +
> +  The buses are based on externally licensed IPs such as ARM NIC-301 and=
 Arteris
> +  FlexNOC but DT bindings are specific to the integration of these bus
> +  interconnect IPs into imx SOCs.
> +
> +properties:
> +  reg:
> +    maxItems: 1
> +    description: GPV area
> +
> +  compatible:
> +    contains:
> +      enum:
> +       - fsl,imx8m-noc
> +       - fsl,imx8m-nic
> +       - fsl,imx8m-ddrc
> +
> +  clocks:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - clocks
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx8mm-clock.h>
> +    ddrc: dram-controller@3d400000 {
> +            compatible =3D "fsl,imx8mm-ddrc";

s/imx8mm/imx8m

> +            reg =3D <0x3d400000 0x400000>;
> +            clocks =3D <&clk IMX8MM_CLK_DRAM>;
> +            operating-points-v2 =3D <&ddrc_opp_table>;
> +    };
> +
> +  - |
> +    noc: noc@32700000 {
> +            compatible =3D "fsl,imx8mm-noc";

s/imx8mm/imx8m

> +            reg =3D <0x32700000 0x100000>;
> +            clocks =3D <&clk IMX8MM_CLK_NOC>;
> +            operating-points-v2 =3D <&noc_opp_table>;
> +    };
> --
> 2.17.1
>


--=20
Best Regards,
Chanwoo Choi
