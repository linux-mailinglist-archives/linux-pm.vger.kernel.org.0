Return-Path: <linux-pm+bounces-23907-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D1BA5D927
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 10:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 129C21737F3
	for <lists+linux-pm@lfdr.de>; Wed, 12 Mar 2025 09:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D9823A986;
	Wed, 12 Mar 2025 09:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FqzuokLZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2079.outbound.protection.outlook.com [40.107.20.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C981E238D2E;
	Wed, 12 Mar 2025 09:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741771216; cv=fail; b=e2d4j+GhlFJmJ96KF7EPwtx0m6NuNTKofM2IUsyNdaBsPa5x6pikLHzdono2PwgL3UGMiJaoBEjQ9cG1ZAhDF7aT+JVu9KhI+dLkDVp4xSJ46nO/BV1p5xVE4yMwQXOeHv1+OOLEmDT5acZaA9a6sHpdp3o8Nn9vL+ywVHP0j80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741771216; c=relaxed/simple;
	bh=BIgnfYeSvXLxJt0uugBUmQu5fRtwMabTeJ/w5riZMfg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=FRKNkTqCASYc71BhULjQXGcOInZ2nBlZQIFbgfzoljjX56hz5cFSQ3K6sSLX6vta5FmuACoLFEBnCx31Fs68m4TKO1+V9PSTtq3WsQ5YL4gdpno/5cx2oC2/shFhow5VHrN2mMzm3PB8h2EYFoo0pAJg1S0UAJuLDLi7obIiea0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FqzuokLZ; arc=fail smtp.client-ip=40.107.20.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DxLrcw8oc5KqyXspNY+JA0HFzGl/3SQdx3Sumg76/4mG0czUIDiVK7bcuvpkx1kPujNera5+jRL2PY4PrBolidn/zH0Ip5U+mh4k+Pi+j12HssXPFSy10g0DoxjYAopuRk+abcs328mcCEzt/p9hc0MbS5rhq4tLb7WswrV6roLtSImcuykfO/TaLQQMwMtL9JdCC5I++teaGrTpJSPf6FPa5NVqyIBl7HpL7vKoRkaQ07V5QFa2cerOkXhXIr0N39zkMOcWTVlRmjLclkqBJN0NUwoMy2pHw4dKto4JXYm9LXh9ofCv7UHHl/rbNAnDZL17Slo01PJ8JpXYRMGTNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7m/RmvonW0/ho4acCbYZQD9YSBX0lm9l6Kl70s4ud0w=;
 b=CPhrbjD/XX1xsRvvOy0thSvBzzjYNVPoAV+zJSH2GdshSjYmAHV8k1no+dNRAtPDFZ2urWEHXcNCAmjvAt5NXguvm5SQ0sdZUHWhfukAB7KRB5+FOC90NJ2ljCXP0n6KPxWnXqu4RjHaB0MIBZ39KlaX6wLKs7/CnlaJyAANe76Zm6MU2peYwAcwf+kPykK6unpQctdXB7p+Axopt4GxU84EPar9I7/TGs64XXkD0PXYGHWrofIJmjXyeR0fZv2EiaQUYOy97sYS1mjYK7UZTJL8Ons5c1MEZxmTQ9eAgz8BEXe4PauVc+10u4DurVM3ZTBIMAXwqZN1XHuCwJyRnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7m/RmvonW0/ho4acCbYZQD9YSBX0lm9l6Kl70s4ud0w=;
 b=FqzuokLZfseD3INPLfzdQD2xOdDXMjOJM+Wrzt1tnxuOMLPjmOGIv7tmJPwmrDfoAHSPshk8xNcawN+AUTPharw+E0bzNmIIIpALklC7YP0lQH53PB/SlqqGFmIMiLcVACy7EYO9z7nldjpdrXQU29gk2Mj/7JgqX63p5+/gSXwANixnyOKIbmlgA8ZPSWQDj3o7yi05JwbjQZGbujnSq1anyX66bwwrmJCRg/N3x0el+LaL95uV4ZJs0yBeU8UsVgIWHmlALiegsSbUvx9yQJde6+9VIYKldEVXgHw9k2AfUv2xrzbFFZkOZhRjXkcZslEzj66JAs9gynrpIkje1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
 by DB8PR04MB7164.eurprd04.prod.outlook.com (2603:10a6:10:129::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 09:20:11 +0000
Received: from AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb]) by AS8PR04MB8642.eurprd04.prod.outlook.com
 ([fe80::50d3:c32a:2a83:34bb%7]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 09:20:11 +0000
From: Jacky Bai <ping.bai@nxp.com>
To: rafael@kernel.org,
	sudeep.holla@arm.com,
	viresh.kumar@linaro.org,
	ilia.lin@kernel.org,
	tiny.windzz@gmail.com,
	wens@csie.org,
	jernej.skrabec@gmail.com,
	samuel@sholland.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-mediatek@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH v2] cpufreq: Init cpufreq only for present CPUs
