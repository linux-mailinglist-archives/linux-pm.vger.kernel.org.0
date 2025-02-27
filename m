Return-Path: <linux-pm+bounces-23053-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E64E1A47B67
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 12:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F396316CBF0
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 11:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EAE22AE4E;
	Thu, 27 Feb 2025 11:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rAARq5xU"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02olkn2097.outbound.protection.outlook.com [40.92.15.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286F522B590;
	Thu, 27 Feb 2025 11:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.15.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740654303; cv=fail; b=KmQSAUIlripyI4AvBEhUMsfzURNkCMqeRu3QDy50nXSf94sEjEP2DKLcPJirD3bEwfzs3o8lpgLZMElOpklLnEbkJibFDHxeFy2YqubO8EYFz+dmM957ZVx9rMdQofROQI4QepMajcqfLM/kWdCUBDCs880+Bd6q2ayehXXmaVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740654303; c=relaxed/simple;
	bh=h9IzJNMFidrJQb1i992T/k5gaVHKZm6nEZWH+G/riMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qCVjowhEg0Wxa+f02TZpKspIqt/58IeDXYKm+BiKeXyvSZnKYbs56qZwdXsm16ALtiNZy1CzHFTD/iJx/Iq+/cNNUTGUqkxR9d2dIs4Y4qPrCf9TEQWmZDJO6ShpshuynSbsUTY9M5OkKQfFenEEq/vGDmHM7ZS7CShV8K08jg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=rAARq5xU; arc=fail smtp.client-ip=40.92.15.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQ7uZaiJ/X0A/AagdWP91gP4tZnwJ3oomyOpK4pdgMA1CDWL0TfIawvVWKsr3BFIjyuHcugfN5n/uKaWET+sbsPgmsQ0cMaONHf6Z7pabRGFMHbUQ+N9/kmbdAXNEFFosqFIuMll66KizJaVGAMQSBFodMwFal+0+HS7qP2KQZcJKauLL6JhHf6cdX1f2geyH/2oTFuZwsmYmhcfWC+xtnYhDcuT/eriGyGN6RkbzazCCpmpzC/40AaTDNV+N7kNIGkCbc4MDhR1U82bLldUm5/cK+IVGdxnt/9fFUosXzkDZENCiwN6xEY1mEbqw6lkCLKL7CfXowxI8nfbAfWssA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0meMMKvmI5jgnz6bOBgmuYVEZO7+N5tW7s6N2tVEUSs=;
 b=Ajz1666/YOBM2wgyIgxwqnU8+0HMYTzZpNddSop3WXG+Ftx/GNih2RJC4x9fP7BkfceIovGhna95a6XgPDVYINo6mgyVOvBTIbSwvIJtHwGjth17QKIlfVaZoTUQ1ylsiY8opApwukBTJMUj8ZWAK9dJvPZgMC0RKQ4dfzKOtUvjYlkZk0noT7NFMw3RByZAruaumW/VsSFtrRuoAqjCxSTnmjQCK/545Ai9DoyNDkrY3WKms7V+SQKPBW7ffuAHl7rn9y+qdJ3+GjARyRMXVk4bo2ZK+3id0F8NLUlipOvSGyO2q8XyOCy+2hOxYV6iFSvQ293OSVypEsDDSBH4SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0meMMKvmI5jgnz6bOBgmuYVEZO7+N5tW7s6N2tVEUSs=;
 b=rAARq5xUTbo9C02aenFPuMd7W9hCA+vcdvGrjqcmVXo5mix9Reiq3JNv59+S/hq27SgG2F52sZHtgs//IrSlGmq/Q1WRkRN6vdKvw7/IZxQsJ1O5BvcZ41FNwf464xYQrWsp4dlD7FnABb94560pWm2lkaikhUy4NWuPMAh4a3TsYhbObEum8PEAggdGF2g4MdBKzGiI9z+DIcMApBPdItrMwUqBJLp7Mgf/fnCkuy38lQggoL+YTFkg6qsjckc5IwWv3iTXoNAl1f84C8fiQVEey3JaVSgoGbe7uU/4Af9eecCQq2duIFzEhundHgBR0im+2Ablk4b5pWae4tv6Fw==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by MN2PR19MB3949.namprd19.prod.outlook.com (2603:10b6:208:1ef::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Thu, 27 Feb
 2025 11:04:59 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8466.020; Thu, 27 Feb 2025
 11:04:59 +0000
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
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	George Moussalem <george.moussalem@outlook.com>
Subject: [PATCH v8 1/5] dt-bindings: nvmem: Add compatible for IPQ5018
Date: Thu, 27 Feb 2025 14:56:39 +0400
Message-ID:
 <DS7PR19MB888340199DD2D0159190B3E79DCD2@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227110423.8418-1-george.moussalem@outlook.com>
