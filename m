Return-Path: <linux-pm+bounces-22770-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA03A4152C
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 07:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8C2D164D9D
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 06:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319FE1CEAB2;
	Mon, 24 Feb 2025 06:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Gqv3kpK2"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2023.outbound.protection.outlook.com [40.92.20.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614CE1C8608;
	Mon, 24 Feb 2025 06:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740377583; cv=fail; b=IxckVDCWikXPIlFDQTYJv1SIJHyDJ2X9iJiJ0ZSdDZ2BMALjCUfSqkd/rPtwYPn4HaIf8XJqP3Df+G3IC1vTJsA9RvX3HBfvJlqI1wF7ZVzjB4NJzYewxH3kvpPTofdNv1Wo8/eKIw2WHueC+8YmMi4UwqAv5jhZKOmzQM3KQWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740377583; c=relaxed/simple;
	bh=FF3dMhHeECdMxjQ2HCQeI3Sz7MYPHtTItMHYBVZKTQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G5oPxx47jnG7+P5IedNQW8U4MQv4npl9r09Wx+bTMYslK2e5FV/yy87n5Sqm5iiamMi7Zuh3f0D8UE6maopDnBJcXkpz8Ci1KPOycamWwvxEZLhl1x0fsAjss+wZdwolJTMP7LWsOkPwpysW+JtzDD//qnLTyQHU1TyBClYl5Wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Gqv3kpK2; arc=fail smtp.client-ip=40.92.20.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oDSYyWqhiQQjxzM9VjHRX1bKG4I01rQ7AX+ECqZuqma9PY5corujDzSZglVkRb9cuSYNUnUHi9BItY9yrjCuR22V4yxQW+Iv3a61tRkPqpW5karhCpc2pPF67VolrY97CnpKSWzzfN0DW5WFOsriWn15Ag1FwGYxLLLZi508dHSbJsbQk+KfhTvBaU7iiARkkB4v+JVrs/zSuhfUcqZ+smd55+xvwmyti6uuyJk09P7bYZIWNgbihC7FGwu6cutz2/jNa1SArk0kN+MA0FyJZt8FJ5S0gNMMQeTNv4R7Lm8ozSwLV7VbJHRveZM1lrI5Gtc1ao/wqX0BfLr0rYyxiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NX4GTad7JPODaBVDWMxGW+ImaBcZeDTwL6qMqm2ZRNQ=;
 b=bc5Wxjoqz4r2ym6GNtt3hSyDd3Zo16cX+ADfrVGTKZhvI2sTVqm6A5ZXBAF2k8TW9MeP//hUhV/Neg94aRmAd6W+mBmlKpUq59Y562rzYKwewEiBu7RoG1orFsy8aToXzixPr6HObVaU7MY/VZ82V1Ka828yVyVkf64EDnjCwJ0v1iMVJywikEwGzN7x1zXVN51ilUenuC9IN61NcFp7Fjg7kgdMR3/c2hai9CDuGg8PVXUTTZOxeHktpkwE5r1txi1MsvoY33/CmJdy+4Bzkh2koY4RgFnU5j5Ch3Kp4h2Sh3OoFD29Ov+PC1AJl3kltTMlpfiyD379OSvnEoTM4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NX4GTad7JPODaBVDWMxGW+ImaBcZeDTwL6qMqm2ZRNQ=;
 b=Gqv3kpK2VeWdqHeJbI1lCYu9iqJYEgctLmaI7AOgLnSfPtgbntmjFhj2+6I2jB1bJQitG5CgPyoUZypA7hiiyJ/nPqONjxVHKEIBsAMCCmTqKvPK5O7DK5ep0NymAs3JrrhMhPv4GQXFwAyyZcE7Td9Fma3l24P+ZInFdEknAcNB3nZ2qdmIWEsa7A/nL7o6rtdN+iJGu0XivpjfItwsdNHur53QxzCYuyCI61aBLgLfBtEASV2SDrUeAiXa4n6liQVyQWRum34RmkObkJShdyieV1J+ZJbnj4TN2twdz30bQLhtsYN3NINGdVrWK+RDpHoWbphkR8W8U5ds1FpZSg==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by CY8PR19MB7179.namprd19.prod.outlook.com (2603:10b6:930:92::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 06:12:59 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 06:12:59 +0000
From: George Moussalem <george.moussalem@outlook.com>
To: linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	amitk@kernel.org,
	thara.gopinath@gmail.com,
	dmitry.baryshkov@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	quic_srichara@quicinc.com
Cc: George Moussalem <george.moussalem@outlook.com>
Subject: [PATCH v6 3/5] thermal: drivers: qcom: Add new feat for soc without rpm
Date: Mon, 24 Feb 2025 10:12:22 +0400
Message-ID:
 <DS7PR19MB88837D7AE30CE306B8F71F3E9DC02@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224061224.3342-1-george.moussalem@outlook.com>
References: <20250224061224.3342-1-george.moussalem@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DX0P273CA0058.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5a::15) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250224061224.3342-4-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|CY8PR19MB7179:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a98f2eb-a875-4562-7f2e-08dd549a493e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|19110799003|461199028|7092599003|15080799006|8060799006|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yuPFZL9DnLprDcrH9EsekZroKkx1ukiUrBEglIqyQ3xT+MV/KTWepPmmgu+Z?=
 =?us-ascii?Q?WRNyH9y3fCypbf7Sp0nMQKuxaEvM/9NuvAtndGztryBEnuzafuHwYiogpnuS?=
 =?us-ascii?Q?lZwp8LpVpQxy/wBA1xdY1wrGSpQ1ldJpYzbKCu6PAhLGi0kJiK8IrD/6GpY+?=
 =?us-ascii?Q?IflhAt5aYlRbwfPx2p0mV1CcUs59L5fVMMwxPJWYZHsDK4PJhTjOJo9nywhY?=
 =?us-ascii?Q?wmpkbqvToEqhp6sHlbz7q1pOxAZNwm+eGBRQ/nDLDcaSe+4X4RX0uP08aiT6?=
 =?us-ascii?Q?5eyCX9H1eJeKqqqQ/84htHFFWIoFjnzYyJn3/LroyDSgDGhg3sFaUhO0uqhK?=
 =?us-ascii?Q?xnG+PcKCKNfcgNNnmU2w2IRaDqEUW+xCfdMAv+O8nDo5m95OE+Chn7K6LmdN?=
 =?us-ascii?Q?pDo1ouib6QHjAUUxHMxuc5k2gxyL5UYnYcnbekl2RgqdRFEd4KAgJbsfn8yp?=
 =?us-ascii?Q?WS15VP8TtznA5Z/PWFUPmXnr3HQHv8UzHg7D5h88qajEiS3PBqOFCCJ3EgAO?=
 =?us-ascii?Q?2Wsn/LRdE8fm6V+qG7HX0Hew/SlpcsKyUhoTue1HBQQ/IaqiV/wQKOZcZtLR?=
 =?us-ascii?Q?FojznEdViXTU+HWb6hzasYU0LhEqyU6EwLITz1xkZ6xyBkv2gokLio6Vk692?=
 =?us-ascii?Q?2Dj2uKeYayOmH+ZbTnGeHX1ALQhkBKMwkM4sLiVEbSS9e5BXpB/lATQJoeLY?=
 =?us-ascii?Q?6xm3yZLEFgIUhkEQY5BI4WLHC05h52G+NqaO9cHMlzG6JBQMIDZMlShLqk59?=
 =?us-ascii?Q?jLNvgpRJnU+zjaaNZv710jByK7YP4ZsYQ+O58j4DOYpuHX1uDe0tOHGLC+gS?=
 =?us-ascii?Q?dkG+lUHAbg5wWKjn/aBuiL9jVyxH/ApJkswBgTtpo/Sl/0JiMZO2M5KETJOE?=
 =?us-ascii?Q?V46nwqbMOVY6OAycAj8qZTmovrPm4WeMVZvczWykWgqUHifCmb6vlYs7kqN6?=
 =?us-ascii?Q?fhyMHk9a9ZJFvZcb2Y1JZDu8wCPJ8ixoi8gpY7NPiqIH+ZjoAyxPE5Aged6x?=
 =?us-ascii?Q?m8PrV33YCHJh7Y3Y/DwB3AyVApCx0CtkLN7WMrN2NC4w4HBBy5NvWm+ADi5K?=
 =?us-ascii?Q?mbOHlqNZmP83O0ahKS7OGkmoCMT+lpRxTKXoyHFtRbgP08NSL1g=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QVgLiFZYXK5pVCvjPLGzO1iLPFfbFjXVMkPY1Ofv5+7pRVHsptXSZm89B5xG?=
 =?us-ascii?Q?Z5SOLNo+QVkmmLmv6wOxrS5CzkGOJRBcYLurU9bMFCHs8snIT1lboTQx1bg9?=
 =?us-ascii?Q?hGa5O/LjxnOpnCxzPM0AE7FDcCoGIYBR1yGvXnO63baM0CGYUyai1KzvIXXw?=
 =?us-ascii?Q?Y/52Sv9aC3FcxELqFya7lk2g465XcxWQgNg8YpNQgLWf97doy9arBTrgoK37?=
 =?us-ascii?Q?XMB452QwmI6oXYcV4mLQRUQjfEPzuvfMV4NIlcMak6En7H4FB81uA8pRK1K+?=
 =?us-ascii?Q?4uma4Jlev+VRkMyYIqnqCfWWCXKN5+M/mh1QT5/ENZvHoQnlVs3braicUofi?=
 =?us-ascii?Q?mhHfuV1gY6qepw2UNLtpu1Nl03jVNtckLTP/xtJ+70LtkYaHUChoqRd/H4GT?=
 =?us-ascii?Q?dMVu/2JuMqed6HiPJMDn6Ln4dgZuVS8PY1wbS5Pxr6bAjMdOOIdwPQ32/wxA?=
 =?us-ascii?Q?q89iSusZOMa/LNqvIkcxXhJGYJxqynFtx3Hp8g+11v3k/8fLKbpRirCAw2wq?=
 =?us-ascii?Q?nYK9Frf321C4noqV9b0PpJQlnxB+1Ly9DRcFmIvlbdvDnTS2JWVHSSedYe7R?=
 =?us-ascii?Q?ut4dROXZTR782UbbJ5MCGicASmjUlLnCnIkYcdYg0WV7fWMu80UiJzfI5ksf?=
 =?us-ascii?Q?XWROCOnpgew04c2zcNoSPLFdEo/R4VtHZJPos2EPau1lzm3NkzY8OhMuelGF?=
 =?us-ascii?Q?YZjz1EDMjyux5cIiErLKh5SUYQkNKYChmT2GYvhZGZoOW5g40nQLNR5tElY/?=
 =?us-ascii?Q?00Ebgv0PV5dGCbSecPeLWlq3y6bu07kjb9MWpNHaJjE68WVd19lDgZVOdMQ2?=
 =?us-ascii?Q?W//U8W3/8FtO+nZxcJ7nGGeMDydBdVV7x+VMTQOc28FYqWtS0/T/6FnRp9FO?=
 =?us-ascii?Q?Pb9DPVOM7iYNeIxvMWzb8gJZ8RO82kix0KeOaYQOFs6XJfksEC8LQU8jBFQX?=
 =?us-ascii?Q?k4ljVJkuQ1Lv2dIzOxm9wF8n/bgREXKAqANoTd6BMk1vWp1rPi0xn4kRXVVr?=
 =?us-ascii?Q?5RMIabdAwS6d+0jP7JCf+udQBmfyLyNPWXdj5QTHwXvG2AXcQwMj/6BQMv+Y?=
 =?us-ascii?Q?90n6SeCXIk0MGljJP4Ieh4LaNH4AF5h7tzA2SIYHOLIn/Wga/YDsBClwm8Y9?=
 =?us-ascii?Q?V34KcQ7nCJxWTX4fidwfEQV9MGNaLns3GZIZvuK7tp2rIihL0VwL3UQeXXwg?=
 =?us-ascii?Q?tCJkHGKSF1XL8IV152EwOPRxecs2ev2Lve782yFAq5eADKZNuww3ntISY1Ao?=
 =?us-ascii?Q?FOFVXbOucKTHqmDWBVLZ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a98f2eb-a875-4562-7f2e-08dd549a493e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 06:12:59.3385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR19MB7179

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