Date: Wed, 12 Mar 2025 17:21:27 +0800
Message-Id: <20250312092127.357316-1-ping.bai@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::32)
 To AS8PR04MB8642.eurprd04.prod.outlook.com (2603:10a6:20b:429::24)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8642:EE_|DB8PR04MB7164:EE_
X-MS-Office365-Filtering-Correlation-Id: 7abca7ce-259b-4b61-5b31-08dd6147169c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tZBrfKbXoclVKObk+LF5IIBT98gNhEI+ijRqALEcOkeueOYTYf8LX41NYQW/?=
 =?us-ascii?Q?ms81//ZIZwE98UJpI/KTdQCaJPJEzd4riVr9vm5Eh3ZS+OG5eGz8/r5CLdC5?=
 =?us-ascii?Q?zGaYFNGSsG+IwNRABLOPxBFcPdWw9iBxV/Fu0dNJL8BiKybRrS/eBiYWx6mj?=
 =?us-ascii?Q?JtdxDhHLB/H+DosXW9rBrI2XkXU+vIhNc6ZXaVim0bUtuGcs4Z9fZJSptB99?=
 =?us-ascii?Q?uYWdZmfslCaFxEEbMhpDWpPKqtf9v0aiNJUrCT8XyMz/Eq6GJeOz4VFTcN7+?=
 =?us-ascii?Q?hhlL/FZ0LHCAY8bpvH6RCWqzIqRnvBWfj6TbMyI2xgAQJ0LQugH9H47zmRxs?=
 =?us-ascii?Q?yS98JwEuomf5U6LMPBV3vnrbDpS0B01gDBAJc0+FQTx4rLjkE7sn7igGz0nW?=
 =?us-ascii?Q?qbOzYIA9O4Qhs+dHGDGfHE5g0a8rkMhFv3xnb5p1CbVnJJfJzFQmAI6HHv3I?=
 =?us-ascii?Q?EZLtlRIITXcKwzjLqrmYjuxQrLOSm6gWE10EHE8binifNtKivjWlEB805HVq?=
 =?us-ascii?Q?KNZ9lox9OaVKqJ/+rbaJFwqBLWwQ8ZJ6aIyb4zKf+/vuyrk62uId1fAIMqXv?=
 =?us-ascii?Q?OqNRpvxwGOUBcHK2gMsD5m5pLanmPH68UssPDtrDysIj43PLE1gNEQpu9AoZ?=
 =?us-ascii?Q?t/3aZpkyXxZlX8lasP72rH72NI1/EmoUjLp3mQopMgDc65dfCFhtiB1MA7aN?=
 =?us-ascii?Q?OW+gDou2jmYpuTkWxSbRFMq0wOtjE9MOma7+2MVOtN4lBXlD8kJkl4LGFY7U?=
 =?us-ascii?Q?kDU7H/uURCATgVBsqk1IHpdopXJfyWyhLBWVvSlCf+uqHekDVg1Rxn8CpEew?=
 =?us-ascii?Q?2XciDYe2PB5309g4ZvwkxRLkGwDvCUubMrjVmuzIfy4gO8zJ24cWacg1/RJs?=
 =?us-ascii?Q?veTp/BYWVbzsKIf1ajPCHBrOuwdUaEGlkbfhVbo/avv1xQ8RXtiFyARmlR+Q?=
 =?us-ascii?Q?uH0V837RsKIOdBTjBnpXOFU1V7bC0CsOTjAShwVkMYAL7xu5H7jdPyRRHPfk?=
 =?us-ascii?Q?xVkbOVIKUzZzy+WFI3AHVF+7jK7vtyUsbqvzy+BbmF96JTzwuOU8tZ9Nd4sh?=
 =?us-ascii?Q?oSVfr3G2wL3aG+DlHiY1u+lsCEX/oJ5+S/M31UuwgTkzwQL0icyOovQYa0hQ?=
 =?us-ascii?Q?VLDfXX7bHneeNvFjTkfateRrsr0ej16v1dVEsgSiGHJVOJuM8oWOQzZL/CGD?=
 =?us-ascii?Q?2wKL7/qmRYyFqmGbp1D6rqtD2XXcQEN93+1fkVQIzq1/ody8SDwPLcKPGEfY?=
 =?us-ascii?Q?cRDizNRWeETilKgeiohQW2/YcdB0Gojhub8vOA7oX+11D6pXrfxefWkgs5bF?=
 =?us-ascii?Q?NcB9dNK2GQGcE/NoBVM0yFt0/xTA5f2rRmyMBPKBN/dXDJS2CySEieDtSCrn?=
 =?us-ascii?Q?EuSQFnfuuSUhVH4IZBlXRNljQNw/XtQ0zh9oVLePaaf4VVBjo2YhAG/H6RM6?=
 =?us-ascii?Q?xAu3jFgPNmRiO+U88DP2w9e5TRtsqtqCvDWOeEqdASWlny/XIKNTDA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?airbpmf2JxmyUfDt4uKCBw3jRydCNXdxbcytAhjbrjP/bTD33N5OhOlJ0NT6?=
 =?us-ascii?Q?OfnE2FKWNORou3LpUfJqJpyVxD9hBMeY6fN4ZxlGFmGsgkMyGGwPxNbs0fee?=
 =?us-ascii?Q?gvlMyMoIAqmeiYWsCoLAsfF7vclYDNwnEjR24qs2HGZ5F/hPO5naLuAUDBMd?=
 =?us-ascii?Q?nxwwVBnQftEs1taWyDBb6R8BcXYGiyV8/zuqZpcNeZOrgHSkTTMPUXq44YV/?=
 =?us-ascii?Q?UovkVSBa9bcllPtKT0UKCKhkbaVUW3l62f21xLv9Qw01H2AasI8kiGQX3v8G?=
 =?us-ascii?Q?NWPEFJ53d+iBIwVTAD5f3llJKFItm8lwyVjUfflG+S99Of2F4oP1hLT8WLdJ?=
 =?us-ascii?Q?K3sl1/62gosqaNpZ734yA7MShvD+iYI3X80aV0NTb7TyBplT9S5yqk7z/52a?=
 =?us-ascii?Q?lrHnaZuDz9GI57GeZBHrbSWF9gkiPYejJBF8K/v//rxse/c3XhZLASzllUiP?=
 =?us-ascii?Q?/rofV8D+FD/x9aqDyTTQOOB4W3tO3tjVLhFaXhqKnUSfjZeO66XTgHxWIycN?=
 =?us-ascii?Q?iGMOrg398T/f9ciAH48knPOH2RAZ7Z9X6n+F+VqPda6LriOTrX5FmyTS/D4P?=
 =?us-ascii?Q?U3fhyuN6C/wgRcCfLs1o6mdyV3hswjF9JWOKrsjuxqDqQFY0L4/r8fkc2ni6?=
 =?us-ascii?Q?sU71RxlZ4NFAGjmd8qAnGt8ftLaYDbauiWQTXfH9cu0/7oCYW+KdzjRhlcrU?=
 =?us-ascii?Q?LCujqmnUDWdpb5VDihlZPUbQxRCgyftsnVJgvz6Gb/nbK2tH4i6mVtV7VBsa?=
 =?us-ascii?Q?OztMGufx9fwkG764X15ZhcsWgocH/N708gvF7D8NG55PIxAUftdmKGIEDpo4?=
 =?us-ascii?Q?es4VSAyu8nWk9V2n9+t+mE6CBbCMdBaC5boqpbFosAEAFKCuQuks2ZMbaVb0?=
 =?us-ascii?Q?FuwehNj/v4U0tgrGtVZj/I2Udqle9v3P0T5QKXs6g93X6uTP3C3MhPQ/7oXE?=
 =?us-ascii?Q?4PqTpsoOZCgn6oIMwDeo5kUDO6eYhuH5pAffw0xU73VO9eku3pfVI8uV4Y6Q?=
 =?us-ascii?Q?D7bCyisZzCc+28cVD85fdzHzVyOvsM/IYfYE3/quxZs8rBfc7sMeSWoaJqVH?=
 =?us-ascii?Q?LW2uKC2gKygmrEV14hMviZKABg/aZYFvMq/XRCB3yDvr78dGRMMhd8JetM+c?=
 =?us-ascii?Q?fxK/zLmYE0CU6I20vJny+sxrfjr7vnKH7XllOGqES9QA1j5jva+RT3FHmH8J?=
 =?us-ascii?Q?128ZJKmaIX002xyqwFaCFYP1Iab9fAehflK+BR7rgdEkxF2GLGDaGU2WHpiN?=
 =?us-ascii?Q?SLPqn3c9VgvbxPPzfjHY+dx7LisFV5f6haLYZuZUtvViMzwbqdzH8WQZfcml?=
 =?us-ascii?Q?/7MGqVVH0hSHDKIS++++EoGzjHRFpv3B0vXf1lxLsJQB2IadkkOshLJ5hsho?=
 =?us-ascii?Q?++AIZWW3id67x6gq1QVPvGD8wKY1XvVM9Gt8Uaj7SX864ICdy6YbN6Rc8lsG?=
 =?us-ascii?Q?lAqoogCaAx/RtmpoT+9WiG0429f9o5Mw0CAkBEBDrsEAVD5D4F4EDAAvFYoA?=
 =?us-ascii?Q?d9vg9FUyLGNp3XxFzk6O5yHv9vK1JNp2KXiWXvx+MDuO5gzQbnmCQQqePtgk?=
 =?us-ascii?Q?UcT7jtBwIfWEtzq5XWEUaPr4kL/RlFgfKYMrw8qq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7abca7ce-259b-4b61-5b31-08dd6147169c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 09:20:10.9802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fdC4TQI5HchHdGGDRuz/hZFQh78GS5d1ynjUM0uKtvtokCnOMqhym/21GWMX5IFTeIVPtXS9CJagR43Ob8EBQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7164

