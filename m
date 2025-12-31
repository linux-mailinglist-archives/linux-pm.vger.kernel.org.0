Return-Path: <linux-pm+bounces-40077-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 492D9CEB4DA
	for <lists+linux-pm@lfdr.de>; Wed, 31 Dec 2025 06:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 110DC301634D
	for <lists+linux-pm@lfdr.de>; Wed, 31 Dec 2025 05:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747DE30BBB9;
	Wed, 31 Dec 2025 05:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ODLI1vLB"
X-Original-To: linux-pm@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013001.outbound.protection.outlook.com [40.107.159.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D00323D7E0;
	Wed, 31 Dec 2025 05:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767159458; cv=fail; b=kVbEqPj+O0pvYlHPCMeDHlifrBOJgY8QXx+YTlra5FgdrvAYbEeBzkRMCjm+n1wG7p4BFIOIFQlbg6lAvfCoO8chFM6gLe/XcbhkkybWHWKTkA2iChNA+mWwo35paKHYsnEL1+lL1sgrGweb9QqGTB0BQrsQfEpx2q6+Gs63pAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767159458; c=relaxed/simple;
	bh=8qiMI+Z1+xhMuhACtn7fqeAYbThKZDc9mXeVZx3lH78=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=twfrGaT3fugcBBGpVu7dih+Bm58rbPSOockfOUeBc9zrkERS+La2JdIAwGWTa02N15rLD540wgNscLFpFXSJiEzGVpPPip0BBw3N99Kha0LfAizpQzAzySzZQS2RupwAz6KS5dxXruXMLuLMIImHmUYGwRxo5AaskvTa20/s7Ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ODLI1vLB; arc=fail smtp.client-ip=40.107.159.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KhhXf48pXRNivUu1PwQrBescHWvVVBzgwlldJqUDyt7nS0TxL3jeiEOOyeW0hdHDaoyykHmj1VKUfklEB9nJ9bsv6Ljg5wrLMHFCH+bL33rFgzWGvR24vYWlzaN1UHVoI3Nt+fqnxvTVMA2IsnAPhTPpTBpDWvbAKj38YMFgU92QjYotR6G07bOYIqV/Z9J802rGstBViBswb0HUA9VoQMxNrTvQL1rYBPgcTXOJINOlHbG0qOTtc0pMkWE0rkqjxYl7R/tY6KawIO/CzRZaE3eeK16kP4arp6uocXoP4hdZnQctluc93ldOFd/z/vyoSAS8dKM+pZbbfLkzWjJOdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+YF/NhY5BbaTjipkL6+B8jFwDA4YCiVu/DkmLygp5I=;
 b=XT3z3ZIIu9KKLjbgso+WntrArOLJHtO1ivXfWp6KAmEV8t3VnsmgAkn1njvOYL9YyRTqC7pCWuKb2PThYU/P6zrp8nPHdDg67vXwnfetzXIWZRTf7ZxeOWZOaHVuAPYrNZowejbKZjRgOYWQKepASiBJquDIEkh0MKTC2h1cgiR6mXiqcWHtvrCglrcPB5q7BB+e32yKSYzn/L2FW/rNtCkfkaxNsiOXZHqmnRQtqfB3ZqylqoBL/0mx86eLE0tfDu9YhpiA1Hpvq5sLegpVSW7tdUOZMArpafFuPCeVcKuyV0deiQad3cO4beEzcVj+WM3cWK7qI0jdTP8E4N4CCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+YF/NhY5BbaTjipkL6+B8jFwDA4YCiVu/DkmLygp5I=;
 b=ODLI1vLB9cV23dpjTpNbz3m/Q4rgf7UtHXqlRWT10kTnMHp3LgxUoD5oHD7GN6G0TlXlOkQgt5k37t72xxN9qOriRIHbtWMUH9D4TJ9PH78niQENKFwj2/dgmzWG+uOOoE5zvbwWkufqrSo1pCm53NNCr8GLchlYxm2JSMuPmas/R+R73qoFDmGjkDNUp5r9Xz0ew6jaxPIKWcblRMtF++cWAUjDs5zWKQG/vtU/urqqcgzVFzcAYtCjRPVYPVpfIxY8temzgqFwli1Q8uLdVg/aFI7nfRFMzVvCQCJGw2iCNWtZFOMzGinemC6ATlhE4cIOAlVn1xro39ABKM28+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
 by VI0PR04MB12212.eurprd04.prod.outlook.com (2603:10a6:800:332::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 31 Dec
 2025 05:37:32 +0000
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::2755:55ac:5d6f:4f87]) by PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::2755:55ac:5d6f:4f87%4]) with mapi id 15.20.9478.004; Wed, 31 Dec 2025
 05:37:32 +0000
