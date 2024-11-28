Return-Path: <linux-pm+bounces-18193-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF229DB3F2
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2024 09:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79F88B20EB9
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2024 08:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EFC14C5A1;
	Thu, 28 Nov 2024 08:41:50 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazon11020088.outbound.protection.outlook.com [52.101.227.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EF013D8B0;
	Thu, 28 Nov 2024 08:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.227.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732783310; cv=fail; b=d99yE2hflM5+mDTDjsEmEdkkjdm9DVoqvkCL/vaWMklGdQkGTy0TSUZu7CS79icM17bXM7FvDtnqqg2ImS53Ja+2UgMWAov6rUKkY2FOK0+Ut5lSybp4lKTx5GgK8AAwNh6uA614cBH8P+C0HV94282s0hU61Q8yNXMTBe5JD3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732783310; c=relaxed/simple;
	bh=IwtVJl8nhWQaEgvVgJ16ejtdIltE6lmDUlD9S2MXA1o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iB7Jer5oqGZ9YxcAxRoE3bKtCaFy66RAk1Q11Rx1kWWHB2TLuX46gCPaWZ7ojG4uY4OtTLhkXYbzGmfJQBhY5cDSh5fLJM7gzKd7sjD08uo3FxYFJub5FDTAGP6L8Xk5Eb4pI3HBJYIq3q2n8VsruWWpOZbEB79SDGxCxItADNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=52.101.227.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hQijfj88pO4E3So+zyUcsEV+bYr1DFd8zhRTcMRLkQF1FygN1UJu3jBiJnf+rYNAPOX9vH6SPczhiznMTnkQj3t6yfDCci7gsjGIGiZWLhzHEXPbcp3pESkKFXdb8L10JRogb4M0EZyDWtCxtu1NhpOkZsMkT95mF0ltMA6RLP3/qk9xJf+Dbz01+YUzSvabzvYHEEazIyFwJaXwr4lw+ESnb+4GJgXhSGd9m9O2gYKYEwTWEV9MTL8JH/zl2X0QNWalDM650mJB9Nmo1Zsl9FSFjJGaNJ5ymiPnmtFjbw7TbKS5zd+Dy+cVPENY363Zr0wLDxKsPYtgwMrr0D9CWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVIRibn2vFEZ6RAmVyeGc4wx64LhhHJndQxo1msC7mo=;
 b=t0dnp9VKBtRf6EcWN2+RS7L2DY1chA9M1Bk4ucj1P+I1wwsbadqNLrPtfjlnoRAwZlIdf+f3ojHxOUNJUPWfGovhdVXNLiNGqP/TmIrrTyAdgW0/dShumNGXyngHdqX+Bw0mzNXBqHFf6fMXGSHHQKQZObWZqQbwS+Wka7q1rTS2HtFQM1LElXLGpGE9DKzm3JRm7StFh+2yKqh7ZDXewhmk0m0aN2FGLiCieXL8BQxjWMYU6+bea9SLXE7TYxQFRHrhZbX36ksPIArDObwQUjLenCPEyjDuJVf5HLLLgGlXoFnBOc1h1I9F/pXCdY0UVeJ3ddb0DYlfd4EqrNGMAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from MA0P287MB1178.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:fc::7) by
 PN1P287MB3631.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:24f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.13; Thu, 28 Nov 2024 08:41:45 +0000
