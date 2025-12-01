Return-Path: <linux-pm+bounces-38943-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 441C3C9585D
	for <lists+linux-pm@lfdr.de>; Mon, 01 Dec 2025 02:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C083A3A24F9
	for <lists+linux-pm@lfdr.de>; Mon,  1 Dec 2025 01:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C6317B50A;
	Mon,  1 Dec 2025 01:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="scA1ixjG"
X-Original-To: linux-pm@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011002.outbound.protection.outlook.com [40.107.130.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8054B13E02A;
	Mon,  1 Dec 2025 01:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764553452; cv=fail; b=PDuTFhlBXEtQeLXCBxiObeq2qQN9kBTTdUbyy9MQ5lNwjCnubosFquBwlujpugkgUL84CRMImTC9l3vYYrE7ltHAiO5mDlAxDgVF6khci++ptM86wEwgHOrf2FezGAs9LboYlGe52vDZS8IGSnaB1LzfyDMi1o1fLq3mFxwp0/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764553452; c=relaxed/simple;
	bh=Vi5FSkp3D79QseuLDzSW3kX2QNewIQjMdep7LyA+AwA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pMz4vEoEJ+go9jDOiOnrp7ihXyNSSaK1h4BL3UX8BpS4LhYPR/Taq8j/jYWclNeUlS5tMNwzdn72p4S/NQY2UI6XZPC0RdaWkPkiQsFrVIr2OyiPLyVjqJv9UqBGBrQeOUl6q5Xx9LIbkrB6Xu+BQ3y4LFAV7jja9A3MKPre+IE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=scA1ixjG; arc=fail smtp.client-ip=40.107.130.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WI8+L517tImJPPIRalsbrKw9W7S1TVjVAicASxfxgH9HVJB7Q5q8bUIwRQNTrRfQVU6iiZJCJvBGjYbA3fb7V6an0b18wYicoyjDmI1fDbBaQaSIolS/8ZkqGbD5woVSTJTB+BREwWAQRtmjbvMDYCcSNsQ1/W2HSun/BZdPTXlCPSPLquta1eadDAL3iubsr3q8DaE5jL4HWS88qpgjl0QJwkwxU1x30Hv0/SCES9A8e5Yn29iAVQujVNx1EgONx4L0StGCRGjY9mZHbEjlVL61X3Oz6Y9B5R6MvRqH22q6jaDLUy2MKLr1FrLkPPUkoF+byksqiNP+24/3vqI2Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9bPFUj23Nfg43qoR7gkSUsREQyIX4k+xCH/whQe4EKE=;
 b=D2MCqwB9eXJWfAX8uye/fGh3aO6VdenyUJH4Y9T+0PC2ptG+cH+hRD+NOJIy7D3XNSGYKgejpYKySktxcoydUmSUoAyU/jBkiGbvb8tSwnTpuY8zIJytrykuI46OBaDB2qJSfRgl7I+LsldsYLb04pKPzm/fzXMUiVs7Qy4ByOZdizybs7hPHkQz2gPudNM/R25o3CynwghHcWylONxHRmNqzJFl+ldJb9h93K1wcYmd39l78/tlgOUYdTynn9z3kUFfZCyhXvEGY9miQK7e3Boi6LD9NXMzYv7bLJuyDA+XHW50bcVh9JQYvU/Kwaoe9nHBSTG7R09l/JGl7QNFog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bPFUj23Nfg43qoR7gkSUsREQyIX4k+xCH/whQe4EKE=;
 b=scA1ixjG/A9WaiGPFQEcLpw3OHUC70LxqN57fn6poUc4bMEIYkFqQBvN0i16czsXMXjVS3h2tT++O1IT7jfwKmjPGXeBZIdGT4B1gJV+AXevpDa/dZQmTEMSLrZhZVR4rnUlkG/OoV6+ed76Gi8zZqx7TdvNRSlEh8lUiAume6p1H7IAaWHMNKjDfII5WKlfbOrUWdGTrpZvnQFHz9LMxc5JelgMtSP4/KsSyVkX6PZNRmvBGl1tG2H+Xk9uAxr/0fAWODysti3p+SohgXrplte9MA6cKevjufMyxdk6SG5mq5hD3mb7G9h4jFT440dMSqJpGggk+1cOTNIHSn9ZPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
 by PAXPR04MB8317.eurprd04.prod.outlook.com (2603:10a6:102:1ce::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 01:44:07 +0000
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::2755:55ac:5d6f:4f87]) by PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::2755:55ac:5d6f:4f87%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 01:44:06 +0000
Message-ID: <5221ac0c-b59d-4f7b-ae4d-acd7dab47780@oss.nxp.com>
Date: Mon, 1 Dec 2025 09:43:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] pmdomain: imx8m-blk-ctrl: Remove separate rst and
 clk mask for 8mq vpu
