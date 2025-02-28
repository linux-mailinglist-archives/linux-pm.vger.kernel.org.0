Return-Path: <linux-pm+bounces-23143-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DEDA490BF
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 06:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3171893433
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2025 05:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B75F1A314B;
	Fri, 28 Feb 2025 05:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="hM8HcyjQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2025.outbound.protection.outlook.com [40.92.18.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749F1632;
	Fri, 28 Feb 2025 05:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740719742; cv=fail; b=RpFRhOZJcKGs1rD5HUQL1JuF/ckoyZT9ZjP9bAakdBtKK0e93k4IGQQWj0azLOhI86KaikubKRcVqW2OU8wZl+vw/eLIZU8tz/mU/BcfjrQSPhRAIbDbWT67SlbVL8uTZUWO/2YhdPSnpVXG7rUgooZAHugIsMmXA0ayHlyxqhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740719742; c=relaxed/simple;
	bh=DToZa9zVz0m2GunOjKOBmphkoitC/ibQTJlg4Le/IeM=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YUDJODZyeg2dWGQ/Y24QvgSbJKSUMmg7pVhRtpHqVUyTS5K0g5k7cMHvi8Wy1XeEIHO9mcYJFWTinlwLORSUChVwpgnLm7AJxh0i0KewPejevGfC0TS6+h9VG9eW2NNoLS6Rrwk74S1CZVmrJFuAEoOaZg9v2Jv2kvqbFrlE39g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=hM8HcyjQ; arc=fail smtp.client-ip=40.92.18.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TGE8MegnQmAoEjG3uHkoyylLyHMzJTOlWvaf7JrUa1QqD3ZisYTLiQvFHB6/pR+no7u9wX3V4xjvdNmRivFBxz8NA9V3TzIzni1hF4hXMaXjV9NDeU9GeWPiZp14mX51Eu/Sm1Yc5hbZwHkBtz3wno+dfnQUiYCRc52rQ7hooC1lXSgauqjh1DL1Xrb0HKTZkl94J4RW0flBMLBFK1dofwMhu/Dnoz40ZRuvZawXepavLmFUIV00RlWLHO6dzY+ZhHGEQJfK7luLYeHJB96SqZFPrTS350bNw/xJ1jmYKXUv8bGR4vt8yG4uHMahaEpYuOyr1XVQW8Y2LvT0eWgq8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1q8ZPKVFSUZicImLgH5Wb6aLZh2u9GgthMU2Y7tEqc=;
 b=L1naAfF1+DvG9EYihh5YfFsnhroBjaRf4tiz/ab67lteIIl/dOOxYoPufu8MKhUaR2lKvPBIFrIg3zV/UQvlCgc+nwqMz86ziaxPFnNagIbQ97OlvGP555jZoGKbFEk9rBKXeeHY6aGZEpeAzWH3oG9qUQOtLdW90sbFcLq96e97qOio8p1u+dp/piNDfqqshQuY7YoMD9Yrke5I0dBJ11R/t1rk7GW4O0embCFsZf1m47+erYWX+5Kw4ZfqxiqIwK+VlEUji1ImYMJ2nz2aBS+Rjj3ctzjHmJvXrIdm9PXVcPHAn9DiW6QSjeUpSFPugJUcjNI9+n5Q9AQUnVhf4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1q8ZPKVFSUZicImLgH5Wb6aLZh2u9GgthMU2Y7tEqc=;
 b=hM8HcyjQqbePaVAp3Uirf1JygNa689BaoLvVcKsbKKCWybM8YaABTCr0P9+znlg3zKQ5Ozq2ZA7peq8y6nXevVGBa4v8VvELVHBYuGoeJz+gPRgxTp0eCR789V0znABmfjm25h2QLN4sYaVd+Z7KhhHfA2Cfsr8FqF8vVH4ZZRNu+drb9wIMdvqWUL3FuZs5JDLB+JhnTavFCRksJ8aJKp/BWwKYfxKa2Zuc6Zp7ybd4BQGaQ6yxT5vJdBS05UOFlG37/xSbEqIyBSITn99IW53vASrt1MkBB/oaCwiJS49W3IF6d4uikyAW1WQKOWj33O6GMHT1AJILR/tdmBn91A==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by LV3PR19MB8318.namprd19.prod.outlook.com (2603:10b6:408:215::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.21; Fri, 28 Feb
 2025 05:15:38 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8466.020; Fri, 28 Feb 2025
 05:15:38 +0000
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
Subject: [PATCH v9 0/6] Add support for IPQ5018 tsens
Date: Fri, 28 Feb 2025 09:11:32 +0400
Message-ID:
 <DS7PR19MB8883ADA4537830A07495397F9DCC2@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DX1P273CA0013.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:21::18) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250228051521.138214-1-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|LV3PR19MB8318:EE_
