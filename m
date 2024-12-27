Return-Path: <linux-pm+bounces-19774-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C38F09FD077
	for <lists+linux-pm@lfdr.de>; Fri, 27 Dec 2024 06:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 600453A050E
	for <lists+linux-pm@lfdr.de>; Fri, 27 Dec 2024 05:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3598F35963;
	Fri, 27 Dec 2024 05:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yGSCNxcs"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB74191;
	Fri, 27 Dec 2024 05:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735278592; cv=fail; b=ibTY57XnZsvUtTaS6tUUZ70oD75LxZMlvTDD/xzaM/QF+38gDRInsG4XjTdCqF0uNjeFWBkDUSOi0vj0YlkX/uCOtD5uwE+fNzELSd8RrvRgRExOWuy2B1qXnD79Yhxh32WZYJNEE7neDCsvWJtwqzRjB7ldhNr8ms1aPNPRf6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735278592; c=relaxed/simple;
	bh=th3DZ9aq6TPvLYBDw5gqcDguRyP68jMzHNMiyZslS+I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HGvW5GZcq21j2M5rMTw1j5rf1Qqh50gygkY7kYS4OO2BF5jsZwNyVGmWDr5laZAgKAwEYmrQp1/y2Z2xl8OjfOA5T8sycNX7oy+eONcvVswON+rN8Hex0TjLmnyq4FB3S/GBlQ5nIU/wQlbLS6zrZWvUNMf486Z62Bj3zelMWUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yGSCNxcs; arc=fail smtp.client-ip=40.107.237.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=imUo0Z7ne4IHkRCf6L7aZ6Pa6fOP1oe9N60grIv6rS3yQKUpXzQDsTptkiAhh+HTpLtUxian7kNh9eqxZ3dbFVKVRYEj2GBJXl5tppV6lQWqiGtR2VT1lLTK5nIK/XWHL2k4AWuPzSAH8JUWq9XiU4AVil9DJxk2YUcseT2Dk63uzOFVdu5I07EQAhncs0ricRUAQ/S0N2PrPQzMLVkGEKlyT4FsBsANRYhI6nSphZwsn0eBW4L+ff0JTR2XLmmLRgafXqN0eyQZEcBMAIaDOt0wi1j5B3KXT/q9XW24CjmTV0jRVGI2VgtP85VBhpoQnMufpAwPJ6C0BXy2RElS8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srhJXUWGBtZ1Jx5pKggtamTREjuu5rei8In86OsrpnQ=;
 b=wEs7rvstcVQywVdqvbtKw6Cr1ax3+J/OYje4nSMEQS1F+OOfpKzfNY9XyrQL9462pJMValn1b+inrZh5wavNj+aQxgKQ8ugmdcAbo3995UcE58JpPspwZmd3BKokaE0TZcuUBK8T0tKppHoxVPE1izsQFxn6lXWGLwcLor0W+TfuylE4wGRXgqq60oP0/katYbALackZkrj7wMyOp5p0G3f32yEhnwSfoa3l/EGp3nMNTBfwPkTOYTO48FCG6n9WJA8DGGxsVKtz+5ZpGnUHVnNasbj1qgeGpBs7yXP62HVlOiDiT1GkgFD61c4X/op3rCPuzq/RX1NkUsPOUdEHtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srhJXUWGBtZ1Jx5pKggtamTREjuu5rei8In86OsrpnQ=;
 b=yGSCNxcsandE8U1OHn9/B8+7ommhTwWqQDNhwz1jW+aNm+vWeRAAlYgZxGw4K5wv1inpsDwb2So8VCR4cYAKCWgfsmHSJhwKuBZKwWkpnbN1Snlw26RJYTyJUZh4+ukNoeb7qIF3dfLGUuRo9HlLaAFcIxhLTHijWH0vVsA0uA8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV8PR12MB9207.namprd12.prod.outlook.com (2603:10b6:408:187::15)
 by DM6PR12MB4235.namprd12.prod.outlook.com (2603:10b6:5:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.21; Fri, 27 Dec
 2024 05:49:43 +0000
Received: from LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9]) by LV8PR12MB9207.namprd12.prod.outlook.com
 ([fe80::3a37:4bf4:a21:87d9%3]) with mapi id 15.20.8293.000; Fri, 27 Dec 2024
 05:49:43 +0000
