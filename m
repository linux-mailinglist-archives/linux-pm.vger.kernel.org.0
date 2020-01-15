Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBD013CC6A
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2020 19:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbgAOSo0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jan 2020 13:44:26 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:48779 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729279AbgAOSo0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jan 2020 13:44:26 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 6CE0B21F69;
        Wed, 15 Jan 2020 13:44:25 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 15 Jan 2020 13:44:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=3KlDlXJYP55FN2KlL735TAQHph
        ecdn0T19PaZ/sz2EU=; b=O3qUU/HHgvK3c+ZwrOSrkOkV3J3HowBFw2ezurVez2
        P8BlsjXTKg1/SM4s4FLgaI8M1zZIUsOMRBzh7KiwLRdME9FxF5AmGvsUOxTjQth6
        rLnQgpzhWv1vIOB51po0CAt+AhiOP7hzSulWXznXHt9yghnoKHp8ZGGhX49SW/Vv
        oEXwAEZ1LySG7HJD1pUFifFYULgIQ8YHzj1trvJnmNYYDkKOVScRWr5tVTAy7jaq
        +XHbEe5boyv/wFKonXlhN5y9675YVPy275yKUYvTe1qNBdxqfitHjou5XAsy8DyY
        cxGyEjY/CKSy+Qc5P8UGykw1/Z1E59nXLFxXF49e7QVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=3KlDlXJYP55FN2KlL
        735TAQHphecdn0T19PaZ/sz2EU=; b=O5yLqWdKDUsbaAgoQdIT/vCuJogO+OSxU
        pwvWeFOKYgL9g5LwJvc0hUXhYCA9S6229D9ud5gKUT/Aw5/mLnkAtjIR19l8evxU
        ayFMTp070Sn5M2ePB+9qb1SCctpng00ewKAkIZjnb5FbF1Lgy52uGjFl5J9fOZlr
        pbhwrQudQHyhSuaJWt9XD1YXwIIaCZruMGOT4kAgYu6lxSKiHCtkeDRXJrlBdohD
        Kl0uFwqh8u6Xc6RYwIzhsMa+SsxjkyPeznD2B1E5fS3o0D+1ZvmlhBilfH+4YybW
        my/FdnbCBaCV7H7cjJV3fE72uwEuiRqqLeKNdtPI+6yiHpFcDY/5g==
X-ME-Sender: <xms:iF0fXngrJ6eBGGMJwsIT1N_BNGXy5bunTjNGd53wSM0zu340QSRxdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrtdefgdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeetnhgurhgvshcu
    hfhrvghunhguuceorghnughrvghssegrnhgrrhgriigvlhdruggvqeenucfkphepieejrd
    duiedtrddvudejrddvhedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvshes
    rghnrghrrgiivghlrdguvgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:iF0fXutXCF4QMqZj6RtX2jAD3QtOVVeiJqzpUW8SegJeDZC-GD-SVQ>
    <xmx:iF0fXvxasAxVE3gOorzDDGZqjiTLt632KpbsQdsGIJv6O1iGo1xPew>
    <xmx:iF0fXrbHGvviZpBbB_9O6kbdXBqjl4eOx8M6FWDwEm_EO3LCJTfGYQ>
    <xmx:iV0fXoABTEroMU1B3inWaYEDHRzIRKa_VUrEi8wLF0fnIoPaFwYMJA>
Received: from intern.anarazel.de (c-67-160-217-250.hsd1.ca.comcast.net [67.160.217.250])
        by mail.messagingengine.com (Postfix) with ESMTPA id AA11130602DE;
        Wed, 15 Jan 2020 13:44:24 -0500 (EST)
From:   Andres Freund <andres@anarazel.de>
To:     Tushar Dave <tushar.n.dave@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andres Freund <andres@anarazel.de>
Subject: [PATCH] thermal: intel_pch_thermal: Add PCI ids for Lewisburg PCH.
Date:   Wed, 15 Jan 2020 10:44:15 -0800
Message-Id: <20200115184415.1726953-1-andres@anarazel.de>
X-Mailer: git-send-email 2.25.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

I noticed that I couldn't read the PCH temperature on my workstation
(C620 series chipset, w/ 2x Xeon Gold 5215 CPUs) directly, but had to go
through IPMI. Looking at the data sheet, it looks to me like the
existing intel PCH thermal driver should work without changes for
Lewisburg.

I suspect there's some other PCI id's missing. But I hope somebody at
Intel would have an easier time figuring that out than I...

Signed-off-by: Andres Freund <andres@anarazel.de>
---
 drivers/thermal/intel/intel_pch_thermal.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/intel/intel_pch_thermal.c
index 4f0bb8f502e1..1f3ff0d489ef 100644
--- a/drivers/thermal/intel/intel_pch_thermal.c
+++ b/drivers/thermal/intel/intel_pch_thermal.c
@@ -23,6 +23,7 @@
 #define PCH_THERMAL_DID_SKL_H	0xA131 /* Skylake PCH 100 series */
 #define PCH_THERMAL_DID_CNL	0x9Df9 /* CNL PCH */
 #define PCH_THERMAL_DID_CNL_H	0xA379 /* CNL-H PCH */
+#define PCH_THERMAL_DID_LWB	0xA1B1 /* Lewisburg PCH */
 
 /* Wildcat Point-LP  PCH Thermal registers */
 #define WPT_TEMP	0x0000	/* Temperature */
@@ -272,6 +273,7 @@ enum board_ids {
 	board_wpt,
 	board_skl,
 	board_cnl,
+	board_lwb,
 };
 
 static const struct board_info {
@@ -294,6 +296,10 @@ static const struct board_info {
 		.name = "pch_cannonlake",
 		.ops = &pch_dev_ops_wpt,
 	},
+	[board_lwb] = {
+		.name = "pch_lewisburg",
+		.ops = &pch_dev_ops_wpt,
+	},
 };
 
 static int intel_pch_thermal_probe(struct pci_dev *pdev,
@@ -398,6 +404,8 @@ static const struct pci_device_id intel_pch_thermal_id[] = {
 		.driver_data = board_cnl, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_CNL_H),
 		.driver_data = board_cnl, },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_LWB),
+		.driver_data = board_lwb, },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, intel_pch_thermal_id);
-- 
2.25.0.rc1

