Return-Path: <linux-pm+bounces-41723-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id lxpoNVu8e2mgIAIAu9opvQ
	(envelope-from <linux-pm+bounces-41723-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 21:00:27 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0B9B41F4
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 21:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5AF43018BCF
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 20:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA84238C1F;
	Thu, 29 Jan 2026 20:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NO86FIhA"
X-Original-To: linux-pm@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013020.outbound.protection.outlook.com [40.107.162.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAE82581;
	Thu, 29 Jan 2026 20:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769716825; cv=fail; b=TII68Lz7+5F4hsnpBrpeuQ6Fgcm8UF3INZ6hRR27Asfd7pRjftxBzvN6AOu/CuBg6lTH9V9VCyqjtTWeZGcqLr6BlHJFqmVAcOsCeEgdOdnVttuHUWcEDOFenC+2/sEqh4c+B4MHw+OeuLjUqMFkGScGwYDwKAskngSuYSYKKOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769716825; c=relaxed/simple;
	bh=oa6/+wbyo2AIBs+wBt62pqDq2w5UObLGsavNNuEKHls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iZHE2ebiO32tXZtrKziCtzuzupgFg7bZ4aQTf6NJIop/dP+D320Cs2SLwHnvfOJqfz4szd6rh1F7jA45ECur7o4+e4V/4OQw8R823GpoFoUZlomLorxH2i/1+zF6a7JxWMZII2XHLMJAQoFVc0HuLV0MYA46EkpGKrNf5b/iZFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NO86FIhA; arc=fail smtp.client-ip=40.107.162.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CcIlBCBhftv7J3bcA8QdVCRHel22s0Bh+nKD1O9vL0dGcGf/M9TUUlR6K5WdQAPBz5LSX5Wa1QpCQAOb8Fb3alf1M4PgcPiIy0gtFyOTx89/jl47KYohighv4t03fQQPL+p0uX1L6TJF3FqT1YNsmY0YUOcDiczzG8iTMs5VbFxK6NwvCY1SIdG//C3NMNexcwBRzm9diYYnxnBhjIul828kwlw1AZMIdOTPQywje9OzMnyQldP2REEWYc90Yk+WhcW+A7xIBzc1LDtmtn0V1Pg71ehYOIfA6clxIK9CyCoseIvo7+cDMSjkSJCY86KeI9a6oyBXvyh39NdrvNR/Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5EPlQY3wkWQ4yoVkr3KNZc+1lpTDqoZD9FiJRINhVMw=;
 b=nOoRqJnLFx85aNAXt6GT7bOj2PwAfDQ+v2U1TJz1zqXdhqobH+FxjAr2VS5GVTm4PZmXim49NjCC/DfjRfofF7KEdvv7EOKIRBdHfGXepemVJG6C/Hlh4YqFqOmQey3yB5RJYYl9vYcavLn2CW66xCIj579NW8TsonywNeXrqbMCeSBzGMeFA1i1iiMBBAeZ7WxlWtu8v5LjWvVqD3QTAny0oyWmLZ9gsbFgfDpGIzRX2ljBhqPzvbuC+argGr3IUxMSCjPpuZWkm1673dltgl4X+hF1uEC7Grelk2EGO/sYhEXH8nEpNjbFLMYUZsP6BQiLimZ8wkwkYbQh9Po+pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5EPlQY3wkWQ4yoVkr3KNZc+1lpTDqoZD9FiJRINhVMw=;
 b=NO86FIhAhmDOSE7PtN6XfgzWvrdrpfw+le3m74hqNsdfJE2LHzJy+WMLG1kR9Q/DVQ8u6x2BVGpV2cCk9hj/g86jTHfYmdEphNwMsOb1FrmcJQKdJjlmB0/jSw+9bzE4vo4jT+rnYbsIICNmy9f9EMjvL9oE/YzTqNo+91ze7AVjEpeZ56vON7fs5aAb8L8Gcd27rtrWLKKIeNEL8G4MKaoB3b+sbqbhBJuAvvH9dUBzxUvaAKMcZ+50db/fB5wYBJyidPP+R6zA+0S4JyaMNpwaQFbeGHXTMIIH9gE80bEAXdGVYiTnEukY2PgjWd+aFX3fvkbJxA1xwRxGGo4KLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM9PR04MB8859.eurprd04.prod.outlook.com (2603:10a6:20b:40a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 20:00:21 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9520.005; Thu, 29 Jan 2026
 20:00:20 +0000
Date: Thu, 29 Jan 2026 15:00:14 -0500
From: Frank Li <Frank.li@nxp.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: alexandre.belloni@bootlin.com, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 5/7] i3c: mipi-i3c-hci: Allow parent to manage runtime PM
Message-ID: <aXu8TiFpMiIVk5Iq@lizhi-Precision-Tower-5810>
References: <20260129181841.130864-1-adrian.hunter@intel.com>
 <20260129181841.130864-6-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260129181841.130864-6-adrian.hunter@intel.com>
X-ClientProxiedBy: SJ0PR05CA0124.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::9) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM9PR04MB8859:EE_
X-MS-Office365-Filtering-Correlation-Id: a98bbf36-3f68-46e9-e700-08de5f71080d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NkswUWdVdWpvays0N1Q2NXh0dmtYbnBQZFVlRlZCM0NsZDB5c2k3TytIVGZ1?=
 =?utf-8?B?ZWZLdENxallmQmRyMHI4MkluUFZZL3hVdFJveTFOUG94MWxpWjFhbHprQzll?=
 =?utf-8?B?SFFkaU1LZHFrTVF1Z2dFWjQxUFZEbmRaWGxTQzlGNzdGbjBJdGxkdjZzeHU2?=
 =?utf-8?B?UC9nRUZqOHFxcmtrU2dwc00rQlZQcGpRUWpxenIzT0hqeEMxUEExLzdrNGpB?=
 =?utf-8?B?aHpFaEdWOFpEZ3pCRE1VcnBKSGdkQjQxVjFxZ2FlamREcExqREJqanNTMjZl?=
 =?utf-8?B?UGs5Y0hFMU1Gdll1QXVkNnA0ZTY2V0FQQTVlSmhZS0RTN3RZRTdpS3pzUml6?=
 =?utf-8?B?RVFzOHpTbk1ua29sQ2JVSGdha2RIYXQ1cVNTbGRUZFZJdFc4VUVOazVlQ24w?=
 =?utf-8?B?Sno0RG8rZEpVVXZmU2JwSUtGbUYrNFBwdFpoWXNIb05aTG8raEFwcUNvdXBI?=
 =?utf-8?B?MzQ4d0xHZEFERVBINVZvcnVReFlhMng4Z2tXTXgzUEE0NlpJaVhtZnhRK2dj?=
 =?utf-8?B?cTRqU2N4YnhZcTV3eVhVMUFKT2dta2c3SkR2TDdleURpS2hhQ3lQUG9KUHBj?=
 =?utf-8?B?cXM3MkR0QWtnMjFiUGdkdmlzeHhkTDI2ak54NEJTdmtYbEJUREdWeEJDWUJr?=
 =?utf-8?B?QUFKQVZhQjZ2S2VkeEw4WlpFZDBZWGVha3ZpZzhTWXBJdkhzOTV1QVJzWWxh?=
 =?utf-8?B?dTN3cm8veHdGVEdSbmVxd1pSYm5yWHJVUjJFY1NaUDFWd1MyaEdCdGRCYndw?=
 =?utf-8?B?cHRjY25WY2dTS3B0VkpyTGwvd2V2aTRadVhZN3NxOGFjY2xDS0w5QnZheGxm?=
 =?utf-8?B?SHRkSFdvSHB0MVlqU0VqazhRWlczai9VbTJrdHpGMForZ2ZuY3lPWm1uTjBU?=
 =?utf-8?B?TnZDbXVjWHJIYUFOdlEwTlNKU3NacUtsMzVGcDFqdEpOMzVjTmppNU5NakNo?=
 =?utf-8?B?U0RDM2wzLzNDNndzYy9OZVc3VTNtTHdheVREc09LdG50LzV5N0k4ZFN3MHM5?=
 =?utf-8?B?c0ZnTzM5MHQ5TUU1a2UvSFJzMnJEeU9QMCtZb01wSnBEc21CTnczQVZTczRv?=
 =?utf-8?B?L1VSQUxPdlFBTkw3MURDSmI2Q1VPTVRTN0d5THd6cHNnZFNvUS9pbHFWd3M1?=
 =?utf-8?B?V3loUU9sdFRPc3c5R2JNTU5PK2lQWVV3ZGJTak1yL09BYTlyN3kvS2EyU1lX?=
 =?utf-8?B?ZndsN2xZRU4rcWtXcGpFRlF5YW9kWUFlM2JmbVRnc1hiY0xia3U4VnhMTmFn?=
 =?utf-8?B?eUxQRzQ2MVM5SEc1STJzSjZhMXJBdk4wZ2g4ekhRNnptNzFKMzcrUmZ5WUxp?=
 =?utf-8?B?NXVjWVFVekVHL0tQV2haenhHY29Bd1RoWWNYTzFTbmpmTlRCZjdCMURsa29j?=
 =?utf-8?B?eUdJOEJPM05HaTdRRU5YckpDdzB2YllVQStyandWRnZVUG44ZlFVOVFWcHEx?=
 =?utf-8?B?VkJiMUR0bHJKRkQ0dW8wbGZaZ0g1clFnNzNYc29uRElCRjRTS0NPcTFReDdO?=
 =?utf-8?B?aXlpZjgwWFBxUnozcnRscWNRUjBkN0ZFeHMvKy9kZEx0MytlTzBGNzVpR2ly?=
 =?utf-8?B?MWdTM0tqV0VuWmRmbU03Q0NmeHZRdDNwNVlxZms3TE9MRnhUZ3V3c2x6ZFN2?=
 =?utf-8?B?Tzg5VGFOMGhqb0NlYjJkNjMwKzNZby83Wm9nanh5R2NXNjZmRytXTFltVzVp?=
 =?utf-8?B?STZCM0wvKzN5TzhBTkRnSTNpbDFuOW8wZ0NqcStsdGdoVmtjQ2ZnQmNtbWNR?=
 =?utf-8?B?KzdtelVCSFpxSFNHVm1uRUpqdjBod212MGZCRFdac3dGL0lFMWpjY2s0ZmlQ?=
 =?utf-8?B?K1IzcHgyOTlVc1VuTmVpbGJzNUUzakpteDlSTkdDUEpMblkwQXdxdFNPTnZi?=
 =?utf-8?B?UDVtbDBNZ2hTWW1oOTQ3SWRvdlg3LzlGYVJxNWtDcmpoZHhRR1laSEJ6Y1BF?=
 =?utf-8?B?NllOVGczaGVlYkJidkxMalRmdDJSVmRUZkt6bVJablNCQW42U3haY3l0S0Yv?=
 =?utf-8?B?VGhLWG9kYjg2eHl3Q2o5akZXWXg0Tm8yQVpHMTFqNVBxaWdVc1k0Wi9VazJv?=
 =?utf-8?B?N2d0UmRJSU90aVovaW9jZkRsZEFnVmJvQWhkQVVUNjc1ZmJpaEwwUGROR0o0?=
 =?utf-8?B?dXZ4Q3BOcy9PNTNwdUNrRE9QdGhsaTd5Y2RxVmhjVVpuQ0s5MHpXaldXbjRT?=
 =?utf-8?Q?G2G9xKDpsFS/HGLopGwo194=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVVQZ2ZBaGZFM3J4UGJXTWVKSGMyaHpXRVgvdVBBMlloRHZvYVJxVVh0YzZh?=
 =?utf-8?B?VVNGMTl5RmxmY21MYnFocjRzWDd1VXF3L0RzTTB3VGY4eWVyRmRnNDUwdmpu?=
 =?utf-8?B?bWJlYWV5ZEM3Vkc3MUxhMmtVaTV0RzBLSmoramcxaVgwVzZSczBOLzh5b1hX?=
 =?utf-8?B?VW03S3ZLdnJuZ0lnUll5SmJXWmE2d1Noak42VS9yT0ovOUNZeDR2M29WMFVs?=
 =?utf-8?B?WER2NnlJcWZsUldjSTdRSGhGVGdPL2xGUVE0bnZ3YlpNZnBvWTF6N3JaelRM?=
 =?utf-8?B?ZjhqU01JMTJJamwvVWZVaE9wSUw2bGxxSk80MlA2V0VxWlROZmY3d0ZNS1hP?=
 =?utf-8?B?ODFCbWNxWkFtcW1BZ2gxcndPeGxPR0czbnVmRHRla01RMEl3VDFJUHdoR2Rw?=
 =?utf-8?B?VE04elJ2bDFrdkZrbStwVUoraUQ3WlFwWEx4QkJwVmdzTkZJOUdlTnlKeUp6?=
 =?utf-8?B?dnpJNkRDenZEbnB1L0V4bHJQUlUvckI4WW5FcjdMcGtDNDhSb21Ib1FucUtI?=
 =?utf-8?B?TUFoT1c5Z1ZYV01SbnEwQUgrVHV5SnFuSzF6TWExRFV2NjJJQUswUVBUQ3BH?=
 =?utf-8?B?ZjJqc2ZqZVRJSTJncWVlT3NzOTQ0dDd0ekNGZndSWTVKZ0dIbi9MVVI5WUVM?=
 =?utf-8?B?NDNhR0poOGpkUVFCQ0N5R3V5NWdHVnozcW5Wcm9qczhzRTJSK2Y2ZXBycjJP?=
 =?utf-8?B?bEJ4ejJRQklBUEhQaTM2OTNwSU81RjBnS25qZnVmUVVWT1BzNkRVWmdQUHFu?=
 =?utf-8?B?MmZmWWpCSnJXKzVxOWZuaHpuV3pFTENDenBvekRkR0huT1VUSHhlTk5DazUv?=
 =?utf-8?B?dEM1SUVXb2U4Z1VvRXZPYy9pWEFtcmdsQUdtb2FobGhZNm1zWkdSTXJEWU8w?=
 =?utf-8?B?dk4wNC9SOUE3UllFdlV6VzlTUG5SQ2pUOFRYRlVldFdxTUtqcExiVit0SGhD?=
 =?utf-8?B?OXhselB0L1MrbTJUSDBYek5DZjJUWTQzQXVPbExScXE0RDhLWDF5Nm5yMnBj?=
 =?utf-8?B?aVlZckFvRzNpcEw4S2RlZ2hxdGhMM3cyOGpSYlZxMVlkZ3hkU0czdmxBMEFt?=
 =?utf-8?B?amFNdm1LdGVVeEJGR3EyT3M1RHFUMVMwQU5YSnpPZ0kxMm5DWllpK2hvR0dU?=
 =?utf-8?B?NjhEZ1lDQS9WVW5FSUg4WWJ1OGJTYno0aVlMYVpYNXhmbm5mOXJTbU1CRjQv?=
 =?utf-8?B?MlRjTzVFRUVKeThyNjJIV2R4NmZhVndReGtscW5jQUtaeWx3ZkFFWU0xRHE3?=
 =?utf-8?B?enVBd0NaVW1wTFk2Yzl0RjZ2VHl1L1E5RUplb0UwbTJIc3ZSak5xRGpVZ2Yr?=
 =?utf-8?B?L0xCVjVCUkNuZjgwVkdaZ25Fbm1ORWpjTDJyWGR5UDVtcVRRbE00SE1kbzVK?=
 =?utf-8?B?Wmo1OHhpcmxKZnN2dk1FakVCREdpeXV1MWFuaGE0WGxTM1kzTTV2Yld3ZDd6?=
 =?utf-8?B?dFRTdndiKzgzNHRXUGZ5ZDdkdzFubmhEZUxSMnp2N1pqSktjVCtqNEF0bXdn?=
 =?utf-8?B?WlhocTVwU1RObitEL2JNVVZaMHpnU3g0R1k0SmJ3RU9nOFZzK2hmQnljS21O?=
 =?utf-8?B?V2JtcWh0Rmt0VjE5TmtVR05nMzhkeEtkaE1xWmFodlFFZEhaRERnc0lJR3NN?=
 =?utf-8?B?VDdoZndmQ0F0ajhCOHBBeXpzZ3g2RHpqaENDT2sxMFZMTGVWVTNUelM5RVBj?=
 =?utf-8?B?d05QMThBbVZoOHlSYVZJQmlMckdldlJEeFBkRm5yZzlBa0lSRm56L252T0px?=
 =?utf-8?B?SzcxQVB4OC9jT2IrV0VWSkpnNWovT0NYN2w5WDN2THBCTDd0MW1LTFJhc3NM?=
 =?utf-8?B?RmV1cEw2RjJ2bitibWlUeDRnWlZSanZ6ang4NkluN3FNN0trWHMzNS9CYUZO?=
 =?utf-8?B?bi9CTGhYUHlCNlZBdzdHNHphZ3JDdERoZnNYeTkyaXRESmoyZkVMTlBOZEtk?=
 =?utf-8?B?WFByQkFyYytpcVNVRTlVY0FyTlEyS2JPc1VxK29PUUhXRVdGdWh0eUR3Znlx?=
 =?utf-8?B?Y1l2QlVWckJJa3BKRkV4Nk40elFFbUxTdHdOL1RFTFdwMFU0SmZrMnVXdzdx?=
 =?utf-8?B?WmZyQlpDbnp1MU04dFBZaXZPeUZ1blFzR0EwNHQzOW9SUktCc1RSSzM1cUlL?=
 =?utf-8?B?WVVNcVlkWU9GVmltVTU5bDVZRkhrM211OVBYTEVrZUNyS09LS3F6RTVyTVF3?=
 =?utf-8?B?WFdEdHR4c0d0bWtBdDFZUVRYUUpUSHgrczNjN1RNT1JDOXZXMm9OYzd6T214?=
 =?utf-8?B?OTlka2dVSkcxK0plUE5TNURjc3B5SWxPSmhKOFhTRGo0eVU3ZmNpVVVXRURT?=
 =?utf-8?Q?ORddk090d7sf8rpOs0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a98bbf36-3f68-46e9-e700-08de5f71080d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 20:00:20.6998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vOJHmuhUkj4l6aJ5ZM65T473fZHr1kSRRX1cLNKL3PxilwJwJu0CKswdaFYqUcAvJAsolPC4Vi58Fs95SP7afw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8859
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41723-lists,linux-pm=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3A0B9B41F4
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 08:18:39PM +0200, Adrian Hunter wrote:
> Some platforms implement the MIPI I3C HCI Multi-Bus Instance capability,
> where a single parent device hosts multiple I3C controller instances.  In
> such designs, the parent - not the individual child instances - may need to
> coordinate runtime PM so that all controllers enter low-power states
> together, and all runtime suspend callbacks are invoked in a controlled
> and synchronized manner.
>
> For example, if the parent enables IBI-wakeup when transitioning into a
> low-power state,

Does your hardware support recieve IBI when runtime suspend?

Frank

> every bus instance must remain able to receive IBIs up
> until that point.  This requires deferring the individual controllers’
> runtime suspend callbacks (which disable bus activity) until the parent
> decides it is safe for all instances to suspend together.
>
> To support this usage model:
>
>   * Export the controller's runtime PM suspend/resume callbacks so that
>     the parent can invoke them directly.
>
>   * Add a new quirk, HCI_QUIRK_RPM_PARENT_MANAGED, which designates the
>     parent device as the controller’s runtime PM device (rpm_dev).  When
>     used without HCI_QUIRK_RPM_ALLOWED, this also prevents the child
>     instance’s system-suspend callbacks from using
>     pm_runtime_force_suspend()/pm_runtime_force_resume(), since runtime
>     PM is managed entirely by the parent.
>
>   * Move DEFAULT_AUTOSUSPEND_DELAY_MS into the header so it can be shared
>     by parent-managed PM implementations.
>
> The new quirk allows platforms with multi-bus parent-managed PM
> infrastructure to correctly coordinate runtime PM across all I3C HCI
> instances.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/i3c/master/mipi-i3c-hci/core.c | 25 ++++++++++++++++---------
>  drivers/i3c/master/mipi-i3c-hci/hci.h  |  6 ++++++
>  2 files changed, 22 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
> index ec4dbe64c35e..cb974b0f9e17 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/core.c
> +++ b/drivers/i3c/master/mipi-i3c-hci/core.c
> @@ -733,7 +733,7 @@ static int i3c_hci_reset_and_init(struct i3c_hci *hci)
>  	return 0;
>  }
>
> -static int i3c_hci_runtime_suspend(struct device *dev)
> +int i3c_hci_runtime_suspend(struct device *dev)
>  {
>  	struct i3c_hci *hci = dev_get_drvdata(dev);
>  	int ret;
> @@ -746,8 +746,9 @@ static int i3c_hci_runtime_suspend(struct device *dev)
>
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(i3c_hci_runtime_suspend);
>
> -static int i3c_hci_runtime_resume(struct device *dev)
> +int i3c_hci_runtime_resume(struct device *dev)
>  {
>  	struct i3c_hci *hci = dev_get_drvdata(dev);
>  	int ret;
> @@ -768,6 +769,7 @@ static int i3c_hci_runtime_resume(struct device *dev)
>
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(i3c_hci_runtime_resume);
>
>  static int i3c_hci_suspend(struct device *dev)
>  {
> @@ -784,12 +786,14 @@ static int i3c_hci_resume_common(struct device *dev, bool rstdaa)
>  	struct i3c_hci *hci = dev_get_drvdata(dev);
>  	int ret;
>
> -	if (!(hci->quirks & HCI_QUIRK_RPM_ALLOWED))
> -		return 0;
> +	if (!(hci->quirks & HCI_QUIRK_RPM_PARENT_MANAGED)) {
> +		if (!(hci->quirks & HCI_QUIRK_RPM_ALLOWED))
> +			return 0;
>
> -	ret = pm_runtime_force_resume(dev);
> -	if (ret)
> -		return ret;
> +		ret = pm_runtime_force_resume(dev);
> +		if (ret)
> +			return ret;
> +	}
>
>  	ret = i3c_master_do_daa_ext(&hci->master, rstdaa);
>  	if (ret)
> @@ -812,8 +816,6 @@ static int i3c_hci_restore(struct device *dev)
>  	return i3c_hci_resume_common(dev, true);
>  }
>
> -#define DEFAULT_AUTOSUSPEND_DELAY_MS 1000
> -
>  static void i3c_hci_rpm_enable(struct device *dev)
>  {
>  	struct i3c_hci *hci = dev_get_drvdata(dev);
> @@ -962,6 +964,11 @@ static int i3c_hci_probe(struct platform_device *pdev)
>  	if (hci->quirks & HCI_QUIRK_RPM_IBI_ALLOWED)
>  		hci->master.rpm_ibi_allowed = true;
>
> +	if (hci->quirks & HCI_QUIRK_RPM_PARENT_MANAGED) {
> +		hci->master.rpm_dev = pdev->dev.parent;
> +		hci->master.rpm_allowed = true;
> +	}
> +
>  	return i3c_master_register(&hci->master, &pdev->dev, &i3c_hci_ops, false);
>  }
>
> diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mipi-i3c-hci/hci.h
> index 819328a85b84..d0e7ad58ac15 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/hci.h
> +++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
> @@ -147,6 +147,7 @@ struct i3c_hci_dev_data {
>  #define HCI_QUIRK_RESP_BUF_THLD		BIT(4)  /* Set resp buf thld to 0 for AMD platforms */
>  #define HCI_QUIRK_RPM_ALLOWED		BIT(5)  /* Runtime PM allowed */
>  #define HCI_QUIRK_RPM_IBI_ALLOWED	BIT(6)  /* IBI and Hot-Join allowed while runtime suspended */
> +#define HCI_QUIRK_RPM_PARENT_MANAGED	BIT(7)  /* Runtime PM managed by parent device */
>
>  /* global functions */
>  void mipi_i3c_hci_resume(struct i3c_hci *hci);
> @@ -156,4 +157,9 @@ void amd_set_od_pp_timing(struct i3c_hci *hci);
>  void amd_set_resp_buf_thld(struct i3c_hci *hci);
>  void i3c_hci_sync_irq_inactive(struct i3c_hci *hci);
>
> +#define DEFAULT_AUTOSUSPEND_DELAY_MS 1000
> +
> +int i3c_hci_runtime_suspend(struct device *dev);
> +int i3c_hci_runtime_resume(struct device *dev);
> +
>  #endif
> --
> 2.51.0
>

