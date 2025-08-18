Return-Path: <linux-pm+bounces-32582-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E215EB2B1A5
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 21:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FF1A625C0C
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 19:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33D327381E;
	Mon, 18 Aug 2025 19:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AxC/k8En"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3187D273809;
	Mon, 18 Aug 2025 19:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755545203; cv=none; b=gvKnHEYgrZGZwdjATCAHYox55ZaZGTY3huT/rDoVtiQQNKSIIce0JgHt/2gy7Tukt+k++PCJs8DdijBwZIH1tTNS1Mg8RN1voQzscKBSlcnr5aCgR1JbPJ8h6m2kjNdHpiKoSwqkIIZCW6S6n5YWZ+5ACULu0s+yk9t/stZjcr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755545203; c=relaxed/simple;
	bh=ROtEZIiiHDU/BMVhYCsKLpgRLFFf6ZgX4SN6yEURSOM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gn8MfXBsn9bktroInB/mPhf9vMez1+HZI3m2NkDETmfHKTBQqBECcijUW/yGuUJ9ly2t7UTVfkckDWC3w6JtuqQw3kXhrfAoXj90PNLwL4L3j3KcGV09d3/5UKpCyaIhY+XbZe9QDaTG0eafw+Xw5OA2vJprOcnOUaBbAdjq6X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AxC/k8En; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57IJQXg62726732;
	Mon, 18 Aug 2025 14:26:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755545193;
	bh=12kQz3A/BbG6iESz2wksdkCzEHrQ+r7GsI58CIwRvvU=;
	h=From:To:CC:Subject:Date;
	b=AxC/k8EnDW38UPgNRBxMexkzSRy4FoqluD99EWO9qYKn70eTni64xHlnjhxwLJzCN
	 iCuLhFwbuq4GbV447F+HWbgWILh66zISTGFSEduGK/k8kIMTIGMDNj36Nzpe9eqNsc
	 vS45SGEcPerFb4HFvJsQPszNy80ERG3zjlBeKpew=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57IJQXnt039958
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 18 Aug 2025 14:26:33 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 18
 Aug 2025 14:26:32 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 18 Aug 2025 14:26:32 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57IJQWxV1525949;
	Mon, 18 Aug 2025 14:26:32 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        "Rafael J
 . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, Bryan
 Brattlof <bb@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH 0/3] OPP: Support more speed grades and silicon revisions
Date: Mon, 18 Aug 2025 14:26:29 -0500
Message-ID: <20250818192632.2982223-1-jm@ti.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

As the AM62x, AM62ax, and AM62px SoC families mature, more speed
grades are established and more silicon revisions are released. This
patch series adds support for more speed grades on AM62Px SoCs in
ti-cpufreq. Also allow all silicon revisions across AM62x, AM62Px,
and AM62Ax SoCs to use the already established OPPs and instead determine
approprate OPP application with speed grade efuse parsing.

Also fix 1GHz OPP which according to device datasheet [0], also supports
speed grade "O".

[0] https://www.ti.com/lit/gpn/am62p

Judith Mendez (3):
  cpufreq: ti: Support more speed grades on AM62Px SoC
  cpufreq: ti: Allow all silicon revisions to support OPPs
  arm64: dts: ti: k3-am62p: Fix supported hardware for 1GHz OPP

 arch/arm64/boot/dts/ti/k3-am62p5.dtsi |  2 +-
 drivers/cpufreq/ti-cpufreq.c          | 10 +++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

-- 
2.49.0


