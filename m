Return-Path: <linux-pm+bounces-28300-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 716CFAD1BCD
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 12:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E7937A5A18
	for <lists+linux-pm@lfdr.de>; Mon,  9 Jun 2025 10:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23311253B64;
	Mon,  9 Jun 2025 10:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h+T0uPqL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838537E9
	for <linux-pm@vger.kernel.org>; Mon,  9 Jun 2025 10:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749466279; cv=none; b=GHuVFs6Z55bLas5G6LpKPv6GgXqgHAcbR4D3xXFczWfIfLKqTGk3/WOBZffCYMM/kiChoaaj9pIrx42OsgHedUn5mpFjIF2TRdbdA1jBDNGpFpWFcloSfQGi1vkdRUW6QYTh8/8GR6P6NpDODs5PEQkmuTtYUBxbp2A+fBTr98Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749466279; c=relaxed/simple;
	bh=WScOWAsVXiVAuzqdP7jM4l6xzCqSJWapHcMjtizWvzY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=M9m9B4dhUSEQXuy7ZnPdtQGpMF11P779//CrjBv9c4+fwTNs0A/yp0i8AygvlF1MmmI6urhsJwQppWHRmTbJNDEX6iMNn+gb1OfUKiEO477Z7TIQ8kkIc59pO715J5fwo9vOpGc8rWWJSYRG+eaPECQnuVcEWTtUVeWuBvw5aWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h+T0uPqL; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2345c60507bso28793645ad.0
        for <linux-pm@vger.kernel.org>; Mon, 09 Jun 2025 03:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749466277; x=1750071077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JZ5sG/zLHPPiUy0YK+tVjWFK+dG0iuLD9KI2Qcyjs+A=;
        b=h+T0uPqLLObp04iJLA8lZmi8USpfnRB1DJLEjUBU+x6sNuzk4v4tcGVXnOIJrvItxi
         +/bbIa0+cKrKbG5GwbiW4JCfDs3qSB6ojxyg4GTnZzTcVOA/8ebBdcNByIwzjFC5CMXj
         tk5sgUIj7dy7wcYtkNvklpO/PFw4mTNXz3tzflaRGs/q7wovPUqDLwnox58Ixs8hCAqI
         LMDpCRRw0DmzrWWUalhKE0bb9z+Bti31KweDnwoW9gwvcFkxzMfyJ7v6gX4plIsXWhVJ
         UwWIG9w/amE4l2CMQ+3jpDIXGIGNx2DSCAMMH2dhu6B0MxSnORyRiD/iL0/m8ZicCi3j
         fAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749466277; x=1750071077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JZ5sG/zLHPPiUy0YK+tVjWFK+dG0iuLD9KI2Qcyjs+A=;
        b=jFwN9cDQfuVY7iPg0S34/RIEDrMQgA78Kyj+D7OgQab9dWhEtHtKC0SLXnv30D1wxy
         tecgUSaT9AFQxlGURr6LqXos/b45Syw8PhqS+LlhtwZQoxhwhyEseu/Vn6dNgIdUCdRy
         SSXfap+cAOkjL6/V74qNprb3s2BcuRWZdChg4oSsFy/3CZxmstjhnzQa0jdbt+c7RO6W
         0PBxw8zCJ8gy3NCfTWWChPK6java+ROtb/lpnITEirJ9Be5pJJEWxNOTWAeiHdUbZU7T
         yMZwa6/HRuaA1JTFavcGpTjer1c4XUifiv0Z+HkTGf00UAkV7ONLfW5ww78oPsUTPSL3
         bY9w==
X-Forwarded-Encrypted: i=1; AJvYcCX0BdMd3u+pryN50iaqvUMAZNZyRc06t5Y+Y7t4EX9xiW6+mtQJ9zaOAuem/bvRLDskvQ+iQHDSqw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTotLOibZtY5+3Lhx7RQZtcHqsjiMn+MZFz8SNenKKLINdGIPm
	OqDY+KJ9TNxhzRHQpeK5YogW0Aa/JM9sSHkFUIuZIGKoY+xu4mBcrjRiqVhlliDf1es=
X-Gm-Gg: ASbGncvN390zZN+Ma8FM/NUPf4sF2jhRU+q60844U+NN8cDGMSs9yqNK5z5wtpwUqZE
	wiwiZMEJVqVUZmFuw7Uonm28geyRQAY5RY2ShsLMeae/pRBKHobZFela9KMPIB/IUQaeZD4+RLw
	morvOHQGvmQNhaSJ1CsvubTbRIjB3PdqjKgizIg5RHU4ytRaEZTb5bs/8bQD30HtSgu2mitsHYb
	XnsYVOh8UzbitoqOAaz0KTD3mhLowD6QhG8oGtDF0xwCZwSTNH40mdD31DeQRJqJhMXWPfjEZ86
	mRJwwm7gQLYj43X6Oywwv6m+lUK06GipQe6gWJ9YfoEfqTLylDIC5Pc4DPBkXY40+BpoecNBFg=
	=
X-Google-Smtp-Source: AGHT+IFPLhDJIesMz+ycULTruk9Mgl8DhhtXvrP8fol6pf7LI+WUMob69Spuj6lN+P05qfqT5WgR3w==
X-Received: by 2002:a17:902:dac5:b0:234:adce:3ece with SMTP id d9443c01a7336-23601cf69d6mr180738925ad.11.1749466276887;
        Mon, 09 Jun 2025 03:51:16 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603078d7bsm51827625ad.2.2025.06.09.03.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 03:51:16 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Boqun Feng <boqun.feng@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Benno Lossin <lossin@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	Miguel Ojeda <ojeda@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Trevor Gross <tmgross@umich.edu>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Yury Norov <yury.norov@gmail.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH V2 0/2] rust: Introduce CpuId and fix cpumask doctest
Date: Mon,  9 Jun 2025 16:21:04 +0530
Message-Id: <cover.1749463570.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

Here is another attempt at fixing the cpumask doctest. This series creates a new
abstraction `CpuId`, which is used to write a cleaner cpumask example which
doesn't fail in those corner cases.

--
Viresh

V1->V2:
- Introduce CpuId.
- Use CpuId in cpufreq, opp, cpumask abstractions.
- Fix cpumask example.

Viresh Kumar (2):
  rust: cpu: Introduce CpuId abstraction
  rust: Use CpuId in place of raw CPU numbers

 drivers/cpufreq/rcpufreq_dt.rs |   4 +-
 rust/kernel/cpu.rs             | 106 ++++++++++++++++++++++++++++++++-
 rust/kernel/cpufreq.rs         |  27 ++++++---
 rust/kernel/cpumask.rs         |  51 +++++++++++-----
 4 files changed, 161 insertions(+), 27 deletions(-)


base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
-- 
2.31.1.272.g89b43f80a514


