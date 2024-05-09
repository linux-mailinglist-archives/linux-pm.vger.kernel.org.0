Return-Path: <linux-pm+bounces-7689-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 689F98C125F
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2024 18:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7ADF282A5F
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2024 16:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4220016F295;
	Thu,  9 May 2024 16:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SAyNWIcj"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2079.outbound.protection.outlook.com [40.107.100.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312E53BBE3;
	Thu,  9 May 2024 16:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715270477; cv=fail; b=ZlskgF0MBTfsR0vyVpdj/8+YN+RNq1RXtDRg5C1KZfkFQC3U6x3x7nsZVvjzr1fx/I1ih4uChoEWSZAXBmv2B/GGmaB3F+fFcyG82c98pTW3urz3H9JzqPLOAyJ8ww7U3Xp8Q4oV40pdBFJj93bXMaPO9uyhLlZFethQ51UztEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715270477; c=relaxed/simple;
	bh=tz0ZE4qvK7LmQLpfiAsNQCEtHvesRcIrx0LtKSdbqKA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LPp6pFHsDWvBmrb0vLe4uRKMQnWeAmextYVDi795PiGj6M/MDK99gHg/YwekSGCMmrgIfqjMRbrLBqTsgJZZf2dqtkJbWtBR39NssbgHv+rPENnI63qRlDy253GlZS3pochTovkbn6jI/b6G5cDLMmgC5ZTjpLcrs7BLZmHUSJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SAyNWIcj; arc=fail smtp.client-ip=40.107.100.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUxpwXTaUrSsLvw/ksH7gRN3glfZky955+dgQCSUFJkC2/TMQenFh9+ZhvD48oRdn9us+5n0vE8F/CWfuAjaPUX7LCQa+jLqINBnrPiOH5pC1iIM6u/D9NgoyT1DtRioSTjtdV+pBzIuqVLL1cGLN+3tbqPlPapd9tIQFN10+Q+r+jkcvboAWAPyPX3i+WrKv5GLK+rJqqL81cJvb3nSlfCZTEbazzII3NAFGu1/ySnfmabBUsvoDLJBSrHKP9q7qEKne4WqHdLcWlbycMQWYNMK6KyLfe8gfPQdGozA1uPy5ob3jjiheMvkqx/LzvT1ZB62TaxhMkM5Ltg5wIL52A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tz0ZE4qvK7LmQLpfiAsNQCEtHvesRcIrx0LtKSdbqKA=;
 b=Kfmb7ZoHfQyS9eF5LGf4WnzZ6gk9W9eNHvBEKzJ1BZm66/zFI1h22TOhjrnR1wrcufJAMl3C9Fe4/4ts6p1SwfTRqIc3HPDPN9Pw9Hf92VBofBLhJ3Qjt5KJwZqXP2y07EUd/dTwbOToxD66WGY8i/MUAFdja3pDYpsJ219Dg0G61WZordQKRXNOnTx41aRhG9EIOJJ3lAbbFzHOYPYTmGwKZUEeWsNQiWsFoQheLlP5kPn67dxQ9hmXyV8pSq59itVyTnsyVPUAeZnVM6+F82k2u+U+8S+C8JS57YTFJ6CWadYIUnwhTaHZORTuUXHGEABHeEAhTbGh0uq6V6KzZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tz0ZE4qvK7LmQLpfiAsNQCEtHvesRcIrx0LtKSdbqKA=;
 b=SAyNWIcjfMBe3kFcqSynIg57gOjGLIS2s0qWRW7yNGhiOoqYtpLAqmFbvCTcnTp3MVFNowOz0TrHeGXaKOGH5qIMW/ssS2anxcOQh0VUFFmBVza8rFIE1dG+XPnyjPO21NinHu/nMRRUUt1OuTQb/i5wdAe19uHgQgVsVejpCZ8=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by SA3PR12MB7973.namprd12.prod.outlook.com (2603:10b6:806:305::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.48; Thu, 9 May
 2024 16:01:09 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%6]) with mapi id 15.20.7544.047; Thu, 9 May 2024
 16:01:09 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>, "viresh.kumar@linaro.org"
	<viresh.kumar@linaro.org>, "Huang, Ray" <Ray.Huang@amd.com>, "Shenoy, Gautham
 Ranjal" <gautham.shenoy@amd.com>, "Deucher, Alexander"
	<Alexander.Deucher@amd.com>, "Huang, Shimmer" <Shimmer.Huang@amd.com>, "Du,
 Xiaojian" <Xiaojian.Du@amd.com>, "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v10 0/7] AMD Pstate Driver Core Performance Boost
