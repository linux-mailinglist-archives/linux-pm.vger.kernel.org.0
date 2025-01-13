Return-Path: <linux-pm+bounces-20380-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E82A0C1B0
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 20:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D93111888EF1
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 19:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635101C5F35;
	Mon, 13 Jan 2025 19:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gO5BXt8y"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2070.outbound.protection.outlook.com [40.107.104.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBA318CC1D;
	Mon, 13 Jan 2025 19:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736797249; cv=fail; b=SMjcTXEpzxCerjjUjdqxI8t8oZ8hhDb7codO/yUAc3u5OSINL7IDJjm+rTgw1adKKx/RXUH/STZ4WyIx0GMH44rvbGZvJcy6QEScrmAn1Vx4pzozqI0kuh8JMZuw8egu6j+RDC5thtFdavrGaQCEJKQ3VGuDNhN4s52ATv4cDVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736797249; c=relaxed/simple;
	bh=TCL7tR4TgphkTql69s20hDX/DeeSj5BiYqjTfxdetEc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XomTXeUZcQBom7pZIHiFItRoPpc2igO80k577Zn6OrTmCK6fvm2X2wR68Q3AKw3f8ZKHaSu0u6P4xC+VcYEqxDw8um7stssYUtzLMK8cS/vJStSQI2CIdMoc1NogiTBiNfEy5rIyAz0PesOe7ajkMBr7P4uz0cDfDtHSSmtpNWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gO5BXt8y; arc=fail smtp.client-ip=40.107.104.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=msByH9uL7jTdyEqaE+GB8SqQDaqAVNsD0F0aKhIzbm/f+dmzCJs2+WfM/UJccigeJyy4HdsB9W+qWIQHW6GdE/raIwqiaigRg7kUv8PfAg8xxUM09uc1g1VxUXQlhkr+3suw6zcd84TnnyuUZo7cPpLr5yDVY1SKHYc4fkVkaniC2Ri1gmAU3blwmwIFFAW77HLDFyinM2WW4tXe8rVKe/U5uljPPyNG0ciercEY4of8yv0w6buHrjud2slMV94HZGRicn6Iyhb5N7TQqwgM2Jm1yILafkhRf1/7Mrwchx0lnCseoK8CS0tgy6DWfEzNSpOlWciZ0ds5OXuOJO6Npw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVfS4XLX1tRQIStDSdyfX1+TGEzlXtJWFD+D16pefGE=;
 b=lbrfBERBohbVg154Ik/Z8JMoHhth+PmzHtA1jJqYwlNlTEqA4111A7UIk/FdKBiPtRxvRjqiC4SJDXG+WHndqEPYNNvZ2OO6FIhFxKmeFHcExH4Lzu3hy+2RbVnZK8NFV5roTNlyscVHQ9xWhiVP/3+IAuC3NqLyZOMxxiqITt/5/mmiRn3r2PJ05kw2V58DHIhJSw9NXQcJOkdXv/d4YnbDq97o2eMkt3SEzU+6ped/5yvCHUQL0ek+lEgxa3SVzowcTDmx2snGUDuPp24ucdGLDKqn2wYDq+3V2ibmIAy3rB70ITsKYe/1TTzTYwOt3X6Oerh5J1KItjKFgD3nGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVfS4XLX1tRQIStDSdyfX1+TGEzlXtJWFD+D16pefGE=;
 b=gO5BXt8yQdyhNUq0nBunc+CQ/5xTfyFB5cRo0enJsIpWiCs+oNanRb8fCocQe4U/1YCbnm4jy9RS9NZufJDx+1l6fJToJAqbAs7NJ8NWgRTg5gLyk0wsrJmgngyBaIwtAaAyJlV+aRTjFS2s1bD3Hd5r+jyu47qis/9JKWXLNg/RKT+a9RIU2IO+RaqWHY9YUsqZFuKvfuKGcgeZwxrOONxiWXPdF84RfThka2kQn9fxOLyGhIXGGYlvx9aV3w8CwjaiKPZEe1uqR7M2OFWlPs3Wg3R2oS49CRD5w7MekFtO+yu7CZgadUWYJb2U3bqCuja++lCwHodcLheDMG5YUw==
