Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2FC2BE5B8
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2019 21:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392318AbfIYTdX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Sep 2019 15:33:23 -0400
Received: from mail-eopbgr40066.outbound.protection.outlook.com ([40.107.4.66]:4303
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732837AbfIYTdX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 25 Sep 2019 15:33:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYHUzMTu8J+05LjbN7C7/JWOb/tkWIK8YdC6sVlRZ4n9lqINx3vcPisGkaPzjSnX7uNnunkTxLLUFJ833QkCwgg8Ga4qIGUTlxAnEFXNvGsQg2R5wY7vjtyCMHwCtcM0bmiwT2Oj+BUakUu7qO4NbJ1x1yHUxTdQtWnIf+Mza3razeYadpA+qte66rxwaLZd42ZEnV59yh5mA/OmPmTVSgQbZ9Junp8TF8LmiFISt20nxNOyi1cGIBwrgJZWsDibz38G69ka2j69pNNZkcrUOX3tktBPM5p5tRDADvjNOS/6kn4JPnI3cWzD3QlVCmcbJ3RHs0z1uqMRqGmowlD3vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hv1nzoHuZlDTZQ4aTa7FUq6Z0f2afQrAx0wJCcpCrqw=;
 b=GiqI78YbRBm2HY9Ei1hj2+qTmxuiwNZTrRUMX4KPv2D9H/AC6pt9paFqW5ppCoge32p3ijJI6zcbeVhfFHzIq94SySZFAk8pBvVZlQQupz5abROGfInulVpyFh7xjZr0Mv0LQKuUicspPLdbfq4CMACTV9YG6scw4aD3wm9bkD2DgDE/kMKtduhGUgcGE7NLMOe0YZJ/OIOz6gL2Fe9oNcMQ9+gMKVULDF05ugoNxvVgBXYuiZ+gRFcbcM3kRCjqJz1NrguM/c0qGPrAmBoPLq++MQfGnLxJNkzyZ+o4ojTiKeEZbBo81b29sAthNct91Wc4vQmJp/vWhNiBMW5VhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hv1nzoHuZlDTZQ4aTa7FUq6Z0f2afQrAx0wJCcpCrqw=;
 b=Sl7WWbFng283zgLvFBncJDRoCh91e8Cxfx1ISTJzG6Ke9O3mFDuw1WeNmGFk3bPzIy3U1G63KbGtaIxVWQ9/UGIrB/6uh6mLglyMeUvFmi4NEs5F8Kk3+OSgGcX9ngimh9M7EkL3FmKHJuuEWIrfqY/nfRLwDJyGx6OgLPGRymc=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB4223.eurprd04.prod.outlook.com (52.134.31.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.20; Wed, 25 Sep 2019 19:33:19 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::15cd:b6e7:5016:ae8]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::15cd:b6e7:5016:ae8%2]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 19:33:19 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Matthias Kaehlcke <mka@chromium.org>
CC:     Chanwoo Choi <cw00.choi@samsung.com>,
        Artur Swigon <a.swigon@samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v8 2/6] PM / devfreq: Move more initialization before
 registration
Thread-Topic: [PATCH v8 2/6] PM / devfreq: Move more initialization before
 registration
Thread-Index: AQHVcsByj1K9FTQJTE6xKNLyIFYeAQ==
Date:   Wed, 25 Sep 2019 19:33:19 +0000
Message-ID: <VI1PR04MB7023CF68F6B393E6FB2DE206EE870@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <398895f3b4f9ca4b03b47b56dfa25fbd58fd2311.1569319738.git.leonard.crestez@nxp.com>
 <cover.1569319738.git.leonard.crestez@nxp.com>
 <CGME20190924101139epcas1p4c6799a5de9bdb4e90abb74de1e881388@epcms1p4>
 <20190925015845epcms1p4f788aa587e53bfa38b9b847838b02342@epcms1p4>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d708d618-469a-4fe0-bba1-08d741ef384b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR04MB4223;
x-ms-traffictypediagnostic: VI1PR04MB4223:|VI1PR04MB4223:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4223381EFBCF629D42D3AAAAEE870@VI1PR04MB4223.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(189003)(199004)(5660300002)(7416002)(229853002)(6436002)(110136005)(76176011)(66066001)(478600001)(14454004)(7696005)(71190400001)(9686003)(25786009)(71200400001)(99286004)(86362001)(186003)(486006)(256004)(446003)(53546011)(6506007)(44832011)(91956017)(76116006)(33656002)(66476007)(66556008)(64756008)(66446008)(4326008)(66946007)(55016002)(102836004)(6246003)(81166006)(81156014)(476003)(26005)(2906002)(54906003)(74316002)(8936002)(6116002)(3846002)(7736002)(305945005)(52536014)(316002)(2501003)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4223;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cP+dICv0bMvk2n4Y94u2w20DlcaFzZUjHxEcgU2ErATyugTGSfeWkFdLmVAs0pvVGF/BWu4AuKN0haAx8BHLFBb6WdPPu0f8YpX0jfbiCHyCc+kXMD3NnM8458xbGHUD7xgHCjHp2c7y5Y1/4uXCxFo7pgsVpBAzWXVfYk+bbeA46t8fHy0IV731dhyEHY5PLae3Xgl8bBJ05nphm8Cr9mgS2ELeHz5j/raGvSkyWSCn8ZJhOn8+imaRy6bM/W5ZV9+/chWV5yU5CGac+gbd5005rjNRreNthOg5Q5lSGrYz7P226LQ6S+MDbhcsvudmIoAIBv9npGoLuPr7tioQsYQzxWmcUDSMKtc1VOTi3ESrN4WDcC/yPsFhorJJUJm5YcKGo1rOei5F5/DnyqBw6L0not5KA+R6Jig83I+dFcg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d708d618-469a-4fe0-bba1-08d741ef384b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 19:33:19.2059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 541ITLhnDjcXVAvUWQmjxEGZWFJCC8F81vrZgBeqe4y9sm208ErqiS8NuVr/8mmg6gQKjtXViD998mcGlklcmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4223
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 25.09.2019 04:59, MyungJoo Ham wrote:=0A=
>> In general it is a better to initialize an object before making it=0A=
>> accessible externally (through device_register).=0A=
>>=0A=
>> This makes it possible to avoid relying on locking a partially=0A=
>> initialized object.=0A=
>>=0A=
>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>=0A=
>> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>=0A=
> =0A=
> Do you object to the general idea of devm_* for device drivers?=0A=
> or did you find a bug in the memory handling in the code?=0A=
> =0A=
> The result of this commit still relies on locking anyway.=0A=
=0A=
This is a dependency of the following patch which removes the locking. I =
=0A=
will add this to the commit message because everybody asks.=0A=
=0A=
This patch removes devm because devm itself is only available after =0A=
device_initialize. Moving the allocation ahead of device_register (which =
=0A=
calls device_initialize) requires switching to manual memory management. =
=0A=
Since there are only two pointers it seemed reasonable.=0A=
=0A=
Alternatively device_register could be split into explicit =0A=
"device_initialize" and "device_add" steps and devm could be used =0A=
between those steps.=0A=
=0A=
Before:=0A=
  - device_register=0A=
  - devm-based-alloc=0A=
=0A=
After:=0A=
  + device_initialize=0A=
  + devm-based-alloc=0A=
  + device_add=0A=
=0A=
Does this make sense?=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
