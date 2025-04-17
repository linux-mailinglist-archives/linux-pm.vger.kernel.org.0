Return-Path: <linux-pm+bounces-25637-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2ECA91F88
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 16:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A34819E7D15
	for <lists+linux-pm@lfdr.de>; Thu, 17 Apr 2025 14:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D672517B6;
	Thu, 17 Apr 2025 14:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DLnqK4P4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79086251798
	for <linux-pm@vger.kernel.org>; Thu, 17 Apr 2025 14:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744899938; cv=none; b=EZJkJmxIEE4qlU8mSAqIlSftxZwkDONyBPEzPEQ5OlXn2gKW2NELYUZZDiWc/dgTdqkgBrmiT043ZXo8QjQRMtOSR8TFH7agZZVpYHHzv3s6ZS9L1/uDgMJGZ9OOXPXrLoruVikyMTydNv8BsrnEfbCfPu4vPobgURi0OOreWfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744899938; c=relaxed/simple;
	bh=XlSonSv9LviP5yU3Iu5BfSf+jtHN/4GkokQYgxmFxEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EJ/NJqKlJVhCN3KD7GzKQWjQcb33+T+l5yRdo3/cngkLgZSWuUC9WtdMevAZZT+UETbibinksMnS2ZUqbbrwVDtIkTs5Hj2nIQlyGktuLrdK4GghAGgrZZJo3wIX/sQc5/9ks/Bhe14vZ0MQaiFWhW8GOhWiho1YmzejzrqjhLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DLnqK4P4; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54d42884842so1113137e87.2
        for <linux-pm@vger.kernel.org>; Thu, 17 Apr 2025 07:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744899934; x=1745504734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAv5QpD/3W+QIUIAEsxCNkQa5aZqJu5jR8/2XBRcQ9U=;
        b=DLnqK4P4iIAM2ihwg+U77jmEfycxjz1IL8tCwfuLx7HzSb6RPN0HBG93fz6urzaFjx
         hKDex43/Ng2fUEWpo6t4Dg7PPWSxiSRtRl2LSTlZ4IbQc7GgY4AVsBGcUh3aVQ7zd2KR
         g89k6P7XhW38H7CAYymtMj0Ggkk3ghuKt94qE/LlHP73/Km5ksSH7VRDuY5bDN4EuDFS
         rn7dC+mAm8Mr9NI6tj9BXmfmux2Wg2ExniQrDRY04A3XhgiS8Kak6I5mDx8X9Iknu3WK
         CKfBDO5+1qGf1594i/bJwlmiO6uQMsoKNwkVYs9vaQCTIdL3bdyR8Xflmt692pRWMHcu
         rLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744899934; x=1745504734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VAv5QpD/3W+QIUIAEsxCNkQa5aZqJu5jR8/2XBRcQ9U=;
        b=ozpvPruvqAFeG+U9wSN8sSGDPOlIa/hMuIiy3WsJd2ql57T4zDp1HMHHEgJpoZZP27
         mzUmWW7NylsDkeozPCvERk/x6gmPgSEjqQeNiPwcmdB6/dhwdl8130uaqM67bwzeftzz
         PsQYPhLo5DN6Ab53Pp3sZLcmmCkKkPoBWqxiJ2vumRY89JWzbO2tgyKq2pDlN5jgZziF
         EgAAHn4gNDJhhz9gZbg7kATjy1p0PCPb9WcKgCkhflaII8ykvVIPfGc/V5gAsatD7oid
         dHbgR8SdW9LBSs2zh9dzSL4m6/mIIxtTtQWuZmgPH3vXfwBS+uYZwsyl2ro5pNLYkT0a
         dn3w==
X-Forwarded-Encrypted: i=1; AJvYcCW/+2eJyQWVppacCbxxKEIF7HRtj3XDWKFB1yxSa6R778C4bOVPl514s3g1IUypz7fi9kaPiqWGuA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ74lJk8O3uwwhtEZKutIJz8OagijItYUUM75Yv3QNxL2ywM0U
	emv3K8eZdaPPeuVfu3q8plW1C5tsdlheLX0CdotLi5cqBtF8JwVFq4zhp7jFs8U=
X-Gm-Gg: ASbGncutLcIzKaEiehL5hCmyk+xVq1S8HXTCfiZn7+L1fmlntvjp6mC/TLxxQyNSIjH
	lI74513WErWp80kQjPj/RxVrsV89bDWZEmDrGSKObii06B3uYk1jGYKjZjSp6BqFS9uk8fet75P
	yjVzq1SF17c1i6Cah6FYe5JSfY8jx1mvzAIkiuUVqsJIeMnOqBBfSVV37fE+LwR1z2V0X6XnqD6
	FeJdJs5euz73SAQ1apC7ARO4vRHmd4nG+sBwrBEDE/O1As7nBHEob3lCZaozzaaUCmePdfhPIIp
	FyXy0vdqZiKH5fDNkrNKWZZk+0yZ26tfTJenG1f9Sf5Xiw6J45SGU9GnoUjVKRtDaoQdTZg5sNr
	+kmbxsqfQhsTzrCo=
X-Google-Smtp-Source: AGHT+IEdRb+byxDtsaF938ihBQexYxdm23PnPrnwFBeiHnuU4i+1SkPOaDcL0cyZpoToJUlNYAezMQ==
X-Received: by 2002:a05:6512:334c:b0:54d:68b7:86da with SMTP id 2adb3069b0e04-54d68b78b62mr1388539e87.42.1744899934579;
        Thu, 17 Apr 2025 07:25:34 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d65e43647sm370096e87.58.2025.04.17.07.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 07:25:33 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Saravana Kannan <saravanak@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Devarsh Thakkar <devarsht@lewv0571a.ent.ti.com>,
	Peng Fan <peng.fan@oss.nxp.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Johan Hovold <johan@kernel.org>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] pmdomain: core: Simplify return statement in genpd_power_off()
Date: Thu, 17 Apr 2025 16:25:00 +0200
Message-ID: <20250417142513.312939-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417142513.312939-1-ulf.hansson@linaro.org>
References: <20250417142513.312939-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than using two if-clauses immediately after each to check for
similar reasons to prevent the power-off, let's combine them into one
if-clause to simplify the code.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/core.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 574a0de1696a..34a85bf347ad 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -917,20 +917,14 @@ static void genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 
 	/*
 	 * Do not try to power off the domain in the following situations:
-	 * (1) The domain is already in the "power off" state.
-	 * (2) System suspend is in progress.
+	 * The domain is already in the "power off" state.
+	 * System suspend is in progress.
+	 * The domain is configured as always on.
+	 * The domain has a subdomain being powered on.
 	 */
-	if (!genpd_status_on(genpd) || genpd->prepared_count > 0)
-		return;
-
-	/*
-	 * Abort power off for the PM domain in the following situations:
-	 * (1) The domain is configured as always on.
-	 * (2) When the domain has a subdomain being powered on.
-	 */
-	if (genpd_is_always_on(genpd) ||
-			genpd_is_rpm_always_on(genpd) ||
-			atomic_read(&genpd->sd_count) > 0)
+	if (!genpd_status_on(genpd) || genpd->prepared_count > 0 ||
+	    genpd_is_always_on(genpd) || genpd_is_rpm_always_on(genpd) ||
+	    atomic_read(&genpd->sd_count) > 0)
 		return;
 
 	/*
-- 
2.43.0


