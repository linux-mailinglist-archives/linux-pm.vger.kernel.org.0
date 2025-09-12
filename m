Return-Path: <linux-pm+bounces-34554-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D80FB551BA
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 16:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D249C1C23DB2
	for <lists+linux-pm@lfdr.de>; Fri, 12 Sep 2025 14:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0388F322A05;
	Fri, 12 Sep 2025 14:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s4agQj0u"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732802FD7BB
	for <linux-pm@vger.kernel.org>; Fri, 12 Sep 2025 14:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757687273; cv=none; b=Eo7M8723fCmx4NIz4UOj1IOsOYIAAWDiJ2X3JmVIfr2O88LvNqpX70eSgC296t1yndq3mR023EcsOcB24n3bBTpPHDcEq7VA78XxorxEuEUZbh3g4v0iHmRDFYrZfh8nJoNomSG2abAVoSD8o02OkLqgtevhPZP5auF7xfxrCmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757687273; c=relaxed/simple;
	bh=/SxMVDTkZvMbBsZ1m84K+ZCGY5O9Fq7p3OG5ytCeDD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F26PiEQTgss8ugsY7zu+4/rUPoX9XT8d7McJZjSlBJikt3q9ngrvAomGzP6B+0Fk7ZVX8Zs8UUNP80LcBK8hTJ1Yy8pso8k/8iDLNsdIUvY4uobhpy7s4fHQddOr/g1w90APBzQg/jKqGFfy4D/KJ8mfuOR6I6QNADfDhQdQLR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s4agQj0u; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55f753ec672so2199332e87.2
        for <linux-pm@vger.kernel.org>; Fri, 12 Sep 2025 07:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757687268; x=1758292068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IKVoiH7XLcNaedQxfza9YTAwsoIt9Wu8Ls74q3lR27g=;
        b=s4agQj0u4cXaFPaAuF9mFttWruoV1C+57lvE+Xj/cDoUrJAeY8r89NeDKQMcINMNWo
         Kr82UEapqfxy7x84LnApjZXgZBRvK5luai7328umO0R+tb3pN7r4qTv28oxFtEY1Do9A
         zNk1FaXEaEldVzNtI8uOJKY2dC4CnkO5KQyI4T7u3yd2yY00Rk+R/TgusR9AAL1OdiH5
         08f/GPTuk+6awbIxQUl/1z7t/8DgWvVWdxGIk8gmiEkwQ2yjk7cVWsCgdwMwZrQ3XdDM
         VDZ666z8EAT6xuyXzN3uhnffVeBs1ZuA0hogbYfvHecIhXCmc4qgLNrRmIqwV3KcquQK
         q+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757687268; x=1758292068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IKVoiH7XLcNaedQxfza9YTAwsoIt9Wu8Ls74q3lR27g=;
        b=E4fH+3/xmZBPUILXYX5ezQQ2U5NdAd23apPh4/ZpqWyKLIK6QWwLFmwRqYuaAg8Fnx
         nTGgahQy/qQSPg4UtFwATjbJ/AembVEvKCZPDNUYbcjnH8HXtN6PPpqux//Ff/20/Scz
         MxjHQuqMFdrttLSLPXoZJ4cInELxAJIOtSicE6FwzQLz/yUhZlh+XYEqvG+aatDrOqmP
         cg5wa0pfeFKc0PHR9xWvFjLBMy7HMXW3T4HrwXi/BCdVarxnbAWBRmiq+DCM9KUaZlHD
         j2xlayoRP9TD2OA1yjPCLgpchi80Q2PuZWe3+QMa353vuSQw1qch5GyRFcmKcUX8Fajo
         DHmg==
X-Gm-Message-State: AOJu0YxFZAy4HMDrmyrCmxYAn1VG8Aubxh7xYTgpg+gcF4gVRYGcDN3x
	FRwV2y8G752Q/2VJIfp6g4Hf3QLnz3JS+1/mDrhXrGn/iStxYozpxueEkBn2K7PJaYWl7RfAge2
	4UBC7VVw=
