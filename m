Return-Path: <linux-pm+bounces-22062-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF03A3580D
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 08:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 039F316D8CF
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2025 07:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B9221638B;
	Fri, 14 Feb 2025 07:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Xb3PWzoQ";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="f+JXnw7V"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B269A21578D;
	Fri, 14 Feb 2025 07:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739518876; cv=fail; b=j6pQH9dX+qToxYA1GMwqZBNIpN9baEyvWXS1Y6YnvKiDTejlQTxVLd6MFNX0sjwbt7la+QPSGG96c7QIjJ2dcniyPUfgS/5UotWLlZpYmiGubvQoYDxmW3M4wzrguQCkvgLbUzQLUf7/Q4xiJJH/x191aSlj3L2Irm4tbFfxHPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739518876; c=relaxed/simple;
	bh=1bLNcD3Jg46nvsyVLQHLrycvxjfgeCzMx8FYjbgG6h0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fLnAxDGHUA8chfiCRU9hDmtIvm+gkqYtyZzaKqRuK4N/4jSCTfmZmuLdBEEuQakT4Wn60ZqONe4C98jGvpSDnyoSDXQ7KTG6EGBKCkltzyZfQZbmHLo7ljOH6rTIH5tPubJPTqTX4gD5wK1J4rz9u7BuE3EFoOHicCDUNZm7nwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Xb3PWzoQ; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=f+JXnw7V; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 0c119998eaa711efbd192953cf12861f-20250214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=1bLNcD3Jg46nvsyVLQHLrycvxjfgeCzMx8FYjbgG6h0=;
	b=Xb3PWzoQLrFG/eCNhDTgx37EWH3unnYFh+f8p5waQZInNiPOtiamx5W1hTlTWRTWNyLnGreIzmhEIzsM7i+NXT8/F1DbESfy/C+SKv7JHxPGOWCx5tdyS1HB+USZt7m59IFe3kEWCE7nRf9+8kowQmAKZqqmvRD8pXP3vezokFc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:deccda47-318e-4426-a746-0873fa9455d2,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:60aa074,CLOUDID:37b0be24-96bd-4ac5-8f2e-15aa1ef9defa,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0c119998eaa711efbd192953cf12861f-20250214
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <chun-jen.tseng@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1431945192; Fri, 14 Feb 2025 15:41:05 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 14 Feb 2025 15:41:04 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 14 Feb 2025 15:41:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V9xSA3FZe5jS/8SdfZY+YOItNiIhwE6yTGvlTVxkS5vdRQnOF7+IkVcFLv9SUGzM8NXIgwnjGFwEAL08gDtFcarf6zwz+77JqznDS7hPjDZ88frBIJrf2kvzSRigF4NsXYJw6OKprrBx4PdGpsBbbTFsmk5q8Yn5PSswQsD+UAbbIV9vMK/rqi3iEYeyKdFdtUccsBX3pHkrQAxNrJ+HfLKnoCozFUelCUdziWxQurzP3dx6EpFb/gD6/7cbdWT5XPGo2XNiRZ8PBdeHuRUG1ZwXbKG0tRlBMIkNVyBlVHcNadM/825LNjpksmi2MosoV+Cx7KOEtqdFsz7abi5lWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bLNcD3Jg46nvsyVLQHLrycvxjfgeCzMx8FYjbgG6h0=;
 b=w1T9VORv6Ajz+AVkW7KlNoJdkmnS1pGxNjumJm4XoBsg/oHDJy5Ff8eT+WFC3P6KJ0cHBolHBkQpmCbHV+yPKQRAlxurjA3LSuerXMrk6UObrfwWf5k8Gv6fJ1Rd6Mi6X3UpaVvdLKLM710B9QCviQvSKDWnF1OXoemkh/KEgNUZDDnn8/1YsCwHl1r+QZgxFuiyzbUrOmyJR+GVappyVBtRSlaAb3y8zEjf0i+Trb3cP1EANrub73Yz+RKsMV192vT6BnMkahz4o4hfEgGP+5O/DR2i3XfjnsrHw9i/+Y2HNtkY4a91cGmVYhsrEYOyIvlwwPLirXcKcqm5tvO4QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bLNcD3Jg46nvsyVLQHLrycvxjfgeCzMx8FYjbgG6h0=;
 b=f+JXnw7Vn4OGZiYpI3TAlzgnp5vyNvzqBZk0UrLU1tYMyn2i4jsWONHB9h81tioCsLL6aPk0iA/7Zfltitv9kQ369yUh5laLirsjV9s2s6GQ4UaPPPEX3Wj0HnFxQbY1cAGIiwlFF5e8yB+beDY+owSR1rWo7qt+i6B6SYNG2gE=
