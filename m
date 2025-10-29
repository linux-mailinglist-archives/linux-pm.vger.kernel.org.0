Return-Path: <linux-pm+bounces-37044-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0FBC1B85C
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 16:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B35AF34B275
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 15:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FBE2EA178;
	Wed, 29 Oct 2025 15:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cmMILQf6";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="kF23WHxL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4152E1EE1;
	Wed, 29 Oct 2025 15:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761750101; cv=fail; b=j5JRw1EMISpcsu3HX8oOxgCcLrgj67rSkZV3u01no6eMkPwAdSdlY49hfD28AudEaswBVnqiegrlHRFh1SvP2yL6NDm4TzZ4vvNzyGT/L+pd81qXX96k3f2+3rY/tT2oV7tY3t7p0lZP01AKrdqaOHx3hgidMBmUWrMRDcfe8rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761750101; c=relaxed/simple;
	bh=W7CPB1QqlsbaZPe9qgoClGOrIAsYyanXGuDMGZtNrQw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hE4FiZBYNMdruCS/cjdrHVzsFZWAsOmslTaU5H1H+YkU99PdlqJtKMt7EoETX7kBLY+VQuuWYpTvMl1geD704cjoEn6EhTg/532AU3dQahBhxlE2mRaz/jYOEPt9wXE+JfzJByBkaLlbGWsRPhQaxSHy3aPZwJTWbI/vU6qqxaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=cmMILQf6; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=kF23WHxL; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 26e12256b4d811f0b33aeb1e7f16c2b6-20251029
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=W7CPB1QqlsbaZPe9qgoClGOrIAsYyanXGuDMGZtNrQw=;
	b=cmMILQf69OlTTttMYewrKPIQwnqal32nvBJIunKT0ZImB/6kmieKcgpcTaqo9csey7HOvLulD6phZ3ooV018675aUB0TK/OEgBq7rKkWZ3BSDmrCqtvvqEYKmcVPTCEaunPx4CZc4UyJU9qSuxFdl+ECkBU88VAk0pZvffMstxI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:6c6950e1-8717-429b-80de-8a5edd1ea474,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:126fd16a-d4bd-4ab9-8221-0049857cc502,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
	C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 26e12256b4d811f0b33aeb1e7f16c2b6-20251029
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 333676038; Wed, 29 Oct 2025 23:01:30 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 29 Oct 2025 23:01:28 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Wed, 29 Oct 2025 23:01:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eb4KTpaYkE1nLno+ylzV27yLWlqP8VnTea6v70j+vM2gEgk6Obwp3qplQ5M4LmuRi3RFTKPUFLGsQM/dD6m6dVNUur3DTG8rTwPLMr0Hs2FkUBJ2WMwjBdi+kslPcffXJoXkq7jhIibrm43Vttbn4qgmVuuG44xxttQAnQwiRZLP8FtjBTfarnoIvmf7wN4QwaaEEOyT2W1CCX19gelsFsOycal4chfwLQQdD/Nj1Kc9PIqyQX+hh7GAaqXLxNnhN7BR4tVaIxNBcBPD95LWfNYnEdxgNitiLCruEmVTEbQsWDFMbMpn/hWRob4v/rd1uMkBv31WWScVZRcQhj0TgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7CPB1QqlsbaZPe9qgoClGOrIAsYyanXGuDMGZtNrQw=;
 b=tGR71SydwIYQRZHu/wWYyF72doMx4j+ZJMh8hBbq/ZNI8/ISeBgpt/JpDKLhRBWJMTRBCEjSx391Ud7wHPq3MCghNnAsGgthyApcMZzhX6r7gwSB9Bie8IUYkapECNDZdqxo9CIjHGvttNz6LUFQ6LofzJzUnaWgRmk7eSuI69uvwLXSlO0/8WJ6J5NzyKoxbDhlKbqxxmfm+JmWi5AH/FS4yFa1+MMznqpABf0Q1ANFqx2h60Smty9ydgHkpG2oS5PUnqGmPKEFwXYwibqEnlWXlPrP6xNziAKgaE35hmkl6Jg7XPt7I/bT8XcywhfKvX7VHb8vgKd5+8wlrU4dUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7CPB1QqlsbaZPe9qgoClGOrIAsYyanXGuDMGZtNrQw=;
 b=kF23WHxLvD6M70OjZrnWYw48SKWFZkMZwmzNNJSIS/qkRjud3cgvRPSpupTB0OWcdQj3yOBvF6zGX9E08sD2KPABEP/yJvRxOEZwaRsvqFqmkAEvlLNW4+hU85cZbWi7jp9BXF7kC2SxpQUTWcZSpO3Fwkm2Cb4B7qgQ+QNNyvw=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by SEYPR03MB7359.apcprd03.prod.outlook.com (2603:1096:101:14a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 15:01:25 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2557:de4d:a3c7:41e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2557:de4d:a3c7:41e8%4]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 15:01:24 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, "Sjoerd
 Simons" <sjoerd@collabora.com>
