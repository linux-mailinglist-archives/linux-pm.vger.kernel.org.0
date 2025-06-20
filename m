Return-Path: <linux-pm+bounces-29153-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0424AE186B
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 12:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29DD51898D40
	for <lists+linux-pm@lfdr.de>; Fri, 20 Jun 2025 10:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57928284662;
	Fri, 20 Jun 2025 10:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3MWFsKl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6721FBEB9;
	Fri, 20 Jun 2025 10:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750413626; cv=none; b=jhH5lycAFB7eKSJgEpjovFsnGjuMxgyQoST4IywoRcKJJ7mb7ba7kFabT8bJdIPKcCQMzi1dD4fOgaguCt6V8tRkDf6x3rB3jH4d9b3TdKkRUKX0YJ3rPCBFmHPsbKLrqvPZyvFOJEVfKZvwhewIYXHuqbJzihrkgcIR1lH1Ek4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750413626; c=relaxed/simple;
	bh=olKXWgZQjhsUkuz2YNRyJhyf9whoZXlTfn3ASsScarA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=er72mKFquHahbbHc5/i4Y7bjuUo6jTZL2oTciFRu8i7iyFku4/CQfRiKp+ZUn0PgM+C39A0MbHRLVVbWOeGO0NhQHHYRxuqhipYEtNZvLTfyyF3J0VEJHDxaj3aedlEdu08m5Hl07HfeFGjILELYVlRgvxPRxwgimDm22ZIXj9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3MWFsKl; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7424ccbef4eso1188957b3a.2;
        Fri, 20 Jun 2025 03:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750413622; x=1751018422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m3/m6Ii9CNtXvzHeVzuWLYEX2B8FFoJZCUGYI3grWJM=;
        b=G3MWFsKlL2oGnQ5eYszfiWwzfkiG+DecwoIUb79Q9CDvdexONmV4PakVHmZCoaUdGE
         /Tjv3JrUOW6gzWkibUMUWtXrfLx6/TaDWxdUUaBFwWXWZtNB+XH26dn6J1fb8ifpqz05
         xfXAjviZLDPGtKK/jKzC8GAbM8iZ8nBKJ5TViS+GuNdoaKJDNqtXLR7V72xU5qPFe2l4
         99cgp5pmLvEut4a3LBDLOadnX3t/bgNFkkvs/XcRksga1Bz8suQCt6nKmVXTHPI6wOQr
         tgF7ANDcsWQ2TQFtKDS3vjBd9U6iycRsoJG770n0geFONeUs2SbdiTHLqVBBckpdULYB
         Zq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750413622; x=1751018422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m3/m6Ii9CNtXvzHeVzuWLYEX2B8FFoJZCUGYI3grWJM=;
        b=hDlklehS81qMOQ9galhypSS2rOk+Iz+fIuo3M2IRYPFJOvavZK9gKqgrKpTxvfacYW
         CaLkL16Tmynthj/zKm9e5q+NOLBFWHzD9k+2OGgRaKlmOmAsmE3pe/FNYls8GLzAEFkv
         ykZAw7FNNx6WwSeaRq2SNzxSV6MPASraaovv2N41Q0ZizmX56LUv86X3LAo2sss7k70j
         ht8Yp+Ol5sjMpv/1aDKfh1YrRk7xLHJfHqqAdG0HD64sgdG2uePvfaaL/OwBm2pglRvl
         Gtn16froDhXYELLMoawoMS1f2r1sas8VtGBhekABLypXA3ByaEtpJv7JLVJelUCc6bvJ
         x60Q==
X-Forwarded-Encrypted: i=1; AJvYcCVFIPuEuD5qBMwy9ED4wDK4uw6zY7at3wpIgcVZ0BAXcxP9+JlP1CK1X19w1P0JrUICpZN3jwEwR/hUZMs=@vger.kernel.org, AJvYcCXSrxhMWk2TnE23w/enEMpyyV7oVkvu99CHaoc30IVHTNYzG2t0btRbS3+tTw6zUczSAfdFAQykmk4=@vger.kernel.org, AJvYcCXijxDFMNcnsQcp/biHdMcMXT5JGqDenX9JFmpEv0OI8cFDDvqemLxM+MZcqXu3QxIdWqsPLSoExB4k2TPslAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAk7+/oIpvCLIQs3VqhaG4H3dgWDgawZpnYpSak+DvxUUxFyJA
	mJHj2iznlllVrUbgMONdfD16b4Y1+5JbbOa9RTwOtfWj/vv0/AKqUW8e
