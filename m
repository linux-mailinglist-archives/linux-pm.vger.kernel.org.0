Return-Path: <linux-pm+bounces-22993-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F323A460C5
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 14:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FF1E3AFAB9
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 13:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD052206BB;
	Wed, 26 Feb 2025 13:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Q8q/VZBW"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04olkn2044.outbound.protection.outlook.com [40.92.45.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3D11552FD;
	Wed, 26 Feb 2025 13:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.45.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740576251; cv=fail; b=lWsR6bBPtTsiwCPCCqnWGHgMgpDjtdoH/Nd8/lVYv5q6r7cynOk8WIDcjFSOhGdB7kilHt3rLwZA0yFvh5I6+60PoEG053K76gK5zvTDSEcnFd9AYTPNcRPj1IOuRenR58VAm5IlLsW/H2oT3kMU1mIjsMlkq0RiTAOVimL6Y2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740576251; c=relaxed/simple;
	bh=rfdVsQBZ1w4r8DV5gyVyUSbejSElONYQT9ycqJxUw9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r9NfYAYLByl56ZZh6gEyqNE0pqtUMi1e7cFyhq5cKo2Q7baH4VG+ptFj3eu4c0J55DrDOMWscO/wC+GeOUZeU/sPnhRZID/hnWjJXXtINwyHLbhWkQ6hlKRJ/XsTBdV7t0cxEQMl6KndWoL9Ol5kmYGtOnKljQIXvHU5pOs1bYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Q8q/VZBW; arc=fail smtp.client-ip=40.92.45.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SmYEtU1yDk4FvIz2eRabgA+G2UcoMRo6YPDsLr+OZ4OwSnR6ktcfZAb6kelpnEw6xLAYizYaKjxNkNilzAT59FEim6Q4+IFJcTsO8dHRp9cvicaYfsKmuE+Ave/Ofsf+NmQFdZXbFNV+eQGjIu4DuuV8fwp2mqF4iIrSEexK9jqGK9du0Tmz7ArSLvV4EpEiPQ7OjmAWgiftxvDxxdPhMqZf4Anqd/B4Ze27xsWRuAlM6gTmF3rttJk/EjOGn+mp7Gse3i6vf1N8CH6RA1BEvZvj5PuGxB/XfKZl8HmgaGDPVn7SWFCrepvrjerDjRKqhesKIvmnAxgdMZ/Pq/ervw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbU20fbNV9C2RXIScXBclqXALcAdCO1Yx7s9d0znSiE=;
 b=KHl9jYjSiPi54oRB6t3gziRTKfUetlNItRqM2spYiYP+NA92fXK8xkD73RvbQI89E5tcGk3zD6rn0WMill1ghITxU1iUQlbESw2Jn7v5GorQGGEwTwqepJofjCRT4nUVCFmn0G7prGHUp/mVR0UrxYj8zP+EKP0B8zafAXBKVAvaMoxiZiAr+Lacog3DjCNnz7ngAEqqRGyTV9xZo2eJG4S60Nmr4Hhv2lVx/LduS1JJuilBMRkxHYT5xSJjmg2Ujc4E58FG+0dhKSq/pygGYEm5HHNMt/6t5XBoO12svYYsrSPXrJyJ7QPmNTnzxfzW7xRCdarv9j7OAOI2WYXZow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbU20fbNV9C2RXIScXBclqXALcAdCO1Yx7s9d0znSiE=;
 b=Q8q/VZBWzU7BoBk229mNcO9kcy8Us4lasqG8jAeS5exbY2yYLu77D0/H+yLMgyi0zF5dUv2Ec/tCVL2rSKhiYOk3gxloBM5Xa0cvYU4iUJWwsCGebCOJTiC40P8/DYIAaDABCk54OGh8fHtRDn4lvsePOkacXRv4B5k8Xhihan5CLPqVKsVQ4k/h3xbadNxOhCzwkMEQdnllY9mATZVZ6YJzg4ku85LeMG8yfCa+bPg6mutbcr5lsepwZvmk2X4MPfDYLy2gN8b9xSb79BMnuBAE6uX/YVbQAolqGj+pNJ+yPcPXkhKQuvUKEj7f00E66xyrl3Gjgqs/ZSqgNelqAQ==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by DM8PR19MB5270.namprd19.prod.outlook.com (2603:10b6:8:4::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.18; Wed, 26 Feb 2025 13:24:08 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8466.020; Wed, 26 Feb 2025
 13:24:08 +0000
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
Subject: [PATCH v7 0/5] Add support for IPQ5018 tsens
Date: Wed, 26 Feb 2025 17:23:51 +0400
Message-ID:
 <DS7PR19MB888380D58D71827D2B471BBD9DC22@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226132356.9398-1-george.moussalem@outlook.com>
References: <20250226132356.9398-1-george.moussalem@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DXXP273CA0022.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:2::34) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250226132356.9398-2-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|DM8PR19MB5270:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ad7ecb6-4848-4c0d-a010-08dd5668d923
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|5072599009|19110799003|7092599003|15080799006|3412199025|4302099013|10035399004|440099028|41001999003|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n789HyWsfrVfe8dWsxQ5Ds77D3sFwIkSU1PXfiR+xgUx2YopuQ2Mm1j0FhQC?=
 =?us-ascii?Q?PyA9O1bbk8+fGJXsiw38diugWhbVNGM1cIVfh2LDuUAlVTCaag6ZdaeHryiL?=
 =?us-ascii?Q?oHI5M1935Kj9Jd2j1HyXyK+zqve5KzMGYbG24nYRx9NEKDGgyOEbazMC3Gxh?=
 =?us-ascii?Q?PO5UUxFv7L31Ajlxlwoy9/yUnvXaJdsve7o3K49CLlz5msTK3JxBoqF3rKZF?=
 =?us-ascii?Q?VXkZs50xms+6ngT7g7uIZVDGUeLTAK94B+bsVe54kbqH6xB+bldYXyqESU6q?=
 =?us-ascii?Q?NhaBLrNsSO0527/LDrVED5LOcvj/zAh92smZIU0juYh30rSxgPIskFCUDecm?=
 =?us-ascii?Q?A6qYGnLp/XviC3i+fy/BeZpOjqrF73R2KPYpFL4YFleJqil2qgaaTqFrPlcw?=
 =?us-ascii?Q?PsSR0lzjsZf/JTyDrzRAZoA1zI6do0lEsesDFCcr+dxfSNwMR6+Mlo85LP7g?=
 =?us-ascii?Q?eEYotmiGjBUZlbuYdrHghOW74RRwlYjZKcf34OqWJJlVf0tUgTKgfxO2EUFB?=
 =?us-ascii?Q?biyksqePJK3MOpL6uk66zcIkzGZyS08abv4k/ynFeNPh1ej2TrD2jA95tq84?=
 =?us-ascii?Q?iERODI68Tw9n8hV5qU1r6V//tXkPgpkZOZtHW/a5xfg7/grgsvdG6KTWNOab?=
 =?us-ascii?Q?2h87mlMzqATO/Ve978UIHmLJ3Aw5rl2H370OAlYaPl/02/c4oNP1DorfDgR5?=
 =?us-ascii?Q?movrF3VY/+WY6B9rdcD1LOEEptjqM3MMrOFiQGM3hd/cNnSnPTB62tRfqtgf?=
 =?us-ascii?Q?o8MOmmw5iwEUXPMA0kR8WFyGg+oOJ9mtNbKQrP7RRnUsCY+VFfxyAJ77pwT0?=
 =?us-ascii?Q?YijOBGwxPIsH1d26kP97t6go4y+hbZ3prnvMbT0xg/61AOzHVmsBgPpvIf+E?=
 =?us-ascii?Q?0YJvlzBSDvBTxBfFiM6XP2lFfVWs4luRmGPCxZYlXvtYMOdWmRrid87l6LRt?=
 =?us-ascii?Q?tpxeEoHiB63Cik6SQ6Tz17vtwWMGrS9FV8UuR7J7AxuwQ+32WkneiYs5b3LB?=
 =?us-ascii?Q?Ph/uwTWGvqJHdbc2AgbeSfa8J0dPL75zVFmQJhhMhvuUXxDdAHvA68IHNhXU?=
 =?us-ascii?Q?+9h2WOq7faS8VEpdqTMwnJQtKVVYjkMXedfyBbZkPlpE9EkHQBdCktwoAxbu?=
 =?us-ascii?Q?I3lk1PIsruW1mDLqt0Q50RhdATtpngLcd7L/7YYHmtHGvbYO8tVD4cpjBCsU?=
 =?us-ascii?Q?qtFPzNlNzm4ecMEGLnPr2b5NhB75yC0xLgEGRLd7U+DT271Ei6xNeSjS4Rlb?=
 =?us-ascii?Q?JAswkrFdnNRRmTevorJ/0fdEBQQbiZNNpTfRTDWDAfH1hToOeempeUmwEYBh?=
 =?us-ascii?Q?zfXSW6qbMe7dvPLLWn9OvwZ+?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i5ZwctC37wmUPZ9fFAZBzifZ0x31KmZTrLcJ6y7bxucFfZ8jM1tABklhbrNF?=
 =?us-ascii?Q?A5V8IdPmJyJnipf1uB5XgnIO7VvimPuNlciFKeaOR/AtgEEyBqdMUHf5iG1W?=
 =?us-ascii?Q?DVqR5dVy6NK/LDmybWXwb9gJPXUV3+rqsAKe1o7EYt73W/pdc5wxW4er6hHM?=
 =?us-ascii?Q?R055VBnXGOjiyOevpnko1QuGupkhfjX4pKaxy9moyzAXQceWzlbwpdTUcZwN?=
 =?us-ascii?Q?i+ADhnw2mJwCpAOvVXPo988vr4GndsVoTvzZE0k0xso0QdqGfVq3BrT21yFL?=
 =?us-ascii?Q?HSOVNyc1NqXu8BpviFBY79ylDm0k433d+2I5bLcVJA5v2YrnTTOizi/SAy9n?=
 =?us-ascii?Q?IRiGZvAhfYg6sSpR3M+NSBEiigGt0Msg6zbO49nusKWuFdf8rkiaxQwZthKd?=
 =?us-ascii?Q?MmSVYVD7EZZC72YZ4q7+AtP6YlCtR2ScGf08ncSeItUecC6xc4eqgCbksYRo?=
 =?us-ascii?Q?6yfdVlPW9cS4iTpUFuekSB+tPbs6x3dj9IVph3eJwTnJoQ6qV1dJiVL/U7bE?=
 =?us-ascii?Q?y4Fdj7qpCZhq9t9qpui3IzlBesP8HTW/QyKwVsIFxIW1USm5uhnDVxvl966O?=
 =?us-ascii?Q?YHtMC5CYXDej7MeeYnCE268gmeMWgxamI2spLHbTgpy1iiziWb566lvOZDS3?=
 =?us-ascii?Q?wKptJSUYI5ZHMkICGSCrDb3wZ9Akq9r3E+ouc+KzObzj5rWy4Nbn34ChrxYN?=
 =?us-ascii?Q?TlN/J6YBcVwXNj04CTzA9ORfxysfPh0OXEXNinK+bw0spXjr2pDDA774nZO2?=
 =?us-ascii?Q?ZY1k4aFRDVzXejJ28GNSqeiwmPAtuwDjDB7pwP+MAh+Jv9ke3xDEjrf7qm8v?=
 =?us-ascii?Q?82qcFD2P6zGMlKpM7I1njaDxMSLcE3761PmcUn90rm2BE0CS35QtrkHwxq/k?=
 =?us-ascii?Q?siLj1zMuFYjdUBw/wSMJP2SustlCBuib7dJM7tN6fT44DhMbjPqRu+BqTqKh?=
 =?us-ascii?Q?hbuoLZi3z7/Gir7URDvG7PGfko1s9gtCCO4qY17V+LQWDrU8vlTEIp4V27eC?=
 =?us-ascii?Q?v2h33SdebAYB7eeofU8JYeCyP5XGaMmvBJhQ+ksERiWqYx0EafWq2ViHn3H+?=
 =?us-ascii?Q?BQZQY1K6vXqk52wIPMIwuqDs5dcunf6+B8JpOyBGOCt/fjyrlu1kghMiSuOA?=
 =?us-ascii?Q?q774qcWGsNsx9AbsK8JW0MTh8327ggsnNhFGfP9LlBGsQRn5wNBN2h/GhDh5?=
 =?us-ascii?Q?NOwv8FKZuhRkV+C0aGjsDFQDe23Vb/Tlhfhs083Ui74HeitQCqZ2m8vh+7DA?=
 =?us-ascii?Q?123nEytEujmHSMLQoL9+?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ad7ecb6-4848-4c0d-a010-08dd5668d923
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 13:24:08.0570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR19MB5270

IPQ5018 has tsens V1.0 IP with 5 sensors, of which 4 are in use,
and 1 interrupt. There is no RPM present in the soc to do tsens early
enable. Adding support for the same here.

Last patch series sent by Qualcomm dates back to Sep 22, 2023.
Since I'm working on OpenWrt support for IPQ5018 based boards (routers)
and Sricharan Ramabadhran <quic_srichara@quicinc.com> in below email
confirmed this SoC is still active, I'm continuing the efforts to send
patches upstream for Linux kernel support.
https://lore.kernel.org/all/63dc4054-b1e2-4e7a-94e7-643beb26a6f3@quicinc.com/

[v7]
	*) Updated cover letter to include
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


George Moussalem (1):
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
 drivers/thermal/qcom/tsens.c                  |  19 +-
 drivers/thermal/qcom/tsens.h                  |   4 +
 6 files changed, 252 insertions(+), 5 deletions(-)

-- 
2.39.5


