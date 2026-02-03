Return-Path: <linux-pm+bounces-41991-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4B3hFp8rgmlxQAMAu9opvQ
	(envelope-from <linux-pm+bounces-41991-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 18:08:47 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE74BDC855
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 18:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EB7FE302EBCA
	for <lists+linux-pm@lfdr.de>; Tue,  3 Feb 2026 17:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A56239B488;
	Tue,  3 Feb 2026 17:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ic6AYdun"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FFD33F8D3
	for <linux-pm@vger.kernel.org>; Tue,  3 Feb 2026 17:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770138518; cv=none; b=jGYEi6Na7LPQ7IuQuSQZGM7AADjdQFM0rgGYigZF2LNT8+n5/qX/JXkF1Zjcd6yIg2RAmXTPN6XG7QzEVVRN+04swNCWyf0cjlprqQ1rzTuMqOGWYBmzvIe0J0QBaytdxrlH5nxw4rehKTxL+BxyoJysP58Tt8n6bWEIwMgkkus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770138518; c=relaxed/simple;
	bh=9d2BGazhIYXPwhBFBoQUyC6ZxxKt0RrvnVioMb0m0gc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZOk1QUCHre5Mi4iixx9NtJWKGDd77qKKpuJCAEhZTE7r79v8V80DS43bq8qOp0e/Ljdal+ZTa32aGe/w7U0/MxJLC03FSPmTw+ubq6jxhB2IHQ2lSrxgbav1bX1PD71lsMxH9qhkUDkwL7XUDkaWIHOcaBxa4Mxxw9N9O2CWtoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ic6AYdun; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-352ccc61658so2824620a91.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Feb 2026 09:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770138516; x=1770743316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X75L+uiZCaHBsd3xEjw6pILEYYmRHS59ChoDO8zTouY=;
        b=ic6AYdun5han+IbUqIt9lRV4Ps37TbTTWbrF/E61wVL/aNceZtiZWmqqh/EVtG4wFF
         3HzD3mxSYn8+MhAx1Toji+ag+jVOOkHQffs4y1gWFCjy4YZAeiu2zGytH3ArzyfjD6jO
         jm4wKRbSfT0WQJW6EZhLKQyk6TLK242eZCHzMIPE1PjiHeVhfEmtzSOxVDKSgordxBP1
         PNUtayIjQvwVItsC/vF7xW+hF/diw0TMOnwUSRseMC+8iSfeWqRIO/hHD5QP8ayK/CPc
         oa+7Q4/RqdjoCUQidJRvfljEcwnc3B0+x8kZKkgWjUqxqNDoqZ5Je0a3+xoa9hMX2YCu
         Jsfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770138516; x=1770743316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X75L+uiZCaHBsd3xEjw6pILEYYmRHS59ChoDO8zTouY=;
        b=Bel+FnmK7EhuOLMIw71qmL19FPW500b1iJ5Gkj2Hkd6/1LDZw6zxKHXtdJETR22Q3L
         SbJ/nK6iNfhRBaOPmNvBC+y8axBqgywe4/4tkfFpwee8q6awivWY+DqxoD/Fjvv08tpv
         mG0DG/Ee3nqcHqag+9oScJ0AG6dSurMA0gMjZzlzZo5UklNlS5VAJtuWAQnYbL9q8nwH
         4leoACXKxa8uBQVXAw4t9AQawRRT0bxEpTPI5T+L2Y3cMdrTDUogRx3PwI+eJfU042t6
         gl+Mk2UAlBZPYap5v2bJ4QNIqOkTJZg56D/wuu7fnew9dX3tqzjT2RwFbqBRObGDEE4A
         LOMg==
X-Forwarded-Encrypted: i=1; AJvYcCWiUTnktu92LTpQj5fbISOQdTcMMKWG4m0tsE35019RytZwR48zL54b1+sOul95RBi/yzeL51AJIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxX63P4xxgGHXlcidjOhRF/XoAi+v1U/dcG3r2f3dBV7V88qZEH
	uJaT8v5E4unXw60DB2TePItdzyMDT47T4ZlT4j9wOmUtp1++kzGIYbyP
X-Gm-Gg: AZuq6aIK8nQe0wyyYWaFRHXR/OSE2X0HmcDigTraoJTiEVpHWhxfhtH8smTrmkG0ik7
	Fzpknny7AGDKle/Fz7aBbN4SniuPByF0LNvt0bLDPD1HALG7eIDaEMDnsFeoY+RCEpAYH9nwRdD
	FPArSl9yJ24X/e/a3L7luaN1TqotLPlaRXYTpy8RLsJOy+Gx6O2gPv+OpsX+QhKUbnS4ecurGXc
	iVRajWzCdPPs6zO+tHwfjP17kdKN/tAPI4oeQ3pFV2Tey8OnCxxkafR0vmo1BrnOW89gl4oTe0H
	5nNprphRMt+IsfBqY+R3WMev3xNFa8ylzNRIQj5yPaUb+DlG77z9KF8qJqvFZyC4jX4otgo9Nas
	zqlKaMjcGU0jCEeupupLR9LQ0atkgeSfogod7pubSx+HZkWXjHl5g8cqLEJHsaA10W+j3/4TW0S
	Z5GYSMXmqvtyvQvR6eMdc3YOIYDXZ/Wv3npQQeu5ghxeXYhaYbt3SH5ai86khYvlP20BfdV5kPB
	Nz/OcwZiqTbzqvlCjT33s9d2AI=
X-Received: by 2002:a17:90a:ec87:b0:34c:c866:81ec with SMTP id 98e67ed59e1d1-3543b3f1ccdmr13696817a91.36.1770138516527;
        Tue, 03 Feb 2026 09:08:36 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (118.239.201.35.bc.googleusercontent.com. [35.201.239.118])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3548633616csm177520a91.17.2026.02.03.09.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 09:08:36 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: geert@linux-m68k.org,
	sre@kernel.org
Cc: jserv@ccns.ncku.edu.tw,
	eleanor15x@gmail.com,
	daniel@0x0f.com,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-pm@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2 0/2] Add QEMU virt-ctrl driver and update m68k virt
