Return-Path: <linux-pm+bounces-36171-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FB0BDD89B
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 10:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2FC419C2A48
	for <lists+linux-pm@lfdr.de>; Wed, 15 Oct 2025 08:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801C331AF16;
	Wed, 15 Oct 2025 08:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="keslNJ2u"
X-Original-To: linux-pm@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010022.outbound.protection.outlook.com [52.101.85.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75F431A55E;
	Wed, 15 Oct 2025 08:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760518315; cv=fail; b=dfCkaNkXL2JnMNMzajYGTLhqMQqVlYQraw3ELUUOvoPbh1CCHWIFyYtkoTw6xdfDR32ZLLbGdZ7frWAF6MWhL43RA00Ri/SJNSCL3/YHb/bjZg6IIe6lS9SBF2tMQTyB/UupZuHTo7nUywpqkzf/QaR8y1QlXh4oMpB57Jxc/+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760518315; c=relaxed/simple;
	bh=JzC8ATZmp/nLIlbZmbQzVaE6/cU6Za8N9cdA04TpeL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EIAj6fe36l/iqd9xKF6IJmYtEs/zbGCp4xu6lQUl9AmVwsWbAfgOzHAMRpYx9RSviTb5V3cWqoi2AxRFSOg7OGjBxXosT/Ig3VzE6Dz8rSvZqG/U00JQcb309dEjEzwV3ydzOl1ZHJl3/whE3r3+PsYZBRlmmUpPoL34J8MmIA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=keslNJ2u; arc=fail smtp.client-ip=52.101.85.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=njyUuztM5FznQyqf44fVotWDwD88F5s5D9cNBYa3PVpYioSeGa5aJR2WmuhF2pnTmV7AFD9lJq/wHn0+pY6Vyw34E0gPXZkimkeNyk/TkWZV7l6qEp5fkeOgTiIqKukg3atqcumpFrZWF3DJcRKjXDCSS0GhEOkCbx8KdHQol7Mc7fbUIANWobrNLtulM/rUoS2lVi/hHLH3yXVnXo/0gCyf9wA43HbFdkUCUzpeIfheCEBkV+cnh5rJcwB6zTTT0FskmiFuEKjxRQeJDkv4d/+7hlUpySR/pF+wDwwtZC/BHpIsMij3LkZL08vd5irPh+MqO8uIh7CDWLebcIE37A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=beOTy0PKpyZdhtiZf2HTCD4a+BYAjyiViYUH3CQwZmY=;
 b=A0gMGikmxW2g2ZssCngOZinGh/eSoOIZusqbG+EuY12fA/Tvsb1D25Cqcx30g1IAvHZ4/E+hwHi/9n/nmTgjBxwAi3sEoBt+KVYIORnqmnG3zkIOYXP82ryim9KACF7L0OHOZKjj2R1tX0hnJ7rurMIh/wZXf+G/fuGGHU5ePfd9oFVnryX8ghg+A1BcuL+TgJAfzE89CkHIMke/DQ2uFLJgDSdykTnv/KY8vkFdGn56yKvWj7BeNQCu5fVj5N42iiV1s4bnGoAq4QULZt/0FiYw7+YCqH3/cmB0GfC4Atp6mCtAujOKarO8sgqkE+EO3NOPn8uPHAOdpB8kQEo6Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beOTy0PKpyZdhtiZf2HTCD4a+BYAjyiViYUH3CQwZmY=;
 b=keslNJ2u3cQ4xMeGes+tBSKQRjhEuHD6+RvVZLLjYTcNj4kA3L3oLbKuVxqNdV6iJiK5SAkDP4ddJYIA05LnWrlCRV2U6DCcZU1LhgNVFvjc5vrD3B8AvQ5iRSWbR0dkMWPRFl0Hmgl17oCBMlhwu+He65iXWQhZzBDPDJBOV8w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 PH7PR12MB7114.namprd12.prod.outlook.com (2603:10b6:510:1ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 08:51:44 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 08:51:44 +0000
Date: Wed, 15 Oct 2025 14:21:36 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: Perry Yuan <perry.yuan@amd.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 3/6] cpufreq/amd-pstate: Make
 amd_pstate_get_mode_string() never return NULL
Message-ID: <aO9gmGMCMncoxCKr@BLRRASHENOY1.amd.com>
References: <20251009161756.2728199-1-superm1@kernel.org>
 <20251009161756.2728199-4-superm1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009161756.2728199-4-superm1@kernel.org>
X-ClientProxiedBy: PN4PR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2af::10) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|PH7PR12MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: d0a58706-360c-44d9-d28a-08de0bc810f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jSbe3NC06KCb3EF66mseFxuFpJ6xCOYhwEbNiYVq2Klu0aUdl5T8Rvw/oWdB?=
 =?us-ascii?Q?kSzWgQ1ChFwgkxSjsQTeX9wAx78Ct2FsuN10tUSfizvnqMUUnHpeMCjWNh97?=
 =?us-ascii?Q?/5ujzsLRnTxnMbDTIkhS2PQBBhtnkO92wK3X/lPDRZcksUtwaQQOQcu9H8l9?=
 =?us-ascii?Q?44Sj8VGXlUXH8tlmFBk1uLTBUq9r9Tr4Wbj8h3qoLQfjL12qhZQgs+samokE?=
 =?us-ascii?Q?C6rB3qaOM+xPQKIrwe7xuq2+pCF/gQsslcGC3882LRRxqHHIj3Ec0TlhZn20?=
 =?us-ascii?Q?vJ7FHbipGZq2p02o0kQxlytKCaSPiaNSTg2ksmtd25sO+dp8wvkhinYz/64d?=
 =?us-ascii?Q?VKfgdcSGLleO+qEvNCQOS3Bz/EN1+CX+k2vDuKltBaZ/0No6d1EYCPJ2TD2L?=
 =?us-ascii?Q?6n+QH1WAanaZ+AfMGdaQN/D2rOgy8c79jDWRWpLRCDLQkUlHkmxoHwealmXh?=
 =?us-ascii?Q?lFVYROA6G1yTzRijc00HEscxJhVxG3zAfLkhk1Lf0Za5x0c9wxyQ36SCEjhh?=
 =?us-ascii?Q?ix80/cL9u//7LEMuk3CTGe8PE4h86uJi+LLmOs62A87aHfjP0tSoku3gankW?=
 =?us-ascii?Q?u3CEwYViyHdud8TrT96kJI2QmzCYy1cGLTu2fqGne117wN7V6nU2KH9dESQF?=
 =?us-ascii?Q?F1pH1Ob8pW/YscwCBx8Liw4l95kwCp78X1pO8ytZyNjBsTWIwpJmJZmKfNDw?=
 =?us-ascii?Q?qgfoeT8LaPEbtIJq08E+lEaAfqXXk4KLZZ50id2vRCUwurpRRk69gDw0kJwt?=
 =?us-ascii?Q?2i5QeX3jTsXDe0tZ0i4yjuo6Ickdf+gY35wIC9coiIB2W2MZ4b9pj/afQfdt?=
 =?us-ascii?Q?7yQLNEufEl0xPFROYcOqLd65XCfOe14ep1u+TGL0SdtnuAuCKGp1anSXehlR?=
 =?us-ascii?Q?bcs+7TuaAuk7QJMW9dRSnOWoUXSKJEaFwK4WhSbFwoGsNGNNPxk0gexyRMYN?=
 =?us-ascii?Q?5WnlJk8KjDpHQzDlN6gNDSDwJK16RdsQjN0HyFo6Peh6xr28O8kpYlad7EsC?=
 =?us-ascii?Q?UiHGqsyqS2RtkIgo7kn9Jatm6tRMiN/r7tOwF1JgwMlOH5ODoicL8onBm6p4?=
 =?us-ascii?Q?GOu5V7LibwPLAIrJgkuYjfNsno+kh/Qz/adDgVUD9GENkP+VArVvXFdQ4JDV?=
 =?us-ascii?Q?LjiVGlR1yR4aUOaHulcnxOjwlL/DTP/pgReHG5ps9qidAadTCHie5I9oBsav?=
 =?us-ascii?Q?/WpaqXxDPH3S3zApQ2Br+JR4mIcZGPCXYCT4oZ9WiGQVsVpa8UeRv1Rn9lDN?=
 =?us-ascii?Q?gSwRNNhFLX5oGbc3Zu5vrkcuwJTdfKXAMIVeXtZLkfAdU/WB8e9855V9UuvT?=
 =?us-ascii?Q?6tzXNMHty6j9rQ+TFyWM7vh9InBWHjhyKfB5J0GjjBwNZ7Gods97artg9DCu?=
 =?us-ascii?Q?1++84i9b08lk3/4nhu7RO//Z41av06j+/eIqIEawT+ARfefsgTLin5yRChKD?=
 =?us-ascii?Q?oFy1DGfSTN77ssIQbduXRcsc6JLzdiX5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uwiObeDs63mXT+xRrVUhWqCcZV/k4T/AG5ocKt8N/cqdoHs85otHfv/pHK2l?=
 =?us-ascii?Q?gF9ibBF//JzQ2GpF0p2qGxHLh2hOGcYZEy2sQuyNQG/C6tWNlle1u+UqZuW9?=
 =?us-ascii?Q?t919if9urNlRZbzBFL+MoW5KOk8VHVCaIwIAwpxsyzrc2JN4dabdZhYitjPK?=
 =?us-ascii?Q?ibwSxwIehvA27J78XmqyttXIelzoKzoyp2v0o8SviTLHmSnD+kD8Uc/Z6CJS?=
 =?us-ascii?Q?v4C1uKeXVO2xaVPOp1/gVJwpWMnWVtfzg8y/wMM9SHM4GLGvoHZAesDe1HP4?=
 =?us-ascii?Q?OskWTUOMw0k9QenFx31Ty+KsbHftuP89NG27lH8Wcu9idnR+92N4aS7VphqO?=
 =?us-ascii?Q?Mmzo02+fa/+Sem4qVOjwjQTH4ha9suiLmxxgEgGzuQYlLHR7EHgeBHE+M7/y?=
 =?us-ascii?Q?Q4cVwjsEQXY6uCeM2gHkhLNriPtxt83DTD9Mg6Lxig/fmegwKJrveba6+eDi?=
 =?us-ascii?Q?Y4TGaesrtELijhVJ509HKtk9CVa6WxGCarFyRLqhN74rzRFPMF9QZnatvaut?=
 =?us-ascii?Q?s1lw1dtavgJwRF/z+Vwp8WWeHtZ/3a2uVL4IUyYkb0Y7RtUGR74pWZWQS2AD?=
 =?us-ascii?Q?S1VQozxz5/Yv+DIyU7KItIKeeUS/1LN/b9LPOsc/XxBj94fiK0GzLJ3F1o0+?=
 =?us-ascii?Q?ESDmtG1Me2biHizVSph58zQYayvFZo/FwiXTVaS3u8Bz3Rlz96H3LNeMJkl+?=
 =?us-ascii?Q?lWge2rg/YmFTvYGOGIjJMnkwPNFelQl/Hcv18OEXefxRynCEMZnWG0a2+tCY?=
 =?us-ascii?Q?mf3X58BDMw9Ynog6YMn4rWXtBgzNpjiaExX5MOScJhxqO/WSfEa7WcelQqb2?=
 =?us-ascii?Q?CGxIJIQAab6njFdAy41IEecF/4d8bu71P6nAxoR68nVczNdLf+cZj6KoVUx1?=
 =?us-ascii?Q?Qb+pLA/E4fyJPBg0JJUSnSCZ1h0XIWxZ07iC1sm9FypPRnx8fG2qGptx36dA?=
 =?us-ascii?Q?aKVS36RscXks3kq0q6sxsr7GhRWXJ1fiNjUoH6B77Jwv0PMho2whLdVPryOp?=
 =?us-ascii?Q?FOZguuEwxtHmb9r+TMGh00D5HhWlqyMPkPDdHVg0WJeQU1TOZh2K6Gm57C+j?=
 =?us-ascii?Q?eHBnsTPIvNaWGURV+zY9fI2Ow7HY0iftx7sdWJdlFybfi5LBUhu7+ui+PYRB?=
 =?us-ascii?Q?y4G51v4pkObki/YG02s5jk7CPGZMzqxoBZKoWUJPUMxBfUehyoQlJM01kpdg?=
 =?us-ascii?Q?OAbw3elkJ7rBpo2OWq81m0aczrlDTzuAwpENkGHp1fTfs+UYJSVWvyDgpcAh?=
 =?us-ascii?Q?U2OGm+kjAauESv6ru/urZY6wPK8k6ssPOxlshe2belqQjzFiRY1VsofprIpo?=
 =?us-ascii?Q?3HpLfJVbXflNyQ3rUN6W4MK0t1NnKjjuch1c2d+wzDUAXmX2AG/XzfRU7LcL?=
 =?us-ascii?Q?3kmNIJbkFX29sqaIzoxftWKZm0SVW4RpwMcNCErjuawjCaCDvJVmWUnhGW9y?=
 =?us-ascii?Q?shEMewfk0G1p0dH8C3H4XfycqD9Ue5jYzd4k/ZAWOOe91I1EBt+9DHsNhGh8?=
 =?us-ascii?Q?l9n3cGlSuT3EL4nGyl9q6GH3J52TLG9elQfb0aa9ZtRNhNGDVDHwvpetlx6Q?=
 =?us-ascii?Q?d+Sr7bQ+1JJ8kn92AzZOCTLWuUstMLrdRI/C571t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a58706-360c-44d9-d28a-08de0bc810f9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 08:51:44.1290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8NeAn/EWzqP/jLZqbGDJFFcqcuiqbaz6TMFCOSOhnyQ5ybLNLP237eDr87vLLrI9MXyH0jm2g2XFuVYIn/ueog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7114

On Thu, Oct 09, 2025 at 11:17:53AM -0500, Mario Limonciello (AMD) wrote:
> amd_pstate_get_mode_string() is only used by amd-pstate-ut.  Set the
> failure path to use AMD_PSTATE_UNDEFINED ("undefined") to avoid showing
> "(null)" as a string when running test suite.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>

> 
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>  drivers/cpufreq/amd-pstate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index a5b9e5baf4234..5feb9f5e3a491 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -70,8 +70,8 @@ static_assert(ARRAY_SIZE(amd_pstate_mode_string) == AMD_PSTATE_MAX);
>  
>  const char *amd_pstate_get_mode_string(enum amd_pstate_mode mode)
>  {
> -	if (mode < 0 || mode >= AMD_PSTATE_MAX)
> -		return NULL;
> +	if (mode < AMD_PSTATE_UNDEFINED || mode >= AMD_PSTATE_MAX)
> +		mode = AMD_PSTATE_UNDEFINED;
>  	return amd_pstate_mode_string[mode];
>  }
>  EXPORT_SYMBOL_GPL(amd_pstate_get_mode_string);
> -- 
> 2.43.0
> 

