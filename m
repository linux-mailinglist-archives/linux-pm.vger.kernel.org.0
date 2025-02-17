Return-Path: <linux-pm+bounces-22213-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B6EA38544
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 15:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD713188E2DF
	for <lists+linux-pm@lfdr.de>; Mon, 17 Feb 2025 14:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113C4216E3D;
	Mon, 17 Feb 2025 14:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SNOt57mv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE5621C16F
	for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2025 14:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739800919; cv=none; b=njMsattIMfyPM0Q7pBmq9xD1QxuGu9BAlxM4woQyIMkfhM7Gsi5h7NNfavaI3+W2YgLuH0prHShJHmT/WVxyWIeNunUrdBo5BNQwo73EI97NHl2JqnJdFNSwd9Pxy8Cq85cjUwtHbg050GnaZH9jLGZuNsqiYNsi6efQnlk7Eh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739800919; c=relaxed/simple;
	bh=Zg6nsepDzjp4JBsTtcekYO8wkKsE613Xg2P4Bh8tnRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ujcAqwD0+iIrT0Q11z/k2ghTxpvgO3MQYIor0VzuRicJOUsIT8S9QCHPVSt6vP/1Jskjt1d9hMR9d21FaGzRmHMntxNwYO1hC9MRgD9G7IeLMoGJ+mcSvDu7p3TISHJ3GHVfNoKDz4CZoyrYdK+dgpSyGkfqWgxEKyfPiUKyBZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SNOt57mv; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54622940ef7so997048e87.3
        for <linux-pm@vger.kernel.org>; Mon, 17 Feb 2025 06:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739800915; x=1740405715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p1v5BxmP2rCNFSOwTVJRGcqOBB5QdIDbO+mvb6vcgSU=;
        b=SNOt57mvz93AJ2I0lZiFdCiMNA2EY6Jsy3wh3StqeCyqJWnjmy9EDmoHSW3+2eZZkm
         CXeIj7E+kdks+x0bTEUvTJEbpYjZaVEiDlnHMx8eEAZ5LTs0HI9Y2noKgCwaVxre531R
         iV0JHXZjO2gKWwPmxvOTny+OfMP/ERWpompS4aO3mKs1ILLMz0OlHRxtc4bKCXpVZNzh
         PaB+jDB9lQHxDeIG54VpNY0egV+IBHZM/Z7COgjoLGPAsgbhrJRe97pHQcVwGRf/3qBU
         DeTwATNUi+fdvqnZnzgC8HgqlaQECvDhjNdWmPnsv9pSbwYq0ETfcPT4L2JGUlmt1/T5
         Z9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739800915; x=1740405715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p1v5BxmP2rCNFSOwTVJRGcqOBB5QdIDbO+mvb6vcgSU=;
        b=afjLiMncN8KCqTqWcarDFifjjwsBE1MVSoxFzI42izKmuaR4CEDskHMLVGsHHLiai7
         e653+esulX0B7khZ9LrVzNHqolKbLFBPw3bhSdVy/HKNn/vSRNs3OrqdCJgJnN6up0Bs
         oNfcXmh/8rH6PbfWcfA6AXdf53T1PIwsGdR0BzhYVBNjgbbmmZm8wd5s2PfO2DOTqTOy
         lmdoydvl8ZvJdQoAmf8SkMYx02okOvWeRa6Z7NdgMkNguUbZSSsQX8Mqk9uQ7kqQWFwK
         1nFSmlFF5knWq2cS1DSsgQpemlfMwp8186hMjGouwBM18Dpl7aQff6IOLkpHuViRZy1b
         bxow==
X-Forwarded-Encrypted: i=1; AJvYcCVuenOI2stdvXj/Bcv8ONoy0E1ki5me9zQgj+77dFPf85F9CgJAtrewpeuO3YJM07W2YvaSZNYM8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/hYcMjlWkFONo+kqOtq4liGwddK/dLgEwEenzVWz3Gyybq09v
	iEoCYipK2QOKjCiZcYKP+xlcN7msGe6gmWUFYpu0w7pmPW2Hcf6qu9IGzqSXyYI=
X-Gm-Gg: ASbGncs1WfZDzSYPiKcPoobVhQpsICBaAuUFygXc8mYsQWIBVM7fw0k+UnXINBDQ95M
	As35BgNN5PW/uC+qOYm7yKv87xEl7+c7O1HgUP2lHCEWxhAOODwPaywqYVFkJgjVg+wuG2Z3Utt
	isv3xzXlM6/5A78+xN0HXC9vM6MUOF9bVqUz02cVUA/EDFxduLuiadN6UvRk4e5+9VGgyTLrjC3
	GNxahRlEfsgfpFXeN/KQNGjU7ffb1traamP+/Sg3lkbkCkm51Xqzd3Nz5F8zmyd1RFxrMsk69RS
	016FKuDSrl5NZT3KgH/bXbJ7PUZ7rc4PY6G5T+8bJoVvI4oA4aLVpzWhCW5uQesLfQ==
X-Google-Smtp-Source: AGHT+IF/D52Y4+TysjkW4Xz5QNqCyiJ7TzizrtncOHf/Kr3p06spV8nAGCs/R5F9Gjj5PmpWjUddzw==
X-Received: by 2002:a05:6512:1389:b0:545:1718:98d3 with SMTP id 2adb3069b0e04-5452fe93081mr3468336e87.34.1739800913531;
        Mon, 17 Feb 2025 06:01:53 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5461d1d8fcbsm608806e87.83.2025.02.17.06.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 06:01:52 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] MAINTAINERS: Update section for cpuidle-psci
Date: Mon, 17 Feb 2025 15:01:45 +0100
Message-ID: <20250217140145.117086-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add myself as a co-maintainer for the cpuidle-psci driver and the
corresponding git-tree, which I am already using for this.

Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 25c86f47353d..f2be70dec4ee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6087,9 +6087,11 @@ F:	include/linux/platform_data/cpuidle-exynos.h
 CPUIDLE DRIVER - ARM PSCI
 M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
 M:	Sudeep Holla <sudeep.holla@arm.com>
+M:	Ulf Hansson <ulf.hansson@linaro.org>
 L:	linux-pm@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git
 F:	drivers/cpuidle/cpuidle-psci.c
 
 CPUIDLE DRIVER - ARM PSCI PM DOMAIN
-- 
2.43.0


