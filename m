Return-Path: <linux-pm+bounces-23748-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A56C3A590E7
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 11:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61A6A3A3DFD
	for <lists+linux-pm@lfdr.de>; Mon, 10 Mar 2025 10:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA4122577E;
	Mon, 10 Mar 2025 10:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="JaoHvx5Q"
X-Original-To: linux-pm@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010066.outbound.protection.outlook.com [52.101.229.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0246D21D3E3;
	Mon, 10 Mar 2025 10:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741601869; cv=fail; b=apTbEip12fWo2rCkAIlgo+KY70uvBRDGl9tHt8WLZcl8kb7D1JPUl0CsagScj1uYOCHAP8lbKd3YKosp4jJf1SksSDKPTedSB+M64Ll3/LScnwX1Kvqf8bbaHhfsE7TF5V5tcEfcfcdLyCMxQhTcGC1cMdxdkEAtosl+62g27UQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741601869; c=relaxed/simple;
	bh=cZ7UP3Dt3CmRfHakJ6pfZ2RCVbitG6BxFl63E8mEjxo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BGAQb/5lngzv3JKr147nAWCc/yBC+m4vsSTf+a0bVrGA12fDbqtDj+nxIyAl0taLLDYjTJaoMUtJzQgRAhU1RoHo3SNSjeiXfOsDk8sRfxYlMTrtuaREBwYb0aJUhiE1fuADd+gbzJScMY+8DAmsroyEUJQNtIcN4rxN+B18QUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=JaoHvx5Q; arc=fail smtp.client-ip=52.101.229.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0ZOQYPT8NbMTykw2x76dtRl52j3CZnCJLZzhj/Ht+iCEfisKDnIowC2tdiF41kjvqpryawpM1aX0COE01wgDElHb7SLX7+OicpX3h4KMX37ZXNgOt4vZQmaehuSptbLESr2y2Gl/rDcbV0XyEz14/15rhGUPrLTPufQ5arODOYg3qrDIMwT7UM+MZv/7JXoOIJCig3puWMxgvkWsGaZND7lRyOF8Cz6IUe4ISDLrOI6cuOR3U5iat326588QerYBfyo9e69E6HZKzVN/454G4p83TN7jD370ybFW2FqU6v/97aphSnYaZ/Slv3PHdDfxH5gY8PCBKvLvtYXxvSJIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pe11PJWRI3QczKocTSH85ff1Kd9wNMpupi5oF3HHJIw=;
 b=oNXXVeTlr2swG8kG6/2J/8pAW0xdiqUg8w5OWPTjC/2bIJ9fH6OIUH6amG8wdyNNJkPj/zqmBlA2T2ayNahBHgPb/m2ZFOxTt3tKeBztKmnXdcWw7dSGiNRf1WPquvRX73Ut4SyU0Cg/Dq/CZkTvjlMETTFBa5ioN64jS7vXdkaLs1NZGfec7p+XdIry7LWM9AoVI2MaGvxwjacQl+N+ZbIme0aJTTBoAeOgHfF1mFvQzRJF7+lB+HFEvPnTQaOp3/T3cpkIHsNrNepn2QW53sklScAH8GbbqtkwAtWH2F9qkN6XdJbgit7/tx2v3kHgT4ctQlgEOE836aONiT9SyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pe11PJWRI3QczKocTSH85ff1Kd9wNMpupi5oF3HHJIw=;
 b=JaoHvx5QOgRG2gyE6587EG2TltXr3YQdseKSPjCqsKmOL0jqQORQoMH/UFYh5u26DIvBpRm4HK/Iuya8X2TFCdnl80CTTBfUqs7ybTsidJDfFEO7MT1Bl7TKQoI455ojcu883r/7ra7s99UaDm7MPizcmD+wR+Dw2rKVs9OVChM=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYCPR01MB9847.jpnprd01.prod.outlook.com (2603:1096:400:20e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 10:17:42 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 10:17:42 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: John Madieu <john.madieu.xa@bp.renesas.com>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, "niklas.soderlund+renesas@ragnatech.se"
	<niklas.soderlund+renesas@ragnatech.se>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "rafael@kernel.org" <rafael@kernel.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC: "magnus.damm@gmail.com" <magnus.damm@gmail.com>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "john.madieu@gmail.com"
	<john.madieu@gmail.com>, "rui.zhang@intel.com" <rui.zhang@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, John Madieu
	<john.madieu.xa@bp.renesas.com>
Subject: RE: [RFC PATCH 0/3] thermal: Add CPU hotplug cooling driver
Thread-Topic: [RFC PATCH 0/3] thermal: Add CPU hotplug cooling driver
Thread-Index: AQHbkOyvCCVC9dX0IkqQUouVN8+nJbNsKMYg
Date: Mon, 10 Mar 2025 10:17:42 +0000
Message-ID:
 <TY3PR01MB1134648D962B26E94C4BA0D1C86D62@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250309121324.29633-1-john.madieu.xa@bp.renesas.com>
In-Reply-To: <20250309121324.29633-1-john.madieu.xa@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYCPR01MB9847:EE_
x-ms-office365-filtering-correlation-id: 1d1235ae-1af0-48f2-3028-08dd5fbccb4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?AUV0DHNavEvMC/Ike4XUe0UwjeEH4oyG/JtbF26K8URl2UNy/pGkZcrlqqzm?=
 =?us-ascii?Q?ZTydUUyKnXwfRIc0FqYLFpseBrDs8j0OcGM3PmbruufHzSdYxmG2A6N0c1bO?=
 =?us-ascii?Q?S8tIT1UHPcQuKOL5etOid8YcA9hka3AXIZevYB1Zm5maOmJBr5HtiGEeJY2q?=
 =?us-ascii?Q?uUczpBKlmsgH3xo3rEs9CHla76AivS2MuibDHN8WBgCDgRO0X+qJR4OmgYZ5?=
 =?us-ascii?Q?PzRnG4qPVpy1HQhOQZzv5vk8NUu7mKW74d4mOJPOMwR0EuVh/chlwNMw0ft7?=
 =?us-ascii?Q?eASL+Ji/COZBnsqu5ruXeO53vMksvDsfKRYtUIjxKlIrafAq5slx2Y4b5o0K?=
 =?us-ascii?Q?rSqK0SXJx9/PiYIbSc/zoJ6/fmKuazajLM3fawI6cvFXU4eVq5/ykVz24l5p?=
 =?us-ascii?Q?xEM5BeS3UNnqLwA4bUacoOzUv9OMT4xcpF9hq1DjMlcEfKDUp9qnXqUDkD/B?=
 =?us-ascii?Q?oZ7BbeDNIhAMm/gTDrgz+Gwlktay9QNaZfTFF3MFIjIPac71c6htMs6JMDwj?=
 =?us-ascii?Q?PjZHygoQcJc93Ing8QJIP4gVMhne9LmXiMgY4YJBaUsTC5uePYUgKC0RVgj2?=
 =?us-ascii?Q?Ah4S3b4rn1arXgPrvE1HRXSJTiIXBNFp8vOrXH5H5wxtgfybf/VCLT/GsEbu?=
 =?us-ascii?Q?b83ao58X0fYIMsED4YhnelWq0QSKd65rWAbfKQyNNAVcfPxXexmChfHGndEb?=
 =?us-ascii?Q?Thx+mi7UNLtkg6CQvhtsG6Ltzq8nKmScSo0DTb/xdYD3G1p+ocw5fEzqRVpJ?=
 =?us-ascii?Q?pTt6r6zrh7GIiYknLj5tYYVCGaoqwjlbnfUXlVuKfxJDfMkpd80SYY4Nw1Uu?=
 =?us-ascii?Q?4R++eHQ/8X3XPwPVvrR91waZbx7wPGzgTaZuQa9kkT3+BjwPjdW7u6C7xLHg?=
 =?us-ascii?Q?aVTGbx+tCOYNRo7WHGFbalVwmqz3gygoJ2RvenUUV6xOOKgmuoursSyQVFne?=
 =?us-ascii?Q?svuLuoGDj8lrXoPBVuSp4/C+0ARd8Okydgt0jtu7bqD53+gISAix6DlWlvdj?=
 =?us-ascii?Q?hSG3CU15/z9AQFzpYJB7ZWeCG2VwhRAEiSvlKNNhcOb/NNL6nqgYcHMY7tqD?=
 =?us-ascii?Q?Pf33W/J4hsYB2OuOOP8bnkdy+PjZli6G6qJsK7VLbFzwuGtJcos40altSTIX?=
 =?us-ascii?Q?juOtD4LpNJ4yFnMwOxykb8bbeunzPrexVgaXMmEVAVDhhZBq3yCWjJr3SIFZ?=
 =?us-ascii?Q?kT8mAiaHxznsHx78/NXsaUlq9ClyEML1h/clY0khiDbzPOJ6GI6DdxMw/Jvp?=
 =?us-ascii?Q?/kOomJq7vXsR35bmPfXtF7XGrAcpl4529nNz9XtERU99+N5GHcr1/P4e7yI/?=
 =?us-ascii?Q?7lUDX76Sm7MV05C6mDdbWTE7vpngIqz4Ow9b4VngOMCTp5qRNeFJlo7dj1JH?=
 =?us-ascii?Q?frtDY2Y+UApvncuWSeeEtpm0pLsyHcILJm6+0GTqs3A5Pnh6jKi31zgyMUhi?=
 =?us-ascii?Q?+x5K8z1uXYI287aOXYvZ50OYqruC9Sdq?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?c2LfS4/gdRKNXX8EKQjBAwGFtXQkfjG+CH++Sh4uLBGvXwzu/7fZI3FQbuCO?=
 =?us-ascii?Q?zmyw+aAN17GxOgY0oHcA+Tp2F2o5qk6MWb+AO3vdTItyACw6lHDOs7bhps7x?=
 =?us-ascii?Q?1FwHnztWuKUG0gXTZKSJtHjETAlkwnKOT+nzy+0dOdKks02Rkl4OXB5egynB?=
 =?us-ascii?Q?ABzJ0OfFKumaZaTE5hOK1EqMMTFksxSxL7azjBsqLygbqbU7xRy8p0UQy343?=
 =?us-ascii?Q?WFEBk5jc77AvCriVMIW9RTJ2RVhYaqAKjJOw0L0JSY7NFS2tlO9w3ZZH/HM4?=
 =?us-ascii?Q?LSDA7GUV3cLiRMKyCYsa9517oUvMYtEZd0M4i0ny+Wrj73eIWdU0Du1Gu+rf?=
 =?us-ascii?Q?ifrPmtRT+TwNPrPdaYxsk6oY4bOlRmOQsv/ftzqEHqSOuJtlbBfIOFAHD9Bg?=
 =?us-ascii?Q?WsLuGsO0O0GXhSRX9skxEvVllq6+EQ4Upx4h83bo0MKW5XeOmNYKzsr1gQ7H?=
 =?us-ascii?Q?8ydlJF2jJjGuoZ28m/kJa7a9kHfcoKt9K/sUAMYgYlNpcWHcD1OYiquUslwb?=
 =?us-ascii?Q?zzwV5+HBeqkaK9DyC5SBg/UnSqwUIZVMFhlLNrS9KgX03xay5EtUbTD8x2Es?=
 =?us-ascii?Q?Tspmo/GFsgxWBNYqeoMOpsueFD3GLp7LOCOCrW0FdEF0mjE39aczR8/saoEv?=
 =?us-ascii?Q?WKnV9khcyFxJV5SEhHEjLAq2INd8yKIdfM9BXLIDTUC3quLXnOOlQZKWMzUZ?=
 =?us-ascii?Q?Otgs61G3Gl8upc4hqSmj3jphuBoT8/O/QrDP2h8j3MeIhPPYoq3pvTz/64vG?=
 =?us-ascii?Q?mjHasfKEux/gfVNvz/v8011Fi5/pqkXzlG92gH5nqBM+4cu0jwnGZGUD0YiN?=
 =?us-ascii?Q?Zuosx0+0iqjwuIblsqMv91RD8R9/uDc1TSp5GQUChyLgbc9789Yzse7aaK1/?=
 =?us-ascii?Q?x5rAaZNzpgVazbEQKGg+ZQRM7InCn8bzNUqMp1pcYrxXwhEnvsilRrChfKiL?=
 =?us-ascii?Q?cIz9yiwTUCsQ51E3rGi5dP1TmiUvPMJTKpk6ujUNkuXIiczXRclK0UNrm/w1?=
 =?us-ascii?Q?7RjCiFkjkCZuF2QfwREax/QYUx7VtxgiJRZ2TmVdySGAHfwTx4Hpr4gV2hZg?=
 =?us-ascii?Q?YtccCuY7xPhwP2Y8QEGxpiWM8xiz+CE4TlK741sUx5Rwc5S4j2kSAcnfqeLq?=
 =?us-ascii?Q?GTZFFUIUEZqHVnBaHwRmr42iv+faB2I8AIcHwQzIiT/q4YOXi06mMZVMoniB?=
 =?us-ascii?Q?LK6OWz7A4cW6dx6haXzFCBwWTgG25Ucc7pXRrpYjXVZcByJxm29/x/lohEUi?=
 =?us-ascii?Q?BGuz8b5j43LnFsHDf0GfW4GTmeWlP9YJMiK2Gl0SDOoZe0oBXtoNVLHo1/9K?=
 =?us-ascii?Q?YWKN1Efr8+KenxC00SpHrJPbH4bcSlZULYfZqSPxyY2CnQHjX7SVHpywfmtz?=
 =?us-ascii?Q?zVeohR6oWnElwn+VQ/ZIbJNU3JQSozU53l6jq3Wtf+gY/9Top2ZrMpAtkNLo?=
 =?us-ascii?Q?lrBRKEb7jYK+IlABo3vOBJ0Q6rhV3AWaCei1mi3Ai5yoZ0xYw4Vfc8PfjCAf?=
 =?us-ascii?Q?cWyqs0Gp8MJTDBRruS6Di/sR6iu/a4a05a1rnLLYwMpuAsnVYJW2aK6bDVsU?=
 =?us-ascii?Q?OZX9QLYDWMWfsDw/BaWsSEYoP+iw4oLGcGVwu6hfEOA3dQXEApLl4VQSEbGV?=
 =?us-ascii?Q?Fg=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d1235ae-1af0-48f2-3028-08dd5fbccb4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 10:17:42.5339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AG/gDg40d7rw8CWoQvGYIWCGrU7OhVw7vInO8F+tNBfCzIgQOlOdcrdxMzs4xo51R+vx6chRnxVulFnrYw1HWwpjkMy5IBGriIpN6vbQexw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9847

Hi John,

Thanks for the patch.

> -----Original Message-----
> From: John Madieu <john.madieu.xa@bp.renesas.com>
> Sent: 09 March 2025 12:13
> Subject: [RFC PATCH 0/3] thermal: Add CPU hotplug cooling driver
>=20
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>=20
> This patch series introduces a new thermal cooling driver that implements=
 CPU hotplug-based thermal
> management. The driver dynamically takes CPUs offline during thermal excu=
rsions to reduce power
> consumption and prevent overheating, while maintaining system stability b=
y keeping at least one CPU
> online.
>=20
> 1- Problem Statement
>=20
> Modern SoCs require robust thermal management to prevent overheating unde=
r heavy workloads. Existing
> cooling mechanisms like frequency scaling may not always provide sufficie=
nt thermal relief, especially
> in multi-core systems where per-core thermal contributions can be signifi=
cant.
>=20
> 2- Solution Overview
>=20
> The driver:
>=20
>  - Integrates with the Linux thermal framework as a cooling device
>  - Registers per-CPU cooling devices that respond to thermal trip points
>  - Uses CPU hotplug operations to reduce thermal load
>  - Maintains system stability by preserving the boot CPU from being put o=
ffline,  regardless the CPUs
> that are specified in cooling device list.
>  - Implements proper state tracking and cleanup
>=20
> Key Features:
>=20
>  - Dynamic CPU online/offline management based on thermal thresholds
>  - Device tree-based configuration via thermal zones and trip points
>  - Hysteresis support through thermal governor interactions
>  - Safe handling of CPU state transitions during module load/unload
>  - Compatibility with existing thermal management frameworks
>=20
> Testing
>=20
>  - Verified on Renesas RZ/G3E platforms with multi-core CPU configuration=
s
>  - Validated thermal response using artificial load generation (emul_temp=
)
>  - Confirmed proper interaction with other cooling devices
>  - Verified support for 'plug' type trace events
>  - Tested with step_wise governor
>=20
> As the 'hot' type is already used for user space notification, I've choos=
en 'plug' for this new type.
> suggestions on this are welcome. Here is an example of 'thermal-zone' tha=
t integrate 'plug' type:
>=20
> ```
> thermal-zones {
> 	cpu-thermal {
> 		polling-delay =3D <1000>;
> 		polling-delay-passive =3D <250>;
> 		thermal-sensors =3D <&tsu>;
>=20
> 		cooling-maps {
> 			map0 {
> 				trip =3D <&target>;
> 				cooling-device =3D <&cpu0 0 3>, <&cpu3 0 3>;
> 				contribution =3D <1024>;
> 			};

Is it not possible here to make cpu1 and cpu2 as well for DVFS passive cool=
ing?

>=20
> 			map1 {
> 				trip =3D <&trip_emergency>;
> 				cooling-device =3D <&cpu1 0 1>, <&cpu2 0 1>;
> 				contribution =3D <1024>;
> 			};
>=20
> 		};

Is it not possible here to make cpu3 as well as hot pluggable device for co=
oling?

Cheers,
Biju