CC: =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
	"lihongbo22@huawei.com" <lihongbo22@huawei.com>, "robh@kernel.org"
	<robh@kernel.org>, "kernel@collabora.com" <kernel@collabora.com>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	=?utf-8?B?TW91ZHkgSG8gKOS9leWul+WOnyk=?= <Moudy.Ho@mediatek.com>,
	"mbrugger@suse.com" <mbrugger@suse.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	Nicolas Prado <nfraprado@collabora.com>, "macpaul@gmail.com"
	<macpaul@gmail.com>, "wenst@chromium.org" <wenst@chromium.org>,
	=?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "y.oudjana@protonmail.com"
	<y.oudjana@protonmail.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, =?utf-8?B?TWFuZHlKSCBMaXUgKOWKieS6uuWDlik=?=
	<MandyJH.Liu@mediatek.com>
Subject: Re: [PATCH v3 04/10] pmdomain: mediatek: Refactor bus protection
 regmaps retrieval
Thread-Topic: [PATCH v3 04/10] pmdomain: mediatek: Refactor bus protection
 regmaps retrieval
Thread-Index: AQHcBd2MjPcMwIChxES6TVgTt4RGv7TAgoSAgAFUIYCAFzHgAIAAcRAAgABEd4A=
Date: Wed, 29 Oct 2025 15:01:24 +0000
Message-ID: <3ea6f9cbdd36c0dc17a9627c543cbea26eab635d.camel@mediatek.com>
References: <20250805074746.29457-1-angelogioacchino.delregno@collabora.com>
	 <20250805074746.29457-5-angelogioacchino.delregno@collabora.com>
	 <a2eae87efe46ebf397bcec3580eb9bc152b80846.camel@collabora.com>
	 <be3a2d50-044b-429a-820c-5260c6ce730c@collabora.com>
	 <0d8da30aaec2a5dc4bda6d67b640081dcc320f37.camel@mediatek.com>
	 <21f51f37-787b-48a5-a871-d61810adff42@collabora.com>