Received: from MA0P287MB1178.INDP287.PROD.OUTLOOK.COM
 ([fe80::56b4:3b88:bcc8:b1c2]) by MA0P287MB1178.INDP287.PROD.OUTLOOK.COM
 ([fe80::56b4:3b88:bcc8:b1c2%7]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 08:41:45 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: Krzysztof Kozlowski <krzk@kernel.org>, "sre@kernel.org" <sre@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>
CC: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: power: supply: Add STC3117 Fuel Gauge
Thread-Topic: [PATCH v4 1/2] dt-bindings: power: supply: Add STC3117 Fuel
 Gauge
Thread-Index: AQHbQOADe5gZwmKWdUmiMoICk/r1U7LLcMIAgADvl6Y=
Date: Thu, 28 Nov 2024 08:41:44 +0000
Message-ID:
 <MA0P287MB11785EEAC5D646450D30E867F2292@MA0P287MB1178.INDP287.PROD.OUTLOOK.COM>
References: <20241127151953.29550-1-bhavin.sharma@siliconsignals.io>
 <20241127151953.29550-2-bhavin.sharma@siliconsignals.io>
 <3eb06a70-cafb-4d89-aa68-524ec91e3850@kernel.org>
In-Reply-To: <3eb06a70-cafb-4d89-aa68-524ec91e3850@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0P287MB1178:EE_|PN1P287MB3631:EE_
x-ms-office365-filtering-correlation-id: d2f44c71-76c0-4be0-3bf7-08dd0f887d5c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?RnfqWUCv7XsinsW7EXYiAfoZHISYDpDj49AMKAYX91xCh7djVY0QEko1Oc?=
 =?iso-8859-1?Q?x3PSxS67R7TBDKpbZP/3olYKb2rhUe/XgiGFErMHub1V+oYjhdzzEUGA8u?=
 =?iso-8859-1?Q?/zxpCKrTiSf2Hf0PziVnkZSosK1rG8eLQTvawiwyWQFkKVfrfZyKyag60y?=
 =?iso-8859-1?Q?Lsv3qFtmJ1I4HdDQLyvGU+8pEEf5TQwaaS6dh+l2liO6HznzQxocGlaBjl?=
 =?iso-8859-1?Q?LKJu6ZceC6Y+yTV+Ja7f0odaBXkZqpRkCMPaV9dbfUMOGhhzsG4OqTnw7H?=
 =?iso-8859-1?Q?nGb3I6BaRGJRipqdzZAPMWYEpv4+cVstsNvcQDHh5wS/3BX/CgmACtkSeH?=
 =?iso-8859-1?Q?HWzY5qs8h2qeo9Rd7VucQpQnF5MQYBSqF45wquW0/EW45DsEUFXc9jeTgq?=
 =?iso-8859-1?Q?Bqz6K1Cex/XwKZFIUdGuRTjxaDkCX7fP/3ws81Xb8mLLmwz8PxT1sJrvQk?=
 =?iso-8859-1?Q?BpaP1/kV4unAzd3mmgA3xRvTATk9X2LTmofT9oqGhJfl0czoGh66gAKZy0?=
 =?iso-8859-1?Q?WW0Jca04qaHfTFQOy2Qn26lBBow/YM3O9PYUidJmHK+7IMyUXCwieqTxUY?=
 =?iso-8859-1?Q?L52zHbcNi/5DnQk3n/aFv+oSn5iMru4qpJA5hKhJeqvlivoKbqHBr1VUCU?=
 =?iso-8859-1?Q?gjLgQuQGOxl+4SPm3Q0SicUegR81v1wF3ds+uwB+8RbU3yysAT0TryuhfI?=
 =?iso-8859-1?Q?PBk6Br6qveePYxjM9Awn6YpkxRCfxG+InhdsOiP2wv3XnQ1ClYSgqkOx2/?=
 =?iso-8859-1?Q?BjxFMNb7sh7654oCGobdWCRDgkzahN+R3YYIUxhfa55QpY2JrMrbT+8yi8?=
 =?iso-8859-1?Q?lZLrutZUDo5GdC7K6fhp6N4nGPVgbqyYxFEx34en6fzwAZInhH4kysoEv/?=
 =?iso-8859-1?Q?gXASdP7v1G3lSy9G1930lkMxQLC1SZpZQCeF30B+aF3UVhzdDn7hyOa6BM?=
 =?iso-8859-1?Q?zlOqk7JLGnA1SK8qkKa7/Xu6CU5fA8nBi6ALDv/1jr+rwNDP+ATg6B8NcN?=
 =?iso-8859-1?Q?iEF7eURl4mKBPgOEKzb0GuPB4sogTXt+dA+dSSvc1m2XuJzVSmibOzp997?=
 =?iso-8859-1?Q?wsC1suIVS8cdlPsLMDnJTYBkOBugQK15W0jhboiz39z5SarZ/ePUW2Jlrc?=
 =?iso-8859-1?Q?4a8TreuziQuJIz7RsauK5myyQOE3rBUV2ZQ4AOWAiUvrjTPI6ZDWHavpcx?=
 =?iso-8859-1?Q?qSelHI4ZZh2AX/9Zvt/ZBKywk+6U9PjQzRFEaBB+LFH3KBABKIWqQ26k8N?=
 =?iso-8859-1?Q?01BzAgICzEzVkRL58HtHeiE1hullBrJFn+R8RoDA9ZiBzejPNeEDiWlbTc?=
 =?iso-8859-1?Q?NCPmA26mQan1+iF5tdeoe8kBudchG7QgK/o7qPyOUlC/BSpdXGruvNZKQ3?=
 =?iso-8859-1?Q?XXo18LPbYGdmTBA/1RNRDSkhquPAjBzT+W829OS70BPUeI9fiUGmK4fi1g?=
 =?iso-8859-1?Q?/dWLL46mmdurwUhRB1HsnLfi3sil51rPNgTePQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB1178.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?wsRYyI+kSAbptGdgVSbryfdzEVd4/v9P5RQkQ/nzeJXbQNmjG7ob1lfdKP?=
 =?iso-8859-1?Q?jV+0Qkkpss+TORc7fDYuMChtFAOECjK1hgj2UB50DaowLaj89nfNvXiNlQ?=
 =?iso-8859-1?Q?9QN8H6UpkUhDkvUasxsLxaiDGbEwKe39+X0B0BZXVEiDVPJe93KWcbzfK+?=
 =?iso-8859-1?Q?s8+Nnbc1A7rEnIRA0kwuF9UToHEoUFxcLb0VYJ6jYiyAT8RYLIqnQPpYyU?=
 =?iso-8859-1?Q?huLk8JT3btE+hgUeNV6/HvdtIy3VNEjn8uNXqxBd6CJAIkh7IPbaO5t5Ij?=
 =?iso-8859-1?Q?rp2AFL15rzPhoE9ayz4XpJD0BVYNK1Yw4cFuawbP127k6rkUJqmEAo+T8L?=
 =?iso-8859-1?Q?IuMixOGwS6PE5xb0w8zEhCd9lXgNuoQ7KnWwpIR3zyVscjyh5nmteNyPer?=
 =?iso-8859-1?Q?BiqsSPknzGRe2bWLfMUSewu4m56cOxVOfFNL/OwxvoR6e2Xq7bBjJXQ1Vq?=
 =?iso-8859-1?Q?hCK41fTNIF3ijGoghv46H7lVKxfseKzcFEFQH76ijN2Kk06tx0jgURUa1L?=
 =?iso-8859-1?Q?EUjrP29FPkRaPfBDILbtcWmux830Z2XmJmbWENR43hfJXtomr/+sKSHCTM?=
 =?iso-8859-1?Q?JnT3qt3CS91M6+XgACl95S4iEurm/FMN2hPb934p0mijFjcj8oNcQl+95E?=
 =?iso-8859-1?Q?2C4irFYzY0LEx2VrxnDPTUL+SQownPzCg7UA7NAyw+n9bqhyL4G1s7Xb/9?=
 =?iso-8859-1?Q?KC7cN43UbTJtyT64OGcuhCFjY7HAR5V4CudJuVTru8bB92pg6WL3u7RHNF?=
 =?iso-8859-1?Q?YmDzp6b9ti3q2tLzb1bIDXQl2nDWUX5kFku+2M+10aGcrH3sfednD+oewG?=
 =?iso-8859-1?Q?5iC9la2b/WNWhB93wN8109QonTfQupeA1Ul2+5HA1j3/h3jLiQPGZuAU61?=
 =?iso-8859-1?Q?NTLrV7u6y2Csu6aGZXeDcmdgE+fxJLcTmULG5Tmek/Ih8F5ymaAByBigxa?=
 =?iso-8859-1?Q?pqck5MHFpKy+1aZKavNMwifYu6Z3ZSPDomyKUHgKXI9jMNwLgAE3VkvqXG?=
 =?iso-8859-1?Q?wRPkDc5+VSjYBMa9+Z2Ha/2XO9Btio7c3MVq2BYWdsg9WNbLnv4dtYignX?=
 =?iso-8859-1?Q?N51d+ujuIJkyyUl93W1shorrW+mR+khi3Spf80+6Zr+5ehL3S3dbgGYKLi?=
 =?iso-8859-1?Q?ySpAcG14niQ4Qy/yqB60IxIieme/joWCTuN4PpxRRgfusTXtONKdWiU/5L?=
 =?iso-8859-1?Q?PSjP/JjQauOW9b05jNY1XX6KOC4G8MFpVOCrruD74IVYcNqZ1Gu1erS5KN?=
 =?iso-8859-1?Q?4uNwI44p5ibKGraUKPSuX0iaS1+ooXZ/pzrDPAoZCawn+EUbW0fgJoQG2k?=
 =?iso-8859-1?Q?SL7yCFDZalrrxDoVndqUPInzJa1yCBFbBXMusBQmC9SDU7R9ytAvKIDkLN?=
 =?iso-8859-1?Q?UPwd4d8TyP7NW3bpl2lw3kGJdb3CbtNfpCT6Ex1k/ZK1VAue+e0vgCCz8R?=
 =?iso-8859-1?Q?ZzrrV6Z3RGGCFncqYDHCvr0z9YAVmxvu634/9N3UR/VY6MEgAB9W2EdK6R?=
 =?iso-8859-1?Q?p+AtUYSWKJcdeSmfdYFl7wdT6a29gCnrXwZO7HxUxW1vSi6JTbKnFWH0gH?=
 =?iso-8859-1?Q?NGMKNs76RdwoDGKXWFB1zMf8H+W812YgryQwHz5maRx1iWMyg5+Fy5v8wQ?=
 =?iso-8859-1?Q?x/2H2zjofGXuw5C1rWoFd6Xqr1yyOJqVhgA/CnxV0yDjdbR/QbteLaMw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d2f44c71-76c0-4be0-3bf7-08dd0f887d5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2024 08:41:44.9384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tl17K51V0aQmlCJ+zvxlTB5rh7K30Q+eYMmamR589SzEzuQkE2YjH6C39HL3J2V0XgHXNo505vISiuh7606hjUk5lYWKAwixCPlVjocxB34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN1P287MB3631

Hi Krzysztof,=0A=
 =0A=
Thank you for your review.=0A=
 =0A=
> On 27/11/2024 16:19, Bhavin Sharma wrote:=0A=
> > +=0A=
> > +allOf:=0A=
> > +  - $ref: power-supply.yaml#=0A=
> > +=0A=
> > +properties:=0A=
> > +  compatible:=0A=
> > +    enum:=0A=
> > +      - st,stc3117=0A=
> > +=0A=
> > +  reg:=0A=
> > +    maxItems: 1=0A=
>=0A=
> I asked you some questions on v2, then on v3 and no responses.=0A=
 =0A=
I sincerely apologize for not addressing your questions in versions 2 and 3=
 =0A=
of the patch.=0A=
 =0A=
Regarding the battery configuration, we need the following information:=0A=
- Battery capacity=0A=
- Battery impedance=0A=
- OCV curve=0A=
- Minimum and maximum voltage=0A=
- Current sense register=0A=
 =0A=
Currently, I have set the battery capacity and impedance directly in the =
=0A=
driver as default values. However, I understand these should ideally be =0A=
defined in the device tree source (DTS). I will update the DTS accordingly=
=0A=
to include these parameters.=0A=
 =0A=
Additionally, since the OCV curve, minimum/maximum voltage, and sense=0A=
register values are fixed, I would like your opinion on whether these shoul=
d=0A=
also be defined in the DTS or if it is acceptable to keep them in the drive=
r itself.=0A=
 =0A=
Once again, I apologize for the oversight and thank you for your understand=
ing.=0A=
 =0A=
Best regards,=0A=
Bhavin=0A=
________________________________________=0A=
From:=A0Krzysztof Kozlowski <krzk@kernel.org>=0A=
Sent:=A0Wednesday, November 27, 2024 11:52 PM=0A=
To:=A0Bhavin Sharma <bhavin.sharma@siliconsignals.io>; sre@kernel.org <sre@=
kernel.org>; krzk+dt@kernel.org <krzk+dt@kernel.org>; robh@kernel.org <robh=
@kernel.org>; conor+dt@kernel.org <conor+dt@kernel.org>=0A=
Cc:=A0Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>; linux-pm=
@vger.kernel.org <linux-pm@vger.kernel.org>; devicetree@vger.kernel.org <de=
vicetree@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.=
kernel.org>=0A=
Subject:=A0Re: [PATCH v4 1/2] dt-bindings: power: supply: Add STC3117 Fuel =
Gauge=0A=
=A0=0A=
CAUTION: This email originated from outside the organization. Do not click =
links or open attachments unless you recognize the sender and know the cont=
ent is safe.=0A=
=0A=
On 27/11/2024 16:19, Bhavin Sharma wrote:=0A=
> +=0A=
> +allOf:=0A=
> +=A0 - $ref: power-supply.yaml#=0A=
> +=0A=
> +properties:=0A=
> +=A0 compatible:=0A=
> +=A0=A0=A0 enum:=0A=
> +=A0=A0=A0=A0=A0 - st,stc3117=0A=
> +=0A=
> +=A0 reg:=0A=
> +=A0=A0=A0 maxItems: 1=0A=
=0A=
I asked you some questions on v2, then on v3 and no responses.=0A=
=0A=
You implemented some changes but still did not answer my question. I am=0A=
not going to ask again, obviously expecting different result on the same=0A=
makes little sense.=0A=
=0A=
No ack from me.=0A=
=0A=
Best regards,=0A=
Krzysztof=

