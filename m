Return-Path: <linux-pm+bounces-6811-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD9E8AD011
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 17:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0641D2834DD
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 15:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CC7152190;
	Mon, 22 Apr 2024 15:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T+PZlCOb"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F218F15217D
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 15:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713798161; cv=fail; b=sZvTTLATHa2q+er3WNN3EZJ4r3ZXAxrOjoc3hOmB4meH0yyQkxezXtt5woaTp1KxzptBHlqlVPG5tYlZFktmEqgaZP9PP4+ezk8i2DfAvwClavlmFgpmeEusnq18S3T5UbQ+0ur1WH9ULWlaFi2l7+uOnh4xDKG2oePaCvpmjIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713798161; c=relaxed/simple;
	bh=FlAgQM0KNL4E1WgdC2UqW1Jbt/hDUETHWVE9dOq9+2Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mV6DDTcznMsPoqzA0azHd2jnoPYjvMNLEr3w+xfOoF3HvC5wc5dxtgw/oJcha8oKyGpnb/RdbchYCUYoq7Asr8tLOVrcgA5mms/hwtPh2/dwtmYXK0QJjM1JApjd3I6IzSamduI/ImMLQOfy/flOXUO8Mf2fTG7EP8AFwc/2RWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=T+PZlCOb; arc=fail smtp.client-ip=40.107.220.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jtWOTCwrktHHdW6yFjcgodJFiMDo7v+oOmvfNBDq373LmMVYpiyvhgYr7uVXsF4zoroKYD2n3sKDw9xECHujn5V4CCyCIABTPAPFp7IFdQS56QI6WIIVHxuD5hDdLnauXunEzLULv75R2RiYSxRAB3eOTk1SQHV/l6L5fVeN1A966cL553gva+j8TQy9CT7eljCGfro+0bvu3WwH5qLcGHUtU+HWCpl5uab6yRhpO6KG54h/xzSJKg4dZMrKr+9C3u5e1SqOuOihxL3XN6xMckqJwifp9q/ZpZGOGUQqp4Ifd64M5eS9MND+PdeF2tBTdKRJozU/H7xE20iY1isJ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GiVvL7UIMqPS+Eq0NaWe8KcUIfCJZM+1enE+iTqY0lE=;
 b=h0EoP/AxD6NeB14xm6QlnTyg8DML7ELV63MFojhJqDDWfsfyPBcC0DF25z5C7YERKMKAaV7AbcP70evQORD6mvWlCLT0+5hbfGymwL8+rJ2eUgO7WhDmvXqq5CGTr/jxesZc9+p3axEqyzeAmkz2zYts1aY/HgvG4KjBeLd5RovFK3wCDliKehWOezHRI0T7vrCnsxuv37cr02VoZkc1YMxSIccxQJWe1B1wmRh545PqBnHTh/kkopDtOa3rlW4tNUq9Ubl4Bgg8pvMFY5edIrUF7JNw84fHHfAjUVZi/OqY1H97/jpnAZQIG6zSXu8QHtZtTSJWXjtRzJ2uTl9xog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GiVvL7UIMqPS+Eq0NaWe8KcUIfCJZM+1enE+iTqY0lE=;
 b=T+PZlCObjp3mDbOImZs/lb48a0zeL0hxpe7aWUEUigQ2oxCcn7uculE46/NjAULeIm1riimAA/7r6rnd9wsVwH+61klA3qYHKGa0g5SJl3oY0TXGsCXh3Z64uZFb8QIZX65Gg3bnNFF3BXkjdRUh+VxObNUeO1BR8SEIXBKsuh8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB5951.namprd12.prod.outlook.com (2603:10b6:510:1da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:01:06 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::d9b0:364f:335d:bb5b]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::d9b0:364f:335d:bb5b%4]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 15:01:06 +0000
Message-ID: <2888cd41-65d9-4832-a913-399a074de7a9@amd.com>
Date: Mon, 22 Apr 2024 10:01:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "include/linux/suspend.h: Only show pm_pr_dbg
 messages at suspend/resume"
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: xiongxin <xiongxin@kylinos.cn>, len.brown@intel.com, pavel@ucw.cz,
 linux-pm@vger.kernel.org
