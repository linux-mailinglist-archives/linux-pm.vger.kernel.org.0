Return-Path: <linux-pm+bounces-19457-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45ED49F6E67
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 20:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4D791894108
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 19:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBCB1FAC55;
	Wed, 18 Dec 2024 19:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P/WEm0Nh"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEE01FBC96
	for <linux-pm@vger.kernel.org>; Wed, 18 Dec 2024 19:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734550987; cv=fail; b=uoLrKvscwX5oe5mXM+CxTnfMF6JRNcwzJSRWMPJoM2wh0tZ0pfecWmHD1bHra93x6hcdQxpV9X84gvgijjIVA2TgrQtDbBuhFvUDO67ACCE/Zbv7sZMy6bvEmnL9G+CEqnq9fr0QDCP6vyINwfILD5McznXvv3oXiDEUiIuMfFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734550987; c=relaxed/simple;
	bh=spLYU2EsyprhUfmEZQ6UngJYA3HmSa52rMfAuOoArhM=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=nAsdAzENCPeNF4ZIEJB4TLOsq6EDLJLfo6uT1RlCxdzkQIZSOqr272x3CH+U5nF21HAHo8KlVv9orCZ+KbOl6wlO+MudIIGXlUp4fG3g7CGC9pBz7CcAJhQCAqr1HLmIPlDLvjnKsyxgEXIDUELKWGWvTDjlswtCyL4JS4GfkDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P/WEm0Nh; arc=fail smtp.client-ip=40.107.92.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tl2i8qeaU+/Rjo9zLNlkP6OHBzp2xythi6h+f2C/1YuuxIfIBqQWnjuMaN+pmAQsvXAvvWyqgE5rbTXXtRjAnTEMWEK2LXx3sRDZRoNLJ9L2P+w+yRvhbGq0tpTEuGlPXdzk3B4/RzNYgg0SziU5zOvvRIdRYy1Pi30OPj+q1UN0mrhdJCrX2uXsD/J/srFNYcAPhSdneEodvUMStFHppmgV8OeSPvT+GDbJnWMic5zMZXS/XfBHeoBJ7glkwB5deNlhdTdJrt9OGdrImMvoMLeffIeAnNEN/b/JLtRQc+YANUqAndx2spayrXuAux2NmHKsj1yUkCbfW5/Ef0pgVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSlZQnFMBUY85EcIfDK+kxvwidv7+uOWDaBOY+jdqUc=;
 b=HXIc9rGCrEGrPWpWG3Cv8PGmfCKrtYXWU5+Jwg2UjJYlTt927/73fk0osvtT2pGsedK/nleI6V1EiFqH2GtsKv9M+M1RgtFpN0EStATupbWVjoNrHnT+9MdeNGWBfkcJaPkBAiYG+E9oJbuTwOY2APTiYc6iBdUKbrMSrd/WKM6gnkgZ1CGbQ09GUKXz0RTypVRnRGpO12HS2Ief6TWKTArW2A0lbml7yvnKmkSY5pEIz8obz3hiRMLrZTaPt28x9BDRy2ChE5rsV9gKHpMJ6kMqLojoanjLpdFk+g+YTA9KDogjt7Nj6miiu7CAI+T/qQQiW6KJlbJQJOUgIO4HQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSlZQnFMBUY85EcIfDK+kxvwidv7+uOWDaBOY+jdqUc=;
 b=P/WEm0NhiblC3JBSmCy/Or48WmKWHa6c7+F/xY7kOSSLePPxyLihr63UgSMCjXFB3ZMZXSFQaSj6jcS/ym5R33HljkIuiY/iZ4oNPJ8psf3guxU1R3Ovia7nBLnKF47BUno3Ad2XJzpaTFassMlqEw5wrtZnS8gVI3wT54928O4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB5604.namprd12.prod.outlook.com (2603:10b6:303:18d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 19:43:02 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8272.013; Wed, 18 Dec 2024
 19:43:02 +0000
Message-ID: <ba6ab96f-89bb-4bb3-a295-a1f41042eb15@amd.com>
Date: Wed, 18 Dec 2024 13:43:00 -0600
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: [GIT PULL] amd-pstate content for 6.14 (12/18/24)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0016.namprd11.prod.outlook.com
 (2603:10b6:806:d3::21) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW4PR12MB5604:EE_
X-MS-Office365-Filtering-Correlation-Id: 23283a16-d5a7-4d58-d789-08dd1f9c2f00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekZ4QWZlSWZFajlJSVR3d3JpQTR3VFgrcGRGd0tGMUgwem1qY1Zld0RENFJT?=
 =?utf-8?B?OVVPbjQraE45dG0yRkluWGMrY3YwbXRRLzJ1aVpLcktUMGJuQUdXM21qeHRP?=
 =?utf-8?B?Z0NMSStzKzgwazRsRVJvSlRTSE5FS1g5RUJIZGNUSHE2MnhSalordzVSaiti?=
 =?utf-8?B?UGVUVzhSM1dBa0tmQUYwdjN5cVNITG94K3YyMFIrVjNqUWdzV1ArSFI1YUIz?=
 =?utf-8?B?ZU5mbUwxYXl0T3pUcXVPZTZUbjRrN3JSM1NlNnFHbXMxTnpNSVlIZHBaMFlj?=
 =?utf-8?B?NDBKTDZPM01rMGRGcEZMOXZORGVkc083bHBBY1NlZXBlRkhYMUMrUjE4WDVW?=
 =?utf-8?B?TmhwZ3ZaNDNPblJSTDVMaWZ1L0E1SjV1c1dlOFBXaUtrS0t3NlFDRGpobUNp?=
 =?utf-8?B?RENVTWhiMGZ1ZTZKSUZ3TGJ3akllZzRGdVM2TmplMVM5bE4zVDY2TG9VM1cx?=
 =?utf-8?B?b1VIR1N6OXFmc093RGM4OTdVK3FCeEluNWZtRmZUWUpkeEFHZE4yRURmUnJa?=
 =?utf-8?B?bnU0VnN0a3QzVTZMSmQyS1ZHY2VDTnVHamtwT3NUU3BGYUJMZms2bldJT1pp?=
 =?utf-8?B?MHFwcGY0WmRpMzNvNnltYzdPelNsZ1BqOUlBSGFGbXFkeGt2elVBK3VJbmEx?=
 =?utf-8?B?R2lzZnpYNU5vZDl1VDh0Vmp5NTc2OFdsWGNucDVmZXpJeWdjSk9Xb09wQUF3?=
 =?utf-8?B?OWw0MTRSR1lFcUZhQXQ4VlErNXc2enlvZ2dMSkJJM0Rjb0svd1hHbEFraTFG?=
 =?utf-8?B?bXhSakU0M2xZSzE5TUxyWUV2ajZsUkFLSEswb2c4Vzlobk9ZcHdCUGtSUzZm?=
 =?utf-8?B?N1czdmozSFVvNFhTRC95WDByajlCSWo0STdRSm1RTEhBdkZuQ1Q4U3paS2pp?=
 =?utf-8?B?Ym0zYmp5T0tiaFp2Z0pyZk16TlNGdmUxTnpuclRCQmhlSkZwd1RNTnNCa2x5?=
 =?utf-8?B?K2RxVmE1QVM1Z3lIckNadGRRSFVzcmg2azI0aXp5UG5OL3pKR0JFNmJlUERr?=
 =?utf-8?B?OVI4b2JYbDdVelJzVS9yN2NkY2wvakR2WHBsRkZid0srM28wOTB5N0NGSTZn?=
 =?utf-8?B?Y0J4NTB5bUlZVEZsR2NtVk9YaEdCUEl6U2tNd1lyVDR5UFBUVUlRSkFkNEpR?=
 =?utf-8?B?eGpLUnFWUkhhcTFwcWNsUFNxQ1BSWDN5N1NSY2lLTFRkOFVYUmdYaDZhOFVr?=
 =?utf-8?B?Mkk3RC9lT05acDBZT1pDdWl4NmxSakd5bmMyTW9od2ZBTG1LbnB1b2xvK3VH?=
 =?utf-8?B?cjFvWWJGVFpzMGVkOU9tcmhpNjRxUFFsc2ZGQ3QxQngvcUxaWFhvcUViYWJm?=
 =?utf-8?B?VzZ4UWllY2l2NkM0T2JrTFFQbGpNRWw1aDgzaXN0VEYwcTY1TkgrUmw3R3V1?=
 =?utf-8?B?cXBTR0gvZzdCOC9XblhwY2U0NlJrNVQxYXFZZTdsNGVpL1dUWVpxQXVXaEVx?=
 =?utf-8?B?bi94VnJxVWZLV1RiSFlOS0Q0V0pDMzYzNjBNMkg2V05hSTJuSzVrUllaYWYy?=
 =?utf-8?B?ODJlM3ZxYlBXbjhGc1NPT1ZPODNkYkwzVkZUazMwQ3pxMlhqeHlLSUNQalQx?=
 =?utf-8?B?WDUyYlFSaWNyR050R0lGc0o1eVV6NXJ5T3BRYTl6OWtuSEZVOHJpOENmWVp2?=
 =?utf-8?B?YTA4OUNRdDRVRmN3cE5SU25mdjZkc0NOQ3A4blNMclcxY2FhY2xEMjllUHBa?=
 =?utf-8?B?N1VjZ2MvYzNmZzl2Ny8yaVN5ZUxVNWpWbDA1RW9nQzJvOG1tYURZeGF5bS8w?=
 =?utf-8?B?RHBWVDRQamx5UktuTjFwcUdNK0twelhEQURVY3IxdktzTEUzNkxER3lUUEgw?=
 =?utf-8?B?L2ZrWEsxeWFHOHdtMDJadz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTQ2RlBGUFBkeFM0V3JuQnB6TEpuMGdUQi9KcWlDcHNLYmhqWFRkcHM4eWNK?=
 =?utf-8?B?NEFjdmhlMTlIN1A4cWFPeUkyclBJdnVWakhRV01YdHhUMkpud3BXYXBKZU5h?=
 =?utf-8?B?dUZxbEgyN1hRMHdIaVg4Z2xUbC9LQitKYkQ2TVFUeDRDZ2s2NTlwR2VsU3hI?=
 =?utf-8?B?cmZlN0ZIUW5TTTBVNlprT2JWSjlRemw3RFJBRkNCYlJxZVM3ZExOTzA4bGRS?=
 =?utf-8?B?WUIvbTV5QUwweGludUNWaUVUM0FIdXNDbXJuT2hkWVdvRmptYVRSRUFUNVJ6?=
 =?utf-8?B?enNQTXdWZXYwOU1Jd0JjNkU1QVd0TzVOc1Q0V21pVEU4TjFaKy95dWh0T3Jk?=
 =?utf-8?B?dHlSRko0eDU5YmF1K2QwYzB0M01ORFJWQ25FSzFkeThHYjd0U3N6R2J0MzFZ?=
 =?utf-8?B?Z2ZGUU41b0EvTkp5RWZiODF1bE1OTkRrVWtRZy9qblF2OXpCTzBqWXV5NllV?=
 =?utf-8?B?dDhCYldkYjJ0TklvazJrSHIyYnhZd2NJWThkQ1V4SmYwcFNIb3RlTGRTbnlk?=
 =?utf-8?B?N2wxYmtVUVFjM3VvUmY1YVVYY0VUQlJMSnh2ZHFtM3NZWmdLMVM4UWtOWE5z?=
 =?utf-8?B?d1NpT0xsNjhnbENsUmdsOG04N3BkT2pmL3lWWmdTWWtnVGlkb2RKV3ZMUGda?=
 =?utf-8?B?ZUZZVHpRSklTZGR6YmVzUjhzRG9vbjJuS0s4cTFmRlhHY1VieWFwdWJuRE80?=
 =?utf-8?B?ZmdDU3lJRVdVT2ZaZXRWODZYT3o4RXlMQzJjUkFmU0Jxc0lManc3TE8zWTBj?=
 =?utf-8?B?SnJjL0ROeVZCbkNVY2VCbGdoYUZhYmZMTU1Kanp0bTdwTHpSTmgxR0E3VTdJ?=
 =?utf-8?B?SWRQYlFuVHF3bWRyemcyUUNUY3EvWkJucDhmcnNhYXZCSGlWWWFtTStMVzEz?=
 =?utf-8?B?d2Y2MXhqdy9wcXRBWHhJSGRKWm5VN1psaGg0cEVrQStTSFN2QmJqTngzSU4w?=
 =?utf-8?B?WHN3endTcEpacU9lWFY2TjA5eVp2ZDUxb1RnV2FEUUNZMXFsRGRWYUFleFVI?=
 =?utf-8?B?d2l3YWs3WGFlVUFINW1KWTR5RlNKbHJmc2NocVZseHBGVlRYYXZ1MElYYnhp?=
 =?utf-8?B?YTRObm1GUEVyb0VzbVVGUDkxbTU3TEp6c2FjckpxNnRCZFRKVHJ2QWNjZ1k0?=
 =?utf-8?B?bnNqeTVLZ0l5WDdyNWd1cDU0ZW1CVTdJMVJUMlU5cEsra0tqVVBYK2hqT2xl?=
 =?utf-8?B?Nmk5MWFXTU50MmJhbkd0UUx4bzc5bzlDcEQ3OE5XbWpxa3BXN3lIUFQ4OEd0?=
 =?utf-8?B?d01CVUYzblF3ekpuNDdTb3pkWWMwWHN0anNpUzlkMWxyZHhpd0paUU81L25O?=
 =?utf-8?B?ckZNY2RicmVncm1rWDhCWXVaQ0l6VGdtVHRmMU82U2FZazJpYTVKVEJUeDlh?=
 =?utf-8?B?KzlCMzI5bDRhaVExWDNCQWtDVkFzL0k1cUVaVDE0ZnJHVy92QkNFYkwyejB2?=
 =?utf-8?B?RXRDUnNnVW4yU0tMbFFUZTBCVTc1UlYrY2czQ0V0RTlpck5OV044QzhNN1Vi?=
 =?utf-8?B?ejdGdVNUcU5mcEpZQjM2aWFLeStTYVM5NjYrZjNielBGdFJ6dkp1SUY1dXYy?=
 =?utf-8?B?OGZzR3ZEZmZIWU9KM0hIRjNRTHBmVDZ4dVlsNVBXVzZNdGl3T2ZRTHJZaHB3?=
 =?utf-8?B?eHY5UTRtNmNDUC9hbmlmYVBRV3RCYzEwUXBmR09YTmI0dE9mS1RTVFh3V1Nw?=
 =?utf-8?B?eEVoMTVGanZtWWR0QkgzVUFyOVlaMkUzVHFYajRKN1lTeXJSRW5RUENjbjdP?=
 =?utf-8?B?UnhoRkJGNUkzdWxyV09nam05dWc0K0dEMktMRldOQnBrUEpicXlVZTR5Z0R4?=
 =?utf-8?B?UEZQeExKSEUrL0tsQVo5c29nNURjL2NTNG1UcWF0RXpab2cwTlhhT0hjTjVz?=
 =?utf-8?B?RWxHMGhUNUV6OW5JYUxHc0QyWkRZM0x0cW5kMnlYcEUxU1JzVDV2bzRkbk1z?=
 =?utf-8?B?aDNxdkhMMmd5Q3JaNE4yYjBKUWZLVkh6Y2l6ZFdTc3k1bHd0QnZWdFJEbWdv?=
 =?utf-8?B?UElOV3lDWjMvNHNFYmt0MHgyUnQ2aFJxdzg0RXVpVEhucjNLaStlQzhHQ0ps?=
 =?utf-8?B?Nm8yWEhGU2hRN1JFUGFyMk5vNHdyckt5RlZSclNhVk9LOG50cmtROG9EU0Jl?=
 =?utf-8?Q?TddijBEfZSJdO7Iodcg2ixXTZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23283a16-d5a7-4d58-d789-08dd1f9c2f00
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 19:43:02.1378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u1DztqSZ86ETpuyoaz+wKfvlb4qeb8j7EpiQ1XQykErWpuCpShy7bGkIxVzI+vAyY5aWFJkfQ/P6f5cmtvZZxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5604

Hello,

The following changes since commit fac04efc5c793dccbd07e2d59af9f90b7fc0dca4:

   Linux 6.13-rc2 (2024-12-08 14:03:39 -0800)

are available in the Git repository at:

  
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git 
tags/amd-pstate-v6.14-2024-12-18

for you to fetch changes up to 95fad7fb58cfaa2a295aa54a1f001a16b9324963:

   cpufreq/amd-pstate: Drop boost_state variable (2024-12-11 10:44:53 -0600)

----------------------------------------------------------------
amd-pstate changes for 6.14

Mostly cleanups and optimizations to increase code reuse by
shuffling around and using helpers.

Notable other changes:
  * Add ftrace event for active mode to use
  * Set default EPP policy on Ryzen

----------------------------------------------------------------
Dhananjay Ugwekar (5):
       cpufreq/amd-pstate: Convert the amd_pstate_get/set_epp() to 
static calls
       cpufreq/amd-pstate: Move the invocation of amd_pstate_update_perf()
       cpufreq/amd-pstate: Refactor amd_pstate_epp_reenable() and 
amd_pstate_epp_offline()
       cpufreq/amd-pstate: Remove the cppc_state check in offline/online 
functions
       cpufreq/amd-pstate: Merge amd_pstate_epp_cpu_offline() and 
amd_pstate_epp_offline()

K Prateek Nayak (1):
       cpufreq/amd-pstate: Detect preferred core support before driver 
registration

Mario Limonciello (15):
       cpufreq/amd-pstate: Store the boost numerator as highest perf again
       cpufreq/amd-pstate: Use boost numerator for upper bound of 
frequencies
       cpufreq/amd-pstate: Add trace event for EPP perf updates
       cpufreq/amd-pstate: convert mutex use to guard()
       cpufreq/amd-pstate: Drop cached epp_policy variable
       cpufreq/amd-pstate: Use FIELD_PREP and FIELD_GET macros
       cpufreq/amd-pstate: Only update the cached value in msr_set_epp() 
on success
       cpufreq/amd-pstate: store all values in cpudata struct in khz
       cpufreq/amd-pstate: Change amd_pstate_update_perf() to return an int
       cpufreq/amd-pstate: Move limit updating code
       cpufreq/amd-pstate: Cache EPP value and use that everywhere
       cpufreq/amd-pstate: Always write EPP value when updating perf
       cpufreq/amd-pstate: Drop ret variable from 
amd_pstate_set_energy_pref_index()
       cpufreq/amd-pstate: Set different default EPP policy for Epyc and 
Ryzen
       cpufreq/amd-pstate: Drop boost_state variable

  Documentation/admin-guide/pm/amd-pstate.rst |   4 +-
  drivers/cpufreq/amd-pstate-trace.h          |  52 ++++++++++++--
  drivers/cpufreq/amd-pstate-ut.c             |  12 ++--
  drivers/cpufreq/amd-pstate.c                | 520 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------------------------------------------
  drivers/cpufreq/amd-pstate.h                |   3 -
  5 files changed, 301 insertions(+), 290 deletions(-)

