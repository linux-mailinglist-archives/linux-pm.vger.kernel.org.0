Return-Path: <linux-pm+bounces-20693-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23880A16E61
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 15:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 329BF163702
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 14:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221881DEFD4;
	Mon, 20 Jan 2025 14:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="xmGoqtlD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A2213D531
	for <linux-pm@vger.kernel.org>; Mon, 20 Jan 2025 14:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737382978; cv=none; b=gGbjyFXCbUaymEixACYTJ4mglR659E93AIEgKjm5JEQ95jHUdmGOdPG7jwXOH2OFqvnHtL7TgLl3nTWy7chnaNF0pNQeEDtWLNAeGR0I81ce+PgkXXe6q4r/MerbGC4jh/xwYzZ8PqQLcsX/i/XUrBw4pZg4GGbcfIdb3J6M0+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737382978; c=relaxed/simple;
	bh=0zxAHiO8jy3sLY81tVYjQ19iaaZrsPlckIo1I4N2wTc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HlFXHHXprCgmtJFrLJ5cRCYrK8LCS4PrYAd8vmhgsbOV+ZBfXFYikXdI14Fxk5gmMCzSrIt3AZUSTYGuIkM4GD8Mww68wPrslF1x0eZ440yyohQ0GYYDiKTRYwRaiJ9TZzGANr1lHu6zUIlP6+nrmeBKMqlIVS4Y4ce2TCXcgrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=xmGoqtlD; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43635796b48so28935235e9.0
        for <linux-pm@vger.kernel.org>; Mon, 20 Jan 2025 06:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1737382975; x=1737987775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OgaYrQ5Jc68X26MGso1qnr32BkbRj0NV0A3CpvOUERM=;
        b=xmGoqtlDCpRKugG+PiS2+TrgvAZkfF7XRn4p7kqWF7ERuufpohF9REx2ZlnuGI7xwU
         jsbcgc7i7jx/GlFIkMl703K/eyJT2AANVd/yWtkS0nTIq8XfkpVf3lIQuszAO/joxcvr
         82oQawPTIpyv8pBefpOuLoqwn2sz8gcYMm5nPaTtrYY9Zjh1Ttp6aRYymLX3iKwDgDgd
         34SOz4x/1fjH/YqJQrj3jU7puOWzX7/JAy6Xa9yQInhvlCEjB8WiA7dqTZ3EjmM1BgdX
         ymPafbZceKKBg+WSp81blSN+7UHhUPsuaKhuVDV4kHqz8sTS6Il6+dgyn9sEN7Vs2WHS
         l9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737382975; x=1737987775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OgaYrQ5Jc68X26MGso1qnr32BkbRj0NV0A3CpvOUERM=;
        b=EOa3pFrPjvcksq18UzgwcA9SJjQ3Bz6z0hE+V7fOcN+YcOM/yqKTA3glny1gfS+xhd
         hT0fJZuHcp/7T27yMHNomPYB5MRmjxpRUE/o3xMnj/3vDw8p4tYzNFSZoRgiGLd40+dL
         PH2Y0nwXTTg7G/KLvfJM3q121PjbrjkAmTNTx9QNnefQuwlThKsJOwKPlmPW4zFa5v9H
         uqfT/3gRL9nUsxU0UFW6UbvF3R+3vCrBHcM1cVaMgBZdrqTYMYUa6c7FoyBS0NDMG7jJ
         UD6/JSLVTWuNLpshCzIbt9RJYroxUzHBZu2sWBKCxB/qw8zVdp6YlSRNcTVXgLEjhsQJ
         Jr5w==
X-Gm-Message-State: AOJu0Yy8fqIZjN1x8hHOZgBIYfQjnX07wW0yMaIP8KJ9YAVh3bdTEIeJ
	JKwpXJwE8mRnLnbBK5QqeTBBd2VpCWVPhjdhip+scXz/1TUvGeDUsRmD/I2cbDDPOHSN9OitbDL
	p
X-Gm-Gg: ASbGnctvmuJP+vgKZ+lbIXS0jTMWt3H2AR4ignZNmFesL+F/vwdOP7w8bs9OTJxXqWT
	rPPgBEGwPoCnanNh3NhE4U4iJRHHPMWvhRilX4mEnzlzAtFr7r/xZe+KEytXf3YzQBVlMXGKdvk
	0Cwh1Ev3K8qfS1MiMQPB1viJniHooEnAX+gvrd/z0Gh4Q6MfsGGpmVTGU09SbP4EGvzHJrDspwD
	ORVFVCzc19vSZMlpB0b6U39f7V3iR1hKa2YyHOJ/+WMb+PDEGWj6IZ3iC9RkYQkGD1Uvg==
X-Google-Smtp-Source: AGHT+IENLZPpaKkzLvm/nzIzLTRK5MlqU6/eFeCsGq9M89SoCSLvjbAPZ1fyAjvWmL6dB0FuQNKI0Q==
X-Received: by 2002:a05:600c:35cf:b0:434:f1bd:1e40 with SMTP id 5b1f17b1804b1-438918c6162mr100691995e9.6.1737382974563;
        Mon, 20 Jan 2025 06:22:54 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:1e6f:aa81:b243:8253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43890409758sm144972755e9.2.2025.01.20.06.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 06:22:54 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] pwrseq updates for v6.14-rc1
Date: Mon, 20 Jan 2025 15:22:51 +0100
Message-ID: <20250120142251.330065-1-brgl@bgdev.pl>
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

Please pull the following set of changes for the power sequencing
subsystem. We added support for another Qualcomm WCN model and a FIXME
comment that explains why we still need to keep a GPIO workaround for now
despite having merged a set of changes to the PCI code that seemingly
fixed the underlying problem.

Details are in the signed tag.

Best Regards,
Bartosz Golaszewski

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-updates-for-v6.14-rc1

for you to fetch changes up to 29da3e8748f97dcf01498b00d42a3e7574ece80b:

  power: sequencing: qcom-wcn: explain why we need the WLAN_EN GPIO hack (2025-01-13 09:07:20 +0100)

----------------------------------------------------------------
pwrseq updates for v6.14-rc1

- support a new model in the qcom-wcn pwrseq driver
- explain the need to keep the WLAN_EN GPIO workaround for now with
  a FIXME comment

----------------------------------------------------------------
Bartosz Golaszewski (1):
      power: sequencing: qcom-wcn: explain why we need the WLAN_EN GPIO hack

Janaki Ramaiah Thota (1):
      power: sequencing: qcom-wcn: add support for the WCN6750 PMU

 drivers/power/sequencing/pwrseq-qcom-wcn.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

