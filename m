Return-Path: <linux-pm+bounces-19436-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BFF9F6D42
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 19:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D9A67A13F2
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 18:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9961FAC4D;
	Wed, 18 Dec 2024 18:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNRVSRmI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC1F3597C;
	Wed, 18 Dec 2024 18:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734546542; cv=none; b=rl4G/kL5z0LR3Ic2Sea7ZPVttaeKqrl8OGbrOcA6DGSGuLUyO+a8xFN0ck32VGzvX4GvgydISpCgscWn9dRKIHuk7MKnoQ+2yBBWmw/bhI+en8/r73hKapKtXDw5A1jzLRLu9pyP4ct+f1hijcb4d5IaTfworaREpa06jtres8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734546542; c=relaxed/simple;
	bh=McLCdUey2bygS0M+iCLLl+cF5NFr/HCPPVvW6wGUNvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U/+bKXLS0betw6zjgcmgxoCY2r1WqT4b2E5NtYUBNlbxBN555U7QLIIWFnmWJue+SSVKGHsiSimsfLWhpXuCzvp74k0DKd8q4kZ0118Gtv9/JafiJ4cW/EKPBgay4L3ODMjXLZQLoCT6p80fsxsvibVzQ/Dpar6VmJ/wlwqQcT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNRVSRmI; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2156e078563so51911255ad.2;
        Wed, 18 Dec 2024 10:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734546540; x=1735151340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qNc9bbXIkaEAXHmkzJsg6tVAk/RGNozbWEU6KnPyaP0=;
        b=bNRVSRmIQvZqlWh7bHAFXx4Ehw+SsSr324JyQxCxp/jlVqKrxr5nBmq2zD1yVtwTKB
         KFoELjssLZotDuXfJXTPMAXVKHEEF1jJgJw7aqmoZruRv5yalSPw377dU4ZU+0K6BtBD
         bhc/zoQW/BpIhVjFWcpAXiSWJ728JLERD88acxcFpbeKRliho/hA35LkXQPlDeqLrIGa
         tAEWPBz7WSNKG5vHAoZp+7D2u2S1+CUrE7ogSGxZNDHl1huQLn+xDpYoymcczjXsJ9c6
         vkHYC9m6wnyClYJNCX8P5Pr+oS1vKQoaEMsgRZu65/OW8nxBNbzUMa7iAmDx72RgdKEE
         1RNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734546540; x=1735151340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qNc9bbXIkaEAXHmkzJsg6tVAk/RGNozbWEU6KnPyaP0=;
        b=VPmXsmF3+50+4/bLbNBfHwK13fewIk5/de5c78oNZqVAmGvVfwFRIiJRyMAy4HQlwy
         /EMAjMUT8vHhltfGC6VeGcRGV5DNFlcjM/xqNF5OsXBtUO6XmcmP8r4za3h3YM7fWJOE
         D/vaPXwbCG4jNkH6JdNAhgIJqMbkDK+9aHlBY462mXA4sWpVQWc7xRvuxuFRKOTtraSf
         ftaZuvUp33ifbPXGBB/CAjBn3ZdTFJpSdxAcEVHMkjLjUAFsp9ysVjee6Fgv5Q5zziGQ
         BvLJtenZ1NCZg4Ezva67gpS2+QQG84uSBjNV5JhEzCs9/yLBHfusOapa4T+UYIlPtFZ7
         FKmw==
X-Forwarded-Encrypted: i=1; AJvYcCUI4CSwnIsN9rYBR25UhLQK8cGg0exMD34vZFv+XWeBw+IoMutr317c4uX06owfEljhRVMi7yuwE8A+tD11@vger.kernel.org, AJvYcCVBjaEQgwoWJZVB0TKW58c8+BWpblJKSaHe3IF/0Yf9HPshUzQD0EYpqyy9WrQ5Ta3Wna8nmvMsjawi@vger.kernel.org, AJvYcCWraRxXZ05SS19bXgc0C2jNr2B+ABRLJlWrBkqjazko/42YWob3M4FGjZtgCr+/CxxSPYj/qOl+1EY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQiK62s8txTPhM07Dnu+Br7hGLS6j6J4O0oxEcX0476sqE92Fj
	ufUXUCmbLjju0LXFgh1C6S2g/UtANcGXRNnQ+j9DYDa/B6j++zn7
