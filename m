Return-Path: <linux-pm+bounces-19565-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 991839F8E46
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 09:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D574D160C22
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 08:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD5E1A9B55;
	Fri, 20 Dec 2024 08:51:47 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazon11020091.outbound.protection.outlook.com [52.101.225.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4E71A83FC;
	Fri, 20 Dec 2024 08:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.225.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734684706; cv=fail; b=mvUQYL+2yyDS2A2QjO9vatVbXo5k6xO4iv75Ht1Qlh51lthoVY7E8wbP7voUc3J1e5nS5Byw9MELPEMhlYFA3xH5F9Oem80L+0cb7lW+6tBLsQZHVlf7HKDx1/RhOxo5/ZqjnxYRYcHzxuyHKJav8a8QonwLF/yaz3eq6BYusfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734684706; c=relaxed/simple;
	bh=TdiFWDUAiCeNTUQVh3+ZDyl/vz2T6MkhiZomXQ9D59E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uxpi96+8KMN6eyCcIhOwOG5LQD2LN6kW2fd5ThRRcBmk7nZP1V63J6Oqpb5XLpsrgTTcS274ZHsRh/V/Bt6P+0IECgqcaxXSQPDhY7KOMXjgVAIgTnXlGv6RcBZv7/2jSMT470yYUeSbhGmLpKgB8OLu3JnF4BGGLEJNJ2MqLi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=52.101.225.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bUFOZzT5HH5rFrm89T0ucTPdadI7xyuIO9wKFnVS+D/1LGtoBzIiAyypB662DAAdr+GWNQi78QlIohbAVN1NfTLaWfNFrxd5CSSvHn5QNjSt0RI1Aod0qvSrRi+b98nhtvMoHhq4rjHazYCCAkkIoPQ+wdNVBDkfMdvy6g2mLPBS5H97rYDvh5Rbbz7JOrTIGU1RsaXolcP9CfiCyZ36d5tO4pFwN9pPBrGVyzr4j/W0LMBQ395u18N/BfSB6sgYLIsGEROdAeLcuYVDQ/hU9jQ9KzWViP3vTNzDN7mL8LdFSwzih3JylJZupsoSLhX06PhvG39qla+VgAoY4kXfZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6yEqLuwLmA3MzpECiHISwby+VQ9zwkc7mGFNGPfy0YY=;
 b=MNcWEW1aPFHoLzJe/LHPTVkap0T4XqnlzawKFJzYjtwD6rdmS4928VwgLrT6x9tLEadPYGJ6bRaAdbGW9pSjr7XSGKzAHZdHqzSHHs/FSspw929zxJU93mJS7ZUZjFrPbKQCnMBV2Rys0YfGoACmfAy3nmtj1s7zLZkY5mUtt/oMIv4XU5yUecdLyqDPTzFPDeK0SdgXDXv5nYZaEvwtdxqJsCSHOmHkyT1GdihLdQxQd49CGIaPKTmpLd0U8NRXhHcF8aGKwGdyCSiIAnn0uWsFsEnb6LuoH6my8z/SGpKSkiMcgJTvbd44v005BwoLgcA68830rguP5NkWRzysOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM (2603:1096:c04:1::15d)
 by PN0P287MB1045.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:139::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 08:51:41 +0000
Received: from PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 ([fe80::740f:ab98:2be1:538]) by PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 ([fe80::740f:ab98:2be1:538%4]) with mapi id 15.20.8251.015; Fri, 20 Dec 2024
 08:51:41 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: sre@kernel.org
Cc: tarang.raval@siliconsignals.io,
	Bhavin Sharma <bhavin.sharma@siliconsignals.io>,
	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v13 2/2] power: supply: Add STC3117 fuel gauge unit driver
