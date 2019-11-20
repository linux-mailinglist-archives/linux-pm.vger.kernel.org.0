Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD381042CE
	for <lists+linux-pm@lfdr.de>; Wed, 20 Nov 2019 19:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfKTSDi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 Nov 2019 13:03:38 -0500
Received: from mail-eopbgr80053.outbound.protection.outlook.com ([40.107.8.53]:51379
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727777AbfKTSDi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 20 Nov 2019 13:03:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgkQAt9PCxj+K5qooQJpW+GiZ29szB8pOFWVmD7K0iH3ymtUz9bWChnXUg+Dv6yFJqJlQBzR3ipN/Tn4LBf0TDbkq2J9M+SB41PhIUg/s5+Yj/P5Jd19/rozQFUHIgfXx6UJcc0sI6O14kV1vdm4b+8N8kcB1Y59SqM6JHgwxyT2d8CXbFfq0dAdsNjG3pf0eiRXPoOTac9UknNgTnNLMxS4szQJtZIX7Hd5A3DU0Wz5PPzmrtEZfUUUMssOBnjrFq1YTqyBTEidJ9e3r+yueuU/ldU5zMAmv1EER55m6uvW3O+/bCY+q8oA+8S9oW3S3F6M+5OOUCX9u/h2vVfkpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smdTpNNqpotRYy1mknQ9cFeN3fez462MpjNvtaFfZb0=;
 b=FSXRuU0LCEDF0iRoL2/uHXxqfCG13mgGwscDcefU/hCY7Bi7J2IMzf+/9YifEu4GRTfkt+KekzxHY+owOyMoNhWFj4Y0j4j3ZNJE5Nys6qZtm9cA1wtuiG4m4hPiPrvldpqEapVpMkiwSojdBcxEOcfhqJkmDOSc67KK4HTlgsXALs2MIKXYfMozNZi5cCoT2lhrbKR8soLPo2XYbzJl7zGON+eOdLGI9wSErWXz38AfLyK5+UI7LYssZY9z8GfGy3YiA2pmQXliAJREep58B/2Ai6UijB+PbgLH1KHJYppny8L9PTLEDOGUV15BJLa+ysQOhX9Xnq+zzq2o4ICC6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smdTpNNqpotRYy1mknQ9cFeN3fez462MpjNvtaFfZb0=;
 b=VwJ15A65v7Pg1hOntPyhcxacpoNd9E4dVpV8EbdI21qoieKiTWVQCdwIu0elc3kvWG4YND8cucgv3QFVNgpeIqS7zejj4mRGMLFWqFRiwvmwFgHer9DOiGR5rjaBp4TEgcRIuzru76WyahVopRR8WJ032A4ij6xBFjjyagHco6U=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB5184.eurprd04.prod.outlook.com (20.177.51.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Wed, 20 Nov 2019 18:02:55 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::dd0c:72dc:e462:16b3%5]) with mapi id 15.20.2474.015; Wed, 20 Nov 2019
 18:02:55 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Angus Ainslie <angus@akkea.ca>, Jacky Bai <ping.bai@nxp.com>
CC:     Marco Felsch <m.felsch@pengutronix.de>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?iso-8859-2?Q?Artur_=A6wigo=F1?= <a.swigon@partner.samsung.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
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
        Matthias Kaehlcke <mka@chromium.org>,
        Martin Kepplinger <martink@posteo.de>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm-owner@vger.kernel.org" <linux-pm-owner@vger.kernel.org>
Subject: Re: [PATCH RFC v6 2/9] PM / devfreq: Add generic imx bus scaling
 driver
Thread-Topic: [PATCH RFC v6 2/9] PM / devfreq: Add generic imx bus scaling
 driver
Thread-Index: AQHVmyeZDID07b0oVkajwef04uXjmg==
Date:   Wed, 20 Nov 2019 18:02:54 +0000
Message-ID: <VI1PR04MB702329DCBBC98C405421D8DFEE4F0@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <cover.1573761527.git.leonard.crestez@nxp.com>
 <f329e715898a6b9fd0cee707a93fb1e144e31bd4.1573761527.git.leonard.crestez@nxp.com>
 <e311a376e6aec0c380686a7e307d2c07@akkea.ca>
 <VI1PR04MB70233920AC838AD88E1ECC26EE4F0@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <008f2fa973b23fc716d678c5bd35af54@akkea.ca>
 <VI1PR04MB7023E7C380EFA956629EEB67EE4F0@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <d1ca09bdeb7580c9b62b491c6eb30148@akkea.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e3fda3a5-3ff0-48bd-cf4c-08d76de3de42
