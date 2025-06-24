Return-Path: <linux-pm+bounces-29437-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8E3AE68F7
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 16:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC14C16A72E
	for <lists+linux-pm@lfdr.de>; Tue, 24 Jun 2025 14:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D662D3229;
	Tue, 24 Jun 2025 14:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="0EAFe1RT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EEC291C2D
	for <linux-pm@vger.kernel.org>; Tue, 24 Jun 2025 14:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750775551; cv=none; b=T2gSUQgzJMvc8Aq3s6w4tOQROYtHgN3p+Z5jarIi13bbRZz2r+2XK5HRES0ymHsHBKJnyXpevMMax3+xVi3jfBRKiD065nIGGYAB/k69BKNZSWi2tvKScG2LqhQ9K/pguHVQxfPBtxIYhMEoSRkHNi/E17Q9Y1fX3OFSu6DGwB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750775551; c=relaxed/simple;
	bh=qL9XmUvWaq5tHfaWx1V5LuweXRKdi1ZrjKkrO+YSNmw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DWTapWdY8dt8Usy6bY8VOIB2s+CTl21tPopUiEjllp3a1nIi+5R88EzeOeyxU7BTzqk3THwLst1j2tBBfQtEr2OKvUskLJf/1V+6XBSN+kU9Hnxd5AqCLBr/k29/IGM6XEbM8yjnQ28unai4FOGunaQ+aS3tuRv3EnfICc5Hj/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=0EAFe1RT; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a582e09144so3336641f8f.1
        for <linux-pm@vger.kernel.org>; Tue, 24 Jun 2025 07:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1750775548; x=1751380348; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B/7dQju2CZeLI5d0OlTARaTle2Uj51q+BbaBg8wUzJM=;
        b=0EAFe1RTEz0BLt/FrR23WBsQ/aUei6oBJohWZ+bO4PLFJXfoMu2YkIyT0GoKf5mpBb
         OKR0+SqBdouRt/0Js7jjhPgSfFQAPLvh9oKtyUTB3Z39/GVzx1NxbUpUpC0HCcnOgNgm
         XpfWt7irb0GvgP2LPROhDVCro9/ck0trsCEvA9sRxGPMVk6WB2UvCpfC5Tsl1im87oB9
         6xvi/JojQKo4jGeP43M9Ygt4ul2NvHpFuf8rBQgWFxoBeudBjnvK5VwslbjFcn+AxMOB
         Cwja1Gm6Uz/wVIklFt+PjpbjnE91l8bRZRb1trimK/dyRDs41T+hizkO9GpcUP4qrqg/
         yU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750775548; x=1751380348;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B/7dQju2CZeLI5d0OlTARaTle2Uj51q+BbaBg8wUzJM=;
        b=MwI+Bf7oe7gNhMzwQZ5wxIx++47vlpHXwLtkz8bdV7tGBLd6tgczFMwxF/12jChRzh
         4f+0RPGs3TKYmRfVl1fTaktCLpiEFAHbwUvBmsW3YOuJxwS0mqY5nyVYK2zMFsM0lFF1
         tYo91Ew3QAy1K5IoxGk/J0KzeSU/d+75VSgkNnQlu1ntq6HkslaTikPxzrFQg9NGTFiy
         3i5UGDiodWLSvbTMET9pU5SkWCb8TDRTQV61NU29SAkq02drT7d0NxyVOdwQFnadgj3V
         RJM7mIz0TghvSbyg9osM4aP9vCtjkCtvR7nFqUVNN/Au5EPQpQhjESkwKVgIBAjwIj01
         PiSg==
X-Forwarded-Encrypted: i=1; AJvYcCWGnNjzUHx+1B20xkvsOsS/JocyMnQGJZweHDyVSP5X4HBAQp/cM184ljatG/O7Y1gVG2y6amtrBw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2PT09CS9CQkPker2mxok3UNh3DFcz8Gg6GYqXYVdxu1ll4Xut
	HYlcS5kU2RomAdFu06WaDY19yTBXrMFRVgq2vMn7vZpZ9qjCv5RxDb2ECUKruYA56LQ2YELVvEv
	wNmPdJPg=
X-Gm-Gg: ASbGncvjjN5P9JcJmo9VXXT8XFvh1Yvp7ittkI6D7MmzEE8XkDD3kvJ+fLep42m8d9g
	H2WkJPRFf+xOdC3J1GL9xV47OrnYRMv8Hsb72muytN6nem+C9Lkq2sVQh/qhD8njMKTn8VSnHQe
	xk+4EV6PqPzY7qJFYDWHByrEyPHJ3G/9tX2RGwuuSZv0O9bmcKW40BJmFjfhYN4knfWuUt8EOCk
	KH4b6d4vNPLrpvmt79p298IWiSeVu77q1UVJLL3W8UwMFpzmpTJojWWDH034XoVyDiqNqYJryaA
	VmavhHdrQeCR0J4kBra9X4x8M7mfibYTNhtxZ6nTAHvaXMWHgpKaWQB0b94hCEcCGJQ=