X-Gm-Gg: ASbGncv0W0yvWrs5pzuOIg9Y3fO/wF6R2VhCuvLmaPtevBB6x+w5WlGqJ2FEfRhg6eu
	upTnx26jk9YroUZq11X13ll8q5+HEELA9vfs7TG8zO7Pdy9V+RRd7SxITYAmDrXjU7R6BWUzb9H
	lX7S238VOnITAUi1/iidDwH7iBj2Ed5b8KIcOmDCFJDY8b/3SjE7f8RGqM656bpTwIngIzx7/Lk
	OoLaubI3DUk6IJAYguD8XfOF6lJuodRP90qRQP2XoiHZ9HzoiaI1bCOvw==
X-Google-Smtp-Source: AGHT+IHxXWjf3S+DdVVf1jMLuuc8tXpGWFk/e409lCT+hKGNpbdRe9fl9r68eLBILkwmcXvTlksMPg==
X-Received: by 2002:a17:903:120e:b0:216:4cc2:b1e0 with SMTP id d9443c01a7336-218d7216b93mr55843765ad.20.1734546540124;
        Wed, 18 Dec 2024 10:29:00 -0800 (PST)
Received: from nick-mbp.. ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-218a1dcb3ffsm79202565ad.75.2024.12.18.10.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 10:28:59 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Asahi Linux <asahi@lists.linux.dev>,
	Linux ARM Kernel Architecture <linux-arm-kernel@lists.infradead.org>,
	Linux power management <linux-pm@vger.kernel.org>,
	Devicetree <devicetree@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Cc: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH v3 0/7] Apple A7-A11, T2 SoC cpufreq support
Date: Thu, 19 Dec 2024 02:25:02 +0800
Message-ID: <20241218182834.22334-1-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series add driver support for cpufreq Apple A7-A11, T2 SoCs.
Device Tree nodes will be included in another series.

Changes since v2:
- Use NSEC_PER_USEC instead of 1000 as multplier.

v2: https://lore.kernel.org/asahi/20241212070344.3858-1-towinchenmi@gmail.com/T

Changes since v1:
- transition_latency is in ns, APPLE_DVFS_TRANSITION_TIMEOUT in us.
Multiply APPLE_DVFS_TRANSITION_TIMEOUT by 1000 before setting it as
transition_latency.

v1: https://lore.kernel.org/asahi/20241211112244.18393-1-towinchenmi@gmail.com/T

Nick Chan
---

Hector Martin (1):
  cpufreq: apple-soc: Drop setting the PS2 field on M2+

Nick Chan (6):
  dt-bindings: cpufreq: apple,cluster-cpufreq: Add A7-A11, T2
    compatibles
  cpufreq: apple-soc: Allow per-SoC configuration of APPLE_DVFS_CMD_PS1
  cpufreq: apple-soc: Use 32-bit read for status register
  cpufreq: apple-soc: Increase cluster switch timeout to 400us
  cpufreq: apple-soc: Set fallback transition latency to
    APPLE_DVFS_TRANSITION_TIMEOUT
  cpufreq: apple-soc: Add Apple A7-A8X SoC cpufreq support

 .../cpufreq/apple,cluster-cpufreq.yaml        | 10 +++-
 drivers/cpufreq/apple-soc-cpufreq.c           | 56 +++++++++++++++----
 2 files changed, 54 insertions(+), 12 deletions(-)


base-commit: 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
-- 
2.47.1


