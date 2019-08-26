Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 409709D1E0
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2019 16:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731948AbfHZOpq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Aug 2019 10:45:46 -0400
Received: from mail-eopbgr30062.outbound.protection.outlook.com ([40.107.3.62]:51326
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731186AbfHZOpq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 26 Aug 2019 10:45:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Buxn2QG81vpY/FXll3QGUAicNOySJXSElWH3ZRqWD17toJL3aIcWnUXlOL1qknJnYVsh1SR6TWB5F2Hzy79R60hOHc8Webq+pHOesJGQjVCfDqMiVmz5tK1Dg4kpLXzkXbUn4bzAQxHiFjDWg8VVjCv2AnYV3ifF1pWtNZYNDpmFnW5fOAV/5SdgeXcN8RUboy0udbXzp3WS8/L8M4jbncLGRdOCvHDyTGv+tuX7naxQAjfPogRha8SD50Cny71S9b7juMM366qWatG8kU5jgMfGtlJGl/PP1KvSbm/OhTWsRgjLyLZrp3BwHIdrzOWtp1UVpDR1rYQVWKHrk09/CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bg44byClphCiUQr60zpMaGt8vFEHLaNwrwl9FbWvHtU=;
 b=mtSYezYLy4UAq4uprFERq6d92ybFiQQvWzsuERvUoq5ek/vJ1B1T5PVswx3LGf6s7ebmwh2W+WOYewtpZORMxAu9kwgXcJIbY8ejORh2jH1VOFsp5MtykRROj+dLPAOXrY1XTvzC47JifRslsQMu9BXywMSIF5KDQB/zx4hMwAHWgWghSNeNbeFmvft7crfnqIukjE9w7WQ4RafD5WZX1vs4bchjn1aIw4QorqfyV2aDsAbDXniphp1f8IWa45cM4xEteKUkF+aSguEc+e37sY1FQiVqlkF1M54OffidoAgs/1P/1sVzidP9hwH4JaLCfEcs4UG9bbMNTQgyAH4xCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bg44byClphCiUQr60zpMaGt8vFEHLaNwrwl9FbWvHtU=;
 b=NqWSZ27fqM5Tg50tHzY6SrJCr1OdxgfShOezVDlriYwsk7zUY1AHNDHRjlaEnqwvftHyqwZ9G2Tgi03i4G+2X9mpAN/oIEiW9XDFP/t3eDPvbxY0DrH0rmeD0xcF04viIYTPsdofwwEl2WK+Q2Flib2TCIvUHZIKfVSuRpyqM1Y=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB5920.eurprd04.prod.outlook.com (20.178.205.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Mon, 26 Aug 2019 14:45:40 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::c5e8:90f8:da97:947e]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::c5e8:90f8:da97:947e%3]) with mapi id 15.20.2199.021; Mon, 26 Aug 2019
 14:45:40 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>
CC:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH V3 1/5] thermal: qoriq: Add clock operations
Thread-Topic: [PATCH V3 1/5] thermal: qoriq: Add clock operations
Thread-Index: AQHVRn7UNdyaJx5tOE6OrvzyFWKCoA==
Date:   Mon, 26 Aug 2019 14:45:40 +0000
Message-ID: <VI1PR04MB7023F219CA7B4187F86EAA42EEA10@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <20190730022126.17883-1-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47938838-ec7c-4734-d552-08d72a3410b0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5920;
x-ms-traffictypediagnostic: VI1PR04MB5920:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB5920BA96346B2E7E954763FFEEA10@VI1PR04MB5920.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(396003)(39860400002)(136003)(376002)(199004)(189003)(486006)(476003)(44832011)(229853002)(316002)(6506007)(53546011)(14454004)(76176011)(99286004)(7696005)(54906003)(110136005)(8936002)(478600001)(102836004)(4326008)(25786009)(6246003)(26005)(446003)(66066001)(8676002)(53936002)(81166006)(81156014)(55016002)(9686003)(7416002)(33656002)(6116002)(3846002)(6436002)(74316002)(186003)(86362001)(305945005)(7736002)(2906002)(91956017)(64756008)(52536014)(66446008)(5660300002)(66574012)(76116006)(71190400001)(4744005)(14444005)(71200400001)(256004)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5920;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Q3gZqQGW1IqOtO/nyHuhZ9fJEamu1fq9qNEThjtXwkiT2Hlk+6jPgJ3b2AkBM8KTtNRtJ3txMsPMqIGCJmcHYIQlRNCPGHzEGl/wph5ZqrfAAw7JMe5rQ25b/uSR+QfOvNkt29LWvh/UZsAyafu7aOJ/cRvcBIzCfLSCGnefH7vad8Z7SnbqLqDxsFcLEoG+n8thsZ96N95nrbkVCzGumjOu/mTofRRPNQIviAu3eELwTItUHLPbBcVFzlY7fqNLtaVpc/1OSzvsKv/sTJOKlIVShSh1s9mMjU4yen8Tc9QMpnOesULloRngkLjajmHMiMWImOn6jMqZUB43hA6saaJoJsoCjlg45F+HlqRJrX41hRyIaExlaXH2WHcKWSwtcgEbGj1fzgWzVVoqTszcwoPuFWRy6rNqv5T0rXVjWyc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47938838-ec7c-4734-d552-08d72a3410b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 14:45:40.1203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tKaj00hjkeUWlXl5iMlRmFwSRu3JClmuBYC7cNjAwU0QwPtYy4VEcVK90JHgkf9VHivHm2UsCPszxMfOJtHeQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5920
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 7/30/2019 5:31 AM, Anson.Huang@nxp.com wrote:=0A=
> From: Anson Huang <Anson.Huang@nxp.com>=0A=
> =0A=
> Some platforms like i.MX8MQ has clock control for this module,=0A=
> need to add clock operations to make sure the driver is working=0A=
> properly.=0A=
> =0A=
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>=0A=
> Reviewed-by: Guido G=FCnther <agx@sigxcpu.org>=0A=
=0A=
This series looks good, do you think it can be merged in time for v5.4? =0A=
Today was v5.3-rc6.=0A=
=0A=
In an earlier series the CLK_IS_CRITICAL flags was removed from the TMU =0A=
clock so if the thermal driver doesn't explicitly enable it the system =0A=
will hang on probe. This is what happens in linux-next right now!=0A=
=0A=
Unless this patches is merged soon we'll end up with a 5.4-rc1 that =0A=
doesn't boot on imx8mq. An easy fix would be to drop/revert commit =0A=
951c1aef9691 ("clk: imx8mq: Remove CLK_IS_CRITICAL flag for =0A=
IMX8MQ_CLK_TMU_ROOT") until the thermal patches are accepted.=0A=
=0A=
Merging patches out-of-order when they have hard (boot-breaking) =0A=
dependencies also breaks bisect.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
