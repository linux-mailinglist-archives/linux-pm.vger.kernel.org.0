Return-Path: <linux-pm+bounces-21761-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 541C7A30036
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 02:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B3E3A4928
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 01:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AEF1E885C;
	Tue, 11 Feb 2025 01:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="NmT4QGhA"
X-Original-To: linux-pm@vger.kernel.org
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011029.outbound.protection.outlook.com [52.103.68.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BE91E572F;
	Tue, 11 Feb 2025 01:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739237414; cv=fail; b=t7ZS6eio2qxC1X8qwN8qXVHwVrONPTPXnY3Oei3Yi1dil+p6kGGzxUjotBpLbbB1wlW4nE3I9OqKHoEKEK/vdwnNqdUJEyjssm56vSsIPDl0QwYXG4xIGyTILerm+WVbn/IBPrHu+g95SHfCsqTkts/2Z98wU16OP+DUoEISw2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739237414; c=relaxed/simple;
	bh=WY7u6t/DY+V3K67xrafKLmcznkOapeeAyZEfOKnnO3E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sjfMSVc3BgJHT+5v1TUQt4sYymY+tO/tsKWVqpl1BTcTWox90lKwX+jF8EOY1+btC7jfXu14F0d2ZC9w3rkIdtNIcXJSQM0HpVfAuUVVuP6rWs4Vb3QoM9VPZNoqqTnFi3iR8HXdjDFK/kO5cxO0Rbk0Yvtd2zc9w7CtN3pXPAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=NmT4QGhA; arc=fail smtp.client-ip=52.103.68.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SeAQMVkYZQHLtkqxUQ49nI9NEsZWdlBYvJ9o3wMMPyg2FzvBp21DC6ViRWhKczfbpejgOaDStr6xIdOs55revMJasPqIPjmkx1ffwj775p95rH0bGW81PgMjyGDtDTRhbr2go4GKQ/dIhhq6Jv2od3k2iVem1JLBy3TGmknW3fpiNCxp9oqFAQPwxxgPOBiq1bId/PlxAD6vDpD5HetnFmh/7ve4o57R3s2JYZQvwFDo1UYXs3kZLbFU+i0Ok5zrwyK78Mvx2FipioHMSZDzs67OOufD+TlGHxge5n7y1Vr/a8QK8Ub4cNWcH3yJt6rRd9Aha8ovlUp0KGMUDHXGwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGqzrpCYgtaYa8fFCIvKIB03rv8ZY/X5LW8UI/g+3v8=;
 b=g9hhF8wJ1n0ymitI5LYRCslt02jE2O1ExWvM1txudT3Um1P04Hbc6XuwlgPCqe7KUc5yzUWjA7LiVT2Miknh0WrHJiaKuMrw36kVoy7Q+pSf0tdYhARRcQJSn/h2IIU0t7+IXwaa0VlwBVKjMHpzzrt9PEq3dhAxq4dTi709bky1Asu/2uKAmfjpCHAwCUcYvwZXgxZaJEXEovlHvmsJy8XQ6Ungt4GQS/zLrMTjzZfMy+5w2Kwc1AyQspibRbpqVyKs+ROQtMeEi3jNIWIwU3dknJCQLfK8X8ECnMCpMUU3MzLX7MwvJ7SSk2BaVoAccZbNPqoy449lQENhPTvGbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGqzrpCYgtaYa8fFCIvKIB03rv8ZY/X5LW8UI/g+3v8=;
 b=NmT4QGhAiyj4lmIzPfcADj0WE/7v2njPxThY48Ncu2QDi+C7tCGDO+pVMTc0F1VnAue2i5RDM3Lpgnv2QNi82EB8gRR+BHoclKYwHviahqjgX5DSQDOy1WI/ujpduHdOgLEjodtAar3353y36NLJ5o6sDm8cXOhGhfv/WVeHlEx58H3/EMfxt13TQ3G2XYmGAXwswe6wYp4y+7VQnPGOGAdQpxe8Zs/fkgLS9M2HZw164ghhdjRvdKwj/UNaX5EOPVgq+HUKd0FJA4RZD8cmCU/OgT+w8f2jPxtIdxv/UUqnvt1jDxZjz/UhVT6Gq870NZ03EsblHndvfbmpcSjokA==
Received: from BMXPR01MB2440.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:3a::19)
 by PN0PR01MB5524.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:69::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 01:30:02 +0000
