Return-Path: <linux-pm+bounces-20729-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97622A1761B
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 04:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC46E168485
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 03:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01C215381A;
	Tue, 21 Jan 2025 03:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Gvh5oBvA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m1973190.qiye.163.com (mail-m1973190.qiye.163.com [220.197.31.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6934689;
	Tue, 21 Jan 2025 03:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737428762; cv=none; b=g12OFOjuXUi9/h7Q96Kg/uD7+3DByFs7sT2+DMbCWL4TC/3lBTkhLn/RRPeKcO/5QcEj35lKE/TPUHAnV4xeKAGFTqnQvnBE5wXLbWh19cwkInvFTNNe6evI761ciVKNbQy4t+XXkVeAMrdkMWLuJyhEDlBMhRbR6a/QekCS6qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737428762; c=relaxed/simple;
	bh=pRUewvpusrXxYpn3RJSTwNGYU4QZAbcZLjQLju0Y8Dk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=enG7cFbEnPndd0jfORpyaoXt8qsOsX/QogaOcQ09zf/0Jb4rKPsh0UwRqHvmv2xDywTZ8tc/HZf9dNjQbMqQyud9URhtFiG4RH57fdAEsw2RXHQe5GnL7NOV0RJEJo9M+cCJUTqFTSf0TLtLtdmhi97KmjlEUJEjM5Pyox6yaRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Gvh5oBvA; arc=none smtp.client-ip=220.197.31.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 93fdce2d;
	Tue, 21 Jan 2025 11:00:41 +0800 (GMT+08:00)
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
Subject: [PATCH v6 0/7] Initial support for RK3576 UFS controller
Date: Tue, 21 Jan 2025 11:00:20 +0800
Message-Id: <1737428427-32393-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR0ZH1YeHkhNGE0aTk5DQhhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9486ce196e09cckunm93fdce2d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ngg6PAw6OTIVPDULDhcQOUko
	CQ0aCzBVSlVKTEhMT0lDT09ISkxLVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUhNSEo3Bg++
DKIM-Signature:a=rsa-sha256;
	b=Gvh5oBvAo2dEaj4m6Wyc7BHdyd3s9/JSuGx7UtA+I7Bk3WhN3/Sv/aPlA1hhCX3ssyT6sqSCW1yhEAm2M4SOaMvYoNQTR//dMjzy7YXNYh1eUvvLDRPX41XuUa1YIwQjRGi4PNh3SVCk7ZtROWlquqx2+Vv9jWVC+gaDRe58yIA=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=qsTW96WiGE4VUwg9HWhzzwlQ4H/BodYfL5T/GO8IzPA=;
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


Changes in v6:
- export dev_pm_genpd_rpm_always_on()
- replace host drivers with glue drivers suggested by Mani
- add Main's review tag
- remove UFS_MAX_CLKS
- improve err log
- remove hardcoded clocks
- remove comment from ufs_rockchip_device_reset()
- remove pm_runtime_* from ufs_rockchip_remove()
- rebase to scsi/next
- move ufs_rockchip_set_pm_lvl to ufs_rockchip_rk3576_init()
- add comments about device_set_awake_path()
- remove comments suggested by Mani

Changes in v5:
- fix indentation to 4 spaces suggested by Krzysztof
- use ufshc for devicetree example suggested by Mani
- fix a compile warning
- use device_set_awake_path() and disable ref_out_clk in suspend
- remove pd_id from header
- reconstruct ufs_rockchip_hce_enable_notify() to workaround hce enable
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
 arch/arm64/boot/dts/rockchip/rk3576.dtsi           |  24 ++
 drivers/pmdomain/core.c                            |  35 ++
 drivers/pmdomain/rockchip/pm-domains.c             |   8 +
 drivers/ufs/core/ufshcd.c                          |   6 +-
 drivers/ufs/host/Kconfig                           |  12 +
 drivers/ufs/host/Makefile                          |   1 +
 drivers/ufs/host/ufs-rockchip.c                    | 363 +++++++++++++++++++++
 drivers/ufs/host/ufs-rockchip.h                    |  46 +++
 include/linux/pm_domain.h                          |   7 +
 include/soc/rockchip/rockchip_sip.h                |   3 +
 include/ufs/ufshcd.h                               |   2 +
 12 files changed, 610 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ufs/rockchip,rk3576-ufshc.yaml
 create mode 100644 drivers/ufs/host/ufs-rockchip.c
 create mode 100644 drivers/ufs/host/ufs-rockchip.h

-- 
2.7.4


