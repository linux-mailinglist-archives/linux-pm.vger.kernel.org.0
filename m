Return-Path: <linux-pm+bounces-18194-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 758689DB3FC
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2024 09:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3590E281787
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2024 08:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36C814EC5B;
	Thu, 28 Nov 2024 08:44:58 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazon11020079.outbound.protection.outlook.com [52.101.227.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF19114BF92;
	Thu, 28 Nov 2024 08:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.227.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732783498; cv=fail; b=HaSVfYNVj4kXJR+5o2NtSjTexjwxNEyrm9ZrsaNi8LBJKczrSHYP03AElLmcQCB2kIkbr10hvjDkiNa2vKF7fa6qzGxqdah1pzGkMkulaeZw4R+9aAzsBev6c3mdznI2rMK3a6PSHOaoRz7cVNwbLs7XidtmvHA0XyunZIDDsPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732783498; c=relaxed/simple;
	bh=3qI7PD9bFkTUIOg6u72ReEw9/tQv+ttIQ4sm8DfSmSA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xcbm33zRSemRG0vg0p3CcSHeo61Gl7ceoCbNBAXbmAgeR3ALtufcQ57o0WynBaGQ+dmbv26FNIJ9LNOo4MlzCLsbouHfg1oPJEf9WE1H/iBFMQPuPwAgg9OIn7BBlMh/Tzi4Q4irS7KacZpCtGth1nNRnm9ICR5ERsmuc61bGgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=52.101.227.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfAE4weLXM5kpGSKQFeHtqSSTrHgaXDhsbh1wyBBc5VQIqWCwLNTt51PH9FQGOsDJaNnKD7Xj60OaJN+UEEkGexe77pfSIfaJrq/bjgpCauH0L8PGZSs51MxoavyCYlniFQSuFwZTg0jAfIfqXlAAhIhCbZkxtPYIv+2K5Mlf8N9X5q6uyghLkIHNvbUqVmsqsvCXjAzqQj2HtAQHrRBCeRh/wAXMoKcBwpGXeyCBqgj9yWqoK+s0amXTFuxeaUX4LJhTc/uUJoiVYBGy6y+molXL/MRd4jxScL3BFDUsT+8Ya8tDX37r8fsfztjeweGgxJb9K/GxQyhgdacA3a2Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qI7PD9bFkTUIOg6u72ReEw9/tQv+ttIQ4sm8DfSmSA=;
 b=eAawrx6fHP2gUdKqHQK0e2KJdHbc0mGSuYzC6mZJrhKynbXuMXstIpcQnK9jyf8qb7D3dIEqcdlbh7rFBQxx/3b0cY4lzpmEzK7MZDmV0o9wSdOgn4SI+cv41gC2w8sC1KVholzoqgRXtLM2zuezOCHOQSnRFHI/siX2e+qP5eXePJu4rZVnUPzNXIKtRo4Biy0by56bUhnHlLto6+8FD4+XLxnvdeUw2ZX7YyNugJ2V1m+fQaupfwPkIfdtPgndaKtn88lQ7eyL1dlQWsvOSpVaLpG+CH0R7hy42ztRpOPwRhiHd+KJkLZjTdSIckO5DnqfDhCbCa0F+DxlBT/hKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from MA0P287MB1178.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:fc::7) by
 PN1P287MB3631.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:24f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.13; Thu, 28 Nov 2024 08:44:53 +0000
Received: from MA0P287MB1178.INDP287.PROD.OUTLOOK.COM
 ([fe80::56b4:3b88:bcc8:b1c2]) by MA0P287MB1178.INDP287.PROD.OUTLOOK.COM
 ([fe80::56b4:3b88:bcc8:b1c2%7]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 08:44:53 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: Krzysztof Kozlowski <krzk@kernel.org>, "sre@kernel.org" <sre@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>
CC: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] power: supply: Add STC3117 fuel gauge unit driver
Thread-Topic: [PATCH v4 2/2] power: supply: Add STC3117 fuel gauge unit driver
Thread-Index: AQHbQOAFRmzlRiVK4UCGEyTRruxs6bLLcXwAgADvo/U=
Date: Thu, 28 Nov 2024 08:44:53 +0000
Message-ID:
 <MA0P287MB1178B165FAFE680FDBD14301F2292@MA0P287MB1178.INDP287.PROD.OUTLOOK.COM>
References: <20241127151953.29550-1-bhavin.sharma@siliconsignals.io>
 <20241127151953.29550-3-bhavin.sharma@siliconsignals.io>
 <be00dec6-d598-4dea-b608-51ea67b37084@kernel.org>
