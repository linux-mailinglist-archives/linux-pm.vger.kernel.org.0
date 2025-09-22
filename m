Return-Path: <linux-pm+bounces-35138-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C90B8EC54
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 04:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58FBD3BC1C8
	for <lists+linux-pm@lfdr.de>; Mon, 22 Sep 2025 02:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45632EF676;
	Mon, 22 Sep 2025 02:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="doKL/F1a"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013037.outbound.protection.outlook.com [40.107.162.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D622EDD63;
	Mon, 22 Sep 2025 02:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758507691; cv=fail; b=FiIL3lq6YUYZETV99BcAmSNPLLkHIqwoChvKxR3Zy63HCP1jy8W5VambY/yEJobDiDwO/GVH1km/28RIyaOBBzjgOeuRGZj+DPXKjEy0PAwvPE5CnI2e8G6muJiM5CIk20MzRYxuIwbKL91tkQPi5HhDauTDEEqBiHw38g+bh/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758507691; c=relaxed/simple;
	bh=Jfuw4ReqQ48yD6GVrAaD54bMaBD2P0dzQUqUpQGNgBU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=bK2Ql2nF6LwJsSSlSmhmLD3sb+5A5WzcFNp8DqpS9gkGKm0gUsellgjgZbY863ypKHBY7McddJTdsUcqf/ZnLODkyphkkwva75pxB1wQjzk+A3A7EZnXlbZzhRyumiF1a7K6UvYwpWY15lmhAgoCXQoCPzLufH06roCJ8GCRmuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=doKL/F1a; arc=fail smtp.client-ip=40.107.162.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DMQF6bVfL5xfNi0iaRsMxROgKFapAOCuWriVTOzujuNw78tmST5qcx35rEYcGpQURtEv7bu3llkpehOTSHW5CQSwwCTEB0A/lANXskpZTay80exKuZWr3wtRv2Zwn1ONzv2pusMltKFXGCIO4OlnNbtLPnuBi74xalGEyH/sbco6GJSKNw9GGkJkgnmQyObRZJ0IM6WFTwQBio1ca00ha1XdjxH8pfcpV2A4ogsg7hGJ1mmjqaYJ0nh2yxHww2dkYF5+TRVzT8wm0xkzmJixjWD1a3hRz4h1Bfa5hi4Aewnx3bWE1Kgxf8SgO9PjsGFuv0PAqJRWkFfP+OeBGt4qFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chm9mqzbgpbVnPEeOZgoLWO37PtUmrlCKvpvLIYNyKE=;
 b=qZvoZoZkG8ekNbkf3IuPW1JDGwD8VEnPAuGe7p0htPArdNCVosgvFxtUCP8enyg+3fJrT/J5iZcqOZiYSUDBL1X1IUyki6VpRoh8qLOp6Ooj9eDRo5KaLVAaPKuGWjCiXZJTbCvzEbNp4lrZ9Oz/299RSmtOluxRoY6MK/uGKOWZYotJeC7YzXITqAqNezVLhSFAiKphXGy7hSVDf72+G1YhnUUoLwbWuF++S1VBrTZyFiSamG7RqXGyt5TKiLiiqk2LXQc+PSPHrvkCmUvo+I0blEZXfKyoDANEcjrb/F5aH6puuxm8J9FRcWF165pfFjKZwpao0oYGiWLvjRA7IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chm9mqzbgpbVnPEeOZgoLWO37PtUmrlCKvpvLIYNyKE=;
 b=doKL/F1aDcR/staAGfyXIoDTs57Vli2mgeRKHXun+HF0XqUs9pWKUfEYqDoO0p94/Z19sk/Sx0ej6JMnZ4sayQBIMfQcVuBzrxhexa8/DrNleS8t5TZH+VgmpxrxQlWci9jyqRJLyNjUdqVo0HmUEobwymIVeM6aOr1CGCg831nOW+SIi2merGi6Kc1LVPDEWhPL1j/lGL72cYgr1aWVEEVVt4z0OU8Heir96Dj1B+rfRYnJgF7duJtYHLydmGXq4z04GV07VV6GddOf29tjfzZYMIcbUlLQgCfeBI0wsNaw3KNvcit089Cc8ArHos4nuGz5O3zTiPqBy/oAOFfkZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB7053.eurprd04.prod.outlook.com (2603:10a6:800:12f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 22 Sep
 2025 02:21:28 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.008; Mon, 22 Sep 2025
 02:21:28 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Mon, 22 Sep 2025 10:21:06 +0800
Subject: [PATCH v4 1/5] PM: wakeup: Add out-of-band system wakeup support
 for devices
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-pm-v4-v4-1-ef48428e8fe0@nxp.com>
References: <20250922-pm-v4-v4-0-ef48428e8fe0@nxp.com>
In-Reply-To: <20250922-pm-v4-v4-0-ef48428e8fe0@nxp.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Peter Chen <peter.chen@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758507676; l=3180;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=Jfuw4ReqQ48yD6GVrAaD54bMaBD2P0dzQUqUpQGNgBU=;
 b=Uk/YCbFzgc4O5+99Pgncgn1R+/Mi9yX3R3DZQ/lG0EQ21Jl7PmK+BcbOwMCtdQLeAJOhe4DF/
 J0vFSyTcr/XAX4vo4QJmfDzDk5wWFBgILgFBDbqIYPx3zTmDSfmdeSm
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:194::8) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI1PR04MB7053:EE_
X-MS-Office365-Filtering-Correlation-Id: e7364137-2650-407b-53fb-08ddf97ebcd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WlpBb2J3a3VlWUJ6b2JMQnBLV0dnODFpTGd5NksrYzF1SzVLTHJleGlCVnlq?=
 =?utf-8?B?U21senFpem5SREVRbjJaQzloZXlxS2JjaEFnM1hSR2RnK09WMzJjbWdheGhT?=
 =?utf-8?B?ZjlSOHRZMFc0UjZrQmhmTHZlQS9kNnBsVFhZbzBhaWNrVXlLVmRnZU5sQ0Fo?=
 =?utf-8?B?bEhabzlqTklIZ2t0ditHQnZjV1FVVHFOVHlYSEZ3WERkZzV4VFkrK2tzTnQ1?=
 =?utf-8?B?VkQwd1NXMUp5enJ5YWpTcWs0b1UzMzZ4ZHJ5c3YzTVVTakdWaVhXSHVXRitk?=
 =?utf-8?B?L010ZnNBbWZld0hIclRXb2dLS0hBdkw3T3p5VHRhTTZkczZpWTZQTHZNRVRJ?=
 =?utf-8?B?UTdiZERycE9nQlF0dlJWaE13Znp3bnZQMlpDdW5GMVhCUmMwYjhpbldJVUYx?=
 =?utf-8?B?bVMzczU0alE5ekZmOFNZTXVIaEhzVG5SZWxXdEZQSzhvWm0xMUVFTUF0dGJa?=
 =?utf-8?B?aVZTT3J0ZEd2YmYxZzg2bC9aOHdkRjNIRW1FbjVCbEhPelBBMzhXS1I1MHBR?=
 =?utf-8?B?K3FZTmNhdDVMdW9mRE5Jc0xab3ZwTDA2SDRDdm9JWnRoNFNwT3lud1Y5OXpp?=
 =?utf-8?B?N1R2ZElZdGpCc1ZBYTNaQUxGalZXNWJYZzdiRjRrcEx0OTFlY0hGNjFWQWhM?=
 =?utf-8?B?RllXYzloQ3FEUzZzMk1TbVFzS3pEYm02bVZwZlowS1MxZUpZRGlxTmZaeC8r?=
 =?utf-8?B?ZW55UjVlRWV3ajE1Rzh3emRRRjJIdkUrOEs4S3NKQ0hkN1FhWUVxNVdSNHB0?=
 =?utf-8?B?aUkybkhWZjkxMUVrODQrMWlWT0pGUGZrVFc0aFFyWk5WUndNREpmLzFVUnVI?=
 =?utf-8?B?elJQemh3eStCZjNnc3BGaEdvKzgzNlppamxwN2lvM0hnS3RUUjFENjNoZzA1?=
 =?utf-8?B?VmJVa2Z5MVV4YkpZZ05vWmtjajhWRThNaVA4M24rWVJPcXlody9tUVV3UG1B?=
 =?utf-8?B?Zjh4K1ZWbDFMcXFPUmJNcXg5V2U4NDhiaFdEZVhXdzljTEZ1UG9wOTA2eXRp?=
 =?utf-8?B?cHQ4SG96MGhjOFpFbUx4UUlUOTFJOE9jUVVlTUpFVkxyTTNnaE9wdjh3d0Nn?=
 =?utf-8?B?a0JLZ21SVlB2K3Z1akIzMnRzbzREcllqaHNPWjd5aFVLWFpZenA2Y2RXNEtr?=
 =?utf-8?B?QkFlS2t4TExVdmIwTTVLUnF2Sk04TDEvbEN5TElVSnRZTWc5aCtLQ2dOaU9z?=
 =?utf-8?B?T2ZoMzgyMFdiemZCZ3JudzY4Q2FGaTVtQkR4ek9lL3hCNG1sK0R5c3ZYNk0y?=
 =?utf-8?B?M3l5Tm9NZThVMlY2dEZ6L1Rkd0NiZ3l0T2RKdTV2bXNJbHVSOHpvdGpmaW1r?=
 =?utf-8?B?TzNnb0tnd3FnZmZOV2t1S1g2djNKb1dnbFJFK2ZCNkVuZjNQWGpha2xISC93?=
 =?utf-8?B?YmdoQkl3RFdrZ3J5NGtTVWMxWjl1UDF4anRxemlYUU02RkVzOFBBVmt1WWpS?=
 =?utf-8?B?b1JFb0dZV3NoY2xPWVNhTmtodys4N01NeElmZlhoNVVwT2tnUnRueDErOGg1?=
 =?utf-8?B?eXRXNWxwZ3Y0MjVlODFzYnNzQVlPNERMMlZHcE9MNUtxUStNai9VckQ4WW54?=
 =?utf-8?B?alpuNWlIQURQTGRURHZTcWpHTmwrYmdYdHVRUU8vVTIwMDFrYWlwdHV0ay94?=
 =?utf-8?B?SlRyTnQ4RElRYnU5bUw0QWdqZno1eW14VTg0RHlHRXhVVEZEZXl5OUljSmNo?=
 =?utf-8?B?TVM2a3NrNWFTNG9udVVnR2NzWEpHa24wQi83ZXBUY0NLbHpzZzJHYUxTSWhs?=
 =?utf-8?B?NW9CUmNxZ3Nqd1A2bW5tTjZhdERtdXdoZkhYdDVyaytHU2k4QXd4eGw4TDRH?=
 =?utf-8?B?a3hUVCtWcFRDU1U2TnFXaGIvTzhZRGF4ckRDYlRMemkvSEM0TzBqWWxRSVdm?=
 =?utf-8?B?MWZuaHV5ZjNjTTY3QmhYaFpCd1V5elF4V2pDa2ZMZ2pFK050MVcwMG0zWE5z?=
 =?utf-8?B?VVQxdDJmM2E5RmR1bVRLRzlGc0JFTzFVb2tBNzUzU21ReEhTNjdrRXpnS0sx?=
 =?utf-8?Q?xndObrnDQxpl9xYB5H/s3jp2j9JSkQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3VEUnU1SkJlU0tLMFI2RnpqemxVNFlseFYrY3VMYXhja1UrS0tGVmR0dFZv?=
 =?utf-8?B?cFNEZ1J4aG1haHY5eHlFM0dpNU1Tb2dDNTFLNnZ3VGhBR2M0U21GamdCenZD?=
 =?utf-8?B?QUZZY0pYcWpSdm5jbG1IeFJyNUZzbjFFcWZHV1pNbURaQzFnazZwbGxnRGd6?=
 =?utf-8?B?Z1N6ZHRVZzg1RkJ4WmdJVDU0bm41UFJ4ZW83alA1L28rWDFMdXRUd3o2VnB2?=
 =?utf-8?B?b2wxWUxaODBTNjA5Y094MXBCMGdRRVp5ai96bXh5QmRlM2VIWmNIcHFzM3NQ?=
 =?utf-8?B?QndSNnZCeGsxSEdqSnZ1ck96WC94UkVqZ1hKVEdaaGtBVWtnbXNVQmZPbkN6?=
 =?utf-8?B?RDVkRnM5YlNlNUFWQnplWmhIQUVTdmxtbXpBcUR5TjJCQk5Ka2E4V0NISHRt?=
 =?utf-8?B?MXRJYkRMamxLM3BoWk5wZHRWbC9tZUNrQTdOZmloa25YZHJxdXRITitoR3pI?=
 =?utf-8?B?NHNmcUVBeFYvcVM0cFJPUEhCSmNrNlNKQ21oKzR3MVBRVzJZMnM3dk9UQmNG?=
 =?utf-8?B?QlUxc1lqdkVQVlNPWXNCL3oyQm1PNTNoUEFST0xzZ2Fkb0s2Rmg5MjNQVzU0?=
 =?utf-8?B?R2x2WDhSa1A4ZkMrMVVvSnZmVzRxU3lacGVxQmJGQ2NMYUx4S3cxWVZYVHZ1?=
 =?utf-8?B?NUo5WnBEZnNhV3VBNWFFT3BMY3pvVWxvMUR2cWlROVpISGhqOU5VYnk3dVBM?=
 =?utf-8?B?OGU4MUJrQlVZRFViTlFTMWljOC9pVlZWQW5PMmNRa0Z0UWVHNFNtYzdzbXVS?=
 =?utf-8?B?UjhOK1BHWUtGWW9YUE1kR0tlV3FVbHNOVVUwMjlNK3JBcnZhNXF4eWU1MTlq?=
 =?utf-8?B?bm43MGxoaU1QMzBydmZySmpSQ2dhdzhUemZQeElLcHNhcFZJS0xPV2RoelBZ?=
 =?utf-8?B?SHBQUjBNdFB3bmVKSGNXTnR6RmlJdlpPQ3RnWkVITDZBMGVRWDRNNkhnR05z?=
 =?utf-8?B?RTRIQWdVdzYyYTBuS2FFZ3U3bDBRY0ZEbzdsbkNnR1prYlcyMUpHRmY5SWFB?=
 =?utf-8?B?d0JROEoyTDBRQlFaQnlsUmJpY01zT3Zudnhnd2IvSzV0Vzl6bTdkbGJ4UVpx?=
 =?utf-8?B?ZGplRHZBYWptQVBOMmthV2dpL0c2SHViQ2FQTEFUSnBrUmUyZGNESUp5NTUr?=
 =?utf-8?B?ckNac3BzekxUTlBwOTY3Qm5OY2dVMTdyZ1lPY1JFOTZqNXhnYVpNckJRUXM2?=
 =?utf-8?B?NDhxNnViNWdSblNFTEpzWXJjN3A0WmdnSnNxSnRmQzlVOEVhc1lwbEx6clNy?=
 =?utf-8?B?d3VTSFU2VzRST2VyeVlIcG5JcTlDTHlvVU55ekFvVWZnSjJyWTRJSTNUb2pM?=
 =?utf-8?B?TkIyWWZsTTRZNEtCSEpURWZNN1gvVE1vNk9jK2dCUHBrd09WdGMzbTU3UlRW?=
 =?utf-8?B?ejJiRHQ2YjM0RHN1MzRTRC83ZlFreHdOOHM3YUVPUW5DN1doRFZZSGhOUmtl?=
 =?utf-8?B?c2hiVVYvNEI1dTFoVlBBNnBQNGkwOVRoeXBRdzBHYisxRFlZbTZOa0dzVVZz?=
 =?utf-8?B?TEU2bm5Qazc5MU1veUF1b2RDaHRvTUt2akpGMHJZd1MwY0N2MzV2UGxKMnlX?=
 =?utf-8?B?TTdXNnJITy93RkZQSTFTSFAyQTZMVGl4VFVoU0U4T3hUYW5jOHJwYkVnQlIz?=
 =?utf-8?B?MDdnT1ExVkEwQlNqQ2lWeWIwODJ4cDZ6R2pENi9EY1o0ZDh0NFF2T3dpMVNa?=
 =?utf-8?B?TlVNMEI3VGYxeFRERDFkTWxMWFpzaDRIUGkwSURxMUhGLzdpT2lieDhnaTJp?=
 =?utf-8?B?aEZDUVV3YmgrbVFhWU9DaTRnMVhiNXE0U0lIdWR4YlBHeEVaVFpMSWpTZzdt?=
 =?utf-8?B?aE1rTnU1eGNwQnh0Ui9HajFrQUVzL0RkSEY1YmZrUmZTT2s1ZDgwNmdvZTBH?=
 =?utf-8?B?cng1YUtOQVVQUVhqQWVobnBNK2JvSmVzTWRrYXlWN3VtNVFBSUt0aU9Sdklq?=
 =?utf-8?B?UkJ4ejBkazFkVWI2aUt1WUR6YUYrWWFoQmZtVDF3U1J0UGFGakFKVXBUSWVy?=
 =?utf-8?B?V3cvVUZaZk1EcUhHejB0Q1h4RkNZYXpWWGJvN1lCNFVFUWFxSUQ5VmkrUnlC?=
 =?utf-8?B?MzJZSmFzWWpLaUlpQ2UvRUNVa255T3ljQ3pHb2ZhSFhqbThHQ3JCb3VzRXht?=
 =?utf-8?Q?5M4hQ0zjqJvxK/8S1mnFtS5QU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7364137-2650-407b-53fb-08ddf97ebcd2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 02:21:28.6748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R60GWPniL+QoVPRWM6ZY3DN3MkVWLQs0cIeg1t7doTK7Y1PVBWm+mmGTwSYdVlpFfUzfD7xK6vPYY0ixhWxxUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7053

Some devices can wake up the system from suspend even when their power
domains are turned off. This is possible because their system-wakeup logic
resides in an always-on power domain - indicating that they support
out-of-band system wakeup.

Currently, PM domain core doesn't power off such devices if they are marked
as system wakeup sources. To better represent devices with out-of-band
wakeup capability, this patch introduces a new flag out_band_wakeup in
'struct dev_pm_info'.

Two helper APIs are added:
 - device_set_out_band_wakeup() - to mark a device as having out-of-band
   wakeup capability.
 - device_out_band_wakeup() - to query the flag.

Allow the PM core and drivers to distinguish between regular and
out-of-band wakeup sources, enable more accurate power management decision.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/base/power/main.c |  1 +
 include/linux/pm.h        |  1 +
 include/linux/pm_wakeup.h | 17 +++++++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index b9a34c3425ecfab038097e2c03645157af2e598c..6b1ca729dc3e34292952c9c309aab3f34a0a664a 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -2124,6 +2124,7 @@ static int device_prepare(struct device *dev, pm_message_t state)
 	device_lock(dev);
 
 	dev->power.wakeup_path = false;
+	dev->power.out_band_wakeup = false;
 
 	if (dev->power.no_pm_callbacks)
 		goto unlock;
diff --git a/include/linux/pm.h b/include/linux/pm.h
index cc7b2dc28574c24ece2f651352d4d23ecaf15f31..5b28a4f2e87e2aa34acc709e146ce729acace344 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -684,6 +684,7 @@ struct dev_pm_info {
 	bool			smart_suspend:1;	/* Owned by the PM core */
 	bool			must_resume:1;		/* Owned by the PM core */
 	bool			may_skip_resume:1;	/* Set by subsystems */
+	bool			out_band_wakeup:1;
 	bool			strict_midlayer:1;
 #else
 	bool			should_wakeup:1;
diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
index c838b4a30f876ef5a66972d16f461cfba9ff2814..41e8f344a20563898e827da62dd240b8cbe657d2 100644
--- a/include/linux/pm_wakeup.h
+++ b/include/linux/pm_wakeup.h
@@ -94,6 +94,16 @@ static inline void device_set_wakeup_path(struct device *dev)
 	dev->power.wakeup_path = true;
 }
 
+static inline void device_set_out_band_wakeup(struct device *dev)
+{
+	dev->power.out_band_wakeup = true;
+}
+
+static inline bool device_out_band_wakeup(struct device *dev)
+{
+	return dev->power.out_band_wakeup;
+}
+
 /* drivers/base/power/wakeup.c */
 extern struct wakeup_source *wakeup_source_register(struct device *dev,
 						    const char *name);
@@ -162,6 +172,13 @@ static inline bool device_wakeup_path(struct device *dev)
 
 static inline void device_set_wakeup_path(struct device *dev) {}
 
+static inline void device_set_out_band_wakeup(struct device *dev) {}
+
+static inline bool device_out_band_wakeup(struct device *dev)
+{
+	return false;
+}
+
 static inline void __pm_stay_awake(struct wakeup_source *ws) {}
 
 static inline void pm_stay_awake(struct device *dev) {}

-- 
2.37.1


