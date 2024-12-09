Return-Path: <linux-pm+bounces-18836-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B32B9E9C17
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 17:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 593BB18861D5
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2024 16:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9397A14884C;
	Mon,  9 Dec 2024 16:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="A7i+pjkc"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7286514B077;
	Mon,  9 Dec 2024 16:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733762978; cv=fail; b=onDhn3V2AofI5Ba3DngglugOL721hEvY/j/sXRXa21nO6hBskDQ54oOwkksn5RcOwn+QmU5Jp2S7eP1zEnc3HJ1ugoPXRzdYiuX4EUIONgAYB3a9YVHCMzOmVpHfMHzfJUr/gm6QKXDCMpnbtbQaPmovclWHvVOjxpWFJ71tNPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733762978; c=relaxed/simple;
	bh=OSIr4syOEE0HOExS1iJxFOYsXgPCkfpsgW6ahanrFXk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NnGvkhWKLnnUt5IgaCGKP8qhCwVUnMOx7+b1Otbqhg+GpDtx2s26TwIgXW+HdqlTngRRgNFEL01uXnXBkbztLUcRE80v5JC5j5lK2W3ygto+dbtt06UXRyzWDl4c5xRCtF2+MhOV48txeSckqShS48YicLDMIoBb+CLqD1n7vME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=A7i+pjkc; arc=fail smtp.client-ip=40.107.237.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vdlqnslxIZ4ndTffkTmzFUZUF//AqiAMDJ5zpOiUO8sleNz/BKgPDzR5TX+Z14rQvu1xCo3P4Pmy3xELyhvDuphSsmcATQTcjvsGU9Hs+YmHQQpgxPpiBT2bbcmQ4HRIvo8OOBQqGsnX6rIlk8v2dZ4eXpJWLTEnN+TzeDLpdOH5Kkjtg5baAbCOyx8GpY8QsnmgHmanhfhLhrPu8WHih1Axp+Ffk/wt1iQ19ChDLqrW18tvw0Q6vd2hSQoWAY62+VaOzaFIZmk7XUm/2ETa9ighIxpfm7Nxh8p5ixKzQ9mqOwfRXF8lWJYGnshsMwQv0C33VRnVg0I50dScsHJfJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLLsmVzFblnedzO4ojh7Wu1B5Fh4wsfpW2Y8bG/u7wA=;
 b=ZYbl0iUFNE5GfPEqZ06XayN8K1svZfbkdJTSVi6JwLojMaxvlxwP2HA63iiXiMsklGE2+JY4dez+Zj366hu9BGbqkTc0dARAJx4z7jges471PnhvbmIIeIhCy6zsE06yd3k19qWoGZAQIplwY7sAgeAnhl2LA/8bgMeq1zbCCrxKd6nZrvnPbqAoYV+hFExOG26F6fRqO90bDd8LNq+Ed16K6ds0pLzkfJ2aWfRv/s9fqeMESyT7IMXNz3GND5r3SlHKZOsYtkj73AMZhp4NYcwZTqUo+xvFGA22J81zimxgVgqp7emGFueMEjP+35em/yTzsoQ0zffjHUyUO1Sqtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLLsmVzFblnedzO4ojh7Wu1B5Fh4wsfpW2Y8bG/u7wA=;
 b=A7i+pjkc+pfE4A9/hhddLKN8Vjwr0wCV0ySEdVxkfk/DGfuQi9ioXNYgRboIs1IGymebIJQTFC8qPtDasngIde405MUJNW78yCGwb9/7FjT75pjVrNHbvkXZ9yNraZGdz/gDUMAdJ47BRgSe9ZC5sAnwqTSDdMpCi5PNFQ0DN4o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY5PR12MB6106.namprd12.prod.outlook.com (2603:10b6:930:29::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 16:49:33 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 16:49:33 +0000
Message-ID: <c9fc8ee2-db38-48e3-86ee-69a33eab1473@amd.com>
Date: Mon, 9 Dec 2024 10:49:31 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/16] cpufreq/amd-pstate: Always write EPP value when
 updating perf
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
References: <20241208063031.3113-1-mario.limonciello@amd.com>
 <20241208063031.3113-13-mario.limonciello@amd.com>
 <Z1atZRyH3dbWQYjv@BLRRASHENOY1.amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <Z1atZRyH3dbWQYjv@BLRRASHENOY1.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0120.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY5PR12MB6106:EE_
