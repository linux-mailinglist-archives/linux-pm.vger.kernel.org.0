Return-Path: <linux-pm+bounces-42978-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aWRzGr89m2m8wgMAu9opvQ
	(envelope-from <linux-pm+bounces-42978-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sun, 22 Feb 2026 18:32:47 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C858516FED7
	for <lists+linux-pm@lfdr.de>; Sun, 22 Feb 2026 18:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82DE83009992
	for <lists+linux-pm@lfdr.de>; Sun, 22 Feb 2026 17:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D60357A3E;
	Sun, 22 Feb 2026 17:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmDQuE2U"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7366E23AB8D
	for <linux-pm@vger.kernel.org>; Sun, 22 Feb 2026 17:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771781562; cv=none; b=c8RiRY00tVzpx/TfGEyRWY3ZWAwTbP9QyYQONiAKjxjEsbFVmypUGZf+9KZzjuFzmC3nl3PIxiPw4qXkOunXRFk7EgRLlyJO8XgdGNHGLU6tA0HXgHdHCUHPo53Z9Xx7ev1+21XuJqqTzM/vf7bF1hYdYlJRlJCrlruc70din0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771781562; c=relaxed/simple;
	bh=84RpaymkYjedYJkOTZPTM2j0/+tI4Ix62BDTCGBRBsE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wswvt/gq/j6vwDC5a+jfhpF2//Cq+hYsIJzPzTu5BTuGUukioY0meEWi3E7/O3mdehRkmjJpqsVUSw06/JGLl5nlxBzv196xWVM/ZUVwWvOoOZt0FZ2OK4EbhdYCxVFSyQv2k1BtE8Vw9jnY4LDE9fDLvfaPCKOpmHtyAqgrWzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmDQuE2U; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-824b5f015bcso3518136b3a.1
        for <linux-pm@vger.kernel.org>; Sun, 22 Feb 2026 09:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771781561; x=1772386361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0C5225Erxu+gYNOcbLKnNHNXfo0Dpl+lzsBtZrdkm/8=;
        b=SmDQuE2UVw2NML8XELMybI7XwqNpcqvEKKHxeJEt0tohG2lpe6+fiuG10te8a8GE+U
         oqjyk6jpj9kFtk1j3gy8Cv3quNG56hs22Ul974Owbirjzdvn9iHv+1ESCgQNk07HfxR4
         Hf6KwqhlGpk6Gfm7hpvfvss8w2JrKTtpVFD9adsMy5hAdB9HHt4f1YyyVtoYAT3lWPu3
         j7OijO+w/iXsaXA7OYeKigzcgasBgTgj4nkef+dTVLsrVdjMNE6NLaRy4DafDAq4TPDH
         pWdxiXLiOQFbnfM33HEd5W9wijGNfFBKwme8gzmaemtkm/7BKjQjYdps9voe/IHzoosX
         JYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771781561; x=1772386361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0C5225Erxu+gYNOcbLKnNHNXfo0Dpl+lzsBtZrdkm/8=;
        b=LPhtq9CUI1HGhZaGP/r2HtdHqXRHXrfNcf0migIpFbCK3nGjWwdJPXQm6jhGxDQPh5
         CepCm9Be59qbH8e29cKkcr4Xbj1l38+whQlmei3+i0HWwPfsZJQup+P5d63l85reH7Kc
         u11IFE7KL4uHxyt8XA+161sxYjlAJeRhmGw/oP2B1yp6PIpkdqAO42LKcxtMAMWbeiCY
         a0qTc3kLJIQoNOPmG2JSEPKVVHP38TbJpZ+iK5Sb/eS3+BZ1IH+YMCI0usGvaCebgtih
         kqrbK8X6Jo+jmyYHQEDuJUfoD080K4eJCoodWNiwlnmQC0yFhpkrwbCrlddGEJpB9Rfo
         P9Eg==
X-Forwarded-Encrypted: i=1; AJvYcCWRwOx7mdKxQ/7n/xAAJRtnoncS4fWBKrdkdhvBSpxAkmFl1wDsdJwGdyC4gyjS7k5Tp86nZAcgAg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt2k/cgpIjVQumN9/hAQitaKoGRmDb1c5j9BVIwpL9NMa+C9uH
	Ze5MS9RcX4krRqT2Q1sRpytkLltGN9L3UdzbTpP6vIWIevd0wxvEmr6U
X-Gm-Gg: AZuq6aJRiqw5mNycdHOcTpVySNFY/DUxg6e7wPu1jLuaTW14o2YNmg+HaD1uXQ69qcv
	oXuI+2K6mLgQBBVfQrXPEz06eVarUNGlLL/fOB7pMfYKy/DWNsnw9aT30VZ7T7NA80UbcllrqG5
	ADJQV+i2055XK4tp83ZywlRdY9cEOHIwMTJbBJmQPFPJpb0UZkvA4+QXCVcRAxeXiFoRLzftnH+
	iviswc3XDTD+zI51z5/aoZ3ilx72d0e9Qvv10ddmIP6XpLF2ujkS3B0plSSmyRv+4jlKStc2Zv1
	EIaWuDgOWsrs2IKepZVoxSB0wfRuV9cbKyYzRSyV8HKNSKE9iPnC0I4E6HNZ4CkmifO2UI6CA7A
	22ILaP2IR+XQkIaG4IShZjgVC2mDvSnpUQfSXNwQgS/xAGQWV5ulu4q6oC5a78oEckVAeZJ97Qx
	3sB7N601fIbIFjgVrlDx5563OC54dRFGUZtktevtjmOxqEfsCcYRMtDxngUHMLdK2Ei0MoZe+Yy
	40VGOJYS/XdEdaEBP120HGAt1I5FMe4fP9Q
X-Received: by 2002:a05:6a21:3389:b0:35f:46d3:f28e with SMTP id adf61e73a8af0-39545f8d743mr5588261637.43.1771781560668;
        Sun, 22 Feb 2026 09:32:40 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (7.162.199.104.bc.googleusercontent.com. [104.199.162.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70b726cbf2sm5275750a12.34.2026.02.22.09.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 09:32:39 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: geert@linux-m68k.org,
	sre@kernel.org
Cc: jserv@ccns.ncku.edu.tw,
	eleanor15x@gmail.com,
	daniel@0x0f.com,
	laurent@vivier.eu,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-pm@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v3 0/2] Add QEMU virt-ctrl driver and update m68k virt
Date: Sun, 22 Feb 2026 17:32:23 +0000
Message-ID: <20260222173225.1105572-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.53.0.345.g96ddfc5eaa-goog
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[ccns.ncku.edu.tw,gmail.com,0x0f.com,vivier.eu,vger.kernel.org,lists.linux-m68k.org];
	TAGGED_FROM(0.00)[bounces-42978-lists,linux-pm=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[visitorckw@gmail.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-pm];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C858516FED7
X-Rspamd-Action: no action

Introduce a generic platform driver for the QEMU 'virt-ctrl' device [1]
and transitions the m68k 'virt' machine to use it, replacing
architecture-specific hooks.

The new driver ('qemu-virt-ctrl') registers a restart handler and
populates the global 'pm_power_off' callback.

On the m68k side, the platform initialization is updated to register
the 'qemu-virt-ctrl' platform device. Additionally, the 'mach_reset'
hook is bridged to 'do_kernel_restart()' to ensure the kernel's restart
handler chain is correctly invoked.

Verified on QEMU m68k virt. Both system reset and power-off were
confirmed functional by invoking 'reboot(LINUX_REBOOT_CMD_RESTART)',
'reboot(LINUX_REBOOT_CMD_POWER_OFF)', and
'reboot(LINUX_REBOOT_CMD_HALT)' from userspace.

Link: https://gitlab.com/qemu-project/qemu/-/blob/v10.2.0/hw/misc/virt_ctrl.c [1]
---
Changes in v3:
- Add a reboot notifier in the driver to handle LINUX_REBOOT_CMD_HALT.
- Handle native endianness in the driver instead of hardcoding
  big-endian I/O writes.
- Select POWER_RESET and POWER_RESET_QEMU_VIRT_CTRL in m68k
  Kconfig.machine.

Changes in v2:
- Use devm_register_sys_off_handler() instead of register_restart_handler()
  and global pm_power_off.
- Switch Kconfig to tristate to support modular build.
- Add .id_table to platform_driver and use MODULE_DEVICE_TABLE() to correct
  module auto-loading.

v2: https://lore.kernel.org/lkml/20260203170824.2968045-1-visitorckw@gmail.com/
v1: https://lore.kernel.org/lkml/20260112182258.1851769-1-visitorckw@gmail.com/

Kuan-Wei Chiu (2):
  power: reset: Add QEMU virt-ctrl driver
  m68k: virt: Switch to qemu-virt-ctrl driver

 MAINTAINERS                          |   6 ++
 arch/m68k/Kconfig.machine            |   2 +
 arch/m68k/virt/config.c              |  42 +--------
 arch/m68k/virt/platform.c            |  20 ++++-
 drivers/power/reset/Kconfig          |  10 +++
 drivers/power/reset/Makefile         |   1 +
 drivers/power/reset/qemu-virt-ctrl.c | 122 +++++++++++++++++++++++++++
 7 files changed, 159 insertions(+), 44 deletions(-)
 create mode 100644 drivers/power/reset/qemu-virt-ctrl.c

-- 
2.53.0.345.g96ddfc5eaa-goog


