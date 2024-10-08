Return-Path: <linux-pm+bounces-15324-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AFD994778
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 13:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB62C288327
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 11:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB62D1DE4F6;
	Tue,  8 Oct 2024 11:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="KgWcxmci"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-m92248.xmail.ntesmail.com (mail-m92248.xmail.ntesmail.com [103.126.92.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396A81D432D;
	Tue,  8 Oct 2024 11:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.126.92.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728387716; cv=none; b=cXFdOjeHCzUTPtJY8FY5m07bndzOyeOWanEcTyvw5vsHl4JNUbyK5QVBAHEatwDCAvThVH2aeymPwsRu8ynWST0feheTeZFDmT/WL7Rh2GlzH4iRtiAJ5zfuDsHjH6/Ii+EBL8iJ6JCyEgh4X+RGb4sEpeOQ3Z32wdcF9N8YOMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728387716; c=relaxed/simple;
	bh=LqFmd05ir7RUy3YMIpP/6IvCOkRh3HSEHwPzr7nSMO0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=NN/yOEtBs+gyMfgvI6oQU+GLASJuH1qKHx87gtcMckwjIpOC3imWPiNzyPUrh96EJWws96ZZymrrenhoNClSNWDlmk1SSv3FK6cC38Wi7xB78ery3ZfjusVqCm8A8sZN3Lu9ytDfBDhP8rdIi/XTyOAPdSWEiKPe1FHL3biUA4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=KgWcxmci; arc=none smtp.client-ip=103.126.92.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=KgWcxmciS5GpTyARwQKc6LgB1GSoVgqp2cAyyTzFohP9VzhACD6syEFaz9rP2m1BdhLv/8GBTE1ZkwNUrpibIE/EdUjSBiOYgbb/EG2+9Tz2JyJfcgvQok5xP8Ns5VbKEFwlLqZWY2Bxmpiew2YPP1y5fdvSoZ4MK8XdFl+sijI=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=2RS102Ukpw/1cre6YFY4SwFwGmpEzgGiNXvoLSujjwY=;
	h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTPA id EBDA5520711;
	Tue,  8 Oct 2024 14:15:57 +0800 (CST)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Rob Herring <robh+dt@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	YiFeng Zhao <zyf@rock-chips.com>,
	Liang Chen <cl@rock-chips.com>,
	linux-scsi@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 0/5] Initial support for RK3576 UFS controller
Date: Tue,  8 Oct 2024 14:15:25 +0800
Message-Id: <1728368130-37213-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk5KT1ZISE5JQ0oYTBkYS01WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a926ac528db03afkunmebda5520711
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PBA6Cio5NTIdTRYpCStNDkgj
	Dy9PCi5VSlVKTElDSE1DSk5CT0JMVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQU9LQ0I3Bg++
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>


This patchset adds initial UFS controller supprt for RK3576 SoC.
Patch 1 adds new quirk and patch 2 is the dt-bindings.
patch 3/4 deal with rpm and spm support in advanced. Final atch 5 is the
driver added.


Changes in v3:
- rename the file to rockchip,rk3576-ufshc.yaml
- add description for reset-gpios
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

Shawn Lin (5):
  scsi: ufs: core: Add UFSHCI_QUIRK_DME_RESET_ENABLE_AFTER_HCE
  dt-bindings: ufs: Document Rockchip UFS host controller
  soc: rockchip: add header for suspend mode SIP interface
  soc: rockchip: power-domain: Add GENPD_FLAG_RPM_ALWAYS_ON support
  scsi: ufs: rockchip: initial support for UFS

 .../bindings/ufs/rockchip,rk3576-ufshc.yaml        | 103 ++++++
 drivers/pmdomain/rockchip/pm-domains.c             |   3 +
 drivers/ufs/core/ufshcd.c                          |  17 +
 drivers/ufs/host/Kconfig                           |  12 +
 drivers/ufs/host/Makefile                          |   1 +
 drivers/ufs/host/ufs-rockchip.c                    | 346 +++++++++++++++++++++
 drivers/ufs/host/ufs-rockchip.h                    |  51 +++
 include/soc/rockchip/rockchip_sip.h                |   3 +
 include/ufs/ufshcd.h                               |   6 +
 9 files changed, 542 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ufs/rockchip,rk3576-ufshc.yaml
 create mode 100644 drivers/ufs/host/ufs-rockchip.c
 create mode 100644 drivers/ufs/host/ufs-rockchip.h

-- 
2.7.4


