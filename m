Return-Path: <linux-pm+bounces-19166-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 334CB9F02B7
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 03:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 832511883C54
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 02:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8932157333;
	Fri, 13 Dec 2024 02:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="T/m7tBb/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D762221345;
	Fri, 13 Dec 2024 02:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734057508; cv=none; b=ikPJg/y46mcqoIyfknUxPwDl3jF90+1gbxUB8AG2BIu0+8cX9IWb1Wn9wFAjKiH7qkVFlEP2ApMhqZX+GIunRrdjpozdT736FNWC6T8CIXfL9D2ifWGl7Qm/suQotkpiiB/IqZoeVcZM0LhwM+IiiG/0UywAZ5x9/IDlXEMFHS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734057508; c=relaxed/simple;
	bh=w1S7Grqm9Bjm8ZJ6TZtt0Q/QI3gXLllC3K45a81RfLo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K6mjSUtmwV9SUoc9aFb6TK/MJNSsj6i6yZY8EqW/IMcfiEEMdjlX8Yla4+l2A0a1tIr9HCGmekETB3f2N04y9NvUS/KVqhKoMacfFVvNn+sPyTMHtT97c+7P3YmyLiV4ydEUpteHg8VRAleqFRNlsKLF0/KfRZik4rHlhAEmX0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=T/m7tBb/; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCN0o1t021581;
	Thu, 12 Dec 2024 21:38:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=9+DxZcxXIxMJ8fJdBuqSa8b/qQJ
	FiSDjAmimHgBtV9U=; b=T/m7tBb/LJjq57dlRynGJ3/DyBDVhvFFQnCgWOkbqc3
	UHaELIz/IiTabZHtUvipcvy4VZZTBYl0B2ZOxmLw/cRgZ+OWrvqTnyAgxkgopmUD
	1e22W2kGzNWVo6IdXvLKyFen5Azv+AVIQp1Q0bDQr0DiVkUDj/NZPLRNNwo31uwi
	Y7Q7lFZbHzQMx21bbivKhwtO5kRQL2ZW8Pu/jD6xFMFJufE/SB3wmR6GdM2gzEgR
	PHK11hdZgn+GcorigpiMpQs/7tvIlXccQ4AE3kVUeyiiluvGFarexukIAZ7V0NXO
	zUxkEkRHkjnC1/v66YMUPaRFO1hSTzAC+DSyqevscTQ==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 43f1j7us3j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 21:38:09 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4BD2c8r7024820
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 12 Dec 2024 21:38:08 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 12 Dec
 2024 21:38:08 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 12 Dec 2024 21:38:08 -0500
Received: from kim-VirtualBox.ad.analog.com (KPALLER2-L03.ad.analog.com [10.117.223.26])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4BD2bsXr028303;
	Thu, 12 Dec 2024 21:37:56 -0500
From: Kim Seer Paller <kimseer.paller@analog.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mike Looijmans <mike.looijmans@topic.nl>
CC: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Kim Seer Paller <kimseer.paller@analog.com>
Subject: [PATCH v6 0/2] Add support for ltc4162-f/s and ltc4015
Date: Fri, 13 Dec 2024 10:37:44 +0800
Message-ID: <20241213023746.34168-1-kimseer.paller@analog.com>
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
X-Proofpoint-ORIG-GUID: GiqK0pzAyzAdbF-QawzTolOzM7QlPbGv
X-Proofpoint-GUID: GiqK0pzAyzAdbF-QawzTolOzM7QlPbGv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130019

This patch series adds support for:
  * LTC4162-F 35V/3.2A Multi-Cell LiFePO4 Step-Down Battery Charger
  * LTC4162-S 35V/3.2A Lead-Acid Step-Down Battery Charger
  * LTC4015 35V/3.2A Multichemistry Buck Battery Charger Controller

The LTC4162-L/F/S variants and LTC4015 share a common set of registers. The
difference lies in the resolution value of the scaling factor for battery
voltage and battery current measurement, input voltage, and input current for
different battery chemistries. The difference also includes the calculation of
setting and getting the actual voltage setting applied to the charge voltage,
as well as getting the die temperature.

changes in v6:
ltc4162:
  - Changed ibat_resolution_uv and vin_resolution_mv to ibat_resolution_pv and
    vin_resolution_uv respectively to reflect correct units.

changes in v5:
bindings:
 - Add Acked-by tag from Krzysztof Kozlowski.

ltc4162:
  - No changes.

changes in v4:
 - Arranged compatible strings in alphabetical order.

changes in v3:
 - Described differences in the programming model between variants/devices in
   the commit message.

changes in v2:
 - Modified commit message describing differences between variants/devices.

Kim Seer Paller (2):
  dt-bindings: power/supply: Add ltc4162-f/s and ltc4015
  power/supply: Add support for ltc4162-f/s and ltc4015

 .../bindings/power/supply/ltc4162-l.yaml      |   6 +
 drivers/power/supply/ltc4162-l-charger.c      | 434 ++++++++++++++++--
 2 files changed, 389 insertions(+), 51 deletions(-)


base-commit: 5d417a5e7ade02a7b75cd886d8afe3e9025e7e25
-- 
2.34.1


