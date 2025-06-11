Return-Path: <linux-pm+bounces-28449-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CD2AD4D7E
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 09:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B35E189F266
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 07:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A441226CE4;
	Wed, 11 Jun 2025 07:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="oavYBMyB"
X-Original-To: linux-pm@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012058.outbound.protection.outlook.com [52.101.71.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE12D23537B;
	Wed, 11 Jun 2025 07:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749628473; cv=fail; b=PqO3zt35+n++CayNiHaAyIur5e3xAv5txCXJVUhNY7sPqAJJrZId4Srfy0xBbfKcnWQ+Bg2TKJVRJyAHYTKgRe8JOsr4RjP1Zl0szlBW44FfgmOEoRCrzvm0Czk3m1RNBH3XjPeLT9REgTiXp6V0IlUZnYcZJ+PcJRdZFtkwni0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749628473; c=relaxed/simple;
	bh=VYSze+gZm1t1lz+k/0zoUZsqxDtYJVhc1kvQV2TKFGo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jG18GkDIG9TdOZ6PMGFq4LSbi1R+ZKCOCqhc2cCWlwqT9KrcISx8RiE3VgXAdv3EMMOgGc3mDbiywxkhu8TA0EKxnIaxLsvO4Q82ckqdSnYMxa1SfqOeYxiiiZnH9s7FkEJGbM0Ol/Eayq3enQzbo2ihTAeRJbGj4Flmd/xAHiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=oavYBMyB; arc=fail smtp.client-ip=52.101.71.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhQSB6zV53K4Sr14R19nHhZJ3HgDPULVVIMd6DkpLDwoFJqW8lEM3vKWCxzafema4SYnAI9oiVuxo6AP0CUG/3Ef4TKX2rSKKZ9100cZYYrzE3j0Q5B7M9KjeqJPyKRKnvfN2KaDRnLkZYZUl70YIpjXQJMGqe3DsBG6N2rxhoxoetndXM2jFv14kuXmUttdCpUqqY4jBxjGYAwIy+RF7tRxSZSYhA0TLrdT6PrLwMBwGchDShmrbH0+Jhyh8hjrW92XACTf+IRJokkumCnu7M0RQgRHenBkRnDWDjwfFvOTAAhtSImIdan2kDmrzi0m+tTPPxQMGrzElMAC1kyBkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbPiJ1wqEky2QTgUw1jT1WjQfcAECFhC8U2AkOS4rTE=;
 b=jVG2pibvBe2YdSnIO3aiNNnkBnzbsoaFHrMso0Ik0hbRdEQ8IM/vODH/8jqkOLRfhUSzQ5tnQEmLhu9J2lGrzNTMR24fi4IoH5qDnia/qwLePFnUEfrlN/Ub74KYU6nvoJO9OGrDxV5RGy1Z9dMBj9SQWvj2OI4VdIJS6b/luufn7VVgwWkbREtzzNsC4ag53PHiLkL4YH2JhBUY3lAvxDWVTxDH++SPGzonkwNM9VTpYTs9x89iT6WpLiwtaTV16zfidlr0OBRR/4TQZFUHAyS5hpJ8iQ0ewPKWPs/pWe4Tv/cOF9UMKUAIKlCYF6KWUaUdPRNHooZXKUh02pD69A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbPiJ1wqEky2QTgUw1jT1WjQfcAECFhC8U2AkOS4rTE=;
 b=oavYBMyBtLgk6aU1DCLonZNppxdaAJw7NCT8dY7yMCPA+thX4Zv3E1gMCKwsfYiTuRAKTYaGaLZYX/Wh+ip31HMJjxnwA9ZlXZtLdRg0NuKoS9HlP/iNdBDRkcokt0xOcuUzX1EjONoW/qVlfzXvRpN+5fPucKliERqBLbgoVGMDLDGGfO/IZ03sLBPLyqrrfICgJVn1aVBWDbE6XFFHQSdWz2r3DVNo8MvZSTwxUYz5iU9jWAAt6lqp7HhSA/0ifDC+jIdnoJGyu9W2cvgYKZbNz21bR0uAaAyiakPQAt4nRIIc3o6XLUq0crE1RsVzoiatYK1+MeLodRJD4FUfYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB8346.eurprd04.prod.outlook.com (2603:10a6:10:24d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Wed, 11 Jun
 2025 07:54:28 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%3]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 07:54:28 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 11 Jun 2025 15:52:43 +0800
Subject: [PATCH 1/3] firmware: arm_scmi: Fix typo for scmi_perf_proto_ops
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-scmi-perf-v1-1-df2b548ba77c@nxp.com>
References: <20250611-scmi-perf-v1-0-df2b548ba77c@nxp.com>
In-Reply-To: <20250611-scmi-perf-v1-0-df2b548ba77c@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749628374; l=897;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=hvTZkR9p/9OYtCwb4CaVayblOEF9jxPS+t7PMwk8Ul0=;
 b=03Gu7LHSSaWyKzMTaKkELlNCQmmPBDQtE8eb/ofnpBAUcWYfgNtFTi1EW6uKMPc2u32kS4FJz
 2MTb6GP0TG2AZ2ifKvbuEpA/P0Zx5x+nq43hNQTICQ3UoK4Ec3U+OQs
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR04CA0209.apcprd04.prod.outlook.com
 (2603:1096:4:187::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB9PR04MB8346:EE_
X-MS-Office365-Filtering-Correlation-Id: 65c06ad5-5261-4e73-652d-08dda8bd3104
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGQ2MVJyQzVnbTZrM2pQK0tHUDArQXRoQVRwZ25NdlB3Q2grMVRmWmMzc3B6?=
 =?utf-8?B?dGE2Yjhqb1JkZlhWa3lMQXFzOFF3cnJtRks3bWp3OHl6OElwUm52cGJlOGxO?=
 =?utf-8?B?NVJYYlNYUE0waFUwVitML0h2bW05Z1NNT0VmR3JvUFFEclNicWJoQm00eERG?=
 =?utf-8?B?WWdLa1FaV1o0VTRVU3plTGJCbWwvY0w3RXF3VElzVVFQblFRS3NxSEZZYnpY?=
 =?utf-8?B?Y3o0RnJ3R1RqazdwOGl2Z1lBdHUvcjA1Szk0YjVwOWtGQ25KdWxEd2tNR09B?=
 =?utf-8?B?L0lXQ0ZNYWlyZVVRZGdia3pRMldCVGdneXhCcGpSdlh6NnQvdXpyMUFWWFcx?=
 =?utf-8?B?NVRTdFh6eFJQamRVdU9WVGJMTGIzYWxqL1hnNnhTUlhKKzhzMUxVMGpGR0dw?=
 =?utf-8?B?ajdrZy9veGFpcC8xUGxxcjd3QXBydllvSWZ3UG5DOUNkUkhBaWlvNlJxNzZZ?=
 =?utf-8?B?RHVDTm00UnJ0YlYxOHZ0dVRDOW5GSi9Zd09vNVpKR1FWVFcvOSt5KzVMV21B?=
 =?utf-8?B?QVgxUFQ3NlN0RFh3NnUxR09CT3pwaXJEcXRycE56NlovSU9IWFY3K2dmMlpH?=
 =?utf-8?B?b3B4VFZka1ljUEhYdi9EWmlYME13bStyaTNVeEhIc0tFbVlld2c5RExoVDlv?=
 =?utf-8?B?RGZrRnVFTktNNjUrcDZFNWRHMGl6T1lIUDVQclhJVGhxN1E1VXBoY0pmZFdK?=
 =?utf-8?B?L1EzMGhpOGF1UUZublkyTWtQZTBCYWZKWW5NZTBmeVFQUkpFbXdxYWdFak92?=
 =?utf-8?B?U2V3ZjZESHVuSTUzYTZXVWZMRVVjYzdNOGYveC8vOFE4Tlp1K3dOUkt4WUV0?=
 =?utf-8?B?Vlc1Y1RPUWJGdThURVovT0ZnS0Yvdis1SmN5LzhWUnRQUVpqQmtGTTJ2TFZk?=
 =?utf-8?B?Um5LanNld3ppUzZpajlOeWtWaWdzSGpFUmE5bFhuS24wcld0SUl4a0VrQWRZ?=
 =?utf-8?B?ZVlzQW5nSWFNOVI5T3RIK2lWVTVpNzM3OEEvUFdzamRTd1FUYlBDcW41SjFn?=
 =?utf-8?B?cG1hT0o4WkJ3N25WMCs3ZFZON3lXd296bGtsZ0pEOHI1TzBENWxTQXdnRHZG?=
 =?utf-8?B?dlE3cHZRVDJmK3hFdnJjWE4wazNLaGljRXZrN0JCdkIrSG1kK1lhblZNb0lt?=
 =?utf-8?B?R2pubnJDbElJQ2VnblhWS3ZnUVNyLzJGQmNTMjJBcDIxZm1DMjJBMHBYdzFM?=
 =?utf-8?B?K1FDZGl3OUMxNDA3NHRrczJ2NGJ0cnI0SzQ0aFhXZEtISUxuTWtKS3FYR0N4?=
 =?utf-8?B?a2tVQUtrMzZQVW52eTdrRWlzVGE1dGlWakpRNWh2UnFyaXY1a3lLT0FDUE5a?=
 =?utf-8?B?Wi8xa3R2ZFIxQ1pjQnc2bitjcjh4OENZOWFyekRTSk1hMjUyTTJZNFNCdUFF?=
 =?utf-8?B?U0kyWDk1V0JROUpxUFhCU0tPb2p6bWRSeFVHdGNBWXFtN09aejJGNnpFcEZ4?=
 =?utf-8?B?NUdrSUt5Qmp2Q1pSa0p4d2tWUFhjbjhnS1NwQmpZRGltT0FCczJJV21WSVdN?=
 =?utf-8?B?MW9WbDlJN0w5eWk5VkllN0hyKzVFVG5ZR0NZN0pTekpLRHZFVUc5ajNLemxG?=
 =?utf-8?B?UTZ6NFhOMngvanBYNG52c0w1aTlmU2tiblpuZ0ZITjAxeFdRRVBCcUx3Sk5J?=
 =?utf-8?B?MS9IZDJ1a3l0V0JSZDErajI3amZUelQ4cjJEOGRvbUt2VnpKRjdGcEx4c2tW?=
 =?utf-8?B?dnhvUUtuMUxpUUQvTHVRTlhIQXc1TExrd1AvN3ZxRHlxbUtiaDc2OFZkWWRG?=
 =?utf-8?B?Z2tNSXRndG1lWDYwVFoxcTBRSmNCMEZsOWNOL1lqZjF0UWhDOXBWaUg5aGNE?=
 =?utf-8?B?RGNuWFZRQ3UvVEJ4VHlxZHYrc2JZQUdUTXdYMVlIUDRhTmx4cVRJamFjZkNm?=
 =?utf-8?B?ekNaN1ptSThKMUwzWjV5NitaYy9hSWFraFdyOVcwalVFcVlHbHRHaE1UbE1O?=
 =?utf-8?B?RU9ESHBQTWtJOXNOb0RtUVV6UXV6dEwyd3AwRTRIQW9JZy9pL1VVcDI2NWkv?=
 =?utf-8?B?b29sbVVBRVJRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0dKbGtvcWY3bTF0Wk9PY3VmQVhLUll1MzloZzhGOWYwc2wxQnlCWmNjT2pB?=
 =?utf-8?B?bTh6eVI1SExqd3BCeE1UVzB5czhzaHBDbGtZSzdIRXZ1UlYzMTJ3TjZ3ZGc4?=
 =?utf-8?B?S215WDRQM25FSzlRdFFtWVlCa3g2dXRJbmpkR1JoUFpicUpmZ3l0UTVWblB6?=
 =?utf-8?B?M3JLOG5jZm5ESjZVMGUyR1kyME9KU3VSbkdwZlZYVTBCL2JCWHh3b1FhcW53?=
 =?utf-8?B?dEdHSmpFV3pEaHJRMGVFcTVROEUrMWd1RXNNNVo0WnBObnllS2xsUXdBUU56?=
 =?utf-8?B?T0dZNFhvSXAxZmQvSFhKcWJpd1JzYVFGWFozcmdwQVV0TWFSeTNLaFdPTjhQ?=
 =?utf-8?B?WjQvUmp2SEcvNVhLM0pzVVM3bWM1L2VxbXJHUExVZ0ppTWlaUTFrdGdCSHJq?=
 =?utf-8?B?NHRDdUtEOFNTZU5mZ3BMNWdYVUk5SFczcFFUak1yRmcyck1wSEMycy9BOTkz?=
 =?utf-8?B?bml3Z3RiaTdZMjFkREdlRGY4d0xUWXluQU1IQXN0NnhLaE9RNmtIcXlDWisx?=
 =?utf-8?B?VlEyRS9POWx5V2xBRFZvOEpabE8vM3I5MkpvWUdSNFFnTkhuVlE2TUoyMDRZ?=
 =?utf-8?B?V1pibzR1MDRwc2phSGdseG1IWklTUTlDOVpsTlNaRnpBS01YdzhlbFlOTVFQ?=
 =?utf-8?B?S25zbVFPMExwdW9aOEl0dUFjVG90elBvSzE4eFlNZXVzSWRRNStOSUVpS2Jh?=
 =?utf-8?B?aEUxaHZvdWI5Z1J5Z2hlNWh5RjhjSWVXa1BQemZ1U016ZU9MOE9nTGxFaUsz?=
 =?utf-8?B?S2gybW82SThwNVZiVnFkZkhrWVBQRmY4SUw1WS9iY0FFbXdwem1SQlpINkl0?=
 =?utf-8?B?aG84N3FiU0pqMHZrWDcvaEJ2ZHQ0RkdOeGVNZkpRQVRTTUhvSy9IODI1eGRB?=
 =?utf-8?B?TGx6aFA1bTg1Ty84enRuaWRPYmZ2VXFNWndLQXgwMnRLOXJHTis0aVB2UC9y?=
 =?utf-8?B?MjhMcjF6UGgyellKeCtrZ0lGWThCUDNDNWgxZFo5YTJPUkRXMjM3TTJMQUpG?=
 =?utf-8?B?YjFSNnhWRHE0ZWVmRVM5Z0ZzbTZqQitEcXVPd1N2RW96T3Fqd2VqTFhLWlp4?=
 =?utf-8?B?Q3RYR0UyaisrWjcrRHBLRmJGejhrYVc3K1pnYlBHQnZ3Nm5PYkVULzB6OURG?=
 =?utf-8?B?cnAzSG5WWnhTUkV2OHNmN0VXcVJQVUp1Z0FVRmVaT0hzeW5rK1JuQUNITVhN?=
 =?utf-8?B?bU9PL0o4SnorRk1SeHBic2o0aXY3eFhRWUM3OGFFYUI3cTF1bGN5M1FnbSs3?=
 =?utf-8?B?WUc0M2Z4Smthd3gzd09tVWtKaEcvUVJZOGtFSTNKRENpNnAyTk1uNGRxM1lQ?=
 =?utf-8?B?TWluY3paNU0yOFpUd1lLZ2VmbGcwbG5lZFpPTGh6ckxRTHpTbG45UlpZVlN0?=
 =?utf-8?B?Szk1RitwcGkzREs2ZnpTTzRTNFd5UW5nank0VmRvYndzQXNxckVxV0IrRytS?=
 =?utf-8?B?M1BTbHc3bFJGZFNPaWJuMWlFTzN5enpuWmd0bVJKdGoxV1p6ZU16cm8yb1FL?=
 =?utf-8?B?RTVOeVQ1OCtsQk1SSW9VOHZsK2VRZDZLa2NDbmlVNjBWU0x5ekJqUTN0QUZj?=
 =?utf-8?B?YzZJUTdZVVd5dGRvbnBubmxuSTc5akNLMUVSZVFpZ0FDN2s3QXBBVTVqcTRt?=
 =?utf-8?B?Rlk1NnZ5Um52OXBzTWxDUEVMUkNyb2JuUDNFaTBiM010em9aaDdCU2E1MXhX?=
 =?utf-8?B?Nk9vTDMvRWJQK00zSUFkalc5bWEwV3BGNTJqVFhCU1d5Szgwek4xVGlndm03?=
 =?utf-8?B?Kzh2Zi9Ba3BDV1hEeUhyUjVqaDhFcGxGc0hhMzhUR2l3YkFDT0xqTHJvdFdC?=
 =?utf-8?B?dFZZNXZlZk0yVHMvR25LR0h0akpBN2d6Qy9ZbU5aV1BCWDJ6TnJ0V0JzaFJm?=
 =?utf-8?B?VFlFbSs2U2M3WHRpajE1dTdBOXc4bkFyWENHZkwrcmdzbm5Oc29UbzNwS2xD?=
 =?utf-8?B?ZnducTVydmVJeCtET1ZUa2IyM3hCTXVXM00zQ2tQcmI1Y3lvd3NtL0JoNk1Q?=
 =?utf-8?B?ZFJSdWMxU25maDFBSzY3TUdDMUlKa2g0ZVR3NWovU2NYZkFHM2thN2d4d08v?=
 =?utf-8?B?NkxIR2toeFEwaVVBODFobWhycXNGRjlSR0hQTE5wbnJRU25WL0xCVm9VVkov?=
 =?utf-8?Q?8QWxWR4ecR6thSTF6NY7ooRdN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c06ad5-5261-4e73-652d-08dda8bd3104
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 07:54:28.2767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UtlHHXMwhINOFqyvxa6/GLBY+nwNceuFlxdyt7Y+2k6hemjYXqAwkGQGZq4QvpuOxBuvmtDaRX3UVGnRpb7b/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8346

From: Peng Fan <peng.fan@nxp.com>

The name is power_scale_get, not power_scale_mw_get, correct it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 include/linux/scmi_protocol.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 688466a0e816247d24704f7ba109667a14226b67..aafaac1496b06a6e4f0ca32eee58a9edf7d4a70f 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -153,7 +153,7 @@ struct scmi_perf_domain_info {
  *	for a given device
  * @fast_switch_rate_limit: gets the minimum time (us) required between
  *	successive fast_switching requests
- * @power_scale_mw_get: indicates if the power values provided are in milliWatts
+ * @power_scale_get: indicates if the power values provided are in milliWatts
  *	or in some other (abstract) scale
  */
 struct scmi_perf_proto_ops {

-- 
2.37.1