In-Reply-To: <be00dec6-d598-4dea-b608-51ea67b37084@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB1178:EE_|PN1P287MB3631:EE_
x-ms-office365-filtering-correlation-id: ffe1f30c-6ebe-44bb-2b20-08dd0f88eda1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?eUGwa93bpZEjtBddxsH3OjxaOvKYxgoh8NySfse9jf/JTQ5bLz49rm3bd6?=
 =?iso-8859-1?Q?q+YCq9uMEAyeETbvxeMLam9Vx4Sw6IoBy/cWT8GnM27R2+mn+oXK9c5gR0?=
 =?iso-8859-1?Q?kbQJzjBH9lP/oq9sHB8aZspncDsCujNfzZ7arFvRi92GVooV3ku8v6QtUk?=
 =?iso-8859-1?Q?3cUKJCN013VZ8WnB8H5CPggS3taIdLDu1B64fLDh/vu6FzsWUKKBXeQXD6?=
 =?iso-8859-1?Q?lDox1bHpDvFbr6yUtsB/KFF3NBlkhJS+jGoB2Zuc8tEgWAsIsAYDD6evTk?=
 =?iso-8859-1?Q?x6a3uJ/e/JkwKbMFpL0By70JbuNT4YRTQrIW+WHwwxUYFleicEKf8RgfzD?=
 =?iso-8859-1?Q?bd+NOqzpACTS2eDTvxr2MQVKXgKr82/mGaXdJmGGD4K3og8cIWGfVgSUkT?=
 =?iso-8859-1?Q?eqgi57Wl+871TMVaX4lXTdYeaabrbEygjkH+WgTAjcKUdGWP2kejOEVtiL?=
 =?iso-8859-1?Q?rD0ryQIXYalWvtp7y1ySyje49OvXyJpge8XJQsLNecIUp46AdGsQqxbUIc?=
 =?iso-8859-1?Q?ZkQC4Lv4gqr24/a0W/r460B56n9MRdXHcH1AmSVYFR7+claLMLI6Hx88AO?=
 =?iso-8859-1?Q?afVVXNFjLf7Xn0nP2mMB5ajORJjusYUfGEISRKSc9QmA1ZhfpO2muIUswA?=
 =?iso-8859-1?Q?RfaWeOD/vcRFu1sEhRA9JrLEOoeBj3PJeG+We0gfKFGLV4akjvIbCWMYIO?=
 =?iso-8859-1?Q?RJfDON+a4WtrOl5RYtjXmxu3TGDQkpk/blRmlmuqIXxG0ojMZF/RkL8hYz?=
 =?iso-8859-1?Q?p1OjM50kCTOi0UUrOMShhfkvXH/4cFKF/+Qes657mJ2stSFymkwZp/fsId?=
 =?iso-8859-1?Q?Qh0zEqH2JEoen3efroTPdXDc16mDCmcuiWlK87DqVxSZ9KG+KLKgc321XD?=
 =?iso-8859-1?Q?EfSh+sXj0fByEijKRW19fMuGwtaOTM1XGpyDj9ekrSSg1/k9u/WkjQCwCw?=
 =?iso-8859-1?Q?3H5z/84PuQRq7SfWtC0vAd/LEGWofZJdvyMTBDq4ZSGPTiRClqIXE4eJMy?=
 =?iso-8859-1?Q?hBsd/eFwlcajGRvIDwOt2nAnlahuzacC/ykzEOod/h1XR+ERImtF/V4fIN?=
 =?iso-8859-1?Q?MWJB4xZvYh+0Z1ZshRcBBEu68CIE4XcfjHVGFahVhonbUOxmQ+LGgbgTJO?=
 =?iso-8859-1?Q?EN0MaH+rzU+VT5ttIsygUp6TufcaE8QNsyGWm57f0K/ajawwXnYdl0u0G1?=
 =?iso-8859-1?Q?qkWjQ21/HNFlFrxlPcKHzAdy9sQ2zxLpTouFeoP/znPXS8NA/WyH/Ob7nh?=
 =?iso-8859-1?Q?5Y9yt8EmJthIKbFmTU+Cdfcn2w4Zy0g4u9VKSzgQ1E80cn03ssSavYdEKW?=
 =?iso-8859-1?Q?1pxUw9WywTK2iExZ8vyLvW94Mi3DMZU9ws556+De0/mBYOOcjF4l29Gspw?=
 =?iso-8859-1?Q?A6PKgepfIDCvAvlGYDy3DMmfElwSyAztZ3NQd/pG1I0Fv0OdYQna5vv7Ro?=
 =?iso-8859-1?Q?J7KxNu99SBTnKgaouP0597Gn0q/gelFBfs4xTQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB1178.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?XWbAycGajl0136bUC/jOaf3LypoUgbuSFgA1KyDRZjBtLyPrGe9VEHMjHN?=
 =?iso-8859-1?Q?4D6Ot0t0cxgp63saDIHjl7eESRt+1Ux8uGfMRrGUJfdACx0Xur+xcqNakN?=
 =?iso-8859-1?Q?pKrhIRrD1R2VJ7+33decaIHdSHWn+A3qT9tucy5gMpFgPrQW37itcO7JLE?=
 =?iso-8859-1?Q?wHVhNSgSv1GK6fKhZfQ5D2b+xwVLgVK/h2Z8iKCBwGPFPhRBggoTgyyqIl?=
 =?iso-8859-1?Q?cbju/XeHccRPGp0w10nmtESg9NKgzxFOKJh8LPOeGuy9V8vEO4v5uezfn0?=
 =?iso-8859-1?Q?2HDBmuf6Wi9xaqmHvSuynNyvS8QVszpah3rrJCEYWJ76n7GMgqzI//ODuP?=
 =?iso-8859-1?Q?iF8EelFk0+u4lGoN5cPjZ5I7sgTfpH+GwNSPv6nC83g4CcDQlCFo1KGO7y?=
 =?iso-8859-1?Q?WxK8Ee9+E2PnhyT2YKaXA6kQbbVwNyiXN67hgeJWxj8veCBp4hTi6F7DvV?=
 =?iso-8859-1?Q?Z1N72sMYdg0MmPFki2xI7sZSBAw5FG/o2TKm6/HHO7INtUlbx7lE1VYEpu?=
 =?iso-8859-1?Q?HuVwwFXFVTFp2IO8jRhnXe88uPWJtUE84xYJco/pgiCTyqamoZNpxJpneZ?=
 =?iso-8859-1?Q?YrSjCnU0PgWnvPpJpX2HofMTDw9lBqbMg5utETjQsE7E74iKJQcB6ZbCQF?=
 =?iso-8859-1?Q?xHL8MFkEromfxp9CwzScej9LHK4IT37rNWUHTQYoxEU6pBb3U2DlP1sS1O?=
 =?iso-8859-1?Q?xXbJdjupTqyhvsTmtwjVsBCu+Pe+yWC+9yaawXNLllStn1gsiHmBipOpR7?=
 =?iso-8859-1?Q?4mHAb5wY1cWsfkctVcLIhko+KH93hYppUd5oJU4cTGq7Z6aAGlgJC3Bz4w?=
 =?iso-8859-1?Q?GjpSchCvVnGxgz9L2Sj6Oz73C1lI2+E2AmOkB+cFrEX5j5XvPslRgqT754?=
 =?iso-8859-1?Q?2SaY6ZRPdwHxjXFQ9Q3SiFeXUxtXFx2kL6gUOeUQafAvB68/vpr7ul7mUt?=
 =?iso-8859-1?Q?qSsAcKD7dboWj8+7Bk+uBs+ZEk1+meKvq2B5su6O2D91++eEDbVopxAF1z?=
 =?iso-8859-1?Q?i4Nel+X/1FlsKj+piRadrZxBV5/5R8Y9DJoIrKOUmYIbvA6RN8lMSImSIk?=
 =?iso-8859-1?Q?oIxida9xVh/4CA/YtA9DXqzjoUHMCG4XumOgXdqEDciYo+Upg1Ly1onSSn?=
 =?iso-8859-1?Q?n9CUni/YpvsQFQ2u15NuaPFdCFvbI/mwL/biXxyYbVLbNLBahEi9jZHLVy?=
 =?iso-8859-1?Q?OcxgdfEEiJRLIAQau/TP94nDQVs5lChajkgwSkH88k//sQWurF2TagiR9H?=
 =?iso-8859-1?Q?tMhww1BTOv+LHnoJfdJiRF2Cyn4nrP6ioT9yhVKC9Kh+4Ep+PEXjNbyH/z?=
 =?iso-8859-1?Q?geKDXNe351Gbw/C8iR9ipdQ9DwKiQ/ZhcEY/d0IltJ98JSHhkuDfbbphHB?=
 =?iso-8859-1?Q?QdmhLYewrFMZ/j3zfKqCWrZBFQhg5FdlcE19oNbcyqI1e8oZJhiPyUgzGZ?=
 =?iso-8859-1?Q?d8Y9963pokPyqLnhVxOjBFoxnQeqpqbDsmGoSK2igmcN9uUmAoP5BZAp1h?=
 =?iso-8859-1?Q?pVyclTy1aEn4hl0a0GzCWhab/ceo4bA6gbKJ070O1c2YZWxp2VaFpSH5pT?=
 =?iso-8859-1?Q?EiPRH9BNejOvRAYzQjHJj17Dm58sV8Pskdj1D6gLlHDlhVG4PrU8NJsjAt?=
 =?iso-8859-1?Q?7w6uPIa4btU6CksZBHaSd6655yqSRPpB1uAbcHlGXqekZmmhVA3rorKg?=
 =?iso-8859-1?Q?=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB1178.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe1f30c-6ebe-44bb-2b20-08dd0f88eda1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2024 08:44:53.2564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BuyDQCKY9nC7qOXJPqwgjK8hKsjEBNdl0QCsJ4tYp6dIT+hW4ykpYnb88VbVjIiNZ6fr0REZNOj8ykeaT3VQJBu+yGEW163jvY+P0OUYJWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN1P287MB3631