for_each_possible_cpu() is currently used to initialize cpufreq
in below cpufreq drivers:
  drivers/cpufreq/cpufreq-dt.c
  drivers/cpufreq/mediatek-cpufreq-hw.c
  drivers/cpufreq/mediatek-cpufreq.c
  drivers/cpufreq/qcom-cpufreq-nvmem.c
  drivers/cpufreq/sun50i-cpufreq-nvmem.c

However, in cpu_dev_register_generic(), for_each_present_cpu()
is used to register CPU devices which means the CPU devices are
only registered for present CPUs and not all possible CPUs.

With nosmp or maxcpus=0, only the boot CPU is present, lead
to the cpufreq probe failure or defer probe due to no cpu device
available for not present CPUs.

Change for_each_possible_cpu() to for_each_present_cpu() in the
above cpufreq drivers to ensure it only registers cpufreq for
CPUs that are actually present.

Fixes: b0c69e1214bc ("drivers: base: Use present CPUs in GENERIC_CPU_DEVICES")
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
---
 - v2 changes:
  - Add changes for armada-8k-cpufreq, mvebu-cpfureq, qcome-cpufreq-hw,
    scmi-cpufreq, scpi-cpufreq, virtual-cpufreq.
---
 drivers/cpufreq/armada-8k-cpufreq.c    | 2 +-
 drivers/cpufreq/cpufreq-dt.c           | 2 +-
 drivers/cpufreq/mediatek-cpufreq-hw.c  | 2 +-
 drivers/cpufreq/mediatek-cpufreq.c     | 2 +-
 drivers/cpufreq/mvebu-cpufreq.c        | 2 +-
 drivers/cpufreq/qcom-cpufreq-hw.c      | 2 +-
 drivers/cpufreq/qcom-cpufreq-nvmem.c   | 8 ++++----
 drivers/cpufreq/scmi-cpufreq.c         | 2 +-
 drivers/cpufreq/scpi-cpufreq.c         | 2 +-
 drivers/cpufreq/sun50i-cpufreq-nvmem.c | 6 +++---
 drivers/cpufreq/virtual-cpufreq.c      | 2 +-
 11 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/cpufreq/armada-8k-cpufreq.c b/drivers/cpufreq/armada-8k-cpufreq.c
