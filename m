Return-Path: <linux-pm+bounces-39208-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FB3CA4C4B
	for <lists+linux-pm@lfdr.de>; Thu, 04 Dec 2025 18:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1205303B2EA
	for <lists+linux-pm@lfdr.de>; Thu,  4 Dec 2025 17:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D882DECAA;
	Thu,  4 Dec 2025 17:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fbrukrAm"
X-Original-To: linux-pm@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013018.outbound.protection.outlook.com [40.107.159.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE6D398F81;
	Thu,  4 Dec 2025 17:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764869018; cv=fail; b=r8bQajXFECWpBrcYSMTWQfjE+74MbG6QeRpVdnbD2W00H3W/wPBQgpfJ9Mwv7qbm1F8odcr6mHnhgzxUdg8jZk1S9tkZcs3Jtq/VXLoCLQPxRzRkRanf9w3W6I5rTZTi/5wfnKqiDNDTLmOa5/lN2dLWSlIQej643RWfJY2O2i4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764869018; c=relaxed/simple;
	bh=cukJ/OqYymoznefLbE5REetxehPKXPLXL/ZNEvEEYfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LgAtvULr6TsyTy15qxL6P5gUSeti9ZsEOzo8HF4N7osKrASW3e5108mXqIjsdPITEplzyUELhQc1xPvcH9uDtaHge/nYHfRaQUgeU6c8IIrWKC/GYbQSostdWofJJGLlrWS5mgCWBDbo5lE5BX7W1gbwmsWy1eQV+RM5DhQGpRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fbrukrAm; arc=fail smtp.client-ip=40.107.159.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FZ75UiWXJ1vahhYz/kxHp3ZPjJ9epNLKnmbR+Qc9sHOr2aTZ0DP+sFUCw/QjQeIfeMSSZDW+LU+sOoRfz0a9VJYtp0zfLJr0AqGBXZeir3DEQLM6vrUMylH3+hMFCcYsFHJ04zY7ZggjaY1H+apqiFdIwusheGwCP8gy2IXFlrQAVPTVh9up2hRVTjSQdX0hnzUMSyZp0hnXkHfphfxVbeMEA5rhtNcZ+ea9pz1qCA/xqO7TEEQI+JCmM+/6w/y0P/faccT2WEjsEdzCM8dWLCCUkfcQ9EmefPgzRRkvg2yWs4Er861peDcqa3k/BCvZo2wfhzTzME0Cv3hAEVDAqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTR/crLhK/jv5t/UyXOjQru8DsDEkTS/DdlZpttXbu0=;
 b=KGGyhImoUjBX8H77d445S7u7EaeB/PI6bw2j7019zOitPU4xz841OHDqWbgrQBzTy/zBrruZfXdzkNUTzqBB0SPatWR0mbdmVo/E/qM82XvGnEqUKwNmBHRxXznZhu+CAoI0PwRsFULWoyHecKFDihy1ez2aPynGZd+aUtfFwe3Uqov9vg393fNmfu1IcugQ96aYElDR2BGEi61zsd9s1e9zLSkfQRJtgtPBluybz88U6/PxwtF9FZIfEGwyPjfXBZGn6D3rwshc9RETtNGQXzL9ORuKC1H6H/hczfIQLGcsidwOEtlg97j6JdDMuZzIgyas+6qpHcTnSBQiaHg//w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTR/crLhK/jv5t/UyXOjQru8DsDEkTS/DdlZpttXbu0=;
 b=fbrukrAmTPCBrV1NTY+tRVP/ZYBqtzxId4SyIhBKW88PY8NVq2YqFfESZGA903WRLdxNWD4YYDneitaoSJIWAl6rlhXtd93JMaq45xWMzFBXOEco0MWi3w+tYHcvLIZc4KBvTROUGBVvfpZE3YkFYvKgWfCUO05SxKNzJq9gWLf4Pwu/zsUl5WY0u32mgrJ04EO/kLsjpOcJ8sPvevmPx8f91tXyjQJyoV34gXhJK4Fb1wZZgqzI1K2fLbbq6GoAnzq6P+76lq0fBD+VTwfykMoo3YzNjpQGLUnIlT+Ukhyh63FYLvl1I4Z5Fm8ZhIP4qv1QTsSo09WedM5gMtUXiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8957.eurprd04.prod.outlook.com (2603:10a6:102:20c::5)
 by VI1PR04MB7072.eurprd04.prod.outlook.com (2603:10a6:800:12c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 17:23:32 +0000
Received: from PAXPR04MB8957.eurprd04.prod.outlook.com
 ([fe80::9c5d:8cdf:5a78:3c5]) by PAXPR04MB8957.eurprd04.prod.outlook.com
 ([fe80::9c5d:8cdf:5a78:3c5%3]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 17:23:32 +0000
Date: Thu, 4 Dec 2025 12:23:21 -0500
From: Frank Li <Frank.li@nxp.com>
To: ming.qian@oss.nxp.com
Cc: linux-media@vger.kernel.org, mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl, nicolas@ndufresne.ca,
	benjamin.gaignard@collabora.com, p.zabel@pengutronix.de,
	sebastian.fricke@collabora.com, shawnguo@kernel.org,
	ulf.hansson@linaro.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
	l.stach@pengutronix.de, peng.fan@nxp.com, eagle.zhou@nxp.com,
	imx@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/3] media: v4l2-mem2mem: Add a kref to the
 v4l2_m2m_dev structure
Message-ID: <aTHDiVI6ZB3E7Anh@lizhi-Precision-Tower-5810>
References: <20251204090813.595-1-ming.qian@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204090813.595-1-ming.qian@oss.nxp.com>
X-ClientProxiedBy: BYAPR02CA0033.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::46) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8957:EE_|VI1PR04MB7072:EE_
X-MS-Office365-Filtering-Correlation-Id: e26b470a-ffe8-44bc-f6ea-08de3359d8c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|52116014|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S6vY92RSLLlX7VRoVto4y/0aTLxz9aWVwwnV6aXqQsS2r+AIt3yMx7cMcMws?=
 =?us-ascii?Q?BDAY5YMGx+M+nsAG9jNbCPuJMzVw480r6Zrr6V2wp7Ao+Y3CrY6lQ8ip1P7z?=
 =?us-ascii?Q?qq1Elrbgx2NNHQM7NsY77yrgNfH32S6fGogqu5qwYYhEdsfrlJHyeadBpZTN?=
 =?us-ascii?Q?fA5vuSwQyBfWWv10Mkmfye3Ldun6/Q2uSFDXj0eYsferBJr6KYw15rcJOkAJ?=
 =?us-ascii?Q?bQsW9HsidMnJfpkuIuAEudxgBsmotXscqmxv3k/ze0s8jsNlyzLMZlJuijHz?=
 =?us-ascii?Q?2QU4RgRxTkdUd0Dj8Gxq7a+CCBHHXZBhtvFGt0Vy0DILua5j0+QX/wOmLCJj?=
 =?us-ascii?Q?S+VV2pTFyqjdtHFiKvdG/4UCkgqpKxJin6H7N7sqElk0dGDly2mL+ILjwv8M?=
 =?us-ascii?Q?75kZOYtJmpZkl6cZ0SIJBuei26KC6Mr6hx1HItUmFRTfHmD/VFoDHcEj4lAf?=
 =?us-ascii?Q?L14iGTpEo+D8Gs/gwrUDxqBZkolajFRB96FHwA5/rgGbFKQQzzjrCYUpUrYJ?=
 =?us-ascii?Q?2vYLMPWicKEf+Mc34B1CisZVHdoDBcPWoXgqRSbne5Xp9AK9p8vhqRoCaTR/?=
 =?us-ascii?Q?ihclNPjCwDdBk2USQ3eEwosj7B/a4/Yxbfbfw3haX3oBH3gJbGG8BkXkUgn0?=
 =?us-ascii?Q?uwmdKPw1R2conK8zYxso6yH9dcaDvPO/u2fAmxCGgZGbanO0+fsJ3xUA/1Jo?=
 =?us-ascii?Q?rlEMKFH3alAeD0oAvTu0013+g4U+8nGACIMteHYl12Nd8QGbjvduj+jaJEca?=
 =?us-ascii?Q?eq8HKiYytp598txLFou9AyllVc6M2Pm9M8SjDfjiPmuu+hvFwkWLLqdk+72X?=
 =?us-ascii?Q?Cjkc+9lbY4EGAoBu72Lgt4RUkIQlhSZYfhLkeuKwIC0WRW/cbvFcSPjggovO?=
 =?us-ascii?Q?QblCfp4T5COLh21glpSehlPKML59rF6N1n7h8Q/4kAWjBAYXKzVdFLR1sQnV?=
 =?us-ascii?Q?18WBRQcNl22V0GklrIrBfx8x1LbI/diIlxMskNU2SguHWff+XWghZnswID5X?=
 =?us-ascii?Q?eIFbiQ5qD2InXwYA8atEKJwgelbpWCsbii6X55owRil5oR0/hxi/wmI+MQ/7?=
 =?us-ascii?Q?KZIxZM9JDlOpo+EeeEZ1NnUNr7cCrWNMlnJ4cskwQ9qpvEFFz7NsZGK1mYJV?=
 =?us-ascii?Q?wXpPsT5O/VTQxtSa9CPZWZ0MItqoeSCqNWW6MChyi+6qGG3d8JFkhlCW8GLC?=
 =?us-ascii?Q?O6mxsG0ytikIWoTFVywhen6z2c/xf6oGbE9Vry0SHVqIbeFp16/zliket3rG?=
 =?us-ascii?Q?eRczJgChptYTXjvWsL7WCy/VaiJ4EVkAH3ptU/BMOle1cUrhbCJSOHq2EWeQ?=
 =?us-ascii?Q?cnyVl4h16krp3wDkGm1sBcMU7Ofy/dNMIyA3G3ZLgn7aBvzFhpCL0uMjdPtd?=
 =?us-ascii?Q?G6teL9dh+KdeJkxcTaIh8nllU9hP+/lNjWl5jjSpQAm8i0AVW/ShroLjYFWM?=
 =?us-ascii?Q?BDyh2txl/D7LUjNOXcA3TGflPIlOXW9WvL3T575e/5mt24e5ecU0gXZXXr/U?=
 =?us-ascii?Q?bwlMh4f8Mmcf6axsaIhXP+uTYfFMjAInJEsb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8957.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(52116014)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ShBUhi+xbMOf3dziE8hbBoY9VF6/RFp54f1aJf8vuBz0Ua9DXTv4b96k+9c/?=
 =?us-ascii?Q?/un1BRK3CD+uJ9uIXR8MttkAX4jzzMJboI/vN32PTPdmzWb8P0fuZIx7TdlW?=
 =?us-ascii?Q?E5q0jVpP3XzowY6OWlGfSN0qGJkcbyhqqBcPUHN3Sh1tTPNi0XauTYh4RTQL?=
 =?us-ascii?Q?bIke+dpuZWdWHQwMNYQ1sDKthJLVwzsrWSus1EAV+c5JAt1K4x8mJMXDF27g?=
 =?us-ascii?Q?0vPxYu729hqqkUMDFcrE3bdKSCkIz3md7hnwQK+9A76GXf3drAw4W/dgzlDO?=
 =?us-ascii?Q?L47zAO9Oi+RGvdID/f/wG8v9nP0IQP+GyU4aeJ6bvND7L6HMfmMd97Ii+iNJ?=
 =?us-ascii?Q?hPlmMOkl5poOmTSh2sF8tUlRpqcDKbjZN9Z6dOUrA+Mlfd3esLkoaJ+X+gwx?=
 =?us-ascii?Q?Uw573u+2aHhaY9+CyH6u7BZixqXWMTASrNX7g96oFqukpIR7YpprK+4OqILw?=
 =?us-ascii?Q?xXmXsiQjNAdb0Z1dz02B6k2LZw4rWO3clrSsCRiODQE38AzDh9761wUV3/f0?=
 =?us-ascii?Q?hoGQH0nlARncLQ8/voFCE/rWI+ETY2GRJUFCldY/PfZYRrefCC6sCGR4JBB6?=
 =?us-ascii?Q?GOprNMTvaXxmgLh6m2pCQyH8CmXQ65HcLKCgC/kXlF+9JC9w5cFBQn3gAfVQ?=
 =?us-ascii?Q?07im8p42CwB0GdcYniFSAP45BUSMrYTpVbLRF4MypAyec7koUkoFK9AVjZOa?=
 =?us-ascii?Q?bcJiiPzsA1AB0V23LstzJ5WDEKAFzh2WBOZPzf2XHVmjUSVOTqlO+iiIpWN9?=
 =?us-ascii?Q?pOAYH/JZDVSGQ/uXBnXyU4g64Ije74B0wlExcEsgK3zICgd2ZAFUslcH93NP?=
 =?us-ascii?Q?nvvx3M5O5LuQO+/qRPRTHGa43ezOwvmrGyV5Kb0SEkl+2uQdLtG7l3+Qs25q?=
 =?us-ascii?Q?nrtT262u19thqhUYs3DRJAPBQVyf54/XQ/ox/lkcCrrhTp1H2q3vWiFk2/uO?=
 =?us-ascii?Q?BYHbX/+gLBHOo3bi7rLBy+WY3/VhnVGDzhyN2neL4C0Tap8+4EVrd3gh1Spg?=
 =?us-ascii?Q?g5ZSnIJLTwENHX8ilCTYMN0QfarOUllXTjSS4KSWRkjQ4KyiWMSV8hOSMg2A?=
 =?us-ascii?Q?sggtX92cXjecQajfZbrJYwxozpq6FSMZYc6W75XW29X3O/2XI7Vv9C3m04c0?=
 =?us-ascii?Q?u8Lzx7HmPWdIbZyey3vbyfupO42Z6ohyAe/vR+C5oQeuBbVUb7i4owCQ5+rH?=
 =?us-ascii?Q?sFtaRdZPngk323zU/Lgg+fn+h/zqB1yjxxoQ4kfNz50uoS/cODSPC+7DCwAR?=
 =?us-ascii?Q?LZr9Aa+Lvw8RfqsROa2r4YEVETEwTOsNQVIA4eo/0aQYuLzYxWHHMUJh98yB?=
 =?us-ascii?Q?CTxHWCMRj5n/r1E2kBCSKUpV8rtoYtqCFg70s4lJPVfvmoJEVknGOCyzaIKB?=
 =?us-ascii?Q?YWXBvbDMDpSC2eb5iF7/HhTxo6WO99v2sbD/R3EHlJkKa1g3WiTNakNVIRhu?=
 =?us-ascii?Q?xHZfzIaSrxvHa+KyFH0oU9XQ6/9sDhLogY19zU1TseHlqDWw6uSAvZZ1nnpR?=
 =?us-ascii?Q?wLNo/4Gobz+MoQqfhJL+0I1x9pj70OqQJ7v5b3dslxhJAPopeAFlTaQ6mGkB?=
 =?us-ascii?Q?pPvpzoXxjG496iEADoJQa6IQujNqmBuoX0LyAjUM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e26b470a-ffe8-44bc-f6ea-08de3359d8c0
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 17:23:32.4826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m2p9/YmXDdH3jrLTBNrAq/ByS5FcuKLDeUqyF531Qty6s1gQImyLEnXUmY9ssu9vV+Y1PyCf+oHfGqbMXc6/nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7072

On Thu, Dec 04, 2025 at 05:08:09PM +0800, ming.qian@oss.nxp.com wrote:
> From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
>
> Adding a reference count to the v4l2_m2m_dev structure allow safely
> sharing it across multiple hardware nodes. This can be used to prevent
> running jobs concurrently on m2m cores that have some internal resource
> sharing.
>
> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

Also need your s-o-b, or just said refer to other thread if it already
posted.

Frank
> ---
>  drivers/media/v4l2-core/v4l2-mem2mem.c | 23 +++++++++++++++++++++++
>  include/media/v4l2-mem2mem.h           | 21 +++++++++++++++++++++
>  2 files changed, 44 insertions(+)
>
> diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
> index fec93c1a9231..ae0de54d4c3e 100644
> --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
> +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
> @@ -90,6 +90,7 @@ static const char * const m2m_entity_name[] = {
>   * @job_work:		worker to run queued jobs.
>   * @job_queue_flags:	flags of the queue status, %QUEUE_PAUSED.
>   * @m2m_ops:		driver callbacks
> + * @kref:		device reference count
>   */
>  struct v4l2_m2m_dev {
>  	struct v4l2_m2m_ctx	*curr_ctx;
> @@ -109,6 +110,8 @@ struct v4l2_m2m_dev {
>  	unsigned long		job_queue_flags;
>
>  	const struct v4l2_m2m_ops *m2m_ops;
> +
> +	struct kref kref;
>  };
>
>  static struct v4l2_m2m_queue_ctx *get_queue_ctx(struct v4l2_m2m_ctx *m2m_ctx,
> @@ -1200,6 +1203,7 @@ struct v4l2_m2m_dev *v4l2_m2m_init(const struct v4l2_m2m_ops *m2m_ops)
>  	INIT_LIST_HEAD(&m2m_dev->job_queue);
>  	spin_lock_init(&m2m_dev->job_spinlock);
>  	INIT_WORK(&m2m_dev->job_work, v4l2_m2m_device_run_work);
> +	kref_init(&m2m_dev->kref);
>
>  	return m2m_dev;
>  }
> @@ -1211,6 +1215,25 @@ void v4l2_m2m_release(struct v4l2_m2m_dev *m2m_dev)
>  }
>  EXPORT_SYMBOL_GPL(v4l2_m2m_release);
>
> +void v4l2_m2m_get(struct v4l2_m2m_dev *m2m_dev)
> +{
> +	kref_get(&m2m_dev->kref);
> +}
> +EXPORT_SYMBOL_GPL(v4l2_m2m_get);
> +
> +static void v4l2_m2m_release_from_kref(struct kref *kref)
> +{
> +	struct v4l2_m2m_dev *m2m_dev = container_of(kref, struct v4l2_m2m_dev, kref);
> +
> +	v4l2_m2m_release(m2m_dev);
> +}
> +
> +void v4l2_m2m_put(struct v4l2_m2m_dev *m2m_dev)
> +{
> +	kref_put(&m2m_dev->kref, v4l2_m2m_release_from_kref);
> +}
> +EXPORT_SYMBOL_GPL(v4l2_m2m_put);
> +
>  struct v4l2_m2m_ctx *v4l2_m2m_ctx_init(struct v4l2_m2m_dev *m2m_dev,
>  		void *drv_priv,
>  		int (*queue_init)(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_vq))
> diff --git a/include/media/v4l2-mem2mem.h b/include/media/v4l2-mem2mem.h
> index bf6a09a04dcf..ca295c660c7f 100644
> --- a/include/media/v4l2-mem2mem.h
> +++ b/include/media/v4l2-mem2mem.h
> @@ -547,6 +547,27 @@ v4l2_m2m_register_media_controller(struct v4l2_m2m_dev *m2m_dev,
>   */
>  void v4l2_m2m_release(struct v4l2_m2m_dev *m2m_dev);
>
> +/**
> + * v4l2_m2m_get() - take a reference to the m2m_dev structure
> + *
> + * @m2m_dev: opaque pointer to the internal data to handle M2M context
> + *
> + * This is used to share the M2M device across multiple devices. This
> + * can be used to avoid scheduling two hardware nodes concurrently.
> + */
> +void v4l2_m2m_get(struct v4l2_m2m_dev *m2m_dev);
> +
> +/**
> + * v4l2_m2m_put() - remove a reference to the m2m_dev structure
> + *
> + * @m2m_dev: opaque pointer to the internal data to handle M2M context
> + *
> + * Once the M2M device have no more references, v4l2_m2m_realse() will be
> + * called automatically. Users of this method should never call
> + * v4l2_m2m_release() directly. See v4l2_m2m_get() for more details.
> + */
> +void v4l2_m2m_put(struct v4l2_m2m_dev *m2m_dev);
> +
>  /**
>   * v4l2_m2m_ctx_init() - allocate and initialize a m2m context
>   *
> --
> 2.52.0
>

