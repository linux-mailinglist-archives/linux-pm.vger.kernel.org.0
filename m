Return-Path: <linux-pm+bounces-27788-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EDBAC76C8
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 05:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC4314E681D
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 03:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2A9248F67;
	Thu, 29 May 2025 03:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WH5xlt8v"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013031.outbound.protection.outlook.com [40.107.162.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD3D248F57;
	Thu, 29 May 2025 03:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748490893; cv=fail; b=WPI8dKUIaFwCiCSScc8ityOE7TRw1lBWjo517ZA917P0+Y3Eg+7O6v6xM19hI6GSuGMYDJfueP/RHVt6GeoPSgeKJ6hC+g+kIZUOzPHPDiu0h3jIcwDfKWemtbbGbvbZfsAeDuS7bYsEBNhWjToHScGYa/ItE7+FP8ob95oS+zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748490893; c=relaxed/simple;
	bh=FttrnGXR1qOZI/ntXHtQUX/vPA+wAZyrHKAiFbR7TBY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CV4I5otlmAwIAgLs8bhJnakJDRVOMeUvNya54CG0cfZu/pAqJ0ntoHaX9/46MKmp3pyKDqUs5xg3xMen5Os3pihQhSQkLz/MoUVlqRKD1GShuGxVSo4JUxHSOtuajDtyZGk3y8+08cIQjMSf55Iq9dXNdvLtuLDFMEyKXUJiyt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WH5xlt8v; arc=fail smtp.client-ip=40.107.162.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c4UnSFyysWrMUYT53obbrX9Yl82nu1MGE5mP56iCK2ljxYfpwF1FZk5te4sUaisseJnl4jvWJItxEGqUXOMHc5cP8WbwvEAm5YOQMIMT34i71OWwnHjzncD7QNxeC+KltpA5M+gM8o8KoTmecedm0+poQzs0DFr6nLGmg6/pO46Ad3DmeMJg7pmHU7zb+h0++SLL86g0Kf00+jwUiL0rjVr+J1NZKsgx6jojjzb5pof02skDmOvDDWRLcJkeqJYehvL8QY7WJXVQfCUJG7Qw1loYS+WKyXQ1mdD7kTgsfoECKyNL3Ag3N/w8zfZxli9BnGfunBYdl4LtFndlJtR0KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWkZyrkes3qslYjUz1i40bIlm7KSS8kfepX3lEGDx3w=;
 b=c5DO5TbJO8464SIM9upWeFMank5C9MnkLvQ0ovuCyfm/znffnZVNae2gyQkCuuOcPDBZyehgpqZHQuez2VDPqlQb6y5jvUvqGxKaFoEaE1Ix4L5UHS7E0CQODjl06zonzAPm1Io0zS+6T0SwErpxzkxmzAPLcbcAqfJoU+LgiI1IuAKie/LGGLrDugg+B24O+PvMjxpXhV859M5BWwILGSEi4GdgwGPvjZb7oIoaZtNCOfSE72SBj52V8xXHdheQPcUMokqs2RrpaDp5KuxcypE3dUfcg8/oM4Hfh4yab9b8I4jOeV+17i5rmHZfbqLDDbHioOkzjkEiSttwkTWDuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWkZyrkes3qslYjUz1i40bIlm7KSS8kfepX3lEGDx3w=;
 b=WH5xlt8vr88SlX5N0+IFm+KFF3xwI1hbW7W9nPniKEob/U5n5jh0kENr75niMF2cbA3mlK24TOkgIg+QJUk9QU4Jl0BrknZNddF3IHccoDtB7qjNPqh89dkaoUeWswTFifo8putFFJjzCnw8TPLJuLeYmPz3Woshdr8Cw9CDWwZ3M/i+7FzcPtcvaz/OELKQm0E/BgumIJandT0qn/Rfxylcr3Ph21yG1Aq2t0/qnHS/WdhJq+zyRIwJGywIzpkWxF2rMbvxuaun/S3bQ2Gy+tzX1zzK7fQc6+yGi7KHwY9Ejy3e86DZsk2I0tG5V/yxCrNOoX+MFqLNv7uyEoM3tg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBBPR04MB7995.eurprd04.prod.outlook.com (2603:10a6:10:1e5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Thu, 29 May
 2025 03:54:48 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%3]) with mapi id 15.20.8769.025; Thu, 29 May 2025
 03:54:48 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Hiago De Franco <hiagofranco@gmail.com>, Ulf Hansson
	<ulf.hansson@linaro.org>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Mathieu Poirier
	<mathieu.poirier@linaro.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-remoteproc@vger.kernel.org"
	<linux-remoteproc@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Bjorn Andersson <andersson@kernel.org>, Hiago
 De Franco <hiago.franco@toradex.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Daniel Baluta <daniel.baluta@nxp.com>,
	"Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>, Fabio Estevam
	<festevam@gmail.com>, Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: RE: [PATCH v2 3/3] remoteproc: imx_rproc: add power mode check for
 remote core attachment