X-Gm-Gg: ASbGncvquFmLzhNpFAUMTuTZwpZKKWIE644AVvgwfydoFob3WUSg0vkeldmjSdfMbEi
	A2znOIOszBUy/eNbe72NJRCeTOnpfCqPcmFK8w1LqNjoaQIYPaun6Jai/cav3DLBrDgt6HBGlDc
	rBNzw8pd43U+8NUyD1U7xyHW6N8+mZjjj6DoNckDWBepGmOL39n0qzCghrboH1uJLUTfwTssmhC
	sT6DSIZG+TT+bblb9KY2JEW35qoBVhEaCW09T8qjetJQWTu6W5zT7ZRfPaKZo+c0YI0hx9Kq5vL
	FZ+JDY5HCO9OeE5LE3bJpOCheVTULqgTFtv9osLPr2Ma8ytpy63rUjkFkEGk
X-Google-Smtp-Source: AGHT+IEmqSX4AKlleCPKAgbXutcHO2f/Xpc08haGuQzz05YQ9otNxjDLec2RllEvNRSBiZPw0ATUDA==
X-Received: by 2002:a05:6a00:238c:b0:746:2a0b:3dc8 with SMTP id d2e1a72fcca58-7490dac586emr3067302b3a.17.1750413622064;
        Fri, 20 Jun 2025 03:00:22 -0700 (PDT)
Received: from pop-os.. ([103.21.124.79])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a4ac6b2sm1701768b3a.69.2025.06.20.03.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 03:00:21 -0700 (PDT)
From: Abhinav Ananthu <abhinav.ogl@gmail.com>
To: vireshk@kernel.org,
	nm@ti.com,
	sboyd@kernel.org
Cc: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	linux-pm@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abhinav Ananthu <abhinav.ogl@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] rust: opp: use c_* types via kernel prelude
Date: Fri, 20 Jun 2025 15:29:21 +0530
Message-Id: <20250620095920.20765-1-abhinav.ogl@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update OPP FFI callback signatures to use `c_int` from the `kernel::prelude`,
instead of accessing it via `kernel::ffi::c_int`.

Although these types are defined in a crate named `ffi`, they are re-exported
via the `kernel::prelude` and should be used from there. This aligns with the
Rust-for-Linux coding guidelines and ensures ABI correctness when interfacing
with C code.

Signed-off-by: Abhinav Ananthu <abhinav.ogl@gmail.com>
Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 rust/kernel/opp.rs | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
index a566fc3e7dcb..846583da9a2f 100644
--- a/rust/kernel/opp.rs
+++ b/rust/kernel/opp.rs
@@ -514,9 +514,9 @@ extern "C" fn config_clks(
         dev: *mut bindings::device,
         opp_table: *mut bindings::opp_table,
         opp: *mut bindings::dev_pm_opp,
-        _data: *mut kernel::ffi::c_void,
+        _data: *mut c_void,
         scaling_down: bool,
-    ) -> kernel::ffi::c_int {
+    ) -> c_int {
         from_result(|| {
             // SAFETY: 'dev' is guaranteed by the C code to be valid.
             let dev = unsafe { Device::get_device(dev) };
@@ -540,8 +540,8 @@ extern "C" fn config_regulators(
         old_opp: *mut bindings::dev_pm_opp,
         new_opp: *mut bindings::dev_pm_opp,
         regulators: *mut *mut bindings::regulator,
-        count: kernel::ffi::c_uint,
-    ) -> kernel::ffi::c_int {
+        count: c_uint,
+    ) -> c_int {
         from_result(|| {
             // SAFETY: 'dev' is guaranteed by the C code to be valid.
             let dev = unsafe { Device::get_device(dev) };
-- 
2.34.1


