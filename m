Return-Path: <linux-pm+bounces-14577-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3451497EE9E
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 17:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 709D7B2068A
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2024 15:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF95819C578;
	Mon, 23 Sep 2024 15:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T1+CdepD"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC37879F5;
	Mon, 23 Sep 2024 15:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727107064; cv=fail; b=EQbXxph95T8+NcEbRh3AqOt9nPw/c8x14P6ku3alP/TQnJEGmNjQiH+HV0lEpnha46W75I6LhPijwQA7E6rgO6x6IV/GcqbvsQtHwD/xa5Q4D+UQNTybjVvldSL3aSHjQnwAsxO41F/BMlpfQX8rXVzJOogRA3Gu41diQZbYNpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727107064; c=relaxed/simple;
	bh=zpt/6tuKyWv+fvat9r3gBCQ1nkxMsbwGspJrVQPDPbY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fzg2khq2fJ7Zx4qOoHEvgLt6X+a1F0VQxVBq1L5kC8WLiwW2oCZJzqBlJNoye2imipY1u+MIYJ9xF7hoEspQnQp8/XlwUBo5tXndH9mw5AvJTG7U7wNOVU0DfKRDGt4vmOXYs197NpcDFXi4b/yvLjB03w5LuvjFMVMWcR/Ggdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=T1+CdepD; arc=fail smtp.client-ip=40.107.93.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O1eeHYhGBipYDCa0I7YDg0t1TL6qMJXbDd4skkmbxMDDG+85pQjp+S+1YskDOzCZWkiXG48L2QrtAzsv7P25n9Y3+TYk7mMoL8xN2wmUy4RJ5VKvIDXEVbFqupyCg8EvcneSqeV+Hh51O5SokJqs9EA0DaZUNTVaWbG/ciD1nHd6Wr3Nl7ZvmkKTv+x2uraLYEqyND1Ris1Hag8vplQjUuO2haHfjApUMWQ7aZ1JBWzQtx00sMdAt+OG9tVphWopJrZtWSiovAcBV4VSXop+9g8OvBNAA8VdV0slgevgnyBOuWDwrZ+y+HH0GltR4DkrhWWO5ziIwSmTLXeLUJ0cwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0MfeI99qhA6viGI0/NRDz/4eICIlmKz/DNDsxHgYt8=;
 b=fh5siA/EhOMq1qY7VXtc+OhDxulR2CtWQzSzeA58SqIcmEsZywkwj2CImdG35D4zF6TDxW/LI79XoSH8pGsEIiRfrWnTQMd9GjjWwLg4mrqLDJDvFuxjlVf2wKQLtWPXtj77xedQMgDgcUerM7s2EhotxOf1X/rfEh/uR0RbyQR4EkjZsJKpY6JHzoMV9YVvJbDQp/ckT1YdPkDoaOSQEdsvjQVmkhjJx0q9EIFCgGjEcjg9ONZYol7+LJl9tuSELMejozkvnaR1anz2d9XQjKQ8hd6DCikprUiwYlKcf2n9K9SOg/Prb9LW3A+341GNX2nQtDmaJXQvtrecJyTT8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0MfeI99qhA6viGI0/NRDz/4eICIlmKz/DNDsxHgYt8=;
 b=T1+CdepDkt2uYUEW+oEopxjsyBctiEmSJ6e1m1xfngm27p4Z88WYbNfktfNexUbwtj9swCBVCt6Lxe/8BtPEVyDcHXSD1WfyjJmcfUXm/o4LGY71CX5Aq+qn4WAp+UhBK9vVHl1d+xFrmL9UINuI/Ee8Qyl+A1vcbRtT6025404=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB9239.namprd12.prod.outlook.com (2603:10b6:a03:55e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 15:57:39 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 15:57:39 +0000
Message-ID: <bce3dc7f-77da-447b-abca-0187f1817cf5@amd.com>
Date: Mon, 23 Sep 2024 10:57:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] acpi/x86: s2idle: add support for Display Off and
 Display On callbacks
