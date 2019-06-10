Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A82193C023
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2019 01:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390561AbfFJXsq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Jun 2019 19:48:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390524AbfFJXsp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 10 Jun 2019 19:48:45 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC289206C3;
        Mon, 10 Jun 2019 23:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560210524;
        bh=72gAQp6W+mB42Owmu65aph68iaCWcwF69xAsJoCk818=;
        h=In-Reply-To:References:From:Cc:Subject:To:Date:From;
        b=m9+B2HLDSuwzf1/BR+YsFuY5vV0CzkU7xlGpUQv9GqHMTKKQSCoi64iopdgJidRIt
         1t5ny+47b5u70b/lsK0mQzQ5SpZ/+DA6Sr4DRnz45ROxuLbaQSSNOObaijhg3oGvrr
         wpFEZGnlWxtrMlkLWxbZViM6Ht4yBcSBJhJxu53Q=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <VI1PR04MB50558EF0387824D6AAEEB18EEE130@VI1PR04MB5055.eurprd04.prod.outlook.com>
References: <e48d7e3d71166cea20c3c200300e0ffa6d26d085.1559737589.git.leonard.crestez@nxp.com> <20190606031526.xknv5qdoqufim6tr@vireshk-i7> <VI1PR04MB50558EF0387824D6AAEEB18EEE130@VI1PR04MB5055.eurprd04.prod.outlook.com>
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Anson Huang <anson.huang@nxp.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Jacky Bai <ping.bai@nxp.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC] devfreq: Add generic devfreq-dt driver
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
User-Agent: alot/0.8.1
Date:   Mon, 10 Jun 2019 16:48:44 -0700
Message-Id: <20190610234844.CC289206C3@mail.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Leonard Crestez (2019-06-10 15:13:19)
> On 6/6/2019 6:15 AM, Viresh Kumar wrote:
> > On 05-06-19, 15:31, Leonard Crestez wrote:
> >> +static const struct of_device_id devfreq_dt_of_match[] =3D {
> >> +    { .compatible =3D "generic-devfreq", },
> >> +    { /* sentinel */ },
> >> +};
> >> +MODULE_DEVICE_TABLE(of, devfreq_dt_of_match);
> >=20
> > DT can't contain nodes for any virtual devices, this will have similar
> > problems to cpufreq-dt. How is this driver going to get probed ? Who
> > will create the device ?
>=20
> CPUs are special devices, I'm not sure the same issues apply here.
>=20
> If a SOC has multiple buses or frequency domains which can be scaled up=20
> and down then those can be treated as "real" devices and probing them=20
> from DT seems entirely reasonable. DT could look like this:
>=20
> +       noc1 {
> +               compatible =3D "fsl,imx8mm-noc", "generic-devfreq";
> +               clocks =3D <&clk IMX8MM_CLK_NOC1>;
> +               operating-points-v2 =3D <&noc1_opp_table>;
> +       };
> +
> +       noc1_opp_table: noc1-opp-table {
> +               compatible =3D "operating-points-v2";
> +
> +               opp-150M {
> +                       opp-hz =3D /bits/ 64 <150000000>;
> +               };
> +               opp-750M {
> +                       opp-hz =3D /bits/ 64 <750000000>;
> +               };
> +       };
>=20
> Instead of a "generic-devfreq" fallback the compatible list of=20
> devfreq-dt could contain a large number of unrelated compat strings.=20
> This would be vaguely similar to the white/black lists from cpufreq-dt-pl=
at.

This still looks very much "virtual" because the NoC node doesn't have a
'reg' property. Is there anything the driver will do besides change the
frequency of the clk based on the OPP table? If not, then it still looks
like this is a node for the sake of making devfreq happy to probe via
DT.