Thread-Topic: [PATCH v2 3/3] remoteproc: imx_rproc: add power mode check for
 remote core attachment
Thread-Index:
 AQHbv2lh+BLQVuHt90+IsoT8T0GP8rPIghaAgACumACAAO0YAIAAkDIAgA9pMACAAC+fgIABPeuAgAEJyQCAAAGOAIAAg/oAgAObvYCABB1+gIAA6fQAgAArFICAAJxNAIAAHcyAgAHTYICAAKrrkA==
Date: Thu, 29 May 2025 03:54:47 +0000
Message-ID:
 <PAXPR04MB845941FFF347274012A0ECA88866A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References:
 <CAPDyKFpGcgMzOUHf-JTRTLBviFdLdbjZKrMm8yd37ZqJ1nfkHw@mail.gmail.com>
 <20250521041306.GA28017@nxa18884-linux>
 <20250521041840.GB28017@nxa18884-linux>
 <CAPDyKFpSb+KsfDr1-=uk4TF4Op1dUQ9rDwPP5sSpMfxDRDhnZA@mail.gmail.com>
 <20250523191713.nylhi74jq6z4hqmr@hiago-nb>
 <CAPDyKFq6HG6iTZRnBSN25vhCU8Zj1c+r_ufGbiBsJ16N+1bJVg@mail.gmail.com>
 <20250527000510.fofehmsdhifcwlys@hiago-nb>
 <20250527023921.GA14252@nxa18884-linux>
 <CAPDyKFqZkcaGfss=Oi+H9UERFU29jY2t5uTPnGVGQgSAJSeCoA@mail.gmail.com>
 <20250527134525.f7yzs4ww64xxmjmr@hiago-nb>
 <20250528173813.rxqu6pzqgu4m5joo@hiago-nb>
