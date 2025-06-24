Return-Path: <linux-pm+bounces-29432-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C116BAE67EC
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 16:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 874D6189962E
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 14:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F522D130A;
	Tue, 24 Jun 2025 14:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="rr915wTN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F812C325C
	for <linux-pm@vger.kernel.org>; Tue, 24 Jun 2025 14:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774224; cv=none; b=dzc6wjME3NHxV9Zg4Gqe9f26eETd4dVQD3uuo9g9iW2dsuQ6F1ebZ4uMRuY7+wTx7c5Dgcvc00Ehk+kcVMEKGqkCeRghE8pz2E1wa2zIojA/vbWRI3jfcKdMTdpOidq5GjdyzykxpT6DJ9g1WbsSIRGeBpPBBk8wg0q0Qfu/d0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774224; c=relaxed/simple;
	bh=NuJWCvNMDvp7A01JcwhLK1F4wGD5m4AribrwpLbZ6eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EMxNdMbi7ZgH8MxqN037M0CL8h0xrAjSwE7TJC2hImFiPV6VQ1buoBNa/A28W9kHZH/yLjNlUdC7bqcq9v8a/AFYhxYIV6Km2qYE0USsJTvqQibbrpdpBHPIc1S8SPdWrrtmpSoIZir6/3QG/cPZDvC5LpfFw/AigCNMCeCziuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=rr915wTN; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-451d54214adso3830605e9.3
        for <linux-pm@vger.kernel.org>; Tue, 24 Jun 2025 07:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1750774221; x=1751379021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gSOei/bzMdbbI2Pm7lA3f9YENYRJXjnioWA5X0R4sEo=;
        b=rr915wTNTiK3831GdkgGT6zufwkctsTFkJ8xVX+c9kXqwqTZbKVKD+btPgOHdRXhoS
         kfwBQDFhWQoV8Tn5lBtJVQ0wNTy1+c9orNMPsANQC9tpILxhQB038HUEqOy9mO2YS2HT
         0O12hNNDoYM+WljEd9CS1mOkcgxXsaXnUqP6AZsUpVOnJfY8q2YCkOX+PdE/7nxABAd1
         GYeLip4LWQTJp7FSgSZ1Ujp/IQt9SCctn4zsUuVv43RgoqoZ+5BQVENhFUDgsc1LAh5B
         iWBPB0494QHUZpQowBdI/z2n6uzBOgYGmqKEJKkF7jF5mjLTO/IrJtEPIQdkMz6CbSjy
         yKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750774221; x=1751379021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gSOei/bzMdbbI2Pm7lA3f9YENYRJXjnioWA5X0R4sEo=;
        b=hopeoQoUOFnZT0gmuf0Q0FZH6FP1pNh6CpsuFbthIDZeZkIv86VcF+3kJN7aQENy4n
         SB05Woy8IXNflHzhq6fE6jNbm+He5YHV3VqDQs45S0hk8GVIM/WIlLIq5TmdyEJvatuo
         YWwZtSylJQR5T1RQ7skTdnvn5d5pCNUx84T9gS+bxXfVfw39bPiU3DsozMavBDpwaR5k
         N/QFf6oU4rlNNzWSdlxinEJ4o8gRpoLV+YaDg6zc4tm4xxhWuQ8yDFifnODRiCAQ5fWy
         t6AS28+BGKbQtI4iAGFePXuoxlZ6mauoWQDCDJxPmg53DEAHwYN+xkJtsjoHcvWhv0a4
         6BFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVajzI5Yn687Rc+1EN5Lf4RVEJRbQyQwd6d7CXCqLdM9SHx0b4OwKGvwrzTXYSxlpFPL4EPJ6okyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAWWeXit2dPtlvuZbiSbl6HlkJb9eawm55dASMy6EgEjeEyD6J
	mmAoZwWktsrbyASa/kQjagfL47LaGUWt3WqV2iwxibynxRV6ivjFhzVvp9GywmZUDBA=
X-Gm-Gg: ASbGncs08/65uUMNj0S3HJ5C118MuvHRMWb71aqL5bKaErUcxnUXIQcJBd6AO9r0cOx
	Z+7+4uLWbD6UJfr1+4FzskzM62oYR3OElmi9JWK18zYuI5GORdbB4F7cXlSQq/2Tcgo65rAWrj8
	IufXHz8uuehviZMTWUnD7VsTbEX4diX+SWAf812Puf0jJcMl2n50kcWQP4NnZ/CGoH2KPfp72Ck
	jtUlYx6xgcs0AmHXpP/+vhuFgwUGIxCa7770AfYx6SIxbl1AqiW5iIFdTeHwBkQpFcOT5+mNBAK
	EN6izc9ltGCtEtABUc5PpXAZQi/aZswOuVjlBgcthVdOpPs/V8sHy/JLJ5kKS2U=
X-Google-Smtp-Source: AGHT+IHAFIyNFoPHfcJpS9uG7ODV4IPOWAcQwwmdmU2AsHKw3IL8dxcp/xxloNOH3Z3z2+I3czNdHw==
X-Received: by 2002:a05:600c:4452:b0:43c:f0ae:da7 with SMTP id 5b1f17b1804b1-453716b567bmr78480325e9.7.1750774221073;
        Tue, 24 Jun 2025 07:10:21 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:34d2:109c:3293:19e9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e805175asm2004223f8f.20.2025.06.24.07.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 07:10:20 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Michal Wilczynski <m.wilczynski@samsung.com>,
	Drew Fustini <drew@pdp7.com>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] Immutable tag between the pwrseq, drm and pmdomain trees for v6.17-rc1
Date: Tue, 24 Jun 2025 16:10:13 +0200
Message-ID: <20250624141013.81358-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Here's an immutable tag containing the thead 1520 power sequencing driver
for the drm and pmdomain trees to pull from.

Best Regards,
Bartosz Golaszewski

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-th1520-driver-for-v6.17

for you to fetch changes up to d4c2d9b5b7ceed14a3a835fd969bb0699b9608d3:

  power: sequencing: Add T-HEAD TH1520 GPU power sequencer driver (2025-06-24 15:55:05 +0200)

----------------------------------------------------------------
Immutable tag between the pwrseq, drm and pmdomain trees

Add the T-HEAD TH1520 GPU power sequencer driver

----------------------------------------------------------------
Michal Wilczynski (1):
      power: sequencing: Add T-HEAD TH1520 GPU power sequencer driver

 MAINTAINERS                                 |   1 +
 drivers/power/sequencing/Kconfig            |   8 +
 drivers/power/sequencing/Makefile           |   1 +
 drivers/power/sequencing/pwrseq-thead-gpu.c | 247 ++++++++++++++++++++++++++++
 4 files changed, 257 insertions(+)
 create mode 100644 drivers/power/sequencing/pwrseq-thead-gpu.c

