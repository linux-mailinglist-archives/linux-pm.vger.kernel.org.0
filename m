Return-Path: <linux-pm+bounces-16916-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 505199BAD2A
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 08:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 696841C20DF3
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 07:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF6618D633;
	Mon,  4 Nov 2024 07:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="BDoi8/1o"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m6092.netease.com (mail-m6092.netease.com [210.79.60.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA63193408;
	Mon,  4 Nov 2024 07:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.79.60.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730705600; cv=none; b=bMFr33BpthvyXES1YCnaRYnE7bc1eAgg0CKSgbYpmL+tTmJlXrmEmzCRmu64Y00aSdlkxlyX3ImjlY0a9Sf1jYPAq3T00jKZI9sH9ZYBEQ3Z+PLSeBCX4iueJZutW6SH5bvvVYJ4o09DjB2DFggIoj1LU1aeZmnNOpgBzJS5IGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730705600; c=relaxed/simple;
	bh=HcAtJ+KdWFjukkplQq/eUQ5X4sEL5W385xYCnFj8q2s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=mythPPaZljFllmsQXilVcOvxz1chdDx0/UVF7buO8ChbcNjFDwuFQTRG8Tr+N7TgL1UtOstGgCq+NtO7iqz1OqxX0UI8Fwrc71+AZTVQrl24rWNoiVKXr9Korc+fWlH+Z09OxED6xKzSr5WKkROVDXojNBg2MZqq22wf6nYrybc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=BDoi8/1o; arc=none smtp.client-ip=210.79.60.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1b5f85e2;
	Mon, 4 Nov 2024 15:33:04 +0800 (GMT+08:00)
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
Subject: [PATCH v4 3/7] soc: rockchip: add header for suspend mode SIP interface
Date: Mon,  4 Nov 2024 15:31:57 +0800
Message-Id: <1730705521-23081-4-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1730705521-23081-1-git-send-email-shawn.lin@rock-chips.com>
References: <1730705521-23081-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk8eGFZIHU5PQ08YSBlMHR5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a92f61772c109cckunm1b5f85e2
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MiI6HDo6DjIvGjoqDjVKDy8D
	IzkwCg1VSlVKTEhLTEtOTkNNT0NMVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUJOTzcG
DKIM-Signature:a=rsa-sha256;
	b=BDoi8/1o0y4qs1XCUwE1wY8O5Dwy5r8bBTrIJIljgXxpTVkvNOJH/smvoGA+cNjncWRMVQ+cdMOGGwv9YjDfL1I3aAPKzaWB4g2Z9NBlGbdaKX3oCHM5zgKGEy36ss1KQuARxkl0I89/cpCOzfu0PbCIRGn8ITAh+Advkikp1O8=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=Ty6mGnWBoIaPt2RyCxg02+KQlGxmCwE6/d4KhDj58FM=;
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