References: <20250227110423.8418-1-george.moussalem@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DX0P273CA0095.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5c::11) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250227110423.8418-3-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|MN2PR19MB3949:EE_
X-MS-Office365-Filtering-Correlation-Id: 030ba2c8-a040-4b5e-0919-08dd571e9340
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|8060799006|461199028|7092599003|15080799006|19110799003|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j4Lw5dgDJtoIcfSQch5tS3e40EdbVMsGVZtrMZ6jKzzEyV++L42Vv8MDJF66?=
 =?us-ascii?Q?GNBRxZjO35jVkrSek1hvh6HWkNtWkUWpQ9McEcU1usc2ML8U92Hu0qs+5yOx?=
 =?us-ascii?Q?9oKJLQV66485IzCHQbyOG8iXVmqD00csGv3Sm/SKjqsG4CHwqZOeyIDh7CEa?=
 =?us-ascii?Q?33aUTD/RXuu/FYg2u3S710y0uqY/+MqxeZVFs7/SfkqLwJSA0IZmk4dek5sb?=
 =?us-ascii?Q?/5SLbuO77K5ojKEQFHYmCIDWJX6S5e+0DVmXtjl8jd5z9blfgD8QqD3cwPpj?=
 =?us-ascii?Q?qNEHi+3xQaJVbIXeH0EQokoFl3neSMlXfR0/op3BVclAwY/cEmYtDU0q3IBY?=
 =?us-ascii?Q?hObP++4mzZWmCAi5CXlInzgE+iIs+4rruKxAxnyVoaJ6lbXFJrbgB3ymv/Q1?=
 =?us-ascii?Q?FNAR/sxK/Z7pKQNl/DQAw+J7JsIY8mUPTLxHwQZFlKajHwUllcYr++Xezu9b?=
 =?us-ascii?Q?i79av1RcOIhJhglIf+Xglz7PaqVCYFHyZUNwdjzttybo2uK8GPRWMYnVB9Er?=
 =?us-ascii?Q?M0hEcZAZoyZbwlBNWZDG5SpFkqHw3/BUFXYtyVOQXbZinb2UfDJOuTB7ss9J?=
 =?us-ascii?Q?ADba8carcjkvDNgPqaZjqiNcLRuEvbLvTWGuIcBsoVf6Ena6KXSVFl90622C?=
 =?us-ascii?Q?a8WoA/5kUJV+C3VGsf8HTdj2RWgT0iMsv/T7QZIN+XRYI4yAKOsNbvbYM3Of?=
 =?us-ascii?Q?NhLggohDtDKxg1imcp+Vm72kKhGEYQz6JfSuom4pWrjEEy1Glo/qhhPjTN8r?=
 =?us-ascii?Q?ycxHl7sja/lxXmBXwuSLFchQbg+EHgtrDWRK9GuWfkPptCYOlnycTJG5L9hN?=
 =?us-ascii?Q?GVJvBtFGxprA9NgVRRAVVUqgfJpxybjmd/AjbXfMFo4pWoSp0/dgDl6Pe6h8?=
 =?us-ascii?Q?YmF3FRoUOpG8tXOCB7J0aerI4tOtyjquawe26AZtEWyFjy9W5FJ29mZ721k7?=
 =?us-ascii?Q?aOtKdTedxX8qx0MqVL3Pc2v+fX3MaxshLeFEzfZ4OUPvNY33885Wc+60U2O7?=
 =?us-ascii?Q?owZuMvI+Gr93TmJ04lyPrnC/TFRcrVFqxGRDVpWm+mqG5K0qCRkJzJPm7SJd?=
 =?us-ascii?Q?01TUnaTBAr/IfUoqeSAvkJmTTfDtfZMP/JOKCPwAR+M0brtVCCk=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hSxZnLdFvo5WYOHo1fND/Cq3eVADC2KzJ0Lr3n+v0ty6ibqh6MYd9fBa/Q29?=
 =?us-ascii?Q?FdF0dUJOpgpMf+67PdrxeIpICZhgM1VVszfQjQfA2R4B9fG6rV8JLIIYW4su?=
 =?us-ascii?Q?L6iU2prr8P4aSp+UEckBOg/5VHdmZlrDG7uDNgsSMWo+5ZTUWS2x6YGxg/Nd?=
 =?us-ascii?Q?Lc0XzonrF313X4bQrTE0TLNCEL9a991F4Ostk/LPLECtqL8uVK2P0y2VGaSz?=
 =?us-ascii?Q?X74feJSbIfHlkWTowJQqDvfNIpIJIleokZJUmSaapd4kgqxfzJSSfDvk6Fg1?=
 =?us-ascii?Q?FOx4c4rmqLOtmAz71imf8tUrxUwjZG/vCB92U+0rGB6ShBywbZ7xY05JtqOI?=
 =?us-ascii?Q?HSSKzEhqzqSyxTZ95ERBGfB1VCdB3Qg9U3BxherYEhIiiaeSuCy+YtNm1/rj?=
 =?us-ascii?Q?CS5KRXejK92h9n144LlBBCdKwYEkJf6KXVla93g8P4767OwQfT5dOxFIicAR?=
 =?us-ascii?Q?H7C9mdanqMWFtBea7FjU5D7EPCVNkGPMZKKgFmpsB7IWA0n3CDGDNSIUZOKf?=
 =?us-ascii?Q?Kp7iZfiEEXIZEh0Xe2GJrwzz/9UV8OtDd09TSKDbCME42wMQ81WZca3vi4yC?=
 =?us-ascii?Q?CmmNSq+1Pz1sEuEbPCelCmTX5j8KKYKCo8rFxPV+Q7Kg5yHhi+4gNoE4X6Nd?=
 =?us-ascii?Q?WdtaLO2RoNRyvqLXItbKF9mklinV/QqgnvcGGAlVH2tOIECAv6CRKq4/8GAz?=
 =?us-ascii?Q?Zf1Sw9fsc8iMfN7p67yp70hOy43I+5TSXHmEQrAt0/v7HNXtwOPscSm1x2ht?=
 =?us-ascii?Q?YUkD1c1BODJD/c3LZJ1tvtl9vcj9KVSxbkFylWBPqQUxn5EpCZaUDabas0Ce?=
 =?us-ascii?Q?BvOWF80v09wpP0bBQrB5PkK0el20N0wnI864Rk/Agybgnxl+ymAzcNpRkvIv?=
 =?us-ascii?Q?BbqZ5o9co+OJmBB8jr14CeQ7E0aXv2ZaQo49b5lmZh/wBCTnw8I89l3KWVlY?=
 =?us-ascii?Q?91hvA4YgYOXj1zUn0WUrU1kCeRlKC/JQFSpUSyww0B0F3GTsZ548/8dxwLC1?=
 =?us-ascii?Q?99AclC6A9Ez6eSXuQbbQ6QEvd7GOLIN2OhE+Uh94MJoidu4coOJBdk4hDToc?=
 =?us-ascii?Q?sPwdnFqc1VnLzgFtNmuzoGF+JGQGLqGKBNNiyXex46tjpD2DdRGQJVGZ0y4S?=
 =?us-ascii?Q?Hz1/6VQg4c+e/biYsWj7ikQROHrLpZ7UDcpXjgtwzxIMRqh+ByhD4wSf+noN?=
 =?us-ascii?Q?5gWZgcizVGG5EG4R3B4SElH5A+5HlSWxWMfx/35TP+vKoPMbhmvp2ICNvTul?=
 =?us-ascii?Q?yCNJJSksAzgB8eMmzxTW?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 030ba2c8-a040-4b5e-0919-08dd571e9340
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 11:04:59.2133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB3949

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
2.48.1


