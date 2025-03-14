Return-Path: <linux-pm+bounces-24011-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECA5A60E13
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 11:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C7B03AE659
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 10:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E181D5AB5;
	Fri, 14 Mar 2025 10:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L4LLF7Kl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430891DF982
	for <linux-pm@vger.kernel.org>; Fri, 14 Mar 2025 10:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741946481; cv=none; b=OohpmP8xxR7K2BXIfbcfgL3dZ/Tn+HQYxchRyFsiVrKWTmL1aOFXKVrKv/MYjaPd1Zzyi0dDByOyD9yuGjYXRnozT0d5lbe44ZxbFolQXUGo9PfB63YmGqcriGVficSXLWk6fB5eabmGSC/kKV9dUU1ufEdx70Oe80OsosWSd34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741946481; c=relaxed/simple;
	bh=h4YozQ9gdqsEHLD3bmeEiZAm4g7uaJtsWIOuL/f+7v8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TMFKhXQ4w2WTZDgE0d61UoSq/KcDllvLovSzqa/Rre8AHV5mHe6uO+Ag9lFR6yrjTzxMP0W9r10miDGq5oPyM1jZUojWTERBCD0MdNQzjL6L7lea/tufFhp+uyiclIYWEVmtsBjlXO8wV4Yxz4zk3WhghUsC89ZIvb/xeBakFDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L4LLF7Kl; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-549963b5551so1880848e87.2
        for <linux-pm@vger.kernel.org>; Fri, 14 Mar 2025 03:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741946477; x=1742551277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NUgcdMszcZT79fuSYG7PG9+8zG6HmJmlZyIf7W0iDLk=;
        b=L4LLF7KllS1/yVTaI9zFkk/f3iw9JcSsVWCyaLXNu6oc1CM12tkYIt0LCVF/BIHw9s
         L0mTkNqUpLBR5VHaiN+r9YY6Hu2v6sC2rr1f1XbP5BE+VjXYd5S66n8LbQYuahlNNIcP
         8IUNKVgpmfMhcPKpOa7kyxC3n74WmYBnN3fLlM5bH5uE3th3m1YgnxWWm21wqoyMnFEG
         k+wn0GGgVjcIjBhuH6TSOXI6KyWZdmHqXatuSVsj+BP9Nn+3D55PS3DK4e5Y4a/6HY6e
         RkH/Zp2adzeCJwIj4yH1wozlarNgyBWrpReQGjJt+WhvemGfgMM+fcJ6MMVHysX/sN+G
         sk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741946477; x=1742551277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NUgcdMszcZT79fuSYG7PG9+8zG6HmJmlZyIf7W0iDLk=;
        b=xE0qx8FqRZcU/ZNjgWjNvq8STB/RkhHIXgyW1g4z/+0V/Zcu+fB2EKSfSjNTR/yfmC
         Swu/vdfmNVuRCtRYCoqsswfpTwVjE5luT7URi2kYdJyh2bFf9+DiPOSNqDad7ci0iewC
         A6kLktb0QdJpUhnwJ7k+eG6NfuvppdYz346DhuZRdY357kHkp4HBw7anvUOFkMOz0nEG
         4sCp7qbZqVN9QXEW9Ab+f+VYwI8b8ewma/dTwCTkCIT4bqnOXpbgndpDEP1S+yigoT0z
         qOnNU3dVPH2pax9rWG1CARCmvcaA3KthkjJqcMoJmZQMxaLInjR1nnUOBdI7AY+sYsW8
         ysOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsPQ6566wTdtN1MtNQGNOFrZZKypsEAGMlqnAYYCKCisfeO5rEzCr3/Aut/LGw3z62i1m3vLcr4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwF/N/dEphcb6yk+CmdwA73WAXjtgzNl7zbr8zI3a2gVdvHmNox
	4eqNCLgcsXBkmHuFYvZvz1ucYh9gIR37MkrXZdhWVKIMVjS5WrOh4VfbXx0eouU=
X-Gm-Gg: ASbGncsx5gJ8+llSki+7vaj3mqp8ujBfqnpHdPLGh+qQHHK1qlGFF9ysHX0ZNLZbRTV
	Z8XhGA5ap/ViofVDilfQyQ+VMLUwITq+TItdn5b2oVpxOxIUBTZ3l9+dO+ULINaxQoi3YXOxQ2T
	AXzic6Q5gJtzIQ8RcHdV6fCQbrqs6Mf+1YEIZNIQyufX3Cjx4PoiS8EM/8b5TlXZ4tCuOE/Xtnv
	lZJyJepu3x8ZgwoithIz6mpROv4sLglMFXpco+Z/3su05EZnPOjQ8ig6X3kc3DlHFjhchypSJ9E
	JWmNOlF5UrUP+wYjnuzrB0xmtz34WaPIMKeCO2q5pBxGJ5XQyok7JZHxjW4yafZj0whMzaGe1rD
	mSLdXMV8uiUwxjv5P5sQ=
X-Google-Smtp-Source: AGHT+IFr9G0sLdjjGzAEmSADvTJYSJ3/q7bZeLPAORPr3YpjeuD+P4b+VCcMRGSP60Xi47buAS1RYQ==
X-Received: by 2002:a05:6512:23a9:b0:549:8d07:ff0d with SMTP id 2adb3069b0e04-549c3987fa1mr605518e87.45.1741946477176;
        Fri, 14 Mar 2025 03:01:17 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f0ea468sm5168221fa.41.2025.03.14.03.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 03:01:15 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-pm@vger.kernel.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Anup Patel <anup@brainfault.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] pmdomain/cpuidle-psci: Improve domain-idlestate statistics
Date: Fri, 14 Mar 2025 11:00:54 +0100
Message-ID: <20250314100103.1294715-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series improves and extends the support for domain-idlestates statistic
for genpd and the cpuidle-psci-domain. More information is available in each
commit message.

Please help to review and test!

Kind regards
Ulf Hansson

Ulf Hansson (4):
  pmdomain: core: Add genpd helper to correct the usage/rejected
    counters
  cpuidle: psci: Move the per CPU variable domain_state to a struct
  cpuidle: psci: Correct the domain-idlestate statistics in debugfs
  pmdomain: core: Add residency reflection for domain-idlestates to
    debugfs

 drivers/cpuidle/cpuidle-psci-domain.c |  2 +-
 drivers/cpuidle/cpuidle-psci.c        | 40 ++++++++++++-----
 drivers/cpuidle/cpuidle-psci.h        |  4 +-
 drivers/pmdomain/core.c               | 65 +++++++++++++++++++++++++--
 drivers/pmdomain/governor.c           |  2 +
 include/linux/pm_domain.h             | 10 +++++
 6 files changed, 106 insertions(+), 17 deletions(-)

-- 
2.43.0


