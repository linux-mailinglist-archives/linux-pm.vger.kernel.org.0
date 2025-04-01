Return-Path: <linux-pm+bounces-24713-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E6FA78210
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 20:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ADF918911CE
	for <lists+linux-pm@lfdr.de>; Tue,  1 Apr 2025 18:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F47E20E6E3;
	Tue,  1 Apr 2025 18:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b5tn3YV/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wvMKc1yV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E911D86C6;
	Tue,  1 Apr 2025 18:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743531868; cv=fail; b=W0KXpemIG9ANWPkQm1SsU7awNz37eAq4R05BlLzODFbh67fekjq45SVUmAttp5hueS14WTi5WXAYu78lXD9Grqi5LxkV5qXDafd3u6hcPDeEjd78MCs39Famx7BPuqIGfhkBGVYXNq4CeHAYfCV/jxAhNGoF+9XbDGHWLp+Ubkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743531868; c=relaxed/simple;
	bh=Ix0+s6pXdtb65IDgF77db+mKNZdLCX+GzVBRz4j0rKw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fba+p/gicXxwOTJNkadN5VPilK2jJ88j3KtuitOB/4vVFoh+fwXEhEsNEC76Alv/0p0DJi0OZap/z35FUsPznw85Z7XI3M1e++ub1tOKp6HcqRgVG9qi0rZRY3plaLxtTOvjUYFQiNTGS3gprX2H0OGqboKRfqqGJ0B6ag27r54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b5tn3YV/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wvMKc1yV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 531IJvbN030487;
	Tue, 1 Apr 2025 18:24:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=1c1IpZL7O6627OTfRSrv9gcmy/TQfD4zCkla8/HWTCs=; b=
	b5tn3YV/a80FoIILgKYrvcleeZSMPHrBfMDyLWsC7VS0LRz7nyH4mE/5nMaZSGbW
	LETiKdBvVdHaclrrJqAJ/yGmNJqa7tz/XjqTPCd3IMZAIYZqFzSAu4wt4v3rgCi1
	j+CPoeyuHP28QW14NTDY85AYJDdu1B6cGpc/VDNtEh+caz212p7X5swNvCvsahej
	CHHFXO0Loi2T1QGHTL/UWeuThLq9b/KfFwUKCeiFyWUrSSuvJtZfHGFSMQhk4Y/V
	q3lmAsod1cVRFi03rGybZy932omlzEBKQrqi1r0mQNOze/ws+HFH1/+3lJ0Nzp4L
	O4+SfPSQJyV4jPvQzztU0A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p7f0gu59-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Apr 2025 18:24:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 531HcGFs032714;
	Tue, 1 Apr 2025 18:24:07 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45p7a9svcf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Apr 2025 18:24:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oUcf7GBEN1D30F2mSK9Ajm6zb1vAzU2sszcPAgX01gxtfYUzn30vdUy9cZXNHtdiFhyFYaNHpdMGilqUlLfA8NLHv3PnlzmpesSb3FkIC16FzrYleu6OurZpwnRpVpPs1RqB4hlxPmAaVKg8YVUUquVF71XL0FbVkSh6BBDXmHRCPtxKTGtKBiT55Td3NQMER/TnR+qEwIzBF3SlUtfWYHGNFVmxOkyc3l/CH1lC6c0FGqTRDn9u36nMSE8xLHQCLhVFspzqOtKdKNsJPvFMLC6r9N/fX2sBmTrfs1mKrALdi49JMBx+p2+yWiZ7YjcTYxrRxEibrk2RSpIhn6Zk5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1c1IpZL7O6627OTfRSrv9gcmy/TQfD4zCkla8/HWTCs=;
 b=XJ9ydRExu4kcv9g8/xCwYi/E+M7qZRlpU+32g/pbe3u7ZEbEros3cNp/Utcl9sAD4HcyaR9buYSVi6Qii1QqqARjSMmABEzrCaWNpSUhWgap3TikaMwy26G/Xw/HtVuOnJVCIf5aK1Zn6/F1U9aoxpg/i7wQQDgU8VApJQB/hwOQM8o+upwYc3GgLn5SAUpRVnMhEtf8Us5u8yr3rDCxdOQvx1jBvQmjEQlOns37HZE5zcVr9JujAumOYEUq1EcJHPneacqoMyguG3mdExPzrUhu4oE0dLyMmPSZE1rmeJEDejSatMeAHM5QZlA6wSD9H7llpTZ0jbCNFO4fPrEARw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1c1IpZL7O6627OTfRSrv9gcmy/TQfD4zCkla8/HWTCs=;
 b=wvMKc1yVJ2Fq1QF1xjxyLFkN5k9YvzA4MO0dHO5PbbUi6IS7fc05JVlUBf05E8RQoRBsvTNw7OZbX1Erf1jGeFTJFdbiqR84XLxXk9JQMPPss+ZOX7REx3XAqmqAeFyWRK9LljlE+r0durAFFY3dD2zi2JuGmiAlF67ZAg99dWY=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by DM4PR10MB7389.namprd10.prod.outlook.com (2603:10b6:8:10f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.38; Tue, 1 Apr
 2025 18:24:04 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.8583.038; Tue, 1 Apr 2025
 18:24:04 +0000
Message-ID: <ca50f9b4-feb5-4365-927d-a2c931e268ed@oracle.com>
Date: Tue, 1 Apr 2025 23:53:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re : [PATCH v5 3/5] thermal: renesas: rzg3e: Add thermal driver for
 the Renesas RZ/G3E SoC
To: John Madieu <john.madieu.xa@bp.renesas.com>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "robh@kernel.org"
 <robh@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Cc: "magnus.damm@gmail.com" <magnus.damm@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "john.madieu@gmail.com" <john.madieu@gmail.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Biju Das
 <biju.das.jz@bp.renesas.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "lukasz.luba@arm.com" <lukasz.luba@arm.com>
References: <20250330214945.185725-1-john.madieu.xa@bp.renesas.com>
 <20250330214945.185725-4-john.madieu.xa@bp.renesas.com>
 <a380c593-a2a4-40d2-8b2f-e3e1a2cdbe9e@oracle.com>
 <OSBPR01MB277527932C5570EBC3D877C7FFAC2@OSBPR01MB2775.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <OSBPR01MB277527932C5570EBC3D877C7FFAC2@OSBPR01MB2775.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0197.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::8) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|DM4PR10MB7389:EE_
