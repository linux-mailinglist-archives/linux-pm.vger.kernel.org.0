Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB26F93B0
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2019 16:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfKLPKS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Nov 2019 10:10:18 -0500
Received: from mail-eopbgr80082.outbound.protection.outlook.com ([40.107.8.82]:39680
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726982AbfKLPKR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 12 Nov 2019 10:10:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kl4D4rV+tTYigdBoP0LJ44rNhicb6sBhvg6LYgWEoL4dHpf5c1nPm2nB2BqMGViTmI6WfSUxrd5dBWiQcF9pbZnYQMnowYbn51Kzs45iH2wX82+F0D5UlMT3HXWLSsKHFg0ZqntvOkW3KUcjbMgc4KnIfJgcXPpijKmGqLTdOrfD9kEUyXxVNuXO9yDc34+yam37fmN8sKNFQVuL+b19JMFtIFkYRZyvNJgTi/k72KbDkTpFdpZsXOCCCxkJ/MvEeclE32KZeNxCQm+CBsmoC9VLVzYEvWIovHg1Hj9iJGvFo6FqLwDi+JvWAg/ZW+7uPw/ojKreP4bsj9SWqOJHgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dztztVnatxYEo7Do6v5rCP3ACyhW8HFSEMDdISM9eoo=;
 b=W5OflWjEenlwd6hmlHfMqRgdN06kIczLrHJpHw9E305f3/QKSC6ady8GP6u3IaG61WPpj7LENeAojJXIMBkcjaqsDv2FQLWeO3/Ygxx7snNhIV7v05YJBlT2KeyCVXDnYpQvqu+Yc7QllpuSr0MD2FshK2bmdr/Qs8eE5YIqAUF9VQQl5M2GTy+vcX5NrTbk1c6yct/EHG0c9Ts7kQusn/NmfXCmY60Mp8bhaIsp5jx2JqX5Uz2eWIkL3QDtR2FF3v3C5gKt02iQH2bGs/J3vAQ4BxN8Pedx9CyC2ItoqXLh/xNDF3bnsD/IDc9tY1m1n+c/7403t1VbqNJtUfJRNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dztztVnatxYEo7Do6v5rCP3ACyhW8HFSEMDdISM9eoo=;
 b=ClSeF6DQz3SQmHX78jdeqPDIvRZ5Jx2yXDb0jZNNLrDsc64M+Tb77Bx0a1vsCY7r9I0lonJ8zi2fpY+3ed++lGJd1Q4KR+n4JZPubNTmdFVGYFmjS3aEreO9UZKc2HTi3QTUi5iESo4dKdP6+B48e56oAhY73mnTmbGsRLcDYmA=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5457.eurprd04.prod.outlook.com (20.178.113.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Tue, 12 Nov 2019 15:10:10 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde%7]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 15:10:10 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>
CC:     Stephen Boyd <sboyd@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Angus Ainslie <angus@akkea.ca>,
        Martin Kepplinger <martink@posteo.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 1/6] clk: imx8m: Set CLK_GET_RATE_NOCACHE on dram
 clocks
Thread-Topic: [PATCH v4 1/6] clk: imx8m: Set CLK_GET_RATE_NOCACHE on dram
 clocks
Thread-Index: AQHVloV7VZOJz0hWAkeO+G3807P1dqeHqX8A
Date:   Tue, 12 Nov 2019 15:10:09 +0000
Message-ID: <20191112151008.5spfh7y5xzppk4s5@fsr-ub1664-175>
References: <cover.1573252696.git.leonard.crestez@nxp.com>
 <0e0eeeee546a3bb664935184d66866f1c66458ce.1573252696.git.leonard.crestez@nxp.com>
 <20191112111803.c5624in2masqipqf@fsr-ub1664-175>
 <VI1PR04MB702387DCA9DB5A0A3F6288EDEE770@VI1PR04MB7023.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB702387DCA9DB5A0A3F6288EDEE770@VI1PR04MB7023.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM3PR04CA0147.eurprd04.prod.outlook.com (2603:10a6:207::31)
 To AM0PR04MB5779.eurprd04.prod.outlook.com (2603:10a6:208:131::23)
