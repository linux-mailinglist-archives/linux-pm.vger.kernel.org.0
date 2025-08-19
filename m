Return-Path: <linux-pm+bounces-32611-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA83EB2BBBD
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 10:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58B771BA0654
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 08:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B38731159E;
	Tue, 19 Aug 2025 08:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="sVkBBU0h"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011067.outbound.protection.outlook.com [40.107.74.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD823112B6;
	Tue, 19 Aug 2025 08:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755591924; cv=fail; b=BeYxGYWVqCnwAmxi2Ke5O1tqHcTVVIaOz4lEnD/ygwxCmH+CYgi4fr8AA0ub2a6CQgU+rZVSBSY/td+qAiSjzsiR8IC4mVkHpc2tOJZ/zuC9bvIFQBjRteo4ATg/a8ZJEwQUleM4bGNODMwl7zMM8UUBaYU8wU+OgEuOVH/Zs1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755591924; c=relaxed/simple;
	bh=uhT9sbPYlHPqfopTbIBFNBZ1vXFJa90VEqENcQP9yqM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jf4+itJVhHFF1YtObBFo/lKJa9aHdaMSzr4dqiNiuVn38aRjdbLiiNeFe0EOIay1Nlm5/uXZNT59CC5KbB3DiKN0MAqyta6x7Wphgh5Qk3zW+m4+5h7rhDMBVXYv5JPdYs4njMgoPm5hrLcRdnkWK8u1BfJwUXT7EWqP59l3QpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=sVkBBU0h; arc=fail smtp.client-ip=40.107.74.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yz5Lig9jsM94wDcpOYElJBorfc+UMtpPQH5REmugu08QgUOiVD09pD/a6A6ubJtPmboekFKrwnEPK+qHBCjTQBeRMVVoA7quwnhgPuHogTEs7aukpEkd4ulHHKRYK/fCEg7L1jADZZ1Idq8DYoFMsnenxbzjx9zGv34QTk5kZIHcuJx5zjjhBCWrF1g89b+bl4iEYbMTxGyWpRauMycxxoNGtD16KqqvxZZmatH4AmjTj6/MSTO981mY7QKkFzd7A2ubLV7L17rCBCLmv8p9lSPoZWfD5sHHvYqZBxU170R0M7Pmsk7xrS3tAn3yAYq8cKvj3kVIcyenv4euXvqkMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uhT9sbPYlHPqfopTbIBFNBZ1vXFJa90VEqENcQP9yqM=;
 b=wDvZk6g++ZGFKVXi/6nWuE0ZEZk760tL+NF/RI/mlVKwvL0qr6hKsggJ5/qhxJqY2VPiIIYeUA+N7utFzZFEp05TT3cFfZ8UL87XIA8mGkEiZ8rD51GMVmsDiCpfox8RuFwRheM0zWocQKEWovk44tkZylxXcZlLPEND1thdH2aXxyWjAOsYJnBWEy3Xb6XbOVWPR0JjrUDl0K75u1afcXWB/ppAkXlciXifAq8T2MLpGnsQ1DGwZAU4tOnNxp+0/F2tPy0ZbytVod1gGk4l/wQa5yvBNBCWyJyBqJ1BPLlJ6eTiClNSYQ6ToDmzwWBKoITqPfM0qEbCg7D2LIx7dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhT9sbPYlHPqfopTbIBFNBZ1vXFJa90VEqENcQP9yqM=;
 b=sVkBBU0h3f2dmEy7WWhqFZ6f8aXPcyS9xkJ3vFD2n+Dx079Stm1GtBWOGMl/e+1Qa+fb4j1ham0/SlI6AD5B7Vy53UlKR1EMhZcFAa9PIACv2yz+D3MzWqv/bSU7AOdajCCKaZ1zdIjHoIt+mbhabfNpMgJJfYSkKQojsRuPKdE=
Received: from OSCPR01MB14647.jpnprd01.prod.outlook.com (2603:1096:604:3a0::6)
 by OS3PR01MB9659.jpnprd01.prod.outlook.com (2603:1096:604:1e9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 08:25:17 +0000
Received: from OSCPR01MB14647.jpnprd01.prod.outlook.com
 ([fe80::40e:e798:1aea:ca82]) by OSCPR01MB14647.jpnprd01.prod.outlook.com
 ([fe80::40e:e798:1aea:ca82%6]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 08:25:17 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: geert <geert@linux-m68k.org>
CC: magnus.damm <magnus.damm@gmail.com>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>, "daniel.lezcano@linaro.org"
	<daniel.lezcano@linaro.org>, "rui.zhang@intel.com" <rui.zhang@intel.com>,
	"lukasz.luba@arm.com" <lukasz.luba@arm.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"john.madieu@gmail.com" <john.madieu@gmail.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Biju Das
	<biju.das.jz@bp.renesas.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v7 4/6] arm64: dts: renesas: r9a09g047: Add #address-cells
 property in sys node
Thread-Topic: [PATCH v7 4/6] arm64: dts: renesas: r9a09g047: Add
 #address-cells property in sys node
Thread-Index: AQHcEF1QZNTgRFFH3UeI81ZiBc9OsbRpmV+AgAALHUA=
Date: Tue, 19 Aug 2025 08:25:17 +0000
Message-ID:
 <OSCPR01MB146478959897629D628727CB5FF30A@OSCPR01MB14647.jpnprd01.prod.outlook.com>
References: <20250818162859.9661-1-john.madieu.xa@bp.renesas.com>
 <20250818162859.9661-5-john.madieu.xa@bp.renesas.com>
 <CAMuHMdVV3tH-Mnkb4z=_3Fu9_zaB+ysuFQYni-ss+Sm_JmZFng@mail.gmail.com>
In-Reply-To:
 <CAMuHMdVV3tH-Mnkb4z=_3Fu9_zaB+ysuFQYni-ss+Sm_JmZFng@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB14647:EE_|OS3PR01MB9659:EE_
x-ms-office365-filtering-correlation-id: 168cf6b7-8bbe-44ac-5ccc-08dddef9edd3
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aURSVHdnREhlbUhxNGF5VlM4V1FrZjJLQUI5bGZnL09YNWp1aXBwREkyYjJ2?=
 =?utf-8?B?ZlRHNlNhN3VCZ0dIM3NmSUd2THBzRGllS1N5MzUyVlRlZ3dML21laTcwQ0s0?=
 =?utf-8?B?WkhQNzduTExOVVA2Z28wbE03RFF5YjA2ZHFZSHZxMFQ3bllkZUVkSG0xOERu?=
 =?utf-8?B?T0psdXZvaGVNalFoS1krNXZIaEg1UDRaWTdISzYzRUZ5N3NqaStHNUdVbFFU?=
 =?utf-8?B?c2dES0NReDFyYm9IS3Q4czdGZW5NbWJpZFV4OUZQSmhuNUdwbkZZUzZmdUJV?=
 =?utf-8?B?RSt4dDdYd2V6dGpQZUFxSGZOTURVaHlyU1Y1VVFyWHFCSUZtL2pQeGt1SEcz?=
 =?utf-8?B?Q0ZFci90YldOd1lCZHg4ZVoxODZNalh3dnNEa21XeHU4c093dUc3TmtsM2lz?=
 =?utf-8?B?b1ZDbnphYjRKbG5TWlZsc2dBZUM5emc5R1lQQ1Bjc2F0UEw5SnZCKzFTSlh4?=
 =?utf-8?B?a0FFZy9Jb1hHcXVxV2FiVmpXODYrdm1iUFpHM1dYdStkSml3TTNWa2R2STZl?=
 =?utf-8?B?bytzcE93aUNYeVAyOWY5cC9Yb1lNNHZJdzcxSC9YeFJ2ZlZmenl2d0srMUJI?=
 =?utf-8?B?ODUvYk5keEptUUc0RmhiZ2ppN0lQUFFrTEE3bnQxTXlFK1JJTjJQVThzb0Nn?=
 =?utf-8?B?dlU5ZU1RT0F0eVM3TXBDT3BqLzZmMkpHdjAvYW0wMXYxM1VpL0dHdmgyZ3Rv?=
 =?utf-8?B?U2E3TXFrZ1JnWHRmbEZNZ2tsWk5VS0F6SCt1cjBBQkpMZFVuQnRvTmlHMVB5?=
 =?utf-8?B?Z1poUVZsRm00Yi9jdjV2WmtXRnhaVEJZb0pxUjZqbmpvcW9IM3ZEVDZKR3RI?=
 =?utf-8?B?VnJpVVdaNWhveXZLUkF2ZVRoNXo3d3JnUW1EenhydzVXQTNQZms1ZmR6Rm5I?=
 =?utf-8?B?TlZ0NVNjb3piZnl2amppZlZ4QzBZRlpXQ3d2Tkx0RlJZL1l0QUpJZENhV0Ja?=
 =?utf-8?B?R2QzaU5yQjVyY2dENzB6ZEU5US9WdW40d2JrYVZvdytzZkRoZW9rVlZvcDN0?=
 =?utf-8?B?VnR4L00wWlN1Q0h0dzVXREViNXZ1WitwZkVXTmcrZWhySUlMZXY2NzluWCtw?=
 =?utf-8?B?T3FMYVVjMDdsS2N2Q094SVptQnNobVdaNmtFdnFnVXpQbjE2K3JWQXA5SUZz?=
 =?utf-8?B?RmhOc3hoc1BheHdIbVkvSEd0ZnpyK3l6Z1B0ekxKVXRlRXpVQzN1ZXNDTm8z?=
 =?utf-8?B?ZEd4NzlaZWdrN05GdEZmUjFJM1pobXd4bERkUGhHUFR1d0Rxa01ra0FsOHdx?=
 =?utf-8?B?WGtac245ZFRFaGVDa1NvWGxabVg2WTJObDQyeWhSNW5mN0VjdkplWjAvcEtE?=
 =?utf-8?B?N0VaMlRyS2swcDUybEhUVS81aEs2bUVKNjlBQzR2aGlRaHFHL3ZpdWRxUWUw?=
 =?utf-8?B?c0gyNzd3ZWc5UmdlaG4zaEhkaG9Qd3NUa2pBc2tuUUJBVndQNGRjMEladmRi?=
 =?utf-8?B?TXRCS1FkOTV3QWx5RHE4Qi9rZzRndkFQUXYxT245UEEyaWowSnRxSHRiWE5n?=
 =?utf-8?B?RkdNYXNtVDl4Sk55bm5mTlQ3ZlFobHM1OTFzQ3JtVlBCRmhIUm5Wc3ppbWhp?=
 =?utf-8?B?Q0FTbGNvSEI5dEJIQ0pFOExMNG5nbnFuSERCWlc3UHBRN0lWSHYrSWtJcmsx?=
 =?utf-8?B?cmljMEw2VlBYenV0M2FtcURzQVA3K0xsalZuRmFvNjZUNFdDaFUwbDk3T0x1?=
 =?utf-8?B?azJ5WjN0VlMzV2VXVTkyN2hxVmFkSDJNOUljTmVaMFBUNVA0SExxdG5PN2RK?=
 =?utf-8?B?dzlaOGFNVnplT243Y29weUp2cmZmcHQ5WFhsclJYeVJPSkxxaDFHaGc5bTFm?=
 =?utf-8?B?NXltTFFwUzE0d3JQVUxVTUJXc0Q0cE11dE5qTHNGS2lwMGtQSTBZanVhOUFD?=
 =?utf-8?B?dlhwZ000UHNxaXh5S1BNclpIZWRGenJQTiswM0ZidXJ1Qm5sZFU2ZjBRVmhP?=
 =?utf-8?Q?YRXGbGZk6TM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB14647.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b1FHRTBwdTFzZ0t1aHBhMFE0dWpVNE9NenRPVmVLQjkyc3lWcE41WXFBa2pY?=
 =?utf-8?B?c1JmWk1iajRvd1dhTVAzRzRLbVFJNi9BUEpNZ0MyeE5YMWRvZWUvTE1KRFht?=
 =?utf-8?B?bGI4NENjajlrSXc0UFRWVmMrY1NGUnV0S0UvTlJyU2E2K3NzemVZZ1daVVFG?=
 =?utf-8?B?NVZ0Vnp1QWVVdGdqRCtIcExVSnVJT3I4ZnRyam1xOEtxTVpPanRRcU5jYUxx?=
 =?utf-8?B?WjJuLzB2WENRbHErM2hZS08xSGFZbEptYVNpSFZObWNMZEp6OGc5U0o2em9l?=
 =?utf-8?B?RWVRcklQdE1LYTdxUURDU0t5QXZaMm9ydVNYNzl5SDlqbGpIRzcwNUVMUUlG?=
 =?utf-8?B?OEVwNUZoMWFqNG92S05QMUdvV21Vd1R0TFhkeGsvVEtJK1VHRXR2QUE2QmpW?=
 =?utf-8?B?ck4xNDN2ODFGM1pwTzRnWjl1eWd5T1NHdk8rYm83TVdlejRjN25nUEdWekhW?=
 =?utf-8?B?U3NDYWo4eTEzVEViS0pqbW5QK2hJMS9XemM2ckR3YWh3c2RkUlNSRHZvMENG?=
 =?utf-8?B?QVc1RVBSY3ZWQVhoOU91QmRudFIzOGpSZ2ppZlBsa05iRUJMUjNBa0ZuVXRC?=
 =?utf-8?B?bFZ1YmsvbFRFU0F3N21RelU5U1llNlBoZys3M00vSzA4OC95TmNsLzdtbzdD?=
 =?utf-8?B?dzFPMGtyOElReDQ0WmozSnVjRWdieXRORVo0dkxUYzVYaXFabk1Pck1teUtp?=
 =?utf-8?B?TkVyVnVvQi8wUlRJRGYyK3ZJblc0bzJ5a3VnelBKVU9kNDlYNTlYUDcvZUNU?=
 =?utf-8?B?N2lVODBRbHNHcDN2ZnNkc09oUHVicHl0QVM1UnNVMlFwRWxpN3RRN0xwUEVz?=
 =?utf-8?B?YnNRU1FQTnlONldBdjB5dGNaN3VsQThPL3prTklmU2VYeGtZdGNRT1h5MjIw?=
 =?utf-8?B?bHAzcmVzTkpSLzZ4ZkxTSmMzNUVZMGZtU012Y3BoYmgvak9BODhzOWduc0F0?=
 =?utf-8?B?Zk9XNjhoNGJWK0Y1NGQ0VUtqMUhGUFhCWUFJVkNMYWcrTnNsajB4bXlocnYw?=
 =?utf-8?B?SHp1T0Iwc2NQMDZFUDZUYzJ2K1RsK2lGMHhOcnBlcEVIWUVwZ2V4WkpmTDA5?=
 =?utf-8?B?Y1pSUXI4clNTTlBKcUhjTDBGMFMxQXcyTkdMUzFDRjA0TzhOdXhyS0dobVVP?=
 =?utf-8?B?UmhoZTFxdW56aG50ZmwwZHVEQnJyWEtWMWRibDAyOEhxR2t2ZVZ6clliaC9o?=
 =?utf-8?B?S2RTOU5TdFh1RVlQb2F5OVhaK3VTaksrbUxVelNybytTa1hEL2MwWmFpT1hp?=
 =?utf-8?B?WjJQNXR5TkloNWhBY3lKT0R1SjE3L2FPWEk2QnhGS1JEejlkL2U5MzFNc1BH?=
 =?utf-8?B?NEtUREp5Z0lRcjRWQ1haMXR6R0tyTkE4NjIzRkI0bWF0VlZpQis0M0Q4NGxC?=
 =?utf-8?B?YXYrRlVwMUJPTE1ZbXJ0TGZ2aG1UeGNrbDdpdXg2UGViWlJIY2pRMEhxUW5P?=
 =?utf-8?B?YXhPaFJaY1B0aUxZaXc5YURQbkpNZDN4R05DVUhIbmg3bnBsYmlRLzhqK2tM?=
 =?utf-8?B?N0wxdXdtcmZhZUlCTVV6eC9BcDRlVTk2Qnp3aUhMZVZDcmpIWVpLM2ozMzVl?=
 =?utf-8?B?dHpNZVkzWndsdThacHJZbUhmaXJIdDZkVkhlM09SaHNKczFsYWExamxoQTlp?=
 =?utf-8?B?TGNTQ3RxZHE4SWtTVHhGUC9aUWZhVlRuS3drK1VKVkJvcnBpckVNdHhsZTRU?=
 =?utf-8?B?S3liYzBBUERXcDlvc2M3TUpMMmJqSUdQM3dnMXU5Z2ZrRlVKcXk4eFRxNDRF?=
 =?utf-8?B?aEcyKzV3bUVad1JoUmlIUzlwUExONitFbFlWS0ZZZUJQVjhra09udkVhM3Ja?=
 =?utf-8?B?Z0M1WDVWNUtPUFFxdTY1cGNwSlJndmo4NmtPVVBuVzE5ZE50MDFPSENCbnp6?=
 =?utf-8?B?aUUvdFRFU2xFVWJ4bTNvZVpOM3V3ZjVYWDY3dFU3R2RReHozYkNIdUh1YmdG?=
 =?utf-8?B?bmNEbjE1LzRGTzhIaXhTR0hOSlNVcEFjckYwQ1ZnTWtueG5Tblpzd1dUcm8r?=
 =?utf-8?B?RG5OQ3diTWlTa0FVZkNtb1NBbFpaNFRhL1VIODB4NEwycEc3d0dtNlNOaVFS?=
 =?utf-8?B?LzVISjk3WG1ZM3NWU0VOaU5WUTZFT3F6OU9rdmgzdzZGYytGRWtUN09iTXIr?=
 =?utf-8?B?SkxmUlZjY3QwMjBHSE9wQkhpOGNZbHlnVHNrMlZ3UmptZGhaODY4ZnFpRkFh?=
 =?utf-8?B?S1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB14647.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 168cf6b7-8bbe-44ac-5ccc-08dddef9edd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 08:25:17.4146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j03N28eTqL7YHHlxr3lRjO77Y7K83y3QLJN5/zWygD1HXXPB7giLingYhepWF6uvk9c+QupI217fB0ZiEaTvR0gd4V3F/roqLWjPSZ19Nzo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9659

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXchDQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhr
Lm9yZz4NCj4gU2VudDogVHVlc2RheSwgQXVndXN0IDE5LCAyMDI1IDk6NDQgQU0NCj4gVG86IEpv
aG4gTWFkaWV1IDxqb2huLm1hZGlldS54YUBicC5yZW5lc2FzLmNvbT4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCB2NyA0LzZdIGFybTY0OiBkdHM6IHJlbmVzYXM6IHI5YTA5ZzA0NzogQWRkICNhZGRy
ZXNzLQ0KPiBjZWxscyBwcm9wZXJ0eSBpbiBzeXMgbm9kZQ0KPiANCj4gSGkgSm9obiwNCj4gDQo+
IE9uIE1vbiwgMTggQXVnIDIwMjUgYXQgMTg6MjksIEpvaG4gTWFkaWV1IDxqb2huLm1hZGlldS54
YUBicC5yZW5lc2FzLmNvbT4NCj4gd3JvdGU6DQo+ID4gQSBjb3VwbGUgb2YgcmVnaXN0ZXJzIG9m
IHRoZSBzeXN0ZW0gY29udHJvbGxlciAoc3lzKSBhcmUgc2hhcmVkIHdpdGgNCj4gPiB0aGUgVFNV
IGRldmljZS4gQWRkICNhZGRyZXNzLWNlbGxzIHByb3BlcnR5IHRvIHN5cyBub2RlIHRvIGFsbG93
DQo+ID4gcHJvcGVyIHBhcnNpbmcgYSBhY2Nlc3MgdG8gdGhlc2UgcmVnaXN0ZXJzIGZyb20gdGhl
IFRTVSBkcml2ZXIuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKb2huIE1hZGlldSA8am9obi5t
YWRpZXUueGFAYnAucmVuZXNhcy5jb20+DQo+IA0KPiBUaGFua3MgZm9yIHlvdXIgcGF0Y2ghDQo+
IA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvcmVuZXNhcy9yOWEwOWcwNDcuZHRzaQ0K
PiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvcmVuZXNhcy9yOWEwOWcwNDcuZHRzaQ0KPiA+
IEBAIC0yNzgsNiArMjc4LDcgQEAgc3lzOiBzeXN0ZW0tY29udHJvbGxlckAxMDQzMDAwMCB7DQo+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgcmVnID0gPDAgMHgxMDQzMDAwMCAwIDB4MTAwMDA+
Ow0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGNsb2NrcyA9IDwmY3BnIENQR19DT1JFIFI5
QTA5RzA0N19TWVNfMF9QQ0xLPjsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICByZXNldHMg
PSA8JmNwZyAweDMwPjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAjYWRkcmVzcy1jZWxs
cyA9IDwxPjsNCj4gDQo+IElmZiB5b3UgbmVlZCB0aGlzLCB5b3UgbmVlZCB0byB1cGRhdGUgdGhl
IERUIGJpbmRpbmdzIGZpcnN0LCBhcyByZXBvcnRlZCBieQ0KPiBSb2IncyBib3QuDQo+IA0KPiBI
b3dldmVyLCBsb29raW5nIGF0IENsYXVkaXUncyBVU0Igc2VyaWVzIFsxXSwgSSB0aGluayB5b3Ug
Y2FuIGRvIHdpdGhvdXQsDQo+IGJ5IGNhbGxpbmcgb2ZfcGFyc2VfcGhhbmRsZV93aXRoX2ZpeGVk
X2FyZ3MoKSBpbnN0ZWFkIG9mDQo+IG9mX3BhcnNlX3BoYW5kbGVfd2l0aF9hcmdzKCkgaW4gdGhl
IGRyaXZlci4NCj4gDQo+ID4gICAgICAgICAgICAgICAgIH07DQoNCkluZGVlZCwgSSdsbCB1c2Ug
dGhlIGZpeGVkX2FyZ3MoKSBvcHRpb24gYW5kIGRyb3AgdGhpcyBwYXRjaA0KaW4gdjguDQoNCj4g
Pg0KPiA+ICAgICAgICAgICAgICAgICB4c3BpOiBzcGlAMTEwMzAwMDAgew0KPiANCj4gWzFdICJb
UEFUQ0ggdjUgMC83XSBBZGQgaW5pdGlhbCBVU0Igc3VwcG9ydCBmb3IgdGhlIFJlbmVzYXMgUlov
RzNTIFNvQyINCj4gICAgIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnLzIwMjUwODE5MDU0MjEyLjQ4
NjQyNi0xLQ0KPiBjbGF1ZGl1LmJlem5lYS51akBicC5yZW5lc2FzLmNvbQ0KPiANCj4gR3J7b2V0
amUsZWV0aW5nfXMsDQoNClJlZ2FyZHMsDQpKb2huDQoNCj4gDQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgIEdlZXJ0DQo+IA0KPiAtLQ0KPiBHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBs
b3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LQ0KPiBtNjhrLm9yZw0KPiAN
Cj4gSW4gcGVyc29uYWwgY29udmVyc2F0aW9ucyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2Fs
bCBteXNlbGYgYSBoYWNrZXIuDQo+IEJ1dCB3aGVuIEknbSB0YWxraW5nIHRvIGpvdXJuYWxpc3Rz
IEkganVzdCBzYXkgInByb2dyYW1tZXIiIG9yIHNvbWV0aGluZw0KPiBsaWtlIHRoYXQuDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0gTGludXMgVG9ydmFsZHMNCg==

