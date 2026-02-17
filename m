Return-Path: <linux-pm+bounces-42723-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKK0F4UglGmKAAIAu9opvQ
	(envelope-from <linux-pm+bounces-42723-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 09:02:13 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F26A0149804
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 09:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F121D301325A
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 08:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51C62DA75B;
	Tue, 17 Feb 2026 08:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZU/pKziZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FED7287511
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 08:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771315292; cv=none; b=BWqhz3puYb6ZhYVqVr0iXA2U8+1BOxK416gkuuoYYoo+q4P0XTX7Iu7IUoQSWiU6JK96CEblDDpkB7l5d0MZyCEtv798OdQy9XdR1btr+5ZvBqLjs+/igu2dQfYnGB9UG0Gn3h5dZs4A/7GGzYQVx/GTgjYVgCqaUrScQTrTqRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771315292; c=relaxed/simple;
	bh=l/XFNhsX7ERB7yaujlgzJEC3/+9JE4SydtkgZp8Bemg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NwVK6sVSGqOucD6+cXCr39QFMZrxMYEzFh2BMIfSuWPeuPvnvuGWhXWnABTdhBbmZLE5RySUP+f560nX0FVUqGMh0bxXK5qdP7u44wdG4q29i7nFTPoZcnG3z6qpGRIxxso+tylqRCce1u+2GcciS6zhGQin8r0HaTyn5H+zKmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZU/pKziZ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48371119eacso36315625e9.2
        for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 00:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771315290; x=1771920090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kF6ZhZceexRomvWkubldKlsxvta1sWwN/u0Zy1Qrmak=;
        b=ZU/pKziZLd2CumEKBPlwgIGSbeZw35K3R3k1vs9uQ+VcfMGslVuPteJhXSopvViZy8
         B6WzQO72TAxRhGovpNEaiAjMmHHf41Or7UUxD708DrnsSPtnOCVbWabdPoCPqTrZBZuz
         2X9M5+oPaKGq4hwZ3nMjmcrkMBet/L5YZaEajEK1K1PnEm1lM+NJRb2YNtvRdb6jASd5
         eba4UYuooAuX7XvSrGUToNt7GHhmVkTsj1AweqYhPTQpMaCQlinLSRC7X59sP9Vk6UMg
         gDpdOyp3h0hqBK7Wv5BbOS4QUMbPNr1Sw3Fl5aYjUtArazE3B3U067xUQziZ9w0Ch5yN
         fW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771315290; x=1771920090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kF6ZhZceexRomvWkubldKlsxvta1sWwN/u0Zy1Qrmak=;
        b=IBUPsBieeOgC92oV5mK5a5jewGYwh6Nd1DXuSchKLILKuw/R+9nUzx2PUYkxRwreDU
         TptgXvU1kNDSP6N9ZRCLsSmG4DtoIH1vpiicuQ+WlPuCLKp2EyJfAT4jLiK+QTGzTGKy
         UQ7CCMmvciapCdkY2rX69gHNE79DTlyQv9ijWmynoHrXYx4Xk0DuMJOlEVcU0tgz+HsZ
         SfYlZ0xqk457r2Rvk6EYLyVKArz14nF1a1l7AVaMSHIO0U/9wRp5Arb7wBxqwfE1blgY
         T/BQ7wBlBUTVeXs7VTcoB6GSAwyYHKZj+pizszAFY0oHuI+oEIHeVnETWs6cJePDeI44
         TCUw==
X-Forwarded-Encrypted: i=1; AJvYcCXVmUxA8PsMy2p3VsmUx4ETbs6NXrvZXHZLG5w0XR9tJjieyrn3CgbW38CZFniSAfuPm26S5BAmYA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwlS1nZELTrw1uqQB1v/nLvTDOJ74pnLjibxkR+jzYfeLVwQR/M
	U1+v5RUIhunam7157aq8TxzTlDhjRTX9znIrH7WovEOynZzEhzINgWxG
X-Gm-Gg: AZuq6aJT6U03qgVr0xCIhqXHgQ9DyI/N+LZURx+pDM8RJYgj46KaDuZ6gvE6oIAWl/6
	fBpe6y/FAU5LJ4Uq1MhIGvLZCBOiS37gi6/Tr+qXbJzSegTVocyWHdPw2TpZZl54PQ1VsVuaioQ
	HpXjJUS8vVoaDnxyyWLtmRezBffkSHPbih5LdH9nEfDDBXqLaSgjIb26vRjEnywAFLnzA83lFoj
	gatefZLUed91RmiB0UB2oCVzyVZcExvS9qpRF+gYD994TKSjC2Ikvd7MYv76YNrzQ4bY4JrMeiA
	DcX3UJxN4Nv0hfMsUx2414KzURzNOMwhAbMjfSDvixwpif5yuzUf+mRZm5BvX4wFx6JetSuGjyw
	NxTfxgQn+jvk+5gZQFso1dQx6I5f8t4mAlbl2ktK7MUQz+ERA8a87NmiJYUS4i1VQG3G2ujiNr/
	Ev8l9EYgT+7+Es+giSewuEwPepzA+SkHT/ipN+eduOq/oD5ZHhNpBDRR5QMuY=
X-Received: by 2002:a05:600c:a08c:b0:477:6374:6347 with SMTP id 5b1f17b1804b1-48373a5bad7mr216247045e9.22.1771315289461;
        Tue, 17 Feb 2026 00:01:29 -0800 (PST)
Received: from ionutnechita-arz2022.localdomain ([2a02:2f07:6006:8800:54ea:a0a1:e16b:9ca4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48371a21cbesm153558775e9.5.2026.02.17.00.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 00:01:29 -0800 (PST)
From: "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Lukas Wunner <lukas@wunner.de>,
	Ionut Nechita <sunlightlinux@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ionut Nechita <ionut_n2001@yahoo.com>
Subject: [RFC PATCH 1/3] PCI: Add PCIe Gen 7 (128 GT/s) register and speed definitions
Date: Tue, 17 Feb 2026 10:00:58 +0200
Message-ID: <20260217080102.206581-4-sunlightlinux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217080102.206581-2-sunlightlinux@gmail.com>
References: <20260217080102.206581-2-sunlightlinux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42723-lists,linux-pm=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,arm.com,wunner.de,gmail.com,vger.kernel.org,yahoo.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunlightlinux@gmail.com,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F26A0149804
X-Rspamd-Action: no action

From: Ionut Nechita <ionut_n2001@yahoo.com>

Add register definitions for PCIe Gen 7 128 GT/s link speed:

  - PCI_EXP_LNKCAP_SLS_128_0GB (encoding 0x7)
  - PCI_EXP_LNKCAP2_SLS_128_0GB (bit 6 in Supported Link Speeds Vector)
  - PCI_EXP_LNKCTL2_TLS_128_0GT (Target Link Speed 0x7)
  - PCIE_SPEED_128_0GT enum value (0x1a)

Widen pci_dev.supported_speeds from u8 to u16 to accommodate the
expanded Supported Link Speeds Vector which now uses bits 1-7.

PCIe Gen 7 doubles the data rate to 128 GT/s using PAM4 signaling
with mandatory Flit mode encoding (1:1, no overhead), providing
up to 256 GB/s unidirectional (512 GB/s bi-directional) bandwidth
on an x16 link.

Note: Based on the PCIe 7.0 specification announced by PCI-SIG in
2022, targeted for member release in 2025. No hardware exists yet
to validate these definitions.

Signed-off-by: Ionut Nechita <ionut_n2001@yahoo.com>
---
 include/linux/pci.h           | 3 ++-
 include/uapi/linux/pci_regs.h | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index b5cc0c2b99065..21dd6ea5beb6d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -303,6 +303,7 @@ enum pci_bus_speed {
 	PCIE_SPEED_16_0GT		= 0x17,
 	PCIE_SPEED_32_0GT		= 0x18,
 	PCIE_SPEED_64_0GT		= 0x19,
+	PCIE_SPEED_128_0GT		= 0x1a,
 	PCI_SPEED_UNKNOWN		= 0xff,
 };
 
@@ -558,7 +559,7 @@ struct pci_dev {
 	struct pci_tsm *tsm;		/* TSM operation state */
 #endif
 	u16		acs_cap;	/* ACS Capability offset */
-	u8		supported_speeds; /* Supported Link Speeds Vector */
+	u16		supported_speeds; /* Supported Link Speeds Vector */
 	phys_addr_t	rom;		/* Physical address if not from BAR */
 	size_t		romlen;		/* Length if not from BAR */
 	/*
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 3add74ae25948..fa00c6ca9f382 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -545,6 +545,7 @@
 #define  PCI_EXP_LNKCAP_SLS_16_0GB 0x00000004 /* LNKCAP2 SLS Vector bit 3 */
 #define  PCI_EXP_LNKCAP_SLS_32_0GB 0x00000005 /* LNKCAP2 SLS Vector bit 4 */
 #define  PCI_EXP_LNKCAP_SLS_64_0GB 0x00000006 /* LNKCAP2 SLS Vector bit 5 */
+#define  PCI_EXP_LNKCAP_SLS_128_0GB 0x00000007 /* LNKCAP2 SLS Vector bit 6 */
 #define  PCI_EXP_LNKCAP_MLW	0x000003f0 /* Maximum Link Width */
 #define  PCI_EXP_LNKCAP_ASPMS	0x00000c00 /* ASPM Support */
 #define  PCI_EXP_LNKCAP_ASPM_L0S 0x00000400 /* ASPM L0s Support */
@@ -693,6 +694,7 @@
 #define  PCI_EXP_LNKCAP2_SLS_16_0GB	0x00000010 /* Supported Speed 16GT/s */
 #define  PCI_EXP_LNKCAP2_SLS_32_0GB	0x00000020 /* Supported Speed 32GT/s */
 #define  PCI_EXP_LNKCAP2_SLS_64_0GB	0x00000040 /* Supported Speed 64GT/s */
+#define  PCI_EXP_LNKCAP2_SLS_128_0GB	0x00000080 /* Supported Speed 128GT/s */
 #define  PCI_EXP_LNKCAP2_CROSSLINK	0x00000100 /* Crosslink supported */
 #define PCI_EXP_LNKCTL2		0x30	/* Link Control 2 */
 #define  PCI_EXP_LNKCTL2_TLS		0x000f
@@ -702,6 +704,7 @@
 #define  PCI_EXP_LNKCTL2_TLS_16_0GT	0x0004 /* Supported Speed 16GT/s */
 #define  PCI_EXP_LNKCTL2_TLS_32_0GT	0x0005 /* Supported Speed 32GT/s */
 #define  PCI_EXP_LNKCTL2_TLS_64_0GT	0x0006 /* Supported Speed 64GT/s */
+#define  PCI_EXP_LNKCTL2_TLS_128_0GT	0x0007 /* Supported Speed 128GT/s */
 #define  PCI_EXP_LNKCTL2_ENTER_COMP	0x0010 /* Enter Compliance */
 #define  PCI_EXP_LNKCTL2_TX_MARGIN	0x0380 /* Transmit Margin */
 #define  PCI_EXP_LNKCTL2_HASD		0x0020 /* HW Autonomous Speed Disable */
-- 
2.53.0


