Return-Path: <linux-pm+bounces-23859-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B100A5CA59
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 17:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE8F01886E1B
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 16:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E6E25FA32;
	Tue, 11 Mar 2025 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X/1gEMZP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A22225C715
	for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 16:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741709317; cv=none; b=F4JF3as3Kmdy9+YaUfC/tw90zU2hARySuNZN1V64M8S/+HXqNTjIf4BoiahV51emiC/W1V6YJsXA7s7QZPNZ02rKED25fmXTgcpbAJqtlypaTpeKL66PCDdpw3pduHWmQzZFC+83IORtW6xclSBGtKYNP7560M7GrBg2vGTIv1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741709317; c=relaxed/simple;
	bh=l0PCUhBXASLDRPE0V1mUAP8XYiUY2TDG0y8AdPdT3hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fw1l/hV2AtT1rUtqlyit1qPzUZUCFirevgf/9tO+Kt1Bvnk3SxeVw/8XjaOY9Q0hdxYvrNoaM/hbZi1pgj4XODWVTcddch6ytA1kNCHjzGKJ4lSCEOC7HmK2oLhbRi/AQbCF+Cn7hfWaoL9d8upniPyFap7XsEyXOBuY5IHHxA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X/1gEMZP; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30bfc8faef9so35930281fa.1
        for <linux-pm@vger.kernel.org>; Tue, 11 Mar 2025 09:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741709314; x=1742314114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5rCPhsAPbcHexhTKW956Un6CdUeaMwNbF4Qw3OxTxc=;
        b=X/1gEMZPy2gj3MDGVOg+pGqde63nzvwid6ousqgiHOZwKJ4eZ0XP6C/yd7QtepWuNt
         2nlCT1Uo9os5q4za+MJKcS9/TKOp1P+ZIrpPmy0OtebrCFzyyFz7NdhaJHgU7Mlajz21
         Lxs918+ovmtjBchlttZpCedBvAozplp8j8T9zmWQcrsn36WqS1IJky/C/PLv7kCRJtLQ
         /kzxGGp02bgLOEyeUH/o6DL6aY3LGL09WrLuZ+LtpHU9X1v8R+OYfywrf2ruWE0EtXls
         ZGoQS34nq4rlfs51L8IG4vFVGJUba/4KEU06NLfsEdWrcKu/3j6twsXkaWJbWm6TXyAk
         CaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741709314; x=1742314114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5rCPhsAPbcHexhTKW956Un6CdUeaMwNbF4Qw3OxTxc=;
        b=VFL1iS2gAQL6YaTC5HE1ZGMr4nlxZiEgEPt0n23Ivppn0w/4Wgl+wIhQjlwR2Ge9z/
         TO6AgGzXpPSUCrZ9W8nCBcEagkA+1d6ACJ/bL4tjolAoi9d5S4hITrheiDJA23GZgtlO
         Xmp8S5LrlkiTHQehpojPrkvTzBowflF0ps/E5ZOyRskVyfwvOCN5YZEvnaScW1YXbSP9
         +JkrvsUNsXVg8kVg4LjIxukV1xb1hHgzEoziocp9yBqTvJM+LICaruvnc7MVk6ZHfboK
         nAr1rFYjFrBGWq/AgGkNjmvzfiY/wXS4Vi0VLggESiB2UYlnzMjYHlC9xGNW9cdixTrt
         YimA==
X-Forwarded-Encrypted: i=1; AJvYcCUXqrLY8UczujlEN76oGNEkpgVZEmViNPkANwzs+YUeGaZcDrIB87HzUIKnhCFT3IG/ceQPTHOiZA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu4U+s1q+rNKmH6NppSHpfVD7fE9CBQQyFpZXmmPw9ulvtxDPs
	RkkHmFZgDULts66BNPzkP+ja6PlCdW87KiPjEjW8L6WZcFANaKQGPWLSIv3wfLA=
X-Gm-Gg: ASbGncu39GBnS54waNXW14pQUoO99e8ukOJalxC7G/qTR6NyCT4IPU5oVfZGkHgtLye
	YT0AAm4I81tfqcijmQNuE/UunO1pZkf01UaBmteVvVYFXCw7WAug2vyRvWISFhU7UZzLnxW7s38
	vu/XfacRh/GMunrVzRuUL5WvgVmX3i2pwJQF8e8K5aab1lDBuR08vHRsDrirjWuQvJC/kMwqG4o
	kMZjyI3/lXyRdirbd/ZFytG8Sd+/5pC4u+FIbDMKHIPB5vkZmrgBLB9NFDCldm9St3VlL5F9jDb
	pMPDa3STD9E4C9lDCyJbUClTE6b6/3O+IpUVJFbQq8zPpIGluXkvinu1co+LdCLf7aTF3jsrFKI
	gblJf9tQYTa+UuCVpwK4=
X-Google-Smtp-Source: AGHT+IH6xH3iIw5WZ9UvcU1KhACB9sxLwodKE2eiTaozFPA2Kckvhc5eL9CtKwpWSsZqvDw73UKNyg==
X-Received: by 2002:a2e:95ce:0:b0:30b:b9e4:13b0 with SMTP id 38308e7fff4ca-30bf4518301mr57630211fa.12.1741709313621;
        Tue, 11 Mar 2025 09:08:33 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30be9918c54sm20761671fa.62.2025.03.11.09.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 09:08:33 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] PM: s2idle: Drop redundant locks when entering s2idle
Date: Tue, 11 Mar 2025 17:08:22 +0100
Message-ID: <20250311160827.1129643-2-ulf.hansson@linaro.org>
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

The calls to cpus_read_lock|unlock() protects us from getting CPUS
hotplugged, while entering suspend-to-idle. However, when s2idle_enter() is
called we should be far beyond the point when CPUs may be hotplugged.
Let's therefore simplify the code and drop the use of the lock.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
 - Added a comment in the code.

---
 kernel/power/suspend.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 09f8397bae15..90fb06ca07d2 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -91,6 +91,8 @@ static void s2idle_enter(void)
 {
 	trace_suspend_resume(TPS("machine_suspend"), PM_SUSPEND_TO_IDLE, true);
 
+	/* CPUs can't be hotplugged here so let's not protect for it. */
+
 	raw_spin_lock_irq(&s2idle_lock);
 	if (pm_wakeup_pending())
 		goto out;
@@ -98,8 +100,6 @@ static void s2idle_enter(void)
 	s2idle_state = S2IDLE_STATE_ENTER;
 	raw_spin_unlock_irq(&s2idle_lock);
 
-	cpus_read_lock();
-
 	/* Push all the CPUs into the idle loop. */
 	wake_up_all_idle_cpus();
 	/* Make the current CPU wait so it can enter the idle loop too. */
@@ -112,8 +112,6 @@ static void s2idle_enter(void)
 	 */
 	wake_up_all_idle_cpus();
 
-	cpus_read_unlock();
-
 	raw_spin_lock_irq(&s2idle_lock);
 
  out:
-- 
2.43.0


