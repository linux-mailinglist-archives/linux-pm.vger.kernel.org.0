Return-Path: <linux-pm+bounces-16513-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBB29B1C7C
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2024 09:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C328281F63
	for <lists+linux-pm@lfdr.de>; Sun, 27 Oct 2024 08:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196693EA76;
	Sun, 27 Oct 2024 08:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="yuMA0I9B"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83CB28382;
	Sun, 27 Oct 2024 08:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730017521; cv=none; b=C62KcFCHu64xP0YvgCcxBHwtsDAgCCOzEZJXqVPEZpx3bdPQguzUH9iEbdzfAxJxhCQ6fs+cGolPkyYdBCPfH5xOMQubAHaOlK63cTvLNrV27mE2V46VwfUoSO2iJrn+YnAgtxHfOV8YsszA6YU6u+1rSolu0+knzAlXrdsYO5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730017521; c=relaxed/simple;
	bh=2McphKxGFJtFVKuHBKfCJx6Qw/qYujeC/hJV4VsPmIc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aMV1DUSsiR2r3ix4lohXcbXlG+9dc/viZRs818TBsRlt/ue8L6t5Er5aRdY7qkM0HjcDQXOjrC88uMyv4cf2OUD3mYN3JxzKppXOCczUGBXHY7hSZCgmnQq8jRTRqrwiTs56CKbkq+vY5YnEtYmM1C2Qbi/0+JmVhS6npO+1j2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=yuMA0I9B; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49R4hagP006758;
	Sun, 27 Oct 2024 03:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=oRDIAAGCQg4OWIEQpXRg0/rhONZ
	ZBbi2Oz23uwWRDMY=; b=yuMA0I9BmLMjc26Q+Wic2rGtCk3sNtzWgFkVw+c3ZYA
	il8t1J1gSQr5hgcgfnfjRnXwfKyAL8qXuCQHYXQ/amFxGvQtfRE4m8BQrE6/Hv4p
	lX45qqJUaSyeiuCQ6l6x8xxryok5cMRVheE/Pz3U0ZbKKUH3mxJ8diKha2LQ8ZG8
	MnyL1hsHMq/rsC4nR72Wd1WMkETbt8Bt5jzyRF7awkglf9qTQCzNdEQCPPnMd0Lr
	grggsUTgRZDoF6Wm9f6PQqeTp6XyeBT6SbuQbC4j72COmRHtcmikMt2QmT5tgw2y
	7skbu2HOxAlIiSlCdzj04OkZdBdco8oypRPtRVEYblQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 42herc89wh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 27 Oct 2024 03:19:12 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 49R7JBpn014719
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 27 Oct 2024 03:19:11 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Sun, 27 Oct
 2024 03:19:11 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Sun, 27 Oct 2024 03:19:11 -0400
Received: from kim-VirtualBox.ad.analog.com (KPALLER2-L03.ad.analog.com [10.116.18.26])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 49R7IxwK009789;
	Sun, 27 Oct 2024 03:19:02 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
To: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH 0/2] Add support for ltc4162-f/s and ltc4015
Date: Sun, 27 Oct 2024 15:18:50 +0800
Message-ID: <20241027071852.56240-1-kimseer.paller@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: FIFZdSxlo73Zbb6dbfXFMqdl17kWSsVr
X-Proofpoint-ORIG-GUID: FIFZdSxlo73Zbb6dbfXFMqdl17kWSsVr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 priorityscore=1501 impostorscore=0 clxscore=1011
 lowpriorityscore=0 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410270062

This patch series adds support for:
  * LTC4162-F 35V/3.2A Multi-Cell LiFePO4 Step-Down Battery Charger
  * LTC4162-S 35V/3.2A Lead-Acid Step-Down Battery Charger
  * LTC4015 35V/3.2A Multichemistry Buck Battery Charger Controller

Bindings:
  * Add compatible entries for ltc4162-f/s and ltc4015
  * Include datasheets for new devices

ltc4162:
  * Add chip_info struct to hold the chip specific data and functions.
  * Modify functions for battery voltage/current, input voltage/current,
    charge voltage, die temp, and force telemetry to handle different
    battery chemistries.

Kim Seer Paller (2):
  dt-bindings: power/supply: Add ltc4162-f/s and ltc4015
  power/supply: Add support for ltc4162-f/s and ltc4015

 .../bindings/power/supply/ltc4162-l.yaml      |   6 +
 drivers/power/supply/ltc4162-l-charger.c      | 434 ++++++++++++++++--
 2 files changed, 389 insertions(+), 51 deletions(-)


base-commit: 83bce34420eaf91506957703bf9a31d8581ed6cb
-- 
2.34.1


