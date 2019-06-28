Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD8EC59657
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2019 10:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfF1Ipa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jun 2019 04:45:30 -0400
Received: from mail-eopbgr150085.outbound.protection.outlook.com ([40.107.15.85]:40798
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726240AbfF1Ipa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 28 Jun 2019 04:45:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=gjSpLhBMcITCtUbk1cF/melkL2HcdmqbE25GdgbPCzaIoCwuG3RqfCwvO+674zqq/lb+8/H8O4GxHeNte1UG9PrvZB4ap59wFIOYW7pP7jiAU22hNvSD7RI/dRCaTuSLnhCtU7Rjal8XS5J7faxVBW072mFTuiPCWNvo967cvDA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtKCWmZwlVrd958uO0fJWvMz9oFHEYnti+vR6S2u9Ck=;
 b=Jbn45SyF9y9p3Pa3arhWtkST2723OBZtISXlRgjDYqnUOd6aR4/KJyBPeeqmW8v/bBYEVOjYFTWGs/ssRkQCAuaqQpfFO2WfmxYOllYxepWiKNe84nnWlQXTg6VDyiS56F6mcdLqaQc+wvoPbpwp++p6kYDDsNlxFTRaJcKIeGM=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtKCWmZwlVrd958uO0fJWvMz9oFHEYnti+vR6S2u9Ck=;
 b=TX6zqya/9YDSmVzhLtR+Ahal6rFclIIxXTEwWTGvgIz79V6hKUdhUiFzUA7FFcfHmCz91b85mbmFBoWUCo7DJui5p0PXQUTdjPG+vZvQNBlOuHMzI3ee5UKubAf+W5xsR59b38ibLvkqsg5AJ7/jq8gU21EcMtRm89KoXAYzu1E=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5043.eurprd04.prod.outlook.com (20.177.40.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Fri, 28 Jun 2019 08:45:22 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::a126:d121:200:367]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::a126:d121:200:367%7]) with mapi id 15.20.2008.014; Fri, 28 Jun 2019
 08:45:22 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>
CC:     Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFCv2 2/8] clk: imx8m-composite: Switch to determine_rate
Thread-Topic: [RFCv2 2/8] clk: imx8m-composite: Switch to determine_rate
Thread-Index: AQHVLYSzFhiWj3SboUyyXoLKKvuOrKawwJqA
Date:   Fri, 28 Jun 2019 08:45:22 +0000
Message-ID: <20190628084521.d64d5g54zvxlsxsl@fsr-ub1664-175>
References: <cover.1561707104.git.leonard.crestez@nxp.com>
 <5d62b31309e6402bd9fa608730518b39af823fb3.1561707104.git.leonard.crestez@nxp.com>