Received: from PA4PR04MB9485.eurprd04.prod.outlook.com (2603:10a6:102:27d::18)
 by DB9PR04MB9451.eurprd04.prod.outlook.com (2603:10a6:10:368::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Mon, 13 Jan
 2025 19:40:43 +0000
Received: from PA4PR04MB9485.eurprd04.prod.outlook.com
 ([fe80::81e8:f7bb:dbd0:b0dd]) by PA4PR04MB9485.eurprd04.prod.outlook.com
 ([fe80::81e8:f7bb:dbd0:b0dd%5]) with mapi id 15.20.8335.015; Mon, 13 Jan 2025
 19:40:43 +0000
From: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>, Sudeep Holla
	<sudeep.holla@arm.com>
CC: Peng Fan <peng.fan@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH] pmdomain: arm: scmi_pm_domain: Initialize state
 as off
Thread-Topic: [EXT] Re: [PATCH] pmdomain: arm: scmi_pm_domain: Initialize
 state as off
Thread-Index: AQHbZa+EYgINd2mhkUSyLwfM7XAfOLMUuHsAgAAaEzCAACEAAIAACVaAgAAc7YA=
Date: Mon, 13 Jan 2025 19:40:43 +0000
Message-ID:
 <PA4PR04MB9485E62D248B983AE182187D921F2@PA4PR04MB9485.eurprd04.prod.outlook.com>
References: <20250110061346.2440772-1-peng.fan@oss.nxp.com>
 <Z4TreQ5bA9qiMTgC@bogus>
 <PAXPR04MB8459F33BCC84CCA8F49F3B60881F2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <Z4UZ2Au7KSFMibDW@bogus>
 <PA4PR04MB94855052830C8F4874237BA6921F2@PA4PR04MB9485.eurprd04.prod.outlook.com>
 <Z4VLZgAWR7ugDl7W@bogus> <Z4VTO9mowkMfpZiI@pluto>
