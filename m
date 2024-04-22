Return-Path: <linux-pm+bounces-6753-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B058AC3D6
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 07:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F071282B51
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 05:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C651803E;
	Mon, 22 Apr 2024 05:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ETcvaxFk"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3182F5E
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 05:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713764511; cv=fail; b=RdZ+bKidD3QPcAYqHh2eTM3EwY8WRyJLMgXJFx+PajfVst0ror5kdvgVuH5fea9zrTRWUlicAEw3WHgBfVoMyLNIQ0DmkcdqveYqoupXj/7dmRO9MPAnes0fj8yyAIaUI0JBkcv3P5w7px4p84T46oU/En1NeVMVc5w8d7lgnBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713764511; c=relaxed/simple;
	bh=/9ObnnLeml+KYYJIzg8/ySpYSvQ9FZgAEzOTFCnQdoI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gHG0k+5ITCGRolnFNpJlvsfygnQtqsRfMc6a5J/WSxnOJTnX0GGfVrQzzIl4h2XGo7j9hnnMafN+1HHSmJxzc/Om+eHjBC+xL+ZD3jlAHSgFZXlMrVcrLXxZ4u61VgHxreBVfukppHQSoTCD0bHAqVw2IJZJRQEzWAyh6GmUXYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ETcvaxFk; arc=fail smtp.client-ip=40.107.94.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1x7bIgmeDOY422tWJa6tnFeiYrpG8zmvTPJG/F2M4SDC4vZqbmmJY2daNaqls4l1p3YyL7kXk03fMJmHLXezH/5bFjSEW/JjNm7NJuTzDBVChn/DtLzBbFo18wPElMet6m5qRuD3GD8GeazYH7l4hn9Wjvds3eOhv7Xr9anTBDfp79sRO6YCAd6rIgh54Mxdh2iFLqHGKGXi25iENUUH34qGb4vIZBIlJAKrQTcgBaszKzrlRCwuE2a6EIz73u7J5H7McgPoSJ6fFK7/hnB7KSAKO76EGcPzPuXi9xbpgO0HLsfTzpcYeQqGoAT2XMWcX+xriDELakoqyvP9ELywQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9ObnnLeml+KYYJIzg8/ySpYSvQ9FZgAEzOTFCnQdoI=;
 b=Cyb470awHPGxaexHruprImatN/NwGaWlfxQFdMsX3St6F9Lk7ZU7rfxJYjtPqZgOBZkEN/h1VHR5K2OfqduhpKmnIm5Wdq38xweRzY6eOhdKrC7BZdRtKgJW31AFjsZN/yJmyyf34uDWg6uQHEJZ1Q3v4o5Zk+8qZSneZB7eIJoQGvGTOUOqWBJ73IWokMoPOqSKAXAWFQNXT/PZTFEwyDK7ldBYMJxh7PBksBlM1KVo3hCzcrswmGCuYcuX9cqBa5FivzpFGh4xD0BMNbZzbwzxtny0SQwtpZktz9mlsWAiWmP8Elw1LfguaM6OBUimRDk8whlNFzVwajQ8IFhJSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9ObnnLeml+KYYJIzg8/ySpYSvQ9FZgAEzOTFCnQdoI=;
 b=ETcvaxFkskM5lssNEdx6erzSZ9Ns1Lnf6sU7GdrDMtOBQN9UDfKbMBvTeqe60Gnlj1aRaqLmgCoF1TFQM1X0P4RBQTaKmzCWEjD3ljtiheib+YgRF1RzsOqSngVyZ+Z9nIliQaP7HEd2jd9fxIyjkM7zZJmbUq8qygLaM9t51s0=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by DM4PR12MB6159.namprd12.prod.outlook.com (2603:10b6:8:a8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Mon, 22 Apr 2024 05:41:45 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::64d2:3c49:7c63:1749]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::64d2:3c49:7c63:1749%4]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 05:41:45 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>, "Du, Xiaojian" <Xiaojian.Du@amd.com>,
	"Huang, Ray" <Ray.Huang@amd.com>
CC: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>
Subject: RE: Warning `amd_pstate: the _CPC object is not present in SBIOS or
 ACPI disabled`