In-Reply-To: <5d62b31309e6402bd9fa608730518b39af823fb3.1561707104.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d440702-1a1b-429a-5207-08d6fba4f55c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5043;
x-ms-traffictypediagnostic: AM0PR04MB5043:
x-microsoft-antispam-prvs: <AM0PR04MB50437A3B5ECB7561C6607BB4F6FC0@AM0PR04MB5043.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-forefront-prvs: 00826B6158
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(189003)(199004)(6486002)(71190400001)(86362001)(76116006)(33716001)(186003)(68736007)(25786009)(71200400001)(102836004)(1076003)(478600001)(476003)(256004)(486006)(14444005)(4326008)(305945005)(7736002)(26005)(11346002)(8936002)(73956011)(76176011)(9686003)(81156014)(53936002)(6862004)(2906002)(91956017)(6436002)(8676002)(316002)(6246003)(81166006)(14454004)(5660300002)(66476007)(6506007)(66066001)(7416002)(54906003)(446003)(6636002)(229853002)(53546011)(44832011)(6116002)(64756008)(66946007)(66556008)(66446008)(99286004)(6512007)(3846002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5043;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QRQCiFOQUELtbQCERU1f4VHj3UyT1RF9fXYg4ohYCGqf7YBJiWKX1xZJKMykHaDnSbRfsJj3LkqB0YTBZMmobM4N8lnoTDruIxi9P+3hVN4B0zkLW5HJE9VDK9QqO8eUKZeE8bh0fTqwDBQamg0Tplj0LH6PKHZwWMvJI7QScSnOHSBqjtKzlRUEgmxK7U/fTdXQTkJ5u3UCnKSxmMS3VZxIrL6f0XCmMg1vtBCa5uwZng9OTHcIXfi8W32ByGvcCAiutGxlGfTi+AhsU29bzFc/EaSh1jgHDMuqYEm7PpsTxbVoViNIIam2UIS6HJjSgqD2mw6aVxNCZ1hSP62wTShe8IVmfHH7PCKOv19p3E5JUchVh27WmauXhZ747yzg8BWp3ue1jhB5A+BSXB90KTL6uSrUpH+iE73pZoY8PvA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5F0D8F5AB70B2542BFE60CF90270C434@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d440702-1a1b-429a-5207-08d6fba4f55c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2019 08:45:22.8420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: abel.vesa@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5043
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19-06-28 10:39:50, Leonard Crestez wrote:
> This allows consumers to use min_rate max_rate.
>=20
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/clk/imx/clk-composite-8m.c | 34 +++++++++++++++++++-----------
>  1 file changed, 22 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-com=
posite-8m.c
> index 388bdb94f841..1be82ec08ecd 100644
> --- a/drivers/clk/imx/clk-composite-8m.c
> +++ b/drivers/clk/imx/clk-composite-8m.c
> @@ -45,10 +45,12 @@ static unsigned long imx8m_clk_composite_divider_reca=
lc_rate(struct clk_hw *hw,
>  				   divider->flags, PCG_DIV_WIDTH);
>  }
> =20
>  static int imx8m_clk_composite_compute_dividers(unsigned long rate,
>  						unsigned long parent_rate,
> +						unsigned long min_rate,
> +						unsigned long max_rate,

You should pass on the req instead of min_rate and max_rate here.

>  						int *prediv, int *postdiv)
>  {
>  	int div1, div2;
>  	int error =3D INT_MAX;
>  	int ret =3D -EINVAL;
> @@ -56,11 +58,17 @@ static int imx8m_clk_composite_compute_dividers(unsig=
ned long rate,
>  	*prediv =3D 1;
>  	*postdiv =3D 1;
> =20
>  	for (div1 =3D 1; div1 <=3D PCG_PREDIV_MAX; div1++) {
>  		for (div2 =3D 1; div2 <=3D PCG_DIV_MAX; div2++) {
> -			int new_error =3D ((parent_rate / div1) / div2) - rate;
> +			unsigned long new_rate;
> +			int new_error;
> +
> +			new_rate =3D ((parent_rate / div1) / div2);
> +			if (new_rate < min_rate || new_rate > max_rate)
> +				continue;
> +			new_error =3D new_rate - rate;
> =20
>  			if (abs(new_error) < abs(error)) {
>  				*prediv =3D div1;
>  				*postdiv =3D div2;
>  				error =3D new_error;
> @@ -69,38 +77,40 @@ static int imx8m_clk_composite_compute_dividers(unsig=
ned long rate,
>  		}
>  	}
>  	return ret;
>  }
> =20
> -static long imx8m_clk_composite_divider_round_rate(struct clk_hw *hw,
> -						unsigned long rate,
> -						unsigned long *prate)
> +static int imx8m_clk_composite_divider_determine_rate(struct clk_hw *hw,
> +						       struct clk_rate_request *req)
>  {
>  	int prediv_value;
>  	int div_value;
> =20
> -	imx8m_clk_composite_compute_dividers(rate, *prate,
> -						&prediv_value, &div_value);
> -	rate =3D DIV_ROUND_UP(*prate, prediv_value);
> +	imx8m_clk_composite_compute_dividers(req->rate, req->best_parent_rate,
> +					     req->min_rate, req->max_rate,
> +					     &prediv_value, &div_value);
> =20
> -	return DIV_ROUND_UP(rate, div_value);
> +	req->rate =3D DIV_ROUND_UP(req->best_parent_rate, prediv_value);
> +	req->rate =3D DIV_ROUND_UP(req->rate, div_value);
> =20
> +	return 0;
>  }
> =20
>  static int imx8m_clk_composite_divider_set_rate(struct clk_hw *hw,
> -					unsigned long rate,
> -					unsigned long parent_rate)
> +						unsigned long rate,
> +						unsigned long parent_rate)
>  {
>  	struct clk_divider *divider =3D to_clk_divider(hw);
>  	unsigned long flags =3D 0;
>  	int prediv_value;
>  	int div_value;
>  	int ret;
>  	u32 val;
> =20
>  	ret =3D imx8m_clk_composite_compute_dividers(rate, parent_rate,
> -						&prediv_value, &div_value);
> +						   0, ULONG_MAX,
> +						   &prediv_value, &div_value);
>  	if (ret)
>  		return -EINVAL;
> =20
>  	spin_lock_irqsave(divider->lock, flags);
> =20
> @@ -117,11 +127,11 @@ static int imx8m_clk_composite_divider_set_rate(str=
uct clk_hw *hw,
>  	return ret;
>  }
> =20
>  static const struct clk_ops imx8m_clk_composite_divider_ops =3D {
>  	.recalc_rate =3D imx8m_clk_composite_divider_recalc_rate,
> -	.round_rate =3D imx8m_clk_composite_divider_round_rate,
> +	.determine_rate =3D imx8m_clk_composite_divider_determine_rate,
>  	.set_rate =3D imx8m_clk_composite_divider_set_rate,
>  };
> =20
>  struct clk *imx8m_clk_composite_flags(const char *name,
>  					const char * const *parent_names,
> --=20
> 2.17.1
> =
