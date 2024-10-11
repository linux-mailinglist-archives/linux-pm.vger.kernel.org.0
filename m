Return-Path: <linux-pm+bounces-15536-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A35E199A164
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 12:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D37741C2145F
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 10:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB341E282B;
	Fri, 11 Oct 2024 10:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KkgYf50S"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7941991AF
	for <linux-pm@vger.kernel.org>; Fri, 11 Oct 2024 10:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728642634; cv=none; b=agAwLY/uRAicTxzvx0KXcCL88RCqaeMx2O3bPH3EjbS/CvGqobfvncjV51WomLVdH4jfmwQkUwUbJhTUvfLOeMi59BLPZXj50Xf9mh4oqsrweVcSCgbn7LXeOciUEzzPTeSsnC216n2/Ylq4bsPtkY83DmHo3a04TJfuUQTbkWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728642634; c=relaxed/simple;
	bh=TDop1lBkubXGjGGp93LzvDNHNnROonAD9qA/nZYGCf4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d0HzbwuRnByFbfVuNlWq+ZTGQci0p+6acQDx9waVzKmeVohuDRuapc4sMoTkbHCCUYZPkOKGjD/A1vPg4Bme9CQdwlZ8MjZX+dl+Hd8bLPmSKjPYqn8bUEdGYB+9e973W/IYtnL82OegVEdRM2TJ+e3IU+bdhCVHroN5KnoOUnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KkgYf50S; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53993564cb1so2322923e87.2
        for <linux-pm@vger.kernel.org>; Fri, 11 Oct 2024 03:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728642631; x=1729247431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KMNmAfxFNwJpRM+Dggtk4C70nF4xlRNZQPU+WokqmuQ=;
        b=KkgYf50S/OHAsxm2mF1WBXWy5ORkytmiGX33Gk+/Kb7rHQlGPZ8ex0ZjCNCZWtFtZk
         Lz/bzGVzQjVFbL4oRoKBrmvVAFDIZYXY6uN5owCWR7jlaKoKjSfYF2l2thzAykIwCgr8
         ivd6oBUr3tmqmtfq0l+ZrpJQ6s6HX6ASKAJ/yAcrl5jw+hanTfSqghQinlSAZArBe4Cb
         nQt1IjzMOIOuAZLIe5q8aVunVM4zjxD4UX2Pj7rZiP14LarxwvPNzgT/6elMNHYa4q0L
         lGKw3ko2T8M1Ch0lpju9/D7gL6ThEIvQF25S2cqsQS+Frc7Fjrjnge4Fn+wmlO2b3mV0
         CPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728642631; x=1729247431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KMNmAfxFNwJpRM+Dggtk4C70nF4xlRNZQPU+WokqmuQ=;
        b=du1NQ7D4AvJ+zY/N8StsGujXyG1eVVbHwF+lGUmu2Mo2uteiQzJEBDtNjTfqn2dcJn
         5GLi0szN4p63bCAZiMh3p2htn2yyMFr6WOq+Rb0zYXA3u5FM0VL/l8C/pjXqqsKCdyg8
         GSvV3chyhlkwBYF7iIVpjMagqOK0XxedrkSF1Fb5pBEflyw+Db9cXFEECEE26NpsGXCV
         ldZeMSfmaX5X1TPHJzAgcEq4c1cblr0sLTglM6rNPFeu7FdWKcQQMV2cp9uG8q1ofvYO
         OybjiBMpYOYKCpIhOvl5HJfJ171Y4ufHcQWjuYRYQrDE0/znHjcPoqUuH0DY7PPw2xNO
         z6sA==
X-Forwarded-Encrypted: i=1; AJvYcCVuULm1xAivTyu1gG0a+oDBwMerK1ja6nnS6E2jS9ZROEt6y3cgzDzEzHGOsZrU7dXCMnYtJj01wA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbdr+9dfoQtajZrgVQyb1TWC+FyPqQySEXG1Oubof+5bD+E9Md
	P0ijV3Xuq3Y/iYNmq0wUgvM2nMKDnQjr0eXOXsxpgE8PqWt1HHThMNPO4PASNOw=
X-Google-Smtp-Source: AGHT+IFuE220LffJQlPDCqzh1jZ8tOI3NY18uMcugtuXZf9Eo+ON5fcj4QS1rIcmSx1FSaISOuD0zg==
X-Received: by 2002:a05:6512:3b9c:b0:530:aa3f:7889 with SMTP id 2adb3069b0e04-539da57f62fmr1036047e87.56.1728642631290;
        Fri, 11 Oct 2024 03:30:31 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539cb8d8405sm557558e87.139.2024.10.11.03.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 03:30:30 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain/opp fixes for v6.12-rc3
Date: Fri, 11 Oct 2024 12:30:29 +0200
Message-Id: <20241011103029.477385-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a couple of pmdomain/opp fixes intended for v6.12-rc3.
Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.12-rc1

for you to fetch changes up to 7738568885f2eaecfc10a3f530a2693e5f0ae3d0:

  PM: domains: Fix alloc/free in dev_pm_domain_attach|detach_list() (2024-10-10 13:55:17 +0200)

----------------------------------------------------------------
pmdomain core:
 - Fix alloc/free in dev_pm_domain_attach|detach_list()

pmdomain providers:
 - qcom: Fix the return of uninitialized variable

pmdomain consumers:
 - drm/tegra/gr3d: Revert conversion to dev_pm_domain_attach|detach_list()

OPP core:
 - Fix error code in dev_pm_opp_set_config()

----------------------------------------------------------------
Dan Carpenter (1):
      OPP: fix error code in dev_pm_opp_set_config()

Ulf Hansson (2):
      Revert "drm/tegra: gr3d: Convert into dev_pm_domain_attach|detach_list()"
      PM: domains: Fix alloc/free in dev_pm_domain_attach|detach_list()

Zhang Zekun (1):
      pmdomain: qcom-cpr: Fix the return of uninitialized variable

 drivers/base/power/common.c  | 25 ++++++++++++++----------
 drivers/gpu/drm/tegra/gr3d.c | 46 +++++++++++++++++++++++++++++++-------------
 drivers/opp/core.c           |  4 +++-
 drivers/pmdomain/qcom/cpr.c  |  2 +-
 4 files changed, 52 insertions(+), 25 deletions(-)

