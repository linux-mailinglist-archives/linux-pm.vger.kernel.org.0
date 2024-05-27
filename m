Return-Path: <linux-pm+bounces-8171-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9508D04D9
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 16:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AB2D293203
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 14:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC11016192D;
	Mon, 27 May 2024 14:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MB+Qa57g"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7323161901
	for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 14:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819973; cv=none; b=T0lvlEl0kaAMkQnumx7rH7gzHd36yg8FcTC4OzFq274xbakfODkjo1XlZECev65eMt83HRjT7A4krT+gjCJoRhuLGgFTKw0pT114O/fRz+7OMu4Z1j8u7cwXr2nLMFXbBEUVJeWada2pmk2sCpBBRmVqZRdIBvjOPIN5QqSuvpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819973; c=relaxed/simple;
	bh=XKLaI74qjA22QeAsWI8Ln1246wnUj1/8uIXA+l/FzQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L9YYqtN4+LEEozRYb/vfK7VY6SuD6pgEb2BGdotlMUzfAkiO2aEdxcL6Fyw1K+8+GHDu7TiGtoIBy4OqWTIX3zligWlqDf8yyW7fqshfp7xmtQzHKttJR1J7oa6Q7MQ/7uP39FdfkshYp8AP8sjdzXNYYmKQD7ybvJcgJNO2Pkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MB+Qa57g; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51fcb7dc722so5088076e87.1
        for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 07:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716819970; x=1717424770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZoaMc6WifhZ+fBwKL5gwIEFdMUp0oaX6j5v8OfXh20=;
        b=MB+Qa57g/N7vGhiTnBqeOdPr2vrn3NUueqPQQ1Cj2S9JeTDVEVYKown+p3pkV1/rnz
         2fdKR7s0KH8PLV6H7cqPf/nbWkIBZM4RAAEb8ujyrliHHUxgFs36RiT7aCnqeKIfGoIL
         V1HY731aMyAVRbVhkXsr/6dXHuWynzkwFmUTXL+ug3jsUqPampMfQfxYLbzDVxJdrpbb
         gTUTLo0o4x9Ne+RxMEeEKxbTsC2Wod91QWafaMdpzINvF1BpSlgNzNaV215B2i+dzhJK
         lDoLTcmsZ2YF57TJAyaamMFaD8Uc0NUU9vq+bPBqAruMedGXVwU22A3ZxhvfPC5OciKB
         Nw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716819970; x=1717424770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PZoaMc6WifhZ+fBwKL5gwIEFdMUp0oaX6j5v8OfXh20=;
        b=Ylk1GOP4htl5w0JtCfoGJPXc+J5qsYPYXoSXsTJkT5ZpjVT3dLp0QTx2NVcuVCNAUi
         4bqecyIgEGvoEkmXP1O/YHQqzBV+RGa3/SbDX+AW8ajz+VOn0qesRwT34gxvO7Gttz2Y
         27tN2rttWxf116lUPx+bxPZ6UUKSuk9gt76ulRgERikdEA5OM7V72E2PHVGEXxwFvaJc
         4jyd/n6cp1EcOoGHykmqaZAd8TH/CTN1ZC5BEiKgr8HavAKrsEck0a/HhMac2rEvdU7u
         I61afVTtiNuw2Z3+R5s9+3wQ3Fu02SRqgfvyz2pywuKwiFkqGfh7gVs9K7xbMSRa8kLm
         pNJw==
X-Forwarded-Encrypted: i=1; AJvYcCXf/L3IoRhhzGytqVf80gF/YG8GGfZfZ++xJZgzmBXxbfMNAnOdQiSkvm9/t8sW8zQWrJLT4AEyHdZgJclp82/yTzBR0MJd2xw=
X-Gm-Message-State: AOJu0YxuNPAshe4Sn+agDVVXs/8h8CL981CjfCF3BTPVHT1knp2iiX2t
	SKL00YOVQUXSEFragm+qne8Pptez4FfC8MoztqX0R8a6C60YwzV9r+VJ9xO0vPI=
