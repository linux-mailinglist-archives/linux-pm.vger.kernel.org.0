Return-Path: <linux-pm+bounces-20308-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE8DA0B566
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 12:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EA5C7A326E
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 11:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F66723A589;
	Mon, 13 Jan 2025 11:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="whRU9Cfj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D03B23A570
	for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 11:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736767430; cv=none; b=IoGa1nFpL62bHZSSc6BoTgBn5oRVKjo4QFUA5yk4wd0FczsA7t4X4QBm4rpxuPjRd5WSddO3udOsQAIzoBjracZq6uQCHDwhl8M6epAkY5VDa4t7q3Xpw18ruNwb06gLktKM7t7Hk0H1LrFkRkyzPM3bsOIB0ifxlB/T/BHN3cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736767430; c=relaxed/simple;
	bh=qFjzLah+7k0bGLsf807G16R7Nl932aHbCVEztV18Qug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bf+ICI/5akCYNSQ3FHXCGivkoYrfLOMn7D+ceRtFgXm4pWFQlnHTouDIpcBwNNklG+fSJdIQk9xmyeYqe6pNXnng18CnaFnstiscpN4t6LXq3/gqQBmCW7MdSI0nQJKVXw1uJx504OzLwpYyeLv1z0xgOao5rxIyjakspRZyEB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=whRU9Cfj; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2166651f752so90387725ad.3
        for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2025 03:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736767427; x=1737372227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Erl89OKGaS5TERvIe2o6tMzhWrw69h3Z1JOwTaxOJAQ=;
        b=whRU9CfjTnHWSyizQVtwhP59wdi9PnmXTxU0lGYVZ2iGN3hA10ZihH+eLtxU9PG1XH
         IH5HRO/Fi4Txp9Kv061J8jDSGnWBFnTnupIRUaxNaOIrUe3hDVa3pHCoKSoWlpOD+BYK
         5taBS0fy3OpCTJ1BuhRd2GhQQDuX6X23Yaqa3XetPkLqrFIhCq3VVb0KCh6MrRJN65wx
         Q9J+IQY4lMrR8fD+lF/i2k7G8oeoiNhe3DxFfDQQwmWZoIgKGcdjEzrudnUfKB6qq2pN
         NbPg32wBec267vXW7RKS2id8FCkzgr9rSML4d55Fzs3T+dGCieQ5wN+OsuCtisjzkxrY
         1/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736767427; x=1737372227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Erl89OKGaS5TERvIe2o6tMzhWrw69h3Z1JOwTaxOJAQ=;
        b=Ok9bTXdZp3zqUDBWZxsnTKX06pCYz2dcJj2uJzz6KACm57RQw5NVEZUJiZ6Vhwdrqv
         UEl524wG1e11LDJuDwc5hjHuEsZtqZETK5dqN8kGinYOzF4fJDPHk9O+Dg8S7Fl6Y2z5
         0yHONiMpbmH6R9iyFf3OUtlnialR2z76uIM+puy4hU1rhGZGq1pw1UK5AmDqt1VgWbVC
         bFCgnHfLaDroW1OxWKNLjIKrUit+2iXwqDXEXjZPSUcJvdBYetOqUKzwprCxxs6FXdMJ
         g+XvHMRSuVH4D4WhH68CGSXMi5RD7G6/QQ1O3kwn/1hAArzPLVuNQHCXHSqXbrewDHPp
         J59g==
X-Forwarded-Encrypted: i=1; AJvYcCV5YYrFA8tntPOu/LAaU0DJDum/X+c0Gl4HKKbyQjRW1nasq8C+Mgsdyxe0ribFt15vVDsSerAL8w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxneP+9iHB9ZIr4epqtFhm8e0nHbg6UCHDrSyZgHjCPsraLmeRy
	S/NDsaoMjq+GjcBbNyKU2G+KSYVqwt4TnSEW6ruMSu1dy+LmPfZtCI3fcmBRpPU=
X-Gm-Gg: ASbGncuFy9N0Mu4VRiK7SwsPSOKUffE0CzmpDszLLgvk5mKFV/voDjW8zMoiYB7P23n
	fhTtqs1QJx3dDiO4EjtmNGfaD0bD7s688PBvfwqjSO8eBIKe3vEmuBG4x9KyYxxVKu4Zmwlt8ea
	EG+Zh0hpC9k8T5KKMZz4EiZ7ExdRSo14cVX9hDa3zTJhahjDHZkAq1AfVdvfQD+7eH1mkAjO8QY
	S4fXUEi0EHiFty5s/IVXdRRQYuo60amphGYnFqFYXIiRzn7GHSfbOEBtVQ=
X-Google-Smtp-Source: AGHT+IFwnNOadRELhgUS4RHnfHmljCOFqvDn5NHiGTae6Lam/bomtLxFMSA+qHltYXwddKyNK29zYg==
X-Received: by 2002:a17:902:d2d0:b0:216:45b9:439b with SMTP id d9443c01a7336-21a8400a357mr316419915ad.50.1736767427451;
        Mon, 13 Jan 2025 03:23:47 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f10dddfsm52432345ad.23.2025.01.13.03.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 03:23:47 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V7 04/16] rust: device: Add property_present()
Date: Mon, 13 Jan 2025 16:52:59 +0530
Message-Id: <f43fe3f7b3151a89c261ad728b0f3bb2fc24caef.1736766672.git.viresh.kumar@linaro.org>
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

This implements Device::property_present(), which calls C APIs
device_property_present() helper.

The new helper will be used by Rust based cpufreq drivers.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 rust/bindings/bindings_helper.h | 1 +
 rust/kernel/device.rs           | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index d63e7f6d10ea..fda1e0d8f376 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -27,6 +27,7 @@
 #include <linux/pid_namespace.h>
 #include <linux/platform_device.h>
 #include <linux/poll.h>
+#include <linux/property.h>
 #include <linux/refcount.h>
 #include <linux/sched.h>
 #include <linux/security.h>
diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index d5e6a19ff6b7..e8c4cda5aacc 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -6,6 +6,7 @@
 
 use crate::{
     bindings,
+    str::CString,
     types::{ARef, Opaque},
 };
 use core::{fmt, ptr};
@@ -180,6 +181,12 @@ unsafe fn printk(&self, klevel: &[u8], msg: fmt::Arguments<'_>) {
             )
         };
     }
+
+    /// Checks if property is present or not.
+    pub fn property_present(&self, name: &CString) -> bool {
+        // SAFETY: By the invariant of `CString`, `name` is null-terminated.
+        unsafe { bindings::device_property_present(self.as_raw().cast_const(), name.as_ptr() as *const _) }
+    }
 }
 
 // SAFETY: Instances of `Device` are always reference-counted.
-- 
2.31.1.272.g89b43f80a514


