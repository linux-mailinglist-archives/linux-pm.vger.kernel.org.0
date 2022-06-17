Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953E054F235
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jun 2022 09:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377895AbiFQHv6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 Jun 2022 03:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234463AbiFQHv5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2022 03:51:57 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2081.outbound.protection.outlook.com [40.107.21.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F96C674FD;
        Fri, 17 Jun 2022 00:51:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrXtF0PMKrbd1cjX/L3B+k8GImcrNDIxqSw3taV7VosN2HqfBT7i9pI8zLgBBge28/FUunaxtpPy90G7LGtKbZ1YRB1hPEDORu3HBEWNdsnLrotBzvh2ScJFkih9+iI9PmNO8cQ1c+2IxEHsHtLoczqzoND6z53VQ4hiNoQ5DI2+AAvejCT7ITy3EY57wGrUD9aVwbBJgSmh2s5su2R+qaqhl4hSXhYxUG1XBu3b14zurk21Of5y0/pVmK+efqbtYLIpgAMQwcy01DYBYek4aSBZ1icNgUZAbuXhx6daY69DuMmCyY3+nNl28SAqENbwb0ljyEg+CaMNG9x7mRIgWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYtxCvMq/Nc+uSWmrnV7PO6gVq5S7w3SndntCRrdytw=;
 b=VsLnMAfItrfjPr7pf81nLsg0MSlLBVjZhcYeH57HOy/0V7Li32TMUtD+GuEO6fmFV7P+A0MmFlPulCt53WWlDKeeeIOw4/dkQZbMiSmB+6ex1orCXinaz/lhOFncqc2HCtIYcmigFQigrcKqkGW+TgQOSQgIH5dEnyAmQgPP8TCZk0MfLUnqFbzkWrxi4LLKazZZnat1Ickg/hz8gVYAIYvSNeHZV+o2XgLuEkQvb9ReKCMgKQQPq/tKp379BvY2uvTto3f7PllQlzh3SSGJtfLyF41dAduRlg/f4TMjCK7r1x08MXewcVZ1LX+koQZoXs1LNieM6bMwPchKRPKQxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYtxCvMq/Nc+uSWmrnV7PO6gVq5S7w3SndntCRrdytw=;
 b=SS1MECE/ga/elwdhJa5KBHQe5uemYGjVbw0Ejm3uUttWXJh+zgQoj/T7ylmoJMpv/XbCbJKmWFyRbRVUcrSaNOMMUKj0THP/1hzC5uhw4EhT7BplvGKRfNMOWhlDlTlsFPVG7ZV3yWMOFZp+9HpACCyA0dkaD6/yJngFKra4c7Q=
Received: from DB9PR04MB8412.eurprd04.prod.outlook.com (2603:10a6:10:24d::9)
 by DB6PR04MB3238.eurprd04.prod.outlook.com (2603:10a6:6:e::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.14; Fri, 17 Jun 2022 07:51:53 +0000
Received: from DB9PR04MB8412.eurprd04.prod.outlook.com
 ([fe80::9dbf:79da:79b6:97b6]) by DB9PR04MB8412.eurprd04.prod.outlook.com
 ([fe80::9dbf:79da:79b6:97b6%5]) with mapi id 15.20.5353.016; Fri, 17 Jun 2022
 07:51:53 +0000
From:   Jacky Bai <ping.bai@nxp.com>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
CC:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Anson Huang <Anson.Huang@nxp.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [RESEND PATCH v2 0/9] imx: thermal: Allow trip point
 configuration from DT
Thread-Topic: [RESEND PATCH v2 0/9] imx: thermal: Allow trip point
 configuration from DT
Thread-Index: AQHYghncxdtsw65aHEeNmV298Qzo4a1TMnpwgAAE3gCAAAE3cA==
Date:   Fri, 17 Jun 2022 07:51:53 +0000
Message-ID: <DB9PR04MB84128DBB45B29B7BD6ED001287AF9@DB9PR04MB8412.eurprd04.prod.outlook.com>
References: <20220617071411.187542-1-francesco.dolcini@toradex.com>
 <DB9PR04MB84123FC6272AF3C2DAE306D687AF9@DB9PR04MB8412.eurprd04.prod.outlook.com>
 <20220617074220.GA187629@francesco-nb.int.toradex.com>
In-Reply-To: <20220617074220.GA187629@francesco-nb.int.toradex.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9f3e912-f513-4d11-88c0-08da50363e9f
x-ms-traffictypediagnostic: DB6PR04MB3238:EE_
x-microsoft-antispam-prvs: <DB6PR04MB3238E729F4156F9AD090912487AF9@DB6PR04MB3238.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LYTeaEbZWFs6LrbXI2Z4bW4inr0ViOUOvPmxEvhEMZjMSwf6+6V33tIniArANnatpl7wvT+jV/LxdJ/hgyR/BLDw7KWZMgycxiFnsfsfgWPle7lRBHVhFHeY6lgE4DrVCN3q3tuWaKFmIWoioegSzL9eNy2Hl6L7pxpZXXguKwLZTdKz0cHK52d14b3J0D8VwxRktTPNg7L7Tba0vl/oHsZXXEkQobYIuU8pODruBk/XGpUzGkmMJRPKgDElRE6O2H/tblxN01q4ll0KiBLWjnxbxI457aQwR8pSEgITA0BRw0iwNvLLZNKwXXNYNuciVpip93ubKYrBtXJgHFt6AqNCSCbypmVD49OaOhRXD9cOEAC1N7PtFAZTbX6iw1pLtgVtCvl4BSUeAMGJPZ4CEtbDqgdo/QGPPYTElChXmjguKN7B487zLYrLfYT8uFVBkmwalGfv0uWBvYuyk7DiPYb12OIRh8PcpjceUr7Fi2DhbOhhPAjm6U1rihv1F3vbIRZIYH5KiClBkGR6rd2AyoqSxjQwh6q1knY8cbGYiTD3/mwEP2+FRQP/FBpnrjlIpNnTzpoObhI+H9jU5FTEySi32F+MKKq7dfiSaoTmqBJA10LHfmMOumpR+JQtxnzX503r/LdIJvMbM/HIDLjqWOXEo1cMLpyO2qNWVA9NvYMWvp4p3C9sVfB89yKMSbEKqkk83ywHlRXibJUYRJtj8Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8412.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(38100700002)(186003)(6916009)(7416002)(316002)(122000001)(4326008)(26005)(86362001)(9686003)(8676002)(5660300002)(33656002)(83380400001)(71200400001)(55016003)(66476007)(64756008)(66556008)(2906002)(66946007)(76116006)(66446008)(54906003)(508600001)(52536014)(38070700005)(8936002)(6506007)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sl6xkBjARTTWnuD2lf8FxvUFkkTeO/lPmUhywwFgu6/U+QQF9TL83ctQq8QW?=
 =?us-ascii?Q?NmYnSphEvRT4xPZOoFzjGffbGTFeS5ZJHIixXn89pyIu0IZj2FQ39rPA0ggo?=
 =?us-ascii?Q?E2RxvNvmm2h12cZ1L0aQxauZAdVgU5S9ecG0o0Vl9cRsUmPhusHgZuZOjGQO?=
 =?us-ascii?Q?tX5Xus2t4b1NwM8amE43+lH52bHE3hlJwe9Kh1eQarakrVm8wexwqKF00IhX?=
 =?us-ascii?Q?lj/cSoqW48bbcmSQk7MWb3j2qW/Y0bNu2E4BGkkN6cwch3sjSvGKLMF2PfZc?=
 =?us-ascii?Q?CEjS0J7I6epTg0ePeyNWPGDICz1jQfU1jV8TvhB8oyHpqLBl8TzBReWv//Hq?=
 =?us-ascii?Q?UKOMrTxLKcvuUoGSDCnvaX8BUiHXhd7AEc/KQoOYA65CvibDArrtHfU27xl3?=
 =?us-ascii?Q?5dMGGhxO44gl/J9TbnOeADpSUb/7v2/piSwgCI0k1hxx8p+11WbqAHkp9v6l?=
 =?us-ascii?Q?b76C4HJeHxI3j8mihF73SKAnfcPzytbeYkZ6c7S9ppceMWB5/P8Uilk5kJ6U?=
 =?us-ascii?Q?wrvDv7Islr4PBjqVcJB7hk6wetEigqCJGyJHAu28sFPf3de+yL9tgr3le+yI?=
 =?us-ascii?Q?zlMvgGvLZ6SYqcePgiCHr5BYPBnjN0wx/GIzaNXvb8/47kmN9Xql0iAL6nIO?=
 =?us-ascii?Q?pvdL/I+HsNugC/RIJl+4EDf+Q8IqZBUwtw8/nKW4zHU3aZfDyMbe2iFXGedi?=
 =?us-ascii?Q?CSBEBUiGEHgUTnV4ylWfvmaKbHL3n0wwEl01ypQunZB8+k6fb6xPDrU0R42n?=
 =?us-ascii?Q?Js/PpYMZW3ggRzEOH4Vl6Yg6aWiLsgjt2akZW07NUNOQQo6vjJJMCdB5lXdb?=
 =?us-ascii?Q?XNKxhLehr1h17oVF6Gobq5gdMMzHg/3xmxs50rY0cVuJwAkfck4ilu/4bHHw?=
 =?us-ascii?Q?rOhyb6BXHxHT1b5EJhUDiz4LwoRfcgotxmsYGpVB5XbdB5HpwOmZSvODjJdl?=
 =?us-ascii?Q?/qCVFxJOm6f/PAD8fpJaI2hVnomE6F1J9tcLt1BDmlP9uqcNuATavuhefL0m?=
 =?us-ascii?Q?eFhyqC423kLrHTfWGOR9RMJIKlh962lvMIxD5+nD5sLfNkegM4at0LShp6wv?=
 =?us-ascii?Q?GFoyIS+a+U13ljA32H80zIgN7Nt2/obt/wejQe6gXJcMvdhmjbBWQNMkiZSh?=
 =?us-ascii?Q?GUKr9bjhPD8QYrS00TKZl3eBCD7MqtEspp31L5PYjeiTjGQ9NeiOZ8oYCoJL?=
 =?us-ascii?Q?Ekp3mGzRoy7jXMZrYenJuu0q2i6MOtvEfkVW/X0MFwfHdEom0qHtXT6sQQZ4?=
 =?us-ascii?Q?Eg++jar2SQN8F/oJEgtllf6NYP44PdnyySoe4gWz7hMMKn+eH8dQCop3aEya?=
 =?us-ascii?Q?ZwZRIhxC2XVJvJYCxTzaNzbL1wXzlTLHTpmpxC7/EViprc1ZQZxS4W2T5U6b?=
 =?us-ascii?Q?uiVPymJUq8MN8xPYp5sKUmnmFuO+1i+t5ItahSpB82UR8HU1auBinZH+Mi0F?=
 =?us-ascii?Q?9IOtARVCIKcEcX6t0HJoxVBYiWzPuMOKp6oCnnQZZFqlUkpb1tZrTPiVfRS0?=
 =?us-ascii?Q?YnLcoQykWe+rt+5LVmF1RtVRidJoR43hpNq+RRtWlT06wyjX/KKJTBdW6idb?=
 =?us-ascii?Q?GU5ANjtVfvfJVx/Uq8iP9Id8q+TwmqWMaeFUL5FsaOCnrHhNf8r8LYxL1+lu?=
 =?us-ascii?Q?+Aea7DwrxrD9nE+20ffyc64iEgRO8yANExhK/ahe5Kj8TZK37RNK1i386CNv?=
 =?us-ascii?Q?/qxhPq/etqtlaCtI2qcrzdUlEApzT5dqnWO/fOtYDL+8wxGG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8412.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f3e912-f513-4d11-88c0-08da50363e9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2022 07:51:53.5289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yZ1qDpctK+RyC/dm/D8p5Gtv3Uf/dwFpQBhsAD86hCZB1CayDFIDyELs59fWLkavw+Y/TTOxX0+qgSSGKFzceQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3238
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Francesco,

> Subject: Re: [RESEND PATCH v2 0/9] imx: thermal: Allow trip point
> configuration from DT
>=20
> Hello Jacky,
>=20
> On Fri, Jun 17, 2022 at 07:31:25AM +0000, Jacky Bai wrote:
> > > Subject: [RESEND PATCH v2 0/9] imx: thermal: Allow trip point
> > > configuration from DT
> > >
> > > This series allows to specify the imx thermal drivers trip point
> > > from the device tree, without this change the threshold are
> > > hard-coded and this might not be correct given the thermal design of =
the
> final system.
> > >
> >
> > The threshold is set dynamically based on the part market temp grade.
> > I am little confused why need to specify it in DT?  I saw in 'PATCH
> > 5/9', you provide a threshold table based temp grade, why not use the
> > threshold from ' imx_init_temp_grade'?
>=20
> The problem with the existing temperature thresholds is that they are
> hard-coded into the driver, there is no way to change those to match the
> actual final system thermal design.
>=20
> After various discussions [1][2] with Marco, Daniel and Lucas it was agre=
ed
> that the actual trip is indeed a system property and therefore should be
> described in the device tree. This series make it possible in a backward
> compatible way, this new possibility is than used to override the thresho=
ld in
> some system-specific dts (see patches 6,7,8 and 9).
>=20

Thx. Yes, in current driver design, the critical trip is fixed at 5 Celsius=
 lower than the MAX limited.
So the purpose of this patch is just want to override this limitation to ad=
just it based on system need?

BR
Jacky Bai
> Francesco
>=20

