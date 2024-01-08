Return-Path: <linux-pm+bounces-1926-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AD9826B1C
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jan 2024 10:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F45AB210FB
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jan 2024 09:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099E412B99;
	Mon,  8 Jan 2024 09:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RS0asCKf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82922134BF
	for <linux-pm@vger.kernel.org>; Mon,  8 Jan 2024 09:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d3eb299e2eso5918495ad.2
        for <linux-pm@vger.kernel.org>; Mon, 08 Jan 2024 01:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704707716; x=1705312516; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VqqrT91evNLSMIFeT1yu3y810EBdQOMoHVQ4zetICtE=;
        b=RS0asCKfWjnOKepwnvdlVYZWm9KUSudorHbTHhRPi5awiyOCtMfZrLwz5w2ftRHDM5
         PlZL0ufzLWSXGkRcp8Ujtr+t9U/eIa11lW3o1ez6TF/obVeqWRHol1vXtfDYNI8HEo1c
         O+6Pxdo1x+jdT28Un8rcjrW9BBafjqTjy0TIBPpvswkDznbp/EFausX3YuxOGTZQYKxb
         VKkoRG2SOta+7B5EcKv/Qd4XxP1ATOfQVbl4aHoT3+5i5dM6DzSP6cEkhE9aSs9EpBrM
         5hHYe1WcEBaM0Tau0UPgNN0oFIr8LuJYn/RIpTvpTebisecVHly2rrwN28JOB22wQ3TP
         1k2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704707716; x=1705312516;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VqqrT91evNLSMIFeT1yu3y810EBdQOMoHVQ4zetICtE=;
        b=UrCWVMYUtXyTzvEnNiwL4YJw+7FDDfmVzqo7CoJzmJyoWrbBoNJeV0gs8uhimGFANf
         /95N4g5JioUU7wIpeH78jTxM8nwirB4sSpU+6qpLKU46n0QBMocwwQ00VOSYjTHXrX8H
         ZfR17cT1cifvbDhMjGcwUehgsLHz59XdoKdXR6sol0f8GQPhZmAe8+1kGEj05Njs1Car
         VlZONOqZHOThAoIoSlydhERxKhMqO2Fe5qc4QJ/sHFWK6fYb+3PWGgbDtc492lyg3k/W
         mJBDWMDnOp9/ejEho/q0qVYaCMG7UlR7HpGkzDJeU0C6e37DNKRK04kPUPXxLEKL3kcv
         I92w==
X-Gm-Message-State: AOJu0YyFGtvXJJQfl0yVihFkaKyHfN1Tj6GDyQNJM0cbbbTxSyYHJQAa
	mzau+LamK+6fO3uh2QdyYHIIvtDgRFOV6Q==
X-Google-Smtp-Source: AGHT+IFClc4TNMDgfLta5/s5I9a6iuO+0aphjLjRUWI73hxii6YkBkY0ULQ+J3Rp4aTsu7GHznRFGQ==
X-Received: by 2002:a17:902:6bc6:b0:1d4:8fdf:6452 with SMTP id m6-20020a1709026bc600b001d48fdf6452mr927039plt.81.1704707715763;
        Mon, 08 Jan 2024 01:55:15 -0800 (PST)
Received: from localhost ([122.172.86.168])
        by smtp.gmail.com with ESMTPSA id ja10-20020a170902efca00b001d4910ff835sm5890624plb.3.2024.01.08.01.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 01:55:15 -0800 (PST)
Date: Mon, 8 Jan 2024 15:25:13 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] OPP updates for 6.8
Message-ID: <20240108095513.qlrwjon6qwhealvk@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Rafael,

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/opp-updates-6.8

for you to fetch changes up to dcfec12b67980cba139a6c3afba57ebd4936ebe8:

  OPP: Rename 'rate_clk_single' (2024-01-05 15:55:41 +0530)

----------------------------------------------------------------
OPP updates for 6.8

- Fix _set_required_opps when opp is NULL (Bryan O'Donoghue).
- ti: Use device_get_match_data() (Rob Herring).
- Minor cleanups around OPP level and other parts and call
  dev_pm_opp_set_opp() recursively for required OPPs (Viresh Kumar).

----------------------------------------------------------------
Bryan O'Donoghue (1):
      OPP: Fix _set_required_opps when opp is NULL

Rob Herring (1):
      opp: ti: Use device_get_match_data()

Viresh Kumar (10):
      OPP: Level zero is valid
      OPP: Use _set_opp_level() for single genpd case
      OPP: Call dev_pm_opp_set_opp() for required OPPs
      OPP: Don't set OPP recursively for a parent genpd
      OPP: Check for invalid OPP in dev_pm_opp_find_level_ceil()
      OPP: The level field is always of unsigned int type
      OPP: Move dev_pm_opp_icc_bw to internal opp.h
      OPP: Relocate dev_pm_opp_sync_regulators()
      OPP: Pass rounded rate to _set_opp()
      OPP: Rename 'rate_clk_single'

 drivers/opp/core.c          | 294 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------------------------------------------------------
 drivers/opp/of.c            |  57 ++++++++++++++++++++++++++++------
 drivers/opp/opp.h           |  24 ++++++++++-----
 drivers/opp/ti-opp-supply.c |  13 ++------
 include/linux/pm_opp.h      |  28 +++++++----------
 5 files changed, 244 insertions(+), 172 deletions(-)

-- 
viresh