X-Gm-Gg: ASbGncvcNGOGbyh9mwfXi3H9tcR5+zfWzi9tBP/rllnqri+HAoQ7fJiR3rwIuGCKcwi
	+hTnF74sTzjxUIggo9g5/iMgDKzH81ZpKLcxs/dTYIEe4v3reuVzME3TEK8MvdIq3wCAm1uz+DO
	rFHVdkj7groUvZDT1uW/8QqHq68LUgLMjM9SpMNdbBHDHdYKAXsMyPuDq7v/hJdJdcwyoOAh2y1
	dzb0xc1Sl2DelMW38XXbC1waUti83qgMzaegTuhIYLfv7aCCrSAkZMkgs3Zuf2vItgCVYwx0iKs
	neZ33fcYQiGIwvVOHwW3cIKh80Dgzh51bTBJxyHxXKV/oeZkY+IQzuG6mVhB3B5IiXOzOk4GuiJ
	HTbEIUVSOK+6W07IpC4Tuaa7H7GHWE08wbnDPt6HHMqszrWWRnXhWIqQ=
X-Google-Smtp-Source: AGHT+IEElym8VeagaBl+nzdswFEmu7VAD/4OSv6vmc7bSL5e4EMGTxBVOdIqLiD6z+3vnjFAisOdJQ==
X-Received: by 2002:a19:6a13:0:b0:55f:6a68:c44a with SMTP id 2adb3069b0e04-5704a105f44mr667707e87.2.1757687268467;
        Fri, 12 Sep 2025 07:27:48 -0700 (PDT)
Received: from nuoska (87-100-249-247.bb.dnainternet.fi. [87.100.249.247])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e63c63daesm1171816e87.77.2025.09.12.07.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 07:27:48 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: ulf.hansson@linaro.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mikko Rapeli <mikko.rapeli@linaro.org>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 1/4] pmdomain: rockchip: enable ROCKCHIP_PM_DOMAINS with ARCH_ROCKCHIP
Date: Fri, 12 Sep 2025 17:27:35 +0300
Message-ID: <20250912142735.2843958-1-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On rk3399 based rockpi4b, mounting rootfs from mmc fails unless
ROCKCHIP_PM_DOMAINS is enabled. Accoriding to
Heiko Stübner <heiko@sntech.de> all SoCs since 2012 have power
domains so the support should be enabled by default
on both arm and arm64.

Failing boot without CONFIG_ROCKCHIP_PM_DOMAINS=y:

https://ledge.validation.linaro.org/scheduler/job/119268

/dev/disk/by-partuuid/1d48ffd8-f2a7-4a33-b52f-186089b3c85e: Can't lookup blockdev
/dev/disk/by-partuuid/1d48ffd8-f2a7-4a33-b52f-186089b3c85e: Can't lookup blockdev
/dev/disk/by-partuuid/1d48ffd8-f2a7-4a33-b52f-186089b3c85e: Can't lookup blockdev
/dev/disk/by-partuuid/1d48ffd8-f2a7-4a33-b52f-186089b3c85e: Can't lookup blockdev
/dev/disk/by-partuuid/1d48ffd8-f2a7-4a33-b52f-186089b3c85e: Can't lookup blockdev
/dev/disk/by-partuuid/1d48ffd8-f2a7-4a33-b52f-186089b3c85e: Can't lookup blockdev
dw-apb-uart ff1a0000.serial: forbid DMA for kernel console
root '/dev/disk/by-partuuid/1d48ffd8-f2a7-4a33-b52f-186089b3c85e' doesn't exist or does not contain a /dev.
rk_gmac-dwmac fe300000.ethernet: deferred probe timeout, ignoring dependency
rk_gmac-dwmac fe300000.ethernet: probe with driver rk_gmac-dwmac failed with error -110
rk_iommu ff650800.iommu: deferred probe timeout, ignoring dependency
rk_iommu ff650800.iommu: probe with driver rk_iommu failed with error -110
dwmmc_rockchip fe320000.mmc: deferred probe timeout, ignoring dependency
rockchip-typec-phy ff7c0000.phy: deferred probe timeout, ignoring dependency
dwmmc_rockchip fe320000.mmc: probe with driver dwmmc_rockchip failed with error -110
rockchip-typec-phy ff7c0000.phy: probe with driver rockchip-typec-phy failed with error -110
rockchip-typec-phy ff800000.phy: deferred probe timeout, ignoring dependency
rockchip-typec-phy ff800000.phy: probe with driver rockchip-typec-phy failed with error -110
rk_iommu ff660480.iommu: deferred probe timeout, ignoring dependency
rk_iommu ff660480.iommu: probe with driver rk_iommu failed with error -110
rk_iommu ff8f3f00.iommu: deferred probe timeout, ignoring dependency
rk_iommu ff8f3f00.iommu: probe with driver rk_iommu failed with error -110
rk_iommu ff903f00.iommu: deferred probe timeout, ignoring dependency
rk_iommu ff903f00.iommu: probe with driver rk_iommu failed with error -110
rk_iommu ff914000.iommu: deferred probe timeout, ignoring dependency
rk_iommu ff914000.iommu: probe with driver rk_iommu failed with error -110
rk_iommu ff924000.iommu: deferred probe timeout, ignoring dependency
rk_iommu ff924000.iommu: probe with driver rk_iommu failed with error -110
platform fe800000.usb: deferred probe pending: platform: wait for supplier /phy@ff7c0000/usb3-port
sdhci-arasan fe330000.mmc: deferred probe timeout, ignoring dependency
platform fe900000.usb: deferred probe pending: platform: wait for supplier /phy@ff800000/usb3-port
sdhci-arasan fe330000.mmc: probe with driver sdhci-arasan failed with error -110
platform ff1d0000.spi: deferred probe pending: (reason unknown)
platform hdmi-sound: deferred probe pending: asoc-simple-card: parse error

