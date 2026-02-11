Return-Path: <linux-pm+bounces-42501-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGzKKoR3jGktpAAAu9opvQ
	(envelope-from <linux-pm+bounces-42501-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 13:35:16 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 334B6124580
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 13:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54562308BCD1
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 12:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30275246798;
	Wed, 11 Feb 2026 12:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCGLOi/8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBA0194AD7;
	Wed, 11 Feb 2026 12:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770813143; cv=none; b=F58eqAmTLuvtqx1sAYWNw2+jwrYwK9lpQI+N08uQS4U0kNosrrrdiSY+klPDsdVhQ0FmxdZYkJyTyrGtB3qH93Bl6xioneR95GeblhDFGnfU77JXQS7k1ov2tzoGw5HSSGNkHRyZr/cK+YPvq9F724/vWhuG07lba0edKwT0fvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770813143; c=relaxed/simple;
	bh=5o8P1nGD6kgmgbm0HLIZNXR6vykIjvxqUEwtAJh61tE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SFzr9/aStv+Ahf74X72sLlHPAcmZapKio6FnJD7hCKN3j4MP8DA7wLv+pYvzkh/yyT5YoU12UFwSw4IYOmJpykaJXjfbLgiwk45ZpuZ/k+q6Loa5KUhWN/9/HGc4INogdAJnL2HGkVyNcTnV5INx5VrevmbeOKCOQTXP/xOGZSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCGLOi/8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D55C19421;
	Wed, 11 Feb 2026 12:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770813142;
	bh=5o8P1nGD6kgmgbm0HLIZNXR6vykIjvxqUEwtAJh61tE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OCGLOi/8nPLxiXm9P4G0ftYyQ29oLDDV1m/+UUhzsmxtpSh7VB/D6HteHlvw+iDGW
	 tNlfi2GTK5UTRqgmYMSYoyaYYIJTEtKi47Tq6hmAJVMqInb2Pgrf2AFfO/p1Ivcx0v
	 3NFm01ipPPly9CugzVJBPMb4zIdhChf92BfpWxku5T59KCpSRzUERdIauFzoISHe+Q
	 TYzWfzph3b1y4pxjXil1b2atrQDyQQ1GSNEWuw7PIUkz8TzYB+SwEx9Rs4SGdtdUvm
	 A9HRarZKGLD6IZBBF1yuiL7pB9QBOcVbprMgJw/VAzaNBd3zJbVHyHVkbfuaac4Q06
	 Vyv+Nfa607B7A==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Daniel Tang <danielzgtg.opensource@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.12] powercap: intel_rapl: Add PL4 support for Ice Lake
