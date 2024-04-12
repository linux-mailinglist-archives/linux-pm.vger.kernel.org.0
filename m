Return-Path: <linux-pm+bounces-6315-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E398A2CB0
	for <lists+linux-pm@lfdr.de>; Fri, 12 Apr 2024 12:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7221928980D
	for <lists+linux-pm@lfdr.de>; Fri, 12 Apr 2024 10:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62503FBAC;
	Fri, 12 Apr 2024 10:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gl1lzpBX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2386F20310
	for <linux-pm@vger.kernel.org>; Fri, 12 Apr 2024 10:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712918546; cv=none; b=igWWgggQwFgAmiUBVyDbWWQaVq8BpzndDJHoicepL1wivz3KQ1pQoFdBbbUpfesSCH9lxhhMuNd/zH5W9ljwdWV2V9mq34xV9CEDhDt0oPnIzgZ0PWW5USFoYmdr3mfEIHKUTjDCo8/lLDoi23RK8KAonEIkUB4LvqB3MDrPO+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712918546; c=relaxed/simple;
	bh=UIokhiS5Rj3MPlQ+/XRMF9ng6qEkITKXuZOWx3vpGv4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zr7WzZNlKGOrOqD1cZuauDWkq0GiLsvmc53iTxCBcj8dY7lAqJ1B7AnOJIOJdGLrrqYw6k5wuDeeGp/yqZN5UvYAI4uNEpWImXbQdR/v8jg5yLTTWmobLGd6/gXzyZyBFZrl4nRyumOOgywFlWjHIKa/JV4iI7qtpn1uboaHkfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gl1lzpBX; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-518931f8d23so188307e87.3
        for <linux-pm@vger.kernel.org>; Fri, 12 Apr 2024 03:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712918543; x=1713523343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0yzFF7XLEaVBUn6zqt63Jmp6pMmz0w4BTjsr5ZlkzWs=;
        b=Gl1lzpBXgTsaFqFsrX3lBEI8SggK4N06IMkg7smvtCkA5kGOdnjGKYtNVGEEIaD4u3
         0LrMk2t+tOH8G0PvZQY+UdUI0VnCCyWfIBODAdjz0aN+Je0XYvorJP6qzBCEVGZrylGj
         tAh1gIvpCOxzg+AXb3maMxxVlugEQDFnPNcQ/RSFbGsQSnEZmFOIw4s/geSl3rywlY2A
         s2YpCKZLLNafI89Zn+onk7oEX/Tdhssg7TYwjnYdfeUgToWqNceZQkLtpqkYmxdFy4m7
         yJFZdRa0CZngOx3CDzWBNqQTS3N1ehaMe3YU06KgwmcZ6Lms0JRT0W3bQbkuymi+lW2K
         ppxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712918543; x=1713523343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0yzFF7XLEaVBUn6zqt63Jmp6pMmz0w4BTjsr5ZlkzWs=;
        b=YmBbhTMNYauWpV5D4dZGd7cm3tdAKU6sKl/v8G71fdyrrnz9U8JmXIaZRQTdcyqF7Q
         Yi1h1Lbs2BtOUaJksRj0MN3RApFF8W3pOVZ0/IkTXaBY2xKQkoEcbzI206XNUX8ASopy
         Vb2jbgqnKCNu3sWfoasEDXIdNCADIJPxi1l8NlICM4tXpHf1saiottuPMAYv0Zm7TAYr
         CZ/huD9YF3ezZWsK1gestNlxTcIpckDhoL1+U0bR0eMFxwziftbUns1FrRh3qfKzNztd
         ea4iVDdNf6OjNduup5wf0qWVCQd5OyQCaKRwrjMdvT/7bNtOL1HdpSg+GaGPzlopjVZx
         pA4A==
X-Forwarded-Encrypted: i=1; AJvYcCXvFVqEau7qsMBm/fztpCfxoKTzZCgxFcy8ImWnyPZlVRtSu2kJH3IVXKetpKH4K2BjYQHd/wQVVOtvvUM21PpZ/NTK/L6POAo=
X-Gm-Message-State: AOJu0YxQfWQclRwVF16x3NimeZXuIPZ55JD7Cz82DaYEfvs7EOSpof21
	EImdOqgcpN0a7bqgLdVH4Qit/x5+CtDdL2uOzW8RVlOvdWG1sP41avmDHo5cJLc=
X-Google-Smtp-Source: AGHT+IFEu4dnjTinOwWdQUMez8s60WK/1nUwKuFkVdaWfd4AmIZ0Ku0mYf4Xc1K806sEPp0uonGS3g==
X-Received: by 2002:a05:6512:609:b0:518:9964:a7a6 with SMTP id b9-20020a056512060900b005189964a7a6mr1218lfe.42.1712918543246;
        Fri, 12 Apr 2024 03:42:23 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id v10-20020a05651203aa00b005135f60f486sm493689lfp.112.2024.04.12.03.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 03:42:22 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] pmdomain: core: Update the rejected/usage counters at system suspend too
Date: Fri, 12 Apr 2024 12:42:07 +0200
Message-Id: <20240412104208.74361-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During system suspend we may try to enter a low power-state for the genpd
in question. Let's take this into account for the statistics too, by
updating the rejected/usage counters for the corresponding state.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 4215ffd9b11c..903ea0c193e1 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -1178,8 +1178,12 @@ static void genpd_sync_power_off(struct generic_pm_domain *genpd, bool use_lock,
 
 	/* Choose the deepest state when suspending */
 	genpd->state_idx = genpd->state_count - 1;
-	if (_genpd_power_off(genpd, false))
+	if (_genpd_power_off(genpd, false)) {
+		genpd->states[genpd->state_idx].rejected++;
 		return;
+	} else {
+		genpd->states[genpd->state_idx].usage++;
+	}
 
 	genpd->status = GENPD_STATE_OFF;
 
-- 
2.34.1