Received: from BMXPR01MB2440.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::2148:4778:79a3:ba71]) by BMXPR01MB2440.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::2148:4778:79a3:ba71%7]) with mapi id 15.20.8422.012; Tue, 11 Feb 2025
 01:30:02 +0000
Message-ID:
 <BMXPR01MB24401E6557682364D653A160FEFD2@BMXPR01MB2440.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 11 Feb 2025 09:29:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] dt-bindings: soc: sophgo: Move SoCs/boards from
 riscv into soc, add SG2000
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>, soc@lists.linux.dev
Cc: Jisheng Zhang <jszhang@kernel.org>, Chao Wei <chao.wei@sophgo.com>,
 Inochi Amaoto <inochiama@outlook.com>, linux-pm@vger.kernel.org,
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
 Haylen Chu <heylenay@outlook.com>, linux-arm-kernel@lists.infradead.org,
 Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
References: <20250210220951.1248533-1-alexander.sverdlin@gmail.com>
 <20250210220951.1248533-3-alexander.sverdlin@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250210220951.1248533-3-alexander.sverdlin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:195::19) To BMXPR01MB2440.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:3a::19)
X-Microsoft-Original-Message-ID:
 <c9c70f67-6358-4640-995b-70ed5b54cd98@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BMXPR01MB2440:EE_|PN0PR01MB5524:EE_