In-Reply-To: <20250528173813.rxqu6pzqgu4m5joo@hiago-nb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DBBPR04MB7995:EE_
x-ms-office365-filtering-correlation-id: dedf56ac-829b-488c-7235-08dd9e648e6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?dhY1eq6gjTyUl57mpypd1yEq7o5JDNs9nvSNOzusbN64x7gP5RwFIEz4wGNW?=
 =?us-ascii?Q?5mN0rlgj9pok0JHaGRavgKPWleomSmDYGiKOIKWZz0XzT9wosQppxry30/ug?=
 =?us-ascii?Q?wNeHpTDBvpVuUWN3eKROl3cvs+C1lKJVsdtvKMTOJdv0FzndTJrFzmepgVoP?=
 =?us-ascii?Q?B07FgcZQ5gOTcLJCHD2zYGHZ1k8kZwd7GkQGQ98SyMUC9RHNnB28uTyA2ZSX?=
 =?us-ascii?Q?k3JDo/q9TpYD18tRq245BaDpoD+WC7GhBXiTL7HKqAGmk4O3ZnuOKcPww4G8?=
 =?us-ascii?Q?/XtmaW74ASSsCHBT4gKDDtgQi5e3u/PvCtFOujmzR99/iUhOb8091YvrAt1R?=
 =?us-ascii?Q?NBNcNKFRz2lZyQ3yxwd8jEt7fnKD6AZsPt0PPWkZztLYg2ovy6+o4XvUhqQf?=
 =?us-ascii?Q?mohHmPZSvnSjI1SDkwGYRHcgy9xoedzLe7pbV3d7h8s6zq8sqTY59Dr9bgRu?=
 =?us-ascii?Q?ZWGq+zHRbdaLP/WKmvJX2TsVh5GcHXCahGCRhEtyL4I9QWgZ/SV1HLgCiy2x?=
 =?us-ascii?Q?yePdA8SXugPf+OgKhhWuZiiXwKhp9oRACRA2F3cK1givFhqD7lHf9CBYQqRy?=
 =?us-ascii?Q?HqjM9rpZKKO0iTec1VTO4Hcj6AmvG3emsUPcgJlXl1xUAuQalG58bDiSdtRv?=
 =?us-ascii?Q?6oQvuFDFl0Cy+zEXcqERzVvTsFPxuwssW1vJKL947ZWm8/tCwGx0YN1k5H2j?=
 =?us-ascii?Q?MjV/0OUrIxjx3cRtXs43hRNZVXrxlVlBEi5GkS1lI52nosioO/Dhwp3KFaEK?=
 =?us-ascii?Q?rV1Ip1Y/JZPfyr9i9nPd7o+PqcA6tjng/xDxVek0qcdxbzSUw0sTAkjpDIJy?=
 =?us-ascii?Q?UOKePLgTHhEcnhQexgrLAoJxZUVAXx1zVO+qh/HueTDugLkCiJjHEZPJpsyZ?=
 =?us-ascii?Q?vLzMIVKZK9sEv2OrpqtqNPfZKsR3VQM/g6DrTlTEx3Kelvab2tvTVV7nYZMt?=
 =?us-ascii?Q?HJTQvk90xg8I4+hpmDjSrxoc3T/zBaONA+Uzw0ecxiQwt7yOykbt8nsLh8id?=
 =?us-ascii?Q?zL/9EUNuiwIcYun2E114/30qB/cJ0pWfERxaJg4y4V4JeItJ0dhTE91Ftp0n?=
 =?us-ascii?Q?323PcYY/W1l3eEdnbyIXegVne6geU9uRL9sQ+/uaKEMpzmbDJunh51YaUGZj?=
 =?us-ascii?Q?xv9FkEn5sEuLI4TAqTckP2IXk3fapexfz9CWeXkmVIqrknTzRbNzFWVj63RJ?=
 =?us-ascii?Q?84ne7u5xt3vIjyi94mBHap7ZJXyC6vc6Rk/XZfWJWt3uSpQdcQ3TyvsKex3c?=
 =?us-ascii?Q?ywBetPRYE/JYtx/NqGGXCv0iOjszfy5qH9VOts3v5NLpVa1GgYy2Cfpeg5XB?=
 =?us-ascii?Q?B8v8YZkro+zznY1UynUrUt31bCujCh++3ylUNBWU9pFgC5GKLw9wPkY0mYdI?=
 =?us-ascii?Q?MZJgnITrzUSnJsooKeadZWAeqTWI6VNEuz8fgur5jlfccxG5rlmopYzqI5kV?=
 =?us-ascii?Q?WIdC/aAhU3ifiFyRD7N5UkH+myiHON1bjZZYk6iksZfIBWhx8v3Q+caaE4La?=
 =?us-ascii?Q?mzVPY2qYatBfGSQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nw25d85MlEjYiCwKu1mhkUHZvakK4iTglxYHeT+EfKqW7R+UZM4C5UiFp34i?=
 =?us-ascii?Q?5R3D5c20iD6YQL81Sm8E4P3wVpn8DL8Fppagh/VVXPo+L3DTSc6lk0swmbxk?=
 =?us-ascii?Q?RdoPdu5fONgPxYXcgx0iZyHQX2TekfB4MWtRuX7wZpDCVSwU28Ua41Zc5kxJ?=
 =?us-ascii?Q?0Rj36OkAlI+R/McK/a+iFO6wz6y/FbXibQw77NOZVr0gt3ROozBwhfu8VJoo?=
 =?us-ascii?Q?3kUKeF0XNPXZ+bY6sXPmYl6+gXqzcc88PNpGrHnCKvpqM3lmHIOAH5vFVUw3?=
 =?us-ascii?Q?NoSBKHUq16ObDyNNupdZ+kit+zX/5bETdVVwPmlok6eRXUCVrjGw/O9kYde8?=
 =?us-ascii?Q?SBF8b9uxUcCV88s1huH7aG0rFgWr6UbJlXKGJL6uLKRJ3bBQdsWu8E4EiwxP?=
 =?us-ascii?Q?7adsK7dRO/5rjdjB/zbfueqfLdoV/1NA7sZs0boKsRnwtw+/7arpP/7JxYLC?=
 =?us-ascii?Q?bMdcYgmS/rYepL7Uab4q/jxw1eKgOvt4CNi0zC0cA9aPnsKO2fExJbeJ0BFS?=
 =?us-ascii?Q?etBCa0alGjfFgU6hjihlWydLqDZW1SJ7HM07Uxg8PUxErMofaADhV5Q5wAl2?=
 =?us-ascii?Q?xirEZkLo80ztqliPZMYZ6lSTLRhjulB/s0QA+jTPqHT7ty4h3mL5lrNksHAm?=
 =?us-ascii?Q?q99QcjhlZLNvVKhAS1s4yF7br8Mj3haVR3+6gz4dtvW+Bso2hUK4YANfebqQ?=
 =?us-ascii?Q?2vOwBoWRkcg+q8yjSbQmjt4XQbzeiLwsli5yPVxGVmRYQEhT3lLKhqV6zyZF?=
 =?us-ascii?Q?YXEZc1Fo6Xt0Vgl/U6ZjtM64Pp+v1XUx8006qndFqh1SPoDgsBDgAGZpW5WK?=
 =?us-ascii?Q?WUQHL8+O7a66/rua129qcqXQlmdLKWKez/Pt31xgnzrHfiAfSQnw3rnHgIph?=
 =?us-ascii?Q?sYxgVQ/xVl8kF/tdM0KzEHmb3fVz+oe8hwTuPIk6s28dB03DPgbcrFqXvu+J?=
 =?us-ascii?Q?nz9l4zab26wsORMDu7Q5QrcoiqAELDGaVJ/Li7tSj3/EycC3HAT2RLkMLdvJ?=
 =?us-ascii?Q?QHKBJtqGr2fMauxjHQUscnif7gteyBEyhEn0gHcY7IbqeKkRXCnXetJZMYeY?=
 =?us-ascii?Q?5HH1dPZ6HXL4f8f82e188HXbblIvPlBOuqnZp9xPrCsUfYwzOKGSKcwOWJ+n?=
 =?us-ascii?Q?J5UgaNWZ3HwWBxwL8/nUcBhm0vitWN4v+vewfL+Dnqi0q0bZxFO90fwX1CC5?=
 =?us-ascii?Q?q6rX+Cy5mSGpoyltrf9EaXI3eUVLt7CzBu4A4uSpfhDqyYK1eLOI0HoF7Qr6?=
 =?us-ascii?Q?z1YOGWEQKRep/q85Or/EF9QUoc5uqDPo+RUro2LvdsogAQ5Vh/t7GepeSHPV?=
 =?us-ascii?Q?GO0nOThuVp0LQLfJVWa2U6YCsdJNSaPA3wFwr2YOjAJQveY9dwm5qnZEaXWl?=
 =?us-ascii?Q?8A/x98BFiEZhCCXyyk7NF5RWz5j3WmetmE148Z9z0LT+Dd0HnzIlULdoNNCE?=
 =?us-ascii?Q?l8e6bGpyP20tqRVglYAkjLwwEGCZJ8Y3ujNXWkvsQcoxU65+NbIix7Jvzc60?=
 =?us-ascii?Q?ykJzChpQHtd6QqhZmh9FRVbmaXnDvB7FBd/0sFnmdmX69B+W5CEiWlcKWWu7?=
 =?us-ascii?Q?Fb6icKBPyLWX6AEp2dk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dedf56ac-829b-488c-7235-08dd9e648e6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2025 03:54:47.9777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0p2S64CYBPm9fLwJpmYYNAd5uIa74WT4NjSrj9q323jWVy1eW3X8hpkFmzrcXugM89dFT6MNNT1f75LNG49I6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7995