X-Google-Smtp-Source: AGHT+IE/McdjIB2db+Ta75EpAOuo80HDc4szOTHxbQY1a3UNLxB5stFeNpM3m1xKFPzyrfs8FAVxmA==
X-Received: by 2002:a19:5e10:0:b0:51f:c38b:149c with SMTP id 2adb3069b0e04-527ef3ff4d1mr4004099e87.10.1716819970021;
        Mon, 27 May 2024 07:26:10 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-529711fa7f3sm562002e87.258.2024.05.27.07.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 07:26:09 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-pm@vger.kernel.org
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Maulik Shah <quic_mkshah@quicinc.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-rt-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] pmdomain: core: Enable s2idle for CPU PM domains on PREEMPT_RT
Date: Mon, 27 May 2024 16:25:51 +0200
Message-Id: <20240527142557.321610-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527142557.321610-1-ulf.hansson@linaro.org>
References: <20240527142557.321610-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To allow a genpd provider for a CPU PM domain to enter a domain-idle-state
during s2idle on a PREEMPT_RT based configuration, we can't use the regular
spinlock, as they are turned into sleepable locks on PREEMPT_RT.

To address this problem, let's convert into using the raw spinlock, but
only for genpd providers that have the GENPD_FLAG_CPU_DOMAIN bit set. In
this way, the lock can still be acquired/released in atomic context, which
is needed in the idle-path for PREEMPT_RT.

Do note that the genpd power-on/off notifiers may also be fired during
s2idle, but these are already prepared for PREEMPT_RT as they are based on
the raw notifiers. However, consumers of them may need to adopt accordingly
to work properly on PREEMPT_RT.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- None.

---
 drivers/pmdomain/core.c   | 47 ++++++++++++++++++++++++++++++++++++++-
 include/linux/pm_domain.h |  5 ++++-
 2 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 623d15b68707..072e6bdb6ee6 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -117,6 +117,48 @@ static const struct genpd_lock_ops genpd_spin_ops = {
 	.unlock = genpd_unlock_spin,
 };
 
+static void genpd_lock_raw_spin(struct generic_pm_domain *genpd)
+	__acquires(&genpd->raw_slock)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&genpd->raw_slock, flags);
+	genpd->raw_lock_flags = flags;
+}
+
+static void genpd_lock_nested_raw_spin(struct generic_pm_domain *genpd,
+					int depth)
+	__acquires(&genpd->raw_slock)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave_nested(&genpd->raw_slock, flags, depth);
+	genpd->raw_lock_flags = flags;
+}
+
+static int genpd_lock_interruptible_raw_spin(struct generic_pm_domain *genpd)
+	__acquires(&genpd->raw_slock)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&genpd->raw_slock, flags);
+	genpd->raw_lock_flags = flags;
+	return 0;
+}
+
+static void genpd_unlock_raw_spin(struct generic_pm_domain *genpd)
+	__releases(&genpd->raw_slock)
+{
+	raw_spin_unlock_irqrestore(&genpd->raw_slock, genpd->raw_lock_flags);
+}
+
+static const struct genpd_lock_ops genpd_raw_spin_ops = {
+	.lock = genpd_lock_raw_spin,
+	.lock_nested = genpd_lock_nested_raw_spin,
+	.lock_interruptible = genpd_lock_interruptible_raw_spin,
+	.unlock = genpd_unlock_raw_spin,
+};
+
 #define genpd_lock(p)			p->lock_ops->lock(p)
 #define genpd_lock_nested(p, d)		p->lock_ops->lock_nested(p, d)
 #define genpd_lock_interruptible(p)	p->lock_ops->lock_interruptible(p)
@@ -2079,7 +2121,10 @@ static void genpd_free_data(struct generic_pm_domain *genpd)
 
 static void genpd_lock_init(struct generic_pm_domain *genpd)
 {
-	if (genpd->flags & GENPD_FLAG_IRQ_SAFE) {
+	if (genpd->flags & GENPD_FLAG_CPU_DOMAIN) {
+		raw_spin_lock_init(&genpd->raw_slock);
+		genpd->lock_ops = &genpd_raw_spin_ops;
+	} else if (genpd->flags & GENPD_FLAG_IRQ_SAFE) {
 		spin_lock_init(&genpd->slock);
 		genpd->lock_ops = &genpd_spin_ops;
 	} else {
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index f24546a3d3db..0d7fc47de3bc 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -194,8 +194,11 @@ struct generic_pm_domain {
 			spinlock_t slock;
 			unsigned long lock_flags;
 		};
+		struct {
+			raw_spinlock_t raw_slock;
+			unsigned long raw_lock_flags;
+		};
 	};
-
 };
 
 static inline struct generic_pm_domain *pd_to_genpd(struct dev_pm_domain *pd)
-- 
2.34.1


