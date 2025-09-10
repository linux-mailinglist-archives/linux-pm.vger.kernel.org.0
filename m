Return-Path: <linux-pm+bounces-34397-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DFBB51EEA
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 19:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACB6D7BAC36
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 17:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1363277B8;
	Wed, 10 Sep 2025 17:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Lr42V2xt"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49D3EACD;
	Wed, 10 Sep 2025 17:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757525354; cv=pass; b=WwE6twAMB2gc71w88XAKGL98kskyEf4sBWIc/4rpHqjUiEB3/XGJjYOsYC58N6BzWGt/Y1cAqWw1597haTUbM+9lW/Kf1EC4YPQmKIChg9e7EdeoH1/jyLYfSUrGwimzR+WIBjtj2YeVBNF0valNVdk6g0HCwk4YcyFvlIgrGI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757525354; c=relaxed/simple;
	bh=3SXZejCfWVgYELeZNZ6tEH96Xgzru2GpfUTq6rBcDW4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nN8G+LDo425WaOb9isNGSV97yiWj0b4siCuSvOWwwPScu2IxERtU8o6OSVgYMFeCnFtYwLcoSX4gG4YhpIY4dSQBkv/0vooCa/tuJJMqbjMAII0awLlhgW2QBu7hG5fxs5YGqExIsnx10/A4pD0Sako49FeSFTM5/eEzVwjXk1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Lr42V2xt; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757525332; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UDON6ZwaIFwEQwBbfsjzK7HTqH7JhEcLzbBCpa2W7OITu52mJ+dqFl0IVIku8moRyf2hks+Zb+4mlB8P4UsRpMaq6vbQztkzDQ/0fsXfkb+YMlLCPlJ9M1wvcL+vYzBEqopvxTzwa9irwEBcpF9sCEdtCtH+W25z4z0FSbcguro=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757525332; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=k/PM9luG5Lz9YHA8zN2aF7NFM+1kFiTLyLGf1qeGQk0=; 
	b=EU0vtDbQmzlZQzDNNSZcDfzhHK6pGxIg92hFpW5GS7lRqKTN0p+9i9BxW050E3yfWWCRJGnWPEUPPHiPnqKRvVpDmxS7/3tTL//Z8FDp7HqISA7BpsWxKJqF+Cvkm+g4UBePfbJWJlBG6rk1qPAO4ko6Q4V/bJGZtU6Qg6TGuAY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757525332;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=k/PM9luG5Lz9YHA8zN2aF7NFM+1kFiTLyLGf1qeGQk0=;
	b=Lr42V2xtApk0mo7gArgO3wxVmOY36f73s1jlC28wY9qr/aFsSmdDMxsHrl6Dz2a5
	ngM16Ez/1HkjdiHAbylBozhj1zNh52J91wzB0iaunvUZ/YUodI1sZaRrAaUnU3bQy6H
	VjEW3nwPTiHy1FF/lpFGSydJhym8+e8nvov7xHb8=
Received: by mx.zohomail.com with SMTPS id 1757525330126752.3640853365222;
	Wed, 10 Sep 2025 10:28:50 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Subject: [PATCH v2 0/2] Clk improvements for 6.18
Date: Wed, 10 Sep 2025 14:28:26 -0300
Message-Id: <20250910-clk-type-state-v2-0-1b97c11bb631@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADq1wWgC/53OvQ6DIBSG4VsxzD0N0OBPJ++jcTjCsZKqGCCmx
 njvRZcO3Tq+w/fk21ggbymwe7YxT4sN1k0p5CVjusfpSWBNaia5VLziFejhBXGdCULESKC5QCy
 MUUoYlkazp86+T/DRpO68GyH2nvDLFPKHWQQIKKu8VbdS5F3R1toNA7bO41W78ZB7G6Lz6/l0k
 Yf/t9bs+/4BA3y5+/oAAAA=
X-Change-ID: 20250909-clk-type-state-c01aa7dd551d
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2
X-ZohoMailClient: External

This series contains a few improvements that will be soon needed by
drivers:

Patch 1 implements Send and Sync for Clocks, as a raw pointer precludes
the compiler from automatically implementing these traits. This will
lead to an otherwise unnecessary unsafe implementation of Send and Sync
for all drivers that use kernel::clk::Clk. It was included in this
series as it would otherwise conflict with patch 2.

Patch 2 implements the same typestate pattern that has been used
successfully for Regulators. This is needed because otherwise drivers
will be responsible for unpreparing and disabling clocks themselves and
ultimately handling the reference counts on their own. This is
undesirable. The patch automatically encodes this information using the
type system so that no misuse can occur.

---
Changes in v2:
- Added Alice's patch as patch 1, since it is a dependency.
- Added devm helpers (like we did for Regulator<T>)
- Fixed missing clk_put() call in Drop (Danilo)
- Fixed missing parenthesis and wrong docs (Viresh)
- Removed extra "dev" parameter from "shutdown" example (Danilo)
- Removed useless type annotation from example (Danilo)
- Link to v1: https://lore.kernel.org/rust-for-linux/20250729-clk-type-state-v1-1-896b53816f7b@collabora.com/#r

---
Alice Ryhl (1):
      rust: clk: implement Send and Sync

Daniel Almeida (1):
      rust: clk: use the type-state pattern

 drivers/cpufreq/rcpufreq_dt.rs |   2 +-
 rust/kernel/clk.rs             | 405 ++++++++++++++++++++++++++++-------------
 rust/kernel/cpufreq.rs         |   8 +-
 3 files changed, 283 insertions(+), 132 deletions(-)
---
base-commit: 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c
change-id: 20250909-clk-type-state-c01aa7dd551d

Best regards,
-- 
Daniel Almeida <daniel.almeida@collabora.com>