Hi Krzysztof,=0A=
=A0=0A=
Thank you for your review and feedback.=0A=
=A0=0A=
> > +struct stc3117_data {=0A=
> > +=A0=A0=A0=A0 struct i2c_client=A0=A0=A0=A0=A0=A0 *client;=0A=
> > +=A0=A0=A0=A0 struct regmap=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *regmap;=0A=
> > +=A0=A0=A0=A0 struct delayed_work update_work;=0A=
> > +=A0=A0=A0=A0 struct power_supply=A0=A0=A0=A0 *battery;=0A=
> > +=0A=
> > +=A0=A0=A0=A0 u8 SOCValue[16];=0A=
> > +=A0=A0=A0=A0 int CC_cnf;=0A=
> > +=A0=A0=A0=A0 int VM_cnf;=0A=
> > +=A0=A0=A0=A0 int CC_adj;=0A=
> > +=A0=A0=A0=A0 int VM_adj;=0A=
> > +=A0=A0=A0=A0 int AvgCurrent;=0A=
> > +=A0=A0=A0=A0 int AvgVoltage;=0A=
> > +=A0=A0=A0=A0 int Current;=0A=
> > +=A0=A0=A0=A0 int Voltage;=0A=
> > +=A0=A0=A0=A0 int Temp;=0A=
> > +=A0=A0=A0=A0 int SOC;=0A=
> > +=A0=A0=A0=A0 int OCV;=0A=
> > +=A0=A0=A0=A0 int HRSOC;=0A=
> > +=A0=A0=A0=A0 int Presence;=0A=
> > +=A0=A0=A0=A0 int Battery_state;=0A=
>=0A=
> That's some Windows coding style... You need to clean up everything here=
=0A=
> to match Linux Coding style.=0A=
=A0=0A=
Could you clarify what specific changes are required here to align with the=
 Linux=0A=
coding style?=0A=
=A0=0A=
I am not sure what exactly needs to be changed here.=0A=
=A0=0A=
> > +=A0=A0=A0=A0 data->battery =3D devm_power_supply_register(&client->dev=
,=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &s=
tc3117_battery_desc, &psy_cfg);=0A=
> > +=A0=A0=A0=A0 if (IS_ERR(data->battery))=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err_probe(&client->dev, PTR_E=
RR(data->battery), "failed to register battery\n");=0A=
> > +=0A=
> You ignored (again!) received comments. In multiple places. Go back to=0A=
> previous email and carefully read commetns.=0A=
=A0=0A=
Sebastian suggested using dev_err_probe, while you mentioned using dev_err.=
=0A=
so what should i follow ?=0A=
=A0=0A=
> One more thing:=0A=
>=A0=0A=
> Please wrap code according to coding style (checkpatch is not a coding=0A=
> style description, but only a tool).=0A=
=A0=0A=
Could you recommend an example driver from the kernel source tree that=A0=
=0A=
follows the expected coding style? This would help me ensure compliance.=0A=
=A0=0A=
Best Regards,=0A=
Bhavin=0A=
=A0=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
________________________________________=0A=
From:=A0Krzysztof Kozlowski <krzk@kernel.org>=0A=
Sent:=A0Wednesday, November 27, 2024 11:54 PM=0A=
To:=A0Bhavin Sharma <bhavin.sharma@siliconsignals.io>; sre@kernel.org <sre@=
kernel.org>; krzk+dt@kernel.org <krzk+dt@kernel.org>; robh@kernel.org <robh=
@kernel.org>; conor+dt@kernel.org <conor+dt@kernel.org>=0A=
Cc:=A0Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>; linux-pm=
@vger.kernel.org <linux-pm@vger.kernel.org>; devicetree@vger.kernel.org <de=
vicetree@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.=
kernel.org>=0A=
Subject:=A0Re: [PATCH v4 2/2] power: supply: Add STC3117 fuel gauge unit dr=
iver=0A=
=A0=0A=
CAUTION: This email originated from outside the organization. Do not click =
links or open attachments unless you recognize the sender and know the cont=
ent is safe.=0A=
=0A=
On 27/11/2024 16:19, Bhavin Sharma wrote:=0A=
> Adds initial support for the STC3117 fuel gauge.=0A=
>=0A=
> The driver provides functionality to monitor key parameters including:=0A=
> - Voltage=0A=
> - Current=0A=
> - State of Charge (SOC)=0A=
> - Temperature=0A=
> - Status=0A=
>=0A=
> Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io=
>=0A=
> Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>=0A=
> ---=0A=
>=A0 MAINTAINERS=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 8 +=0A=
>=A0 drivers/power/supply/Kconfig=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=
=A0=A0 7 +=0A=
>=A0 drivers/power/supply/Makefile=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=
=A0 1 +=0A=
>=A0 drivers/power/supply/stc3117_fuel_gauge.c | 625 ++++++++++++++++++++++=
=0A=
>=A0 4 files changed, 641 insertions(+)=0A=
>=A0 create mode 100644 drivers/power/supply/stc3117_fuel_gauge.c=0A=
>=0A=
> diff --git a/MAINTAINERS b/MAINTAINERS=0A=
> index 82161bc70b51..42c1af29eddb 100644=0A=
> --- a/MAINTAINERS=0A=
> +++ b/MAINTAINERS=0A=
> @@ -21855,6 +21855,14 @@ T:=A0=A0 git git://linuxtv.org/media_tree.git=0A=
>=A0 F:=A0=A0 Documentation/devicetree/bindings/media/i2c/st,st-mipid02.yam=
l=0A=
>=A0 F:=A0=A0 drivers/media/i2c/st-mipid02.c=0A=
>=0A=
> +ST STC3117 FUEL GAUGE DRIVER=0A=
> +M:=A0=A0 Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>=0A=
> +M:=A0=A0 Bhavin Sharma <bhavin.sharma@siliconsignals.io>=0A=
> +L:=A0=A0 linux-pm@vger.kernel.org=0A=
> +S:=A0=A0 Maintained=0A=
> +F:=A0=A0 Documentation/devicetree/bindings/power/supply/st,stc3117.yaml=
=0A=
> +F:=A0=A0 drivers/power/supply/stc3117_fuel_gauge.c=0A=
> +=0A=
>=A0 ST STM32 FIREWALL=0A=
>=A0 M:=A0=A0 Gatien Chevallier <gatien.chevallier@foss.st.com>=0A=
>=A0 S:=A0=A0 Maintained=0A=
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig=
=0A=
> index bcfa63fb9f1e..6ad968fa1f69 100644=0A=
> --- a/drivers/power/supply/Kconfig=0A=
> +++ b/drivers/power/supply/Kconfig=0A=
> @@ -908,6 +908,13 @@ config FUEL_GAUGE_SC27XX=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 Say Y here to enable support for fuel gauge with =
SC27XX=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 PMIC chips.=0A=
>=0A=
> +config FUEL_GAUGE_STC3117=0A=
> +=A0=A0=A0=A0 tristate "STMicroelectronics STC3117 fuel gauge driver"=0A=
> +=A0=A0=A0=A0 depends on I2C=0A=
> +=A0=A0=A0=A0 help=0A=
> +=A0=A0=A0=A0=A0=A0 Say Y here to enable support for fuel gauge with STC3=
117=0A=
> +=A0=A0=A0=A0=A0=A0 PMIC chips.=0A=
> +=0A=
>=A0 config CHARGER_UCS1002=0A=
>=A0=A0=A0=A0=A0=A0 tristate "Microchip UCS1002 USB Port Power Controller"=
=0A=
>=A0=A0=A0=A0=A0=A0 depends on I2C=0A=
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefil=
e=0A=
> index 8dcb41545317..aea3d35f27f3 100644=0A=
> --- a/drivers/power/supply/Makefile=0A=
> +++ b/drivers/power/supply/Makefile=0A=
> @@ -107,6 +107,7 @@ obj-$(CONFIG_CHARGER_CROS_USBPD)=A0 +=3D cros_usbpd-c=
harger.o=0A=
>=A0 obj-$(CONFIG_CHARGER_CROS_PCHG)=A0=A0=A0=A0=A0 +=3D cros_peripheral_ch=
arger.o=0A=
>=A0 obj-$(CONFIG_CHARGER_SC2731) +=3D sc2731_charger.o=0A=
>=A0 obj-$(CONFIG_FUEL_GAUGE_SC27XX)=A0=A0=A0=A0=A0 +=3D sc27xx_fuel_gauge.=
o=0A=
> +obj-$(CONFIG_FUEL_GAUGE_STC3117)=A0=A0=A0=A0 +=3D stc3117_fuel_gauge.o=
=0A=
>=A0 obj-$(CONFIG_CHARGER_UCS1002)=A0=A0=A0=A0=A0=A0=A0 +=3D ucs1002_power.=
o=0A=
>=A0 obj-$(CONFIG_CHARGER_BD99954)=A0=A0=A0=A0=A0=A0=A0 +=3D bd99954-charge=
r.o=0A=
>=A0 obj-$(CONFIG_CHARGER_WILCO)=A0 +=3D wilco-charger.o=0A=
> diff --git a/drivers/power/supply/stc3117_fuel_gauge.c b/drivers/power/su=
pply/stc3117_fuel_gauge.c=0A=
> new file mode 100644=0A=
> index 000000000000..99291bb9250f=0A=
> --- /dev/null=0A=
> +++ b/drivers/power/supply/stc3117_fuel_gauge.c=0A=
> @@ -0,0 +-2,622 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0-only=0A=
> +/*=0A=
> + * stc3117_fuel_gauge.c - STMicroelectronics STC3117 Fuel Gauge Driver=
=0A=
> + *=0A=
> + * Copyright (c) 2024 Silicon Signals Pvt Ltd.=0A=
> + * Author:=A0=A0=A0=A0=A0 Bhavin Sharma <bhavin.sharma@siliconsignals.io=
>=0A=
> + *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Hardevsinh Palaniya <hardevsin=
h.palaniya@siliconsignals.com>=0A=
> + */=0A=
> +=0A=
> +#include <linux/i2c.h>=0A=
> +#include <linux/workqueue.h>=0A=
> +#include <linux/power_supply.h>=0A=
> +#include <linux/regmap.h>=0A=
> +#include <linux/crc8.h>=0A=
> +=0A=
> +#define STC3117_ADDR_MODE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 0x00=0A=
> +#define STC3117_ADDR_CTRL=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 0x01=0A=
> +#define STC3117_ADDR_SOC_L=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0x02=0A=
> +#define STC3117_ADDR_SOC_H=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0x03=0A=
> +#define STC3117_ADDR_COUNTER_L=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 0x04=0A=
> +#define STC3117_ADDR_COUNTER_H=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 0x05=0A=
> +#define STC3117_ADDR_CURRENT_L=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 0x06=0A=
> +#define STC3117_ADDR_CURRENT_H=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 0x07=0A=
> +#define STC3117_ADDR_VOLTAGE_L=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 0x08=0A=
> +#define STC3117_ADDR_VOLTAGE_H=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 0x09=0A=
> +#define STC3117_ADDR_TEMPERATURE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0x0A=0A=
> +#define STC3117_ADDR_AVG_CURRENT_L=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0X0B=0A=
> +#define STC3117_ADDR_AVG_CURRENT_H=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0X0C=0A=
> +#define STC3117_ADDR_OCV_L=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0X0D=0A=
> +#define STC3117_ADDR_OCV_H=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0X0E=0A=
> +#define STC3117_ADDR_CC_CNF_L=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0X0F=0A=
> +#define STC3117_ADDR_CC_CNF_H=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0X10=0A=
> +#define STC3117_ADDR_VM_CNF_L=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0X11=0A=
> +#define STC3117_ADDR_VM_CNF_H=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0X12=0A=
> +#define STC3117_ADDR_ALARM_SOC=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 0X13=0A=
> +#define STC3117_ADDR_ALARM_VOLTAGE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 0X14=0A=
> +#define STC3117_ADDR_ID=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 0X18=0A=
> +#define STC3117_ADDR_CC_ADJ_L=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 0X1B=0A=
> +#define STC3117_ADDR_CC_ADJ_H=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 0X1C=0A=
> +#define STC3117_ADDR_VM_ADJ_L=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 0X1D=0A=
> +#define STC3117_ADDR_VM_ADJ_H=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 0X1E=0A=
> +#define STC3117_ADDR_RAM=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0x20=0A=
> +#define STC3117_ADDR_OCV_TABLE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 0x30=0A=
> +#define STC3117_ADDR_SOC_TABLE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 0x30=0A=
> +=0A=
> +/************ Bit mask definition ************/=0A=
> +#define STC3117_ID=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 0x16=0A=
> +#define STC3117_MIXED_MODE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 0x00=0A=
> +#define STC3117_VMODE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 BIT(0)=0A=
> +#define STC3117_GG_RUN=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 BIT(4)=0A=
> +#define STC3117_CC_MODE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 BIT(5)=0A=
> +#define STC3117_BATFAIL=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 BIT(3)=0A=
> +#define STC3117_PORDET=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 BIT(4)=0A=
> +=0A=
> +#define STC3117_RAM_SIZE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 16=0A=
> +#define STC3117_OCV_TABLE_SIZE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 16=0A=
> +#define STC3117_RAM_TESTWORD=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0x53A9=0A=
> +#define STC3117_SOFT_RESET=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0x11=0A=
> +#define STC3117_NOMINAL_CAPACITY=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 260=
0=0A=
> +=0A=
> +#define VOLTAGE_LSB_VALUE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 9011=0A=
> +#define CURRENT_LSB_VALUE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 24084=0A=
> +#define RSENSE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 10=0A=
> +#define BATT_CAPACITY=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1800=0A=
> +#define BATTERY_RINT=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 60=0A=
> +#define APP_CUTOFF_VOLTAGE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 2500=0A=
> +#define BATT_CHG_VOLTAGE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 4250=0A=
> +#define BATT_MIN_VOLTAGE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 3300=0A=
> +#define MAX_HRSOC=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 51200=0A=
> +#define MAX_SOC=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1000=0A=
> +#define CHG_MIN_CURRENT=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 200=0A=
> +#define CHG_END_CURRENT=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 20=0A=
> +#define APP_MIN_CURRENT=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 (-5)=0A=
> +#define BATTERY_FULL=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 95=0A=
> +#define CRC8_POLYNOMIAL=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 0x07=0A=
> +#define CRC8_INIT=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x00=0A=
> +#define CRC8_TABLE_SIZE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 256=0A=
> +=0A=
> +DECLARE_CRC8_TABLE(stc3117_crc_table);=0A=
> +=0A=
> +enum stc3117_state {=0A=
> +=A0=A0=A0=A0 STC3117_INIT,=0A=
> +=A0=A0=A0=A0 STC3117_RUNNING,=0A=
> +=A0=A0=A0=A0 STC3117_POWERDN,=0A=
> +};=0A=
> +=0A=
> +enum stc3117_status {=0A=
> +=A0=A0=A0=A0 BATT_LOWBATT =3D -2,=0A=
> +=A0=A0=A0=A0 BATT_DISCHARG,=0A=
> +=A0=A0=A0=A0 BATT_IDLE,=0A=
> +=A0=A0=A0=A0 BATT_FULCHARG,=0A=
> +=A0=A0=A0=A0 BATT_ENDCHARG,=0A=
> +=A0=A0=A0=A0 BATT_CHARGING,=0A=
> +};=0A=
> +=0A=
> +/* Default OCV curve Li-ion battery */=0A=
> +static const int OCVValue[16] =3D {=0A=
> +=A0=A0=A0 3400, 3582, 3669, 3676, 3699, 3737, 3757, 3774,=0A=
> +=A0=A0=A0 3804, 3844, 3936, 3984, 4028, 4131, 4246, 4320=0A=
> +};=0A=
> +=0A=
> +static union stc3117_internal_ram {=0A=
> +=A0=A0=A0=A0 u8 ram_bytes[STC3117_RAM_SIZE];=0A=
> +=A0=A0=A0=A0 struct {=0A=
> +=A0=A0=A0=A0 u16 TestWord;=A0=A0 /* 0-1=A0=A0=A0 Bytes */=0A=
> +=A0=A0=A0=A0 u16 HRSOC;=A0=A0=A0=A0=A0 /* 2-3=A0=A0=A0 Bytes */=0A=
> +=A0=A0=A0=A0 u16 CC_cnf;=A0=A0=A0=A0 /* 4-5=A0=A0=A0 Bytes */=0A=
> +=A0=A0=A0=A0 u16 VM_cnf;=A0=A0=A0=A0 /* 6-7=A0=A0=A0 Bytes */=0A=
> +=A0=A0=A0=A0 u8 soc;=A0=A0=A0=A0=A0=A0=A0=A0 /* 8=A0=A0=A0=A0=A0 Byte=A0=
 */=0A=
> +=A0=A0=A0=A0 u8 state;=A0=A0=A0=A0=A0=A0 /* 9=A0=A0=A0=A0=A0 Byte=A0 */=
=0A=
> +=A0=A0=A0=A0 u8 unused[5];=A0=A0 /* 10-14=A0 Bytes */=0A=
> +=A0=A0=A0=A0 u8 CRC;=A0=A0=A0=A0=A0=A0=A0=A0 /* 15=A0=A0=A0=A0 Byte=A0 *=
/=0A=
> +=A0=A0=A0=A0 } reg;=0A=
> +} ram_data;=0A=
> +=0A=
> +struct stc3117_data {=0A=
> +=A0=A0=A0=A0 struct i2c_client=A0=A0=A0=A0=A0=A0 *client;=0A=
> +=A0=A0=A0=A0 struct regmap=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *regmap;=0A=
> +=A0=A0=A0=A0 struct delayed_work update_work;=0A=
> +=A0=A0=A0=A0 struct power_supply=A0=A0=A0=A0 *battery;=0A=
> +=0A=
> +=A0=A0=A0=A0 u8 SOCValue[16];=0A=
> +=A0=A0=A0=A0 int CC_cnf;=0A=
> +=A0=A0=A0=A0 int VM_cnf;=0A=
> +=A0=A0=A0=A0 int CC_adj;=0A=
> +=A0=A0=A0=A0 int VM_adj;=0A=
> +=A0=A0=A0=A0 int AvgCurrent;=0A=
> +=A0=A0=A0=A0 int AvgVoltage;=0A=
> +=A0=A0=A0=A0 int Current;=0A=
> +=A0=A0=A0=A0 int Voltage;=0A=
> +=A0=A0=A0=A0 int Temp;=0A=
> +=A0=A0=A0=A0 int SOC;=0A=
> +=A0=A0=A0=A0 int OCV;=0A=
> +=A0=A0=A0=A0 int HRSOC;=0A=
> +=A0=A0=A0=A0 int Presence;=0A=
> +=A0=A0=A0=A0 int Battery_state;=0A=
=0A=
=0A=
That's some Windows coding style... You need to clean up everything here=0A=
to match Linux Coding style.=0A=
=0A=
=0A=
> +};=0A=
> +=0A=
=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0 i2c_set_clientdata(client, data);=0A=
> +=A0=A0=A0=A0 psy_cfg.drv_data =3D data;=0A=
> +=0A=
> +=A0=A0=A0=A0 crc8_populate_msb(stc3117_crc_table, CRC8_POLYNOMIAL);=0A=
> +=0A=
> +=A0=A0=A0=A0 ret =3D stc3117_init(data);=0A=
> +=A0=A0=A0=A0 if (ret)=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err_probe(&client->dev, ret, "f=
ailed to initialization of stc3117\n");=0A=
> +=0A=
> +=A0=A0=A0=A0 INIT_DELAYED_WORK(&data->update_work, fuel_gauge_update_wor=
k);=0A=
> +=0A=
> +=A0=A0=A0=A0 schedule_delayed_work(&data->update_work, 0);=0A=
> +=0A=
> +=A0=A0=A0=A0 data->battery =3D devm_power_supply_register(&client->dev,=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &stc3=
117_battery_desc, &psy_cfg);=0A=
> +=A0=A0=A0=A0 if (IS_ERR(data->battery))=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err_probe(&client->dev, PTR_ERR=
(data->battery), "failed to register battery\n");=0A=
> +=0A=
You ignored (again!) received comments. In multiple places. Go back to=0A=
previous email and carefully read commetns.=0A=
=0A=
One more thing:=0A=
=0A=
Please wrap code according to coding style (checkpatch is not a coding=0A=
style description, but only a tool).=0A=
=0A=
=0A=
Best regards,=0A=
Krzysztof=