index 7a979db81f09..5a3545bd0d8d 100644
--- a/drivers/cpufreq/armada-8k-cpufreq.c
+++ b/drivers/cpufreq/armada-8k-cpufreq.c
@@ -47,7 +47,7 @@ static void __init armada_8k_get_sharing_cpus(struct clk *cur_clk,
 {
 	int cpu;
 
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		struct device *cpu_dev;
 		struct clk *clk;
 
diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 778916f89a51..e80dd982a3e2 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -283,7 +283,7 @@ static int dt_cpufreq_probe(struct platform_device *pdev)
 	int ret, cpu;
 
 	/* Request resources early so we can return in case of -EPROBE_DEFER */
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		ret = dt_cpufreq_early_init(&pdev->dev, cpu);
 		if (ret)
 			goto err;
diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
index aa209f5527dc..74f1b4c796e4 100644
--- a/drivers/cpufreq/mediatek-cpufreq-hw.c
+++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
@@ -303,7 +303,7 @@ static int mtk_cpufreq_hw_driver_probe(struct platform_device *pdev)
 	struct regulator *cpu_reg;
 
 	/* Make sure that all CPU supplies are available before proceeding. */
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		cpu_dev = get_cpu_device(cpu);
 		if (!cpu_dev)
 			return dev_err_probe(&pdev->dev, -EPROBE_DEFER,
diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index 2656b88db378..f3f02c4b6888 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -631,7 +631,7 @@ static int mtk_cpufreq_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, -ENODEV,
 				     "failed to get mtk cpufreq platform data\n");
 
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		info = mtk_cpu_dvfs_info_lookup(cpu);
 		if (info)
 			continue;
diff --git a/drivers/cpufreq/mvebu-cpufreq.c b/drivers/cpufreq/mvebu-cpufreq.c
index 7f3cfe668f30..2aad4c04673c 100644
--- a/drivers/cpufreq/mvebu-cpufreq.c
+++ b/drivers/cpufreq/mvebu-cpufreq.c
@@ -56,7 +56,7 @@ static int __init armada_xp_pmsu_cpufreq_init(void)
 	 * it), and registers the clock notifier that will take care
 	 * of doing the PMSU part of a frequency transition.
 	 */
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		struct device *cpu_dev;
 		struct clk *clk;
 		int ret;
diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 4b3b3dbc7d38..8422704a3b10 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -306,7 +306,7 @@ static void qcom_get_related_cpus(int index, struct cpumask *m)
 	struct of_phandle_args args;
 	int cpu, ret;
 
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		cpu_np = of_cpu_device_node_get(cpu);
 		if (!cpu_np)
 			continue;
diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 3a8ed723a23e..54f8117103c8 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -489,7 +489,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 		nvmem_cell_put(speedbin_nvmem);
 	}
 
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		struct dev_pm_opp_config config = {
 			.supported_hw = NULL,
 		};
