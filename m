Return-Path: <linux-pm+bounces-14492-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2272097CDEC
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 21:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46E331C20E68
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 19:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3789E1EF01;
	Thu, 19 Sep 2024 19:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fGhFXTxs"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EBC1DDD1;
	Thu, 19 Sep 2024 19:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726772495; cv=fail; b=Hhm680vbyfk59B6u/UcmMNLx3Sr7ORK3CpITq+r93TfVL37Hg4l2MniMLxLg9bdzHlAbaHZd4WF59pUBGmaD2i4FN/3VnS+Dm3df90fK42fI8kZMmq2MroX4X+xrhC+8Gtj8zzLJg8tNBncYzKcLT8V0J/LmyiSaymzagAiXVAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726772495; c=relaxed/simple;
	bh=eS4YPqeI5zI95Wf0ZME8mh1m7yaXIo+BQOc1QvdPV0I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xg3DWxKjsLIXBk4O7rSbxCijiXecQn0LmRRWqA+JU9Bqmso0mHowmeJ6HuwC1bNesuv8yhjBrsspzKpn5nCxYUVWlFEfi8/FV2c2+4MZsRPdfqYYaHM40KsJMMzV8af/lSMEmcefjPBnp1Bsxt7PYM4Cmj6sLGDy3hmlmddkt/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fGhFXTxs; arc=fail smtp.client-ip=40.107.236.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gC7cv3EUpvy2NsjucSY5J3KSe0IupCGSyRicSSgWeMXLfsvJmHLRNFh1ww7/SyUfpQPnseKTRb7WSEQM8CXDJI36W1UFOjzKqRmocGmzTDD3o9JhJuIob49zlQtO/19mOay3RRBZwKrXh7UIoh42KauCMy4drzrq1iWK31VOVI+tE+IiAvbDOgbG4mUzvBg3QVaCBccMeJn0m++C/2K2rVDhYBe1H51NFx3mT6+Ow6Rw24mo3jlaHNKxrimhTaFrfvXeLlncfRm/qUYiwA3xwbibPK/S7l6YtVO9eRXsi7cW1CTJpXC+YbrVfrrpJGgtO6Q0vLgyysrAiBxMpNjO2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79wmOru49VRN5FbFLIJ8d3n/d/erjfQc25w8xmb9OuA=;
 b=j4f9/b5mzbT6IojR9MP7ra75T/+wOHdLczGAFxE6zYTK/xEfi+dutW0HVPCxB7sZYYP6IVeDhIwh3qf3bBXWRPeuaW6iIrUmhZ8u5eHE07exHa7O4wUHL3JicUDTEpVMJM+J/8e6QAMWorVxao3ciQ4T2GlSr85WzdQIlcuX240erOj97HJ4aRAtOUxG3DFZCoTjxHJz0TptcWJlrAXopkEdnm8eKmy7Rss2Ph5oL0inASc93VWbCseYu1D9u7i6/fyoKIK35euWdLV+XDkuRrlWMugITAt8duEgslJXrr/+Cok82bwInOGLdyl0qHc+/TKkbQh5GHyKXuYqcRp5vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79wmOru49VRN5FbFLIJ8d3n/d/erjfQc25w8xmb9OuA=;
 b=fGhFXTxs5OKkpCxa9Am6LfNml6a1aNIx2S56orwgUzGd3VhXAAtWJEI4Ud8Ibe7CfdLWSZxxdt2YHBuFdrVMsBwu3E4JuMQoehyis5kLbVF4cQE7xUwJZxr5iEuWb7O2Ph4EcIgcNe4paaa1rAmTI/XRJE/WWl7IwaA2E4ZWm+o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ1PR12MB6241.namprd12.prod.outlook.com (2603:10b6:a03:458::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Thu, 19 Sep
 2024 19:01:30 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7982.016; Thu, 19 Sep 2024
 19:01:30 +0000
Message-ID: <7c604018-59a3-4b70-83d1-06f0ed858b73@amd.com>
Date: Thu, 19 Sep 2024 14:01:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] acpi/x86: s2idle: call screen on and off as part
 of callbacks
To: Antheas Kapenekakis <lkml@antheas.dev>, linux-pm@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org, luke@ljones.dev, me@kylegospodneti.ch
References: <20240919171952.403745-1-lkml@antheas.dev>
 <20240919171952.403745-4-lkml@antheas.dev>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240919171952.403745-4-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0108.namprd04.prod.outlook.com
 (2603:10b6:805:f2::49) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ1PR12MB6241:EE_