Thread-Topic: Warning `amd_pstate: the _CPC object is not present in SBIOS or
 ACPI disabled`
Thread-Index: AQHaklWAYg0AncQfkEqAVL+BblI5cbFvxFcAgAAC5QCABAMC8A==
Date: Mon, 22 Apr 2024 05:41:45 +0000
Message-ID:
 <CYYPR12MB8655D32EA18574C9497E888A9C122@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <d0e7eaad-d549-423c-a138-84c2abc817a7@molgen.mpg.de>
 <DM4PR12MB5136C2314DDEA0C7A20C4E5FF10D2@DM4PR12MB5136.namprd12.prod.outlook.com>
 <58b30395-9ff2-4889-919f-54528ffb8dca@molgen.mpg.de>
In-Reply-To: <58b30395-9ff2-4889-919f-54528ffb8dca@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8be07bb4-9542-4543-8be7-9cf210875cd1;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-22T05:39:33Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|DM4PR12MB6159:EE_
x-ms-office365-filtering-correlation-id: a3bf4532-a726-400b-9e45-08dc628ee595
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?utf-8?B?MXFxU1dwYUVyY2RaOHRJR2loWnl0aXZDbEZUZDBGS1UxMG96RVljckJtYVNI?=
 =?utf-8?B?Uk0yUzVYRHFyWHo0N0NkTm00UWZKcHBIUXN3QXpJc3dsQnFReDVDQ245N09J?=
 =?utf-8?B?bWJUU3BTODV5MmhubTJja0NORDYyVnlGTmJJRnp5QTNCcnI4bjVUZFBoT24w?=
 =?utf-8?B?V1ZCa0RsWGpHVU8wMGtTWGhYMExzRDZKZFVSMitlNGptbXhzV1lISU5KNVkr?=
 =?utf-8?B?aGh5eUlsZC9JOVZRRkg4bnh2NWdRdzNvbjVFWm9zNHBYZWRuTWxjZGNJRUZK?=
 =?utf-8?B?WFprM2pYanVmSUExUFg3aTVXQ3JESmZpRGlDZUw1MVU0SVEraGF3WmFQcmVq?=
 =?utf-8?B?RVNySk1mcHpJVXdadFlBZjQxbVRHWEpDR2ZpUkRSS1R2a2ovdlAxY1B4UGZD?=
 =?utf-8?B?enlFbzU4eVRRSjlTV0RnRCs2U1ROaEhRSCsvRW4zNUNvcWs4cGZBSTUxMkk0?=
 =?utf-8?B?TS9DL2xtRkpSZU42MG9OZUZyVnpOVkNBSzhIcWVsR3lMWmt2bktRNGo1Q01N?=
 =?utf-8?B?Ujg1REJBWEpVQmt5citIMmxPU0o0aW9mMzk2ak9nVXRMR3ZiMjJLakVIOXFw?=
 =?utf-8?B?VUFTeVc3cFlkRnBzSDVOTVFEWVRoN1lOTXhiYkQ3RDhIMExWYmJzOXNSVFVZ?=
 =?utf-8?B?cDN4dnNHWWJnRnlGaEFNV1R2L3JLVWd4U1JIL3JKVzNiaWE0cE1OM0FYdEZo?=
 =?utf-8?B?dDV5R1FZaFA0ZWErOW9hdW85MWhwQ2FaNlFhVDh4QU1FSUwwdUEvdHplU2dS?=
 =?utf-8?B?UmFnQTJsOUlWdmg5djRSbHhxV2JrQStxbkd2TFhvNGhPTHhyNTlOdGg5b0FV?=
 =?utf-8?B?VjdkUFJic2tlWHZEVmFyN0F5Um9sNVo3QmtMLzZLb3BkL0RjT3RHVDRuTUdk?=
 =?utf-8?B?clJlbDZ1SWErTU9RbVc5dkh4Ti9SSi8zYmsvaDZad1Q2NnovRXAvNUNiQjNw?=
 =?utf-8?B?OUNQSlhHVlpTSkxrQ3RKRmRidXRVemtxUkFtQWJGQ3VTQWY3cExYY1BRVGVl?=
 =?utf-8?B?NDdRSHNrMGdBTUNkM1B2S2xOSlpzSHZBSE0rSkV2Z2d3UEUydlNNUUpzL3Vn?=
 =?utf-8?B?L09ad3M5WVdZelFYQVNHeXlUcSs4Vmphdm5mVXEra2pwQlRuTjFGTUhZZTZU?=
 =?utf-8?B?eU9nRUZPVlZvRCtzY0p2RTBSaWdGMUd3dkxFM1BuTU50TjNMVUQyYzZlNzN5?=
 =?utf-8?B?Y1A2dWt6Z0RUcXJERzlnRzB3aWlCUDgyQXd0KzdnakNwbW9mWWpzbDdzbDhJ?=
 =?utf-8?B?RlY1Y0RWalJ1QUFiTTdiN1BDWFBNU094bWxUeXVWcU8zbkNsT3IyYmUyeFho?=
 =?utf-8?B?cEk2VFFIMnlFT3JtR2F2V042MkNiM2pWUFVkeFF6RjlMMzBFNy9PNUxUYlNU?=
 =?utf-8?B?U3Nta0NaSzBnMmlBNzlxZ0ZuSnQwQ3NWOTNOUnBYTC9XVHpaMGNZUmNXVWhI?=
 =?utf-8?B?eVlONmY1bVd2dVNwZzBCaVdSZ1VYVDhsRUJHSzM1OVlqNGQ4VTdOSDkrblUz?=
 =?utf-8?B?NHNXVU5OTjM5VHNKdU5kZWNja0VhcWFPdXdLbG5jZFZZaFdZai95aUJzdGUy?=
 =?utf-8?B?eTNYUmZOV1JOTFBBYVFCK1JHYjYvSjRpTWhJY3VBUkhyWklVUjU5anJGTWFw?=
 =?utf-8?B?b2UrZFpHcXhoamZ1QkhjaE5MTkhTeW10R0RWNmIrYkdMWnpKak5QZGRWTVNB?=
 =?utf-8?B?endJUDZhbXJacUZ4R245dkRScHYwUExydUpsSG1jeWs3MWZQS1VHRHo0NEJl?=
 =?utf-8?B?QlFpVXdqZkMvRUtKY1FSc2ttWHoya0hYMTdUbU4yYk5CSnJFa1pLbFdkS2Jw?=
 =?utf-8?B?R1hreCtITkhqQkk2MGlqQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R1ZMbkVLakhmMDMyMkxRYkFINUZ2Z2lCUmRtVkMzYjAvcmRUSHVWODFLc0FO?=
 =?utf-8?B?ZmhlaWRIajdibXZFTkJQUm14RkJoRmViRFQ1djNlbFAzN3hCKy84dHJmdTNQ?=
 =?utf-8?B?dVpNUFZSN2dpc3JmMHE3Z0lPbzBsaHdMWWNSRllETkEzajJyaXA4V3g0MFp4?=
 =?utf-8?B?Q3pZbHdqWTViblBSWlJObitnS0Fob0svbkl2NU54R1hyV0FUZFdMQlhhemFw?=
 =?utf-8?B?c1hpRVA5VDVBNmdKUGowcDNJZm02YitWTllmd25iZU5pVTlsSVA1TnhYS1l3?=
 =?utf-8?B?N2xrWkZyazh3WVpxTHhWUWRXRTIxcVVMMHp3akxNMEI0RzNRK3ZsQTlxWUQ3?=
 =?utf-8?B?d2YzNitsWFhGd1NCQ3Y5cHhFbjZpTjBzVmRlMGFVQksxb0lhVlBXN1o1Z0l6?=
 =?utf-8?B?dUpkQ1VqWXJrQ3J1a1NyT1p3bVZqaFFBUm5PazBnSlN1UmRzWURNanV5L1d6?=
 =?utf-8?B?RWg3eDVsdjF0MlZBY2d0aXcrR1lqUEdrOGJQempzL3BjUzVSNWx1blBVNXlV?=
 =?utf-8?B?OWxDSGt6MnZGNGt1dnNYdGxlUTZvRVZIbldaMHc1Q3JSaFA0cklhbU0rZVdh?=
 =?utf-8?B?ODFEYnd1c3hCNWRpcmNCcU1kam9ad05VZElwMTQyK0hwa051MGoyUXRNaEZ5?=
 =?utf-8?B?SlpJNWdpTTh2NmFDc3hSem1BN1ZKcVl6azkxeGVKYm5iRUVEUHQ3ZmVIY0VM?=
 =?utf-8?B?MXJ6TFFDdSt4Ui9WUDFWNjhuSG5kZUc0SUVhWE9hRHNGMXZwT1VwWmpNcUs3?=
 =?utf-8?B?dzR5NzNXL0YrSVhOS2dVSWs5VG5GWWlEUWRzSUZJS3lxMnNHVm9XZW9TYjBk?=
 =?utf-8?B?QUFaTFJON0tBRUswRkNXOHFHMCszdEFmSTVnTWIwN2VBbll1R3hjaG9FMFRl?=
 =?utf-8?B?ZXZiaXJjVTVQUlo0N1A1UGo3OHJFbFNzUStUSmswQWdmeUxUdjFjUzNRa0lC?=
 =?utf-8?B?bHViUDBMTVRUKzZMUWRQWDhhQ21BVW1QYVhaR3QxWExpMm1YdmZtdCtDN0Q3?=
 =?utf-8?B?VEl4QmR6NUV6TTZMVFZVSFV4emFNYlZHNzhERmJycG5QZStBWWpHWjk1YWR3?=
 =?utf-8?B?V0w3TkxWOHVxcWVDcllUVzFmb0tkcWhLWFZYcW1ER0dUSk5WYXZkSzJmZVR4?=
 =?utf-8?B?V05HK3dxTDU1SmN1M0JhWmYxelNMcm0vQ2xxRGdJQzhzek5QaXRIOWFJUGxq?=
 =?utf-8?B?QTlGZTJYN3hUZ3hHUXZCdVBSL3lVdXRKYnRBUy9HVjZtVkxhdVJjV3NZeWxi?=
 =?utf-8?B?V25Yb29wZkZsYnBmSkxkK0EwOGw5SDlJNUkxUGYxbzNnRzFWZFJ6Ti9rYkxH?=
 =?utf-8?B?QnhPNGtBaEgwRXVuN3dqQWhOanZDNlIvcjlCU3NvZnozbzlIbDQxNFRDNmp5?=
 =?utf-8?B?Z3l3eDNzK2h3SzVvNjdGZGV6eFdxcHlWNWR0Z3lySDVUQjR4bjk2aUlrcUg0?=
 =?utf-8?B?YVR2WmhSazJrd2ZFZ3QwalhaWDZwWElsdGdyWDdpVGR5bEZZeWE1WElRWTR0?=
 =?utf-8?B?S1dHNnovc2k0WWhSNklmbUdiQUZibEVMeldjOW9JT0VxN0dPKzVmVXBJTHpt?=
 =?utf-8?B?dExZRC9yUGZGeEw0OUR4RGNLU2JmU2hJS2srdmE4dnR1eDJrNVZXYkE1VElk?=
 =?utf-8?B?Q3ExUmk4Q3JJeHkyNTAxS1FPdTg0NThNQjRxWFBvUUlMV2FLWXQvRmdtT1Ns?=
 =?utf-8?B?d0ovS1kxa3M2cWRBUTJjUENSMXA0SHg0ZktpZGIxdFRkT1BNQ1MrbTdjZ3dW?=
 =?utf-8?B?dVZuaFpvZFdhY08xcUVGNC92aGZkdlE1VkhIOW11RVN3NGdSaVJsR2VQYW5Z?=
 =?utf-8?B?c0RuRlF2U2RtMW9OQ2UzSGpXUG56M1Y4N1oxTWdlZERNNGM3YmVzemVieGxD?=
 =?utf-8?B?ZEtFSC9IK2kyZDdpa3NtTjg1K042dXoyd1hHY0J1Q051dHNDb0pHSE5Jcmoy?=
 =?utf-8?B?TVk1Z056K20xeU5YTkFKT1p6R1lDZ3BXaGlSeWJtbjdQSVhXS3llb2xTdHVY?=
 =?utf-8?B?MXlJWjJjSisxdkVoZEUwb1ZCQjFuUnA3dEVndFRXSGJFbmE0Rmo4RmM3UWtF?=
 =?utf-8?B?RkZhc0NFTEV4VnY5bXhnY0doRkYzdllTQjNjNFhGcFQrVE5YOWhheUJHc2w2?=
 =?utf-8?Q?RG0k=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a3bf4532-a726-400b-9e45-08dc628ee595
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2024 05:41:45.5592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IAOng4wU37CsVKSMY+REZCYiXnCJfD93opXCpy5qWO4nFn+wx9/Kc17UykakKAn00a/30sRx0JJu9W5FlrrtvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6159

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIFBhdWwsDQoNClRoZSBGYW1p
bHkgMTdoIE1vZGVscyAxMGgtMkZoIENQVXMgYXJlIG5vdCBzdXBwb3J0ZWQgZm9yIGFtZCBwc3Rh
dGUgZHJpdmVyLCBJIGhhdmUgYSBwYXRjaCB0byByZW1vdmUgdGhlIHdhcm5pbmcgbWVzc2FnZSBm
b3IgdGhvc2UgQ1BVcywgSSB3aWxsIHB1c2ggdGhlIHBhdGNoIHRvIGNvbW11bml0eSByZXZpZXcg
c29vbi4NCg0KUmVnYXJkcy4NClBlcnJ5DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gRnJvbTogUGF1bCBNZW56ZWwgPHBtZW56ZWxAbW9sZ2VuLm1wZy5kZT4NCj4gU2VudDogU2F0
dXJkYXksIEFwcmlsIDIwLCAyMDI0IDEyOjI0IEFNDQo+IFRvOiBEdSwgWGlhb2ppYW4gPFhpYW9q
aWFuLkR1QGFtZC5jb20+OyBIdWFuZywgUmF5DQo+IDxSYXkuSHVhbmdAYW1kLmNvbT4NCj4gQ2M6
IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZzsgTGltb25jaWVsbG8sIE1hcmlvDQo+IDxNYXJpby5M
aW1vbmNpZWxsb0BhbWQuY29tPjsgWXVhbiwgUGVycnkgPFBlcnJ5Lll1YW5AYW1kLmNvbT4NCj4g
U3ViamVjdDogUmU6IFdhcm5pbmcgYGFtZF9wc3RhdGU6IHRoZSBfQ1BDIG9iamVjdCBpcyBub3Qg
cHJlc2VudCBpbiBTQklPUyBvcg0KPiBBQ1BJIGRpc2FibGVkYA0KPg0KPiBEZWFyIFhpYW9qaWFu
LA0KPg0KPg0KPiBUaGFuayB5b3UgZm9yIHRoZSBxdWljayByZXBseS4NCj4NCj4NCj4gQW0gMTku
MDQuMjQgdW0gMTg6MTMgc2NocmllYiBEdSwgWGlhb2ppYW46DQo+DQo+ID4gV291bGQgeW91IHRy
eSB0byBjaGVjayB0aGUgY3BwYyBmbGFnPw0KPiA+ICJsc2NwdSB8IGdyZXAgY3BwYyINCj4NCj4g
ICAgICAkIGxzY3B1IHwgZ3JlcCBjcHBjDQo+ICAgICAgJA0KPg0KPiA+IEFuZCBSeXplbjUgUHJv
IDE1MDAgaXMgdGhlIGZpcnN0IGdlbiBaRU4gYXJjaCwgYXMgSSBrbm93LCBpdCBkb2Vzbid0DQo+
ID4gc3VwcG9ydCBDUENQIGZ1bmN0aW9uLg0KPg0KPiBUaGFuayB5b3UgZm9yIHRoZSBjb25maXJt
YXRpb24uIEl04oCZZCBiZSBncmVhdCwgaWYgdGhlIHdhcm5pbmcgd291bGQgbm90IGJlDQo+IHNo
b3duIHRoZW4uDQo+DQo+DQo+IEtpbmQgcmVnYXJkcywNCj4NCj4gUGF1bA0K

