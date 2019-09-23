Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B75BBBD89
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2019 23:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388087AbfIWVEA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Sep 2019 17:04:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:44478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387617AbfIWVEA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 23 Sep 2019 17:04:00 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8C5121D6C;
        Mon, 23 Sep 2019 21:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569272639;
        bh=2HYumd6bd7QRJSQoXTVBAjk+hlSmBUlgr4Tc4zusLQ0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SHMrH9mKtbzwDtautaW56F2gZJ/7E26XI4ICgPvRlM2lw+pLFtdV72SS0gDbQ/7HS
         AeF0TEgpXua/5uF0IIjl/uUUH1J5LvFIlwbsiufWPQIEZBC0dx7DYaYtQ2TW6sJIMa
         zkwHenm3uaGVC+R8S0DPDmBSgnZb4rOdS4r+QbTY=
Received: by mail-qt1-f170.google.com with SMTP id n7so18930536qtb.6;
        Mon, 23 Sep 2019 14:03:58 -0700 (PDT)
X-Gm-Message-State: APjAAAVHjmQNMh2IxGQwnhegSYdW/5ibSpn8rB8VqNabAsmmwxsWL5JO
        QpYQ/z4En4Cq1CYfyVTzp8sNNBFoxt3srmiUKA==
X-Google-Smtp-Source: APXvYqyb1clyCP0EtxyvXy3tkLKx/+18o0FpEUsDXY0uUXP5M9qYVVG7aLQNU81ezk89PZ/fmRTJyZLQgdFP8aVfF+U=
X-Received: by 2002:ac8:6915:: with SMTP id e21mr2219537qtr.224.1569272638075;
 Mon, 23 Sep 2019 14:03:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1566570260.git.leonard.crestez@nxp.com> <3f27038292c09c8bf07a086eac759132c100aedb.1566570260.git.leonard.crestez@nxp.com>
 <20190917201956.GA10780@bogus> <VI1PR04MB70237046A8DF88936C7A83F8EE850@VI1PR04MB7023.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB70237046A8DF88936C7A83F8EE850@VI1PR04MB7023.eurprd04.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 23 Sep 2019 16:03:46 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLj9FdoSwt7HZwoX42GS9RJ6Zeze=bUZs-tia2oS+OzUA@mail.gmail.com>
Message-ID: <CAL_JsqLj9FdoSwt7HZwoX42GS9RJ6Zeze=bUZs-tia2oS+OzUA@mail.gmail.com>
Subject: Re: [RFCv4 3/7] dt-bindings: devfreq: imx: Describe interconnect properties
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 23, 2019 at 12:42 PM Leonard Crestez
<leonard.crestez@nxp.com> wrote:
>
> On 17.09.2019 23:20, Rob Herring wrote:
> > On Fri, Aug 23, 2019 at 05:36:56PM +0300, Leonard Crestez wrote:
> >> The interconnect-node-id property is parsed by the imx interconnect
> >> driver to find nodes on which frequencies can be adjusted.
> >>
> >> Add #interconnect-cells so that device drivers can request paths from
> >> bus nodes instead of requiring a separate "virtual" node to represent
> >> the interconnect itself.
> >>
> >> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> >> ---
> >>   Documentation/devicetree/bindings/devfreq/imx-ddrc.yaml | 5 +++++
> >>   Documentation/devicetree/bindings/devfreq/imx.yaml      | 5 +++++
> >>   2 files changed, 10 insertions(+)
> >
> > Please combine this with the other series for devfreq support.
>
> I understand that having two series which add to the same bindings file
> is odd but the devfreq and interconnect parts are independent to a very
> large degree and devfreq can be useful on it's own.

To start with, I'm suspicious of any 'devfreq' binding because that's
a Linux thing. I somewhat expect that the interconnect binding should
replace the devfreq binding, but I haven't been able to investigate.

> The only reason devfreq bindings are updated is to avoid adding a
> "virtual" node for interconnect. Since DT is a big source of confusion
> here can you read https://patchwork.kernel.org/cover/11111865/#22883457
> and maybe offer some advice?

Design something that matches the structure of the h/w not how Linux
drivers happen to be structured. I can't tell what that is without any
context around adding a couple of properties. Nor do I have the time
to dig into each SoC vendor's bus structure if it's even documented
publicly.

I also don't follow why you need 'interconnect-node-id' and if you do,
it should be a common property.

Rob