X-MS-Office365-Filtering-Correlation-Id: 93e2f6f1-0704-42b4-b022-08dcd8dd7866
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RXpqb0tzYVVmYy9ZOW10K2J1RkU2QmRWbS9CSVVEOTNJaithZWRiTGtPSzBX?=
 =?utf-8?B?YUVMLzd0SDRTZGpHNVdzSU0xcnl4ZlB1enhuRlp0VVF3Mm93ajVsZ0NTY3NF?=
 =?utf-8?B?dHpsODJPd0NVVkZQUDh6WDVZSlk5TFBFR1pLeHpFeVdCeXF0M1lxNVhyeWRk?=
 =?utf-8?B?ZGJPS2NhendvU0VHWWxOVG9melYwVjYyd1EwMGJvUXFBQkJUcEgxblljSUNm?=
 =?utf-8?B?c2Nhd0dQUWl0TElnZjFkQmJVNXFQMWFFRzZMMEJtSkZUNEUybEN6VGZXVWJS?=
 =?utf-8?B?THlwNFhQeWZySzBZTzhmV3dPZjZJNTlrY3VvWnd5RldBcnNlUU9OUFRFTUx1?=
 =?utf-8?B?czY1OHFucnd2TEh4aTdpcFZVeEJZWHk2MVdvaWMwMFNJOC82QUdCeFpYUlJj?=
 =?utf-8?B?NzJQZ3RacVhGRjZ5Unh2aHBrNjlmTmQ0UnpyaHpWQ3E4Z0xHRUpiTlQ2L1Iz?=
 =?utf-8?B?OTAwdjRTNmVjanN1ZW5VR3RXN2NQU0E3ZUVyaGZZUDN3VU1COXhkbm8ycWxk?=
 =?utf-8?B?ajRsNE9FS2l5WmxNUFZ1dTFzVVhiN3hhakZxUUoxOEdoZzV6VERiY2ovK3JF?=
 =?utf-8?B?ZTBwSFo3NTJrbkx3S2QvejFVTjQ0V0lncEgwQzNTZkVGNVg3ejE1emxXNU5p?=
 =?utf-8?B?QXY3N0E0SHFkaWFpNStTTTlVT3JKTnpwZG5hdFNrb2hYUktEd05ra04zeTFq?=
 =?utf-8?B?bGk5VVJjK2hCWmd0WXdTSEJhOW9iYlUwZCtPTmxUc09udjJ3WHJFZGRPYVZ5?=
 =?utf-8?B?K1NKZXlwcFgrVEJEOVVhWVRwTE91Z0FWNjJIb3JDWVd6ci9BRWtzN0V0d0oz?=
 =?utf-8?B?Ym1qYTFwb0x0Tkp3Y0N1c2VieUNLeUdpUUlWZk5GYW1GTFI2Nnh5dnpZanl1?=
 =?utf-8?B?QTFVWEpsMW1hOE5pOUo4d3hHN1JrVTlCWGN3ZkhsOThMRHdNR1pxMTNIUXNZ?=
 =?utf-8?B?eXRJYXUzZlpEYS96djNxUnFIcG1nMU1xVHZOaHdWbnpmQWpEdkxIN012dHF3?=
 =?utf-8?B?bitzOWVEN0k2OGlscjlwcnlTRWgzQjBLd01CUk84RjJTcHFQN1RLTWREQ0k0?=
 =?utf-8?B?L0RrNTNtSWJlRTFRckF2bG1jcStxQ09UUG1KUXhIRkhXVTZKTWtmS2tWZVRF?=
 =?utf-8?B?RVRrbGNLeEErTS9HY0kzeG5WUHVIOG5xVGlyRjdCZkR1cEZJaWFaK28wdmlw?=
 =?utf-8?B?Tmw4b2dGMXlORGtMcnl1QzhkazNBdzFiVlVGRHNUVkRVaWMzQzVQT1RUcFM3?=
 =?utf-8?B?UjVVWmxiQVlsTjRxSksxQWlYc3NuU3krMmV4dXNPZjBUdE0zUHdCYnoyT2ZB?=
 =?utf-8?B?MGw1TlVTQitPbnl6MWNLNENvK1hFYmg3c2MvcjJoS01BcDhtWGhIbEpSdlI0?=
 =?utf-8?B?cTM4YnlsMERtbUlrV3dPVUFFNGxqVjVwQWtGUWZlRHZoT05xQmRSSGoweHZn?=
 =?utf-8?B?dExnY1J1QzY0R3hKNjZuS2k4cWo2YjBhMSt5dHVsT3A1VS8vcS8zZGRiTGtQ?=
 =?utf-8?B?NVhJL0VZa0d0TzRwYTlXemN0SUtNNFdJME1tQjBiOWJ4b21DOFZ3cElNMFZv?=
 =?utf-8?B?NDVaTXg4RTU3VFFldFNiZ3Qxa2dnSTBTalVWNUdSem9qaXVKQkNaclhPVENz?=
 =?utf-8?B?WWtPdkFuOFNyQUxFWjBEKzZaK2huR0JiRGN4bzRYYmNlZytvOVNwZ2NnaUpY?=
 =?utf-8?B?eFNDeXdWOGt0M3JUSDA5dko3ZGJsbmJhTjFndG1qZjByTC8vNTYrTHlRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWxxdTN0Q2lVekpLdDdzYVY0eWJqVS9oM29MSUlJbDlCT1JTcHZPdTE3Tkg5?=
 =?utf-8?B?NmR1RGpUZTdibnQzeUhFaVZXckZlUFVkM3dyRzlZeTRiZUU2S2E2SEl5SWlW?=
 =?utf-8?B?V0MrdkNkbk40b2JQekxvNmE0L0NCTGNkWXF5SnltL3gxaXU3dE51VDRxRWpJ?=
 =?utf-8?B?ODNlY2ZWUGhxajd3NXMxY09JemtjOFhnVmVJUTJvZUk4VDBJVC9ybHZiNTZ6?=
 =?utf-8?B?MW90ekpNSnJNRWtqVnEwOEIyNkVXTlJMTmpEN1dIM28yY1Y5emtMRmpUd0ZC?=
 =?utf-8?B?dEtNc05iUUlpbzlJc2pEcW1PVWJUaytleHNHd2pDNnJ5UTJ5ZG1kZGt2cHps?=
 =?utf-8?B?MXM1NGJzbFZ2QjRTNGo5NDBXN0NpNUx6WEhoU1djNkNmbUZBd2gwOEpnV1ZB?=
 =?utf-8?B?L2o4T2FBd3VrWkVDektYVHZZb2FydkZVVFpLUkpkK3pkejh6d2dCb1A3a2Zs?=
 =?utf-8?B?bytIS3JhdHJBcVhOc1VLVVdxdjl4bTJUYS83OVc4WnRzS2xBam44dS9RT1p5?=
 =?utf-8?B?OGcrTkNvNnI3Sk9zeWZzcllaVFZ4Z0dxdUFFUFh1S1ROcWtXd0pTK1hCa1VN?=
 =?utf-8?B?MGlJbE9jRlJLdTZCcU1ubW1XMXEzWGJnNStuUFJvVVRhbkd4ZnR4aUdtbEQ3?=
 =?utf-8?B?L0pOVS9lRmtGVkF2U1ZscTduanBJdUFvQWpwODF0ejBLck10eVVYSlRDNTQy?=
 =?utf-8?B?WFdSUGlKRXlmblBCZUp4UHZ3UEdxZzZNUnhnU01iMDdsd2NvS0VWcEVGNTlU?=
 =?utf-8?B?VWJ1NStsMStVSUVQQmdXTStjVm9QY2lETU54dzdpMkgwSmFIQ2ZqR3JWcFIz?=
 =?utf-8?B?cG9WcjQxNUk2TXZGSlNhVDltZGd5K3I4MXI2Uk9IUUF1SlJBTmQ4d2VXQkZi?=
 =?utf-8?B?QWhQTDMycGxkcVN0dG9jWlJYb0ZhL1d1Vy9PY2xINmIreTFCNVNsTW0xbGxx?=
 =?utf-8?B?SXpLV1V1bjBQYmV2VExvaXo2ZUdRSkxoT0h2ZEcrWWdaMmRGbDl2QVhibE9h?=
 =?utf-8?B?bDRrYjE1MXhvRzhpUldRZEgwMk5Fb2NOaXhRZm9MNnViclhYcTAvcVFocVNn?=
 =?utf-8?B?Ni9UR0tYR1k3TFcyVFhna1RNYy9rK05XbE9aeFYvOHhhNXFQMWtDZGUwS3kz?=
 =?utf-8?B?SFNodWNHS0xmRU5qckRPMC8xU3lFdlhYNm1Ua243SmQ5RHRBR3lpUnpTc0Nu?=
 =?utf-8?B?QUhwcHp0MGZTMlJVVTQ2VVN3amtOMTQxYUFvSGh0S2ZqTHFqRTJoSmwvem8r?=
 =?utf-8?B?aHBCb05kRDlvcDUrNE5GcGdYRDc5cE1yN3Z5ZG1iSVVyalp5d0NkUmdNUENH?=
 =?utf-8?B?bUs3UjAzWXo5bHFGZFZDelJka2dZSDRLYXBMTGJWYVc5SDAzZjVyVUlvWGds?=
 =?utf-8?B?Vm52aWN1M1I4UGYwUXRoTC9WeU1UelVDU3dHQ0k3OEhteHpKTVdTTUFURTZX?=
 =?utf-8?B?MDBBbzgrOWpwRUJxWE00Qi9DemFIUnA0Nmo5QjQyKzZhRVRMeEdESEtoWEdO?=
 =?utf-8?B?N1N2V0NRZ2FHbTdJSXI0MURKUVVxaXZva3lCQ0lXdW9OYllZWVd5NkMvZW9m?=
 =?utf-8?B?UEtjTVJmeCtLMW4vQmNhdkladlpYdzh0LzMvOU9QS2ZhVXc0ODhmY3huRGdO?=
 =?utf-8?B?WnQxaDFUeHppb0xiNmVLa0VMRkJZVktpQmFyMG10NW5FQ2tmYVFsMkJKVHVE?=
 =?utf-8?B?Q3pmdXNiVTRnUjJVQ21zRFpSZzdhc0x3NjYwYWpQWVllYTAvaUtScFBiSVJy?=
 =?utf-8?B?VitvSU90MVg3bnBUeE8vWEVPc3YrendGYjZNblVRTFhXdDNGeGRhREdhNEcv?=
 =?utf-8?B?Q1VFbno0L1FTbXZlTnBIUkVhOUtiSVNXcmV2eGZmbnlJUjUzODlnL1J6TDBP?=
 =?utf-8?B?bkcvandsK0NKY1U1dWpKY1Nxc2JMTi9hU3MyMXZpZG56UWRWUkFrc0QxMWIz?=
 =?utf-8?B?VlB5YlpVTEV4WWlQejhzQWE3VzlSLzJYNVZnbFJuK1pkcVNPSUJML2t4aER2?=
 =?utf-8?B?eGF6MG1uU1NjNGh5NURCSUZNME1Rb1c0VWhSTWx1SndDRHV5ZUU0S1RBWmg0?=
 =?utf-8?B?SktRYW94YmtFcU5CeHBuYkxXWmtaek5aZFg1U3JKbDYyclBQVTdxTjJHWEFw?=
 =?utf-8?Q?+5RzvYhJLUzxv0GvxLSZIk5Z7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e2f6f1-0704-42b4-b022-08dcd8dd7866
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 19:01:30.0146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RTtaLAak4dFjJ83uE5gU1rpWNHqTYdHeh3KgBZhdc9TDgveBiUqr0Kc1VQcv9SEc6iRCV7Dgx670PTPEDUdkAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6241