X-MS-Office365-Filtering-Correlation-Id: 11dbc81b-6d2a-4545-cea4-08dd57b6ee1e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5062599005|7092599003|8060799006|5072599009|19110799003|15080799006|41001999003|1602099012|10035399004|3412199025|4302099013|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1xyQVjWJxh0V5C4/uc/LpuBhcyeULWCPDbT2y+vJeVCfwlNFJadctG2lrLzn?=
 =?us-ascii?Q?g96NdRO8iCJGXgNKSqny+m4PpHqaiKe6tWpjXYhTaeNJFw9zmfiEqKotbC1j?=
 =?us-ascii?Q?S3iqQ5nEC6CCU9513rXIds0OrAMWRvzlKlI6q3GoouTfHkRdWpGKlaKtguCV?=
 =?us-ascii?Q?/jVIO4E5IUQu0valjXJjTXqPR98QcPtaPtXdMslf9eF4SjoFqNEdWllD8iXg?=
 =?us-ascii?Q?bUI1eqB7yGfY8P32sE1QUuk+Qv5oRNXN4L5A83gltqH3oW/FsgBGU3XUDGYP?=
 =?us-ascii?Q?VYkiyN70q+vUXrcyRZG9KoUjZ1blrjxDYoUCt85DYjizbH81WOPFMPJf1jje?=
 =?us-ascii?Q?l6pwnpt0AZ3hFzwqlBBLy2PjnTI6DLvD9Sasv+vBN1+PTmiCpg08HZRN99//?=
 =?us-ascii?Q?u9QRY8xw29UkT9oB/ughk0ROIrPOUMyaTcavzXYo4x53RVzRZT1978MsaQWN?=
 =?us-ascii?Q?bSzGJjAt9U+u5QIX0uVZEqaEN9qTMMK4LSTxZ4OqHP3UeO3IoXxBRmhc0PFa?=
 =?us-ascii?Q?Tt7++7NOloU0cgnoaoO8InIK/Au1iDhCkCFE0J2Khy2s8xT+QO6tYA50q8w9?=
 =?us-ascii?Q?6gdR+ACFyBvRboOLMvvHy4h7fDgpex3cYnoRET3aOk6guk81XQHhq0U3rRn7?=
 =?us-ascii?Q?xaa0OuIGwVpci9YKki5Mh7LgKTpo1tftDnV8fyp0eVdsOZtSFGqlac7T4tpO?=
 =?us-ascii?Q?+rQt/0aGqsaFj6CevP8a5i4oaYrNhAk8x2oTc4w/EcQqfB5G6InCgSws9DPP?=
 =?us-ascii?Q?y5F3hra7o8hh1HfPjPZYzrNmIJizJeWV5dASznPLEiW3MRkWXLP3eP9IHmzr?=
 =?us-ascii?Q?9aL8hzXTyxFU9Zj51FLBbyFS4mUgqDmryCnlmUiGAPhEJHBo/ynZhDOU55AH?=
 =?us-ascii?Q?wMLkk8uS+W58lKR6WyrrkqE1IUMzCIgcexUk+ZjF6lEli8qc/4ftomHg5/oI?=
 =?us-ascii?Q?0UORM/Wnr45UDN7OiD8ZMWHOhXIggu99F1fEzRPg6b9rQcsuchm62VnULQOC?=
 =?us-ascii?Q?yvhjjq0TqapBjsM1ZdaSUeWP/9yIWnPg4xP/8vglTU9rRDJ67y2fiZswGP8l?=
 =?us-ascii?Q?3K+J+TZKj4E2FkiYVJAx4q79O8WUFTOz58GhLe8WqzEK972CgQa665wmfO3E?=
 =?us-ascii?Q?4XIQT1t5MSqyJt91vtrEcXDBf/5UbXteFXsPC0E/GqOjrhxRlNRk7jAWoqJj?=
 =?us-ascii?Q?XDxGmd29k+e0mKylmRfQgEg//arah7LsdZIAl5OUMPSmjMudVKiA0OogMil5?=
 =?us-ascii?Q?Wfh37gEAOFEc/DebCFK1IrQgNJhAKalumcf7Sb7ShbkE78Pw05Kh3hpl05DY?=
 =?us-ascii?Q?DQJjDMWKSLjF07TZxrIM1NKJ?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VqX7gLmB9+m6/GRzQ0Z1YNb9iNg+oc31jL5+btoji8PPa/UQMusp4SwpKVi6?=
 =?us-ascii?Q?zcApLr/PRAiIjiNx7u7ovhdpmzsPtVmJJy6YvcAUWWy1pY9eaoxfS1MdWsxy?=
 =?us-ascii?Q?xc+Q8eT8ijMaaY3jfBN+aU3vCkdSRkF7fJrAVr2G8R+QtHY0+RVaFksENqDr?=
 =?us-ascii?Q?uKjiCCuBV0kPcKdrAJ1Tg7CO496qX3T0UU0biXnVqHkKklhiX8X9/X6D542e?=
 =?us-ascii?Q?sNAnMuH3EnT9ToqOFlYLEJ2CBpU3kYA2aWPeGInun7vkZIV60Z1rPhIdG07n?=
 =?us-ascii?Q?BfiUJsLTm7NVqIHEa5NCBViL32Q7eO60ZkQzR4Yuls9JWswX+SK8qK92Z2Po?=
 =?us-ascii?Q?tAiUc4wTMfvZL63qFpThBODspJpTmPVG23gJxt1EURxZ0khQlPvawGGDX+TI?=
 =?us-ascii?Q?YBBm3HRYFa/sIyhjJQh1Hi6qeG6lg5W9vOobxCyABiyvmjOwRAt7tIs70EeK?=
 =?us-ascii?Q?oUUZO1n2yqmwc7XKMZ7gKvDOW5UqZk9N+ogcmmadoWE45KtGMK2EBDkruj1a?=
 =?us-ascii?Q?+WobQv+HMnBcuQ36Kc8nZVZ/kCTEKZwJluZvf0Fgik4C051bKtOvZeE79gEf?=
 =?us-ascii?Q?Y9olV7c+Z1rfIOqpqpU2dcAatMuNmKAScA2oShgc2a9fsZLtzlojvbC6FqFD?=
 =?us-ascii?Q?AS0NJUM8TIp/L0js4rOVzVn+Enxti5VWzEI4YwDTDeEmUXCpxHhhRhhAe/cS?=
 =?us-ascii?Q?iBKYVXtCKxBcZM80i9yrZT5TlhQsZZAVpzORYkfVcuSj2m9R/ElJBr0kQZdR?=
 =?us-ascii?Q?OhcpVdLwB35j8yA5ARVjf1osCkk2lkv9PuT05QNGpofWlTp4DCLITz0aI5Ya?=
 =?us-ascii?Q?QYxVw073lVKM7qBj715PN/RhjWkUlkP7P9nlXns6J8C3Q/iaQ9iLH9z8yhS+?=
 =?us-ascii?Q?cnA2k26+cCcQlwGv60OpGetPMz92a+ssG4PyDCMF7hu/L3TT4bDjynn2rP6E?=
 =?us-ascii?Q?6Shn0CD3Fbsv6XtK92m8aORaRaCDoqYD9IwhadUd087GAmJkencC8GZklUXR?=
 =?us-ascii?Q?E2YapGpqaOPE+XKwy9qWnohvayP2XZgVsxS7Dohh96wLk0UzP+0OFPPV3NiF?=
 =?us-ascii?Q?XXqroTqH9RY1OA4jte6JwFsZ7S4Qo/r9nF3KK3gaxCWsykRNeVUvUtLZwYZQ?=
 =?us-ascii?Q?d7KUD/O0KN3JGQenKlGTpLrXVESEnu6melaozUeBd+WtLZzNkG4/x6XpxBUD?=
 =?us-ascii?Q?ubb3qtHzChcvWRZe2/h9Se2Obi5OI7BxWpPmewvY/eGIhztEEsMSzg/iWv5H?=
 =?us-ascii?Q?oZTCxFdObEWxPxMsVlUs?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11dbc81b-6d2a-4545-cea4-08dd57b6ee1e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 05:15:35.5290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR19MB8318

