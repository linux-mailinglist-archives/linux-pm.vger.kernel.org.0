Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD08B3A6B
	for <lists+linux-pm@lfdr.de>; Mon, 16 Sep 2019 14:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfIPMf3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Sep 2019 08:35:29 -0400
Received: from mail-eopbgr20053.outbound.protection.outlook.com ([40.107.2.53]:18055
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726696AbfIPMf3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Sep 2019 08:35:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=medvI1zpWPUrIsPH4uoDBwjY5l+6UaRc4VjTIwIxMqawRYNpb67ImWMLgv5+AHcGmwI0Fj/b7HWLk7ywkzvBkKLKVP+EU3Jqf+LOQVytN1UVFy6/3Ap0VWaoyEj1OTHKIV2o4iaFmEGE0SbUlE/FIjVQ2/rA1Qkp9PlDomfBAthy/nFQvZYW+7CVO2UseAixx3tBTwOI976fKVjSobh06v3Sz94uE/CVK5843n4ihWScQlknoIVdrrMmr9d+waxMw6G2Xj9Zcj9fLiSxqJdKH9OfpI68xJPjC3zEI8B+hxpqeit2DNhWN0qghwWIk+SkptRjWh8f/GWdKLgJo4SDgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ml3YPGsLpUOIkgTIous3KeFaFrHR8fYhTHyUTHQBDvk=;
 b=OsqCm5K1Ls2JCtopimvLl5yw7Jv+wO9ppElouZnVqT/3dn4iwE/rS0G4FYGhlGRoHdVTKLsRdRiIZPMR8SL5zIxsmvq0roH6qqQyFFrDGqnH+fGV3m0vKlLUaZOBV/DSLG4mLeTC68OsY+wUvxIJxb48tkwaRIufuy4fel+boCnY12gOWFekGrWbRt5xsCt7NGbl1ZApd6cpG+r8ToXz8BIrlCWwSNGtWwnjqdH6/GOl2hAotzXNFO+5Zf89KJHfOvfaDr8n3SGwOrtDNMX88tSl+ScXeI/5fZBBp/hsTvs7ApSVxNR0hD6zcrKEAOgIQH95k6NkEl8/vUSMcs4T4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ml3YPGsLpUOIkgTIous3KeFaFrHR8fYhTHyUTHQBDvk=;
 b=DQD0lSihdWhpEFFa6i9KeLWap9Bzz/jHy5gXF8D3bI3zFJAat2MAMGe5bksg6ymr4RArj+FMFJQ0Gs+et9tjGyXa3l8zDlpjJ776iow1ZI/NuW0hpa9GQHxnXBDq/AQVSxtr2JKBNP7LWzg0cDUf5x9T//SF2B96P6DVXOpMEuM=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB3280.eurprd04.prod.outlook.com (10.170.231.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.23; Mon, 16 Sep 2019 12:34:45 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::c5e8:90f8:da97:947e]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::c5e8:90f8:da97:947e%3]) with mapi id 15.20.2263.023; Mon, 16 Sep 2019
 12:34:45 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@partner.samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFCv4 0/7] interconnect: Add imx support via devfreq