In-Reply-To: <Z4VTO9mowkMfpZiI@pluto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9485:EE_|DB9PR04MB9451:EE_
x-ms-office365-filtering-correlation-id: e9a4f885-1e7a-412e-0149-08dd340a2b2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?YZjqA51RPsACiIQR6J7L2vu/8tsZghMkuj+K56hTpGzzF7kFfuO4Ma3ft30r?=
 =?us-ascii?Q?++RnvBdmz/U3bn6tLXrGEXhgJARYqiaEH+8iSpJK6Vq6l3Lj3E+sm8+4UJ5Y?=
 =?us-ascii?Q?Yn66mhcpX0A2WBS68N4S8gSZuT/1kZWLzdytFIuv1Mn9TcH5sS5Bjm230xba?=
 =?us-ascii?Q?QwMQoLI6PNTrgqJFUYaB1AjRR1E+HtV3/n1rm1E8LCFOjqEKgSqZfYnOQ+pV?=
 =?us-ascii?Q?RNZ8V8aevAD8EYIdp1f4U9kka43wrOttt4hGjRhET1wUv6bfhgUfG8HBUf9w?=
 =?us-ascii?Q?1ICPfsvUUN/74rqpDLAcI4gV9uu1TEkvac/qD2GeT1COE5RVmFYffmfQOALr?=
 =?us-ascii?Q?Rd8QvoNeXiOe7w/UvSL50S9BhMYmlj2oaFf+/vlqSzqsYXRmMBs5/gbjbx5i?=
 =?us-ascii?Q?jdciZudxfPyTg681JXNZZIzSTUiC4BHVfFB/LWrX2PCFZUF5J+qUrKKOmeq+?=
 =?us-ascii?Q?Mdb0y1w40qHhnZ8X0w8ZdZgEwmDSxevVJYIuSBuPPkOy+0Z1Id0Qz7PzaTy+?=
 =?us-ascii?Q?UdOHgE2q+6xiPEy3NNVtmSoAb539CizT3Fd7SjaAPeTkP3PUsLQwu/oU1Ptf?=
 =?us-ascii?Q?4xkAGp0EXfBgLMOc+XpWMO0vZpNk4nMtm9pvxHWYd0vSvlYd4C8YMDnR/17+?=
 =?us-ascii?Q?adk52kVXrn1DJiLJhRy3kd6be8Fhv85Cg2NLrrLPmNOI0lXREEMyiVh+5Df9?=
 =?us-ascii?Q?TirM5oc3rvZZhTU2eUPKtI+ylDBWGetIt/IGO7vjapD0B8/x5g/eDFhc7RFb?=
 =?us-ascii?Q?z2PaGNBTCT6oRRP+mDnQHHlG1mRKdu6HbvTheMpGgcUCTNnhoofSsYr0C4OH?=
 =?us-ascii?Q?STiXspZBEUgrjjmnNd3C0BoNx01+rStmYrp39LqvHMfS8Yycgme5XYOEceGt?=
 =?us-ascii?Q?HnpVG69VYeTDqv2gjsHRP2fP+pv7UGDefNxuykqEntSD0LqqU4VUJkeQHRSl?=
 =?us-ascii?Q?ryaGC57Vn+UJLOBP63HUxdHXO0bITb8Rc4Bdk4zR4FZtXFS8D8tYXIQxhK7K?=
 =?us-ascii?Q?CiHSqjYYOoXZYeF5ZB0Gyj95rzqBRmasqgqcrwlVORedj8BIZi1S5xedqDr/?=
 =?us-ascii?Q?4+5+W2T3WalZg8tuLkTJ8CKMguL7Y+NMGNF8yXDnv8XHVL8ZjLoqLQQMZKZn?=
 =?us-ascii?Q?BiOXuwF/aQnjgZ10dLM1+mrzM1uEri3NkXTDWAppO7305QeMMXGx5xFSnMi1?=
 =?us-ascii?Q?3YSS2rVm0eZk65WFkK5GZbsJC9inI3UYc2OMXxwgrtGAzNpZq60oQlaZxJgD?=
 =?us-ascii?Q?NepH9Nzf1gjmdA+GUxioL4ygNrYDq15/wwWntzDV/vy8UGa5QopT1TX/kXOQ?=
 =?us-ascii?Q?0gsJl1dl3RKsxr4ozpvmP8LvKWPZ+QVjBbW/HEONrJfRz95+cCEkSdUegQrq?=
 =?us-ascii?Q?eU+M4EdmeuO9FL558TvFQGqA6ohy+ipBfidaTw0jE06nUKE5wHrTI0AS2TgX?=
 =?us-ascii?Q?L6nlynJQA7DTeRaicvq1S1zNALqXHEVc?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9485.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dMgx4/bRAtBbV1Jsbb7ChVNVG1u24y4uGMOyWd84niCoDrm9HK9Hg9JqEfor?=
 =?us-ascii?Q?S33PS+EgvtDALvxxjyrfkd9rpXsnh+dvNIiez8xKxw9o8PlyXvhzstxkkZ6n?=
 =?us-ascii?Q?OaJxNBa2TZnj5DN7SCAy+Kr+vcYz2e224fATzpeCP/HMCNwb4/ioxh7oZ+BV?=
 =?us-ascii?Q?mJZHBQql1W+nYb+DJ6TSHmpsuGKJopaPU9CQizoVMYj6STvsmsUCDSD4gZ5L?=
 =?us-ascii?Q?0vEwSjbRJ70YAf7VMjyhxABZTzdwbB581crGO/gwMc4GgJRLn9bLQRi+cG3r?=
 =?us-ascii?Q?L0FYbPm31MtLqTDPv1VozZ623EwGkYXZfKYx9GbF3ofSYWilr6otQYr78VZ4?=
 =?us-ascii?Q?OyfcuDUQxxpRjQczcFCmnRFXo+OiAbqm44sJEuSGequHi//5615PzI7I7Jku?=
 =?us-ascii?Q?+NG3YOxR7TJ06LdkgCa/1iErNf4ujKuXmVTxBsQs8uPT4WId1oiYz42HZIC7?=
 =?us-ascii?Q?O890OZOpkiz4ezwWdycMdZvc8JRFrMu0ftEgwC0n+gcAjpBjfTz8jPNkK1Nl?=
 =?us-ascii?Q?q72UECR2iVlynTiFpl+fD71eTQ6EmErZd+T47uFweuOkwrfDXg4s+BR1hwXE?=
 =?us-ascii?Q?w2igHptAgav2jA7umaHPPbW6sEo5CHKQgp5Xs1gK9e1Ax9SoCHflyQZ47P4V?=
 =?us-ascii?Q?BKDcLl59tpdUWngvYIFt/TiZjITcGd9vr2UlnH48/sLYItkZ1qQChRDeeNtr?=
 =?us-ascii?Q?2eCOyQmxtcLWMATRYvHRSdsCvuE+kub5GjWNnvdbxR/vGuhHtFlYLqFXG2o8?=
 =?us-ascii?Q?FCJQKWpeiijnfWUVI298FmoBPgL8LTy0e10+aq94eroY9DEjB31sMjWNDgrx?=
 =?us-ascii?Q?fJ066Jsh0tj3EqbLGYt1+EmhWNj4RzQs7Nxmc2XGTTKgvNQP7FxblwpeJ3WI?=
 =?us-ascii?Q?X877vrPgK9W38aD3t1hfsyINLDJSYSAXDaOuI7FIu9sjtcVGM1gNdx3n0faU?=
 =?us-ascii?Q?os8JAUOIWnQyTfe9krsTWTcmTvhmb+T7xG8i/9snlg6l/ETDy5XQKGg3Gc6R?=
 =?us-ascii?Q?XQpU51PwPZPOku7hWHCBUPtXe7XXz7PzEq6wWHnjCUbnwxSGUJjHs9kjhgeO?=
 =?us-ascii?Q?sdEST38WTCvU1tsY9r8VMYxt0I+mq7LjdozAjlFD3oIDGw3Z8rUWx1+1RTpE?=
 =?us-ascii?Q?KCRvgV1/FcXRCPaTZmU9KVd2A/yPwpMmbccj2DnxXvhfOJg4j9nAbRNo6VKJ?=
 =?us-ascii?Q?ewpeMlpf15OzKS/FJggwrYRyRcXDbj7/xaef/fhCh00AHe7R5xlRQ+RYrH8n?=
 =?us-ascii?Q?QN24bRrjQtdYluFcrtNUFrDJwPdiO4VqM7Cz/k+nvglh+65mnQHP3LHaUmen?=
 =?us-ascii?Q?xEdU64Cb9Dz8mw4IsytOK/PbcndoER64SSZ1m7boJIiDqpm9xkZeb5yFk+/F?=
 =?us-ascii?Q?0deZG0CEjWDT3eVPsC1R0eNiMJrZjDOeDYJjQEOiFKgAFrpTtqNc4HFOzrlx?=
 =?us-ascii?Q?rSfsgM851NJrYZTpQbt/Q5NVAwTSX+9ll9bbYsDGSuWSSkHBpLfgGj4q8ayY?=
 =?us-ascii?Q?bR7R4QMw9hVROlPFeVfF2JP52zA92ZaaszYwMnjvRCyK0IuBcHszNdqaYnjL?=
 =?us-ascii?Q?qngT7sx4TNnQwc8/nZzZ58L6Xz5a5ByZayV0L+ymnpmdBPLpYRSGd+Gudkie?=
 =?us-ascii?Q?iw=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9485.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9a4f885-1e7a-412e-0149-08dd340a2b2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2025 19:40:43.5046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J+BoEjB9DmrJwnaIudfNHkSL1bpcsRFa90cbHz8NO82tDMPAb8ynVnup+0OozcL1DKMgBL19kBlBYt6ANzzSWP/rZDFKdfRCB32tY+16OUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9451

