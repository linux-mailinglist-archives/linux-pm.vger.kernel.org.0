Return-Path: <linux-pm+bounces-22601-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 784A2A3ED12
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 07:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB9C63BB06B
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 06:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D421FCCE3;
	Fri, 21 Feb 2025 06:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="PUiYFcRO"
X-Original-To: linux-pm@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2109.outbound.protection.outlook.com [40.92.40.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B5745948;
	Fri, 21 Feb 2025 06:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740120767; cv=fail; b=o7c+JqYOkxcKmi5jmeF8VFE1sYNGarEWrJIsOGVl8IByZU9hjC7sS8HI4KvGtpWYulfTl7HRlFtcG98i4JY/Ud8BJ4Xipdb7qEYgNZLMGAkdHSkZGTGShLDxUQWf0MHEoEhGCrh/YDWwGZKm3KZ0rgPDexa2qs6tdjVdLvzTJ1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740120767; c=relaxed/simple;
	bh=/U+7i3asY3aDIHWXUL0s1unhZtW2Dg9W3kpHTzs0Kzk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CGPWjuCZaWY8SlT8cLXuwHwLICCI323V1gsHsoumz3KolmoxgrPrsn3/ouHmS5wuOrfeJAhxzCpDLsYamrpquRyrI0gGhH+swvDV5SnJdyQDmPOVorO7CKr0QFqgEBQOicj9VQIOHVA1CXSpeIxi0ie1t8ZwXrRERZTWo82JOic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=PUiYFcRO; arc=fail smtp.client-ip=40.92.40.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XzkBhifcRxkI/gUa5wqCnNtfX0kYK43VYz337F0d6FVh4ZCTGOLdcdpL5DmgvpDKB1As0RPhD1cs6yyy+taiw7AuVMRScAPGYyt+hTFEEeTeHP08gaM1ie9Mpj2Tu6Zq4C9CBbrsmKOnuJWITDTzuef4JUeMwRfZko4piyV35AFedCGqnG08a1EsLhrkC8NdJu/PpVkdp5qxHKPadmlsVhBNNAv6l3BmcAmBdw2oyuNMg27Z0OuM/9fj6zmTMcsDrUCxrTWuB0wBLx1cCMrCtTbruAiLwvQPv/023HP1fNao1ui2x5hlPqPa4nidD3cg3HX6Nh+KUTe12lAox4cfkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lc6XTgKBwNkUWQVAlWGrx9SijqBqICIqSm22LSb2d2A=;
 b=H24pbzg/1d8NmVSRlvbB0a44NjzwrMqXNUcKNivs59XEBQUrWRpWPEI2YOPxAGyM7gQNE7ZUz5Rq7FQhy//NTAT6aLx/LYJPRn9VuYPzh63b/oQ08GBW1Io5giznJbZNhq3xZ2ScIY+Cwyy5SvA1wzSJXJzsvjq62fFVoZHiMV1zKRet0OgMb49Y1amC4o3JtLCFKifhH7ro3RE/8h+PNcv/xfTQShRPlPLL+pquAF9P4QYl37AukvP7hCWqIqJ3onfVfbtmHnehKFNTqJNl51eYpqTbVI33WggNsJcAmtpuq0gThdGoYai0emKUONc0eBvpp5BN8N7FO4Owqq6O0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lc6XTgKBwNkUWQVAlWGrx9SijqBqICIqSm22LSb2d2A=;
 b=PUiYFcROOzVVlvPQUJvzQ7xYyA1fG4QHw2MUPpqnNvIVdNJRSMWqoXi2w3l9oZPt7tL/TRDzgcq3IMQUj2Z1wZ33b0gYrA8xXS7gfJLCnWmqFI9DPrwY5O/CvS/8pvaCv/luX0jk1olBPTMKwSbakHSvKFJX/DhY2OVrkMEhn/P3rCM8UfGAkq62PfAa7ShcrFA1bdVIHtjpb7sUZ0ZASB3vKAT8IUUTXIMW5gyAucXuE7npxHBjm/Tw5n20NycTicduhwUgDHGHIniMTPp4sUlMAvIy82tiwMM+biKenr4uvFEGaZybFwW1rGcEhqq/w0HMZvKBWimk2xy5zlWzSQ==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by LV8PR19MB8323.namprd19.prod.outlook.com (2603:10b6:408:1ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Fri, 21 Feb
 2025 06:52:42 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 06:52:42 +0000
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
Subject: [PATCH v4 0/5] Add support for IPQ5018 tsens
Date: Fri, 21 Feb 2025 10:52:14 +0400
Message-ID:
 <DS7PR19MB8883BE38C2B500D03213747A9DC72@DS7PR19MB8883.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DX1P273CA0007.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:21::12) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <20250221065219.17036-1-george.moussalem@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|LV8PR19MB8323:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a87f197-ba05-4da0-17a2-08dd52445635
X-MS-Exchange-SLBlob-MailProps:
	YfhX3sd/0TWYnBBcTvvGLlHdY79wcCjUDD5TixbazfAFrec+7bgk9+MYg25tPk9e7+5Zm6ynr8g3fYE/N8Zpe77W6qVlJA7jEgxif0H2pgbgwRc0K/TFzrEyNa0EvlJxK20nH62VbDWhzViW4fPoqkT2TKa5Cr2/xL2p7SYLvokebQcxb3zPpOt5QrybUKaQ55cEAJ7DY2YeY98Xch516VERE52XNVw1+WM8vc75Yalzbi00dB3lOR8M7+c/qi3fH9qpTbYp7LZKxgmA/yLWs7FKRHdf381epxamesVZXXELKMsDsdSxymB13X72w6yDB6GEmRsJpaB/Uf0FEHk9XYeM3W1FWnFseKFjs2bU98WoIcAMoc6bISbZrzldd1HS9Qqg5BuzrATPXirWiZD+2GCqh5yZ4zYRpUsBfOeIouT6vtivotyiuNmI544Gc0zxH/oyOoo3G3nFfCvPG2oRkbEDxaMMtPxORXqn6w99+U/Zk0d8rlwZoGT2UvIpJAha3In85uUQ1ePL47RMvdJywOmDwPtHhQwtf82HngAmesIkMnDHHwvRwORlDQgHTrdfjd8MEI23lag+EGPR21YghF2qhNTYUpVWuo5dTWSNUfaesLMWxZTBnTka6E7EFgxV+/DSs4KyCBZKmK3srW4zVnmhVUTDPrpeLdAnofoFrAnFaGJxgzhBOHZWtsPtWC60o9JrTqbUGV1DcQxuMGIsdHfNSIlwGRtzaIs7lcuqvD3rl4eTAG1mW/ef9DpJqrx6CKAWAxBLxOSGtO4LK3XalcY494qBlwq05K10dDwn6IQ=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|15080799006|7092599003|8060799006|19110799003|5062599005|5072599009|1602099012|3412199025|4302099013|10035399004|440099028|41001999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F8U6XDVFeyYcwkmloR9f1z5tDMsOqk6fRpHvFWQialkREc6U75N6zXIiXEKj?=
 =?us-ascii?Q?KA/7nL4JjhG6fsjihc6n13mfDah1bYoW+KWZLmjoOs55xF3FOAsJT1uLU6lo?=
 =?us-ascii?Q?LZ2O/CBa8J0YsovqQfxr+21hG8r4+FJTn2uFtlkMd7OG9kWs5U6uGNCt9b5l?=
 =?us-ascii?Q?z3lweDE0/PCcifod6odgvQRht5GlVqe8dfSV3gyJHxb0+PzoSpEYqbFheS/r?=
 =?us-ascii?Q?yKJSsht2bxHMRtdh3ekh84GaMlz9Xkg5o6eJT8c9IKKhmZbkuMwXSTR5EKn9?=
 =?us-ascii?Q?/AYWZeFwFmG9CNjgao+ORrFnRx+IagTPRqI/0388CySUzFTzgkNjG8cG47hQ?=
 =?us-ascii?Q?YvvixQJzPHWrqZNFmnrnkizWgzGqAkx1V8qxWaHCkHcF/3MtyqQcXnjeC49Z?=
 =?us-ascii?Q?wLkr+9L4kJ3CpW/EJR7G0/S83NxGCbwPeR4Fav+nEBWyLq6ZS4OjxZBOqxCM?=
 =?us-ascii?Q?AAJgLOvZGiEq8hfrYMHz47NpUms92DEJtvTY9EBtBSati9Cr5U2GzPQqLZMn?=
 =?us-ascii?Q?aDRcPL/drzC4/FNBatthmv7dlXSvQlbqhwp53YCblSCs5v4nKf9XJbzZ2yah?=
 =?us-ascii?Q?nz88G6AKFT5C47t2Dkz09Yr8vW2H7VjtiVxjPyrkxJx0E9HubpsB0VoJWbz8?=
 =?us-ascii?Q?QO+5Ff1+SA8bn/M7v3ykgBNEUXBIFRA0ZtU16R5jFBVU22q6st8rJrWoHTPh?=
 =?us-ascii?Q?dWKOsMOs+yWi2G9zNc5Kt6C55/ZA5EaCptz04cw+RDZkditEUYQp8hM6f7T6?=
 =?us-ascii?Q?YDvRKTCngJFdZotJF/g/CohnDkRibI/mgnc1kM7mvKTv+77Z5tNtG01A24wT?=
 =?us-ascii?Q?NJR8tqteW0OUaJ3GyZlM4kaIpZSoXHRkIzds33/Gb8V6EoyiGkfTHgro/eYX?=
 =?us-ascii?Q?NqscIJdcesXYhOcAEyKXkK7hhNhfabMneEGqzRvPZOIpRrAaLG22bviKhaet?=
 =?us-ascii?Q?kZB0l3XmYYKDjkYcyOE7T9NEGhDTMxrOehEBYASpNeSsCSBmDZ1JiBc7a0Ws?=
 =?us-ascii?Q?7j5nfXLKyyDqEYQ7PhxtgO0eIN+dpU0Np2Mf6i/yoYr54w8OsFCbH+VW8W+u?=
 =?us-ascii?Q?xSyo19RowRLFgg6pooc+zKKMTTqn1lwDD4Xb/+4CjYGlKa2SwuCvWdMg9FzZ?=
 =?us-ascii?Q?Z8MpVvKKFT+9MmjSheeXy711MwRTeFSAa/QJBki1Ch2P+4zoJfmwcBKFyHuH?=
 =?us-ascii?Q?Kg0pgwueAk7Bym+A6iZTrQBieROZXBZdr7Kt780jIopnwPyM0UBYI1JBQ4Gs?=
 =?us-ascii?Q?igfZJREmxWe/3tJP/38fMUU0Ydc33emtbYEryJSPKGdm8kzAg/2zc4z+dTq3?=
 =?us-ascii?Q?RB29X6br/sBjfugYgiQctuxkukN3mEzjgd7p2KCTM4uW9A=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7rCAHcJz6SojFXZRWGDsDYTqg/g4A6nUjs06NAcgcAwfMwyabJCO7I063HX4?=
 =?us-ascii?Q?CIxY71fKc2Y7LaJzXML0hILDdQdTGDt1ccpy14Ml18tMnuDWyZ7Opeb8gA/i?=
 =?us-ascii?Q?lP4oc0DQzyyot+Zw0CZBfIAuUdHMObD/tFXJqk7YVJV5p7zJU9ieUZ670BVL?=
 =?us-ascii?Q?fqYHvDK6nL/dGCO2CVaNuhQwMNqgOEka9olgbEr6TQ+Te72MWM4dFvCDzZvi?=
 =?us-ascii?Q?H37UTHG4F3sfE4jtD1MyV8UUht729wqCdDubNKFF0cAOwQBYXmpx5VUB5Iwp?=
 =?us-ascii?Q?LnAaVuvGw7M3JhMiHhLGQciXELXZFhvt3YTZ4vuc35nsBqerWRop6LORB9Xc?=
 =?us-ascii?Q?jkQROJY9VUKcmmwo3cbbGNEQAv/EdpCo1xavqCm/cT8iCCy7OecPEIJpyzeS?=
 =?us-ascii?Q?hvnDhzcfKY+A4J5vzjs9oegCQWx+aCNiM/tZiZKrFrvCUJEq3KOPkdUbPuy0?=
 =?us-ascii?Q?q5zz29BeuGQw1uQSJBjr96mDJVdhn6Yrm9PPuZVpHZrG+dLAJ3i2iANxvDvj?=
 =?us-ascii?Q?HQ9GAOy6PuBJ6W75fmJqd33YNWS3rAmXiuBUdOFENI5Oqb9Rv32MC0k68deh?=
 =?us-ascii?Q?M7FH8cv32ZBJhy2CABALx7X2R6HrpR2UXxPwpMy1JRHK8tC7MmL04sTDWjVJ?=
 =?us-ascii?Q?HPlmtkcH21JUouM+sJoZthVFPhCwful7tkMQSyRlVCugR3a2lw0bhqPxgtGc?=
 =?us-ascii?Q?Q5Hfuo5Fo3nRdm/6yLKA5B+mDmpqKRTyp10kAD2nZAzksrHBX66dnzgC3QuI?=
 =?us-ascii?Q?Vggbhk4BHwYQ28gsiqZ6z0vtUSFHQ1Cf8A77J0+1Eto2UIbFzPF7TBq7zTwq?=
 =?us-ascii?Q?WHvgwTCpm/czdiR01AdJjeEfM9Bsk+mlG9N/Dkcv+B08cEBDwL/VlRCO9fGv?=
 =?us-ascii?Q?bzrwvM2oXdTr3PBajfIuIvqMPY4eOJSxAImY0gotnIKaSa6aupjtiIOoSUCp?=
 =?us-ascii?Q?+Zzy/m1Ac30ntnVIMx6qOMMkRQrX9aidQl2GjVwB3pJsxeIMCEL3vkXToohP?=
 =?us-ascii?Q?jVPO99VVyci2hamNapKudSZPdOeHR9ps2TQMHErPFhwJZ//gpA8TCsBseauB?=
 =?us-ascii?Q?CMTxo+SxSLv3gNtqfYhZLtx/YiznF4/LFcgWLXHjVZmVyDnZOF87K3D3dpHv?=
 =?us-ascii?Q?debJLnUCc++pmdLSy4oz7r8oLBFF0uoH+9TT3OTyov5TzjfBl4akyaacsBUi?=
 =?us-ascii?Q?qsO7+Q9c5SP3mNvXBx+yp6+eXOo/QhfwWQ3awJiP2STQ5KVxtO5SYuXXRnhT?=
 =?us-ascii?Q?fcTPs0OVe97MEDOv4j0a?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a87f197-ba05-4da0-17a2-08dd52445635
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 06:52:41.9623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR19MB8323

IPQ5018 has tsens V1.0 IP with 4 sensors and 1 interrupt.
There is no RPM present in the soc to do tsens early enable.
Adding support for the same here.

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

Sricharan Ramabadhran (5):
  dt-bindings: nvmem: Add compatible for IPQ5018
  dt-bindings: thermal: qcom-tsens: Add ipq5018 compatible
  thermal: drivers: qcom: Add new feat for soc without rpm
  thermal: qcom: tsens: Add support for IPQ5018 tsens
  arm64: dts: qcom: ipq5018: Add tsens node

 .../bindings/nvmem/qcom,qfprom.yaml           |   1 +
 .../bindings/thermal/qcom-tsens.yaml          |   2 +
 arch/arm64/boot/dts/qcom/ipq5018.dtsi         | 169 ++++++++++++++++++
 drivers/thermal/qcom/tsens-v1.c               |  60 +++++++
 drivers/thermal/qcom/tsens.c                  |   5 +-
 drivers/thermal/qcom/tsens.h                  |   5 +-
 6 files changed, 240 insertions(+), 2 deletions(-)

-- 
2.39.5