@@ -543,7 +543,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 	dev_err(cpu_dev, "Failed to register platform device\n");
 
 free_opp:
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		dev_pm_domain_detach_list(drv->cpus[cpu].pd_list);
 		dev_pm_opp_clear_config(drv->cpus[cpu].opp_token);
 	}
@@ -557,7 +557,7 @@ static void qcom_cpufreq_remove(struct platform_device *pdev)
 
 	platform_device_unregister(cpufreq_dt_pdev);
 
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		dev_pm_domain_detach_list(drv->cpus[cpu].pd_list);
 		dev_pm_opp_clear_config(drv->cpus[cpu].opp_token);
 	}
@@ -568,7 +568,7 @@ static int qcom_cpufreq_suspend(struct device *dev)
 	struct qcom_cpufreq_drv *drv = dev_get_drvdata(dev);
 	unsigned int cpu;
 
-	for_each_possible_cpu(cpu)
+	for_each_present_cpu(cpu)
 		qcom_cpufreq_suspend_pd_devs(drv, cpu);
 
 	return 0;
diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index ff2897789797..c310aeebc8f3 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -104,7 +104,7 @@ scmi_get_sharing_cpus(struct device *cpu_dev, int domain,
 	int cpu, tdomain;
 	struct device *tcpu_dev;
 
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		if (cpu == cpu_dev->id)
 			continue;
 
diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index 048dc43a9997..17cda84f00df 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -65,7 +65,7 @@ scpi_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 	if (domain < 0)
 		return domain;
 
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		if (cpu == cpu_dev->id)
 			continue;
 
diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
index 17d6a149f580..47d6840b3489 100644
--- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
+++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
@@ -262,7 +262,7 @@ static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
 	snprintf(name, sizeof(name), "speed%d", speed);
 	config.prop_name = name;
 
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		struct device *cpu_dev = get_cpu_device(cpu);
 
 		if (!cpu_dev) {
@@ -288,7 +288,7 @@ static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
 	pr_err("Failed to register platform device\n");
 
 free_opp:
-	for_each_possible_cpu(cpu)
+	for_each_present_cpu(cpu)
 		dev_pm_opp_clear_config(opp_tokens[cpu]);
 	kfree(opp_tokens);
 
@@ -302,7 +302,7 @@ static void sun50i_cpufreq_nvmem_remove(struct platform_device *pdev)
 
 	platform_device_unregister(cpufreq_dt_pdev);
 
-	for_each_possible_cpu(cpu)
+	for_each_present_cpu(cpu)
 		dev_pm_opp_clear_config(opp_tokens[cpu]);
 
 	kfree(opp_tokens);
diff --git a/drivers/cpufreq/virtual-cpufreq.c b/drivers/cpufreq/virtual-cpufreq.c
index 45becb92aa4a..7dd1b0c263c7 100644
--- a/drivers/cpufreq/virtual-cpufreq.c
+++ b/drivers/cpufreq/virtual-cpufreq.c
@@ -138,7 +138,7 @@ static int virt_cpufreq_get_sharing_cpus(struct cpufreq_policy *policy)
 	cur_perf_domain = readl_relaxed(base + policy->cpu *
 					PER_CPU_OFFSET + REG_PERF_DOMAIN_OFFSET);
 
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		cpu_dev = get_cpu_device(cpu);
 		if (!cpu_dev)
 			continue;
-- 
2.34.1


