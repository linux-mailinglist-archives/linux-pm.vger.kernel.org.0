Return-Path: <linux-pm+bounces-42880-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HnsFJpTl2kzxAIAu9opvQ
	(envelope-from <linux-pm+bounces-42880-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 19:16:58 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AAC161908
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 19:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0819301CCF5
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 18:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEAD353EE9;
	Thu, 19 Feb 2026 18:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kO1phRyI"
X-Original-To: linux-pm@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012052.outbound.protection.outlook.com [40.93.195.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC132353EEF;
	Thu, 19 Feb 2026 18:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771524871; cv=fail; b=XoLz8hvjjx1ILpOlFerNQ0dD4pnFeGzWHAv+GAitQhBMy2vWXkuEGDKmY93gusgSCbeUaxUNJuksO9pR9sJHCswCWrijsu33/uVdoanyAE9grXJXXMxrEyAF5BW9GyIicW6wY7uWZISjUE3bbMu+ZpFlCYAp4CZqQh/3z0DzSRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771524871; c=relaxed/simple;
	bh=1glAql7vKIJM7kgECxru00kvtA5YP9doTrmkQ4wLCAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UwGNsN2ZF1qhn8mo5s766pmCT1sANgMtPmmOn0o6J1hC/hLZOiSBNIN4h1y4TZ+krfTQPpdGeO9mzOX93Y4b0ZiOc3DEmwGt8Ql4NpPP0s0G5cNddtNjcSszgKAhE9nPiVF/TX7faqrdGKLSQ/hXO0wWUWZ4tOMYsaA3S6VXMnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kO1phRyI; arc=fail smtp.client-ip=40.93.195.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NbC4gcexWYlx4RrKA/UZGvyLHZe7JYnkzSZaNJmVbejjdam6dAtJf1fl7iNr0k9opMZUedwAWH8/4ELEyDTrY5mmtDJgBXDKf0mfHunn/n9xbgnp90jkNaoyMic8HGDpFAichTWe/3atF8yRZ+jV1Cv/28YMYgwpgjluEOC55s9yw3jLmpBE39/XDL6l5ewn2CSkTGzDygk6faIg170WJapvBO6DF8IvLiR+AuOJOtPajjXNt3Ph47bb26d/xE3d53h9F4+oClbBiBWyoz0E6BJtDoAFwftV3mETJ5nbhBcGyi7nHX0E2Yp7wmdMiH5DiiYvixj0C+RNIcXK1rmAvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8BmDy0gTyR+JGXK54e1ppRP+kTpEMAoYKTdyk5aHfg=;
 b=FWN1bF48UAcyv2fuLcVrp/eY9/eIQvSrH5KzLTIKOsDJ2rFu3SNgVj/tRSZoZsDe6TS47TiC7l60YeqkrR/n+OVw88MpVYg/T+UcQPf/Rook5oH4/gaUE1+GZj/wrLSA4OpxZhIF3srrNTi8DPkt+TAac4eTqpHfaiRn/vCxjM90dkePTK40GWitx8cu0R9oUW7bPNM9qOn/DSx34ldpSyjmPgCBW6NMrwqwuOAcFqi/g/D0cTbv7TDU1GSx6QkmQMgfqLFebbP8iIvvtcYJG1zIESM8E44FxOe13jbreKUqP9cbebsPtgBZ1uX3F++odrZ3gxhGv5ZHIpL6hPzi1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8BmDy0gTyR+JGXK54e1ppRP+kTpEMAoYKTdyk5aHfg=;
 b=kO1phRyIzIAj6zLhZXIah5ZRaVnbussAlXZ3vpBExaZUBqeYbJMgvvzHVl6KekkNeh7aRb9vPw+eumQ4qnQlp63gSzKkVNverS5tvgIO2dO9wrTDqy8ALjmHklwVr/xgIlnRp7qCw7HJr9AvGmIKHOXYU4zHCT+Z/y4+ApTCrTjEwjYnPY7BlEQqT3PA4PdCVYVjt7FnuYEAwbRYUtwTlCKSiNdvyfvZM9fnUQNkZK3lhZbqhWG3WKa/ayXRKz+LpE1PKqqCH/0ASb3Y2pGf/39GZCHSr7foOFysA27kUO3Ewe6NsE1zA5xb06p3YKW9vUjcyXwR0K8FcB0wwNV2Tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by IA0PR12MB7674.namprd12.prod.outlook.com (2603:10b6:208:434::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Thu, 19 Feb
 2026 18:14:19 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 18:14:19 +0000
From: Yury Norov <ynorov@nvidia.com>
To: linux-kernel@vger.kernel.org,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	Antoine Tenart <atenart@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Eric Dumazet <edumazet@google.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Ingo Molnar <mingo@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Jerin Jacob <jerinj@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mike Leach <mike.leach@linaro.org>,
	Moritz Fischer <mdf@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Tom Rix <trix@redhat.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Yajun Deng <yajun.deng@linux.dev>,
	Yury Norov <yury.norov@gmail.com>,
	Zhang Rui <rui.zhang@intel.com>,
	hariprasad <hkelam@marvell.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-fpga@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	netdev@vger.kernel.org
Cc: Yury Norov <ynorov@nvidia.com>
Subject: [PATCH 04/12] lib/prime_numbers: drop temporary buffer in dump_primes()
Date: Thu, 19 Feb 2026 13:13:56 -0500
Message-ID: <20260219181407.290201-5-ynorov@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219181407.290201-1-ynorov@nvidia.com>
References: <20260219181407.290201-1-ynorov@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0352.namprd03.prod.outlook.com
 (2603:10b6:408:f6::27) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|IA0PR12MB7674:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f3c0ee3-c44b-4309-0e14-08de6fe2b332
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5j33hir8D1dJEfTmdXS5JnnvpnSkcD1tUJca8lIZoD4QoFjLiIym0q6xCt6o?=
 =?us-ascii?Q?oLRfLsAlMPbDOeVU8V6XVYSKDfRULssfn5XoHIrOx9v3s1GQ4Gcgrd+NuhSH?=
 =?us-ascii?Q?5LXJRCt4XHbj4QMDYETFF5FMEZxNz9NbYE303ecHjvB31G8jL30932xLowXf?=
 =?us-ascii?Q?Nh2CpCqjNmBVp5pDLpYtZsf4pQhx9YfZOxs1uJ3wIxvDCg8cYOrM1BAGY/TC?=
 =?us-ascii?Q?KlhxvJh5hEEMPuYRyFx3iyH86Nhl2XfU+iF6Y1PETUNnsWKIXJxOGdnyWzRt?=
 =?us-ascii?Q?XeB5qEQJGUuJGagZLMoYa3Ru3KAP44cREHkhiBC21kQfhw66QfmIfutSNoFO?=
 =?us-ascii?Q?xXDv9OueQ/cGC3D0lZ6Ca8sAFlpVp9fosEf3VlX9kXm/tTNZaBEfcNvV/MbV?=
 =?us-ascii?Q?wQOmPBavMwJH8m0P1293Xdkp8xVH4a563w/6IrblXJu1fxhuu0vlEoeQWpJ4?=
 =?us-ascii?Q?Gxznn04lJURZAH0WZnlyGqnm84R1wIjItTOObaPHu3OYTA1yORm0zsyaUjvV?=
 =?us-ascii?Q?RFMMIt1olq7M02rdXla9X2Qgrla3nfNWGUW9HVrNfi8rWnvOiEnXCNbXGbEw?=
 =?us-ascii?Q?TdBOL5BK7Q/qu80RuCFs7dR+XbXLTujrAEpP3DTR1mXHSZdBOOLkO5tb76wE?=
 =?us-ascii?Q?J3PssqsF0QuOvC4oU1Yx2TEDqUKZcydG/CMV51fwcmrWpfHxDmTCi4JqPa6p?=
 =?us-ascii?Q?AMGAosMgTWSA4KofgADCD5zUB7GthJRCrYo+SBKi+H9Wf2jpAl/S6nxiV+O/?=
 =?us-ascii?Q?U3fugE1a/xjG7ikkHgj9Yk/zdGIKeT/Qvz7TSk/IJ/sO1mxgfe/NdpeyqXN1?=
 =?us-ascii?Q?HCfvAHiHfXhCejrEN+Nn6h2N0PjZH3+Dyi46vnR7uQRU1Ie9OInlapa8wJua?=
 =?us-ascii?Q?m6lethv6FahHnn8cDA1ykgBJ+RmZr66UKYSfKxFZtV139op806I232GZfU0k?=
 =?us-ascii?Q?DadQTcKIb4EY1aub2uNZD5rsAsf9i2xalzBwKRtsJFv6u1xYI3KCLyRXArZ3?=
 =?us-ascii?Q?aTL8VHyucK2LZidhJE14h0dRR+pPtF45bHgpLLB0ahSruFoTMmk8W7eJ5AXN?=
 =?us-ascii?Q?J7UQjv97E3GB2UUz7ap/dYdp+l4THM864o6TXO0pnKU0o/AuksgqcOjD8ljQ?=
 =?us-ascii?Q?uoWceGv8oR2SQItmaxb2DZmV7q00AqXRAa95vuvRynA/6L7fcysaAy335yYd?=
 =?us-ascii?Q?SsE8T615xTx+ptSM6LI9IayUKlYjlhauDtR7mca/wYSBOfJbaaELHafM4ISs?=
 =?us-ascii?Q?OCeR5zc7vbfKewbWCxo1GHuHXwp+L/CaDplf4K61RG/1G6rWDqTD6hwXMzlJ?=
 =?us-ascii?Q?/BBZ6Z/vL90kUGRYOZc78SNW2SLDOMjTZxjcoR/TBrw7C321YUvp67+hVxNb?=
 =?us-ascii?Q?gR48X6JPYuHiP5amWCUbsUEO64ykoRxyElPA2KrNk4F5JEjfIHelUeODaMZ9?=
 =?us-ascii?Q?YSDjbJ9BsWb329ai/IURwnHg7Q5GhwUif0qAS2eO3UsD5nM8EtWhbqcwfSCq?=
 =?us-ascii?Q?0bVNX3SxXk15o33W6JuSTIKyZknVB3aqoriEF3XaxWudZaeysLljqm9dnruF?=
 =?us-ascii?Q?YUcdh9PzWSLzEQIGETz+ECjv+Jdi1Prym2MNpipvOQ7rsrMPFRiNv07DZRZK?=
 =?us-ascii?Q?VQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8mnS64xHvE9khaY08St69Y2i0oYcNb7F/1+/TPM2PyoKsvN6QqFZoyz2BWZX?=
 =?us-ascii?Q?Zqdb0PixRQvO/qCEtZ1pnGAttHsLO8prn0vH7TmYHq+iafCGIyVl7MALEoz/?=
 =?us-ascii?Q?2TeFflN3/vXi20SDTmtCRu0lqvlfVIDHiPMhre85+IvLgrXVVbgkJMAnVnCn?=
 =?us-ascii?Q?HdDFu0IEmumnib6aWtxsFzCxUs56MRPxtP+rmPde9+O9HMhop44HaVfIKd3r?=
 =?us-ascii?Q?FJsZE10rchRj1gyTQMvTyuuv5nGsJTymQMKEdOKgqtqTwFzVuzP/hVu2oYX5?=
 =?us-ascii?Q?o1OcpZ+KpopNEP6VfJ5XvU2PUMmOHnsEXhmFp6Vd91eRgUWDvBM0iUPN0Knu?=
 =?us-ascii?Q?bqH2wl/dRHOzhKeKhBWAkmRZlmH+9Gf/dfhye9WeEXwFrajAA7CankTXextu?=
 =?us-ascii?Q?fLuDkWKSVo5cfeez4uP+rlmlNthZE6vXvi5guoX6Y0l5V1UVDN1mz83uNtaN?=
 =?us-ascii?Q?QEgxnnX2iiXyZ/GEGQS7juXwcc1Jjbgc5DFfZWsMxETaMPnAq0I01Ps4Cssc?=
 =?us-ascii?Q?1WPtUXbZUw7cRhisHTGSmtSQn0/yNh0QjCcetsdM0OXlG3QjTiZwdlL6DHdC?=
 =?us-ascii?Q?OqvUSOPuXfbRdEXueLrWp1GsQCR1X4NbmqxaX1ydt1xmHABwVN0MXVxzYE3l?=
 =?us-ascii?Q?NzaliZqbhdQNKm5qPSp9t0g3PmlEj43uld4qx/tQiLK55vG4P5dIeH5PY9AB?=
 =?us-ascii?Q?s4zsJjy7fxpxM63jRG6A4v5eZk9s8eevgxVaby9GmixRM6DwX8NfnoBAvdt0?=
 =?us-ascii?Q?I28meNQ9SqPktxkT99/derWVGQdKUVFmUVLXSbcUH/Wvm2ieKUiyRSHzSjNq?=
 =?us-ascii?Q?+bakro32YXug0EoOQqcf4lQkrzl//odJDzcPoOpVo/Un0Z7LZrekc8dSjTBW?=
 =?us-ascii?Q?WwA6CA3fCIO6HsmQp2aZpndHHjDL6zxvAgSHHWHG6jPj02cHQmJkFucPiI3F?=
 =?us-ascii?Q?9pf/CCgPTdQYf6UxgwPdGV/B0zkx39zbjT3yMuG/VBis82oAkRaugcEo5esB?=
 =?us-ascii?Q?/6FLGeFqFdJMrIPdwTYiuvrMmI5DqBWBfeAw7HsmQGUZonZe0OemK8qwQwDi?=
 =?us-ascii?Q?hSHt389F2EGZSHnXAkJ6h7CTZwiScW3q8wlUUyHi/VJNLbD/+qL411+F9cID?=
 =?us-ascii?Q?MtX/dwGX5ENCO6uaeXzR0i6b64DW0W6j8qy7Py4EoRGDFabmS8SXcJe2fEg4?=
 =?us-ascii?Q?WYwPXIF7dx6UPqLQKxW+gVr4Ew3thwP4P2CvtZq6zSTlOK5MQHY0aIDn0AtW?=
 =?us-ascii?Q?S2Mu4imEiG9BPVK4KqDo+ChdMBGGv6csb4LSKBikeShrfrZ/U1WO7dNkXvVK?=
 =?us-ascii?Q?L2TuDC6xnY4md8pfNNKPJ8Za/mMihY/hpXfd6EY6wnUTYV0OMAejwNAbh3yF?=
 =?us-ascii?Q?PljLUOZhzs4Nxab0I8UpCdjBQIw8VQsb6v78fmTFnJtaP1jY6w+bEgoRU6pT?=
 =?us-ascii?Q?8CAWWQwJF6xOLAfXSN1oyrfgV3ErSc4r2hQiTN0pR89Aglzu0KLxK1FrEu2t?=
 =?us-ascii?Q?uwLr2XeO3hI19qbaWs0ubXXCODaklnk+aF50zaR13xbMm1GzVRZjNsN1+3UX?=
 =?us-ascii?Q?v2LDn/2aEOOtUna2UTZhkhc1zQiCZ+Rnr/nZjGqvhEG0nkdYzMqUJFTQCXT6?=
 =?us-ascii?Q?7tjgRh2/Px7wYWZmu7vFtvkbPTAweS38h/bxeI26lQC6DAHRB9WWjiUjFkxm?=
 =?us-ascii?Q?PQEmPYwJwRGZK5OMT0jvKwitaAqb6t5B9cZRSgtJ/KUuZTAHJXmQyI0Vg+Zl?=
 =?us-ascii?Q?iQHK1qZVsONOINqDmqBhbrAPmFL8kANPrpTZDepdkQlRNe1wW2zk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f3c0ee3-c44b-4309-0e14-08de6fe2b332
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 18:14:19.4675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uUvmzCDfyWzIRpc4i6UWdFuH/jYFmfvwJWk5klnKrDyOFsvZQhkfXSjlaSub/b/DGn3GHNVQpmH6Jot6ngO+4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7674
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,davemloft.net,infradead.org,linux.intel.com,lunn.ch,linux-foundation.org,linaro.org,google.com,marvell.com,arm.com,linux.ibm.com,ellerman.id.au,gmail.com,redhat.com,rasmusvillemoes.dk,fomichev.me,intel.com,linux.dev,lists.linaro.org,lists.infradead.org,lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[44];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42880-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: A7AAC161908
X-Rspamd-Action: no action

The function uses temporary buffer to convert primes bitmap into
human readable format. Switch to using kunit_info("%*pbl")", and
drop the buffer.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 lib/math/tests/prime_numbers_kunit.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/math/tests/prime_numbers_kunit.c b/lib/math/tests/prime_numbers_kunit.c
index 2f1643208c66..55ac160c6dfa 100644
--- a/lib/math/tests/prime_numbers_kunit.c
+++ b/lib/math/tests/prime_numbers_kunit.c
@@ -8,12 +8,10 @@
 
 static void dump_primes(void *ctx, const struct primes *p)
 {
-	static char buf[PAGE_SIZE];
 	struct kunit_suite *suite = ctx;
 
-	bitmap_print_to_pagebuf(true, buf, p->primes, p->sz);
-	kunit_info(suite, "primes.{last=%lu, .sz=%lu, .primes[]=...x%lx} = %s",
-		   p->last, p->sz, p->primes[BITS_TO_LONGS(p->sz) - 1], buf);
+	kunit_info(suite, "primes.{last=%lu, .sz=%lu, .primes[]=...x%lx} = %*pbl",
+		   p->last, p->sz, p->primes[BITS_TO_LONGS(p->sz) - 1], (int)p->sz, p->primes);
 }
 
 static void prime_numbers_test(struct kunit *test)
-- 
2.43.0