Message-ID: <057d8f01-c1ee-428c-8c19-80edcf9017bd@amd.com>
Date: Fri, 27 Dec 2024 11:19:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq/amd-pstate: Refactor max frequency calculation
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Naresh Solanki <naresh.solanki@9elements.com>
Cc: Huang Rui <ray.huang@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241219192144.2744863-1-naresh.solanki@9elements.com>
 <Z2ULvwb1hePiDmwj@BLRRASHENOY1.amd.com>
Content-Language: en-US
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
In-Reply-To: <Z2ULvwb1hePiDmwj@BLRRASHENOY1.amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PEPF000067F6.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::37) To LV8PR12MB9207.namprd12.prod.outlook.com
 (2603:10b6:408:187::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9207:EE_|DM6PR12MB4235:EE_
X-MS-Office365-Filtering-Correlation-Id: cb7650d0-c33d-478c-b662-08dd263a42d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3FmMG5TdjlGa1hEMWF4QkVBSjlCRCtwSzFsLzl5dENoRU9IQmRXMGVLcU8y?=
 =?utf-8?B?dDBtMFRwck90cldrRnBaamRCZ1JMNW1sZUJudlNoWmw5MkpwUnl4emJDMDE5?=
 =?utf-8?B?R3lSZW0rcFJRcmMxSmJPMTNJTGJCUDA4c2JINTJ2U3VnbHhxeklDZlNvY0Qw?=
 =?utf-8?B?MHZoNTA0OUhnd0xNTGp6OGRlRm9qSnNKL0hVYUFiWXJ6YVNYZWhqd3FQY01L?=
 =?utf-8?B?Vm9LOWdHckRlVW0zSDljdlRvVGpMcUJxMEl2dWlIK2lxeGJyTWtuSmpmem40?=
 =?utf-8?B?TjlKNm9MUzdTdkZ4U3pUQ2laZFNScnRUMUprOUx0UE9COGNLN2o0MzlQYlFS?=
 =?utf-8?B?WHBmZHc4d0R3eEw0dy9uNTZSalF1UHp0RmdMakZVYXlJdnVZSkFVRGRwMDRL?=
 =?utf-8?B?MnRaMUNSZzRVV0FxbEVKOUoyVWZMOWgrVCtTdkpDbEptdVBZalQrM2lCaE1z?=
 =?utf-8?B?RC9PM09RSXNWVU5lbTA3ZWRFOHVpdEY1dzVOcDh2SHF5N3ZkblBHQy9OclNO?=
 =?utf-8?B?dmpCZXRQWWFKL3dMbWlmS1lwS3I2OTQyeXFzYnorYnI4UXBuWE1QRURwY2p4?=
 =?utf-8?B?RTFoS3dIZmI1R1ljd2xnYVVlVE9xb01NUjR5T290cXlKaGgzdlhzbjhUT1hn?=
 =?utf-8?B?WUpCOStxMlI3SVRmYjc1VTRrNk5pQU5Sb2tENWZXT2h2dXRDYnRzd2JSTVRj?=
 =?utf-8?B?OWRhcXNXanJqblBvbDhKRDVNd1hlWmZKVVBQd2lnNnJXRUFHd29BemZERU55?=
 =?utf-8?B?S1d4NDNMNDVsZVBsOFdKcjlwNEt4Rk1ZQ0g5NVZTaFE4UitjVnR6R2tuRGxy?=
 =?utf-8?B?YitrVURKSHlHYU0rRWZ1K2l0R2xSNEhUWWs0NFNMNnQ4cnBoTmtCeXN0UWg0?=
 =?utf-8?B?eVlCcFhvRFU1OThPWVpkdFpPcDZrZTVYdXNLR0ovalZKMmlpTzVjSEVUaEo5?=
 =?utf-8?B?K3dpUktveVJmSmpoelpYdE1teVl6YmZtSGpJbklId052VUpwL3h1V0RVczJR?=
 =?utf-8?B?R0hLc2lkQWlnVDdHRXR2S2M3b1FtOHJwbGcwMnRpZFUvUEZUYlJWdkxtODUv?=
 =?utf-8?B?NDNlaW9nOWVpTmYyNVk4UmhpVWdMYWNMOHlMTTh1a0JrN1dlR2VaMStoVjNH?=
 =?utf-8?B?bVB0RmVMbmxyNWtwOWhMYS9jR05EVFVyTmF1aEdBWUlNa2tuVG9uZG5NZGxI?=
 =?utf-8?B?TkNnU2FpTkNSSUxJQkUydEYxTWVWdm10NmxsNS9SSUxkY0k1aTR2QzNZRXQ4?=
 =?utf-8?B?R2RQM3RwYmpTQ2c0aEx0NVBQdVFrTTZVMXNXUTIvUVZsaGRLbHNBb0FRVlVS?=
 =?utf-8?B?VXpqaTFEVFNZWVBOY0VlNWh4Q1hDV21RVG5mQTlSbnhaQ0hsNzNiQm1VOHVB?=
 =?utf-8?B?VVdtaDEvTTFNbXNQNHN5RVBoRGV1eUl3cS85SzlDOFd1V2dzWmVFcnVMOWd4?=
 =?utf-8?B?Vkk2VWN4MWpuczRNdWdDajBacThIcy9GbXd3NERUamFRdHY1ZGV5UjZlVlZ4?=
 =?utf-8?B?cDE5czhYQ1FKZk1pckNlemdCalY4TzVJa2MvMVdhTC84YXVzWjhkbzk0KzB2?=
 =?utf-8?B?Rjl5cVN4R0I4VEM4Z05iUFd3TTE5OTl2cmhyWjZYWnh1MEEwQ1lxSDY4YXA1?=
 =?utf-8?B?MGN1WEZqeHQ1ZTlTdjFSNkc5YmhId1dhUFNLT3lLSnFQakk3V2RMd2MwZ3RT?=
 =?utf-8?B?TTgzZks4QnVJVnpIblhoMWRGMVdJUTE1bW1kZmh3NDFMSmRraE8ybDJFWHNW?=
 =?utf-8?B?aVJNdnBqcmdRUHc0bUtBNW8yaUlGYTZDY1RWQ0FyK09lV2p6dFIyZ2pzSWgr?=
 =?utf-8?B?Mk5SOW9aaW9TbDVEYkJlQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dG90TXl5c05mYUZabE9lcm1ZSGQxK1Nxa2pqVVJuU3ltclp0czZUSmE5a25Y?=
 =?utf-8?B?MHFvZE5nVmMwQm0xa1BBTmU0eDBrcG8vVXV6dHl5Um0reUtUKzQ2clJmK0lS?=
 =?utf-8?B?ckFrdm1zSVBuNWhQYkNzUE9jbFdHUWF2Rm04UVNrWHhMbC9hT0E0dU9KZ0NB?=
 =?utf-8?B?cjlGUDBlQnYrSFlkQUNYL3pqMStRSWcrTHNCa0VoMmlpaVo0RTdhVnE1aENk?=
 =?utf-8?B?Njg5dXJ3VFQ3WjBGSHd3WXo3U2lzK2gzZVZIdE1wV1JVWXMrR2NMNm0zdGox?=
 =?utf-8?B?VDlZazdIWm5sRFBTeG0zenFwUDEwSDRMNEI4czgvd2QwOXFVRU1GaElvekpW?=
 =?utf-8?B?Z2tIMzRVaVVLUzZhRyswQk1lWE1USnZQR3VRdTFkaFIrOTgwWmxjQnE1RnZC?=
 =?utf-8?B?ejNzNUh1TFg5UTJYbDlRR2oxZllQR0RpMDBHSGVXZFhUM1l2ZlN0c1doL3c5?=
 =?utf-8?B?RkxpTkZzL1VNY1N0Ky8yYjM5K2RpY1RFVUNzVmJJYVdWYldQbnk1Q3V6RndB?=
 =?utf-8?B?RSt4NnllTllVbkRkaFFmWW1uUkFDSnpoYjBCc1VPN1VkWEVRdllxcW1GSXV4?=
 =?utf-8?B?ZWVWVnJpaTdEOEliNDVVQ2NyQWVmL0t6M0tnb0VjWHZNSEx0di9vSFRGbmtn?=
 =?utf-8?B?a1RiQmY0YjhPZExZaU9Qc2JFbWdrRnErRWZxV1Z2RDl4UjdudDZWL1ZwblFv?=
 =?utf-8?B?RGhhbERsWnpYNWFvTjBYZjJPYzdLNVhjVHdZQS82alRSOE5VcUVSZmp0RkdE?=
 =?utf-8?B?OE1nZ0IvcHNvNEdPM1ZXNFFzU1hvQTFjTTIvci8zRHNlVU9qRVpNNHpuZUpT?=
 =?utf-8?B?cURiRHp1MExpTllsamVPM1V6YzhPaUtPVHdQaVFFMEdVS0VUcUJJMkN5RUJV?=
 =?utf-8?B?czZzT0Y2NTMxdjJHZHFZREk2bHEyMHNzKzFFSllvb1lGY0lCckEzQ2VPenZZ?=
 =?utf-8?B?eVJXTlpMb2loSXVCSlQvR3dvazM3Z3VEMmlJYjdPSWtGSW8rSVArTi9BTXFx?=
 =?utf-8?B?VHh1ZzJLNEZ0UGZqQ29PNmJNV2VjeGkwTU4zVEUva3p1dDI0d2RXK0JJTDdp?=
 =?utf-8?B?NWVNYkZ4T09xMzJjL2Q3UDRIQ3hKdWU4Um9WdmdtSkgya0k1MkpHd0dlbndW?=
 =?utf-8?B?Z3ZleEZGNlBxMGVibFlNa2VVZHVqWHZabE9sdG9adG44UHBhYmd2dG9IaHhi?=
 =?utf-8?B?WlNmMVBnbGtCVXpoTWpFOG9KcmhJY0p1QmdCQ0NkdzJVSE12bnNXSUpTVHpM?=
 =?utf-8?B?b2hwMENtN1RFNjZIWlRGdVZrd1FITWU5amE3bGttYnNBWE9RTDdFbXV5NmRl?=
 =?utf-8?B?UDNZbHQvRFNiaXI2Rktud3ZpOVJNZm5ETThBQ3Y4aFhBVUxhbkEzWnR4SkpQ?=
 =?utf-8?B?MlZEeG15VGtUWm9La1BPNjErdGlMNHBhV2JHRVdyTDZ4Z3c0YnlRNytTazU5?=
 =?utf-8?B?d1VSS3JJTnVIWHZiY2Iva1RNNHdNZnU5eEJSdFVMek5WVmhvL0lqcmVsNWJ4?=
 =?utf-8?B?UDlCZmpHWUxRcnlXWFplQ0dhVEk3QVhpd3lKVkZMODYveWpQMUUzd2s2NHVM?=
 =?utf-8?B?QTg5dE5UUFBzdU9BQ1BEQVlURmw5Wi9hdDM4Q2c5NG9qMlo2UkNPRE45VlRv?=
 =?utf-8?B?MGFJNTVDUXZBMHpPQXkybVpvbk5pMzUvRVJtWnQrTm8yL1Qxekl0Tk92MGRk?=
 =?utf-8?B?RGpyRmRBeStZNGw1NndjUUM4ekNDQ3RyMXZxR2RtWmZic3ljYzNMekV4ekEw?=
 =?utf-8?B?cU5vdS9XdVZoWDErci9GNGQ1Q2k3YVoyZDZ1SjhVazlvTm53dVpEVE50L2RO?=
 =?utf-8?B?QnJrNzZwb0ttM01CTWF5TTBvMm9nOE5DWXpZVXhueVFhUm5lNjIxNDlGcEpq?=
 =?utf-8?B?RW0xRFA0alZDUFZKMHRsUVFpbmkvbUhLRE9hWG1YSnFPc0RzMFJwNm1xanZh?=
 =?utf-8?B?SG5oUEUwc3FpOTJZSHRBZ1FFR2NiQVVPSHl4UzdZR1grcmdMMit6dVFJUTFJ?=
 =?utf-8?B?enE4WVhCa3BSbDNoOEtuZGYvUXlRTEJQcnFOTWhvYVpwSkREdytYNGNHV2Zv?=
 =?utf-8?B?M3FIalhreGhHckYrZElhV1NFODdIRW9YSjZ0K0RnZ1haemM3YkJ0Z1JtVEtO?=
 =?utf-8?Q?p2/frkdNOV+Lay57x4bZBk27r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb7650d0-c33d-478c-b662-08dd263a42d6
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2024 05:49:43.1411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cH+t8CC9i7mN9JrKEoMDTKm9NCE7twXzGWyqETCjRhmsf48L3zRa3i6AXXSDIcJKJa9hR8BYhHo/IJPUJ6GxCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4235

On 12/20/2024 11:46 AM, Gautham R. Shenoy wrote:
> On Fri, Dec 20, 2024 at 12:51:43AM +0530, Naresh Solanki wrote:
>> The previous approach introduced roundoff errors during division when
>> calculating the boost ratio. This, in turn, affected the maximum
>> frequency calculation, often resulting in reporting lower frequency
>> values.
>>
>> For example, on the Glinda SoC based board with the following
>> parameters:
>>
>> max_perf = 208
>> nominal_perf = 100
>> nominal_freq = 2600 MHz
>>
>> The Linux kernel previously calculated the frequency as:
>> freq = ((max_perf * 1024 / nominal_perf) * nominal_freq) / 1024
>> freq = 5405 MHz  // Integer arithmetic.
>>
>> With the updated formula:
>> freq = (max_perf * nominal_freq) / nominal_perf
>> freq = 5408 MHz
>>
>> This change ensures more accurate frequency calculations by eliminating
>> unnecessary shifts and divisions, thereby improving precision.
>>
>> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
>>
>> Changes in V2:
>> 1. Rebase on superm1.git/linux-next branch
>> ---
>>  drivers/cpufreq/amd-pstate.c | 9 ++++-----
>>  1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index d7b1de97727a..02a851f93fd6 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -908,9 +908,9 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>>  {
>>  	int ret;
>>  	u32 min_freq, max_freq;
>> -	u32 nominal_perf, nominal_freq;
>> +	u32 highest_perf, nominal_perf, nominal_freq;
>>  	u32 lowest_nonlinear_perf, lowest_nonlinear_freq;
>> -	u32 boost_ratio, lowest_nonlinear_ratio;
>> +	u32 lowest_nonlinear_ratio;
>>  	struct cppc_perf_caps cppc_perf;
>>  
>>  	ret = cppc_get_perf_caps(cpudata->cpu, &cppc_perf);
>> @@ -927,10 +927,9 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
>>  	else
>>  		nominal_freq = cppc_perf.nominal_freq;
>>  
>> +	highest_perf = READ_ONCE(cpudata->highest_perf);
>>  	nominal_perf = READ_ONCE(cpudata->nominal_perf);
>> -
>> -	boost_ratio = div_u64(cpudata->highest_perf << SCHED_CAPACITY_SHIFT, nominal_perf);
>> -	max_freq = (nominal_freq * boost_ratio >> SCHED_CAPACITY_SHIFT);
> 
> 
> The patch looks obviously correct to me. And the suggested method
> would work because nominal_freq is larger than the nominal_perf and
> thus scaling is really necessary.
> 
> Besides, before this patch, there was another obvious issue that we
> were computing the boost_ratio when we should have been computing the
> ratio of nominal_freq and nominal_perf and then multiplied this with
> max_perf without losing precision.
> 
> This is just one instance, but it can be generalized so that any 
> freq --> perf and perf --> freq can be computed without loss of precision.
> 
> We need two things:
> 
> 1. The mult_factor should be computed as a ratio of nominal_freq and
> nominal_perf (and vice versa) as they are always known.
> 
> 2. Use DIV64_U64_ROUND_UP instead of div64() which rounds up instead of rounding down.
> 
> So if we have the shifts defined as follows:
> 
> #define PERF_SHIFT   12UL //shift used for freq --> perf conversion
> #define FREQ_SHIFT   10UL //shift used for perf --> freq conversion.
> 
> And in amd_pstate_init_freq() code, we initialize the two global variables:
> 
> u64 freq_mult_factor = DIV64_U64_ROUND_UP(nominal_freq  << FREQ_SHIFT, nominal_perf);
> u64 perf_mult_factor = DIV64_U64_ROUND_UP(nominal_perf  << PERF_SHIFT, nominal_freq);

I like this approach, but can we assume the nominal freq/perf values to be the same for 
all CPUs, otherwise we would need to make these factors a per-CPU or per-domain(where 
all CPUs within a "domain" have the same nominal_freq/perf). At which point the benefit 
of caching these ratios might diminish.

Thoughts, Gautham, Mario?

Thanks,
Dhananjay

> 
> .. and have a couple of helper functions:
> 
> /* perf to freq conversion */
> static inline unsigned int perf_to_freq(perf)
> {
> 	return (perf * freq_mult_factor) >> FREQ_SHIFT;
> }
> 
> 
> /* freq to perf conversion */
> static inline unsigned int freq_to_perf(freq)
> {
> 	return (freq * perf_mult_factor) >> PERF_SHIFT;
> }
> 
> 
>> +	max_freq = div_u64((u64)highest_perf * nominal_freq, nominal_perf);
> 
> Then,
>         max_freq = perf_to_freq(highest_perf);
> 	min_freq = perf_to_freq(lowest_non_linear_perf);
> 
> 
> and so on.
> 
> This should just work.
> 
> 
>>  
>>  	lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
>>  	lowest_nonlinear_ratio = div_u64(lowest_nonlinear_perf << SCHED_CAPACITY_SHIFT,
>> -- 
> 
> --
> Thanks and Regards
> gautham.


