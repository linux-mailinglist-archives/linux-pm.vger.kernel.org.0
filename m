Return-Path: <linux-pm+bounces-11341-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D253C93A31D
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 16:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51BF4B2192D
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 14:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5257015698B;
	Tue, 23 Jul 2024 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fegGfuYU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81381156962
	for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2024 14:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721745996; cv=none; b=b0krVALU724UE5z4VkbUPs5yDfqTgd4s28OMJTphV3hvU7csCPpoBpXlXjvJc2Pxg3lrFB9jUkS6KomJbOGflAxrvAEuqebhL1zNJxg9rka4THIFyMkhLkgOHq6S4Z3ipkMP8IY5bo3ZHbVN3wvhKLelSRVZldHUsFjOTFZQss8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721745996; c=relaxed/simple;
	bh=YGzAFLg7/sOgkHlwOecxVa8CoxT3Tbo9FXcwKrYUf0o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jzchyolkM1r8ZzFKv6u2TJWEt4IzRKWwP/WUXSfLX51O/1YDwjuCfgfbNMBzRuBwoNBxR+yUGRczRQOFn5Vi3tSFzvJ55QjAE4MLDFEPsD7JZDM2Doo+sX7Wwote4oeksErYKVXv+pw7qzKuKNsBzFRwUfgZ8Y8uuh1B3wFFLYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fegGfuYU; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52efd855adbso4138406e87.2
        for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2024 07:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721745993; x=1722350793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Blz5ww9zpbNRbNfg1Tx/Vs1xK3UddL3Pf8Da6X8Ufco=;
        b=fegGfuYUuV91lZgjzrbEiMpogkIqbldItbSRbEWGPrvqlmAA6ySvCT5zR+pa5NOW0s
         Guf9HBQzYQT4Tf6oXP+aDPmZXdqk56FTfBGDY5rAqsqtPylrVwz7d7pmTjUYEyJZ/A89
         e/mAEkS6u9rUSlJpwQPi1/Xc+EtS/eEaa1BBzq040PjzM96rht9Oj0/B1tX5zAtJVmB0
         46RlntDefwYjjR1xN4xOnCT9cqE5xvhFhFIoSXn8X7V8KhvAgunWfe0fHhnKBYG6SzdD
         w7KIL26f4WnfthfihmYCp9D9vLrFtJQfUoECFemHQFuB3/28vf9tP8U5idVXEYGhvgp3
         HCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721745993; x=1722350793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Blz5ww9zpbNRbNfg1Tx/Vs1xK3UddL3Pf8Da6X8Ufco=;
        b=vmj5huEeGNYZ4afmJ58388q1AivQbSyA3xeAYPsOOHtK/HbDLdtqNOx6pJUg9LXow6
         fq2W1Xy5b4smkGr0lA+8JKc9adsRssgFBKFdYPAYNs4yZPuomb34eIChVZDKIq3JH124
         WLP92cksi3ccv1Z6x+mqC39wgAQ8q72anXkKbXzE4daLbY7Y8PEtejjnaY0G3e268f8W
         kfVqRnvE5bKEECi1xyV5dedboe7ZI8lr4/eAD91z4C+m7c9FmtEfJ1/Qk35mH9kg6/gp
         z2CHYF6787hVo553EKucjkFQH2bIuAxxVQfcLKOJvVQZ8QzPVg+5h0bMQeuxKDWoYeHs
         ngYg==
X-Forwarded-Encrypted: i=1; AJvYcCWoYMuUbgXuWCfw+1HgauHzlh+Vqim/Ga+UaD+EsVyge6MfPB04NE2DeRGrvcyuQJPNjBZ+Up4I6QAgodUi5l7v5CDjTL4880A=
X-Gm-Message-State: AOJu0Yw9ttEimFIaiBaQ06Esf8+uJ5ksNRslN+3MKTumv9reaUHPGg1J
	g2RHGQPZgonjNxJwijgLA10jZCMCiT3b+wmoT2MWED63SPvNUqvZoUmLYgO01wQ=
X-Google-Smtp-Source: AGHT+IEo7RlT5yI398EffxymVutocpoXGeDirrJ9joGNhamx3zavj82B21E0+ZR1gZi6YcUF99SpMg==
X-Received: by 2002:ac2:4e07:0:b0:52e:eacd:bc05 with SMTP id 2adb3069b0e04-52fc40782efmr1972193e87.61.1721745992590;
        Tue, 23 Jul 2024 07:46:32 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52f0415eb08sm774540e87.9.2024.07.23.07.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 07:46:32 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] OPP: Re-work code to drop _opp_attach|detach_genpd()
Date: Tue, 23 Jul 2024 16:46:06 +0200
Message-Id: <20240723144610.564273-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Note, this series is the next step beyond another genpd/OPP series [1] that was
recently submitted (and still being discussed for merging). In other words to
test this, that other series needs to be applied as the first step.

This series converts the final users of _opp_attach|detach_genpd() to use
dev_pm_domain_attach|detach_list(). Then the final patch drops the redundant
code for _opp_attach|detach_genpd().

Please help to test and review!

Kind regards
Ulf Hansson

[1]
https://lore.kernel.org/all/20240718234319.356451-1-ulf.hansson@linaro.org/

Ulf Hansson (4):
  drm/tegra: gr3d: Convert into dev_pm_domain_attach|detach_list()
  media: venus: Use dev_pm_domain_attach|detach_list() for OPP PM domain
  cpufreq: qcom-nvmem: Convert to dev_pm_domain_attach|detach_list()
  OPP: Drop redundant _opp_attach|detach_genpd()

 drivers/cpufreq/qcom-cpufreq-nvmem.c          | 79 +++++----------
 drivers/gpu/drm/tegra/gr3d.c                  | 46 +++------
 drivers/media/platform/qcom/venus/core.c      |  8 +-
 drivers/media/platform/qcom/venus/core.h      |  6 +-
 .../media/platform/qcom/venus/pm_helpers.c    | 31 ++----
 drivers/opp/core.c                            | 96 +------------------
 drivers/opp/opp.h                             |  3 +-
 include/linux/pm_opp.h                        | 38 +-------
 8 files changed, 56 insertions(+), 251 deletions(-)

-- 
2.34.1