To: Lucas Stach <l.stach@pengutronix.de>, linux-media@vger.kernel.org
Cc: mchehab@kernel.org, hverkuil-cisco@xs4all.nl, nicolas@ndufresne.ca,
 benjamin.gaignard@collabora.com, p.zabel@pengutronix.de,
 sebastian.fricke@collabora.com, shawnguo@kernel.org, ulf.hansson@linaro.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 linux-imx@nxp.com, Frank.li@nxp.com, peng.fan@nxp.com, eagle.zhou@nxp.com,
 imx@lists.linux.dev, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20251128025117.535-1-ming.qian@oss.nxp.com>
 <f68f4836b1ee1d1d1ca0c9754db1080e4e56425a.camel@pengutronix.de>
From: "Ming Qian(OSS)" <ming.qian@oss.nxp.com>
In-Reply-To: <f68f4836b1ee1d1d1ca0c9754db1080e4e56425a.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:3:17::28) To PAXPR04MB8254.eurprd04.prod.outlook.com
 (2603:10a6:102:1cd::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8254:EE_|PAXPR04MB8317:EE_
X-MS-Office365-Filtering-Correlation-Id: 39553791-7ae1-4f80-7d2c-08de307b1d26
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWVWWjQ0Nm5oNFpNOUV4NkJaMG0wKzN1c3lpVVpNdjZ5c0NHSGgyeS8wVFJW?=
 =?utf-8?B?QkQ1emhTWlVKaVFZYWorN1lXQWxnaSsxNCsvYkhqVjR6REJGcnJoalNiVUFC?=
 =?utf-8?B?QTE0Y016anlNSlE0dEtOUHlFNk9jYkpVcWtGSGpPb3N4TFZZWEdLSFFEU3Iv?=
 =?utf-8?B?MjVGTDk1citOOU1FMXlEaGdjcnU4QXJZbGV3c3BkTmxyUWpvcXI2WFJMT29W?=
 =?utf-8?B?cm03dHVlbDBhUjlDWTRnYlY4RUs5OFNNTHZqNzcxMHloT0JlWnMyV3VCa3Zt?=
 =?utf-8?B?eTFURHpRQWZPN1VmRzUyNFduZ0FpR1NVaXdsdFV1NE5Pd0UvWkhaNktoQkxa?=
 =?utf-8?B?VWxKckdqTFg3TTJ4RmFGODVRQWptRnlzdjQvR1VvUWltZWZFMTJ1SFcxdkVx?=
 =?utf-8?B?aFNRMm9BUSt4RUY3VU5PV0tUbU1RUDlxTHRRYTlFOXB6SGI3aWRnWG5uY0Ft?=
 =?utf-8?B?ZEl2VWNqbjNOaE1wVGhvbUxPcmlIdkFLdFNNemhoRm93T1Z0L2U3SU92ZnZw?=
 =?utf-8?B?eFlwOVR6TGhjaFN4NGFUQy9Ia0lSMS83QncvejBwWWVIajhncDJLT1YyU01t?=
 =?utf-8?B?bXVzS2lTT0tyN2pMdnlkTnBjUHBmTmw5QktMeHZYT0J4ZUxlNGhlWktqdXhK?=
 =?utf-8?B?UUd1UEl6TDU5S0RFTi9saFJtMEpQLzNhVXQwWU1NeHBLMWJvUnpxeWoxTmNm?=
 =?utf-8?B?RDFTMks0SzhEeENjN1J4eXdueGhFeU1WaHZNNnVkYUgwc2VmaWxnRVFyb1hS?=
 =?utf-8?B?Qm1UUTRMU1VVSnJ3Z25lMExRRjNreXp4cEVSY0pkVVR2OHhzUDNDQnF5RXRr?=
 =?utf-8?B?QnNsZElEc2k0aTYva3ZSckZ0VWJLK0hWdDZWR2R0dTBNbzVyMVk5b1U2T0tB?=
 =?utf-8?B?NkFBMzJhS2NmL2c3aXhqOTRTbXdPTVFuTzQwYVRuUXYvOVBKSTZQVEJvbnY1?=
 =?utf-8?B?N2s4MjMvOVVvc3EyMnlOc1JMRlZaaUhlQ2NCYVV2RXFsNVVwQWFNU055cFgr?=
 =?utf-8?B?VkZvUTNrQlNzMzZEMGQxQlJhSlVZaWZ1T0lvZjBkMHlXMjRFbTdqeE1mSGVX?=
 =?utf-8?B?dnc0a2VtMS9tUkNoazA1bHVrRE5xNGUveDRhQ0tiVEZna3VGVG82TG5UWUN6?=
 =?utf-8?B?MG0zOXgxcnoxenl1SzZnT2M0ZlJHZ1A4QlZVSUl4VzVuU3FLam9keitORWFP?=
 =?utf-8?B?R2pvNmIvdThubGloWkhuMWRYQVAvdEJra1BHSzBReU5pejNkcEExUVZNS0hG?=
 =?utf-8?B?M2RhR3phbHA5OGZtcFp6bXMwbWt0V1ZZVzk0RVBVRS9xcysyNktycnBoQ2cy?=
 =?utf-8?B?dUJrdTJSb2luWmhoRlUxN0d6bjZ2VEFyY0ovUnlRQzNwbitZYnJDcDNjaDFB?=
 =?utf-8?B?Vk5VZHFSNmlLR0NHN2EzZUJENEFadjBkeTl6R2xzQjFkRm0rbkluYzJPZEFE?=
 =?utf-8?B?NlR0c0RPT3ROejNpV1FsWVdYRVZXM2dKWThmUWhXUWpMYk5SdFZXVlp1c0dz?=
 =?utf-8?B?d1JqNG55V2tuRXhBTElpM1R6cmdsSjU0b2NJRElvZGlkUjdpMUxhNkk0QTUx?=
 =?utf-8?B?SE44RTBXRmdUcUN0TDd4RktQTE1pakNVbXd6bXM2bytaUTNEVytudCtDQ09Y?=
 =?utf-8?B?SFZqbFphSEVaL1hvOG1ranZxamxvYnpJb3gzU29GRUFyaFZOZEloZk1obEFL?=
 =?utf-8?B?eURFZG81TUV2UzI3cUpvT3pvRnA0MzJnTDY5UGx1SUpnRGpUVngrdElkeDE0?=
 =?utf-8?B?NW9zMm1iRUxvOWgvajFvODZpZHFkMnpsSHV0aVFaVWRuYWpJZ3dFYlVBLzhR?=
 =?utf-8?B?dVpwRWlya3FzY2hXYWtWV2FwR0t4T0NOT2lzd0N1L0ZRdmxLTnVMWk54ZHdY?=
 =?utf-8?B?VDFvbUFmTVBjZ0hhdU5JMlpZdWd6TkZTbUVjNWpvbzhodHZDRUR0S1JuTkEx?=
 =?utf-8?Q?+Vde7NWc3eXYHVT2VrLoe8/bcX2Zw8gI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8254.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TW9wUmQyRitVcGtzTWh6c2YyUlB4VWZtVFAxdDE3UjJOVDgvWldzb3RGVUls?=
 =?utf-8?B?T3JRWUp3SXgveDkzcmgvOEVQV0J6U2Z0TmdJQjBrNnlJa0R5dko4Smp5aEZ5?=
 =?utf-8?B?TzF6Nm9PY0hFOFR0QWNWejVEdVlDRjE2WkdkVUx4cGJTS0RmTFpzZXphcDJj?=
 =?utf-8?B?dEdsZk1CWTBPeFNxaEEwR0FsQXJxTkVZQUJJTGRkcjNOWks4dzNWZnk4YWFv?=
 =?utf-8?B?UXBrSW5CUURzbXJqUWJtVlM0d0NjbzFWdVN6Rmo5UEgyYzlxYk4yS0o1d2V5?=
 =?utf-8?B?WlBRSkVWQnlvWlU2KzVPNTg1cVFGY3p1bHlhcHAyQWt5cm4vYWVMTm51WXd2?=
 =?utf-8?B?R0I5KzRPb3J2em5VWnYxZGpBdGZmbE9tNE03YnBZR1EzSnBDZTdxUDcrOHBE?=
 =?utf-8?B?RVhjd0xNeTdtVzFHZGhiU0dSNXRiMjZqN05MNlowNy9ORlFaRzZJSTdlT3RM?=
 =?utf-8?B?R2h2TTlHNnArRG5KTHh3azI5bzRmSXNMcHRkR3ZVUC9oMnd0Y1pGWmgzZHRq?=
 =?utf-8?B?K1hEekZGaDhPMjNzZlkzNFZ0MlgxSjNIZ3luN2pZYW5WNVFSY3hvU2JUdVBP?=
 =?utf-8?B?L2Q3dGVYdDh1dS9kSzBiSHBMd2EzaldJeXZuTGFkelFzWVhzbUR4cW5LTm5W?=
 =?utf-8?B?OENQVm9EQ2xoVlRGaE02S0Uzc0xQZE9pclc5WE82SkdjcXcyTVFNYkowRmI1?=
 =?utf-8?B?enIzQlU3SnBKazBWUEhnMTd4OEg4L2trV3EwRVVaN3VEZytZc2M4SE0yOEtF?=
 =?utf-8?B?YnJNRE1lOE51YW5leGdZY2VZVnptR1dUcXI1VDZGSDlDWG5DekM4WW9RcmQy?=
 =?utf-8?B?NW5FYTdWWmZsQ21ndnZXMXFXL1JzUDBUWTNuZ2xmREZFVFlRVnI3OU92cktM?=
 =?utf-8?B?VlJtN2NxbjUxS3M4Kzd5aTN1TXoxRlFuOEtwSVcwNDM4bFl2MmwyYmdUNEtR?=
 =?utf-8?B?TVZGcEtXK05VR2Vqd3pyQkhDUkNWQk81dExoNUR3MEdMaHFITkc5aDl1eGpo?=
 =?utf-8?B?NE54VS9JdkZQZUpMME5FbEc1UTdqd2plNTJCZmw5SWQ4eFM0bCtmKzdHK0pr?=
 =?utf-8?B?NlptSjBBbVoybnRGbkw4RlUwRVZMOFpMOCtSY2kwQ0JhNmp5Q01mZHFScEV5?=
 =?utf-8?B?S2l0U1F4OXJaaXRPKzF1WDlRbVNBWStiLzNEcDNQYnVJclk3QXphNmpqMXhK?=
 =?utf-8?B?K0hnZG4vQ2RHRXE0L3RZbTd4SHhpcExhU0l0QlduMEJONU5PTS8vaUQ0MmlX?=
 =?utf-8?B?cEJEc0o2UmRrU2RoVmhJSTIwbGUyZ1M1MEd1Z2VTVXZpZWJyVXdHbStiNndR?=
 =?utf-8?B?YXZlNTlleFRVbHJnSnBkYkhVemJHZllrbnRkdDhsVWo0WnBVSDRrcVAxdk9v?=
 =?utf-8?B?SmNjVHRRNzlSamh0RWsrWjRGWVhVWHl6Si9ORW5xakI3N3ZWb0I5M1JrVmVv?=
 =?utf-8?B?SFBMSjl3RERVb2lRbWFDbm02L0IxZkJwaHZuWWlMNlJNWGNOQlk0NGtXQzVP?=
 =?utf-8?B?SUREWjJVWVd3SnRqVnlqVGpYbExQZm9iMlQ5ZXZlYms3RHNHZk8raldXMXR0?=
 =?utf-8?B?ZlpGMFNWUStQcFJwakorMUtjWDRqT2UxNnVUYjUwdUR6dm8vNTVMY1R0OVhh?=
 =?utf-8?B?b3VWVjZFRDIyaVc4Q0FGSW5jc0lLYVNqU2ZLVVQzbDlialpWRExKWUcxd2Jq?=
 =?utf-8?B?QXBaMVNVT2RWUUwzS2xnUkwzd0JtUGdWQ2VPQWQrWVYxdVNNVkJGQURYbEdp?=
 =?utf-8?B?c3RVcTZCZXBhcnlnblNRQWFJdjNJVnNxV0V6Ni90RWJxR1pUdFRKemVGSEN4?=
 =?utf-8?B?SmEvaWszL25JZ1BIZWVUTmlPUkJQcU9VY0hvMkhGUTdNZkhsYVRhQTRVaXdR?=
 =?utf-8?B?NlVnOTlLR3hSOHZ5MkhPMnlRa011VVNkcU1VdjliZDFTWWdmWVlVa0FITHow?=
 =?utf-8?B?VU5XVVNWN3hId0FmMk1FeG1UL0lrR0xtWm9XbHVBNHlCZHpmVHFsbkFOc05Q?=
 =?utf-8?B?NmVhdlJKTnk4OENpaHNXc1lmNkw3K2NNckNXbUJybk02TU1QVC9OOW1vQmNs?=
 =?utf-8?B?SUJYc2N3ZDdlSE0rWUdCS0dTcTduR1ZsUlNKMGNMTmI4M2pzVDYzVUNod2xv?=
 =?utf-8?Q?R0KqQnD2WSgMmzDg9WEGKLd9j?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39553791-7ae1-4f80-7d2c-08de307b1d26
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8254.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 01:44:06.4717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fx8uKIJTWDmJ5UNF1ACyQ7vs8eynl+TfMlHYJAa/Ds0BahHsSEeM3Hwb8QHlo4s0vw9J65S+2O8GW7FnfiGa9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8317

Hi Lucas,

On 11/28/2025 6:38 PM, Lucas Stach wrote:
> Am Freitag, dem 28.11.2025 um 10:51 +0800 schrieb
> ming.qian@oss.nxp.com:
>> From: Ming Qian <ming.qian@oss.nxp.com>
>>
>> For i.MX8MQ platform, the ADB in the VPUMIX domain has no separate reset
>> and clock enable bits, but is ungated and reset together with the VPUs.
>> So we can't reset G1 or G2 separately, it may led to the system hang.
>> Remove rst_mask and clk_mask of imx8mq_vpu_blk_ctl_domain_data.
>> Let imx8mq_vpu_power_notifier() do really vpu reset.
>>
>> Fixes: 608d7c325e85 ("soc: imx: imx8m-blk-ctrl: add i.MX8MQ VPU blk-ctrl")
>> Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
>> Reviewed-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> ---
>> v2
>> - Update commit message
>>
>>   drivers/pmdomain/imx/imx8m-blk-ctrl.c | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
>> index 5c83e5599f1e..1f07ff041295 100644
>> --- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
>> +++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
>> @@ -852,16 +852,12 @@ static const struct imx8m_blk_ctrl_domain_data imx8mq_vpu_blk_ctl_domain_data[]
>>   		.clk_names = (const char *[]){ "g1", },
>>   		.num_clks = 1,
>>   		.gpc_name = "g1",
>> -		.rst_mask = BIT(1),
>> -		.clk_mask = BIT(1),
> 
> Change itself looks okay to me. Can you please leave a small comment
> here and for the G2 domain to document why the clk and reset bits are
> removed, so one doesn't need to dig into the git history when reading
> the driver code?
> 
> Regards,
> Lucas

Sure, will do in v3

Regards,
Ming

> 
>>   	},
>>   	[IMX8MQ_VPUBLK_PD_G2] = {
>>   		.name = "vpublk-g2",
>>   		.clk_names = (const char *[]){ "g2", },
>>   		.num_clks = 1,
>>   		.gpc_name = "g2",
>> -		.rst_mask = BIT(0),
>> -		.clk_mask = BIT(0),
>>   	},
>>   };
>>   
> 


