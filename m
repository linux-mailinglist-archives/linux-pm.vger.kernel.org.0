Return-Path: <linux-pm+bounces-25890-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7A6A96529
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 11:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A4293BAF27
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 09:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04F6215173;
	Tue, 22 Apr 2025 09:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mdi+q4IL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F55216E24
	for <linux-pm@vger.kernel.org>; Tue, 22 Apr 2025 09:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745315666; cv=none; b=QTl60x28eLXwN3vM3I650ctrDlkSShc6UEU+OkLcSjV7AK+hlr0tzJk78lGo9PK4vG8dkvDYEDDKBSXBMh3+SOET1FToSTIfKx40IYWNFgZaOvdv6I21XzsqLfNCYozqdLNjBCLxd8CyPABLHJ9HF7rtRgiz6UWtgouEh7lN5J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745315666; c=relaxed/simple;
	bh=h2PlaUDNh+Zo7Zhthf2PkPMeYtfakuR/Qz/FV6Egn6I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TxXn+lD4w1eatbHosbyCwGjauUg7ifWtLQcAWzyOYoB0OJ2iNQKMzt6SXUr+noWFFAjfIpcAgkCYfr5vBmb+JNdllyqToMYA+582QmgEuOdQ8Tb3+wUecLjWMVbnggSyoMqc7vUSO5KoQMNuJtDrFOhouIf3fDQDeCBUotb06fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mdi+q4IL; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7376dd56f60so3483630b3a.3
        for <linux-pm@vger.kernel.org>; Tue, 22 Apr 2025 02:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745315664; x=1745920464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLlCWejYiaj9zuTPSqef+ff7x8m34iah1oXk7eNizuA=;
        b=mdi+q4ILLg8SGqDKvh/yRk+IZ2U2NNBQIbKgzuGhOgNT9zSnD5W1h7TE5CovFA2b9+
         tX3Yx5KgpsixXFVuso51TMrGXExLC/YSc76fwm8Hfli+UyNk9DA6EyWXum1zC5U/Qerr
         CiliVM0gLKaea9/GB8ZlGCHGsyJiHK/jMq98uSpR1xhSIb5g3iWtCkEuOrrJ6anekPpm
         Quwx/lf7EfcI9JjmSQ2ycqt2n9G4M2U6deR1J4sUlZGAsifrUoMBa3NqRFcCSrW6emM6
         ug3+dVGDHv2gcSFk7zoIlGK873oF41RhRUslPJ/z5ObkN/7tggDaUIxUwIVrBGvJG9ti
         BOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745315664; x=1745920464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLlCWejYiaj9zuTPSqef+ff7x8m34iah1oXk7eNizuA=;
        b=pnqsZNNf22ahH9OwKu4U4yYzVToKQSTS46wqOrORHnRkHSArAGRDBOax4jg6ZWcxJZ
         KFFeZejdiuR5jtj0dS884U/Vgo9WG4jAGjSplt5ZeBUGRbyFegGRWqOGFmw0pcwLwzyy
         8YPCTgHEgCx6O/5AOb/b6Sz5X0Sj4ay8Xv6FWXqLil/W/40OCB0SCpltbVIgZOAeoNSW
         XVEz0sxIdnFLkDv+Ua0OECXq4fK6y/KuZt8qO66vm/uR15jXXpzitbOuIagMrYcVUpYY
         Wr9QrAUOxireuuDJaBuLFfVJ9GwDHvbCYTiOX1EgF6f9F+t9fnuTs4HQvJ8gobXOfIky
         tDJA==
X-Gm-Message-State: AOJu0YyShchf46brBuRUXzpBpgHKykhkN4ToJyNo2wdWWE17p++LFp3p
	tAgjV0Upg5c8EF2x5iUF5sf+/B+z0bQKdO37UIG0uBYcsN1OBB6xhLpibxN8Bsk=
X-Gm-Gg: ASbGncuNTwi3wBgi2dm39GDplb88/0kt09IW2aN7Z1S6HtDiaFHagNOc+SqU5fZfukj
	AzlyyiF9uxilrYsaXm94mktFZtEfcaJ4aH+Y601KFsgwgCjMNBieA30LrXga3AiX9AgYtMUiob2
	g6ZbsYrLnOPCnNKcsT/5T9CTFOb/xnqpcAt2rGy+VqZkyd+HM/zpil/pDakO5hkNeGCuPwfz41L
	/QNwaivZgUiwvkiaDuRdp3IFzLD2zdevAjzaROnUJ+R8Eogox5aYUYUJuIs2gadQ/kR3m2eHJgm
	vHK/C/Vvtkg0MFkV1nsqD3pfu1WaK8spcp0RIHMmjQ==
X-Google-Smtp-Source: AGHT+IHqQTHvvzAxnddY26qFGNYR3FXphqrDnq4k6oSYICVoVYNGfaLtcHbgiJNvmduT4S9HNBMjSQ==
X-Received: by 2002:a05:6a00:3928:b0:736:a694:1a0c with SMTP id d2e1a72fcca58-73dc15cc4b4mr20840085b3a.21.1745315664414;
        Tue, 22 Apr 2025 02:54:24 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf8e510bsm8463248b3a.66.2025.04.22.02.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 02:54:23 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	Nicholas Chin <nic.c3.14@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] cpufreq: Force sync policy boost with global boost on sysfs update
Date: Tue, 22 Apr 2025 15:23:56 +0530
Message-Id: <73708a14feae46166e9bceeee5e8bf2d0802930d.1745315548.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1745315548.git.viresh.kumar@linaro.org>
References: <cover.1745315548.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the global boost flag is enabled and policy boost flag is disabled, a
call to `cpufreq_boost_trigger_state(true)` must enable the policy's
boost state.

The current code misses that because of an optimization. Fix it.

Suggested-by: Lifeng Zheng <zhenglifeng1@huawei.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 0ad459bc8f84..4ac5d4fcfdd4 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2863,8 +2863,10 @@ static int cpufreq_boost_trigger_state(int state)
 	unsigned long flags;
 	int ret = 0;
 
-	if (cpufreq_driver->boost_enabled == state)
-		return 0;
+	/*
+	 * Don't compare 'cpufreq_driver->boost_enabled' with 'state' here to
+	 * make sure all policies are in sync with global boost flag.
+	 */
 
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
 	cpufreq_driver->boost_enabled = state;
-- 
2.31.1.272.g89b43f80a514


