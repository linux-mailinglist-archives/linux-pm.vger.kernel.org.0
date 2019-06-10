Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C81C33BF38
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2019 00:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389429AbfFJWKM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Jun 2019 18:10:12 -0400
Received: from mail-eopbgr130074.outbound.protection.outlook.com ([40.107.13.74]:55854
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388328AbfFJWKM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 10 Jun 2019 18:10:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnUhM6lzbUUmwqBv1uRHu1Q1o2Qy1bISxKMAFr947kI=;
 b=TNBC7xombinh6IAlKufSLIr8Oa/T6qvBF4IXxli/WDTq2PrxSLLk10bh1hLeSA5iQ5xh9GVgNsw60VxqLtnsETofvIUX0pbA1VFHJK4opJ7Avg5ixoxr47Szi07r2UbRqN3V/DuPFXQH+MJ+1AXv3B8IBfqnzpg3Hrpj24dXD3w=
Received: from VI1PR04MB5055.eurprd04.prod.outlook.com (20.177.50.140) by
 VI1PR04MB5903.eurprd04.prod.outlook.com (20.178.205.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Mon, 10 Jun 2019 22:10:07 +0000
Received: from VI1PR04MB5055.eurprd04.prod.outlook.com
 ([fe80::9577:379c:2078:19a1]) by VI1PR04MB5055.eurprd04.prod.outlook.com
 ([fe80::9577:379c:2078:19a1%7]) with mapi id 15.20.1965.017; Mon, 10 Jun 2019
 22:10:07 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Alexandre Bailon <abailon@baylibre.com>,
        Anson Huang <anson.huang@nxp.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "georgi.djakov@linaro.org" <georgi.djakov@linaro.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "ptitiano@baylibre.com" <ptitiano@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        Jacky Bai <ping.bai@nxp.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: Re: [RFC PATCH 1/3] drivers: interconnect: Add a driver for i.MX SoC
Thread-Topic: [RFC PATCH 1/3] drivers: interconnect: Add a driver for i.MX SoC
Thread-Index: AQHU2dPAGEvIM5gAt0ufevh4gpMf+A==
Date:   Mon, 10 Jun 2019 22:10:07 +0000
Message-ID: <VI1PR04MB5055980A24CAC07010E6192AEE130@VI1PR04MB5055.eurprd04.prod.outlook.com>
References: <20190313193408.23740-1-abailon@baylibre.com>
 <20190313193408.23740-2-abailon@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0950b67e-8523-4625-5409-08d6edf0659d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5903;
x-ms-traffictypediagnostic: VI1PR04MB5903:
x-microsoft-antispam-prvs: <VI1PR04MB590340E245DAD739AAEA3B08EE130@VI1PR04MB5903.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0064B3273C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(366004)(136003)(189003)(199004)(8676002)(73956011)(68736007)(66556008)(6506007)(53546011)(66066001)(102836004)(81166006)(66946007)(81156014)(229853002)(53936002)(99286004)(7696005)(66446008)(66476007)(76176011)(64756008)(33656002)(74316002)(6436002)(14454004)(54906003)(478600001)(71190400001)(6636002)(5024004)(71200400001)(256004)(14444005)(76116006)(91956017)(8936002)(110136005)(9686003)(55016002)(305945005)(3846002)(6116002)(186003)(25786009)(5660300002)(44832011)(86362001)(52536014)(26005)(6246003)(486006)(4326008)(446003)(316002)(2906002)(7736002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5903;H:VI1PR04MB5055.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mj43Mubsto0+pYgjjiIHsx1bkGFIAxq7Aq+fazA4FwAuZNi4XZDbsbhtnwZcKtaKWnFt003Nmeda53VUfLF3D/uqt8k7xxYnLeRJATflUX6ZZag6X91TB6We+0LQvotK150jFylfYSBcBxfCGdBYug4mCXicxn672KsH2dbq/G8HNPrWyRPQeKffdVZ0o6xSgsDZQ1/G3zVx4R63j15dHOGsLf6zOCzObOZQc5HLXtGdH42bBf+r+8UZRcTlbRRMwgZH3afsIq0Yt25TZ5LWAINpsmbw+fMPbFPXzrCCBft+FFD4+vxLw9c2IQaEq3Y3bQrMxDihQ1vuF7EXsKbuQcdNMJu1JIdFsjvQgZmNmCrFZN4fKGJTiGdU8bL8hcz9K3zW29p7VtkSBxNfgazYkZ4noLJisOO/zLqDnb7w7ic=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0950b67e-8523-4625-5409-08d6edf0659d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2019 22:10:07.0868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leonard.crestez@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5903
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 3/13/2019 9:36 PM, Alexandre Bailon wrote:=0A=
> =0A=
> This adds support of i.MX SoC to interconnect framework.=0A=
> This is based on busfreq, from NXP's tree.=0A=
> This is is generic enough to be used to add support of interconnect=0A=
> framework to any i.MX SoC, and, even, this could used for some other=0A=
> SoC.=0A=
=0A=
> Thanks to interconnect framework, devices' driver request for=0A=
> bandwidth which is use by busfreq to determine a performance level,=0A=
> and then scale the frequency.=0A=
=0A=
This part is difficult for me to understand:=0A=
=0A=
> +static int busfreq_opp_bw_gt(struct busfreq_opp_node *opp_node,=0A=
> +			      u32 avg_bw, u32 peak_bw)=0A=
> +{=0A=
> +	if (!opp_node)=0A=
> +		return 0;=0A=
> +	if (opp_node->min_avg_bw =3D=3D BUSFREQ_UNDEFINED_BW) {=0A=
> +		if (avg_bw)=0A=
> +			return 2;=0A=
> +		else=0A=
> +			return 1;=0A=
> +	}=0A=
> +	if (opp_node->min_peak_bw =3D=3D BUSFREQ_UNDEFINED_BW) {=0A=
> +		if (peak_bw)=0A=
> +			return 2;=0A=
> +		else=0A=
> +			return 1;=0A=
> +	}=0A=
> +	if (avg_bw >=3D opp_node->min_avg_bw)=0A=
> +		return 1;=0A=
> +	if (peak_bw >=3D opp_node->min_peak_bw)=0A=
> +		return 1;=0A=
> +	return 0;=0A=
> +}=0A=
> +=0A=
> +static struct busfreq_opp *busfreq_cmp_bw_opp(struct busfreq_icc_desc *d=
esc,=0A=
> +					      struct busfreq_opp *opp1,=0A=
> +					      struct busfreq_opp *opp2)=0A=
> +{=0A=
> +	int i;=0A=
> +	int opp1_valid;=0A=
> +	int opp2_valid;=0A=
> +	int opp1_count =3D 0;=0A=
> +	int opp2_count =3D 0;=0A=
> +=0A=
> +	if (!opp1 && !opp2)=0A=
> +		return desc->current_opp;=0A=
> +=0A=
> +	if (!opp1)=0A=
> +		return opp2;=0A=
> +=0A=
> +	if (!opp2)=0A=
> +		return opp1;=0A=
> +=0A=
> +	if (opp1 =3D=3D opp2)=0A=
> +		return opp1;=0A=
> +=0A=
> +	for (i =3D 0; i < opp1->nodes_count; i++) {=0A=
> +		struct busfreq_opp_node *opp_node1, *opp_node2;=0A=
> +		struct icc_node *icc_node;=0A=
> +		u32 avg_bw;=0A=
> +		u32 peak_bw;=0A=
> +=0A=
> +		opp_node1 =3D &opp1->nodes[i];=0A=
> +		opp_node2 =3D &opp2->nodes[i];=0A=
> +		icc_node =3D opp_node1->icc_node;=0A=
> +		avg_bw =3D icc_node->avg_bw;=0A=
> +		peak_bw =3D icc_node->peak_bw;=0A=
> +=0A=
> +		opp1_valid =3D busfreq_opp_bw_gt(opp_node1, avg_bw, peak_bw);=0A=
> +		opp2_valid =3D busfreq_opp_bw_gt(opp_node2, avg_bw, peak_bw);=0A=
> +=0A=
> +		if (opp1_valid =3D=3D opp2_valid && opp1_valid =3D=3D 1) {=0A=
> +			if (opp_node1->min_avg_bw > opp_node2->min_avg_bw &&=0A=
> +				opp_node1->min_avg_bw !=3D BUSFREQ_UNDEFINED_BW)=0A=
> +				opp1_valid++;=0A=
> +			if (opp_node1->min_avg_bw < opp_node2->min_avg_bw &&=0A=
> +				opp_node2->min_avg_bw !=3D BUSFREQ_UNDEFINED_BW)=0A=
> +				opp2_valid++;=0A=
> +		}=0A=
> +=0A=
> +		opp1_count +=3D opp1_valid;=0A=
> +		opp2_count +=3D opp2_valid;=0A=
> +	}=0A=
> +=0A=
> +	if (opp1_count > opp2_count)=0A=
> +		return opp1;=0A=
> +	if (opp1_count < opp2_count)=0A=
> +		return opp2;=0A=
> +	return opp1->perf_level >=3D opp2->perf_level ? opp2 : opp1;=0A=
> +}=0A=
> +=0A=
> +static int busfreq_set_best_opp(struct busfreq_icc_desc *desc)=0A=
> +{=0A=
> +	struct busfreq_opp *opp, *best_opp =3D desc->current_opp;=0A=
> +=0A=
> +	list_for_each_entry(opp, &desc->opps, node)=0A=
> +		best_opp =3D busfreq_cmp_bw_opp(desc, opp, best_opp);=0A=
> +	return busfreq_set_opp(desc, best_opp);=0A=
> +}=0A=
=0A=
The goal seems to be to find the smaller platform-level "busfreq_opp" =0A=
which can meet all aggregated requests.=0A=
=0A=
But why implement this by comparing opps against each other? It would be =
=0A=
easier to just iterate OPPs from low to high and stop on the first one =0A=
which meets all requirements.=0A=
=0A=
The sdm845 provider seems to take a different approach: there are BCMs =0A=
("Bus Clock Managers") which are attached to some of the icc nodes and =0A=
those are individually scaled in order to meet BW requirements. On imx8m =
=0A=
we can scale buses via clk so we could just attach clks to some of the =0A=
nodes (NOC, DRAM, few PL301).=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
