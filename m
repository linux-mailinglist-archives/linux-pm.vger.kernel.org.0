Return-Path: <linux-pm+bounces-18356-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 075779E05BC
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 15:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA8E528E661
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 14:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD007209683;
	Mon,  2 Dec 2024 14:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b="HKfsbOEx"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2117.outbound.protection.outlook.com [40.107.103.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531952040BE;
	Mon,  2 Dec 2024 14:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733151297; cv=fail; b=qqVC/VmL4kVNqDUEPnVMXuVaV+7v9vwFw6gt+LiV2uRN0WBxBywn5NC7x2ykqXBSLVQ6I8bSs3yf8AL+C+Q+f7UqpcBQWchbDdFSDlPRLir8+75qVrZ7QQ2st3WSdQPg+UE5wscvtOoKMi98qBa+2r7aeAwkqG6nYhhh8buyX0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733151297; c=relaxed/simple;
	bh=WZzj707enoeLcHMzugoAvx1Skp1KP4hSzoCWGhZwFkA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gQb3Yao2qnLF9QSbVlTE5IvdBG9Ocg4AkMbNZJyES3HBteBysgAWXQqp+cmZvGfXPVtmQECKFa0kR73KFu0qNFOCF4ElRlHxE8cXlF5nLxK8GJVLSu4WTfFPPIObVmP7HSeJCrdBoMf77IKQTrOEFeC+ooFhrNC9D3tVDRXL/0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be; spf=pass smtp.mailfrom=uclouvain.be; dkim=pass (2048-bit key) header.d=uclouvain.be header.i=@uclouvain.be header.b=HKfsbOEx; arc=fail smtp.client-ip=40.107.103.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uclouvain.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uclouvain.be
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=szRL17UNNWAPR+cPoBzno3QfzugY90LZ+0Bc/SiTmtwwiT0dNRS959NY45QrNlIpnUd5dybRuaqtMTS4xiqfZcHQJDC5wRk7KvlGHlP2Mg8rLZMxjRDNFZMpQg9am4bh+jpZ6PTv3vq2Hj6udsPpM8YcjC8x8EiT663r29gMX4mOBMBjxcZe1fKQip5yxdkRGUldIanZAie3bbTQ9wNtGWRarSlHg0BaUoVAaMzw2ijQ0h4L2waK9dbFwc7bcctUBEP4YTDXVf6bQUDEhiMBZDXwqqzuRKXr+2DLJVW6YEEJpy/u9Fh8XEvJhn0x11A2N6+n4h/AV7x3YsBE+T8/dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phSJLAQUpSIc4MH9f3YnY+ht5TF7ZwxBzwVlV7H0iFs=;
 b=AnRRrAhZE1znSSYAxlfECr1jqMMggn2Y4eD0wt5kgUAgawaH7u8nksAo4XpSsOzscGs1cQ6HuJb/CuvjMajhue2ugA9ywP0ox92dowaRtjy/T8jq090WJ3zj0zNW0t+6vWDVVSgjBv+qMIJStQvtk5Eoqj8U8YwQWq9+O0NjuAnpQMHsHyD62+8llvlci+R9Kchjn8yy6ea7AyyuR9BrYR6Yzk+7JgwX6JUBPjTBF0g8h12+HTBNTRe3eWC/DjmhasMR0nrm0CelQ4dxJXzitmtjy07zOCa7Ku6HjnArz1cT0f6PHYApY+itH2WhUPwM9+nbvJin5dw7sLWmCQgB1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uclouvain.be; dmarc=pass action=none header.from=uclouvain.be;
 dkim=pass header.d=uclouvain.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uclouvain.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phSJLAQUpSIc4MH9f3YnY+ht5TF7ZwxBzwVlV7H0iFs=;
 b=HKfsbOExx+ZUuEW3MNt5E6tH+TCIHucM5d6jHIBFX4oH5HOx7KEGhIOXMB8u7ORGakbqLPI/kvdCSuMrzcYp1TCSVW/h2pReq3rvT3U62fmnzNXcCN4OtGAtuJG0HKKrZJhV1zmzpZuMSVYZY2+Vy8mL1XO4hpunaq8I7pkBe5b/9ArMMjb0Zi7z7/6L1Z7l2snWzjXFc38pKYJMYM0fZIQm3Z6R5wnksiEVzPo00nuxOZ6UNHt7ccrK9FwAa3rxYdzcbm7mc+MMAvnN7BYlB0LQ83SmFzmstxfK4JjlHuVQuiz/aCwrQGXxVt7KSCDN2D0umswQXMivdpMzHUEW0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uclouvain.be;
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com (2603:10a6:20b:5b6::13)
 by PA4PR03MB7182.eurprd03.prod.outlook.com (2603:10a6:102:104::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 14:54:52 +0000
Received: from AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::c90e:deef:6dcf:538c]) by AS8PR03MB9047.eurprd03.prod.outlook.com
 ([fe80::c90e:deef:6dcf:538c%6]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 14:54:52 +0000
Message-ID: <08558b39-bf69-43a7-8f55-064995221099@uclouvain.be>
Date: Mon, 2 Dec 2024 15:54:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: defconfig: enable Maxim max1720x driver
To: Krzysztof Kozlowski <krzk@kernel.org>, Sebastian Reichel
 <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org
References: <20241202-b4-gs101_max77759_fg-v1-0-98d2fa7bfe30@uclouvain.be>
 <20241202-b4-gs101_max77759_fg-v1-3-98d2fa7bfe30@uclouvain.be>
 <a917cb0b-68de-4916-9a4d-021a8da37289@kernel.org>
Content-Language: en-US
From: Thomas Antoine <t.antoine@uclouvain.be>
In-Reply-To: <a917cb0b-68de-4916-9a4d-021a8da37289@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0111.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1ef::13) To AS8PR03MB9047.eurprd03.prod.outlook.com
 (2603:10a6:20b:5b6::13)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB9047:EE_|PA4PR03MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: 999d3f69-c977-4412-629c-08dd12e146e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tm9qTWxJWVNPK1NWcHFVbndCSEU1aWxhT0xxcWFmK2I4QmR4VjhRUEE0TktC?=
 =?utf-8?B?K2preUFMNDR0Q3BWbER2WG45ODJBZlNoZjYySnU4M3BEVWZ5ZXlyb0VpQmk3?=
 =?utf-8?B?WmRycE1iWldIZGNzN3huZ2wxeklJOTVGMmNndHlvYVpIcnhoSVc0NnB2Mll2?=
 =?utf-8?B?R1pTTmhGeGc5QTM3ZE1zdVJnTmduT0dZMW9XK2FTMytRNEhUUXJwN1ovNDlW?=
 =?utf-8?B?YnJtS0ExTHMyZkNSMko3NkZNSnRjOEF0ajdhYUJLbS9sbmZKYTNtbkRiR1R6?=
 =?utf-8?B?OTgvKzdONlRxWjRzdnE4OWNTVVZGUVFHaEZWQm1DRzRJbWJvT3R2VWFZUDRj?=
 =?utf-8?B?L3UxYlBsdmFYYm9HVEpNMGtnOUY0Q1BWeHRMbWJKS0ZVdmdxWVgwWHh2ZGY1?=
 =?utf-8?B?RndNajR2Ym1VVE9CQ3dqNUpYcUlWRHhTcTh3MlI1L1NBMVlNZE40Z0RaWFRq?=
 =?utf-8?B?M1hTekNWUitRRW5yL0JQRDhMRUhRQVBrYWVzalFLT2NJRjZ4MmVGZEFMUTNh?=
 =?utf-8?B?bGpWZ3ppaStJVW1vaHhBTkpjZ21lb2VWVGc2RHg1a1ErYXlKaDF5ZjhJUXpV?=
 =?utf-8?B?SGpaN241NTF4aFhFb0pKT2VEbmoxa3hSSE1aWlgrZzVnaXM0YmJoN0lqclV5?=
 =?utf-8?B?Nmx3WFQwTmY2QTFQN3BXdmJBWWZiN3FITXN4WG5MMGVwenN2UWZWVEZUSjJI?=
 =?utf-8?B?ZHV5di9IQWlDS2tOTVNlR1hOSWk2TzJneUdHNWpDbVZydjdqV3dRV25Bbjgx?=
 =?utf-8?B?ZnVMNGJ0b0RFU2FGWDdtNW1JVVFnbUUreUdjK3NINmszUWdudm5VaGdrZFEz?=
 =?utf-8?B?V2NlSlh1ZWQ1ek1mNy9rbjdzVGc0aEs1WjNBYTE0ZVNtNEFpU3ZpbXZSWmV3?=
 =?utf-8?B?KzhVbi9WOGs3TUkwbTJJZzk4aXJzSWhLV0tUSXpXdE92ZlF6Y0c3VVhxaFJB?=
 =?utf-8?B?bmFJQXk0YVI4eGQ5K1NpUlJwakIwUjlmKzdrck9nV1BpUTlEZTNkVzZuYjFG?=
 =?utf-8?B?Smx4NEVqR1RIM3JtSzA1K1Z2MnY5MmpPeXExU3ZnMVVvR1RCRzFWNFFsSUMy?=
 =?utf-8?B?MWJCZk50Q3hkLyt1MXBOQWErMzQzbFA3S0QzYi94aUpNU3FsZ0kvdlpqYUMy?=
 =?utf-8?B?Z3FsMzhlemJzaWovWHlHeUcyRmlyZ1NYZW8ra0x5aTNsNWRhb1dHbXhibG4x?=
 =?utf-8?B?TzJzaGFNa0x5dWZsUDdMSmMyWEtSQlhVYWJsRis1aFFMM3IvazRXWUFzVWxi?=
 =?utf-8?B?OHJzVEVEZXRxKzNzMmY0VEkzL20yS2tFZU9UYUlsMHcrYWliRDJnaHNLNWNM?=
 =?utf-8?B?endEK013ZnMvbnJ6U3lDWHpVcjlSZ0tqWmpmWjBNQU9VYjJzNStYUXp5YjFu?=
 =?utf-8?B?K1ozT2ZsTFhDWkZBTzNrY1d0NS81QTJKMzhxOGxpek9pWXFzcGN6dlZZcWQ4?=
 =?utf-8?B?dFlQdmdCK0RaL09xVkxWWkVOVG1jbVNLd2hsa1lQM20wMUJXQlVCMmpUSGpD?=
 =?utf-8?B?OEovRngybm9xM0pTejE1QUtRTTdaRDkwVzB5WXlJMW8zaUNZRDF3T2xydHZ2?=
 =?utf-8?B?S1pHVnRnT3RBOTdMd1FzaytQMXlwV3BUU3laSXE3T3FtWlZVZkxOTzhRaGFr?=
 =?utf-8?B?enIvTTJnelloR1FvMU9EeTJOQnpCRjJFdHNPVXZib04wd1gzR2Q5TzFyZmxQ?=
 =?utf-8?B?b0dKTS9zSURXazR1NXRrMjJvcjN4aHNYUk1FR2tOVmFEeENZNVpCSkduMVNN?=
 =?utf-8?B?RFp4WUdLdDFBZkNBcVd1UkZEZ1NPZTJlY1NPV2Y2RG5oTG1rQy9iWlplUFdU?=
 =?utf-8?B?TlNhZ2F5RS9lQTBXVmNzZ1I1Z2JjbzdrT0s4WDFoS004cms2K3FEdW4rZytl?=
 =?utf-8?Q?/Jcr3EhvUbZnG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB9047.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFFCbE1qZWZHZ05XUlJMR1E5b3FKNDVGcGl2aWFTalRCL1oxNmd3K0kwL0hY?=
 =?utf-8?B?bzhQRXJkY0JDaDlKY0txR25YVGNxZjJGNFJIcVlVbDlIQWlCdkt5QlJVYU5M?=
 =?utf-8?B?bjcyN3hLVkFCVFR6USs3M09xMEg0NWtndmNMclgxazE0cXkzVldMUkVHTDBN?=
 =?utf-8?B?TzRIN2NWcUpvbFRDOE5KTWFkU1JKaU56TUVLWkorK1Z1OHJoNk9SVm5Icllq?=
 =?utf-8?B?Z0I0Y2lIclBFVWVIOWViYzlncjc0TDkzakJJbStyNEtyM1d0T2VuanZkSWZK?=
 =?utf-8?B?S2FGdFRKREwxaGwzSFVDYkQyM1F6YTI4ZUU5S0lYdnFMUkE0UDYzblM3bWRu?=
 =?utf-8?B?MnJVZnpuckN5TDYxd2xpK2hFWWlDQnRTaDRlemw5S25BNTI3dWRpL05kVXMy?=
 =?utf-8?B?OWR5VnJQangwaS9kZDVMaTBtSU5Ba2tzdXNtRjFvdXcweXk1aGlkVHJLRW5D?=
 =?utf-8?B?M3hFYUQvTFFiTXZGWS8yWEgxM0tJaXQ5ZEZ0OFdPRWo2U0pobVpQSzNzUTcz?=
 =?utf-8?B?UTZVWTdFUVRXOWFaVkNBQ1ZLVHkwNTdEcG9FUTRhbjBBUTRKV2JIMG9RMUZz?=
 =?utf-8?B?NmNIUnY2bmdvV3VBYlNVUjErYjgrbzB1ZXJmWDBMczVMVkVPWTNvUFlybGRy?=
 =?utf-8?B?TFU0VmROdGZBbXRYQVlYWmpZZ1FPcWtyZmZqWVREWGx4UUxCQVZoR1Vrc0VF?=
 =?utf-8?B?d2FudFFqeUNvMjlRUzU1empEZnlwSFZNU0RjTGk2OEY3NThUZDhXMVdGRCtN?=
 =?utf-8?B?Tk8zVWtmSHZEOTNOclMyKzRERUliS0szdmdsbWJQMXFtWTh5QzI1K3p3MC9B?=
 =?utf-8?B?MC80ZWdTVVdoYzRkUW5xSHNiMlF0aHJIYk1qYWpRQU1Ndm9aU2xuK3lycldy?=
 =?utf-8?B?L0Q2Q2pkeWY0SXBWQlZOaWJzSHBPdzFZRE5mYktjWEZpZHI4SVgzbDBEY2NK?=
 =?utf-8?B?UnBHdFRCT2cycjV4UXlTY3RQU2YzV054U3psam5lUy9ReVEyMXlQZW5FNkIy?=
 =?utf-8?B?SmdMV2ZyMFg0c0VlNUdsT2tBT3ZNdnBVSDFWTDBVMlAwNXllTTVwSFN3OGVQ?=
 =?utf-8?B?SFpTZlg0aVdxNStGTytoM0hzQ2c2bDFrbTFSUnlrOWxUbXpIa3pZbHhlUUNI?=
 =?utf-8?B?TjFad3VkWnVaTGNBSFRweUFGc1h2eGxxTlVuUnFiNXZDVWVZbW1FREVPeXpW?=
 =?utf-8?B?eFVrSUZKaVFFVklKQ25ET3FlL1NCaWFhTGlIdEpZZXcxK0lkYXArRkU0a25K?=
 =?utf-8?B?Zll0b2lCbnVTNXhzL056eGhnS1Q1aUNSdWtFQzFJcnlwRXFyL29rZE45d3N4?=
 =?utf-8?B?bFl2K1BhelhxQ3kyNkNleGZCVnNNUGE5WWpRbmFZOWtjaGRxSTl3VkN2bFhk?=
 =?utf-8?B?cnlMQmdlMTIwVktyelhBenQwVFdGMXdWcTJBK0pYajBJWW1Jc2YyOUVrWmVq?=
 =?utf-8?B?Zzd2MXd1UytZY3p0VVhqbnBDTnNTWHovWTczcTM0Tm9jOEpMZklIdUErYVlo?=
 =?utf-8?B?MGFqQXBCNHhTclhtTW9XZkhZSGFpTmpaUDlVTmR3bkdHWkdvVDlpb2ZJbTMx?=
 =?utf-8?B?UGpWMEY2Rkx6ZHk5K0JBR0J0L1NhK05TdlhZb1lvRGhSbzhlVTNRR21FVTlO?=
 =?utf-8?B?SFZTK09mUC9KRG1iSkYxdVJHNDd4M3BpSGVZL0VPZmUzclcrZ1lUMHZXdkVm?=
 =?utf-8?B?eUR0WUJmZmZHRytDTU9pRnBQYjgycEgza0t1REt4QVpaTCszK1BUUkw1dUFS?=
 =?utf-8?B?NHNRdGd3YUx5eGo4MnVWbk5KY2liOUIrQnFWbGxENmlGQXJtMXRQM1Z3cVk1?=
 =?utf-8?B?dkxPVDVmQytlV2ZzRlQ1TE1rRWtDLzU5V2hxM2hwZlRzc0xkQ0JUVEZ4QnJV?=
 =?utf-8?B?cDIyaHlQVG94VzdKMHFOaDFJWjhzRXQ0UjJFU3pHeVNOSjZTTThRR1J5dnha?=
 =?utf-8?B?dEU0R2xHdkswdFJld0pzNHRZZFg5TUdmeGY5Y01ZTmxkOVZ3Q3RlTjVPVDUv?=
 =?utf-8?B?eEh5UVB1d2QzRkpORDhrMnk0bnF1SlJLb0dWMEdQV09zSEI0UzdiNGYrRlpD?=
 =?utf-8?B?anFrekJsMjJqTFduYU9udUFyYW44NUthbVB6MjJZNHlyQVFib3MwUXZYZ3ZU?=
 =?utf-8?B?VnM3a1Y1eG14eG9OWkswZFF2S2RSQXhFNXBpSk0veUFlUXJiS3ZHWUFiUkwy?=
 =?utf-8?Q?nHu2DMfT7NvjLPAxkWotSi/qA89xRVUIjLFO/WY/dk19?=
X-OriginatorOrg: uclouvain.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 999d3f69-c977-4412-629c-08dd12e146e0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB9047.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 14:54:52.4056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ab090d4-fa2e-4ecf-bc7c-4127b4d582ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pXiTRwWYE6dmoLDO0nyrVdY7YXrfQp5QRmrti+yITVhi0anWmYVU9txqiviLN26WJ9YXMP5bbsZwalWN02x3qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB7182

On 12/2/24 14:40, Krzysztof Kozlowski wrote:
> On 02/12/2024 14:07, Thomas Antoine via B4 Relay wrote:
>> From: Thomas Antoine <t.antoine@uclouvain.be>
>>  CONFIG_BATTERY_QCOM_BATTMGR=m
>>  CONFIG_BATTERY_SBS=m
>>  CONFIG_BATTERY_BQ27XXX=y
>> +CONFIG_BATTERY_MAX1720X=m
>>  CONFIG_BATTERY_MAX17042=m
> 
> Are you sure this is placed according to savedefconfig order?

I ran menuconfig and it put CONFIG_BATTERY_MAX1720X below
CONFIG_BATTERY_MAX17042 so I think it is an error on my part.
Will fix in v2.

Best regards,
Thomas Antoine