To: Antheas Kapenekakis <lkml@antheas.dev>, linux-pm@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org, luke@ljones.dev,
 me@kylegospodneti.ch, Denis Benato <benato.denis96@gmail.com>
References: <20240922172258.48435-1-lkml@antheas.dev>
 <20240922172258.48435-2-lkml@antheas.dev>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240922172258.48435-2-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P221CA0017.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::22) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB9239:EE_
X-MS-Office365-Filtering-Correlation-Id: ba2df517-7e08-4985-1d9e-08dcdbe87341
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bDg4N2l3dDZZWTFhTG84OGVoenBvWkdFdjNsMmg1T3BkYnZGbWpSY0hMc3lP?=
 =?utf-8?B?OWRxZ0JvcFlMUDZCQ1JrNThseng3WE1IUXVXN2o5cHJPMVlRTjJ2akFFU1NN?=
 =?utf-8?B?WmFlSithT3VXUTJLZWZjdmdzS3FvSlgvSWZVWVJNTnlZWTJtUHphUDBkQmNQ?=
 =?utf-8?B?TVBQV0MxOU1objJRTFlGdDBmT09aRyt1akhpME5jK21tUUJEcUM0OVJNWEpm?=
 =?utf-8?B?YmV6bzFRakFyMndNRkFUSWYxeGJ4WWxublg5dGFabm9rWC85TERFZmd5QTJv?=
 =?utf-8?B?ZjRkM2hDTlhBWFM4TVlLb29RQW93MURsZ3UrRXpWK011YXpTdGxNNHl6eldl?=
 =?utf-8?B?K3F5REY5czV4VlhCdkwyMitIMWcwanNoazZoTk1lV1N2bjNCLzNhazVXckJu?=
 =?utf-8?B?NDN1QVRLQk41aU9DNDhwOC9NRmplY3dqQUpYN0ZjV0M0bmNFTXRNRE1aWGFO?=
 =?utf-8?B?MXlHSVNmdjk5eVo5WmRXWk5TWTN5aGh5cGRvUS9NcGJJODg2aVRNcmtMRnA2?=
 =?utf-8?B?blNUK0lOWVYxTmh6dFFjWlVMY2RtOXZyWWtrdmpIVVlhUzE5M0JEcENGc0Jv?=
 =?utf-8?B?ZjdFRkJEQTk3T1ZjS3BOcGg2UE5XZllrRE1lVnd0Y1RDdkpQNWpBZjlFcU0v?=
 =?utf-8?B?R3NkcEhYT09aMjlGc2k5eUpqVlcvdXZTZk5TVGZPQ1UvL1lUaUozQmlISlZ6?=
 =?utf-8?B?emFhYkdNdWtTbkZwcDlyZVpRMktBYlNqQXEwbmV2anh0NHF2L2h3Ly9wY3Mx?=
 =?utf-8?B?MUVxUDdEUXF0UHNZZ1J6cTJvUFRXMlhjSHVaWkFFeFB5UEJ4MUt6VUdrVXVI?=
 =?utf-8?B?VCtXU2dmZmErMUZkay9Sa1RlQkJoaUwvdmgycHZsb3V0K3ppbG9hVjJlTmRY?=
 =?utf-8?B?YXhsdU1aR0Y1b3pMQk9ZSXY2RDlnTFh2SDV4aWZXa3JhQ09BcnNGaW1tWlZ6?=
 =?utf-8?B?ZVhCSnlGb0xhOThCWmh3ZWdsQWlGUFMxakpRM2hTRm5oaXgybnRWN0NZLzQw?=
 =?utf-8?B?SFErWmRlTnI5dG9ZVFdES0oxR1NoWUVEaVFUcldpdzlZd2Y0TEtmaEJSR0N2?=
 =?utf-8?B?ZVFCSEFjL21lKzdScU1kK0JVaWptZkpyaHpVeHJuYXgxbFQ1VDYwaXJINkh5?=
 =?utf-8?B?SW9scDV2VHM1a0VEQWtDalp1YngrRFczRTJzRHlucDBOUmh6dHJiM1lva3p4?=
 =?utf-8?B?ZGswYS9laWJCTlMrNjkzVWRaRVFCQjE2T1ZYaUhEejU2WWFsT1VucHlLa1Nh?=
 =?utf-8?B?Tno4Tzlham9yM05sR0JvOG1WYkdNVUExd085MkNoZlZVblpDQTZmYTdYU2Mr?=
 =?utf-8?B?aktLUm5SalptZmlmY3BOMk9IS25GdUdKSGE1dnhndjd6b0l6U1F5U3hmWTdN?=
 =?utf-8?B?d3NESEd3Smk2WjdDVithbFc0QTZ5UTJyL3V3eVBQc04xWC9QYzliRFRNRndo?=
 =?utf-8?B?YjhhcG1BNEdpOVlGSklqRlVqZkh0Ky9JNVZIYks5L1FqTkV5N29rTjUyd3lh?=
 =?utf-8?B?bzdiKzNxUEVvSHM2SWZEMUxFSmtMblFrTW9ZWE1jckNVTFl5eS90dFYxSHRM?=
 =?utf-8?B?UkF1NDdmckVkc3FwUGYwZVJhd0d0b1BhL0o2RnJxeVlCYU1EbytoNjhpd3VD?=
 =?utf-8?B?NzlFUmdwZ3NyeHhuaXpucjBxSUtpV3pUb1RubkF4STRQVTdEVGR3KzFXbVYx?=
 =?utf-8?B?QytMbTRHQnNkZlRETWw0MGVGWk91NFQ5Qm0zMDg3enlFRzJYRlJZRDBZTzBR?=
 =?utf-8?B?NG5SOFJmQURqQmRJWG94WVdFbHc5c1RsTVlMNThuL2ZOb2VkMGZvWFdITTFB?=
 =?utf-8?B?eW9YUlFNM2V6bGJkL2FJdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXh1RWJIZmpUVE01NDZnNndMOFh0SytDVEdPbG9janVjaVNBWXpGVm85SC9p?=
 =?utf-8?B?VU1xdldPd21qKzcxM2NjcFBhUXBmRVp6NjloVVJrU1NndHNoYUVkQkpzR2V4?=
 =?utf-8?B?Tm1xRzh5YlMyQXpvWFJQOUsxci9QbDRLZWFZL1N5NTd3RWhQemhQZWNxdlNV?=
 =?utf-8?B?Z0JITllabHhrNWUxTmRMeGNrWlF3MGZIMmdPOG1Zb0xYM2g2a3JtalFDUm1t?=
 =?utf-8?B?cHFyQklUdjYraExZZmZGTU12S2QwYW51Nk1xdERTRnUwa3JsM0FteFRHeUFt?=
 =?utf-8?B?NWFDeXl0RVdUVlYzQ1kyNlhGWlpSMFUyQmUrV1pWNHhuRHMrSDVvTGgxczZx?=
 =?utf-8?B?YUpGaTJIbUR1VUZXSWhaaVBadXRiSWw1ZVFHRjl5RnptQkU0aXc5K2s5WWcw?=
 =?utf-8?B?K3FxZjZnVTU0TGF3VktYaDVXcVlTRlpKNnc2b0tHeVY4NjZJcVNheUtpalVj?=
 =?utf-8?B?MjVDd3NVOXoxK2oybWpvSE9yR1R1N0Fza2tybEdLREMxa29mc2dBOG5Ya2Iv?=
 =?utf-8?B?YU4reTFxd3NjZGYrUVZNK05zTE5kWkhwblpucjNyTEkrL0pyVGg2V0RjRmhC?=
 =?utf-8?B?ZnVsVDUraGhCLytMbnNORGtzMHlEZDRuTEY5VzBKWWhHYm5jMlg2REV2VHpi?=
 =?utf-8?B?bko3L2VMdldocnpTZlJzYjVvbDFMOWVhdnpreXFOVTIyYmJOTFpvNW1qVzFm?=
 =?utf-8?B?eVlPeXJBMzluNm1MTFhXL2orYXMxS2VVOUR5YnZ2ZzFhOERXTGppVHhtVXFr?=
 =?utf-8?B?RCtSTngrK0V3bnlndnljbjNpVkRCamVhUFlWU1ovYjU5T2h1VE83OUx4RTVj?=
 =?utf-8?B?NFp6dE51VmZBcVZXckt1S2Q2UHhIS3hoaitMZUVMMTFiV1ZKSC85djBkVDVp?=
 =?utf-8?B?cEFjdnpDTnF4QncrV1lrOEUrV2tqb09vVHVJampybWgvYWJnQ0JqR2xiU3pr?=
 =?utf-8?B?Mk8wOGQxNkFSSWdGb3MzZFYxNm1sa3ZtVjJSdXJDa0E1Q0FIdTR3ZGlHbHBw?=
 =?utf-8?B?ZjhVeHc2MEZLV0w1cGd1dFVDSmhQT0h6ZVpwSEQ2aGRkM29FZ3hRSENTRmU1?=
 =?utf-8?B?TzN5M1ZKd1lVcm5TdjBmK3RkOE5BYVUvMHRyNnpjY1ZCdG1UNFdzUjBHSnl2?=
 =?utf-8?B?c0NHak82MDQxZFVFUVJPY0Y5RWsvUFVVMDNBZDluMlR3TXcwdzRHb0xGRlBZ?=
 =?utf-8?B?WjVSa04wU1d2ZVMvR29GUzZsZlpFOWJTZjU4cWZnVUFCUFdzcmpkd1NJdkhk?=
 =?utf-8?B?VUd6OFoyTEhlN2FxeUtmN2xrdmtMakplNGR6M1liRmRWQkpHSHB6WXhmUUlP?=
 =?utf-8?B?ZG9KY09zSVdDdkptam9ocjBGTnVDd2lFdjlGRmU5ZDN0MFEvNUxsN2JlMC9n?=
 =?utf-8?B?YjdudzUrTE0ydVZGWVlSOFJRSlNMV2Z1dEVQSEQrcGFESnNXKzY1RWh1WjFr?=
 =?utf-8?B?bmZkaU9IRDU0VkYyM1lIQUVjR3kyTVhZYk85S2llWThPcFVRWUpRNmUzb2tU?=
 =?utf-8?B?Z0txSFFrRW9vWDhjRCtxcGJOSUxndWU5NEtyRSs1NE9zdHRONWdrNzhBYlRE?=
 =?utf-8?B?bUVLckhSZENvMFRXbnIrbU1KWkdOUHUrS2x5bVRJbU9xdVJ4eC9VK2l0U2x1?=
 =?utf-8?B?RU96QkY2Y3pDZVU3OGZLZmJkbldTZ0tUSGo4eDBXWVEva2lSb1g5djlHMERx?=
 =?utf-8?B?OS8rVjA1bUdGNXJpMC9CZGViWEhxTWRNQlp6cjh4aHladHIvMktHb0RPZkt0?=
 =?utf-8?B?ZC9WNzVvZmQvQ1J6WnVpNGVySTJ6SU1nYnJib2E4ekJkbVhWNFFhRk9kQ0pD?=
 =?utf-8?B?VUtiRS91anpaMlRtZEJtdDRHa0luMXdJbllDK3l0TkZoaTJqUjFrOUZGeWpM?=
 =?utf-8?B?aUorbXZ0bEpBU3FmNE0xV3ZGVU5xWGJUck1aMTRxOU9FQUVYN0NndExsTUsr?=
 =?utf-8?B?QUxaOUFSbmRaNGhDRjFiZ2dENGNyc2wvS0s4TmhuVFJqNTZ4dGE2RFprNHZN?=
 =?utf-8?B?TGROOHNSYTIwSzVUR2FxRXhGdlJYUG9UN2JhdHhHaW9WZm9ZTTlNMXU4NGJq?=
 =?utf-8?B?S1hwUzI1NG1DYXdCZk83MXBOSzZXV0cwbUhpZUZkNThoOHpYZys2aXF1RTEv?=
 =?utf-8?Q?qG+TKjshRWi3iDmHCPFwfS/03?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba2df517-7e08-4985-1d9e-08dcdbe87341
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 15:57:39.3263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qgb+xxtyrK+0udoZA7uX0zmeyCe9Zt0cVWAySIwCPmtwE0fWNim32Dx/54VgWnPLi07m/o6zO1uOyxdMBpF7VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9239

