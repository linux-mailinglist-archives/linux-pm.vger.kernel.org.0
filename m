Return-Path: <linux-pm+bounces-760-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE2B807385
	for <lists+linux-pm@lfdr.de>; Wed,  6 Dec 2023 16:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1F5EB210DE
	for <lists+linux-pm@lfdr.de>; Wed,  6 Dec 2023 15:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AA93FE34;
	Wed,  6 Dec 2023 15:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="PlcZAJwv"
X-Original-To: linux-pm@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2122.outbound.protection.outlook.com [40.107.114.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF1910DD;
	Wed,  6 Dec 2023 07:14:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jv+9Mzre0QYXIAYXH+SGw5f4FkHRiyoleRkkCOHP5ZXJqovI404pEMy4cFEd9hGwmOBCpJ6luFf5Yn0LJZyQTU5nuCC9SMx6/krmRvla7POHl3DWW43dtGoZj7UdgzRrL7MYnBDfjHKcPoR6/5deBTorrCllyytWdjE89w7nW6VcblWdFDvLieAf0MGhzovUuNyyu2My8+oJ9y27ZoYlNJ59Ggg6ZRJBNtdNygicTT7wdYLfmNdcGOu6IxmlUFllwPrXu7P+bJS4kH7/F5kicSPx56/BrwLl7v0jJerKB6s8Y3CfF4nO9oOR9Ju24/bhmehxTq+Hw/Y5I73cjmZ2Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJGujwCLMd1wmZN8frlfG4IzxiI/FYL0L+HHnurMgzs=;
 b=VEHwhdeW69Aiz9C2gjuX2c872NthATqP/8798Vneqq5gSFZ9I0/uiGz8TIcT5VZlykpOgwiuZ/R1OmXaTFjIA6yt+NZfZd3N+0hsIDifVAB1bkeAzLhap/lM4m6FKKgixfxRt4nH6EfDadXve4eKdPJaHmyDR0s0d+U6hNkeXyLMfA9nmn5NeMOQ3HpjhNgLB8HsR+RjTmoB69wkoAQ2PSNu9/wpszdGzBqx8aAPryWW8hGbWr8QzzxROxlsv7OQtm5KOpTmB9uJuWIC8uKjE0aQsjdFLFlpilSo+GPgO9Rx/Wkff4CX/8cUk8jX9wpdhfE7D6zA0j1i4VHUawWF3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJGujwCLMd1wmZN8frlfG4IzxiI/FYL0L+HHnurMgzs=;
 b=PlcZAJwvgrzl0EEnlhHaxZg7aZ3wNfgzuUbtNuv9agOaulmmSprxGyMIxCBmjl9QCj3hkPJI7j74NDh3+8VRxhpjEXZH0YvMDiZ9b4b4a+CA5YY9/O0eGV1ESosZaTrh+fG+c9k3YGi6JdjCovO0fxOpvYPrRnRUdXE0kEpzeWM=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by TYVPR01MB11230.jpnprd01.prod.outlook.com
 (2603:1096:400:368::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 15:14:44 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::4af6:b31a:8826:51ac]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::4af6:b31a:8826:51ac%6]) with mapi id 15.20.7091.010; Wed, 6 Dec 2023
 15:14:44 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Rob Herring <robh@kernel.org>
CC: Lee Jones <lee@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Support Opensource <support.opensource@diasemi.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
	<lukasz.luba@arm.com>, Steve Twiss <stwiss.opensource@diasemi.com>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, biju.das.au
	<biju.das.au@gmail.com>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v3.1 0/8] Convert DA906{1,2} bindings to json-schema
Thread-Topic: [PATCH v3.1 0/8] Convert DA906{1,2} bindings to json-schema
Thread-Index: AQHaJtbcW/oW/Awmmkq1FFE79BsfALCcSv6AgAATSCA=
Date: Wed, 6 Dec 2023 15:14:44 +0000
Message-ID:
 <TYCPR01MB11269F5495D078FC44D2C08228684A@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20231204172510.35041-1-biju.das.jz@bp.renesas.com>
 <20231206135849.GA2051159-robh@kernel.org>
