Return-Path: <linux-pm+bounces-42724-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AE1hBr0glGmKAAIAu9opvQ
	(envelope-from <linux-pm+bounces-42724-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 09:03:09 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62425149849
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 09:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75E9D302296D
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 08:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BC92D0C7B;
	Tue, 17 Feb 2026 08:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQtYpjli"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D3F2D7392
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 08:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771315300; cv=none; b=s8gLpnZvTx/W+qEXlTbf19aAeiL3UgVFuG7d6e30cVwpTlg3KHp5ZqjLXA6gih4lAHaIgDNa9IFzVKvpRh752oHL20Z3z0GOkrlZ4dcYjszdigy8Tyf/3iUg/hHglZSMwEna+tFyaNYANN5rQHQ1Th3qeYX5zfE3kuwaaSyH4Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771315300; c=relaxed/simple;
	bh=OfTkdLKhii631W7xDnbBCj+J4IweuTOYodhlfj8wGas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=huwkESA+nkIJxfWoBxOBicSO9UMwT8chzLLdjKrKUG3vLWumEcM+LWtoUF/cqimk4rrhU/JJ4pXUFUT0JWnsYPmErE2agYdyrjHxtqaQTrvxkhBjeTVzy9RrlgFeBSY2su17lyKfgCgu4nDsUOe5u3DhOzVP8ku0K48+9UXlnG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQtYpjli; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso10529415e9.3
        for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 00:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771315298; x=1771920098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ML/eqcDm9JPU41NbeTbVpohdII8TeXgVAo1wc0Rl7k=;
        b=YQtYpjliZ2FgTYusoVcvHd11h/yTjsh5zBNLZ6+bZyIhMq0qtJKBNSKj9In/PfJyOY
         6Yjs2pa/zbnEUH2iKcNkfi575p3ehwSLDcvDSQ2eaXtJ4RfWhCAHREPwmpJ+CEZQltdd
         IZJx4ink41QBwP1V0Bc7NCsSAfn/TocJyCvXN2nWv4ctkM7pdU0e3djApb7dBZ8/QKrJ
         mUfkiuki6esu4T82vmMYLrUFvmJoCngYgv29VhkczqdCHwuNm6odZL8ooTY3Ds8K+0FM
         q4sseoeHP9RweIn7ABmbSYfAczFjFp9GXQtQkaVnzcd/2sEeYV6i0RJfIkSsNfwEE0BR
         fIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771315298; x=1771920098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7ML/eqcDm9JPU41NbeTbVpohdII8TeXgVAo1wc0Rl7k=;
        b=G8NXRVMjwXeLEbh3zfneIN3CrbFRllPsrZsIK24pX2i19bNe90maqoshQE8F7L++q1
         dFVJBpFEICW0We5su2zN0VZRvVbQbdSKOnf55CFY5YtlsVC6PmDw/PlDzx2vZYn4pOEm
         baQnm2TefAJ5z5jv1evC/bMUqVsl6XGd92Vgq8DwD6QGIvPS94Ayzha53MdYAExrTm8F
         4P3J/byV3UiHE8RsE8y7GOVdkTYy0Z0waufS6xDIMVS6prP7LxgMjd0FsC8AGaULTzHc
         oO1TOtPx2F6pexywdo/s9QZMnHAf+0n9aWlGP5nOfhJ/Zc8RtoRh01cR5g5yJyP4HG//
         mZTA==
X-Forwarded-Encrypted: i=1; AJvYcCUfQGyRyUkEUd9Q64efmEV+ljLHa8/1Llp24zveitPSVovlNkbfFL7taMlFUU86BjE42sEHcD/ysA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6QqiKKrW2YFt2CzwGqb7sMEdFrJrMCrOJYlquHvA6cDYijDo0
	HvX/C4XKXW2WL6wNsVgyf/+KB9ippCCmJzD2DSQI78pbo2Uzouucvady
X-Gm-Gg: AZuq6aJKHWD34Jz6HTPfCJzDMpTroLqKzqe+2t9GfZlKUOn8U78MSj1hXul8VGRliPt
	DrxfmeXdveLiGMOqvUpd+FMGcMOa3ZqeMiLPVDlHRehvG/ie7C5v/gZT0/rXlEOZ6YCE5LPCLbY
	lMWyrNJ9FmpI2Q/5vDQUnPTvIuNq6WVRYRtiakmPYqFrwSLdNmJ5thVR/NLqHOMih3zQIUV5iYH
	h6E9Vom5/N/VA6RKVePLZstD+zNMbCay5j82UTGFWj+bBw2H012WDLTmmPzxKN8tU7ofrpXVCt+
	nTEdYimyrGhzDZzNjIpe8ywCvi8QF8Z4hrWWfDjNAHPI2pVTeoRA9T76tyWD2wi+x8gm/ISZse1
	02EGf1uO9tw5VM+5COwW6IxgsNnNBmG3w0e8QinppYSJQcNJQHa3FxNPTPDv0Uy+UOhkO2wjCql
	WIPKghq9ikCOqAOnVLog6xPyTNIZbIOjttcTw+Ei8ONQCR3UfSnXOEaEheaos=
X-Received: by 2002:a05:600c:8b4c:b0:480:5678:1fdd with SMTP id 5b1f17b1804b1-4837105240amr220470315e9.12.1771315297189;
        Tue, 17 Feb 2026 00:01:37 -0800 (PST)
Received: from ionutnechita-arz2022.localdomain ([2a02:2f07:6006:8800:54ea:a0a1:e16b:9ca4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48371a21cbesm153558775e9.5.2026.02.17.00.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 00:01:36 -0800 (PST)
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
Subject: [RFC PATCH 2/3] PCI: Add PCIe Gen 7 (128 GT/s) speed detection and reporting
Date: Tue, 17 Feb 2026 10:01:00 +0200
Message-ID: <20260217080102.206581-6-sunlightlinux@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42724-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 62425149849
X-Rspamd-Action: no action

From: Ionut Nechita <ionut_n2001@yahoo.com>

Add kernel infrastructure to detect and report PCIe Gen 7 128 GT/s
link speeds:

  - Extend PCIE_LNKCAP_SLS2SPEED, PCIE_LNKCAP2_SLS2SPEED, and
    PCIE_LNKCTL2_TLS2SPEED macros with 128 GT/s mapping
  - Add 128 GT/s to PCIE_SPEED2MBS_ENC bandwidth calculation using
    1:1 Flit mode encoding (no overhead), consistent with Gen 6
  - Add PCIE_SPEED_128_0GT to pcie_dev_speed_mbps() switch
  - Map link speed encoding 7 to PCIE_SPEED_128_0GT in
    pcie_link_speed[] table
  - Add "128.0 GT/s PCIe" display string
  - Add pcie_speed_requires_flit() helper for Gen 6+ speed
    validation with proper range check against PCI_SPEED_UNKNOWN
  - Widen pcie_get_supported_speeds() return type from u8 to u16
  - Add Flit mode diagnostic warning when Gen 6+ speed is active
    but PCI_EXP_LNKSTA2_FLIT is not set

Signed-off-by: Ionut Nechita <ionut_n2001@yahoo.com>
---
 drivers/pci/pci.c   |  7 +++++--
 drivers/pci/pci.h   | 28 ++++++++++++++++++++++------
 drivers/pci/probe.c |  3 ++-
 3 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 13dbb405dc31f..8091f7bf30e6f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5912,10 +5912,10 @@ EXPORT_SYMBOL(pcie_bandwidth_available);
  *
  * Return: Supported Link Speeds Vector (+ reserved 0 at LSB).
  */
-u8 pcie_get_supported_speeds(struct pci_dev *dev)
+u16 pcie_get_supported_speeds(struct pci_dev *dev)
 {
 	u32 lnkcap2, lnkcap;
-	u8 speeds;
+	u16 speeds;
 
 	/*
 	 * Speeds retain the reserved 0 at LSB before PCIe Supported Link
@@ -6020,6 +6020,9 @@ void __pcie_print_link_status(struct pci_dev *dev, bool verbose)
 
 	if (dev->bus && dev->bus->flit_mode)
 		flit_mode = ", in Flit mode";
+	else if (dev->bus && pcie_speed_requires_flit(dev->bus->cur_bus_speed))
+		pci_warn(dev, "Flit mode not active at %s, expected for Gen 6+\n",
+			 pci_speed_string(dev->bus->cur_bus_speed));
 
 	if (bw_avail >= bw_cap && verbose)
 		pci_info(dev, "%u.%03u Gb/s available PCIe bandwidth (%s x%d link)%s\n",
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 60542b05de0c6..4dd23f0d5de9f 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -487,7 +487,8 @@ void pci_bus_put(struct pci_bus *bus);
 ({									\
 	u32 lnkcap_sls = (lnkcap) & PCI_EXP_LNKCAP_SLS;			\
 									\
-	(lnkcap_sls == PCI_EXP_LNKCAP_SLS_64_0GB ? PCIE_SPEED_64_0GT :	\
+	(lnkcap_sls == PCI_EXP_LNKCAP_SLS_128_0GB ? PCIE_SPEED_128_0GT :	\
+	 lnkcap_sls == PCI_EXP_LNKCAP_SLS_64_0GB ? PCIE_SPEED_64_0GT :	\
 	 lnkcap_sls == PCI_EXP_LNKCAP_SLS_32_0GB ? PCIE_SPEED_32_0GT :	\
 	 lnkcap_sls == PCI_EXP_LNKCAP_SLS_16_0GB ? PCIE_SPEED_16_0GT :	\
 	 lnkcap_sls == PCI_EXP_LNKCAP_SLS_8_0GB ? PCIE_SPEED_8_0GT :	\
@@ -498,7 +499,8 @@ void pci_bus_put(struct pci_bus *bus);
 
 /* PCIe link information from Link Capabilities 2 */
 #define PCIE_LNKCAP2_SLS2SPEED(lnkcap2) \
-	((lnkcap2) & PCI_EXP_LNKCAP2_SLS_64_0GB ? PCIE_SPEED_64_0GT : \
+	((lnkcap2) & PCI_EXP_LNKCAP2_SLS_128_0GB ? PCIE_SPEED_128_0GT : \
+	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_64_0GB ? PCIE_SPEED_64_0GT : \
 	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_32_0GB ? PCIE_SPEED_32_0GT : \
 	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_16_0GB ? PCIE_SPEED_16_0GT : \
 	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_8_0GB ? PCIE_SPEED_8_0GT : \
@@ -510,7 +512,8 @@ void pci_bus_put(struct pci_bus *bus);
 ({									\
 	u16 lnkctl2_tls = (lnkctl2) & PCI_EXP_LNKCTL2_TLS;		\
 									\
-	(lnkctl2_tls == PCI_EXP_LNKCTL2_TLS_64_0GT ? PCIE_SPEED_64_0GT :	\
+	(lnkctl2_tls == PCI_EXP_LNKCTL2_TLS_128_0GT ? PCIE_SPEED_128_0GT :	\
+	 lnkctl2_tls == PCI_EXP_LNKCTL2_TLS_64_0GT ? PCIE_SPEED_64_0GT :	\
 	 lnkctl2_tls == PCI_EXP_LNKCTL2_TLS_32_0GT ? PCIE_SPEED_32_0GT :	\
 	 lnkctl2_tls == PCI_EXP_LNKCTL2_TLS_16_0GT ? PCIE_SPEED_16_0GT :	\
 	 lnkctl2_tls == PCI_EXP_LNKCTL2_TLS_8_0GT ? PCIE_SPEED_8_0GT :	\
@@ -519,9 +522,14 @@ void pci_bus_put(struct pci_bus *bus);
 	 PCI_SPEED_UNKNOWN);						\
 })
 
-/* PCIe speed to Mb/s reduced by encoding overhead */
+/* PCIe speed to Mb/s reduced by encoding overhead:
+ *   Gen 1-2 (2.5, 5 GT/s):       8b/10b encoding
+ *   Gen 3-5 (8, 16, 32 GT/s):    128b/130b encoding
+ *   Gen 6+  (64, 128 GT/s):      Flit mode, 1:1 (no encoding overhead)
+ */
 #define PCIE_SPEED2MBS_ENC(speed) \
-	((speed) == PCIE_SPEED_64_0GT ? 64000*1/1 : \
+	((speed) == PCIE_SPEED_128_0GT ? 128000*1/1 : \
+	 (speed) == PCIE_SPEED_64_0GT ? 64000*1/1 : \
 	 (speed) == PCIE_SPEED_32_0GT ? 32000*128/130 : \
 	 (speed) == PCIE_SPEED_16_0GT ? 16000*128/130 : \
 	 (speed) == PCIE_SPEED_8_0GT  ?  8000*128/130 : \
@@ -544,6 +552,8 @@ static inline int pcie_dev_speed_mbps(enum pci_bus_speed speed)
 		return 32000;
 	case PCIE_SPEED_64_0GT:
 		return 64000;
+	case PCIE_SPEED_128_0GT:
+		return 128000;
 	default:
 		break;
 	}
@@ -551,7 +561,13 @@ static inline int pcie_dev_speed_mbps(enum pci_bus_speed speed)
 	return -EINVAL;
 }
 
-u8 pcie_get_supported_speeds(struct pci_dev *dev);
+/* PCIe Gen 6+ (>= 64 GT/s) requires Flit mode with 1:1 encoding */
+static inline bool pcie_speed_requires_flit(enum pci_bus_speed speed)
+{
+	return speed >= PCIE_SPEED_64_0GT && speed <= PCIE_SPEED_128_0GT;
+}
+
+u16 pcie_get_supported_speeds(struct pci_dev *dev);
 const char *pci_speed_string(enum pci_bus_speed speed);
 void __pcie_print_link_status(struct pci_dev *dev, bool verbose);
 void pcie_report_downtraining(struct pci_dev *dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 9d4eeda5ea946..031c3ec8615d2 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -774,7 +774,7 @@ const unsigned char pcie_link_speed[] = {
 	PCIE_SPEED_16_0GT,		/* 4 */
 	PCIE_SPEED_32_0GT,		/* 5 */
 	PCIE_SPEED_64_0GT,		/* 6 */
-	PCI_SPEED_UNKNOWN,		/* 7 */
+	PCIE_SPEED_128_0GT,		/* 7 */
 	PCI_SPEED_UNKNOWN,		/* 8 */
 	PCI_SPEED_UNKNOWN,		/* 9 */
 	PCI_SPEED_UNKNOWN,		/* A */
@@ -816,6 +816,7 @@ const char *pci_speed_string(enum pci_bus_speed speed)
 	    "16.0 GT/s PCIe",		/* 0x17 */
 	    "32.0 GT/s PCIe",		/* 0x18 */
 	    "64.0 GT/s PCIe",		/* 0x19 */
+	    "128.0 GT/s PCIe",		/* 0x1a */
 	};
 
 	if (speed < ARRAY_SIZE(speed_strings))
-- 
2.53.0


