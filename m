Return-Path: <linux-pm+bounces-23860-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5C2A5CA57
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 17:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED9F4163CD2
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 16:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A077260399;
	Tue, 11 Mar 2025 16:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hTbbffLr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B91825FA1C
	for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741709320; cv=none; b=I8YzfLundTsjsI146zaxXfiDwZ0x6rQo3P3cJq6W7ow9a2+3DKEJ1/8jJfZO3ad08/8EbuALK7zozZmDAo7YIjv5WJNGTtDGDmuJB8d5AjGzaNXPFUaITMGA0X9zTMG0eg6SEAHvK7l9ORRYS74x801trKVi8Sc0fyzzOd2Y4sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741709320; c=relaxed/simple;
	bh=0JyQVQNXAvmJ1/n8UxRyRWsOn+wf5nWtMrbcEr1qgqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MPHOVMmoonETDS/R/2rmwkKnkdfL7Aty+xsPC3lGxXeOFkViQHNqCVWLJKHFKB3fDWSk0OTA1byZl6C2IzDZIGVfzyndUtYkFq3Zcd318vqmqMRsnzjBRolzj3JHeT3fRobgWrF1fVcaTExBpzrBfThaOPR2pWrzCc3nVpRozJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hTbbffLr; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30762598511so60949091fa.0
        for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 09:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741709315; x=1742314115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcjlvQ20Z+LP3Azhfy6nFMLexKDv2Y/3x8IawyIsoTw=;
        b=hTbbffLrkgs8aWE0ihiJgubeavcGhEQG6xM/foE2BNKjgqINpGUMGbOOqm8crtsKFU
         XVES0G8uZ99YcU3NYYD7YCN6XjCBLHb6qyBkR9wvQC3UcMp2m4jNrSoHaJm+hnbrbaRf
         WFmH2La8YZe+zMSQgaK7WHL52wS4lbLk2PwEf+Tww33CUtTm9Uy+4EG8nGN4MULxrdHh
         IpiE65qmMQIUJPcCLQMtbYuFTN5Oty5XUrdNFH31AnLfkQ6I/K1I7TMX6JSTWshiHqV7
         7SeNq06JmQXDjQ7siQwXvd8DFt+4QxG6jgjaAFKNCNsGaw4DLRQCu9FllDvHO1Z0d8gj
         86lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741709315; x=1742314115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kcjlvQ20Z+LP3Azhfy6nFMLexKDv2Y/3x8IawyIsoTw=;
        b=G2Dy25DxwFfupZOqNMyaSfTGDE5sfP0mMJLYG3MwhooJ4hlwx1hMD+CUWUAsSwfztj
         PGgB5smUaPICDJz+j/Mto5qcH7YUbtAwBt/bbxCnLQgizSm2O5fg44AvGsd9IoM6ROnb
         yYlb5Oic2WDU9M05WCe3anwwTplZ9QIxqTglcM5bEQ6vP3Ez104cs9ut31SSdw4EyyGp
         EtKsgNihBu3o6PIgCUOHDkCwyHeuwyKKENOnhuVRFLyP9pipADzE0r51Kdckla9iLNCQ
         k0UBvUgqVDaUlGOe0F/RX89MXlkU9Eug4A6zraAmqXUpEoxj2epkTdapXH9nNP3G25IC
         O+Vw==
X-Forwarded-Encrypted: i=1; AJvYcCW6gTXAfcF3gswqlt1DoZlpVpxZACq98RBYR6PhAgfJYdcYnRV9mNCoDY4k3Mk9Yj8QthHgAhrUrw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwK+tgjimj4WAYGoVRTWhTnpLkfciOd22l1gWt4gZw8yQzJKMpQ
	G1Fnwy+bmA/+ry1eV2vsp/qkIy532ruhWH9ZocQ2HrgpHd8h50SOL0DO3tp8584=
X-Gm-Gg: ASbGncuXjh3LZR2p4wGRNUTI1UNj6us/Vyn3Dl7narZMaNGA1thUxBtXb5hbt6poIJs
	UB3csX7O66lWWyh/rKDrdJ5URnv/DriZoLvJH76OLIFrM2M4BYrmDvcI50TFLzaf9XM+TPFsG8j
	+kF6cZ2z1fGAf434VnKf/xD4hQBtT1uWRFTRUFYyrQawsKywLVi8kxu9zAEs2RBhH6gMM1NzTI7
	g5kqXBBd9XA8nL2zhEhUAogfYVCf3sWTfIVczO9haomOSqu2KUwJ7kjMODt0GwpuMszfpmtyCRz
	cwVeHoANhx7wmDanY9jlvoD2VGpO4LcMJPJjGwZB1v7SMn/ul1tDL+jR1gd+pyXWWyWpG1tJeJo
	OzLu+J7sqI8M9n109VCg=
X-Google-Smtp-Source: AGHT+IHqEinybzI7v0pVnETj2v5LwyPFnNPlZDH83XrlF6Z5frt4mvnADmS29mGe3LSIyUVtpKjvJA==
X-Received: by 2002:a2e:a9a7:0:b0:30b:cef8:de87 with SMTP id 38308e7fff4ca-30bf44fa059mr66552361fa.4.1741709315430;
        Tue, 11 Mar 2025 09:08:35 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30be9918c54sm20761671fa.62.2025.03.11.09.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 09:08:34 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] PM: s2idle: Extend comment in s2idle_enter()
Date: Tue, 11 Mar 2025 17:08:23 +0100
Message-ID: <20250311160827.1129643-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250311160827.1129643-1-ulf.hansson@linaro.org>
References: <20250311160827.1129643-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The s2idle_lock must be held while checking for a pending wakeup and while
moving into S2IDLE_STATE_ENTER, to make sure a wakeup doesn't get lost.
Let's extend the comment in the code to make this clear.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
 - New patch. Suggested by Rafael.

---
 kernel/power/suspend.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 90fb06ca07d2..b7aa1db278ff 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -91,8 +91,12 @@ static void s2idle_enter(void)
 {
 	trace_suspend_resume(TPS("machine_suspend"), PM_SUSPEND_TO_IDLE, true);
 
-	/* CPUs can't be hotplugged here so let's not protect for it. */
-
+	/*
+	 * The s2idle_lock must be held while checking for a pending wakeup and
+	 * while moving into S2IDLE_STATE_ENTER, to make sure a wakeup doesn't
+	 * get lost. Note also that CPUs can't be hotplugged here so let's not
+	 * protect for it.
+	 */
 	raw_spin_lock_irq(&s2idle_lock);
 	if (pm_wakeup_pending())
 		goto out;
-- 
2.43.0


