Return-Path: <linux-pm+bounces-20022-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A21DFA03D98
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 12:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D86616551C
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 11:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499D41F2C30;
	Tue,  7 Jan 2025 11:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f3mE8vAy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B621F2363
	for <linux-pm@vger.kernel.org>; Tue,  7 Jan 2025 11:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736248988; cv=none; b=EZCRbvGnIV/2Pv19pyLZxB99sAXxJKQ9r/bJoEYH8zuSixvy/UCSE1e2ylEW0uyzavoygEpru9vS5X5735TKiLUldpfqKVl5sWSYXxZ8wYiPTtXtfJr9PlcE3z09w4BfIJCmpelvpeuhF/hQTvsWqXWxJIOf1yqHUrJa/++zpec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736248988; c=relaxed/simple;
	bh=tFTJTbLEdeHvFXuVjX+TFVFRiMUYqNKqGsL8FVajwVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kPT3I2bEDTyEDlbtoVn40UWQiJ7jYwo1w8aWAO4y8UiQecw+Q6RN/f0GCzZ0ktnba8YCwfum7BapiM9XPr8vMR/rkhRnF+TiT9i/euK0qlxUVCk7ce7EjZJXfwE0uqhOONbcD4yCJ9/82uEBzWNMA3qVONC1Okwaf32iojV4azg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f3mE8vAy; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2164b662090so197393435ad.1
        for <linux-pm@vger.kernel.org>; Tue, 07 Jan 2025 03:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736248984; x=1736853784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H48pFuB51FzsnvAB5ojR6La/szgVG1aOsMJ1JHDym5o=;
        b=f3mE8vAy+HZKjkJslPqmhOO7vcdGEfVzCTuQtpItjxphs+YvieIlkenKkqL7eNay1j
         CQmSiia6QgFaln0iXi8YjPTMEk5ToOKuv55zsH7P82+qu2d/EcS0InH8AHzDEvNhjIvA
         5K0MT978SDGOxPZzLzfRN2fjiQV5LBxE6UMDlHhl85ov6EcGsfwbR1RdFIOOnBJKY/60
         l+/sim7XZvo43qdUVQU25UH4GrUMYmXsNsCqyJVwEA872y/QqbNuJxhwANDCUE1yvurH
         Zh9jc7CNK8qtiDFjmC2nC+UfJt1UhV2GIj1NtjHDSElkSGEzi6rVaNnXCnv6OpLd11uy
         oOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736248984; x=1736853784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H48pFuB51FzsnvAB5ojR6La/szgVG1aOsMJ1JHDym5o=;
        b=XSNhHIg7btW20f5vwRKY/BVglOe60WlFGOQ2i0NuI4xkvC4Rfz6uz0r3XYxmh1PwNz
         jUslBqrifSSJGojRaXilmKB+N6+3quLGcY7QlBXTqZFwwW9CXrR/hn7UdpL/3lENQMY3
         lLSGtPh5K0ZM866Wxos0fFSpVW2XpnQfO5rw5KZ+oPfshqT5zn+s+H8KJo2qSBbVfnGR
         hgEKEpWZ7wsUI92fWz6JmXDC61tSj1U2qCkRONPOGOOdyRH1OSJZeLkcmo7WGbPlK8Tg
         TrH5pObBQCbYqauY3JAvkxO9tSVxOILGJCB6+0sRNwKIPaGjRPxeBbgOeozvsj8nV3FA
         6J7Q==
X-Gm-Message-State: AOJu0YyRfaqjHyRDfTN1ecsj9cfQjytgx9pTRPf3sCNk0Ku1yi+vYF2s
	nK9rh4HWLniyO3ofA/3ATdNg6CXODHnFCYCMnfIAuNgf90w7VrnxWSEagyajBZg=
X-Gm-Gg: ASbGnctU+GJPFJWAyygv7mfBKyAEWeUrVH3SAXbBXpdObNUXY+Koy5iJen6MOtqrzQg
	i+4mXA6gN6nsOPmDA6uaOEVzEz1JWAuAY8kekrP9rx/O4EM7M25ZQBuzZ+F6di6lv3TR2F9N3/S
	W1X2Tiry2qY4rGfbNQlwd4BtU9H1rrE/B04nRhgNk7NUAGhq0YqYTuE4TV65ihD8wCs9KkMGYO+
	fxs1zFTR3Rbn5LwltIge/98RDvjIPfXvBf3g1BXgZ0s17BKLZH0/YYAaTw=
X-Google-Smtp-Source: AGHT+IE0VLVku8xsDJpwDp2mHFnWuLopMmkq2+92QaKH8cWC1XmAZlfGo1VglqLtglys6t3AAvvRhA==
X-Received: by 2002:a17:902:cf07:b0:216:5561:70d7 with SMTP id d9443c01a7336-219e6f2702fmr1031684115ad.52.1736248984121;
        Tue, 07 Jan 2025 03:23:04 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc96eb83sm309145025ad.97.2025.01.07.03.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 03:23:03 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
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
	Stephen Boyd <sboyd@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V6 15/15] DO-NOT_MERGE: cpufreq: Rename cpufreq-dt platdev
Date: Tue,  7 Jan 2025 16:51:48 +0530
Message-Id: <742d39ea8aa48790c2efbb79507e9d6255c82771.1736248242.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1736248242.git.viresh.kumar@linaro.org>
References: <cover.1736248242.git.viresh.kumar@linaro.org>
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
index 2a3e8bd317c9..e69ff11eccbc 100644
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


