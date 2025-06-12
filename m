Return-Path: <linux-pm+bounces-28536-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A01AD6E17
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 12:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AE2C1716EC
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 10:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A410B23ABB2;
	Thu, 12 Jun 2025 10:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+J34uwg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0BA2309B2;
	Thu, 12 Jun 2025 10:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749724993; cv=none; b=K3/DG8bCFnSes0ba6eh1duLyuWJiuSHem/obXVjtJ4WSo4QeQNemMEI2KCQnRsiBlbbg888VhdG80PiwPbyzACAcFc1XupzNWy1ZCsf2PlLQaH+WV/Gj43rlxtmFvjyeJ75XdXCyyzZt/l5GYgYxvjqr7p/OEKXAdx9FNtIvgQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749724993; c=relaxed/simple;
	bh=oFVhBP/YL0n9/tCf5ttdVuifzE71UiLOJVEiL84VSXw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YWlrQi5QkYg1iIm40qNG/ujes1VhU15jZbiYbHKBpTCNCmb6OHm1ALbhl7eAC7NOdV/HIGQIY+5/+8qhoOKF7LDOHX6XXBrWUDwDd3bsGKW8s/58qnM4BY6XJtgy4l9G3WM6MCAVhYKEk6psNx4S21infQ0wzD1UodhmuqtQ4BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+J34uwg; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-311e2cc157bso728189a91.2;
        Thu, 12 Jun 2025 03:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749724991; x=1750329791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GybQZWZoCD/mNp4Fv4oNQX2ZSbaSeKZ922lZ4/MEtpA=;
        b=A+J34uwgZHgcittbfFdE7DZsSog8nzLMzAzqsf1I0eLPwD4hAgyAF2RBGQcj+o48F8
         PgPZZnnKmZX+K1pn3W4LBlEYEp2N6C+1nhOMf69cYPh3Sj4mnsgpOTY7YyxzGrogPmCO
         SAi+xxCeWoj+IHIVmWuXJc47fN98IMhiw/RIjcZrxyn4e9E4HK8ixLzLseWlyQdDHmYi
         HnmGYE3XtrCQqq8Vj+MYRfA+vf7vNT+17P/GCoYhNuqZuc1cTkNgnus8mhd89dLeRKpn
         eSyw7P7WTZF39z0F6iyyhqkRcZ+0loEaeacvCbY1zHZOEEyVpsmC/05Lv+gx/dF81Yp7
         Vgrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749724991; x=1750329791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GybQZWZoCD/mNp4Fv4oNQX2ZSbaSeKZ922lZ4/MEtpA=;
        b=vGe0qB7FZq7yjuJdU1Bz6goJZ8cMmTQh7mppmfmHx6vgVHweylxyO4kutqbl8DT4/S
         RBuntyq15jMZTvVBmo9Pvvtvl6Mj5Avk+p+Wcets+9JpNZuStw6k0P0NxdPHAKBNTMB9
         n8Zms4c3uYmQ+f2SgvO1xOC0UXZhacQtHEPrr2mY4iHvulmCOclyMKqQT0veX0SgZTAG
         KWPb7nIlNkr63I/7/lwes24QSO/A+pXFuJKK/xUq66ouFeM4CCHAMrn4tqpUYhS2Jc7z
         Z5ZixXczM5iTwsn/Qp8Af4g4kYjrH7SnRkJNQ/snHvFXfW3vG9fe3jk5XGMPT0bMitSr
         4nJQ==
X-Forwarded-Encrypted: i=1; AJvYcCU12cvz+TiAZbjqMvsoagTgFXsVq9niAsvOc3P6EUhwrifsQoaAhzlx9C6uQRF05JeDMHgdJRD9c1DN3Mw=@vger.kernel.org, AJvYcCVaO5PCnw1C5aOXsuVHa3XMBwex9tqNYjyp9sUHem3VQxjdW0nw6FMX8maw+RlBEqTT3k6ONB6srWU=@vger.kernel.org, AJvYcCXHCnPcRmw8m+v94MkuD+QdVOMFVfSjM6moLgWCmgapDGYEFI+nJsrmSl0Vj9dgflOuINLevDayYS8qBcBc2Kw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhoXGIdVTJWiENT1+Q1sqP54QUqmAGFxLzBOWfOVJE+GLlo7h/
	PfBtI4wVrnPBx7B8a5vPZYQFP15fNZkxVAXkz6RN8gfXqE4oRQb1NUKm
X-Gm-Gg: ASbGncucQPvGK1EEGjIfp2a9eauiv9lJ+hPjM5rugaMBNsUeFR6pB+c7odEvzl6nd/O
	mrLWcdd+UHjAZ3ESXdUMePD3S4Fw63OlIOowMnL9H3bPlrxa8VyOp94PRWn9cYRKRr/UiV/g4IE
	lVKg+WqW+ERDEbsse2BngVy2N8zabq1vIjlpyqAocfTtMGq2t8I/9mheA9fumTpuKmd8H3DJfbq
	snKMQFQnsOfsHiwcLq+SOpWXY4T56SU+aX7YJocIAluxhO/EOa+Imi0lptPRv0bbOIVQyZK0HnL
	vr8vsPDJ33+cbYCE74t5IgcM+8aEWLpwf/SMqZ6532DpjaHwerCzSM+gCvrCIC0=
X-Google-Smtp-Source: AGHT+IHg6+K7/369twPwnEdgKacxEtzlOuGqebE0nmlGI4VEfrZdZBBOEN5QKHZebNc+OnOs5jDsrQ==
X-Received: by 2002:a17:90b:1c83:b0:311:b0d3:865 with SMTP id 98e67ed59e1d1-313af225286mr8056711a91.32.1749724991238;
        Thu, 12 Jun 2025 03:43:11 -0700 (PDT)
Received: from pop-os.. ([2401:4900:1c96:fdb4:2bbd:5e55:1c88:31fe])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c19cd5a6sm1148873a91.12.2025.06.12.03.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 03:43:10 -0700 (PDT)
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
Date: Thu, 12 Jun 2025 16:12:53 +0530
Message-Id: <20250612104253.10413-1-abhinav.ogl@gmail.com>
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