X-MS-Office365-Filtering-Correlation-Id: 80f49b43-2820-46d9-025b-08dd4a3b9ac1
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|6090799003|15080799006|19110799003|5072599009|461199028|7092599003|3412199025|440099028|10035399004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnZTZ0NBZWt0NGVYNHRVc09RZUI0ZXdGblNRcHRpTy92ekFoZTZVenlMajZ1?=
 =?utf-8?B?STJrTXljSU5nM1N3eEQ5MmtuSFlseGcydmJWL1JyOHVKWFUweTFER0tWTzdh?=
 =?utf-8?B?YjhFOWhZRjUvamNRVkhZd1V4dEVVSGFCY3g1WW50U1hxcnlMMXBwS0ZXSFgv?=
 =?utf-8?B?VzZOTWVXQnRmaVRya3hBSFdnWUowTWV6MDZrb21sS1g5OU53YVI4WEVFQXVi?=
 =?utf-8?B?OGtvVExzNXBYckdDMmJ1dmhWQ0FRL01ZdCtrbmRac0tscXdpeGxucTJlcStT?=
 =?utf-8?B?dDFUV3Z0VThhc2N0QVlQUURiZHg1MzBnMHE0MnB0T1RKdHFZS0l4amJjK1pL?=
 =?utf-8?B?bnVWZzZHQmxPNWovTW92dnBTTDJ3ZFBsNDBOSmYxWTQvVDU3OFlsSGoyT3hU?=
 =?utf-8?B?ZkY2alVJSHBWMUlUaTdoNzAwcG42Mmh5QmRuTWpJbkRmWjh6VzdFeXZGLzht?=
 =?utf-8?B?YTdxeFBwT29PdEZUQmsxb3haOTROV0VObEFjYVh0dXNuYlA4MmcxL05jVHJy?=
 =?utf-8?B?OEI1a2MrTkNRelEvUUt4bm9GajlpWU9EaVVSRVB3K0pFM3lJYWUrRlh1Q05v?=
 =?utf-8?B?MnN5UkUxVkZvaHZqSHlZTlpjeThvYmZRTmlZanc0Z0MwcmlrWTFMa21aL2N6?=
 =?utf-8?B?RnJLYWhSaTNJNlFPajZVMlFNUzYzMTFCRzlBVmVseHEvcWpUcGRGK2UzTnAw?=
 =?utf-8?B?MzFRQUtBNFN2ZnpML0FsNjZseVhmWWpGTjlqVmtQajZPOTY2RGdEL2hiWlhC?=
 =?utf-8?B?THQ2UmlqazlCWWpJVW52MGNpbHJYL0FkaUh2VUFLbkpFVnk5QnhFUlk1bWwv?=
 =?utf-8?B?clUwNE05aFRWclVWeHg4b2RnTEphbFNqdGxFTEFBTkZZU2x1LytpWGdwVFV0?=
 =?utf-8?B?ODdJdTFIWklyejZVMmkwcktSbE1uOWhpNEw5SUJia0hHSnZhZXZNd0R2OHBW?=
 =?utf-8?B?WDNydStaSnNFZ2FacVoySVJDY3dCYlQ5SUlkZ1NQMWlsVkNTaTNhMlcvbk11?=
 =?utf-8?B?SWN3bXRIU2VnUHgzMTNrTUFiWWs2Y0hYNFhTeDg3dVZDV0tOMTY1NzBwWFA5?=
 =?utf-8?B?OEVjTC9yZ0tFVC9XK1FGQ2NPZlFLdHlSV0M0UTBQbXpTaXYvb3RhbEEvMmIy?=
 =?utf-8?B?WHJWbytxa2N3YlpZSkpGRDgydzlrZWpRNlNBSTkwRzBKL2JnY0FPdUhYV1Qr?=
 =?utf-8?B?Wmg4Q3d0SGxXZFpZMitSZlZqRGZaeWNrTms4U0hUT2tTS0JXcHFZTjgxSnFx?=
 =?utf-8?B?RWZHWFQwTmVUNU9KVmZQcm9RbWtrT2xzUXdxSWVOY0pBOXV3U1Rsc3RDSUhO?=
 =?utf-8?B?b29hV2tDSDdyM2NORWdxQ1N1TW9SV3VHSi9NOU52VjZXWEVRWkt1Szd5dHNC?=
 =?utf-8?B?bE9DN09oMFpRRlVnc0RuT3VUQUR6anVBSWZ3VVZ4aHhLQzJxdFF2VUNpak1t?=
 =?utf-8?B?SVY1S0JwbTdxaGF2WU9KU1IwbzE1QXNEMmFTT2dpZ3BJaDhmOUJacDNJTUVO?=
 =?utf-8?B?NTZqRTljV0hkSmZuRG1hc0J3YzM1VmdvakNyNG1SNmNmcktxaGxpeHBka2k5?=
 =?utf-8?B?VXhBUT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V05ycm15MWR5Q0psdmJ6cmFNY2JkVEgyU0wrL2piMHdhMHZ0MmpZcHJJWmtI?=
 =?utf-8?B?WkVIaXl0djlqRm43RzVmcGNXM0lIZ3NXQWxZZjRwekgwc0FPOEtNQi9BOGRJ?=
 =?utf-8?B?ZWd2WmJ5akQyTXBjMWRWSkRDeWEwdnR4RzBIREFyaERhUmErTW5hR2dJelpm?=
 =?utf-8?B?bWZEeGlqWmVBODM5aUxJZEVlNXg3dkdPaWtyR05zWDVjRkZYQlo2a3FMU2RU?=
 =?utf-8?B?SXN1ZE94eC81S1FkTXVSQ0ZsU2NDWXpJQzA3RVVvVk5raEJpQ2VhajlFQzU2?=
 =?utf-8?B?bzBoVTFvOTUwQkJsU2s5UFVsMytNVlpEUXFCQm9OYXdYSXVGV3JhVXV4czMw?=
 =?utf-8?B?U1FNRWJ5M0w4ZnVWVG5FTWIzVU0vRjZJMm5QUWFNcnpUaTMrY0UvQ3FNVjVv?=
 =?utf-8?B?TE52WE5lWDFLNDdlanVSSVd3alNFQ0taUHl3akVyenlxdkN5QXpnbllTc2l4?=
 =?utf-8?B?T3A0WW85aWN6a0ZWdnUxck5Nby81MVZlUHZUaGQ2VHl5T3BHSmxiVHYvblky?=
 =?utf-8?B?cHdhYVM4bjhUZU9sQUljQm1kSGl1ZHJiNWlqWnVPYWtyaUczWURxWllvVzVI?=
 =?utf-8?B?a3NaMkpFMTAvd3k4WnlBNFVTbG1NVTY0R2NtQ1Y3N3AyWlZnSFFXUk1zMXZX?=
 =?utf-8?B?aURlejlEamRSMXpDbGJTck1HS2p2SHhqSVJJY2xZTjZRZ2dHSkpKaUFxVTJE?=
 =?utf-8?B?VWljVE5tTkVhRmVnbmdHdjBORFpuSzlZdGdydlY5d3A0dytoOFBJS3BYNDZi?=
 =?utf-8?B?azd6S0JzRlNtYitaak9oNUxmVyttUktRVkJ3eHlkOU45YzNIa2p1SXUrWmxu?=
 =?utf-8?B?NTZrOWRhb0xucmhkaTBjRUE0ZExIZ24wc29hV2w3ekNSQS94UlRTSmRuanpE?=
 =?utf-8?B?dTV1cmdpV1F2K1BKY0RrYkxseUlVRmZvQnlVZnpQanBrc09uVnFaNXJ3Yytu?=
 =?utf-8?B?WnE4WjVPdjZhdjV3ajViZHI2WmZNL1BDa3BSU0ZCRDM3WWVvU2doK0IzR0py?=
 =?utf-8?B?YXJNcHVrcFpYYWhmQzZaQzBJem9oVGpDUXlTZUpHaGU1Mk1PRytvVi9HRkI3?=
 =?utf-8?B?aERGcUxxdHA3emZ0a0xsZmovTGdENWg0MlQ3YTJYL2d4MGlQVFdXZm84L3hl?=
 =?utf-8?B?R1lqSEVmakl6SC9rdVpkWjcxam5RVlhqdGtHRmtNdTNBQ3BWN3NiU2w2OVVh?=
 =?utf-8?B?clVBRk5TYkJoSXVJSTJSdGIyUitMc0Q5ME9qV1FyeVBMb0FCUW03V2cvQ3hR?=
 =?utf-8?B?bEUxTE1pU3V1a2tRUVpBQ2dyNjdWb1FjWFpKa3VibTREZy9uU0g2R2RmU3Zx?=
 =?utf-8?B?OWFwRDBBdHJIV1RNb05kRnNCaUJ5Mnk5M2JWSkUxY3Z1L0hEZi85VDF2K05k?=
 =?utf-8?B?K2FiRW5SM0w3dGM0UXBtbCsyRklTMTVuU3EyemxyN2JoRUdMTE5BcjNjc1I5?=
 =?utf-8?B?TnJNRXBxczRsS3lQZ1pVSGZwMUlCMXJSQmdxbEp5RUkwWGJXSDFpQVVlNStx?=
 =?utf-8?B?S2ZWMFVZTmFSMjBCcWhvVThuSEVSeVEwWFErNUJ3ZlBXSGJhQ0RwSVVPK0xn?=
 =?utf-8?B?dHJ0ZG10OVhLcm0zcmpRQVR0NFpjSFE5cUFaVFNieGFRNStxblM1eFJMYWRy?=
 =?utf-8?B?K282V3pENnpwRTVCOGdKdTBWcUdnVlNlbVBZY0Q3THl0bXNlNzJOS3FoMktq?=
 =?utf-8?B?MWVncHp5OUpNYjhOVGNyTUp4ZFhGTTlkSmhUY0wvdlI3ai8wcXdaN3Rta2da?=
 =?utf-8?Q?d1T7UrBuql3gaa0h5bTpvAkKZPwo2UxvpLs8szh?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f49b43-2820-46d9-025b-08dd4a3b9ac1