x-originating-ip: [89.37.124.34]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e617868e-1576-4286-50b5-08d76782689d
x-ms-traffictypediagnostic: AM0PR04MB5457:|AM0PR04MB5457:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5457057E559698CA92B00EEBF6770@AM0PR04MB5457.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(199004)(189003)(6246003)(5660300002)(6486002)(14454004)(478600001)(6436002)(4326008)(6862004)(229853002)(25786009)(66476007)(3846002)(6512007)(9686003)(66946007)(66556008)(64756008)(66446008)(1076003)(6116002)(14444005)(486006)(446003)(256004)(71190400001)(81156014)(7416002)(99286004)(11346002)(81166006)(44832011)(54906003)(52116002)(66066001)(476003)(8676002)(8936002)(6636002)(186003)(76176011)(71200400001)(386003)(6506007)(53546011)(86362001)(33716001)(2906002)(7736002)(305945005)(316002)(102836004)(26005)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5457;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T9fQXSzCQFmpUb97+BdguccGjsric9igcMnkcYHDTMMuWFbTTaOW0CzmAga7mhvVaU34pDeKaYiQiQk4zFX3wV4pFKc/nZkE2b9TjqomJV3rxHIDvWPqDzxTpv2aSzH56t5hlMTmswc50zhdzsltKGBAlMR+IG9vg/XDpwfONyUERhYtFqZwWQQVCzoFF8UT9dcfR4Rci9HA6jv/DNvbWdUePIrvbRAlldQoMN3gxNkqs+YHnoEqI7hcjgQqGy4bBy93JF/HKmm0HnegeQIzp2l0osxeVcbXvPPuHZ2YXYrFCYdtdWBuOYNH2lX4OiWVHP0rJ2SHQcmD3UlojYmLuHsyUMpmEqHZhV+2rVqgBx+JhFYZF47em4GlWlAn/mtKV3E/MxE3yKI12MmFJy/xqQObMHFiRkrxvwACY5TGj/gaRO8/KluXkj7KLHnOeQgz
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <CEBC11D2F4C3804D8B849B3252B2D1CF@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e617868e-1576-4286-50b5-08d76782689d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 15:10:09.7862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: txkS3UEo/uv0zvf5u/GtkwcT/2VejBnUUpum6BVpkUuJboWqFjGM7N5JJHmdmTKy1JeFX8l8dvWwSDUU3s7U9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5457
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19-11-12 13:43:35, Leonard Crestez wrote:
> On 12.11.2019 13:18, Abel Vesa wrote:
> > On 19-11-09 00:39:51, Leonard Crestez wrote:
> >> These clocks are only modified as part of DRAM frequency switches duri=
ng
> >> which DRAM itself is briefly inaccessible. The switch is performed wit=
h
> >> a SMC call to by TF-A which runs from a SRAM area; upon returning to
> >> linux several clocks bits are modified and we need to update them.
> >>
> >> For rate bits an easy solution is to just mark with
> >> CLK_GET_RATE_NOCACHE so that new rates are always read back from
> >> registers.
> >>
> >> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> >> ---
> >>   drivers/clk/imx/clk-imx8mm.c | 11 +++++++++--
> >>   drivers/clk/imx/clk-imx8mn.c | 12 ++++++++++--
> >>   drivers/clk/imx/clk-imx8mq.c | 15 +++++++++++----
> >>   3 files changed, 30 insertions(+), 8 deletions(-)
>=20
> >> --- a/drivers/clk/imx/clk-imx8mn.c
> >> +++ b/drivers/clk/imx/clk-imx8mn.c
> >> @@ -428,12 +428,20 @@ static int imx8mn_clocks_probe(struct platform_d=
evice *pdev)
> >>   	clks[IMX8MN_CLK_AHB] =3D imx8m_clk_composite_critical("ahb", imx8mn=
_ahb_sels, base + 0x9000);
> >>   	clks[IMX8MN_CLK_AUDIO_AHB] =3D imx8m_clk_composite("audio_ahb", imx=
8mn_audio_ahb_sels, base + 0x9100);
> >>   	clks[IMX8MN_CLK_IPG_ROOT] =3D imx_clk_divider2("ipg_root", "ahb", b=
ase + 0x9080, 0, 1);
> >>   	clks[IMX8MN_CLK_IPG_AUDIO_ROOT] =3D imx_clk_divider2("ipg_audio_roo=
t", "audio_ahb", base + 0x9180, 0, 1);
> >>   	clks[IMX8MN_CLK_DRAM_CORE] =3D imx_clk_mux2_flags("dram_core_clk", =
base + 0x9800, 24, 1, imx8mn_dram_core_sels, ARRAY_SIZE(imx8mn_dram_core_se=
ls), CLK_IS_CRITICAL);
> >> -	clks[IMX8MN_CLK_DRAM_ALT] =3D imx8m_clk_composite("dram_alt", imx8mn=
_dram_alt_sels, base + 0xa000);
> >> -	clks[IMX8MN_CLK_DRAM_APB] =3D imx8m_clk_composite_critical("dram_apb=
", imx8mn_dram_apb_sels, base + 0xa080);
> >> +
> >> +	/*
> >> +	 * DRAM clocks are manipulated from TF-A outside clock framework.
> >> +	 * Mark with GET_RATE_NOCACHE to always read div value from hardware
> >> +	 */
> >> +	clks[IMX8MN_CLK_DRAM_ALT] =3D __imx8m_clk_composite("dram_alt", imx8=
mn_dram_alt_sels, base + 0xa000,
> >> +			CLK_GET_RATE_NOCACHE);
> >> +	clks[IMX8MN_CLK_DRAM_APB] =3D __imx8m_clk_composite("dram_apb", imx8=
mn_dram_apb_sels, base + 0xa080,
> >> +			CLK_IS_CRITICAL | CLK_GET_RATE_NOCACHE);
> >=20
> > nitpick: I think it looks better if we stick to one line each clock.
> > I know it's against the 80 chars rule, but at least is consistent.
>=20
> Yes, there are longer lines in the imx8m* files anyway.
>=20
> If I fix this (in all instances) can I also add a "reviewed-by"?
>=20

Sorry, I forgot to add the line.

For all the clock related changes:

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

> --
> Regards,
> Leonard