x-ms-traffictypediagnostic: VI1PR04MB5184:|VI1PR04MB5184:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB51841F5C9C8DB547E63EEF00EE4F0@VI1PR04MB5184.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(189003)(199004)(8676002)(8936002)(6636002)(26005)(44832011)(7736002)(305945005)(478600001)(446003)(486006)(4001150100001)(54906003)(33656002)(76176011)(110136005)(14454004)(7416002)(186003)(476003)(316002)(7696005)(25786009)(74316002)(102836004)(6506007)(53546011)(81166006)(14444005)(55016002)(256004)(9686003)(66066001)(6436002)(229853002)(6246003)(86362001)(4326008)(71200400001)(71190400001)(2906002)(3846002)(6116002)(66556008)(52536014)(5660300002)(66476007)(66946007)(76116006)(99286004)(91956017)(64756008)(81156014)(66446008)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5184;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cb+3lbvdKHr4Ultyoo1zWoPFXiomIQrQNKVfpfr0XnX8Q6roYq4sh9Nuclc9Bs7LzFON4oOFNOxR9f+SZ0IluvHtP5oq6j7BbWjXjaoJ3d+S8tHAcOoFW2nXeeQfEI3ru3DKEO4cJoFER4QZ9FK6g3xbSEJFhn7rRUa4qxfzmmfzqReXVXI4YwUVugkpr/SvGN2n1eGST7OAzm0Nr9wnAI4N1DE9POD71l34Sh7DqC32bddh9L0wDDCLXr+unWCgEZc5jQ29DaFzzcFVPX7OEZmMP/AMz54Gupj8Wm855td4Wdbhyh2QqPBM/04CuFdN0ivP5uWrB+J005D9Gi79/bpXj17JusUe1PEqOi4rQelr0WY2+AfIjNxRNfGvQRLZgLMp++I8gr7XAIYmG1hT4eapB9tZj/WUVG5PkC0OsANh7GZwHGwVs/sMiYaz241U
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3fda3a5-3ff0-48bd-cf4c-08d76de3de42
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 18:02:54.8256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xrT/GbW8WVBkUbUxigdLCLITRoj+X6ZN7gaqRn3r14r0V2e2uGrgWcMgAdWju+iaJrVT98igKr1wtztI/bRYOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5184
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20.11.2019 18:38, Angus Ainslie wrote:=0A=
> On 2019-11-20 08:30, Leonard Crestez wrote:=0A=
>> On 20.11.2019 17:41, Angus Ainslie wrote:=0A=
>>> Hi Leonard,=0A=
>>>=0A=
>>> On 2019-11-20 07:04, Leonard Crestez wrote:=0A=
>>>> On 20.11.2019 16:08, Angus Ainslie wrote:=0A=
>>>> Is "mainline ATF" an important criteria for Purism?=0A=
>>>=0A=
>>> Yes we intend to bring all of our patches to mainline and were hoping=
=0A=
>>> that NXP would be doing the same. Shouldn't a mainline kernel run on a=
=0A=
>>> mainline ATF ?=0A=
>>=0A=
>> You can still use mainline ATF (tested right now) but the imx8m-ddrc=0A=
>> driver won't probe.=0A=
> =0A=
> Sorry I was talking about the DDR frequency scaling specifically. >=0A=
>> The ability to mix and match different branches of firmware and kernel=
=0A=
>> is very useful for testing. There might be slight incompatibilities but=
=0A=
>> in theory if a feature depends on both firmware and kernel support then=
=0A=
>> it should gracefully degrade rather than crash or hang.=0A=
> =0A=
> I saw the check you put in for the correct ATF version and that's very=0A=
> helpful thanks.=0A=
> =0A=
>> ATF support for this feature will be mainlined eventually, I picked the=
=0A=
>> linux side first because review is more challenging and changes are=0A=
>> much larger relative to what we have in our internal tree.=0A=
> =0A=
> Do you have a patch against mainline ATF that we can test this feature=0A=
> with ?=0A=
=0A=
Not right now, and imx atf is based on a slightly older version so some =0A=
porting effort might be required.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
