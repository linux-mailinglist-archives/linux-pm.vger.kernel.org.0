Return-Path: <linux-pm+bounces-43538-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CfAErqSp2mUiQAAu9opvQ
	(envelope-from <linux-pm+bounces-43538-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 03:02:34 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A0C1F9C1D
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 03:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5009D300BEAA
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 02:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FEC1A6802;
	Wed,  4 Mar 2026 02:02:28 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021120.outbound.protection.outlook.com [52.101.100.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D850470808;
	Wed,  4 Mar 2026 02:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772589748; cv=fail; b=mAvxKr+LZ6azuoizdK0NCiovn0DtIZ3WRJYWYQVY9vUWaC58kUGL+UgjDSoxSkxDujD5hp/JuY0jgA2Wd8JVJn4dezOTwZndrZDp5oYfe7gjGz5/mGwqlRstw4gja1eBMnON7EZl6+dPeNY5aLEJtq6PXZBxkKi2uheSQLU3DpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772589748; c=relaxed/simple;
	bh=AB7A8hbr5ZJo3WMu/lITggHogFo7doPvO5dff5FdxuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f07GttIsPcEd2vXV8w9clT8AR5UiO56ZY6Zr5D6KJk4WYHAg7YNcnQkTjbdUGHw3znuLN2uICXCD7Dpj77CCUy51PEReQgZibSgMuzPyfSL65R8DYyp92H675oNGCFfxqxu7sIzjx6puMLDqmAKKHSN98fGBeiSit2gIdhAsKuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fjqnAgQscRPfrLW6W1fwLHoSWMTq7WDRqyOymw4vIq5Dg8ARAJz24TPG7RjGx/9hqMEXvIq/xdS+rTgBXLuwvi4/6soDhUKxI74tvruKVk0tjDByygXU/+LoV4wJuSNM+RvLZqenw1pXWZTbnvBwk7Bg2d6R6dLH5NULdWA9RsCRVRdHRyDRZleXqTQDqyYHEHeE5GcwGlmCV8u4uG7N7eQ6ODdWxB+4zy88FsiynNyD0cLd8HUUk21FpmQoAJWDuF5sxF+7NmIVKbouMGWKuYZiuHR3lN7CwsjN76/l/qEGsc2IRzTy/MC2apXF2ia8sJ2R/DffbiBdScy9DJqA1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+jyf4QRvNznbE1TPgPglGmV6T0ggp0XXZ7u0aUjiD4=;
 b=sEGgfy0jSYXdfhjA9Cuhzi/78fCmSOgcVTLyCQY1syq5ck6rnmKdYh63hn5FyETLU5K6UalG98rzgxjMJ4AVQSXhjN68w+U7zDpM3v1VvSREbdYqwcHn5KRvXv27t+Tmop9yziunl2Gdu7kGMvRD9YFPJpW4wfjBgi7dU5yZjYHkAgiE8uFItw75fmAdaXhX2jJd92ShN/SmLHhwN2R7GpnfxX2ka3AvVNqkBgsVn6O2Hh9qCLUtseusHYPU9lNaWLvQCTZWxDyeKmaOBmUJZ/4MM/jU0P0BVezqv5cKqiWXalsXW8T1/+01AFh9O2wGAMOYYPm7g0Ont/6TD6T8/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWLP123MB4161.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:be::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 02:02:23 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 02:02:23 +0000
Date: Tue, 3 Mar 2026 21:02:18 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: rafael@kernel.org, rafael.j.wysocki@intel.com, dakr@kernel.org, 
	pavel@kernel.org, lenb@kernel.org
Cc: akpm@linux-foundation.org, bp@alien8.de, pmladek@suse.com, 
	rdunlap@infradead.org, feng.tang@linux.alibaba.com, pawan.kumar.gupta@linux.intel.com, 
	kees@kernel.org, elver@google.com, arnd@arndb.de, fvdl@google.com, 
	lirongqing@baidu.com, bhelgaas@google.com, neelx@suse.com, sean@ashe.io, 
	mproche@gmail.com, chjohnst@gmail.com, nick.lange@gmail.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [v2 PATCH 1/1] PM: QoS: Introduce boot parameter
 pm_qos_resume_latency_us
Message-ID: <tzin3pkg4kc5vkjj75jpwze3qe2lgmf25jxyy7pcnjmor7sif7@nl6df4p4k7sf>
References: <20260128033143.3456074-1-atomlin@atomlin.com>
 <20260128033143.3456074-2-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260128033143.3456074-2-atomlin@atomlin.com>
X-ClientProxiedBy: BN9PR03CA0224.namprd03.prod.outlook.com
 (2603:10b6:408:f8::19) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWLP123MB4161:EE_
X-MS-Office365-Filtering-Correlation-Id: 68d4b0f2-4f22-4ed5-82ed-08de79921304
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	UZdLOh7uRiulh8ra5b37+AGAgNtk3RXwpB1+p+aslpdrywa4NNrgRwic6JTAPROFW8oL1RcDJRIr7GmxOQE7qpCKGX9XnOk8VngqVZEOPusHBKUM7ZcK7KlLNo69GBgeZhbvmgqpgKVwN7T7xboWy4GVCp6PfZ8QMtd+jqePOp7jGsn5TXGVJmDoHKRGtYgnPOU6N6TQyptSyiPfa+2LP/fWdT7yrikoPN2Q/LNclwFcMdoy7c/ABsjR6wJfIXl36OVmsLmBdJRi6cXG3venBblxqei33tpzEthCYGxVb6ADFxYEjtnkCe3xBvdWbluDqxmaJpbvN+0YEUz37Po7n/qZalgiPl1eiOUW+oPFExIbXEgZPpf1/qxSjbfyJwxaZHmH+Wvbk3EbNlXwCyxwgeVYlAamtSnNB1D27//K1HiJOvyLsYMR2qwzdq0gmQFHnpiS2kQwu+Ub2R0jvFpT85+PP4GxTAtkvVJHNepHln1u6NuN9VoSOS14a25SPfWqglh3m+aTOrpS5Hly8U3myHnu430qfMKcg2CducVmKvkye0gE3urk2c9I/BGAZNszr+sLYqe3TfN48p1KZIeD0+304o59q521YMZdu2tywh961oPWyBDXpDsi7uCmOPxkvCZnNhg6tSFxhnu+sIxma4gsfOVjScci8b9iqcrfxeWVVxKsJx/WUHIMcIAbl/bS4RIq7ogGkq3x72oEA41gxrRuLolSnJ0rd5LEVtw7l8o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTJsQkV1aGhzWU4ybUVzYWZKd0x3ZFZXWm1hczRmTlI3ajdMdkkyRWJQbWFh?=
 =?utf-8?B?c3B1U3VZVFlNK3FsTkFtU2kxU2xZMjhTQmZQL0hiZkZJRit1NERsb1hSMGkz?=
 =?utf-8?B?ZXB5bm5MMHVMTVNhR1ZXMjF2RUtweE1jbzBQdTdtY2RVQXhUdlZYY2RKR3JP?=
 =?utf-8?B?NURkQ2YxazhyMGxjeFNDbE44a3B3b0hwYk5pZzQ4VlppbnZKcGdicXdOWTAv?=
 =?utf-8?B?RnplT3RQMW1zZ1IxNUd0SlZRZ0w5aGJvWTFWQmJHeHNHRTIvSEZIRUxqcHVI?=
 =?utf-8?B?VE00cGxVWi82WGxZdGZ1OFpDbUxEL21nazdCcmpES0JFL3VqOHlzQnh1MEJD?=
 =?utf-8?B?azgwVE01V3FOb3JtWHYzZ2l6c3RGZHdwdW1jem9hUUg3U1JjRklEeTZab21E?=
 =?utf-8?B?R0V6dGFXTHhqYklsZHZvY1YvSEpiTXBKUEMwSmxZR0Q0Ny9mdml0bEsvRDZW?=
 =?utf-8?B?L01xR3hkRlg4alpsS1JrMDNMY1cxTzUremlMcjBrNVRFdk5yZ1JaOGtGUTlO?=
 =?utf-8?B?bDBuME9YZTJrOW1hdnE1WGh1blcyUTE4TG93MXRtRkQvM05sSS96WndqaVBn?=
 =?utf-8?B?eXloTEhjbkgvTFpDNXFndlZrVFVVcXpsZ1VTNmNhMEJwUDRHelJZYnhoNTBH?=
 =?utf-8?B?dnA0V3NjYkY1c0hwbVFxNU5aVUlHV3lLNWMyc2lMaTFsZ1IvTmNwaDBIUmVZ?=
 =?utf-8?B?WlRLYXBuQWNHczExMXpwSkVlaTRXWUE1QkRkcFhNSFFZMzFyekZ5V0pYcG9D?=
 =?utf-8?B?YmNWSitiYWRyOWpISmJTYUg3YU5OS1RITkh4R2tZWUNCMGxQS3ZYT1RUNG9S?=
 =?utf-8?B?OFo0UGJFT0swd0NHaWZJTUVWU2VLc0wrWk5wSitwTnZraVdKYUx3aldra3J4?=
 =?utf-8?B?QmNDR0JRbzVWMXh4SFZxOGNudXFsdklPaUZNRVRXRjR0V25lbmhOeDFLOENi?=
 =?utf-8?B?S0k3d3M1c2s1bHArY3oyZUt4dlBDK0luRXR0OFlGTEZWVmVIYnZ0dmdKZEYz?=
 =?utf-8?B?eWEydmdCYWcwbDVObUFoZnY3cWlPQ0NlWWhLRDFWNmYvTDkySnNzN0kwRVoz?=
 =?utf-8?B?MStqUGJNeFlaV0M5cmJzdzBaMzZUc1ZxSEpaS3F4a2cvQnduNk9obFBoQTBL?=
 =?utf-8?B?cVFKRStVTis5a1pzbVFuekRYa3lyRXNTWjdpbm4vVGdEdExGd0tlRUhKd2hG?=
 =?utf-8?B?aks3d3N2eWY3OW42RHU0TFFQVTZkZDlvQjF3M3czakRpV2VJTDV0cmpTK1hP?=
 =?utf-8?B?MWNQVG4yWGUxbjJraDZ2T3hWUWR1czBJd29WS2ZPVnpQNnNXTlpMb01EeXhH?=
 =?utf-8?B?dVNKRzlDOG9kUmk3blVhM2RtNU9tcXU3VkZwQWEwSWFHL2JLSkkzbmlZSFVN?=
 =?utf-8?B?S2h4NEVOTnlpZGJmWWV5aUNvdnlTSmVNRUhKUnFBamRDQUJTSFBmNUxscURE?=
 =?utf-8?B?eTJpMEppOHlSRjJBMXcvdVd2aDloWDF0OVM1NGh2bW4zYkEyV3ZJcjRwWDhE?=
 =?utf-8?B?dlYwUEcxK1lMRTI5cmJaNlJTem13MkFudC85MjA0ZkhUeUEvREh2WVJsaWU5?=
 =?utf-8?B?dFFIRmpaQVV3aWZaSHpLVFpHSkpxYjhzRWNCSTdIM0NUendkSFgxbUpzS0Vv?=
 =?utf-8?B?UEtnbFRzNjkwN2ljME1PWmlMeDF3ZGpFdnBTdlV1UGxkVmpWaU5GaTRlVmVO?=
 =?utf-8?B?bWFwQnprUndEUVNVWHhXSFpBd3NSbmp0bzdrbVNWQUdZbTBLYm1ISjJQZldz?=
 =?utf-8?B?ekhISGowQ3RNc0JXSmFyOFpOQ2J2U0g3aXYvTmhVRFhMZFAwaEJlajBIWlBW?=
 =?utf-8?B?M2lPYjFNcDkvZXFNZndRcHU3TGxkSHp0ckczZGxwNDF6a2ZkZ0kvaWhpUXlq?=
 =?utf-8?B?ckltVmhzemtNNTdGMGRmYkhKSTZSNWFlNlFEc1I3VVkvbW5OMkZyaE1hTEJD?=
 =?utf-8?B?QmFlOUZQMndhamQwKy96TC9KbTFNbVVReWZlSEJRbGZrcVlRSXZZaG9aWE52?=
 =?utf-8?B?b0pqMDJYall1d0NUN2VoVkxTeUNCMjZURVJnL0UrVGEzMmFJbjJGWFpEVjE0?=
 =?utf-8?B?SU9odjErU1ZNT2VmVGJZU1N1YVI2cklabUM1b0hsOEdlUjdGVGxndTk1V0tB?=
 =?utf-8?B?WkZJeWZGWW50VzlwUE1GOE9tdGpmOEJta1dYQ3NmSWNBNDBJSlZweE9zMmpo?=
 =?utf-8?B?WUdkSHZwRCtqT3VvVGlCNEZWRGt2TEZwQlNmUzQ3ZU5XZllPaDRCMlBHSEd0?=
 =?utf-8?B?QnMra3ZwbzRPakd6aEdrNzJlOS82cWNhNmJ1SmlzMXIyM0ZPYkpNWVRFSEtF?=
 =?utf-8?B?MVBrUWkxUHU0THlsVEV6ZDNnc1hsdUNUTy9sVXpLQTRvWHBKejRoUT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d4b0f2-4f22-4ed5-82ed-08de79921304
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 02:02:23.0474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3qvUPFDzo8Kw1ZBYMqssScce6JIjgF4LxA7sTIHNsOrFVzw7OoWCkLgc8PsmnAR3pci3usjqBw5finDxpJbuiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB4161
X-Rspamd-Queue-Id: 55A0C1F9C1D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43538-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[atomlin.com];
	FREEMAIL_CC(0.00)[linux-foundation.org,alien8.de,suse.com,infradead.org,linux.alibaba.com,linux.intel.com,kernel.org,google.com,arndb.de,baidu.com,ashe.io,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atomlin@atomlin.com,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.949];
	TAGGED_RCPT(0.00)[linux-pm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 10:31:43PM -0500, Aaron Tomlin wrote:
> This patch introduces the pm_qos_resume_latency_us kernel boot
> parameter, which allows users to specify distinct resume latency
> constraints for specific CPU ranges.
> 
> 	Syntax: pm_qos_resume_latency_us=range:value,range:value...

Hi Rafael, Danilo, Pavel, Len,

A gentle ping on this v2 patch. Now that the v7.0 merge window has closed,
I was hoping to see if there is any further feedback on this approach to
introducing the pm_qos_resume_latency_us= boot parameter.

Please let me know if any further adjustments are required, or if you need
me to rebase this against the latest power management tree.


Kind regards,
-- 
Aaron Tomlin