X-Google-Smtp-Source: AGHT+IHImXCD0PRHI4M7v4iVLzEcYBW7djJvPwpqCRg7wUTNPed+BG1KF5ix/KPWpzBJJQPBFgd2ag==
X-Received: by 2002:a05:6000:4b0b:b0:3a4:f66a:9d31 with SMTP id ffacd0b85a97d-3a6d12dbda2mr14879216f8f.16.1750775547583;
        Tue, 24 Jun 2025 07:32:27 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:34d2:109c:3293:19e9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535ead2a84sm178512935e9.32.2025.06.24.07.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 07:32:27 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 0/5] pwrseq: replace magic numbers with defines for match()
 return values
Date: Tue, 24 Jun 2025 16:32:17 +0200
Message-Id: <20250624-pwrseq-match-defines-v1-0-a59d90a951f1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPG2WmgC/x2MQQqEMBAEvyJz3gENGl2/sngIsdU5mNWMqCD+3
 eCxKKouUkSBUptdFLGLyj8kKD4Z+cmFESx9YjK5qXJrSl6OqFh5dpufuMcgAcoOvrRNUcN+QSl
 dYhLnu/119/0AI6qNWWYAAAA=
X-Change-ID: 20250624-pwrseq-match-defines-aec46817e69e
To: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Michal Wilczynski <m.wilczynski@samsung.com>
Cc: linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1246;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=qL9XmUvWaq5tHfaWx1V5LuweXRKdi1ZrjKkrO+YSNmw=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBoWrb56VtEbN8jrXfh++pA9Tt/a91zSI2thLGP6
 Zb3X5N2VSWJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaFq2+QAKCRARpy6gFHHX
 cs66D/9nnDqDh8+Uk6m4QTPNKsT8dOx6VegPWlRe/pW2j2o1y4gS8tZrc+2iV21gq7fF4mxnmiN
 SZJ+VE3IBUWkbI469tBUamwvJmopwlvIWXBbpvLmns5TuVfg2ziCF6b9f53xUGr0ptLAxC7xt2+
 6ofUKyshmn4ReWIk/gfyRUG6F20k9fUbxcm0IL0CKHADAcWOhEGdAYBu33Hna7oJTzahusPUZvg
 zGR91MBSHbd4Xxp77OJZRhjuYDIm8kYhYaN16zs08H6GX/OxlJrm2bXf6+qRb10/mu9xZlACjZf
 mVW3bszsPHgUBF8/RPQ/SEO8frUA59kInVGDYJ1J8XgmcLqE8sqfui5C0rREjVHO/Qgr8/CCgi1
 c0sIkUxzX4PjQB8EGSGkks0qHUt0+bwvKoh7mwO20lRlgxCBGSPhybLH5uJ2mHANOBJNHDpzZJI
 wcJ5JG9eCbuNApPD8E22Lr03o/197nRm6I5uGOBXWW5Tt6QgI/kOr04mMYtVR4RZYThbaA3b72S
 pS4feJHuF7MukcvxVQmLyKCrFVbn99hheJXgJsGlzyGDMUiwbS0CrQoJ+YzV/o9I+pFub/k3naU
 XBQK0UV1GCUgIHc9UNYX4IpDnXhF5652trnNl9Iva/DbXSbEUbGAdR+MPdzj27BUa2+W+Lp7aEA
 opBD6qhhZj6HaKw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

We currently use 0 or 1 as magic numbers returned from the match()
callback. It's more readable to replace them with proper defines whose
names indicate the meaning. While at it: fix a build issue with the
thead-gpu driver I noticed and extend build coverage for the drivers.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Bartosz Golaszewski (5):
      pwrseq: thead-gpu: add missing header
      pwrseq: extend build coverage for pwrseq drivers with COMPILE_TEST=y
      pwrseq: add defines for return values of the match() callback
      pwrseq: qcom-wcn: use new defines for match() return values
      pwrseq: thead-gpu: use new defines for match() return values

 drivers/power/sequencing/Kconfig            |  4 ++--
 drivers/power/sequencing/core.c             |  6 +++---
 drivers/power/sequencing/pwrseq-qcom-wcn.c  |  8 ++++----
 drivers/power/sequencing/pwrseq-thead-gpu.c | 12 +++++++-----
 include/linux/pwrseq/provider.h             |  3 +++
 5 files changed, 19 insertions(+), 14 deletions(-)
---
base-commit: d4c2d9b5b7ceed14a3a835fd969bb0699b9608d3
change-id: 20250624-pwrseq-match-defines-aec46817e69e

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