In-Reply-To: <21f51f37-787b-48a5-a871-d61810adff42@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|SEYPR03MB7359:EE_
x-ms-office365-filtering-correlation-id: 0d7ff2ec-0668-4676-5115-08de16fc07a1
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?UXE4emEwUkM0WWpORlV0dDFsM1VuK1BwS1lHTFp1cnUrYnU2N29uZ2ttRXVS?=
 =?utf-8?B?OWVBNTNNaGJSMFRzd2lrZXUyakx0MlgzOXNERlNhWndlS1dEKzhJS3RFcVJr?=
 =?utf-8?B?aGFJMHU0dzVtRVZWcVh4UDcyOFVjNGRVL2lHZzNuSmYwSTZ0SlRVekt3Zjl5?=
 =?utf-8?B?ZnJDYWtZWE9CeTZjVFBvVXg2cTVFSmgrMnVXL0w3UjZOMGpXYU9kSG5kQ0VU?=
 =?utf-8?B?NDFiVlR0VExXcGc0anZTQXdBRTlWbFJRYTc2YlZmd256TE1WNCtyWFdUTVJE?=
 =?utf-8?B?VHk2YmR3andoRVVadDRXVEpYNE9FcjlvTENrSmlWK3Q1Zml4akNnb2NyYUI5?=
 =?utf-8?B?S3BuV2ZybDJlS1R0OTZ0UmhiODQxNjJJZlk0VXFkSFJxYTVLQzRKUGVaNktF?=
 =?utf-8?B?eVJGOWRXMXR5bngwTUR1bW1PdlNhbjltWEd2dUdZNmYraTVGUXkvaG5xdWo0?=
 =?utf-8?B?ZWlTRVJxdEsrRG91azRFRzY3V3EwYU1CSTBvQ2VTVlpsSitkZENDQ0g3Rk81?=
 =?utf-8?B?N1FHNnJzcldnanZJVk5QN0hFR3o2d1FrUUlNMXVXZUxkTm9ZZzVWSDRuNzlR?=
 =?utf-8?B?aG9jZDZQdjVtTWZPcVorMTEzRm83em9ab1BqYVVJU2JxclZDb1JHdHhnVzFC?=
 =?utf-8?B?NWc2MDgwbm1Fam9waDRUOTlXNXJVS0VyeFZ3a0oyUkpXSTRaUmNQVzNtbHA3?=
 =?utf-8?B?clZVNWJod3d6MHhLa1JJbGdvNHN6KzlVZkdDZkRNYm9qc3RNZ01TWVNTY25s?=
 =?utf-8?B?UDEweG9UdUx2VUNzS3hkTW5TMWs4RUsrMkxDS2p2Tk9Uem94MldwekZGeDdG?=
 =?utf-8?B?eVZmTFdVSlMrdzYwcTdERjNhS0F5MUV5eU5yYS8yWkgvRVM2cGJtUWxvTkNx?=
 =?utf-8?B?aTFnbEppKzVBSEVKMUlWTG1YN2RPanVSYU5sS3lyaWpSQTQ0dTlQTjRQWklL?=
 =?utf-8?B?aWtOL3pvNXlmNGdxQXBZd2UxL0w1d1lZVlVMTGpRYWkrVnUxMmtUMHVIM1JE?=
 =?utf-8?B?bitrSDY1RkhWajVIbjNmRnAxdisrdFRqQUhGY21XRitaMEpYQ09wcVZJazJm?=
 =?utf-8?B?a2NyNUZjUWVWMEZibEhmUVQ1QXFrNmx3dC8yNzgrb1BiUGdkOHgvM2k3Nkpo?=
 =?utf-8?B?MmpxTU9rbVF1UW9DUG95ZHQrUWRJMWh0aWdwaHhwUHRQR2hnTUhGZkZkVCts?=
 =?utf-8?B?NWhhaXY2QTNKNjJzZzhudU92eDR0NTJzUndHMlJ5c3djMGtiOGlTVlJKM05z?=
 =?utf-8?B?WEg5dGZPazNuYVordnYyck5sSlE3d1p2alBISEhITUhaU1F5ek9xbHZlNlY4?=
 =?utf-8?B?TnQrWnBVNEt0OHRNL1FLMHZFYXBxTHN2TG5ETllqeklseWE2ZVYxKzVQTXlS?=
 =?utf-8?B?bVNUamx4VE0xRW9DckNZNnVIcjkzU1A4RzJIM3lkZzBjOVVmakptc0lGb2JU?=
 =?utf-8?B?SVdrd1ZjTktUbXQwSStSWDZEc3JnK21CR2J0TWRKM0NpQWFZdnc1UWZPSFNh?=
 =?utf-8?B?UnIwRDBQY09uN0hEejlSRmkwd1pWZ1BYRXlqSER0bG1jYkI2Wncrb2tkeEVi?=
 =?utf-8?B?ZUtxRkdpK1Q0MEFBdUxhUFE5cE0wclMvTXVHUCtYbXFCai93MVhKT2xBMlFJ?=
 =?utf-8?B?ckE4UjR4NU5jdm1VYk8va3l2Z0F5Z1k2T2ROWjQrZlNJdEMxOGQ3cVlUL3pX?=
 =?utf-8?B?NGF0RHp1TkVQV1I1aG9QbXNXRjNmTkwwVFo2YVo4RGFKczVMcStObDIyZFFq?=
 =?utf-8?B?NUordHliZS9kd0xVL3R2WlFhdEZFeGp1ZDgzb0c2eVVSZ25HSXNOSk96WStw?=
 =?utf-8?B?NTNnTlBEdUZ1aGQvU1FFdFdFQnhzUUJmV1hrMHIxQWlUcUdTRXJuTHZ4aEdr?=
 =?utf-8?B?QWtEWEJvaVpjVmxQL1pnZHBpSXFsSWlnMmlGTWZDOVhteFI1dG5rY3phcEY0?=
 =?utf-8?B?UWhqVjBWaE5FbU5uSUhCdkozdytBUlppRkZKdUpvNUZXT2FkU1pLbmdqM29q?=
 =?utf-8?B?VERhdGdwdHNSNFFNaVR6WDBIQkVjbmc3L1lzWmVMQnE3eTJIQTJGMnppQUVh?=
 =?utf-8?Q?JZKnZB?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7810.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTRwU2RneEpMMnJYS1kzTWlXNHpxYXFIc0t4VzFPdnNrZTVPeHZGdWxTNW4w?=
 =?utf-8?B?WklCbmJYSFNjWVlINklhMzUrcHZpYnhQTFh1Q1JJYXpmNFUyaEx0RVhMRjk2?=
 =?utf-8?B?eGt4ZkJMamxrZTdSYjRrMGJSZWI4MkE3TkFqcTVpYWVncU1hUmoza1lHRU04?=
 =?utf-8?B?M09qbjFEOWNGVGRuSTVzdWh6RnR3cVNvZC9aSUZkQ0p1UXdPNm11aFo0Uk9l?=
 =?utf-8?B?dGUvYVFkSEV1ZExkSGxJdXhIV2NlQnkwTG1USXg4NHBLMWtJQlF5bkpUWElk?=
 =?utf-8?B?c1cxaytGblJzTXlpTGEvUkJKTEEyTlVwWURjeHBZWmJlSTJsa2t4cjRFOHdu?=
 =?utf-8?B?dFB6Vi9SVWhuRUt1VCtEbW5FeVRZVnhRWjhjWStkc0luYS9RcDlTV3YrTTcx?=
 =?utf-8?B?cDRGMEVvT3JJdWhqM01RcVVKT0dkRGZrdjNNd1V1elh2ZDI5MGVKZE9nZ1lz?=
 =?utf-8?B?Q3ZMY2c0S2dJRnp1NkVDeHdMbUR5MUtseTBhRUhJVSt1RW5LeDJ0eGRZRXBv?=
 =?utf-8?B?a2FtbHVrMnVtOHc1dy8zcmZUc1pLaitKeFVQcllXTFA3aFBFTTRKMzBRc1Q5?=
 =?utf-8?B?eHQ3bnhFd0lPcWJRMnNOd3M2ZDZ4TGcrUFBIc3R3N3BsUFg0NUFWMU96UnBk?=
 =?utf-8?B?MXhJMTViaDRnRmRwWEpOb21RNmpJMUZjd3VBd01uS3hrK3RKTkkrK3hxWHBW?=
 =?utf-8?B?V2JVbHAyeGJHdWRsNUFXd0JoemtUMXJtMVh4ZVJpMkt3bzhmYWRoVU9tM2Rp?=
 =?utf-8?B?bFlRSFZtbFBETU1Rc0tkK2RuQVJFa0pBb3lIeUQ0YWplNHdWbXF6cGZYQnFH?=
 =?utf-8?B?OVZSeENSMFpDN1l6L1h1Wm1qNmpDTXlIVFV2UXJSeFkrRDhiSW5TTkh6UDJr?=
 =?utf-8?B?dW1HUTFocHVvUzR1L2x0azlQa0xkbkFvOGNxUlVhNmVzU3BHN1lUbkRJN2Iy?=
 =?utf-8?B?Qm04WmF5WXVwSStQRWQ0eGszSFJKSVpVV0ZzYXNpU3lMb0djSGNhSTVxSXJw?=
 =?utf-8?B?Yi8vK1VlalN0VVE3MmpvQ3FiR3pRWGpnbGhVcWMxTzIycGw1UTR4V1o2TDVr?=
 =?utf-8?B?UnVhUGgvVkFBQVQyMEFjem5rTDEvVER5YVFkbVhwSXR1NXNORVQxOUxlT2p6?=
 =?utf-8?B?Y2hJSVJwbEtMS2UvUHFyakpYQWRDOFMwZ0d3clJVdVpVYkRFWGYwdzJNSXRj?=
 =?utf-8?B?TE1LckFxc09BdVUvUjNUTVl6bHREaVVuMWd4R0tEVjcwWHgvUHhaZ3FZM1Zs?=
 =?utf-8?B?ZCtWOXFCWVpReTdydVRiTSt3ajcveXpVRmpham81OVlqQ2tFdVJYZkJ0RUhw?=
 =?utf-8?B?ZmJHbnAyclBwS3hPUU9scjc2TS9KbWRCakIrSU5EY1ptUFRKWHJBWGJkbGFK?=
 =?utf-8?B?YlZrUU9yaUdUUmRBaURaUFpjMDd4NG5xYXdEOGovMnAwNitRU2ZqeEkySmZx?=
 =?utf-8?B?WUFUdHNkNWZ3elBrb3A0R2o3SlltUUU5VlNUVS9WS0V6NjA4YzU0UHVaRXls?=
 =?utf-8?B?R1ZZVW5ta3c3WldOYlZRMU9ObnJrdmE2S0JwQkRqMmx0K0xhcU5aMW9mNjRL?=
 =?utf-8?B?OC80NDBXdTl3VkcvMzFzenRNYVZpcUhGRUJkUVFwY2lURnNxRzAvanpoUE0z?=
 =?utf-8?B?bStTZmhPeHlsZ2RqbmdrazVvWkszZUtBQUtHZERSZVRpTXRZNjR2aEtxaWJI?=
 =?utf-8?B?RzR3cXRFRC9TNjNnRUMzVkVmYzFrVkprUHVLN051Wk9vQTdxOGxRL2lobVZM?=
 =?utf-8?B?cmNnQUsxTkRqM1Z3OWJ6LzFSMFFOWmgwSVMzeVV4ZDFwdzJBcXV5ZUNTWjhn?=
 =?utf-8?B?VU9VQVNiMklqUkZqcWpmL0NuSDlveVlJajlNUkV3Wk1mejVSc3lDbjdJU2p6?=
 =?utf-8?B?bDVOQjdFOGpjM2FuTkRuTC9WYXBQN09RMXdISE80Wm80eFY5MnV6QnlHUWk0?=
 =?utf-8?B?RXNIUWZHc0xTWVdObG5vNXBmMjZnN3ZjQUZNSEZuY1pSU1NOTXQ4QU52aHhX?=
 =?utf-8?B?WENSVlQxSmRXcWRmRFhDbEtkeFRRSmlDWVBsVmJkRW9QcVY3ejd3MzRpT0Vt?=
 =?utf-8?B?QWRhZCsrSnpCYjNKNkFwYnYwcUFURVVoMElHQ2wzVENzTmpmMENEdVVCZ0hu?=
 =?utf-8?B?dWlwSVNoZ1lPVlg2V1NCbGxhNTNFNEVCdFU0bFExQjBzTXg1QjdkSDdFTi93?=
 =?utf-8?B?bmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <40821A9A35A7C9448595E2BAC2BC65B3@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d7ff2ec-0668-4676-5115-08de16fc07a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 15:01:24.8164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y3WD0xl9HOvrI/EroK5skEFZYFnfUDjp4UNMIpXtp21IhuLo8sj/SNSBlZznA4d8JT9MXZXJLHacdzes68cR8nBA93mua7x9zlHI+WV3ihE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7359