X-MS-Office365-Filtering-Correlation-Id: 015d1111-7d12-4efc-cd57-08dd187174df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHFPRDdWMkVaWUEyVDVrTjF3cEx2ZkZIS2psMU9aVkwzdVNaQmJseTRJKzA2?=
 =?utf-8?B?bms1TzlYQm5DdTZGTThjOUMybWNTMVZ5aVoyWVJzOWtqTW91NDArR0NvRTJO?=
 =?utf-8?B?ZUFGZzM3ZnJsc1hXVjgvQWN5VDV5RTRBZTk1U3prZmxKVU16NjVSV1gxalFN?=
 =?utf-8?B?dHNwQ2psTE80VWhZQTl5UmZEUTgrMHpjcHRNWktWVGpOVHFTL3ZGWWdKc001?=
 =?utf-8?B?blhkRlpqLzRSTHBRd1h3TmVLbzhNaVh2cCs2dzMzWDRZajZaSXR6WU9kdk1j?=
 =?utf-8?B?TG1HQ0F1VXlPSklrT2JQNlNPMXROUUV0a3U1QlFRMU9mWXB1aGlodHcxUEdv?=
 =?utf-8?B?UE1oUkl0ekdobGFRVGM5cHlSN0J0RVhEaldRVzZHTE1DZDEzK1NRUFN5MUdT?=
 =?utf-8?B?dEFRVmIxTi95eHZDZmNTWU45cVY2KzY3UWNLbmU1UG1vUWdaZlVWeXhIOHM1?=
 =?utf-8?B?YlROZy9NeGowV1VtMW0zb0ZVOG5BM1JkLzlNSTNFbXZCcUR1Y0FJQUFxTzZF?=
 =?utf-8?B?K3BEQi9GMWozTi9PNEhxeldWMjZocmlod09HMnpiL0RZSStWdVZzTzlNeHpQ?=
 =?utf-8?B?RHJVV3hIdnpBZnFSUEN1bFpSUk1peXZaZFp5Tk5ZMU9idlBMS0p2WUNBamtF?=
 =?utf-8?B?cmNEN1ZVT2tMRXVGSy94Y3FEK2IxMHB2cEN0Y3RuWS9oQUVZOTVwN1ZKMHlE?=
 =?utf-8?B?NWRwRHpDd2VFNnFSUW91RFY5VWx6WkxTWnVJZ3F1OUJIamV6N2lPSEV5VzNs?=
 =?utf-8?B?b1FCNzEwQUZReldJSUlJbWkvYmovczNUQWNzUjlpR0NhV243cGtuZW5SYXZ3?=
 =?utf-8?B?ZllETkNvUW9tTnpCVWNOSTlocDRaT3NVWHRKdEUyajNJSG9RSzFjN2RMSDQ5?=
 =?utf-8?B?Wkg3ZERvVDZZcHA1dVNQTmQxY3c4d3RnMFpwVkI3aENGRlBmZzl5ZWpTKzRm?=
 =?utf-8?B?SWQ3UDhuVHg5dmIzeW8veDJuczVmaG5wZXFoT2N6Y0E4N0w4cmkrV3NLNnli?=
 =?utf-8?B?azl1NDZYditOaTJ1QithMjRVTlM4ZFBnU1h1aWh4WEZMOVBYdkFJdUswemZH?=
 =?utf-8?B?SFJtemNlaUJEMU5CTjRVRENIenpaSlUrMTh2NmpFN2JLbTBhR2JGbDRtTUdK?=
 =?utf-8?B?Q2RNaHM2RGFqRmlmVGNDR0VQUERyYnI0dXBsSjZYUHJ2L0N2YXRiQ2FZWjQ0?=
 =?utf-8?B?bFdMYVJGeVVBMGVnYkJYcVNXaWw0K3BXVlBLVmk3eXloWnRGOS9rcHc4OWJt?=
 =?utf-8?B?YkowbjRidDFmRHQrZHJSVjJ5aWY5YlRMWVc2cy9RNnB6L2dlaUp4TmRsUEZ5?=
 =?utf-8?B?WU4yRnYyODQrblFBd3Z4cElJcElndWNrUUd3ZzZBMHpiTEpuenUvNnNpWUJP?=
 =?utf-8?B?dk5OZ2Q0L3NoZXFxY091RURQclJFblVTbEdlWkpsei8xUkJXVW52Z0YrZU9Q?=
 =?utf-8?B?NXJqWERzWmFKTnkrYnFVL0c3ZkE4bll6ekxHcWduZkVQRHlPQ1RrNDZUK2Mv?=
 =?utf-8?B?OTJpd1h1RHZUS0w2bGJUNEIrT2hPMnJTVk5ZdnlwQjJlT3dWa01icEFHY0xi?=
 =?utf-8?B?VE9GdHd6QnVYaFVhamhHeXMzYS9YQ1ZrTTNwZU9Ld0UyRjZtS042SFZxeVYv?=
 =?utf-8?B?R0FlLzVNbVRvYkE1aFFPL3VVZkZ4Yk9QY0VkTWlOdWRIcUlscjFwRFl4TVAz?=
 =?utf-8?B?dFpweEFTU09BREdXNVFKbVRNVldXUkZrQzhqR00zeWZJRVFUdUVXVVZCUGlX?=
 =?utf-8?B?SjJyVU9vcUltUUVHeGR1QTVPd2VFT1d2WTBmbFdJanBzSnllaDgzNytWQk5j?=
 =?utf-8?Q?tQNNi7i3vWlvs1v/oCjZqEtEL9Ok+a4IsfC1g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0FSN2k4azVUTXN3RTRjajVBbkExVDdpU0lhNDNTa2FnbGJOSG0wT3RRc3Ju?=
 =?utf-8?B?bU1xbUJSUmlwd1JjTFcvbzNWcTNLcGU3MnJxaGZRSGFseGtRcnlmYS81V1dJ?=
 =?utf-8?B?clUrcDVoSWxmNlFrOE9mcE9vQU5lUGJPUThWK1g1eERSMlhkaTVZaHBMQ2FS?=
 =?utf-8?B?bUJzc3NpeUVTamxTd2I5K3hIMVFnMnc0SXk2MENsSXhwM1A5NUFIZlMzZTh3?=
 =?utf-8?B?WkpzUmwzNTE3NGVJeHJ2SnZXbWgweGQ0dFJBM295VE00VW1GMWh6dmNzUHRE?=
 =?utf-8?B?VHl4eGM5NEI1WHIyaUdxTzd1dlFPQ3J3cHZMcWJHVlZwTkdwNUU4TjF2dk1y?=
 =?utf-8?B?Q285VEh0MU9qL0ZocC95Y3MrTXIrQThROG1FN0lLRWpoejc2cTJaL0JKeWNs?=
 =?utf-8?B?NlVXL0lCazdvT0pDKy91aDJlT3dPaTF1UmJqVmFoTlVqeVpaQnhLRE0zbkp5?=
 =?utf-8?B?d2F1VXF1aFFBKzNQT3VodUdnNzZlYllkYUV1Q1BlUVprVnZFVGhYWHhxSGc0?=
 =?utf-8?B?TUc3d1Nkd0hNQmJYK2UwQzVXeDFFeURMUHdidkhaaFNSZUtwWkFjdCt1a1No?=
 =?utf-8?B?YUxvTmF0TU92WjBLV3BvNnREWUVJWDZOUFlaWUt6U2w4eVZoSU9IbGFVeWlx?=
 =?utf-8?B?WUxlZ0VGN2hxendYbzliQThRNExBS28yRGQydTBVVmhheHVRWUs1VlBLaE4z?=
 =?utf-8?B?cklqOXNJajhKSlZQNUswOUtON1Y2UitSOW9HMjJHMTFNWHBjT0l0ejFpUEhG?=
 =?utf-8?B?L3h4cFU0TWZPZFhhOUs2OVU2N0VGZGUvK0Fjd0FvN1hwYzdjR0E1RllkcW5F?=
 =?utf-8?B?b0pjc0tXTmxCL0VKaE1mQjc4enBMWlo0T25ZeTNnZFBkckhGN09oNVNTc0RS?=
 =?utf-8?B?YnhNMG5oeXB0eS9UUTFDbmVXZUowMDhJUmk1bDQwbUszRDNWaGN2R0F3YzF0?=
 =?utf-8?B?TDN0TGI3VDBIM2xZYi9JVjlPd0RGcjMzSllZSEhhb29hd3R3ZUU0bFRHRm40?=
 =?utf-8?B?S0lJTXBOTnRIU1YzcmE5ZTMwcFBvaG8yejFOcDNXMWp0YmxRWkJzQmM3bWVk?=
 =?utf-8?B?d1hicWdjaUVZZlNnQW9kT20vYjNWSDdKQUxHeEFXSHRPcTJKVHp4Sm1JNkpt?=
 =?utf-8?B?YWVTZGdEOHE4cjRubXY4RjE1aFFaT3BSYXNWdTRBVzgyWnZHUU9iZ09zdFMx?=
 =?utf-8?B?Vm5HbzBqemhGRlhNMXlzS2NaZHJQak9oUVVuaFlweUY4aTZYSnJ2eXk2Mklh?=
 =?utf-8?B?dHR1RUJhMmd1bEk4VmU2VUp0SWdkaU9rOVUwV3JBMzcwS05lREZ0aUM3Z24w?=
 =?utf-8?B?Y0tHLytoZGY3WGNtNk03L2JYWmtlMDA2bmV6ZlNubytia2pYK1cxRlRCd295?=
 =?utf-8?B?KzZ4QTZZY3JKUWJLNXJUL1dSV01IVmxxcGNtN3VpaDdWRUUvcTZjVjhtd1pN?=
 =?utf-8?B?SENaNHFQZHZrUzdaMWlWcFdoNDVxUzJHZ2QzUVNYSjBzdVMrRzRIODRCT2x4?=
 =?utf-8?B?c3VUakxadzMxa28rSEhYdmlmTkU3aUp6QWR6RFBJKzAzVHZBYmdIMmRHR3Bj?=
 =?utf-8?B?ZTNjRUkweFRDdEVRempZQUpvT0dXVzB0U3E2cGN5RUVwcGc1STkzV20rREhV?=
 =?utf-8?B?Z1AvcU9pdDluZGpHUE1qVmh1VzI0Q2EvYlpnNHh6WEhING91Q1B0WjZvZnoy?=
 =?utf-8?B?Q3luanVkY3lESmZubkc3SVJlNWV3OXZkV2RaYVk1WkRYUWRkUUVkR2ltaTRF?=
 =?utf-8?B?dzhnOXpRRmp3S1dWS2tZYWRoV0hBcmRFSHZ1RDM4SzB1SnF0dXBzbnV0THJV?=
 =?utf-8?B?TTZzN3FLemNSa0dFSVhCVmRtWXpjbUZZSXQ3TFZqdmFyN01sMnA3OEdLVXBZ?=
 =?utf-8?B?ald3eVcvSDlUcy9JL3NOdjhpMEdjMnRQYU1ndEdidG51cTI1eWJ2NEUvTDkx?=
 =?utf-8?B?RE5obGJvVmxjbks5N01sZnhYZ2xIWW9wclhSUHlxNUozdE9hYUdyRkoraU5R?=
 =?utf-8?B?RVkwN3JNb1BMZFc4WFVtMXlPRGRBZUQwVlppWDdzS21vWHEyRGF5a2w4TGhh?=
 =?utf-8?B?cXdxSzJMQ0dnUXNvTVNBYWg5TG0rYU9tNWIyUlB4YlBrMFFXQWJ4VjF5OWc0?=
 =?utf-8?Q?lrLo/w4eQ6Ot8U4TCXUxilSOL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 015d1111-7d12-4efc-cd57-08dd187174df
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 16:49:32.9252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gdcGFFoHAEl7aMptlyGluLc3xMw32US4784yEHOJ0rMoJ/bXBFOlghQE9+I9Uh4nrTKok7PdguNH6GIlYXKtrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6106