Date: Tue,  3 Feb 2026 17:08:22 +0000
Message-ID: <20260203170824.2968045-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[ccns.ncku.edu.tw,gmail.com,0x0f.com,vger.kernel.org,lists.linux-m68k.org];
	TAGGED_FROM(0.00)[bounces-41991-lists,linux-pm=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[visitorckw@gmail.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-pm];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EE74BDC855
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
confirmed functional by invoking 'reboot(LINUX_REBOOT_CMD_RESTART)' and
'reboot(LINUX_REBOOT_CMD_POWER_OFF)' from userspace.

Link: https://gitlab.com/qemu-project/qemu/-/blob/v10.2.0/hw/misc/virt_ctrl.c [1]
---
Changes in v2:
- Use devm_register_sys_off_handler() instead of register_restart_handler()
  and global pm_power_off.
- Switch Kconfig to tristate to support modular build.
- Add .id_table to platform_driver and use MODULE_DEVICE_TABLE() to correct
  module auto-loading.

v1: https://lore.kernel.org/lkml/20260112182258.1851769-1-visitorckw@gmail.com/

Kuan-Wei Chiu (2):
  power: reset: Add QEMU virt-ctrl driver
  m68k: virt: Switch to qemu-virt-ctrl driver

 MAINTAINERS                          |  6 ++
 arch/m68k/virt/config.c              | 42 +------------
 arch/m68k/virt/platform.c            | 20 ++++++-
 drivers/power/reset/Kconfig          | 10 ++++
 drivers/power/reset/Makefile         |  1 +
 drivers/power/reset/qemu-virt-ctrl.c | 89 ++++++++++++++++++++++++++++
 6 files changed, 124 insertions(+), 44 deletions(-)
 create mode 100644 drivers/power/reset/qemu-virt-ctrl.c

-- 
2.53.0.rc1.225.gd81095ad13-goog


