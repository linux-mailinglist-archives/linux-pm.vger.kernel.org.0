Return-Path: <linux-pm+bounces-42500-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AS5DPl2jGk6ogAAu9opvQ
	(envelope-from <linux-pm+bounces-42500-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 13:32:57 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5DA1244C7
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 13:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C2383019197
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 12:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D11194AD7;
	Wed, 11 Feb 2026 12:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CR/9dh3/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EA0219FC;
	Wed, 11 Feb 2026 12:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770813106; cv=none; b=c4VcQXlftNzKpUQkBf6ZWoftUCjopv9QR857EmDtfQS4IQwLLvkbxqIEPfGwxAMvZ978WFGEzDXwO1oCwHFGmBBISCfGso+2AIslpC9a5eHM23nEMSwtjLdMqt1Hk9BnJW6wmaDyIhvcPQv6LW57qORSKMiV+GyU0aUtCdy7oCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770813106; c=relaxed/simple;
	bh=ENlGDnCCpVbCweAatB+Bj6R2+QrSPPC9d8pacjFF0Tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQvcU84zRHlwaz5usyqdyXci9yamvjfY1Ud5msqLJjlxkqMJfaIodISzKW+CrRNrSjJIGe4a78xWZZ5qWrlG7GNISI4oLWSYa7BNqKJq4t48fHtKVmOrfpQZ2QcvpMNmmVIo/FLVy28B4VaN3kD19dj+YZtu5pXZuJq1cO6y7wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CR/9dh3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D039BC19421;
	Wed, 11 Feb 2026 12:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770813106;
	bh=ENlGDnCCpVbCweAatB+Bj6R2+QrSPPC9d8pacjFF0Tg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CR/9dh3/it36j2UWHDJuoG3MWY8i3jdeA9fp1soqleCxEB4wjC3YdrQzGO8bkBUGG
	 CrOek9imnPaRkud0Q3/61neX/RQLrLcRlowDfpYwJRjS9QZ6eQWtAlb4zRdZ7Vg5RZ
	 i6DuQLsAMI6S1SHGVoq04uspz4QfbwlBZy3FYwJMXg3NQGN/3SEMITnadRmqQcS9QI
	 wX1uqkkO3xOFRhsSrAKbajvF0CbvFQXHnu9rQ/uhPWUuCvSifUB4P32oVhApj7N9q3
	 vH8cFUtsUdeefi3tbd/kHcADtB0bg95YOvaQN6sGBzR2fihdWIcdix9xmHUeyuiLWm
	 qQ2kOcc4IFVzg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Alexandre Courbot <acourbot@nvidia.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	ojeda@kernel.org,
	lossin@kernel.org,
	gary@garyguo.net,
	linux-pm@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.18] rust: cpufreq: always inline functions using build_assert with arguments
Date: Wed, 11 Feb 2026 07:30:26 -0500
Message-ID: <20260211123112.1330287-16-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211123112.1330287-1-sashal@kernel.org>
References: <20260211123112.1330287-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42500-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email,nvidia.com:email]
X-Rspamd-Queue-Id: 9E5DA1244C7
X-Rspamd-Action: no action

From: Alexandre Courbot <acourbot@nvidia.com>

[ Upstream commit 8c8b12a55614ea05953e8d695e700e6e1322a05d ]

`build_assert` relies on the compiler to optimize out its error path.
Functions using it with its arguments must thus always be inlined,
otherwise the error path of `build_assert` might not be optimized out,
triggering a build error.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have all the information needed for a thorough analysis. Here is
my assessment:

---

## Analysis: `rust: cpufreq: always inline functions using build_assert
with arguments`

### 1. What the Commit Does

This commit adds `#[inline(always)]` (plus explanatory comment) to the
`const fn copy_name()` function in `rust/kernel/cpufreq.rs`. This
function uses `build_assert!` to validate that a driver name string fits
within `CPUFREQ_NAME_LEN`.

### 2. The Bug Mechanism (Build Fix)

The `build_assert!` macro works by calling `build_error()` on the error
path. `build_error()` (defined in `rust/build_error.rs`) is exported
with the symbol name `rust_build_error`. Crucially, in the Makefile:

```25:26:rust/Makefile
always-$(CONFIG_RUST) += build_error.o
endif
```

When `CONFIG_RUST_BUILD_ASSERT_ALLOW` is NOT set (the default),
`build_error.o` is compiled but **not linked** into the kernel. This
means any reference to `rust_build_error` in the final binary causes a
**linker error** -- this is the deliberate mechanism that turns
`build_assert!` into a build-time check.

