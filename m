Return-Path: <linux-pm+bounces-18737-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4489E8041
	for <lists+linux-pm@lfdr.de>; Sat,  7 Dec 2024 15:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA1B22820C7
	for <lists+linux-pm@lfdr.de>; Sat,  7 Dec 2024 14:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EE214830A;
	Sat,  7 Dec 2024 14:27:20 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazon11020075.outbound.protection.outlook.com [52.101.227.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C531DFE1;
	Sat,  7 Dec 2024 14:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.227.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733581640; cv=fail; b=s9pGYd3hMndC5DI0zfGx13UxAmVvBb28quOxrYaihmwUbF1k3WUMSnby3vvscUULay80rsf6rV/cPVJyPb5scHvVVyjWnd8NV9oR/3mGcYRx9kMLeHD/TPiLFXxjFEFlAjld5sSNkHZVDbwhIBUeLXuaGBe+vzP8et8MrCgaXFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733581640; c=relaxed/simple;
	bh=z7cSk8IIRqtv5R59zFb7jSbULj58OfdgEEnWZb90ed0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rk12SzaxOh7RU1RB7JlE0l9qoaDxjaddhKuFQZO7D88+F+p5PkBJohmv6TdT/NuowWWHL1cw29eLRy4NoaY5RFop0sA+rxNY9Bhh/x3XuPgw94nIXn/ZI/knUF4urE+o4U3QpOI4mcOb9u8VGlGxiXlUwduVurSTVdfDwO7IHFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=52.101.227.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJI0UjIl/2e3derhXMRV2o+YjtPA+WxWQ45qLJxf8tjsrx6KaVviy4vV57lOLFD+H9uyQsWQ/MvqbM2lUxtBpjBeRMxwd3lVOK9n29qJ/VyM4DO/PzRRA2vcZAPwrtZt79Ko/mbnYlYVxkI9r5RZY0lUbxEM7B4WOoV+kQz+18wN1iB3jPZ1WFBUHDBmltX5FlutrI5ZeUJG6ZpJkCux8WNWg59cojxCVwnFIz/QICd0kmpQb6Em/EtfxCZtHU+21JcZBSx27njT0K3OhP3IiOTrYnAbVaSEpTZRJen6Q3Qo53fIJl8W/AOXiDXwZIw55hGOvhJIhwSNQ0jIFLjdmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIjwFCI4ZuBOXEucrAaH0znW3LrpFDb3oaZUiRiQEjQ=;
 b=DIj9e+HuB5GXP6rSZcxk3QhKpGxz/ESmjxJO5lX6WpgyjKnZBHS68/Y+rddP/FVEOph39NmBfWjTKQ+7WKm+dS4OdZRPwZNeHt7x5kRXC1nxzpdrXu5Ah8gQ9jY/oW2K5O9P+c/ChOyUwoGJiWDewWjhkFET9dz0LSg1yofu1F+x+Bc5W+gbzcGfgpN06sZaFNMKkC47Am9HMyXR736wbojmBVy/oN9Fc41Jh1K6CnE7DmI/1UadXwBpCKdN9Wb6R7q98pU/iqISlQxgB5lhi4KkaCsmMthy1d5Wy0g7qFDdoSkPyKI6HCtHTNvKDE2DBSIl+dYzwlm2Z74OcvjNNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM (2603:1096:c04:1::15d)
 by PN3P287MB1032.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:17c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Sat, 7 Dec
 2024 14:27:13 +0000
Received: from PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 ([fe80::740f:ab98:2be1:538]) by PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 ([fe80::740f:ab98:2be1:538%4]) with mapi id 15.20.8230.010; Sat, 7 Dec 2024
 14:27:12 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
CC: "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 2/2] power: supply: Add STC3117 fuel gauge unit driver
Thread-Topic: [PATCH v7 2/2] power: supply: Add STC3117 fuel gauge unit driver
Thread-Index: AQHbRJ6/jwy1FDqx5067UiykHyVizbLZKtGAgAGzE0c=
Date: Sat, 7 Dec 2024 14:27:12 +0000
Message-ID:
 <PN2PPFF679F9759E522908216724F696B21F2322@PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM>
References: <20241202094328.14395-1-bhavin.sharma@siliconsignals.io>
 <20241202094328.14395-3-bhavin.sharma@siliconsignals.io>
 <6ccn5xnsfwxeepsft7tfozbhsvs3w3m2qpmcj74xua74qzkny3@s5rg3ytmcgzn>
In-Reply-To: <6ccn5xnsfwxeepsft7tfozbhsvs3w3m2qpmcj74xua74qzkny3@s5rg3ytmcgzn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN2PPFF679F9759:EE_|PN3P287MB1032:EE_
x-ms-office365-filtering-correlation-id: aa4376e9-9ff3-4863-92c0-08dd16cb3ddb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?bJxoMcPHQuIRQ/8MrMt1xcIWfU1rsm9t5A3/ykvcQahZGRUDCoA9TF1+Ja?=
 =?iso-8859-1?Q?vqtC44imPzgEZXDuwyqv8/KtNRjVhtMKeYvNtWciYo7L+VJKleeGQCSeAP?=
 =?iso-8859-1?Q?XyRgR4oVakjFkKPD3/Rvh2ds/5htq7thoKzw/qnnkeed8oAnviuT7IXD6m?=
 =?iso-8859-1?Q?RuRlCooXYNADiDuUMfiBYK5o9EWBEzjUeLzndhytNwfTFhyrTF2LjwqrJI?=
 =?iso-8859-1?Q?ZGC+ZCDVlei+Z/ybHpXPXxoJzEv8zAeKzfwj1V5J/Q32sYhLYRYBESxIJl?=
 =?iso-8859-1?Q?QwMYRhPJpi+JINSclt4w0wcRxla1j5i9Q/QH5EmRZFRit2VWhIqqyKokKr?=
 =?iso-8859-1?Q?1xUpPoiELQdqNKiT4gJGeXCPB8nYaUBtWjhVdXFPEOuP3i8zxL57sw06Iv?=
 =?iso-8859-1?Q?r07jcHF8DZ9VmzLUA2cX/G0HRASYjw2DS8+6J6mCI4x13ML1xplSYMaGqs?=
 =?iso-8859-1?Q?owfuVDUb40D2gW218aZcZQCZhq9RV/GmKfoqdKPeG/xG8QrqbAWBYoUKGb?=
 =?iso-8859-1?Q?I8bTzAu1A6ATn58BNX0Bdu99pFf5LBc7IpP0e1O9W2kwQDbLRwnNhdGMyX?=
 =?iso-8859-1?Q?b3cPhSkNQtEAp7jxcyosx3BCD8fw15em12wq3Ay8dkpuK7G97hje4vkKY4?=
 =?iso-8859-1?Q?PXjVILaw9shafOicVYu0xyupIQpWe3xXOc1F5+dGQlJ4WeqtqDOuZrE7NN?=
 =?iso-8859-1?Q?tHhHabeBmBijbQqMnbRZTp4hJmfRMuYHtysESc/jZnMpb5v654JpMgG64g?=
 =?iso-8859-1?Q?r6Iz68UbU6/r5S3FneEnFoPhmsrYb+7l+BjZFkG+L5ky7i+lQcjIh5yo35?=
 =?iso-8859-1?Q?LTpM1bZY5R+PUYxIMYXZJaDYGKST9dasm7RQgsTDQ25itz/S64+ZLj+O19?=
 =?iso-8859-1?Q?MFHlwLwRdueVq0JqeLD3UocLgumHyyeBOczh8I7TENjQUjINuita1MMWXj?=
 =?iso-8859-1?Q?L58pxGOXmDlAkml76OsIpfmMqUVM6qUGQ+hNRYRKwXqZRytkDNvmIfUzZY?=
 =?iso-8859-1?Q?FpvtyQialcYFPs7fGUqhYw4EXqBZ6Laems2n2HGq6yCUCIO3IxXqggBQhl?=
 =?iso-8859-1?Q?+7KMUY3cBM8wgGCBiDQF4UfCNPDPBN46rpJMpkAYHHdDio31Rg1jRalnpI?=
 =?iso-8859-1?Q?zx3A81exvUWkqU/hSDJ/AeKWd5z+I8wmXhlKAlyenJhKc6GjTL6/NvFthK?=
 =?iso-8859-1?Q?nSpnq97TsAL6zrvRWwW61qvmaCdym5BQ3HoZWbo0agy1SkyYoGLAjgQUFi?=
 =?iso-8859-1?Q?/d0LiIano0tKMWl7/4dYDi+1pZd79hL3fFHJTcjo8j0cCQ6ZLmr9UbR4oy?=
 =?iso-8859-1?Q?5M93OJ7zSAHbCuA6VkPS4XeDANLCfFmdxfiLUHuPgCdbTKM4LAYhUx7ap2?=
 =?iso-8859-1?Q?TOkNxFDlgt09RFj1+MeG9Ki51gLsZCm+mX/2J+szXslnN8ODck8JErQGPE?=
 =?iso-8859-1?Q?RTnMumCZ8Au8SewWyGPOfdV3r+t32tY0cM9LSQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?8VHRp2BRDVQSd22k5EdV6LnSLGAoNjtCOtyHMmunaSwmPTj9PHwKtsnCCN?=
 =?iso-8859-1?Q?ogYr7i+qR689Pxew1dhi0MqFfVhvpd5miSKcdU5mfZC1iGUGHjfdpk5Oqi?=
 =?iso-8859-1?Q?MygQ+frunPlLd70nokaipqw12rqcbYvU4LyLSjuf92m70argiirTmclMNU?=
 =?iso-8859-1?Q?BYUhUmtCyHuGFwJ8u41riYlOz7zqcdYJE2JhLvsdVxFjvBIs8KFDTnoMwq?=
 =?iso-8859-1?Q?dtmCwbpZ9as+Fzr4oIA92YRpwabJr+omvzC5gEf7FGMJXTBVoNLLyr+0ce?=
 =?iso-8859-1?Q?QbdX2BCrvkEWz9b+4/hbqAGJvKgX8xbt9hO17FESHL3BeAA5Yh5a0rnAzl?=
 =?iso-8859-1?Q?4BgNsHu/DoXT55OvFeNV/V3EqfHAYB3bafOyN+aTYrYQ/8TXWfYfjLqGSG?=
 =?iso-8859-1?Q?lRlIJvavq71zZoEBEP2AdzQICHGR3RAG/wbgnZBAlFeNIyDS5+qlmZ+loF?=
 =?iso-8859-1?Q?0wRl1W7+jFtfnDrYKQCkZV+BiPIdxkKQh6/MsRUIBAYN9LtbxB0HKzAJ3b?=
 =?iso-8859-1?Q?7kfk4DuD3Id57a5njv4DGvZj7wzrMV1bIrw6k79x4o0q4ZYzE0ZKRTHss2?=
 =?iso-8859-1?Q?nbJrTBpS7kjWIm2ZQFOoFNUAOjcwTXppK8T09WfeFomhJg8kfShOA+WMiB?=
 =?iso-8859-1?Q?9g6YDj8av94I/x4fP1u5UKYpqNrG/KZ3J5jlwBWoC1ppwvPVtRYOyeEaRv?=
 =?iso-8859-1?Q?EhEdOK3fEQiavVCJIC68hwOgUjL/R04LMwXon+HiKvyJi5os8QxFJVRoRS?=
 =?iso-8859-1?Q?rkvJXXcsbUoIfBU1HmiIexyorBPFaCMpCAuHuPG9zzQmUC0fY96QFqbhxG?=
 =?iso-8859-1?Q?ubWZt3wBgROsx3aL0XKoHGXX94i5OTAAAQKT83q/Mpr/1PRmGDGn5rFoxt?=
 =?iso-8859-1?Q?WQCNGR0aN0QOU1yz9BuEm6yCu82Lg++QfqcbejQLdLX8flShzgGNTovgus?=
 =?iso-8859-1?Q?Tllu8AeNjbe5qFJlVjAyQU8ECd58Hg3lOyYnVT/5Ru8vUHrVzzTjgSaOuH?=
 =?iso-8859-1?Q?kHS78Ymi51KuH4tWKVYxteD96PjRZZuFO5WjLkC3sKbbhIj80VXW5h4nZI?=
 =?iso-8859-1?Q?uT5EkOj22m73hRV8bpmO9LdCQNrB5AtQtmjP5Fko8Ox/e5S7KatK5apT3Q?=
 =?iso-8859-1?Q?bXhO5/QuCZ/cc/GgZ74kuxZ6rZRWRenqXnTooiE0EITBcPYDOnCqaA/ZIi?=
 =?iso-8859-1?Q?qrPela0etLxk3O1nblU3T17Z7UKikNPJQ46Baud/Pur8Gy2V8K64TtJPBC?=
 =?iso-8859-1?Q?Q0bfBdnf1q/IlBghEZcwGZLX9E4WpbmjUXiVaq4c9MISfMRftVdCDp79M7?=
 =?iso-8859-1?Q?r7fv3Ik1gRDuiI94j03J8I4mdhiiwkxx/9VMnpLSKi+J4rTS4Jmfz6BeZ7?=
 =?iso-8859-1?Q?oD55Kot/f0pCxfcTrs4iqNwvTZXdM3W6dzB1VFhygJ1o0skzSNSxbSypkB?=
 =?iso-8859-1?Q?ZqzWOCFBiqRd6XPdxA0Yo3NLnP87wDSrMWVyp4KB8ZbhBDTMbee2l9F1C+?=
 =?iso-8859-1?Q?DKQEdTni6BwRSGUvTg0al3X8sa0M+OR9Gkn+NBf0xpY/qZNysmvq1iOiDv?=
 =?iso-8859-1?Q?xXo98Pk0UIeHse+Gihxi52CvWYr3NAQ+YiXYPDQdp2p6yxpCvh45514tYx?=
 =?iso-8859-1?Q?ttZ34HD9rB5Jt//KIoodFdBJrlf7Di87yGnagEEjrSybPcvl4sBK9zcR6g?=
 =?iso-8859-1?Q?uw7YrL03ADOdd66AXhvF8vyRPBm4C2DnfHIAz4aIB9Nlt8wh3YUFKcXfqp?=
 =?iso-8859-1?Q?AsZA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: aa4376e9-9ff3-4863-92c0-08dd16cb3ddb
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2024 14:27:12.8244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dqmkYX40UKKzNKChc2IGNlg390zei+kt1iyR5V8WxgeqXoVjNk7engoXmcADcXDP0jxk2fFv/SD/HSe3vJdWwNhqOw9pjGTcEQa/fLaWIvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB1032

Hi Sebastian,=0A=
=0A=
Thanks for your feedbacks=0A=
=0A=
> > Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.=
io>=0A=
> > Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>=0A=
> > ---=0A=
> =0A=
> Please add the output from running the following script on a system=0A=
> without your fuel gauge to the cover letter in the next submission.=0A=
> It helps to check that the values are properly converted:=0A=
> =0A=
> ./tools/testing/selftests/power_supply/test_power_supply_properties.sh=0A=
=0A=
Sure, i will attach output of the test =0A=
> > +#define STC3117_ADDR_CC_ADJ_H                        0X1C=0A=
> > +#define STC3117_ADDR_VM_ADJ_L                        0X1D=0A=
> > +#define STC3117_ADDR_VM_ADJ_H                        0X1E=0A=
>=0A=
> Please keep the x in 0X lower case. It suddenly changes after 0x0A=0A=
=0A=
okay =0A=
> > +     data->soc =3D (value * 10 + 256) / 512;=0A=
> > +=0A=
> > +     /* cureent in mA*/=0A=
>=0A=
> typo (cureent -> currrent)=0A=
=0A=
okay=0A=
> > +=0A=
> > +     /* temp */=0A=
>=0A=
> Looks like temp is in =B0C?=0A=
okay =0A=
> > +=0A=
> > +     /* ocv */=0A=
>=0A=
> I guess ocv is also in mV?=0A=
=0A=
okay=0A=
> > +     default:=0A=
> > +             data->battery_state =3D BATT_IDLE;=0A=
> > +     }=0A=
> > +=0A=
> > +     return 0;=0A=
> > +}=0A=
>=0A=
> You are never using data->battery_state, so the whole function can=0A=
> be removed and battery_state can be removed from the data struct.=0A=
=0A=
yes will remove in next version=0A=
=0A=
> > +{=0A=
> > +     int ID, mode, ret;=0A=
>=0A=
> why is ID in upper case like a constant?=0A=
=0A=
okay will change into lower case=0A=
> > +     if (ram_data.reg.state !=3D STC3117_RUNNING) {=0A=
> > +             data->batt_current =3D 0;=0A=
> > +             data->temp =3D 250;=0A=
>=0A=
> why 250?=0A=
=0A=
temperature range for this sensor is specified in the datasheet=0A=
as -40=B0C to 125=B0C.=0A=
The value 250 lies outside this range, which means that the temperature=0A=
data is unavailable or invalid. This approach is consistent with the vendor=
's=0A=
Arduino driver, where 250 is also used in similar conditions to indicate th=
at=0A=
the sensor is not in running mode.=0A=
=0A=
> > +     struct stc3117_data *data =3D container_of(to_delayed_work(work),=
=0A=
> > +                                     struct stc3117_data, update_work)=
;=0A=
> > +     stc3117_task(data);=0A=
>=0A=
> Please run checkpatch before patch submission.=0A=
=0A=
I did this i am not getting any warnings here =0A=
> > +     case POWER_SUPPLY_PROP_VOLTAGE_NOW:=0A=
> > +             val->intval =3D data->voltage;=0A=
> =0A=
> This has to be in uV.=0A=
okay=0A=
> > +             break;=0A=
> > +     case POWER_SUPPLY_PROP_CURRENT_NOW:=0A=
> > +             val->intval =3D data->batt_current;=0A=
> > +             break;=0A=
>=0A=
> This has to be in uA.=0A=
okay =0A=
> > +     case POWER_SUPPLY_PROP_CAPACITY:=0A=
> > +             val->intval =3D data->soc;=0A=
> > +             break;=0A=
> > +     case POWER_SUPPLY_PROP_TEMP:=0A=
> > +             val->intval =3D data->temp;=0A=
> > +             break;=0A=
>=0A=
> This has to be in 1/10 of =B0C.=0A=
=0A=
okay =0A=
> > +     POWER_SUPPLY_PROP_TEMP,=0A=
> > +     POWER_SUPPLY_PROP_PRESENT,=0A=
> > +};=0A=
> =0A=
> During the read process you are also getting OCV and average=0A=
> current. Why are you not exporting them via the following=0A=
> properties (in uV and uA) when you are getting them anyways?=0A=
>=0A=
> POWER_SUPPLY_PROP_VOLTAGE_OCV=0A=
> POWER_SUPPLY_PROP_CURRENT_AVG=0A=
=0A=
okay will add this property=0A=
> > +             return PTR_ERR(data->regmap);=0A=
> > +=0A=
> > +     psy_cfg.drv_data =3D data;=0A=
>=0A=
> psy_cfg.fwnode =3D dev_fwnode(dev);=0A=
 =0A=
okay =0A=
> > +                             "failed to initialize of stc3117\n");=0A=
> > +=0A=
> > +     INIT_DELAYED_WORK(&data->update_work, fuel_gauge_update_work);=0A=
>=0A=
> This is not being stopped on module removal. You need=0A=
> devm_delayed_work_autocancel() instead of INIT_DELAYED_WORK.=0A=
=0A=
sure =0A=
=0A=
Best regards,=0A=
Bhavin=