X-MS-Office365-Filtering-Correlation-Id: 87619dd5-401d-4a28-1787-08dd714a61c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VSs3MzAxOVc0TWtkMnRRMXpkc2NWNXliMDF5TVI1V0ZvVzQ1cWJ6azY0TUF2?=
 =?utf-8?B?aVA0SWR0alMvWkxvUTcwWDJtL2tZNFh1eFRGdkhkZ1N3NmY2eUkvd1RNdzAv?=
 =?utf-8?B?R0lra1F2bFJPcldKR0ZGUFVWckp6OUQyVWVrbXNnTnJnL2dZNjhuYWx6cFJ0?=
 =?utf-8?B?NnMwaDhrRnFqeUhwVENlOGlpN1lwK1lKeUptY0ZONGRBMTdqcDVFb0pSMXY1?=
 =?utf-8?B?Yjg3Zi9QRm9MNmN2QXcrQjFjTDNOZ1Y2c1M5VUhVYlVTQldQcEUwNDBvLy9w?=
 =?utf-8?B?ZSt4VmQ4NlpDNVVUSlp0QmhrdW9LRnZBa2NZT25PZSsxWjFTaXB3dGRZZEk3?=
 =?utf-8?B?MDRxcU9KK1VVSWJwM1o2eWUwR2V0dnRNc1hCbFdVYWR0SzkrbTQyMkpqVC9F?=
 =?utf-8?B?MjRoNS80ZXlISHJkcDUzQXVvdkVLUWxnc3lOV3llaFZ1M1ZjRE1SWFYxUW5j?=
 =?utf-8?B?TjUyeCtHYW52bGJMbnhyWnZMbk9XdFJLcm9UM0V1Y3dJZ3ZoOEJVMXJLNzBp?=
 =?utf-8?B?Z0lEZVlEWjFnVnFBQkF6ODZISGlBcVNkQit4MTNaVlBSR1lTSDlLcW9tMEVO?=
 =?utf-8?B?RzF1d3A0OFFXSmMrN2lFWnlBWFN0TkdFclg0eGxtV1k1MzJSY0JYVE5ySExY?=
 =?utf-8?B?RzczMzF1ekZuVi9HaG5CUkVsL2RxRGE2dW9mMnBHdExrb0pOcUhXSHJ2b1Ur?=
 =?utf-8?B?R05HZjNNQnZVZnRhU3orL1gzRXVFRUtHZW1oVUY5dmdaZXJLRVA1Y0M5ajJp?=
 =?utf-8?B?V1A0NEQ3YUpHc0RZSTRWMW1CYVBFR2lCakJ2d1YyUXcyVHlpS1Nka1dWUUtM?=
 =?utf-8?B?RXdyeDlFVXI5WFV5M2tieHZlNFdkdWkxTEtFU1Y1NXlwNUk4MmV4eFlxL2x2?=
 =?utf-8?B?VyszY2JMWVlkRFdoREUyU2pCMHRsejVYV2dxM2hscEFXVWxIQy9lRVovb203?=
 =?utf-8?B?ZDc4NnF1U3BweDA4ZU95aHNOanU1eFFxWlpxbmVsaFBGblByQ1ZBS3pFTHhR?=
 =?utf-8?B?T2RJZGRjR3JTZjBYbWUwdVRHUTBTSElhZ2RmSkxBTzlmU1NhODBlSW5LSTNl?=
 =?utf-8?B?VnNnemFPbjZNZnhON1Z1L3Q1bnBad0pSOXJBZnVhSzBma0k0eDFRUTRwd2cr?=
 =?utf-8?B?VUMvZzVmdkJ0VlA1U0J2d29id1o3UVBkME5vMjAzYUxXeDFDNUx0NzZDaXNk?=
 =?utf-8?B?a0s5b29oTlVYTEJZbTBUMk9SQTY5c3JnYnlZd25NWmlDcFB4akNrNVlkcnBZ?=
 =?utf-8?B?ai9kL1R2S0FVdlNBTHg2U1V5d2cvT3RTN0ZnUG5YK2hmK2FXazFicisxelZp?=
 =?utf-8?B?T2YzRCt4UUtOZ0tZeE5jcmV4RlkxdkFlMVNCUGx3eC9pcEx6YmJSZUJUcnZJ?=
 =?utf-8?B?aHhDU3lYenNTUVNKRjZ0eUtCek9HWVNVbzBkakVSa01MOXVhZW1VZWhqMmNV?=
 =?utf-8?B?ZlZaRHNTaUNVT2w3N3pESXdFeHJFVG80K0FJbUxlVlpiK25kdDFtVS9XZis2?=
 =?utf-8?B?eE9NSWhuRW9yc0YySFhJOW92VW53ZlRkblNYR1BqaCtPNXVWeFk2QktuMVF0?=
 =?utf-8?B?YWFjUThFODRyMERuNlUydnN1eTBtcDV5UHI3dTNoT3owODhlbVdYbzBFSU5B?=
 =?utf-8?B?WmRXYm1HUVdSY1JhbDl1VmNET0dtMEo0MkF3dUxuZ2QyMVh3Sy9SSGVDMm5x?=
 =?utf-8?B?cTR2bzgvYUc4ZytqV2l3Nnk0WUl0YzhWRGJ6SXpMQ2QzUUt4a0VVLzVoaGtH?=
 =?utf-8?B?a2p5QUNucEt3RE5yUisrTVAzc25Ya2ErWExNemw2KzhZa3Z5SGRPVnVjcGh5?=
 =?utf-8?B?V1RjbDlPWHVCTGZ6OHJ6YzVwU0xMWXNyMit0UXgvYmhRL1U0NCs4aHhRRkFt?=
 =?utf-8?Q?yYGImKkuUZcZN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dW9oa2JobEduTGhaR0o0bW1LVm8vdTZxQU53VWFNQk56aC8rY0NiZHYrc1Nm?=
 =?utf-8?B?N3UwbTlIeURhOEppZ0gxZEt6S0RPZGxhQjY1YXlyV2t3azMwUWZOdkRGbmhD?=
 =?utf-8?B?R3ZjVXZmQmViWkdVRVJvV1MzMFpMQnloWk1hMlplYnJRNUFJeVVGend3c1Ri?=
 =?utf-8?B?bCsxdjQvNWFVclZ3MUNBdFZvSk1YTncyOHhEOHlrUXNvRnJsYnhhRlovR1k1?=
 =?utf-8?B?N2dBZUxnNEdJOXRmczRZNVNQZ0tZbFNwUThkK1RBVkFMSTJGT0wwNTdZV0lU?=
 =?utf-8?B?RzdCQS9JUG5SNHBEZ040c25kZEJBRHZUa0JCZVhPZHVvTDF6NnpBSGZDTmJm?=
 =?utf-8?B?ZDg0SkxmTDN2akNIN0RUS0JrZi9sakJrSk1xKzN3TUg3WWVsTnlyVkxlVUM5?=
 =?utf-8?B?dkVuS1RHdTVLdlZ2d2w1S1RNNFozUlg4cnRtRU8zVmlkWUZRMjFzSHVHbzFO?=
 =?utf-8?B?Q3Z2NDFQZnQzUzVseTEvaGdZUEhtWmVBbDBLb3ArOEtVbW9PRzJFbzd3UmZy?=
 =?utf-8?B?eVdnRGxJYjZpc215SFlpWE8rMjhCYTA4SmxkRXA2dVhCaEUxMTdVOGlkM0Zu?=
 =?utf-8?B?NWVFeXVYQWl0VGNRdXBtdXlrQWZwSlU3ZUhkUE9PZmZPNmJaekUrZGV1Vk5O?=
 =?utf-8?B?Z0d3MGlJVDlmNVoyOEppelRpMEFGRVBqdXptaXppL1BjYWtZdW9UYXYzcW1Y?=
 =?utf-8?B?RUhVb0dnUkwyYTVmWW12U1V1M0hwNGlULzlGUUxxMWQ5eE0wTThDMVorRG0r?=
 =?utf-8?B?Q2tUSnFPbFlQNk1zRW5vQWdnczV1VE9paGJkblFhRHVLQS94WitzcmFiWFli?=
 =?utf-8?B?eFhWNnlUQjNudWZ1ZGx6K0ZkZlNZWVRqanpRRzFhOGtiVWpaenJxWUJwRmNz?=
 =?utf-8?B?Q3hOMDV2bkdtM2d5UFpZSHFTa0ZrZ2duSkRSbUhtVEorUlJZa0k3dnErNklq?=
 =?utf-8?B?TXdncENaNWU2dk40WU9HVldSRHpIdklYMFQ1RVZQWUZwcFd2NFA4QmN5L3pq?=
 =?utf-8?B?dWFnbXZ0cWxHdDd1SlBHdy9VNkE2aDhHL2tUSXlRTFQwVXAwenI3ZS8vZlMy?=
 =?utf-8?B?eHlEa1o2Mk05a09YRW9JcWVFZk9rZnN2UDBzeW04b0s1dFFkTkQ1c21FQnVO?=
 =?utf-8?B?MllRUGgvdnRBUUpmQ2tyNU1sazFKb043a0lDNlIrTWdycGdoZTRYUXI3WVdw?=
 =?utf-8?B?ay9GN1UrMUdzSk4xdDRQcE01RFR6dldLaGJ0VWtCT2toS2NrV2QyUm53Q3pL?=
 =?utf-8?B?UytFZWZoWHdnWDdQaU1RRHBWanBRS1ArVWhtbHB4bVMrRDBlWDFFM29uNGE5?=
 =?utf-8?B?LzUrcXdNd0xYWHRYN3RUSkNoc0I3MklodVVMMlRmMUthdll5NFF6aU5Sbk50?=
 =?utf-8?B?ek52aktCYXVFR0JXU1doUG5BeUhpNUhjNkt0YWZ1OGNidGdOSTFYVm9TekNi?=
 =?utf-8?B?a0xsYTR2TGZ1Tk13ZFFrcVVnY1k5c3RWRlJHMG1LTHV0NkdBRFdqTlVwQXJz?=
 =?utf-8?B?ZFFJN0FJbnRwejV3TkZpUlUzQWNVYmlGUWExcklSUXlxNU9iR3FKZU5PRXJ4?=
 =?utf-8?B?bHczUnh6WXhsc0pTdUtWQXpycGtteVhzR0FnTkJObkxtUzR0K2ZVOWswUW5r?=
 =?utf-8?B?ZzhVN0hjQTJJMG9rUDJ6TzRCZUNpQ2NPZm1KeEgxa25QOWNwMFNtTm5HYTBB?=
 =?utf-8?B?eXMzREJkb2NsN0J6YTZNVC9HOEplbEhRZ1JGUVFxSkNQZ0RtV2xzRGduVkhz?=
 =?utf-8?B?SGVmQVkwRWtybGVheGdXQUNhM2FNNmJkYTB1MWh4K1lkRFlzb0FTaGU5VXNx?=
 =?utf-8?B?Z1lvdXFwWnNmQ3luMlpnbEZOMGdDRkd0eEYrdkx5RnhmSE1MYVI5ZTgyZGM1?=
 =?utf-8?B?TmFORTVwamEvVUViZ0NlUm9vbVNTOHNEVGlzUlBJdFlIL1NVTmZiWkVWUmZa?=
 =?utf-8?B?Y3ZFMXR0eGRHTEl1Q1NSTlZvNURac01ZWnFzRis1cHNMNkFMdnZQa1pQWDdH?=
 =?utf-8?B?cldBekVSeEFZR0tZQ2ZYSk9Ob0s0MWtiMjVQbTEwRlk5SHQwUHZKQ1R5R0gx?=
 =?utf-8?B?cFZ3Y1JaNmNqYW5rTGlOTHFEaTJCd0F3VUNhRHQ0c1g1RjJwaDl6M2Zjc2Vl?=
 =?utf-8?Q?QruzL1HC9STw2B8LyP4IgXwc2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RkbelcJGt9ISJeAccxo8KwTJWnRePkoWVvr3Po3n9+OA2hTXjlFZXOhuHhip7a16fbR8G850errpyyn50OkdPAxx+oxIdY/RWPE2BMoKzSTDOdErQaePgxpXn+Ctj5jRGKPYUXAhI08vVJpGmPNz+TakoiHG6/rkPeqV+9DJYHNl9qwR2eRUcoR55zgwvkgDmIp3rhlEkPG21LlK905M+Zr8XT8jCKiWc36/6jI47PXJjHEkllb31OlMMiZV+aIVzmmLd7+N5PlCLV7MG0DPdnUMzZ4YfSccNUrsC+XPMgiIpGvlZfke8/CI0uEc9lHG+v/YvCM1LeN827tzRVH5xRy5AgmgcC7OzOS6ANohFlWztPD+9M8AlKIkHQ2uYDJtl/sdPQKrNOQV28U2iAg/DmtRXViX65YoUla/AtJEknziWFYZwWcNg8LgxDvBXTFWIK64huNr5fYgpQq3QLYDKxM3Vsj6gAR3nG/klG1XxqBCPRCvZTPZWfijtbhEHwoeQ1J4KvkYDcVBlUk/rUydiVuBver81O38Vj5EBqupWVxfAk2ZzVlQ60rNHdTADNpS8Px2ljm6GMuMyyo7byZsC/gqh/e8lildfYjRqS3iwlA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87619dd5-401d-4a28-1787-08dd714a61c8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 18:24:04.1501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1+kaRHvQRuANKE3CYXmi5xgJxyJL09Utd8B9CsgJLfM/1dPP3wqBYA9okUgcULxizkfWXAL6cw2B/DuHGBB/E5R+7kzQJYHzzXsJ+yZohRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7389
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_07,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504010113
X-Proofpoint-ORIG-GUID: TxkBuHwZ3WtV9LWPmBbxHkzYK40jqDOj
X-Proofpoint-GUID: TxkBuHwZ3WtV9LWPmBbxHkzYK40jqDOj

