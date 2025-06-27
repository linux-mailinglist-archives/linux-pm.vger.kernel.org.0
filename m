Return-Path: <linux-pm+bounces-29711-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05475AEC170
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 22:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 676253A4965
	for <lists+linux-pm@lfdr.de>; Fri, 27 Jun 2025 20:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306AB1E98F3;
	Fri, 27 Jun 2025 20:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tXY5VlWs"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7608A1E48A;
	Fri, 27 Jun 2025 20:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751057344; cv=none; b=dSUHPc1+TadzhxUxOkwUhIFbHEodxpRUhjWzCwnTpVLYsL2xrI6OQfzgTpzLKrjDMbdqr5RkW1IiSQMmXcu8TvT7zuBNsrNE5wmwjLcCEKuON0eeeyGe7X1ZCr0G7iejPypsmmAgoZ7iKKBD2BcLHhyRFRT6S0sUYqO10Z6HtTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751057344; c=relaxed/simple;
	bh=7lh1D7X4PEQNtzbuYBYYZr7+QXtnCRLLN3kysbsGGTQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qg1u4PDmv3PaSRwbq5j5gw6NuFm5pN4zTzgXHrJAgz+T4+dBSpUZutxzBYw1QWOrXYRC9BDqu2ymr1ep+OgBPPtkO5xdlN8dH9DGopFpkOK686hRvr8b4XF346p1JhVm+9RVLdUoG7OvulCfmD1aHPC8TmOypMwgGob/+9Iyb8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tXY5VlWs; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55RKmqvX2508627;
	Fri, 27 Jun 2025 15:48:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1751057332;
	bh=93MTeUvjAac0mVu0/ygJFfMB9ChTxtocV2BdLcqjMgs=;
	h=From:To:CC:Subject:Date;
	b=tXY5VlWsttAx/kckmqxTnws32hkyIMizdP+Fof8ypF05IY/Njpy/3ojw6bH39zdGV
	 CMcd5iWqIZggeGZkUggZw23GGmlMMLOy3gAkMwVVazOWV7/0il4pRK6IYJx6Ke5Lob
	 TFUBwGyJG3IeZc2ztQhFi9HTsQt+t3RXPg8L+1tk=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55RKmqcw3578130
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 27 Jun 2025 15:48:52 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 27
 Jun 2025 15:48:51 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 27 Jun 2025 15:48:51 -0500
Received: from uda0506412.dhcp.ti.com (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55RKmpWV3421525;
	Fri, 27 Jun 2025 15:48:51 -0500
From: Kendall Willis <k-willis@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <ssantosh@kernel.org>,
        <ulf.hansson@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC: <d-gole@ti.com>, <vishalm@ti.com>, <sebin.francis@ti.com>,
        <msp@baylibre.com>, <khilman@baylibre.com>,
        Kendall Willis <k-willis@ti.com>
Subject: [PATCH 0/2] Enable abort sequence from LPM entry
Date: Fri, 27 Jun 2025 15:48:19 -0500
Message-ID: <20250627204821.1150459-1-k-willis@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The PM co-processor (device manager or DM) adds the ability to abort
entry to a low power mode by clearing the mode selection in the
latest version of its firmware (11.x) [1].

This series adds support for aborting entry to a low power mode if an
error occurs during suspend. If any driver with either ->suspend_late()
or ->suspend_noirq() hook in the TI SCI PM domain fails to suspend, an
abort message will be sent to the DM and the DM will abort by clearing
the current mode selection.

The flow for the abort sequence is the following:
   1. User sends a command to enter sleep
   2. Linux starts to suspend drivers
   3. TI SCI suspends and sends prepare_sleep message to DM
   4. A driver fails to suspend
   5. Linux sends DM abort message via the TI SCI PM domain driver
   6. DM aborts LPM entry by clearing the current mode selection
   7. Linux resumes the drivers that have already suspended
   8. Linux works as normal

Only devices in the TI SCI PM domain are able to trigger the abort
message because the TI SCI PM domain driver has ->suspend_late() and
->suspend_noirq() hooks that are apart of each drivers respective
suspend path. In the TI SCI PM domain driver suspend hook, the suspend
hook of the current device will be called and the TI SCI PM domain driver
will check to see if the suspend returned with an error. If it does, an
abort message is sent to the DM.

The prepare_sleep message has to be sent to the DM first before the
abort message is sent since abort works by clearing the low power mode
selected. The prepare_sleep message is sent as apart of TI SCI
->suspend(). Since TI SCI suspend happens after all TI SCI devices with
the ->suspend() hook have suspended, adding an abort call in the
->suspend() hook isn't needed.

Additionally, if TI SCI fails to suspend or fails to prepare sleep, an
abort message will be sent to the DM. This had to be done separately
because TI SCI is not a device in the TI SCI PM domain.

Testing:
To test this series, a driver in the TI SCI PM domain has to fail to
suspend. When this happens the following is printed during Linux's
suspend/resume logs:
   Failed to suspend. Abort entering low power mode.

Series has been tested on an SK-AM62B-P1 board. Normal suspend/resume
has been verified. Abort was tested by adding an error into the TI SCI
suspend hook.

[1] https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html

Kendall Willis (2):
  firmware: ti_sci: Enable abort handling of entry to LPM
  pmdomain: ti_sci: Add LPM abort sequence to suspend path

 drivers/firmware/ti_sci.c               | 67 +++++++++++++++++++++++--
 drivers/firmware/ti_sci.h               |  3 +-
 drivers/pmdomain/ti/ti_sci_pm_domains.c | 46 ++++++++++++++++-
 include/linux/soc/ti/ti_sci_protocol.h  |  2 +
 4 files changed, 113 insertions(+), 5 deletions(-)


base-commit: 2aeda9592360c200085898a258c4754bfe879921
-- 
2.34.1


