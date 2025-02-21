Return-Path: <linux-pm+bounces-22603-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DFFA3ED14
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 07:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A410D3BB765
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 06:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2D51FECC7;
	Fri, 21 Feb 2025 06:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="TUsKzbpE"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2076.outbound.protection.outlook.com [40.92.42.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356E41FECA5;
	Fri, 21 Feb 2025 06:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740120775; cv=fail; b=ihAS62au7Q9MMsE17C0ygaHmUlTLQyYhcF+0M8avYYVIYLAo5a+AqLVp7vBs6CiAhtKaNTp7jNr31Tt0ZRrAb+J4z9yD4TkWsnByBFs0Bsoo0fnVn/ijx5++JvynShmrEVTstsZX+ld3cl/stzaOHR2lJve7k8fQrTjYjNaOZGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740120775; c=relaxed/simple;
	bh=R0RCC0VJ3Do69/wRH764RdwqNBQVR6SolO+O3fftMvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SK2xLNpMrQKGUPawPzLQA517wRVc3LMsLX4JV8/tF8oQ0wG/pQ4NkHiR2AKRyrIsiDmWIc9j9jghy027EWvE9eHC68+heQwt4lZwL8ut2FCOg8bzSqgSEbyl9NCycxp2baMZudYC6m3D3CyEv6A9ynTXe8m6fkQzr8WVgAVWRjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=TUsKzbpE; arc=fail smtp.client-ip=40.92.42.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g1vwGsCooQrFBSSLviO1oqbV88NLe+PEAiiz4PQ9qK0/iPlMD6RDrVU2ZFu7cqRPby8lv/BcXvH3AEn+ceveXOKm03pOiGB/xYx46LPFo24lB/fcdB+ah1dfl918ThJl5dSnhcaGC+Yr6RwNY7Lm0uuw5gEvefZRcjUC4tK+5FfeoIy9cSoH/dW808Rs+qGu0XlE807hvT4QfgdPTUbLMoVDDeHrY4/mOIaiaIMDKEKk7M6cPFirJBuPE+5gr5ZIuGiqfcf2rWslNoDmA4D9a77G7YSmwdstx+7XKwpsfLzUlLLs9CfHC10En0+3gnRj+o36hJQ43HWVoVaqiGXnew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wE4urmM9MCtEXIY08mokCxg4+uoPs8yi38Vr9SIgJSU=;
 b=pcox57cO9Qg1SQVF89gcXMi/b2ZB2A7F05l4N8OH2ItUs+e9umhSZoXIxuPFrnujWcBzMPFpAts78ZUytpq2ogrR/P6PA1E1ViwRiRorvpDZ/ulFuVgbl3SVnQULB5706r5RatcmOxdy56X4c3zaS7Sk+HD8Oe8VjZRL0vxZxo3oEbeZAOcAj+bosBYkXtqDaKjXUblmEXpyYBGtj6ImYNTGXCOX25qWSSelyCwWQeLTLyDAskNE1Vz2+jPWr5tJrVeYH8bQw3UxBpY24nE9le5AdmHBR+eSejtiN7Da0gNejBabkku2U1cuRDRd5pQ0ogvEU58Zkj2HKs2VkBN4PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wE4urmM9MCtEXIY08mokCxg4+uoPs8yi38Vr9SIgJSU=;
 b=TUsKzbpEws+73c6K7N+5QSo0XmBnNqeKjvDmLDfgckFXq5vpSN4MlKq1Wih1H/pAiahj6VF4xnAgBtMZtZoaFJlSxwDLkp9RzkQ4bUD36NOwA6T0oeAbLUfcnlK6o8Y9rZdD1BljCEaPpy2EbI6u2Nh4PXLdVID/5qONHGGvUKbTUMMU+EU/dch4E1bMNiJ78aHrrDDVaZ1vDYqWLPCCXelGv4bVNJbuzK985b6vb+yTZaoVIze70XVcs4czNPuKrLhptDnV9kOnokpLJVWsvdywKQG8PtsBd1CTyr8pUpIEpKFPT2klI9To4M4BLGY1wdetToGWel+/DYQ+zJoLxg==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by LV8PR19MB8323.namprd19.prod.outlook.com (2603:10b6:408:1ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Fri, 21 Feb
 2025 06:52:52 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 06:52:52 +0000
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
Subject: [PATCH v4 2/5] dt-bindings: thermal: qcom-tsens: Add ipq5018 compatible
Date: Fri, 21 Feb 2025 10:52:16 +0400
Message-ID:
 <DS7PR19MB88834479C1ECE2B5D9CF2E1D9DC72@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250221065219.17036-1-george.moussalem@outlook.com>
References: <20250221065219.17036-1-george.moussalem@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DX0P273CA0090.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5d::17) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250221065219.17036-3-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|LV8PR19MB8323:EE_
X-MS-Office365-Filtering-Correlation-Id: b349340e-0ebb-46d6-d3e6-08dd52445c4b
X-MS-Exchange-SLBlob-MailProps:
	zZTkHIKWWP94qxx1m/VUOQl+zamCu0H8RUWicrcIKgtPh+DcMyQ88n65iHy8sKYkTaHQT8eF+Qs8KPTsj1/ABvPmG6I1yAOaiXhZ5Is8oweEZXbPvKsLCtNuA9jHJPtGnx3uEFKk08mYpigR9KHKh/2nd8cH8OHzkLs1HohbI/7SoT0XoiA3N3Kb/UUGwMyO0F2XVrJ/fTR5eTQ8L8BSKDNZWr2GSgx7uxC7LeDC5Aq0GB1JnTtTCYts9v1P8ABt07fjyURhGmychf1CM3QX6YoOXgCY0OhXS1WxawzarWLGriVBMHsiJgLr3uCBeO22TTKk7LSkxZSxm7gYKV2efUkfeNgRa09UvdJ9keyDk8qlzNciWy962f7J7IEIGztrPC1uC/0l25nbPyleSb1I3a7Vy5a2w9MMOzC4u78WXjFBBi2IesmVvDrq6jIigewe7CJdhoYx4YwgHk0Yi1doNGxBEogbmdEYsJB5IclO7HMGqytV3n8C+huNlDBe9mj1E+z3vWjzyays/2WGqvJFPlmegPGVBNkr/xpOmf6xGyVF2v40jXyuK/T+lLpf6lbToJHKWU7Kn2hJkEs+hOWejD+AtZ50ob/5z31K+I1BVr7TOlxej7jrSw7Iak1/G7NGzdONfJ/Xx2lnmym7BU2R7ThQDJ2dkkt0IWuj2ZytJtsqoUVAQybBZA==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|15080799006|7092599003|8060799006|19110799003|5072599009|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ks+6qwAvUS3Iw2fafX2qursOFPSaA1l1Ie7IzXrYHhOoemM0Mo7xq6P5+PEI?=
 =?us-ascii?Q?kbTt0KSmgjNqmhnsssnLm/lIOj6q1m1jSBbLUKkm6zbj0nvo+dWOUOKHCxE+?=
 =?us-ascii?Q?8Fmn4mXLUz0S4rDICN78MrR+qdx7I+Qy6lXCgGxjyq/2iN0vXB4OAp1kfRj+?=
 =?us-ascii?Q?fKxv//SKVG6AaU8+42hxITH6PcAEgD6pXJ7+jdZGx1Ag6NRSs62MLD6Wzp1Z?=
 =?us-ascii?Q?Ho9Zo73/C/o0+5utVx8eAYXx/HJllrKS+ntWARbLN2X9cjZfWbDRnx5UPDHF?=
 =?us-ascii?Q?35cATMa7q2rIGcGOmdW8KedAQcfpA8hkm7TL6vTzCICYp24/OkctkBnlvxCD?=
 =?us-ascii?Q?baYuQMkVZCNxXuA/S1CJY/zumJC1tRUglRZqYZexPfeht0AbuvzdCSgUp4hA?=
 =?us-ascii?Q?PxgZicb2CvVeg7mlBH0dDB7V7Dh4Mjdt9bbjLNo5KjG3dVP3861uO7NH1244?=
 =?us-ascii?Q?wGhqEMIaK9QOJUc/m++6ANHoCnKNwbMh5AN7j8Z/4CQ7qWKa4jJIKSCd2MJw?=
 =?us-ascii?Q?eU22uwM4z8byLBT6QjtXzOHX2dEdSpfept23dN+aRKxKSX0UXuCfTBsK7NcM?=
 =?us-ascii?Q?BvtH3KM2TzGy1HRiC6VnfAWvxUbMAHMYWULJa0fZJ1Pqjk0Zd+ko73aN3SEw?=
 =?us-ascii?Q?8d694L00viY+JjySnFY8lqdk+rtXvGtxzMn335g+dVrW58KpLkrFHF4nEGjZ?=
 =?us-ascii?Q?gejFlae+tvBmz7ffP/C8A930sHkYx0t0H+PEtdRof5yAXcRgCWV1SLBNbZVl?=
 =?us-ascii?Q?vdsSs29kbCIiIhJjoS2FePmIUZnJuP6NmFIYgz6uhZ4JL+yDXP9cszB1G5vd?=
 =?us-ascii?Q?zMbYAUC+OixDYni6bB4Yk2hx70ku66dWm2p0nQv+mZ76CpRh1eeh/G8XPCJp?=
 =?us-ascii?Q?EYapOMIyVRLSTO5zZ8pVTve4wR2r7HVhz5tTktwnKdByCBgJE1iQxe9doJ0G?=
 =?us-ascii?Q?VrkmWqQN2T33j2mK9WhPik6W5fOYctZpUJlHj/ka2RmAA3eZwKJbDVAlqIhs?=
 =?us-ascii?Q?lJF6MjE+cB5Ku9R6BC+e5aKbyaJa7rM9TkfZY1ofInbbpDO6Aq1lv5ywHmzd?=
 =?us-ascii?Q?ire4N2TSWd4ADble5k2sPR3fGg//OJZXUm5QorI+UHsIWejwJww=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tx3F9fdgiuXA8rdu3jTTDEsIpe5Co1X1jmtwdB3UHR73WuhnKdWrBwlQXyOU?=
 =?us-ascii?Q?qCF6R7RLWB+7j03qVcCh2VcUnH579Li4n/D0KD/WiRu7tNEuplQjSgxaAAKt?=
 =?us-ascii?Q?AhT7VGJgFKpRfasUyy3HO+hkaWiC+L/uuUIkS3TQJsuv6veiJbJkYNrjzX/A?=
 =?us-ascii?Q?SbsGoZDKeUSw3aSaTDPpBB7I7o8/5iaDOewU0P6pUP4SN50i4BJQKLKkdxZ2?=
 =?us-ascii?Q?nuloXDN6+w+J8U6kpgSTo+dTHE0JcxhvktPAEtlmju9Dd6GkixCfWSlt3KEM?=
 =?us-ascii?Q?HCT/OCdImLZzv/DHXC9gliHOs/JwbLrSSaxAOlzxkW2kxQaAfYb8efvMh/gE?=
 =?us-ascii?Q?+2weDgUI55iJzIe+ThDgi4iK2pNOFCN/a4WQL40oJXeNRKPzOMZfLntj80ec?=
 =?us-ascii?Q?TX7Y0PltttpJm2pbJM+I8dSlijjgnyNgyVrSmNgTbQ7jPzS71PKalHVYH8ZX?=
 =?us-ascii?Q?w1/E98ZHTeEZ3VBZBkkBJQ+wTe37F2USV6LGN+WF22vFO+XMBymbWISjdOrb?=
 =?us-ascii?Q?ymIS2PYZ7+zBzX9ouQ+SUjGNpleD5FFdC/Bon0sgeSqjL+ldxNrHbyoEHzu+?=
 =?us-ascii?Q?dY/K4savVto7b7O3mlej7bvZXcdTHh8ikXnqWahJ1S/uCVxEU5vLTS09S8MC?=
 =?us-ascii?Q?zmuZyv/VD4VD4pEf8rnZUSvHsUF0RSjArsQRysGAeHzTDslxRxfWKhYQe7YT?=
 =?us-ascii?Q?lsXsPXWgYABGWqxr8BcN1DOMhseoIs4QsBx4IhEP8mgzd9ap2N1a5j5P6uzz?=
 =?us-ascii?Q?HoFL87+0E4T9Q3CgDIXZVqvIyxwIvYRiugMh0LlbgXcrO3PC+8GBNcxdCz2u?=
 =?us-ascii?Q?bmzwye59YTTZJPOu9XajirqbI0EInqVj/NaP0J1DCJ4m8yehk+8lfZU1glP1?=
 =?us-ascii?Q?1PTF/DyIXU0z7LB4bN/9Bz0pMfScCGsFUnAwMj4FVKJb7gpD8oZ2/pz+XWOx?=
 =?us-ascii?Q?7yQWftp75HI/ZeOCifH2veOVGlPOLTnJF5/k/aAcnw8l0Oo7ox/omp36f7l8?=
 =?us-ascii?Q?dfOyZ6i7ye0M0dX4HSHScO02kq7Z7usdoNeTfxuiknn0AlBeAuqmx6fsLM2h?=
 =?us-ascii?Q?+rKPd4cQTFZpbja3LZguNVPNCjV8Gt+rdZvlZO2l8ZOP4mZ0NCC0CaA7e5jc?=
 =?us-ascii?Q?9b9AJO1cR4/h+eGP3MU30kVv0Wsa8zGqj+vAnuKAmE2A1QckwbwUHsl0mqJ5?=
 =?us-ascii?Q?AjeNPnVFyzjqZTXivtzdVGMDbFCelnPPmNLZpRWs2llNacy/HG/rsyhiNjqe?=
 =?us-ascii?Q?0IFDOYLiDaUvS1lHEEh9?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b349340e-0ebb-46d6-d3e6-08dd52445c4b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 06:52:52.1580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR19MB8323

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

IPQ5018 has tsens v1.0 block with 4 sensors and 1 interrupt.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 [v4] Constrained ipq5018-tsens to one interrupt with description
      Added Rob's Acked-by tag

 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index b9829bb22cc0..8bc468e44f85 100644
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
@@ -237,6 +238,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,ipq5018-tsens
               - qcom,ipq8064-tsens
               - qcom,msm8960-tsens
               - qcom,tsens-v0_1
-- 
2.39.5


