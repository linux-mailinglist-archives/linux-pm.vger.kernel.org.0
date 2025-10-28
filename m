Return-Path: <linux-pm+bounces-36983-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F90C153B4
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 15:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 126784E9167
	for <lists+linux-pm@lfdr.de>; Tue, 28 Oct 2025 14:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBC6224AF1;
	Tue, 28 Oct 2025 14:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="asssLdd4"
X-Original-To: linux-pm@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010034.outbound.protection.outlook.com [40.93.198.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979AF22A4F8
	for <linux-pm@vger.kernel.org>; Tue, 28 Oct 2025 14:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761662800; cv=fail; b=PpVoeWJDwGHtqrqmZP9Y0/NE/2YmWejDvIQTaCMohSJ3MeO9dF5AHvxV7GuPPEMFlbGuZoEd6jyLJ/bI9vCg8y5o/zkIYtrraRDIpWP4Ky8W3q9yNgW4+QOu4CMIqRCD0YKhSm5M+nzLUAVkafuOx1b3MQO8E6UzA8hzI21PJMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761662800; c=relaxed/simple;
	bh=W2Yv5Ou9vwWvovLmS5iKUinYpo0IbT8fXxucTO4ltdU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UplORGz+dCL+Kg4P8dNDvOtzkzq1Gt8oIyW0MHdjkiJeJG9ndZlZZxIfxmEiF+P+wUb9yyiVdhjomEeasgJuBn/CABFUp9c7PtEXdmJLMkGuSihpUb7At10aMFgcAiegmkrdPQ6RPOpMY+vkb+08h997PKWutsIRvXtmQXY81ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=asssLdd4; arc=fail smtp.client-ip=40.93.198.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cpf5XvlYu0zlKH7VpEWP848b8QHSwUXpGkc0pqEioxeJ4dARfjKwNec3e1s5nN5k1DA3T1yVEnX3+BlJEoXpGwWmKVLZcyAgYbCl0i5kE/gOCXbvExoZFh4fYtfFM/aqJRaJsf5fG/Vsh93hep41qLltDVkvDYQBFvDehyHFkU5AAoTJlMDYoxC6bmaQGl0AwEZZ2w/kvsTsqqwGYVgAjlJU4pgRjxZmOa+7id3ULKMWQ8kncEA1vt4YYKEWtzVj9Jt07E+lY32/4UzArjSPuoBsMK6gos0cY0adfab3mwsY07Id0v1uhaogobkFq41FTSmgYWKX4G/smbVtX5y8YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFJkQfbwhhwcFahfpW2k3iK8ZgMHujzi/SY7wUnB94Q=;
 b=SHYXP0kpfoD4TecEt6njmJzgT2eJ+b3b2o2nznUZ9T/4STVIQ9ChXQSsuNBV4F8d6f+bgyXUzQ/v0XiruiDr7oAMkkGdXx2IPpKArF7MKoFt5uk83vnrpffJqBF5gID+/mxnD4XnoLF53mjpP+ViR/t8UHgawQw9GlnrgEDmCixt8YvVlPf2/TdXRslV2M4BdFYjz/aGN9zBdIMQ/Ggr+yzN1jN4bzyGHJ8BgQ3DajFn3eOpZfrp8ILsqjarm02oznYtVot0ASIzMyPt51VXlONF6DYAuRV4Fp4Mzc8WFZ2VKgRMj8kb25192hnlhBkJt71q+jhDxOW1B4bSaa7wig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFJkQfbwhhwcFahfpW2k3iK8ZgMHujzi/SY7wUnB94Q=;
 b=asssLdd46swEK8pyRu+m5Wsff2vZHgNXp6EP7JoX0YjFKNuMFlgiMfAVZczDRosp2DBD6JzphhHAWgM/lEjedUqIHDtbHySk6ufo3PFnC8PG8ZgLRRh4c2exk9DkqBS75j/ZM/y+vOa79aYP6JOO4Lh+5OtVkj2yyQZ4eh3xwVc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV3PR12MB9267.namprd12.prod.outlook.com (2603:10b6:408:211::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 14:46:25 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 14:46:25 +0000
Message-ID: <9c264378-702b-4a5a-8012-984e15f91779@amd.com>
Date: Tue, 28 Oct 2025 09:46:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] AMD P-State fails with "_CPC object is not present"
 on AMD Zen 4 (EPYC 4484PX) between 6.10 and 6.11
To: Christopher Harris <chris.harris79@gmail.com>, linux-pm@vger.kernel.org
Cc: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
References: <CAM+eXpdDT7KjLV0AxEwOLkSJ2QtrsvGvjA2cCHvt1d0k2_C4Cw@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAM+eXpdDT7KjLV0AxEwOLkSJ2QtrsvGvjA2cCHvt1d0k2_C4Cw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0147.namprd13.prod.outlook.com
 (2603:10b6:806:27::32) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV3PR12MB9267:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fdc49b9-f585-409d-31d2-08de1630c4af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dnhOU09oOW82MG1GN2IyeGVYTDhocUN1Znc5QTFuUU91bE1NNWJWamRtNHha?=
 =?utf-8?B?TmFKOUd3NkIxOTVqa0hOZ3NkMnJ1WEFrQlRITkRSUGdEUjdTOGdOZTFDU1Bu?=
 =?utf-8?B?ZGZ3N283UUNlR2J3aGhRQTBraVREYkh3N0FXY2J1YmNMUlhNK1prSVdZNG5n?=
 =?utf-8?B?d2FycVJ2SVlBM0d1aFVWMFh6ckpydkI5cExBcnRLT3V5ZTYxT1BadjI1RnYz?=
 =?utf-8?B?b3E1Ly9qOUt2WGU2dmh5WmVzbzV5V3R0Z0NLVzVGNVE2VEVucW5LT0lvcTFn?=
 =?utf-8?B?Zkp4eXRPTHF3b3Vtd3VhY3lTajRQRlFqUFkyamcydW9KVkxCdTE3dUFOaENp?=
 =?utf-8?B?cUN1YXlzbEFEZFlBcGgyeExaLzJKTmx3eHpZdDRJTXVvbVlvOHNkWmVUbllP?=
 =?utf-8?B?Qnhub0lBTDRIeXZPcWZLN2FDMTlWUnlsc0k4djdlc1NlS2d5Zit0M0ZveXJa?=
 =?utf-8?B?R2pqWE45Y21KcHpaSnZQL3pkb1haaU9QLzZFUHFTZStGZXE5L0xiYlVMUEFt?=
 =?utf-8?B?alJueDRvelJiY0lvd2QxSHRQVTB2NDd0czlOamJrK0g3a0NLd2s2Z0VYWE4v?=
 =?utf-8?B?cWRpR045Ri9PaUN4S1hlV0xsMW1QTk1XYWs0TE9LSzVRcWo2QS9CUlM0TmlW?=
 =?utf-8?B?WGp5bFNMdmVUa1FpNTJkc1E2L21wc0VGRTY4Q0huS1dWTUF5b2wyTFZMckps?=
 =?utf-8?B?MUUrYzA4dWFSWVlJUGZYSkJDbDNyWUVkVmpoZWQrT21zUlBLMHJHbHE1T09r?=
 =?utf-8?B?RGNTd2RhME0zOW10c0dVbTV1cDBZTTE3b21ibGFFZnZURm9LMHp3Um9CZlVJ?=
 =?utf-8?B?NFd4MDczc1JlRzE0MHhieFZrWEtDekprN25wclhsbllCL3JXazZqRFBsQmFS?=
 =?utf-8?B?K2lZL0pIbDdvSVNEWmQ3Y0lCbzBZT3p1aGlpelAyb3hPdE50QnMwS00zLy9w?=
 =?utf-8?B?Si85YlFOK1ZlYUltV0VSeXBuU0hEQkJNL1oyOVJ4bzA0K0JSb0JIQWt3cm5U?=
 =?utf-8?B?N3l5QzJsOEFRelA0ZFhvM202aktQaDBYWU9JelZoYVU5WVhqWGM2V3FlRU5E?=
 =?utf-8?B?T2RKSGNIVVdBck1SMHVma2Z2cmRid01jdWpWdmZ2NnFaK2NuaTdaVFl0LzE0?=
 =?utf-8?B?aURiTzJ2VDRRT0dkeEFTQzV4c0xWR3JiM2VlYkZHT1R5V1ZVWDZKdjdQRStL?=
 =?utf-8?B?dlZRM0xDQzR3NG5VeDdRNDhjUmJsdkM4SkZtNDFrdWE5bFREeEN2SUhscUdS?=
 =?utf-8?B?K3hqKzhYN0pGOVRxeW9tTXhVTy9xM05xbDB3d24vYVRSM29lOVQ4SHgyODdK?=
 =?utf-8?B?ODdDOG53UWhXdjh4cHgvVDVuaXh0cERPKzhqTHVVTVFMZWE4Yk9tNXR3WG9T?=
 =?utf-8?B?QmQvMlNxUkZKR1dFQVo2c1I1TXpiVGtIT251UVpTRk4yM3hoNDJ5WGdlQ1J5?=
 =?utf-8?B?L1p6b3ZXZG0vZUpLSk8vckFtenBxNS83K1dQaE9pMCtzakpiY1RIbnRwenZ1?=
 =?utf-8?B?NFhsL3lwUmU4VlArWTFKb2NsT244QWZsWDBFRVFzQWVabzN3VXlEV3p1OWdu?=
 =?utf-8?B?MkRCTlA4NEtUMzVEeTJKSzA5YnJpQ3lzNFdjZE5ZNUYzOE5TZXpyQ2EwNVNT?=
 =?utf-8?B?TkdNTlk1U1dGdUdVanFxUURuekx2bFVzQm1EVm52SVRrU2pIOGV1Nk1QTHo2?=
 =?utf-8?B?cmpUejAzcTd0dlpUY0ZVdkxiS0N0Rmd4ZnlwMDFpU2RQOUR0VEVsUGh2VXVQ?=
 =?utf-8?B?M0p5dDY0NFVBQ1BNeUVWS0xpQ0hYK2t1bXgxbmZ0Yk4rOEdZSVNydCtieTRJ?=
 =?utf-8?B?NmJUNDlJU1lJVlFsTmVpK21LMVVOK0lONUloQkZ0U21hTlVDdDBlNThFLzd5?=
 =?utf-8?B?N2pQOU4xVXRLN1JrK3RWZUprNmVQcXAwSkltaUlrOG5zK2t6WVY1Vm1CNS9U?=
 =?utf-8?Q?ZVZrXz55DAYipL2Ryamb3ACqZ04gy2Ug?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDBFUUE4SzF2c21KOXM2bzRuTkhaRWFjVkNOMkx4MTR1NWlxRWZrVks2VG14?=
 =?utf-8?B?VlcyOWVKMjVWeFNjZ09pa0NsMFdxOWJ3NmNjSkg5b2gxU21CL1RwU2NWNWlD?=
 =?utf-8?B?QWlIZWt4aFA4TWM2MmtUWm9qY2Fid2J4VHBZb0VJMDZ2NW9SNW8zNUVSaXBS?=
 =?utf-8?B?RmVwUCtrSkQycXlBU084UWJmdG5NWmdsdHlRbTlTRU5HZFhwNTZUNTVwdndF?=
 =?utf-8?B?bWNwLzM3cGRUb3UyNnZCQXA4eE9JWERkNGk1WEVTWmdxWGIraGM3dFN5Vm9R?=
 =?utf-8?B?c3ljcXpRSlVNclVMWVM2VVhuRE5iZHM2VG1zZ1J2QTNJcHlaTTFvTkpFSXU3?=
 =?utf-8?B?eDgyY3IzbWY1RTZCVmJtTHZnUENJVzlkVURkQTZZeWR5MzJCWXVBV0EzUlJD?=
 =?utf-8?B?OHB0a05UQk4zK1BXR0xPdkhMWGRELzRJV3JZcFArQ2ZrVCt1b09xbldRMEQ1?=
 =?utf-8?B?REJxN21VMlAxQnVqN2RqL1d5ZjFRR3VKZnBqQloyYnEwT1dVcWM1VllzaytH?=
 =?utf-8?B?ei9zTWJzWUI3cnNVK3liaU5xdU1OSFRsRVpSWWdwQ253ZEx6YUJZK1cyTjB6?=
 =?utf-8?B?K21UVHc1UjdCbSs5M3BDcC83MVo4K1ZkcXlKT012SjVkZUNWVXlJeW41R1pa?=
 =?utf-8?B?cTdBV2t1VHgxNUNOQ3laQ25SMWpYanZsVmlOM1FVckUxUnNMcE9YVFBvVlpC?=
 =?utf-8?B?NFpGYytvTSt4cnc5VzlsMGJKNzc0TkdWZldReDM5ODZoWjBWVmNpVHVLWDJI?=
 =?utf-8?B?ZEVERWRGZGRkVVkwWXdweDBSMWgzdytLdnk0RHhhS29JVW1tVjFkK3QzRXpS?=
 =?utf-8?B?QXFmSkNra0YxaUJWaTMzRmw2V09pTW5POXlxWkFJNDliYlgrTFlBdUhxV3BS?=
 =?utf-8?B?R3BXN2ZJVEw5eXZZWHN3cnhPS3Q3dXFFU09sMlphbWd0YXNFb2ZDT0Z0bUMz?=
 =?utf-8?B?U0xKSXIzYXd2NC9pVkNZeHM4QUM4bnN2dGVRanZ3eTJuaW1jb1lEbnhpcVdr?=
 =?utf-8?B?aU4xc3Rjcy9aWjZ5Zm03K3ZjMWtTcFFjZ2NkSUp4N2lJeUVoNTFyM0ROc3JF?=
 =?utf-8?B?Z2VQNGthQjZ0S29TNzNjekRvSzRYT25xeXNqR0Z1MnpuY1BSUUhqRzJEQzlR?=
 =?utf-8?B?RG9RKzQ1c2s2eTRTUkd5YzN1UEFOakJoTUg5dDlJMTdQczFVQ2FMazAxelBt?=
 =?utf-8?B?elZ6Zk96YmViM3FqbnZJQzF6eHVxcGcxelYwUm9Id3E4UDYrd0Y0ZTByazFp?=
 =?utf-8?B?N3dic0JDT2N4Rzh4eGI1QUFvbTYvZXlsVHR1dm1nL0tsajY4R0tCSExlZTVy?=
 =?utf-8?B?OVBDMmtrWG5BRTVwVjRVeDNHa2pkVms4RmNpeWFaTStHYjAxaDJUYVVJamsv?=
 =?utf-8?B?aXJnVWFHYndOd3ozcVFmbkZTSXBpY2MzNTNTQm9kRWhqcTRvR3ZISUQ1ZFRO?=
 =?utf-8?B?STFsQ09oMVhyQk1ydnRDS0NXTCszUU4wYTdJbFV3aTcwekxpem9qalQ3MmVh?=
 =?utf-8?B?aUhtQmRqVThKTXlqRHRWMm81Mk85cTZwS1AzZlNiMjUwYUJoQUJiaVZ0MkJm?=
 =?utf-8?B?cDZzN3hEZEdLKzRVWTE3U2ZKcm1ZcFh0Y3N4YXFidkpNZ1NueEdvZnVIWC9Q?=
 =?utf-8?B?V3Z5dE9RNDZMcUhKM25IZGZsbGFYYU00Q0VqL1l3V2lMcERXbkpMQ2lzcncx?=
 =?utf-8?B?NGRNWFVJcW5ScFZxUE1hdWxJWGtXY3Y2TEFmSVRHR2NSbWJ0azIwT2s2ZU9k?=
 =?utf-8?B?MVRCUFpKNmk3UHhNUlVZSG54YTFIZVZERnY2NTlxaEdWQVRUNDdMNHZDSGlw?=
 =?utf-8?B?SzJ1dXQ1VXJFa2haeTNkZEI0b2R0QUhaRTlXMk1NOHFGUFpsWTJNczR0eWVI?=
 =?utf-8?B?SDVqSUFOM1pxRkVBVzVLZFNCOXB2eDJyTElqZ3k3SWhqYUxvNUhjMkFnYWRU?=
 =?utf-8?B?MWd0NkEvQ3V1Z0tMVXlNQXZIcEpNVTByU1JrMGVsRndRcUN1ek9GNzI3MDNa?=
 =?utf-8?B?Ym1PNnBKZEpxL2NOazYrM2JqdUkvRDk2U2hlNThCTUpUemRKa1VOb2xiWk9t?=
 =?utf-8?B?MXRReDhjZmdZYWRwLzdneGxiaEo0ZHNEaFBnV2pTUStocXFPd1RiUlBSQ2sw?=
 =?utf-8?Q?wauafRqQtYVm9RJYb743T41F6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fdc49b9-f585-409d-31d2-08de1630c4af
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 14:46:25.0080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VDhVlHkLAFih3QKjl1/fGBaJr1YuuBxRR6TRqHvz/+ZTG0o7H5bclvq0lgBsbwagAACVZmlFIw9RsgG6GUPX5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9267

On 10/28/25 2:38 AM, Christopher Harris wrote:
> #regzbot introduced: v6.10..v6.11
> 
> [Regression precisely identified: Last working 6.10.0, first broken 6.11.0]
> 
> ## Summary
> 
> The AMD P-State driver fails to initialize on AMD EPYC 4484PX
> processors starting
> with kernel 6.11.0, returning "_CPC object is not present in SBIOS or
> ACPI disabled"
> error. The same hardware works correctly with kernel 6.10.0 and earlier.
> 
> The regression was introduced between 6.10.0 and 6.11.0.
> 
> ## Hardware
> 
> - CPU: AMD EPYC 4484PX 12-Core Processor (Zen 4 architecture)
> - Motherboard: SuperMicro (confirmed CPPC enabled in BIOS by vendor)
> - Tested on multiple identical systems
> 
> Note: This issue likely affects other AMD Zen 4 processors and
> possibly other AMD
> generations, though testing has been performed specifically on EPYC
> 4484PX systems.
> 
> ## Regression Test Results
> 
> **Working** (amd-pstate loads successfully):
> - 6.8.0-84-generic (Ubuntu 24.04)
> - 6.8.0-86-generic (Ubuntu 24.04)
> - 6.9.0-060900-generic (Ubuntu mainline)
> - 6.10.0-061000-generic (Ubuntu mainline)
> - 6.10.14-061014-generic (Ubuntu mainline) **<-- LAST WORKING (latest 6.10.x)**
> 
> **Broken** (falls back to acpi-cpufreq with _CPC error):
> - 6.11.0-061100-generic (Ubuntu mainline) **<-- FIRST BROKEN**
> - 6.12.0-061200-generic (Ubuntu mainline)
> - 6.13.0-061300-generic (Ubuntu mainline)
> - 6.14.0-061400-generic (Ubuntu mainline)
> - 6.16.7-061607-generic (Ubuntu mainline)
> - 6.17.1-061701-generic (Ubuntu mainline)
> - 6.17.5-061705-generic (Ubuntu mainline)
> - 6.18.0-061800rc3-generic (Ubuntu mainline RC)
> - 6.17.1-1-cachyos-server-lto (Arch Linux)
> 
> ## Error Message
> 
> ```
> [    4.508125] amd_pstate: the _CPC object is not present in SBIOS or
> ACPI disabled
> ```
> 
> ## Steps to Reproduce
> 
> 1. Boot with kernel parameter: amd_pstate=passive
> 2. Check driver: cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver
>     Expected: amd-pstate
>     Actual: acpi-cpufreq
> 3. Check dmesg: dmesg | grep "_CPC"
>     Shows: "the _CPC object is not present in SBIOS or ACPI disabled"
> 
> ## Kernel Configuration (identical in working and broken kernels)
> 
> ```
> CONFIG_ACPI_CPPC_LIB=y
> CONFIG_X86_AMD_PSTATE=y
> CONFIG_X86_AMD_PSTATE_DEFAULT_MODE=3
> CONFIG_X86_AMD_PSTATE_UT=m
> ```
> 
> ## Testing Environment
> 
> - Tested with vanilla kernels from Ubuntu mainline PPA
> - No additional modules or patches
> - Kernel not tainted
> - Reproduced on both Ubuntu 24.04 and Arch Linux distributions
> 
> ## Impact
> 
> This regression prevents affected AMD systems from using the optimized
> AMD P-State
> driver, forcing fallback to generic acpi-cpufreq with approximately 5-10%
> performance loss. While confirmed on AMD EPYC 4484PX (Zen 4), this
> likely affects
> a broader range of AMD processors that support CPPC/ACPI P-States.
> 
> ## Next Steps
> 
> I'm prepared to:
> 1. Run amd-debug-tools to capture detailed reports if needed
> 2. Test any proposed patches
> 3. Perform git bisect between 6.10 and 6.11 if required
> 4. Provide any additional debugging information
> 
> ## Bisection Results
> 
> Through systematic testing of Ubuntu mainline kernels, I've identified the exact
> regression window:
> 
> - **Last working version**: 6.10.14-061014-generic (latest 6.10.x series)
> - **First broken version**: 6.11.0-061100-generic
> 
> The regression was introduced during the 6.11 merge window. All 6.10.x versions
> work correctly (tested through 6.10.14), while all 6.11+ versions
> fail. The issue
> persists through all subsequent versions tested up to 6.18.0-rc3.
> 
> The regression appears to be in ACPI _CPC object detection/parsing, as the same
> BIOS/hardware combination works with the entire 6.10.x series but
> fails with 6.11+.
> 
> ## Additional Information
> 
> The same ACPI tables and BIOS work correctly with 6.8 kernels, confirming
> this is not a firmware issue but a kernel regression in CPPC/ACPI handling.
> 
> ACPI/CPPC related messages from working system (6.8.0):
> - No error messages, driver loads successfully
> 
> ACPI/CPPC messages from broken system (6.17.5):
> ```
> $ zgrep "ACPI.*CPPC" /proc/config.gz
> CONFIG_ACPI_CPPC_LIB=y
> $ dmesg | grep amd_pstate
> [    0.714133] amd_pstate: the _CPC object is not present in SBIOS or
> ACPI disabled
> ```
> 
> I've tested on multiple identical systems with the same results. I'm available
> for testing patches or providing additional debugging information as needed.
> 
> Thank you for your attention to this regression.
> 
> Best regards,
> 
> Chris Harris
> chris.harris79@gmail.com
> 

Please open a kernel bugzilla and CC me.  Please add an acpidump, a 
dmesg with a current kernel (6.17.y) and a dmesg with a last working kernel.

