Return-Path: <linux-pm+bounces-38700-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F3BC899FE
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 12:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6F9964E398C
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 11:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A011324B38;
	Wed, 26 Nov 2025 11:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="nbkvzPIy"
X-Original-To: linux-pm@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012013.outbound.protection.outlook.com [40.107.75.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF79EED8;
	Wed, 26 Nov 2025 11:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764158360; cv=fail; b=qDLPrLJTIGWFG7CtkiyLtR41otwDYkMLIWhJvlTZRdiGwludq+ZTLYTJVxs3H7tS1QE2EW+6xhMqbu9wP4VtgCYzVhOKLxmFhaHGQWUCUWTk127HZUa0kjw7k8hC1xIKAuFQjButCIwpfe1gboZbONXVnL4hAovPpEY2xGDv06k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764158360; c=relaxed/simple;
	bh=vP5kl8A/o+F23ltAISMpBjU8fEMYMzj2KwCy20degiE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mxYG7W26c/tTTF9VpjOxhobca4v/ArbZfi97CmL47shjj+hyECeN2YpFOPhGvSph9fEN89vK4buVR6KmHGuYBBOFTEcnsTWw4G1uWeRhzm2+n+PCJD7mtUPKh9AGdsLOw9R1zgNqYmR9+SrYrJKA4zu2SiojC172PgJdhw6LJi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=nbkvzPIy; arc=fail smtp.client-ip=40.107.75.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fhvalD1D2Hr+2huGvwf4FbN2Im+NFa/dE76UhYBMS5Jnet3sbZWxFHUDRxRHwg6MGrld8bUERrwL+DLmGD37K/va2fsJGpzCHvU1464Y2tJHQjg4yL1LtBH6GAjhvv92d+d/vVbi0Oz7LPe0EJX6NMqwBgxjyLnw0gSCAWK+Y1sryLGjyu7wgNnL7QIjPUmB2CcG4QpwOZhDLsBumYgOdOZYcnEvzlA2qxLYy3ftnOoHvN0AbgET30j65gAvXgUjDT21JLSlL0KoR4V7gwSZNMuD3ZoIn0z61MaB+NlwwUs4rpb7ySJPhggyj/aXejaAI62uKDbhvkZSPFn6XQTDMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1TTKUmJlS0gcdjsjF1mgUGER0i2YJumfXS0pY0Oucw=;
 b=Az0BGef1uZnNiZ4tPhOOfC1XWU5oJ5G1k+0xeIKTu0GuBoF/7eu5ijv4+hP3FJ88rp4Q5ACc0WQkttfLm8x/5mUHUPIfzGUdi3TP5M6xSGzAwMJIhuhUl5p6VuqOEtoRfL746QRBDeNAXulRsMRdKhvfND+T8Zxh/GuFI6WsfRXzSR1Ysn+LqWQoAhbcv37oP6LMxevKYTzSXr8AYuoyy5TW7u7jFVK0LXvpw1KMfXdB1nkaN00RphQtqzObYr5DnNagmCA/RXfLmp5DWPJpfjQAuWP/RSLBeeJnBxOfRGDNPzNpRnGJXFy9ylkUg2oTzJvgSaADYjTrRSLwSgxFQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1TTKUmJlS0gcdjsjF1mgUGER0i2YJumfXS0pY0Oucw=;
 b=nbkvzPIy/S0poWb79j8UVNdiV2K1I60dLE7KUvZ1sXfeVVPgC/VwWOXXPfL6tiwHFKK9LAI5fJmBtalBzLSm1/JDZVBsmtflTsHUm/lE9JqK47cnPMu1LA3ajrkw7H16zQ8xI73Df7Z8c32J6NHIAIE9C9vTZ8jsDOFphgBtjumPKqXeXLt1qhizjm9wQnbpqZrqqB1I4VYB3xZqbSYGKJnS5i2WwMbcSoVR86nI2Z3sJ8+YhTdvelCh9n2WRxpssr0nkhNh/5wgfnX/71YZZKQ6WF4bEUivVMzzBUNrlHpJbuIgozHynO70jlwn/b+QmWKFB6ZeLYon2OrIDqQKIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB7422.apcprd06.prod.outlook.com (2603:1096:990:aa::10)
 by JH0PR06MB6437.apcprd06.prod.outlook.com (2603:1096:990:2d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.14; Wed, 26 Nov
 2025 11:59:12 +0000
Received: from JH0PR06MB7422.apcprd06.prod.outlook.com
 ([fe80::4ab5:337f:ef41:adc8]) by JH0PR06MB7422.apcprd06.prod.outlook.com
 ([fe80::4ab5:337f:ef41:adc8%6]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 11:59:12 +0000
Message-ID: <1a2d2059-0548-4c5f-a986-5081447c3325@vivo.com>
Date: Wed, 26 Nov 2025 19:59:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PM: runtime: Fix I/O hang due to race between resume
 and runtime disable
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20251126101636.205505-1-yang.yang@vivo.com>
 <20251126101636.205505-2-yang.yang@vivo.com>
 <CAJZ5v0i1YLiri9oiiq2W6_KSbqGuWOqdrMPrOf=do-DdW=_rfA@mail.gmail.com>
Content-Language: en-US
From: YangYang <yang.yang@vivo.com>
In-Reply-To: <CAJZ5v0i1YLiri9oiiq2W6_KSbqGuWOqdrMPrOf=do-DdW=_rfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To JH0PR06MB7422.apcprd06.prod.outlook.com
 (2603:1096:990:aa::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB7422:EE_|JH0PR06MB6437:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c03e70f-0aee-454d-ba15-08de2ce336c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MW13RlMwZzhZbE9yc04zY1ExVmFGUWcreTJHK0xMazdOeTRaNHRPK1E3eHVq?=
 =?utf-8?B?WWpaOWV4UVpoQnEvdU5uN0JvVG9CWGJCNDk5L2czUVVRTzYzOWtwcHNtd3px?=
 =?utf-8?B?Y3Vxc25nWXU2aTAwbFIvSS91c2VZZUJhMHVkR25seHdLR0JxeEc0S1Z0bW5q?=
 =?utf-8?B?KzI0QVNVK0FXd1dYU0swZTBCY1Y3VzQrUXAyRFU2M1M5V3dCb3gxUXljcVVM?=
 =?utf-8?B?NHAxTUc4OHN6anJRdWMwSFVxa0ovKzdURlc5OGo1MzVCeVAwc1d4UVpxZDJx?=
 =?utf-8?B?eDB1V0JMdmFFc2U2cWUweW5WeE9pZit3ZUZZVVdTdWU3d2pLdlhKalZtWFU4?=
 =?utf-8?B?SCtxa05lajBSS3p0dXFkck92SEFlSExObm0vcGdHSzluQStvb0lBNGtqeEs1?=
 =?utf-8?B?UDc5NjNMcngxNURFbmtmbjRqQTJIUnlkQ2I5RktkTDNlZE1aWnR2cmZ3TVVB?=
 =?utf-8?B?NGZBRFVQQWk5aTBrNTlnOWRVNVN2ZFY4cE03RC9seE4rUFNPWE05UUtjNVBw?=
 =?utf-8?B?dGkwZW1QeW1LQ3VhbHFnM2QyR1J1ZnVzUEtvMlpEdnlkUkg3cWgxTGp4bnll?=
 =?utf-8?B?bUFEWVIxcVNLOTJKRFZobjkyZkRpM2h2V0ZYc1FaNDMvbTRNL3p3cmJtZ1E4?=
 =?utf-8?B?MW9mYTMvS2VSNWxnTDl0NXpNeGN0bDJnTHJicjhLbGpLOGJhS2Y2UmZHcGtm?=
 =?utf-8?B?ekIrMFU1RUlsY21KcjhhQ25oazBUT282RjFyVHhJUFEyU2tRWE1ZTUlIdFRC?=
 =?utf-8?B?WS8ybzJJYTV2aTE3QWwrQ0c0TGlmZHpwUC84S01oL3o3WHJVZnB2dmNwaGVJ?=
 =?utf-8?B?SVdCb1dxSXJ6VU9BUTBoL1g3Z1diOEU3ZHpGSFpVZ25kbFdIUWNpV284SjFy?=
 =?utf-8?B?QmRlTHAySWZjaWRPYWpPdkV5QlFLUytmLzJhS0t4TkxmZUlCaDIwWEp2RFkw?=
 =?utf-8?B?emE3WWFHclIzR2dYSngrSFVTcHR1MVBrQ0NiRWErb0prNWVucU9OWWZvR2RV?=
 =?utf-8?B?d3hVK3lTeVhoU0FuTXpmRFRjKzd0bTB6UGtBNUxEd0NUM2NEa3k3OHgxTDV0?=
 =?utf-8?B?ZnZqTTVBb0FqbzYrN2hxQS8xQzNCOFlsbmRwTGRSR2ZVbng4UUgrS3ZCMEt4?=
 =?utf-8?B?bXY0UHVzVFhnbW1adUpyNEFkNnFlNkxydThBSGNvVXAyNUFZbXorQjFHeXEr?=
 =?utf-8?B?aUVTUTlJazlkeExCYUt6d3h6SXo3RXRvcXJFQnRwMXd2QVZqZE1WS29LQU12?=
 =?utf-8?B?VFJYV1JUeHFEMVRFR3NwWlp0ZW1qdVRoOExPZVVxcW9KZFdwNVpOT3JSSGlz?=
 =?utf-8?B?MC9ZeTZJZGc0TzBwSjRzUkIwWFlxVXhpUlc1L3p5WllFTVJIVmMrVmQrcTdU?=
 =?utf-8?B?cHl5VENoZDY5MDdxM01qTHBVRHdyK3VHaVZVU3pkRmN0eWpyc3B3aS83WjFQ?=
 =?utf-8?B?aTF6YVUxWWZ4Si85R1NVQi9lZHYzK21kMzJoNDNkQWZkdFNVb2dva1pFNmsy?=
 =?utf-8?B?V0tyVHJxVW5jaFVZSnhGempXcTBwZ1dLdFhwa3RjOWpXb3dwSDczaTN4OThZ?=
 =?utf-8?B?a211YlNvcUhwOTVtS2pMcXJVQ2hVazdrcngwYmxYTHhvTjhVRFR1VkIrK2VO?=
 =?utf-8?B?em9uK0hmZWtqdWpnbVBXS0JYMTJLaThDWVZRY1NOMGhHaHJGOFVxNi9PWWlo?=
 =?utf-8?B?UWRVK29yYVJWdFRRYUc3TmhHbjVZL2RKOEI4QzEyMmRvZitQdjk3UVZCb3Rk?=
 =?utf-8?B?YWx1T3cyZGVZRlRRMmFUOXFxaVFuNGV1U2RFVUhkU0ZnZzI4S1U3SUpOQklG?=
 =?utf-8?B?UWpyYVVyR1hqRUI3azZ0UXErbUZBZ09MSStCbTl3SlhxQWN4dXIrY2h6Unls?=
 =?utf-8?B?c3dNa3hwRGpzY2xyRWI4cm1zZml3b3VSaS9Dd29YbEplYU1mUEgzcTlVeHhK?=
 =?utf-8?Q?mHO/eUVd0izKxWJBX349AeXIfjxPnKqv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB7422.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KzZIcDJLYzBuTjFrUHRFQU4yUVNMQkllSFBTUDdYbWplMkJ3M0t6aElJc2ZK?=
 =?utf-8?B?aDRPWitkaS9ZbzBOM0ZkMGJ6bGExOFpKd2l1QWhONG0xWFBlWEg5bDdZVmpi?=
 =?utf-8?B?V3B4UTFRb25ycHZlK1JqQktOR25GQVVqa3NoYWxPWHMwbjhIY0xjTWlJUFpz?=
 =?utf-8?B?Zzl1dWV2SnNWblV3SmdDZmhTZVFoTTc2eWpKcUVHYUNXT3NsZnJIN0VSZUsz?=
 =?utf-8?B?cXpvUlg4bFBJcDRMT1RwR1R4YlBJVjE4OVVDSTd3SlQxZXV4ZlhGMGFpY01Q?=
 =?utf-8?B?ZWwzUENPZlNJQ0VNczBvbTJyRDJrQit4a1NVMjFmb3d3L3pYd3lIYTB4Rmhs?=
 =?utf-8?B?bXdrKzFPVmxhb1I2cXp5MXZnQm5qZkdFSjRhVUtDK3pCRGttV2t0QnpuRnZh?=
 =?utf-8?B?UklSSDFKdzducXB4Wk0xa2htdXczMXJsc0lCUjFVTHZLZHhiNnBTdk01OCtM?=
 =?utf-8?B?dlFUMmxsekNMY0c3NlQySVkyVHRESEJ1bXVQblFrWlByc3NSZ0VkYjlnbUJi?=
 =?utf-8?B?dXBvNjJhc2p3ak0zZVkxR0lNZDNkRFB3eTlObHhzZ2F5M042aFk1NXc2cmlP?=
 =?utf-8?B?UDJZL2NYUDhDcjluVWIxYzlkVmFOSE9KNSt6UngvdDgzOTl2Y1VBMzRaYVQv?=
 =?utf-8?B?bjFqVUpweS9oV0xvbDNlNmt1bjZKeTdBcWRWK3lwelZyaTdJNExXcXhobnh4?=
 =?utf-8?B?cnZKSEJNSEFwQllkOEFkZE5JTHhkNTE1Ync0emVBN2RodjFBRk0vUTUybWc4?=
 =?utf-8?B?VUFtNVhKQVlpMUgwcGFPeUVWZ0tIWnVwL09sUStRSHlBRm5tU0lQSlZTd3c5?=
 =?utf-8?B?cFhVY0NwRVc5YlJLZ0JQMHh3TUVQa2tRYk9DK2l2ZTNXKzhMVHJQU0RRNTlv?=
 =?utf-8?B?cXNDRHg4VXNCeUxqVnlCQjBrS2dRbnlrRnowVVgyL0hOK1N5Uk8vSGFldVNy?=
 =?utf-8?B?NkJSZHlHYWlxZE11N1paVFJJdnBhczdwWVdYZU05WTV6R2pzOUhsVVlRdTVO?=
 =?utf-8?B?MUpXbmhvOFM3cVpIK01uTHJHY2xmdVVGUFJXb2VnS1pPcG9CY3hNQ3d4K1BB?=
 =?utf-8?B?WDBuZS96RDRRWFlFZmZJekFxd3BvbVZlengrbEN1aUZZbWxZY0FkMTh4YzlJ?=
 =?utf-8?B?Q2hIanBLaWZTN2N6UGowOHZhdVVERmF5amp4aWZPZXdGb01KVmpmNVo4dXFT?=
 =?utf-8?B?Lzg2ZEdqWkZJMEw2NEN0UWtHcG1Hbll5eVorRG1xdzNVY1NzTzFuRURwU21n?=
 =?utf-8?B?TGg1SGc1dlhJMW9xb0Z5ak8ybnh1ZWtZTlVVV2NzeVZEbE5UNlN2YUtRQkJK?=
 =?utf-8?B?WktJS0tQczgyclJvdGJFOU16VVQrUC9RcmV0TldkdjF0VkpvVFZqQUpDd3Ix?=
 =?utf-8?B?VnltMkNOM1NkWUd0dzBZTzFFUE1HOGlzSU9qK0svMWtPYU5JUUR5SmUvZU00?=
 =?utf-8?B?RFpXRnI0SHRkUTRtY1BIZG1hbmxZUHVRcWFQck9UNmFaWThYamkxeURaVXVM?=
 =?utf-8?B?Q1NpNFZuSHpMbzJlck9oTDNjc2hlYmpEbnlXM3V3bWtRaE9MNFd3c3dETWpw?=
 =?utf-8?B?SUNrcWpyNE8yaWZRcjVOK0RlUTg5M3JYNDNUS3gzZFdCNTlPdFhKZWxjZ1FP?=
 =?utf-8?B?VU1lK1ZzOEFib3M1cXlaZWxHSDFxR1dNVmdjK1B1OE9EK0ZhWVUxSzlzQ25z?=
 =?utf-8?B?U1l2R3l6TmNYUXZlRGxvZTlPZkE0Ui95NVZYRGRDWWIwTjRpMlI4d1gzcWpp?=
 =?utf-8?B?RjNuZkZKdm9mN3M0M2swZ1B4c1FrVC9vUkdaaEJnTllFa2lTV3laKzBlaWdQ?=
 =?utf-8?B?ME9zZ2hEbnkyNWlLUmxkbG9wYjJFZWhZKzcrL0M1Q25SS24vaFNXWkVNQ0c5?=
 =?utf-8?B?cnNkTnRvcVNScDVmUXNPQVBxMjFPRzQwdjlIMFNxcm0zVExMZUZpUGNnaHkw?=
 =?utf-8?B?bEZxS0Q1NUJmemVndzE1RUhzOGlDNTdBeTM1TllkM3l3R2xDcXJxSS9KaXg1?=
 =?utf-8?B?Z1J1dk5OUmlHaXlkMXRQUHBQNkhLZmwxTGFQUENZUDVtd3lUYjBRU0daYXlT?=
 =?utf-8?B?QmV0V3dhV2RCSWM3L1IwMGp4VzRnRzY5NjdQN0pUTDdmZGsxaUFweFVyMmFa?=
 =?utf-8?Q?LA+TTFE9oouCgP1WqxUPfeJAB?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c03e70f-0aee-454d-ba15-08de2ce336c2
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB7422.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 11:59:12.2813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JP/kf5H42WZ7evGaH54F5hwfpV8sbW3SrmkYcnlwsiVhpgUt8tmESqPqpVF2LFrnlcbcfcjsDUQ/JeC69x/GDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6437

On 2025/11/26 19:30, Rafael J. Wysocki wrote:
> On Wed, Nov 26, 2025 at 11:17 AM Yang Yang <yang.yang@vivo.com> wrote:
>>
>> We observed the following hung task during our test:
>>
>> [ 3987.095999] INFO: task "kworker/u32:7":239 blocked for more than 188 seconds.
>> [ 3987.096017] task:kworker/u32:7   state:D stack:0     pid:239   tgid:239   ppid:2      flags:0x00000408
>> [ 3987.096042] Workqueue: writeback wb_workfn (flush-254:59)
>> [ 3987.096069] Call trace:
>> [ 3987.096073]  __switch_to+0x1a0/0x318
>> [ 3987.096089]  __schedule+0xa38/0xf9c
>> [ 3987.096104]  schedule+0x74/0x10c
>> [ 3987.096118]  __bio_queue_enter+0xb8/0x178
>> [ 3987.096132]  blk_mq_submit_bio+0x104/0x728
>> [ 3987.096145]  __submit_bio+0xa0/0x23c
>> [ 3987.096159]  submit_bio_noacct_nocheck+0x164/0x330
>> [ 3987.096173]  submit_bio_noacct+0x348/0x468
>> [ 3987.096186]  submit_bio+0x17c/0x198
>> [ 3987.096199]  f2fs_submit_write_bio+0x44/0xe8
>> [ 3987.096211]  __submit_merged_bio+0x40/0x11c
>> [ 3987.096222]  __submit_merged_write_cond+0xcc/0x1f8
>> [ 3987.096233]  f2fs_write_data_pages+0xbb8/0xd0c
>> [ 3987.096246]  do_writepages+0xe0/0x2f4
>> [ 3987.096255]  __writeback_single_inode+0x44/0x4ac
>> [ 3987.096272]  writeback_sb_inodes+0x30c/0x538
>> [ 3987.096289]  __writeback_inodes_wb+0x9c/0xec
>> [ 3987.096305]  wb_writeback+0x158/0x440
>> [ 3987.096321]  wb_workfn+0x388/0x5d4
>> [ 3987.096335]  process_scheduled_works+0x1c4/0x45c
>> [ 3987.096346]  worker_thread+0x32c/0x3e8
>> [ 3987.096356]  kthread+0x11c/0x1b0
>> [ 3987.096372]  ret_from_fork+0x10/0x20
>>
>>   T1:                                   T2:
>>   blk_queue_enter
>>   blk_pm_resume_queue
>>   pm_request_resume
> 
> Shouldn't this be pm_runtime_resume() rather?

I'm not sure about that, I'll check if pm_runtime_resume() should be 
used here instead.

> 
>>   __pm_runtime_resume(dev, RPM_ASYNC)
>>   rpm_resume                            __pm_runtime_disable
>>   dev->power.request_pending = true     dev->power.disable_depth++
>>   queue_work(pm_wq, &dev->power.work)   __pm_runtime_barrier
>>   wait_event                            cancel_work_sync(&dev->power.work)
>>
>> T1 queues the work item, which is then cancelled by T2 before it starts
>> execution. As a result, q->dev cannot be resumed, and T1 waits here for
>> a long time.
>>
>> Signed-off-by: Yang Yang <yang.yang@vivo.com>
>> ---
>>   drivers/base/power/runtime.c | 3 ++-
>>   include/linux/pm.h           | 1 +
>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
>> index 1b11a3cd4acc..fc9bf3fb3bb7 100644
>> --- a/drivers/base/power/runtime.c
>> +++ b/drivers/base/power/runtime.c
>> @@ -1533,7 +1533,8 @@ void __pm_runtime_disable(struct device *dev, bool check_resume)
>>           * means there probably is some I/O to process and disabling runtime PM
>>           * shouldn't prevent the device from processing the I/O.
>>           */
>> -       if (check_resume && dev->power.request_pending &&
>> +       if ((check_resume || dev->power.force_check_resume) &&
>> +           dev->power.request_pending &&
>>              dev->power.request == RPM_REQ_RESUME) {
>>                  /*
>>                   * Prevent suspends and idle notifications from being carried
> 
> There are only two cases in which false is passed to
> __pm_runtime_disable(), one is in device_suspend_late() and I don't
> think that's relevant here, and the other is in pm_runtime_remove()
> and that's get called when the device is going away.
> 
> So apparently, blk_pm_resume_queue() races with the device going away.
> Is this expected to happen even?
> 
> If so, wouldn't it be better to modify pm_runtime_remove() to pass
> true to __pm_runtime_disable() instead of making these ad hoc changes?
> 

Sorry, I didn't make it clear in my previous message.
I can confirm that __pm_runtime_disable() is called from 
device_suspend_late(), and this issue occurs during system suspend.

>> diff --git a/include/linux/pm.h b/include/linux/pm.h
>> index cc7b2dc28574..4eb20569cdbc 100644
>> --- a/include/linux/pm.h
>> +++ b/include/linux/pm.h
>> @@ -708,6 +708,7 @@ struct dev_pm_info {
>>          bool                    use_autosuspend:1;
>>          bool                    timer_autosuspends:1;
>>          bool                    memalloc_noio:1;
>> +       bool                    force_check_resume:1;
>>          unsigned int            links_count;
>>          enum rpm_request        request;
>>          enum rpm_status         runtime_status;
>> --


