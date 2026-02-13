Return-Path: <linux-pm+bounces-42616-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIVBAEBMj2nnPgEAu9opvQ
	(envelope-from <linux-pm+bounces-42616-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 13 Feb 2026 17:07:28 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E40E5137D2B
	for <lists+linux-pm@lfdr.de>; Fri, 13 Feb 2026 17:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DE29230054D7
	for <lists+linux-pm@lfdr.de>; Fri, 13 Feb 2026 16:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE19C35FF54;
	Fri, 13 Feb 2026 16:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="X9GvQ8eC";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="qjWsJC7K"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F62234FF41;
	Fri, 13 Feb 2026 16:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770998842; cv=fail; b=NVAhXg2HcxjcQRsYjUW14b595hLWTewNj33Lm4nABnQ48EoTS6MCMgpE51bVN3FP2qRYQyYtk3czG8vJKtRm1xYrDOhmNFCanYnKURDPJt4+s38+Gyi8qOGwHbY7Di2NNKAAGtJEMPa9PFLrJD8a868YjzJfOKARH2Rc50nqGEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770998842; c=relaxed/simple;
	bh=/JdJgXFFGub+psdnMUh5B3KOb6CDsIOPeohlfk9zJqI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zb0elM0WC8imXDYVBFrbcdsNjkdqa/N3RnxkeoNAHUJhyWIBqo+lJjn813+KN/zeYNm+OrAqsDyMa6LOjb+q+5bP7QBIcZVs0SSmAp3tQ1llthW12Pd/w7VLSSdkCWC+ON9z8+hhv0LcSA4PcKvjFVKrp6wxFvSdwbtWOFNovbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=X9GvQ8eC; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=qjWsJC7K; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1068aff408f611f185319dbc3099e8fb-20260214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=/JdJgXFFGub+psdnMUh5B3KOb6CDsIOPeohlfk9zJqI=;
	b=X9GvQ8eC28K4VSrb6c6VwEuZoDVMzZgv6kRlvg+Eb8mHFp76/a39U0x+K/h/25Oc3iVcha9q/YEBwDvg14a+R96mCOoW9yDsJgtwieDT4h4C0dSN8vMgi1eAkOIZf4Y/V7KC8/NejiGLRKM+ymHW6VY0rffC+GUKwI7QH7m3W0I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:ab6d17ea-cb8a-49e7-9dac-9550913ea4c8,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:0e50a7e9-ef90-4382-9c6f-55f2a0689a6b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
	C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1068aff408f611f185319dbc3099e8fb-20260214
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1847793785; Sat, 14 Feb 2026 00:07:15 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sat, 14 Feb 2026 00:07:14 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Sat, 14 Feb 2026 00:07:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z3q24HOyXgumVOt+4z/U4LtUYoCjQDgfuGE0+1TsSkOCv0El8YsFUWCxfg1QSP3XmzA0Ro8o/hDBbvXGBZeMB/4YEPUyqe9vPmw1qdExLaY8zJM16a0hXQuyxP8XS4OE2/yeT3V+1+9rIPVuO8pRKz8RTaiNH/ZaZ94lvGinTcgC5q3/TyIi08dF+XyLFMOf9ZkFSvcMorLLymEiWKLTWAwV/eq8TN9rYTUDk69If1UR5G6ODTfQ/nbgjfpSWRoP8jWjd5NZgOsAiwlGtAyJmPsaxvDBDR28nXybu3f3k1NV18AoWFpx/Zl5jtT9+99yuYneOFvxu2bXtZEx7kojkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/JdJgXFFGub+psdnMUh5B3KOb6CDsIOPeohlfk9zJqI=;
 b=y4I+XxGfv5v6uHNt8OBPnyYiRK7fePqgkFUobOGluJVHqNQ7cIay3Q9aVvHslDG1KaaGpPWa04qLQ8bDlDwvsT6x4846yIKVijv4cU+ggWmR/bMYuqBsDGaM25zT7T40ZnTn2Wx7zaAPMB8ctTYQCVewZabH8ocMHtHS9xQKxF4XzlY6bf2GOrgckV+jvwDh92AdEHMz8dwfIlMLg9QtlMkAVRNPyzmMuR2v3SthdlJhWdFwHYWTvx7++K8rCckvty67fnJWA4xfKuRPTIzkx5nH94ROu/7oiJxIEJzffuMsgAPYUK65+6X2ZoahxUoohhzvgrVHJK9mHmckmvi7qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JdJgXFFGub+psdnMUh5B3KOb6CDsIOPeohlfk9zJqI=;
 b=qjWsJC7KKvymUKTU1LECPN2HLbR4PxwMyz5UFcoBqAohclRjs5H7tyMi/65SUdxYQpo80DCW4RLbEOr3ZSKgn7+HuXraM7hDGHEdgSJPa0stPrpMrtbxUyiAhkIr33Xdp0CUnC1mP4/DOpCKQKBAwAnKM+oL5+ijyWZW0VXk2co=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by TY0PR03MB8224.apcprd03.prod.outlook.com (2603:1096:405:14::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Fri, 13 Feb
 2026 16:07:11 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 16:07:11 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
CC: =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
	"lihongbo22@huawei.com" <lihongbo22@huawei.com>, "robh@kernel.org"
	<robh@kernel.org>, "kernel@collabora.com" <kernel@collabora.com>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	=?utf-8?B?TW91ZHkgSG8gKOS9leWul+WOnyk=?= <Moudy.Ho@mediatek.com>,
	"mbrugger@suse.com" <mbrugger@suse.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, Sjoerd Simons <sjoerd@collabora.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, Nicolas Prado
	<nfraprado@collabora.com>, "wenst@chromium.org" <wenst@chromium.org>,
	=?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
	"y.oudjana@protonmail.com" <y.oudjana@protonmail.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, =?utf-8?B?TWFuZHlKSCBMaXUgKOWKieS6uuWDlik=?=
	<MandyJH.Liu@mediatek.com>
Subject: Re: [PATCH v3 04/10] pmdomain: mediatek: Refactor bus protection
 regmaps retrieval
Thread-Topic: [PATCH v3 04/10] pmdomain: mediatek: Refactor bus protection
 regmaps retrieval
Thread-Index: AQHcBd2MjPcMwIChxES6TVgTt4RGv7TAgoSAgAFUIYCAFygogICnFzOAgAHj4YA=
Date: Fri, 13 Feb 2026 16:07:10 +0000
Message-ID: <54d3abf79ce1cc0f59a18cfff585699073918f60.camel@mediatek.com>
References: <20250805074746.29457-1-angelogioacchino.delregno@collabora.com>
	 <20250805074746.29457-5-angelogioacchino.delregno@collabora.com>
	 <a2eae87efe46ebf397bcec3580eb9bc152b80846.camel@collabora.com>
	 <be3a2d50-044b-429a-820c-5260c6ce730c@collabora.com>
	 <fd071501b66fb332439617f2b270c837043b0862.camel@mediatek.com>
	 <8fc93d93-7d99-4d38-9fa8-92951a0acdcf@collabora.com>
In-Reply-To: <8fc93d93-7d99-4d38-9fa8-92951a0acdcf@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|TY0PR03MB8224:EE_
x-ms-office365-filtering-correlation-id: b5199e23-47be-4a4c-0199-08de6b19f1d9
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Skh5VDE2b2hxOGFuaFJSS0g5V29yd0RqSU1rcGh2UUVkem9QU3dvU1BQNkkx?=
 =?utf-8?B?dytrczBwSkVNWkl2MG5vZlNOamxiREVPMTVYTG5lT01qallDZlBwaWJscWdk?=
 =?utf-8?B?TjlTZFZrM205K3VKaFFDWGtRYUxrUit6ckZ6NEozaFVOL3A4dUFPZUlPb2Jl?=
 =?utf-8?B?S3cvaUVnWkJodFJjclVWK1lRS0k1TkV5dHhYbHRQSDN1cTJ2RHdXd1RIZmRi?=
 =?utf-8?B?bHJxTFk3R1c5dEQ4MEREb2NNbGVoNVBJRE1jdVVPRFUzYktsbVo1eklyN2tP?=
 =?utf-8?B?Q25JeGJvNGUzdTNnbWdVc243YlNoMXVkZTlBS1d3ZCt2VVpzVGRza0xwOC9W?=
 =?utf-8?B?MFBxZ2R5bUJvd3ByQlpUcjFEMEQrMG11NitvWWpqSzBIYWNyV2k2TGp3V0hL?=
 =?utf-8?B?UWpLNVBjdDhGL1FqR0hkc0dWT1BoVTRQVWZDT3cwM1R1U2QzM2FXaVo1Qm1P?=
 =?utf-8?B?NCtDYnFITml3MEpRc29kTEo3OUtzVkhBemFnZnBMNGtvQ3FZVVJwdXJBY1B5?=
 =?utf-8?B?eVZaRDAyblhCS0ZlQUY0TlJJcm1KUTBmWnduN3F3ZnNEZXFDNUFUZTlTa2R1?=
 =?utf-8?B?dCtjWUltMm84Nng4TUR4cEhuR2ViWjdHRVJkSWFJWUo0RlgzdExXWndrRFE0?=
 =?utf-8?B?VkhFWGhVR3JjNEcyeDNQRFNJNm1rMS9ZSW9SY3VGblEzMlQyajVWTVF5bk1q?=
 =?utf-8?B?eHF1N0prV2phcTk1a0lVVHE1ZzNpbmR2RXg0SnJLbisxU2FwVFVwQ1o5TDk1?=
 =?utf-8?B?c045blNGN3Q5VUdZSU9EQ2p5TXlBZG9hMkJzRy9iajhMSFVEK1FFUDAxSzRJ?=
 =?utf-8?B?NUdnU2Zxb3BHTVQxamRnV2FmUXRMeGgwdU0vaExQQ2cvL1hUOEhBcjhHL2JS?=
 =?utf-8?B?QXpkOUJZYVJjMVdoYXh0d1ZNYk5CVThKSktxTkwxSG1LTnlkNXNKMG1sK2V2?=
 =?utf-8?B?M0pQSTQzeWpyRWdWMlltdVo2cHhMQUJneWJncVZkdmFDQzhIL1B4b1pIY3lY?=
 =?utf-8?B?UmovNER4UXp5dzlUMFZSTjNZVGZXZ3Z5bUJRRlN4MmxjYUpHU2d1RTF5ZC9u?=
 =?utf-8?B?enFFQy9ETTByOVNWOVh0eGNvZ1NWR2ZsY0RnN3VpdSsxWXVsYXhONGRtUERt?=
 =?utf-8?B?bE1RN1JuSFo4MTlwSEo4dm9LYndZNFB4UStRNE9SWHlRQmhCbEVnSmdrSlZu?=
 =?utf-8?B?bEx2eGlLVTAweS82ZnRuTjBWYnNvWmVxMFIrdWdTWUl0dzh5MkV3eVYwYUhQ?=
 =?utf-8?B?dlFPaWJuUS9CTnhYZkVjbFdNSzc3dlVEbHd6eU5qNzR2bmtJVnhZRFEzY2pH?=
 =?utf-8?B?MElGN0p0Tm1QcEpUNXFZZW5LT3U3UWZxRk92dXJnYURRU1NMSWp3U0IzeUQw?=
 =?utf-8?B?Vi85TW5QdlI0cGptQ3RZWlNmS3JFblRkSEVnajB5cmlnNjhCR1RGK3FKSHdP?=
 =?utf-8?B?VitXelh2cGZCWmp1UjBXbThRUGdiVDU4ZFZkbDlZRVplUExOWlZyQ0xqcGZy?=
 =?utf-8?B?MXN3RkI3TTRiVEd1elZzVlVrcUJ6V0JNVUxUUGZHSjdxbGhaNHVQTTIzVkp6?=
 =?utf-8?B?MzBWNjBYNk5UVTZGZ1hJK3ZHWXIwSmlmOXhoSWVibEZTVEVwR1J3SVJidHJv?=
 =?utf-8?B?Yytwd3M0Vm5hYUhIMGRCaXN1M05wSHlXTXpOZ25lWkR2aXpydkNBT1d4aS9a?=
 =?utf-8?B?ZERwTnV5Tk8rNGdLSGJLeGpxbnZwRkNickk0Z1RHdHhkSlY2cFBOdDM3VDk1?=
 =?utf-8?B?SW1XNlg5OUtZN3E3d3RzYmN3NDFDMVJpMmVWaGxES0EyWWpSYWNqeGIyd0ZR?=
 =?utf-8?B?Ui9VREdzL2hFaWU1NE9CUDNTdGt3bUFXeWhJNDZ1dkwwaDZSanFrMDdvRDdW?=
 =?utf-8?B?d2ZwWWEyN2MzOFJPc2h2T0NrQTFjUWZwZUhxRDJBUGxVTXQ5T3A0ZWhTcStr?=
 =?utf-8?B?WXFWbHlKR1dFMUgyckVmSzdWaWNsSEtKTjJpTVhVUUxFZE5TSDI2TjBZalJW?=
 =?utf-8?B?dWlyTlpBbTh6K0NLaVlyRnV3TitWR1psblQrOWZXZHN4TmFlUERJQjQ5eVps?=
 =?utf-8?B?ZlZDRlN3MzkvVWJrQ0ZrTzdFTGZTV0ljcERzbGF1WFdqK0lYOTNvN09ZOURO?=
 =?utf-8?B?RTk3SnVnczVvQVpNRytpckM4cUJCNWlweTBZUFBzVzRFZm1GNmJyUjNlNTd6?=
 =?utf-8?Q?E6tZjRa1GNVzjJpDWMLTV1Y=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7810.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUtka255YWE4VHE2aFYvd3RuTWZodS9YanBITm1XQWIrWGRFRFBlZVBYb0wy?=
 =?utf-8?B?Ty9ETDYrMzFUaExlSThJSXNCaXJhNWJtV09vNUdITUNZZENFd0VYak9IWU5y?=
 =?utf-8?B?T0xKbkdBeFN3RmpUcEExUWk1bld6eVQzVzE0QXIxK3duYnk3aWRML01tWDRF?=
 =?utf-8?B?bVozNUw0aTlvcnlpZFhWV0pCVnZ4bzBGU1FsZnRXeHVBN3RQTTZzbkw3a1h5?=
 =?utf-8?B?OERzTndvYlkwNmJUMUdBMDEwZnUxYkd4OFRqdGRmOFBSMDE0Z0FiVlU1Y2Y2?=
 =?utf-8?B?WWZxREtpUXY1Z2swVFZDK2cwbmkyS0Q1djlvRElqdEE3eFNYbTAxQnJFZVBI?=
 =?utf-8?B?QlVXV08yc1kxQTRER2FTTjBqcUx0emt3OVVqOGx0QUtSV3Q0ZEM2blZZSHJ0?=
 =?utf-8?B?WlVZb2FrZnFmR3BpcmM1WWdLdU9Wd0JURDBjdGpWaVdzRUVZQlZPUy9LTjEv?=
 =?utf-8?B?d0dKRkRjV3hiOTlwbHltemo1Q0IyMTFFTFJNRXZKRVVhKzBUZTRLd0VDR1Nq?=
 =?utf-8?B?YjdUNXJ3dDNxc0V5SCsyY2JFaXltaWRxOWxsb2RJeG45NmlCQWVMcEhodWZa?=
 =?utf-8?B?cGZyN1BQRUdJbUdRR1V4SGhLd2c5SHY0VTdmQWxtOUVBcUphZmZhTWZHbnlE?=
 =?utf-8?B?aG83OEFIY25udnJrR1BFU3FUMitHUHZvUWlLMXdPSEdmblczWXNUQWdpd0hk?=
 =?utf-8?B?TzdFekNheFI0Qnl0ODdic0lENDBxaHJXaENjVnliYWJHYVYzaVh6dGRqWTZ6?=
 =?utf-8?B?dlkzRm1nT2wwVDA2SkRDOXpnR1d1MlNncDJkNXV1VXBXK1Z0SExPWHNjcVdx?=
 =?utf-8?B?bjhVQmxXYXM3ZTlIUndTVHNJeGx6YVZQRlZPQU5hTjk2a293L0ZWUEhWSHFB?=
 =?utf-8?B?bzhKbWpuMUtTMG11V0duN0VlOGNkTzJKRW9ha1crU21iQktObkkxT3pDZ0Rz?=
 =?utf-8?B?SEhJYWxBQ1pKcVVWN3UvM3lYYXovMXpOdGFLS0srdDBzelQxTkRFaS9FNjJh?=
 =?utf-8?B?SVVzSlVueDdRRXFmMytONzlzRkNSV1lPVS91dEo3UmMrK256cG90NytFTkdp?=
 =?utf-8?B?WkNrU3RRajZtSldaSkFLaFpBM0hZRzN2S1o3d1hEWi9QdEJLMWhsVHV6ZnRE?=
 =?utf-8?B?VGhGb3EzaXFHRExqVGpWLytsczJVd0pta3pHNmoyellvMmNJb2I0c3d2OHkz?=
 =?utf-8?B?d2JNMm9TeGlTNUhCTlZzbGZtUkFqeWJYSCtBOXhXT05sNVNMMmZnUWx6SlNO?=
 =?utf-8?B?ZEtGdWRDYW5mMnRkNnZ6anFWQ3U0OVMxMDJ6WVkySFhyYURrbzFZUEtJdXpM?=
 =?utf-8?B?bG1zYlNMUzJ1aEhtbzZZU2NsNk42a1Mrdjc5N2EvNkErdm5oNTRPWDYvQ1dx?=
 =?utf-8?B?c1ZtS0hPZTlLcEg3NENQazFja2FZaExUQ2RPUHRrbnpNbkJLUlVBOE54TEtY?=
 =?utf-8?B?UisrSTh4UmRUN2NpR3ZOMGxGLzNvQXBSbkdhSDZiMlJCTmdsdDBXaDVmemx4?=
 =?utf-8?B?aVdLMFlKdmxvSDlVcVdRWDBOYjl4UUx2ZGlhNXp5UURYWU1RSGo5Y2xjS2g5?=
 =?utf-8?B?VkZHalRqdE40dGFSc3hGZzgyUTRJeDQza3lRODREalZhY2p3Ylo1Wk5BL1FR?=
 =?utf-8?B?UjZMWTBmMnB4K0hXc3BvUlNteDBHUXY1ZnVSUW1qRnhxZk9JM1dSZXAzeUx1?=
 =?utf-8?B?SW9sUS9Na2NtTmNNKzdwOGFzMUhQQVF2dXNNRWpNWEhpVzAwYXdCQTFUM0Jq?=
 =?utf-8?B?a0J3Uk9ob1ZhM2N4WWxwRmREYXZyVi9MaWlzd1p2VC9pY2FZbXJQVnZudWJF?=
 =?utf-8?B?eWNQam05RnVJTU1OU3ZpNnMrdWtNblJqN0FidXRrdjNZQnNJL2pEUmVtam5Z?=
 =?utf-8?B?VklOVG9mVzllWmloMDVTWjJRSkt1SWFpUTRxSVFnUGRiaWcyWWd5a2tRQm1E?=
 =?utf-8?B?d3N0QkhTeHlaT2MzL1ROUnZ5eVRtYmtnOEdpRlUzTzBXaXhpOWpDSmRzRy9S?=
 =?utf-8?B?cThWNEY1d1g1UlpoZWxxQktEMnNWYVNocjArQksvdHY4bnd4ZXpybHA5N1NJ?=
 =?utf-8?B?TTB1TmY3b2tWc2JLNHgwa2xTNjV0ZEpDeDNsZ1REcnpSL2dhbTJMM3hyMHRj?=
 =?utf-8?B?VDdGdGZBdjhOSG95TTk1KzlKOWlwRDVoYnhCdkFvajhHdTg3YTJ1T3BMaEM4?=
 =?utf-8?B?N0xXUGNQWEhKSVlXZ2F1U2JNd3cwdUdNVzVoQks4TWZFa0gzaSswZnZmQUYv?=
 =?utf-8?B?cnFtdi9IM2U2R0F0dVI2c0JBT2F5aVhBVHpvelM0QVc3NUtPUkFXYk1OV2hz?=
 =?utf-8?B?NkRxeGdJQTVIMzRmV0NFQjdyTWpNY3N5Sm54ajNpYW42NUN5d3lmZXVmODZT?=
 =?utf-8?Q?Z3cTD+TsaVlhWPqE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <28213B739177594798D5479D589DAF53@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5199e23-47be-4a4c-0199-08de6b19f1d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2026 16:07:10.8722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ezNf9oI60+XmAzpNebvhaXsslBJI0xBIMjbba3YtcY77L69HPvJk/c9+QAr11VXNjaRjctTpzl7p43OuJ+yWlZ+Hq2tvof/VJbHjK2YB0BY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB8224
X-MTK: N
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk,mediateko365.onmicrosoft.com:s=selector2-mediateko365-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-42616-lists,linux-pm=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[mediatek.com,huawei.com,kernel.org,collabora.com,linaro.org,suse.com,vger.kernel.org,lists.infradead.org,chromium.org,protonmail.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Macpaul.Lin@mediatek.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mediatek.com:+,mediateko365.onmicrosoft.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: E40E5137D2B
X-Rspamd-Action: no action

T24gVGh1LCAyMDI2LTAyLTEyIGF0IDEyOjE1ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMTIvMDIvMjYgMDg6NTgsIE1hY3BhdWwgTGluICjmnpfmmbrmlowp
IGhhIHNjcml0dG86DQo+ID4gT24gVHVlLCAyMDI1LTEwLTE0IGF0IDExOjU5ICswMjAwLCBBbmdl
bG9HaW9hY2NoaW5vIERlbCBSZWdubw0KPiA+IHdyb3RlOg0KPiA+ID4gDQo+ID4gPiBFeHRlcm5h
bCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cw0K
PiA+ID4gdW50aWwNCj4gPiA+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNv
bnRlbnQuDQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gSWwgMTMvMTAvMjUgMTU6NDEsIFNqb2VyZCBT
aW1vbnMgaGEgc2NyaXR0bzoNCj4gPiA+ID4gSGV5LA0KPiA+ID4gPiANCj4gPiA+ID4gT24gVHVl
LCAyMDI1LTA4LTA1IGF0IDA5OjQ3ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubw0K
PiA+ID4gPiB3cm90ZToNCj4gPiA+ID4gPiBJbiBwcmVwYXJhdGlvbiB0byBhZGQgc3VwcG9ydCBm
b3IgbmV3IGdlbmVyYXRpb24gU29DcyBsaWtlDQo+ID4gPiA+ID4gTVQ4MTk2LA0KPiA+ID4gPiA+
IE1UNjk5MSBhbmQgb3RoZXIgdmFyaWFudHMsIHdoaWNoIHJlcXVpcmUgdG8gc2V0IGJ1cw0KPiA+
ID4gPiA+IHByb3RlY3Rpb24gb24NCj4gPiA+ID4gPiBkaWZmZXJlbnQgYnVzc2VzIHRoYW4gdGhl
IG9uZXMgZm91bmQgb24gbGVnYWN5IGNoaXBzLCBhbmQgdG8NCj4gPiA+ID4gPiBhbHNvDQo+ID4g
PiA+ID4gc2ltcGxpZnkgYW5kIHJlZHVjZSBtZW1vcnkgZm9vdHByaW50IG9mIHRoaXMgZHJpdmVy
LCByZWZhY3Rvcg0KPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+IG1lY2hhbmlzbSB0byByZXRyaWV2
ZSBhbmQgdXNlIHRoZSBidXMgcHJvdGVjdGlvbiByZWdtYXBzLg0KPiA+ID4gPiA+IA0KPiA+ID4g
PiA+IFRoaXMgaXMgZG9uZSBieSByZW1vdmluZyB0aGUgdGhyZWUgcG9pbnRlcnMgdG8gc3RydWN0
IHJlZ21hcA0KPiA+ID4gPiA+IGZyb20NCj4gPiA+ID4gPiBzdHJ1Y3Qgc2Nwc3lzX2RvbWFpbiAo
YWxsb2NhdGVkIGZvciBlYWNoIHBvd2VyIGRvbWFpbikgYW5kDQo+ID4gPiA+ID4gbW92aW5nDQo+
ID4gPiA+ID4gdGhlbSB0byB0aGUgbWFpbiBzdHJ1Y3Qgc2Nwc3lzIChhbGxvY2F0ZWQgcGVyIGRy
aXZlcg0KPiA+ID4gPiA+IGluc3RhbmNlKSBhcw0KPiA+ID4gPiA+IGFuIGFycmF5IG9mIHBvaW50
ZXJzIHRvIHJlZ21hcCBuYW1lZCAqKmJ1c19wcm90Lg0KPiA+ID4gPiANCj4gPiA+ID4gVHJ5aW5n
IHRvIGJvb3QgdjYuMTguMC1yYzEgb24gYSBHZW5pbyA3MDAgRVZLIHVzaW5nIHRoZSBhcm02NA0K
PiA+ID4gPiBkZWZjb25maWcsDQo+ID4gPiA+IGVuZHMgdXAgaGFuZ2luZyBhdCBib290IChzZWVt
aW5nbHkgd2hlbiBwcm9iaW5nIE1UVTMgYW5kL29yDQo+ID4gPiA+IG1tYywNCj4gPiA+ID4gYnV0
IHRoYXQNCj4gPiA+ID4gbWlnaHQgYmUgYSByZWQgaGVycmluZykuDQo+ID4gPiA+IA0KPiA+ID4g
PiBFaXRoZXIgcmV2ZXJ0aW5nIHRoaXMgcGF0Y2ggKm9yKiBoYXZpbmcgQ09ORklHX01US19NTVNZ
Uw0KPiA+ID4gPiBidWlsdGluDQo+ID4gPiA+IHJhdGhlcg0KPiA+ID4gPiB0aGVuIGEgbW9kdWxl
IHNlZW1zIHRvIHNvbHZlIHRoYXQuDQo+ID4gPiA+IA0KPiA+ID4gDQo+ID4gPiBUaGFua3MgZm9y
IHRoZSByZXBvcnQuDQo+ID4gPiANCj4gPiA+IFRoaXMgaXMgbm90IGEgcHJvYmxlbSB3aXRoIHRo
aXMgcGF0Y2ggc3BlY2lmaWNhbGx5LCBidXQgc3VyZWx5DQo+ID4gPiBzb21lDQo+ID4gPiByYWNl
IGNvbmRpdGlvbg0KPiA+ID4gdGhhdCB3YXMgYWxyZWFkeSBwcmVzZW50IGJlZm9yZSBhbmQgdGhh
dCBkb2VzIGdldCB1bmNvdmVyZWQgd2l0aA0KPiA+ID4gdGhpcw0KPiA+ID4gb25lIGluIHNvbWUN
Cj4gPiA+IGNvbmRpdGlvbnMuDQo+ID4gPiANCj4gPiA+IFdpdGhvdXQgdGhlIGRldmljZXRyZWUg
dXBkYXRlcyAod2hpY2ggYXJlIG5vdCB1cHN0cmVhbSB5ZXQpIHRoaXMNCj4gPiA+IHBhdGNoIGlz
DQo+ID4gPiBmdWxseSByZXRhaW5pbmcgdGhlIGxlZ2FjeSBmdW5jdGlvbmFsaXR5IDEtdG8tMS4N
Cj4gPiA+IA0KPiA+ID4gSSdsbCBjaGVjayB3aGF0J3MgZ29pbmcgb24gQVNBUC4NCj4gPiA+IA0K
PiA+ID4gQ2hlZXJzLA0KPiA+ID4gQW5nZWxvDQo+ID4gPiANCj4gPiANCj4gPiBUaGlzIGlzc3Vl
IGFsc28gaGFwcGVuZWQgb24gbXQ4MTk1LiBJJ3ZlIGRvbmUgYmlzZWN0IG9uIGxpbnV4LW5leHQN
Cj4gPiBtYXN0ZXIgd2l0aCBtdDgxOTUtZ2VuaW8tMTIwMC1ldmsgYm9hcmQuDQo+ID4gVGhlIHJl
c3VsdCBzaG93cyBjMjkzNDVmYTVmNjZiZWEwNzkwY2YyMjE5ZjU3Yjk3NGQ0ZmMxNzdiIGlzIHRo
ZQ0KPiA+IGZpcnN0DQo+ID4gYmFkIGNvbW1pdC4NCj4gPiANCj4gPiBJIGNhbm5vdCBzaW1wbHkg
cmV2ZXJ0IHRoaXMgY29tbWl0IHNpbmNlIHRoZXJlIGFyZSBzb21lDQo+ID4gZGVwZW5kZW5jaWVz
DQo+ID4gY29tbWl0cy4NCj4gPiANCj4gPiBJJ20gbm90IHN1cmUgaWYgdGhlcmUgYXJlIGFueSBB
UEkgb3IgZmxhZyBjaGFuZ2Ugd291bGQNCj4gPiBhZmZlY3QgaW50ZXJhY3Rpb24gYmV0d2VlbiB0
aGUgcG0tZG9tYWluIGRyaXZlciBhbmQgc2NwIGZpcm13YXJlLg0KPiANCj4gSSdtIDk5JSBzdXJl
IHRoYXQgdGhlIFNDUCBmaXJtd2FyZSBoYXMgbm90aGluZyB0byBkbyB3aXRoIHRoaXMgLSBidXQN
Cj4gdGhlbg0KPiBldmVuIGlmIGl0IGRpZCwgdGhlcmUncyBzb21lIHF1aXJrIHRvIGJlIHVuY292
ZXJlZCBhbmQgcHJvcGVybHkNCj4gaGFuZGxlZC4NCj4gDQo+IFNvIC0gaWYgaXQgaXMgKGFnYWlu
LCBtb3N0IHByb2JhYmx5IG5vdCkgYSBmaXJtd2FyZSBpc3N1ZSwgaXQgd2FzDQo+IG9ubHkgYQ0K
PiBtYXR0ZXIgb2YgdGltZSB1bnRpbCB0aGlzIHNpdHVhdGlvbiB3b3VsZCd2ZSBoYXBwZW5lZC4g
SXQncyBwcmV0dHkNCj4gY29tbW9uDQo+IHRvIHNlZSB0d28gd3JvbmdzIG1ha2luZyBvbmUgdGhp
bmcgcmlnaHQgKGJ1dCBpbiAxMDAlIG9mIHRoZSBjYXNlcyBpdA0KPiBkb2VzDQo+IGV2ZW50dWFs
bHkgYnJlYWspLg0KPiANCj4gPiBKdXN0IGEgcmVtaW5kIGl0IGlzIGhhcmQgZm9yIE1lZGlhVGVr
IHRvIHVwZGF0ZSBzY3AgZmlybXdhcmUgZm9yIGENCj4gPiBtYXNzIHByb2R1Y3Rpb24gY2hpcC4g
RWFjaCBzY3AgZmlybXdhcmUgc2VlbXMgc3BlY2lmaWNhbGx5IGRlc2lnbmVkDQo+ID4gZm9yDQo+
ID4gZWFjaCBjaGlwIHNlcGFyYXRlbHkgd2hpY2ggbGVhZHMgdGhlIEFQSSBtaWdodCBiZSBjaGFu
Z2VkIGJldHdlZW4NCj4gPiBlYWNoDQo+ID4gY2hpcC4NCj4gPiANCj4gDQo+IEFkZGluZyBMb3Vp
cy1BbGV4aXMgdG8gdGhlIGxvb3A7DQo+IA0KPiBMb3VpcywgY2FuIHlvdSBwbGVhc2UgdHJ5IHRv
IHJlcHJvZHVjZSB0aGlzIG9uZSBvbiBhbnkgb2Ygb3VyIGJvYXJkcz8NCj4gSSBjYW4ndCBzZWVt
IHRvIGJlIGFibGUgdG8gcmVwcm9kdWNlIGhlcmUuDQo+IA0KPiBDaGVlcnMsDQo+IEFuZ2Vsbw0K
PiANCj4gDQoNCkFuZ2VsbyBhbmQgTG91aXMsIA0KUGxlYXNlIHB1dCB0aGlzIGlzc3VlIHRvIGxv
dyBwcmlvcml0eS4NCkkgZGlkIHJlcG9ydGVkIHRoaXMgaXNzdWUgYnV0IGl0IHNob3VsZCBiZSBx
dWl0ZSBhIHdoaWxlIGZyb20gbm93Lg0KDQpJJ20gbm90IHN1cmUgd2h5IGFuZCBob3cgdGhlIG1h
aWwgY2xpZW50IG9yIG1haWwgc2VydmVyIHNlbmQgb3V0IHRoaXMNCm1haWwgc28gbGF0ZSwgYW5k
IGl0IGhhcyBiZWVuIHNlbnQgdHdpY2UgdW50aWwgSSd2ZSBkaXNjb3ZlcmVkIHJpZ2h0DQpub3cu
DQpJIGd1ZXNzIHRoaXMgaXNzdWUgaGFzIGJlZW4gZ29uZSBkdXJpbmcgNi4xOC1yY1ggcGVyaW9k
Lg0KSG93ZXZlciwgZG91YmxlIGNoZWNrIHRoZSBsYXRlc3Qgc3RhdHVzIHdpdGggbGF0ZXN0IGtl
cm5lbCB2ZXJzaW9uIGlzDQpnb29kLiBJIHRoaW5rIGl0IHNob3VsZCBiZSBmaXhlZCBhbHJlYWR5
IHdpdGggQUZCQyBwYXRjaCBvciBzb21ldGhpbmcNCmFyb3VuZCB0aGF0IHRpbWUuIA0KDQo+ID4g
VGhlIGVycm9yIGxvZyBvY2N1cnMgb24gZW1tYyBhdCBmaXJzdCBhbmQgdGhhbiByY3VfcHJlZW1w
dCBoYXBwZW5zLg0KPiA+IFvCoMKgwqAgMS4yOTEwNTVdIG10ay1tc2RjIDExMjQwMDAwLm1tYzog
bXNkY190cmFja19jbWRfZGF0YTogY21kPTgNCj4gPiBhcmc9MDAwMDAxQUE7IGhvc3QtPmVycm9y
PTB4MDAwMDAwMDINCj4gPiBbwqDCoMKgIDEuMjkyNzc1XSBtdGstbXNkYyAxMTI0MDAwMC5tbWM6
IG1zZGNfdHJhY2tfY21kX2RhdGE6IGNtZD01NQ0KPiA+IGFyZz0wMDAwMDAwMDsgaG9zdC0+ZXJy
b3I9MHgwMDAwMDAwMg0KPiA+IFvCoMKgwqAgMS4yOTQ1MzldIG10ay1tc2RjIDExMjQwMDAwLm1t
YzogbXNkY190cmFja19jbWRfZGF0YTogY21kPTU1DQo+ID4gYXJnPTAwMDAwMDAwOyBob3N0LT5l
cnJvcj0weDAwMDAwMDAyDQo+ID4gW8KgwqDCoCAxLjI5NjI5M10gbXRrLW1zZGMgMTEyNDAwMDAu
bW1jOiBtc2RjX3RyYWNrX2NtZF9kYXRhOiBjbWQ9NTUNCj4gPiBhcmc9MDAwMDAwMDA7IGhvc3Qt
PmVycm9yPTB4MDAwMDAwMDINCj4gPiAuLi4NCj4gPiBbwqDCoMKgIDEuNDMwNDA4XSBtdGstbXNk
YyAxMTI0MDAwMC5tbWM6IG1zZGNfdHJhY2tfY21kX2RhdGE6IGNtZD01NQ0KPiA+IGFyZz0wMDAw
MDAwMDsgaG9zdC0+ZXJyb3I9MHgwMDAwMDAwMg0KPiA+IFvCoMKgwqAgMS40MzM3NjZdIG1tYzA6
IEZhaWxlZCB0byBpbml0aWFsaXplIGEgbm9uLXJlbW92YWJsZSBjYXJkDQo+ID4gW8KgwqAgMjIu
Mjk3MjQwXSByY3U6IElORk86IHJjdV9wcmVlbXB0IGRldGVjdGVkIHN0YWxscyBvbg0KPiA+IENQ
VXMvdGFza3M6DQo+ID4gW8KgwqAgMjIuMjk4NzIzXSByY3U6wqDCoMKgwqAgNi0uLi4wOiAoMiB0
aWNrcyB0aGlzIEdQKQ0KPiA+IGlkbGU9MTA0Yy8xLzB4NDAwMDAwMDAwMDAwMDAwMCBzb2Z0aXJx
PTQ1LzQ1IGZxcz0zNw0KPiA+IFvCoMKgIDIyLjI5OTgyN10gcmN1OsKgwqDCoMKgIChkZXRlY3Rl
ZCBieSAyLCB0PTUyNTYgamlmZmllcywgZz0tMTA1MSwNCj4gPiBxPTIwMA0KPiA+IG5jcHVzPTgp
DQo+ID4gW8KgwqAgMjIuMzAwNjg5XSBTZW5kaW5nIE5NSSBmcm9tIENQVSAyIHRvIENQVXMgNjoN
Cj4gPiAuLi4NCj4gPiANCj4gPiBCZXN0IHJlZ2FyZHMsDQo+ID4gTWFjcGF1bCBMaW4NCj4gPiAN
Cj4gDQo+IA0KQmVzdCByZWdhcmRzLA0KTWFjcGF1bCBMaW4NCg==