Message-ID: <3397e2c8-602f-4cd8-8cd5-7af3410edc00@oss.nxp.com>
Date: Wed, 31 Dec 2025 13:37:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] Fix concurrency issues between G1 and G2 on
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-media@vger.kernel.org, mchehab@kernel.org,
 hverkuil-cisco@xs4all.nl, nicolas@ndufresne.ca,
 benjamin.gaignard@collabora.com, p.zabel@pengutronix.de,
 sebastian.fricke@collabora.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
 l.stach@pengutronix.de, Frank.li@nxp.com, peng.fan@nxp.com,
 eagle.zhou@nxp.com, imx@lists.linux.dev, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20251205015428.643-1-ming.qian@oss.nxp.com>
 <CAPDyKFpFm9kCSNbALJTqeyzFdg3OoooE2gUOXJcjv=WgQeZ84Q@mail.gmail.com>
From: "Ming Qian(OSS)" <ming.qian@oss.nxp.com>
In-Reply-To: <CAPDyKFpFm9kCSNbALJTqeyzFdg3OoooE2gUOXJcjv=WgQeZ84Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0188.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::10) To PAXPR04MB8254.eurprd04.prod.outlook.com
 (2603:10a6:102:1cd::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8254:EE_|VI0PR04MB12212:EE_
X-MS-Office365-Filtering-Correlation-Id: 1912f1dc-7594-4c78-56eb-08de482eb17d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXNhUEdWMnBTSm9SUGV5SGd0SVBHZHhQcjB4dUNKTEZlRS9ReTgzdlJkMG41?=
 =?utf-8?B?bFh4UXZDcnZSeEsxQnM5N2hBTC9IK1ZHN2loTjR4bzlPV1hTMys4RDNleVk4?=
 =?utf-8?B?R0RDdHN6bWpjZlJqeWsyejhzamNUSEd1YVgxTytrZFFUTGRIUTZRQU83L1Fo?=
 =?utf-8?B?NFlnNG9rR1dSZnlxWXp0VnVoZkU5RVAvVmFGbFpWWjFKT2d3VjVqOUFOdkxQ?=
 =?utf-8?B?cTF2UlhBSmVEakdUenRlMlVkWmpsZkdZdy83UGwxMktpamUrQnJVWjgvaXBH?=
 =?utf-8?B?L2Y4WUhnZnJTVnByYzBXNHlNcU5RcnZ2Ukd3UFBjdisvNHhoNDBlYjlENFIx?=
 =?utf-8?B?akhRQk52Z3Y5a2Q3VmxVL0dTYU9PRmhVdDJEc2xPUldiSmpweHFrdCtNUVYx?=
 =?utf-8?B?MTA1UWtNdTl4RFZ2NnQ0Um45RWVKQWJEbXVCWU13QlE2MjdqQXh1R2RkaDVY?=
 =?utf-8?B?N2Q1RUR3SjZVait2V2dvaDN1MmRFL3JaTUE1RFNrQVAxRGl3TEYvWVRDZkY3?=
 =?utf-8?B?OGlFQmxFWUl1T0kxLzRpU01CeGttaXdlZmpWWmRTL29QNzNZTjB0SjZWWHll?=
 =?utf-8?B?YTc3RVdUOTdJQythQmdZVUxFNGRDSW1GU1c4UDBWWFJsOU1GbzVvQU9MZ0t0?=
 =?utf-8?B?WmFYWUVZcE5oaGpRYTlFaUFVdzYwNDlEY1p2Z1JkMWdzT0kwRzBDWnRka1k2?=
 =?utf-8?B?UnN0RGhjRTBrSHpzMUpNRytKMzZUT3hWN1U0TVovcnZqbzNtaHNSYUtWd05C?=
 =?utf-8?B?VUlReXBpNlo2T1lLdGt1dzgreFJ6d3V2RmpiQ1grbWRGVXV4WTNDZXJQRmZq?=
 =?utf-8?B?ZnBXQ094UGNrL0JiS2lETEFCWWdPdzE1TTliT2d3RTNEVlhOc3VNelV1Yzk1?=
 =?utf-8?B?L2pSZzQyS2dMZC9uS0VFOXdaSjBLd1p4VFQxdmF3Q2pKYU8vc1dQRlRwNVRE?=
 =?utf-8?B?Q2VnZlN5dEtaMDVsanhuaGZmeWF6WHkyMkZJNk5hbVRRSzlnTTFyTWRqK1NW?=
 =?utf-8?B?NjJ1M3pYRlhDZEtaUUkyR0xaT0loL0w0anVpWWhXajBRK0dEZzBRa3ZBQ1Z5?=
 =?utf-8?B?NUtPanhTUzF0S0R4M0V6VEJEeDVpT3RFelp4T2ovK0Q3SENvbnNIbXh6MTNF?=
 =?utf-8?B?bFFabDRhTlU0azdJUGRNbDJrcVJ2SG80OTZMSk8vaVgzSHF2SDRuOFh0SWx5?=
 =?utf-8?B?d0hLQUlFQlA4aDVoNDA1UEhvdUFzN3dvNXdRU1N6MXFKUUE5aEkrcnJCbWtn?=
 =?utf-8?B?RkpzRzFZdTJHYm52Vis3ZGo4aXlzaHZyK0ZwN1Q5NEFIZFp1V0ttd25OZnBW?=
 =?utf-8?B?MUNScW1aTlRaOGp6N2UxZGUxSmV5cUNaWkRSY3dHcXBjQ0NRMFZUSTJ0ckxm?=
 =?utf-8?B?T3JKMldQc2h3cXBkNlFNSm1mMlZPelJVV3lXTis3Smx4RDVpV3c3aTltaVJj?=
 =?utf-8?B?Zk9tSlh0SmVFVmVQci9xMkYvU2FyQmN3a3lVL1ppdTBoLzlCOGc2QmQ0bk82?=
 =?utf-8?B?ak9oTCs2b1VoaWRHeDlkZGE5N2hDWHUrVVlyVGtKVU56WmxmTE91b0lKUGxm?=
 =?utf-8?B?L1JrUGhURkIrSUFXcGliUGd3dXZnWjlRNlVoaFpLTjlBVFFtLy9Tcm5ZZVBM?=
 =?utf-8?B?T3ZCYzVrcldDUURYRXpRRk9JYVlnUTY0VnlnYXIzUDJ0bithU09lSk5JWVp3?=
 =?utf-8?B?MlpZRUlxYnpTV0diT2hxRzMyUkdGTU9Gb01zZjJIWFRyMlVDMEhFWERSVFZM?=
 =?utf-8?B?VTdzOTg1RldzTVllMjYxVjRJQklQWmxoZWwrblZJL2lhaVZ0VzhPT1laNFJz?=
 =?utf-8?B?NXlHQ01FakViSWVGa3RRcHR5TVZTMWE1bjRLVDdvUzV5L3RGN2UvM3A4SjM4?=
 =?utf-8?B?TzRZNnczNmV0ZzVNRFRMT0lYS0dYZDhzSGIzalFkSHRDMnUrUVpidjFmS0Np?=
 =?utf-8?Q?vPbvr5hskT+t+/XQy7zWRATkl39MkUNx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8254.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmRRanR1cjZZZGZFYlVESmx0V01xUlY0dWFYanY4MmQvWC9qcmkwM1J0T1JN?=
 =?utf-8?B?ZXR2SzF6T2h3RGVjSGRIN1ZpdUViWXZObVhEVmZuN1plZnUyUFBqM0M4by93?=
 =?utf-8?B?Q0UxZE9wTm9iYVBZTG01SVg1eWRkNjBiZDgyOFpkRHVydHRuQVQxWnJ0QTJ6?=
 =?utf-8?B?eXdWZzlIZkt0SW5KR0JkdW9FL3N3UjNCWVE4ZDVpT0RBS3ZxVmJtQjJ0bmRq?=
 =?utf-8?B?SGFGQ0lFbGhpWDc2UTBra0NYTVFXL1ZBa0hObTVHWFpuU25DUDFSQnBHanF5?=
 =?utf-8?B?blJ2SFpmZTRBN0owVHVJUWFtNm8zM2V1NUhSNXIwY3dpbnpOS0lCd2dhRUQ3?=
 =?utf-8?B?eDRoYXBuWjgvSnJWSUppMUxMVUlTbW5WV0NvSlBobERtZ21WbDJYUkY4Z1Ix?=
 =?utf-8?B?QVFKNmVLTDl0bHlJUmZHUDJJRkRJck5xcTYyUEM2R2VFTzU0MmJzZFFjaXNm?=
 =?utf-8?B?UE9GRFMrNGw4WkNtcEdqaVNEQ0xZMjc0R21LcmMzS0dnUGVEMFM2RFowdDBI?=
 =?utf-8?B?UDVKVXMyU1d1U3ZRRW83MkR1Um9SV0lxeUI4Sk1DNEp0YU9lMG5kZXRhbTlP?=
 =?utf-8?B?Zm9IRGxRQ2FGamN0Y2FrT2wzZUZZR1VaQTBqdll6RURVTjQ1SlNoelkxWXh5?=
 =?utf-8?B?dmJlbk53ZFJsTzFBcktpc1NuNms1YW5YazNpYVpWejNxcGsrR1BLSURPR0gv?=
 =?utf-8?B?RVdaYklTVzZEYnhZdXlXU0c3OXVBVzBsdkVpdmxqSTRPdEphcDlQUm1YT1dw?=
 =?utf-8?B?TFEwKy8wN0diYVZJSjFuSU5PaUJUSnZYS2lRMHRrQzNBbkh1WnhEWllZSHlE?=
 =?utf-8?B?VGE3WG5BSEVMUmRzbDhjSWdOS25oUUU0TGVMaHcyQ0hqekZlSEIwZWlnU2dX?=
 =?utf-8?B?UUhOdDM5Z3dPb0N3R0VnMjA3Z2lUYWpmSG80QnRqWkpTYytwQkJrZVViZlo4?=
 =?utf-8?B?dXlybTQrMWdsNXVZM2hjZllneEVLMHlmTjVtbXJTOC8xQitKMnU1cXc3cS9L?=
 =?utf-8?B?REt0Sks0ZHE2RVc2Yld5K3M2RGpwVUlHWFJyWGZnVkVKaEIrL2lwMFFiTUV2?=
 =?utf-8?B?QTY4M08xZFoxM29TRU1kVWlibUl4cnNwQ0EyMDBTWVp3SGFWZlZNWEZsR0Fm?=
 =?utf-8?B?RWFBT1F6QXk3VGdyeFVyY2JTTFJpNTVqaisrWGxlRGNQTlp4YU9BS2NEMHpR?=
 =?utf-8?B?WVJOaWgwNVI1elM3OTR2M2R6UUFuNDJZWjJHcTI0TkhDVVh3eTBBbUttVytj?=
 =?utf-8?B?N05iVGNoMXUwSXpwV2VYTHI1aUhPTzlQNzZWeEJLbEpwa00rTW12OTB2T0Nl?=
 =?utf-8?B?ZElmeHZiT3R6TTdQU3AzdU41N0o5aVRNVlRyOVFpai9vMS94TWRQN3V4Qmow?=
 =?utf-8?B?MVVYTjIxYVlsMmZPaHE1czZ6aFpxMDBwaEtRK1Y4bGJadERXTE5WUzhYOFVh?=
 =?utf-8?B?cVlNMUZ6RnZINCtiNGwxNEVKRy8vZW56dmJVaE9OUDFiY2V0WTdidjRvWGZZ?=
 =?utf-8?B?b3YxMUVqT2dqTHBIN3cxY0Q1RmFCZWY3RGpnb1RockdXQjQyZTh1aS9UUEVS?=
 =?utf-8?B?SGtHd2xLWVp1L0M1V09hQ0V5Z1ZoMVZUL2xrK0YzL1ZuWDRzQnJZWDEwZ3Zn?=
 =?utf-8?B?TXJwU2FJV0tuMUtWZHB2clJKVEZtdE1BQnV1SGtaeG5ZQ0xsQmtTZDg5cGZk?=
 =?utf-8?B?RmhJdFdtZkJWdWpPcklTQ0NyS0h0Umx0MEZOaVRqS0xUVTlMaVJnTm9Nb0Zo?=
 =?utf-8?B?cFIwNkFaUWVucXRhUGYyNmVsYjM1d1lFUVlOT2o2UXhMUmpTSExrdFRocXR4?=
 =?utf-8?B?eDJEMmtHOUIrMlVXZGxYL2wzSTNudklxR212VlFKOWlHZDFhZUY0Wjdqc0c0?=
 =?utf-8?B?UEx5SFRpZlAvbzZsc3V2YllNUGNMYVhWZS9BY1FFSzQ1YzJWdVlmeXE4NmRM?=
 =?utf-8?B?U1UwSEJnM2xFVEd1c29RZHRYS09zcUhHMVBCeFBzOGhxekw4V2hqc2E3azdD?=
 =?utf-8?B?WmNXSTQrNmo3Rm9CcjBuOVlKcGFZMFNFdmV3eHJ2SFFKdVFmR1d5L1ZYeGYx?=
 =?utf-8?B?Z2JYTTVUeGdyNjA4VkZTTjhLVTNjOXZrZit3M3BFN1BVQWdoOGRLcmg0SDAr?=
 =?utf-8?B?TEt6NStOcXpYb1NpWHFZK1I0SjhjQTZ0K1pORFoxMFNUWHFUWnRHSnRycEtj?=
 =?utf-8?B?TDFUSHVWeHFmVzhDRGsycWR0YkgvK2FnRElwdU9LT0cyNHNINTA0OWtWbXZv?=
 =?utf-8?B?eTVTLzVyV3lKS3NDVGNCK3BZU0htR0pSRjZGbkdPMGdZSUZ0cW9BL3V2MEZL?=
 =?utf-8?B?NzYrQ3NpWkptcUhNc0NSZ2h5QjlEbWpYS0cxS0l2anIxSEVjckUxQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1912f1dc-7594-4c78-56eb-08de482eb17d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8254.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2025 05:37:32.0430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +7Dtqdcwhxjr+0B43PRSwxt3X9+292fVY6ZM0YEi7yv+8aRPssoDOM2ugW+bsvlY1UdGMQQ0KRF6iyYf0nxQsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12212

Hi Uffe,

On 12/30/2025 9:42 PM, Ulf Hansson wrote:
> On Fri, 5 Dec 2025 at 02:55, <ming.qian@oss.nxp.com> wrote:
>>
>> From: Ming Qian <ming.qian@oss.nxp.com>
>>
>> On the i.MX8MQ, we encountered some concurrency issues with H264 and HEVC
>> decoding.
>>
>> There are two main reasons:
>> 1. The vpu blk-ctrl don't have separate reset and clock enable bits.
>> 2. The g1 VPU and g2 VPU cannot decode simultaneously.
>>
>> We attempted to make corresponding fix to address these two issues.
>>
>> Ming Qian (2):
>>    pmdomain: imx8m-blk-ctrl: Remove separate rst and clk mask for 8mq vpu
>>    media: verisilicon: Avoid G2 bus error while decoding H.264 and HEVC
>>
>> Nicolas Dufresne (1):
>>    media: v4l2-mem2mem: Add a kref to the v4l2_m2m_dev structure
>>
>>   drivers/media/platform/verisilicon/hantro.h   |  2 +
>>   .../media/platform/verisilicon/hantro_drv.c   | 42 +++++++++++++++++--
>>   .../media/platform/verisilicon/imx8m_vpu_hw.c |  8 ++++
>>   drivers/media/v4l2-core/v4l2-mem2mem.c        | 23 ++++++++++
>>   drivers/pmdomain/imx/imx8m-blk-ctrl.c         | 11 +++--
>>   include/media/v4l2-mem2mem.h                  | 21 ++++++++++
>>   6 files changed, 100 insertions(+), 7 deletions(-)
>>
> 
> Can I pick the pmdomain patch separately from the others? Or does this
> need to go together?
> 
> Kind regards
> Uffe

I think you can pick the pmdomain patch separately.

Regards,
Ming


