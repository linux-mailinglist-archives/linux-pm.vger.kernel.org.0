Return-Path: <linux-pm+bounces-19442-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D3D9F6D53
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 19:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BDA21896139
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 18:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053F81FCFE3;
	Wed, 18 Dec 2024 18:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6yH2rLY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764071FCFC0;
	Wed, 18 Dec 2024 18:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734546559; cv=none; b=Ei0i2dljspzn98dZ+74FnKuojda/P0f8gVW2khdOKY1OZWuqZwVZjiOUbZBAGbbYFQ4nt4MNDFRo0J/kIPG8uLdNwHHs4Iist8kcaep60bri6A7Nigx8Pb7/8LFs+H2NlkiAdlC4dvFr2xlnFFBx9F2cEL5XY16TCnwv69DQ4UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734546559; c=relaxed/simple;
	bh=fCCg/V03dlTVApvfdzM+UzWAAxzMgivnQ9qaZgFnZ0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NYNn6SoSzxaHScbAmSS9mBpRmdViulZ4LwSKYwjqUOd3CPe5TLvr7zR27v7P28LzA1ndPd3CaHXYawcSV7JI70gq+WYCfQsDGeEvIilGsO3adbpdyYIjTRlzwFISfcwTW+WAChx33fDvi7HOAli5NsywQ4PZEjeThZyPuA8nkNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6yH2rLY; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21654fdd5daso5095ad.1;
        Wed, 18 Dec 2024 10:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734546558; x=1735151358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1e4i2yJb6M8JWolS3FF1qtbGtdKGQDJ3R3qFDxNx2w=;
        b=S6yH2rLY4KugWbgc+1EJwTDw0ZE6Q8L7qsYyxqYKig0+swiJtrfRCQnS761Vc9BiU3
         snL4DjI5xTHZ8LOcGIChI/hHeEGxF7wNrfzQ4EIEqVeuvW4e8QkshoIVwsjrC/HQVXX3
         6KrJmw1+/XLGaN+Jjn5Imu0N/w0zPmRcgqoBlLW+SAqBc7DcDLeUxvmPHOaB0jlj9MPk
         g9O2c4/EgTQxtN/OFc6pl4i7u67JkEZ2YLAscqBgB3cWQClDMiVsaRY9Ex1+TYWVthz+
         EsvYEycASLOMsSiKxbGQtvcX4OFg2k2fjo8xlj+OdpZbyvIdyrgoC6Q5qOKE+f/JZ5eT
         0Ohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734546558; x=1735151358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O1e4i2yJb6M8JWolS3FF1qtbGtdKGQDJ3R3qFDxNx2w=;
        b=gcnGJAAEclSbZr+TfGoEr76QdL1YcKupw1B5D7SuqxuPKwPhMH6GdKhP3BTEyVv8FQ
         sPI15ontwZutnNBGXR6Bq+X69iBCUdlK8ir2D3taONTE8VSJWBSX+T4QgD9mZM29keNC
         iyuxmjT+Q+RNKBEcdKSXPU6y+NYdIy+wc8Tq93J1NrLj+97TlBMiGF0Z96uDSYxAHGUC
         fYN6fg91EaCZHh0pxiSyX10k+IjRzgJQZ1CZ5r7mrJb97/4QyEyVhh7rDLgjo1zKY18j
         1BjA5IGdRNo+sNa+FxCGaGTfu95uzVA6isjeBLC5XoJ+IyYu93xy75dzelLuzZyIeAuL
         aatg==
X-Forwarded-Encrypted: i=1; AJvYcCUcQ8bXgBnHZwJLKZVhmsu8UmJeCzdNGfKuPMfFumD7OybepLmHNAGAElWbETh5oFQ9eSg7ZNuRgq/JgsAy@vger.kernel.org, AJvYcCV0XkbUIYacnkd9Bk2xq4WLyX4ul2A0PqpyNxtmT+RCfcNGgrYc1xx89ceRHMsDiVDeT//EXSauipqp@vger.kernel.org, AJvYcCVQuPJFx39zowEXU/jjbg/qXFFIUrAn9m6YMqRf5sEpNLqVVW8aZ/78LHA6CCt2J3L5Fyv93YeVo7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLbQnafcyIQalM8bo6TbggIymEZxCwwf7ER2BQAvfp0aw8M3J9
	KJGfAFKnDyNTZlC5PKpzJfmK2dCdhUoxlivkkI5TBb0W9w1owJFb
X-Gm-Gg: ASbGncuqCSz2yYuhG9y3DkdBMxlny7NUUh+umiJJwxzJCvfNHBB+bEPXFoH1Uma91Lz
	g77XON/sF7ESPUct7xrmDYcARcj8JNAJr38w3hIzzux9Ao1GyLOh7kDXmnMnVXFDNnc/5Yd2sFX
	pCm25quwoHPW01o+ZXHa2J39FXzLtZ32UcGD8uHO0h8ynLeN5A6pV8CYNuZlbiK2XeLYC/Qx7N1
	mTFw1veCxXD46/5SRB7YnKyVwiIGrJf7PN/v4YGGXUTky2TcOe6Ku1a7w==
X-Google-Smtp-Source: AGHT+IHIJQZvEA5f5MqvLKQRVSuowhIimcNsdQUZGQd0bWhhesTYwzAxxO/1ARL7Nrb4NCT2ZfdFZQ==
X-Received: by 2002:a17:903:2306:b0:215:a190:ba10 with SMTP id d9443c01a7336-218d6fe1a96mr58866725ad.15.1734546557853;
        Wed, 18 Dec 2024 10:29:17 -0800 (PST)
Received: from nick-mbp.. ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-218a1dcb3ffsm79202565ad.75.2024.12.18.10.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 10:29:17 -0800 (PST)
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
Cc: Nick Chan <towinchenmi@gmail.com>,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH v3 6/7] cpufreq: apple-soc: Set fallback transition latency to APPLE_DVFS_TRANSITION_TIMEOUT
Date: Thu, 19 Dec 2024 02:25:08 +0800
Message-ID: <20241218182834.22334-7-towinchenmi@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218182834.22334-1-towinchenmi@gmail.com>
References: <20241218182834.22334-1-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver already assumes transitions will not take longer than
APPLE_DVFS_TRANSITION_TIMEOUT in apple_soc_cpufreq_set_target(), so it
makes little sense to set CPUFREQ_ETERNAL as the transition latency
when the transistion latency is not given by the opp-table.

Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 drivers/cpufreq/apple-soc-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/apple-soc-cpufreq.c b/drivers/cpufreq/apple-soc-cpufreq.c
index 94e57f055a5f..879ddec9e557 100644
--- a/drivers/cpufreq/apple-soc-cpufreq.c
+++ b/drivers/cpufreq/apple-soc-cpufreq.c
@@ -291,7 +291,7 @@ static int apple_soc_cpufreq_init(struct cpufreq_policy *policy)
 
 	transition_latency = dev_pm_opp_get_max_transition_latency(cpu_dev);
 	if (!transition_latency)
-		transition_latency = CPUFREQ_ETERNAL;
+		transition_latency = APPLE_DVFS_TRANSITION_TIMEOUT * NSEC_PER_USEC;
 
 	policy->cpuinfo.transition_latency = transition_latency;
 	policy->dvfs_possible_from_any_cpu = true;
-- 
2.47.1


