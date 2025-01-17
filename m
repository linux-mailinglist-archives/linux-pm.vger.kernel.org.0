Return-Path: <linux-pm+bounces-20589-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4830A14780
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 02:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12BE63AA2AD
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 01:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A564618B03;
	Fri, 17 Jan 2025 01:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QrvlXRzr"
X-Original-To: linux-pm@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011000.outbound.protection.outlook.com [52.101.65.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C071F957;
	Fri, 17 Jan 2025 01:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737076960; cv=fail; b=UHG+YXs4JV9FkIIlgFmoELTU5EYO3H3BXb9NaK2MoOE2xVh0lecFu9X+zeYhWT59cLgIPJmXnQU6EMUPWuVR1FJvxNkIcOwausTYsq7p7oQp2yPGe4nGLpRtyE+8OldtX3vt8x4NI/dvDCSPvo/vwAztR/HmtSzksUVOhqN1p9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737076960; c=relaxed/simple;
	bh=yVQFJC00s6icS4I8EfSKquneUxMqcUuLbTukDAMipEQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I8KN02xcTTWV0N16nFLNOl4/KYBbql3yQjiGyuREOEjom3ad6UpA+x1s17WoBrKnu58ICQEV2lhmLh1VHFtlgStXscIEsCWlp03z5qdc6SihX7u9tvxSQVUTtHytLNYr63LS8epsU2Tl2yFLhf8E6bxDjlFFu9Uj4AUVVaMYcsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QrvlXRzr; arc=fail smtp.client-ip=52.101.65.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fslgZs1LFEWtW0XFO47B15ZDpHBmWYFz+rX1X07Zzm+gYHi/1IbTp7lG8RaGKaNwTgeR1+TJIxhwqEmofJ0L+VF9Ledn+ysKPBwUxRCaUjtqwSANy7jYipAa5goY2AE3hZAX7ChOIT+g4TIPKKiiBQ5VPDSPyfsYAPspWKe7KxkhjG8o1a5MyrAvnlDfIIVXJFYS/WVo1viIKqZQMtApL6avh7jT5ytz1FXyxaVm/pkbOZKSdlAFpgnEwDTwnnzFiJU2ngd8mbIE/F1kt1fQloUub5Ej8fDGg2XesCrsIIQujBhfp+xVIMsEbVxBbfb7ZTMFeFafYr+sXUyjOulSrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vz9GPEy5qE3nVcHJwYbF8UoBRO+4CTUgGX0dFJtwQUM=;
 b=AnxcLKIxL0VedxUvz44YddrysKjuGu7OKNqLPG1knRavLeDVDPNbg7vp+B2aLylNlGBEzLb+Z4GG279PMVgjdjKOTy2cFAHwRjp04MQQVIxwxO7tlw2/MKSaerDx+LrNOGXfLlvhbvc+jif5sOkHt9zi9hvKjHaiEPlwbitIhFTfQpvNIT72ADp0/gJekg2aw0TBAZgTru1ReouDm0Ab5++9YlBJ7G0rmGzC+WP7I3Oij3DEB6YyolGknWZgkIVSZST/AASDgE+RqAnRQBsptaDB4E08BAjggyEa/KF4ig1MOEIEZkPQ7BnztC56UgSROWIzkZEyM/8YjiAml3M6tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vz9GPEy5qE3nVcHJwYbF8UoBRO+4CTUgGX0dFJtwQUM=;
 b=QrvlXRzrsAixvLsveQfFKFmQ6j8laQPs5zVG+FWOg87rvb0OrOUKZjEeyADBs3sxfn7fYG3f2Z8L5yUBtOjP+J31G3wOfdJRatNVzqpHNko+zt1yTMKhsY5jvra48oApHn02CFVGroRgX3ouNVmt4aA0OdgUwHZ/y8mA+TIMo5+hx+h0ZfkjI17Y/ZzrBWCTGmpFJ+oFxVIb+XeDPQR9ngfwrvT4PG3j0ZP37jKDOnbhANeCQKCbRsp794euM9PKiPFVQk+H1uy2zI7Ww26cpzptblQTg0d/Ej8EG2qWS7CB+DXfIa/XO+yqaDv8CHriWxu1WjEUhuY2qk2kclknKQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8675.eurprd04.prod.outlook.com (2603:10a6:20b:42a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Fri, 17 Jan
 2025 01:22:34 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 01:22:34 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>, Ranjani Vaidyanathan
	<ranjani.vaidyanathan@nxp.com>
CC: Sudeep Holla <sudeep.holla@arm.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH] pmdomain: arm: scmi_pm_domain: Initialize state
 as off
Thread-Topic: [EXT] Re: [PATCH] pmdomain: arm: scmi_pm_domain: Initialize
 state as off
Thread-Index:
 AQHbYybo8rOmeh/en0qIMyX2XTiTxLMUhkWAgAARnlCAACWpAIAAHG8AgAAepACAACrhAIABRt+AgAAMoYCAAR6lAIAAnpYAgAFqFQCAAJa0MA==
Date: Fri, 17 Jan 2025 01:22:33 +0000
Message-ID:
 <PAXPR04MB84592FD305C1B0B29B526E7C881B2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <Z4TreQ5bA9qiMTgC@bogus>
 <PAXPR04MB8459F33BCC84CCA8F49F3B60881F2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <Z4UZ2Au7KSFMibDW@bogus>
 <PA4PR04MB94855052830C8F4874237BA6921F2@PA4PR04MB9485.eurprd04.prod.outlook.com>
 <Z4VLZgAWR7ugDl7W@bogus>
 <PA4PR04MB9485E9C126E48A088D7E399B921F2@PA4PR04MB9485.eurprd04.prod.outlook.com>
 <Z4aBkezSWOPCXcUh@bogus>
 <PA4PR04MB9485507CCC21354B5ED55C3792182@PA4PR04MB9485.eurprd04.prod.outlook.com>
 <Z4d8nrJy-h9EwzsJ@pluto>
 <PA4PR04MB9485CC9D9925BB5D23EA629092192@PA4PR04MB9485.eurprd04.prod.outlook.com>
 <Z4kxYvR9XxldCpk-@pluto>
In-Reply-To: <Z4kxYvR9XxldCpk-@pluto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS8PR04MB8675:EE_
x-ms-office365-filtering-correlation-id: f2e0ee2c-26d0-42ba-0f4f-08dd36956b97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1URtf66tcb50MojO+KcZ0qUVlYF8ClR2T33AQkQWcnXKUmJ7wU43tzJBitPY?=
 =?us-ascii?Q?ivrGNnYinDk8/EV0PQxEEnRsGdmy+O/RWW7vRu+olPtcMt4b0BLwEMfXB6vY?=
 =?us-ascii?Q?eek5cO4NMNjXKxDWjGHvRkggLNDnYaAimZrw/MaR05U8SSqIY65AbmqCBOzp?=
 =?us-ascii?Q?I3qBGq13iwdJD5E9i3avOpfLtOddo4nx8pofOYPtwLybFABVPzXzPUk6Np06?=
 =?us-ascii?Q?a5tjP8FZmBK823c5O6aHU0NN4EL0dkNSeEoz7jpJiP9ArhDKE7DRQbihmp45?=
 =?us-ascii?Q?DP51hNqO3FKFxuqLhwi30wStdmSDzPXrV0WqY6hd11DgnEfvmEvTJ61TTPuO?=
 =?us-ascii?Q?8gv09qAwuLtb/C6rXG8Srgn4axAynDIhr/bV8MB33uIh1lVRdEZlHSRVwJwM?=
 =?us-ascii?Q?3grrFFz7O4dVO+gjwOosWSd2UAKXwnM7gkf5RPwGejh7hdCtqMP/wCpgMUOe?=
 =?us-ascii?Q?mSPidemeV6j6ELrIg/VNTbsHoZvfJLlTIfQK0Yr55mpd0ls28RlE4cxa/Ba4?=
 =?us-ascii?Q?p9rMCQ1wnE6y12EGcfnI8WW0aiIVQoeOztSRVctUJHl4gl2cOvSrWKlXhMw2?=
 =?us-ascii?Q?DFtJHYdyvhkFsvUmPxvEEexQWUN51eyRHXVpiEL6Du4plyL5tLvVLHUQ0l/x?=
 =?us-ascii?Q?R9pZX2GfPyjQgtvCu3XUUkviTCZuyRExsS0hwn7nWXlZywF59nr8fT3Z02CM?=
 =?us-ascii?Q?yF5wGP6QVmmKjafid4bZqT3/FkSBcKe7QzJxKFrArZ42zW0LnPfWEIYiga0Q?=
 =?us-ascii?Q?RD3zW/9Napa8ExyHnK3xmav7F4dhgouHmBQGdzCDducNIO3h2XTXbKMKWn1m?=
 =?us-ascii?Q?RwIYlKCF6POyzTWEIJR3VPOYDypVstNoR5IKdo+GN93gzNrXAfz5GBYcntnt?=
 =?us-ascii?Q?ywWAF/VJKJ6oo2j2rprs7wsCCnVeqLvUHpgg3MLUxhKpHhWByWTLzUL2TUJ0?=
 =?us-ascii?Q?Jr+R+I0xBbK7JfJb+3nqv5wteVi3IbGN6Btle8E44GBwQ4xBotSpk/Iu7eIc?=
 =?us-ascii?Q?TBpHnL2FtLtKnlGfJn2Cea1JFrU1QLGqAssyLmhEUqhrptmHh+Qs3jx/42W0?=
 =?us-ascii?Q?ihkV0d1iN+8e/14uPO1EgmxtkA9vKs3EJJR0tWSpvP7/ssGo732cgkn1F+OF?=
 =?us-ascii?Q?1pFWnHWExa15uVtT6XWIxwINIRijUmJNlS47Wajzbo9rhNOcYode3pb60HTF?=
 =?us-ascii?Q?ZzKmTtIorU2NKCwQXNFU3rzq0RyxzjCBv1h9d7tF7iphjogE3sk/eb0uzgGy?=
 =?us-ascii?Q?mU1+psleHlxEjJ9Gf2BcRjaV1cUJlEXISq0PEeYS1UVqrOTjWE47UUQp68p+?=
 =?us-ascii?Q?ARZylIHf2gOh/077fcRMi5oRGrQNNdtVJv2nsruzFDgUp7nLyb5CZkV+wK3Z?=
 =?us-ascii?Q?KvIEe8WDdCAbv6+Vr9vRMDc4eRPgiQARk7iTesrJopTYLgwVVJ52ZKJgo2zN?=
 =?us-ascii?Q?REY2Z7QdNi9woV1qa31lztbRphKnsifZ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EOZuO3KmiieZbQrenxSoLdPIqvlMkBEqz9LfKao2/utWrqAYCArhIRMEXgwu?=
 =?us-ascii?Q?qXZx6BX42MO9oTCRPKgl3C+dw785cv2bq6BBZa/fd5glAX/pdMQMXW1/f120?=
 =?us-ascii?Q?6Xk5NdJtkdqLSM0sBDAxlqV4LZ06jmU6o9wOIo5uItnkw3MrBWzCTMkRpUeb?=
 =?us-ascii?Q?ZZTrkVOeBmSTkMWneGDpV5C/PVBtWkGnVmpHnJQD1JSb70WpFTZD+A9mspnP?=
 =?us-ascii?Q?fP7SV8P8pljed2J1ZS58oNtK11fPd6cUvlBMx0qbpKaRSlPPWG9w3QXMhAVr?=
 =?us-ascii?Q?qsiQaqvB4SO/ZuZVDdmykJWnTFSHm6wrUDDgW2FX/hNcTJtFAR/jMCkCUZfl?=
 =?us-ascii?Q?t36oUvm2364baB4CcaKiJFE+pddBE7H2DrhZ6iDeLSdrM8MLp31p1mXHWtjk?=
 =?us-ascii?Q?yIfs/XB/Bgc34dLHkxF2yMs/gDsKPukh+NIHJx/tTVYGX0ypLbw3N3hT6H+J?=
 =?us-ascii?Q?41qD8U/rahrd4ECpAHRyX2srahdAfEISkhRwGwdEt2gy68OYIsEMnHQ2gej/?=
 =?us-ascii?Q?iN5v9AcYkPf8BZ2iZxlyIyc8Sz+roIEqHMzuDmquo2nBD4Jz2kcqff0BhQ/9?=
 =?us-ascii?Q?VGem+HlRCyq+unsi5m8InIbULvM7a2txNTDhZA+A1UBlmF53Jau3juuA52fx?=
 =?us-ascii?Q?r99TWhlZ9JedrCBnSnDylkPSTrdAcQTGTTEkneBB7qZudxmPfbVXNpui6/Bd?=
 =?us-ascii?Q?cGiR6x+zPqtkqUtpEi12JdOV89qDP0zqEY4wEmHnnwOgu14m2QHHf09czXuJ?=
 =?us-ascii?Q?FUzqOLwbMIeQkdRDI+hCLR0cB5tofvE0ESV7M4JZ3jg6RzvRel6Zg1jtQoLI?=
 =?us-ascii?Q?uprNxnjk+HsQWkqzHVSa8tdWsfSIrUDL7iFuiu6K7NhN+9nHBxMIvThPeQl9?=
 =?us-ascii?Q?ACoIIWN5u4WTYVEVsSOApgCNbJWsZbFwrjAZqj4YoHE1o5jYrsViUC5LamUo?=
 =?us-ascii?Q?HZvqFmRMFYUTgwzNMqtKJUdJziMZZcy48NS0XUk6p1o4Ohww8hLYJdbPn7nF?=
 =?us-ascii?Q?SfBkCG7NbLbzaNjCInpVRotB+cKL6hY/Oh9DvOn28Y8wZDlnDJYOkoMoqT0f?=
 =?us-ascii?Q?T6AUnlLzS41VYAtGboJPVfmQ9hKCNScKb4StjHJptaTjbqnxHLfJ1BDO2OLa?=
 =?us-ascii?Q?Ev/LEq9LAm7cthdCCF9/s+p3Gq31SqvKe9TZkrGVMRu5Y90cYr2OJqtJcrBV?=
 =?us-ascii?Q?iAll+HSP6u0BK17qr+nnfmHZ1MIzuBsKjyij3vXnd4rxeGQHhTtIbq4Dvmqu?=
 =?us-ascii?Q?b5R0LWxwoQM2lJAAEMyi3PqRntDX4GW5mN5UC9Hwf1KGvZvYszuGdH8jiahC?=
 =?us-ascii?Q?s8FR3Eb3PqAyZ3XMRO+EprY8sVdnApYzpGC87YdY9QbdgiA27FEtexqlroYH?=
 =?us-ascii?Q?dmdeRdAbhQ11gOBqJALoLBSF3ZLUgw6zNKUfDhJwvbfY4eMQtS4cRx/EhQD4?=
 =?us-ascii?Q?bHc2zXjprJUQZOi8vALR5D6Dau3pRsy/2XgjEkazHivC2DhVhi2qtaW26M3F?=
 =?us-ascii?Q?7UDjEXgqchV6hsLDz6S/zIe/wqeaZRaN2n/OiBoTNFd2Pa+PeKwOtB9Q4WhX?=
 =?us-ascii?Q?qrShBQvT4kyCCWDBBBs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2e0ee2c-26d0-42ba-0f4f-08dd36956b97
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2025 01:22:33.9319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XPAyorikhBbjLdDIHfpM8umgKvq8LP4fXRj8IEDV0iyOe+nCkemPv2B3uaFAaZg2GSDnhXR+82vrJZ0Yla3iEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8675

> Subject: Re: [EXT] Re: [PATCH] pmdomain: arm: scmi_pm_domain:
> Initialize state as off
>=20
> On Wed, Jan 15, 2025 at 06:42:46PM +0000, Ranjani Vaidyanathan
> wrote:
> > Hi Cristian,
> >
> > Regards,
> > Ranjani Vaidyanathan
> >
> > -----Original Message-----
> > From: Cristian Marussi [mailto:cristian.marussi@arm.com]
> > Sent: Wednesday, January 15, 2025 3:15 AM
> > To: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>; Peng Fan
> <peng.fan@nxp.com>;
> > Peng Fan (OSS) <peng.fan@oss.nxp.com>; cristian.marussi@arm.com;
> > ulf.hansson@linaro.org; arm-scmi@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; linux-pm@vger.kernel.org;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [EXT] Re: [PATCH] pmdomain: arm: scmi_pm_domain:
> > Initialize state as off
> >
> > Caution: This is an external email. Please take care when clicking
> > links or opening attachments. When in doubt, report the message
> using
> > the 'Report this email' button
> >
> >
> > On Tue, Jan 14, 2025 at 04:09:13PM +0000, Ranjani Vaidyanathan
> wrote:
> > > Hello Sudeep,
> > >
> > > Comments below.
> > >
> > > Regards,
> > > Ranjani Vaidyanathan
> > >
> > > -----Original Message-----
> > > From: Sudeep Holla [mailto:sudeep.holla@arm.com]
> > > Sent: Tuesday, January 14, 2025 9:24 AM
> > > To: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
> > > Cc: Peng Fan <peng.fan@nxp.com>; Peng Fan (OSS)
> > > <peng.fan@oss.nxp.com>; cristian.marussi@arm.com; Sudeep
> Holla
> > > <sudeep.holla@arm.com>; ulf.hansson@linaro.org;
> > > arm-scmi@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > > linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
> > > Subject: Re: [EXT] Re: [PATCH] pmdomain: arm: scmi_pm_domain:
> > > Initialize state as off
> > >
> > > Caution: This is an external email. Please take care when clicking
> > > links or opening attachments. When in doubt, report the message
> > > using the 'Report this email' button
> > >
> > >
> > > Hi Ranjani,
> > >
> > > On Mon, Jan 13, 2025 at 07:54:06PM +0000, Ranjani Vaidyanathan
> wrote:
> > > > Hello Sudeep,
> > > >
> > > > Will try to explain the situation we are facing.
> > > > 1. We have multiple agents running, Agent-A is booted up first
> > > > before Linux is booted and powers up a shared power domain PD-
> X.
> > > > 2. Linux boots and gets the power state of PD-X. And its already
> ON.
> > > > And then PD -X is initialized with a default ON state.
> > > > 3. When the driver that needs PD-X  is probed, Linux sees that the
> > > > power domain status is ON and never makes an SCMI call to
> power up
> > > > the PD-X for Linux Agent.
> > > > 4. Agent-A now is shutdown/suspends. Linux will crash because
> the
> > > > platform disables PD-X because it has no other requests for PD-X.
> > > >
> > >
> > > Thanks for the detailed explanation. I understand the issue now.
> > >
> > > I would like to discuss if the below alternative approach works for
> you.
> > > We can debate the pros and cons. I see with the approach in this
> patch proposed by Peng we would avoid querying and setting genpd all
> together during the genpd initialisation which is good. But if there are
> any genpd left on by the platform or bootloader(same agent), it will
> not get turned off when Linux tries to turn off the unused genpds(IIRC
> this could be the reason for the current state of code). While your
> platform may find sending those commands unnecessary, there was
> some usecase where SCMI platform kept all resources ON by default
> for faster boot and expects OSPM to turn off unused resources. So we
> need to support both the cases. I hope my below patch should suffice.
> > >
> > > [RV] Linux can still make the call to disable unused power domains,
> even if it never explicitly made a request to power it on. The platform
> will aggregate the request from all agents and will power off the
> resource if no other agent has enabled it. From Linux point of view it
> has disabled all unused power domains.
> > > Your patch below may also work, but feels like a workaround to
> artificially (for lack of a better word) enable a resource. And also make=
s
> unnecessary SCMI calls (expensive) for every resource immaterial of it
> power state (maybe can be improved by a conditional check).
> > >
> >
> > ...sincerely, both of these solutions seem to me hacks/workarounds
> to counteract the fundamental issue that derives from having allowed
> (IMPDEF) to implement the get operations to return the real physical
> state of a resource instead of its virtual per-agent state as maintained
> by the platform, while, at the same time, having allowed to implement
> the set-operations to operate in a 'virtual-fashion'...
> >
> > ...so, when Peng's patch forcibly set the state to OFF on genpd init,
> you are indeed artificially forcing the kernel internal state to align wi=
th
> what would have been the virtual-per-agent state of the resource in
> your specific particular configuration....
> > [RV] Perhaps it's a hack. But at boot the state should look like OFF,
> the agent should explicitly request those it needs to be ON.
> >
>=20
> Yes it is what I am saying, it should see it OFF in this system config, a=
nd
> that would be the case on a platform that returns virtual per-agent
> states:
> forcing GENPD to see as it as off just mimics the same, but breaks other
> cases as I mentioned.
>=20
> > ...on the other side Sudeep's proposed patch tries really to play the
> same trick, just on the other way around, by instead forcibly/artificiall=
y
> aligning the state on the platform side by issuing a redundant ON
> request to bump the refcount and take hold of that resource from the
> Kernel agent point of view...
> >
> > ... but Peng's proposed patch will broke immediately the moment
> you have instead a system with an SCMI-capable bootloader that
> instead left the resource ON for the Kernel to inherit, since the kernel
> will now forcibly see this anyway as OFF, and so you wont be ever be
> able to switch that resource REALLY OFF in the future, if ever needed,
> because the bootloader/Kernel agent will never see it as ON in genPD,
> since, at least in the genPD case, AFAICS correct me if wrong, there is
> no callback to peek at the real state later on:
> > so, after the initialization value has been chosen at genpd_init time,
> genPd subsystem maintains the PD state on its own based on the
> issued ON/OFF genPD requests, so your forced-initial-OFF-state will be,
> in this specific alternative scenario, wrong and forever.
> > [
> > [RV] SCMI-capable bootloader and Linux should be the same logical
> machine (different agents). And the platform maintains the state per
> logical machine. So if Linux tries to power off a state that was left
> powered ON by the bootloader it should bbe able to.
>=20
> In the SCMI world there are agents, i.e. clients issuing requests to the
> platform AND the platform identifies such agents from the channel
> they speak from. Not sure what you mean by logical machine.
>=20
> In the case of an SCMI-aware bootloader like UBoot, that dies and
> relinquishes all the resources to the Kernel during the boot, that means
> that the Kernel should be configured to simply re-use the same SCMI
> channels as UBoot, so that it will be seen as the same agent
> (transparently) from the platform: in such a scenario the Kernel will
> transparently inherit all the per-agent current interrnal state...
>=20
> ...IOW if an SCMI/Uboot was holding res_X, the Kernel will result as
> holding the same res_X "by inheritance" from the platform point of
> view, since the Kernel would have assumed the role of the UBoot agent
> from the platfom point of view, since it is using the same channels as
> UBoot.
>=20
> Why you should consider Uboot a diffrent agent, if it runs in NS-world
> too and does not survive the Kernel boot ?

Per my understanding, Kernel itself should not count on bootloader
settings, kernel should try to configure all it could do as much as
possible, kernel is not aware what bootloader might be used or
what settings bootloader could set or run in what state.

Regards,
Peng.

>=20
> This, at least, is my understannding after bunch of past talk with ATG.
>=20
> And this is the scenario that I fear would fail with Peng's patch.
>=20
> Thanks,
> Cristian

