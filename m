Return-Path: <linux-pm+bounces-26110-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0627A9AAD4
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 12:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D84517B8F8E
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 10:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAD5227581;
	Thu, 24 Apr 2025 10:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LnBAyKc7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D44221D99
	for <linux-pm@vger.kernel.org>; Thu, 24 Apr 2025 10:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745491023; cv=none; b=NEKWJJFss7Awf7txvy9gWZiBZe3UahpnHZvGvzHQgp00Rq0wdPuGD7OoTgSZt3hjrKhIrE0wJlhWi0N3j22kiCcP1yCGrkECYpwmSm119sGmckGEkpvpxqLYQIXDHkG4WE1IHTU2LFmgoBlheBhFqgmglXfSzaYkPrnK9Dh2SiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745491023; c=relaxed/simple;
	bh=UechCo47qLLRuMf6wbn4WAas377Itb+KTz2qvfZpdFA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FZp2OH+Rr+8dH6PDw0PvrlVRRpz8nQ51ecUnwU4ZgRbsastxT4NMw4LrLPC0QqlJ1cOsjmQTA9CGUfhXoWWidFOwfgvWoPdcCwEbHhugaQEo3B1v5U2BD7m8/LdT7DfNt8XoN/oHIQE35+UmaAG6+xC6VszCZtfZqG95U+Xn5B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LnBAyKc7; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b074d908e56so529870a12.2
        for <linux-pm@vger.kernel.org>; Thu, 24 Apr 2025 03:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745491021; x=1746095821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q7dk2/C/FgTZtugG3sjnuQxIgyT1iGedayX4ysvVif0=;
        b=LnBAyKc7VIGaHQQm/xC1DVxAaEyheEzBHzq+2fB2q9InIrc8EKYh3S+Dci73JL4Pfb
         gLWy1txiKxDszOJYeDB+5xCmGwk/KpeJJRxqQ7/YAqnz8g1ey2wpilh4WaunnvIjy2Xy
         IelT80hYlluljFoNauv2aJZQ87/AKSiNOYj6DNljkkmLnNjun7n1wWijTzhdgGyn8GjF
         3hqWzXZNKYLwTMNY734oH06/bsLIgPLdt9lEQTrP5de7305g95lhXW/gw+oCELC2lvqp
         QZb6nS19uuc8hH5xj5xLkDgBtlKlJAE9b46hf9ymVaah8HaHVo8xbpPtSnllZclBJfXm
         hU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745491021; x=1746095821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q7dk2/C/FgTZtugG3sjnuQxIgyT1iGedayX4ysvVif0=;
        b=vZEoCcyvXAvNncmWY3BJdlodNyFReX6B1Qrk/hQ07eCpCRtYTNBCczcyifYI5I4huR
         fIm6l6kraOLEdYexr5juprg7hyix2/1HysqoKSUb24trQ2gJBITlPy046zyJnhsjohhB
         Fzde1NoU9jWdOpdQ7b6pn6QKZdmcNW47FATJ5IzcO6SESAh2lZM2trsnTGNgjsphUb1f
         BTgjCufIksKhn4+fcw8ph4Q3M3LNitf2Dg7++4u9iwj3ctcdX+Zz+VveGEDz+1PbU+6v
         MY4ra14vmSqxFmQm06Gdf/pufcJCcTcIbCnzxlp+B3lEKpkFpwiycBh1U1TZs4JoY5UL
         fFOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEjwgs+IyBKwwwkPJW5u4+FoVvLcATIpzWr5phPJ3Yc26l2foMTyfom3Hic/STZ2H/AYzr3QlZWA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Ca8usQmX8DwWFRBBUDIoe6YKXFMBb9Vf3ylW6V24rUrFPqda
	ek1F6N73olaYVjL4L7uddPTvDuVr8HmWtEbiNAEs9A6y2ACEfXphHwyjWaa/n+8=
X-Gm-Gg: ASbGncsDYxEkAFswkrGX4fFSWKraCCyajk9zyi1/Ud70q96dxHpT0GAZ+AkAf80Bz8z
	DhmIRUIXpE5UX5/P3JJTRESqhe/bzrQLvz/a0mJ9bkUca6ZNlZHr/7Y7TJKlne5bbAd4B+G1+FY
	8miUvuXouxco3yG5qlQtoHfJdfrcVOW0UanrQR/e21T8rRM9c5G6L+fwwmr2OdtcdkphtLHaO/Q
	Rg4pTUPZy5ZV921QnsFq+TLZGFiDxS0QeM/EN6YB4TEIHIMdH3E2rVrazEivFMzXXkJwAp6AQWr
	f9n7xmqxjhEi/FQn7/tlLcizsKkb7VJ/Wp/rnpxOvA==
X-Google-Smtp-Source: AGHT+IFT0RD46t/R0Zf1IErgjIpEGCMAsdYfxHsHNbtvlyC3cPEP2QPV193RVltNHaQVgcd61b8g1Q==
X-Received: by 2002:a17:90a:d007:b0:308:2b5b:d67f with SMTP id 98e67ed59e1d1-309ed279ec2mr3546910a91.9.1745491021404;
        Thu, 24 Apr 2025 03:37:01 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef03b27asm1093013a91.6.2025.04.24.03.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 03:37:00 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Nishanth Menon <nm@ti.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] OPP: Scope based cleanup helpers and lock guards
Date: Thu, 24 Apr 2025 16:06:43 +0530
Message-Id: <cover.1745490980.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This series performs various cleanups / optimizations for the OPP core.
- Introduce and use scope based cleanup headers
- Use mutex locking guards

No intentional functional impact.

--
Viresh

Viresh Kumar (6):
  OPP: Remove _get_opp_table_kref()
  OPP: Return opp from dev_pm_opp_get()
  OPP: Return opp_table from dev_pm_opp_get_opp_table_ref()
  OPP: Use scope-based OF cleanup helpers
  OPP: Define and use scope-based cleanup helpers
  OPP: Use mutex locking guards

 drivers/opp/core.c     | 426 ++++++++++++++---------------------------
 drivers/opp/cpu.c      |  30 +--
 drivers/opp/of.c       | 205 +++++++-------------
 drivers/opp/opp.h      |   1 -
 include/linux/pm_opp.h |  21 +-
 5 files changed, 249 insertions(+), 434 deletions(-)

-- 
2.31.1.272.g89b43f80a514


