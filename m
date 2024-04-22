Return-Path: <linux-pm+bounces-6808-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D840D8ACF7E
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 16:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 082681C216DB
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 14:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DC61514C5;
	Mon, 22 Apr 2024 14:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q6hyoEXP"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB073CF65
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 14:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713796398; cv=fail; b=mSz2iDPQv7GX2GwJoYmAdm+MkRJIAXZpZYScZIHy14XN5F4P6w++3sY1erg1U62h5jSO8iehg07gbaOZaQv6jm/XSLahlt0CbRXDZ9L6c9OBsT5snFJuSCkegYCGYiEolMW2LdothZkashCzaLNe9xc4W7PggQlsLG8D9J231fE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713796398; c=relaxed/simple;
	bh=jG86TzPhm0yJGY1Gh8n3JBlGo2jQlw7EgMKwZplEqoM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oChzcOgPBC6HwrXSCllBMpVeLtz+T2KEOsFKFMZ5qIq1NJ+37n6Lv5vOF7UYHrgWW0w53Er//9BNELJx8W+jwCZckM95jWf1J2KuTTh2Vim6/G7dUKAm/v3G0dF6o231wj9AEpQSESc7F+GS5cSvzbFROFl90mT77+nJVWTiYv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q6hyoEXP; arc=fail smtp.client-ip=40.107.236.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HchRsDEv/wnZTVGHwtVhOmPG1DO5foiarcAZO2Osw32Qog1dC9Apovw1Naw3Lq5vZtZzXptOjfnml9hdpcSrAi0qT8o2yySD70ABGxSvPBB0zY13VYls9naV+eM9hKM2LE623TOjnFG349IwyA2huolm9FThH3xfCam+ruKdMo9oyvghw4kebkp5aDnty8KwAMnR93MbLg9IwM5HROmPntea6rh5+ugaNOxoQhxs8wCA6pHZhA5y9L7wdpmyXHtEbZtWn+TOreJEfqeruM4NfsneQPSaApLXqI78siGfRsH92Xe9y63pRpnj4QTOdOWycLZ72UDhi9PXeDmdQ+lMaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+z4iK2V/Ce5OLI0Xj5MJ2lNYEFG109dhydxB7EHByg=;
 b=T3cpLrnmpGqBSmPd0LnGYg9emancQsMrtLe/+iGPDInzffJQ+eFEROPsTJGei5zO2kAS8XuzeBuRu+g/AmGkDgru1hZ38uJUnsNyYV8EfVaLfxm8l9ssruMF5Omh4Gl4J2LRQ9Gg8qB/CAVteJhKS8wkwqPIeTuKbXja2Rm34gjGutoopTIZhhhSaLTojiHzHJVtB8Dj5ZFCbi5ftbFMDl82oO216/33lF4LAicpspEQ3aCkxVgnxDb9LOHjbPRv2C0SdfBMzSraO1GyXWeJ8g2LEwvEqolZZMTmEYIBrp+0nE1ib+bB6omd2HuJFXc/qJzy2dDYSKteGLQX9b9x7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+z4iK2V/Ce5OLI0Xj5MJ2lNYEFG109dhydxB7EHByg=;
 b=Q6hyoEXPN9MVO9hVsvZWK7LmhKn4juEnObavl/lb8mAQxhc5yEyrj18KFDv8dfPpRjaAsA6T3Lpsd+NzrYe4jB9e2AbUasd+GMkMdccyWHjQvvcBV8rIk76vOsfxQ5YEy63eQpu+oauPBavMaMNHVyhgI8dRyF02+HkfOSesn2A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW3PR12MB4443.namprd12.prod.outlook.com (2603:10b6:303:2d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 14:33:13 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::d9b0:364f:335d:bb5b]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::d9b0:364f:335d:bb5b%4]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 14:33:13 +0000