On 9/19/2024 12:19, Antheas Kapenekakis wrote:
> Move the screen on and off calls into dedicated callbacks that gate
> the ACPI mutex, so they can be called outside of the suspend path.
> This fixes issues on certain devices that expect kernel drivers to be
> fully active during the calls, and allows for the flexibility of calling
> them as part of a more elaborate userspace suspend sequence (such as
> with "Screen Off" in Windows Modern Standby).
> 
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>

This patch is inspired by my patch
https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/commit/?h=superm1/dsm-screen-on-off&id=e1a274ee7634f0f8fb877990df6d884189065228

So in a future revision I would appreciate a Suggested-by: tag.

> ---
>   drivers/acpi/x86/s2idle.c | 72 +++++++++++++++++++++++++++++++--------
>   1 file changed, 57 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index dd0b40b9bbe8..aa448ed58077 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -60,6 +60,7 @@ static int lps0_dsm_func_mask;
>   static guid_t lps0_dsm_guid_microsoft;
>   static int lps0_dsm_func_mask_microsoft;
>   static int lps0_dsm_state;
> +static bool lsp0_dsm_in_screen_off;

It seems that this new variable is mostly for debugging purpose.  If the 
variable stays I think that you should fail the screen_off/screen_on 
calls with it.  More details below.