IPQ5018 has tsens V1.0 IP with 5 sensors, of which 4 are in use,
and 1 interrupt. There is no RPM present in the soc to do tsens early
enable. Adding support for the same here.

Last patch series sent by Qualcomm dates back to Sep 22, 2023.
Since I'm working on OpenWrt support for IPQ5018 based boards (routers)
and Sricharan Ramabadhran <quic_srichara@quicinc.com> in below email
confirmed this SoC is still active, I'm continuing the efforts to send
patches upstream for Linux kernel support.
https://lore.kernel.org/all/63dc4054-b1e2-4e7a-94e7-643beb26a6f3@quicinc.com/

[v9]
	*) Updated checks in tsens to more strictly evaluate for v2+ upon enabling
	   v2 features as suggsted by Dmitry.
	*) Split patch 3 into two, one to update conditional statements as
	   mentioned above and the other to implement tsens IP v1 without RPM.
	*) Added back Dmitry's RB tag on patch 6 which wasn't carried over
	   from v7 to v8
	*) Link to v8: https://lore.kernel.org/all/DS7PR19MB88833F7A9C8F4FC484977BA69DCD2@DS7PR19MB8883.namprd19.prod.outlook.com/

[v8]
	*) Tsens V1 uses v1 interrupts and watchdog is not present (only on v2.3+).
	   As such, replaced VER_1_X with VER_1_X_NO_RPM in conditons to ensure
	   v1 interrupts are set and watchdog isn't enabled.
	*) Tested on Linksys MX2000 and SPNMX56
	*) Link to v7: https://lore.kernel.org/all/DS7PR19MB88831624F11516945C63400F9DC22@DS7PR19MB8883.namprd19.prod.outlook.com/