Received: from PSAPR03MB5351.apcprd03.prod.outlook.com (2603:1096:301:40::11)
 by SEZPR03MB7998.apcprd03.prod.outlook.com (2603:1096:101:17b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.15; Fri, 14 Feb
 2025 07:41:02 +0000
Received: from PSAPR03MB5351.apcprd03.prod.outlook.com
 ([fe80::c9d6:2574:8710:24fd]) by PSAPR03MB5351.apcprd03.prod.outlook.com
 ([fe80::c9d6:2574:8710:24fd%5]) with mapi id 15.20.8445.015; Fri, 14 Feb 2025
 07:41:01 +0000
From: =?utf-8?B?Q2h1bi1KZW4gVHNlbmcgKOabvuS/iuS7gSk=?=
	<Chun-Jen.Tseng@mediatek.com>
To: "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "AngeloGioacchino Del
 Regno" <angelogioacchino.delregno@collabora.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>,
	"kyungmin.park@samsung.com" <kyungmin.park@samsung.com>,
	"cw00.choi@samsung.com" <cw00.choi@samsung.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] cpufreq: mediatek: CCI support SoC , the
 transition_delay set to 10 ms
Thread-Topic: [PATCH v2 1/4] cpufreq: mediatek: CCI support SoC , the
 transition_delay set to 10 ms
Thread-Index: AQHbMakE5dwIegzEA0y6JPSWkG3EArK2mviAgJBpSwA=
Date: Fri, 14 Feb 2025 07:41:01 +0000
Message-ID: <6b52c51f4046dda5d9aa3726e9be51c746e9c623.camel@mediatek.com>
References: <20241108063942.19744-1-chun-jen.tseng@mediatek.com>
	 <20241108063942.19744-2-chun-jen.tseng@mediatek.com>
	 <9f9a969f-6ce5-4e6c-89bd-51fe121db693@collabora.com>
