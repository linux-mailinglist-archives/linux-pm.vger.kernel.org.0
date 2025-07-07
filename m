Return-Path: <linux-pm+bounces-30296-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2311AFB674
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 16:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CBDA1888C5F
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 14:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1227A2E1C63;
	Mon,  7 Jul 2025 14:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=viavisolutions.com header.i=@viavisolutions.com header.b="H19iCsR5"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2108.outbound.protection.outlook.com [40.107.95.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEFF2E11CF
	for <linux-pm@vger.kernel.org>; Mon,  7 Jul 2025 14:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751899736; cv=fail; b=KsYcRx7pP04sBVzuIbPVx5+QC1Fq5ZLHIYL8nd/noV3uuiEwm6r6v/il+C/2fZIyngO/LNmmd3c1gTTSIMcaBGcuCHHLUC7ZEW9Bwi0Q5KYhSvbyZ93byF1bfBduP1n0nLOGAT3NR8RPmkBvcPMkq2C93LLXHk507CssXfpAFME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751899736; c=relaxed/simple;
	bh=rrsLLwujs9e0twI1zyOMOhXAHbSlcb4XZJiDVoeaAgs=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=Gbtxkqq2SF3lDSTfecZB++e9XkUwTM1W+ettcPh3VFZAN/fyVexHMyMJSexuwSCF/dN2QMmvlRIRfqzCChkPuYC3tlVuStge7ixpJEk0DHoO1O75DFHte0usvFXfXwD2mwQN+yCG+crpqL4Yok1ogUtb2jM3XUJmHT/ab+Wcf5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=viavisolutions.com; spf=pass smtp.mailfrom=viavisolutions.com; dkim=pass (1024-bit key) header.d=viavisolutions.com header.i=@viavisolutions.com header.b=H19iCsR5; arc=fail smtp.client-ip=40.107.95.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=viavisolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=viavisolutions.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SKj38zUl6smwiscG6jYW/W0an5JsKIVVdV1M5mfnlZ2wbJXha8DxbdsEsht19x6tyI2UJCwAx7Ra3i0k73wuRlnpLVPB2ahl9sclg56evCkJ4Sit6Aufjb71kDTA+NJQ58GRYnV+QZ1P4ZMUyEcWLFqrTZizHGsP1Jkqnc06OQBkzrt60dhWMYgopzO42B5EsYPBa/Ra+C1AP7Zrcve9X3oKAvJ4NqRcY7wPKI+03Ri7Uv9oPjUrPlb/i9BK8PZNSZ0XhcU7ThVoFXLEWPsnfecoPOjAd5EXU5LGF07/Y1LCgU8vBCaSH0gKZRBzQTn8QIPQgHg9VoA5MB9BF/uoIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5OjhSlDELTwkEec5emEvQbhHDDZqfn33qNG7d8hLV7c=;
 b=BbGm3d5eXIvH0MLywChmh++QeV90LCSX7y0E0X4zCbOlQKxG83381aJ6AN7eseJ2I7RXp/dwqq96GGN3cehAjLHf1vX52+j06kFTZkwwUlrPlsyGvfrlX9JjGtim0CTPsTaE39bd5iMihZ3NJyQiDeXenXnj1cl9E42lcOHtdC3d61FergtX6ntj57UXp4KvBN0KcTylyMOXZwwM/qYpukANg3bg9pCPQAKTWJDsQ+cnhP+/2C7nSLIursz412HNkFVF7sjQ0bLv031NjvdW6OY3v5vzW/tGAgU8F9fUQdh/0udhTzPpb+DlyCjs4pHikzVnrflO23q5CAA+fsTrVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viavisolutions.com; dmarc=pass action=none
 header.from=viavisolutions.com; dkim=pass header.d=viavisolutions.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=viavisolutions.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OjhSlDELTwkEec5emEvQbhHDDZqfn33qNG7d8hLV7c=;
 b=H19iCsR50B6MwRoAwIrCZkXLsufiRSCN8sRHCGpVDRcQpEiWdriv7VoF+v8cg6jZ6bRF22NPmmrspbFSuisTETq3Ynzeu66+XM9hIqIW0LzeKf9jDL3UW8Hingys0p9jAldT3/p7nQ3UxAaKcHyzN15S8LJ3nZ2+Qf/cOWyqXNY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=viavisolutions.com;
Received: from PH7PR18MB5549.namprd18.prod.outlook.com (2603:10b6:510:2f9::5)
 by DS4PPFFD8A841C2.namprd18.prod.outlook.com (2603:10b6:f:fc00::ad2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 7 Jul
 2025 14:48:51 +0000
Received: from PH7PR18MB5549.namprd18.prod.outlook.com
 ([fe80::b355:4e50:c0fa:ae1d]) by PH7PR18MB5549.namprd18.prod.outlook.com
 ([fe80::b355:4e50:c0fa:ae1d%7]) with mapi id 15.20.8901.021; Mon, 7 Jul 2025
 14:48:51 +0000
Message-ID: <e3e71f22-7865-4daa-b02b-b6b58b1abd53@viavisolutions.com>
Date: Mon, 7 Jul 2025 16:48:47 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org
From: Fabien Proriol <fabien.proriol@viavisolutions.com>
Subject: [PATCH] power: supply: sbs-charger: Support multiple devices
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR0P264CA0252.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::24)
 To PH7PR18MB5549.namprd18.prod.outlook.com (2603:10b6:510:2f9::5)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR18MB5549:EE_|DS4PPFFD8A841C2:EE_
X-MS-Office365-Filtering-Correlation-Id: 781a5e19-6b02-42ca-e79d-08ddbd65637b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RERKSTVpUzg3Z0NUVnp4N3FQZjd4dlRNemVnWHY0enZEUXFGV2dXS3l4Skl2?=
 =?utf-8?B?VkdVcTZZY2ltM216UllaREpMZDlzNTJ0NWU3alZJSjRqQTY0WHlhTk5pQ2dH?=
 =?utf-8?B?enNiZDRUb3FMbnRYVHNybFJheWYzd1NuWE1aL1lVY1ZsUnlmU0w4VTZvUGZq?=
 =?utf-8?B?MFZvRVZXczEyK3gyUHpvdGJ1aFJNNGYwMElnVC9tRGI4N0Q3alczZGp1dnJr?=
 =?utf-8?B?Vko1MWdRTmRFT2JvOFV0MUl2RDNJNytNMkJDTTBGUThYQWUwWEZjaHlScng0?=
 =?utf-8?B?YURqT05WYTZ4c05hTkhoWVA2QmZaMFlNcGdFcmZSRlRGTTg0Q2FGN0pPd2pT?=
 =?utf-8?B?clIrUjMxOEwzNGZCbXd2SkNZY2dOdHJnN0VWbHVXNVljRzZqRVJmN0VOTkVi?=
 =?utf-8?B?ZDZnZjIwdytuckY2Tmg5VmZYZEZkQnV4Tzc5aXRySVdJamwzak5FcVdFa05G?=
 =?utf-8?B?eHNsVDdNRDNHVEpEQk1qUEl6QjZubkIySDBJUXUvZWo4UWFmZngxWVJYK0Nx?=
 =?utf-8?B?SDhwRjRqYyt0d1ByNmVENVpzWVNnUHJmV09LdldXOW5BaFZ4UWNiYmN2OGV2?=
 =?utf-8?B?MHlsL3dxSFlIZXJncWs5VktGVFFSN25EVTU0Nkt4bU80Z1dOTDZEZFJHVGlh?=
 =?utf-8?B?dGJRMzBibzFHS3NmWks1SHRuYWlzL1FzYkxoeHNSdmhTSlJIUElvaCswQ04r?=
 =?utf-8?B?YnczaXgyZmdLTHlza1p1eU0vZWNQaWlBcFZMcmNEWTVjak1VdEwyekY5M01J?=
 =?utf-8?B?am5oRnJqWm4yZFRiZWlHS2tKQXo0d0FBc3hVR0lPd29RbTl5OFdoNFR5c1kw?=
 =?utf-8?B?eU1vY2c0QkZiVmFDNyt5REZYUU9VZ2hjUVErdE82WHozSngwVk5FdW5mcVZY?=
 =?utf-8?B?Ylo0ZWNuV0U3OXAxM3N2S1AwYkNPMnRSdCt0Si9zK3BsTUJqT2hBalVRMGlt?=
 =?utf-8?B?RFdVOTJhdnBDUk5pYU10NzUzMUFEVlh6dUZrc1VDd1FEU2pEQ0VHNW1QRmFV?=
 =?utf-8?B?S2c5djBaOS9UTGFtMDJwZkVFSkgxY3dsM3pwdkRTZlJKYlJwM2pTZzUwT1RP?=
 =?utf-8?B?a0VzY2dFK2FudjZWU0hyRGltRHFMSzQxYkVBc3I1NDVnTzNMWXE3N1RqRGZm?=
 =?utf-8?B?MHJvSXZZSGZqUzc0YW42NUFuNWVONW0rSkNxMDZjRk9IUHliRkxpbzdEc3M5?=
 =?utf-8?B?N29iZFZDWVlRS05jYXp1UFVRZlZmcHNNaHZiU0w4T0lydjdtcWJEcVVUR3Vj?=
 =?utf-8?B?WlA3M09DQk53YnFVWWUvQmNTYzV0NmZ5NzQzUFpHWlp6K0Rqa1FvM3Vqa09V?=
 =?utf-8?B?RE9HZzZSZndhMWpQdHZqUW1GWVVkd0hjUHZCclQzbjdBRUx4WGFxVDBqaXk0?=
 =?utf-8?B?SFNCdlBPL1lZendabW5qaS82ampBSlpGR3Z4WnRSZjM5NjYySk1oNFBscmVs?=
 =?utf-8?B?OGh1Z2dJdkxwWTNudkYrdnZRTHNxKzd4V04vSjZ4OEEzRjQwZkQ1d2hNRGhj?=
 =?utf-8?B?NUF6cWdacGlEeWZUaVlhT0FGSUNIUHk4RDFSdzZ1OHoweFh4RXloSlJBNnhJ?=
 =?utf-8?B?VE5RajNDTERHVHNZVUIxMWdEU1Rmb0FiTGhQcEkwNTJ6NmIvRU1WaUNVUHBX?=
 =?utf-8?B?THBhanA2MnkweTA3bXVndVIraFo3bDhJaFV1Q3QxdVNaS3JENDZvVnVUMTdE?=
 =?utf-8?B?N3JYOWRBdVVpK1RMVVpsc3JlRTY3YWlDWHcydjVWc2JJQ1RGSzZFUHMwL3dS?=
 =?utf-8?B?d3FwUHBlOXZCS0l1N2FYOTVPb1hMelVVOVJOVjRpRkhHTDJNTEJLcGNTUzNv?=
 =?utf-8?B?SGJiVGpzMUo1TDRQSXJTMTdYSXlNMGFZNDBDS2NucWYzRm5xZmN2bTlmVW1h?=
 =?utf-8?B?Yi80UW5BcUQ1dlNDQzBGRGUvZnRjZDhwZ3NEekJ5UmdNUyttT2duenJMWm9y?=
 =?utf-8?Q?HQlr8QXvQk4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR18MB5549.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTdreVFNMDRlOXUvZVdMMG4yNkVaSjdVK0ZSaDlabytkWVFNNGVNZEFjZmFO?=
 =?utf-8?B?dmo4blhtQ3dXcjZ4ZHoyQVRGck9iSzNLd0psbTBQZllQNjZRbEI0dW01czBy?=
 =?utf-8?B?eU41dWpZTkxpdC9rd1BMUFZEVHNaUzE2K2lOYkJHVFdIZ21QSUpqTTZsRGZz?=
 =?utf-8?B?cGZURUE4bHBxVkxpUG5qWlJZV0xSMEZ1RjFvZkg2TzZEZGI5dFN5VHpqdnpn?=
 =?utf-8?B?ejMzS2FVVER6TjF3YmpRdzRST2tiUXNqTXlHazJseThiaTVESTVZYTlHMFJR?=
 =?utf-8?B?amNVdE5vMFBGdXBMVnRPa2RBUEFGWUlmK20rWHFWdEZEaEZhd09pc0NYUTEv?=
 =?utf-8?B?K3RNeVRPV2EvaWFmN2p1Y1RYZHkzMlFJMmlLR25OUGVsZGJaaFNoQTBKNVRF?=
 =?utf-8?B?RVBvUlNhRStqY3MwTTRUR0w1V1hwcnh1UHNHNFRva094WHUvd1RFSEdVcGhM?=
 =?utf-8?B?dDB4aG10SnN6d2NPdHhpbnV2eVo5SVJ2bi84VFh1anhVdXErRmhTTk03WTNt?=
 =?utf-8?B?YXh1Myt5eGI0WVRtTklEUDVVNWk0SmxIbWFrQlBZY2tkNlRYTHlvTVZPN1hx?=
 =?utf-8?B?Wnp2RTVCNmx1bmtnSkF3VExkdkpOSlNmemJIbW4rUVdoTkF0eXJBcUFDY0VB?=
 =?utf-8?B?M2tJU1MxM29kakVMb3czZ0hkb2hEN2t2QlRudFFVeTNuU0w3ZERhN1FnaHdU?=
 =?utf-8?B?djhldmZpbWc1ZHZrTjlUYWJHbXhLMHRjRHk1THZCTlA4ZHhDREZhTUFmUGhE?=
 =?utf-8?B?RjJkc2VwSGtXZGFrR0E1UzJPN1NjWWwvUzFxMTgyMEJFVW9iMk02aEVDZE1z?=
 =?utf-8?B?YzBKdkozUmM3dkNuZmRSVW5ITzY1cC9kMzVjYmQ1NHlBR1lLd0NZTExXWVBz?=
 =?utf-8?B?blpETUxtd0JVakl4OHY1MkdLVEJXM3BvR0JwUWpoZXkrTEQ5K0dmNTNtdUVB?=
 =?utf-8?B?NjdtSXpsQ0Rpdnp4NEdJUndpYSttS3hGZXEvZFV6aEs0b2YyeUN6dTg3aVhV?=
 =?utf-8?B?ZXYwZFc1MVM1QktiaW91eHRMY01pSkZwejhVSTFWTllwV2NKSGFOZVQydnFw?=
 =?utf-8?B?bHNabmo2eGdrdHRBbFVDVExvQkRnWS9IY0NTVSsvZklNQXI0aVF6WXVDT09q?=
 =?utf-8?B?ZGQ4MG8weVkrR3QxZE51RW5nNDZpNUFFQ3V1ejdNOE5FaHVlbTNEWUY5Tkps?=
 =?utf-8?B?VHgzNkV3ZVNZdkRtSzNJU2czZW9TQ2NkZzRaK0FaMmFOcjFDbkpFY2o4Y2d1?=
 =?utf-8?B?T01wYy9kRDNTNzZTZnJKc1NWU2N4bGY4Wi8ya3hFRjlnMUJhU0dwYXBvR2ZX?=
 =?utf-8?B?Z1JTWmlvTEIreUxoUE1vRCtKVG5FdG5DTWEyeDZPY3JiYkQ2L3hvVDlxanQw?=
 =?utf-8?B?ajFHbUtFakRKSkxiYnhsSDFHa1B1TSs1THNpcWtxc09OVDJHd0JXaE12Unc2?=
 =?utf-8?B?alRwZC9OK0xzSkdobUZDWmNwQnNmYzNNbXgxYWx2WEk3dzdwOGpxYmwyVklL?=
 =?utf-8?B?OWJ4c2tVMktFZzh5b1o1R3NLSEU1TmpPWHBLVGlzMW1NWC84RlpVYldHUElT?=
 =?utf-8?B?T1gzRUh1K3h5UE02NGVSK3lvaWlaOEZhTkxFZEZiWE5hLzMzVVl4eWxvN2hr?=
 =?utf-8?B?Z1hDUkdxTXBvMnQvNFNjWTBBZWpJd0pxWnZzUG5oNnhndXlBUFpEYWpEUUxV?=
 =?utf-8?B?dHpRVGNmNkJJZTIybGZ0Njd6R0UxNFFUZGRXTjQ4UXo1b0tCTzNUcGFyOUxy?=
 =?utf-8?B?dlMxTzh2d09jRFhBbUtKT055UUlnWGx3YXFmRFBwTjUrWFgxOHA4L3V5YWRt?=
 =?utf-8?B?K0UwU0hnbE9rcDlpTEMxbWlIOXp3cUgycWpnS3M3Qk1xU0xEVVVCQVJBaG80?=
 =?utf-8?B?K09MQzltalNIcmFZTUlrT05lb1NwcTc1TSs5RmFJQk5ndjhvWXZyS1VONjBK?=
 =?utf-8?B?V0xnZjl5U0RwdVFwbDBIZXRVUzF0ZGJ1UVAxKzJKbmhKRG9ibDc4bFIvNzN4?=
 =?utf-8?B?ZlRhWkY2bXdIcndpeUJETE5PMUszd2xJMUZSZ004WjlqenBHbk9ycWhpRm9D?=
 =?utf-8?B?WmUvMTJjSzZRajFnVjc4eDNRT2xTZHVubG5uR0VqUFFqS0FMZTFzMWFXcXZD?=
 =?utf-8?B?MDB3MDFTRXVidHBXaWJ4a3dTbWNTdkJMMi80OTNTYk14UVlGUVIydlZ2ZVBl?=
 =?utf-8?Q?OKJBoeLqdJN7Lwu8Pxi23/0=3D?=
X-OriginatorOrg: viavisolutions.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 781a5e19-6b02-42ca-e79d-08ddbd65637b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR18MB5549.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 14:48:51.6394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c44ec86f-d007-4b6c-8795-8ea75e4a6f9b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rB+ClWR7TiQNQLKvlrYKEAMM5tRrlwY72QqGM0kiBFQzJNVxGt+6yavb1jwoVBpBR3W3dwSuikZY6AM0kz7gIYR9oon9iHJHcBwgHBmlms0svp5upjwR64oWJSxRL7zg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFFD8A841C2

From c24a5c0b6f08edcd9fa0affe182cf69a4f66c770 Mon Sep 17 00:00:00 2001
From: Fabien Proriol <fabien.proriol@viavisolutions.com>
Date: Mon, 7 Jul 2025 16:46:51 +0200
Subject: [PATCH] power: supply: sbs-charger: Support multiple devices

If we have 2 instances of sbs-charger in the DTS, the driver probe for 
the second instance will fail:

[    8.012874] sbs-battery 18-000b: sbs-battery: battery gas gauge 
device registered
[    8.039094] sbs-charger 18-0009: ltc4100: smart charger device registered
[    8.112911] sbs-battery 20-000b: sbs-battery: battery gas gauge 
device registered
[    8.134533] sysfs: cannot create duplicate filename 
'/class/power_supply/sbs-charger'
[    8.143871] CPU: 3 PID: 295 Comm: systemd-udevd Tainted: G 
           O      5.10.147 #22
[    8.151974] Hardware name: ALE AMB (DT)
[    8.155828] Call trace:
[    8.158292]  dump_backtrace+0x0/0x1d4
[    8.161960]  show_stack+0x18/0x6c
[    8.165280]  dump_stack+0xcc/0x128
[    8.168687]  sysfs_warn_dup+0x60/0x7c
[    8.172353]  sysfs_do_create_link_sd+0xf0/0x100
[    8.176886]  sysfs_create_link+0x20/0x40
[    8.180816]  device_add+0x270/0x7a4
[    8.184311]  __power_supply_register+0x304/0x560
[    8.188930]  devm_power_supply_register+0x54/0xa0
[    8.193644]  sbs_probe+0xc0/0x214 [sbs_charger]
[    8.198183]  i2c_device_probe+0x2dc/0x2f4
[    8.202196]  really_probe+0xf0/0x510
[    8.205774]  driver_probe_device+0xfc/0x160
[    8.209960]  device_driver_attach+0xc0/0xcc
[    8.214146]  __driver_attach+0xc0/0x170
[    8.218002]  bus_for_each_dev+0x74/0xd4
[    8.221862]  driver_attach+0x24/0x30
[    8.225444]  bus_add_driver+0x148/0x250
[    8.229283]  driver_register+0x78/0x130
[    8.233140]  i2c_register_driver+0x4c/0xe0
[    8.237250]  sbs_driver_init+0x20/0x1000 [sbs_charger]
[    8.242424]  do_one_initcall+0x50/0x1b0
[    8.242434]  do_init_module+0x44/0x230
[    8.242438]  load_module+0x2200/0x27c0
[    8.242442]  __do_sys_finit_module+0xa8/0x11c
[    8.242447]  __arm64_sys_finit_module+0x20/0x30
[    8.242457]  el0_svc_common.constprop.0+0x64/0x154
[    8.242464]  do_el0_svc+0x24/0x8c
[    8.242474]  el0_svc+0x10/0x20
[    8.242481]  el0_sync_handler+0x108/0x114
[    8.242485]  el0_sync+0x180/0x1c0
[    8.243847] sbs-charger 20-0009: Failed to register power supply
[    8.287934] sbs-charger: probe of 20-0009 failed with error -17

This is mainly because the "name" field of power_supply_desc is a constant.
This patch fixes the issue by reusing the same approach as sbs-battery.
With this patch, the result is:
[    7.819532] sbs-charger 18-0009: ltc4100: smart charger device registered
[    7.825305] sbs-battery 18-000b: sbs-battery: battery gas gauge 
device registered
[    7.887423] sbs-battery 20-000b: sbs-battery: battery gas gauge 
device registered
[    7.893501] sbs-charger 20-0009: ltc4100: smart charger device registered


Signed-off-by: Fabien Proriol <fabien.proriol@viavisolutions.com>
---
drivers/power/supply/sbs-charger.c | 16 +++++++++++++---
1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/sbs-charger.c 
b/drivers/power/supply/sbs-charger.c
index 27764123b929..4bf4dfb50539 100644
--- a/drivers/power/supply/sbs-charger.c
+++ b/drivers/power/supply/sbs-charger.c
@@ -154,8 +154,7 @@ static const struct regmap_config sbs_regmap = {
.val_format_endian = REGMAP_ENDIAN_LITTLE, /* since based on SMBus */
};

-static const struct power_supply_desc sbs_desc = {
-.name = "sbs-charger",
+static const struct power_supply_desc sbs_default_desc = {
.type = POWER_SUPPLY_TYPE_MAINS,
.properties = sbs_properties,
.num_properties = ARRAY_SIZE(sbs_properties),
@@ -166,8 +165,19 @@ static int sbs_probe(struct i2c_client *client)
{
struct power_supply_config psy_cfg = {};
struct sbs_info *chip;
+struct power_supply_desc *sbs_desc;
int ret, val;

+sbs_desc = devm_kmemdup(&client->dev, &sbs_default_desc,
+sizeof(*sbs_desc), GFP_KERNEL);
+if (!sbs_desc)
+return -ENOMEM;
+
+sbs_desc->name = devm_kasprintf(&client->dev, GFP_KERNEL, "sbs-%s",
+dev_name(&client->dev));
+if (!sbs_desc->name)
+return -ENOMEM;
+
chip = devm_kzalloc(&client->dev, sizeof(struct sbs_info), GFP_KERNEL);
if (!chip)
return -ENOMEM;
@@ -191,7 +201,7 @@ static int sbs_probe(struct i2c_client *client)
return dev_err_probe(&client->dev, ret, "Failed to get device status\n");
chip->last_state = val;

-chip->power_supply = devm_power_supply_register(&client->dev, 
&sbs_desc, &psy_cfg);
+chip->power_supply = devm_power_supply_register(&client->dev, sbs_desc, 
&psy_cfg);
if (IS_ERR(chip->power_supply))
return dev_err_probe(&client->dev, PTR_ERR(chip->power_supply),
      "Failed to register power supply\n");
-- 
2.47.2