[v7]
	*) Updated cover letter
	*) Replaced patch 3 with a new one to add support for tsens v1.0 with
	   no RPM and removed Dmitry's 'Reviewed-by tag
	*) Refactored patch 4 and split support for IPQ5018 from support for
	   tsens v1.0 without RPM. As such, also removed Dmitry's RB tag.
	*) Depends on patch 1 and 2 from patch series to add support for
	   IQP5332 and IPQ5424 applied on Feb 11 2025:
	   https://patchwork.kernel.org/project/linux-arm-msm/cover/20250210120436.821684-1-quic_mmanikan@quicinc.com/
	*) Link to v6: https://lore.kernel.org/all/DS7PR19MB88838833C0A3BFC3C7FC481F9DC02@DS7PR19MB8883.namprd19.prod.outlook.com/

[v6]
	*) Include (this) cover letter
	*) Picked up Dmitry's Reviewed-by tag on patch 5
	*) Link to v5: https://lore.kernel.org/all/DS7PR19MB88832FDED68D3EBB0EE7E99F9DC72@DS7PR19MB8883.namprd19.prod.outlook.com/

[v5]
	*) Adjusted commit messages to indicate IPQ5018 has 5 sensors of
	   which 4 are described and in use as per downstream driver and dts.
	*) Padded addresses of tsens and qfprom nodes with leading zeros.
	*) Link to v4: https://lore.kernel.org/all/DS7PR19MB8883BE38C2B500D03213747A9DC72@DS7PR19MB8883.namprd19.prod.outlook.com/

[v4]
	*) Documented ipq5018 in qcom,qfprom bindings
	*) Constrained ipq5018-tsens to one interrupt with description
	*) Added Rob's Acked-by tag
	*) Added Dmitry's Reviewed-by tag
	*) Fixed modpost warning: added __init to init_common
	*) Sorted tsens nodes by address
	*) Sorted thermal-zones nodes by name
	*) Link to v3: https://lore.kernel.org/all/20230922115116.2748804-1-srichara@win-platform-upstream01.qualcomm.com/

[v3]
	*) Added the tsens-ipq5018 as  new binding without rpm
	*) Added Dmitry's Reviewed tag
	*) Fixed Dmitry's comments for error checks in init_ipq5018
	*) Ordered the qfprom device node properties
	*) Link to v2: https://lore.kernel.org/all/20230915121504.806672-1-quic_srichara@quicinc.com/

[v2]
	*) Sorted the compatible and removed example
	*) Fixed the name for new tsens_feature
	*) Used tsend_calibrate_common instead of legacy
	   and addressed comments from Dmitry.
	*) Squashed patch 3 & 4
	*) Fixed node names, order and added qfprom cells
            for points seprately
	*) Squashed patch 6 & 7
	*) Link to v1: https://lore.kernel.org/all/1693250307-8910-1-git-send-email-quic_srichara@quicinc.com/


George Moussalem (2):
  thermal: qcom: tsens: update conditions to strictly evaluate for IP
    v2+
  thermal: qcom: tsens: add support for tsens v1 without RPM

Sricharan Ramabadhran (4):
  dt-bindings: nvmem: Add compatible for IPQ5018
  dt-bindings: thermal: qcom-tsens: Add ipq5018 compatible
  thermal: qcom: tsens: Add support for IPQ5018 tsens
  arm64: dts: qcom: ipq5018: Add tsens node

 .../bindings/nvmem/qcom,qfprom.yaml           |   1 +
 .../bindings/thermal/qcom-tsens.yaml          |   2 +
 arch/arm64/boot/dts/qcom/ipq5018.dtsi         | 169 ++++++++++++++++++
 drivers/thermal/qcom/tsens-v1.c               |  62 +++++++
 drivers/thermal/qcom/tsens.c                  |  27 ++-
 drivers/thermal/qcom/tsens.h                  |   4 +
 6 files changed, 256 insertions(+), 9 deletions(-)

-- 
2.48.1