In IPQ5018, Tsens IP doesn't have RPM. Hence the early init to
enable tsens would not be done. So add a flag for that in feat
and skip enable checks. Without this, tsens probe fails.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 drivers/thermal/qcom/tsens.c | 2 +-
 drivers/thermal/qcom/tsens.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 3aa3736181aa..a25ca17adf1a 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -975,7 +975,7 @@ int __init init_common(struct tsens_priv *priv)
 	ret = regmap_field_read(priv->rf[TSENS_EN], &enabled);
 	if (ret)
 		goto err_put_device;
-	if (!enabled) {
+	if (!enabled && !(priv->feat->ignore_enable)) {
 		dev_err(dev, "%s: device not enabled\n", __func__);
 		ret = -ENODEV;
 		goto err_put_device;
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 7b36a0318fa6..90bf11fba563 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -505,6 +505,8 @@ enum regfield_ids {
  * @srot_split: does the IP neatly splits the register space into SROT and TM,
  *              with SROT only being available to secure boot firmware?
  * @has_watchdog: does this IP support watchdog functionality?
+ * @ignore_enable: does this IP reside in a soc that does not have rpm to
+ *                 do pre-init.
  * @max_sensors: maximum sensors supported by this version of the IP
  * @trip_min_temp: minimum trip temperature supported by this version of the IP
  * @trip_max_temp: maximum trip temperature supported by this version of the IP
@@ -516,6 +518,7 @@ struct tsens_features {
 	unsigned int adc:1;
 	unsigned int srot_split:1;
 	unsigned int has_watchdog:1;
+	unsigned int ignore_enable:1;
 	unsigned int max_sensors;
 	int trip_min_temp;
 	int trip_max_temp;
-- 
2.39.5


