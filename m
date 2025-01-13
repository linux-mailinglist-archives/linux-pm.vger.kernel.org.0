Return-Path: <linux-pm+bounces-20320-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B923A0B5A8
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 12:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7365F1643B1
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 11:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8517F22CF28;
	Mon, 13 Jan 2025 11:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dydf1gl3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D094F22CF16
	for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 11:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736767476; cv=none; b=cRjH+mcneT9Qt84W0B2Eufv8t9gyK/E8ZD+Ba/0LBbaoU5PBrw9nAKQL/p2u017IIAGJq173Tg/wUM/iB3ZvGD6XKmnt6ySGGSFT5YNHcdwZONYDxkOcfF52lpB63+hufw9AxPPgBpzw+w+ZIt6oNhcuav6BDfxGS1VhoSXPvzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736767476; c=relaxed/simple;
	bh=zAgcTK1vxHH9JbWsGAZBhQO4BNGHJbmi22K+j/HI9GM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kJPNBl43T9n0BkeSRRqZwFN9TyZcECzGson5fhoGWx4jOkBVqXmWqawJJN4l5sgaC2aeZOnkU773vmPYvZJFzhd5mq5AFFC9OyIkXy5q1ZOKkKDR5cvpk3fwFmchb5pPYU3xGtKqzx4s9GQmWJdqxGSSY3Jlo1RTnsrU27r6+6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dydf1gl3; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-216426b0865so70469905ad.0
        for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 03:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736767474; x=1737372274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/YD84rEPrBCk3G930SjRh7BJIiSlM7R2s5ncfP28y8=;
        b=Dydf1gl30EAg5pPV0nDgp+E71jVeAWKNseEBW6GRrLAhPiYcn3hjPfZSaSKsbzXb3i
         aFEm7cKioJI/XMZ3ZaHioDk28PHbSkRjfXteDIcNOnCUVdj9LG0sAuaRkI1HyJdBjtGD
         3jDDbC46Vfotceo38G3OCMbgV8Cf3iWEjxwfUB18KxKF7TlotmP3/SMf5NHR8ymjkZM6
         A5mivlqepVFUney8IZ99tptEjV9Yv35DK02vrRmMvezDRN76Lfis+q8Dii7MGt4omnze
         i21DGgmGJ/HqTWeFPUf0f1l8fVaMrZnv/LvK0htqJBbNRbmepOxrMUjedKtQ/Nmw0U2R
         PEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736767474; x=1737372274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/YD84rEPrBCk3G930SjRh7BJIiSlM7R2s5ncfP28y8=;
        b=Y9/4xU3zk1jSiY/lZATUr8y4OKuGkiXuTafXvbRflSZcF6Ttn8gxtoDfcOlxddAxk9
         jnA1HCmkudCAONWs5eU1nnBUCX7efsUdYpaJyE6lmDcz51/QbGhqGjPhgoXar9/5EIRd
         zhK4cRAnGXO/bn58vxJ+bwVbPla4UaQfPe6lXJQO4Bs1ZqdGgF1qSZTIGhVSKCy2+wPs
         pEmH4hsLwbaaMBGMqnObtyBSkS4P6ge6M/qBJruxwHH7ykJ8MwAUFS2VmFetiBBPzwjE
         nRBD2P0z0uoQUxrut9fwtQYdb0DoRK1Y5A9sM2gILsYYjFV5bhS6QhD2EhbnNBd1yrw/
         CVMA==
X-Gm-Message-State: AOJu0YwMGTgISiv57bFZc13jgOKsGHAvU3sCSToiP7YB8iZ+1qNo3j4D
	qyutNvnLED+1LXy2+WV9g8eYTm1Djn21pMXzrVBftFb85Frlr6mjXmxv8gQb7xkAimEGXGWnl7D
	z
X-Gm-Gg: ASbGnctDr20NeVjQGSwIsTHnf6+MRepQbIHjMqpLirUE/Po4uTI0sfe6IcmOR9XGhVY
	TSDXjScJRU+c07y2HvI4OzN1y2kg3gS7EmGVi3zfIhG23ItxhQVxLDCJw8RcDFSGLh8+ik2W9mp
	iokFwuCHQ/xGnT4EQZJsEe1dzlxoYYn65sylBKZywGx2+YmFTJVDn+uFywIU2ogzDqwbwgAfDoU
	J+aHzx9tn7/CyRHyamL0JDy1HdEpUDCFUKJLFfJ/C9Fgn9Dj3fHb7BFEao=
X-Google-Smtp-Source: AGHT+IELMOT0PbMKi+46Q87eT/Vfc0JWjP7to1bvIXbajUzFmNLB3hpaOQyToHivf7D0wpdCnj8xQg==
X-Received: by 2002:a17:902:f693:b0:215:a179:14d2 with SMTP id d9443c01a7336-21a84009d06mr276039425ad.50.1736767474223;
        Mon, 13 Jan 2025 03:24:34 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f155e00sm51658825ad.103.2025.01.13.03.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 03:24:33 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH V7 16/16] DO-NOT_MERGE: cpufreq: Rename cpufreq-dt platdev
Date: Mon, 13 Jan 2025 16:53:11 +0530
Message-Id: <5c93f6aaff0bcbc907d14d3a74ee5073fa135a07.1736766672.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1736766672.git.viresh.kumar@linaro.org>
References: <cover.1736766672.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The module! implementation in the Rust code expects a module name
without a '-' symbol, else it fails to compile with following errors:

error: expected one of `:`, `;`, or `=`, found `-`
   --> drivers/cpufreq/rcpufreq_dt.rs:247:1
    |
247 | / module_platform_driver! {
248 | |     type: CPUFreqDTDriver,
249 | |     name: "cpufreq-dt",
250 | |     author: "Viresh Kumar <viresh.kumar@linaro.org>",
251 | |     description: "Generic CPUFreq DT driver",
252 | |     license: "GPL v2",
253 | | }
    | |_^ expected one of `:`, `;`, or `=`
    |
    = note: this error originates in the macro `$crate::prelude::module` which comes from the expansion of the macro `module_platform_driver` (in Nightly builds, run with -Z macro-backtrace for more info)

This must be fixed properly in the Rust code instead. Not to be merged.

Not-Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 9c198bd4f7e9..263e1e97538d 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -230,7 +230,7 @@ static int __init cpufreq_dt_platdev_init(void)
 	return -ENODEV;
 
 create_pdev:
-	return PTR_ERR_OR_ZERO(platform_device_register_data(NULL, "cpufreq-dt",
+	return PTR_ERR_OR_ZERO(platform_device_register_data(NULL, "cpufreq_dt",
 			       -1, data,
 			       sizeof(struct cpufreq_dt_platform_data)));
 }
-- 
2.31.1.272.g89b43f80a514


