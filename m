Return-Path: <linux-pm+bounces-40684-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D81D14BCC
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 19:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8263B3017224
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 18:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FB438759B;
	Mon, 12 Jan 2026 18:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRtYPJsW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4928338759E
	for <linux-pm@vger.kernel.org>; Mon, 12 Jan 2026 18:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768242195; cv=none; b=uOyX2iin9Lagu2EWBTw2L8pvoZ+wr0EOf2fGbGID93hAqpP1hjSnx+qtTLqJlcFw2yHR5zDjLaBb9LdWABwO2Ce0fIjYtdbz71wrBZry5hyzsa9eykj7muEG/MpZLu4mZgyi48QzyQ3PB0FIqtnQAYN+b8I2NCZxvIganZRckjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768242195; c=relaxed/simple;
	bh=2QtKLjJUQEoCJQaHKjpnH3IwdHEGqEsfUmEqicyo0ss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QMf+M9B12CzbuxO+i16IGJu2gpKR9YtdDQKm0RGKR59c8Q4ukOQH5YYURGvnb2uU7jEkrqZ8drZuNQOgatpKR96r7ng5Ie+o45ygUSay338MnS+XB3/Ur6xvc52/WJsH5tyU/Rjyqz/ZZwg162fMF+SpIpQk3sjudM31ToxHMyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRtYPJsW; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c03e8ac1da3so2708223a12.2
        for <linux-pm@vger.kernel.org>; Mon, 12 Jan 2026 10:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768242191; x=1768846991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YF3AVkxsTcjAysM3wvWeUS9ZoFA004AjKvMbKLzO3IY=;
        b=FRtYPJsWiEdaCEsdCc4pOD+HMxIeQzfKPzbWFKAAxlxsTFX4VoaZlRo0N3TLKUM0w+
         6Oq8cHkQaWhBd6dqqNIhVNXaJTz151RUn0GS9Xcv2a1p50OwXpaDeRegs7O1yBDaWBdR
         qs2n2kwlMX7WpB7oasyr3tfc+9Q5KPSA8Lca5rUeXFxN7R35YYuM6ijHo8Cw+LqOjpKg
         yMq5iSJDuXmUiG8sEwnPQN7gJwB6IFSJUdgTkq5ZxmNLXdZP+k4sDjhI7jyD25y2tWWb
         H/Jg9c/u3sUAfNYKaLE/XVWViUdLsOB/obCSsQyJSBKy7TXF/fshzC6YwdtxbC4eURl8
         vGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768242191; x=1768846991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YF3AVkxsTcjAysM3wvWeUS9ZoFA004AjKvMbKLzO3IY=;
        b=eXN0YviNOqlw2yq87+O4FHbHfKN5majMlRqhc0OOP7/TWYvMIXJsCgZYQ7scrYHIOe
         D1lojl/ZY5f3B1MK9yQjMiue4YKuttdfDuIBdkZ8ZYegPq7W3pwWNvToHXjlmFXlxhNd
         kMI90EF/wbR4K6hhGdiNmDBQCJgqVGYhxWHnoO6PamwELCDArhbta8++kipQVTzIP1hG
         b/vzkJyKY1MfepyjmTG55v6zagbychOpSRNSOokCr/H3wKkiwhGF2fkliSt1g7wEGCtm
         cuyxZrTk9Kucvm7Qsv/wfFMVLJVHk2M0MV4qlaxhoSbzHTNzNT71GJiEw/JKBHvMhTh4
         pRhg==
X-Forwarded-Encrypted: i=1; AJvYcCUteGrJ37WRzA+zYwCVM9tvTsxuZKVN7WRF9t2w6vLtFiTQJQwAlDkCvlAtx633MirDjSUEFPFmww==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7akiHR0GoQl5km1FVCuulaSlEd5myEQGgIXNgqZMvyE/YUiXp
	AgYaTp5VApfXdnS1hYgOJ6hPNTmvl9V+VXI+/YzAwvg2rrg6OF4u+iAbOuwIoQ==
X-Gm-Gg: AY/fxX7V6nnaYF7oQo39Jamq9jTwBXgwbyeUYBTKQYXLyempYyK66LOpOGeLi57BGFb
	ZoQfiCLZzPDHLjqx/Zu5BHUBoZ+M8k6YgLF2p6ZuKnHrtPYZUfy015xrIJp2m6i0K5e9YcJkr1s
	JCs2XrRmhQ9RkXyE1zZZoDY2ywIZMODS4KoLt1iyj5HtUKyCH47Rt0XjubAWwAuD6Y0IJvoiWXE
	IgUkdUbyZFBD8TvH9HMvc8qb0KpPVXl4IUkjNz1zk+0TkEe+77Vvj3v3ri0VvJEnEmCN3JqcpN8
	2GRxnVZWJaCdVeWKTALVTeBv3QCtNsv7X8OEmPYTUhpBSvp3MNSb1fV8pRh6vmcxFfD0EM/RFAO
	kr/GBn5pYVjSPkwjPbsLlqwviMW7oISeNi/F/OZsOvQthCmS7jSN4Wr8Ijgbxb6d9p37+6kjvuq
	ql6Efn7LbsTrL30a2TC1n0phejkYiFK5RlX4B5Pkddrj7PWfHH/O92h4iQO92s90mIFv/54D00k
	u9oe7rZcmo5xaiXm2prtQ==
X-Google-Smtp-Source: AGHT+IEmRo9q8nqLipvVwRTR8qCLNp9eYKwhxSb0S8NZW7a9hoCVY9lEmri2jzPiLwH8s8Uer0RLlw==
X-Received: by 2002:a17:903:3884:b0:295:290d:4afa with SMTP id d9443c01a7336-2a3ee46179fmr167389495ad.23.1768242190608;
        Mon, 12 Jan 2026 10:23:10 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com (25.118.81.34.bc.googleusercontent.com. [34.81.118.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc794asm180981205ad.70.2026.01.12.10.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 10:23:10 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: geert@linux-m68k.org,
	sre@kernel.org
Cc: jserv@ccns.ncku.edu.tw,
	eleanor15x@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-pm@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 0/2] Add QEMU virt-ctrl driver and update m68k virt
Date: Mon, 12 Jan 2026 18:22:55 +0000
Message-ID: <20260112182258.1851769-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Kuan-Wei Chiu (2):
  power: reset: Add QEMU virt-ctrl driver
  m68k: virt: Switch to qemu-virt-ctrl driver

 MAINTAINERS                          |  6 ++
 arch/m68k/virt/config.c              | 42 +-----------
 arch/m68k/virt/platform.c            | 20 +++++-
 drivers/power/reset/Kconfig          | 10 +++
 drivers/power/reset/Makefile         |  1 +
 drivers/power/reset/qemu-virt-ctrl.c | 98 ++++++++++++++++++++++++++++
 6 files changed, 133 insertions(+), 44 deletions(-)
 create mode 100644 drivers/power/reset/qemu-virt-ctrl.c

-- 
2.52.0.457.g6b5491de43-goog