On 9/22/2024 12:22, Antheas Kapenekakis wrote:
> The Display Off and Display On firmware notifications are meant to signify
> the system entering a state where the user is not actively interacting
> with it (i.e., in Windows this state is called "Screen Off" and the
> system enters it once it turns the screen off e.g., due to inactivity).
> 
> Currently, these functions are called within the suspend sequence, which
> causes issues when these notifications interact with e.g., a USB device
> and makes them unable to be called as part of the screen turning off.
> 
> This patch adds a set of callbacks to allow calling the Display On/Off
> notifications outside of the suspend/resume path.
> 
> Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>

Make sure you run your patches through checkpatch.  I don't believe you 
got these tags right.

> ---
>   include/linux/suspend.h |  5 +++++
>   kernel/power/suspend.c  | 12 ++++++++++++
>   2 files changed, 17 insertions(+)
> 
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index da6ebca3ff77..8f33249cc067 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -132,6 +132,7 @@ struct platform_suspend_ops {
>   };
>   
>   struct platform_s2idle_ops {
> +	int (*display_off)(void);
>   	int (*begin)(void);
>   	int (*prepare)(void);
>   	int (*prepare_late)(void);
> @@ -140,6 +141,7 @@ struct platform_s2idle_ops {
>   	void (*restore_early)(void);
>   	void (*restore)(void);
>   	void (*end)(void);
> +	int (*display_on)(void);
>   };
>   
>   #ifdef CONFIG_SUSPEND
> @@ -160,6 +162,9 @@ extern unsigned int pm_suspend_global_flags;
>   #define PM_SUSPEND_FLAG_FW_RESUME	BIT(1)
>   #define PM_SUSPEND_FLAG_NO_PLATFORM	BIT(2)
>   
> +int platform_suspend_display_off(void);
> +int platform_suspend_display_on(void);
> +
>   static inline void pm_suspend_clear_flags(void)
>   {
>   	pm_suspend_global_flags = 0;
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 09f8397bae15..c527dc0ae5ae 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -254,6 +254,18 @@ static bool sleep_state_supported(suspend_state_t state)
>   	       (valid_state(state) && !cxl_mem_active());
>   }
>   
> +int platform_suspend_display_off(void)
> +{
> +	return s2idle_ops && s2idle_ops->display_off ? s2idle_ops->display_off() : 0;
> +}
> +EXPORT_SYMBOL_GPL(platform_suspend_display_off);
> +
> +int platform_suspend_display_on(void)
> +{
> +	return s2idle_ops && s2idle_ops->display_on ? s2idle_ops->display_on() : 0;
> +}
> +EXPORT_SYMBOL_GPL(platform_suspend_display_on);
> +
>   static int platform_suspend_prepare(suspend_state_t state)
>   {
>   	return state != PM_SUSPEND_TO_IDLE && suspend_ops->prepare ?