>   
>   /* Device constraint entry structure */
>   struct lpi_device_info {
> @@ -539,15 +540,19 @@ static struct acpi_scan_handler lps0_handler = {
>   	.attach = lps0_device_attach,
>   };
>   
> -int acpi_s2idle_prepare_late(void)
> +static int acpi_s2idle_screen_off(void)
>   {
> -	struct acpi_s2idle_dev_ops *handler;
> -
>   	if (!lps0_device_handle || sleep_no_lps0)
>   		return 0;
>   
> -	if (pm_debug_messages_on)
> -		lpi_check_constraints();
> +	if (lsp0_dsm_in_screen_off) {
> +		acpi_handle_info(lps0_device_handle,
> +				"called screen off call twice before calling screen on.\n");
> +		// fallthrough for debugging, calling twice should be gated by the caller

It seems like it would mostly be a programmer error if it was called twice.

How about something like this:

if (unlikely(WARN_ON(lsp0_dsm_in_screen_off)))
	return -EINVAL;

You could do something similar with the inverse in the other call site 
too then.

> +	}
> +
> +	lsp0_dsm_in_screen_off = true;
> +	acpi_scan_lock_acquire();
>   
>   	/* Screen off */
>   	if (lps0_dsm_func_mask > 0)
> @@ -560,6 +565,50 @@ int acpi_s2idle_prepare_late(void)
>   		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF,
>   				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
>   
> +	acpi_scan_lock_release();
> +
> +	return 0;
> +}
> +
> +static int acpi_s2idle_screen_on(void)
> +{
> +	if (!lps0_device_handle || sleep_no_lps0)
> +		return 0;
> +
> +	if (!lsp0_dsm_in_screen_off) {
> +		acpi_handle_info(lps0_device_handle,
> +				"called screen on before calling screen off.\n");
> +		// fallthrough for debugging, calling twice should be gated by the caller
> +	}
> +
> +	lsp0_dsm_in_screen_off = false;
> +	acpi_scan_lock_acquire();
> +
> +	/* Screen on */
> +	if (lps0_dsm_func_mask_microsoft > 0)
> +		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON,
> +				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
> +	if (lps0_dsm_func_mask > 0)
> +		acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
> +					ACPI_LPS0_SCREEN_ON_AMD :
> +					ACPI_LPS0_SCREEN_ON,
> +					lps0_dsm_func_mask, lps0_dsm_guid);
> +
> +	acpi_scan_lock_release();
> +
> +	return 0;
> +}
> +
> +int acpi_s2idle_prepare_late(void)
> +{
> +	struct acpi_s2idle_dev_ops *handler;
> +
> +	if (!lps0_device_handle || sleep_no_lps0)
> +		return 0;
> +
> +	if (pm_debug_messages_on)
> +		lpi_check_constraints();
> +
>   	/* LPS0 entry */
>   	if (lps0_dsm_func_mask > 0 && acpi_s2idle_vendor_amd())
>   		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY_AMD,
> @@ -623,19 +672,10 @@ void acpi_s2idle_restore_early(void)
>   		acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_EXIT,
>   				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
>   	}
> -
> -	/* Screen on */
> -	if (lps0_dsm_func_mask_microsoft > 0)
> -		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON,
> -				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
> -	if (lps0_dsm_func_mask > 0)
> -		acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
> -					ACPI_LPS0_SCREEN_ON_AMD :
> -					ACPI_LPS0_SCREEN_ON,
> -					lps0_dsm_func_mask, lps0_dsm_guid);
>   }
>   
>   static const struct platform_s2idle_ops acpi_s2idle_ops_lps0 = {
> +	.screen_off = acpi_s2idle_screen_off,
>   	.begin = acpi_s2idle_begin,
>   	.prepare = acpi_s2idle_prepare,
>   	.prepare_late = acpi_s2idle_prepare_late,
> @@ -644,10 +684,12 @@ static const struct platform_s2idle_ops acpi_s2idle_ops_lps0 = {
>   	.restore_early = acpi_s2idle_restore_early,
>   	.restore = acpi_s2idle_restore,
>   	.end = acpi_s2idle_end,
> +	.screen_on = acpi_s2idle_screen_on,
>   };
>   
>   void __init acpi_s2idle_setup(void)
>   {
> +	lsp0_dsm_in_screen_off = false;

Doesn't it initialize to false already?  Is this really needed?

>   	acpi_scan_add_handler(&lps0_handler);
>   	s2idle_set_ops(&acpi_s2idle_ops_lps0);
>   }


