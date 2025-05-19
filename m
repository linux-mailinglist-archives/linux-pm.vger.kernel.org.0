Return-Path: <linux-pm+bounces-27302-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5842AABB5A2
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 09:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA8BA168879
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 07:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED372676C5;
	Mon, 19 May 2025 07:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l+YTjkwB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB25267B98
	for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 07:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747638476; cv=none; b=gDrgVZbgeDTGw32nEGXUBJX3LYGBZUwKIPUPfBGHBVooTh/NzIJltyNVyIc2nq5+VQuxVKb5sD1AD4Jw6VCWIuuIG9xyUJvGdhqgD8YsFKG6jZriuYubfEAISu075OyIRGjTAmd83oDhtIH9kvQy5wObuikzM+BeHnt5ZhDg68g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747638476; c=relaxed/simple;
	bh=pRm5rikPg836Cpaht6T2Bti6G/gsdEEiL/oreW2ehWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L5mZ/H8w9i1Xy1Ejn+qVDcev1CbWKKA8rMzeY98Sn2QiXlIFdRrjyJfNtr1Jf5a3b7zihzUaVx50QEqfzxPiuRcg2jA9bvcd1bHRhGjqaA88aL2Z3TGYGYKod5yN2+MUw3vFD+bLGzDxGAk1/mL6CkwtFyMQCAKH/pN1t9/Swwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l+YTjkwB; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso4549240a12.2
        for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 00:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747638474; x=1748243274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eaMUD1BDVL417dtmG3+/1YWJeUCWl78+KVSs+NX3TJI=;
        b=l+YTjkwBHgTH8v1w34B5fJiYaOKFe53M9ewGKfa4UJjZ0k2lPCEBBnbIfYCSZt/FD0
         SNRIYAbSqo+1wpXam+T4jvGZoAY6LhMQFHXwziespZte5KjJRGOFbOiRgZ1P0AHxh1nf
         m5/NqgSIqQlqKxdMxDAfsmhY8RV/JJ1DAvo5JmtLmffHUU0MD6xY51VnsI4kYsinWjiL
         cOqrUv3QAkIKFPP0hGlGiYvyYwSIYbgjdRZC/we3aLkAw81Z8sqEmRuyqOxBRxFlejdk
         3PKeKykFAEjDNLKF+gi6/GtuG6X5Zgsdxzbh+gxXjI+YtfO5xxV/DglU/fbI+II04ShC
         1Hlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747638474; x=1748243274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eaMUD1BDVL417dtmG3+/1YWJeUCWl78+KVSs+NX3TJI=;
        b=MFqSg2VFA8smhiZHqvsv+DkmAAx/hn/kCpMUyfGoXnlXCfEiSLFY0Y8q7TeNr6xLMQ
         RlN2jzebEFiHAqTqZ2S1kGSUduM5g9a36u+1WoJcQADO3jJxOVQRyyr/VEqteG0FgUX0
         fPRiMlEAHQNXkozoPRhILpqsgg0dnwMDdMrlsham1geXqA+5Gn8mZbMeIrUULEwp+oRv
         n9FPqjNz1DVJSs8vYuCQcVuq0URAJTGUpZseUJSUHQnKzNs4aWpiQswTReygD1ghqzKl
         aW6PZ6q1ykwpUGFkFFkTqPlGgK4EDi8z31zBACJffwTMaTMSWTzI2FQik3MvRqvhPTSl
         njLA==
X-Forwarded-Encrypted: i=1; AJvYcCV4nrj1r+dyT9UHps9p5vjC62awmp0FV+jpCZPRbH8cqgfhq++FWPPwpSswOWlVn+uGagjxPaUppg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCPxyVCgTf1jrj0jzBQP1WGcCryD2mPLqVWJFAft6DUIOPKz3N
	8objB1VGdEjtfhxaK8ycMNoPBO06bBaE+kIo3nmwVUQWFIDdHkcl3riROiBc+qLAhJ4=
X-Gm-Gg: ASbGncsKV8k3iKydC/h5IclxZbsrKqLYK+cZ0Jyqo2rLltr1NyCOK5E+C3x4WshiWDX
	h4cfH0yHBx5qQz8/g+NvcbUDvFrAaS1nG0YOLP88S9uSCokQydFmg+UH7PwHW4K1+oJPjKLvEVY
	4sgaAaxwCOqOEiV7BHaZ3wjsY72GRFNE5fgnYSZZ9TRzK7X35z+kH0prnrpQKERlZ9BCRRvoqqv
	VGXd8cD3/ApTy1HSrOSJDi7wMuhLPFAbSisnLDT93ZkYuNtdqVMuSgxEJhN2wXeE8Lf2NVSLyjw
	VwqsUe2JMWgYyQdKY5+QRXhW5inmqHxbJ+BrI3KZMtNXU/Awabl+
X-Google-Smtp-Source: AGHT+IF6hrADdyFBpfdMCMprB3NMgzCMsos6RN5vYSz8df1JQKxMeM5q1LLUUUmaKL61jlqJM0kYYw==
X-Received: by 2002:a17:902:e808:b0:22e:3eb9:471b with SMTP id d9443c01a7336-231de36ba47mr143813725ad.23.1747638473898;
        Mon, 19 May 2025 00:07:53 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4e988c3sm53200075ad.120.2025.05.19.00.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 00:07:53 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Yury Norov <yury.norov@gmail.com>,
	Burak Emir <bqe@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>,
	linux-clk@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Andrew Ballance <andrewjballance@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V12 03/15] MAINTAINERS: Add entry for Rust cpumask API
Date: Mon, 19 May 2025 12:37:08 +0530
Message-Id: <0bda169b2243ea571c7dc26a3362380a4b2c7840.1747634382.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1747634382.git.viresh.kumar@linaro.org>
References: <cover.1747634382.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the MAINTAINERS file to include the Rust abstractions for cpumask
API.

Yury has indicated that he does not wish to maintain the Rust code but
would like to be listed as a reviewer.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Yury Norov <yury.norov@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 96b827049501..bd7c54af4fd4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6237,6 +6237,12 @@ L:	linux-riscv@lists.infradead.org
 S:	Maintained
 F:	drivers/cpuidle/cpuidle-riscv-sbi.c
 
+CPUMASK API [RUST]
+M:	Viresh Kumar <viresh.kumar@linaro.org>
+R:	Yury Norov <yury.norov@gmail.com>
+S:	Maintained
+F:	rust/kernel/cpumask.rs
+
 CRAMFS FILESYSTEM
 M:	Nicolas Pitre <nico@fluxnic.net>
 S:	Maintained
-- 
2.31.1.272.g89b43f80a514


