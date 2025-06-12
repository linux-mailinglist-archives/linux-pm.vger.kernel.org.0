Return-Path: <linux-pm+bounces-28535-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C53D7AD6E19
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 12:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A16A2189B996
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 10:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B746E23E235;
	Thu, 12 Jun 2025 10:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnYAvcr5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA3523C8D5;
	Thu, 12 Jun 2025 10:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749724939; cv=none; b=GcXHvL6Pal9Z2qCaAUrlZZwY3nXFo0yPKyf9Hnyz8VI46ynkKHINShrBaTAY6XMxG2aCNpfbk7NBUfnNiajV6QLaaR2IjWfqMWOeFa9Hy/EMdax3KRXygCfzhyfYm54q2dVsmrYsYr9IFc7bf0Qz/nfwR5Bhh1O01qbKaPpGuDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749724939; c=relaxed/simple;
	bh=oFVhBP/YL0n9/tCf5ttdVuifzE71UiLOJVEiL84VSXw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b3kS1nrrj2zz58MfT/QHmgbgfp1QwiuBLdHtm97JgsHLr19oV08bzW+g+0thEGkXETC4+qlcAR5uNAttK6GW0r02DQI8wFHDeaYQCs1YNnUfc0+KjGpYibcJPjh99ryrQWwNtfnU7cVGsZmR/Ys+ZBVnGDHa6ue/x1CZLKLLQUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnYAvcr5; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-23649faf69fso7538135ad.0;
        Thu, 12 Jun 2025 03:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749724936; x=1750329736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GybQZWZoCD/mNp4Fv4oNQX2ZSbaSeKZ922lZ4/MEtpA=;
        b=OnYAvcr5Xf5dXA3uUW0Vg9SVoa9cVGBZPQstWPBGyyF5863OlXakqSOrcFDQ3Dt+Sl
         Atb7thj2KgHpg3TApuJ4A0U2RZuchIp06tgrd97ztMIZfm62/qRV+9zDA873Ua/7GGtX
         LcZ8wm8+I84qH2fHHFUPT88BwFDgte31+4JO+a33iWOTjv6Eirsa+KCeYx9O7P5gxtkJ
         57gE8DmD+hAXqhFr1OfLwPzRZYzvcVDAt4p5svwvOSyTkvMZv1D61eqM01jjRKGsYw6i
         zcyZ3vTjZjY8ugNTe9+Jc7lxlPi7wzScJKMtfv2Gi3BbDtDbVh2DncWoj5XGPVwMv3MR
         XQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749724936; x=1750329736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GybQZWZoCD/mNp4Fv4oNQX2ZSbaSeKZ922lZ4/MEtpA=;
        b=WCAj8PcoMEGicr7UuxCx+4CyPGy34IkdFLBHnqYOo2jkeft+5eR3Su/ktnPJEtRAiD
         n4etWJ9ORiZM1Z7KpMWSsupjALkcziRwbJwKG5yv4KLseUSlwY/2g4mgw+gqrdtBOJAW
         7AiiFARIv+i5T928CvKORPpvSRq1LqJ4hWnbHvRT9JN1NsJXiUQ2OzqRkItOcY7qIzMf
         UZQ7lpMFRAAfDmL0LjbFNl+N7/zyu39/TcDA7bzAU9u1nvd99eFzSryXoBTwN965Vz10
         gEdYsCgNurj94za3MW81sBsJ6xFRp47pI/t7niSpKwiejQ2A2FdnVjExaEV9lAvI5qkj
         A+jw==