T24gV2VkLCAyMDI1LTEwLTI5IGF0IDExOjU2ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gDQoNCltzbmlwXQ0KDQo+IFRoYW5rcyBmb3IgdGhlIGxvZ3MhIEdldHRp
bmcgaXNzdWVzIG9uIE1TREMgaXMgcmVhbGx5IG9kZCBiZWNhdXNlIHRoZQ0KPiBNU0RDDQo+IGNv
bnRyb2xsZXIgZG9lcyAqbm90KiB1c2Ugbm9yIGhhdmUgYW55IHBvd2VyIGRvbWFpbi4uLg0KPiAN
Cj4gSSdsbCB0YWtlIGEgbG9vayBhdCB0aGlzIGFzIHNvb24gYXMgSSBjYW4sIGFueXdheS4NCj4g
DQo+IFRoYW5rcyBhZ2FpbiwNCj4gQW5nZWxvDQo+IA0KPiA+IFvCoMKgwqAgMS4yOTEwNTVdIG10
ay1tc2RjIDExMjQwMDAwLm1tYzogbXNkY190cmFja19jbWRfZGF0YTogY21kPTgNCj4gPiBhcmc9
MDAwMDAxQUE7IGhvc3QtPmVycm9yPTB4MDAwMDAwMDINCj4gPiBbwqDCoMKgIDEuMjkyNzc1XSBt
dGstbXNkYyAxMTI0MDAwMC5tbWM6IG1zZGNfdHJhY2tfY21kX2RhdGE6IGNtZD01NQ0KPiA+IGFy
Zz0wMDAwMDAwMDsgaG9zdC0+ZXJyb3I9MHgwMDAwMDAwMg0KPiA+IFvCoMKgwqAgMS4yOTQ1Mzld
IG10ay1tc2RjIDExMjQwMDAwLm1tYzogbXNkY190cmFja19jbWRfZGF0YTogY21kPTU1DQo+ID4g
YXJnPTAwMDAwMDAwOyBob3N0LT5lcnJvcj0weDAwMDAwMDAyDQo+ID4gW8KgwqDCoCAxLjI5NjI5
M10gbXRrLW1zZGMgMTEyNDAwMDAubW1jOiBtc2RjX3RyYWNrX2NtZF9kYXRhOiBjbWQ9NTUNCj4g
PiBhcmc9MDAwMDAwMDA7IGhvc3QtPmVycm9yPTB4MDAwMDAwMDINCj4gPiAuLi4NCj4gPiBbwqDC
oMKgIDEuNDMwNDA4XSBtdGstbXNkYyAxMTI0MDAwMC5tbWM6IG1zZGNfdHJhY2tfY21kX2RhdGE6
IGNtZD01NQ0KPiA+IGFyZz0wMDAwMDAwMDsgaG9zdC0+ZXJyb3I9MHgwMDAwMDAwMg0KPiA+IFvC
oMKgwqAgMS40MzM3NjZdIG1tYzA6IEZhaWxlZCB0byBpbml0aWFsaXplIGEgbm9uLXJlbW92YWJs
ZSBjYXJkDQo+ID4gW8KgwqAgMjIuMjk3MjQwXSByY3U6IElORk86IHJjdV9wcmVlbXB0IGRldGVj
dGVkIHN0YWxscyBvbg0KPiA+IENQVXMvdGFza3M6DQo+ID4gW8KgwqAgMjIuMjk4NzIzXSByY3U6
wqDCoMKgwqAgNi0uLi4wOiAoMiB0aWNrcyB0aGlzIEdQKQ0KPiA+IGlkbGU9MTA0Yy8xLzB4NDAw
MDAwMDAwMDAwMDAwMCBzb2Z0aXJxPTQ1LzQ1IGZxcz0zNw0KPiA+IFvCoMKgIDIyLjI5OTgyN10g
cmN1OsKgwqDCoMKgIChkZXRlY3RlZCBieSAyLCB0PTUyNTYgamlmZmllcywgZz0tMTA1MSwNCj4g
PiBxPTIwMA0KPiA+IG5jcHVzPTgpDQo+ID4gW8KgwqAgMjIuMzAwNjg5XSBTZW5kaW5nIE5NSSBm
cm9tIENQVSAyIHRvIENQVXMgNjoNCj4gPiANCj4gPiBCZXN0IHJlZ2FyZHMsDQo+ID4gTWFjcGF1
bCBMaW4NCj4gDQo+IA0KDQpUaGUgY29tbWFuZCByZXRyeSBvbmx5IGhhcHBlbnMgaW4gdGhlIHZl
cnkgYmVnaW5uaW5nIGR1cmluZyBsaW51eCBib290Lg0KDQpUaGUgZm9sbG93aW5nIHJjdV9wcmVl
bXB0IGFuZCBjcHUvdGFzayBzdGFsbCBhcmUga2VlcCBhcHBlYXJpbmcgdW50aWwNCnBvZXdyIG9m
Zi4gSXQgaXMgbW9yZSBsaWtlIGNwdSBub3QgcmVzcG9uZGluZyBvciBydW50aW1lLVBNPyBJJ3Zl
IG5vdA0KdHJ5IHRvIGRpc2FibGUgYW55IHBvd2VyIHJlbGF0ZWQga2VybmVsIG9wdGlvbiB5ZXQu
DQoNClsyMjY0OS42OTg5MTJdIHJjdTogSU5GTzogcmN1X3ByZWVtcHQgZGV0ZWN0ZWQgc3RhbGxz
IG9uIENQVXMvdGFza3M6DQpbMjI2NDkuNjk5Njg3XSByY3U6ICAgICA1LS4uLjA6ICgwIHRpY2tz
IHRoaXMgR1ApDQppZGxlPTFiN2MvMS8weDQwMDAwMDAwMDAwMDAwMDAgc29mdGlycT0zMi8zMiBm
cXM9OTc2NTk5DQpbMjI2NDkuNzAwODM1XSByY3U6ICAgICAoZGV0ZWN0ZWQgYnkgMSwgdD01NjYy
MTAyIGppZmZpZXMsIGc9LTEwNTUsDQpxPTIxNiBuY3B1cz04KQ0KWzIyNjQ5LjcwMTcyOF0gU2Vu
ZGluZyBOTUkgZnJvbSBDUFUgMSB0byBDUFVzIDU6DQpbMjI2NTkuNzAxNzM0XSByY3U6IHJjdV9w
cmVlbXB0IGt0aHJlYWQgc3RhcnZlZCBmb3IgMjQ5NSBqaWZmaWVzISBnLQ0KMTA1NSBmMHgwIFJD
VV9HUF9ET0lOR19GUVMoNikgLT5zdGF0ZT0weDAgLT5jcHU9MA0KWzIyNjU5LjcwMzU5Ml0gcmN1
OiAgICAgVW5sZXNzIHJjdV9wcmVlbXB0IGt0aHJlYWQgZ2V0cyBzdWZmaWNpZW50IENQVQ0KdGlt
ZSwgT09NIGlzIG5vdyBleHBlY3RlZCBiZWhhdmlvci4NClsyMjY1OS43MDQ3NDZdIHJjdTogUkNV
IGdyYWNlLXBlcmlvZCBrdGhyZWFkIHN0YWNrIGR1bXA6DQpbMjI2NTkuNzA1Mzg2XSB0YXNrOnJj
dV9wcmVlbXB0ICAgICBzdGF0ZTpJIHN0YWNrOjAgICAgIHBpZDoxNSAgIA0KdGdpZDoxNSAgICBw
cGlkOjIgICAgICB0YXNrX2ZsYWdzOjB4MjA4MDQwIGZsYWdzOjB4MDAwMDAwMTANClsyMjY1OS43
MDY3ODRdIENhbGwgdHJhY2U6DQpbMjI2NTkuNzA3MDk3XSAgX19zd2l0Y2hfdG8rMHhmMC8weDFi
MCAoVCkNClsyMjY1OS43MDc1OTBdICBfX3NjaGVkdWxlKzB4M2IwLzB4Y2E4DQpbMjI2NTkuNzA4
MDM5XSAgc2NoZWR1bGUrMHgzYy8weDEyMA0KWzIyNjU5LjcwODQ1M10gIHNjaGVkdWxlX3RpbWVv
dXQrMHg4Yy8weDEzMA0KWzIyNjU5LjcwODk1Nl0gIHJjdV9ncF9mcXNfbG9vcCsweDE0MC8weDZj
MA0KWzIyNjU5LjcwOTQ1OV0gIHJjdV9ncF9rdGhyZWFkKzB4MjA4LzB4MjU4DQpbMjI2NTkuNzA5
OTUxXSAga3RocmVhZCsweDE0Yy8weDIzMA0KWzIyNjU5LjcxMDM2NV0gIHJldF9mcm9tX2Zvcmsr
MHgxMC8weDIwDQpbMjI2NTkuNzEwODI0XSByY3U6IFN0YWNrIGR1bXAgd2hlcmUgUkNVIEdQIGt0
aHJlYWQgbGFzdCByYW46DQpbMjI2NTkuNzExNTE3XSBTZW5kaW5nIE5NSSBmcm9tIENQVSAxIHRv
IENQVXMgMDoNClsyMjY1OS43MTIxMDldIE5NSSBiYWNrdHJhY2UgZm9yIGNwdSAwDQpbMjI2NTku
NzEyMTE3XSBDUFU6IDAgVUlEOiAwIFBJRDogMCBDb21tOiBzd2FwcGVyLzAgTm90IHRhaW50ZWQg
Ni4xOC4wLQ0KcmMzLW5leHQtMjAyNTEwMjgtbXRrK21vZGlmaWVkLTA0MzkyLWc1YzkyMWIyYzU5
NzUgIzEgUFJFRU1QVA0KWzIyNjU5LjcxMjEyM10gSGFyZHdhcmUgbmFtZTogTWVkaWFUZWsgR2Vu
aW8gMTIwMCBFVkstUDFWMi1FTU1DIChEVCkNClsyMjY1OS43MTIxMjZdIHBzdGF0ZTogNDA0MDAw
MDkgKG5aY3YgZGFpZiArUEFOIC1VQU8gLVRDTyAtRElUIC1TU0JTDQpCVFlQRT0tLSkNClsyMjY1
OS43MTIxMzBdIHBjIDogY3B1aWRsZV9lbnRlcl9zdGF0ZSsweDJiYy8weDcyMA0KWzIyNjU5Ljcx
MjEzN10gbHIgOiBjcHVpZGxlX2VudGVyX3N0YXRlKzB4MmI4LzB4NzIwDQpbMjI2NTkuNzEyMTQx
XSBzcCA6IGZmZmY4MDAwODQ0NzNkMDANClsyMjY1OS43MTIxNDNdIHgyOTogZmZmZjgwMDA4NDQ3
M2QwMCB4Mjg6IDAwMDAwMDAwMDAwMDAwMDAgeDI3Og0KZmZmZjAwMDFmZWY3ZDhjMA0KWzIyNjU5
LjcxMjE1MV0geDI2OiAwMDAwMDAwMDAwMDAwMDAxIHgyNTogMDAwMDE0OWJlMDA2NTNlYiB4MjQ6
DQowMDAwMTQ5YmUwMTczNmVmDQpbMjI2NTkuNzEyMTU3XSB4MjM6IDAwMDAwMDAwMDAwMDAwMDIg
eDIyOiBmZmZmMDAwMGMyZDM4ODgwIHgyMToNCjAwMDAwMDAwMDAwMDAwMDINClsyMjY1OS43MTIx
NjNdIHgyMDogZmZmZjAwMDBjMmQzODk2OCB4MTk6IGZmZmYwMDAxZmVlN2U5ZjggeDE4Og0KMDAw
MDAwMDA1YmQzYmFhZQ0KWzIyNjU5LjcxMjE2OV0geDE3OiAwMDAwMDAwNDAwNDRmZmZmIHgxNjog
MDA1MDAwZjJiNTUwMzUxMCB4MTU6DQowMDAwMDAwMDAwMDAwMDAwDQpbMjI2NTkuNzEyMTc1XSB4
MTQ6IGZmZmY4MDAwODQ0ODc1NDAgeDEzOiBmZmZmODAwMTdiOGM4MDAwIHgxMjoNCmZmZmY4MDAw
ODE2Zjk4MzANClsyMjY1OS43MTIxODFdIHgxMTogMDAwMDAwMDAwMDAwMDAwMCB4MTA6IDAwMDAw
MDAwMDAwMDAwMDAgeDkgOg0KZmZmZjgwMDA4MDFkYzY0Yw0KWzIyNjU5LjcxMjE4N10geDggOiAw
MDAwMDBmMmI1NTAzNTEwIHg3IDogMDAwMDAwMDAwMGYwMDAwZiB4NiA6DQowMDAwMDAwMGZmMGZm
ZmYwDQpbMjI2NTkuNzEyMTkzXSB4NSA6IGZmZmY4MDAxN2I4YzgwMDAgeDQgOiAwMDAwMDAwMDAw
MDAwMDAwIHgzIDoNCmZmZmY4MDAwODQ0NzNjMTANClsyMjY1OS43MTIxOTldIHgyIDogMDAwMDAw
NDQ5ZDI4N2U3ZiB4MSA6IGZmZmY4MDAwODQ0ODc1NDAgeDAgOg0KMDAwMDAwMDAwMDAwMDAwMA0K
WzIyNjU5LjcxMjIwNV0gQ2FsbCB0cmFjZToNClsyMjY1OS43MTIyMDddICBjcHVpZGxlX2VudGVy
X3N0YXRlKzB4MmJjLzB4NzIwIChQKQ0KWzIyNjU5LjcxMjIxMl0gIGNwdWlkbGVfZW50ZXIrMHg0
MC8weDYwDQpbMjI2NTkuNzEyMjE5XSAgZG9faWRsZSsweDIwOC8weDI5OA0KWzIyNjU5LjcxMjIy
Nl0gIGNwdV9zdGFydHVwX2VudHJ5KzB4M2MvMHg1MA0KWzIyNjU5LjcxMjIzMl0gIHJlc3RfaW5p
dCsweGZjLzB4MTIwDQpbMjI2NTkuNzEyMjM2XSAgc3RhcnRfa2VybmVsKzB4N2E0LzB4OTIwDQpb
MjI2NTkuNzEyMjQzXSAgX19wcmltYXJ5X3N3aXRjaGVkKzB4ODgvMHg5OA0KDQpSZWdhcmRzLA0K
TWFjcGF1bCBMaW4NCiANCg==