In-Reply-To: <20231206135849.GA2051159-robh@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|TYVPR01MB11230:EE_
x-ms-office365-filtering-correlation-id: 634ea50a-b53a-4582-6436-08dbf66e13ff
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 J46H1Oyg8cSOASI9Xl5k2RKPTACFYWJzYaPvgWW2NezAnWKzXQdfyl70aCI+wkiHB6E1H2P7O4ZhUw1TUM9G5NbBfxDSOM0dCkByOfzqp3JuoYEU5wMWPsay/mgTVBle4cIWDeav5pgEyE1zZOHBxfwehNBt4tRHwLAKGkmvXEb6lp0MMR2AXnAuNYyNPzupIVmZXVKNTxY4kbZNSswNfCBLvbOpRfdMFOuVAHextRZnknlNS4BsMTqGNZD7eAWtb8LhnEWFbTNoHo6MlcWUPDTTGx4jmjx1eSECOlBH9VQJYLwmJu00CAtB7+v1AsvohgZKt+hFGduDG3GLbK3/HNgwu1GD9vvLZ9k7lm6XslNqTcKtjTVYC0VZOGr3jG+UuYEMTbyeOmlDRjJXxyEzxT4Jerq8yLc4PueBdeZmwXnwdAT+qPgA4Z2o7PZmARQL06t/DW7S2jvv8CGSHI3L04GRK+B+D0olvraPJ/JEHHcsXM45t8eMFTcO5Bu4+6i2FrIGOAI4/upfpDQb+Tv3pQVj0F5sEcpVAuYQfmFcD47w7yC3hB+DWVZsgBzqpXLqY4vxPtkksUscJcjpKXDgC5ZzueO+NyTkEA+SYv4ZJ9cXXl4O17EiYmpVGM5UCPb0
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(39860400002)(376002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(26005)(7696005)(53546011)(6506007)(9686003)(83380400001)(55016003)(4326008)(8676002)(8936002)(6916009)(66946007)(76116006)(316002)(54906003)(478600001)(52536014)(86362001)(64756008)(66446008)(66476007)(66556008)(122000001)(71200400001)(38100700002)(33656002)(41300700001)(7416002)(4744005)(2906002)(5660300002)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3ffYXo4GI9snLNdSo5xo+brivtW3qa++aQRCgOS4Rlu6kohD1KFsvcprJ0Ow?=
 =?us-ascii?Q?2KrEgwXxmE/Qdvi6prJLUxhI70Nv0sMhv3YjZqGL1PsArBu2AdeAW/Gej54T?=
 =?us-ascii?Q?79OhOsg+gp5xYzLt9BA8I57KL05Dq9NFu4SEqf6ezmsAZ9IjOF0J3G7wfgmU?=
 =?us-ascii?Q?6h35u9MXaXe4Zct9Y/H2602DVd5ST8G5hTHWt8jGMEqpPYBv1wGudePdt+jL?=
 =?us-ascii?Q?gI56mIztZpuBUlx/jBPDOcrDSDaqLwhAJtWpVWyqs2LN8JRgcSAKNGgQhZIP?=
 =?us-ascii?Q?OJ4FSJv6Cb4+d1qhR3TvpZmqsOsArS7+m8x1rVwe/huq+k9wMoh5bwTl1mwa?=
 =?us-ascii?Q?rU9C3NW0YDJSro4x9FXZhwPZqf4qKrg1LFDsIwa7Gke6pzGZFT/oUtdjZUea?=
 =?us-ascii?Q?OS/Iq7nRD16YxvUCzjJqcoJ4iSdEL9Sy2R/3afAVyPQY5lKK4x9hvcv7hs9/?=
 =?us-ascii?Q?UftWLZze2wzgQXkAJH1+1EuKg1ITjzCCqN4Oh3E4PCpLFeQF2ZMRxv8F3sNI?=
 =?us-ascii?Q?GKL7ZdvmxuSHlAHE4xfb3upSsNawZ8OAJbHnvnIP71/HcoR9BPs8A9skUlSf?=
 =?us-ascii?Q?cw9X118MEbvZxuhI+JZfFLWZ+2oZVyCMbhv755gm2taX8FWn/GYfyqUBjWkU?=
 =?us-ascii?Q?S2wlaOSqflcSqfwURAqPbjfZ3OneshStQTGj2bhEpAFB/lrmPFZbVIcdz7v2?=
 =?us-ascii?Q?iUrvzQRi3R9O0bCSj8EK5f1HtLJclxi0XC5Aw9isr8wH9yXQzwq+lga9ZYDR?=
 =?us-ascii?Q?BLtnX/7OiLKkqO5ft7AmFugaC8xUDqRe+Cq/UXw7gQWS5pHIE0Q3x0J7Iiwh?=
 =?us-ascii?Q?qd8hVox4Y3TFt3TVoPglqrkScBCxxbVbpIBR4IirL0C3akdZtqwDR3cXjfQq?=
 =?us-ascii?Q?zR/0t2a/MCtRrg7Q86ZJN0jBvB0Z6ftrhzvILmMKSdJzHY8GNvgGQpJIw+hd?=
 =?us-ascii?Q?npD1vCKJ4Ff2kzTWRshlz1z2NE8GxCcz/eZZSrsH3UqrIYg6Ujosj7kef5jg?=
 =?us-ascii?Q?w+GpToA9M+kPSUdsG4akYQZIzrFJTxVPpHZvNivxgMoZ37zs9nJfNQJ/fUOF?=
 =?us-ascii?Q?cUUInQNGlYCHPRSbZR17NaJfEIt2fKKbHF/83K9opmLEbinX8xYUibx53Y86?=
 =?us-ascii?Q?ScaRnXEz4eiSUXtoMXIdzNWVS4Hc0D/GNRptenfpjO8tuaWn8NyZUvo2ZqV8?=
 =?us-ascii?Q?BK7+1JmJAegDTHsLe78Nea1gbZmPs2N1j9XyPfKPchtcKiBOhVVh2o8G6fLQ?=
 =?us-ascii?Q?EOHqOlSV/kS95bwmPrkAxEcf2ztlKF8vuwC5EpMMQP+XW4GFBH+GlZx7NhSS?=
 =?us-ascii?Q?6np9dxcamGdGqok4T/t4TNTEL5vJDBCA8UwFJrrmKtCtUYcYo2J7nU6ybpTn?=
 =?us-ascii?Q?CZYO6Dv15uLt0E9hlCFLV/CkAmLIj8U+uftiCq3VITYSqrLcBGHWzv7XBvyp?=
 =?us-ascii?Q?K78fCtaHRdDO3/Ffz6g9WsNWbnGrQbPeZgJHr8gEF9rLlYXWgXwle+QEPJgT?=
 =?us-ascii?Q?+YCxHWob6VxRXMkZz2Kr4oglEISm6zPpLNAgTUQRnlp79JVtitxLeaeLjwY3?=
 =?us-ascii?Q?3Lq/cdV2ceTcU8WgGdQdLBlPkabY4kFhy/lRAKyywl1opucYVzGST5wcHUwd?=
 =?us-ascii?Q?NQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11269.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 634ea50a-b53a-4582-6436-08dbf66e13ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2023 15:14:44.5147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +M+zoXh0imUEvIP05J04jOSVQyZBp22LoiwZDgh3Npli9T3MBJA64FGLPGXvIIYt7Vhap+pg/eFeur2YrgqoD3LF4KuS13DZNGb+zczUUNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11230

Hi Rob Herring,

thanks for the feedback.

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Wednesday, December 6, 2023 1:59 PM
> Subject: Re: [PATCH v3.1 0/8] Convert DA906{1,2} bindings to json-schema
>=20
> On Mon, Dec 04, 2023 at 05:25:02PM +0000, Biju Das wrote:
> > Convert the below bindings to json-schema
> > 1) DA906{1,2} mfd bindings
> > 2) DA906{1,2,3} onkey bindings
> > 3) DA906{1,2,3} thermal bindings
> >
> > Also add fallback for DA9061 watchdog device and document
> > DA9063 watchdog device.
> >
> > v3->v3.1:
>=20
> No, it's v4. The various tools (PW, b4) don't understand point versions.

It is a mistake from my side.

I will send same patch series as v4?

So that one can, compare the current patch series(v4) against v2 and v3.

Cheers,
Biju