On 12/9/2024 02:42, Gautham R. Shenoy wrote:
> Hello Mario,
> 
> On Sun, Dec 08, 2024 at 12:30:27AM -0600, Mario Limonciello wrote:
>> For MSR systems the EPP value is in the same register as perf targets
>> and so divding them into two separate MSR writes is wasteful.
>>
>> In msr_update_perf(), update both EPP and perf values in one write to
>> MSR_AMD_CPPC_REQ, and cache them if successful.
>>
>> To accomplish this plumb the EPP value into the update_perf call and modify
>> all its callers to check the return value.
>>
>> Reviewed-and-tested-by: Dhananjay Ugwekar <dhananjay.ugwekar@amd.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/cpufreq/amd-pstate.c | 71 ++++++++++++++++++++++--------------
>>   1 file changed, 43 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>> index d21acd961edcd..dd11ba6c00cc3 100644
>> --- a/drivers/cpufreq/amd-pstate.c
>> +++ b/drivers/cpufreq/amd-pstate.c
>> @@ -222,25 +222,36 @@ static s16 shmem_get_epp(struct amd_cpudata *cpudata)
>>   }
>>   
>>   static int msr_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
>> -			       u32 des_perf, u32 max_perf, bool fast_switch)
>> +			   u32 des_perf, u32 max_perf, u32 epp, bool fast_switch)
>>   {
>> +	u64 value;
>> +
>> +	value = READ_ONCE(cpudata->cppc_req_cached);
> 
> 
> There seems to be a mismatch here between what the API is passing and
> parameters and how this function is *not* using them, and instead
> using cpudata->cppc_req_cached.
> 
> The expectation seems to be that the max_perf, min_perf, des_perf and
> epp fields in cpudata->cppc_req_cached would be the same as @des_perf,
> @max_perf, @min_perf and @ep, no ?
> 
> Or is it that for the MSR update, the value in
> cpudata->cppc_req_cached take precedence over the arguments passed ?
> 
> Ideally, the "value" should be recomputed here using (@min_perf |
> @max_perf | @des_perf | @epp) and that value should be cached as you
> are doing below.
> 

Yeah - that's what the next patch does (which I think you probably saw 
after you reviewed it).