Date: Wed, 11 Feb 2026 07:30:44 -0500
Message-ID: <20260211123112.1330287-34-sashal@kernel.org>
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
	FREEMAIL_CC(0.00)[gmail.com,intel.com,kernel.org,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42501-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 334B6124580
X-Rspamd-Action: no action

From: Daniel Tang <danielzgtg.opensource@gmail.com>

[ Upstream commit 54b3cd55a515c7c0fcfa0c1f0b10d62c11d64bcc ]

Microsoft Surface Pro 7 firmware throttles the processor upon
boot/resume. Userspace needs to be able to restore the correct value.

Link: https://github.com/linux-surface/linux-surface/issues/706
Signed-off-by: Daniel Tang <danielzgtg.opensource@gmail.com>
Link: https://patch.msgid.link/6088605.ChMirdbgyp@daniel-desktop3
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

I now have all the information needed for a thorough analysis.

---

## Detailed Analysis

### 1. Commit Message Analysis

**Subject**: `powercap: intel_rapl: Add PL4 support for Ice Lake`

**Body**: States the Microsoft Surface Pro 7 firmware throttles the
processor upon boot/resume, and userspace needs to be able to restore
the correct value. Links to a GitHub issue.

**Key observations**:
- "Add PL4 support" sounds like a feature addition
- But the commit message explains a **concrete hardware problem**:
  firmware incorrectly throttles the CPU
- Links to a well-documented issue with multiple affected users over 4+
  years

### 2. Code Change Analysis

The change is a single line addition:

```c
X86_MATCH_VFM(INTEL_ICELAKE_L, NULL),
```

added to the `pl4_support_ids[]` array. This is a **CPU ID table
addition** to an existing, mature driver feature.

**How it works mechanically**: In `rapl_msr_probe()`, the driver checks
`x86_match_cpu(pl4_support_ids)`. If the running CPU matches, the
driver:
1. Sets `BIT(POWER_LIMIT4)` in the package limits
2. Registers `MSR_VR_CURRENT_CONFIG` (0x601) as the PL4 register
3. This exposes a `peak_power` constraint in the powercap sysfs
   interface

Without ICELAKE_L in the list, there is **no kernel-provided mechanism**
for userspace to read or write MSR 0x601 on Ice Lake systems. The only
workaround is raw MSR access via `wrmsr`, which doesn't work with Secure
Boot/SELinux.

### 3. Real-World Impact Assessment

The linked GitHub issue (#706) documents a severe problem:

- **Affected hardware**: Microsoft Surface Pro 7 (Intel Ice Lake /
  ICELAKE_L, model 0x7E)
- **Symptoms**: CPU throttled to 400-1500 MHz after boot or resume from
  suspend. Devices become essentially unusable.
- **Root cause**: Surface Pro 7 firmware sets MSR_VR_CURRENT_CONFIG to a
  very low value (e.g., 0x78 = ~15A peak current, far too low for normal
  operation)
- **Severity**: Multiple users over 4+ years reported this issue. Some
  users reported getting stuck at 400 MHz even at 100% battery.
- **Affected user base**: The linux-surface project has 7,000+ GitHub
  stars, and Surface Pro 7 was a popular device

The workaround proven by the community (manually writing MSR 0x601)
confirms that exposing PL4 control is the correct fix.

### 4. Classification: Device ID / Hardware Quirk

This commit falls squarely within the **"New Device IDs"** exception
category for stable backports:

- The PL4 infrastructure (`pl4_support_ids`, `POWER_LIMIT4`,
  `MSR_VR_CURRENT_CONFIG`, the sysfs interface) **already exists in all
  current stable trees** (verified: v5.10, v5.15, v6.1, v6.6, v6.12)
- Only the CPU ID (ICELAKE_L) is new
- The driver already supports Ice Lake for all other RAPL functionality;
  PL4 is the only missing piece
- This is analogous to a **hardware quirk/workaround** for broken
  firmware behavior on specific devices

### 5. Scope and Risk Assessment

- **Size**: 1 line added to a static const array
- **Files touched**: 1 (`drivers/powercap/intel_rapl_msr.c`)
- **Risk of regression**: Effectively zero. The change only affects
  systems with INTEL_ICELAKE_L CPUs. All other systems are completely
  unaffected. The PL4 mechanism is well-tested on Tiger Lake, Alder
  Lake, Raptor Lake, Meteor Lake, Arrow Lake, etc.
- **Worst case**: PL4 sysfs interface appears on Ice Lake systems but
  nobody uses it (no harm - it's read-only until userspace writes to it)

### 6. Backport Compatibility

The `pl4_support_ids[]` array exists in all stable trees but uses
different macro formats:

- **v6.12**: Uses `X86_MATCH_VFM()` - **patch applies cleanly**
- **v6.6**: Uses `X86_MATCH_INTEL_FAM6_MODEL()` - trivial adaptation
  needed: `X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L, NULL)`
- **v6.1, v5.15**: Uses raw struct format - trivial adaptation: `{
  X86_VENDOR_INTEL, 6, INTEL_FAM6_ICELAKE_L, X86_FEATURE_ANY }`

All adaptations are mechanical and `INTEL_FAM6_ICELAKE_L` (0x7E) is
defined in all these stable trees.

### 7. Dependency Check

No dependencies. The entire PL4 infrastructure (commit `8365a898fe53f`
from 2020) is already in all active stable kernels. This is a standalone
one-line addition.

### 8. Summary

| Criterion | Assessment |
|-----------|-----------|
| Fixes real bug | Yes - firmware throttling making devices unusable |
| Obviously correct | Yes - identical pattern to 14 other CPU IDs in
same list |
| Small and contained | Yes - 1 line in 1 file |
| No new features | Correct - enables existing feature for additional
hardware |
| Tested | Yes - author tested on Surface Pro 7, community validated MSR
approach |
| Risk | Extremely low |
| User impact | High - Surface Pro 7 users affected for 4+ years |

This is a textbook CPU ID addition to an existing driver, enabling a
critical workaround for broken firmware behavior on popular hardware. It
meets all stable kernel criteria and falls within the well-established
exception for device ID additions and hardware quirks.

**YES**

 drivers/powercap/intel_rapl_msr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index 9a7e150b3536b..a2bc0a9c1e103 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -162,6 +162,7 @@ static int rapl_msr_write_raw(int cpu, struct reg_action *ra)
 
 /* List of verified CPUs. */
 static const struct x86_cpu_id pl4_support_ids[] = {
+	X86_MATCH_VFM(INTEL_ICELAKE_L, NULL),
 	X86_MATCH_VFM(INTEL_TIGERLAKE_L, NULL),
 	X86_MATCH_VFM(INTEL_ALDERLAKE, NULL),
 	X86_MATCH_VFM(INTEL_ALDERLAKE_L, NULL),
-- 
2.51.0


