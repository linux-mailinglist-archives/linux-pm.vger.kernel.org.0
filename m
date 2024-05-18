Return-Path: <linux-pm+bounces-7965-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C9D8C9141
	for <lists+linux-pm@lfdr.de>; Sat, 18 May 2024 14:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 703351C20CA4
	for <lists+linux-pm@lfdr.de>; Sat, 18 May 2024 12:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7182A32C60;
	Sat, 18 May 2024 12:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWRBHVHC"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAD444C68;
	Sat, 18 May 2024 12:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716037151; cv=none; b=P30XJuVvePj4BIubxN5YQ0Ogp2Yzplv6leP5qIvU70vyjz3TqB7hC2BHF/8wts02z4eTlhU3/gsz+VxE2lxv9CpxwiMQGFEpP8Bsw8lm8OT0LTiUq4jeUFCBGARJeHVkScHheIL75AZt8PG+nvee3v+zVu3JsNU3v85N0nNfGO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716037151; c=relaxed/simple;
	bh=NGJ4jwZUKOAzl+f3mjHvoT5yz5huI75D7VhkMXWjZLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rv24gf5+SbgnFMP00xGnyJm91a8BzOUkPE74m8tMfxYEmwG199j+xV9kjns8kM+RrLCxoOOXvsD8939PECeVs5WGGZDknykwFwhGX4R3cB/FjhwuHyha8iARMqCa3RiyxipcO52tXfhHYiLeNdErH1dyPEU4hB0NkHsFd90809k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWRBHVHC; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51f3a49ff7dso3669965e87.2;
        Sat, 18 May 2024 05:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716037148; x=1716641948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zSRsu/greOiguhxWKwTVAbA1IuBqHC3TjNHFAMMX7g8=;
        b=VWRBHVHCt+TOQkY2Zje8/zEyJ4Ex0+mQDvuo1j7NeAiiYbt31KddoLCzKR1RHRws8m
         RJAy+GvlLMUgaKrw/v2mSEmW2AHMEX6HTmx9UTT/BPZ1rdMCrg4IMCuAq4ZN0MkreQax
         tRI9By7MTcVKddT9FAJ9zjp1k+T2AbdkqPynHnyu27DwFsQx8EJNeW9/tnMb2lsqgGFX
         m8QvcDWjtvDOsk7H6AT3tKjGv0c5r7B/ATLx44cojMvDDVX7he73EjqUf4GPRRtBC6rQ
         nahC4LsXYrcVrxTLYeicNF6TI3GI9M+49pLwpveq+qfybAS4XuIlDE9oFlvwAn/yG2Xt
         QdWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716037148; x=1716641948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zSRsu/greOiguhxWKwTVAbA1IuBqHC3TjNHFAMMX7g8=;
        b=TiatzJbhpEflmFN4h/ht1grAZrnLDT0LdoXT3CZ8Stt6Ac7paffcsKoHI0gAt9oXG6
         qnke+erLa1rfvhRwqFcY9IcpotUi961Svn+HKQYNncUxjbLUL1250pwpXPgopvteBtr+
         oezxpG1ZKfHFmz/0JG/z8yfockJEzI/q0C3Q3snkqWD6V7LRtIN3BzL7HnMmuGPh8wAS
         Oc/W2t+NqHaCF6QkhAb++9AmxzJb5na4iUez6aN/UbaItXVDm/APAo3eatpwOnZrBxlz
         hfCWuPbktlla/f4R6wdrry6P+GELtCgb1SoY8J4c28PnwtDdGfeNeA8tMjKZFDWdDYk9
         FZ1g==
X-Forwarded-Encrypted: i=1; AJvYcCVozsoawZA53hxsRjmiljhwSyY3vWMoSN88w7c6FiTiMXWHvMDJk0BGG5VEp+OXDXNu+exVKXJ47uIaK1InCQ2w06WcSHvAjSKZPTof
X-Gm-Message-State: AOJu0Yw3JulS93KGddWLOY3vd8GdHR3GMqTFeeTPTVTquPrGaZ945j5W
	JLoPErkLfDf0i6oT4Qd4w+oHmtbJZgA4BKKybnCVBIw/6bEuB7U7
X-Google-Smtp-Source: AGHT+IGmgDdWyufJS6O/YFZlzO9rFPBXlmgfzmmslRVJ52yFcNLNqtyJBEy3OIDC3SDr5Gf74W4mbw==
X-Received: by 2002:a05:6512:2254:b0:523:294f:7fe6 with SMTP id 2adb3069b0e04-523294f806bmr13064332e87.44.1716037147727;
        Sat, 18 May 2024 05:59:07 -0700 (PDT)
Received: from emdj-bno.. ([147.78.30.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a8967a711sm552263566b.2.2024.05.18.05.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 05:59:07 -0700 (PDT)
From: juhl.emildahl@gmail.com
X-Google-Original-From: emdj@bang-olufsen.dk
To: daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Emil Dahl Juhl <emdj@bang-olufsen.dk>
Subject: [PATCH] tools/lib/thermal: fix sampling handler context ptr
Date: Sat, 18 May 2024 14:57:44 +0200
Message-ID: <20240518125744.71854-1-emdj@bang-olufsen.dk>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emil Dahl Juhl <emdj@bang-olufsen.dk>

The sampling handler, provided by the user alongside a void* context,
was invoked with an internal structure instead of the user context.

Correct the invocation of the sampling handler to pass the user context
pointer instead.

Note that the approach taken is similar to that in events.c, and will
reduce the chances of this mistake happening if additional sampling
callbacks are added.

Fixes: 47c4b0de080a ("tools/lib/thermal: Add a thermal library")
Signed-off-by: Emil Dahl Juhl <emdj@bang-olufsen.dk>
---
 tools/lib/thermal/sampling.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/thermal/sampling.c b/tools/lib/thermal/sampling.c
index 70577423a9f0..f67c1f9ea1d7 100644
--- a/tools/lib/thermal/sampling.c
+++ b/tools/lib/thermal/sampling.c
@@ -16,6 +16,8 @@ static int handle_thermal_sample(struct nl_msg *n, void *arg)
 	struct thermal_handler_param *thp = arg;
 	struct thermal_handler *th = thp->th;
 
+	arg = thp->arg;
+
 	genlmsg_parse(nlh, 0, attrs, THERMAL_GENL_ATTR_MAX, NULL);
 
 	switch (genlhdr->cmd) {
-- 
2.45.0