Hi John,

Thanks for your reply.

On 01-04-2025 17:35, John Madieu wrote:
> Hi Alok,
> 
> Thanks for your feedback.
> 
>> -----Original Message-----
>> From: ALOK TIWARI <alok.a.tiwari@oracle.com>
>> Sent: Monday, March 31, 2025 8:11 PM
>> To: John Madieu <john.madieu.xa@bp.renesas.com>; geert+renesas@glider.be;
>> conor+dt@kernel.org; krzk+dt@kernel.org; robh@kernel.org;
>> rafael@kernel.org; daniel.lezcano@linaro.org
>> Subject: Re : [PATCH v5 3/5] thermal: renesas: rzg3e: Add thermal driver
>> for the Renesas RZ/G3E SoC
>>
>>
>>
>> On 31-03-2025 03:19, John Madieu wrote:
>>> The RZ/G3E SoC integrates a Temperature Sensor Unit (TSU) block

>>> +static int rzg3e_thermal_change_mode(struct thermal_zone_device *tz,
>>> +				     enum thermal_device_mode mode) {
>>> +	struct rzg3e_thermal_priv *priv = thermal_zone_device_priv(tz);
>>> +
>>> +	if (mode == THERMAL_DEVICE_DISABLED)
>>> +		rzg3e_thermal_hw_disable(priv);
>>> +	else
>>> +		rzg3e_thermal_hw_enable(priv);
>>> +
>>> +	priv->mode = mode;
>>> +	return 0;
>>> +}
>>> +
>> always return 0 here ? what, if (!priv) return -EINVAL; ?
> 
> priv cannot be NULL here, guaranteed from probe().
> Returning 0 here is expected by the thermal framework to notify
> ops success.
> 

I agreed. priv cannot be NULL.
It appears that return 0 is deliberate in this case. can we add 
Meaningful comment which help to code readability.

not sure if user call ioctl(fd, THERMAL_IOC_SET_MODE, 2) and it returns 
0 with thermal enable.
that create possibility to thermal_core call thermal_notify_tz_disable 
if any case

>>> +static const struct thermal_zone_device_ops rzg3e_tz_ops = {
>>> +	.get_temp = rzg3e_thermal_get_temp,
>>> +	.set_trips = rzg3e_thermal_set_trips,
>>> +	.change_mode = rzg3e_thermal_change_mode, };
>> other renesas driver defined as rzg2l_tz_of_ops, can be used similar one
>> rzg3e_tz_of_ops for consistency!
> 
> Thanks for pointing it out. Makes sense. Will double check and
> update accordingly.
> 
>>> +
>>> +static int rzg3e_thermal_probe(struct platform_device *pdev) {
>>> +	struct device *dev = &pdev->dev;
>>> +	struct rzg3e_thermal_priv *priv;
>>> +	struct reset_control *rstc;
>>
>> Thanks,
>> Alok
> 
> Regards,
> John

Thanks,
Alok