Date: Fri, 20 Dec 2024 14:19:55 +0530
Message-Id: <20241220084958.32367-3-bhavin.sharma@siliconsignals.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241220084958.32367-1-bhavin.sharma@siliconsignals.io>
References: <20241220084958.32367-1-bhavin.sharma@siliconsignals.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0254.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::20) To PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c04:1::15d)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN2PPFF679F9759:EE_|PN0P287MB1045:EE_
X-MS-Office365-Filtering-Correlation-Id: c9985256-91e2-4df0-3316-08dd20d38601
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zld2QVBSbzFQUy9jRTNDWVlQWEMyRktLcnlQakwvTERyb29BaWV0ek02VDFx?=
 =?utf-8?B?cGUvQU9vVVRZUFRoS2FUR05VMUg3REJNK2Q2ZDFRdjVCR094TUZKb04vbDNI?=
 =?utf-8?B?RHUxSnFXemNyUU9NNFZxM0xwcFgrYlJBcW4zelNaMXlSMEh1RHlzcmlGVkx6?=
 =?utf-8?B?bnJuRkcrMjZmaWJ0aGhZVkVyMkwyK0pSR1NERnFSU083NjRiMU5yd3pYeVh4?=
 =?utf-8?B?bDlWQi9HUllxR2xoTEIvU1ZhdXYzRjArbEcrWC9jaXUzMGxFdVBEMG5YekQ1?=
 =?utf-8?B?S0IwZ0JIZFdCMlltRnlSWTMyWTl0dG9jN3dyRlpTU3dMRzgvU0VLb0NERVI2?=
 =?utf-8?B?ZGF3SnJSTVJmMlVMY3M1STFwQ1NPallVOG16alZkdU5maVJmUXAwR1g2TTVn?=
 =?utf-8?B?V3lKdG5oY1c3T3oydm05SDM1MVZFTTBST2JLbmJCY1MvbmdpNDZFbkZWOCtS?=
 =?utf-8?B?MHUvUDlKRUNqS1F0QzhyU01pQzgwRmJxMExha2d3ODV6bTEvREtVeGl0ZXBR?=
 =?utf-8?B?NHpUL0RIem5hYWZ4eStHVkhFanQ2STFkSXZBS0VybktsanQrQmloR0tyNUNH?=
 =?utf-8?B?N0RpbmFwM2dSTXROMnl5ZG9pcWs1TUhSRkJnMjliY1ZMUC80RHdIaGR1SndG?=
 =?utf-8?B?bEdMTG51VXZWdllsZVhGL3NXSzBYRmhuZmgyODhNcVJvYmhDR1JYajhSUkpp?=
 =?utf-8?B?L2tZazZGQmY2c3dHM1Axb09mMG13L0JoQzdJa3Vzd0xNNVRwUXZkUFI2RkVq?=
 =?utf-8?B?S05ZYkZkRnRUR0xtTFIwaTBjRDFkKzVwMmlLNEFFL2VOMmxjWlMwUEVyRlpl?=
 =?utf-8?B?RDJhVjFmUitxdTFnZnNsVFFtSDJUUEtuRVF1VXYvN3J5TEU0SU9PN2NOOXJT?=
 =?utf-8?B?YWoyWTVnR2lJcDdRTTlYWGU4M21jbzUyM1FzZVc4dXdNK3BnRTJQQy9UOHlz?=
 =?utf-8?B?STdIZE5oQWpPYkljekRBenZyUW16UXIwc3hRdmZwbmh5ZzVRRS9wa3htbnFM?=
 =?utf-8?B?K2ZXRDRHL2NhNUFMcmRZRmtqREg3OEtZS1NFem9seVhCdFpWb0pTTjFCWTg0?=
 =?utf-8?B?Y2FEdmRJL1c4L0JQYVZobUwrcmNmbDhpZW50TW1pOHpNUWRITVZwM2VicVNT?=
 =?utf-8?B?Tm9jVkxucFVldUYzYngvN050Sm5FWWNteUtTa1habDFhc3lteTRBQzhNdXo3?=
 =?utf-8?B?OXgxMDY3MUNTeHhoTVVZd2NFUlNCVWVvamVpZkU1TGh5MmdUTFpINkUxak8z?=
 =?utf-8?B?STdaNXdzOEhXeDdWRXJyTXBlc2VDOUhtZnUycTdLZzVYWndtV2Q5ZWNLWW5N?=
 =?utf-8?B?cWtlT3cycGtxc1I5a20rUlB0cWNpdVF2ZHFFVlRMeHYwVUJ1VUpiaDIxUVkw?=
 =?utf-8?B?VWdrOW1mT1hoTlpXT2NjZ0JIS1hVaUZ2UXpkNndPN2xjYmNSM1RSemZONW94?=
 =?utf-8?B?TDdVN2phUkxZUjlUTGdFKzdjeXF5VXVpSkV4M3JwY2hMbkpYVHpPZmlPcXor?=
 =?utf-8?B?b1NVNXdwTnZ4K0Z4RDRpWUUrN3Z6VW1rTnVUaHlTZ1Ivb3lwODR3QUVRK1I1?=
 =?utf-8?B?b05BOUNzUllYUjB1ckxqT3NzeWhHVTNuREVFWUtTYXB0Y2VBNlBMYi9ybXpp?=
 =?utf-8?B?TkVJclRiR25NMm5BZEJCYXRIb0VTZWlobWVtV1NRU25RUFg5aWM5RXhBOU5R?=
 =?utf-8?B?dUJrOHZwOEtNV2ZyOVpQcDZiVW1TYW5UWGVFMlR3YlNqWXNtQitSTDRPL0oy?=
 =?utf-8?B?OWxKMXR2VmozZXRmN3kxY2hyK01aTU45N1JyekgveDg0VjcxVlQrOXFEejhM?=
 =?utf-8?B?eWJvUkhUS2VjRlM3TiswYUtaTlJzb0VDSzNLdlpHUEpQZjFwejlwRHI3d3JP?=
 =?utf-8?B?aHF2dmtHZ3dKcmNCUzdRczEwWGtyazVtTWxSa2Q4RmxraFZpdW9SZ3NaTFRi?=
 =?utf-8?Q?T7QdT1yX4bhi1sTEyYP9zFHopwpkYFSo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1NXNjl5NEZ5blR2YnRlaUdYK1VBNnlaYittVUQrTjMwdytFNTJ0UW5WaWgv?=
 =?utf-8?B?REI5TFdVZHhlWWxFWlZDMWxZQmJaTGg4UCtYamJsRmkzekJDNnQrOHRXU0Fm?=
 =?utf-8?B?WWNQTDVmRWN4K1RVNFpqUmVGTWhFeW5DYTcySWN3RzcyeThpM2J2ajE4NkEy?=
 =?utf-8?B?SXN2VFg1Nmlza1p0VjhCUGxuaHVvSE9GcitsK29rMmdvT2RtUWUwWk53czhw?=
 =?utf-8?B?Rnd6d3kxWVJJWDBvSExmWnBQcjNmOU04cWpocG5NZnZPMFVPbjFxRUM3RHRM?=
 =?utf-8?B?RTZBRmpYRW9aeU1CZExUZG9POGFTZFZZSERuUDlhaUxpMzJHQWV0NUFxcjlq?=
 =?utf-8?B?Sml1YlBPd2x4TUxuakJCamtXUFZ4cFRCSFFiOXRMcEp0c2ZEdFIxNVJOMXpq?=
 =?utf-8?B?a0ttTWEvejdVWkZ5Vzk4Z3JPV2dXTlV2Vzd1STJqeVl0bE5yZW04Ui9JUnJB?=
 =?utf-8?B?VTVJanNRU3JsZVJvaWFkVldLMHRScFFNRUNzQ2o0QUxuZ2xxbkJrUlFMQS91?=
 =?utf-8?B?WmhhVkJrSFlKc3NTMnlPV3gwelhocW45ZjlKK1pNWlVHRVdrS2xXSmhTSnZm?=
 =?utf-8?B?VXhSWXoxRUo5VVdxendkREJVTHUzSS9CaE1VVC8yamE0S1hMODIvMVVyMWRP?=
 =?utf-8?B?ZUZabDFvcVJoOXdxRGw0K2o5WXNuaWFVWUJ0cFlmNjhjVDBiZllZb1VUQWZK?=
 =?utf-8?B?RzZDV0p3NE9xdVJDYjA1Wnh3cVJETHFGS0FoTDlRUGh6L2dqeGxNcldVd2Fi?=
 =?utf-8?B?TElmR1lZK3pPaDRoUENkOWN6bnUyRGpGa3FyT2VEYXFDUm9yS2lTdEhPbVZ1?=
 =?utf-8?B?Umw1WnlKRDlHd3pVMlk0RzI5T1d2bDlJcENBd1RZVUgwTmI5Skw0OGVUNmNC?=
 =?utf-8?B?NEJlTnptZlU5NGI3NHdxb0pybzI1TmUwOXBuN2pkelVqMm44SW1OMm9xVmRs?=
 =?utf-8?B?UzNKQlo1VDltaFozYTVGLzlDZXZZT21ycDdQczE5S2lSVW1COGNoNjV4Y2tP?=
 =?utf-8?B?aG14WTlVMHNCY0hpblhKVGZFamlZYUJWMVd1ZzM0cWN2NWtyZXJFUzJvdGJ3?=
 =?utf-8?B?Y0NDME9NM2FXSFNnQXZvelFmSnFOZ2E4MFUyRHRUaUxKWndncTlpbU1xamE2?=
 =?utf-8?B?TFFDUWN2TEY2bXB1R3EvbTgzdllhaUR2NzBqaFltUWN5eWRPZ2JzZHdlVXVY?=
 =?utf-8?B?MzVpS1hyYmdvRXF2QnUrSlU2dytIa0l0UG1rdVZaMHNIWG5zM0FzYTI2aUlm?=
 =?utf-8?B?OFZQeVR4ZitFc2RidlVvSzNmNkUvWWNRb1RFenlsc24rRmdiS2RIWWRwTEh0?=
 =?utf-8?B?QmdiRERIaGJ3dnF5M0pCdjlGVUpBcml3NUNXdy9IK1E3VTI3ajdwM0lwN2s1?=
 =?utf-8?B?T25uRnUwYytVUGdxVHBPY2RxZEpoZlpXQ2xGWVVId3lHeVBmRHlyTDNFSkl6?=
 =?utf-8?B?SE1Gb1ltbHlob2lJazJ0dGV2dVZ3S2hQbTJNOGNqTlFaSzNMaWR4emRwME5X?=
 =?utf-8?B?RmEvd1prT0tjcVRtZE90SG1BMjIzdS9iSGxKRGxsalRSSGFkTUhrL1F5RkQ0?=
 =?utf-8?B?OGxuWjkxaVBjZWZtTE9DRnJFalRmSjBEdk9CdGQvMTNCTngyMzlRZWxVcUxm?=
 =?utf-8?B?QXMzanB0Vkt1aEl5akg3NTYzb2ZXNk1pNHFmQ1FabUlDYzdaMEREcENsRlVH?=
 =?utf-8?B?Zmo0QXFvQVFadUVoaUdLZ2NwSFlZb0gzbkNuZDU2RFIzY216K3lNZUR0R2N5?=
 =?utf-8?B?Y1BZVmFKM0RUK1FDNmE1R2MydCtob3ZydVplQUt4Lzh2SUtEYy81ZG1xK2c1?=
 =?utf-8?B?VmlGNDU4Z3JGY2gyRkMrVFovTVZOZC8vRkNEcnQ3VUhpbGZIQ09SRGNreVNM?=
 =?utf-8?B?cm9yZWZvMHB1d25aL0UrUElCMm1yQ2o2aUw3VEc5OE9OcDFXeUo5aVRhWVRZ?=
 =?utf-8?B?MmV1amFIUVR2Y3dQMnhkYnl1eXp6TWJSS01LSFpLUlo1dGNycWkxampzTFFm?=
 =?utf-8?B?YnNjaDVzcFVTY3BWWHl6NE1XWFU3SGRsNGNpekVCVDVzRk5yTWRsRzhhTTBH?=
 =?utf-8?B?NEdHNStqZFUzdytSUkJ3OU1NN1gvSUJpSzVFMTVKZVo1dTV2aE9mVEo5ZkJD?=
 =?utf-8?B?MFhvWjVQcHZVQTRucHdkYStmamdUOFBsTnVWNTN6Nldad1RwRkRFVHRlZXc1?=
 =?utf-8?Q?KWXI14bS2IdqI8VvYUEaO14=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: c9985256-91e2-4df0-3316-08dd20d38601
