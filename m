Return-Path: <linux-pm+bounces-35689-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EF8BB7464
	for <lists+linux-pm@lfdr.de>; Fri, 03 Oct 2025 17:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 158084E18D2
	for <lists+linux-pm@lfdr.de>; Fri,  3 Oct 2025 15:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C610627B4FA;
	Fri,  3 Oct 2025 15:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s/7ol5q/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D968B2327A3
	for <linux-pm@vger.kernel.org>; Fri,  3 Oct 2025 15:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759503793; cv=none; b=So739LxdI09oWu7+3Tqha6VEQj7+9kMEEcfXZu15qh6+sfcLNqWRMppWSg+tLuX3o82HscZQBETLkBZmNzkINqfboeKhJo8CtdfS87x2vYlbsAIs3IhYzV3qU3wtzwtAFlgGaktnDaqYWjsKOuxPwneBMjMObubOpR5X95jer4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759503793; c=relaxed/simple;
	bh=owm4ds9OjyTLRq3vRT/eCnc2YctqsonLioVmqEaKn6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WTzhgem4TFJ2PrE2QMz+o7OD/XcGhzHMEgVf1nKeFIXMgT7rYbbtfjsd8ueSwG6Qv+OeOIo+SDbVBLBGuReSrm1EONU9hjPsMsf6otoXUn6AYRNHpxA4gc8pOV4dKOAoZPiiWufPbG3Wvwiqy039lrkCFGwSH6VOVfsEWPUq6AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s/7ol5q/; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-579d7104c37so3356188e87.3
        for <linux-pm@vger.kernel.org>; Fri, 03 Oct 2025 08:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759503790; x=1760108590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6I1cp+HxhEc7B3vUrgn327X00KQrCoI8VrJ+oGMKDrk=;
        b=s/7ol5q/hBpGqECWeXUs8LB0+ZAYXXyuigLKkfQniPs02PYToa116o65EBP2Blsy0U
         IJftC+P2UoASHrpQGW6vpgdhkFdDo3jTx4p2wrNUrYOMyOw3Z/pyn8PtG7EKatfO8vK+
         uNIGA53SzluYlPtA3d3xXr2fmLhU8qQKHfCK7jXiSP4F44zJW8Xqzb8BhY8OzTv9877X
         LUEbM2fNfeCFRMOYmNeUKnsJ1L+I35W/iJAtE+hCgVVkg60cmdBvm6BBSWIvmNdgaOCh
         fiPt5q5WIwWe6Px6WI7OKGqjuOb1OuQEclaeDqzYxWXKuFa9YKCa8joH/nSLV98i+ZIY
         pF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759503790; x=1760108590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6I1cp+HxhEc7B3vUrgn327X00KQrCoI8VrJ+oGMKDrk=;
        b=laD0y60wzPApu6S2LXAakRJJnC4YGEav0u4ViKleHj3ELsebcvnv3elb7ekforNpJA
         vqxexmmbfdtA0oE3OnakViMInfiL5dHZyY//HzZfZh0Ak3iSdUuSMkQbtt0ChA8Ewlm7
         SgHZKrbAqrkSCeeGCkprwXQgS/vtpEsuKmxMX1iP90VDFEG9AuzEgfJGYkjZIim6/CHL
         SpMRI/KgQr+rYXp3PB/NBkflaNCZQH9lX+Swgs3znqhMqYeVS7wDTTwB9DPQMDFY+gt3
         55PsicPoqEukaWnC6XrNk+jmpIKJ87crcyP6qdDoYR3siAcfVKdVMo0hnjGyUOhbVe8s
         4SuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXP7U77ch8RSWuV2+WSi7PAWSKsoizo4pFQYY+5em+ZuvD8tzkZFFCSnbP24Qfa7EjXwhpEYz223A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWFw6N2xkJPEV8htE6G0q20+G4HtuLu3KwTbhmI5XAYd8a/Bi0
	8BdtvYZGyQCnbH3TU/KJ8L1C6kKSs20auMbec3ryhuxYjusHd9LRWhknr3+Dm+pkFK8=
X-Gm-Gg: ASbGncuRA+YqWLW4dc2aZXuyDy5YrhJhz/pmMggwhAsN2JYtU8Uadf0PiRiw33sD4vA
	jcaApkkXRqOnlDjmPQlxjfYYRDfWMuX1BEjUmBWxCTG+of/ysBKQIGp89SI9xs8ni8tLSqrXBPc
	/lGftXoOONPHiUb5DtmGma4brnFUA0OsV2p/TNUsGhmk5B8eXh50tSEnuwcKrnDhS285ZrQmk7o
	yryS4Q6H9lnNnA++efOMQdblo0l/YFfa18xMmqMrf8vfAPhMaYvCtUqKtamZF0Dyf1+dm8TFYxh
	lPaHnxlYKPCoqjhhv+F+R85LE0ld4nQLM6GNl+4UtiD0UrEuQ0Ntm/qedu9fd7lSvHCAz9YdKQe
	5fhgQnW3mue9dUQj2KtME1R2casbRiNiU0QbvULTcxsZazYJsiyO0CrsNJafgiGHKsDKYSkDsH3
	I5fVSO2qtKIE+51xRGL9JuPwrlnDBpt+tG/V52PU7ShsVeOA==
X-Google-Smtp-Source: AGHT+IFDyf2CAvnV4x29ZpVZ+szdDhm4mElGlYbHAAsCPKVjg7GYU5VG2tOvCk368uOv15rIxkfSIA==
X-Received: by 2002:a05:6512:3f28:b0:579:ca71:2750 with SMTP id 2adb3069b0e04-58cb9f0b673mr982744e87.2.1759503788264;
        Fri, 03 Oct 2025 08:03:08 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b011343b6sm1933369e87.35.2025.10.03.08.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 08:03:07 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Maulik Shah <quic_mkshah@quicinc.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/3] pmdomain: Improve idlestate selection for CPUs
Date: Fri,  3 Oct 2025 17:02:42 +0200
Message-ID: <20251003150251.520624-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Platforms using the genpd governor for CPUs are relying on it to find the most
optimal idlestate for a group of CPUs. Although, observations tells us that
there are some significant improvement that can be made around this.

These improvement are based upon allowing us to take pending IPIs into account
for the group of CPUs that the genpd governor is in control of. If there is
pending IPI for any of these CPUs, we should not request an idlestate that
affects the group, but rather pick a shallower state that affects only the CPU.

More details are available in the commit messages for each patch.

Kind regards
Ulf Hansson


Ulf Hansson (3):
  smp: Introduce a weak helper function to check for pending IPIs
  arm64: smp: Implement cpus_has_pending_ipi()
  pmdomain: Extend the genpd governor for CPUs to account for IPIs

 arch/arm64/kernel/smp.c     | 20 ++++++++++++++++++++
 drivers/pmdomain/governor.c | 20 +++++++++++++-------
 include/linux/smp.h         |  5 +++++
 kernel/smp.c                | 18 ++++++++++++++++++
 4 files changed, 56 insertions(+), 7 deletions(-)

-- 
2.43.0


