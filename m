Return-Path: <linux-pm+bounces-42499-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLTtMrB2jGktpAAAu9opvQ
	(envelope-from <linux-pm+bounces-42499-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 13:31:44 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B3B1243DE
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 13:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9673330157CC
	for <lists+linux-pm@lfdr.de>; Wed, 11 Feb 2026 12:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A603194AD7;
	Wed, 11 Feb 2026 12:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpX6NjUB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC9A1862;
	Wed, 11 Feb 2026 12:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770813100; cv=none; b=DmNSkQ/uldYBpzXy4DTQPR764zGrkojGjp6d8yrac9U89d1UAQ6R1l5/kerC1TG6Dfv+D7kf4ejsumqNR4oWrcu3NWD9Ju5nY6MuI52FQiIkPMwhCryyaeNS485LoNIf0F1lQ/wSLd78BldL4quhl9pkLS7TLnkEUlWDqRVf744=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770813100; c=relaxed/simple;
	bh=deJUF3dkn3Zq7a88bQb2bHUI8BcwpQprT+NQbmTzwB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cdx/yzn7TBbpiHxybAobOUoiEzkGzupOaXmuxk+EbK4HKng0IAk4SBw0K4RUvs87U/JP4K1MXjxGX6kbYvvNY+b6FVL4C54jCZ85jOPmcyXYED4MEWHKKQbQGNOoTuKpvnlUVQJWVZUFaMOYyN6haBtD2Kknn/BXdk+32MXLIqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PpX6NjUB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C198BC2BCAF;
	Wed, 11 Feb 2026 12:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770813100;
	bh=deJUF3dkn3Zq7a88bQb2bHUI8BcwpQprT+NQbmTzwB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PpX6NjUBJvy3MsqOuWnpUhZaL6jRCYtM0xVp7r42p9roMdBnGe03sVhuagBoydgUY
	 bKooW5+rd3S5Pw3uJEk9DWzH5ufekpVYmD3gMsjJwj+VGHA93zSZ3x6GMsPIxojOVJ
	 IOvsEkc2k9RJR5jLdrp3d4+2Mc8ZzHPNSYm3tGM7AxIo1miu8ZOTfqn2ZcAi+89qB+
	 K5D08P6rsu2gN7TBgL+ss8PKtKbXPiZRs/TUIFXfItV6UNXIwGSmVbldSdyu5saPvj
	 KGbHyuILYwxhmr+GubMEDrFi7LiHGDm9LROVgVRujfsCCyneicRy+cY2okRlP+Omjz
	 QCoSEDIF6jVDg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-6.6] cpufreq: dt-platdev: Block the driver from probing on more QC platforms
Date: Wed, 11 Feb 2026 07:30:23 -0500
Message-ID: <20260211123112.1330287-13-sashal@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42499-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,linaro.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 42B3B1243DE
X-Rspamd-Action: no action

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

[ Upstream commit 7b781899072c5701ef9538c365757ee9ab9c00bd ]

Add a number of QC platforms to the blocklist, they all use either the
qcom-cpufreq-hw driver.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Analysis

### 1. Commit Message Analysis

The commit adds three Qualcomm platform compatible strings
(`qcom,sm6125`, `qcom,sm6150`, `qcom,sm7125`) to the cpufreq-dt-platdev
blocklist. The message states these platforms all use the `qcom-cpufreq-
hw` driver and should not use the generic `cpufreq-dt` driver. The same
author (Konrad Dybcio from Qualcomm) made a nearly identical batch
blocklist addition in commit `0aea7a2f88a5` in 2023.

### 2. Code Change Analysis

The change adds exactly 3 lines to the `blocklist[]` table in `cpufreq-
dt-platdev.c`:

```c
{ .compatible = "qcom,sm6125", },
{ .compatible = "qcom,sm6150", },
{ .compatible = "qcom,sm7125", },
```

The logic in `cpufreq_dt_platdev_init()` (line 220-238) works as
follows:
1. If platform matches `allowlist` → create cpufreq-dt device (OPPv1
   platforms)
2. If CPU0 has `operating-points-v2` AND platform is NOT in `blocklist`
   → create cpufreq-dt device
3. Otherwise → don't create the device

Without the blocklist entries, a platform that has `operating-points-v2`
on CPU nodes but uses a dedicated cpufreq driver (like `qcom-cpufreq-
hw`) will get a spurious `cpufreq-dt` platform device created, leading
to driver conflict.

