Return-Path: <linux-pm+bounces-24020-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEB8A60EDD
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 11:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC0213B2F0E
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 10:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18791F4261;
	Fri, 14 Mar 2025 10:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SRH5sI0v"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1FD1F2B8E;
	Fri, 14 Mar 2025 10:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741948146; cv=fail; b=QZi8MqV2eR9lXZSimNf5i/ngZRmkNOUi7k5J0Hju00faQEgmj/LFD1GC5GWxYfzC5XgZqPklozenbVY/yobTFkRsGTqyoGwVEhQPipsw3io7f/8HDkZbrMXy+BJSOxaL/c9Jm58KnrH2+N7EypspvHNK0CKl2H6+Tcb0sLcV5C8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741948146; c=relaxed/simple;
	bh=nWgj1Djh5oVGiHM2nT92zyKoliBiU3ZIlinZxdLWGNw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rwa+R5cB0GokTiUCf6EFXCch4fzaV8qEFYpSJV2HLROUrAI188+SHphqHLw2hMoIEoi58cuoMSVKquBU71CxklCxlVkbGRpClHA53gs0aHUV1CWB9kdnV6F2BPIu+QavI+TJNnSB4NMwGXIjUWA8UC8SUMff134RbUBf8G2zQQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SRH5sI0v; arc=fail smtp.client-ip=40.107.22.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F1utDJJgOsF64FKnwrJbzFsN8Yak2QxbRvCuiNk1SMgpVZjFDtk9g+sQ+W6RjYxM1StPV21kxStsEbNLwFzYlUidAUBoTpZdLn0IiWb1XSy6zx1D+iOuzfOTE/8XxPIQbEiQ1zozd27N8c2mKR8569yAEqZIhAoVt0LYWo/0h8PFlUPAhOyltXOBiSUnHtThiUdll80923w9RVfmglgTVcAFNsitrYbA/9gwbhfAa03lB/70hRyQ/1XRAGjZfm4NM8uxmr2P/ROyHIsPzA35h7LC+dOUyVEDYRvF8wAuKTtoIVQG78UrS7BeDFsgjZnP3snSDIWdziAO1BZHA7GX9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWgj1Djh5oVGiHM2nT92zyKoliBiU3ZIlinZxdLWGNw=;
 b=NNbQnRNJ7zGaWJSceaFjFh0PqCkn8f4mSdQ3lxskrqSgLCk8mPlYaheQ9o5jYkULT9jc4+s6HdOEYKKVILA9cdGEikmEAmSP6GmZSDA7gnaTDkUnG4u5pqmHbO2UzIglfVOjEX3UPneC4FxDFjiThnhXul/UaUCifh8HS7HB5aEWA9+M1Zcr5vnLB68b88DEdf7sirC8Dl+EZuu8f2ZuwKKKKShxPqGoafVpHuaLuNL0N00qRYjMJt2B9Go35LIFNElmU6r+vtbs1XPfIG7dj4bX6q1CXlNE0IhdyuLGTUZbozMXXSRRVOxs2Pv6PcSjHhDmr123AauRliqZV0ttNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWgj1Djh5oVGiHM2nT92zyKoliBiU3ZIlinZxdLWGNw=;
 b=SRH5sI0vU35QEiXpgELMIVRaofbmzbGB6LNw4BFH4Ubf0w6ZfMYBJkQSzfOHDhfu2+ztL6ZCiSQ060p/TsZzAXpjzoNS9bPXT0YOV11kCKqJCSL3BdTNwVaWP1fnqhty8Nqk5KSk0O/+Pqgxj4PS90d8sNlORiMFZwEw+6ING5yciR6sLZsdxQHka56o3V8w98tfJ8tf4WscZDskDravQMSm5ku66lQyiRSwVjNHq8rYyq0VDdGyXbYtlSz35vlHvYxA4PorS14rpar7e1E569VtLWJDXTeBfR6HnXaEnwLmQ+80aVAnbKNnYYCATeOg+35dpRZM9QBcuulZKsjGyQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8454.eurprd04.prod.outlook.com (2603:10a6:20b:412::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.27; Fri, 14 Mar
 2025 10:29:01 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8534.025; Fri, 14 Mar 2025
 10:29:01 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Cristian Marussi <cristian.marussi@arm.com>, Ranjani Vaidyanathan
	<ranjani.vaidyanathan@nxp.com>
Subject: RE: [PATCH] pmdomain: arm: scmi_pm_domain: Remove redundant state
 verification
Thread-Topic: [PATCH] pmdomain: arm: scmi_pm_domain: Remove redundant state
 verification
Thread-Index: AQHblMe4GnkknwhmmUSVPD82/DKJm7Nybh2g
Date: Fri, 14 Mar 2025 10:29:00 +0000
Message-ID:
 <PAXPR04MB8459F43DF554C008CD97FF3488D22@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250314095851.443979-1-sudeep.holla@arm.com>
In-Reply-To: <20250314095851.443979-1-sudeep.holla@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AM9PR04MB8454:EE_
x-ms-office365-filtering-correlation-id: 5d17884c-a90e-45ce-1686-08dd62e3094f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?4+QwD29+4XNwtswNen3d+tn2MfXdGtne1rgWaKqBEY07ZHg8pD81snvxp3pA?=
 =?us-ascii?Q?ulPIkzuAAbo6MJxuAcU9bVziJ6zLaFQpt0tMpF7wifRygpQMVnVxVYbCHITm?=
 =?us-ascii?Q?fWUUHVQ2S39ltPyOZYwP7iXdmf9jNJ4hx/UE38ZCRFp7Y6GEwNTNpxrBcT9q?=
 =?us-ascii?Q?gjXIjgsgn4HHXy7OUqb8kl1fAnfslJ4Hqo7FP3XN5m33SD33zV+CgqsARL+4?=
 =?us-ascii?Q?qZkRBLx04ji8yI15xZn4bYNsnnChNaLA+Jc805qOr8Sjf3IvfK1zRHsmnrol?=
 =?us-ascii?Q?Ev6RI1egiMPEyKXRUKSBAA6KXTzLUpRPMEL908AxzxYECWbL2+JzGV1622UI?=
 =?us-ascii?Q?6FyPByTfwaqE1vJ1I9pRM7VQEAODXx7maK0xoa849MgCLNjmUI7wBOWKnIj4?=
 =?us-ascii?Q?C1VR7Haa0hLzzpl75gA6Qu6pnFIvT4KgS9XApHaEWVwdDrtj4x7+enSiiVfo?=
 =?us-ascii?Q?O/2rBnjVhBjAy0IOo64o1cMZEhRm9b4aS1J4QN0ekDEmSESukjNBmsxCvRr9?=
 =?us-ascii?Q?dL/FUmjOjOjlCwRVD8xo8YXbESoP+6dLKGmhP2E17kbycIh/Hu+xOmwc8sBo?=
 =?us-ascii?Q?jH/iHy9H2bZy2jdfS81S+dHXcIHdk+mTJ5MMobPQ+a7ap+qpbMtcKU5caatZ?=
 =?us-ascii?Q?Kmoesc8Mdzv6MCYVOb/2jWrhEfPcFNfcJ+/Tnzjhn+v/iRlN8Lih5DUd0Xjf?=
 =?us-ascii?Q?UZfqsOsaued8YDOrqomqg8O0DS+4g3saQjCJNWf9pM8KH32NlKbWaogRFh4I?=
 =?us-ascii?Q?rrdAwINcr33v6QN3B12zmcWgQ/YvSYwk00g62PLJn1ufpbU7lmNqYTkqwDX2?=
 =?us-ascii?Q?bTC4WCw9apGjhkPdTyEs7PrMQXYYCpBYAKF1WVS5zkZMWLbQojZPyiae3jfu?=
 =?us-ascii?Q?aCN9Kx6OQrnr8hs77fhkinY39dlqVocgnu9o82hNLxycDGDB6BiPKi0XU24p?=
 =?us-ascii?Q?q8wPFRPXmDtcnlHsVVFbbAXENjTwuxYPOiAXM50LCNIypxwC2bdpmflb2+dg?=
 =?us-ascii?Q?qWSzOinHlch7yCKgiukLv8Vik4vbyIRldDaALSDZb//6y+3e6ZZFaKFop2iA?=
 =?us-ascii?Q?So7iaQsJXwBBdn6DLA3GKYI3UcTzkLJdNiAPGd4rMOOb48PQqL7+ws2soA3M?=
 =?us-ascii?Q?b6SANmR88aBYxtGRiV+8761MR43QNK8NgzF3SRMk6Q1qL15jsD5shsrymmAz?=
 =?us-ascii?Q?grxhDl6A7Pcs1JUKIklzM38cbn+v8H09pA36sX3gnggS51dGXfH0GyounCVV?=
 =?us-ascii?Q?4d0dOCT02TDmkVYhRIkMvAOuIFguEqG/Fk1BobGraH4/932Rro13yxc4T4As?=
 =?us-ascii?Q?Sbvxg0H3QQBsfzCqAP2zGxK5XsrI1q8oVIEu6r1nS3aLj3mqw64nk801eeh2?=
 =?us-ascii?Q?/EacwvBgPeYlbivlrcqI9Mz4/qnxNQtZMLPffP2qhBnDSeElhwZux8jUwjOP?=
 =?us-ascii?Q?Spfn/61j+irNht//CfieajmLjFmNHgnj?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?52sbSrraoICQDJWNmKF+S+7lZKJp2kq30Be0e9wsshH+w889GF7tecm43Bv8?=
 =?us-ascii?Q?lR5SldtS/vxxMQu2nIO76wN171kto9sa/8BozRXM1TppqiwCSkAaxkrNYV8I?=
 =?us-ascii?Q?4Jfs0p+/+0jep5fcBfCKfpaskLCGPRsrgWnAgernSFQ5o+quebo84KAADw2v?=
 =?us-ascii?Q?pHtN09YpKRy3A7WfxyCFSt2Z5bYCmoXUaUEUgfW+zXnlxT0WT8L67xS0ESE1?=
 =?us-ascii?Q?nHq3OkIyxA2ItM9KPUkizlZdAYPYurxqeyWbMEYp/sIwkUfO/fEajQ4cGpWN?=
 =?us-ascii?Q?drqELkUhEhvPUlM23OC7ysL9mBgzHk/GY0UZ6wRNPq3cq1JOmFCuLk7mle6W?=
 =?us-ascii?Q?5iWrlfQeZpUy46kBE2yBokNv+NOpCMRRlfwSB1hMW4iG2FP9moyvIOjrZuDk?=
 =?us-ascii?Q?HuG44SaakqWXlbuiVWxlTrrqAoZQZ4RjAThcQHlCUj0ej+MyC570k6DoAd1P?=
 =?us-ascii?Q?ofQIgl9/lBmM4jxnJ4rMhnMGTWC3b5w3JW4uT1vKLJbMAUnKgF4w0ELdh8oN?=
 =?us-ascii?Q?0OdkJ3IxX31Dv2QholBftL5PFDgzijHVyc2rsu8+w6+b105xCaN5dirXWsIQ?=
 =?us-ascii?Q?SMv2XVRFCZ6DOjOiVt2Op8wqHGPNf3H1NJa58d3OItOEqxNitk089uGYas0X?=
 =?us-ascii?Q?/wNbThb9tJGHy2eHxBvhgwa6A46oq/vvYln3DLWBFTkIPRUSwLCZZnjf7kGj?=
 =?us-ascii?Q?4eRCVVAPqKlkMtQvcphDVfahTuGrBkZjRXzazab4XKYMPHZ2n9FjMxsjpOrr?=
 =?us-ascii?Q?GEoZXOT5cRXqcg/rsAcMbxrJE8maKRvqth3Bct4EFDB+XDr2hkJpSOt4bBVI?=
 =?us-ascii?Q?C3IDm7zXZdD7Fpeq48YlHlABIrxTRWZ7UG/wCT3hNCcOtR42F+u6mJIeoXO8?=
 =?us-ascii?Q?L9aIDiDHu74ieYZiCDDc7x5co+02e2UxSAzDudhmtHH315l9+X4a3xLLVbkZ?=
 =?us-ascii?Q?+sCkVAm0Z4IA/FyIYfKwxpypl6M9eYobkeH5PeJf0EHc9tf9Qn431C1JpCRj?=
 =?us-ascii?Q?2nYvqVfYwVYWWqWyGIrShifrSethftdZkwFycN24oHL1cFUsyoqRbUrnXJ24?=
 =?us-ascii?Q?2lMndmVkOFRyS8LlhtddnGEKLWMzr2KWoppdkE2dsyHrFbsTRB+VmTZpDthH?=
 =?us-ascii?Q?Ecc/NPZMj2vsblpnB5RaVcgjfRHYTe/AO/oJLhVuaYeRVFAEZ+xJGp7eyVfk?=
 =?us-ascii?Q?A02KQDxsEkXPR6E0LUQjC31issFg3rNcwbFhM5X0oFi/9ObGhhNju0LCamyt?=
 =?us-ascii?Q?C2VO9lCVlZMMRDI0mKLnNLQOZq3syAdtAsNV1m4Qy/YCaje+aMqEhMEPgnxi?=
 =?us-ascii?Q?n7C0U9qDpgkdSlKyuzEuQRYRqFmvCOY271JkikhTwGM5OYIfTBWc49jP24qv?=
 =?us-ascii?Q?AVAacou1P+Jj/BYOPIv31rtROoGIkwsip3HIWu5yiJjm44VaqPdqPIMeQliU?=
 =?us-ascii?Q?1IvDVWd7uu2vMcVOM18P9cUZArJkImIJ8kk5Wl8ke//s6Ga/b+wYsqDjRDVX?=
 =?us-ascii?Q?+454bE3KC3m06jLRfcPyTDhjB81MlD4B5LGNYls22pNYDBd96A//N6eEa/WD?=
 =?us-ascii?Q?le5lyu8gkuAGDYXILPQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d17884c-a90e-45ce-1686-08dd62e3094f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2025 10:29:00.9438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PDYbmc0qKwTYLQxCBWOoiYcMBq6zsV5Vsanzc9Bb9rXma88ttianCegs20axgWkNWqQ5awN9gK97HKVeIlNHmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8454

> Subject: [PATCH] pmdomain: arm: scmi_pm_domain: Remove
> redundant state verification
>=20
> Currently, scmi_pd_power() explicitly verifies whether the requested
> power state was applied by calling state_get(). While this check could
> detect failures where the state was not properly updated, ensuring
> correctness is the responsibility of the SCMI firmware.
>=20
> Removing this redundant state_get() call eliminates an unnecessary
> round-trip to the firmware, improving efficiency. Any mismatches
> between the requested and actual states should be handled by the
> SCMI firmware, which must return a failure if state_set() is unsuccessful=
.
>=20
> Additionally, in some cases, checking the state after powering off a
> domain may be unreliable or unsafe, depending on the firmware
> implementation.
>=20
> This patch removes the redundant verification, simplifying the function
> without compromising correctness.
>=20
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Cristian Marussi <cristian.marussi@arm.com>
> Reported-and-tested-by: Ranjani Vaidyanathan
> <ranjani.vaidyanathan@nxp.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---

Reviewed-by: Peng Fan <peng.fan@nxp.com>

