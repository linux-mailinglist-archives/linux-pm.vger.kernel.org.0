Return-Path: <linux-pm+bounces-38857-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0DDC90A7E
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 03:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3292D4E2051
	for <lists+linux-pm@lfdr.de>; Fri, 28 Nov 2025 02:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B1F1EE7C6;
	Fri, 28 Nov 2025 02:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="amcZxkWg";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="iySrue6i"
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B0B72606;
	Fri, 28 Nov 2025 02:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764298304; cv=fail; b=fzxvR/qx2UphzsKv24EolYu9hdxv585UD0wlCx+7gsCqNlxEg9wpt/C1KBfu4JWVW8MbU01yCb3WOaKD5GyIMn4Kej0BLPLplTU6roApubPosMkol/Xw7cbgeYuFZyCayVQ+hR/WdXlO14L0yanbb2cHUz294y7PtLstkY3Xsik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764298304; c=relaxed/simple;
	bh=0chMR7aVY89llpaiMbbN4ySUSWb6zZYiYLLJvlXzrIQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=blgcKZJzrn9b6/VlPMAddKzwOGwPtpQ5TklLYoFFjX0f+JgnSPpjL1CVBJvv/O5lmglqpH8t2yvBei3dsSiPpt4sRYzCzkrfalhECUZ6xBETXVUvGvxhZZCPwLEb0PcCZan2xApAZj5JAwCHwUA8kgSvaAEuNR2E6OmMZod2ADc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=amcZxkWg; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=iySrue6i; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2909c666cc0511f0b33aeb1e7f16c2b6-20251128
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=0chMR7aVY89llpaiMbbN4ySUSWb6zZYiYLLJvlXzrIQ=;
	b=amcZxkWgorQM+gTIq0emLdJ6IegboTU3FmCA+P3RD6ul7TouFh8MtBK7KYSxK1wdkXrmzCidJ3/anU5KTCRGGzrNu75KvLKXq/CKNQrlKVY1lU6AQBN12lRiqEkyIZwam+KPxuRfkh/hxkClWEt6U0fBnW07tXmw8r1wa4ygvyM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:36af8f73-07ad-4ed5-bb26-f4c40767762c,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:bff3cba7-1697-4a34-a2ba-2404d254a770,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:99|80|1,File:130,RT:0,Bulk:nil,QS:
	nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,AR
	C:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2909c666cc0511f0b33aeb1e7f16c2b6-20251128
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1322006211; Fri, 28 Nov 2025 10:51:38 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 28 Nov 2025 10:51:37 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Fri, 28 Nov 2025 10:51:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ki+PAURHJezjwYgxIWEYZkAycB3TSOv3wAGljvyQuY5N1uje2QY+sYjiP9c9z1hyWpoRKkv8UStAj5t9bDqK9VobDunZEvAwADXuxYygbNdFEkBa4YSMtxPJOcFxjdW6gZXwwKX4KnqfXtgXS/5AAhqJckkKRGtMrmu44jJkogHdZEMEerSpwwI/Nk+q6YzGDqqoEcRBM66aHXoG0zqA5e9mb+flx3matfAZsPzWCg8hX2rELJr3xuXqAviqX+0Ypj9QYZpJhVKU1Ks4O+AHBxzolNyeO91OuvzxWMflRYvJ0+ZxJovroy8fpNImQIbmqXMiXpnOJ75/I2ArJOf0RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0chMR7aVY89llpaiMbbN4ySUSWb6zZYiYLLJvlXzrIQ=;
 b=VKpnb59tJNC6oENDDgNHr5L/TImu16ty0cu91SrE3ixpP2Jk3l8GaOG66Zqy0EJI4h6/Mr+anddPNQh2z4mcB5hSFtdriFYazE3tSE9xXgKs64PV5p4q6BYz7vMEw9AN0fKFz46+L/d+JaGcAHUsBW/aqNqoZAi0dJmMCd+Th1WNjE2AOE20IC6MYeYgql7LrZ/tdKw8P1MqRXtZ1VETzRc8Eyxuqklw4ikHQrZfqmef+d5mKFhqA4drQHGln09n3REazNl8ZVljggyeGW24a3Q75/h2eG/jxS76iU1MQ4BQPmJnHu4yC/dTVij9WQ547VNRbvbr2+nal+uLT/oWvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0chMR7aVY89llpaiMbbN4ySUSWb6zZYiYLLJvlXzrIQ=;
 b=iySrue6ilP5qKIA5LLXMFnLWzMPXGsNQeO4oXiXZl3OryFIu/m9++KGsRqxflGQVxjRXNwVTkP4O/j+8EfLnywQB2BD+xTEEHLx8jD8CtdoOl/fYyVgaUpkFCtXxNbRgAjXKb1UeI4ehOOgvcHpz85LXcDhhKiGDdtpkCwDgMxg=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by OSQPR03MB8713.apcprd03.prod.outlook.com (2603:1096:604:2a0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.15; Fri, 28 Nov
 2025 02:51:32 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2557:de4d:a3c7:41e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2557:de4d:a3c7:41e8%4]) with mapi id 15.20.9343.009; Fri, 28 Nov 2025
 02:51:32 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "wenst@chromium.org"
	<wenst@chromium.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Nicolas Prado <nfraprado@collabora.com>, Louis-Alexis Eyraud
	<louisalexis.eyraud@collabora.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
