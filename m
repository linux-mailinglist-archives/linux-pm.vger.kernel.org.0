Return-Path: <linux-pm+bounces-22695-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C2BA4017F
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 21:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 307E23ACAA5
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2025 20:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5E3253B61;
	Fri, 21 Feb 2025 20:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHrfXLzL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50F8228CBA;
	Fri, 21 Feb 2025 20:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740171417; cv=none; b=iykcksh/KWHtv1hQ+ALCuDGYytBO1Pi+rQDTUskBHEyi8onxnX2XAe0iO4mZ0rdg7CDhT5BTLGCUDD/rkSD7t0BjAyx2Qsiji5TRq4PT5lDHneC+YbdgHsjn2uIW92tI+tuLdIKPX759xIvKQfAQDV6xzuGgpmxvUSkSCUkgEtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740171417; c=relaxed/simple;
	bh=/7+cCF97LVI2LZ3uAXEdDIX21F0soxUVOoE6LZY7lpc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sAkZXI1+QZUi+O+q0itgAnJJUeADx3DJP8debLsEPZkv+0hBK5dRQpMe2FV9PCllAZMd+EIDLigU1jMUZblz0ic0D10yX/XXIgchNKFeYJFbRM5AbS6D2rZOpnypy4E5y9SEgFXPO5nUW/6cM9LOOh7tl6nMTqi9pPO8X/+HEbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHrfXLzL; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22114b800f7so50762975ad.2;
        Fri, 21 Feb 2025 12:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740171414; x=1740776214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8lhhVeH9X9OD7xrq+ml0fQUZEnU/MtBX4pCJFfiH3Y=;
        b=cHrfXLzLeCiBctYDt7eyGs+c255csl8Byl1cw2l3IXmxM7HP3DoEOJvjJeSLY2VBQ4
         JoASFiE2x73qBQYw55Ac+P6afwb7okYAr9Fh9bLTEC183YoFxOkJPKs1WN5158UBzbUG
         G7ORgjIOfPFWo4Ml7bsU5UFoElcjnj62cfiNxx56k0PgUT90DM0EGq8DnYhpU3HK33wK
         nYWw4iHGInGRiEfZmVNoikP2uqs6lD4FjrJ1bvkgX+NMuood3WBCjMZhj3OC1EVjf0/T
         3NLVvDTDtyZ7Ba6TJasiP8w4eGou15EkbHava4uRBEuRAiVL2dI77OifcqLosMAactUX
         8Ppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740171414; x=1740776214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z8lhhVeH9X9OD7xrq+ml0fQUZEnU/MtBX4pCJFfiH3Y=;
        b=SwrikKUV8dxhzluzC5b1YDYRfF+aqE7r77dNLuxtzLlG0Ovc1rLk1fvrx1r8PUh0Uk
         800Q9kWorefOiFHSor/RLjx13iBM+2PKia022WmsZArCR5DAodxIrXOq7S2+07f/oilG
         l4CKjCdSHRx8f4UhpaDatIq6q2p0hm1YN9H5naW1wHholPSjUAoZ+s6IKPby4P/9o/a2
         sOJsBO8LlHP6FNoc2PsDLslLXqCVmBdDqOGUeP8nljWOp8cFnY0h1Kw+e6paWSks79uV
         3n262/0+Q38iL9jSGxC5qhWp/t/mliJ4C4IVaG3n0Bq9OwFvZxos8HRj4vs6sJJXFzsm
         Z3hg==
X-Forwarded-Encrypted: i=1; AJvYcCU0J4qr/iIx9eCRHzCbZFvA5e3PveSepdfEVmYYkmc6QftdVn7HRUVq0YUgo50hmLHi0mXSSrXG3MmPSjA=@vger.kernel.org, AJvYcCV1/mM4sH5hoXaekLdCIK3SC6dpQ3jKPTeayX8eSK/a27bmUya+JPDaB4gqF78IG4FYnZ7AEVALvquUhHr/+TU=@vger.kernel.org, AJvYcCVzCsG03cjNS62IQ8FwPrhnbsNdzb1U6lYbkfqgIzpDVwiaSZHo6jjdGJf8Cahez+bpHoXJBNA2e7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEo8fZIzRmtplGa/CIHOj7ZU6hT6sukXIelaM3T8sraVv4Es62
	4WWSVCUX+p9Lq58co5Orzb28quDVjlwraH+g6R4EVgDt2mnBpvYY
X-Gm-Gg: ASbGncutOrMm++F71tLs6I9ZK6YF95N1ZNTGIKPNCkzISqKfgh1tGsTIf3jSkhpT7Ml
	z5L5LHro/VE3h0QNofDRbLmRLguLHwhd71veJ9eNGbMTqNu3KlDasHWbHj9wWsQZ2e4nL/yO7zh
	2n3jWCCUFcwx/WQK5SvViWj+91+Q97ynJ3ygziyyRu1JK/v52o/9xyesbVZbfpJd1ey2sM2Fcrq
	63LwjdI/I/wfc4nazlcwbvuv8jHX6i5GzbC09xe8wizXTBB+KRiKwlPiaQmH9bGEDzUUlfo691h
	En+sgipYEfyDfEi4kY2reQ5FMg==
X-Google-Smtp-Source: AGHT+IFRImKa4DoPyReOUvSXgQZq1X5x1z6dYzGTDKMLJGX3yWLR8EyKsJPywhTzWA46IVhMKnABsQ==
X-Received: by 2002:a17:903:32c2:b0:220:d078:eb28 with SMTP id d9443c01a7336-2219fff356dmr58787965ad.48.1740171413934;
        Fri, 21 Feb 2025 12:56:53 -0800 (PST)
Received: from localhost ([216.228.125.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5585220sm139846785ad.215.2025.02.21.12.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 12:56:53 -0800 (PST)
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
Subject: [PATCH 0/2] Bitmap bindings for rust
Date: Fri, 21 Feb 2025 15:56:36 -0500
Message-ID: <20250221205649.141305-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Viresh, Miguel, Danilo and everyone,

Please review the bindings and a new maintenance entry together with my
understanding of our way to collaborate. I tried to summarize the recent
discussions in patch 2. If you have any thoughts please let me know.

Thanks,
Yury

Viresh Kumar (1):
  rust: Add cpumask helpers

Yury Norov (1):
  bitmap: add rust bindings entry in MAINTAINERS

 MAINTAINERS                     |  5 +++++
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers/cpumask.c          | 40 +++++++++++++++++++++++++++++++++
 rust/helpers/helpers.c          |  1 +
 4 files changed, 47 insertions(+)
 create mode 100644 rust/helpers/cpumask.c

-- 
2.43.0


