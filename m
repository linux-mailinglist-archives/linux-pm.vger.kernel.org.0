Return-Path: <linux-pm+bounces-23147-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DFFA490C9
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 06:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5109E3B1B1C
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 05:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EC51ADC75;
	Fri, 28 Feb 2025 05:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="A20ZK/lS"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2075.outbound.protection.outlook.com [40.92.41.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB2B1A4F22;
	Fri, 28 Feb 2025 05:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740719769; cv=fail; b=NBpukHqGHIWhYudeDfDgymXaR9oRiwCzMZrF002G9ZQbWf/9hWLWFM4gIVisIm096F2t42DUHZaIOCUTuTgfjmbypLk1HUt66M+4Nv24o8mhaLT6kXcmuosDUo2nk9VulxPiwID/nA9APWegh4XGdz1nJAKR/3/19o5vTGpyWOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740719769; c=relaxed/simple;
	bh=0YBWyEw5ilmk/JBVlL6dJC3G6ExM3isiZqhAn5sfYjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ij9LYGnJki8Ny4CkYXuLmPTIukebq71eUtUAzFJTCV3M8amRNAYMiSlSYiQTcCXSizo2r7xxZwvFQMhaQaNc+/O95HPvX1XVowKLZ4c0qXIrkkqp2JQ4VQIAI+WC+6eJZa+ocfRiiO7hA9HJXErQjzaqPEUBkLl7ENrCoupcN8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=A20ZK/lS; arc=fail smtp.client-ip=40.92.41.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W23HMW1GYL4kJN8d+UHgkjLLQN2feU++96kNuYNRujN3kYWR2GTot5SLr80mQk/cNDODgh9RCtDtd7D+RNdaACrmSgtTfz1hsxMbHwsDNbOXF2T/XN7GHw7EXQJbjAJLwOfsxEo3KHq9r6p5w1OqHLQ1O58XfzzAWCox4v8CDkPfpEYkTZkf4xkOszwOw3f0UWKUTwwLbqW4PhNHmdUC4IOAQshc9V3HANIKRGhTYNF/+umvhjxeVbZz3znpQ15IstXQEiJLd1guPLxY9LiBwaHtDe+tIaIFkQ+GmS4/jCTcQTE9aWzmfICbeYDeDfTlcL/TElClF6tQYmxZKXMIbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7IOrs2pO2EF/YC+A23sRpSscWWlqzIqnqayKhIXjsg0=;
 b=KMNoJSOlw+X7KfKYnbucYwIU7baWLDW3vOgxnxmEp1zHDkD5ag1sleI1bkb7ILeI/7B9jZwnR+ZbY3Sk4wzy+cUhvI5HhAp46TY+xcUsqFKBHnpguTjf1j95GyM4UchngN91XCKX25XkKPKs6Ijyc24KCmucuwWw4CWceuTz9nGbvXMwybp9TErSBP2pwjE6MuCNyffquu09iqvECTvffz8bJkd+rYhZAwSE7xrxVesX1D4vxAn3OlTV5b5NmgegKqdWtN8CACOdXwtvxYUBA+VCo0XrP2rXoKmwG97JDAywaWsb1EmqV1PqDhc48pdO/+9463qT1IvwAb9k5MriRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IOrs2pO2EF/YC+A23sRpSscWWlqzIqnqayKhIXjsg0=;
 b=A20ZK/lSyio2NEM+eQGkmAtP4cqSK2oGvwWiovmedNHOEDnB3LQ2kBXfuJn2sAiv1gFYSg0Bi4+VUuHoY8WBBCBREfWdsBrYRsIeGyX96IJToSyFAKeq9X3FRpLyJaWok2QVmt8nB9iAVTFOUjeE1HexLN1gt+2rXOiPJBr+3kqRG/kyDa9rZtpqsE8fWE40KPEGmd3rMF+77o/WVNBDSBxc7pvrI+SSiAmrHX5XNQ8kKykBZmp/9UVG/pYqdXFVRsW58r/htVSyoDpxMSr04QHDzwrfwBHsFEx0IzlJw7oyLiM0S42rlJigRuTYQz5sPKvQ+wApJC2hp5OHJL83uQ==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by LV3PR19MB8318.namprd19.prod.outlook.com (2603:10b6:408:215::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.21; Fri, 28 Feb
 2025 05:16:05 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8466.020; Fri, 28 Feb 2025
 05:16:05 +0000
From: George Moussalem <george.moussalem@outlook.com>
To: linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	daniel.lezcano@linaro.org,
	rafael@kernel.org,
	amitk@kernel.org,
	thara.gopinath@gmail.com,
	dmitry.baryshkov@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	quic_srichara@quicinc.com
Cc: George Moussalem <george.moussalem@outlook.com>
Subject: [PATCH v9 3/6] thermal: qcom: tsens: update conditions to strictly evaluate for IP v2+
Date: Fri, 28 Feb 2025 09:11:36 +0400
Message-ID:
 <DS7PR19MB8883434CAA053648E22AA8AC9DCC2@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228051521.138214-1-george.moussalem@outlook.com>
References: <20250228051521.138214-1-george.moussalem@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DX0P273CA0044.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:58::17) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250228051521.138214-5-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|LV3PR19MB8318:EE_
X-MS-Office365-Filtering-Correlation-Id: c1a36814-415a-4729-b260-08dd57b70000
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|7092599003|8060799006|5072599009|19110799003|15080799006|41001999003|21061999003|12071999003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o/dIj0joIkXfEbk6BqkzIVAXvtomx9EEmYczQ1Miel64KhNchwWZBG/UYS3g?=
 =?us-ascii?Q?nosFKHOpCWGuTmaixKvx8z6+CnKFKWJ1pFNrBc5JN/Erjp96MjAWeLXadyw0?=
 =?us-ascii?Q?WZVVhqzmbhUBR+Y7kMpU3hCYKMtrcXRpplRuCgPTb9aDRMYWFg3u60i7PFPj?=
 =?us-ascii?Q?mkckaE8F7XrXawCir5UTkN68a2h+1i10a+HskEpUFxYLbYpFHIayFqiV7C48?=
 =?us-ascii?Q?Y7je3Do+Tvsx15jPCZZCiRWq7v8kr3wx6tG2yWZ0Ie/uZfbnvlm+0TGhTsYf?=
 =?us-ascii?Q?U1BjaJP2ltnmsjzbfhdmJXohtO4R+j7if6yyNf+C9dt2jQAgEdoX8xaeF+2j?=
 =?us-ascii?Q?nI1hgPFWzJ20d+TcVdv8DHVC4vYqBVdFn/VBfSaw9vdGbyGd8EYBfu+4lfcE?=
 =?us-ascii?Q?fC38o6IYAUGseZa946mEveRDWYzmfX4Dms4fJu5+86NcJ/CxJhA1xKO9L0a7?=
 =?us-ascii?Q?jb+Rc8VbAHTmmfWMQ47ZaTFm8j1163RncpXU/OT4N9tb9Q5zfrE7yEpr25y6?=
 =?us-ascii?Q?O0JLI/IeXppktnEFKcs8U5i7XrXG5vUtJGSBABqmQnohhARyzUPNpxF+UpYQ?=
 =?us-ascii?Q?EQjtJyulaQTp0vI1750t4dudliVVA7pjWdqI6JhgEedsmrhDjzizCroBMAAe?=
 =?us-ascii?Q?xgTlLoqmafdLu5dyEPVlZn9bAO2SEHPHf4vJUdEwGtPjtfRtnI6K426oCK7W?=
 =?us-ascii?Q?g5hl7ldNgb86XF7G00M4aCXrjEe74FZSgd5t+z0rgjB/KemT4EBcbbcCy18k?=
 =?us-ascii?Q?JANRtWLPzW6rE5nF3+AiDF49KdzRbPRF7F+NKRM3TsW22G6smVh3YvTCGkrs?=
 =?us-ascii?Q?9plfGDASIiStJo1thfpp2s6vLcmM9eRsxwzm8dUxG7mSDUxRDTrxB7VNMtF2?=
 =?us-ascii?Q?TVeVmBcOZ5gd98k5UKbxupod+tQU8t9G58gbgBEYHVusIjk1EVJ3Et9vwxpS?=
 =?us-ascii?Q?vRsl/x8FWTOGYFQNpt9PByWNYSdOWQXGOaeshMfNiRgtHFB1vFYB7EilEgM/?=
 =?us-ascii?Q?Ajnq+1jvH3SeW0uCd2yTPfOcCFEus3pP1d7KIBM8caIg7Y9qEJ3tQDJuseB/?=
 =?us-ascii?Q?iQ8dtMl0zMzb3XlGc/ftoO6749R7y2aS6QNyUKgI/aoN6nR2f3nSmZuzwD3V?=
 =?us-ascii?Q?ePV25vtzDQ5iLkiXrhV3DVMhXtWVbNwbElhrXm8kTS7yR96uzlSf1I012Gy9?=
 =?us-ascii?Q?DUHmiClui5bAuvjW6QJfOsDhyT99fS3wlyQIiQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EpSx7FIa0GlSM578WGyFaEND60YPBwl7cQRHHC72xndQXg9uDh64vNTqAsAV?=
 =?us-ascii?Q?fZ7so+XaYXRPTjUH2EuN5y8/kETZcqSvi4Rp64bvBkWNK7WCm+uVKchnqcov?=
 =?us-ascii?Q?3tJZmYd3Ve6kDCeLya1XEtjWpaAKR8f4WLvosr0LYa8AYHEtYhF8CO1kgUO8?=
 =?us-ascii?Q?XuBmheCJB7aFdjTAMPy17OOIibcvrcj0utMw2zbIJypyvkTN0HPPnke1GroY?=
 =?us-ascii?Q?HF5UBTVf/q5QZAxh5vhgcCvc3JlVwELLnxlvnDsybD468m37A0oU4veqhObZ?=
 =?us-ascii?Q?Hkl/cJ/RXugcuIViK4vh/YqjxDNYiGQa+AzhQ+Tgxx9RkdnGG8TMLqIkOBfi?=
 =?us-ascii?Q?KPBvqLinHbyjDryiDCLUxr0x+hQI/9ZWmdwqWepFIT52L5x/pYzuvNGAeYfs?=
 =?us-ascii?Q?9H/CEFHwaORT/Qhxy9E7FOr4NxZdS5cn99ALq3csKXteBOtbotmkbX2uZJI/?=
 =?us-ascii?Q?O8QJX1k/PuLh3DeXDk8xS5IhfLg4NOACqeAEVVIC+hxWz553TZMuS6EVP7iw?=
 =?us-ascii?Q?yQH1tRY4PyzsrAMhkI+ThqtJOKC2p3vJxs08v8J+PvBtUHz0v/sNiUPwEOdn?=
 =?us-ascii?Q?QfhEqMnqKgzZwxes80OU7vr1xio4WVMYs2LIx30WRepADEWc+4z5L6gmevEt?=
 =?us-ascii?Q?r/Tvymra+P6WZfYACPIa+hGbR90vWu+utrTRQgd8a42h7fV4rD/5jbiY26Kw?=
 =?us-ascii?Q?17Mq4TGPxENnlU+JwEfz8Zs0GULs2NfIM7BzrRpDrWlB9uN51N9JC61y4kg8?=
 =?us-ascii?Q?FUAx/m87mo3pwW0GlZ1M9VhknORaHPuqd9J37IPHyOa39Iz585mAZrAoK0I5?=
 =?us-ascii?Q?YflwHz3B9FGC3YC2KoabZhjnArPukHLqj6VVzXGw477J9LPIU+T+HDIr1BZ4?=
 =?us-ascii?Q?Vl5x+kWUY73xTq4uxnj4GX1IArWeTCvaAcZCtXjvrk0Q/+9aH2SpKiQ3n7io?=
 =?us-ascii?Q?CAVtYJr38Y5p+eD2ksbqNes3tAuRRday+GOOJpGFqj/pQTZS8LkX9ENMJf2p?=
 =?us-ascii?Q?f6nYYgnHEE67WDdr8oV+15qtWYJLgTCBZqesstfxDHoFRr5SkErUEmnBU1lZ?=
 =?us-ascii?Q?Zom2x3WpozjyXCWy1ihym4y8MUV5C05WNFQO64p4ZSsL2E+3Q9XMFKMibXis?=
 =?us-ascii?Q?Et8LyCMw8e4NQKmCP0lAIgsGlpy8qqveFaXwqDfLvAQa6LOH1Pe3ym3X2ycK?=
 =?us-ascii?Q?SRPT//RNn15Ac363r8yWQmU/qyfdOG5syQThX3/gJ3fs9AAdkT6BGm2Cteyh?=
 =?us-ascii?Q?XD0J2n211DWwAohvG2+U?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a36814-415a-4729-b260-08dd57b70000
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 05:16:05.1882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR19MB8318

TSENS v2.0+ leverage features not available to prior versions such as
updated interrupts init routine, masked interrupts, and watchdog.
Currently, the checks in place evaluate whether the IP version is greater
than v1 which invalidates when updates to v1 or v1 minor versions are
implemented. As such, update the conditional statements to strictly
evaluate whether the version is greater than or equal to v2 (inclusive).

Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 drivers/thermal/qcom/tsens.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 1f5d4de017d9..43b388bcc7d6 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -447,7 +447,7 @@ static void tsens_set_interrupt(struct tsens_priv *priv, u32 hw_id,
 	dev_dbg(priv->dev, "[%u] %s: %s -> %s\n", hw_id, __func__,
 		irq_type ? ((irq_type == 1) ? "UP" : "CRITICAL") : "LOW",
 		enable ? "en" : "dis");
-	if (tsens_version(priv) > VER_1_X)
+	if (tsens_version(priv) >= VER_2_X)
 		tsens_set_interrupt_v2(priv, hw_id, irq_type, enable);
 	else
 		tsens_set_interrupt_v1(priv, hw_id, irq_type, enable);
@@ -499,7 +499,7 @@ static int tsens_read_irq_state(struct tsens_priv *priv, u32 hw_id,
 	ret = regmap_field_read(priv->rf[LOW_INT_CLEAR_0 + hw_id], &d->low_irq_clear);
 	if (ret)
 		return ret;
-	if (tsens_version(priv) > VER_1_X) {
+	if (tsens_version(priv) >= VER_2_X) {
 		ret = regmap_field_read(priv->rf[UP_INT_MASK_0 + hw_id], &d->up_irq_mask);
 		if (ret)
 			return ret;
@@ -543,7 +543,7 @@ static int tsens_read_irq_state(struct tsens_priv *priv, u32 hw_id,
 
 static inline u32 masked_irq(u32 hw_id, u32 mask, enum tsens_ver ver)
 {
-	if (ver > VER_1_X)
+	if (ver >= VER_2_X)
 		return mask & (1 << hw_id);
 
 	/* v1, v0.1 don't have a irq mask register */
@@ -733,7 +733,7 @@ static int tsens_set_trips(struct thermal_zone_device *tz, int low, int high)
 static int tsens_enable_irq(struct tsens_priv *priv)
 {
 	int ret;
-	int val = tsens_version(priv) > VER_1_X ? 7 : 1;
+	int val = tsens_version(priv) >= VER_2_X ? 7 : 1;
 
 	ret = regmap_field_write(priv->rf[INT_EN], val);
 	if (ret < 0)
@@ -1040,7 +1040,7 @@ int __init init_common(struct tsens_priv *priv)
 		}
 	}
 
-	if (tsens_version(priv) > VER_1_X &&  ver_minor > 2) {
+	if (tsens_version(priv) >= VER_2_X &&  ver_minor > 2) {
 		/* Watchdog is present only on v2.3+ */
 		priv->feat->has_watchdog = 1;
 		for (i = WDOG_BARK_STATUS; i <= CC_MON_MASK; i++) {
-- 
2.48.1


