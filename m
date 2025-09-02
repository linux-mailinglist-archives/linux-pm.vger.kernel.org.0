Return-Path: <linux-pm+bounces-33595-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46867B3F2B4
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 05:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD2EE7A129A
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 03:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0372DECA5;
	Tue,  2 Sep 2025 03:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="niVGK4+5"
X-Original-To: linux-pm@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013008.outbound.protection.outlook.com [40.107.159.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230B51F428C;
	Tue,  2 Sep 2025 03:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756784005; cv=fail; b=qneOVGBYaZXPPHavDR6ByCgkdhLl+DNSGnd1YwOa1Gc2cSbgssfXZ+9kZIGzejRfnvo4/B4uoOv7CO7/JS0hJUtRs/uAeHI1RNs4slrMcncDnlpnUmsd1MEHopMmQdhI//ys6BFd7KTf0hnARer+GodmkBBLorDEbjvdVo0n+Vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756784005; c=relaxed/simple;
	bh=torLNiIvuR2CI+3fr9gulff30bMAE4PIXnOYnPbqFNE=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=m+7CdrAxDEk3OZ4mcNLUYJRorXsaxud4OTl674YEdJCdS9sM9gNaKYBxia08TVYs6ol7coocMN7jWvvjWxDqKtzrJzRRFxWV/LCBVLJeS39rVUsxWFBwMdITLXk6xVGetS6JUd0gRpq8OlDOZJCxKUo7THgZ5U8mocORk77IzlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=niVGK4+5; arc=fail smtp.client-ip=40.107.159.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p7uV6R2p1VkggkXhPOYtJpvk6B0iswlGaDVTerQZkUO/xPQ0hCYFU30HIioQH0ZriO9GLFsBtSjC0VwbghIoFpgVOKXz6ifLH1USJR9eQJy/Ex41Xku57FGFDnwHkKfmE0SKruxutCEEXX0kPV9ixSNFa++bKC6qp7GUrgA2ZtjI4EqP6hlhfr9nUiG7t2XQ2X5pwD1YcXKrRmtH1ECuZ+T5c9/Bf9bEJMEkB8yr/1IKUCa2JSn9ZdOQog7Xxy4AxUVfP/5CPb5fQAbTls0D4WTTkvxFnYMnbQ0byecB8/16QQJolhcKknWGx5kk66J2c/UwXEMFveoEasFpjiyoZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T85Y7LjCrhqFTN1RtR7Y4CbpDfcjl+zQA3uHxgA+0P4=;
 b=gEQPdgn5pDiPp4HhEHg5+xyfZ8TIdtdtTh7Ob7Uzh1h+7m+vQ+3ettGEufGnznQzSH4X8nniVIF2n8MJz6np4JZupc68AntooJMg2GHHAOD6huKR7n2P8q2P8XRib3lkoAZ+AVrwAJyfJAa0R/jj5iBBQRX5X1ceq7DWfGYf8g5vS9TSWKYQPpkmWzAcTFNNQqWJMueJ7q+AgrEueAuKv9E6sYo+XGKUmJM8JX6z+OWxSO0aN3SO6tzkLdDZRUnAXHK9GNy5+Dezyiu16p8VgZVWsktBLeirKI9XYN5Geo0PN9wOBeIJIqFI+q+M8aJUo272B+HAif84B5VRak2gLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T85Y7LjCrhqFTN1RtR7Y4CbpDfcjl+zQA3uHxgA+0P4=;
 b=niVGK4+5P25/fmDTHZ9bLtSLU1gaETHIEUIwV36CcrR/4yl2KCaWOFAWSeYTDRSxxgK+7LkcdtQ7kR4njPZeCJW6OB3ZLazVStfHuTvt8ICuL1El/73nVQqTviRi5ZROkvt2VxI8J5AlOGUO9MM0vZOPfX0DXJkmaVMJPi9jMZcFSZPMIDiz9nYF3PamG4ipxDyYXvMuCyDEs/Y6A9s/bsF6x86eWJTw/g/IICMjN2UOuf1yXDesQ8rLjHu0rxKd4c4+Tke3F8eP5iTtc1XNQe+eAX56jGKbvPgon4J6SU/VgdJ9Ko9qAkpKrlW4ibuU/OLi3hYRdOlqXOTiq+0KBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS1PR04MB9583.eurprd04.prod.outlook.com (2603:10a6:20b:472::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 03:33:19 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.015; Tue, 2 Sep 2025
 03:33:18 +0000
From: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v3 0/4] pmdomain: core: Introduce
 device_set/get_out_band_wakeup and use it in usb
Date: Tue, 02 Sep 2025 11:32:59 +0800
Message-Id: <20250902-pm-v3-0-ffadbb454cdc@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGtltmgC/yWMQQ7CIBBFr9LMWgwOGIor72G6qDjYWRQaMKSm4
 e7Sunw//70NMiWmDLdug0SFM8fQQJ06cNMY3iT41RhQ4lUatGKZBWrlvZHWkNbQjksiz+sReQy
 NJ86fmL5Hs+C+/vVeXna9oJDCGtf7J45aKXcP63J2cYah1voDr/EyJ5IAAAA=
X-Change-ID: 20250729-pm-243ff7097e44
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Peter Chen <peter.chen@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, Xu Yang <xu.yang_2@nxp.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, imx@lists.linux.dev, arm-scmi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756783991; l=2011;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=torLNiIvuR2CI+3fr9gulff30bMAE4PIXnOYnPbqFNE=;
 b=7KmbWdUhKDER8a13lv8lvzFdJZLwPqTk04GzWi9BvRc11PGWZH63kn2ClrJqjdx9N5bQJVg6D
 AdkLEsiKTzVB3JXrEz05FTabDJr0PnD509uTDiVSyF2a8v/hvgum+GX
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS1PR04MB9583:EE_
X-MS-Office365-Filtering-Correlation-Id: 88db0c2f-4808-46bc-1219-08dde9d1758d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|366016|376014|19092799006|1800799024|13003099007|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjJwT0dNYmxSVTZNK2JGNEFlRHAzblRDOG1kOVNEaEwrUTc5ckROZFRHdHE5?=
 =?utf-8?B?UGZPbmFHZjdCOFBVQTBScWhyNW9DUk9EQWw5aU01NlBTRVpZeC96TjVTdFNi?=
 =?utf-8?B?VDhBc2FtN043WUZEY21VS25KQ2taL0YyY3dIZU1Hd00xc1JTSXdkQ1c0K05v?=
 =?utf-8?B?OThXU1pEdHBnKzBadGI2dnVycjA0ekFocm41SVdPN2ZieUpjamIxa1A3eXJL?=
 =?utf-8?B?aXVJekJYbVhNTnBkRzRWZFVKSGM0cnQxSFlNVzlVbWNTOGI5eDR5czlsbzhC?=
 =?utf-8?B?Z0VUYVE1T2tYbzIyalJEVm9mVlJaSXd5VFNITnBIQ2t3S2NqejlkQksyUmp5?=
 =?utf-8?B?dXA3Ykg0dVB6MjhDQVhxaXI0T2FHVGNxcEFTcVoyUGhzaXJ1MUoxSFpEQ1FI?=
 =?utf-8?B?K0dQMzI0N0tSaU56bklvM29TeHlLeUdKaVR5TUZ1Vm50SFNSWW15Sno0cUtX?=
 =?utf-8?B?Ym4xcnNiZTM3eDU4aGtQVUliVlJXNW1YWUhEQi9HYzVGaTZpblFiRkUvNEtT?=
 =?utf-8?B?U2htUWV1cDhmQVRRbE16YVpVUlVhMDBiN3dheVEvV0NTSGdwZnRvTHhYS1hB?=
 =?utf-8?B?N1A4SUY4M1ZUSitSUzZjd2lvcExSQ1A4dFJSYjVPTnU4czRET1E1c0JqTy9a?=
 =?utf-8?B?WGx6cW5jRDUvaUF2eUJiN0h2NWJLM1BkTGxsTDNRNkc3Unh2NE1GcDhzTHp2?=
 =?utf-8?B?dHR0L2VPYTgvMEZVVk9UemptZE5uNUhBMCtGano0Q0cxK092MUozZkZiODZL?=
 =?utf-8?B?Z05jeExrZVRaVi8vRzhpSER0U081bTdPRDI0MHlZcjBXaXBUSFlwYTF1VjMr?=
 =?utf-8?B?RFdiOThCK2hyRVNaVDJTSVdrcUpPSmtHSE90SlcxeGt2VkNRdTZVMTVoQ2c4?=
 =?utf-8?B?YWFYeDdwdVZaSFBkTUJyVUVKTU5mL3JCbmR6aHlVMUpiY1E5VnpoRVpiaEds?=
 =?utf-8?B?SDVDK29pNU5zTm01dW14WG0zaElqNHloMmNwU1JpMjhQRzRsK0FTSEtaY1RC?=
 =?utf-8?B?cGFlcSt2MHJNMmZxOXg0S0hLbGEzeWhrcUJpUUNTd0FpSkwwRUtSSkU4anNU?=
 =?utf-8?B?YTM1VHp1ajBsQzlZUnVucEJlMGJoVUJ4NFo4MzBwRk9wOWpEWmtYT0pieEFl?=
 =?utf-8?B?a2swbEt3bnNTY1dybUU2WExrQzg0ZUxZNU8zTEhGVWhPdURmT3hWcStHTC9B?=
 =?utf-8?B?bzNBQS80YW0vRXh6d1hnUld5ZjRVY0Vid21YQzRxVVMyRE1JWlF5NlJOdkFM?=
 =?utf-8?B?cnk5WUhQWllaNkM2Uk9TRHVZbnZ5WkFacW92UFhXM2dEYUpCZC9mU3A3K3BZ?=
 =?utf-8?B?dkg2aVJybkdCczhxTjlkam9nK0lsVG9ZaU1wU2VBUktKekNEZmkzeVBJSm1n?=
 =?utf-8?B?VHJPSjRIYVBEZlA1WnFkaUxRdDAvUzQ5OVhNMjBWSis4MiswRkdzK0pMNTBx?=
 =?utf-8?B?QXFvYlo1cXUzK0JsMFA4cG5zVTZrNFhTRzc4aUtqeHNqUUc0eEtnVUdFTzRh?=
 =?utf-8?B?RCtUck82elJmK251ZlNtYmVMZG54SHVIdU1Ua1pZcVRrOWJJcTE5WG1TRSt6?=
 =?utf-8?B?U0dNK0Y3YTI2QmdOTFFmbFlyS3JqanB2OEMveGw1NEVOSis0cDhPVXRGZjRw?=
 =?utf-8?B?Y1JPUmdjRnpqYllUT1FLUzg5K2pQVHpKdnVjRlo4UVk5MWhPU2FlbGU5L01h?=
 =?utf-8?B?YUEzZFhHSTBvYTNsS1lZMVVuYVJtYXJiZTVtaERhQkVLOGhPR0wwSE10VkNv?=
 =?utf-8?B?bE9pVWZnelp4Y1lKbld0UG9sOWFDa1pNS0FZM3g3eWl1RmFQUzRJTkVvWGxB?=
 =?utf-8?B?aUgrYWIwbDNSNHExd09uaVZ2Tk5ZeTNBdmZyVnNiMS9UTTZocDY4T2t6QmF1?=
 =?utf-8?B?MGc0QlJtdTEyNHFxMVdnYkhIbzZsYmV0TzU3MVdvSTU1OG5ZUUhMRFd6Nng1?=
 =?utf-8?B?L3RsWjJUdjBrSWNJRWxJL1pHU01xd214UFZtN2g5TlhKZy80VFZXc2dPaVlG?=
 =?utf-8?B?RWI4SmpEc0trRnFRanFYNjlhZ05zb2k0MmJqTHhLTmU4V0djdWlyUExNcjZX?=
 =?utf-8?Q?7685xE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(366016)(376014)(19092799006)(1800799024)(13003099007)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sktva0FHdEZ6UEFTcXhtUDF5Rkd4MFV4Q2hLbGhlRjhDVXkvaFpVSSs1U0M1?=
 =?utf-8?B?Nk9LSHpkQnNVV2FOVEdCZXNnS2o1YWlBKzJQK1hWMk5rLzlyR1NFK084bDUv?=
 =?utf-8?B?V1dldTlNZkprRUt0U3NwZ3pGU3M3QVRKSTlveUZzTmlsZmZwdThaS0ZreVM0?=
 =?utf-8?B?a2FsZGhDSngzYTBseGlGTUc4S1NjT0sxM2x6KzRBR1RGNVJOOFdTM0p4R3hP?=
 =?utf-8?B?b3NzWUlPd253RVhDa0lQbzlsYzQ4N0VTSXlzSmlXSUtSSGM1QnQycHFQell6?=
 =?utf-8?B?bFFJN0FuOVI1dG82aUNSVDVtSGp1eUhKN2FGVzBWTE1IMlQ4bno2VnhtZnNQ?=
 =?utf-8?B?aDdSbU00RnpPNWVsbzNzdFVJbEhGbUVEaVI0dzRhNDhPZmloa1NjdWVBVytP?=
 =?utf-8?B?SFFKSW80b1BBREVTRk1BMG92a2I3K1VFeVhJOG1CSmRzTWJUcFNyWHY0WWxI?=
 =?utf-8?B?MGlMc1MvYlRsR0U1MFVUYS9ra1A4U010clJPM1k0ZkthdGtzdTRoMkxXUkxZ?=
 =?utf-8?B?M0x4VXpsemtsV2lyUENJQXgxUWVjallOYmJBSWVTS1ZZUWJWY0k2L05jNFRS?=
 =?utf-8?B?VVJMZDNRNDI4ejdsU3M4Z1FKNTh6V1hJcnB4RG5WejYrYktGd0xaaWJlVGNQ?=
 =?utf-8?B?cmRsZ1FndldxNnZEZEkwb01MOXNoSmlBbXdyUVFoZzh2bmdlallsQUlKSFox?=
 =?utf-8?B?WjhycUZQaXdDcEV6VDdQRVFsMWthRldySVU2amxIZkxoL3h2MXNsT2ZFUk16?=
 =?utf-8?B?WmNBS1E5TlFxbVUxa1VFTlRFQ09DNXNXT3ZpdldNaDFLTnZ2UmdHejVFMzRT?=
 =?utf-8?B?OGw1SHFibDRZRCtkaksyWG9ZdW5CMDgyTDFOdGx1aUVXc2lKWU9iWFk3clNV?=
 =?utf-8?B?S0pOOXdrOThhcHc5ZDFwZ3UzcEwwenRYWkZDUE5zWHZmRmttN3IzMlNVMUlE?=
 =?utf-8?B?Sjlkc2dRUWhpZzROK3MxT254UFl5dGtPNEU3eExwM2VjaFF5akxickZLR0hJ?=
 =?utf-8?B?TFg1YUp1NUROR0RKalM1VjVGYllnRVNSWE1tbk1MeUpQd2lNejVuR2duRlhv?=
 =?utf-8?B?eUZISGVIVlJLQlI1cStobG82MnJmcmhRRHZkUkJWZytvNnJxMStXaWlaUmsv?=
 =?utf-8?B?ZXFiWEJwMXJlK3dCaEJhbjJIVUVpNzE0MW5rU0hwU2ZsUlBMTTM3Y2xlcnRi?=
 =?utf-8?B?UjMveWNYUlFiS1ptbFpjK0RzUmcrcGdrUDNPYlczU29HdkFhUE9mUmtJSFo4?=
 =?utf-8?B?WC8wb2RKdGtLdnRLMDhKRldhRDhjaHVtWHE3cDVaaW1EQ3VRVUZhVEJaaUYx?=
 =?utf-8?B?cDZmaVJXSllFWUlTZ2haSWE3M2d3TzduSmtwTThkR1I1QVB5UEhNaTFjUVls?=
 =?utf-8?B?ZWQxZC95cnhHRGR3RVdCSVdJcHVUWFlhbTFKUHJ3WkRvd2J3RDRjeTZ3SVcx?=
 =?utf-8?B?YTVxTUZNL1BHODNMYlB3WDhpV0ppWDJDTjNsUzZPYUg2eGlMRUNOdm1lOFB0?=
 =?utf-8?B?NDdHT3dVVEQrTllyNGVxU1JlMTkrdmhYcjNiT1dSMzA0NGpUMjArcDk3VjZS?=
 =?utf-8?B?bEJPSmNjTHBQd2FyZTNQQ0NMVStPK2gzdDNRNVd3UXY4WmZvTFRLd2RoY29Q?=
 =?utf-8?B?WUlLYUl0N0x0azJMQlRLdEw5ekVQSVFrRUNzTXF5SncwVHJ6aFhac1Q1bHhT?=
 =?utf-8?B?K2psMi9JQWZ0VFlLL1RuaVFMRHRmVGpiQXdpRWwvS1RyREJNUng1Q1RUNVFE?=
 =?utf-8?B?SkZRSW02ZjBwVlJVRGQ1YWRYT1FPanUwOTFIbW5paXZjVDZEb1JSMEY0QStD?=
 =?utf-8?B?elpwU1RmNnpaREc2RjFHazMzL2pOemRvam1RVDFyUUJXNk5xYmxNQ2V1Vzkz?=
 =?utf-8?B?aVJGVnRISFpYekNaMFNFMVZXRVRnb0JFZkVibmd0SUxQUFRRanNVcFpvelo1?=
 =?utf-8?B?NS9SZ2lmUk5ZL0JVdTl0YUkvK0ZJNjJsNHZuY3RHMHEwMXhLOThBRExYNjZT?=
 =?utf-8?B?eWlzenh6RXJHQUw5NmFoUnh3dGhqTkJvU0NpWWF1eWZaQXJwNXFnV1p6SjJt?=
 =?utf-8?B?Q1pJTlVDQW8vYzhhVlVkOXRmaDJpVkdOdUxjK3FPY0VLY2psM0RDRGdudGhL?=
 =?utf-8?Q?ciFLptnyCdEWRKupAs0bznM1F?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88db0c2f-4808-46bc-1219-08dde9d1758d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 03:33:18.8952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PauFQUCRuDXmAMMqW0DDJPOEc/Cl0Xgvw1Puhd8NC3+wPGMoiyECsFBn8C85a2Pd03UGJKJkwPpuKUtcYsJ8uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9583

This is pick up of [1] which does not have response in about 5 months.
This V2 patchset
- includes usb driver changes(patch 2,3) to give people a full picture on how it is used.
- Rebased next-20250729 to resolve conflicts

To i.MX95, USB2 and USB3 are in HSIOMIX, but there is always on logic
to make USB2 and USB3 has wakeup capability when HSIOMIX power domain
is in off state. Otherwise the HSIOMIX will be kept on when
USB2 and USB3 are configured to be wakeup source and Linux suspended.
With this patchset, HSIOMIX could be powered off and Linux could still
be woke up by USB hotplug event.

Patch 1 introduces device_set/get_out_band_wakeup
Patch 2 and 3 are drivers changes to use device_set_out_band_wakeup

[1]https://lore.kernel.org/linux-pm/20250311083239.3336439-1-peng.fan@oss.nxp.com/

More old discussions:
https://lore.kernel.org/linux-pm/20250311083239.3336439-1-peng.fan@oss.nxp.com/

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v3:
- Add a new patch from Xu Yang to detach power domain for ci hdrc
- Add A-b for patch 4
- Link to v2: https://lore.kernel.org/r/20250801-pm-v2-0-97c8fb2a433c@nxp.com

---
Peng Fan (3):
      pmdomain: core: Introduce device_set/get_out_band_wakeup()
      usb: chipidea: ci_hdrc_imx: Set out of band wakeup for i.MX95
      usb: dwc3: imx8mp: Set out of band wakeup for i.MX95

Xu Yang (1):
      usb: chipidea: core: detach power domain for ci_hdrc platform device

 drivers/pmdomain/core.c            |  6 ++++--
 drivers/usb/chipidea/ci_hdrc_imx.c |  8 ++++++++
 drivers/usb/chipidea/core.c        |  3 +++
 drivers/usb/dwc3/dwc3-imx8mp.c     |  4 ++++
 include/linux/pm.h                 |  1 +
 include/linux/pm_wakeup.h          | 17 +++++++++++++++++
 include/linux/usb/chipidea.h       |  1 +
 7 files changed, 38 insertions(+), 2 deletions(-)
---
base-commit: 1b09efec32046a9c78cfecc46a26b1b139a3e8a8
change-id: 20250729-pm-243ff7097e44

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


