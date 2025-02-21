Return-Path: <linux-pm+bounces-22662-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C437BA3FAD7
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 17:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 737F77A5C94
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 16:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E9820012C;
	Fri, 21 Feb 2025 16:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="eMJpa7vF"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2015.outbound.protection.outlook.com [40.92.18.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC681E2838;
	Fri, 21 Feb 2025 16:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740154290; cv=fail; b=ZyWR3zDkZcEzYLwFclyxi3xV4OjdJTPIKfwZsWEboFR+f/wDpc5yB1q7jWaNuzoDzi+5+DeiRtFo35FTE7WVYvW2OGstoojPenTXGWjUxjtI0GG8tiMtBEgrkoBwNaxAQJireLRk6gDTnMFaUkGWsFexOJcBcT3lp97z8WI9NF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740154290; c=relaxed/simple;
	bh=FF3dMhHeECdMxjQ2HCQeI3Sz7MYPHtTItMHYBVZKTQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eMV+kVmAlgq7n6zozicG2izv+nX/wyiDvyETIrsROv9L9HLX1PjgXYCnu7RlIMujLuQXeZ/AlvKJ05/DZyUbVr5Y41/buNFsBBqJx45GpMGAS7OwcyghR5d2Mr3XW5cxCSVI+Abetn+JTyDJZu50cbI5rRPGWHqTheof8kleKQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=eMJpa7vF; arc=fail smtp.client-ip=40.92.18.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nQfm8kjM121nUB7sG4s/Lqm1iD/nbkRVsXV0HXv6hrMiHw2D4s3dgc3aOWTeHx7flzlONoZ2QnARyXyRbnnHVVB6NSOPK8LKkfoga4ndW+/s25cxBAl3NwF0tHOVUQ9YJLfQGyBupW3iBsCZYFk7koHCaSpxWy/vGdCBaFyHzY5E31INvL7PsF5SozrO2wZYJc5APXq5YWytWGtA+PMHc1tQn0NxqfXY6oXqldNFnX9+5glZ2uboQ9FcwpBvF1r4qCMhGePLZLRNfaRHONji9gQsnMyKQBCsMDmbQv6iVEbmhCndjxTQt7fPQkE9f87lpsbnbHCMUjyudr5WHCjR2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NX4GTad7JPODaBVDWMxGW+ImaBcZeDTwL6qMqm2ZRNQ=;
 b=CS6L2YLIxVZ5GdviGzHO/BiYaezbwIlb3JrobcVTlOaPrDtzBxbDkWjYSu/IQtcS6fXL9GdZS8dakAk9LFMkNNql3/knajmann8W/J0HH0wU9fiqb7BGwcSniyR8ZJHCSRbnjjQof9SSRZ1QOqzFIV1aZwYnYBc6dPGKBP1jZDNaB8kI7oKlazU/7usPl52FrAIPRXdGhxPkPps9xLjhS2Pa13gKnQ/S/upgtbvxMFw6BumPr7cGLCEZWmMZlWOv6AE3fvES7cYIvn9EhVIVHRCHJ03vfRWt14dwZXDJeloI1WcDD6xtijjE1HfMYvxzSVChP43lnDFd1/pH5aewNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NX4GTad7JPODaBVDWMxGW+ImaBcZeDTwL6qMqm2ZRNQ=;
 b=eMJpa7vF6S4CzG/hm01FRYTjrTpeylJctYsJ7jArpW1J099WaT0auihbAYlCwvaJkhNJ4AUObg+2sr9wkenh3UZGZtqbQEAheHJbZe+P+zMlGGyX9DnoScxKZrOu11GfCOXTmCHQK3rGaI4z9X0hus9a/q7rOj7w9FrMq++UhaIweyjZngSn9Bck6IS8GLd9p9BYCGrt4AN/gIqwBOTqXRSDXvYzzfddTgyi0GTi6phPXWyLeEluxXxbv7cINpavY0LnouUwov3IkG/ffZYY4rvOnA/UNadnvAXMcFMTue3rEltBHVRGfJoCHeKv/GnsabS53h/yQR45rhqr0oz2pQ==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by IA3PR19MB8736.namprd19.prod.outlook.com (2603:10b6:208:51b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 16:11:26 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 16:11:26 +0000
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
Subject: [PATCH v5 3/5] thermal: drivers: qcom: Add new feat for soc without rpm
Date: Fri, 21 Feb 2025 20:10:59 +0400
Message-ID:
 <DS7PR19MB8883FEAB79D43037BC8634619DC72@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250221161101.17204-1-george.moussalem@outlook.com>
References: <20250221161101.17204-1-george.moussalem@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DX0P273CA0059.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5a::14) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250221161101.17204-4-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|IA3PR19MB8736:EE_
X-MS-Office365-Filtering-Correlation-Id: d80c2644-5566-4bc2-5486-08dd529263dc
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|5072599009|19110799003|7092599003|15080799006|461199028|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4ePIvhZcSjOLEsBOr5AVSiw/SDVvfMLcp+U8duZoJuZZ4cqI1PsJbbix1NP6?=
 =?us-ascii?Q?DgCd4gNwaBsM33Kw65m18YbftJNDWp6YFrEjH+wAuDL43bzlAsw5fO8lm5fB?=
 =?us-ascii?Q?vyDfUJEPCb+nOfVdtMca9vsifJRvwYPDyHM4b01Wt+FVHY+rbpXlzZ/naM6q?=
 =?us-ascii?Q?s9EzYNYagP8J297VBmfGF45S1JlB0oaYZi+3PDVnaUSofpb/u1xs40HKQco4?=
 =?us-ascii?Q?Q3AqY5Y3ji60+quDfC6H7zNpcZxPq5urnIMqOQC+/ipu/wQWlSoRLStL55Qx?=
 =?us-ascii?Q?kYs6/4NgFXA8qALis2V67hBUQWe+01hTBJEO2f2Ou92Fda32yT3AFO6pq2JV?=
 =?us-ascii?Q?hgqL9Fglh/0YjwqIxl8AK6WlGbP4OKgrFZrrGU+pBRAxKKyRf7NpdujubqCS?=
 =?us-ascii?Q?43DA7m+iq/vGGcmQh8EayNeKo6t4QUW1HJghZQrZyKxYt7PtUhrz7DHtLK1t?=
 =?us-ascii?Q?Xh43PghbFIgRff1PolvAmlmZQRDQcdX5GftIognOR2d9p/u9Xo6jbX3r6bgI?=
 =?us-ascii?Q?2Hv/pucbvMK0YYNe3gA/NaQE0z1LaWiZ5h1mdtl5l33Lxz0XIC+1/d2fe9Js?=
 =?us-ascii?Q?qb1zEdVAs0kQMsaalGhNjHpVjZrn0ZDrcCXl6LExLhqaLwd57RoicVINBYeR?=
 =?us-ascii?Q?1nXSH1PR8nLUmGFV1vnju91uzNcjNmhir9J5hco+pwTPWmzVa2BBWqCUTIOO?=
 =?us-ascii?Q?cY6tnEiU570wR0mLwnpGFFqlwgleO9psXy0iz5MDIrb8IEfc+iNVlrpEA/eR?=
 =?us-ascii?Q?EM9Puc/roywWD00dt91yblDOkP4kVXTKa4iOWtud1xr4wtQiAaCIcLxOXZSs?=
 =?us-ascii?Q?9BJRNTTBRnfz9PVy0XvmMu3gb7afuqh1s6SCpLXbOn52zQMDzX62LYzxSN4u?=
 =?us-ascii?Q?vYIz6aSkngPcwrV2DYD/Dub0cmLwT9QGVvZX2TDGnuRJMDrmRwFQnrkSRkcm?=
 =?us-ascii?Q?pNLiTlvwMXs/GM67/lW+SEkoOGLHhf7mA96pBcWbJiDXvp9uSBSAs6aEhYXj?=
 =?us-ascii?Q?gulZ2wA15favZU2IgHQkGUmdDoDYvxpDMtBSiSj5r1CuI0zXCFj3rAj9Ahs4?=
 =?us-ascii?Q?RGwp6ZAIWWHnWbgHdk8vlR0Z4ZRFWOKlAun7DAMJmDJ+QvyWYW4=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PNT7gRBsHJb1HfWH40gKrWnr5WwcYOJmCXS48K+umYav9kmTsslC4PCRC5Ms?=
 =?us-ascii?Q?7ewWVvYq8U6ji7+aaAOCu/PBAqPBLwL6VNH4LM1xQ4yhdNkwZVHjxkXD1szB?=
 =?us-ascii?Q?TaMaeM/ntHD5CdLOUTGakqnZ1d8+JKIPVaBQMVbCEF1MYeYcwgGXJscZOSUi?=
 =?us-ascii?Q?cHVGwpAfL7dVmQmERKoePdiqx9tn8xj6324nx6RYQ6vMXrYL2oOj15Qdnq/a?=
 =?us-ascii?Q?1vTqsu4YoY736k4pI9JxQV874IrBcO8Ej5aP2y68khdaR+4ltNLu+ad9CXV+?=
 =?us-ascii?Q?FKo5MMM6kX5EJxvYSjCdkaD/o5I5WJT363G0nKVSIqF/m15/rF/zR95FCp5X?=
 =?us-ascii?Q?iV1SeZOH8WOHSN2yQ7cJcGHMCR4fHsxNnmP7W9ImGKau+0nzIzaPHW24osZf?=
 =?us-ascii?Q?TRDesi+aTm0qTuLau6kUXPBDi59XTUBiOOqpBs1lNT261u+38enz8kBy5FGr?=
 =?us-ascii?Q?VaZBWNwp74d7s3PyLxdAQqCZrak6gZFDk4NY5Z3qGmwT7Ac5Q0zV0pbP5neZ?=
 =?us-ascii?Q?NHhKdsxL0hLcH4amH0q2/nM59NPtKV3VK7zxbfmVGf87GPvNY6anFC7/7DzG?=
 =?us-ascii?Q?mrvWa/7XRzEuKAf8rTsLAnjZqJ6xR2liXog1D3qiqBRyrAjTCuDJnYE7Bmzq?=
 =?us-ascii?Q?wKG56YvMrUzUa9jyW8PSHKPdiDhQWNt7jscYRaGVUL9+0vBNdwpER2UOXFbL?=
 =?us-ascii?Q?vGcJlbqMHaTeNBcYJy0f1cO54V4GQp9dBe1MUcsyTepmz+9ZL5JTG2ZBBopE?=
 =?us-ascii?Q?MP39AkyhAFn0csyKbpoeCJjovpuY+pX3tW13crBz46V7sX9UgI/Lc3pFl1cn?=
 =?us-ascii?Q?EZXyn9bYrkzdYfhBim1TckOy89hjZuc5dVI5cgok3jCwwnhxFKroGCFnCFxO?=
 =?us-ascii?Q?AjzRLqOSz4ncNPDs+xE3jBLwjW+pDqRSPAeL3ca0Tl7CPXRU18oFWCnOoRAv?=
 =?us-ascii?Q?o/ohSEiMz3OIq8sjFtgdl7piyjJxkkNf6XXHCRR2j1e4Zpy6mooz9Nfoca1f?=
 =?us-ascii?Q?kErdBc4LvV6MXMxXY7Gwk31FBtUFmePCdnvUzaeFFGGCLr9ZlZXDiHZ5ITLz?=
 =?us-ascii?Q?tSpdAY/GTFAAGFJbjqhOhJiH/B3cjXy/eb4af2riHuB0Db77zBrm9zaOWoxv?=
 =?us-ascii?Q?mfXwOHTCyk0/bqMaYuQCacOYnHCacqkzGEU4kDCMMT2s+SdrGWgxOX0yU4IG?=
 =?us-ascii?Q?Puqn5UriSfg1A8yb7xGS5YZJwLhQANZhJrq0/argAWphCk+O2MjuI84sfezq?=
 =?us-ascii?Q?EtbTcd/k+NFceSrKAem1?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d80c2644-5566-4bc2-5486-08dd529263dc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 16:11:25.8860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR19MB8736

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