X-Forwarded-Encrypted: i=1; AJvYcCUShPqibipuIZ+tnnhevPS2Tyu/7Yx5iOi81pyVdcCOavB8w2UGiMxwb9X24mRTEBjXANO1GqNyoI841Ok=@vger.kernel.org, AJvYcCWjkI3ef0EK3CZ6uSEB2sDipQm+GhK3RpV4n2jm3Leva6U1QOkPzACMR9+0RBC9X1wOrG5XbtRQ6Xk=@vger.kernel.org, AJvYcCXXy/3YlOkstsaf8HkitB0XDf0oPqm12ivaPuldBU/BZafH2FIRoo5xVeBmXpkpGwvhS+vCyHrWNVLLNT7Jtrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBrdq9C3cFCJu+QHylxwLsNITI1SlPSj0oI5mVfoewJvXxLe22
	5RGUz/5J2kQhpzacuptrNtW5jTx2qwoYXOqqtnqpx2Nu8j3mR5YVusbc
X-Gm-Gg: ASbGncu1efhdmNVZGb6vs99WoBPoIxrBE4chmqsSXdFa95zQW0Ik03j6D2M+w4NLsuv
	vrhmZJQVJ/oygyz/ZzoqACrD1P7sza1kF5D6VR1U3PQimmbUE/8h8zl597JwAvFywhxEHGUDnVD
	5WxsQ97knbDa78yDixQyQ59J+1DoFayL6eglb7XuVKeWjQ5aQMHjOfzNQWC56wVGU3hYnZertoy
	/q1SRCfdieVnDlpQ/rxqvcgvXb5hxrU12T4TsI0z+5UoIEGmtUKdV14lYP8cPkzmzE/vg74O4xR
	vSIAQ1/Y/z7VZwuzkhf+/uzMaz+vNoVC2Z4Nqacsy4v7VBcmNzEM9IkBK/iIXB2c
X-Google-Smtp-Source: AGHT+IH8ZWbq3NcYdfeleEGz9gzoJI5uvC922HCmGxSqEdvple5ZXtJJUZjzVkBZ/Vxr7g8UM1sPMA==
X-Received: by 2002:a17:903:1a0d:b0:22d:b243:2fee with SMTP id d9443c01a7336-2364d6603b7mr33758835ad.13.1749724936128;
        Thu, 12 Jun 2025 03:42:16 -0700 (PDT)
Received: from pop-os.. ([2401:4900:1c96:fdb4:2bbd:5e55:1c88:31fe])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e6d9bf4sm10781665ad.104.2025.06.12.03.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 03:42:15 -0700 (PDT)
From: Abhinav Ananthu <abhinav.ogl@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-pm@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abhinav Ananthu <abhinav.ogl@gmail.com>
Subject: [PATCH v2] rust : Update the bios_limit_callback to use the C FFI types #1170
Date: Thu, 12 Jun 2025 16:11:28 +0530
Message-Id: <20250612104127.10299-1-abhinav.ogl@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the `bios_limit_callback` function to use `c_int` and `c_uint` types,
which match the C ABI for the corresponding callback function. These types are
imported from the prelude.

This change ensures the Rust function signature exactly matches its expected
C counterpart, avoiding potential issues with type mismatches in the FFI
boundary.

Reported-by: Miguel Ojeda <ojeda@kernel.org>
Closes: https://lore.kernel.org/rust-for-linux/CANiq72=WpuGELzLbH-fxdOeJy9fiDFwatz6ynERDh=HP2z2MBw@mail.gmail.com/.
Signed-off-by: Abhinav Ananthu <abhinav.ogl@gmail.com>
---

 rust/kernel/cpufreq.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index b0a9c6182aec..e97607ed86c2 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -1277,7 +1277,7 @@ extern "C" fn update_limits_callback(ptr: *mut bindings::cpufreq_policy) {
     /// Driver's `bios_limit` callback.
     ///
     /// SAFETY: Called from C. Inputs must be valid pointers.
-    extern "C" fn bios_limit_callback(cpu: i32, limit: *mut u32) -> kernel::ffi::c_int {
+    extern "C" fn bios_limit_callback(cpu: c_int, limit: *mut c_uint) -> c_int {
         from_result(|| {
             let mut policy = PolicyCpu::from_cpu(cpu as u32)?;
 
-- 
2.34.1


