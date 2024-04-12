Return-Path: <linux-pm+bounces-6316-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 345518A2CB3
	for <lists+linux-pm@lfdr.de>; Fri, 12 Apr 2024 12:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92586B21C84
	for <lists+linux-pm@lfdr.de>; Fri, 12 Apr 2024 10:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFB63F9D5;
	Fri, 12 Apr 2024 10:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zldM/5bq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CC13D547
	for <linux-pm@vger.kernel.org>; Fri, 12 Apr 2024 10:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712918548; cv=none; b=hcdFZENQssYglvUDLR1CTEIfobKkew5x/A3XEbRuhglsk0TPxQ5tXJvi3knyQVmGAG7ys/RNqrshWgG7mbRleMiiXSgP//cabxj6yyML77Uo2mbHiTU6c211A7i+ve19E6pjx/tSMa54+HXITWtOKCE5AM5iFLbAYBjthELoI8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712918548; c=relaxed/simple;
	bh=0H0hMWcNgkbz+OoHU/6BAy/ktYGB04j8mn1Ne/MmgnY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZGPOdAZOD84O1/RDQN/AmI8ZPJxR5fKkEdA+PxZP5APsEDsmUfgLrR5hlFTo6GD4eB0H23gniNSmp6nYGo3/gS+Kpqr5sbgbDnKfhGHbw/DXgPf8hcgmAi8f8p/s8B0yhwrqIICOee5sErnEesuM0yYRmcoBtrzG/7OQpC2bKbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zldM/5bq; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-516cbf3fd3dso923708e87.2
        for <linux-pm@vger.kernel.org>; Fri, 12 Apr 2024 03:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712918545; x=1713523345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9dyIX2GIRxyxtjQgoTbfebK6wI7hUKbyAEauzQCGs4=;
        b=zldM/5bqFFiNufQFSrHeHapYinsMtGL7tZVHfyElLRSyCPrBJgXygR978S8mTx54j3
         5Ach93SDlvlBjUAdK0hw8NI49wOjqEviXhMx3Rh4ek2L35iXhwO4xJ7SoP616brTngYk
         S8MiBArMQ8P4UcHmkc9WYN+ClT6J0rl+twXaGjwN4YnDU5aCFW7GMK7wdFCD62DJwDCA
         cggEqD+5j5kgpTP/HkRM/Gf/gwOkP0r3FwqnRBGwsUC83IWhTzHAlzI6whh9Yk/rKuda
         nEfkyQwNx1C8B1dLzcMmQNPpGUxLuPhFTcqR6ZpQxBKtWg2YuwkrvGBgCFKG10jmHnem
         r1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712918545; x=1713523345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x9dyIX2GIRxyxtjQgoTbfebK6wI7hUKbyAEauzQCGs4=;
        b=NvGNjS9wHZCciZ/LKQ2vVOP9peoi1tU6K/x/s+eJ2qEzJxIzcqBGiMLkbOz4KMaMEJ
         JEEelz3iFKakPLzUEpceigEOAm9eWpi0zocaLBWYXxujJEEZ1U+UlSpdF7rMq4XkWw0G
         vGkLGcqdP/tbFCm7MatyQ/0ZjF4Ssr0IEojpVukwtSh5Oq8KD9dclj9348EV2gBieIjc
         xTqhXYuIFtkiJ9UZugfNwIhYSh0lushywv5QT0iI29LXdcayUMyG3ZpfozzSduJCf7Z3
         f0+AXNw2uysxmbEu37Jn1OpzRVcu39UUzP8KAi7PiMKZntiJIKBrCgtICKauQbAnhmaY
         J0/A==
X-Forwarded-Encrypted: i=1; AJvYcCX4OvAc4U53dFGZ9wVdPaKaPwE7K8wgjfZ9uxF4TCh/c8j+oqO2UqOGPyJvZX13q5l3ZMsVHkgalkWIAlY3ZAvrfDy5SW+a9KU=
X-Gm-Message-State: AOJu0YxK3PMMiL3Ff5GDxWRYMewmnwtSCbieQizvtaIDRLTkHWiJaaXv
	HanTBtPD7HoCowenu43j7v8vG/DdDhlt0/Pf6ELxD+CkqIOdYQch7dExidnb97U=
X-Google-Smtp-Source: AGHT+IEZwUht8/pnBTEaDnGWHh3CxFUN2Na4wDCS6x/BRz79j0pltI+VYdSu7+r0i6OuXZDbWru1Tw==
X-Received: by 2002:ac2:5982:0:b0:515:af1f:5bab with SMTP id w2-20020ac25982000000b00515af1f5babmr1431306lfn.40.1712918544283;
        Fri, 12 Apr 2024 03:42:24 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id v10-20020a05651203aa00b005135f60f486sm493689lfp.112.2024.04.12.03.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 03:42:23 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] pmdomain: core: Don't clear suspended_count at genpd_prepare()
Date: Fri, 12 Apr 2024 12:42:08 +0200
Message-Id: <20240412104208.74361-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412104208.74361-1-ulf.hansson@linaro.org>
References: <20240412104208.74361-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no longer any need to clear genpd->suspended_count in
genpd_prepare(), as it should be correctly incremented and decremented for
all cases. In fact, if the counter isn't correctly managed we would be
hiding a problem that we shouldn't. Therefore, let's not clear it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 903ea0c193e1..342779464c0d 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -1255,10 +1255,7 @@ static int genpd_prepare(struct device *dev)
 		return -EINVAL;
 
 	genpd_lock(genpd);
-
-	if (genpd->prepared_count++ == 0)
-		genpd->suspended_count = 0;
-
+	genpd->prepared_count++;
 	genpd_unlock(genpd);
 
 	ret = pm_generic_prepare(dev);
-- 
2.34.1