CC: =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
	"krzk@kernel.org" <krzk@kernel.org>,
	=?utf-8?B?SXJ2aW5nLUNIIExpbiAo5p6X5bu65byYKQ==?=
	<Irving-CH.Lin@mediatek.com>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	=?utf-8?B?UmFtYXggTG8gKOe+heaYjumBoCk=?= <Ramax.Lo@mediatek.com>,
	=?utf-8?B?V2VpeWkgTHUgKOWRguWogeWEgCk=?= <Weiyi.Lu@mediatek.com>, "Jian Hui
 Lee" <jianhui.lee@canonical.com>, =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
	<pablo.sun@mediatek.com>, "conor@kernel.org" <conor@kernel.org>,
	"macpaul@gmail.com" <macpaul@gmail.com>
Subject: Re: [PATCH] pmdomains: mtk-pm-domains: improve spinlock recursion fix
 in probe
Thread-Topic: [PATCH] pmdomains: mtk-pm-domains: improve spinlock recursion
 fix in probe
Thread-Index: AQHcXfpUoREZ8RJ2M0mvDKXZYgCPq7UE6siAgAJ9DgA=
Date: Fri, 28 Nov 2025 02:51:31 +0000
Message-ID: <34bdaffe2d3179accfc39ffd92d0083ba31bb124.camel@mediatek.com>
References: <20251125105617.1564725-1-macpaul.lin@mediatek.com>
	 <47cb520046a1dab6ea49abd402d3a9647aabf7b0.camel@collabora.com>