Message-ID: <37847b26-1c1e-48d3-a74e-bd2bcc6e1fda@amd.com>
Date: Mon, 22 Apr 2024 09:33:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "include/linux/suspend.h: Only show pm_pr_dbg
 messages at suspend/resume"
To: xiongxin <xiongxin@kylinos.cn>, rafael@kernel.org, len.brown@intel.com,
 pavel@ucw.cz
Cc: linux-pm@vger.kernel.org
References: <20240422093619.118278-1-xiongxin@kylinos.cn>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240422093619.118278-1-xiongxin@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0232.namprd04.prod.outlook.com
 (2603:10b6:806:127::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW3PR12MB4443:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bfba737-25a3-4a58-d356-08dc62d9241d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NUVNQUdab2Z3ZklXZVZBcDF0K0NtSjd2M1owaVJ6bXhqZXZYWVVwd05RbzN0?=
 =?utf-8?B?NllyTVJZOVlJMHE3c3lwdXdQZy9uc1Rob2lYSVBIVVN0TjRkc091ZEhvMWwx?=
 =?utf-8?B?dFdlME0zd3ZoTjI4ZUFXSEpWWVZJWDIxQ2RzVTFUQTlsTDBEWXhvN0UzdU9t?=
 =?utf-8?B?RUZBWHc0NmhOVU9Zc3ZKbEdTeDVxZ0wzdTIxYmlQaVBaNjAveVFBc3FiSnJi?=
 =?utf-8?B?T211UHJwOGNObHc0S0d6YTl5dG5CMTd4RE1pdGpMMlFhOHMvY3JzWGx6Qm5F?=
 =?utf-8?B?RmxBS3JNMjF1bTErbFdINGtnZnloWjRGaVAwOUMxSU5UOFNXREhkbEw1dnp4?=
 =?utf-8?B?ckRCMnNRUndSTUl5bkZJcEZTZVEzaTAyNHFJYkgxN2MyWUtRMi81TGM0Z3Fy?=
 =?utf-8?B?MUVaYWpBWVVQNXJWM2NMenRiekZKUzRCVUVVUXZ1ZHlsb1NMZ3Z6VmN3MHJF?=
 =?utf-8?B?cnJkK094Nmt6Vjk3azlFMkxvb1BQVWRlei83aEtYdTVNTllKWGdFMmJ6T0Qy?=
 =?utf-8?B?NXFIbERZY3VCMXl2aXpweUp1OEJ0US9QWnp1UzhCU0xhQjh1dVJKRTBHSEtF?=
 =?utf-8?B?aDE5V2dpWTdFWXVTQWFJRlJpb3ZlSG5HcVBZREVxRk9UdGlDLzVGS2syb2pn?=
 =?utf-8?B?T2hrNXAwbkdQdXAvNjN0TjNHcENTV0lMRVBrZjErNTRiZ1EvU1VaVDBkcVdn?=
 =?utf-8?B?eVBXV0JlRjN6UG1BSE5LM0ttOTBaVXpFM3ZTOWUzazdqNFp0ZWlLZVRxcXBm?=
 =?utf-8?B?S3BXRzFCR0I1RUlHVmdQejhxSHphTUtLbFduT0F4R3pPd0lJOUI3OHNZNzdF?=
 =?utf-8?B?TzRxNndQSzFTMWoyakJqK1BlYjMxYXRFTENSWFBJcVlRUk9IaTBzczBlNjVZ?=
 =?utf-8?B?RWtocnpuNWN0d1QvUWhLOW43WWRBYVRyRzhqOGY3WnNleEJGd2RLQWlUejlk?=
 =?utf-8?B?Z3hRUzgzTFUzY2dzQjhHSFA2Mk5IT0dPT1JaQTk4WUVkT0JsVWNvMGpxR3dU?=
 =?utf-8?B?NmhobGRvWUlacWhHQm1ReU5PcDk0VDNINU9kMVFpNThmOFRBdHYvWHFkS1Zk?=
 =?utf-8?B?eVRYcnhEN0hwSGhRV3kwSmNDemhhT2FuTk03YzdRcXpJbkxYRzdMQVdzbzVD?=
 =?utf-8?B?Y0lma2lHeFUrczlCaU9Zek14dDdCYzlnU1MxeVNSVnRpSmlzMklaSFhZV3RH?=
 =?utf-8?B?UlRKbmcxS2RKT3VpZXFUcXFiMkNyL1ZWR0p6NWRrYXRQZVlvM3Q3Tng5c2cw?=
 =?utf-8?B?VWRxVzNPc3NFaEVvMGY3dTlUdlVNQVFOMkpqMElwamtVQlp3bGVIcTYzVm1j?=
 =?utf-8?B?UkxoNCsyNmtXVHJHK25qMStaTzNCc1BibWNDekJ6RDMwWUhqL2hMdnQ5YXJo?=
 =?utf-8?B?VHpjRlZsQU84TlI3Tk1reHh5V0dETU9kRVlvS0xNMkxvdlJlbUh6MFpGMmxM?=
 =?utf-8?B?aldmUUdFVE5lQ0plR21hUzd6OW1iNWF4clVzL1lJUnhCUS9BNHFZSm5RYjFh?=
 =?utf-8?B?YUYycXFZWEptT0hrZmlRT0tzanpTcXY1QTNhUnUwRTJZcTVxcTY4YndlQnlv?=
 =?utf-8?B?UE81Wnl3WUVzTmxYUG1WVUlzT1FlM3RNWC92b21jYUdqZ0V0NWI5TlZRYTBX?=
 =?utf-8?B?ZmQyUGRhWExBMGkxRDJTZnE4bUEwekhUWmFKQ0NDWlAxVDVaTGtIUzBySDRn?=
 =?utf-8?B?bnpERGRUVE9Zb0RRM3BWL3M5THdXUnVIV25rTVpicGVrREZZbXNJYm1nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2R6MmMrUlV0OFZEcVAxKzBuaHJHRVdHbit6d0U1S1pXMjgyaG95QjNwOEdz?=
 =?utf-8?B?dVJDcWl2eWI2OE05bUI2N044SHlmcUduMmRpK25KUjhZV0d3Rng3ZitmeFA3?=
 =?utf-8?B?VXFQN0sxdTdUU3JTamJiTTZJL0hKWkFJZ1BlK1g5c2x5VnVoUFRicE1oWTkw?=
 =?utf-8?B?YmRtMTZPeGlYY2c2eHlWQnFUUkZIcTRhQk5EK2pia0dOMkZ5TFYvSnlrVmxK?=
 =?utf-8?B?RXppNC8zeTZ4SEdDTm5sUFdNak94bzhYS0JtQm1xM2M5ZjBiemxWY2d6eGh0?=
 =?utf-8?B?b0tUaUJ1MWFSLzVzdytsalpIMkhDWkpXd0VvMjJnZDE2bW8zeDB5VmdqNEJw?=
 =?utf-8?B?bU56ZW40WlBQSUtWamRXQlZmOW9GSEp6eEVkWjhDdWdaQlhWWU9QVjM5QmE3?=
 =?utf-8?B?QXlxQ0hvNUx3UnFWd3VId2lCYTFyWFpZMzhQbzk3Qm05bFhBamRKaUdEQUFk?=
 =?utf-8?B?SzhZMDJTb3FqTTlOckNsNCtqYmFvMUFkdEFsTDB4dkJSdGkxNm1wbmFUOXcr?=
 =?utf-8?B?MjRiaytEWUhPU1BRbVRDcUswL1puN0toNDU1Z0hIM0t1WVAxMWFqSXROWkIy?=
 =?utf-8?B?eEpld3Ftayt5ZUV1MmFBWHEvaEtqQ29iK2gvckd2d1MreHBETHJ6OXhheWN5?=
 =?utf-8?B?b0lxSDNvOEdDQk1GeFlaZzVjM0l3c0RsR3RoSGtnRVl3a1dhaEU5Y2lnWDV2?=
 =?utf-8?B?VHVJY3pBRUQrOFJVQm5mWGF1RUhBdmN4c2c4NUp0QVZVa2tQM3M5T0s3SVUv?=
 =?utf-8?B?bU03VmRQbXRna2VIbElUUk9TOEVLYTM1aS9DL3FzRSt1Q1Y2YzNjbWk1d24v?=
 =?utf-8?B?N2hSb1hscHJ1NUJtS2NaaWJxOFREOW1PT0owNzdIam4xS2FyWDdIeGZGcVNk?=
 =?utf-8?B?Y2lpNHRwQlNONmxqYk56Y3V2Kys0bXY1NFRkdEw4SVkvbTI5L1VtU1F3VDUv?=
 =?utf-8?B?cmlVcWsyN3lzOENoNmNWQlYvWE0rV1RBWHl4T1BDaFRXdDlod0p3VUZ4RGZw?=
 =?utf-8?B?TXhIYmhyUHRXc0ZobHFTQURuNUlHK3MranZLdGF4UGVZL01jMm41WldVbm9m?=
 =?utf-8?B?Z1RLeGtWT1ZraDk1QWQwbTBWeWxJaERjaWZmK0VKblVEejNQQjZOeVVES1hM?=
 =?utf-8?B?bHQrb0pmNEIvbS9uUHl5T0NrZWtSYXBoeHNQRnF6MXJ2WDFjUHpXOW5sS0FM?=
 =?utf-8?B?aVlmZm1WcVpjYmNoWTZVSkhoeURURzc3ejdneHk2VlM0enJYaVlFdnVFQzJs?=
 =?utf-8?B?Mi9uZ1AvVUR1cUh4NzhKSWlydFplYzRWcHY5TDlXTnN4M05nNUJaMVBFZ0Iz?=
 =?utf-8?B?clJmWlRISHl6eWJSRkJGS21UbDBHUVd3ZFNxUzZDQSsvV0FTTGxNQlpBZkxw?=
 =?utf-8?B?eWJlekpCbDZYUWZ4czFoTUR2K1lnUjNWcTJxZUp4WlA1L0w3dFJ1SUZ1NzYw?=
 =?utf-8?B?bHdaMysvUlBIS0VHL3JSTzQ4S1VrS2h5SGhlSER5QlRNVXpDV2QvQ08ybmdv?=
 =?utf-8?B?L2VKS0lVS09oeEorc3ZDdWdWeVQ5dHhudlp2bXJIZzdYbVJwQ1pOK0YvT05S?=
 =?utf-8?B?eXNjaHNTU2dQYUpOUWJ0UnZ5YXJPc3V3K2xoTXdTYy8vUWRZZUswbndOYTFB?=
 =?utf-8?B?NXFVU3RnR0wvdHB4NWZOd0FwU2xQQTl5bGZFek05ZWtxeEVmQ1BwQWNDYURK?=
 =?utf-8?B?Yi9KUkdpTDd0Lzh3SVJpZ3BhSzdLMEU0Y250a0ZUNTZBMzExSTlob1hCb0kx?=
 =?utf-8?B?TUNmN1c3Mk1oV1RTalJ3cm03Y2JmeWQ4ZlNjeVB3c1NJdHJkdnRsTWtyc2lj?=
 =?utf-8?B?N0pZNVN5aFFXSGZOWWh4ajhwUjhBTElXWDNpaHRkcDlBOGx4QktDeHF5ejlD?=
 =?utf-8?B?cnFBSWtVVTJiKzYwS09aeEZzRThHRVJwSWpaa253ZzNwZE9xblFEWkh0WlFF?=
 =?utf-8?B?a0trQ3Bwcy85dGI2T1lOR0N1NXNhR2hmNElZUFZCbU9ZMWlqY0ZrcDNicm0r?=
 =?utf-8?B?YzdWaGxrcUMyenFCc3RxalJVSDFWMUgzU283NTlmR3ZFcUg5TjcyNVNYekps?=
 =?utf-8?B?S0t1VW10RllreGp1eCtJSklic3hSbjV6cnZhSWt4MUxUV3lSMmdqTWJWa2pE?=
 =?utf-8?Q?U0WOKkb7u5wl9UT0IGaJv417t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bfba737-25a3-4a58-d356-08dc62d9241d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 14:33:13.5115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IMHn8j2oVvdI9Rau95QA0rrteC+fBARL8Mm2aEJXPuYnJpIvIh0Q2l+vsXn8V4iCfwxgPCzpTS1qJOX/Tfp+jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4443

On 4/22/2024 04:36, xiongxin wrote:
> This reverts commit cdb8c100d8a4b4e31c829724e40b4fdf32977cce.
> 
> In the suspend process, pm_pr_dbg() is called before setting
> pm_suspend_target_state. As a result, this part of the log cannot be
> output.
> 
> pm_pr_dbg() also outputs debug logs for hibernate, but
> pm_suspend_target_state is not set, resulting in hibernate debug logs
> can only be output through dynamic debug, which is very inconvenient.

As an alternative, how about exporting and renaming the variable 
in_suspend in kernel/power/hibernate.c and considering that to tell if 
the hibernate process is going on?

Then it should work just the same as it does at suspend.

> 
> Signed-off-by: xiongxin <xiongxin@kylinos.cn>
> 
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index da6ebca3ff77..415483b89b11 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -503,7 +503,6 @@ static inline void unlock_system_sleep(unsigned int flags) {}
>   #ifdef CONFIG_PM_SLEEP_DEBUG
>   extern bool pm_print_times_enabled;
>   extern bool pm_debug_messages_on;
> -extern bool pm_debug_messages_should_print(void);
>   static inline int pm_dyn_debug_messages_on(void)
>   {
>   #ifdef CONFIG_DYNAMIC_DEBUG
> @@ -517,14 +516,14 @@ static inline int pm_dyn_debug_messages_on(void)
>   #endif
>   #define __pm_pr_dbg(fmt, ...)					\
>   	do {							\
> -		if (pm_debug_messages_should_print())		\
> +		if (pm_debug_messages_on)			\
>   			printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__);	\
>   		else if (pm_dyn_debug_messages_on())		\
>   			pr_debug(fmt, ##__VA_ARGS__);	\
>   	} while (0)
>   #define __pm_deferred_pr_dbg(fmt, ...)				\
>   	do {							\
> -		if (pm_debug_messages_should_print())		\
> +		if (pm_debug_messages_on)			\
>   			printk_deferred(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__);	\
>   	} while (0)
>   #else
> @@ -542,8 +541,7 @@ static inline int pm_dyn_debug_messages_on(void)
>   /**
>    * pm_pr_dbg - print pm sleep debug messages
>    *
> - * If pm_debug_messages_on is enabled and the system is entering/leaving
> - *      suspend, print message.
> + * If pm_debug_messages_on is enabled, print message.
>    * If pm_debug_messages_on is disabled and CONFIG_DYNAMIC_DEBUG is enabled,
>    *	print message only from instances explicitly enabled on dynamic debug's
>    *	control.
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index a9e0693aaf69..aa754241aaa6 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -611,12 +611,6 @@ power_attr_ro(pm_wakeup_irq);
>   
>   bool pm_debug_messages_on __read_mostly;
>   
> -bool pm_debug_messages_should_print(void)
> -{
> -	return pm_debug_messages_on && pm_suspend_target_state != PM_SUSPEND_ON;
> -}
> -EXPORT_SYMBOL_GPL(pm_debug_messages_should_print);
> -
>   static ssize_t pm_debug_messages_show(struct kobject *kobj,
>   				      struct kobj_attribute *attr, char *buf)
>   {


