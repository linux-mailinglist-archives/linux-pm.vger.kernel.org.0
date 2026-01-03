Return-Path: <linux-pm+bounces-40146-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9B3CEFD80
	for <lists+linux-pm@lfdr.de>; Sat, 03 Jan 2026 10:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5F143017872
	for <lists+linux-pm@lfdr.de>; Sat,  3 Jan 2026 09:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4944299AAA;
	Sat,  3 Jan 2026 09:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VWSRtXNC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D673C465
	for <linux-pm@vger.kernel.org>; Sat,  3 Jan 2026 09:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767433076; cv=none; b=SeMRREucmXqRQdH9wqRcMWsGps1tpXccnNWzl9963qbkZhkqUKlu0NoYQffoqMiC6+D1IP2R4nR40fseraldmAUX79qvs/f7yJAZo8JLbeb+8LjIqk07+VDBy4MUMuzkUtFMw71bytfP5TXMQF8jAAYKj6BOYFAK0Ml5LGSU5u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767433076; c=relaxed/simple;
	bh=TpVi9D0jzpT3ukHrer/AKAT/FwYh0F6irW4JiL0SZi8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jaXtkqpiljMceHmvK8JuZbdFql5qgNIHM0fzQBQHoNEt2fjEVSFPbuB/7gT8sohjUFeJwsifTGM7pRu4D2Fw43pmSrkbCax+EUF13GhvNyVfuWImdGhjJwa/z1z2naJ9aTIuKzfqLPyrwVLi/XNlYm6ccok4npZYihuHDqDJIrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VWSRtXNC; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5959187c5a9so10922730e87.1
        for <linux-pm@vger.kernel.org>; Sat, 03 Jan 2026 01:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767433073; x=1768037873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pWZkKPiFtnR/rs3kiMr68GAakSXnMiP1ZnZ9OMgWTpU=;
        b=VWSRtXNC0s7VVe4SwMdAebtZn8kv3P1JHRLQdk3WhQJyjAwt67ar8INucGBgOc8dNT
         1DxECcUhlcuIuIp3ik471/ZCp2RXkg1lVghtyj5BJ/yndorM7/XLDsNALtRZ3tPauI4W
         bgpJHnaceL9DFLXmAlkedWcOAE8Y1x3w5hjEMuJ1nxcHwngPqL3WQydHDEXMkL7YsP/h
         LZlA+xBiiYbPGkw/fTgHh6BvFyhGyUYHOwwqUJpyz9DZrXQFECf1pwvEf5+IFuOPi8+A
         cEXArkmbHS+Zm6jNVScHVL0EFW/Qiwyae4Wbx3okuWyidrtI/XiTE792WVfbCDCUwIT+
         CtHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767433073; x=1768037873;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWZkKPiFtnR/rs3kiMr68GAakSXnMiP1ZnZ9OMgWTpU=;
        b=SY2MSh1zBLCFzCMHgpge5XolrOMPkKJt1xQ8NYWrXrBoPpAR60gnjFdAuOkTWuwx94
         KWJzZ4fEKVBVwnu5cbpapoRkb2xITp4F5u+GE8AnucteqGilWwTIh47/5DPCwUyEUHb3
         Jwj5dqz+LaF3oIBd/OhP6MZlf49qu9stAgpK5reXytpP7uOUseZvJJCbGRqe6QNpLMAV
         N3qDCeDspB3F/u2rIPH32cOd5/NzJdOfUL1eLv3rl81G5LmtIv+Rk131gxO/w/FiXfYk
         /eCI/mt5yTwu+SgiRL6yAjouH1xf/v5vEA/SAeDTUBWZRfMZDcOZuGnDF+pBmkIwSP2h
         7Vgw==
X-Forwarded-Encrypted: i=1; AJvYcCUfwHb8GsNNuSpEraQUc/xrBT0lAx/2Ty7oiIM9DGR5fZU4FJ0ZLmoLQy12+T/Kwu2eV/pnGcOofQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe5OcZJW/AvCF4soLo3ZA8kXrzKyKwXLgPx/eDeQiw3EX58Yzc
	pOf1g0r81s1q/RsVFaY4aqj6HReW73MCDqQvIxF/WoogZIAbmE/gXC0ilWyZ45I+6xk=
X-Gm-Gg: AY/fxX7uORsXmz7LdxmcztXMcZ36QFjClsd0dcJKsqA5tFrfy92sLwkEGyHrkHq6NKl
	gVMoOypMyBIFl8CfBR2dVCE0eDUmnDwr6u/JC4rQ8+1v0BKJmD0+00lpfR/RhH+Kf0uqWA8kMik
	31Qap1nBTQpXQ6v/JE8TReH3J5VbC73g2iVNX7DIxLQBs81wMwgw47i5CGdyLW5RjOnU1Hx/wSZ
	tx9Wwn58CCujHb7I7AneQX9/eoSj1b4UbvYgjuqz2J1JMYqBdJw39vinh55ohKHhyyP7neuKvgQ
	KFtq5ilKhDuV1Etj4JjPCFffdLBk/LtdVLHkwQ34ZRymqMn1+B8m9u3Z25uEo77/6+TXu1e3+rg
	Wl1Bl61crvOJOL4QKYcFkfcgvs7HiANgStFDl/tZsmbNMPfIMGZME1oY+sfQGuVLryarn6vpP1F
	euz58416RRt9Hc1Ai6MLvLNvQ2C4A7NJYszr2Xkp2Pu+Ghtj38W60PS2mmtNmQ
X-Google-Smtp-Source: AGHT+IE+2jMoWfH0mG2kim3lvOWpG5hQP8AXw3e+htxPH4TjM8NTe2jcV7wlyub4Ua3gnsY82BxoQQ==
X-Received: by 2002:a05:6512:747:b0:59b:29b0:11e9 with SMTP id 2adb3069b0e04-59b29b01201mr7236169e87.53.1767433072874;
        Sat, 03 Jan 2026 01:37:52 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a185ddc12sm12970431e87.37.2026.01.03.01.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 01:37:52 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain fixes for v6.19-rc4
Date: Sat,  3 Jan 2026 10:37:51 +0100
Message-ID: <20260103093751.58526-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a pull-request with a couple of pmdomain fixes intended for v6.19-rc4.
Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit f8f9c1f4d0c7a64600e2ca312dec824a0bc2f1da:

  Linux 6.19-rc3 (2025-12-28 13:24:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.19-rc3

for you to fetch changes up to 73cb5f6eafb0ac7aea8cdeb8ff12981aa741d8fb:

  pmdomain: imx: Fix reference count leak in imx_gpc_probe() (2025-12-29 11:41:09 +0100)

----------------------------------------------------------------
pmdomain providers:
 - mediatek: Fix spinlock recursion fix during probe
 - imx: Fix reference count leak during probe

----------------------------------------------------------------
Macpaul Lin (1):
      pmdomain: mtk-pm-domains: Fix spinlock recursion fix in probe

Wentao Liang (1):
      pmdomain: imx: Fix reference count leak in imx_gpc_probe()

 drivers/pmdomain/imx/gpc.c                 |  5 ++---
 drivers/pmdomain/mediatek/mtk-pm-domains.c | 21 ++++++---------------
 2 files changed, 8 insertions(+), 18 deletions(-)

