Return-Path: <linux-pm+bounces-30181-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2171AF9B94
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 22:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 616361C26099
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jul 2025 20:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0696323C507;
	Fri,  4 Jul 2025 20:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIdRfwjh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F7222FAC3;
	Fri,  4 Jul 2025 20:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751660167; cv=none; b=jDcLQj+Qstd2OAYAdcENydsUnJHbdi0W7gqMCVo3EhhdQO/SnipzDYWJUp0HL0oBatG1FGIvVdPqWsDRvbB7+UVzFsp6xvLkUQdW/gMjSPR3utelL9CmcYSKV4dK/VJ+YoEdG9hfZqljamRymPQc2FCJcSkRdXXfmGXO48yWcAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751660167; c=relaxed/simple;
	bh=mJsS2vyiaMWiPQwd7tQN5gQccE2lmw3c6g9maEbaKdQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cvVyMGySf59Rv4kSa2nmOFoPz0szosvZyVn4UGPNSZPxsUJsle4cLMZ/GWgaqtBY9BUa2D/jrdQjR3Om54zHdsGk7MxqvKziQNqCGnS/Dia0TS9IedVGpMcqaIiySpZNbhJHFE57BD5m3KRTUMKTFTyajUNxa6sS+yv8qod4nhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIdRfwjh; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7d5df741f71so82910285a.3;
        Fri, 04 Jul 2025 13:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751660165; x=1752264965; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a8gKMhK1P8kYlXeRydF9g6Ir5n6qoRzHtME7/jbZwh8=;
        b=HIdRfwjhpY9nQnxjgWjliRaByNHiSBC4tfqczWTOcaYl7lFbIuHVFs+waeAUctN83K
         ndOJJH7MpmSOe7Wf0pMT9c5sU5E+316h3w93JyS+aD4ekikZvErjPFkMEhNgaVfDdTyb
         opWnM9K5YSvsCXm0o8RNanO9+RXmG2Rn2dUQzrATifQ93De4YNzIyYFhZJgX4YZ89LTq
         3aoF+qL1K3QXLCjB42u9dx0sHaKH2TQ2TmZx6FznL2qFXW6EA3qZvYqMA+xR5KnHoK2N
         wcy2zr/TQAIJSzW5kKJLuy6Bwa4dIANPKNbfsfBym80D68063AUmOcEs6EYXmCLPqfUp
         3U9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751660165; x=1752264965;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a8gKMhK1P8kYlXeRydF9g6Ir5n6qoRzHtME7/jbZwh8=;
        b=a6dxoS7qGqG9Pry3pGI9goAISBnNzjMSmsABF/UMUy4vrR4ohknLBJtUC7aRb518ta
         AinIMaw5iMor/lTGLZ+kC5zUk+GCVEAI6YujrEliIqoAkyl1l2umLJPdrZSYHTzKOP1q
         sw8jXV+8gr/S+322qSgzJfg6WOqGIqfDrYsq+yDVxWnsHyW/lel8c4+XCRecQvNm8uw0
         iO9McFOwNCKdnqrov7i3WMX9tTnfwikGCCUZnjMwkoo81UJbswlXCrbldoJuGbyovrq8
         GpoNeWGJflHRuRVuya8Q1gQMCP07+ACgRgDFu+2SAMsl/4UTN+iLyxAjI66idOSIC04b
         5fZA==
X-Forwarded-Encrypted: i=1; AJvYcCUeRd4cd4s/TM8rihuKzb3wv3gYmq9fU56I8o0EgaRWiBlOW/w1SgFcVmsf75DfpvgGcaxPKPr7eBjR44M=@vger.kernel.org, AJvYcCWIHSVCoNT7cBsyU04YDEZXXTrhKsUCt8sAwibhRuT8gDxf9xZ3VyO26C7+hTnLhd6joY7gTsRJRXU+DwKO6hk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEuLuqOpw4O2i+uXBSGjXgtUni78xqMyJYKGH+ZQS+Ew8dcF/I
	HVvXWr3IpxzNXotVt6TbWJl67uRHDnU1WY5tY4a5e2HijAiLRC5H3jf8
X-Gm-Gg: ASbGncu5d9ga8t5enCEhlesFUlpOJvziDnpNVOMUCHYGjVmCey2UIE2a/J550HOu3UU
	VMOBMUiqc2XXJRZ6Dq/tAQn8Ig5af2NLLgQ3mebtE08CGUyhxAlgEK122qM2IQZi+sFI66A4lei
	bVkUVmhEptc8kkbx2DmV/fZZI5PEnCw0rWupiyDUrY40i91GX8z3poyBVw6fT+VCHoKu+vW+v4k
	QqEa5Dzx2QxvBugTaRfQ7imqMtqy8ft6b30V9pb8gNEzhx0iMGmmalbXLkw43TeI8VAcJma4Y4o
	p8vlvAmqWLM3ewK/CVg+PskkNAEb9R19soLHlDtWS+hiyJCgfBXWBF7V1GQ0wA641boIROHRA/j
	mlmCSoBk=
X-Google-Smtp-Source: AGHT+IF8p2jozIXmEQ2f+bxDZzizA3OOtjH7naor9ZhxgadHOKRJrT3ao5tXDNlKY8MPWMKo8J986Q==
X-Received: by 2002:a05:620a:370f:b0:7c5:4278:d15e with SMTP id af79cd13be357-7d5dcd0b203mr506984385a.33.1751660165283;
        Fri, 04 Jul 2025 13:16:05 -0700 (PDT)
Received: from 156.1.168.192.in-addr.arpa ([2600:4041:5c29:e400:94f3:d2bb:5ace:77a1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9949e5221sm19772941cf.2.2025.07.04.13.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 13:16:04 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 04 Jul 2025 16:14:53 -0400
Subject: [PATCH 2/6] rust: kernel: add `fmt` module
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-core-cstr-prepare-v1-2-a91524037783@gmail.com>
References: <20250704-core-cstr-prepare-v1-0-a91524037783@gmail.com>
In-Reply-To: <20250704-core-cstr-prepare-v1-0-a91524037783@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1751660160; l=1102;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=mJsS2vyiaMWiPQwd7tQN5gQccE2lmw3c6g9maEbaKdQ=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QG3gvXbICtoQcnka1UGwT4DQfnT07Ks8Lh3dK1e4qeI8hb+rSV4UlssrsjJhEtHgZyeSB31xbBA
 926txUPuxKgU=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

`kernel::fmt` is a facade over `core::fmt` that can be used downstream,
allowing future changes to the formatting machinery to be contained
within the kernel crate without downstream code needing to be modified.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/fmt.rs | 7 +++++++
 rust/kernel/lib.rs | 1 +
 2 files changed, 8 insertions(+)

diff --git a/rust/kernel/fmt.rs b/rust/kernel/fmt.rs
new file mode 100644
index 000000000000..0306e8388968
--- /dev/null
+++ b/rust/kernel/fmt.rs
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Formatting utilities.
+//!
+//! This module is intended to be used in place of `core::fmt` in kernel code.
+
+pub use core::fmt::{Arguments, Debug, Display, Error, Formatter, Result, Write};
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 6b4774b2b1c3..aadcfaa5c759 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -77,6 +77,7 @@
 pub mod faux;
 #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
 pub mod firmware;
+pub mod fmt;
 pub mod fs;
 pub mod init;
 pub mod io;

-- 
2.50.0


