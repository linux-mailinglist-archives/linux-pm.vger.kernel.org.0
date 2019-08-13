Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 795038BB25
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2019 16:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbfHMOGN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Aug 2019 10:06:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:40262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729438AbfHMOGN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 13 Aug 2019 10:06:13 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47CFA21744;
        Tue, 13 Aug 2019 14:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565705172;
        bh=O/fCUAPwaNaOOD9s9pkmueTj8itaAZFGU/uvEuU6kgc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HpR0kTzh0L+1HCy1Trd3qsQrbjZn52IPfyQt3g5Y8VCr7jeQ4xAJGXgARJUR1xzUP
         klqdwHVZdgDWaLEyuO5irst9vm8D+yBfjbDxpDfpaPy5IwtXu8xDHljvjkBzTYqGfd
         9qbk3phoAnuJjqVtWEPfHlqqv0nRh2ShRjc21dNs=
Received: by mail-qt1-f171.google.com with SMTP id u34so7135061qte.2;
        Tue, 13 Aug 2019 07:06:12 -0700 (PDT)
X-Gm-Message-State: APjAAAXWSLkjYplKz83m4/rtfRd83t72UPnqLi2i1FSIFIglA+ftSRwb
        TY/ddRLswAsRTdo5BU1McNXHPadD/MCzqie/jA==
X-Google-Smtp-Source: APXvYqx3FMdHhwFr0AVbpQ+Lxot0AwypTnxtWq13JJOC5ylQw8YnX1DEfhh/V+OPrUwvGuTcbKUoILzXiL4zskKDN5g=
X-Received: by 2002:aed:24f4:: with SMTP id u49mr6124643qtc.110.1565705171397;
 Tue, 13 Aug 2019 07:06:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1565633880.git.leonard.crestez@nxp.com> <97b0bff95ddb85b06ef3d2f8079faa36562a956d.1565633880.git.leonard.crestez@nxp.com>
 <CAL_JsqJWpQN2oTm8Q2_Gzd0GJ+YZoc9j-zh-U1s4eGhMxDEmEA@mail.gmail.com> <VI1PR04MB702300C8C78BC033D16EDB85EED20@VI1PR04MB7023.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB702300C8C78BC033D16EDB85EED20@VI1PR04MB7023.eurprd04.prod.outlook.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 13 Aug 2019 08:06:00 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+BDO-J12BddWw-KbhjTx95p58qqpUhhKzUHED6vFK2TA@mail.gmail.com>
Message-ID: <CAL_Jsq+BDO-J12BddWw-KbhjTx95p58qqpUhhKzUHED6vFK2TA@mail.gmail.com>
Subject: Re: [PATCH 2/7] dt-bindings: devfreq: Add bindings for generic imx buses
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 12, 2019 at 7:32 PM Leonard Crestez <leonard.crestez@nxp.com> wrote:
>
> On 8/12/2019 10:47 PM, Rob Herring wrote:
> > On Mon, Aug 12, 2019 at 12:49 PM Leonard Crestez <leonard.crestez@nxp.com> wrote:
>
> >> Add initial dt bindings for the interconnects inside i.MX chips.
> >> Multiple external IPs are involved but SOC integration means the
> >> software controllable interfaces are very similar.
> >>
> >> +description: |
> >> +  The i.MX SoC family has multiple buses for which clock frequency (and sometimes
> >> +  voltage) can be adjusted.
> >> +
> >> +  Some of those buses expose register areas mentioned in the memory maps as GPV
> >> +  ("Global Programmers View") but not all. Access to this area might be denied for
> >> +  normal world.
> >> +
> >> +  The buses are based on externally licensed IPs such as ARM NIC-301 and Arteris
> >> +  FlexNOC but DT bindings are specific to the integration of these bus
> >> +  interconnect IPs into imx SOCs.
> >
> > No need to use the interconnect binding?
>
> Separate RFC: https://patchwork.kernel.org/patch/11078673/
>
> The interconnect is represented by a separate "virtual" node which might
> not be OK. There was also a recent RFC from samsung which turns devfreq
> nodes into interconnect providers:
>      https://patchwork.kernel.org/cover/11054417/
>
> Is that preferable?

Virtual nodes are not OK.

>
> >> +required:
> >> +  - compatible
> >> +  - clocks
> >
> > reg?
>
> This is deliberately optional: for some NICs the GPV register area is
> not exposed in the memory map. This is unusual but an accurate
> description of the hardware.

Different h/w blocks should have different compatibles. GPV is an Arm
thing and I'd expect FlexNOC to be different.

> The current driver doesn't even attempt to map registers, it only
> adjusts the clock.

Irrelevant to the binding...

>
> >> +examples:
> >> +  - |
> >> +    #include <dt-bindings/clock/imx8mm-clock.h>
> >> +    noc: noc@32700000 {
> >> +            compatible = "fsl,imx8mm-noc", "fsl,imx8m-noc";
> >
> > Doesn't match the schema. (Well, it does with 'contains', but
> > fsl,imx8mm-noc is not documented.)
>
> I'm confused about how per-SOC compatible strings works with validation.
> There is a rule that every SOC dtsi needs to add soc prefix to all
> device nodes but of_device_id in driver code doesn't need to be updated.
>
> Without using "contains" on the "compatible" property then all
> SOC-specific compatible strings would need to be mentioned in every yaml
> files. Unless I'm missing something this means updating update every
> binding file for each new SOC?

Yes. The main exception is if various SoCs are just packaging,
binning, or fuse differences.

>
> I guess it can be useful because it also validates the compatible
> sequence itself.

Right. Order matters.

>
> For this current example something like this seems to work:
>
>    compatible:
>      oneOf:
>        - items:
>          - enum:
>            - fsl,imx8mm-nic
>            - fsl,imx8mq-nic
>          - const: fsl,imx8m-nic
>        - items:
>          - enum:
>            - fsl,imx8mm-noc
>            - fsl,imx8mq-noc
>          - const: fsl,imx8m-noc

Looks correct.

Rob
