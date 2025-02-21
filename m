Return-Path: <linux-pm+bounces-22697-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DACA40182
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 21:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB2DB3BFFC5
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 20:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461DF254AF3;
	Fri, 21 Feb 2025 20:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2r87cw0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55A7253F3F;
	Fri, 21 Feb 2025 20:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740171423; cv=none; b=UGz+Ba8Rj1CGtXfGEem3jk2QW/2xyvzmeStAVNv3ms2q4wNY8xZj3q8N2C1reAFZns9edo2jW6VGH8zijH9AXfhJzMOfq9juD8BKgzl6wFGEpBthp6XHJgHMB0JRHRb8oSEcRCJt7UXEtyFaowSj8+nsFmwc55kaWGk4iso4oKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740171423; c=relaxed/simple;
	bh=nTEzKniELy6rtgcRJ1LhZSKCUPtCF3hVA2JfQRrQ8vY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b9ychtWbLoN1zz18rbeCaC5WVdeR2MmaNKIK9L8v89TdNVpUuBGTiIMqlZzilvcfjvJjgf1+VImyUv1aOllSFAZpVrIdkvwIRpFder7q0pUS+V3DIObSFNt3cOW990TIYm1fjVJE1VW7y8chZLo001ZP6Px+eMtrg22tW0lrTcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2r87cw0; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-220d39a5627so40889855ad.1;
        Fri, 21 Feb 2025 12:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740171421; x=1740776221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZEyBOXYSKxJgV366aF8y/N7qrlB7sKrMSi8tBbqHAU=;
        b=M2r87cw06V4JVBEeDQHsCgJcT65rm7u3BokOnnmBaWkEBsmIt9Csksb70sq/OlFZP2
         WjzmnIy1ObeMf88x99rq0QOZMxMD1Z1ba8ib8NGSKJppg0aw3x0u4giTnqlKvzYsq0XN
         O8vm8ynGgc9gCDr+iuu+a1rcGJ+uq9JotWI0+P0U2vQWabb43HFyKhpdso8HOJSnUjzg
         ehHjCnF/rYaVFf6/ye25IrVgNJioqUVKwiKBSxhjnyraaZDgn1cQIbiLOFAO8/DLSOOG
         BdrWIdEF7kbr9Ze/35Wao84UrFXDoxmEf5dlPKkKIJV+7jGQ1OhugMShpvP44pHIEb+W
         AMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740171421; x=1740776221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZEyBOXYSKxJgV366aF8y/N7qrlB7sKrMSi8tBbqHAU=;
        b=c59Km7mEl+/Oq/aBauF9+rXR9wJvYhbWOUcnHfRBXs1BD3+WsoDaFIE0L2Juc1zODX
         K7IUVwjBUArRqgPK/vAHFtlhak22r2BLhbqgjcqdy1Wyc8Gh9361bEbZTXilQ0G0Eo2y
         2A5Ys0ZSQxq7l5Rinv9sWCQ6oWR8t33cVxpRIfSvAblrbomqSsy1KWzgxL94lQCjd/U7
         HUxNTWBszkeNd/0oOShovCWejRV7I993zKLZwBUk0RTa0n0/GnxrVN7WKPolRB7a31I0
         L0tAUFzZHlnZ1lXxfXBxlfpQ62eOZdZi4xgFiUyI1Rx2pqRWiQCioJNPNHh1ZWZ9nsCI
         W1fw==
X-Forwarded-Encrypted: i=1; AJvYcCV/8a/8NmO8Ao1klBZPYVyw13H4Se7revVG6yQAiXryltAML3froH50uGe5+HKRWJu1wmZldgNz6uzjdz6ZAPU=@vger.kernel.org, AJvYcCWrjLh+Yn5APnUWvQcXZ+k8JlOtylEbOOykPrYmIj6nmYmVHVongebGDxNVF5atxQye+WJj2Pw5Ycxp8s0=@vger.kernel.org, AJvYcCXHb2Orh8u9nq0fUvUb73r/tAhNMFSaVWqH17ZvLn+Zcr7ZI0U0LCaCb65tzximtFne/WVbSVAI/xU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPCR6Bv/zGsetWgDFRJFGrPMdMtFYDcqwF2KjwPIeeK420GeKe
	ZSSLM0gEnVefes2yQJ34Lf9lw3v/c+vihje3r1KRE2GIcKbx6zAi
X-Gm-Gg: ASbGnct2zKhuGpbeG8D0qtX3CGLKKobmp6RBG9H7drCZcJNtBSFCg6397vwNHnNpS6L
	W9z1P5h66+g6BS7iPx+8gesrxLN0pMD3S7J6PJ+++6PzhGrJ15/VuY6EDUytoB3FYsZsFGZ+44Q
	am9pcgm21YbIbl337Yt5HO3SeuTJneX45pCgv8VzPNV44s5p5sS8N9zLIOSpWPvfnNKhe3wm9yE
	GqxZux391e2syBYM//8kZ+ceHjsTZvYSpxlcsdHCfEpjwk5+9lmwPSzXYHVtyb8/DBKFFaUpa9P
	I1d7PG33d0lVxip0EWzMc1ZthQ==
X-Google-Smtp-Source: AGHT+IHwQvbv49Sik8KAS69/deJ0jnLXJ55Ci1h7rLZBZxkmUIbJVFjCyz1a+o7IN07ICvKyQZtIAQ==
X-Received: by 2002:a05:6a21:38c:b0:1ee:ced0:f094 with SMTP id adf61e73a8af0-1eef3d5a938mr8505492637.33.1740171421024;
        Fri, 21 Feb 2025 12:57:01 -0800 (PST)
Received: from localhost ([216.228.125.130])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adb5a92c6d8sm14789233a12.65.2025.02.21.12.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 12:57:00 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Danilo Krummrich <dakr@redhat.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Erik Schilling <erik.schilling@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	linux-pm@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] MAINTAINERS: add rust bindings entry for bitmap API 
Date: Fri, 21 Feb 2025 15:56:38 -0500
Message-ID: <20250221205649.141305-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250221205649.141305-1-yury.norov@gmail.com>
References: <20250221205649.141305-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yury Norov [NVIDIA] <yury.norov@gmail.com>

This entry enumerates all bitmap and related APIs that rust requires
but cannot use directly (i.e. inlined functions and macros).

The "Rust kernel policy" (https://rust-for-linux.com/rust-kernel-policy)
document describes the special status of rust support:

  "Exceptionally, for Rust, a subsystem may allow to temporarily
   break Rust code."

Bitmap developers do their best to keep the API stable. When API or
user-visible behavior needs to be changed such that it breaks rust,
bitmap and rust developers collaborate as follows:
 - bitmap developers don't consider rust bindings as a blocker for the
   API change;
 - bindings maintainer (me) makes sure that kernel build doesn't break
   with CONFIG_RUST=y. This implies fixes in the binding layer, but not
   in the rust codebase;
 - rust developers adopt new version of API in their codebase and remove
   unused bindings timely.

CC: Danilo Krummrich <dakr@redhat.com>
CC: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
CC: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index efee40ea589f..4fb287405492 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4021,6 +4021,11 @@ F:	tools/include/vdso/bits.h
 F:	tools/lib/bitmap.c
 F:	tools/lib/find_bit.c
 
+BITMAP API BINDINGS [RUST]
+M:	Yury Norov <yury.norov@gmail.com>
+S:	Maintained
+F:	rust/helpers/cpumask.c
+
 BITOPS API
 M:	Yury Norov <yury.norov@gmail.com>
 R:	Rasmus Villemoes <linux@rasmusvillemoes.dk>
-- 
2.43.0


