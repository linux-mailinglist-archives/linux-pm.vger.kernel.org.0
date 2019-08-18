Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8773F913EB
	for <lists+linux-pm@lfdr.de>; Sun, 18 Aug 2019 03:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfHRBLf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 17 Aug 2019 21:11:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:44780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfHRBLf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 17 Aug 2019 21:11:35 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE6F52173B;
        Sun, 18 Aug 2019 01:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566090693;
        bh=HEk8XIpEA4mKu9ETPAtTenyB9qoVj6YJR6owDZIimHs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=sK9Zf/ugbsO75h1nHUNXz44KUjY5aEA9MnyjFVsDNwQTo4GWK7FXrVcl8buP+RkpQ
         IKARSoCV5i/ZRLTSA7Vx7M11YUQKMWzMqPd4RQkrPe05z/EE9Ib+ZloogrWcWnN5cW
         u/2QgfCMRzjgHcPCupHFUaAQ6csiw5Muyoa2MIyY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <DB3PR0402MB3916D320EB51B2D9E28D55E1F5AE0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1565866783-19672-1-git-send-email-Anson.Huang@nxp.com> <1565866783-19672-5-git-send-email-Anson.Huang@nxp.com> <20190817035220.268F32173B@mail.kernel.org> <DB3PR0402MB3916D320EB51B2D9E28D55E1F5AE0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Subject: RE: [PATCH 5/6] clk: imx8mn: Add necessary frequency support for ARM PLL table
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
To:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>
User-Agent: alot/0.8.1
Date:   Sat, 17 Aug 2019 18:11:33 -0700
Message-Id: <20190818011133.CE6F52173B@mail.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Anson Huang (2019-08-17 15:22:01)
> Hi, Stephen
>=20
> > Quoting Anson.Huang@nxp.com (2019-08-15 03:59:42)
> > > diff --git a/drivers/clk/imx/clk-imx8mn.c
> > > b/drivers/clk/imx/clk-imx8mn.c index ecd1062..3f1239a 100644
> > > --- a/drivers/clk/imx/clk-imx8mn.c
> > > +++ b/drivers/clk/imx/clk-imx8mn.c
> > > @@ -82,6 +84,7 @@ static struct imx_pll14xx_clk imx8mn_dram_pll =3D {
> > > static struct imx_pll14xx_clk imx8mn_arm_pll =3D {
> > >                 .type =3D PLL_1416X,
> > >                 .rate_table =3D imx8mn_pll1416x_tbl,
> > > +               .rate_count =3D ARRAY_SIZE(imx8mn_pll1416x_tbl),
> >=20
> > Why is rate_count added? That's not described in the commit text.
>=20
> rate_count is necessary for table search during set_rate, it was missed p=
reviously,
> I will add it into commit text in V2.
>=20

Right, isn't that a more critical fix to make by itself instead of
rolling into this change that adds a few more frequencies?

