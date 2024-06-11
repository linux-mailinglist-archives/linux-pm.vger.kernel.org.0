Return-Path: <linux-pm+bounces-8974-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DB690464B
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 23:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 766BA288F4E
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 21:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C108D15442C;
	Tue, 11 Jun 2024 21:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RG9rHs/1"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2084.outbound.protection.outlook.com [40.107.96.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE2F153BE4
	for <linux-pm@vger.kernel.org>; Tue, 11 Jun 2024 21:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718141758; cv=fail; b=Mj/9aO96MK9daCPIhnkSf1sBO919BHQYEgiksH2Qw5TOu5XfHfCO+f905HOoj2GKWopWGPcBN4mpCrYsosS/v8d4aEkCxMlQbCfKndMBTU0MxFT6599plA0SAckTFoh5iYNQT+q3iZM9Qaue0gqAjdWs6CqAzWm7VXOmoujRIzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718141758; c=relaxed/simple;
	bh=ji4ROo2rRBgTyloGWgeGmzEHtR8TSyu3dwij4zOz8UY=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=jHMYqiWXLaQF/9rxSK+KlKdbThxuDIicmWjqKvFy5uNsyV1qovWvuTNmBkrYxo5T1gZqfh9uRLhMtfQVC73J6SCOX9xiACh+bNG91fCp7aEtTDQ/TxsxwkV5mhJ3CGDwBQvHq3dNp1qrnaMaqAawn8ZpMTtE/lVr6AlzQ4MA06M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RG9rHs/1; arc=fail smtp.client-ip=40.107.96.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHTFS1eUrerodQhXUUPJGbN868kua0nhoaFwhdIUIXHSkWBrR/wpWamxjpD8glRZde04HVc2Qu7LwPvoijK5qd8RnvfApu/FTcqM8MukzzjYIJTUCFH/f+SOWlQx9ZXZ0CuyY9XdHUsxY21mG4ESOSw4lelkDY0uN5t4QG9QL1aQsVVszV9n6NATTvkLkpqCoN4O2thrpilaexxyq3NkH/03mUYPfpkT2rkfAwLzz4eRT6gWyn+v83gE+Lsqb9WYku5ceLl87OXd6+gn8dj+ZXBx4v8hC2VtrbnQ5WEEWBBf6JpstMgbIy8anVai6KfgWm7jqp5E2LSJIHtWhxMDBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4s/ACuvjN8m/9Hy2SmBo1y+mYe3PmOTxdljeZTm/nQ=;
 b=jjHJW4d9Pd7PuPPgpgzI7E/JkdKPQ8h4zoCVM3klVnuFLTorupRnaGT+V/A00LqI3ndeaY59rtOizGH5+3EINmEyUwNkc3YXQ6MD14Ak82IWLeVbUsZ/8XOlGcNZ/l83Tfb/UwNlbfrIQWS8MFHr4AoSAlf2j87ya4eq8AfFE+SdRClHXumMFQybCfhwFo5FvNeORGMuO8wYEiceX7g4t4pe5HEvrxnLXDqwIo3BtvbiWuOV67Qe8XDpzKLn396sKQE3g0vOIC+QVsyefGA9TathwWRNlCVOQMdMEQn71Gm9XoBf6jiQcBrQ26iGMOJUBcaJErU/HIn4cTsFuT+I5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4s/ACuvjN8m/9Hy2SmBo1y+mYe3PmOTxdljeZTm/nQ=;
 b=RG9rHs/1W9gqExpePrIrwC4TGlXrO37GWtkcls9jAjJeXUIgi2JC6dylxoxfveBmhbcLpcM2d3Iz17XzVEIFg1LbvlkuuM+8IDBsNe123m5FkVGp1Z1RFVpu7erjAmHxsgmS/nUfm67VBieoJ+4I9fRtTOFO7F5MWdUS4+hqPxk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB5909.namprd12.prod.outlook.com (2603:10b6:8:7a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 21:35:51 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 21:35:51 +0000
Message-ID: <d8de3761-6fa1-477e-8ed8-71abf115eb60@amd.com>
Date: Tue, 11 Jun 2024 16:35:49 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: AMD-Pstate new content for v6.11 (2024-06-11)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0120.namprd04.prod.outlook.com
 (2603:10b6:806:122::35) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: b4e15c40-ae2d-467d-c274-08dc8a5e772a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|376006|366008|1800799016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0U4T0NwLyt5WDk2RnJxSVoyVkVvY25yWjdhc2R2Z2FwNW9pZkM3QkNlVW9a?=
 =?utf-8?B?Y0FMOEh5bzB2dXFLaHh6UXFSdTdWSWdyS0xZRjdlYktqMERqTGMzVjVwNE82?=
 =?utf-8?B?dThOZXZxdGlYNmdyVUMrVXgrbHdHaENpYm02MmUwTlJZR1BwcUFPakU4empL?=
 =?utf-8?B?YzF4cURZelZHL3VaVVJlNmJvaGpCVXc5KzkzSit1WXVkaWtaMEtHL042MlJq?=
 =?utf-8?B?OVBmeHl3anY1SVhUVXhLcmdJelY0ZXBJNnRGK2h5RlpBTkZTbjJ5aFdlSDVh?=
 =?utf-8?B?QkJ5OFZSeUMzTjI3N1VZWVVLZGUwck5WY2oxdWJvbU9IU3Z0dnMyUmF6dHdU?=
 =?utf-8?B?d1E0WVZoOGJ1M3E0QWRKamRSbEFWbUhnY1JId1FtblA5SlpBRFAxVngwSER2?=
 =?utf-8?B?U1dQVU1zMDZKdzZmT1NCOEt3YXk5aVFJbVdvL1BxTW51K0M2WE1JZVpCdk1V?=
 =?utf-8?B?TlJGNmJaVS93N1lubkF1b0dQbW1kUmhLTEVXNlRlbnQ4QUxQMCs0RG5CL0dp?=
 =?utf-8?B?Rk9Sb3BhUkwwN1ZXZGlUUGE5WUhrV3RLRkh4QUNRd3MrZndGZDF0N1Z4c3dS?=
 =?utf-8?B?Y0RrcjZzUENxR2ZvLzZjM2hwSEEwWWZQS1lyT0ZPcy9MZ1o5UHdlYURzMFpG?=
 =?utf-8?B?VnBLOVJGbDdza2NNQUg2czNoTW9TK0hadm14Yys4aHIwNGcxN2paVWVrZEJX?=
 =?utf-8?B?VzRUbk1XVXlIU1VndFdZSWVFWXdFVDAvN0RzekpPc3pmU1dCdHZPZ1YwUjZ3?=
 =?utf-8?B?UmlydjRqMERUdmhmUUdYVDVVWEtRUHdqSHRtczFBeTdZM0lCamVUNHkxQ1M4?=
 =?utf-8?B?U01HTVFDTUxIN2dlaHVVTHd4ZDJxQW90VVRhMU5JMlNnQktjV0JYbG9EWkxL?=
 =?utf-8?B?aC9BNjhJM3dJR01MSitsem1TdTFPb01UeTZ4UlBFYVdDTDM3RllVb0xybDA1?=
 =?utf-8?B?YUgwaENXb2JNcTJiWk9XVW9mUnRtT25uQmRXK09QWWNra2x3UTZFUGxxOU9X?=
 =?utf-8?B?d20yRStxWFBnTzU4ZWMyaXg3RlVkemFIVFkvYzV1UU5YenpOSTU0V016SGVR?=
 =?utf-8?B?OXBHdU1lZmVZeW5aS3V4cEE5WURYZmtuMzhQcloxWEhmVGdIVVM3MXhnbXNO?=
 =?utf-8?B?NVUrTTBzcktiRTAxVnM0VzJ1ejcvSTFwaXZEY2ZaUW5UL1VybVF1NWhvTEkw?=
 =?utf-8?B?R0UrNSsxYWRmUkxCbEFiQVRTMC90d1QrYW92ZHpPMTdGR0RqRlF2YUJuSDFt?=
 =?utf-8?B?V2RPNVdybHk4MHlJK2pXUTI5ditMLzdQUit5RlZFTnJocXJSVDN4VXdRbWVY?=
 =?utf-8?B?STY2SERvZzVwWjhpTzdOSkVMNWZ5MDZaVWliOHB1QVQ3aHoyT0VOVkdXYmFE?=
 =?utf-8?B?R2JpVytWSkl0YTIwRU53NmhjaXZnbEk2QzVQSkllUnJZaWpkcndXUkprZkVO?=
 =?utf-8?B?VFlKN0dQRkkwV0JsNWtIMjBIeVNxbEg4YWRjVklGcnFlMU1Ud3c1U2NBdnU5?=
 =?utf-8?B?S1NFdElDc1lVYlFXM3NYVS9qTGZzcjdjMmxZd25yVFVuNVFTZERpMG1CcEli?=
 =?utf-8?B?WjZ0bm5kbG92YXJxMnFFeVhVNFhMOHNsSEZ0M09WOWtZT2VvdzR3ZmpHMVAv?=
 =?utf-8?B?MWh4N1R2QjZncnBCVENrN1Ftd2FidzZLaEpOenV1LzgyWnd3aDF2VGgyblZU?=
 =?utf-8?B?aEZSbXdtenZteEVJSGhKYXVvcGhCMUxiVFp5SmNHUFBFdkFNWk9TbXZKWVpq?=
 =?utf-8?Q?6Z269RVJSwUQBzWjA84aS+Xg79cfQ5PJeIbI0ou?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(366008)(1800799016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1NJZzJOVGtQbk9OTXhnQWc0YWNVbm1oN1doMGxKYkdyQnJIY3dRRGVlWjZh?=
 =?utf-8?B?bEN6M0JmZGNXM0NBUHp2aEp3eFA4djJ6dVJ2bjh2bW9jZmI3M2EyVHJsYnNV?=
 =?utf-8?B?bUprL1E3Y2FOVkx2dlFKYjREc0lvSVhydC9lQnlaRWdUWHFRLzV2UW82S2N4?=
 =?utf-8?B?dGpCTlc0aVpHc1FSelIvdHBIbDBMQ01QdFJENHV2Yy9aMGIrV3ZLdjAxNmto?=
 =?utf-8?B?UG9KTHlac09PY3VoZ3FpMlBHU1dlQzFVSzE4ZE9idUtGeU5RZE1vNVY4bGY4?=
 =?utf-8?B?VlpBQWF4QU8vSzVCS0ZWK3RJeVZLdGwzR3g3eHVCSit6Zkc5cGRCTXpFTWh0?=
 =?utf-8?B?WFN1czVRZGhsZ3dMRDNVUlNKVkprM1A4dFZKd3c2S2FIWE1QVHlXa1lWTXlz?=
 =?utf-8?B?T0ZvNC8zZzlNTURRdTljMThGRk92Yjdha3BtQ3VqaGpJYlhrSzRzenpRTW9U?=
 =?utf-8?B?M0lPUlpIZTVONlBJUTh0bUJydzZCOUlmVy9rdHVxd1RaeVdrQzdCVEh1TGtO?=
 =?utf-8?B?SXd3QlBjZHpLUGdVTHcxWHRNaUd6ajlrYkprVzluMHBCSUVCS3BCMWREeTVJ?=
 =?utf-8?B?OEo4aU5MZGF6MGhJeHFUYkxoZmI5RXExK3dPdEJJVmJERzE4V01LOGs0Ykg3?=
 =?utf-8?B?UjVQK2JOMnQ5dGNJbGVSOE1MTUlxam85enJUc2Z0a2t4ZFMyYTJwd3VXclYy?=
 =?utf-8?B?cFl4ZVBuTDV1R3F1ZlBsOGpSTjJKZ0d0c1ZsQy9PYVJ4aC9qNm56aDQ2OFpi?=
 =?utf-8?B?Sk1HZGxJRW5STXBPVGd2c1FMZ0N6YVpwQVZublpDS3lFMVBzUDM3VGpJbnFo?=
 =?utf-8?B?eFdkQ0x0ZmFLaFVyS1R2RkRobUplc1QzSjFoTG5xM1hPREpHWlNia2o0TVNZ?=
 =?utf-8?B?MG1FaEMvVCsyRmdZWk54aXdGWWVEQXFkUjQwQ2ZZVFRKc0hsTHAxUTdEbEp6?=
 =?utf-8?B?VFcrejFvWHJILzJCNml6MW8yZnYvNTlJU1RqSmV1anFjd3FQdzh5S1VFamV3?=
 =?utf-8?B?enZtcTRlcG10MWJXdnlYRC8xN1NhcFBxalhBYXRpUm9rZzNPaWx0ZHpaRzlE?=
 =?utf-8?B?dlNIK0VZeWVZNTRZMlorT2RFeW5GREhmMlZldFludkwya0dHMjYwU2VKRjY2?=
 =?utf-8?B?YkxYRzM0bnZUcTdMNFEwcUppd3Rkb0RiWS83NFRNMGlwMmo3eHNOcEs2amdD?=
 =?utf-8?B?VVZKMW92aExlQTBlNHdXVzdTRURaNXpydTFCeGZmUWE5YzFIV3hHWHF4WHA3?=
 =?utf-8?B?ZG1ZMVFCOGZ6VFRPRXpwc3N6eFJqV1VUak9JbzAxVkVsNE4xZG1jSFNWcUY1?=
 =?utf-8?B?RDNHKzJaYVRwRndpZlcxUXhCZTc3SDRJcUlRRldXekZqRk0rakdmMGsreTRF?=
 =?utf-8?B?WWwyQ3pJOVdqZWMzOGtWQ21WcnRiTU4xRE02VU1OODRTbDExUmFObTR4ZGc4?=
 =?utf-8?B?V20wVzBCNkVucXVqaDBxOE9SZGF6VHg5d01LaTZsUFplb2JjT2F0emxwcHBF?=
 =?utf-8?B?Y3NWRytmdVFkeDlRV1RoK1lzb1h6WjNjK1ZUcGZoTFFCSzMwOHVnU3ZCeGND?=
 =?utf-8?B?Z3dJK3VpcGR6eGhEUFhrZGZtbTh6MXJydUliWmxhQnU5YlZoL0txcHdTL0tj?=
 =?utf-8?B?UUVzSE9kZlBBbC9ITTFNdXVrRDlyUEwrNFA1SU5nYWc0bFZjM1pVSFVTRTdp?=
 =?utf-8?B?VFY1MXFzUkxJQzJ1bXhSQzdiR0ErNko0clVJYjdVUjhlOWdYNHN0YVhYODRk?=
 =?utf-8?B?RFVGTlhzdnNrSHJsWUtvVXB3Q0U2aGhhdmo5akdQOVRXcmhGNElUMUd6clJG?=
 =?utf-8?B?ZHNCLy9EcjNKR2pKdnFzTVVFYzdTVExVN1JFODNTb1MwQ1h0Q0JybDJJNk1l?=
 =?utf-8?B?c0FHdTczdXlFTEE4TklVV3Q4UUZ0eEYrZW4wNDBadklxZWJCSlRHL2lEM2t1?=
 =?utf-8?B?SE5tNmlCVm4vVkZ2YmM2ZlJvTU5qQ3RGMUtKUVJJZ25NYjRLK21SWlFsbTZS?=
 =?utf-8?B?aGVDZk0yd1BtZ1VpMytIY09BMk05VGtOSEFSc2lhaWlNVjVJclNEQVJiWDNi?=
 =?utf-8?B?a29XRDlyS3E2OURtTnlnQ0xRRXk4aWxsc2RpOUorMnNTcEhIU0s3MXd3V21X?=
 =?utf-8?Q?CBgI/V3of7HlYmckkcQ8f1fp+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e15c40-ae2d-467d-c274-08dc8a5e772a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 21:35:51.2170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L61Gb7d5IaCXFPSEqKNGv0XODQQ5dpsHrffhANgnmpygKTcxpHYd5hf51XKSS0XZNzmZ6h/F3SzDLkLBjpVwNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5909

The following changes since commit 83a7eefedc9b56fe7bfeff13b6c7356688ffa670:

   Linux 6.10-rc3 (2024-06-09 14:19:43 -0700)

are available in the Git repository at:

 
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git 
tags/amd-pstate-v6.11-2024-06-11

for you to fetch changes up to c00d476cbcef4cbcf0c7db8944df7e98a36bdbfa:

   cpufreq: amd-pstate: change cpu freq transition delay for some models 
(2024-06-11 16:12:12 -0500)

----------------------------------------------------------------
Add support for "Fast CPPC" which allows some CPUs to operate a tighter
loop for passive mode.

----------------------------------------------------------------
Perry Yuan (1):
       x86/cpufeatures: Add AMD FAST CPPC feature flag

Xiaojian Du (1):
       cpufreq: amd-pstate: change cpu freq transition delay for some models

  arch/x86/include/asm/cpufeatures.h | 1 +
  arch/x86/kernel/cpu/scattered.c    | 1 +
  drivers/cpufreq/amd-pstate.c       | 9 +++++++--
  3 files changed, 9 insertions(+), 2 deletions(-)

