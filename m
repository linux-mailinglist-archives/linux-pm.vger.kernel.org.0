Return-Path: <linux-pm+bounces-23560-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F1EA549CA
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 12:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0078C3B4CFD
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 11:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C17211A14;
	Thu,  6 Mar 2025 11:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YkzetN6C"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE492116F2
	for <linux-pm@vger.kernel.org>; Thu,  6 Mar 2025 11:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741260962; cv=none; b=NQMuu0HNlgkCRbWp3Uba98Pjl/uWyOuwcmCLk5dbGVklLd6MlUTC9FB+lzd4pVh+fKUiGr637/FpuFMRFaFtOZZiX1A2t5uxE/hrRscre9vwiLt1LEunfM38K1gP48jIhy46bWS6rXMJ00BNAn2snTwXv63uh9UGa2lLZwempak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741260962; c=relaxed/simple;
	bh=1MgOglgWeqZ5DURbA5C6RKUi3TqTKBpUJ1JubfsftK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MQx/wCiEtOR+PX7JlxmLeQqelLGwCOOqQr6KepLpz37cUqoC/v3Y2l+DrVxsnkGs+eGJCivK4sWWJJkkKE+IZNz8dZM8zHwhHyP1DzwIWfBEL4L1X1mfXzQ0omDc7GdZ0fuUnZRxeVkpjJwmKKKwMlRjwsc91ypoGNbu0VHzLpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YkzetN6C; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5498c742661so453863e87.1
        for <linux-pm@vger.kernel.org>; Thu, 06 Mar 2025 03:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741260959; x=1741865759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBMULT8xQriesWy7NboPFXpZgjpNODYYC6tAPexJTqE=;
        b=YkzetN6CboPJ4dopj6wI2crD5Y66E9XMdJ6hVj1naGREJIecEQX5hwg6Pe7zh0cR6P
         aUmPMFm4XfxXloZxqE3mkTg1p/suxeQe3HxA9Q5HVonWqyL+E01PtvxKcegZrbzLlr+0
         3/wNcMERvpt5oI+3x05oCAMxX7YcR5bRpbFv8a3tKmaLJLvuZXz9HPztoJd7cuFNJDvS
         ygMSjjtUv2R3mbIqPr7P82vIXVly4OdLzaOVNxCYDuYYHG8Kh79oD5V8gCm4XOaDFeXC
         qBDOqqYEFXbQJVd5iLaKcQyzoY5JnBBdnYzyQyaAGNw32lFCe+7mfKK4KGOBWRzCvZKu
         MwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741260959; x=1741865759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBMULT8xQriesWy7NboPFXpZgjpNODYYC6tAPexJTqE=;
        b=TvNfvj82Rwwvi8rwKoKo4T9kxvR1tX2osCT6ncbdYywGMQhplxDAxBobgz5nHkJGTY
         1nI+fHiQ4iGP9uakjEMlVWzLsREtpE/0GlGLmdVEthyeJFe3DPKjMrMFYzC/myFpH9d7
         a2oKx9OkL9UYLbro7UKb/75vaKaB3xFQo6DMRWx7d2gOLqFsuktUhHOj1F/r+tbIhsXM
         Xv0IE02weDVpl0LTff879wwLIYuR8IMjKUjZkpWj/54Lf+nzDHoend3tsMGuYAqWEVmx
         z4BNxxtziNNY1ZHUA3G1vsDdTpqZhoQvWi1c3McTmKaXXEPdWByklFIW9OLNCmsptyy6
         ZwAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7f4jyQGbklo/HB5N7YNYykfzS+u0lWPiQxizadN97mWUAiP9VRIMHs92ApqwqShInmf16ksEayQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFqv5qblFTtxUFO+q16x0bQkiVY5oLxih6pIydl1FQ486ZXJc7
	IHT6OI93K67PA7uWhWWSpOh8RvZs7/+saogC7084g3e/HHd7Hyd1jor+o44xLzY=
X-Gm-Gg: ASbGnctt+FmP0+KI6mhRgRxv911nX1eJQsFDCWaRcl0mr3qmTSvN/rjRnwjC3AA7Tyd
	DFyoPuGEv9C4QyC/Z/ttJgsSbk8uqqNL1Xc4DcAmpt3OvPBxkbsJY+F/Px8p2VZr70CjrOiq61k
	jB1iLtc6lEsAjE/6IhDloF26X3epszfRw+Vb/jzn0jTM7DWr36pvji05J0nuhtuSpHo8VJ0ovp1
	xrePFp7xdvHRBPV34MjgxL/JY43IS58GjhQR1zTlzYOwHUSYyJdsP8Df792SE4W0Xu5mRzYJHYQ
	X7+nW53LYnBKMghb2sH88Wbd0b0zyvsBAnpgjzU4TjuUpIpamn7dCKnEbXxb3xLWESI/PHxE770
	WAZDaJ8Guu0pd0ukUDXQ=
X-Google-Smtp-Source: AGHT+IH5ZdNyYNNrPJYlDdxxlS0p4Gdwo6WgrmWaFXoosE+Qc9huNH9ZZaWragkADaMW9/g7wB45KA==
X-Received: by 2002:a05:6512:ba3:b0:545:1d96:d702 with SMTP id 2adb3069b0e04-5497d380ca6mr2831393e87.48.1741260958643;
        Thu, 06 Mar 2025 03:35:58 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30be9918086sm1809511fa.54.2025.03.06.03.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 03:35:57 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] PM: s2idle: Drop redundant locks when entering s2idle
Date: Thu,  6 Mar 2025 12:35:40 +0100
Message-ID: <20250306113549.796524-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306113549.796524-1-ulf.hansson@linaro.org>
References: <20250306113549.796524-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The calls to cpus_read_lock|unlock() protects us from getting CPUS
hotplugged, while entering suspend-to-idle. However, when s2idle_enter() is
called we should be far beyond the point when CPUs may be hotplugged.
Let's therefore simplify the code and drop the use of the lock.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 kernel/power/suspend.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 09f8397bae15..e7aca4e40561 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -98,8 +98,6 @@ static void s2idle_enter(void)
 	s2idle_state = S2IDLE_STATE_ENTER;
 	raw_spin_unlock_irq(&s2idle_lock);
 
-	cpus_read_lock();
-
 	/* Push all the CPUs into the idle loop. */
 	wake_up_all_idle_cpus();
 	/* Make the current CPU wait so it can enter the idle loop too. */
@@ -112,8 +110,6 @@ static void s2idle_enter(void)
 	 */
 	wake_up_all_idle_cpus();
 
-	cpus_read_unlock();
-
 	raw_spin_lock_irq(&s2idle_lock);
 
  out:
-- 
2.43.0