X-MS-Exchange-CrossTenant-AuthSource: PN2PPFF679F9759.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 08:51:41.6302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lcv51qrWqpiyRTOkNa20ZVTar9qNVimnCXmcuK/TYOCB2Gc1jb17G7xRNUjZvFDNCTbGuhzqd/tMkAOxOM3BbaabGcCqa7PzrKiMF/RC64g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1045

Adds initial support for the STC3117 fuel gauge.

The driver provides functionality to monitor key parameters including:
- Voltage
- Current
- State of Charge (SOC)
- Temperature
- Status

Co-developed-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
---
 MAINTAINERS                               |   8 +
 drivers/power/supply/Kconfig              |   7 +
 drivers/power/supply/Makefile             |   1 +
 drivers/power/supply/stc3117_fuel_gauge.c | 613 ++++++++++++++++++++++
 4 files changed, 629 insertions(+)
 create mode 100644 drivers/power/supply/stc3117_fuel_gauge.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7e29c4e86db1..847690a8d9a7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22170,6 +22170,14 @@ T:	git git://linuxtv.org/media.git
 F:	Documentation/devicetree/bindings/media/i2c/st,st-mipid02.yaml
 F:	drivers/media/i2c/st-mipid02.c
 
+ST STC3117 FUEL GAUGE DRIVER
+M:	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
+M:	Bhavin Sharma <bhavin.sharma@siliconsignals.io>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/power/supply/st,stc3117.yaml
+F:	drivers/power/supply/stc3117_fuel_gauge.c
+
 ST STM32 FIREWALL
 M:	Gatien Chevallier <gatien.chevallier@foss.st.com>
 S:	Maintained
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index 9f2eef6787f7..5c13fbc9751e 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -918,6 +918,13 @@ config FUEL_GAUGE_SC27XX
 	  Say Y here to enable support for fuel gauge with SC27XX
 	  PMIC chips.
 