In-Reply-To: <47cb520046a1dab6ea49abd402d3a9647aabf7b0.camel@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|OSQPR03MB8713:EE_
x-ms-office365-filtering-correlation-id: 353b8d8d-b7a4-4e91-d387-08de2e29098c
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?MmpDTFlHKzYzUTAvMG5wWjNtU09CM2t6MTU5bEU5aVJpOVorQXNkTlVNY2xy?=
 =?utf-8?B?QndKd1ZyK0U2N292dysrdDNVVmpnTXpabjMzVUlQT29ybkZhZkpJOHB0UVBI?=
 =?utf-8?B?TEJpRDlCQUhyMy9QU25QQ3dpZmovMEM0QzZnaFUvUHFtWHlHUFZGamVwNjV0?=
 =?utf-8?B?NE11c2w5bmc3SmVkekdpemlvOXJtQkhYakVRR1h6bmhHaEhBSzB3VVMwTXFY?=
 =?utf-8?B?Y0t2eTRvc2tMdTZMcVNHMyt1dStaaVFLT0pMOXhScEwrU0tJWFp1VXo0U3Iy?=
 =?utf-8?B?cUlqWW1sRUVidFRTaW5tQTROS2ZYMkkvT3Z0T2JYWncwdXZUR01IOUxXSXI5?=
 =?utf-8?B?d0ptZk5zUTh4UXgwUTJaeWh1UXAvbnZsTGNZMlJQUVVnN1NiVVB1SVhwbldN?=
 =?utf-8?B?eUJqaGdnbkNKQWJBREtFSjRna1pVVTUwbzFDSUtNdkMyQStmZk5YbnRkR0Fs?=
 =?utf-8?B?QWdaNVpIWjFRWE0xSWNIQkZWM2p3NEY1dS9tNGlQOHBVVWFIOTFBd0s2ZXpy?=
 =?utf-8?B?MEY0UUtSazdHZWZjU0NCNmpmdVJtOVpvOUlCaENQV3pQdWR3UGtzUkJFdFV4?=
 =?utf-8?B?dndqYkNSWTc5TnBNb2ErajVrSzZxSXFiUUIrQlROeVVBOENpdVZzTlovRTI4?=
 =?utf-8?B?d3l5T2pBUEdxNGV4QmkxT2t5MmwyeitGMm95VE5tbmx0SDNDQTR1SWxqT2M2?=
 =?utf-8?B?RVFYSDNIOXVjQ09hc0FEYXBmanRTL2puVFNiajBPdXQ2aVZNTGJqN1NOd3Rk?=
 =?utf-8?B?elUzY3ZIcVcwTnNmcmRLOStha0pYY2plZ0QyTFpvMG1ySFg1Q3dlRUkrd3Vn?=
 =?utf-8?B?SU1iTGpBYXNiaUcrRC9yT0s5UXUrTWVYenJvQURrWDc4akxJVmU2My9HMjFu?=
 =?utf-8?B?WHIzMFRFWXpxeHMvSjZzZEIwbDJ2NlZKMEF5QzdkbGZSb2VqTER2Q2tJaDE0?=
 =?utf-8?B?ejJCUnIrOVBHY3dUdFN1NHNHUDl3R1VpZDkwWklrNlpoZzVPV0cxSkd3ZElR?=
 =?utf-8?B?MHJPT1V0UzNvcjNQRy9MbkhYQTNiSGNJMThTWmRpUU00Nlp2SFNFMk53VjQ3?=
 =?utf-8?B?ZjhNbEQxeFd4emMrdWxTZmZlVUk3VXhGams0TVZqeE9GVW9zNjJRcXdrME4x?=
 =?utf-8?B?cjluZVZnUU5ERXpHcnZmNnVocnQ0Vm5rbU5PTS9UaENDQjc2QnBKT2pqS3E4?=
 =?utf-8?B?ZjVNSHZ0QkpuS09FL1RDUVBEdUVNY2hxZnVneUo5clBuQlV4WnNrZDRNcmRt?=
 =?utf-8?B?a0FSZEQzYi9lUStUVGZVWk45cGZ4R3M0NjV4azE3WDhmS3pndFJjZUk4dnAv?=
 =?utf-8?B?MjBuVWxzZmtBbVNma0dLQ09ibDZ4RllHQU41YUx0azBrQXp0RzBoeWpBdDIx?=
 =?utf-8?B?UE80bjF1aEJabC9rZ3BxUjRZZjlUSm1xOTM5Q0F6OU8yaGJtcXlTNVNvSE9X?=
 =?utf-8?B?d1hITVRPR0hSVGcrUklJU3FqWjRJUHRGM0I1T2J5ZTlIS0RWWmE4SXBDbHl0?=
 =?utf-8?B?WlkrNFo0NlhtczNQcCt3cjgxamdGM3VIUzRBZWhrZHNpTmlKcCtTbU5rSGxp?=
 =?utf-8?B?a3VwV3VqR3kyOGhsdm1BbzZOOUNTZnA3WnRQWm03TVRJL1NQN0krQUdzek43?=
 =?utf-8?B?WVZYWHZCeFhNMHlYdGhGNEpoSUlaL09WWEVmdEtMS3ZjQmF2d1Mxb2VYb1Qr?=
 =?utf-8?B?TzRTalFMY0R5c0dOQkkzZGhTLzdWWjlYQkgzc0dRc2lDL2lWKzQxWDFHUkpU?=
 =?utf-8?B?Nzd5R0VpbXN4dXcvWXlzVVR2dW14cTVoRE8yaW5xbjNWRTRMTm40WU53TUdL?=
 =?utf-8?B?d2VmZ0dmVGRudmQ3QlhRMWNUbFVvSXFUazNKZE15QVZkTzVvaWhvVkpTZk1R?=
 =?utf-8?B?UVljdm42bkZ3Z0RtNkhNUUdISVlpWDMyWlA2eDVjRXprOFVlNnFHS2gvRmtY?=
 =?utf-8?B?cFcwRDZ0ZEkzWkNPMWVpcXZPa1lhb1g4Z2R5a2laakNoSS9TZDNPbFNCZGh4?=
 =?utf-8?Q?DkVCPEKrk//zTneUPW66JBIvJQkBBQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7810.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWIwQ2luZWJtRm1kczBINGJRUVhIUThpYUtJMXl6dCs5OHIvYXp0NjlhSmZo?=
 =?utf-8?B?Nm95azVqSnZpVFNzNW00ZlBMSTNadTRLWmVobitQVStHcUpMMVAvcjJTc3p0?=
 =?utf-8?B?RDU3dnlnelgxZzNPcWtURFdNVGdKV0UxcCtSSEpkK2xrTkNlSWNFeVFMVk9n?=
 =?utf-8?B?UGVFMkFZQlZndm9ZMVFTaksxcUpZU3FRMjA4V0djUmYrMmxqazZ2MUNPV0s2?=
 =?utf-8?B?Qy9pSlZubS9rODdtKzh4VDBlbU5vclJHanQxRlByR1JHaDFyQnNOYUVOamFX?=
 =?utf-8?B?UHBJdFJSZlh3UG1vcmRLZjdid3YyVXlVdjI0N010ak84ZEhJMDlHM1pWUlB2?=
 =?utf-8?B?d2xka3RWcWVMR01rYndoeEkyUndzekxXekQwRUZ4RDFHZlBieS9UNlp0VVVK?=
 =?utf-8?B?Y3ZjVnJuWHR0dVRydHdIdEllTU85NjF1ZWJxbCs3bzRYbnUwZlFLTmQvd2Vu?=
 =?utf-8?B?OEo0TGNERmZJSEN3QTl3SEoxdXpQcVhveFFjMXRaVERnR3ZmcXFuY29Ga01o?=
 =?utf-8?B?VW5ZUDdHZ1hDYXlOb1U0NFF6MEJoMW1ONlVqTTBiWFcvTURvekkwZ1huc283?=
 =?utf-8?B?THl0MnBNMXFDVi94M1F4VTdjVFV1RUM5N2VHR1F3N1FxQ1pFTno4ZlNtbklN?=
 =?utf-8?B?dlREWXBhdER5K0U3R2dnR29BWXVyZG40TnlBai9CTi9BUXovakZWekRtY0pQ?=
 =?utf-8?B?OHFVakFuTWtmR2s3VzJjU0YwUWt0bnhNWEE5Ritqc01lZTR0dlhLbEU1Q0Uy?=
 =?utf-8?B?OGZCUktlVUIrdGpmOW95WkU4MmE0Rm5vbVdtTGVKNERGenhlRGhUN252dWFo?=
 =?utf-8?B?RGdNRkpkelpUQlpqWFZ4clNERXhKb2Nyc1FLYVh0aUZYcVdrbGJwNWlucEtw?=
 =?utf-8?B?QS9LK3JvZUhFaS8vcGs0bUFzbnQ3emtxVW5paGxVbjNlelh3U2Nna1FDcksw?=
 =?utf-8?B?eEdqcTc0dlV0ZUQ1RDgwTVBmNmI5WDFUV2RselNJSVlnbFIyWFI1cW8xaURr?=
 =?utf-8?B?SmFaam83QXF0OWJwYjlhVnc2NVpkcEkyOEtzR3dySllqbmpvTkN0TzJaQTBC?=
 =?utf-8?B?c1RDa2ExWmVQblZtUHpIOTcwVEdWdUh3NXNZbW1DYnRTY2tLRi9YQVQycGx1?=
 =?utf-8?B?Y3pxUjR2TUN5WVZzRjZDZlBsVHN6eGhEUjdMTDNnWkNaYzlhMksxcmNlcktT?=
 =?utf-8?B?ZkgrdmtKWGFsQTBYTlFvbnFHSkNRRVVvWThSRjg0b0lUdHNOcHM4V3crbmpX?=
 =?utf-8?B?aWM0ZDRjemw0cGdlNk8yY2dsUFVyNStSRm43LzB3eFJKTENXeXpMeEcrQlpl?=
 =?utf-8?B?T0JlTG5YbUtIcFlHVkdHYU5VVVkxM3F3ZmJyUWVtWEo3a1Vta0NEWW96OVJJ?=
 =?utf-8?B?b0pHR1d1RHpCRll4RXQ1YkJHemV2dHFDYlBXZ2FlVlRhOUlSL1JTVkREVWZW?=
 =?utf-8?B?aVZuZWk4ekpZTXI4Q25NR1ZoNXpNaDNLcTZNU29kM0Z3VVJQb0J4YUFST3Vu?=
 =?utf-8?B?OEczaFZFUHJkbWF6QnZDcExmaEFQYzh1TnpMZ1JQSHNvZSt0T0hTQkJsZWJO?=
 =?utf-8?B?dnpNYnVDL25oVjc5UG1vRDFsNVJCdnVGRUpheXg2a0R0bU54NlJqWlRMb2hH?=
 =?utf-8?B?S3NpSDJENUo3OElpTE5oMEFYekVPQWVzWkg1dGhxVFIzbkE5UktrRGxhSE9o?=
 =?utf-8?B?QkVqMzRPQ2M1K3pkVVM2dlJIMmcrNHIxWlA3bjZETmUrWjl3OGRLeERVeVE3?=
 =?utf-8?B?bCtVY3JGT1I0NTBXVWNsQVB5ajJiSGxjZ2kyNHVpQlBXSTMvRVlOUUYza3dZ?=
 =?utf-8?B?NUtVZGxPMjRRYnUzQVhaVXFPTEgyeWIyZmJvVEpqRmFrVHBiZlYxbGJocEky?=
 =?utf-8?B?aGgxMk9kOW1ybitFODQwdFJQV3FML2V6KysrcEs5Y05ORnR5R3l5dVNidnlF?=
 =?utf-8?B?YzFBb3hwRmp0UWsrb1ErazdUeThLTWczTFRXeEtHa0hNK0Q5MW1lcmh6Wmk2?=
 =?utf-8?B?UGpSeE1QTW1HMXFHaGh6U1VKZWpUUE1rR1ZKejZpNytSWTl4M3lFWUxmZFZB?=
 =?utf-8?B?UzhWMHRIWVZXcjd5SVAzMmhrcUh5TlB0ck5XeVNSZjVjR1ROVEZZQWlyVDFC?=
 =?utf-8?B?eUxhV1hPbGlSU1ovejdVR3BDSUp5NWN5TFNjV0t1TWVIRHNJUVhRNjRpcEwr?=
 =?utf-8?B?RGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8FA7CAE343ECA742A205CCDF2C1AD02A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 353b8d8d-b7a4-4e91-d387-08de2e29098c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2025 02:51:32.1789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kXfeDBBZHOpY1dRhVxhYoYLcF5z1WudLR/0Mc3vSdH4YeO9fXxMpFdulMY2xja2VS56UIeSCJHXUoSkOVgRXhZPlYbBFyuzhXK0Z4d36wfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8713