In-Reply-To: <9f9a969f-6ce5-4e6c-89bd-51fe121db693@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5351:EE_|SEZPR03MB7998:EE_
x-ms-office365-filtering-correlation-id: bfe405b5-5b2b-4781-8594-08dd4ccaedff
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RGM5MmQ4M052YnhWdXFXUllxTWVZNHFLbEx2dFRUYnFHWVZENTd1NmFsNUpG?=
 =?utf-8?B?MVlPOWlZRGFuaFJnVkxBeVBBZXk2K2RqTzc5V1dWejJoTEFjMTlRb3ZsL2ls?=
 =?utf-8?B?cWtyUTE2NlRqNW1FVS9OY2c0QTlKekt3UkRyYVdhUDJRVS9RZVJsMkJwZHNC?=
 =?utf-8?B?ZjhpWS95ZlBFbmdjdGpRb2dta2g2VUI0bjlTckdULy9vZVNMVExURHVtdm1h?=
 =?utf-8?B?UDk3bkprbGxveGNGbDlTKzRRRnBlVkJxaHRIWjhaVVB2QVJzSkNuWmJvZVFn?=
 =?utf-8?B?a2d1S2s4UjlQVEJKUm92MldNZTJXcTBveDZsUjROUVI5WXZhR0tMUmNBb2lX?=
 =?utf-8?B?Z2lvdXZKT2ZQSU1OQmJ3U2U4Qi9aMmRiVVpuZkFUa2xxV1RrNkNjNkkveHVU?=
 =?utf-8?B?TFNWNyt6WllSM054WGFVSU1LbUQvTWZEclVnNStrVjVwakh5Q0Q3MDFZb0Nn?=
 =?utf-8?B?Tkg4NzJFM1R5T3k1bWRaNlFCQWUxb2k2RnBkR3Rpb1dqbER4aW4zcWdPbmVw?=
 =?utf-8?B?R0NaVWpidHV2K1p5RDBDaytxVExGaXdmUWtGR2pwd0pZZXJhbXVWcVl6M08w?=
 =?utf-8?B?aW1zWmZ0MVBuM2Zzd09oOUk4ckdESGozZ0trTnh5Y2dJUUpJUFoyODNWK21I?=
 =?utf-8?B?MjQxV2QyU200cTR1UG5nLzRycWxycTdmazZxbEZOTE5qTVpVbmZobldlaWtz?=
 =?utf-8?B?UFlYUnZtOW15WGQzOGpvUXErQWlVY1VwRmg3YTE4U1JOR0w2VTZ3eXp4bE9M?=
 =?utf-8?B?VlU4bzFhUkYxYVlmNUhjWTI0VlZWdWpCY2NIaTZDS2JVQnB1a0VTUzhINkJ4?=
 =?utf-8?B?L1IyOUxWeU92YnVVU2xaRXc3NVJIRi80NTRVOTRObDBHenRGT3BVeFMrQXhm?=
 =?utf-8?B?MnBxaVNVVWVnRjc4ZW5iS0RrNU1NdVBVS09JK3ptcHpENExxQnM5aVpVUTlN?=
 =?utf-8?B?dWptWEQwaDZUV05ZQWNwWXplelo5ZmQzclFqZFlIV3B4OFJJWVNkL1RTWVNN?=
 =?utf-8?B?cjBINnRXeU1QMDZZTExoSGNFSjZwMEZsTzBXNnJXSFBBYmhHajNhWFpSaHFD?=
 =?utf-8?B?eEpsdW5DNUZaRE1Xam01Z3NkMEVBWHNWempscUl6bmYrSDRMYWc0M2hRNkRN?=
 =?utf-8?B?V2VpVnRUNmRaM0piWE1QNEFrd0t1M2I3b1dBeVJLVlR2b1ZoWG9hdmZUdkJv?=
 =?utf-8?B?em0ydTFjN2V3cWFlWVNOU3FhajFMaDFWN04rOHNBRzFJU0FIUTFySExyS0Qr?=
 =?utf-8?B?YzkzNHowVTU0Rm1ockRUOUVxYVhncGl2Q0hWVnVZNmNWWWFJamg3c3lJU0Nu?=
 =?utf-8?B?R1pUSTFmOFVXLzMxQ0dRYXFtMTArRUN1d0Y1d29VVm1WWG9yeVZwVUE5OWtw?=
 =?utf-8?B?REJBYXlGaWl2eldNZUoyZ01iWmxHOHovb1JoZW9ZSXlPYS9icHBJTjJHTzZR?=
 =?utf-8?B?T3dUd05USlI1NHJtTjF5eStNZWQ1SGFweGZUTDlpQ0Z5SlI1eitoczFYbzJl?=
 =?utf-8?B?M2x1Rk56eXU5ekJ2QmRFT3Y2am1ROHBUTkRCWkNMdXV4WVBteUtSSVlLVUlH?=
 =?utf-8?B?Zk16VTlDMFhtVnR6VGJ3bnRGbkp3VGlyUk5WZU9kUG8zMWZNRDloN2gza3cx?=
 =?utf-8?B?MVJRTGhXUDc4RjNPZEc0ZWZxeVh3cVRUSWZ6YlJZZlVxd2p0VW5VTm5CaUcz?=
 =?utf-8?B?T3JpdUxIOWhTdVF3NXFjeS9VWVJJaWhIcHdnREZMaHEvN1JEUVc0REk5c0Jz?=
 =?utf-8?B?RXc3OG1GZ0pQc1NjTHNhWGtLZ0poTnpCeS9tYmFseVlXcHFlTjVnY2RLdG41?=
 =?utf-8?B?TVpFQ3FLczVWaFRSOGtGY2RIVm9Ka3hzakZTcjYxcWVBZm5rcVZSM0p0R1pJ?=
 =?utf-8?B?NjlMcmtaU1JNUTQ3SVkrLzdmajN6Z2pXUCtPemhmaDFzNjFPRExRZ0lHTyt2?=
 =?utf-8?Q?U2aqQSn6ZgKJH5AfNknv0aJjW4AkshWO?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5351.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHg0RnBzOTJiRDFzeWNPaVd6SCtpTEJXNythZHByY1ZjTnI4NFg1SlBkbXFp?=
 =?utf-8?B?Wnlabkkrc28zYlRZVlVhK1lxSWV1Q1REam5pNTFkRCtUcVpvdldJUFI0ZFJn?=
 =?utf-8?B?c09kam5lOWtQVkd1TWZMQVFrVS9URlFvcWdhOHJSckdlLzRuT1pqcEZRV2do?=
 =?utf-8?B?aXppYU5kNjhWVHM0azhWVmx5cUU1RXdQK1oxejRONXhXQTk2c3l5QWJkT2F4?=
 =?utf-8?B?RHZYbk5pczNQRHhYUmRRL2pheW9LbzhpSmVwT2sxZFloUkN1ZG52UnFTNEU1?=
 =?utf-8?B?SktaOFhpNndNcDdFb3pPaTdZVFlYNWpoZSt4Yk9NMFU1NCtPQnJxR3R6bEov?=
 =?utf-8?B?aEFzRG1sTXhKVlhpekYycGJmcHZIVFZibSsvSERFalE1VytqcGQ0Zml2V3BD?=
 =?utf-8?B?eVlzTkNHczcvcHNRZzhJcyt5S1JEZmx6Rnh4NW1peG9ra3ZZUzkyYjYvUlFk?=
 =?utf-8?B?SmtNSEs0WnBReHU3NHoyTE9KaWFVNUxGTm03UVAyMWVYRTZtd3Bua2lBZGZz?=
 =?utf-8?B?cllFVHlMM0dsMjQ4VTB3T0VWSGtQN0VyRHV3c3c1clBBSERPS2lZcGFHNDRV?=
 =?utf-8?B?VjN2WUVnNy83b3RZUXVkaWROY0xmbmlTRkhJdHJ3OEZJeEpHQWdSbTRjZjc2?=
 =?utf-8?B?Tm1oaVFZWEdQRUllcndZTjkza24wOVB1U3RveGpid3dXV0FlZTVLOUFZQVRo?=
 =?utf-8?B?aWpkekcxTmtNOGR4WFJhOFNwd3pLdDhJWVVvbno3MU9WbDl4WTBUYS9zeFZw?=
 =?utf-8?B?Qi9uSmR0MU5hMlc3NmR0TkQ3ZHd3ZkdVc1ViMHI4YlRyOThUZ3E1SHRSaG5I?=
 =?utf-8?B?SEJITytIdDlGQWFPSWN4Mm9CZERRTDBMaC9pMFJyVXBhQlJMd3R1Q0VodG9a?=
 =?utf-8?B?UkJmTXFWcC9lRzRFT094SkozSzNNVjJmeXZwOWdDQ3pFaXUwc0VBZU9wRmhq?=
 =?utf-8?B?RWExdVlMV2loa3BsUkJId1JmdEt5M1VlSHVwR1Z5MUJUQ2hMM3ZyME9LQUM0?=
 =?utf-8?B?TFRHWmZ5bkc0WG9EVFZDRVZuN1NqZVg3S3FVVkpoeWFaK0xTQmFNMGF4NjNJ?=
 =?utf-8?B?QkFIcmozcGN5TGY3Z0FxTkZvYVliOEt1aEh0anpGMlVNQ3hUVVoxenZUSzVs?=
 =?utf-8?B?eWh2V0JVTkVQa0hEbXFXODlJUDdqVWlzUm56cXptMVVDbDYrTml3MDN0dmFl?=
 =?utf-8?B?Q0tSTVd0QkFkWHM5NDE0L09YVUlmQXpES1BteG52NGZic0QrM1VBYW45U0c3?=
 =?utf-8?B?K0l1M1EwdzJ1MmlSdTZ3U2dYaFpHVjlueW95bHh4VGFRTWpTRWtESlpNemp4?=
 =?utf-8?B?bVJES2hHV0FCNjBySjlTczJCWDVMV3FaSmlrME1CRHE4NXl4ZFYwTXJGeVFL?=
 =?utf-8?B?Wm9HZ2JzNTU2MmRrMzAwOTdCcFdBbjdFOW1OemJIcmtIVjZudnFSN2J3NmhQ?=
 =?utf-8?B?dHNqZnQzdmFLSVRueTFRZnhrNHE0K0pKKy8reFBoTXh0ZHJKV2syZXFVNlNY?=
 =?utf-8?B?VHRXWkk5c284MkdMWlpNaFBiRUVCS3JaK2RRL0pCZFZxS1RwNm1zcGhNMG4z?=
 =?utf-8?B?eHYvdlo3RUdLbkJhNFZJaHl6ekpKYmN1d0hteW9QVXVmWkZFVE9nakZ3bVdE?=
 =?utf-8?B?Vml6KzN5MkhWMW4xRC9qTmhxclg4UHc0V21qNFo4MW1jZXY5MHVjR1BXZ1Bq?=
 =?utf-8?B?eDVjWVY0cWFtNy8yRVE4SncxZWlvcVZKVVFrOXkvZ2ZScnozS0RZUFdMRHB1?=
 =?utf-8?B?TVRobTE3WDBkRWtaNGxwQjNzRUhnazlVbHdpWS81UFFVeUgxU3hZa3A4VEhZ?=
 =?utf-8?B?RW5vNUN3eTdVYVZUakVCR0FaRXF1N2hnOEd5Z2gyR2hjaUZrN0tKMDdBa09h?=
 =?utf-8?B?SFovbWJQR0NrdmNWY0NjZ0RNQ3pNRjY4QWtwTUlFNVg0ZTVCWHI0MnIvaUdC?=
 =?utf-8?B?bTNvUlVxMTkwcEYxTFpCc3Ntb0N0RzVHUnJWUU01Z0V2bjE0YkRNN2M0NFpB?=
 =?utf-8?B?SEthTFpwS0hUdll6QmJkcGdtS1F3bEdoNlpPTkUxMkZKaGc4WnBYWGVOTHBt?=
 =?utf-8?B?WFRFMTIyYkZRdDJWcFYrTzlxNE1SSW5uOUxCR1ovYXpWSDlOYnV6Z0hrY1RO?=
 =?utf-8?B?VVZCSVltMkVsTm81TDRZdHN6TGNxTDhRUlMvWjkwTE9idWtSWlZ6MEJNZE1Z?=
 =?utf-8?B?Tnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F13B94DD6FEAF429B75E08218288FA1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5351.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfe405b5-5b2b-4781-8594-08dd4ccaedff
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 07:41:01.5955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YGpezPUSzqTE8EXAvQ3HPzHMFWejfSbH1/DehFyUibuVnth6OXvYZPlP69ywynN9vOr2t07agHyJZJ/J+AVRmVDylPDJHlZLlZoJ+VupqFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7998

