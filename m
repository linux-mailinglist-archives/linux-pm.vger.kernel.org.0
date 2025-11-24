Return-Path: <linux-pm+bounces-38423-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BB9C7EB74
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 01:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 57DD134540A
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 00:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6948632B;
	Mon, 24 Nov 2025 00:41:18 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020082.outbound.protection.outlook.com [52.101.195.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196EE70809;
	Mon, 24 Nov 2025 00:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763944878; cv=fail; b=KBRX54rYRlIu0Ou09vYmO9jKxkH0peleIXwXbvcvIlhfJgsuH/p64DJ22/VocFm5BZIyKGVObMU0PNbn+QkGDMJNFtttwdKCGfpWSLQvKc/l9mv1CLUV4MScDrpAuGZ8ddum2WuPd/SPwadiUDfJBdIZAFdzxt6cgV2X/U/a9wU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763944878; c=relaxed/simple;
	bh=eorQmH5X3ZVYttc+wFGkFEeQosbyehjGeRHfWrAIbxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iedS0BmFHk16xtnlHotgU7VNi5SHup6/bUHj2FypA/f/8FtkIidp2rWOtnjMEev1f1+T0v3nN5qKedTya7GhoYNF9L7whmuhijuQVOtaFfoXEnfG7xkTVZ+pzJKodOnQpSIHe0BoDEUrheYM8FavQgC7K4V5oryR7HTI/wpP4A8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=at7dOKooHusUZ2wE/KgWNr7PfnodcYFhBWuPbXjTmWyvSg9u4cxG1opGvVUtBfiAGiaEeENLv/wERLZWvqPHyAXDSiqgb2dUX3Ku+dPn+7M7DImDSTIiRU/ykXnwxVTGTtm+NX1oY8tg3IVdOLUqmVul7eUX9AhmN7A9dvc08Woix/+7OhoQohrG7W07+GzZ3kNtgcjByUo1XRmNhFpxTOlShdi3I0A6avx6B7/cS57DLsX6y+NNKhEaAGbSDvAJOQNAfbD67yo+Av7bdNvt7QpX4v2vBnr0K8tCSdXzJwQ7dCuJKJVi9N0YrEBGmxnGRa679AVL/+cEw9qXWuTbbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=maxfPSqh/TPFDKRWXod9yKjvPDD00K8LNZwmfh4joOY=;
 b=wGbNi3h4y6dDuu7sc1L+H0heLVJCv4zIPMlMrnd6qJMcqKMd5pbnKhqz8WNHn4WumFqCt9Ocp3j9C8OMlqBegjLoNg7jHCvCcNfQLyYPTmTogcgPlC7on78neOLVBFUP19c53nMbMITJfnua/wUh9X1x5nkthqngBCydw4qehKqu8qNTC33C1op4svCuBqp53AGlD5Lh9Ary/lj00ZiNJzWtvsf3S5KZcw7iS7dzij86Ul2/AGcCh7M7JhFKHAymuK8xhAWc1hT1Rkfa5hxRmjc4LRZGP5bo8ObSspHtBlo61fdCsBpbwZhMwIyrZKA3lROK+qR2/bdq7PY9qQApog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LOYP123MB2942.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 00:41:13 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 00:41:12 +0000
Date: Sun, 23 Nov 2025 19:41:08 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: daniel.lezcano@linaro.org, gregkh@linuxfoundation.org, 
	nathan@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] cpuidle: sysfs: Display idle state enter function
 name
Message-ID: <ktaeuznhnzrrdy2at3lxuvotq2uqj2lfqm4zxb4rhh5bertied@hqyiir7wciiw>
References: <20251119002545.666251-1-atomlin@atomlin.com>
 <20251119002545.666251-2-atomlin@atomlin.com>
 <CAJZ5v0hUWMgJVAZ36_9k8N3AdZ_rGajKpQSprF6QwUtxmpH2qw@mail.gmail.com>
 <oifgpnkuupj4s7picyujw3jp2b22dcdrr7kqejho6uhxh3juam@7bqtbuxzjt5p>
 <CAJZ5v0j3Mpo2LLGN+jWbNi4vT+u+Wckm5NK+ehA=GhigThpcnA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j3Mpo2LLGN+jWbNi4vT+u+Wckm5NK+ehA=GhigThpcnA@mail.gmail.com>
