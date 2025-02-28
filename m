Return-Path: <linux-pm+bounces-23146-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06011A490C7
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 06:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B22F618934A1
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 05:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2311A8418;
	Fri, 28 Feb 2025 05:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="HMEciAg7"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2027.outbound.protection.outlook.com [40.92.40.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FCE632;
	Fri, 28 Feb 2025 05:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740719760; cv=fail; b=HJCDaAH1nibs2HhL3AGNSTHzmCqEFRB7/KQyLmy1u3Op9oDC1Jwq5Jr3xWqMSHQ+EesJY8ZPfAF+LccKCYbblAVomH0aImSsD8Q7eHEjqI/TCbb826gsfuuwE4o0thi2o+OcJnXu6t0oUBSnDMU+fq4Tdf/MC+Dziw+0zXFCiyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740719760; c=relaxed/simple;
	bh=4W8AToeSAniUgIeWSrkw+QIyEfEFa5KNJcZfOQN7qIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ppRwMWcJ/ThgQl5NYKI/bOHtelQM6qvEc8Np9h4Hm1HLZ3YrLh6Yr2bVJB8QBTWaT30RaYBKU6jXqb8geTBCabj7PgbwZeH9+4AGm0pQ6s+fYuC1vTxbo7Otmoq0YE8yNxKme/a6xFdL679w1jA2zmqyUS+48YKbtrzt/btkHlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=HMEciAg7; arc=fail smtp.client-ip=40.92.40.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UxgTl2EnADjKjtlLlXdsakX9ZW8KsFtjgF/wzts0ormiY/CYRGh/mpjt6tFpF++1uc3wM+512gVBSu9mlQ7DOqf5oXYhcK3cAEvSkF2S0/kpOKjztsuqT3JpYOzdCNMWOIjmRxaYBsh9p3rDhlzDFOU/EshdYELzqf/f0Sdg/SYWivJpOS7AmUWJGTA4yopFPoIVCpiz76XAAlhiWyz/K32Tk+8YsTgLgTIYKn7+gadcsPkzn1vFbKPpT3nABtjzEC6UT8S7XcvGlYLtzfuXqETYZPxo0NoZtBfVwNoJD96lplr7VTnosssyH9vB+mt/mGZq3/zviFUgvjmupllBsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYzEb5vhoVlcsGihzy6imGYRwS3qn5QacjAXLwA8oSU=;
 b=fI2StwaoUN0eteKRo5eAzuhH4IRGcKSqSElSPeL+Y86zhzpHX9Dbr6887sT7rs305MJghSH/Tp1jrpeaXs+XcO1pjGNlDnRUBl4LEqu+AjlR4fq1V0Jl97pgKS6AIsQGVwtOjQCRJ7r3YSxTw1Zdo3OJeSxZtaa3TLJrnz/co2E0fXSRUbXrdHsVti6a1wOLawS8Z3nHn9XtslR/LKmYrQ+LXVGO7YNztU4hQxJGEHqcor6CpbioLjxqpC0bHe6VIRqA6F+6sQP4IhVPeR6n7ZaQKm93Iw+0WckO8Sdg7490/6J34sLLoTf0dbK0a+dgcKAuMTToq1bP1jcEheFWkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYzEb5vhoVlcsGihzy6imGYRwS3qn5QacjAXLwA8oSU=;
 b=HMEciAg7pjYk6zPj0q1Wb6tKk+MEihJGpqfckIfhozL+FMbTTOQFi7rRu8aEbZwl24V/UuvXS/FS9pUSztQ1BFBx4js7am9+HsLInjR7y+nRkFjsJMzJl5/FwtmTzJ9AEWbBTdMybb7g2e2S1sn5YUcDu9DtHjsNYb4hk/Id8f6gblfoQZYtbMNJuJHrnlczOx4aq1hg4HjxehnluHFPLBfqGd1SXIvRhUhC70HjGpTh0QEDb5QHPWFletN8IxbYVMqnEwMDnXknv61vsJyMzDi1NPBshoZibL+sKFnMLcBO/CGhwF7VK1ySXhs9f1I2Fd+L0TCEI/AiNb5i5eXrUg==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by LV3PR19MB8318.namprd19.prod.outlook.com (2603:10b6:408:215::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.21; Fri, 28 Feb
 2025 05:15:56 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8466.020; Fri, 28 Feb 2025
 05:15:56 +0000
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
Subject: [PATCH v9 2/6] dt-bindings: thermal: qcom-tsens: Add ipq5018 compatible
Date: Fri, 28 Feb 2025 09:11:35 +0400
Message-ID:
 <DS7PR19MB88835BD1063C4D5451E14B0E9DCC2@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228051521.138214-1-george.moussalem@outlook.com>
References: <20250228051521.138214-1-george.moussalem@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DX0P273CA0071.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:59::14) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250228051521.138214-4-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|LV3PR19MB8318:EE_
X-MS-Office365-Filtering-Correlation-Id: 9362ca64-2b44-4c06-efc7-08dd57b6fb16
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|7092599003|8060799006|5072599009|19110799003|15080799006|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jH4D2jmGrRkntAzlZet6RwnXIw9hco19heU4E2+jdqGAo8004AQWBlASA0tj?=
 =?us-ascii?Q?lDPdS3Bn9nm3HOrwiHPvEqByQefai4/YWXUBFb7LNxF3QOyjTwMuuvDLn0yk?=
 =?us-ascii?Q?cloXJhA3yEJ7ULCpwvyIgMlhTGNecidifxC7eLuY5NZbGf2cV6k6mYPKNx7t?=
 =?us-ascii?Q?HBCQyZT/K75D1e56OJiU5pPusRst0lTJcHb2q6uh9mR+QlMnKAySOEYXCI1R?=
 =?us-ascii?Q?LtIIIuUoCuYyAW3a5n8iCOwy3wogcEwTzOAGEzlT7aASo9PKC7w5JvgdZG/U?=
 =?us-ascii?Q?p+zWC0XQSvM13fDC6bFIEZi2436JNqH1DmqmF4qlPEUTj1ItbPeVYkVFbZ2v?=
 =?us-ascii?Q?hiF65wAR25FIT0NYGaS0VogeIRVpZ5qkxB7+xQTJIEaia2pwwofDQK4uptSk?=
 =?us-ascii?Q?ly3ZU4H90ReUfhDHCVRhKDrw+beLny76/Jxky6QwPCNhPrG+jX5lYm9x6g1F?=
 =?us-ascii?Q?zQi8YZ+M801j0w07wALU62YtnCx24NN8o2bnbQEmCPASDStoSAafLSzOPhlI?=
 =?us-ascii?Q?mP6BoVAmAJN2jrDPaTexqXLAWiPGzI5GiP2IJFNDGfZnLZR7sT55kBHxMvQx?=
 =?us-ascii?Q?CY72OaRK+Es2dM+AM0VFIv0IqggLFELHP5EMLeLT4Uek8HpzeXTTI89BKKMN?=
 =?us-ascii?Q?IqEgn0tyedM8XY6BuSiqEqM+7IbOv/OzDkAZUICnT5MchLI1oX7A0Hcetkaa?=
 =?us-ascii?Q?se0KF7Y3MAfBLtwJ5CykUmj/qvD0nKJRA6wkC0MYFTaxZJcKJ7r+uxtsQHes?=
 =?us-ascii?Q?BVl5+FQkeIju9N3kUvwDzhTsI5jxbouYrc9elEOorMTv9s5H1zsOEe63v0ai?=
 =?us-ascii?Q?MiX7f2E+1hnW5fkT2P1FlygwMnRBWSUiDkv6m5qsgNIUpSsPGOaxdt/pWOrW?=
 =?us-ascii?Q?NCb8mrPLSS2QFVCXOIYMuMVjgv3hS0RJRp+/OB2janG6Vl5im94HmWtVdxtL?=
 =?us-ascii?Q?wsdwgG5Utg57y4g2veayzUA6n2IVJRIQ32qJjrIJm77Z3meHykf9ztKU0raJ?=
 =?us-ascii?Q?VqlsjQpBgpEISa/5PcKHh5328+XQpykvZEzEVCuy9og1s1MA9Z0m3Cm8mUDh?=
 =?us-ascii?Q?eQj19sxTJYweJmgGhnnjVLFEwDzEMih7YlhrtC8jlZd2jMttR7k=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gh8qubC8jeZfYrwbIpMydmo/vdK0nhYDrp/SD7lZ2tJvNcMRXgIMzKNJWMLl?=
 =?us-ascii?Q?eP/ImEiqevgGuPPsN4ccMJNGG3dcvNSD74IR/y6j0mqurZb0MiA+Tfm4B+OH?=
 =?us-ascii?Q?wsrf/nozIY9/eY568U1FNjgSC/nr4ObsoxzZ8LUcJaTH3SLxudYKv01F1NJ+?=
 =?us-ascii?Q?3VGwJlTo3Q8YjjS0llVd/MkWk6TjNwEZT5aMvhzx1lEmEcpIwCW8UC+O+iER?=
 =?us-ascii?Q?wx2uwAhqGnlP14182nqWA3vsIFMtxj+DxhlxMB8zZ2vrnefJtev8xr12uYm/?=
 =?us-ascii?Q?DtxNgu37F9Uh0+hBJTTB5y5hoZopECOgcvpgRdAYVWz+T8FJMmltp6Ib4Zz0?=
 =?us-ascii?Q?tXkhnq86OfuapESiJygl+aI9pttIFph20AWHQRNqYpt3z68SX5rva0TfoZjL?=
 =?us-ascii?Q?VcpmGC5pznyM7QFsBJyh6oAqk2hjdtxkIR4gC6Ch/MKjToDZSWosDimJAtUL?=
 =?us-ascii?Q?R49tKdSnh5SiAYtAUbKjxyQxsRxY78X0RXIu5M41aJL2r6xg8vA0qWxQIjKU?=
 =?us-ascii?Q?0hapKZT7wN2CDEjzSA0w6HHOHk8HyJMGc+eG8tIW1FsajCteFDb/WQxTVkFV?=
 =?us-ascii?Q?SSOBISZ+nhx7pQeyMhWAFyuXq+k/JNv8OP0oHIk17rhEnAXsEVnDWneyBb5K?=
 =?us-ascii?Q?No5JXtL/Nf5wgK1m8qmyLwba9TvfXXpelbelAgUWbMwogEmuZ7lwrbeX4U+l?=
 =?us-ascii?Q?oZMb7PINr7H0nhvAHGjPCbNhRTMPI1iS1h6fSJoJHw6FlFKioTuHkzrWoeR6?=
 =?us-ascii?Q?4a8H7NZayv3o+Vil+QXp65ud8L28izoSi842Lyit7f/LEycyKKdAAUVnzi1b?=
 =?us-ascii?Q?aRr+8HLwfRdTPQ3wbf0FzMIbFp9rtZC8tveQ5MTRr6ic9s3/5+T+6AHom9Ky?=
 =?us-ascii?Q?zl+BoH7tmAtuMvOoFsYfbTLo7Udw1tXHnfdkhGrQdGWVKSJ7fWGtpVqZ6zKq?=
 =?us-ascii?Q?rkc4bwZ62Z9eQkPUXeofVrWZw4udoOP5IY+ythZ4IdpxPqSTwC5AlTVvzVrl?=
 =?us-ascii?Q?9G5Cc5Aainz5yRLI4ZqCr03aVDfxM4lyHjWcmjPjIxL5986gQx9G0SzQeUiu?=
 =?us-ascii?Q?ICdYFOZZw+AI9AX/KfFTMES/XOXj2eb/lXG5wK0K2ywtF4ChBNDbW3VKPMpJ?=
 =?us-ascii?Q?BXCMrEmef48d3EvggzG3Ccz9P7I6wDkLdeeQuvw10txyf/PS14ptDK7V44eR?=
 =?us-ascii?Q?fV4qQLXzrbB+y74sOkutBWsFeRqQNNE7bScfw80ADeBVBNrldF+3mdVtzx0Z?=
 =?us-ascii?Q?BEq3IlZzkfc+8Xs8Z8hA?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9362ca64-2b44-4c06-efc7-08dd57b6fb16
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 05:15:56.8908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR19MB8318

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

IPQ5018 has tsens v1.0 block with 5 sensors of which 4 are in use
and 1 interrupt.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index f9d8012c8cf5..0e653bbe9884 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -39,6 +39,7 @@ properties:
       - description: v1 of TSENS
         items:
           - enum:
+              - qcom,ipq5018-tsens
               - qcom,msm8937-tsens
               - qcom,msm8956-tsens
               - qcom,msm8976-tsens
@@ -251,6 +252,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,ipq5018-tsens
               - qcom,ipq8064-tsens
               - qcom,msm8960-tsens
               - qcom,tsens-v0_1
-- 
2.48.1


