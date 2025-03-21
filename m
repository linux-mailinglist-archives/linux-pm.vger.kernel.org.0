Return-Path: <linux-pm+bounces-24367-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD2DA6B82A
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 10:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADCDA175C64
	for <lists+linux-pm@lfdr.de>; Fri, 21 Mar 2025 09:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A321C1F1319;
	Fri, 21 Mar 2025 09:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHUmrh0t"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B3133F6;
	Fri, 21 Mar 2025 09:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742550979; cv=none; b=ouXFpkPutyhlePNGyjP9uQpS5di+caNzUaArow6muT77TX7VNlJiJGJiXaa/qmOCb6j5WjuF2kglzzqRFr3458yz/k2aOP5m+QEX8ArQDUO6aZd15T8ZJTteD41IlATEgLQ4c7rMQOV41Enj/+ot619WTH9Abdph8F44JuxuugQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742550979; c=relaxed/simple;
	bh=vST3+YBnqZ7vgDLq/8DcOcgG26aUWoWL44PgfuNMLDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W94X3MihZezK5ePH3Cg931Wn4W0uayzcC00XaAoEohWcDX10BbQRGRuJ4W1W6uvAIeVc3ok8xb5jupsBZXGc7SOGp+5J8FlG275z2Gwu+T10butN2b/2Z/VvFXw4w7/AxcnkMRms/NKWvrrk9D2zAJwpE/tJXfcaebNU0IGv89w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHUmrh0t; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac2af2f15d1so234867666b.1;
        Fri, 21 Mar 2025 02:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742550976; x=1743155776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HsIQgwq+etm/XqjoaMjvezC22//tyBjo4Yc9wEZeyaU=;
        b=XHUmrh0tgTx5wg2GYr570i1z2dgQHY2mNQMnGevzWwiboJw9anl3kpRcH0WS83RCZ6
         gOaoAp1KhItpo9V6lAbfCDOghluN5pZKx15svgKVsVtDs/HqjCSUMylEPK+qGAq8iExM
         Wrjs7XrsyPvcy6h7jzoet7BlpbGARpj0Dbh7s6ImnDqClJYVJqfrIRuVQldBUFC4rJq+
         lzAYMvl7lSRStpiKU98dp/H4S16dhnVqJspIe/5IkFAD9aSb2cK6djFIoDU106y61nhG
         cf54yxb+l3rgzo4WXZv8u6nlcV35P5I9nxjhvOnrcE0BVHILxjbvv016Aq3c/EcB37xg
         h6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742550976; x=1743155776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HsIQgwq+etm/XqjoaMjvezC22//tyBjo4Yc9wEZeyaU=;
        b=RdQzDm8dN7nBf8u5KLykf5uOeU0LBXTEfeJtiLvPBN8e8RQ9zG8UQKSl07wF0GZecX
         qLZL49dx7E1UIvVBEp/bRw5OhdzmT+BiM0NZbES0Z2U6Y5gmkjzctId7MI1VgBGBjJ2p
         GFXu93IHemwqBBlF3NA5+Zu7sLiGyfRk8HXju3/miMysSgzfqCDOYzOC4pKwU0uqeAGk
         16QcPOePG2As3Xa9DF7mdJUrq5u5MzrGO1Dw+FMrmWJO4rYwS+T9zW/fsxg8ZQLmGBk+
         XeTlSggTrusplRu5XFABt0En5mvfJ1lGWid3s4qrbl1zp+QtxMwkTn2Oy01XxjGa4L/R
         ExVg==
X-Forwarded-Encrypted: i=1; AJvYcCVUPALBq6+h4XtDpxiiO2trb8CoWeytT3UNDAmo2KXGLfAa03xaOK0z9DxGSjPCstQSU+s1BeuBTNYvDU0z@vger.kernel.org, AJvYcCWAmbWr/aP6OVONqqCG4yIF77Y4iNa+a9Zui5csXHp7kzBcgiOVx7UPBPMXNPP3aRFITsOhV1ki2BA=@vger.kernel.org, AJvYcCWqlj8WZGq/q3Cpuu9vm1Rdp4CcF84A+kyDG+AWECNSofCxYBJGlTbMm3QClm4hlrHw0GUQcEWO5r8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9oAnwZtexrk6S5Oce97gslel8IDgWkrqnG6tWYLdSCuAMy+Xw
	7CY3vtBGjdfZkghV3tfSXf3owKy8Aj0PKITZ3rjiOI3Dv7vYSsED
X-Gm-Gg: ASbGncvSnXFMmpAw+tpIXieN9odqi1bhyA2qv6+QHwGhelhKy+Qrh7tjeCvkRTXdYfV
	vuanH2Ryq8yewLaM55Ie5T8d/b/NQi78ataF35KthCAPATm6a8RTZ0Kblm8zs/pNEgvn5hQItup
	OYDT4paoMs4Ci6tY9OEeDgVezlxGwfgAOpKk6oOjh+SYpSUbwxF1F2Y7VoZJ/XyVIrsWB4hzHKB
	Ftmq7WQTkD9zVOqPM3ukYI8UoawAg7KC/ibgCPcQVl1/srpCIkSxzs8+5hAy0tJzTsbwtKMS0mV
	nk9N4jvo25nBNCWGvzn3OpffMsBB6AwZd9Id
X-Google-Smtp-Source: AGHT+IEA4cvQlKUh63/bf2w0jpxSzULQ2c58vPVghi9BDntFsgz8IQJcwMuPPubpGpmuAW1XqJX0ww==
X-Received: by 2002:a17:907:2ce1:b0:ac3:8897:eb75 with SMTP id a640c23a62f3a-ac3f20d8b99mr237058366b.10.1742550975733;
        Fri, 21 Mar 2025 02:56:15 -0700 (PDT)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef869f19sm122300866b.33.2025.03.21.02.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 02:56:15 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Peter De Schrijver <pdeschrijver@nvidia.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v1 0/3] clk: tegra: add DFLL support for Tegra 4
Date: Fri, 21 Mar 2025 11:55:53 +0200
Message-ID: <20250321095556.91425-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DFLL is a dedicated clock source for the Fast CPU. The DFLL is based on
a ring oscillator and translates voltage changes into frequency
compensation changes needed to prevent the CPU from failing and is
essential for correct CPU frequency scaling.

Svyatoslav Ryhel (3):
  drivers: cpufreq: add Tegra 4 support
  drivers: clk: tegra: add DFLL support for Tegra 4
  ARM: tegra: Add DFLL clock support on Tegra 4

 arch/arm/boot/dts/nvidia/tegra114.dtsi     |  34 +++++++
 drivers/clk/tegra/Kconfig                  |   2 +-
 drivers/clk/tegra/clk-tegra114.c           |  30 +++++-
 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c | 104 +++++++++++++++++++++
 drivers/clk/tegra/clk.h                    |   2 -
 drivers/cpufreq/cpufreq-dt-platdev.c       |   1 +
 drivers/cpufreq/tegra124-cpufreq.c         |   5 +-
 include/dt-bindings/reset/tegra114-car.h   |  13 +++
 8 files changed, 182 insertions(+), 9 deletions(-)
 create mode 100644 include/dt-bindings/reset/tegra114-car.h

-- 
2.43.0