Hello Cristian,

Regards,
Ranjani Vaidyanathan

-----Original Message-----
From: Cristian Marussi [mailto:cristian.marussi@arm.com]=20
Sent: Monday, January 13, 2025 11:54 AM
To: Sudeep Holla <sudeep.holla@arm.com>; Ranjani Vaidyanathan <ranjani.vaid=
yanathan@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>; Peng Fan (OSS) <peng.fan@oss.nxp.com>; cri=
stian.marussi@arm.com; ulf.hansson@linaro.org; arm-scmi@vger.kernel.org; li=
nux-arm-kernel@lists.infradead.org; linux-pm@vger.kernel.org; linux-kernel@=
vger.kernel.org
Subject: Re: [EXT] Re: [PATCH] pmdomain: arm: scmi_pm_domain: Initialize st=
ate as off

Caution: This is an external email. Please take care when clicking links or=
 opening attachments. When in doubt, report the message using the 'Report t=
his email' button


On Mon, Jan 13, 2025 at 05:20:38PM +0000, Sudeep Holla wrote:
> On Mon, Jan 13, 2025 at 03:30:58PM +0000, Ranjani Vaidyanathan wrote:
> > -----Original Message-----
> > From: Sudeep Holla [mailto:sudeep.holla@arm.com]
> > Sent: Monday, January 13, 2025 7:49 AM
> > To: Peng Fan <peng.fan@nxp.com>
> > Cc: Peng Fan (OSS) <peng.fan@oss.nxp.com>; cristian.marussi@arm.com;=20
> > Sudeep Holla <sudeep.holla@arm.com>; ulf.hansson@linaro.org;=20
> > arm-scmi@vger.kernel.org; linux-arm-kernel@lists.infradead.org;=20
> > linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; Ranjani=20
> > Vaidyanathan <ranjani.vaidyanathan@nxp.com>
> > Subject: [EXT] Re: [PATCH] pmdomain: arm: scmi_pm_domain: Initialize=20
> > state as off
> >
> > On Mon, Jan 13, 2025 at 11:37:23AM +0000, Peng Fan wrote:
> > > > Subject: Re: [PATCH] pmdomain: arm: scmi_pm_domain: Initialize=20
> > > > state as off
> > > >
> > > > On Fri, Jan 10, 2025 at 02:13:46PM +0800, Peng Fan (OSS) wrote:
> > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > >
> > > > > Per ARM SCMI Spec DEN0056E, page 16, "The platform may disable=20
> > > > > a resource if no agent has requested to use that resource."
> > > > >
> > > >
> > > > True, but ...
> > > >
> > > > > Linux Kernel should not rely on a state that it has not=20
> > > > > requested, so make state as off during initialization.
> > > > >
> > > >
> > > > IIUC, this was done to avoid any transitions if the bootloader=20
> > > > like
> > > > U- Boot has turned on the resource and OS can just rely on that sta=
y.
> > >
> > > But if it is not U-Boot turned it on?