Thread-Topic: [RFCv4 0/7] interconnect: Add imx support via devfreq
Thread-Index: AQHVWcA7xPiNhLrdqkSG10Lu7U9EhQ==
Date:   Mon, 16 Sep 2019 12:34:45 +0000
Message-ID: <VI1PR04MB702373BE28E4404C7F2CE75FEE8C0@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1566570260.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 566f74f1-8beb-4b4f-7e67-08d73aa241c7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR04MB3280;
x-ms-traffictypediagnostic: VI1PR04MB3280:|VI1PR04MB3280:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB328079E81EFC1924AE45127AEE8C0@VI1PR04MB3280.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0162ACCC24
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(199004)(189003)(33656002)(486006)(44832011)(7696005)(9686003)(8936002)(81156014)(8676002)(99286004)(86362001)(55016002)(2501003)(66066001)(54906003)(110136005)(316002)(25786009)(476003)(14454004)(76116006)(91956017)(186003)(66446008)(66556008)(66476007)(66946007)(4326008)(64756008)(26005)(53546011)(76176011)(478600001)(102836004)(6506007)(3846002)(7416002)(6116002)(71190400001)(71200400001)(52536014)(81166006)(446003)(256004)(229853002)(6436002)(305945005)(53936002)(5660300002)(2906002)(74316002)(7736002)(6246003)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3280;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cIcb1sLISs6WjBDIovfGIeSHBXeZ9HrV/DNCBq26iQPPSL8chDkPbElHx/Y93thtdeEJtjNkfv5VeouaHbdtztcTPgmMXKhdERJPog6CNu5vdC8vLjLCly0ImDQ0fRy9hg4n7q97SExCfFZwaD0UYWH4AamMJq3E9+cNhRLelMLwclsn4oK4vQ1zNflpqO4oKkEZ4tZf8LbqHNvGhoGFaG3JsfHSyosckfCQ9DWCa2355cDFPc/a/WULhTxLEQTv6aQekdrCmUVQ0k4wps7OgY3oIeaXb6+DssvflSVNbAbq8YKQHUjfIorC4FUeCl1eCSDW0ucd62x31Y7eeF4TdbcZCyAL2w3nQ4kZ2IjXCl5PmJ60+qKbngbCgps1lPRvOB8Fqa+PE0sTyX7WrBp2MLW3BPmJOqOEhE9Dw6+VNpI=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 566f74f1-8beb-4b4f-7e67-08d73aa241c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2019 12:34:45.4176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CWaEHDDjLQDsP/13KOQHx/1aut7vKDMooUcJRCvOQoKjmBYNjfNXIJnzxRgOvi057LKJoUQRd88fFhkrsOphQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3280
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23.08.2019 17:37, Leonard Crestez wrote:=0A=
> This series add imx support for interconnect via devfreq: the ICC=0A=
> framework is used to aggregate requests from devices and then those are=
=0A=
> converted to DEV_PM_QOS_MIN_FREQUENCY requests for devfreq.=0A=
>  =0A=
> Since there is no single devicetree node that can represent the "intercon=
nect"=0A=
> new API is added to allow individual devfreq nodes to act as parsing prox=
ies=0A=
> all mapping to a single soc-level icc provider. This is still RFC=0A=
> because of this=0A=
=0A=
Any comments? I made a lot of changes relative to previous versions, =0A=
most of them solely to avoid adding a virtual node in DT bindings.=0A=
=0A=
The only current interconnect provider implementation is for qcom and it =
=0A=
uses a firmware node as the provider node (with #interconnect-cells). =0A=
However there is no obvious equivalent of that for imx and many other SOCs.=
=0A=
=0A=
On imx there are multiple pieces of scalable fabric which can be defined =
=0A=
in DT as devfreq devices and it sort of makes sense to add =0A=
#interconnect-cells to those. However when it comes to describing the =0A=
SOC interconnect graph it's much more convenient to have a single =0A=
per-SOC platform driver.=0A=
=0A=
My solution is to add an "icc_proxy" API so that a single platform-level =
=0A=
interconnect provider can be referenced through multiple DT nodes. Does =0A=
this make sense?=0A=
=0A=
The implementation is not very pretty, the interconnect platform devices =
=0A=
ends up enumerating the entire devicetree in order to find proxies.=0A=
=0A=
Right now the interconnect API use a relatively standard split between =0A=
consumer and "provider" but I think it might make sense to have a =0A=
separate abstractions for "graph" and "midnode". A "midnode" could act =0A=
as a DT proxy if there is no single representation of the "interconnect" =
=0A=
and it could support custom scaling for itself (with the default being =0A=
scaling kbps into MIN_FREQ).=0A=
=0A=
There are also other options:=0A=
  * Pick one "main" bus and bless it as the "interconnect provider". I =0A=
want to represent buses as devfreq devices so I would have to call from =0A=
devfreq to ICC for registration somehow.=0A=
  * Maybe the "no virtual device" rule could be relaxed for the =0A=
interconnect subsystem?=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
