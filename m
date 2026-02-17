Return-Path: <linux-pm+bounces-42722-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3JGQNlIglGmKAAIAu9opvQ
	(envelope-from <linux-pm+bounces-42722-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 09:01:22 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4F01497BF
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 09:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A477B3009B1F
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 08:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8ACC2D0C7B;
	Tue, 17 Feb 2026 08:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdRFFhAb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801C12367D5
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 08:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771315279; cv=none; b=NChzY5Ub0uTXeHEyn6Gz4sgZCfX0E8/8qVQsN/ieViyl8AsCHFGPea5Rb6FnAJato3jRSdC6LIc83vGpkcOlLV5w82Rh4/qqMZkSs14yahqYeXAso8rFCsX35jerSWNSF+GaSwXsv/pnBS1lptJNNyVDwEBZCcDD4gKdivcm6tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771315279; c=relaxed/simple;
	bh=1UCIQAMaTfESmQmryakYLGh5ALkY+Rp7DT+TZUGcZKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GN6Q2qEcyfwJ4JO3wBdPNC1W7G0ERcx8DdAZG3HrSvuJ8iQ3JH2ntPDBJNA75ZJc5KLFK2MmU0QaJkfRFbtlr0+9Vya15/2DXLdNBP/aNbSscfed/IgUgpNWYfEl08b9bB9wRWU5uUzKwtQjgxlb5prhYlGjbYe1n0bYbjwBArQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdRFFhAb; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso10525265e9.3
        for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 00:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771315277; x=1771920077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zLI1c+BVCTXh+QgGz9la+7RtF/6HCUTH3kkMfNUqGzw=;
        b=RdRFFhAb5fdirRQqxSGbijNEdqTvfEJYAN5lpEuaQAYmq4Kh6+XrvehyPicFspCI/S
         BgiLIpgGlMfikp5k6DMARk1qdx9Wj6+8fTV61NItkrIexERsFCcITOiRK1VBmSq6VQqU
         VUsKjQayqc+hkUU5ceXM+H+kV4rNRy/jR5CQBx359c26GSbat9KbrsIAGEA+8bmf3oWl
         Pzj75wRSbezyx+jfLR+O/CNw8AESF5sqWVONEBAnaPfsYPAyC/+Nd+ZyDsitUJIyjUgp
         yPCmCpEKspal1EKQC+syf/ycqTMrRuOYKnGQvo4jJYrhPZvz4/7d08yUyB2a9d9uFtPa
         v7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771315277; x=1771920077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLI1c+BVCTXh+QgGz9la+7RtF/6HCUTH3kkMfNUqGzw=;
        b=jKzfV4SdsGe6bzr3DHSndYYssflrvK9tMpWIPQeLSJicMNQl1hpZNAD63zScj+5xpP
         xmtvMl1ou32Ey5m40sQCXoURJMT3r8z221+rZ5Kq7JZtbj/4FGfW9sSlSWjRIaiJI9ha
         HYC+yPHEnB441E+/5aG2D6NONIz7dvvfYsnF1RP/usET0Pic/axiOPb9ZQujjf0kuLVm
         CD+0k4lqRAapOz0ijwgaM7CmfXfFgwt97g9YcxHgVyhoh6vxNwpZ0pUxL42gXUGhtBh9
         pTLCQC4k7B/2YlngN39xj1IGEKUwEtLMi4YQaamiYSP7lCcjVVGVlzwdQWh52AarFJxU
         6h3A==
X-Forwarded-Encrypted: i=1; AJvYcCUoARzHZJPQlhxoIWzdzHydDzzSThG67qn86KQ3FWlXQDFu24ANsqPJGIYoKJwLo5KslMSzVNZqIw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/fXKMB0LYMMYTAw1HIuHgCOXj67WUE0S/U8Am2pdA3s+b51z6
	tUMAfY9FQ6GKXCOHt34SvavYjN5iqQ9M9uFxhfLRf7jRjpl9sARkfLdV
X-Gm-Gg: AZuq6aIhwV05DaY7sNzUb6mj1qvDZcwnXb7F5ZW4SZ0/DqV7YrYoo8Ql13gJL6+H1ky
	LcwwzkSNMPkpG+9GtYE5ICZRS8LmUW1YABhpfdvooj1tQP9+kK7IYuDV8kFLor/v2DEDLbASd56
	yVfPviJ6HYn3FECvqcNpNJqGoubE6FeOvIE/pFzyluCE7jGe0pzKdXiATGcGnIqoWo5nTUWW7em
	0LvBmVj8WTtrf290Gnas2l+PxH5IsaupfypBgRpD/11eZHEHq1VQH4L+/pf6fDbum6Zdf5UC8ie
	lUCl2uDpSkbJFrX1S4gPh2v6y+IPsiFFZf67Ezo0UfTjpgJ5OiKuSC1wXyD4E4L0nfdjUJyZwDd
	IRH6qeRNEqohxHPE8X7YKWNMRBTzx86tGJMP3H6ZBJG89XY++trlqMfeRmgA8JMGAHQgrjt4n9P
	RNogXlhdauyce4hBB99AYzAn+FM/OrFiBtjBedwibUb0sVMLjna1DcF9fUp9Y=
X-Received: by 2002:a05:600c:474e:b0:479:3a86:dc1f with SMTP id 5b1f17b1804b1-4837109740amr239415095e9.37.1771315276687;
        Tue, 17 Feb 2026 00:01:16 -0800 (PST)
Received: from ionutnechita-arz2022.localdomain ([2a02:2f07:6006:8800:54ea:a0a1:e16b:9ca4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48371a21cbesm153558775e9.5.2026.02.17.00.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 00:01:16 -0800 (PST)
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
Subject: [RFC PATCH 0/3] PCI: Add PCIe Gen 7 (128 GT/s) speed support
Date: Tue, 17 Feb 2026 10:00:56 +0200
Message-ID: <20260217080102.206581-2-sunlightlinux@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	TAGGED_FROM(0.00)[bounces-42722-lists,linux-pm=lfdr.de];
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
X-Rspamd-Queue-Id: 2B4F01497BF
X-Rspamd-Action: no action

From: Ionut Nechita <ionut_n2001@yahoo.com>

This RFC series adds initial kernel support for PCIe Gen 7 128 GT/s
link speed, following the same pattern used for Gen 6 (64 GT/s).

PCIe Gen 7 doubles the per-lane data rate to 128 GT/s using PAM4
signaling with mandatory Flit mode encoding (1:1, no overhead),
providing up to 256 GB/s unidirectional (512 GB/s bi-directional)
bandwidth on an x16 link. The specification was announced by PCI-SIG
in 2022 and targeted for member release in 2025.

The series covers:

  Patch 1: UAPI register definitions (LNKCAP, LNKCAP2, LNKCTL2) and
           pci_bus_speed enum. Widens supported_speeds from u8 to u16
           to accommodate the expanded Supported Link Speeds Vector.

  Patch 2: Core PCI infrastructure - speed detection macros, bandwidth
           calculation with 1:1 Flit mode encoding, link speed table,
           display string, and a pcie_speed_requires_flit() helper
           with Flit mode diagnostic warning for Gen 6+ speeds.

  Patch 3: Subsystem updates for bandwidth control (bwctrl), port
           driver, and PCIe thermal cooling.

Not included in this series (not yet defined in the specification):
  - Equalization presets for 128 GT/s (PCI_EXT_CAP_ID_PL_128GT)
  - DesignWare controller preset programming for Gen 7

This is marked as RFC since no PCIe Gen 7 hardware exists yet to
validate the implementation. The register encoding values (LNKCAP
SLS=0x7, LNKCAP2 SLS bit 6, LNKCTL2 TLS=0x7) follow the sequential
pattern established by prior generations and are subject to change
when the final specification is published.

Tested: compile-tested only (no hardware available).

Ionut Nechita (3):
  PCI: Add PCIe Gen 7 (128 GT/s) register and speed definitions
  PCI: Add PCIe Gen 7 (128 GT/s) speed detection and reporting
  PCI: Update bandwidth control and thermal cooling for Gen 7 (128 GT/s)

 drivers/pci/pci.c              |  7 +++++--
 drivers/pci/pci.h              | 28 ++++++++++++++++++++++------
 drivers/pci/pcie/bwctrl.c      |  7 ++++---
 drivers/pci/pcie/portdrv.c     |  2 +-
 drivers/pci/probe.c            |  3 ++-
 drivers/thermal/pcie_cooling.c |  1 +
 include/linux/pci.h            |  3 ++-
 include/uapi/linux/pci_regs.h  |  3 +++
 8 files changed, 40 insertions(+), 14 deletions(-)

-- 
2.53.0