T24gVGh1LCAyMDI0LTExLTE0IGF0IDExOjIyICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCg0KaGkgQW5nZWxvLA0KDQpUaGFua3MgeW91ciByZXZpZXcgYW5kIHJlY29t
bWVuZGF0aW9uLg0KDQpJIHdpbGwgZml4IHRoaXMgaXNzdWUgb24gbmV4dCBwYXRjaC4NCg0KQlJz
LA0KDQpNYXJrIFRzZW5nDQoNCj4gDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBj
bGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVk
IHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+IA0KPiANCj4gSWwgMDgvMTEvMjQgMDc6Mzks
IE1hcmsgVHNlbmcgaGEgc2NyaXR0bzoNCj4gPiBTb0Mgd2l0aCBDQ0kgYXJjaGl0ZWN0dXJlIHNo
b3VsZCBzZXQgdHJhbnNpdGlvbl9kZWxheSB0byAxMCBtcw0KPiA+IGJlY2F1c2UNCj4gPiBjcHVm
cmVxIG5lZWQgdG8gY2FsbCBkZXZmcmVxIG5vdGlmaWVyIGluIGFzeW5jIG1vZGUuIGlmIGRlbGF5
IGxlc3MNCj4gPiB0aGFuDQo+ID4gMTAgbXMsIGl0IG1heSBnZXQgd3JvbmcgT1BQLWxldmVsIGlu
IGRldmZyZXEgcGFzc2l2ZSBnb3Zlcm5vci4NCj4gPiANCj4gDQo+IFRoaXMgbWVhbnMgdGhhdCBN
ZWRpYVRlayBTb0NzIGNhbiBjaGFuZ2UgdGhlaXIgQ1BVIGZyZXF1ZW5jeSBvbmNlDQo+IGV2ZXJ5
DQo+IDEwIG1pbGxpc2Vjb25kcz8hPyE/IQ0KPiANCj4gSSBkb24ndCB0aGluayB0aGF0J3MgcmVh
bGx5IHRoZSBjYXNlLg0KPiANCj4gQmVzaWRlcywgYXJlIHlvdSBhd2FyZSB0aGF0IHRoaXMgd2ls
bCBoYXZlIGEgKmh1Z2UqIGltcGFjdCBvbiBlaXRoZXINCj4gcG93ZXINCj4gY29uc3VtcHRpb24g
b3IgcGVyZm9ybWFuY2U/DQo+IFdlJ3JlIGdvaW5nIGZyb20gYSBidW5jaCBvZiBtaWNyb3NlY29u
ZHMgdG8gKm11bHRpcGxlKiBtaWxsaXNlY29uZHMNCj4gaGVyZS4NCj4gDQo+IFJlZ2FyZHMsDQo+
IEFuZ2Vsbw0KPiANCg0K