References: <20240422093619.118278-1-xiongxin@kylinos.cn>
 <37847b26-1c1e-48d3-a74e-bd2bcc6e1fda@amd.com>
 <CAJZ5v0gmF0Lcy_nHSvTDnu4C3N0mipaeJqHff=00fgWdtwOzMw@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0gmF0Lcy_nHSvTDnu4C3N0mipaeJqHff=00fgWdtwOzMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0050.namprd04.prod.outlook.com
 (2603:10b6:806:120::25) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB5951:EE_
X-MS-Office365-Filtering-Correlation-Id: 395fed7a-0a4b-4c9a-233f-08dc62dd0907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZkhpR3ZlUWY0Vk5Sc25JWUJlTG1DTlhWT2FIV2hjbTF3RWVtdmJseFFUV3Ar?=
 =?utf-8?B?YzhtcTRHVXhwVUJMOFhrdW1PVWQwUUxxbnVlaUVtYWZqWWtyY2I5b2x4TG5F?=
 =?utf-8?B?SVBuREtJN3M2RDN5VHdHREdndEc1akdxb2lRbXkvYU9mTWpwR051M3hFR2tB?=
 =?utf-8?B?RTg3V2pmc2FBRG0yZGJHMkt3YU95eUNLc3Nyck1wVWpLV0N6dEZkL09GUDNG?=
 =?utf-8?B?cW5Cd3N0S2JxbFpBem0wM3k3bDluek1xS3RXTHNNZ0UvLzI2dEhIeUxNYWho?=
 =?utf-8?B?RnVwYnpjNldBckdXZGlvOGVYd2pRMG56MHFLTlJaSUpUVGtGQnM4Z01JNjlE?=
 =?utf-8?B?WVpSN2k3VWRmdUxEdU41WWYzODUvRUdTU3Yzb1dPSUV0eThKNktXN0JJb2FY?=
 =?utf-8?B?Q3dNMnkwbkNrY2FCd0pUbldxa3A3ZERlT0s3aHFxNVVobUs5MldzWHh3MTFE?=
 =?utf-8?B?VEtpY08xajk0bDdHYzd1VUJXRHlKUUFXNWk0aVRBbjZBVW4rVW5ieTVPR05v?=
 =?utf-8?B?ajdVbGxubkVTaGN6YWZ1RTk3TXU0TTdtM0daVldLTEc0V1ZjNGxHejFERHRu?=
 =?utf-8?B?dUZnS25KQlVlbHhmUjduM21JWTdOZ3VBNkhkUFJjRlRRZ1d3MmkyMm8wL0wr?=
 =?utf-8?B?VU1OSHBrRGVLK1JTdnFvWlhIclJGL3lHdEYzVnZ0T2xCUEgvdVUzckJiZk5I?=
 =?utf-8?B?ZzdZV3JsN1FEMlRMYjZsNm9WTitDNC9BNGphM3R3YjVLOEVWZ2ZjMU8wK3kz?=
 =?utf-8?B?WGNzOXFUalo1R2hpWHZMU0k3ek9VWVpaL0NOZ1pOWGRJR2ZvY3N4OUNQeWJs?=
 =?utf-8?B?bmUzV3pMei9QZEo0ZHV4T2Q2aW9sMG0wUVAybkdFeTJDanczMjB5cUVDRmxB?=
 =?utf-8?B?YVE1elB2YXlJVXRnQVgxZmVtZjlOTGRlcXY4c0t2ViswL1VtbHpjRUVsMmp4?=
 =?utf-8?B?MmFIZktwQWh5ZEk5QU9zS21pWndsWWJybmJHb3FaSTIrT2grdUpyUFN3dUpH?=
 =?utf-8?B?MGpCVWcwVEZVbmxVMEFndHNpaEM2ZmtHekZqZTJqZGk5eHhlVmxXbFJwT01V?=
 =?utf-8?B?bm50UFdHbUhKRzhndFpWZ0dKRTBvTkExVkpIV0VNUkxKcm5mVlkzZ04wY3lM?=
 =?utf-8?B?Qy9wZVlUQjVkU1ZheWFNQ2hjOEs0Snk2d01Odk5ETjFJR3NDWm0xZ0dkamEw?=
 =?utf-8?B?dk5ZbXhlZlFzbG1TN01YcktNMkNjL29MVFgrSmU5M3dYeEJEYjNNRytJMERE?=
 =?utf-8?B?UUdSM3VETXBQa1plMEgrUlpVRmpOUjJGVGgrWHhoVG5BQ1ZHSE5aak5NZWha?=
 =?utf-8?B?V1ZYY2Y5dFlXdWlVRnNuWmU1UHlOcG1RT3dnVDlGNitEa0xiMERjN2FZWGFE?=
 =?utf-8?B?c0xoTktuL01FQzNIZVNQRjRNSy9Ic1hVTTZCZEs1V0pkYlk5ZStyYlhaajVI?=
 =?utf-8?B?SVY3amNRcC9YckJrcFBoOHJjWGNtR0cxUUhGQks2by9sQ2NLRmdYd0Flekcy?=
 =?utf-8?B?MUJyVUpIdzVzcTZwMEZLVkNQVndJSHAyQ1B6dkdPRFBYQlpXTTNWWldIaTBl?=
 =?utf-8?B?cjhmZms2MkRzRFRZbWtxV2piVmszUDdwdUx0Wmkyelh0REN4Y2IzcVdVVFcw?=
 =?utf-8?B?SUQ1bHVwRGxybGFKcjZVanl1WXVkL1R4ZXVZZExKcXUwSTFhM3JJOGUrMGEx?=
 =?utf-8?B?VW5yNUdLVnROdlhOcDUvOG45QXNDWThpUWNLcldjYVBFWmZ6NFAybVBBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDVidSsxNStWYmNDV3l3MmFRUnJqMkRDUGpoVjFWRGZxWlFVb1B3V2w4emly?=
 =?utf-8?B?c05ObCtvVXd5bWhjY1I1TDhlS0x3OGttNm1PTS9XQUdoSUZjYTlMTkRLMXpn?=
 =?utf-8?B?c1ptZjI4U2RJb3RsVHd0Mm5YSUpqeUdyR0RNUkFOaXNsSnlDT0IyYXFWUkpu?=
 =?utf-8?B?VmFGUU9SZXhYVkVCaWlCaTR6VDJ4UWNEeWk4cmFLR3pQV0FEejFScFhWRzFm?=
 =?utf-8?B?QWFHTHc4T05yZW11OFVtaE1YSzZtUFpGakhPQTRvR3J4Q1Q1VnQ3b1puVW9Z?=
 =?utf-8?B?cFE0bmwwTEpsMytEVVYzdnBYTm9EWldMMkl2K1RJdllQM20xRXRMQ2hSMytX?=
 =?utf-8?B?Nm9VdUdqdlRUaFJwcTE0TkxKWStBTGhYNXdCUFNIa2JmNWZ3MXkrUWFDbmVH?=
 =?utf-8?B?VVI1Um1IVDhSMnB5Z1AzNDRHbEV5N0hqcXlvUzRrLzQwL2RQYXhNK2cwY2dS?=
 =?utf-8?B?TE5lOVI3ZmlnS1dveC8xZFNLUGVuWW44OVExMUlyUm9hWk1NT2JwdDN4NnBa?=
 =?utf-8?B?TUorMnY0aFVqS0RlLzRHYWJyTE5vbnA2MUNZL1VPcFdIbVdNVndoRFBRUGNJ?=
 =?utf-8?B?VTVVT0FGdnkyV09BTlBsRWV0UVN6Lys0VTl1cnpnMFpSS2NuVHBCRjlybUN6?=
 =?utf-8?B?SmJqbzN3R1lKUEowdzlydW1ZRHlJV29kQ0xSWk5XMHBwQUVwNnl4TGIvZkht?=
 =?utf-8?B?UWt5czhYZk4vUjkwM1N1WkdTeVhrSjd2REc2OXNXSlhNR3k2WGp1cjRYSUls?=
 =?utf-8?B?dFc2MC9LS3FKZUZBeVV2SGZWOTEzN0RTTk1hb0w1VDNvYUJvMjNpSVZQM3pa?=
 =?utf-8?B?QjFtamRCbEJNdVNYWDNFNW5rZVN4ZEhpTldOOGxWOURhYVZYOXJTOTM3ZE1S?=
 =?utf-8?B?Z0RrSmVRam5CZWhHK0E2K0xXZ3B4bzl1bGVQeXRhbGNLbWgxSStTK0JjS1pX?=
 =?utf-8?B?TmFScE9wQ003MWxPM0w2L1plWFRYV1NKaXpUVEE5a3pnRFhhZlFQY0JFZ0Mz?=
 =?utf-8?B?R28wZnVIUlhoR091b0xtL1RFY29Sc204N2hPMDNEb1ZZQytkU2xqVjZZR21C?=
 =?utf-8?B?b2NkTnh0NEppNTFJSU4rRjNOMFcrem1GVDBTZnBWWmYzZklCaVFwclR4UFdL?=
 =?utf-8?B?czNqMW14bVVCcXlmRzU2K0F6MU1zTnd2TGVCTFRpSUtIWXptdnBXeHdCMjZn?=
 =?utf-8?B?eXprakVzSVplejYxdXF5UnhsVmtOQU83RFVra1ZRM0M3V25vM1RsajRNMzAz?=
 =?utf-8?B?MnNoSURwckIzVnp0Vis0NDRUYlJPL2xnZHlGWVhTMmV5NmxHbWpHZXdVZ2x0?=
 =?utf-8?B?eXk5MUdXdzV5THk2Y2gvOXMzQ2xqbmUwMHZEZTh2VUtOSC9oQ3FPMjRWT1hm?=
 =?utf-8?B?YkRrNGF4RHc5OUVBMGJzbU55cUJyNVMrRGZGVjNFdE9JRHJMaERJZVpIU2Ez?=
 =?utf-8?B?N0I3bFNLWk5sWkUzMm9qV01kQ09YeUNKdk50T0p6eGhRUWJCamR4UndxYndj?=
 =?utf-8?B?aG9aUXhRQ1o5UjhraWd1NmtTeThDVTVpUzcwR0UrSlY2RGUwd0pERzR1eGJC?=
 =?utf-8?B?RENOUkpMTDJXVmhKZ2cybG5BanBLS3pJcmdSSWgxUGJNT1A4Z2JvSndobThn?=
 =?utf-8?B?YTBMRCtaazI2cFRvb1JVUllMcEZhTmkvMFFjLzZMU0dKa2lqTWhrc3VHYWFp?=
 =?utf-8?B?bSsrQUtTR3R5VEVVSS9Dak9NZllRamY2eVduajNlZm9ibmVaQXRNQlcvNUtp?=
 =?utf-8?B?enQyMFBSVENnU1BNQ3FMNnVPb2M2Q1pLU2dPckhIc2l6RC9lQ1VJY21PdG1Y?=
 =?utf-8?B?d1VhVml4V1FQNi9NL3NHUklFMmFNeFl0U2RvQW53VGVpL05XTk1EY3AxOVZS?=
 =?utf-8?B?azRUdC8xWFNzaUlPOVVoNkVPbzg0cWpUMGw1eFk2bFV2bHUxNkhlZzFpWlNM?=
 =?utf-8?B?WU56NE9NNGxFaXZtMFhtRnA0Wnk5N2J6TkFhZjEybm8zai90bUxQMzZwNWpa?=
 =?utf-8?B?MlNMS1dHb2pvajhUdnA5YTJyZE4wcit2S3BRQXVDZmRSckxlMVo1Zmcxd2o2?=
 =?utf-8?B?aHV1WEpMYytwWmQxQUxzeVk1aEZQV3IzcmNwR2I0YnNueWNoQ21QTGxoZFND?=
 =?utf-8?Q?CdjFW8xTOgKvKbchVHsptruiZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 395fed7a-0a4b-4c9a-233f-08dc62dd0907
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:01:05.9857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BpLxrBj5ETyAS6xLFyU06G18QHGKcvgjs4Qxa3HeZCfb58LuGMlkMYDc8GaPnxaXQSmhgkLKcBGttb8Xu9tlHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5951

