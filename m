Return-Path: <linux-pm+bounces-17720-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C7F9D11C3
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 14:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C94A4B29AB2
	for <lists+linux-pm@lfdr.de>; Mon, 18 Nov 2024 13:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488B21A9B55;
	Mon, 18 Nov 2024 13:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Ll1+Vnak"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7169319DF99
	for <linux-pm@vger.kernel.org>; Mon, 18 Nov 2024 13:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731936090; cv=none; b=B79uU83RNP2lrQuLBiaRxYeXMRPKjecQwG8bYJ2ftkNBBjX1JkR/d6EcTrVzVKCN7K5VCZIyBkKUSDxdYkFYu/qy0YIwb+yoouezpojEYjr4b4f61qgxd2RW+kUNhjgXkeeZVftQMhZvIFvG6lbWhobHGBmVVKUHeIZ/GibjCP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731936090; c=relaxed/simple;
	bh=5e15/+bHPlyPUeinr5GLfnM3H2bpq8GIdCJQ2iHU5h8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=haT4btYwuJfDt8ppiNVIVs3bNk/CeSM1wjcl7pYJenGvFcMB2tMH/fdbIeopLszbN2hj5EVPs1dVKvkSuN8nAUxW7QsaJ3Ci1acHq4fEO+/mbanE1WAFCZG03WpOsYudkBz+8x5G4avQtyJPcv0sd0v0J+qS8PpLZ4tSx0zbqno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Ll1+Vnak; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4319399a411so38390235e9.2
        for <linux-pm@vger.kernel.org>; Mon, 18 Nov 2024 05:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1731936087; x=1732540887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kHZQr/QOHCs06FPGnYcNQfB4AHp0CkVK9KIY8uA9p5I=;
        b=Ll1+VnakkL1HGSlkMjZVI6sYSnv/Ypv5lBONs5atoVQD7ekdRqgZqIB5C0DU4cz8d8
         56D8VooZBu029wbU3S2UbTotg/rt2aD+HgbcUmfLPQ/j6ELZkW4OyJoJ3x3TKYxycvSU
         nwLuvGRzg0NkHutfapNuBXz4hFkYt6dAFlod1jegJ70yt9LVAKnv34J9ZlBishvbqXnf
         FK6FW9HkR7Jjao75K7npS84yqAC+GH2ATATx5H4M6v4f+A/w146BFB2ClKe5LKr5CYMo
         LOJ8+YKoWBFreztyVEt+8xrXqxF2KmOCLQ811+tcenJxbcz3OFt837Vc595wO4hqBzQC
         rDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731936087; x=1732540887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kHZQr/QOHCs06FPGnYcNQfB4AHp0CkVK9KIY8uA9p5I=;
        b=q/rqPm3Kl5mLQ3lTfQKV3SVl9qc5LCS3bd5rD8qjRbD6Pv6gd9vXURTKyhIoTS0B31
         7UAXIjychRXklmG9lcnUh3kWivIagh6N5mRNx81sQugRT/Gkfy85ZlKeFqvcE2eRlg0I
         LjYJmgM9GmakwdkttP1u0B0lyHsykxwXeUncuH/LJmoevpI0zOFSL752lzc2/KCCJ0a+
         WwVMBO/CROh8cI6Yxj1fLm3SaSzlNCZxYRJ8Q401mueYGTjZdO8SPJ/X5X1OD+/ZNrbV
         7E1kFN76c1THzI3IEp/92nP9XUTR9a0k+XiDrjmOMpPRvJzBP2ADuz5HiUFVe4El43mk
         +mCQ==
X-Gm-Message-State: AOJu0YyQLeDk6nQHsd5QKYE5LBBJ4BX6JC2aQKqSWWC19SJ7b54VPXby
	e7XV8Cif7+Ahlm9PLySQ92ZDmb/bDhBx1k27VtICHloA7TaBfbiJC75asv53JdJZ7Y8IR2ky0id
	9
X-Google-Smtp-Source: AGHT+IG2zZfDbQrxSxOWZff0rETvvGdmbIYPw/wDj5Ye1fnJVEkTNpt4hoDbiiA6KVcR61t5FpDM5Q==
X-Received: by 2002:a05:6000:1fac:b0:382:d7a:315b with SMTP id ffacd0b85a97d-382258f0d9emr10409306f8f.11.1731936086575;
        Mon, 18 Nov 2024 05:21:26 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b8ce:8ea9:933b:1ec6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3824a00d8f1sm1829847f8f.107.2024.11.18.05.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 05:21:26 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] power sequencing updates for v6.13-rc1
Date: Mon, 18 Nov 2024 14:21:24 +0100
Message-ID: <20241118132124.52994-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Linus,

Please pull the following set of changes for the power sequencing subsystem.
The first commit makes the QCom WCN pwrseq driver depend on CONFIG_OF and
the second extends its support for the wcn6855 BT/WLAN chip.

Best Regards,
Bartosz Golaszewski

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-updates-for-v6.13-rc1

for you to fetch changes up to bd4c8bafcf50b6bd415c8bf04e98ebfba78071f9:

  power: sequencing: qcom-wcn: improve support for wcn6855 (2024-10-25 09:59:30 +0200)

----------------------------------------------------------------
power sequencing updates for v6.13-rc1

- extend support for the wcn6855 model in the pwrseq-qcom-wcn driver
- make this driver depend on CONFIG_OF=y as it uses some very
  OF-specific interfaces and depends on phandle parsing

----------------------------------------------------------------
Bartosz Golaszewski (2):
      power: sequencing: make the QCom PMU pwrseq driver depend on CONFIG_OF
      power: sequencing: qcom-wcn: improve support for wcn6855

 drivers/power/sequencing/Kconfig           |   1 +
 drivers/power/sequencing/pwrseq-qcom-wcn.c | 101 ++++++++++++++++++++++++++++-
 2 files changed, 99 insertions(+), 3 deletions(-)

