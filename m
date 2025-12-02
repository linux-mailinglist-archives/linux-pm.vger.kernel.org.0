Return-Path: <linux-pm+bounces-39103-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C019C9CCBE
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 20:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 48EFB34AF72
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 19:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EFA2EA171;
	Tue,  2 Dec 2025 19:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z1AM+O7X"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2644B2EAB79
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 19:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764704285; cv=none; b=uGvzqyq4IlkZo/zPGOo4ExAhpvl7xRxAtv5U7S8VLbS2e65GLqVn/bVKVZBupyMy66jpRV3bWQsr6CuPZ+u+o6Nd3W6ZQGchUM+LnU+pB7ZSp01Ygx7KRBPulTveBHtKurMj3clWMDI0arTYYCkx39vMXSgbSsFwY2LxB89+KAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764704285; c=relaxed/simple;
	bh=/uRkXMMnQbHggezbPMDlJAAX7sbhCQ8KF+LNPrndfLE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kcgSgi9r+q9BRTC8twEhYQYVgloVncuwhN4LWIySpb00QbXh6R9/sDFd9KDaoiawNedE+YCcs6Wg5PfF4I2+YvdJXu6S6LI2DT3z3q0l1Fr4AneXJFwIdJtmcZDZ6c7Ccrsfpc16CKypEAczJYfFBsKXkkqKgHlhR0DH8RrMZtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z1AM+O7X; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-6416b2de86bso8779654a12.0
        for <linux-pm@vger.kernel.org>; Tue, 02 Dec 2025 11:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764704282; x=1765309082; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=54syvTsAoYC8sXnOsRu1oetBVSsGxpCbEliB3X2MzVM=;
        b=z1AM+O7XGonDp4xbrG89jUQyhdGSrdvFybl8/REMj03lsF0Al+bzGZGB8drj/+53z7
         kN7Jkbzur9hxIWzHQXRkU/IUMmBg7Zr/vujdPqvdOfjp1g50bZQM9fxK5gkoflB+gQar
         wnE20T+UgTUUFlqInraX8TNibfGw1nsjZwSQmfX7WpiiXSoi9t3LahFiPjafnvCT1sET
         7wXCPQFWjNptn5egy5yiIxr49WdmnBUpoDnMD0W5btkDnaGiytcK14suQiLY4sLGHMDU
         K2U7FAnZ5FjDejAGc2klMleAHe1h+L1Oav0o1iVFNMgMeQNojRAovAOE3oDS+5llpGTk
         OHAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764704282; x=1765309082;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=54syvTsAoYC8sXnOsRu1oetBVSsGxpCbEliB3X2MzVM=;
        b=gOrQCpOeg44P26y17WKb832rF2dkT8Dl9VRCMTp0wBnuIG2BYzdru4JCptPNbtFyKv
         giar9dG5ZlGsHMjqXJDppYmNQ1Z92zbjiXKQzrxJlnptIazxOm2ZgkcjorEY4WQVkYMX
         KNhx4OeG8QMiffrhID+Uasvkxcd6RwM3iktTsjpHo7gb6/8LFgWz1kfFabKm4xn67Ekw
         q57fUt2XZCq8E08itgYU45j0MxtWR7aWQjPS893QrE1w4PZ9m8WHts3qSaVnRBZZaPqU
         MNPW4+eeB5rqs6YHCKMnPaEHiQZa3NM+wekGiHnE5XaSKFbgNkxLaS+84vYE/NFgW+pm
         AF7A==
X-Forwarded-Encrypted: i=1; AJvYcCXz4GKRME73uDKw7CK6RSQYy42IgUP+oh04YJunYwIlbNX3UslJbYQ6BDc5i36wpjYbLHnSHwyZVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1ecwK+L51TkCPLpWz2A2rqx4DBSAOa/aJLnhNMTXZvavjcD10
	x0fSJNNmjMPufJVaj9tU+9a0UL8Ipr0QySILW0vgGMdACkzbvJQGdMm+9KSu8boUUQRmFH8osS0
	GdiNmyDJ8lglNL5pMKA==