+config FUEL_GAUGE_STC3117
+       tristate "STMicroelectronics STC3117 fuel gauge driver"
+       depends on I2C
+       help
+         Say Y here to enable support for fuel gauge with STC3117
+         chip.
+
 config CHARGER_UCS1002
 	tristate "Microchip UCS1002 USB Port Power Controller"
 	depends on I2C
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 59c4a9f40d28..b55cc48a4c86 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -108,6 +108,7 @@ obj-$(CONFIG_CHARGER_CROS_USBPD)	+= cros_usbpd-charger.o
 obj-$(CONFIG_CHARGER_CROS_PCHG)	+= cros_peripheral_charger.o
 obj-$(CONFIG_CHARGER_SC2731)	+= sc2731_charger.o
 obj-$(CONFIG_FUEL_GAUGE_SC27XX)	+= sc27xx_fuel_gauge.o
+obj-$(CONFIG_FUEL_GAUGE_STC3117)       += stc3117_fuel_gauge.o
 obj-$(CONFIG_CHARGER_UCS1002)	+= ucs1002_power.o
 obj-$(CONFIG_CHARGER_BD99954)	+= bd99954-charger.o
 obj-$(CONFIG_CHARGER_WILCO)	+= wilco-charger.o
diff --git a/drivers/power/supply/stc3117_fuel_gauge.c b/drivers/power/supply/stc3117_fuel_gauge.c
new file mode 100644
index 000000000000..b4aeee8a7232
--- /dev/null
+++ b/drivers/power/supply/stc3117_fuel_gauge.c
@@ -0,0 +1,613 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * stc3117_fuel_gauge.c - STMicroelectronics STC3117 Fuel Gauge Driver
+ *
+ * Copyright (c) 2024 Silicon Signals Pvt Ltd.
+ * Author:      Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
+ *              Bhavin Sharma <bhavin.sharma@siliconsignals.io>
+ */
+
+#include <linux/crc8.h>
+#include <linux/devm-helpers.h>
+#include <linux/i2c.h>
+#include <linux/power_supply.h>
+#include <linux/regmap.h>
+#include <linux/workqueue.h>
+
+#define STC3117_ADDR_MODE                      0x00
+#define STC3117_ADDR_CTRL                      0x01
+#define STC3117_ADDR_SOC_L                     0x02
+#define STC3117_ADDR_SOC_H                     0x03
+#define STC3117_ADDR_COUNTER_L                 0x04
+#define STC3117_ADDR_COUNTER_H                 0x05
+#define STC3117_ADDR_CURRENT_L                 0x06
+#define STC3117_ADDR_CURRENT_H                 0x07
+#define STC3117_ADDR_VOLTAGE_L                 0x08
+#define STC3117_ADDR_VOLTAGE_H                 0x09
+#define STC3117_ADDR_TEMPERATURE               0x0A
+#define STC3117_ADDR_AVG_CURRENT_L             0x0B
+#define STC3117_ADDR_AVG_CURRENT_H             0x0C
+#define STC3117_ADDR_OCV_L                     0x0D
+#define STC3117_ADDR_OCV_H                     0x0E
+#define STC3117_ADDR_CC_CNF_L                  0x0F
+#define STC3117_ADDR_CC_CNF_H                  0x10
+#define STC3117_ADDR_VM_CNF_L                  0x11
+#define STC3117_ADDR_VM_CNF_H                  0x12
+#define STC3117_ADDR_ALARM_soc                 0x13
+#define STC3117_ADDR_ALARM_VOLTAGE             0x14
+#define STC3117_ADDR_ID                        0x18
+#define STC3117_ADDR_CC_ADJ_L			0x1B
+#define STC3117_ADDR_CC_ADJ_H			0x1C
+#define STC3117_ADDR_VM_ADJ_L			0x1D
+#define STC3117_ADDR_VM_ADJ_H			0x1E
+#define STC3117_ADDR_RAM			0x20
+#define STC3117_ADDR_OCV_TABLE			0x30
+#define STC3117_ADDR_SOC_TABLE			0x30
+
+/* Bit mask definition */
+#define STC3117_ID			        0x16
+#define STC3117_MIXED_MODE			0x00
+#define STC3117_VMODE				BIT(0)
+#define STC3117_GG_RUN				BIT(4)
+#define STC3117_CC_MODE			BIT(5)
+#define STC3117_BATFAIL			BIT(3)
+#define STC3117_PORDET				BIT(4)
+#define STC3117_RAM_SIZE			16
+#define STC3117_OCV_TABLE_SIZE			16
+#define STC3117_RAM_TESTWORD			0x53A9
+#define STC3117_SOFT_RESET                     0x11
+#define STC3117_NOMINAL_CAPACITY		2600
+
+#define VOLTAGE_LSB_VALUE			9011
+#define CURRENT_LSB_VALUE			24084
+#define APP_CUTOFF_VOLTAGE			2500
+#define MAX_HRSOC				51200
+#define MAX_SOC				1000
+#define CHG_MIN_CURRENT			200
+#define CHG_END_CURRENT			20
+#define APP_MIN_CURRENT			(-5)
+#define BATTERY_FULL				95
+#define CRC8_POLYNOMIAL			0x07
+#define CRC8_INIT				0x00
+
+DECLARE_CRC8_TABLE(stc3117_crc_table);
+
+enum stc3117_state {
+	STC3117_INIT,
+	STC3117_RUNNING,
+	STC3117_POWERDN,
+};
+
+/* Default ocv curve Li-ion battery */
+static const int ocv_value[16] = {
+	3400, 3582, 3669, 3676, 3699, 3737, 3757, 3774,
+	3804, 3844, 3936, 3984, 4028, 4131, 4246, 4320
+};
+
+union stc3117_internal_ram {
+	u8 ram_bytes[STC3117_RAM_SIZE];
+	struct {
+	u16 testword;   /* 0-1    Bytes */
+	u16 hrsoc;      /* 2-3    Bytes */
+	u16 cc_cnf;     /* 4-5    Bytes */
+	u16 vm_cnf;     /* 6-7    Bytes */
+	u8 soc;         /* 8      Byte  */
+	u8 state;       /* 9      Byte  */
+	u8 unused[5];   /* 10-14  Bytes */
+	u8 crc;         /* 15     Byte  */
+	} reg;
+};
+
+struct stc3117_battery_info {
+	int voltage_min_mv;
+	int voltage_max_mv;
+	int battery_capacity_mah;
+	int sense_resistor;
+};
+
+struct stc3117_data {
+	struct i2c_client *client;
+	struct regmap *regmap;
+	struct delayed_work update_work;
+	struct power_supply *battery;
+	union stc3117_internal_ram ram_data;
+	struct stc3117_battery_info battery_info;
+
+	u8 soc_tab[16];
+	int cc_cnf;
+	int vm_cnf;
+	int cc_adj;
+	int vm_adj;
+	int avg_current;
+	int avg_voltage;
+	int batt_current;
+	int voltage;
+	int temp;
+	int soc;
+	int ocv;
+	int hrsoc;
+	int presence;
+};
+
+static int stc3117_convert(int value, int factor)
+{
+	value = (value * factor) / 4096;
+	return value * 1000;
+}
+
+static int stc3117_get_battery_data(struct stc3117_data *data)
+{
+	u8 reg_list[16];
+	u8 data_adjust[4];
+	int value, mode;
+
+	regmap_bulk_read(data->regmap, STC3117_ADDR_MODE,
+			 reg_list, sizeof(reg_list));
+
+	/* soc */
+	value = (reg_list[3] << 8) + reg_list[2];
+	data->hrsoc = value;
+	data->soc = (value * 10 + 256) / 512;
+
+	/* current in uA*/
+	value = (reg_list[7] << 8) + reg_list[6];
+	data->batt_current = stc3117_convert(value,
+			CURRENT_LSB_VALUE / data->battery_info.sense_resistor);
+
+	/* voltage in uV */
+	value = (reg_list[9] << 8) + reg_list[8];
+	data->voltage = stc3117_convert(value, VOLTAGE_LSB_VALUE);
+
+	/* temp in 1/10 °C */
+	data->temp = reg_list[10] * 10;
+
+	/* Avg current in uA */
+	value = (reg_list[12] << 8) + reg_list[11];
+	regmap_read(data->regmap, STC3117_ADDR_MODE, &mode);
+	if (!(mode & STC3117_VMODE)) {
+		value = stc3117_convert(value,
+			CURRENT_LSB_VALUE / data->battery_info.sense_resistor);
+		value = value / 4;
+	} else {
+		value = stc3117_convert(value, 36 * STC3117_NOMINAL_CAPACITY);
+	}
+	data->avg_current = value;
+
+	/* ocv in uV */
+	value = (reg_list[14] << 8) + reg_list[13];
+	value = stc3117_convert(value, VOLTAGE_LSB_VALUE);
+	value = (value + 2) / 4;
+	data->ocv = value;
+
+	/* CC & VM adjustment counters */
+	regmap_bulk_read(data->regmap, STC3117_ADDR_CC_ADJ_L,
+			 data_adjust, sizeof(data_adjust));
+	value = (data_adjust[1] << 8) + data_adjust[0];
+	data->cc_adj = value;
+
+	value = (data_adjust[3] << 8) + data_adjust[2];
+	data->vm_adj = value;
+
+	return 0;
+}
+
+static int ram_write(struct stc3117_data *data)
+{
+	int ret;
+
+	ret = regmap_bulk_write(data->regmap, STC3117_ADDR_RAM,
+				data->ram_data.ram_bytes, STC3117_RAM_SIZE);
+	if (ret)
+		return ret;
+
+	return 0;
+};
+
+static int ram_read(struct stc3117_data *data)
+{
+	int ret;
+
+	ret = regmap_bulk_read(data->regmap, STC3117_ADDR_RAM,
+			       data->ram_data.ram_bytes, STC3117_RAM_SIZE);
+	if (ret)
+		return ret;
+
+	return 0;
+};
+
+static int stc3117_set_para(struct stc3117_data *data)
+{
+	int ret;
+
+	ret = regmap_write(data->regmap, STC3117_ADDR_MODE, STC3117_VMODE);
+
+	for (int i = 0; i < STC3117_OCV_TABLE_SIZE; i++)
+		ret |= regmap_write(data->regmap, STC3117_ADDR_OCV_TABLE + i,
+			     ocv_value[i] * 100 / 55);
+	if (data->soc_tab[1] != 0)
+		ret |= regmap_bulk_write(data->regmap, STC3117_ADDR_SOC_TABLE,
+				  data->soc_tab, STC3117_OCV_TABLE_SIZE);
+
+	ret |= regmap_write(data->regmap, STC3117_ADDR_CC_CNF_H,
+				(data->ram_data.reg.cc_cnf >> 8) & 0xFF);
+
+	ret |= regmap_write(data->regmap, STC3117_ADDR_CC_CNF_L,
+					data->ram_data.reg.cc_cnf & 0xFF);
+
+	ret |= regmap_write(data->regmap, STC3117_ADDR_VM_CNF_H,
+				(data->ram_data.reg.vm_cnf >> 8) & 0xFF);
+
+	ret |= regmap_write(data->regmap, STC3117_ADDR_VM_CNF_L,
+					data->ram_data.reg.vm_cnf & 0xFF);
+
+	ret |= regmap_write(data->regmap, STC3117_ADDR_CTRL, 0x03);
+
+	ret |= regmap_write(data->regmap, STC3117_ADDR_MODE,
+					STC3117_MIXED_MODE | STC3117_GG_RUN);
+
+	return ret;
+};
+
+static int stc3117_init(struct stc3117_data *data)
+{
+	int id, ret;
+	int ctrl;
+	int ocv_m, ocv_l;
+
+	regmap_read(data->regmap, STC3117_ADDR_ID, &id);
+	if (id != STC3117_ID)
+		return -EINVAL;
+
+	data->cc_cnf = (data->battery_info.battery_capacity_mah *
+			data->battery_info.sense_resistor * 250 + 6194) / 12389;
+	data->vm_cnf = (data->battery_info.battery_capacity_mah
+						* 200 * 50 + 24444) / 48889;
+
+	/* Battery has not been removed */
+	data->presence = 1;
+
+	/* Read RAM data */
+	ret = ram_read(data);
+	if (ret)
+		return ret;
+
+	if (data->ram_data.reg.testword != STC3117_RAM_TESTWORD ||
+	    (crc8(stc3117_crc_table, data->ram_data.ram_bytes,
+					STC3117_RAM_SIZE, CRC8_INIT)) != 0) {
+		data->ram_data.reg.testword = STC3117_RAM_TESTWORD;
+		data->ram_data.reg.cc_cnf = data->cc_cnf;
+		data->ram_data.reg.vm_cnf = data->vm_cnf;
+		data->ram_data.reg.crc = crc8(stc3117_crc_table,
+						data->ram_data.ram_bytes,
+						STC3117_RAM_SIZE - 1, CRC8_INIT);
+
+		ret = regmap_read(data->regmap, STC3117_ADDR_OCV_H, &ocv_m);
+
+		ret |= regmap_read(data->regmap, STC3117_ADDR_OCV_L, &ocv_l);
+
+		ret |= stc3117_set_para(data);
+
+		ret |= regmap_write(data->regmap, STC3117_ADDR_OCV_H, ocv_m);
+
+		ret |= regmap_write(data->regmap, STC3117_ADDR_OCV_L, ocv_l);
+		if (ret)
+			return ret;
+	} else {
+		ret = regmap_read(data->regmap, STC3117_ADDR_CTRL, &ctrl);
+		if (ret)
+			return ret;
+
+		if ((ctrl & STC3117_BATFAIL) != 0  ||
+		    (ctrl & STC3117_PORDET) != 0) {
+			ret = regmap_read(data->regmap,
+					  STC3117_ADDR_OCV_H, &ocv_m);
+
+			ret |= regmap_read(data->regmap,
+						STC3117_ADDR_OCV_L, &ocv_l);
+
+			ret |= stc3117_set_para(data);
+
+			ret |= regmap_write(data->regmap,
+						STC3117_ADDR_OCV_H, ocv_m);
+
+			ret |= regmap_write(data->regmap,
+						STC3117_ADDR_OCV_L, ocv_l);
+			if (ret)
+				return ret;
+		} else {
+			ret = stc3117_set_para(data);
+			ret |= regmap_write(data->regmap, STC3117_ADDR_SOC_H,
+				     (data->ram_data.reg.hrsoc >> 8 & 0xFF));
+			ret |= regmap_write(data->regmap, STC3117_ADDR_SOC_L,
+				     (data->ram_data.reg.hrsoc & 0xFF));
+			if (ret)
+				return ret;
+		}
+	}
+
+	data->ram_data.reg.state = STC3117_INIT;
+	data->ram_data.reg.crc = crc8(stc3117_crc_table,
+					data->ram_data.ram_bytes,
+					STC3117_RAM_SIZE - 1, CRC8_INIT);
+	ret = ram_write(data);
+	if (ret)
+		return ret;
+
+	return 0;
+};
+
+static int stc3117_task(struct stc3117_data *data)
+{
+	int id, mode, ret;
+	int count_l, count_m;
+	int ocv_l, ocv_m;
+
+	regmap_read(data->regmap, STC3117_ADDR_ID, &id);
+	if (id != STC3117_ID) {
+		data->presence = 0;
+		return -EINVAL;
+	}
+
+	stc3117_get_battery_data(data);
+
+	/* Read RAM data */
+	ret = ram_read(data);
+	if (ret)
+		return ret;
+
+	if (data->ram_data.reg.testword != STC3117_RAM_TESTWORD ||
+	    (crc8(stc3117_crc_table, data->ram_data.ram_bytes,
+					STC3117_RAM_SIZE, CRC8_INIT) != 0)) {
+		data->ram_data.reg.testword = STC3117_RAM_TESTWORD;
+		data->ram_data.reg.cc_cnf = data->cc_cnf;
+		data->ram_data.reg.vm_cnf = data->vm_cnf;
+		data->ram_data.reg.crc = crc8(stc3117_crc_table,
+						data->ram_data.ram_bytes,
+						STC3117_RAM_SIZE - 1, CRC8_INIT);
+		data->ram_data.reg.state = STC3117_INIT;
+	}
+
+	/* check battery presence status */
+	ret = regmap_read(data->regmap, STC3117_ADDR_CTRL, &mode);
+	if ((mode & STC3117_BATFAIL) != 0) {
+		data->presence = 0;
+		data->ram_data.reg.testword = 0;
+		data->ram_data.reg.state = STC3117_INIT;
+		ret = ram_write(data);
+		ret |= regmap_write(data->regmap, STC3117_ADDR_CTRL, STC3117_PORDET);
+		if (ret)
+			return ret;
+	}
+
+	data->presence = 1;
+
+	ret = regmap_read(data->regmap, STC3117_ADDR_MODE, &mode);
+	if (ret)
+		return ret;
+	if ((mode & STC3117_GG_RUN) == 0) {
+		if (data->ram_data.reg.state > STC3117_INIT) {
+			ret = stc3117_set_para(data);
+
+			ret |= regmap_write(data->regmap, STC3117_ADDR_SOC_H,
+					(data->ram_data.reg.hrsoc >> 8 & 0xFF));
+			ret |= regmap_write(data->regmap, STC3117_ADDR_SOC_L,
+					(data->ram_data.reg.hrsoc & 0xFF));
+			if (ret)
+				return ret;
+		} else {
+			ret = regmap_read(data->regmap, STC3117_ADDR_OCV_H, &ocv_m);
+
+			ret |= regmap_read(data->regmap, STC3117_ADDR_OCV_L, &ocv_l);
+
+			ret |= stc3117_set_para(data);
+
+			ret |= regmap_write(data->regmap, STC3117_ADDR_OCV_H, ocv_m);
+
+			ret |= regmap_write(data->regmap, STC3117_ADDR_OCV_L, ocv_l);
+			if (ret)
+				return ret;
+		}
+		data->ram_data.reg.state = STC3117_INIT;
+	}
+
+	regmap_read(data->regmap, STC3117_ADDR_COUNTER_L, &count_l);
+	regmap_read(data->regmap, STC3117_ADDR_COUNTER_H, &count_m);
+
+	count_m = (count_m << 8) + count_l;
+
+	/* INIT state, wait for batt_current & temperature value available: */
+	if (data->ram_data.reg.state == STC3117_INIT && count_m > 4) {
+		data->avg_voltage = data->voltage;
+		data->avg_current = data->batt_current;
+		data->ram_data.reg.state = STC3117_RUNNING;
+	}
+
+	if (data->ram_data.reg.state != STC3117_RUNNING) {
+		data->batt_current = -ENODATA;
+		data->temp = -ENODATA;
+	} else {
+		if (data->voltage < APP_CUTOFF_VOLTAGE)
+			data->soc = -ENODATA;
+
+		if (mode & STC3117_VMODE) {
+			data->avg_current = -ENODATA;
+			data->batt_current = -ENODATA;
+		}
+	}
+
+	data->ram_data.reg.hrsoc = data->hrsoc;
+	data->ram_data.reg.soc = (data->soc + 5) / 10;
+	data->ram_data.reg.crc = crc8(stc3117_crc_table,
+					data->ram_data.ram_bytes,
+					STC3117_RAM_SIZE - 1, CRC8_INIT);
+
+	ret = ram_write(data);
+	if (ret)
+		return ret;
+	return 0;
+};
+
+static void fuel_gauge_update_work(struct work_struct *work)
+{
+	struct stc3117_data *data =
+		container_of(work, struct stc3117_data, update_work.work);
+
+	stc3117_task(data);
+
+	/* Schedule the work to run again in 2 seconds */
+	schedule_delayed_work(&data->update_work, msecs_to_jiffies(2000));
+}
+
+static int stc3117_get_property(struct power_supply *psy,
+	enum power_supply_property psp, union power_supply_propval *val)
+{
+	struct stc3117_data *data = power_supply_get_drvdata(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		if (data->soc > BATTERY_FULL)
+			val->intval = POWER_SUPPLY_STATUS_FULL;
+		else if (data->batt_current < 0)
+			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+		else if (data->batt_current > 0)
+			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
+		else
+			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		val->intval = data->voltage;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_NOW:
+		val->intval = data->batt_current;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_OCV:
+		val->intval = data->ocv;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_AVG:
+		val->intval = data->avg_current;
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY:
+		val->intval = data->soc;
+		break;
+	case POWER_SUPPLY_PROP_TEMP:
+		val->intval = data->temp;
+		break;
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = data->presence;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static enum power_supply_property stc3117_battery_props[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_VOLTAGE_OCV,
+	POWER_SUPPLY_PROP_CURRENT_AVG,
+	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_TEMP,
+	POWER_SUPPLY_PROP_PRESENT,
+};
+
+static const struct power_supply_desc stc3117_battery_desc = {
+	.name = "stc3117-battery",
+	.type = POWER_SUPPLY_TYPE_BATTERY,
+	.get_property = stc3117_get_property,
+	.properties = stc3117_battery_props,
+	.num_properties = ARRAY_SIZE(stc3117_battery_props),
+};
+
+static const struct regmap_config stc3117_regmap_config = {
+	.reg_bits       = 8,
+	.val_bits       = 8,
+};
+
+static int stc3117_probe(struct i2c_client *client)
+{
+	struct stc3117_data *data;
+	struct power_supply_config psy_cfg = {};
+	struct power_supply_battery_info *info;
+	int ret;
+
+	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->client = client;
+	data->regmap = devm_regmap_init_i2c(client, &stc3117_regmap_config);
+	if (IS_ERR(data->regmap))
+		return PTR_ERR(data->regmap);
+
+	psy_cfg.drv_data = data;
+
+	psy_cfg.fwnode = dev_fwnode(&client->dev);
+
+	crc8_populate_msb(stc3117_crc_table, CRC8_POLYNOMIAL);
+
+	data->battery = devm_power_supply_register(&client->dev,
+					&stc3117_battery_desc, &psy_cfg);
+	if (IS_ERR(data->battery))
+		return dev_err_probe(&client->dev, PTR_ERR(data->battery),
+					"failed to register battery\n");
+
+	ret = device_property_read_u32(&client->dev, "shunt-resistor-micro-ohms",
+					&data->battery_info.sense_resistor);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				"failed to get shunt-resistor-micro-ohms\n");
+	data->battery_info.sense_resistor = data->battery_info.sense_resistor / 1000;
+
+	ret = power_supply_get_battery_info(data->battery, &info);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+					"failed to get battery information\n");
+
+	data->battery_info.battery_capacity_mah = info->charge_full_design_uah / 1000;
+	data->battery_info.voltage_min_mv = info->voltage_min_design_uv / 1000;
+	data->battery_info.voltage_max_mv = info->voltage_max_design_uv / 1000;
+
+	ret = stc3117_init(data);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				"failed to initialize of stc3117\n");
+
+	ret = devm_delayed_work_autocancel(&client->dev, &data->update_work,
+					   fuel_gauge_update_work);
+	if (ret)
+		return ret;
+
+	schedule_delayed_work(&data->update_work, 0);
+
+	return 0;
+}
+
+static const struct i2c_device_id stc3117_id[] = {
+	{ "stc3117", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, stc3117_id);
+
+static const struct of_device_id stc3117_of_match[] = {
+	{ .compatible = "st,stc3117" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, stc3117_of_match);
+
+static struct i2c_driver stc3117_i2c_driver = {
+	.driver = {
+		.name = "stc3117_i2c_driver",
+		.of_match_table = stc3117_of_match,
+	},
+	.probe = stc3117_probe,
+	.id_table = stc3117_id,
+};
+
+module_i2c_driver(stc3117_i2c_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>");
+MODULE_AUTHOR("Bhavin Sharma <bhavin.sharma@siliconsignals.io>");
+MODULE_DESCRIPTION("STC3117 Fuel Gauge Driver");
-- 
2.34.1