### 3. Impact Analysis for Each Platform

**SM7125 (the most important for stable):**
- `sm7125.dtsi` includes `sc7180.dtsi`, which defines CPU nodes with
  `operating-points-v2` and `qcom,freq-domain = <&cpufreq_hw>`.
- SC7180 is already blocklisted, but SM7125 boards declare `compatible =
  "xiaomi,curtana", "qcom,sm7125"` — NOT `"qcom,sc7180"`.
- Therefore `of_machine_device_match(blocklist)` doesn't match, but
  `cpu0_node_has_opp_v2_prop()` returns true (inherited from sc7180).
- Result: `cpufreq-dt` platform device is incorrectly registered.
- SM7125 DTS was added in v6.7, so this bug affects stable 6.12+.
- Real devices affected: Xiaomi Redmi Note 9S (Curtana), Xiaomi Redmi
  Note 9 Pro (Joyeuse).

**SM6150:**
- Used by QCS615 platform (talos.dtsi), which has `cpufreq_hw` and
  `operating-points-v2` on CPU nodes.
- The cpufreq-hw OPP tables were only added in v6.19-rc1, so this only
  affects very new kernels.

**SM6125:**
- CPU nodes in `sm6125.dtsi` do NOT currently have `operating-
  points-v2`, so `cpu0_node_has_opp_v2_prop()` returns false and the bug
  doesn't trigger. This is a proactive addition.

### 4. Real-World Symptom

The SM8650 blocklist commit (`fc5414a4774e`) documents the exact
symptom:

```
[    0.388525] cpufreq-dt cpufreq-dt: failed register driver: -17
[    0.388537] cpufreq-dt cpufreq-dt: probe with driver cpufreq-dt
failed with error -17
```

Error `-17` is `-EEXIST` — the `qcom-cpufreq-hw` driver (registered at
`postcore_initcall`) is already in place when `cpufreq-dt` tries to
register (at `device_initcall` level). If module loading order changes
(e.g., one is built as a module), the wrong driver could actually handle
CPU frequency scaling.

### 5. Precedent

This exact type of change (adding platform compatible strings to the
blocklist) has been done **20+ times** in the file's history:
- `032b149bcc547` - SDM670 blocklist (2024-02-09)
- `b14ceb82c3a1b` - SM7325 blocklist (2024-08-08)
- `fc5414a4774e1` - SM8650 blocklist (2025-04-05)
- `0aea7a2f88a55` - Batch QC blocklist (2023-08-09) — same author

All of these are structurally identical 1-3 line table additions.

### 6. Risk Assessment

- **Risk: Essentially zero.** Adding entries to a blocklist table cannot
  introduce regressions. The only conceivable failure mode would be
  blocking a platform that actually needs cpufreq-dt, but these
  platforms are confirmed to use qcom-cpufreq-hw.
- **Scope:** 3 lines, 1 file, pure data table change.
- **No dependencies:** The change is completely self-contained.

### 7. Stable Applicability

- SM7125 exists in stable 6.12 (DTS added in v6.7, board files in v6.9).
  The bug is active there.
- SM6150 is too new for current stable trees (cpufreq-hw support only in
  v6.19).
- SM6125 is proactive and harmless.
- The patch applies cleanly to any stable tree that has the surrounding
  blocklist entries (which all current stable trees do).

### Conclusion

This is a trivial, safe blocklist addition that prevents incorrect
driver probing on Qualcomm SM7125 devices. It follows a pattern that has
been applied 20+ times before, fixes a real dmesg error (and potential
wrong-driver issue) on actual consumer hardware (Xiaomi phones), and has
zero risk of regression. The SM7125 fix is relevant for 6.12 stable.

**YES**

 drivers/cpufreq/cpufreq-dt-platdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index b06a43143d23c..2fecab989dacc 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -169,8 +169,11 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "qcom,sdm845", },
 	{ .compatible = "qcom,sdx75", },
 	{ .compatible = "qcom,sm6115", },
+	{ .compatible = "qcom,sm6125", },
+	{ .compatible = "qcom,sm6150", },
 	{ .compatible = "qcom,sm6350", },
 	{ .compatible = "qcom,sm6375", },
+	{ .compatible = "qcom,sm7125", },
 	{ .compatible = "qcom,sm7225", },
 	{ .compatible = "qcom,sm7325", },
 	{ .compatible = "qcom,sm8150", },
-- 
2.51.0