X-ClientProxiedBy: BN9P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::29) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LOYP123MB2942:EE_
X-MS-Office365-Filtering-Correlation-Id: e457a3ad-96cd-42f5-591a-08de2af22ad8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bTE5dmJpKzJsZGM3KzNDb3ZQcldRWDJES01wQzBNQ1oybHpWN0NrTEUvRS9W?=
 =?utf-8?B?NDdHQnZqTWtKOGhoSHdpcm5abFZaWHBxZ242MEtzaHZNcUJwV2Ivd0pIU0cw?=
 =?utf-8?B?ZnhvUjZPeXhzem5kNFErRUxjNmVlWEw1TkhYWkV4WHlHWFZMcHY4UTJqWWNo?=
 =?utf-8?B?SlBhNWZsazUrSE9WY1hkR3drbVpDSklFOEJLN3E0c2dHMHAvbERBYXI5bSt1?=
 =?utf-8?B?WTY3bFd2TUpZeVdVeXBKWFpTK0pTMlZOTCtTUCtzMmVIVDhlSFFCOUVaV3I0?=
 =?utf-8?B?RTErNE5LU0R4eUNmb25iNDQrZk8xUG9OdkF2cDVhL2M3RitNTWNZM0hQK0p6?=
 =?utf-8?B?ME9Pa0pyc3AzanhOZ0VTUCtpV0d6b0w1WE5hYmpWUUZORllBZmZEMERIYnpX?=
 =?utf-8?B?RjkvU3NUR0lkc1NlaGxXQzk5UUUwbEZQdlk4a1NGMjVkazFzbHAwOFFVYjA1?=
 =?utf-8?B?dnNyNFVacXVRMHg5cjVsNk8reGZuQitwaVFpSks2ZGNMZGRHWW9JK1dyd1V2?=
 =?utf-8?B?bmt3Z1gxWW8xNi9uZWdGb3lrVUxiSGU3OGQzWjVtREgwV1RqbHpjVE5qY250?=
 =?utf-8?B?b1piZW1TTHJPa3o4RlM1czZNNlladmxpdnRJYnV0a2FFR3JXeVlFLy9KbUJ0?=
 =?utf-8?B?bWRkYkZDRmJUS1RCVmxUL0R5Q3ZIRHh5UkxHVjJsV3NXTi9mbnI0U2JDWkk5?=
 =?utf-8?B?d0tJenNIeVdSUWJZZ1hvNlo4R3d6MlI3SWJpVkRHcmNwNjVPdlRtQ1NyMFFQ?=
 =?utf-8?B?TDFzWHVhUXRTcC9ueHR1a0RlU044VFVxMjV5UHFrcTE3R0hVWDJYVXNyK2Mw?=
 =?utf-8?B?VlFkTTNObE0wSm9DL25uS0dFbXZXYWZ2M0xkN1o1c2pKK1pqUjQ0UFpNZWNL?=
 =?utf-8?B?dnpZT3lneWdkSm1GWit2UWFrWUlMN1VVOWVrcml4Tk1FZlNBalFpMVpNRXla?=
 =?utf-8?B?MkZqVDQ3NGJiQjlNeXZtY3MwWkN2alNkZkl2TnpUR2ptbC9ocTlYTTkxS2tt?=
 =?utf-8?B?Q3NtSkVzSTlXeldvK29uKzNkSVFOT01KM0lJMlJFTFExcXA1ZmpsaVhwa2ZC?=
 =?utf-8?B?MWJxcmVUQjROWjkzTlpjcHY1VlhSVzhpV1Y5S21PZkwwYTk0VU1ORTdLV0E0?=
 =?utf-8?B?M2xteHVyaXBkRVVONE5iQWF3Wm9wWHFJSndIOHJkTkEyMS8vM0QyaDRucjFt?=
 =?utf-8?B?TC9TalliR3N6a0RQQWNaNmIwTE5GRTdGZ2V1aHFLOWJVL2doejlMM2NDOU9u?=
 =?utf-8?B?NldoVk4zVkNISFRGb1pYK3g1UGdPVVRxbWdrR2E0K3hTUkovZUFmWWt1cjNV?=
 =?utf-8?B?L2t0aTBnRXVYcitRMVBraVJRZU1XVU5FSU1yenQxSStEL3Z4eGR1NVpUY0ph?=
 =?utf-8?B?Q0NMTFE2R2JsdDN2djlaNHlqdkh1NlM3M28vT0U5Q04vTHJ2WWpKa0N2bXlC?=
 =?utf-8?B?VENabjVCbFMrby9CQUFxQVRIbnFsYlhPV21UOUg3Z0tJSSt1Nys2a3pkeWsw?=
 =?utf-8?B?d3VtdFJWeS9TWVJIcVZ6VkRpUHdIZWIzMWVqcnREQmZ2MnNpUnZIcTd5Wk10?=
 =?utf-8?B?NldmNTBhdG9RMTFYTUJaUExRSDNTcUNva0RUMGpaWUhFMW5PeDhJNDlWZk9P?=
 =?utf-8?B?dmxjK2NNem5QL0ZBdHc3SjY2dVBtUTB0K01FTUxsSXJzSWNJUFJBb2dBelJw?=
 =?utf-8?B?MlkySFJkL3BqekMxVDZZVUoxRnVTZmoxUEFKakJxOUQxdTNTV1hBWGRuWHds?=
 =?utf-8?B?VHFuWndLa1ZtU09XRlQzeDVmZ1gwTUxENGxHWVFKNVR5UkYvU2w3T0tIcktq?=
 =?utf-8?B?cE9DRkVVWkk2NHJMWnhQT1FRazdnR3FOdXNiUEJFdmRzU3h4ZG9SQ05tQjFo?=
 =?utf-8?B?bEt0NVNVbXVzcDFkcmlrY0p1ZjJGNzJ0NFJDb0t3dEFpK1dack1CQjVIYmdR?=
 =?utf-8?Q?MlPpWLVbX/2G/xalLY52136639ggs6WI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2tRRzJyOS92eThPaExjNVB2ZUsyN2lXMzYxVHZGVEFFZGtaUXQvZE5mSDRC?=
 =?utf-8?B?NnJsMVVhZGpWY1JOQzBUeHJtNTVUMzdpc3RjM09NSFZUMVFVbHoyVDNlRkJG?=
 =?utf-8?B?RWxMMnVMTS8rNHRsK1JnelJVc0FjNXNHMDNpMDJkMGIzUWltM1RzbDRINUhz?=
 =?utf-8?B?NUI2ZTFpdi9EempYQkZKNFQ3aW1CWGNNK1VwNXVCYTBLd3N3dTRKVlcvOUNO?=
 =?utf-8?B?U0hjWFcvOXllU0lkNURHa1ovRk9TNFcxOVJ2TXhVNWhRc2xYejIwdEVZWXlp?=
 =?utf-8?B?WDF1Q2xCMTBDNGpSWjN6RFUwaTJ5by8yaUhVeVRSNWwrR3NCM0NhVGQ0TUlZ?=
 =?utf-8?B?Y1JDZkg0Yk94enZrMi9HVDlKZkNUT1RyQitqbmp4dU1IOWlZd1drclNGTk5z?=
 =?utf-8?B?dGZLeGZiMSt6TTBYV0FSSDEvR2pUbEVCYUJxTjhjV25NZ2VQQ1RwQmdXL3Z0?=
 =?utf-8?B?dFUva3RNOFJkREpuT2hJbHJ4eDBQZ3ZhSjIrRk9Xb0FTOTk1Zm5EZkpYSmFx?=
 =?utf-8?B?UXBNOXJwYjBqc3RheSszSzJuTlE4ZnFFSFNuMWxvWllWQjJBOWx5QktaS0JV?=
 =?utf-8?B?SGp5ZXhIcy9TSHZ1UDFMT1MwdkNLTXp6UCsrOEFqb1VzTUpzbnpxaGtURDVy?=
 =?utf-8?B?bzF3R2dQM3pOTlFDeDd2bzVER2lIQk1OTFhUdks1RTBaMEIvbTYzRmI2YmhN?=
 =?utf-8?B?YVh3ZGRtMHhYT00xdDd5NHNOTWVobkJLcFJ3cHFLNmh4TFltblE1ZEJjanF2?=
 =?utf-8?B?TVhuTWJoTVQyTmZHVDdnNkVLb2lqWHhTRld3Nm4yQlRHMDZFNjd5WHgxckRy?=
 =?utf-8?B?ck9JMGZMcXN4Rkl2ai9TRThNUk1KdkNtQmk5LzNOeGJ5eGJOWVFPMXl0WklK?=
 =?utf-8?B?TVhjVDVkbW8vckpyNVFPWkVBSWlWRFo1UURYZ1dtMG8rTUN0QzVvcjhoeEtp?=
 =?utf-8?B?NEkxcjNWcUdodDZ2ZWxWZFUvUUNveSt3eEh3U2Uyam1mMkpjZ0pFdEJZclh2?=
 =?utf-8?B?TC9nMU5SWkxiKzhVY0ZCYXlZWWR5SXhQSlBKd1FsbUV0ZElmZ2RSdlBUajVo?=
 =?utf-8?B?OGZ5V2ViMi8vNjd4UXA1NTBlYzdyYnFWUXo5bi9FNVA3ZE56dkRvY1VGaHVY?=
 =?utf-8?B?SitwTW1ZK0VZWXhHc3NhOEJwbTFGTFBrMk50c3hNWnQyY2Z0bThUbjNBa3pu?=
 =?utf-8?B?Vk9vR0lVYzZISzgrRmJuemIrUU9paC9kUlFwaTFxekZHdTZyZDN6UFhia2dk?=
 =?utf-8?B?MVJvV2xaOEJCd25QMDN0WDhqdE5ZdGNBeTdMMjRQd3lFN0JGTmVQSm5lWUJS?=
 =?utf-8?B?dnRLYnlQMklPWnI1cDcwbjZ6SFNtTE44R0JESzBtYlI1WUY0WXBzWWVXQlhX?=
 =?utf-8?B?Q1NnZmdCV0c1b0hib1lNTnRDQWkvdlZTSHFpZGZTa0tsMkw0czZ5ZzZBVFRo?=
 =?utf-8?B?Yjc4WUNlanZvZGt2N3U5RE9LQm9pQWw5YlJ3WDh6YzdzSmZtV0w4dVVOSDlX?=
 =?utf-8?B?V1RNdkt6MkZ5LzVhWlE0U29EekdHMi9JZkdNWHp3ekpBN0Fob1BQQVV2UlNo?=
 =?utf-8?B?RWpjY3A2eWpwOVVEaTZEcWU1RkEwa09DT253R0NSemt1YXJOYlBPeHFreEt2?=
 =?utf-8?B?emdRaGxtU1RseXVITUYyQTNnYkZnR0ZkdXZmczV3NzBiSGdaVXNmaFFZMEFT?=
 =?utf-8?B?ZzhhRkU0TkVIMGVEL3JJNGFaWUdjV01uOGEwRDFUdlNZdDBaN0djSVEzRVRR?=
 =?utf-8?B?UWNCU1lHU0xZb2R3U1gxT3JxMEJTTndPOU05NUpDaW9KcldWNzZBaXF4MVhR?=
 =?utf-8?B?VEVWMzVPeGxNOWtGUExacjN0b2MwbjQ1cjBnUSs3bmVON1BhS3B2Zk9ISGFI?=
 =?utf-8?B?SFFvZUVHZDdOMkhsa3o4d2JqRE9KU2R5blhKVmJJVmE1ZklQdHJUaUFQMUs4?=
 =?utf-8?B?aG8rOGJzbFFTNlZrVXo4bTRYclY4YW9XWEtmOG9pbnNxR09WNlpYVlZrQUpM?=
 =?utf-8?B?ZUpLcjA2RW9iOXNBK3JvTU8zZFI3Qmc3ajlzbHkxbWR4VmdkKzhaNlpnQWsw?=
 =?utf-8?B?MXVNRm9Ub29JQmoxZ05BVGVhZTZLSEMvVm0rWkdpK1lGV3BaSFZxZld6UGo4?=
 =?utf-8?Q?9mDTFT9Reiw3E3v9i0sjffNvO?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e457a3ad-96cd-42f5-591a-08de2af22ad8
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 00:41:12.5944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IsYNZzkmim2+ukCcjyKdA4csKxBQS2/J4V0pOJfOfbIQHYoazFUXrWl+I018Vgg+mWNUy4xpYMQUAYdUak8kxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP123MB2942

On Fri, Nov 21, 2025 at 02:31:44PM +0100, Rafael J. Wysocki wrote:
> No, it doesn't.  You'd need to tell me specifically what use case is
> going to be addressed by this change.
> 
> Though this is not going to fly regardless because exposing kernel
> internals via sysfs turns them into ABI which may hinder future
> improvements.
> 
> So let's first talk about what problem there is that needs addressing.

Hi Rafeal,

Apologies for the delay. I understand that turning internal details into an
ABI can severely hinder future improvements, and I acknowledge that this is
a critical barrier for the current approach. I do not currently have a more
specific or compelling use case beyond this initial need.

Please ignore this patch.


Kind regards,
-- 
Aaron Tomlin

