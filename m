Return-Path: <linux-pm+bounces-17192-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 933E59C18FD
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 10:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D93A2B24875
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2024 09:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC63C1E130D;
	Fri,  8 Nov 2024 09:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="ZhFJOLDP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m10140.netease.com (mail-m10140.netease.com [154.81.10.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23351E0DAC;
	Fri,  8 Nov 2024 09:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=154.81.10.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731057570; cv=none; b=k42yUB9WB4xKNC+z9+pAWLJGF7Dh5uaPe7BCClH6SBCd41ZwH26Ex74ewLFf7pwk/znldubPP04XD0e4bgVTOQgxyGYhJSkwph/nXysFJmWcPXg2mlmsTTqaS/RFz60fuuocw3mLErl6CrUTOI2F7/bB+a8EVRuH2Ocs8saeeTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731057570; c=relaxed/simple;
	bh=Cx+xucL519aRKedwvrQaxnFzpGdLIVByoNipm0ybSZ4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=FUGA/5sRSGVZK7vEjlAND4P0CXEgQxLy5F0DzruKdhr/srORj52A/GNnNKGomjxy4wKJgwqw5JwwCrioo78+O51ZoNrw7lp5F/A9RERKuJYqGMx/96rRUgWCN/7CIIT4EaOO8FRP3DHtNB5uraPCN6Kapco4nVGArQocV5h8XrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=ZhFJOLDP; arc=none smtp.client-ip=154.81.10.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 22d35fd3;
	Fri, 8 Nov 2024 14:56:54 +0800 (GMT+08:00)
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
Subject: [PATCH v5 0/7] Initial support for RK3576 UFS controller
Date: Fri,  8 Nov 2024 14:56:19 +0800
Message-Id: <1731048987-229149-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkhLS1YeGUpLGU1KT0tKTx9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a930a8fc58e09cckunm22d35fd3
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NC46Qhw*FDIdQypLUSo0NAIz
	UQJPFANVSlVKTEhKS09CS0pNSUJCVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUhLTEM3Bg++
DKIM-Signature:a=rsa-sha256;
	b=ZhFJOLDPCmOVRq1c9MJZ92uM29kJn5WKwL+TLFpISXECT8JdkHYxH0NjD1h1UDppnMrtjAp7KJQBzJBasR8D0s2NGML8b65ulRzboCCjjVXUudOKl5UPKbzkH1nOTkLY/6lIlsa+UuS7WIr89xEnbQKOipPYsGSNxakH8JW1sDo=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=1000dFGZBHbcIY0+dtVdQKYZfaPAMvgoTS2zlP+JXns=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>


This patchset adds initial UFS controller supprt for RK3576 SoC.
Patch 1 is the dt-bindings. Patch 2-4 deal with rpm and spm support
in advanced suggested by Ulf. Patch 5 exports two new APIs for host
driver. Patch 6 and 7 are the host driver and dtsi support.


Changes in v5:
- use ufshc for devicetree example
- fix a compile warning
- use device_set_awake_path() and disable ref_out_clk in suspend
- remove pd_id from header
- recontruct ufs_rockchip_hce_enable_notify() to workaround hce enable
  without using new quirk

Changes in v4:
- properly describe reset-gpios
- deal with power domain of rpm and spm suggested by Ulf
- Fix typo and disable clks in ufs_rockchip_remove
- remove clk_disable_unprepare(host->ref_out_clk) from
  ufs_rockchip_remove

Changes in v3:
- rename the file to rockchip,rk3576-ufshc.yaml
- add description for reset-gpios
- use rockchip,rk3576-ufshc as compatible
- reword Kconfig description
- elaborate more about controller in commit msg
- use rockchip,rk3576-ufshc for compatible
- remove useless header file
- remove inline for ufshcd_is_device_present
- use usleep_range instead
- remove initialization, reverse Xmas order
- remove useless varibles
- check vops for null
- other small fixes for err path
- remove pm_runtime_set_active
- fix the active and inactive reset-gpios logic
- fix rpm_lvl and spm_lvl to 5 and move to end of probe path
- remove unnecessary system PM callbacks
- use UFSHCI_QUIRK_DME_RESET_ENABLE_AFTER_HCE instead
  of UFSHCI_QUIRK_BROKEN_HCE

Changes in v2:
- rename the file
- add reset-gpios

Shawn Lin (6):
  dt-bindings: ufs: Document Rockchip UFS host controller
  soc: rockchip: add header for suspend mode SIP interface
  pmdomain: rockchip: Add smc call to inform firmware
  scsi: ufs: core: Export ufshcd_dme_reset() and ufshcd_dme_enable()
  scsi: ufs: rockchip: initial support for UFS
  arm64: dts: rockchip: Add UFS support for RK3576 SoC

Ulf Hansson (1):
  pmdomain: core: Introduce dev_pm_genpd_rpm_always_on()

 .../bindings/ufs/rockchip,rk3576-ufshc.yaml        | 105 ++++++
 arch/arm64/boot/dts/rockchip/rk3576.dtsi           |  25 ++
 drivers/pmdomain/core.c                            |  34 ++
 drivers/pmdomain/rockchip/pm-domains.c             |   8 +
 drivers/ufs/core/ufshcd.c                          |   6 +-
 drivers/ufs/host/Kconfig                           |  12 +
 drivers/ufs/host/Makefile                          |   1 +
 drivers/ufs/host/ufs-rockchip.c                    | 368 +++++++++++++++++++++
 drivers/ufs/host/ufs-rockchip.h                    |  48 +++
 include/linux/pm_domain.h                          |   7 +
 include/soc/rockchip/rockchip_sip.h                |   3 +
 include/ufs/ufshcd.h                               |   2 +
 12 files changed, 617 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ufs/rockchip,rk3576-ufshc.yaml
 create mode 100644 drivers/ufs/host/ufs-rockchip.c
 create mode 100644 drivers/ufs/host/ufs-rockchip.h

-- 
2.7.4


