Return-Path: <linux-pm+bounces-22660-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C57CA3FB11
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 17:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2EF27029A9
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 16:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E201F3FE2;
	Fri, 21 Feb 2025 16:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Nkg62NeG"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2109.outbound.protection.outlook.com [40.92.19.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B9B1EC016;
	Fri, 21 Feb 2025 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740154282; cv=fail; b=Ouqx2spoeSIGpnzh2LUFCDCtLDqlEO13VAJWyuY1TBvaYfC0lX1HkflvmNH23VrB2ym21vkVhg04QyY/scqpOQ2D6tUS9lD+/70OomwNE3I8UakDV9Wh5ujmuOTIj2rTbcoxmf9n+Gr7GpRKwK8xnleB0vEWdLpCNuVkadg03Bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740154282; c=relaxed/simple;
	bh=y5/GfodOADYBuUi/XJZOIjmzHFgFGiQp3RDcUdbfcpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VzwMR0MW+9Ico9l7Pd+eVz3TIqRgXC0CXSFPny9keLT9LXqN3nV2J1qFtdgSnFaexETAvigm1yfLZ/qFp5R7GhhwroRqTwWiDPTL2CL3g+AqNhA1ZmjW86Cjf5536lHA420pWCw428RTTndfya6SR47pB0E+w/tnmVqW6IFf6TI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Nkg62NeG; arc=fail smtp.client-ip=40.92.19.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m01VzMQSb1YLTj5QJ1Axpweur06ne3er2PZ/VYppfbSwfzWhCZuJ7NNz4x3fqOBD6k7RNZktdgunSi1E2K8v3RxiGsyr9oibXTgnIpOxAimLNCkyHeWS9t3fb+9J9n6huDLknnT1TcMsQ51nILxnCBm33XpYklT2hl14mw8dxuOPYdgmUYUMasZ8CqCN+sI7xLmUEjR/g75cQukJICvIO7h8wWvF8/CU21CHtHcRTtfwiLcpctD3VDBZihEnyS47cDBOFcnTYR1y4mcZBquN/zQNJcz83XCFuXYBtbj10DFUdCcwxcRH/EHOGGos3ZBkglPwelwJqoe8U+BSXQejyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/EdbcgUAQZOKmN/YsPH6pyb5rvfRjPLhk5+gDF0YYE=;
 b=jWqJV33DT73bq2SKGyWF5cpz4C8Gx6dKIwxn+XXcd5MMcO9OIa63+EBNpVh+B6cWMGgY6qDFwdKrP2Asndv59/z4UHsr3SjWSD42AygSSuxxKQOqBKL56DrF7vx7gSvv5UikeDia1vJgM5eHrUunT/Lpk9rrVcBnJ7tckt4g6qMORfzoRJ1gYZlYpKMJ8zh6bQEjNxNmxvjhQqXhZLQVqozjZg4WlVQfEw9uMKEnnf3TvTuMTky5qDDH/99AI/1CKdF7G7vL45pmNMIFZUis5Zy3pZqOfYs51OEGilVY18cuJX4aeam+RWolKHzMEuo8RQDBZVZwgiSVRfWFyLQDoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/EdbcgUAQZOKmN/YsPH6pyb5rvfRjPLhk5+gDF0YYE=;
 b=Nkg62NeGC8dBcda5cU+oeVTE8v0CWyDmWViucT9d1F/hTyYXV0Dcxfn3RpwbR2zxmd1tDhDQnqH7YrVvU52EXoE+wHZ61ea6JBkc3yIKqhjSMX/Y/15gl6LHqIEK3YwySm3vhTveo4jWaNJMuXY/V12DaM2uBy1skfBvGTcO2MejYlbct7nT8vQF9qUDS/f/FdMEAyiB2jvFhdnXS5GMGBqHs6lrGTUGP3AUSGTA+Cf5ipW4xfb3IhODAvjeYXA89o9n1bpCJ/nF9vjd5lMj/Gxe1zC4C+hReoXKss21k/MdcowPKXzKwhTen8jvje/2lXZecvxjtehwMx/sr7OJRQ==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by IA3PR19MB8736.namprd19.prod.outlook.com (2603:10b6:208:51b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 16:11:15 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 16:11:15 +0000
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
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	George Moussalem <george.moussalem@outlook.com>
Subject: [PATCH v5 1/5] dt-bindings: nvmem: Add compatible for IPQ5018
Date: Fri, 21 Feb 2025 20:10:57 +0400
Message-ID:
 <DS7PR19MB8883D5A1DCD11909775DFE2D9DC72@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250221161101.17204-1-george.moussalem@outlook.com>
References: <20250221161101.17204-1-george.moussalem@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DX0P273CA0056.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5a::18) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250221161101.17204-2-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|IA3PR19MB8736:EE_
X-MS-Office365-Filtering-Correlation-Id: a0a690a5-e0d2-4fd1-aae6-08dd52925deb
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|5072599009|19110799003|7092599003|15080799006|461199028|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a87caRCmeLsG45s3nMzzRoD5zsHgNxfM1EGEad6LkN71p0IYBNbRm6s91kTC?=
 =?us-ascii?Q?h0R+Tjv1VtS6WynITgSUAIVZN7jH8PgVL+m5IyU0XBhqL3PqkTom8kvL+HbW?=
 =?us-ascii?Q?Os3yfMgNhy37UIJbUglHt5ma4pzlvmyl0Fmiz6g+ei8ATn7oIon8xSfVPsFI?=
 =?us-ascii?Q?57WfPxK8U43Gy2q0QH+9PfzK3jiA1oTyqKx3w8Ij3d6wdGIKie/d1oJ4Foey?=
 =?us-ascii?Q?4eTqRF+5zEbuxytYo0I4VZMIQi0S3f/VVJmVvKpYpVzO75JSQOvWlIrc5jwq?=
 =?us-ascii?Q?pzFnWBx5COWe+t3hEiY36wq1l/v1n2BWATUHNGAiGqqMZK6QAjCIRcuOfEyJ?=
 =?us-ascii?Q?8ReeqbIolHUtPokqOXPZrU7n5ac31wf3LKd3NHMCGdokrBqQVJVrCYB7iBUd?=
 =?us-ascii?Q?bxoK68laFDcFHD1xeKSPmiPvcGdFfo9U8rYQ0fV6z3uSdYwHPbUqMpZEN4Hq?=
 =?us-ascii?Q?r148agA1JoNx/c1/1GJ8jJjTpdQXgS+vBnCqnu/g2qQnUl428rWe1Jt6RlSK?=
 =?us-ascii?Q?BYeYnlk0BgJ3b9cdAta28oTxuqqUmfOTZo5OzeArUW8GgsEP2dzoOJCNrb6d?=
 =?us-ascii?Q?ooPmaMWN3z0i1166jFrMWc5v2ATcD3e+77/dedwvPOhbqtNaDsLARhF6CELP?=
 =?us-ascii?Q?o3mdDCjvhUM/DSg1/IWktvtL3I6eeGlUnToY1HckiigSnoTpL30+WRfJR1Tq?=
 =?us-ascii?Q?cMVf0TySwO5OsaEXnaDZl2GwuYiMa+9jDkjap2fR66+56FUKsk+LhG4xgVTI?=
 =?us-ascii?Q?Mp+3CtisZZHRyl3cB0K5xJJ2VHLbcDrtp/nBDNI+yn040ju1ciGxp3ff0742?=
 =?us-ascii?Q?6fn0XDAeXRczdFdfh6rYywnTVrdED3bTHg+mxUJM3HcZstEFfaRBRTk5+Uey?=
 =?us-ascii?Q?RsV/ijKazOSUcrr0l8Cc5QZ1ka2NpNjR6Xc/dR1l1dfB8AgZG6KMjrxzas7G?=
 =?us-ascii?Q?dWSTyD7DWedFMz/c4lcIlc0C5d3zrnwtmsElp3gFGF14z8kc0LYFdqgMrJKw?=
 =?us-ascii?Q?l9PQOh+eul5lR8lpnUOn2nSFkUL4/ekrTMEGQQKWLQ4SL3X7zvx69Omysedn?=
 =?us-ascii?Q?ljhnq3xhp84MSK8O4Fs4eMsZX7E4R0Uxi8zDtxn2zBetij2/JM0=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PyAhvX481FYSFKyXoWR4GKfLkyiaZPHb2czxbM1pV8Rz1EV7L6/oVxQFzlOC?=
 =?us-ascii?Q?xc5rXYQsSxs2hNOEzqlHsW2PvLZ0zyzWJDVlO+aCg1j2eJYVVUA+gN3DwvDW?=
 =?us-ascii?Q?kUYqf/CkkSbzIZ9m3LALDLHhUgBEhl+YDki96umXc2tPktStMC3chwgWw6Hv?=
 =?us-ascii?Q?UiIvHXKSlzIcXbM6Avt5BDLyLSS0d21wlE3wHiQ3XAMhg3JGbjNDUHerMWux?=
 =?us-ascii?Q?/pkhGdSKx0ohC8SuBTtdnnObbnBwpVypTbCFWV9dpBiGqr9Jkt4auqu5qMVb?=
 =?us-ascii?Q?Itad2BxEzkaJqzfzmkOKILmxg726SOGFZarI1+eYrOw/u3fY63irZS1poNue?=
 =?us-ascii?Q?maXl6w08WQ1n3AcHlo//PR2tIS845APKhsvN/rIKOcJw/7phI5gZf2zzokVR?=
 =?us-ascii?Q?0jiMMEr/NM8bDuJjw0KmKqw6g3GY7jNqj2KV/JpaCllgCtF1x02+WmPY/ljz?=
 =?us-ascii?Q?oS+4cIe8Txo7tGaWVtMR48Yy7+CSSmsgMJt6DYrIAaiyizHJDPnvsEcJow87?=
 =?us-ascii?Q?R0R3D40hBP6Jxccpo8rA1cDLk6y/HQSoj8Tz6sS2aZFZSSGehh3HXYKNoJSi?=
 =?us-ascii?Q?5fBvax43qCij4J/N8uxkbBE0lEsiD9Uv+X62k7KdgQfJf2P8OyGeU6gmo2/6?=
 =?us-ascii?Q?dMxUfUwfgeHPLXlF5NkijgRO3Qp7TeBD77vIucpYxzkcPwyuQl4sZ/dCpTdf?=
 =?us-ascii?Q?3VjNflL2PcHjritTd6lJZv1+xAHoV9r84WFMbRan73VfMrnD1iNgT7e5DZhd?=
 =?us-ascii?Q?ZjhFPQKYW7nsoqdoi8JSs4+JKZNjIbbZbIBa4Vk+XyiDDT5oIu8rb05FHFFO?=
 =?us-ascii?Q?nYozfa4HFHVwW+Uqv3+CdPirFEGO6Hbc7wYzgIbzB6nKsGTavCrLb6ln+lO7?=
 =?us-ascii?Q?Tk372ga2nuyt5uRFta4KiklQOyplAj0Q30ZiC3A8FJ4LyCJ13ZHBpkWzaLD0?=
 =?us-ascii?Q?TLbAjkZHd40rx/DcbanqrC2fPiBxoIFR40KBtmrJ7QSrq69FqW5U32JHPwDv?=
 =?us-ascii?Q?ZXm1XtySnhW3VQ6NY7m22Ume2l+SgeOgBxkTtbcZBp4AsVb8faL8+WaTQCDR?=
 =?us-ascii?Q?+VPKXA7rwYgItqEHBlhjwGizsaDLQ4nEmRuFfhvfyN2Naq2UKhdto4Iqy0rN?=
 =?us-ascii?Q?gGVrMlmK4BFbw0eXI93zahQbDz8NwuN5QDq+WIpgxncrfiM8ojX3VOyotYlv?=
 =?us-ascii?Q?WegXxz7B5KQzvB0ge+xBNlHJgsChmqf/6ah6cHDCkmio82mtLQSxRX0ElB7c?=
 =?us-ascii?Q?hzInFrVCtVTxgQsXUOiu?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a690a5-e0d2-4fd1-aae6-08dd52925deb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 16:11:15.5909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR19MB8736

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

Document the QFPROM block found on IPQ5018

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index 39c209249c9c..de262f3153ed 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -19,6 +19,7 @@ properties:
       - enum:
           - qcom,apq8064-qfprom
           - qcom,apq8084-qfprom
+          - qcom,ipq5018-qfprom
           - qcom,ipq5332-qfprom
           - qcom,ipq5424-qfprom
           - qcom,ipq6018-qfprom
-- 
2.39.5