Do you think maybe I should just squash the two?  Or would you be 
happier if I re-ordered the two?

> 
>>   	if (fast_switch) {
>>   		wrmsrl(MSR_AMD_CPPC_REQ, READ_ONCE(cpudata->cppc_req_cached));
>>   		return 0;
>> +	} else {
>> +		int ret = wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
>> +					READ_ONCE(cpudata->cppc_req_cached));
>> +		if (ret)
>> +			return ret;
>>   	}
>>   
>> -	return wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
>> -			     READ_ONCE(cpudata->cppc_req_cached));
>> +	WRITE_ONCE(cpudata->cppc_req_cached, value);
> 
> Since cppc_req_cached is not changed, why write it again ?

Because of the next patch.  It will look at cpudata->cppc_req_cached and 
determine if anything changed in it - including EPP.


> 
>> +	WRITE_ONCE(cpudata->epp_cached, epp);
>> +
>> +	return 0;
>>   }
>>   
>>   DEFINE_STATIC_CALL(amd_pstate_update_perf, msr_update_perf);
>>   
>>   static inline int amd_pstate_update_perf(struct amd_cpudata *cpudata,
>>   					  u32 min_perf, u32 des_perf,
>> -					  u32 max_perf, bool fast_switch)
>> +					  u32 max_perf, u32 epp,
>> +					  bool fast_switch)
>>   {
>>   	return static_call(amd_pstate_update_perf)(cpudata, min_perf, des_perf,
>> -						   max_perf, fast_switch);
>> +						   max_perf, epp, fast_switch);
>>   }
>>   
>>   static int msr_set_epp(struct amd_cpudata *cpudata, u32 epp)
>> @@ -459,12 +470,19 @@ static inline int amd_pstate_init_perf(struct amd_cpudata *cpudata)
>>   	return static_call(amd_pstate_init_perf)(cpudata);
>>   }
>>   
>> -static int shmem_update_perf(struct amd_cpudata *cpudata,
>> -			     u32 min_perf, u32 des_perf,
>> -			     u32 max_perf, bool fast_switch)
>> +static int shmem_update_perf(struct amd_cpudata *cpudata, u32 min_perf,
>> +			     u32 des_perf, u32 max_perf, u32 epp, bool fast_switch)
>>   {
>>   	struct cppc_perf_ctrls perf_ctrls;
>>   
>> +	if (cppc_state == AMD_PSTATE_ACTIVE) {
>> +		int ret = shmem_set_epp(cpudata, epp);
>> +
>> +		if (ret)
>> +			return ret;
>> +		WRITE_ONCE(cpudata->epp_cached, epp);
>> +	}
>> +
>>   	perf_ctrls.max_perf = max_perf;
>>   	perf_ctrls.min_perf = min_perf;
>>   	perf_ctrls.desired_perf = des_perf;
>> @@ -545,10 +563,10 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
>>   
>>   	WRITE_ONCE(cpudata->cppc_req_cached, value);
>>   
>> -	amd_pstate_update_perf(cpudata, min_perf, des_perf,
>> -			       max_perf, fast_switch);
>> +	amd_pstate_update_perf(cpudata, min_perf, des_perf, max_perf, 0, fast_switch);
>>   
>>   cpufreq_policy_put:
>> +
>>   	cpufreq_cpu_put(policy);
>>   }
>>   
>> @@ -1545,6 +1563,7 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>>   {
>>   	struct amd_cpudata *cpudata = policy->driver_data;
>>   	u64 value;
>> +	u32 epp;
>>   
>>   	amd_pstate_update_min_max_limit(policy);
>>   
>> @@ -1557,23 +1576,19 @@ static int amd_pstate_epp_update_limit(struct cpufreq_policy *policy)
>>   	value |= FIELD_PREP(AMD_CPPC_MIN_PERF_MASK, cpudata->min_limit_perf);
>>   
>>   	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
>> -		WRITE_ONCE(cpudata->epp_cached, 0);
>> -	value |= FIELD_PREP(AMD_CPPC_EPP_PERF_MASK, cpudata->epp_cached);
>> -
>> -	WRITE_ONCE(cpudata->cppc_req_cached, value);
>> +		epp = 0;
>> +	else
>> +		epp = READ_ONCE(cpudata->epp_cached);
>>   
>>   	if (trace_amd_pstate_epp_perf_enabled()) {
>> -		trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_perf,
>> -					  cpudata->epp_cached,
>> +		trace_amd_pstate_epp_perf(cpudata->cpu, cpudata->highest_perf, epp,
>>   					  cpudata->min_limit_perf,
>>   					  cpudata->max_limit_perf,
>>   					  policy->boost_enabled);
>>   	}
>>   
>> -	amd_pstate_update_perf(cpudata, cpudata->min_limit_perf, 0U,
>> -			       cpudata->max_limit_perf, false);
>> -
>> -	return amd_pstate_set_epp(cpudata, READ_ONCE(cpudata->epp_cached));
>> +	return amd_pstate_update_perf(cpudata, cpudata->min_limit_perf, 0U,
>> +				      cpudata->max_limit_perf, epp, false);
>>   }
>>   
>>   static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
>> @@ -1602,7 +1617,7 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
>>   	return 0;
>>   }
>>   
>> -static void amd_pstate_epp_reenable(struct amd_cpudata *cpudata)
>> +static int amd_pstate_epp_reenable(struct amd_cpudata *cpudata)
>>   {
>>   	u64 max_perf;
>>   	int ret;
>> @@ -1620,17 +1635,19 @@ static void amd_pstate_epp_reenable(struct amd_cpudata *cpudata)
>>   					  max_perf, cpudata->boost_state);
>>   	}
>>   
>> -	amd_pstate_update_perf(cpudata, 0, 0, max_perf, false);
>> -	amd_pstate_set_epp(cpudata, cpudata->epp_cached);
>> +	return amd_pstate_update_perf(cpudata, 0, 0, max_perf, cpudata->epp_cached, false);
>                                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 					
> On an MSR based system, none of the values passed here will be used,
> and instead the value in cpudata->cppc_req_cached will be used, no?

Currently; yes.  After the next patch that changes.

> 
>>   }
>>   
>>   static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
>>   {
>>   	struct amd_cpudata *cpudata = policy->driver_data;
>> +	int ret;
>>   
>>   	pr_debug("AMD CPU Core %d going online\n", cpudata->cpu);
>>   
>> -	amd_pstate_epp_reenable(cpudata);
>> +	ret = amd_pstate_epp_reenable(cpudata);
>> +	if (ret)
>> +		return ret;
>>   	cpudata->suspended = false;
>>   
>>   	return 0;
>> @@ -1654,10 +1671,8 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
>>   					  min_perf, min_perf, policy->boost_enabled);
>>   	}
>>   
>> -	amd_pstate_update_perf(cpudata, min_perf, 0, min_perf, false);
>> -	amd_pstate_set_epp(cpudata, AMD_CPPC_EPP_BALANCE_POWERSAVE);
>> -
>> -	return 0;
>> +	return amd_pstate_update_perf(cpudata, min_perf, 0, min_perf,
>> +				      AMD_CPPC_EPP_BALANCE_POWERSAVE, false);
>>   }
>>   
>>   static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
>> -- 
>> 2.43.0
>>
> 
> --
> Thanks and Regards
> gautham.