The problem: if `copy_name()` is not inlined, the compiler generates a
standalone function body where the `name` parameter is opaque. It cannot
prove that `src.len() <= CPUFREQ_NAME_LEN` will always hold, so it
preserves the `build_error()` call. This creates a reference to the
deliberately-missing `rust_build_error` symbol, causing a **build
failure**.

With `#[inline(always)]`, the function body is always expanded at the
call site where the actual argument (`T::NAME`) is a known const value.
The compiler can then evaluate the condition, prove it's true, and
eliminate the error path -- allowing successful linking.

### 3. Established Pattern -- Sibling Patches Were All Tagged for Stable

This commit is part of a broader effort by Alexandre Courbot to fix all
`build_assert!`-using functions that lack `#[inline(always)]`. The
**four sibling patches** (all with identical commit messages) that fix
this in other files **all have** `Cc: stable@vger.kernel.org` and
`Fixes:` tags:

- `d6ff6e870077a` - `rust: sync: refcount` -- **Cc: stable, Fixes:
  bb38f35b35f9**
- `09c3c9112d71c` - `rust: bits` -- **Cc: stable, Fixes: cc84ef3b88f4**
- `5d9c4c272ba06` - `rust: irq` -- **Cc: stable, Fixes: 746680ec6696**
- `33d19f621641d` - `rust: io` -- **Cc: stable, Fixes: ce30d94e6855**

The cpufreq variant likely lacks the stable tag because it was sent
through a different maintainer tree (Viresh Kumar's cpufreq tree, not
the Rust or DRM trees), not because it's less important.

### 4. Consistency with Existing Code

Identical patterns in the codebase **already have** `#[inline(always)]`:
- `i2c.rs:45` - `pub const fn new()` with `build_assert!` on string
  length
- `acpi.rs:38` - `pub const fn new()` with `build_assert!` on string
  length
- `ioctl.rs:12` - `const fn _IOC()` with multiple `build_assert!` calls
- `bits.rs:31-32` - `bit_*` and `genmask_*` functions
- `irq/flags.rs:100-101` - `const fn new()`
- `io/resource.rs:230-231` - `const fn new()`
- `num/bounded.rs:369-370` - `from_expr()`

The `cpufreq.rs` `copy_name` function is the exact same pattern (const
fn taking an argument, using `build_assert!` on it) but was missing the
annotation -- clearly an oversight.

### 5. Affected Stable Trees

The file `rust/kernel/cpufreq.rs` was introduced in v6.16. I confirmed
the vulnerable `copy_name` function (without `#[inline(always)]`) exists
in:
- **v6.18.9** (latest 6.18 stable)
- **v6.17.13** (latest 6.17 stable)
- **v6.16** (and its stable updates)

### 6. Risk Assessment

- **Change size**: 2 lines (1 comment + 1 attribute annotation)
- **Behavioral change**: Zero runtime change. `#[inline(always)]` only
  affects compilation.
- **Regression risk**: Effectively zero. The function was likely already
  being inlined by the optimizer; this just guarantees it, matching the
  established pattern.
- **Benefit**: Prevents potential build failures that could occur with
  different Rust compiler versions, optimization levels, or future code
  changes that affect inlining decisions.

### 7. Classification

This is a **build fix** -- one of the categories explicitly approved for
stable backporting. It prevents a linker error that could occur when the
compiler decides not to inline `copy_name`. The sibling fixes were all
explicitly tagged for stable by the author and maintainers.

### 8. Dependencies

None. This is a self-contained 2-line change with no dependencies on
other patches.

### Conclusion

This is a minimal, zero-risk build fix that follows an established
pattern across the Rust kernel codebase. Every sibling patch from the
same author fixing the exact same class of issue was tagged `Cc:
stable@vger.kernel.org`. The affected code exists in 6.16.y, 6.17.y, and
6.18.y stable trees. The only reason this specific patch lacks the
stable tag is likely that it went through a different maintainer tree.
The fix is obviously correct, small, and prevents potential build
failures.

**YES**

 rust/kernel/cpufreq.rs | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index f968fbd228905..0879a79485f8e 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -1015,6 +1015,8 @@ impl<T: Driver> Registration<T> {
         ..pin_init::zeroed()
     };
 
+    // Always inline to optimize out error path of `build_assert`.
+    #[inline(always)]
     const fn copy_name(name: &'static CStr) -> [c_char; CPUFREQ_NAME_LEN] {
         let src = name.to_bytes_with_nul();
         let mut dst = [0; CPUFREQ_NAME_LEN];
-- 
2.51.0


