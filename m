Return-Path: <linux-pm+bounces-43909-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBEpKOhbrGldpAEAu9opvQ
	(envelope-from <linux-pm+bounces-43909-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 07 Mar 2026 18:10:00 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CBE22CD6F
	for <lists+linux-pm@lfdr.de>; Sat, 07 Mar 2026 18:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B6023018BEB
	for <lists+linux-pm@lfdr.de>; Sat,  7 Mar 2026 17:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A091F334C39;
	Sat,  7 Mar 2026 17:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7eih2Oe"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBCE330D58;
	Sat,  7 Mar 2026 17:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772903388; cv=none; b=kL59fkAXs89RDXNzXZ0Zn2OE2uD8C/vc8NOrtOEB7Oa9WlR++/cSlbFI9V2d/k5aUSxJCxAe59HJbYUIfNiXQeXRzCZVoVqnHgMgTZA7Ubxse4S92ZXJljFR4wzQy+N+v217g3M+H0PrRodOO6JMPpznrfQf63uI5t1jJKZ1NhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772903388; c=relaxed/simple;
	bh=4IxBPKKn4evJJtdNJSN8E6aqj/2UG4QKdCiEcgJfsKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TvZTCX5pKcsZkFW+Ghu0X/5eGVYGHzuiwAB8TFHj+GmEbBjM1PJR9qPAsQOS67eEE1D+ryAE3n/V+CVEAATChkzq1GEDL3iIsZyRgd0NBbjiTsa7+bPBhX0/puYK3L4691xERJrPKYpjjWNt2lvRbuSPIwtOpFwUAF+9G22FGGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a7eih2Oe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB3EDC19422;
	Sat,  7 Mar 2026 17:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772903388;
	bh=4IxBPKKn4evJJtdNJSN8E6aqj/2UG4QKdCiEcgJfsKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a7eih2OeNA8aD5t7CYyIdfCBqsbluM+pMKH1e6DM2wuOIBl1BlQ0P4MIwPa5Ctw1k
	 f3ivvrFaGIj6D01oxXhGfap4FYXLkoA5Xs7vP/fBa7FSlzMSIJEbewR2X1gzzqYC3c
	 A5YHUlnoaTVwikS6RcCjrdyJGzLVQHgWU/UyZitpmL6QuVn3ECKDpI1o7Hafju3fF0
	 Naz/tnlIFymkk7zSZnKbSw3odKnwySbTcsOptVOqK2uf30/REChvd7rNTL/CzvsxI2
	 5aAGbIIZ0uVTmnxCDl0QKvUx1yvahoQ2X8EgBzAIylDT957y3JQVeSuqEDOYQy0ZWR
	 D539uM2LmijDg==
From: Miguel Ojeda <ojeda@kernel.org>
To: miguel.ojeda.sandonis@gmail.com
Cc: a.hindborg@kernel.org,
	aliceryhl@google.com,
	bjorn3_gh@protonmail.com,
	boqun@kernel.org,
	dakr@kernel.org,
	gary@garyguo.net,
	jhubbard@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	lossin@kernel.org,
	ojeda@kernel.org,
	rafael@kernel.org,
	rust-for-linux@vger.kernel.org,
	tmgross@umich.edu,
	viresh.kumar@linaro.org
Subject: [RFC PATCH] rust: kbuild: support global per-version flags
Date: Sat,  7 Mar 2026 18:09:29 +0100
Message-ID: <20260307170929.153892-1-ojeda@kernel.org>
In-Reply-To: <CANiq72mWdFU11GcCZRchzhy0Gi1QZShvZtyRkHV2O+WA2uTdVQ@mail.gmail.com>
References: <CANiq72mWdFU11GcCZRchzhy0Gi1QZShvZtyRkHV2O+WA2uTdVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 07CBE22CD6F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,google.com,protonmail.com,garyguo.net,nvidia.com,vger.kernel.org,umich.edu,linaro.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43909-lists,linux-pm=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ojeda@kernel.org,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_TWELVE(0.00)[16];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Sometimes it is useful to gate global Rust flags per compiler version.
For instance, we may want to disable a lint that has false positives in
a single version [1].

We already had helpers like `rustc-min-version` for that, which we use
elsewhere, but we cannot currently use them for `rust_common_flags`,
which contains the global flags for all Rust code (kernel and host),
because `rustc-min-version` depends on `CONFIG_RUSTC_VERSION`, which
does not exist when `rust_common_flags` is defined.

Thus, to support that, introduce `rust_common_flags_per_version`,
defined after the `include/config/auto.conf` inclusion (where
`CONFIG_RUSTC_VERSION` becomes available), and append it to
`rust_common_flags`, `KBUILD_HOSTRUSTFLAGS` and `KBUILD_RUSTFLAGS`.

An alternative is moving all those three down, but that would mean
separating them from the other `KBUILD_*` variables.

Link: https://lore.kernel.org/rust-for-linux/CANiq72mWdFU11GcCZRchzhy0Gi1QZShvZtyRkHV2O+WA2uTdVQ@mail.gmail.com/ [1]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
> Doing it globally for certain versions (i.e. `rust_common_flags`, not
> just `KBUILD_RUSTFLAGS`) requires a bit of reorganization,

If we wanted to go for a per-version global one, we we would need
something like this patch -- sending it here so that it gets archived
in case we need it.

 Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Makefile b/Makefile
index 2446085983f7..a49cddb0599b 100644
--- a/Makefile
+++ b/Makefile
@@ -833,6 +833,14 @@ endif # CONFIG_TRACEPOINTS

 export WARN_ON_UNUSED_TRACEPOINTS

+# Per-version Rust flags. These are like `rust_common_flags`, but may
+# depend on the Rust compiler version (e.g. using `rustc-min-version`).
+rust_common_flags_per_version :=
+
+rust_common_flags += $(rust_common_flags_per_version)
+KBUILD_HOSTRUSTFLAGS += $(rust_common_flags_per_version)
+KBUILD_RUSTFLAGS += $(rust_common_flags_per_version)
+
 include $(srctree)/arch/$(SRCARCH)/Makefile

 ifdef need-config

base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
--
2.53.0