Working boot with CONFIG_ROCKCHIP_PM_DOMAINS=y:

https://ledge.validation.linaro.org/scheduler/job/119272

dwmmc_rockchip fe320000.mmc: IDMAC supports 32-bit address mode.
dwmmc_rockchip fe320000.mmc: Using internal DMA controller.
dwmmc_rockchip fe320000.mmc: Version ID is 270a
dwmmc_rockchip fe320000.mmc: DW MMC controller at irq 45,32 bit host data width,256 deep fifo
dwmmc_rockchip fe320000.mmc: Got CD GPIO
ff1a0000.serial: ttyS2 at MMIO 0xff1a0000 (irq = 44, base_baud = 1500000) is a 16550A
printk: legacy console [ttyS2] enabled
mmc_host mmc1: Bus speed (slot 0) = 400000Hz (slot req 400000Hz, actual 400000HZ div = 0)
dw_wdt ff848000.watchdog: No valid TOPs array specified
mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req 50000000Hz, actual 50000000HZ div = 0)
mmc0: CQHCI version 5.10
rk_gmac-dwmac fe300000.ethernet: IRQ eth_wake_irq not found
mmc1: new high speed SDHC card at address aaaa
fan53555-regulator 0-0040: FAN53555 Option[8] Rev[1] Detected!
fan53555-regulator 0-0041: FAN53555 Option[8] Rev[1] Detected!
rk_gmac-dwmac fe300000.ethernet: IRQ eth_lpi not found
mmcblk1: mmc1:aaaa SC16G 14.8 GiB
rk_gmac-dwmac fe300000.ethernet: IRQ sfty not found
GPT:Primary header thinks Alt. header is not at the end of the disk.
rk_gmac-dwmac fe300000.ethernet: Deprecated MDIO bus assumption used
GPT:1978417 != 31116287
rk_gmac-dwmac fe300000.ethernet: PTP uses main clock
GPT:Alternate GPT header not at the end of the disk.
rk_gmac-dwmac fe300000.ethernet: clock input or output? (input).
GPT:1978417 != 31116287
rk_gmac-dwmac fe300000.ethernet: TX delay(0x28).
GPT: Use GNU Parted to correct GPT errors.
rk_gmac-dwmac fe300000.ethernet: RX delay(0x11).
 mmcblk1: p1 p2 p3 p4 p5 p6 p7 p8

Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
Suggested-by: Heiko Stübner <heiko@sntech.de>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 drivers/pmdomain/rockchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pmdomain/rockchip/Kconfig b/drivers/pmdomain/rockchip/Kconfig
index 218d43186e5b9..17f2e6fe86b6f 100644
--- a/drivers/pmdomain/rockchip/Kconfig
+++ b/drivers/pmdomain/rockchip/Kconfig
@@ -3,6 +3,7 @@ if ARCH_ROCKCHIP || COMPILE_TEST
 
 config ROCKCHIP_PM_DOMAINS
 	bool "Rockchip generic power domain"
+	default ARCH_ROCKCHIP
 	depends on PM
 	depends on HAVE_ARM_SMCCC_DISCOVERY
 	depends on REGULATOR
-- 
2.34.1


