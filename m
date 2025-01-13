Return-Path: <linux-pm+bounces-20382-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03597A0C230
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 20:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 233DF1882FB3
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 19:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831AA1CD210;
	Mon, 13 Jan 2025 19:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Mw2uwFWZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2074.outbound.protection.outlook.com [40.107.249.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3029D1CC881;
	Mon, 13 Jan 2025 19:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736798053; cv=fail; b=u54OGyoLl/bDoNY+Y9pynnRIWdxByF9d2jYkQ4iQQ2PYjIvcP1J4p004RqF5ARdco4CZFIANn64LYox6G/gItYW1RoUIXQ4BR9YGB0xKx2AZzXPIXttBuiC34fELLjqgoknvadhnndgzUqZMvSBl+gtoebgttoJMsuRQn7lX7Dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736798053; c=relaxed/simple;
	bh=CNQJcZABIZAvfki9UK1gtj7tnw0OqLzHd/NNNAGRt0c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kMykRYqpaA17SWKm/V1tymM+/lmWcqW/j9RWux77zTP5uN4LHFHSMTOvUyptk29EQU7o5XN0xpU1Wfm0SJ95EzuxWTfOv21Dbw73f7vIw4V9kojZFjEKgZuPmrPhjdruMCMUSocfjVzZcnJNEoW1+Mwb+KJmJMFNZxEETzdn0f8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Mw2uwFWZ; arc=fail smtp.client-ip=40.107.249.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mNzjKFOxm/wRHvJBISVSOAhMb1EHw7n7To8Ojfw+vFtJIiEi9uL88JHCo6/+wQGUH/zOop7WQC+T8jkIHqilNjBA3P/Hj4lH9QCqjgfOSbhq/pMx6S3y968S+fb6W9Ayxcbc8oq8xC86gXyJDblAymgcbO3VbDsFCOtrwVW1YDk4si5KaGIdsMdkU+uV+eQF4Y5vnt3/BEGSMFU/2S5Kd5IdPRlfgrnRRO56jKNmXAtowNwAP2NMukyl53eUmhvRbr40qwxzinv7d3aXF8lByNgDk/yLJXi8jklX7XMDVjlHO3xnusYxhTYCm//f/D1S1eDYl6jah6OOJgtqoYOE1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSaK4ajJO06o5+M18k/6CSKbJRsYyYHMJF1lB0y7kng=;
 b=Utc1kJ8ry8gBanvf1zR9yiYPM8czVuehHMFjr+QXkDkQXWYcwEQ7xjQZJNUK70ZiHq6wLLZ9VVDHkkqJkz5d7Hg3sEHGcwbRY548TEtvegB1kfte3aEHjvWKYrR0VbrS1QpQZBGid+oJuWhf4SdRj606iGLd7CGZkugDW+9GZhNNj/QuB1VB8dd64ZlpmgiDTSBmiMtk4/wUUb4dt9vnRYg5RUsyNQfyg87dtWg+kXWXS9hxPkxf1HbaPv6uQ3PCydqMEt9LYN7VxlNxZbwwFFES7Q4NYYrGajfY8/ODNcU87qZc7TvlRPVNJ1QXvoeYgJ8GeHLFPgeq6gkwsie/cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSaK4ajJO06o5+M18k/6CSKbJRsYyYHMJF1lB0y7kng=;
 b=Mw2uwFWZ+Ir0AXLmAeabqXFIOmPNQhHHY9Rgx6BzWZs5IAW8ilIhhgCDpT7OEdRGBO+Ol/4lVJbPKH3vQ3YWvr6GY/Nn2vs3RMblO4DsfW1Jvk8F0E+RbW6nFcnWrTI7pV48H5/JVSi7kNqQtc7PeXfqCMwPIsMUFM3cz5+OXgJWuZjVp75xdGWN4Mtczxq+h3Y2SfRTQrqN80vkqHyY9huJhX3/Pl0Q4Y5BYtP0q8ztNLs2tSOH9L74MpUyk1Y4DpreoDv+CfiQsra7UXalxlM5GsUq6tbMgh+GglvlSqgQLwOZtBlB8s8XWTohK3QdgVmDElKQwtQ7EIbcM4zUQA==
Received: from PA4PR04MB9485.eurprd04.prod.outlook.com (2603:10a6:102:27d::18)
 by DU4PR04MB10981.eurprd04.prod.outlook.com (2603:10a6:10:58d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 19:54:06 +0000
Received: from PA4PR04MB9485.eurprd04.prod.outlook.com
 ([fe80::81e8:f7bb:dbd0:b0dd]) by PA4PR04MB9485.eurprd04.prod.outlook.com
 ([fe80::81e8:f7bb:dbd0:b0dd%5]) with mapi id 15.20.8335.015; Mon, 13 Jan 2025
 19:54:06 +0000
From: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>
CC: Peng Fan <peng.fan@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"cristian.marussi@arm.com" <cristian.marussi@arm.com>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH] pmdomain: arm: scmi_pm_domain: Initialize state
 as off
Thread-Topic: [EXT] Re: [PATCH] pmdomain: arm: scmi_pm_domain: Initialize
 state as off
Thread-Index: AQHbZa+EYgINd2mhkUSyLwfM7XAfOLMUuHsAgAAaEzCAACEAAIAAJ0wA
Date: Mon, 13 Jan 2025 19:54:06 +0000
Message-ID:
 <PA4PR04MB9485E9C126E48A088D7E399B921F2@PA4PR04MB9485.eurprd04.prod.outlook.com>
References: <20250110061346.2440772-1-peng.fan@oss.nxp.com>
 <Z4TreQ5bA9qiMTgC@bogus>
 <PAXPR04MB8459F33BCC84CCA8F49F3B60881F2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <Z4UZ2Au7KSFMibDW@bogus>
 <PA4PR04MB94855052830C8F4874237BA6921F2@PA4PR04MB9485.eurprd04.prod.outlook.com>
 <Z4VLZgAWR7ugDl7W@bogus>
In-Reply-To: <Z4VLZgAWR7ugDl7W@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9485:EE_|DU4PR04MB10981:EE_
x-ms-office365-filtering-correlation-id: d30d6c67-cb7d-4d62-8bac-08dd340c09de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?QoD1Z5cdZiH6sxwy8qQYnh1LjvY46R2GBOwYOgU59Wp0P5OQuqstfcK/oHKu?=
 =?us-ascii?Q?9r3wluhWu30Z8jSpzSaJmSp1rOuoSYgsa1ir+8JpMr9f+wCq0P6u4ycqCs3H?=
 =?us-ascii?Q?UWKFozFCPChQoq+mrOS/FOyrnuKPislRGySNe1Sfs8t1EZe6jLMQD0bYYTs/?=
 =?us-ascii?Q?rsziCFA+kGox9Kb3Ey7Gxo7ml9uCP3A3cpmIRTT1NaZu1xGsQVrmjPNHyYV+?=
 =?us-ascii?Q?a5Af19qgxP0y18tz0iVduAAtIXTFDigBj8fYT5NUR/4pT5in1dMIKuaUb9cl?=
 =?us-ascii?Q?WXYo/s17ZuRRU+nU8tGHOqs5LFUupdLsFLZZqtzF7B9a1U9Ridi/FZJsa+M9?=
 =?us-ascii?Q?bkBZCPLhAj4+5ch5mq3WKAYY3zsAXkPZ+0YYd61o6TK5D3TEErAftiBn3RHD?=
 =?us-ascii?Q?vHEPsycjvdd527Dfgiy/oVqwU5JJzZFuPwso2xM2xnFf2Hu/ldSVlwi0zXG0?=
 =?us-ascii?Q?djw7RTIMGhrzoiAjH2fFYgW5R8I70iz6YUKwc2CgEHW3GJ3w2FJi8p1ate01?=
 =?us-ascii?Q?f1KFfjejbOjyV9pMMZ8ojcVW2RdosiHahsrkfO6w/V2AHMNcaAny3v81blWT?=
 =?us-ascii?Q?lb/7FpLVwfozAGzpuugNnJru536HzqmDMWAARxPg81VnGHqvfh4IIJ8f6pfm?=
 =?us-ascii?Q?W3qu+u2Hgy44zDbexvs89IGcipqkHNFmanObqf5FYp7mO6xhEItBYB1Zhcnx?=
 =?us-ascii?Q?m3AjjbjXTt68sKAzoVMRPz4tu3hhmLegiKu5XDVdrpVDrROJJvpbcWXqwReB?=
 =?us-ascii?Q?3GNlZGPmWesoguuohr7F+OexUaILmyJpTSjV5vMPcTObQ9V5vwOoYOnU+BEP?=
 =?us-ascii?Q?fPnvRzC+HkTAYtpXOqzrDIF3EWw09ArBT1cynMtnhx8YKfTscXkW3cMFtbyp?=
 =?us-ascii?Q?X1RsVPeVqqrKl8KjebuiG8LSEAu5Yi7dao+QcN8ke1rxADtn9p2XAofpqUsj?=
 =?us-ascii?Q?G3O6SzWYNx1KupG7gTgiQLQtWqc5ezJmk6JLMh7wOzgEN83Bpm+Uc2u1SWRD?=
 =?us-ascii?Q?GPG1NgLZoO2S48dyY/H9CKSZaHsuy4ee/lHPKvNbHhau2/kOgwSSrWInaLdW?=
 =?us-ascii?Q?nrLLzLrEIZkfHOjAtExI5LzXufDfNUajVaxwVa4ZsnYTa4KT6Hj9XDnoIBdA?=
 =?us-ascii?Q?zbbCr5i+opBJ1hswns2XIL96XKkjXRKlTkqstmysd9NPNFt1UobS335zErJo?=
 =?us-ascii?Q?y6/6A7ZGUT09zAStgEvidsvRA1Ru/hUuaeaoHhqtS+MvyMhsjLVWHMslkNDk?=
 =?us-ascii?Q?Z5RH13IO92HbM7N8q6IracljG9o2ez/8V0majN/4LE1j7bUB73ankM860Zg4?=
 =?us-ascii?Q?qACYxjI2voGwFpHSsJzQ7ikCmv4YbfvgKCJ77TNRfZCNd/WKYeTOC55P/8t6?=
 =?us-ascii?Q?uPvLAdSJ31PeDBBxMYB6vUeXViz9EIATHMU9rHmT0C3iw4F2IiXILbuZ9w0j?=
 =?us-ascii?Q?1Cz/TLzgjgkXJl/LiaLkmNVb7/vwgXd/?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9485.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qPR+42suKN0EwV3hrG1Kkhusdv0M57k1X749Eb6J/uYl7YtrcY/iGUqCz15D?=
 =?us-ascii?Q?vsSbqCheHILcNSYW9dNPlgTcPixqCv5xyONirECares9cnfFWli32q6BndI3?=
 =?us-ascii?Q?kTXC6/NAcmthd+VQw7PhAO7p6y9chZYQvoP4dUS2yWnj4tKxGpNlaKRHkBSD?=
 =?us-ascii?Q?IGatUsuBYCPa7oHpuYBdmopWdx2mge9LmdsT7KaRaTy/r9WfmV+HKcoGD+vP?=
 =?us-ascii?Q?dbVJbDWtoBp/VkEY3v3VObebbgxl0XeLT0M14d4RI5tcU1Ri5arPlc6Wdgax?=
 =?us-ascii?Q?KXLUHW8pb4SfIIUpEoFe/LWUKW7LWfSqsXcrWgzkQVbr/LQ6vocI+ow/TqYr?=
 =?us-ascii?Q?orZ+J5yKRv7B7ZoIputVjiOiNbR+4dqrLX7KYSCEdRL0jk0sfbm+B4+fvjgM?=
 =?us-ascii?Q?mjp7yiLFjIWnFSdKFAzep9H3PG3dOTwuClM8PB6Wm8H2hFJlrRyBL1gtvIUh?=
 =?us-ascii?Q?oFGPFC42haldYMY4363yO923fBIhIpQjTGAcxS10vSyHHad+PQKGC2Kb4yGD?=
 =?us-ascii?Q?Puz/U45PTfD97+3iTEyU7Y/ysZJOAi21LGf5RJtGxr82joWmwqzRaO08C7Dj?=
 =?us-ascii?Q?xS0tz08D8mWDxMtlAeh3vnXeXigo1tNSG0e9P8Ap9b9vttajEYh3UFIxePpD?=
 =?us-ascii?Q?7cLNvII9uRtxyRO57S5jSONHMKUIdvh+BBkoJfqisMAZ73T/f8Ap/HOERxZz?=
 =?us-ascii?Q?ZMI11F1GSibr9ILKo9wwXA8n+wN3fftUVpPuOWKZKhN31ScQSfvZ6T58MwJU?=
 =?us-ascii?Q?0SFmxVYZcR7ifulLS7ejunjkspbUN44ZzE1rVtNr5kVRXsrnKhEWl2pfRSfe?=
 =?us-ascii?Q?OfS5u8woT1CbcohQoQITNTrFztnTAeCCS3kF3L+q86ZK9z4HvX1RLCAa+eMM?=
 =?us-ascii?Q?q+BweIlBR+o6RNCpl8CWl28FIYAtqJectGbNQER1cLAhoNJl/kS7yHwOlhgD?=
 =?us-ascii?Q?xlP3oENdtIUmYwCYIHBWJYwPLScc+bmhEjL9zuvuAnuE63bCK1hqtbEb3ZFk?=
 =?us-ascii?Q?PCLv83M0i/FhGR0I79DIiBMysLZaJBDXXYyQ5wy2ibKGkksPLGighbzFyUSM?=
 =?us-ascii?Q?Bx3bQ9HmYkQIbhB3SreKbVhmldryBWs1qMRQHH0ey2a4teAxlgkSPWEOc8VU?=
 =?us-ascii?Q?+iiKduQQbq+9iF2Bpj2fyN51gtLZbzN6IekPyMkTThQNVOpAuEM7hKwvlSv5?=
 =?us-ascii?Q?RoLDkREaXx9g8GyojMTZegpmVNwyKfEBiJoC1RwlQG+Kl8lrTQ71NQhZOUF4?=
 =?us-ascii?Q?H/fGWpxOQdLTec8TVSxmjh7ocOk4BJvh5SMe/N+4yAq8kbv25UH5l7LIQNxz?=
 =?us-ascii?Q?p9kMC/IQ3jhiSXuKZp1G+yIcrYhE4uy3SWGZrv/YJKV2WbLJDjR9ECVj97El?=
 =?us-ascii?Q?3sPEZnae5a4dGmbTniKg7I5i0YrsstZRStOrhankxu4tEgPkbxQvw8IIRCwQ?=
 =?us-ascii?Q?bGlBeaanpBrbRvCbRFthR/Q6KXAjWkStc3lrBJz0ZBIH3P1isN4qFDCpsE5C?=
 =?us-ascii?Q?/ik5A5xHHDp9GasSfoCpGut+yxfiZg+Zr72K35lsJ+hLvkNo4dQ6xQM0K8sq?=
 =?us-ascii?Q?/oBYRTs5vTv2j5auuAAKKEAwZH7K0kzpfE4QO1LPMjUMbfrzj8p13Nnywx2t?=
 =?us-ascii?Q?fg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d30d6c67-cb7d-4d62-8bac-08dd340c09de
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2025 19:54:06.5800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PH3lPuFLgehtya1hFErUv2fn3wm26sUEXYx9jT+5SyrqySuNLyLE0A8UnGY//ogMbRwJaaiJK0ZzF8N7JXxznePS8LCQ0CH1taBk6E7il9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10981

Hello Sudeep,

Will try to explain the situation we are facing.
1. We have multiple agents running, Agent-A is booted up first before Linux=
 is booted and powers up a shared power domain PD-X
2. Linux boots and gets the power state of PD-X. And its already ON. And th=
en PD -X is initialized with a default ON state.=20
3. When the driver that needs PD-X  is probed, Linux sees that the power do=
main status is ON and never makes an SCMI call to power up the PD-X for Lin=
ux Agent
4. Agent-A now is shutdown/suspends. Linux will crash because the platform =
disables PD-X because it has no other requests for PD-X.=20


Regards,
Ranjani Vaidyanathan

-----Original Message-----
From: Sudeep Holla [mailto:sudeep.holla@arm.com]=20
Sent: Monday, January 13, 2025 11:21 AM
To: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>; Peng Fan (OSS) <peng.fan@oss.nxp.com>; Sud=
eep Holla <sudeep.holla@arm.com>; cristian.marussi@arm.com; ulf.hansson@lin=
aro.org; arm-scmi@vger.kernel.org; linux-arm-kernel@lists.infradead.org; li=
nux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [EXT] Re: [PATCH] pmdomain: arm: scmi_pm_domain: Initialize st=
ate as off

Caution: This is an external email. Please take care when clicking links or=
 opening attachments. When in doubt, report the message using the 'Report t=
his email' button


On Mon, Jan 13, 2025 at 03:30:58PM +0000, Ranjani Vaidyanathan wrote:
> -----Original Message-----
> From: Sudeep Holla [mailto:sudeep.holla@arm.com]
> Sent: Monday, January 13, 2025 7:49 AM
> To: Peng Fan <peng.fan@nxp.com>
> Cc: Peng Fan (OSS) <peng.fan@oss.nxp.com>; cristian.marussi@arm.com;=20
> Sudeep Holla <sudeep.holla@arm.com>; ulf.hansson@linaro.org;=20
> arm-scmi@vger.kernel.org; linux-arm-kernel@lists.infradead.org;=20
> linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; Ranjani=20
> Vaidyanathan <ranjani.vaidyanathan@nxp.com>
> Subject: [EXT] Re: [PATCH] pmdomain: arm: scmi_pm_domain: Initialize=20
> state as off
>
> On Mon, Jan 13, 2025 at 11:37:23AM +0000, Peng Fan wrote:
> > > Subject: Re: [PATCH] pmdomain: arm: scmi_pm_domain: Initialize=20
> > > state as off
> > >
> > > On Fri, Jan 10, 2025 at 02:13:46PM +0800, Peng Fan (OSS) wrote:
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > Per ARM SCMI Spec DEN0056E, page 16, "The platform may disable a=20
> > > > resource if no agent has requested to use that resource."
> > > >
> > >
> > > True, but ...
> > >
> > > > Linux Kernel should not rely on a state that it has not=20
> > > > requested, so make state as off during initialization.
> > > >
> > >
> > > IIUC, this was done to avoid any transitions if the bootloader=20
> > > like
> > > U- Boot has turned on the resource and OS can just rely on that stay.
> >
> > But if it is not U-Boot turned it on?
>
> Not sure if I understand what exactly you mean by that.
> [RV] Its possible that some other agent (M33/M7 running OS) in the=20
> system turned on the power domain. Resources in the same power domain=20
> can shared across agents.  That being said, uboot provides mechanism=20
> to clean up any power domains/clocks that it enabled. And our=20
> implementation of uboot does disable any power domain it powered up=20
> for downloading of images or anything else (display is a unique case if s=
plash screen is enabled).
>

Right I was referring to the display as one of the example when I referred =
to the case where bootloader turns on the resource.

> >
> > Because the power domain is ON, kernel will not issue SCMI to=20
> > platform to request it ON when kernel needs this power domain on.
> >
>
> Yes, but the agent(via bootloader) has already requested the SCMI=20
> platform, so it should be fine. No ?
> [RV] As mentioned above, it need not be the bootloader. And secondly=20
> how to handle this power domain during suspend/resume? It's possible=20
> that the agent that turned on the power domain initially will have=20
> different wakeup requirements. IMO Linux should completely be=20
> responsible for the power domains that the drivers need.
>

May be I am still missing something. The genpd framework does issue power d=
own of all the PD that are not used once we boot. Is that not sufficient.
We are just not changing the pd state when initialising the genpds.
Is that causing the issue ? I was under the impression that it shouldn't ma=
tter if the driver manages the genpds they consume and all unused ones get =
turned off eventually.

What exactly is the issue for which this patch is the solution ? I think I =
might have not understood the issue properly here. Sorry if that is the cas=
e.

--
Regards,
Sudeep