> Subject: Re: [PATCH v2 3/3] remoteproc: imx_rproc: add power mode
> check for remote core attachment
>=20
> On Tue, May 27, 2025 at 10:45:25AM -0300, Hiago De Franco wrote:
>=20
> [...]
>=20
> > >
> > > Thanks for the detailed analysis!
> > >
> > > This is a very similar issue as many other genpd providers are
> > > suffering from - and something that I have been working on
> recently
> > > to fix.
> > >
> > > A few days ago I posted a new version of a series [1], which is
> > > based upon using the fw_devlink and ->sync_state() support. In
> > > principle, we need to prevent genpd from power-off a PM domain if
> it
> > > was powered-on during boot , until all the consumer-drivers of a
> PM
> > > domain have been probed.
> > >
> > > I had a look at the DT description of how imx describes power-
> domain
> > > providers/consumers, along with the corresponding genpd provider
> > > implementation in drivers/pmdomain/imx/scu-pd.c. Unless I missed
> > > something, I think [1] should do the trick for you, without any
> > > further changes. Can you please give it a try and see if that solves
> > > this problem?
> >
> > Cool! I can give a try and provide an answer soon. Thanks!
>=20
> We are making progress ;-)
>=20
> With the patches you shared Ulf (I added them on top of the current
> master branch), it works as expected, dev_pm_genpd_is_on() returns 0
> when I boot the kernel without M4 running and it returns 1 when I
> boot the kernel with M4 running with a hello-world demo.
>=20
> However now I tried to, if dev_pm_genpd_is_on() returns 1, put the
> DETACHED state, something as
>=20
> if (dev_pm_genpd_is_on(priv->pd_list->pd_devs[0]))
> 	priv->rproc->state =3D RPROC_DETACHED;
>=20
> In this case I used 0 because I understand this is the
> IMX_SC_R_M4_0_PID0 defined in my device tree overlay:
>=20
> 		power-domains =3D <&pd IMX_SC_R_M4_0_PID0>,
> 				<&pd IMX_SC_R_M4_0_MU_1A>;
>=20
> But in this case, the kernel does not boot anymore, I see the "Starting
> kernel..." and nothing else.

Please add "earlycon" in bootargs to see where it hangs.

>=20
> I am using the pm_runtime functions before rproc_add():
>=20
> @@ -1146,6 +1154,9 @@ static int imx_rproc_probe(struct
> platform_device *pdev)
>                 }
>         }
>=20
> +       pm_runtime_enable(dev);
> +       pm_runtime_get_sync(dev);

I think only make this apply for i.MX8QX/8QM/DX, then no
impact to other patforms.

Regards,
Peng