X-Google-Smtp-Source: AGHT+IGJc3qMQV4Tiew7vJsG1JacIYJGPoxXANnYISLPrZ170ZFOcWUF9+xQRkP5vtmpknWxelIwF6l2qj4993k=
X-Received: from edaa24.prod.google.com ([2002:a05:6402:24d8:b0:641:8ee4:8ffa])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:2708:b0:646:6de:a09f with SMTP id 4fb4d7f45d1cf-64794f2b59dmr697109a12.2.1764704282535;
 Tue, 02 Dec 2025 11:38:02 -0800 (PST)
Date: Tue, 02 Dec 2025 19:37:35 +0000
In-Reply-To: <20251202-define-rust-helper-v1-0-a2e13cbc17a6@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202-define-rust-helper-v1-0-a2e13cbc17a6@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=873; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=/uRkXMMnQbHggezbPMDlJAAX7sbhCQ8KF+LNPrndfLE=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpL0AHjZMlnHHFMoh929di8EjUsCLjmEfSxg3tT
 2GhNI8gm7iJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaS9ABwAKCRAEWL7uWMY5
 Rj86D/45UKCvMffghxd1TOM9Kpgv7sTNWQRLKPICF/FwK/EUK0t9tCRyN8DOXECqh81J1HPWBLH
 fwy0VurRe2Uf2/N1tu8YV/B/rjJQ9bau7gz+JB/z/OYuqDM7vP/ZItEK+2mgxSEKkcoy26qyrsy
 9ts+t9ddjYnA3Nav79AkmodsJd/yRujVVzJ+qkOtujY25VTEa0vzm2aP0MF8Z1nsl7L+NFqsBRP
 /tfq0/CyWnPCEg4cYuJiJWHOJVoGUUcfPKTHnl75HfLngLBs8e88t4eMY8MCYz/gviTTYs2oQmd
 k9sC0j2uRjzfaZd0rq3iw8czk3Lzr3v/Sf+8E3E4btY4JhXZ3EuiDWCXrpuYO/flyUyIVG4nO90
 E/9QD0knl9DBegIUsUD7fHwQa7/M6NW3scA4khH+92YbjVo2rZo6LoEt8Eq1yh168NECZY0wpe8
 biJs4zuB2mZ49ZAvd+wFjOJXGYleBMK8hrbJJ3R48HGkpPRO0L0T3iH0BYMhWKCt63VJsJsVRX0
 9J/0+4h2EFSmY0CR8Yb0fOYzFZimBaTkhAFPVhgml+xxnbRLdSy+JqDC4b9zRd2qANDfH70F55A
 TCTRH+E1HLAoGhmkej8TNgNGMus0YvztTSZuMepiXDfdau3polP4u7y2z8xuwo8vrET8oeGIeG2 ilPM0gn4CQU1RcA==
X-Mailer: b4 0.14.2
Message-ID: <20251202-define-rust-helper-v1-11-a2e13cbc17a6@google.com>
Subject: [PATCH 11/46] rust: cpufreq: add __rust_helper to helpers
From: Alice Ryhl <aliceryhl@google.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

This is needed to inline these helpers into Rust code.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
---
 rust/helpers/cpufreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/rust/helpers/cpufreq.c b/rust/helpers/cpufreq.c
index 7c1343c4d65eaff6f62255b6c9a9a67f89af1541..0e16aeef2b5a696bf8974f37d9e5e3c24d999f40 100644
--- a/rust/helpers/cpufreq.c
+++ b/rust/helpers/cpufreq.c
@@ -3,7 +3,8 @@
 #include <linux/cpufreq.h>
 
 #ifdef CONFIG_CPU_FREQ
-void rust_helper_cpufreq_register_em_with_opp(struct cpufreq_policy *policy)
+__rust_helper void
+rust_helper_cpufreq_register_em_with_opp(struct cpufreq_policy *policy)
 {
 	cpufreq_register_em_with_opp(policy);
 }

-- 
2.52.0.158.g65b55ccf14-goog