X-MS-Exchange-CrossTenant-AuthSource: BMXPR01MB2440.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 01:30:01.9108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB5524


On 2025/2/11 6:09, Alexander Sverdlin wrote:
> Move sophgo.yaml from riscv into soc/sophgo so that it can be shared for
> all SoCs containing ARM cores as well. This already applies to SG2002.
>
> Add SG2000 SoC, Milk-V Duo Module 01 and Milk-V Module 01 EVB.
>
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>   .../devicetree/bindings/{riscv => soc/sophgo}/sophgo.yaml  | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>   rename Documentation/devicetree/bindings/{riscv => soc/sophgo}/sophgo.yaml (80%)
>
> diff --git a/Documentation/devicetree/bindings/riscv/sophgo.yaml b/Documentation/devicetree/bindings/soc/sophgo/sophgo.yaml
> similarity index 80%
> rename from Documentation/devicetree/bindings/riscv/sophgo.yaml
> rename to Documentation/devicetree/bindings/soc/sophgo/sophgo.yaml
> index a14cb10ff3f0..5d73d0ccc547 100644
> --- a/Documentation/devicetree/bindings/riscv/sophgo.yaml
> +++ b/Documentation/devicetree/bindings/soc/sophgo/sophgo.yaml
> @@ -1,7 +1,7 @@
>   # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>   %YAML 1.2
>   ---
> -$id: http://devicetree.org/schemas/riscv/sophgo.yaml#
> +$id: http://devicetree.org/schemas/soc/sophgo/sophgo.yaml#
>   $schema: http://devicetree.org/meta-schemas/core.yaml#
>   
>   title: Sophgo SoC-based boards
> @@ -26,6 +26,11 @@ properties:
>             - enum:
>                 - sophgo,huashan-pi
>             - const: sophgo,cv1812h
> +      - items:
> +          - enum:
> +              - milkv,duo-module-01-evb
> +          - const: milkv,duo-module-01
> +          - const: sophgo,sg2000
>         - items:
>             - enum:
>                 - sipeed,licheerv-nano-b