On 4/22/2024 09:45, Rafael J. Wysocki wrote:
> On Mon, Apr 22, 2024 at 4:33 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> On 4/22/2024 04:36, xiongxin wrote:
>>> This reverts commit cdb8c100d8a4b4e31c829724e40b4fdf32977cce.
>>>
>>> In the suspend process, pm_pr_dbg() is called before setting
>>> pm_suspend_target_state. As a result, this part of the log cannot be
>>> output.
>>>
>>> pm_pr_dbg() also outputs debug logs for hibernate, but
>>> pm_suspend_target_state is not set, resulting in hibernate debug logs
>>> can only be output through dynamic debug, which is very inconvenient.
>>
>> As an alternative, how about exporting and renaming the variable
>> in_suspend in kernel/power/hibernate.c and considering that to tell if
>> the hibernate process is going on?
>>
>> Then it should work just the same as it does at suspend.
> 
> Well, this is not the only part that stopped working AFAICS.  I'll
> queue up the revert.

I just tested the revert to see what happens to other drivers but it's 
going to have more collateral damage.

ERROR: modpost: "pm_debug_messages_on" 
[drivers/platform/x86/amd/pmc/amd-pmc.ko] undefined!

> 
> Thanks!
> 
>>>
>>> Signed-off-by: xiongxin <xiongxin@kylinos.cn>
>>>
>>> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
>>> index da6ebca3ff77..415483b89b11 100644
>>> --- a/include/linux/suspend.h
>>> +++ b/include/linux/suspend.h
>>> @@ -503,7 +503,6 @@ static inline void unlock_system_sleep(unsigned int flags) {}
>>>    #ifdef CONFIG_PM_SLEEP_DEBUG
>>>    extern bool pm_print_times_enabled;
>>>    extern bool pm_debug_messages_on;
>>> -extern bool pm_debug_messages_should_print(void);
>>>    static inline int pm_dyn_debug_messages_on(void)
>>>    {
>>>    #ifdef CONFIG_DYNAMIC_DEBUG
>>> @@ -517,14 +516,14 @@ static inline int pm_dyn_debug_messages_on(void)
>>>    #endif
>>>    #define __pm_pr_dbg(fmt, ...)                                       \
>>>        do {                                                    \
>>> -             if (pm_debug_messages_should_print())           \
>>> +             if (pm_debug_messages_on)                       \
>>>                        printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__);  \
>>>                else if (pm_dyn_debug_messages_on())            \
>>>                        pr_debug(fmt, ##__VA_ARGS__);   \
>>>        } while (0)
>>>    #define __pm_deferred_pr_dbg(fmt, ...)                              \
>>>        do {                                                    \
>>> -             if (pm_debug_messages_should_print())           \
>>> +             if (pm_debug_messages_on)                       \
>>>                        printk_deferred(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__); \
>>>        } while (0)
>>>    #else
>>> @@ -542,8 +541,7 @@ static inline int pm_dyn_debug_messages_on(void)
>>>    /**
>>>     * pm_pr_dbg - print pm sleep debug messages
>>>     *
>>> - * If pm_debug_messages_on is enabled and the system is entering/leaving
>>> - *      suspend, print message.
>>> + * If pm_debug_messages_on is enabled, print message.
>>>     * If pm_debug_messages_on is disabled and CONFIG_DYNAMIC_DEBUG is enabled,
>>>     *  print message only from instances explicitly enabled on dynamic debug's
>>>     *  control.
>>> diff --git a/kernel/power/main.c b/kernel/power/main.c
>>> index a9e0693aaf69..aa754241aaa6 100644
>>> --- a/kernel/power/main.c
>>> +++ b/kernel/power/main.c
>>> @@ -611,12 +611,6 @@ power_attr_ro(pm_wakeup_irq);
>>>
>>>    bool pm_debug_messages_on __read_mostly;
>>>
>>> -bool pm_debug_messages_should_print(void)
>>> -{
>>> -     return pm_debug_messages_on && pm_suspend_target_state != PM_SUSPEND_ON;
>>> -}
>>> -EXPORT_SYMBOL_GPL(pm_debug_messages_should_print);
>>> -
>>>    static ssize_t pm_debug_messages_show(struct kobject *kobj,
>>>                                      struct kobj_attribute *attr, char *buf)
>>>    {
>>