Thread-Topic: [PATCH v10 0/7] AMD Pstate Driver Core Performance Boost
Thread-Index: AQHaoRhhqR2kK746VUiJQZTmHwG33bGM/n+AgAIR2nA=
Date: Thu, 9 May 2024 16:01:09 +0000
Message-ID:
 <CYYPR12MB865543653A46840345CFD2139CE62@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <cover.1715152592.git.perry.yuan@amd.com>
 <20240508081845.GAZjs1ZS7atvvdsOOd@fat_crate.local>
In-Reply-To: <20240508081845.GAZjs1ZS7atvvdsOOd@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e9c06fbc-0ebe-4fc9-99fd-c95a618f6108;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-09T15:55:09Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|SA3PR12MB7973:EE_
x-ms-office365-filtering-correlation-id: daf4e1b8-9cd2-4d25-88fb-08dc70413e2d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?LzZHaUlvbmRjSTh6clV0MzJNMEpPNmJOYklGZnRlWUVDQSsrdUc5VnQ2K3V4?=
 =?utf-8?B?S21WVzQ5a3VxeURwRFpDMmR5TmNwamJac2I4Q1R0UE1ZVkcwcEQyVG1kakMy?=
 =?utf-8?B?SFlpVVdiaWtRSzdHYXFESGU5dU53ZlVHZ0kxVzY0TFFNL3ZrT2dRNGh4MXhD?=
 =?utf-8?B?d0JzWEp5TUx6VDF1SlNFRCtySnMvOWYrbUJLTC9rSmJSZ2hPZkFjODZyVEpC?=
 =?utf-8?B?WWZFY25UVFJybXVIK3VCZzRQd3BzZU5zL29FQjdQL3lMcFZMWWJOZ1Znb29E?=
 =?utf-8?B?dUhEMFNSa1RlamV1VTFmREdMWXlyVzhYdnZ3NWE2VU1rbk0rUVdMdzFmaG5B?=
 =?utf-8?B?Um5wdW9kM2kvK0FCc0lJaEc5MVppRG9YeUJMRTQ4SmxYcVVoVFFrd1hZQXU0?=
 =?utf-8?B?WXhZUmJpd3lMazZtdXdSODBnZjREQzJESUc5TC85WVo3cU9Ib0pnLzYzSVlB?=
 =?utf-8?B?TnY1eUE0SVBiZmhzYXVadXg1Uk1DZjdLeS9zVmV5SGZPcmVGd3Rkc0JDZ1lZ?=
 =?utf-8?B?WnBqT0UrdjNxdlpiUlpWY3VhWVNmVEh5VWFNMVB5T2hUNWJVZkNmeG42RVdy?=
 =?utf-8?B?ckRUalhqYnE0Nmg2TjJxWXdvTVQyS2RvcFdOUzI2bDlVZ0UvbUYyeUpZRllj?=
 =?utf-8?B?bzNvR252SURFdTN4UFpRVnNGdXhIOXlrajB3dldRV01BUjloNWdyRU9yaUJE?=
 =?utf-8?B?Vi9yUS9wdkcxQXBLNmtTV3lQT0JxeFBNZEhhWTNucWRkdVBZUXhUQlRZM1Zo?=
 =?utf-8?B?Q1pTTmFwNXg3YjEyRytwYjliVVp4ZnF1dkhYSVAyQjMvUVBtR20zNVYwSjFU?=
 =?utf-8?B?RGs1aXhzSnlPNzJpNlc1bzdqckRKdUN1UldnTVAzRldkM2RoNUJBVUllOXdy?=
 =?utf-8?B?c2hMNlJGbG5rZkZjcHJ1L3poUk5Pb3RwZDA4cGEybytJaTBubTI2dysxajgv?=
 =?utf-8?B?NVNXdWM3Y0QzUGhNZFl5em1jSXpWcDdFSE1GbVdIdTZaN3NDV3VTRThvMjJm?=
 =?utf-8?B?VHlEMzhTT25EWEczRmVwWnh0Zk5PVnB2SmVhVnBtOThFVnI3RUIrcVJGZEt2?=
 =?utf-8?B?cUdrTnRJSEpTakRtVVc2Zkl0N1RpMDUwK2NTNHp1dEdkVHA2NGdMTVM2YUk1?=
 =?utf-8?B?blhvUlhyMVFEaDdJK0pNQVVhOHdMNmt3bG9EUXZ1ZmJmZFE3QTBZcE5ZaU4x?=
 =?utf-8?B?UlNiNWdxek9xTXdFcS96cjBGR3Bxa0xNc3pJZmZPb0lwSzRRVEhPSGQvL1FV?=
 =?utf-8?B?MFZjakRlbjBRaWEybGV0V3AvZjFQVmZWb0lGUXA1QXVhaUJXQTVvOEdteUc4?=
 =?utf-8?B?YkdJWG4vc05OQ3BnajdCRG9ERmRncUFWbEpIcUdkdDdGVE5CME9mTktNckJl?=
 =?utf-8?B?Z0VnU2xGSVp4OGJscmd1cStwYVpiSmJFekkxWVEvU3YwVFJ5UC95WU93ZFlF?=
 =?utf-8?B?aE9ESzR6STNHVlZpWXNVOTJEVzZLLzJISEUwUjJOTjRiamxmUUpTeHFWTGo1?=
 =?utf-8?B?S2FsSkJPcTM4UHBKaitRUVdmanBGNW5GaXgzdjB3OEhTdCs1K2lKdzBST3Ex?=
 =?utf-8?B?bFBnMlhwc1BQU2V0UUZLdjNCUUNvNFhvZnZJaHZlSVlIV0Rkb1V4YWNlR3p1?=
 =?utf-8?B?M2wwaVZyUU5lSkxNSzJhTkNSZnNwblRWLzJBL1R4QktTTFlyRjlJOUlRUFZl?=
 =?utf-8?B?VlhOY29xQ0R6VDZ4T2daaEJrYUIzS0dUN09EejY5WURYUWsraFRac1RoMlZR?=
 =?utf-8?Q?e8XiPAYgguYASthDuM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aGtrMWRFUjZVTnRaazJvNG5RZElsNVJkN01jRkFHd3h3aXdlNzBSREhVVFVS?=
 =?utf-8?B?bmJPN3pmRlJvU3hFZ09tZzRGRmdCSDJ4VFIyUmIrZURYZnllMnlmODYrR2xT?=
 =?utf-8?B?dElKb1p2R201VTVFQVZQRWhnenhTZS8xejRKZ1RzelM5ZnlpbnNSaGVsZ0hV?=
 =?utf-8?B?WlpPRys0RXhYbHcyYmx3Q1pWMFViS2FkNHl1SHk5VE40SFR5eHY1RCt6ZFp1?=
 =?utf-8?B?Yk5acm52Qlc2RG8wbTRzdlNSWUxORDdodkU5VlJJR29xL3BoZHVDSkpYdFdp?=
 =?utf-8?B?cXh4Z3VxWU5jU1NsY1l3V29CSmpBdGhIOWZpZndDdy9CZmM0VDFwUUpSOHpt?=
 =?utf-8?B?TFRCNlQwOGNXRmthMVdod1lJNW1mRTZiTFd2OW1xRnBWdCtnamo0MEk4YUww?=
 =?utf-8?B?NlpHaWJUcG9FYUMwRWVnclk1N2d3WldPNjNBQXBjRFFkR1pJZ1dwclU2elZU?=
 =?utf-8?B?Rnk3NVBDU0kxOURXWS9BN1RWK1IzWUh0VVIrbkRrV2NBR0JTeDVzUUlDOXlQ?=
 =?utf-8?B?d2x2bnZwc2pONW5GZmx1VkllbEFxTzBFY1g1eUdDZFc5eHpFVjhKclV0N1Er?=
 =?utf-8?B?NlhkbDNtRko2QTNoN0VVNEJkVDUyd1MvdFU5S3RlcE5VV1hLVWFRclpwL0FT?=
 =?utf-8?B?eUhsL3dkckF1M3p1UW42c255b1dyais0bXl6NWc5WDhBbFMxcG1ubS9OUU8z?=
 =?utf-8?B?VWF4R1J6bGVJKzMwdzJkMWd3Nm1uSXpIeXYwRFRQSElLOGs3YVBVbmxzWnZz?=
 =?utf-8?B?UzlXa0lPcmVPRFlZT3FQODF1UERnc1N0am9xa0RHTE1yRXphZDl0bWUzWXRh?=
 =?utf-8?B?ZlBFU0FBOERWZHk4NnpqWGdkQU9wYjB1NmczQWJqajlpWTAwcUpqbVk1a1Vz?=
 =?utf-8?B?OGlTNTkwRmVoR0dWaVNSRGdwcnZmNW8vbWZMaEErb0dHdTRGSWhnSEZ5aTRx?=
 =?utf-8?B?QWRWbkdzdjRzR21qZUYvVCtrclFtNXZ0YkpYOGlIZExPODdKOTNiUjJsMVA0?=
 =?utf-8?B?UzI4YmJqTlNNQ05PVWF1ejlITCtwWVNoMkhTUjJMTlE0bStYM1puZzNhZERX?=
 =?utf-8?B?ci9yamdrcnZPYmtSSWQrSEpQdm9NR2E4NXpnbU1BSkhtQzFxK2krWTVtUDA5?=
 =?utf-8?B?UE1SOWF2bW9jRFJ6cWtsSk14QjMyL3NUbXFKT2d0K3d1ZzhHZUE4Z0dhWmJz?=
 =?utf-8?B?dnpGYnhoQ1MvZTJDcWhoK1MrZWtZZ0NEdDVwSVlMSHhvLzkwS2ZLNHZjY2xX?=
 =?utf-8?B?Yi9FUmt4V1lmcXIwU2FCdmtKNCtacFFmUE0rbi9pVjlZelI0QmJ6QUlFcFZB?=
 =?utf-8?B?UmgzSWJWaUdESWZsaGhSZVVIcjRTRXNUUkh5cTlWbVRMNHdtQWg0azJtNzhh?=
 =?utf-8?B?ZjJuMUVSYkpzWit3QXp6ZGliajBoVnNqcTBKMHU3YzR3ZWxocXpqdEdZL1pm?=
 =?utf-8?B?OEg5Q29LR0lkSUZyeVlzT3VORkhpcjFpRzRvOEhuakdQK0g0WnU2MENkajN3?=
 =?utf-8?B?Rkx2SmNqejNvaUI5K00zVS9VbDNnODNJS1BKTGtzeUNmUGJQZ1BsaVVDaVI0?=
 =?utf-8?B?bHFDRG0veEtFNHJhdU94MWY2ZHZGN1dpaTdSNVNzZDRJSncyRGN5cHpWU3RI?=
 =?utf-8?B?OTFqaXdqMms5Y25QZ2l5MnlvQnpEa041TmpRK2ZuVzg0R3grTEVQWENRc3Jo?=
 =?utf-8?B?aVhJdlltY2oyaUp6YzhRN1lKSzY5cDBWZGRFNU1xQm91elpmeUFsdzNaVTJY?=
 =?utf-8?B?N2dTbGxvc3JGSlVkdXpyK2lSOS9RL2NVV05Za0tBakFWZTF2Q0Z0Q25qY1F0?=
 =?utf-8?B?ZUpCUC9KVDcyVVZ5eEJWeWJFcWdhS2ROQ3ZFMFoycjMrQWJ2QkJSVGZHelVU?=
 =?utf-8?B?WEhoQnRNNFRrTlQ5TmRRZmZrU2MzaVJWbHlQL0g5bTZERVpxczVRRzltYmN4?=
 =?utf-8?B?cVpKQU9sQit2dWh3SEFxZUZMMFdpNjZjVVhCQVB6ekZlZWgzeC92M3JvWUU5?=
 =?utf-8?B?T1NsSWF6S0hyN0ZraitHYW5MV0FHNVROL01SWmVOVCtmZXJ4YTM4NCtreCti?=
 =?utf-8?B?Y3hQS3A0MWJRQ1pNTkxyWFFQck1ZUUM3bGFUZHRYTHRPZkR2blFPVDRpTFNH?=
 =?utf-8?Q?qVA4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daf4e1b8-9cd2-4d25-88fb-08dc70413e2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2024 16:01:09.7897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 59voXBJt1eH+/v41LYKDtfuiOvcmQFGLx5DV3MWtse57o37sTVeQhbF/fxYkbnsl/9pFgCjan9X5qT6kgLythQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7973

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCiBIaSBCb3JpcywNCg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVu
OC5kZT4NCj4gU2VudDogV2VkbmVzZGF5LCBNYXkgOCwgMjAyNCA0OjE5IFBNDQo+IFRvOiBZdWFu
LCBQZXJyeSA8UGVycnkuWXVhbkBhbWQuY29tPg0KPiBDYzogcmFmYWVsLmoud3lzb2NraUBpbnRl
bC5jb207IExpbW9uY2llbGxvLCBNYXJpbw0KPiA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT47
IHZpcmVzaC5rdW1hckBsaW5hcm8ub3JnOyBIdWFuZywgUmF5DQo+IDxSYXkuSHVhbmdAYW1kLmNv
bT47IFNoZW5veSwgR2F1dGhhbSBSYW5qYWwNCj4gPGdhdXRoYW0uc2hlbm95QGFtZC5jb20+OyBE
ZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBIdWFuZywg
U2hpbW1lcg0KPiA8U2hpbW1lci5IdWFuZ0BhbWQuY29tPjsgRHUsIFhpYW9qaWFuIDxYaWFvamlh
bi5EdUBhbWQuY29tPjsgTWVuZywNCj4gTGkgKEphc3NtaW5lKSA8TGkuTWVuZ0BhbWQuY29tPjsg
bGludXgtcG1Admdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9y
Zw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxMCAwLzddIEFNRCBQc3RhdGUgRHJpdmVyIENvcmUg
UGVyZm9ybWFuY2UgQm9vc3QNCj4NCj4gT24gV2VkLCBNYXkgMDgsIDIwMjQgYXQgMDM6MjE6MDVQ
TSArMDgwMCwgUGVycnkgWXVhbiB3cm90ZToNCj4gPiBUaGUgcGF0Y2hzZXQgc2VyaWVzIGFkZCBj
b3JlIHBlcmZvcm1hbmNlIGJvb3N0IGZlYXR1cmUgZm9yIEFNRCBwc3RhdGUNCj4gPiBkcml2ZXIg
aW5jbHVkaW5nIHBhc3Npc3ZlICxndWlkZSBhbmQgYWN0aXZlIG1vZGUgc3VwcG9ydC4NCj4NCj4g
Q2FuIHlvdSBwbGVhc2Ugc2xvdyBkb3duLCB3YWl0IHRvIGNvbGxlY3QgYXMgbXVjaCBmZWVkYmFj
ayBhcyBwb3NzaWJsZSBhbmQNCj4gb25seSAqdGhlbiogc3BhbSBhZ2FpbiB3aXRoIHlvdXIgcGF0
Y2hzZXQ/DQo+DQo+IGh0dHBzOi8va2VybmVsLm9yZy9kb2MvaHRtbC9sYXRlc3QvcHJvY2Vzcy9z
dWJtaXR0aW5nLXBhdGNoZXMuaHRtbCNkb24tdC0NCj4gZ2V0LWRpc2NvdXJhZ2VkLW9yLWltcGF0
aWVudA0KPg0KPiAiWW91IHNob3VsZCByZWNlaXZlIGNvbW1lbnRzIHdpdGhpbiBhIGZldyB3ZWVr
cyAodHlwaWNhbGx5IDItMyk7IGlmIHRoYXQgZG9lcw0KPiBub3QgaGFwcGVuLCBtYWtlIHN1cmUg
dGhhdCB5b3UgaGF2ZSBzZW50IHlvdXIgcGF0Y2hlcyB0byB0aGUgcmlnaHQgcGxhY2UuDQo+IFdh
aXQgZm9yIGEgbWluaW11bSBvZiBvbmUgd2VlayBiZWZvcmUgcmVzdWJtaXR0aW5nIG9yIHBpbmdp
bmcgcmV2aWV3ZXJzIC0NCj4gcG9zc2libHkgbG9uZ2VyIGR1cmluZyBidXN5IHRpbWVzIGxpa2Ug
bWVyZ2Ugd2luZG93cy4iDQo+DQo+IE1haW50YWluZXJzIGFyZSBub3QgYSBzaG9vdGluZyBnYWxs
ZXJ5Lg0KPg0KPiBXaGlsZSB3YWl0aW5nLCB5b3UgY2FuIHJlYWQgdGhpczoNCj4NCj4gaHR0cHM6
Ly9rZXJuZWwub3JnL2RvYy9odG1sL2xhdGVzdC9wcm9jZXNzL2RldmVsb3BtZW50LXByb2Nlc3Mu
aHRtbA0KPg0KPiBUaGFua3MuDQo+DQo+IC0tDQo+IFJlZ2FyZHMvR3J1c3MsDQo+ICAgICBCb3Jp
cy4NCg0KSSB1bmRlcnN0YW5kIHlvdXIgcG9pbnQsICB0aGUgcGF0Y2ggc2V0IGhhcyB0YWtlbiB2
ZXJ5IGxvbmctdGltZSByZXZpZXcgc2luY2UgdmVyc2lvbiAxLA0KSSB3b3VsZCBsaWtlIHRvIGdl
dCB0aGlzIGRvbmUgYXMgc29vbiBhcyBwb3NzaWJsZSB3aXRoIHJldmlld2VycyBzdXBwb3J0LCAg
dGhlbiB3ZSBjYW4gZGVsaXZlciB0aGUgZmVhdHVyZSB0byB1c2VycyB3aG8gaGF2ZSBiZWVuIHdh
aXRpbmcgbG9uZyBlbm91Z2guDQoNClBlcnJ5Lg0KDQo+DQo+IGh0dHBzOi8vcGVvcGxlLmtlcm5l
bC5vcmcvdGdseC9ub3Rlcy1hYm91dC1uZXRpcXVldHRlDQo=