Hi Sudeep, Ranjani,

> >
> > Not sure if I understand what exactly you mean by that.
> > [RV] Its possible that some other agent (M33/M7 running OS) in the=20
> > system turned on the power domain. Resources in the same power=20
> > domain can shared across agents.  That being said, uboot provides=20
> > mechanism to clean up any power domains/clocks that it enabled. And=20
> > our implementation of uboot does disable any power domain it powered=20
> > up for downloading of images or anything else (display is a unique case=
 if splash screen is enabled).
> >
>

So, RV,  you are saying that the your UBoot is cleanly releasing/turning_OF=
F all the resources that it claimed during its life before giving control t=
o Linux (sicne no more needed) BUT some other agent in the system has reque=
sted that resource to be ON, so when Linux query the status of the resource=
s it sees it as ON since it sees the physical real status of the resource ?

If this is the case, I suspected this was the issue, and I will address the=
se scenario in a separate mail on this thread that I was already in the mid=
dle of writing....

[RV] Yes, this is our case. The platform will return the physical view of t=
he resource (as SCMI spec has left it to be implementation defined).  I wil=
l try to provide comments to your other long email.=20

> Right I was referring to the display as one of the example when I=20
> referred to the case where bootloader turns on the resource.
>
> > >
> > > Because the power domain is ON, kernel will not issue SCMI to=20
> > > platform to request it ON when kernel needs this power domain on.
> > >
> >
> > Yes, but the agent(via bootloader) has already requested the SCMI=20
> > platform, so it should be fine. No ?
> > [RV] As mentioned above, it need not be the bootloader. And secondly=20
> > how to handle this power domain during suspend/resume? It's possible=20
> > that the agent that turned on the power domain initially will have=20
> > different wakeup requirements. IMO Linux should completely be=20
> > responsible for the power domains that the drivers need.
> >
>
> May be I am still missing something. The genpd framework does issue=20
> power down of all the PD that are not used once we boot. Is that not suff=
icient.
> We are just not changing the pd state when initialising the genpds.
> Is that causing the issue ? I was under the impression that it=20
> shouldn't matter if the driver manages the genpds they consume and all=20
> unused ones get turned off eventually.

I think GenPD turns off unused PD domains ONLY if pd_ignore_unused kernel-p=
aram is false, BUT it is true by default AFAICS.

Thanks,
Cristian

