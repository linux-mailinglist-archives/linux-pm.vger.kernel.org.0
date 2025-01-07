Return-Path: <linux-pm+bounces-20009-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD213A03D77
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 12:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C339F1653B6
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 11:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2711EE00F;
	Tue,  7 Jan 2025 11:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bdauNgYU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7059F1E1C02
	for <linux-pm@vger.kernel.org>; Tue,  7 Jan 2025 11:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736248940; cv=none; b=XYQnJzjvWqVNSoEdyzGb5enR2JEb9eJ1E2BiEJKRE6uxnZ9mMXsnwzt1jcj85W0mX46VPD7JVaHfr0mgFtHXjhsJpGQL2QbmqX+ZwEYYJw+LRMw3650NF63rhcb4UpmJECLJTDM1yueueZOe5oeZrI09bAQTHyc0eh1ZU4skApQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736248940; c=relaxed/simple;
	bh=cdokPHvwKyokV3hwBzmQO12SedZRDpfVgc8m4ctxbwI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AXMufTHQBLiwv2100j/IraOBw2B0rvaOGBsNxYgtEhe5NEr3NeDC107l4P87WhVzXskhHPO2blpWFp6eORXO4jW4yhlKl/q2IYPjjBEFaGzRJ0OtFRYDiR1cd0vWHZGxZZlcN498yrDygu9G/Qasgnz+YwHFHBYx8kcZeG86Trk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bdauNgYU; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2167141dfa1so220083725ad.1
        for <linux-pm@vger.kernel.org>; Tue, 07 Jan 2025 03:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736248936; x=1736853736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ASfdta/u0wkPRjfyeaLnqQ/klht5Qg5KYEOzmHA0l0=;
        b=bdauNgYUtEnFwVs/pYRQsY0TZ/w0BEq+U5fXKfgfVywTMfIaIOGag9FG7eAI036st+
         JDpqkqobj378Fnw80t2TO4Z3jXRT5tINzVf2CbLIr4a1ZRN+SQ2PxlGCuvm+XLt7rqqh
         bwihGIG8WSqPZqA2s1P/Qm/TcWiscM37TB1QOvdGzCYWPF1LB8KEgXHlTzuErw4niQye
         ESSbvbRT5NUAOTfh85rpoo3ldY4IdjZlmNO1zsMrMV7ZRFB3EI6wwu/NmjDMQrEd2B1h
         HhPg7BZM6NP89RpW8Kr6mfqITfK5qnx7c5KEg37xfO4exNMwCJSnF+kqT87tTPIXGuFw
         Z9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736248936; x=1736853736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ASfdta/u0wkPRjfyeaLnqQ/klht5Qg5KYEOzmHA0l0=;
        b=eIr2FaNvBN5PBV8HqkG1kS+uzbGh1R9+w7Zr6wjc7w3DVu+4yNSqQPYAo0RDX6jydv
         KqefAigDLZ1iJuWJNMj5ghyhxu684fFQ/aW83K2lzq0Vj2K6A1LDVETS5Xd/nJ9rVvEL
         5BE+qt/P0jxUKqhJpHcWCaQMTzgt/baHOzIXfLWLSoX7ybCRjog9RHg1vvP/JykWU2Ad
         fsn5MpjfJuKjKv1CsqzS6gfLpIv4zKYd3F5RK3mpQ44row0HduoCfBCkA7b0bOOiA4hI
         Zbu4xDki5O9PXR1rKLJyDpNEGX+/PyaYedb87QE4Dd4uP58vusC3pUCkRWvFZ+p3zTto
         7oIg==
X-Gm-Message-State: AOJu0YxSh4bLXh5lKOOWcS67ch7ucglP4Z7lDcpti0cgTMe/gQDeHR8j
	N2QNvYUhqXtYlO15NvwKteIQHYiatJCWUmC8wAWOe8ZYRqMtag5px65oBoBl0yM=
X-Gm-Gg: ASbGncu4BfFyHzg+F4lXuZ0ERUvWjm9qM3XVOKZBJ1vwCMtuQvvRwR1btGqoUGDu8GW
	c8eGz+nk2DUDwYAnPFaMEPAaYt9JXNOkFM/3EIVW0q/4kTDszJkJaU9W7klYg0FsxsyuoP3h6cX
	SP2OvT2VlPc0BkjOEDLHyW3IThWoGBLkWBlQxLMt0DfmFYPHhZvX5cN1YWEVXygIyk4gZ9TPhia
	r6iBpdziAwOBfGrJMUplAmt6qM7ZG5wSCUjDaXHrM5mrnTaUnCFWbLaFMw=
X-Google-Smtp-Source: AGHT+IEaWLMcL8bHxAFeukhJpYOpx8QL26UyBSGPga9CzNP9StwHzqf6lsQksJ+v3Nx6VNAD4SfyCg==
X-Received: by 2002:a17:902:d482:b0:216:1a59:5bbf with SMTP id d9443c01a7336-21a7a0be85emr36270175ad.0.1736248935755;
        Tue, 07 Jan 2025 03:22:15 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842aba72f7csm30274625a12.4.2025.01.07.03.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 03:22:15 -0800 (PST)
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
Subject: [PATCH V6 02/15] cpufreq: Add cpufreq_table_len()
Date: Tue,  7 Jan 2025 16:51:35 +0530
Message-Id: <867ba9728179ba21ff8f8aca97d416b72ccd63d9.1736248242.git.viresh.kumar@linaro.org>
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

Add a function to calculate number of entries in the cpufreq table. This
will be used by the Rust implementation.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/linux/cpufreq.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 7fe0981a7e46..6b882ff4dc24 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -783,6 +783,17 @@ bool cpufreq_boost_enabled(void);
 int cpufreq_enable_boost_support(void);
 bool policy_has_boost_freq(struct cpufreq_policy *policy);
 
+static inline unsigned int cpufreq_table_len(struct cpufreq_frequency_table *freq_table)
+{
+	struct cpufreq_frequency_table *pos;
+	unsigned int count = 0;
+
+	cpufreq_for_each_entry(pos, freq_table)
+		count++;
+
+	return count;
+}
+
 /* Find lowest freq at or above target in a table in ascending order */
 static inline int cpufreq_table_find_index_al(struct cpufreq_policy *policy,
 					      unsigned int target_freq,
-- 
2.31.1.272.g89b43f80a514