T24gV2VkLCAyMDI1LTExLTI2IGF0IDEzOjUxICswMTAwLCBMb3Vpcy1BbGV4aXMgRXlyYXVkIHdy
b3RlOg0KPiANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9y
IG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBIaSBNYWNwYXVsLA0KPiANCj4gT24gVHVlLCAyMDI1
LTExLTI1IGF0IDE4OjU2ICswODAwLCBNYWNwYXVsIExpbiB3cm90ZToNCj4gPiBSZW1vdmUgc2Nw
c3lzX2dldF9sZWdhY3lfcmVnbWFwKCkgYW5kIHVwZGF0ZSB1c2FnZXMgd2l0aA0KPiA+IG9mX2Zp
bmRfbm9kZV93aXRoX3Byb3BlcnR5KCkuIFVzZSBhbiBleHBsaWNpdCBvZl9ub2RlX2dldChucCkg
dG8NCj4gPiBlbnN1cmUNCj4gPiBjb3JyZWN0IG5vZGUgcmVmZXJlbmNpbmcgYWdhaW5zdCBvZl9u
b2RlX3B1dCgpIGFuZCBlbnN1cmluZyBpdCBpcw0KPiA+IGNhbGxlZA0KPiA+IGluIGEgc2FmZSBj
b250ZXh0IChpLmUuLCBub3Qgd2hpbGUgaG9sZGluZyBkZXZ0cmVlX2xvY2spLg0KPiA+IA0KPiA+
IElmIGZ3bm9kZV9jb3VudF9wYXJlbnRzKCkgb2J0YWlucyBwYXJlbnQgbm9kZXMgdmlhDQo+ID4g
Zndub2RlX2Zvcl9lYWNoX3BhcmVudF9ub2RlKCkgYW5kIHRoaXMgcHJvY2VzcyByZXF1aXJlcyBk
ZXZpY2UgdHJlZQ0KPiA+IG9wZXJhdGlvbnMsIGl0IG1heSByZXN1bHQgaW4gcmVwZWF0ZWQgYWNx
dWlzaXRpb24gb2YgZGV2dHJlZV9sb2NrDQo+ID4gaW4NCj4gPiB0aGUgc2FtZSB0aHJlYWQvY29u
dGV4dCwgbGVhZGluZyB0byBzcGlubG9jayByZWN1cnNpb24gZXJyb3JzLg0KPiA+IA0KPiA+IFNp
Z25lZC1vZmYtYnk6IE1hY3BhdWwgTGluIDxtYWNwYXVsLmxpbkBtZWRpYXRlay5jb20+DQo+ID4g
LS0tDQo+ID4gwqBkcml2ZXJzL3BtZG9tYWluL21lZGlhdGVrL210ay1wbS1kb21haW5zLmMgfCAy
MSArKysrKystLS0tLS0tLS0tLS0NCj4gPiAtLQ0KPiA+IC0NCj4gPiDCoDEgZmlsZSBjaGFuZ2Vk
LCA2IGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3BtZG9tYWluL21lZGlhdGVrL210ay1wbS1kb21haW5zLmMNCj4gPiBiL2RyaXZl
cnMvcG1kb21haW4vbWVkaWF0ZWsvbXRrLXBtLWRvbWFpbnMuYw0KPiA+IGluZGV4IDgwNTYxZDI3
ZjJiMi4uZjY0ZjI0ZDUyMGRkIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcG1kb21haW4vbWVk
aWF0ZWsvbXRrLXBtLWRvbWFpbnMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcG1kb21haW4vbWVkaWF0
ZWsvbXRrLXBtLWRvbWFpbnMuYw0KPiA+IEBAIC05ODQsMTggKzk4NCw2IEBAIHN0YXRpYyB2b2lk
IHNjcHN5c19kb21haW5fY2xlYW51cChzdHJ1Y3QNCj4gPiBzY3BzeXMNCj4gPiAqc2Nwc3lzKQ0K
PiA+IMKgwqDCoMKgwqAgfQ0KPiA+IMKgfQ0KPiA+IA0KPiA+IC1zdGF0aWMgc3RydWN0IGRldmlj
ZV9ub2RlICpzY3BzeXNfZ2V0X2xlZ2FjeV9yZWdtYXAoc3RydWN0DQo+ID4gZGV2aWNlX25vZGUg
Km5wLCBjb25zdCBjaGFyICpwbikNCj4gPiAtew0KPiA+IC3CoMKgwqDCoCBzdHJ1Y3QgZGV2aWNl
X25vZGUgKmxvY2FsX25vZGU7DQo+ID4gLQ0KPiA+IC3CoMKgwqDCoCBmb3JfZWFjaF9jaGlsZF9v
Zl9ub2RlKG5wLCBsb2NhbF9ub2RlKSB7DQo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBp
ZiAob2ZfcHJvcGVydHlfcHJlc2VudChsb2NhbF9ub2RlLCBwbikpDQo+ID4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGxvY2FsX25vZGU7DQo+ID4gLcKg
wqDCoMKgIH0NCj4gPiAtDQo+ID4gLcKgwqDCoMKgIHJldHVybiBOVUxMOw0KPiA+IC19DQo+ID4g
LQ0KPiA+IMKgc3RhdGljIGludCBzY3BzeXNfZ2V0X2J1c19wcm90ZWN0aW9uX2xlZ2FjeShzdHJ1
Y3QgZGV2aWNlICpkZXYsDQo+ID4gc3RydWN0IHNjcHN5cyAqc2Nwc3lzKQ0KPiA+IMKgew0KPiA+
IMKgwqDCoMKgwqAgY29uc3QgdTggYnBfYmxvY2tzWzNdID0gew0KPiA+IEBAIC0xMDE3LDcgKzEw
MDUsOCBAQCBzdGF0aWMgaW50DQo+ID4gc2Nwc3lzX2dldF9idXNfcHJvdGVjdGlvbl9sZWdhY3ko
c3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3Qgc2Nwc3lzDQo+ID4gKnMNCj4gPiDCoMKgwqDCoMKg
wqAgKiB0aGlzIG1ha2VzIGl0IHRoZW4gcG9zc2libGUgdG8gYWxsb2NhdGUgdGhlIGFycmF5IG9m
DQo+ID4gYnVzX3Byb3QNCj4gPiDCoMKgwqDCoMKgwqAgKiByZWdtYXBzIGFuZCBjb252ZXJ0IGFs
bCB0byB0aGUgbmV3IHN0eWxlIGhhbmRsaW5nLg0KPiA+IMKgwqDCoMKgwqDCoCAqLw0KPiA+IC3C
oMKgwqDCoCBub2RlID0gc2Nwc3lzX2dldF9sZWdhY3lfcmVnbWFwKG5wLCAibWVkaWF0ZWssaW5m
cmFjZmciKTsNCj4gPiArwqDCoMKgwqAgb2Zfbm9kZV9nZXQobnApOw0KPiA+ICvCoMKgwqDCoCBu
b2RlID0gb2ZfZmluZF9ub2RlX3dpdGhfcHJvcGVydHkobnAsICJtZWRpYXRlayxpbmZyYWNmZyIp
Ow0KPiANCj4gd2l0aCBhIGtlcm5lbCBiYXNlZCBvbiBuZXh0LTIwMjUxMTI1IHBsdXMgdGhpcyBw
YXRjaCwgbXkgTWVkaWF0ZWsNCj4gR2VuaW8NCj4gMzUwLCA1MTAgYW5kIDEyMDAgRVZLIGJvYXJk
cyBib290ZWQgT0suDQo+IA0KDQpUaGFua3MgZm9yIGhlbHBpbmcgdGhlIHZlcmlmaWNhdGlvbiB3
b3JrIG9uIGFsbCBwbGF0Zm9ybXMuDQpXZWxsLCBzaG91bGQgSSBhZGQgYSBUZXN0ZWQtYnk6IHRh
ZyBmcm9tIHlvdSBmb3IgdGhlIG5leHQgcGF0Y2g/DQoNCj4gQWJvdXQgdGhlIHBhdGNoIGl0c2Vs
ZiwgaXQgbG9va3MgdGhhdCB5b3UgdHJ5IHRvIGJhbGFuY2UgdGhlDQo+IG9mX25vZGVfcHV0KCkg
ZG9uZSBieSBvZl9maW5kX25vZGVfd2l0aF9wcm9wZXJ0eSgpIG9uIGl0cyBgZnJvbWANCj4gcGFy
YW1ldGVyIChucCBpbiB0aGlzIGNhc2UpOg0KPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19f
aHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuMTgtcmM3L3NvdXJjZS9kcml2ZXJz
L29mL2Jhc2UuYypMMTA2Nl9fO0l3ISFDVFJOS0E5d01nMEFSYnchbklFS0JOYzU4Mk9rRlVXa2U1
Slc2NkZLQzc4QXpJdGdUd2xlZm9UaktpeUFSOGt6Sk9DY0YtaFRCd1dWdzJsb1k0bUc0bFk1QUt2
dkJwQ05UYlhEb0hibDhsaXFCOHNTJA0KPiANCj4gWW91ciBwYXRjaCBkZXNjcmlwdGlvbiBpcyBh
IGJpdCB1bmNsZWFyIGFib3V0IHRoYXQgYW5kIGNvdWxkIGJlDQo+IHJld29yZGVkLg0KDQpJJ2xs
IHRyeSB0byByZWZpbmUgYW5kIHNlZSBpZiBJIGNvdWxkIGV4cHJlc3MgaXQgbW9yZSBzdHJhaXQg
Zm9yd2FyZC4NCg0KPiANCj4gSSdtIG5vdCBzdXJlIGlmIGl0IGlzIHRoZSBwcm9wZXIgd2F5IHRv
IHVzZSB0aGUNCj4gb2ZfZmluZF9ub2RlX3dpdGhfcHJvcGVydHkgQVBJLCBzZWVtcyBhIGJpdCBo
YWNreS4gVGhvdWdoLCBJIGZvdW5kDQo+IHNpbWlsYXIgc2VxdWVuY2VzIGZvciBvdGhlciBvZl9m
aW5kXyogY2FsbHMgKGxpa2UNCj4gb2ZfZmluZF9jb21wYXRpYmxlX25vZGUgb3Igb2ZfZmluZF9u
b2RlX2J5X25hbWUpIGluIHRoZSBgZnJvbSBpcyBub3QNCj4gbnVsbGAgY2FzZSBidXQgbm90IGFs
bCB0aGUgdGltZXMuIEhvcGUgc29tZW9uZSBlbHNlIGNhbiBjb25maXJtIGlmDQo+IHVzaW5nIG9m
X25vZGVfZ2V0IGJlZm9yZSBjYWxsaW5nIHRoZXNlIEFQSSBpcyBPSy4NCj4gDQoNClllYWguIEkn
bSB0b3RhbGx5IGFncmVlIHdpdGggeW91LiBUaGF0J3Mgd2h5IEkgZGlkbid0IGFkZCBhICdGaXhl
czonDQp0YWcgc2luY2Ugd2UgYWxyZWFkeSBoYXZlIEFuZ2VsbydzIGZpeCBpbiB0cmVlIGFuZCB3
ZSBtaWdodCBiZSBhYmxlIHRvDQpoYXZlIG1vcmUgZGlzY3Vzc2lvbiBvbiB0aGlzICdoYWNreScg
aW1wbGVtZW50YXRpb24uIFRvIGVuc3VyZSBpZiB3ZQ0Kd2FudCB0byBtaWdyYXRlIHRvIG5hdGl2
ZSBvZl8qIEFQSXMgb3Iga2VlcCBzb21lIGxlZ2FjeSBmdW5jdGlvbnMgb24NCnRoaXMgZHJpdmVy
Lg0KDQo+IEZpbmFsbHkgdGhlIHBhdGNoIGFsc28gbWlzc2VzIHRoZSBGaXhlcyB0YWcgc2luY2Ug
aXQgaXMgYSBmb2xsb3cgdXANCj4gb25lLg0KPiANCg0KT2theSwgSSdsbCBhZGQgRml4ZXM6IHRh
ZyBpbiB0aGUgdjIuIFRoYW5rcyBmb3IgcmV2aWV3Lg0KDQo+IFJlZ2FyZHMsDQo+IExvdWlzLUFs
ZXhpcw0KPiANCj4gDQoNCltzbmlwXQ0KDQpCZXN0IHJlZ2FyZHMsDQpNYWNwYXVsIExpbg0KDQo=

