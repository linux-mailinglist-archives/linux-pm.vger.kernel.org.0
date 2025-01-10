Return-Path: <linux-pm+bounces-20182-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B23A08975
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 09:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D2D6168B3C
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 08:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4F32066D9;
	Fri, 10 Jan 2025 08:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="P+R2kCmQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BF033987;
	Fri, 10 Jan 2025 08:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736496180; cv=none; b=NI0+lY039d/kkKGlwR+rWBcJJyom+al9CNRYZsXRGmtUUhQ/h0wfbXmN0T8OmkjEqbabsGcFdpmS68cpNG/dsShQ0Du5jxd4iAbF9ylVuin6+0IIYacd0Hcjo/U99QEJVevf7wjNEKw31w/H+05UWFB9EYl7fy8Mi531Hw//Gew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736496180; c=relaxed/simple;
	bh=yxnjeX/5FGWHlvXKApmqczkkMULfrrdeVX/qPS4qWDI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YLI4dkZeEJp9iV+kzciSlugMpQjfWXWaP3n5ioCOU0CGpbZhws4TjUxVC7Rk3UFKtL0g01Kg58oNqd1yVZdDcxsZX8b6GbqmAFbCN256tu46AvILh29/uS8qvy0rucz181AgGuLwK8yFa+gE3qapnYf77zREqoIf8eVYPqFzgzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=P+R2kCmQ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A6oHnG020302;
	Fri, 10 Jan 2025 03:02:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=HHSQ50cdgE/zjzBVZqmakpzICSW
	OmTHO+wVWvM6XecE=; b=P+R2kCmQLW66H6V2d8I+/3CqONxYiS8wxYIuvpFB+1G
	TF7FPt/mx/+2Nn5qt1WcLZQka9tsKMojEvYSFzJRv6l3H9yQye9VMlZoPlVs6B/I
	dxOANYqBeYwkUnxphg+XEB6G6TdYqmdXWdfbPh+mJxIg7s1J8xljY4QpOSVRLOEU
	UWr1KQGOixnJM4DQocM1+0vYFUZO3RJHUAw1H9PKqF+DXF6fUIw5EbSrDWKuOj3A
	Qz7FOcz5ghQXkWKbkdEsdXASzObzpxr8rN9gxYcCkWZIELmShw32NKa0jJV6rF9e
	8qJEnv8dYQR+4jr6SzA5XqB2awxFSEtPULaeLPXS5gw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 442xmr88rd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 03:02:55 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 50A82s8g053904
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 10 Jan 2025 03:02:54 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 10 Jan 2025 03:02:54 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 10 Jan 2025 03:02:54 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 10 Jan 2025 03:02:54 -0500
Received: from JGERONI2-L01.ad.analog.com (JGERONI2-L01.ad.analog.com [10.117.223.12])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 50A82hMH006597;
	Fri, 10 Jan 2025 03:02:46 -0500
From: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
To: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH 0/2] Add LT8491 driver
Date: Fri, 10 Jan 2025 16:02:33 +0800
Message-ID: <20250110080235.54808-1-johnerasmusmari.geronimo@analog.com>
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
X-Proofpoint-ORIG-GUID: wkZg7pSjSDUmJP9LojDVnUvD1Md-Iv1f
X-Proofpoint-GUID: wkZg7pSjSDUmJP9LojDVnUvD1Md-Iv1f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 mlxscore=0 impostorscore=0 clxscore=1011 suspectscore=0 mlxlogscore=823
 bulkscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100065

This patch series adds a driver and device tree bindings for the LT8491
battery charge controller.

The LT8491 is a buck-boost switching regulator battery charger that
implements a constant-current constant-voltage (CCCV) charging profile
used for most battery types, including sealed lead-acid (SLA), flooded,
gel and lithium-ion.

John Erasmus Mari Geronimo (2):
  dt-bindings: power: supply: add adi,lt8491.yaml
  power: supply: add LT8491 battery charger driver

 .../bindings/power/supply/adi,lt8491.yaml     |  89 ++++
 MAINTAINERS                                   |   7 +
 drivers/power/supply/Kconfig                  |   9 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/lt8491_charger.c         | 410 ++++++++++++++++++
 5 files changed, 516 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/adi,lt8491.yaml
 create mode 100644 drivers/power/supply/lt8491_charger.c


base-commit: a3a8799165ff83bb764fd800c6559c3cba0ddac3
-- 
2.34.1


