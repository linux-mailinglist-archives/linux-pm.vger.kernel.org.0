Return-Path: <linux-pm+bounces-14551-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D95B97E5F5
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 08:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A4AB1F21142
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 06:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723F61759F;
	Mon, 23 Sep 2024 06:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DEEQZhSQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013033.outbound.protection.outlook.com [52.101.67.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B64112E4D;
	Mon, 23 Sep 2024 06:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727072811; cv=fail; b=EyZUdcLr119qLZX87gT3G696br6ROAnmtY81U7P6yflfF2IGiUiIdJn3/zW+k7JE/gwhVZy+gJFpvNbbhEU8oGOBdyHYka/JAHkx/a7Bl6KaVo6wu7jC4sCZQ1JmZHg3QuzigfvtVB3+udEgnx//F0s3zY6i2PAN78+KHXHGlS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727072811; c=relaxed/simple;
	bh=k9U6d6bEC6ySP8rrpU4/Me+dl79mWlUt14GrntR4M/4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CzfCxjF1zTnQDMfmc1gAiYeHTcQIbYojplWKqN735MDPdEUqO79RuWMi+DT8CEGUXO/ACu4RCPdUc7LYP/38YYDzEV5KVrg00h+GnrM4BgC4W1xpnf6rXu5SedwGt7B9iGgc+nLG7Cb4/j8V28acTvjfzqhdsmTwgxH0eh4HXUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DEEQZhSQ; arc=fail smtp.client-ip=52.101.67.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R3uOtwxMv09HMOuORlGV9GgiU4VMC29kxcSaU2/SiE60dKmwHN5+R7gLTHyzVf+LERW4fORDSSdcScDnm6Qf7GG+AM4eS/D/lBneDflWlUFxOPjUUg9T2esuFLiG8NCp3TtY+WGw6tpztJW+QwQdxshBi/c9UoIZZFy1OXGXbL6XmAwkglDLSnljwCr3avSVvWqdDSO6nq8eKgSf8l3Q1LKIuygxSFRZLleRc+WOJLgsm0vAZualUmluNeUvXnfIDqBj9wb6sKzeNFXu7t6fEn5xZVrvuAUD5Kmt/Bxrjpla9qs5GAzCDyn3kMXcRP8sGEO+2xzRi5CV+CLcOTtVvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9U6d6bEC6ySP8rrpU4/Me+dl79mWlUt14GrntR4M/4=;
 b=c5vM4foRgnq7Ed2po5CGBzYUh6hZ+u6zjrIwy/HcC0YpK8rG2lzCEzWwk3z9xym2KE07c2pE6wXgbmND80vjC1+iQxAhGuLONuzxo3HEuHy9owaxfKSDxQpV/pveNXcTyQJ3ad/yX/VchAI5i9rw7oZcV3JWqPIPu2C6fz8YOX6ZhtZmwv87Yv6Dv85rlBxTZ0zwsgOxpDvsQlsAtJg5xktkys2NyFQSc26O079UptPTyI9+KRCk1j72mVbs4rIa2dN6tO8+44s1YfoWZSXiSVXOfK78lKxq0+sp5rmnfBAQx8BSNb/4t/X4e/Zr9Wts/e8Y+qRD3v2Y5xHRj6gVaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9U6d6bEC6ySP8rrpU4/Me+dl79mWlUt14GrntR4M/4=;
 b=DEEQZhSQs5v1nVWtmIIcYYy2FdNQTsSPQ9Ur2YkYgvJ40t9tTWO2T5BKnEBnzO6J0w3LLmXSAj5YAB3D9ukXRP2WNtHp4FU3Fy4731NdkhUzul+VUvIPO+EEhofT609FZtMUsWcZYxYCnQjZEhNMLrvLOPGLuazRvpJQenp8LJ1foKfsuxAvyGwSrTlsVuKok8W8j9wqzrI+yqcUPq0FSU9ie3KbvBlNPuAoZIE2zRi/Q7GDEGdHVJiUEahc5aN7FniV+8hO5g6gHeLipI/JnaFaowUxbeZv9jaf6TI3eteM2R3bCQbhCoOy4cNjNvUvrunRr07qBhWPTC34MNW96Q==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9959.eurprd04.prod.outlook.com (2603:10a6:102:387::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Mon, 23 Sep
 2024 06:26:46 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Mon, 23 Sep 2024
 06:26:46 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "John B. Wyatt IV" <jwyatt@redhat.com>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Thomas Renninger
	<trenn@suse.com>, Shuah Khan <shuah@kernel.org>, John Kacur
	<jkacur@redhat.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/2] tools: power: cpupower: Allow overriding
 cross-compiling envs
Thread-Topic: [PATCH v2 0/2] tools: power: cpupower: Allow overriding
 cross-compiling envs
Thread-Index: AQHbCotf4uMyP70W+022nGBUmwhal7JfT6uAgAEQhSCAAAHVQIAAPpqAgARNK4A=
Date: Mon, 23 Sep 2024 06:26:46 +0000
Message-ID:
 <PAXPR04MB845992183A08AAF05C339C05886F2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240919-pm-v2-0-0f25686556b5@nxp.com>
 <ZuxTjy7I-pZBcXa0@rhfedora>
 <PAXPR04MB845910C56EA61D3215DA5452886C2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <PAXPR04MB84591B0819F847D79548CFB0886C2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <Zu1uNyTWDgot8cQY@rhfedora>
In-Reply-To: <Zu1uNyTWDgot8cQY@rhfedora>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PAWPR04MB9959:EE_
x-ms-office365-filtering-correlation-id: 235ad29c-accc-4f06-00ad-08dcdb98b2f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?wCKjAaTVBv7epeJA4kdQyp9fE3+A5oC+8aOp48RNgKvhRcT7Yz7/gtErRxI4?=
 =?us-ascii?Q?mgam789/NT/3iVbTNaa4h+rWl9WDgbhue5V/KRgsD73u0QLXuWnnXMtfokdV?=
 =?us-ascii?Q?//fJUjFxAJvrpWfa9yGsbWsqamjVCpEUwpIDQK0ycpMCjuzPlRS3bwLseEMv?=
 =?us-ascii?Q?j7DFTLWBrPBNSZkS7OwG/CmxqCF6efbBkpzPtxIKbvRGtk7ThSdNbU/yZlk3?=
 =?us-ascii?Q?eWgtgEAi0I7QBDK7B8X+T+bXfv0bARVXIQynOlECaaPdp6Umno9FPeAcvrmH?=
 =?us-ascii?Q?08w2M4yyQgAW4ZHhjvd8Gav0klu6F4YK48+qY4KB/nkfUI+sCKUM2pOV1z2O?=
 =?us-ascii?Q?7QBxHW1fVwyZgftun4fvTThWrX/+qZ7xT/N0Rfo7z8KUIASr3uJtA7cNlYY/?=
 =?us-ascii?Q?oxEhRGudTgMJFA8DgMkPal3LM/eD3ZIs866v7aMlF3dkV9+X6pIYS17++FZz?=
 =?us-ascii?Q?ViotwD72mL0k6t2/IO9FR/cBnJ1bVPUksaOD/0zJUvvS3xbc7kNg7uaD02h8?=
 =?us-ascii?Q?TOYavhhlgokypgckQ09vwCXggzawd+qTMVJ699rbtUK+KmBaPCUwsjzVAlAu?=
 =?us-ascii?Q?I88L/3WO4zNV70gpaILP5jQRzKytKXYk4mbBJIem6Rxe+33V4pom9hv1WUEt?=
 =?us-ascii?Q?enRQ7J8smGl2kY1fz+dFi7FtZ2XgdTjmuo/bTnTcRbXpBs7NToODq8Y91Iv4?=
 =?us-ascii?Q?fIHMvC9XiOyB78P4ZF02c+wZQQkeXvWd8Ik3hCpDvYjZ1ZLTxF1Rtbivxv15?=
 =?us-ascii?Q?3pRzF+XthJbDGaOMNXZnTR8QFV3D1smMSN3A+y+9E471lnbnab+agysrJS3f?=
 =?us-ascii?Q?RKlYG+y/N3x7ls9st8lbzaJfg6fEFyPYZaizeAPS0FEpA67HN5LK649PsHk8?=
 =?us-ascii?Q?zp5XG7mYnwWT2u+7uAf7YPi9nOfyEpz5acAlMrWptwt6LLzZLn5PcqwTjbBC?=
 =?us-ascii?Q?ZZDhZ1mBACG1iXg2320b9pFmmlOFEqA77uGeY/IBJ5FH0oYMTld64a2bYGoG?=
 =?us-ascii?Q?GgGXaRmRf1bNWIfw0wJTygzSLt+V3fg2jiCJ0E8IcglqiRWGAiY5BZEvYjoj?=
 =?us-ascii?Q?KHAOjzRpmmaZNndMaonJ8vUw5eZx93Ld8hlVLGWud8XkRkRLYq/DmGbQ88al?=
 =?us-ascii?Q?P3uczr7o/OYOx7SBW5d+hqi6+UT+XvSnIthmaazejCrv8aAQQ/rn+o21Ns9u?=
 =?us-ascii?Q?zcSGllTk/n7147xY8nuRLMmVvpgoLUldsZmVAL+0QxWTDwCAg+FPM6XKiPXS?=
 =?us-ascii?Q?BQE3j4WAnzI7PXGQY5P5Vo2KFy3JT+cAD7BwG88dhET6gQpeXqociIM02e4b?=
 =?us-ascii?Q?Z+6S6jdpSYUs+7INHZA60GHsBS2TFX15ejnfvs8amS65mA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TqfD8hyNS++R79oP/C3boy/lmhgqzkeJj8n8IfaA8bm2XxV33rKcAnukhmr+?=
 =?us-ascii?Q?Tu0RCL7U4qr1Va79nz3LB8/iqz8ZrviHUOSDnlHubhCqkvCZlwIbVBanLmO7?=
 =?us-ascii?Q?FemO6Ch3xnsrQGbA/Ofc+oaF01Z7ah83ouWzH8WGKl6ZU1kGl58DzZGifLsp?=
 =?us-ascii?Q?x9kZ+lt2MuWx5zC+098oOCtCfqeMd6sGPpZKksHo6Geh/p/jZ8jMzUjD4g7D?=
 =?us-ascii?Q?zIFKPe98/hLgIocyKXqqUCBuxHq8PklsXkFaV7IJHs5iumIm+XMSrKsmoOm2?=
 =?us-ascii?Q?YNeFfKS73go5i4qSUUztz0lfBK+Y+vSqm0mzBhphnjWQgfp7Sbcb+aSR3ox4?=
 =?us-ascii?Q?OUqGPCorof//LwcNYCWBP+v7LTVHq3CWGKUQ2ZPXL3y2FuA02l0lf89nOthX?=
 =?us-ascii?Q?fVQN+pqqGtRSmnXYv5CEYcaN4gsm+iSvqnAWgWbNWHPs3jyZg497FQGxI+wu?=
 =?us-ascii?Q?jYFHyNAQjk60zDFqp23Xx0qJc05JPr6GI6FoMkyWrpAygi91GJVBlcqxeHC6?=
 =?us-ascii?Q?Slz2BhCJU/2/hiQM9G+eX4bNnvqxMRH4x2iLbzHpVl6Gt+xalb+9bMcLxz2w?=
 =?us-ascii?Q?00uUkcQgSOe+Mm5p3zFlp1yGETgnYC6jZ7JsEPjjonR4shsS+eJDu11MFceW?=
 =?us-ascii?Q?aqm7OGgpaVdgsZGf2fRYv7W37P8HZg1hvmjmtyi1lsKokz7R/OZhAFrGRUDp?=
 =?us-ascii?Q?mq17B7u3qHYrg0fFEXDl+KqvLGZzfCpgD2tU964Ouqa2YNMC9QcIEXGWsd/7?=
 =?us-ascii?Q?ddJpyIBT4x+6RRpyy7dYai/z3z6Fevz24IjvTg9wVDiyY2KIhnvbyrdOlxmq?=
 =?us-ascii?Q?yW1xQxyEjZ2f3NQ0R1SdGLEmOS9yrxo0Ta5Ct5cRLLWgDi83sUxPpHiekkMA?=
 =?us-ascii?Q?nelnCecf7B7lu0Fw6WKoeuWeQ8D6fEMlM4NqcHwYNO3oWGSCR2cGVE0oNKk6?=
 =?us-ascii?Q?wsPOJ6ySs6AAcACF0OhGfpPOIF6A4CIw1Twj0S5cgTC9mesjY3MeLA9uczXY?=
 =?us-ascii?Q?heWq8mG649KkWV05SzBAV99NAq5U5yJsiMZz+xlyZVCFzlM6KeMrkhbxP4LY?=
 =?us-ascii?Q?GspgrK8wUsJdmz5pluHE2CQ0mTCdaKOR3pXzZo29ODLNyG51ttKN7ButtJrU?=
 =?us-ascii?Q?6I4FVJLa0tbeejLQ8xeQsog2zf5VtCNHcr/HIbPEGKEPrR0FfBsKc+y6Hd4p?=
 =?us-ascii?Q?/X7PyGz3b6bbbdmhx3EQQeu4y1MKov9F3qLjPNrIiBLmVpNQzGC7uHlYUjxb?=
 =?us-ascii?Q?jc9URtUQS+ijX56NQM0yxMvM4hLufJ+K/8jejEvH8bjIhd9JOSEivsDgJK30?=
 =?us-ascii?Q?H07Ki/0OzpVCtB/TQABehGP/B48AfWU/lvzMx4SM+dGcwElKkHkZXHvcwRJi?=
 =?us-ascii?Q?UOIEDn2Wi8CTeMpX8aWOtzVMMSEfwVWAnDX2A+/ya6dfMr/5i0Jn9pA3Tnap?=
 =?us-ascii?Q?XP4h0YP1y73RjM5rlRJYGNN4YhlNVdzTkn5+GYyUEECMsu7qmBjZH863FO97?=
 =?us-ascii?Q?bX+zOmuaN8xYc0pY5yhe8cNhpK7lgDqh+sqrpkJmXvquPfh0CjAg5+Zopq1n?=
 =?us-ascii?Q?s0Xim/EWbKGqdk2DHQU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 235ad29c-accc-4f06-00ad-08dcdb98b2f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2024 06:26:46.3281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rO0+cSMsl4zIljUjnadZwmYlW2h/MjG2Ah5oYb38ZskZTdr+UndcYXT/RVuSykR3fL+yS/2+WVwcRgds+2w3dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9959

> Subject: Re: [PATCH v2 0/2] tools: power: cpupower: Allow overriding
> cross-compiling envs
>=20
> On Fri, Sep 20, 2024 at 09:01:49AM +0000, Peng Fan wrote:
> > > > Not sure you need 'tools: power: cpupower:' in the cover letter.
> > >
> > > Will use "tools: power:" in v3.
> > > >
> > > > > pm: cpupower: bench: print config file path when open
> > > > > cpufreq-bench.conf fails
> > > >
> > > > I do not think you need bench either.
> > >
> > > Will drop "bench" in v3.
>=20
> I do not think those alone are needed for a v3 since I was corrected on
> the changelog; at least as far I am concerned.

I will do a v3 to convert perror to strerror per the reply in v1 from
Shuah.

Thanks,
Peng.

>=20
> --
> Sincerely,
> John Wyatt
> Software Engineer, Core Kernel
> Red Hat


