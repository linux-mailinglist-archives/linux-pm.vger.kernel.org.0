Return-Path: <linux-pm+bounces-20735-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B92D1A17647
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 04:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F86D1889BBD
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 03:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503921531DC;
	Tue, 21 Jan 2025 03:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="ZntfaLit"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m19731103.qiye.163.com (mail-m19731103.qiye.163.com [220.197.31.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6948F58;
	Tue, 21 Jan 2025 03:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737430610; cv=none; b=ns8aPxslWylFKb8pkegUmfBilI0/3ygdZExHnZIjYk0QPMSre4h2csVXpFhMU41DjRfgtZ3zRvEJvHXYdFt5l+epVlBVAGnW2MewzNrLkZkg2i+YiOuVVh+MRdAdAKxH4qzcBKwQGQRPOa2KuQWEV1rXlhd43Jyce+r8XBZhsRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737430610; c=relaxed/simple;
	bh=N2A3lf9fkpBeWFLhv8dlYUWCGEJ0ylvivEzzwB5kZAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ZekPyTB4QABSRJDJFwm8vDJ71dc4SXsP3pClhy4I7uj2NHesNNlHdXTS4p1yjizfog4+eBcFLYe0abSvbsDyBzNGAVvfPEcIUhrlzy+AXeC3EvCdSMnAWqcIVaPhDyOmJcXX6M/Pqv57/oFWJhEPOft4vpuW3haYfJktytZWGCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=ZntfaLit; arc=none smtp.client-ip=220.197.31.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 93fdceb3;
	Tue, 21 Jan 2025 11:01:11 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Rob Herring <robh+dt@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	YiFeng Zhao <zyf@rock-chips.com>,
	Liang Chen <cl@rock-chips.com>,
	linux-scsi@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v6 2/7] soc: rockchip: add header for suspend mode SIP interface
Date: Tue, 21 Jan 2025 11:00:22 +0800
Message-Id: <1737428427-32393-3-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1737428427-32393-1-git-send-email-shawn.lin@rock-chips.com>
References: <1737428427-32393-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkhIS1YYSktMGU9OTEoYGElWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9486ce901309cckunm93fdceb3
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mj46Iio4DjILDjURDhQJE0Mv
	MBAaCUpVSlVKTEhMT0lDT0xIT0lOVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUJCTTcG
DKIM-Signature:a=rsa-sha256;
	b=ZntfaLit/Ng3eN3IHMuaijfJr4+Y/fb2vJe79da64JdeUDHg5kAXyVht4HliOqMuBbhs4EEMsszswEYVnfWt2MUmurOE6IMPtHuXkRWpdsp6MjL+eIYTxwWHkJGdo3oQh7ad9/zfv31Xji/K18aTpQTOI7ePOkC/hoHSYxbaVX0=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=8+W942VRkD9KzsoBrCz1dgz/NW1wjNVf0le2KbBegUg=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

Add ROCKCHIP_SIP_SUSPEND_MODE to pass down parameters to Trusted Firmware
in order to decide suspend mode. Currently only add ROCKCHIP_SLEEP_PD_CONFIG
which teaches firmware to power down controllers or not.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 include/soc/rockchip/rockchip_sip.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/soc/rockchip/rockchip_sip.h b/include/soc/rockchip/rockchip_sip.h
index c46a9ae..501ad1f 100644
--- a/include/soc/rockchip/rockchip_sip.h
+++ b/include/soc/rockchip/rockchip_sip.h
@@ -6,6 +6,9 @@
 #ifndef __SOC_ROCKCHIP_SIP_H
 #define __SOC_ROCKCHIP_SIP_H
 
+#define ROCKCHIP_SIP_SUSPEND_MODE		0x82000003
+#define ROCKCHIP_SLEEP_PD_CONFIG		0xff
+
 #define ROCKCHIP_SIP_DRAM_FREQ			0x82000008
 #define ROCKCHIP_SIP_CONFIG_DRAM_INIT		0x00
 #define ROCKCHIP_SIP_CONFIG_DRAM_SET_RATE	0x01
-- 
2.7.4


