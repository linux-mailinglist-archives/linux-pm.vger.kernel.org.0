Return-Path: <linux-pm+bounces-14362-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F86D97AE2E
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 11:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3DB728354B
	for <lists+linux-pm@lfdr.de>; Tue, 17 Sep 2024 09:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD8A165F0C;
	Tue, 17 Sep 2024 09:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="x7adQPPx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB08C175D32
	for <linux-pm@vger.kernel.org>; Tue, 17 Sep 2024 09:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726566394; cv=none; b=Na26nzRnxLyps3P+ygGJAFwRqdL89tAwMSSrQGOyRfCD29JPxCnC71icmxqZVlZi75mSECXl5eDOPY5Je6u3dyz/+S7k+3kfMZ8wD65xhRdepsqDEbtMP1c2JS7exPq1vNaXIjnlH4Ig8RxcInS7vhqNEEggBI2E5FGDyBdVFtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726566394; c=relaxed/simple;
	bh=ZmYKhf4vmEW/E7NahV8giMLTGRkWMghWO0I0cUnqrVE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sUhXQEkxEga+lRZyWoKQ2yUbrZwxspIfbEZ3Ep8hL0o9PGeEsz+VPVUAv3fmZYYezZSXQGivvwyr25WigaHndppdollBekQCTO440IeSI59y0Cm677+ExeIyMV1QaIS4df+AUIdww0FwwEL9RB1NTfsw8qvyhJneD0+uaZ98rDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=x7adQPPx; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8a789c4fc5so1034633266b.0
        for <linux-pm@vger.kernel.org>; Tue, 17 Sep 2024 02:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1726566362; x=1727171162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yjricXX/Ap/NeTWKCWeNSw+7TkReM6+VHnzcmIqkLpc=;
        b=x7adQPPx3acW3H0qiDpTRX+qzWXKxOaT2VqnO913x5Erlhbwtk8VrzKGkSWT91TepY
         DgW4x0IziY7kA5Xuo3Hqxivs3zSeWk7hTB3WOHIdX8+sR0yZ7bUTsWA/hs3eaBEf+IWJ
         glILV+Ik3Loz0gx2hWDi0J3926STnoC/IMidndOy55nRCHN6euig6mIrGsS0dOPrr58r
         H6bOesfnsh3rNX8rdkmFm0WrX1lxjVMp3aiXq1UJtQM/lLpJB5PAYRDrR8SGiWcfQesp
         uVM0ygziePaqBo08bD8GYrH0sIQZgZa/13clW898m2CuB65CvAZ5pZwEKySPY7nZjkAG
         bVCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726566362; x=1727171162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yjricXX/Ap/NeTWKCWeNSw+7TkReM6+VHnzcmIqkLpc=;
        b=IXxWgH2hQu9Xh0IW4xGGqiQ4whF6LwoKlBJQfd/BW7HHVpzOZfXf7n6+Zx1eKyA9Wr
         SEv6kpskW/ghtzZFyVoX5epSFrvZ99lZnHrTA7ZD0AfDejAEOsNUKwN3G+iu7jMbAGwL
         8POBZmy4RZiOw9DqXaUEiZW2e8Kh/LXkRHsgDkEKjd7dKqUxjZBgK3F6gB1upUik0M+/
         cd2nzAFSkwBCKm1qtYJ1EQ/of9/GL37FpnZ747RZdyjAz1mgCkG80P5MKGOmW9KEqTUr
         /Xeqf7MNBQ5m7GSaiFg0OgAjJW3/9//SeU6IZBIjZdqxfD+B6sspXRSSepOkHkM2AhfH
         jmcw==
X-Gm-Message-State: AOJu0YxApXZAftxkqTVsNWS16wKj2w+/pZGiH3zapuDVlpRvqnPMnGE/
	fGEqXkFdz9QqvJ+zmSSeSYf6H9Gv6jOjhQ+3TDW8dlwOvYq66TQhd3HEJT4mDzLZSPrvQHMBrCw
	W62bG8g==
X-Google-Smtp-Source: AGHT+IHh9SUBmZvohUs6HhszQ8imfPwPKRUtgNljAyYRO9S0wlPZQqsGye124tPbyjnLe8/wYTS5jA==
X-Received: by 2002:a17:906:6a01:b0:a8d:43c5:9a16 with SMTP id a640c23a62f3a-a902a3d6986mr2055463666b.6.1726566362219;
        Tue, 17 Sep 2024 02:46:02 -0700 (PDT)
Received: from brgl-uxlite.pool3009.local ([83.68.141.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f42b1sm427516966b.46.2024.09.17.02.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 02:46:01 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] power sequencing updates for v6.12-rc1
Date: Tue, 17 Sep 2024 11:45:57 +0200
Message-ID: <20240917094557.6419-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Linus,

Please pull the following updates for the power sequencing subsystem.
There's one change adding support for a new PMU model and another adding
documentation for the subsystem which probably should have been part of
the initial commit but better late than never.

Details are in the signed tag.

Thanks,
Bartosz Golaszewski

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-updates-for-v6.12-rc1

for you to fetch changes up to 8b7e0a6c443e855374a426dcdfd0a19912d70df3:

  Documentation: add a driver API doc for the power sequencing subsystem (2024-08-22 15:29:29 +0200)

----------------------------------------------------------------
power sequencing updates for v6.12-rc1

- add support for the new PMU variant inside the WCN6855 chipset
- add documentation for the subsystem

----------------------------------------------------------------
Bartosz Golaszewski (1):
      Documentation: add a driver API doc for the power sequencing subsystem

Konrad Dybcio (1):
      power: sequencing: qcom-wcn: add support for the WCN6855 PMU

 Documentation/driver-api/index.rst         |  1 +
 Documentation/driver-api/pwrseq.rst        | 95 ++++++++++++++++++++++++++++++
 MAINTAINERS                                |  1 +
 drivers/power/sequencing/pwrseq-qcom-wcn.c | 11 ++++
 4 files changed, 108 insertions(+)
 create mode 100644 Documentation/driver-api/pwrseq.rst

