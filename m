Return-Path: <linux-pm+bounces-42541-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIrXD76LjWnq3wAAu9opvQ
	(envelope-from <linux-pm+bounces-42541-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 09:13:50 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE5212B23E
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 09:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C12423074A89
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 08:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C244A2C11C9;
	Thu, 12 Feb 2026 08:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="HSvvS4bK";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="dHD0UqlO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AE1279DC8;
	Thu, 12 Feb 2026 08:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770884024; cv=fail; b=bQLo4+MSKhjph0CxUp6XCkfGI/uG+36LQDrrv6msvhcFl+yaI7DU0ESt3YuaiTN17kAyJwY3aMELKgkwvLSxw7NDVQqtZo5kAPjwBdhEj5hTFQWcl7n9tdHv23OM93+rhJKze3oZa0rTsgjLslI9iSt0tvIDcJuRiDj+tfaC63g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770884024; c=relaxed/simple;
	bh=V6sQRdv0gdyDuDW5deARJm1wRHqNaBqk1W5pj9mt6DA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iFyXqiZHlzJw0xiqp/LuFSX8UYPLGWY+oX7NdS7t5pBxFjiuEYEudD1S/NcQv/1yeLItUN3Lbzyo9jOubkvKC2DZayWcErZyuYgd19LumFzOdrZOouFspJjx2mECVUzvgH+EKA1npTDP19gq676nP0lCjD11H0WN0AtQYNPD4nQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=HSvvS4bK; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=dHD0UqlO; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a1bc6b4407e811f1b7fc4fdb8733b2bc-20260212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=V6sQRdv0gdyDuDW5deARJm1wRHqNaBqk1W5pj9mt6DA=;
	b=HSvvS4bKjTDQKxf0RvLPlpUOPp50LC72Zypye17usal6b+OQQGmMXYai4jllLZnHNGlP9yIIZevmhNABFyhGBhc3mpjVoF6HuT0bSXPOqxF33Rxng5PB8mHpRvOsGfF5PIo6Y+nHHYYqDsKi9/axTpTxdi+OnhnDvePpYcZOw6g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:99a0d104-b8f3-49ff-b447-6b89be39555d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:8cca375b-a957-4259-bcca-d3af718d7034,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
	C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a1bc6b4407e811f1b7fc4fdb8733b2bc-20260212
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 319212086; Thu, 12 Feb 2026 15:58:35 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 12 Feb 2026 15:58:34 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 12 Feb 2026 15:58:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nAhCoLX35L6+39Ep+O4LCAj8jjZnprOFVYyQ8HwlyIWehQUyT/WWnDDWNW+M/OK8EqcEA00V0muN5iHQblYlxtaxWgBp0cx7UxVI2nWOHtr8qfoEipSEj76OTzWl7yyy1yySjVjCKd9zNjDbGA/x7NSe9nK+KTqrBSXZ0Hb/Uia0e8J8tGSnKlshxfEbga0Rk8eOR5LknujLcHa5g0WJ+BjcIgSHUH4/lYFtI2pDJ10LIGG1wGkCA+WIAl0ejNKJvl/sUXAmpqXW4hd/3Lo8URntnw5AcPacMbsu5DjM0nSx2k8Ef/OL5dANC+FQ1ZxDugJT1oQqW8jp5Ec/+LjFrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6sQRdv0gdyDuDW5deARJm1wRHqNaBqk1W5pj9mt6DA=;
 b=VGiBrdOWLfIoQVNAoasIxpHS1SIRSZC0WCquV80PM+U35F6+rOiSE08+m4cLWoKHg2nAHTc4ApsKIZP1hPEVoAB41fpEYUEHHrKZ27j3TJlcdHRtW/K6dLJxxi7uwx/bi7wpvFmFZcVWgjzTZZ7aUgvZ+I8sV24eI+iugbaM+V24y5hqYw+Kz2ZRCnwPAPXpn8V1x/c86FSI4OEQXk2veMsBf1LVXkB336REgh6vqmOSmjzTI2inHtSoDESORee62t+TZVRaZjjgUXMapSLQLkVKlCqRZmVgr9YZwPxQvBJE9Hz23+yGhOGjUz03rFQVOCIY3jFx9yYVh4A7jfNplw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6sQRdv0gdyDuDW5deARJm1wRHqNaBqk1W5pj9mt6DA=;
 b=dHD0UqlO1Rq5fMlVTCQRojg34RjX4Kilq+EsCY+OHl+YZzGR2vm+KkHi7U4G+hQgp5CuzjmQnlhjGe7WOVc1sY0ulS30zDtRSjB1zdC6XfoPf0WRTxZmG5huw2cc0gzCuM/kfJ3GIggkGw7N0D0DQTzilepfg5toJgm6+C1pjvQ=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by JH0PR03MB7906.apcprd03.prod.outlook.com (2603:1096:990:3f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 07:58:31 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 07:58:31 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, "Sjoerd
 Simons" <sjoerd@collabora.com>
CC: =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
	"lihongbo22@huawei.com" <lihongbo22@huawei.com>, "robh@kernel.org"
	<robh@kernel.org>, "kernel@collabora.com" <kernel@collabora.com>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	=?utf-8?B?TW91ZHkgSG8gKOS9leWul+WOnyk=?= <Moudy.Ho@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	=?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
	"mbrugger@suse.com" <mbrugger@suse.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	Nicolas Prado <nfraprado@collabora.com>, "wenst@chromium.org"
	<wenst@chromium.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "y.oudjana@protonmail.com"
	<y.oudjana@protonmail.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, =?utf-8?B?TWFuZHlKSCBMaXUgKOWKieS6uuWDlik=?=
	<MandyJH.Liu@mediatek.com>
Subject: Re: [PATCH v3 04/10] pmdomain: mediatek: Refactor bus protection
 regmaps retrieval
Thread-Topic: [PATCH v3 04/10] pmdomain: mediatek: Refactor bus protection
 regmaps retrieval
Thread-Index: AQHcBd2MjPcMwIChxES6TVgTt4RGv7TAgoSAgAFUIYCAFygogA==
Date: Thu, 12 Feb 2026 07:58:31 +0000
Message-ID: <fd071501b66fb332439617f2b270c837043b0862.camel@mediatek.com>
References: <20250805074746.29457-1-angelogioacchino.delregno@collabora.com>
	 <20250805074746.29457-5-angelogioacchino.delregno@collabora.com>
	 <a2eae87efe46ebf397bcec3580eb9bc152b80846.camel@collabora.com>
	 <be3a2d50-044b-429a-820c-5260c6ce730c@collabora.com>
In-Reply-To: <be3a2d50-044b-429a-820c-5260c6ce730c@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|JH0PR03MB7906:EE_
x-ms-office365-filtering-correlation-id: 3010768a-ddd3-4829-f40d-08de6a0c8385
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?L0ZmUjM5QmJyazFheXQxLzRnNXJHVTFYRXR4cEhsS05kdTBUNlJmRXp2eCto?=
 =?utf-8?B?RjRQNnJOd0EwSTJ2bmNvSDJtM3p1cEpsL3JiZ1VEL0ZBaERtaEtkTU9wS0Zq?=
 =?utf-8?B?WDNRMFoxdUZzamhlaXRPSzdEQ2wzU2JIVDh1djI0cHN5K3ZGUUR5a3ZkUUs5?=
 =?utf-8?B?bG1LTEZNQ1F6cG9IR3duclRGaFF6UDl6aWJ3M2lnZjdTVVJTbFNYN1FCK3dv?=
 =?utf-8?B?MHRuYWQ0c1BnWE0wOFE4SWdZMFlCNmhySUp3enhCdDlTV2x5R2J6MlBod2h6?=
 =?utf-8?B?Vkh6Q05qZnFMTkMxcWwzUStUSzgydTJ4cnEvUWJ1RW1NaEc2b2tvc1JpbTd3?=
 =?utf-8?B?RkNlVWxJR2FxWkgvS2RkVk1zQ1J5Q3pxRTFVZXE5ZHNFWFFPenBKVFBjZCta?=
 =?utf-8?B?VENSMk9pM0FvdnIzZ0lHbDZtZTBiRXRMUkUrTjlRSm95ZzFITzc0dHVUeE8x?=
 =?utf-8?B?cDNPR3pCRHBBQ2FWRnRkS2Y1aXRGL1BsQ25JeGQ5T3NaaHBzTUltREFLUVZ2?=
 =?utf-8?B?M0VHWnJwZ085TkdDanVCdERiQVQ5RTJ2MjdDS1ZnaUJ2aitYbW1QS1dRQWYw?=
 =?utf-8?B?andERnRpNGNtdVphWWphZmhkU05abjVoWWdmcTcyL3ArZkxGdkQ5K2hYdXNH?=
 =?utf-8?B?TGM5U3R3NlQ1bVN4MURacE5rWjZJanl1bHlqSU9iVkU3cXNKZGJLUXIyT3Zt?=
 =?utf-8?B?T0dueG5vaTRHOG4wb3dhTUVIRFlIdTJDaHBicFUxYWI5VTVMd3NId3o2ZVNm?=
 =?utf-8?B?UG1kODBmU0diVjRkTXZ4Y2JDcDFCUlRyRlBleDZzODJncTRWU0pZbldMUUVM?=
 =?utf-8?B?K25CWlRxNkp1U25iT0Q1Vk5TdTdUemF5OGtnRjJURERUWVowSUZQNkpUV3dw?=
 =?utf-8?B?N1RvOHdnTXQ0UkdOZ1VaeEdqaWtqNEpYQ0Fwbk5KRHNNNnhyWXFpSG1DY0tW?=
 =?utf-8?B?MnkybGlHWTM4VzE2MHYyM3BqK25VSnRSR2ZuZkdpTmYvYXBSUXI1QXVZd0lI?=
 =?utf-8?B?VmozMWNIZ1ZJdTB5Wno2RTAxK0QvQUs2RFZwVzBzSlNkNTUwZEFNcVRLbkt4?=
 =?utf-8?B?V3BVUDRVL2JHRithVWJidGMvQitMRVRCblZ1V0hGZ1E2U0NDRGdXWWZLTnZN?=
 =?utf-8?B?WGdqR01GZlVnK1Z1bVJ3SDFFVVJuS3RQN250TVl5b3JqWVJ5SWxtK3FjV1R3?=
 =?utf-8?B?OGJ6SG9QMVRJWlhNUU1OenZkdm54bDA2WVdsNHRxU29USEo3RTlOVDlKc282?=
 =?utf-8?B?ZEZDVGt3SHAxRjJhUTNmbW43MythRVZVSi80eWJxOXJNRWVtT1hXSFZGT1RY?=
 =?utf-8?B?KzIxd3VPVVRtYXdoZnppZHlyNER4WG8vZFVRcXVZZlZVaC9lTFc1UDJwT0VM?=
 =?utf-8?B?cDk0M3FVcFExWG1xWDI2eDBkZlJaYzZpejhGeC93WnJBeFNxZlMrUE5TSHB1?=
 =?utf-8?B?WXV4N2R5SWZNN2NFWDlINXZ3cWIvMzR6RnJoL1c5VlJUN1VjRzFMZFBDeHk0?=
 =?utf-8?B?d091ME95MUdpQVBnMENLUlN6R284QmVGREpsazVjVGhkL2lMRVlaek5nK2wz?=
 =?utf-8?B?NUtZM2cxZlFrdlpVQnB5a2xUTnJBb2FrQUlXRHZjUGtOVVNNemFRVDl6SmxX?=
 =?utf-8?B?SGZtVWQycUhoMllpMUg0MmpJMVpxb1ZTaUFPNk9kY3FJUWNBZkVWazFlRnhQ?=
 =?utf-8?B?UWoyTERmcHBUUlhrcnhBdXNNYTErWk82VjE1NDdLUEJqcHk2Uy9adkt4WjFi?=
 =?utf-8?B?UUdIWU9xL28vL1I5aDdNNkhpV1FYcXd5eFNFYzN2WmtkVFJnZ1pQdVc4eVEr?=
 =?utf-8?B?YndSMG80VUs0akV3VVpqZWVraldENUwrYWxpV0luRStQR1F3YTYyVE5EYnAy?=
 =?utf-8?B?eHdHMkt2L2ZpaXo4R0wzNm1mM0ErVjk0THREWWpNaS9OWE9zcThHT20xUTMv?=
 =?utf-8?B?ZnlLTTMxbXk4Q09BbDlFVzI4c0I4WUM5Q0VYeDgrcmVXUkRhUmdNUTZLMHZM?=
 =?utf-8?B?Znc0SEdaaU52ZkMyRVRxK2dRd3NYYnI2TFZJLzdDS3dPQlM3eWJMOTRCeEJQ?=
 =?utf-8?B?OEJXUFpkZjc2Vm5ua3c4NlJaWXJFUTNDUjAzeC9OcElKdUk1T2w4a2d4RHZx?=
 =?utf-8?B?bVY3RTQ2ZmNMS2hxQmxwanpSTGkzTXo4aTBBMEdIMWI1V3NQcXViQkhkVlQz?=
 =?utf-8?Q?lnDqDATSupSp29DkhETGGFw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7810.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzF1b0RBdm5oOHdwcFNPQ1ovYjJjTDhTa3FTY0VodW85bTZrNk1VNEhZSFds?=
 =?utf-8?B?ZENHL2pNai9BL0tib2JYd1QzMnEyRlpSWFFTZWxSOThSclV5NG0rVWIwa0sr?=
 =?utf-8?B?UlZsNmlnRjdqMFMxMGlSQ0JFUVU0T3FDdTF5cVNsbmtjdGFlYTNCZ2xEc29E?=
 =?utf-8?B?N1pHMitIUUlHQkNrWG1wRlJicE1XaEwrWkZzczR1TmdNdFd0NngvN0IyYVo5?=
 =?utf-8?B?djRmdXRjcDVqOFo5Yks4aHNmRHNrY3A0ZEM3dEhNQW9TV1RYUEVDTXdVQVY2?=
 =?utf-8?B?TnZuaExyZDBVMnFENENiVkR3eDhGVzZaL0E3SjBkVmdmbHlsYi9aeUlwVkpI?=
 =?utf-8?B?RW5MMG1oSnViRjJQcWxydzBJTXowZkhadkpQd3lQeGJyOVdkayt5L2xzcHdU?=
 =?utf-8?B?RkhKQU9aK1lUMTNDL25YQ1pOUGRJQUtsemI2UDh5Tkx0cWFqZndoakcxNkEy?=
 =?utf-8?B?ZGx6TzFmZXdMY1B6UUFFMkVRalFNcFQ5Q1VGSDM4M1Y0aHp6eHdXaTdSNFZC?=
 =?utf-8?B?VVhPMFUxWlJyRSswKzVnaWgyelo2dlNEOXBOMkExWlAxN29NMExYVXM2eXU3?=
 =?utf-8?B?S0o2NFFnSHRwT2M4Q0trekdqbDdJanEyU2tpZUZVOVpWLzhBekZyeEpZaHpI?=
 =?utf-8?B?VnRyOUxHUURyZGRMRUFrbnVVdkZMWnBVYU1paG9Xb2o1NHVwTzFPRlpJSGRH?=
 =?utf-8?B?eXk2QlRTNjlsamZkOXBsYU1BaVk4dXFwWUowZjZxTDV0NVRKbFg1Wm5HUFox?=
 =?utf-8?B?aEhaNVVlODlrY0lUMmZaTGZqeVRzVVl5Q1E2MFFrNmJrQ1doVS9xR0RrdnB4?=
 =?utf-8?B?WVRBbWtub1dJM0Y1K1dkZWVqY3M3L3l5L3ZOcDlIc3V4NTkyd3Jvc1BicDdv?=
 =?utf-8?B?QStlYVRLTjhnR1V4MGwvOVFWSUp0R2I5bTZPc2tIdGxidkxad3paQkRQa0R1?=
 =?utf-8?B?THptMGF0dlhTK0xRNnE0bENYeFdqYjFxd2JFMWZIRjlhcFI5T3B0ZXNaQ0tI?=
 =?utf-8?B?YW5CUm1pN3FGMUhWZnRsVHlxQmJPc3pRekp1d2RobDZpS3JUTzF2bm83OVVj?=
 =?utf-8?B?TlFmcjhJS3lMa2RUTFVSSTlhRTlSclZNUlM3cDB6azRITmJRZS9ndy9LK3RM?=
 =?utf-8?B?VUJES3k0cHR1QnJscmM5L0I3SFczdDB3ZkwxNktwUWZtSm5QTEVuWlRlY1ZV?=
 =?utf-8?B?cDUydkMzMWpxd2pJaU4xZDlUMzh5SUY3NDlKK2hXNGhTREpobkFTNTdWNmU3?=
 =?utf-8?B?bTB4aHJxTGY1d3dSU3krWURSWVVFOFhOanI1czlBMGwwcXA1Wm1BdDdTVjcv?=
 =?utf-8?B?R3RDTDI1UVp3NGtsa2dVOWV3WjFobC9oVXdzQW1WMGU4eXgyNVl3ZzM0b3Rp?=
 =?utf-8?B?ajA1S2x6dmlzSElkaFVKZW92OHJCLys1MWcyM3VlelowU0pyN0tBMUl6Nm1t?=
 =?utf-8?B?SjZybEpjTnVJaFdPVTZnMGJ0Q0g4TUkvditWWEtlZ0RNQUFNQW5NVGROVXZn?=
 =?utf-8?B?U0x6T1hlSERZMlNZdmoyRHFMMU1OM05raHNkb3luNkY2VmRWWHcyUWpnQVRl?=
 =?utf-8?B?eVhoOEMzRjVOZ3N0YkZhcHNZVnZaQzBlckdQREdaVGJwYjF6d3ZIUzE4TlAy?=
 =?utf-8?B?ejhiK1Q4R3NNWTdjUTBlN2cxQmIrK1JEN2o0RVdnWDJ0TEFVR3Y3ckFYczIy?=
 =?utf-8?B?ZERHSFhzeFdYZmp2ai9SWm1mdUdPSHo0M2J3L3hKN2FYWlQrZUh6ZU5mVmsy?=
 =?utf-8?B?NVVyVnA5NmhSVEh6dFFkbU1BQkhGcnBpajZwMm9ocmtMMGg5dGtETDZ4RTND?=
 =?utf-8?B?SVBJVllsK05LMjF2S1diZGtCb1pVQjdTQlJHb0RTME5kL1ZZeFpJbHR4Yjd4?=
 =?utf-8?B?UUNUQUlucGo4RzdlcjlwUTN1ZGNva1Z2OHVyZG5xang0K3plY2RLVkxYTEpu?=
 =?utf-8?B?S2l3eTZ3NUswV3dKTm11T0xySDkyeVQ5SjZLVFdRY2FTa0V3Z2xuV0tnWnd6?=
 =?utf-8?B?RXc1RVg5amdwQ3Q5V1RzYlp0UEI5ZCtxT0tQVG16TE9aQi92Q3lYeWJkTktX?=
 =?utf-8?B?RDFKRDRMcFIyMm1IeWx3L0N2MEJwcDR5ek5FWCtQYkpySU5PYnhpclBra0kx?=
 =?utf-8?B?RStQWW54WW5BM1VFSUI0YUVOcFRZT29Pc2ZhODRyQ254Y1cvUjJacDNTQThl?=
 =?utf-8?B?bEJWbVpNOWpHTnN4RkRGdjNlL2hJQ1RpWlpIQ3BaVG5vcW9EUWZCWHdyRGl1?=
 =?utf-8?B?MGluU0JzcVdNZ3kxOEtpa1psTUdOdE41Q2U0ZEZiaUNrbnpMeVRKZGNlaC81?=
 =?utf-8?B?dU1LeE1JWjRWUlhJbS9ONUMybEdVb3gvWDJjb24vak5JME9rUmhBQ2RHTVdX?=
 =?utf-8?Q?qLlAb+eX0N/Iqi3k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F569F4AD8417E42979A414A6319E175@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3010768a-ddd3-4829-f40d-08de6a0c8385
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 07:58:31.1693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z6jQyMmjo6Lco5+ib5g1t+aahOyRy4+QVqCLWCZbhC2pObzMAHpsv1nC3j4yu7wGAhmzwkWBOuty7w/0lxvvz7yRYM9sPQKdRXETVSQjqnQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7906
X-MTK: N
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk,mediateko365.onmicrosoft.com:s=selector2-mediateko365-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-42541-lists,linux-pm=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[mediatek.com,huawei.com,kernel.org,collabora.com,linaro.org,vger.kernel.org,suse.com,chromium.org,lists.infradead.org,protonmail.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:mid,mediatek.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mediateko365.onmicrosoft.com:dkim];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: CBE5212B23E
X-Rspamd-Action: no action

T24gVHVlLCAyMDI1LTEwLTE0IGF0IDExOjU5ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBs
aW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBz
ZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+IA0KPiANCj4gSWwgMTMvMTAvMjUgMTU6NDEsIFNqb2Vy
ZCBTaW1vbnMgaGEgc2NyaXR0bzoNCj4gPiBIZXksDQo+ID4gDQo+ID4gT24gVHVlLCAyMDI1LTA4
LTA1IGF0IDA5OjQ3ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubw0KPiA+IHdyb3Rl
Og0KPiA+ID4gSW4gcHJlcGFyYXRpb24gdG8gYWRkIHN1cHBvcnQgZm9yIG5ldyBnZW5lcmF0aW9u
IFNvQ3MgbGlrZQ0KPiA+ID4gTVQ4MTk2LA0KPiA+ID4gTVQ2OTkxIGFuZCBvdGhlciB2YXJpYW50
cywgd2hpY2ggcmVxdWlyZSB0byBzZXQgYnVzIHByb3RlY3Rpb24gb24NCj4gPiA+IGRpZmZlcmVu
dCBidXNzZXMgdGhhbiB0aGUgb25lcyBmb3VuZCBvbiBsZWdhY3kgY2hpcHMsIGFuZCB0byBhbHNv
DQo+ID4gPiBzaW1wbGlmeSBhbmQgcmVkdWNlIG1lbW9yeSBmb290cHJpbnQgb2YgdGhpcyBkcml2
ZXIsIHJlZmFjdG9yIHRoZQ0KPiA+ID4gbWVjaGFuaXNtIHRvIHJldHJpZXZlIGFuZCB1c2UgdGhl
IGJ1cyBwcm90ZWN0aW9uIHJlZ21hcHMuDQo+ID4gPiANCj4gPiA+IFRoaXMgaXMgZG9uZSBieSBy
ZW1vdmluZyB0aGUgdGhyZWUgcG9pbnRlcnMgdG8gc3RydWN0IHJlZ21hcCBmcm9tDQo+ID4gPiBz
dHJ1Y3Qgc2Nwc3lzX2RvbWFpbiAoYWxsb2NhdGVkIGZvciBlYWNoIHBvd2VyIGRvbWFpbikgYW5k
IG1vdmluZw0KPiA+ID4gdGhlbSB0byB0aGUgbWFpbiBzdHJ1Y3Qgc2Nwc3lzIChhbGxvY2F0ZWQg
cGVyIGRyaXZlciBpbnN0YW5jZSkgYXMNCj4gPiA+IGFuIGFycmF5IG9mIHBvaW50ZXJzIHRvIHJl
Z21hcCBuYW1lZCAqKmJ1c19wcm90Lg0KPiA+IA0KPiA+IFRyeWluZyB0byBib290IHY2LjE4LjAt
cmMxIG9uIGEgR2VuaW8gNzAwIEVWSyB1c2luZyB0aGUgYXJtNjQNCj4gPiBkZWZjb25maWcsDQo+
ID4gZW5kcyB1cCBoYW5naW5nIGF0IGJvb3QgKHNlZW1pbmdseSB3aGVuIHByb2JpbmcgTVRVMyBh
bmQvb3IgbW1jLA0KPiA+IGJ1dCB0aGF0DQo+ID4gbWlnaHQgYmUgYSByZWQgaGVycmluZykuDQo+
ID4gDQo+ID4gRWl0aGVyIHJldmVydGluZyB0aGlzIHBhdGNoICpvciogaGF2aW5nIENPTkZJR19N
VEtfTU1TWVMgYnVpbHRpbg0KPiA+IHJhdGhlcg0KPiA+IHRoZW4gYSBtb2R1bGUgc2VlbXMgdG8g
c29sdmUgdGhhdC4NCj4gPiANCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHJlcG9ydC4NCj4gDQo+IFRo
aXMgaXMgbm90IGEgcHJvYmxlbSB3aXRoIHRoaXMgcGF0Y2ggc3BlY2lmaWNhbGx5LCBidXQgc3Vy
ZWx5IHNvbWUNCj4gcmFjZSBjb25kaXRpb24NCj4gdGhhdCB3YXMgYWxyZWFkeSBwcmVzZW50IGJl
Zm9yZSBhbmQgdGhhdCBkb2VzIGdldCB1bmNvdmVyZWQgd2l0aCB0aGlzDQo+IG9uZSBpbiBzb21l
DQo+IGNvbmRpdGlvbnMuDQo+IA0KPiBXaXRob3V0IHRoZSBkZXZpY2V0cmVlIHVwZGF0ZXMgKHdo
aWNoIGFyZSBub3QgdXBzdHJlYW0geWV0KSB0aGlzDQo+IHBhdGNoIGlzDQo+IGZ1bGx5IHJldGFp
bmluZyB0aGUgbGVnYWN5IGZ1bmN0aW9uYWxpdHkgMS10by0xLg0KPiANCj4gSSdsbCBjaGVjayB3
aGF0J3MgZ29pbmcgb24gQVNBUC4NCj4gDQo+IENoZWVycywNCj4gQW5nZWxvDQo+IA0KDQpUaGlz
IGlzc3VlIGFsc28gaGFwcGVuZWQgb24gbXQ4MTk1LiBJJ3ZlIGRvbmUgYmlzZWN0IG9uIGxpbnV4
LW5leHQNCm1hc3RlciB3aXRoIG10ODE5NS1nZW5pby0xMjAwLWV2ayBib2FyZC4NClRoZSByZXN1
bHQgc2hvd3MgYzI5MzQ1ZmE1ZjY2YmVhMDc5MGNmMjIxOWY1N2I5NzRkNGZjMTc3YiBpcyB0aGUg
Zmlyc3QNCmJhZCBjb21taXQuDQoNCkkgY2Fubm90IHNpbXBseSByZXZlcnQgdGhpcyBjb21taXQg
c2luY2UgdGhlcmUgYXJlIHNvbWUgZGVwZW5kZW5jaWVzDQpjb21taXRzLsKgDQoNCkknbSBub3Qg
c3VyZSBpZiB0aGVyZSBhcmUgYW55IEFQSSBvciBmbGFnIGNoYW5nZSB3b3VsZMKgDQphZmZlY3Qg
aW50ZXJhY3Rpb24gYmV0d2VlbiB0aGUgcG0tZG9tYWluIGRyaXZlciBhbmQgc2NwIGZpcm13YXJl
Lg0KSnVzdCBhIHJlbWluZCBpdCBpcyBoYXJkIGZvciBNZWRpYVRlayB0byB1cGRhdGUgc2NwIGZp
cm13YXJlIGZvciBhIA0KbWFzcyBwcm9kdWN0aW9uIGNoaXAuIEVhY2ggc2NwIGZpcm13YXJlIHNl
ZW1zIHNwZWNpZmljYWxseSBkZXNpZ25lZCBmb3INCmVhY2ggY2hpcCBzZXBhcmF0ZWx5IHdoaWNo
IGxlYWRzIHRoZSBBUEkgbWlnaHQgYmUgY2hhbmdlZCBiZXR3ZWVuIGVhY2gNCmNoaXAuDQoNClRo
ZSBlcnJvciBsb2cgb2NjdXJzIG9uIGVtbWMgYXQgZmlyc3QgYW5kIHRoYW4gcmN1X3ByZWVtcHQg
aGFwcGVucy4NClsgICAgMS4yOTEwNTVdIG10ay1tc2RjIDExMjQwMDAwLm1tYzogbXNkY190cmFj
a19jbWRfZGF0YTogY21kPTgNCmFyZz0wMDAwMDFBQTsgaG9zdC0+ZXJyb3I9MHgwMDAwMDAwMg0K
WyAgICAxLjI5Mjc3NV0gbXRrLW1zZGMgMTEyNDAwMDAubW1jOiBtc2RjX3RyYWNrX2NtZF9kYXRh
OiBjbWQ9NTUNCmFyZz0wMDAwMDAwMDsgaG9zdC0+ZXJyb3I9MHgwMDAwMDAwMg0KWyAgICAxLjI5
NDUzOV0gbXRrLW1zZGMgMTEyNDAwMDAubW1jOiBtc2RjX3RyYWNrX2NtZF9kYXRhOiBjbWQ9NTUN
CmFyZz0wMDAwMDAwMDsgaG9zdC0+ZXJyb3I9MHgwMDAwMDAwMg0KWyAgICAxLjI5NjI5M10gbXRr
LW1zZGMgMTEyNDAwMDAubW1jOiBtc2RjX3RyYWNrX2NtZF9kYXRhOiBjbWQ9NTUNCmFyZz0wMDAw
MDAwMDsgaG9zdC0+ZXJyb3I9MHgwMDAwMDAwMg0KLi4uDQpbICAgIDEuNDMwNDA4XSBtdGstbXNk
YyAxMTI0MDAwMC5tbWM6IG1zZGNfdHJhY2tfY21kX2RhdGE6IGNtZD01NQ0KYXJnPTAwMDAwMDAw
OyBob3N0LT5lcnJvcj0weDAwMDAwMDAyDQpbICAgIDEuNDMzNzY2XSBtbWMwOiBGYWlsZWQgdG8g
aW5pdGlhbGl6ZSBhIG5vbi1yZW1vdmFibGUgY2FyZA0KWyAgIDIyLjI5NzI0MF0gcmN1OiBJTkZP
OiByY3VfcHJlZW1wdCBkZXRlY3RlZCBzdGFsbHMgb24gQ1BVcy90YXNrczoNClsgICAyMi4yOTg3
MjNdIHJjdTogICAgIDYtLi4uMDogKDIgdGlja3MgdGhpcyBHUCkNCmlkbGU9MTA0Yy8xLzB4NDAw
MDAwMDAwMDAwMDAwMCBzb2Z0aXJxPTQ1LzQ1IGZxcz0zNw0KWyAgIDIyLjI5OTgyN10gcmN1OiAg
ICAgKGRldGVjdGVkIGJ5IDIsIHQ9NTI1NiBqaWZmaWVzLCBnPS0xMDUxLCBxPTIwMA0KbmNwdXM9
OCkNClsgICAyMi4zMDA2ODldIFNlbmRpbmcgTk1JIGZyb20gQ1BVIDIgdG8gQ1BVcyA2Og0KLi4u
DQoNCkJlc3QgcmVnYXJkcywNCk1hY3BhdWwgTGluDQoNCg==

