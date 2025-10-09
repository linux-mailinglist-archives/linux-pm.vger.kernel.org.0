Return-Path: <linux-pm+bounces-35864-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AACDBC9FE4
	for <lists+linux-pm@lfdr.de>; Thu, 09 Oct 2025 18:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E244C3B3F8B
	for <lists+linux-pm@lfdr.de>; Thu,  9 Oct 2025 16:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAC12F3C27;
	Thu,  9 Oct 2025 16:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDsXOx8E"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B9A2F3C11;
	Thu,  9 Oct 2025 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025632; cv=none; b=C8ha9+zfaHBTJ/c5bwKnqtuP0x+8qMy/WBbRoDFCzSZBMypZRZoCl9CWVrPNXLe0s3qeR+zEnXasAIDR/zO4aa8HVbyLrdzSg0548vk6XQeru2nr7is9mMS+RnF8cykqe7DVtEKXC2PfEZXWujz7kcofNLtl3U6DrPHhOuITjnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025632; c=relaxed/simple;
	bh=w0lL11a4isY3KVINmF2py0wl6uiuhSRVRIWX6J7UIGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rH/bT6Uwx3Ml2+Iwq5f7aiJzShkHjrflKxw/82BqWn2orV5hjROkeD08vxboqdAFN1BeFhPLxPFdZSXT/FQJSE6svZT+h8AIdh57uYgKhk+w8QBpXD6iakDPMvBTBGIHCp0yNQ7/y29OXFbfwUAsGnmOj2S5taXyBj+FK70AA0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDsXOx8E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3BDC4CEF7;
	Thu,  9 Oct 2025 16:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760025631;
	bh=w0lL11a4isY3KVINmF2py0wl6uiuhSRVRIWX6J7UIGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kDsXOx8EemIDZuiq1NZmH0se0ut/7R9FTdT+Q5lJQrC5oY0cfqj0xJTRYYq6Q/lsc
	 jXZ2rifu1Xvi0OR17BS2fM4Q9yNuvUfrHmi43vx2VG1FjIAHovltIsJwkZWCfOVUPT
	 4XoVmeo6fvM3kHqKw3OCZPjalTXkTsJVgv8KEGAix2HSuiLC4GMgYXD6Lddn/zzNwq
	 IIHcTSyrwGHe1/eNAgJXgKUzADKrJOMVIwoujHzAm0c8zmSrlIAxJzVMnbcqCvZaNe
	 B770Q4qDULvFhFjE7QKK7QJL9FHNTuXCopJs4/+2DEVTU4/7G0XifMPCAiUPsMlqm6
	 aFSX+y7p3y8Sw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Paresh Bhagat <p-bhagat@ti.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.12] cpufreq: ti: Add support for AM62D2
Date: Thu,  9 Oct 2025 11:55:51 -0400
Message-ID: <20251009155752.773732-85-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009155752.773732-1-sashal@kernel.org>
References: <20251009155752.773732-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.1
Content-Transfer-Encoding: 8bit

From: Paresh Bhagat <p-bhagat@ti.com>

[ Upstream commit b5af45302ebc141662b2b60c713c9202e88c943c ]

Add support for TI K3 AM62D2 SoC to read speed and revision values
from hardware and pass to OPP layer. AM62D shares the same configuations
as AM62A so use existing am62a7_soc_data.

Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Based on my comprehensive analysis of this commit and the stable kernel
backporting policies, here is my assessment:

## Backport Status: YES

### Detailed Analysis

#### 1. **Explicit Policy Support**
The Linux stable kernel rules (Documentation/process/stable-kernel-
rules.rst, line 15) **explicitly allow device ID additions**:
> "It must either fix a real bug that bothers people or **just add a
device ID**."

This commit adds device IDs for the AM62D2 SoC in two locations:
- **Line 313** in `k3_cpufreq_soc[]`: Adds `{ .family = "AM62DX",
  .revision = "SR1.0" }`
- **Line 461** in `ti_cpufreq_of_match[]`: Adds `{ .compatible =
  "ti,am62d2", .data = &am62a7_soc_data, }`

#### 2. **Strong Historical Precedent**
Similar commits for the AM62 SoC family were backported to stable trees:

- **AM625 support** (aac0293a8f1cd): No Cc: stable tag, but present in
  stable branches linux-6.10.y through 6.17.y
- **AM62A7 support** (5008e4c8c31c6): No Cc: stable tag, but present in
  stable branches linux-6.10.y through 6.17.y
- **AM625 blacklist** (e66e20d71d79e): Also backported to stable
- **AM62A7 blacklist** (b2b2029eb1788): Also backported to stable

#### 3. **Minimal Risk Profile**
- **Only 2 lines changed** (1 file, +2 insertions)
- **Reuses existing configuration**: Uses `am62a7_soc_data` as stated in
  commit message - no new code paths
- **Isolated change**: Only affects AM62D2 hardware, no impact on other
  SoCs
- **Well-tested pattern**: Follows the exact same pattern as AM625,
  AM62A7, and AM62P5 additions

#### 4. **User Benefit**
- Enables CPU frequency scaling on AM62D2 hardware
- Users with AM62D2 boards (device tree support added in v6.17 via
  commit 1544bca2f188e) need this for proper power management
- Without this commit, AM62D2 systems cannot adjust CPU frequencies
  based on load

#### 5. **Companion Commit**
There's a companion commit **fa40cbe1c86b6** "cpufreq: dt-platdev:
Blacklist ti,am62d2 SoC" by the same author on the same date. Both
should be backported together to prevent the generic cpufreq-dt driver
from conflicting with ti-cpufreq.

#### 6. **No Architectural Changes**
- No new features beyond hardware enablement
- No refactoring or code restructuring
- No changes to existing functionality
- Meets stable tree criteria: small, contained, low regression risk

### Conclusion
This commit should be backported to stable kernel trees because it:
1. Falls under the explicit "device ID addition" exception in stable
   rules
2. Has strong precedent with similar AM62 family commits being
   backported
3. Provides essential functionality for AM62D2 hardware owners
4. Has minimal regression risk (2 lines, reuses existing data
   structures)
5. Follows the established stable backporting pattern for this driver

 drivers/cpufreq/ti-cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index 5a5147277cd0a..9a912d3093153 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -310,6 +310,7 @@ static const struct soc_device_attribute k3_cpufreq_soc[] = {
 	{ .family = "AM62X", .revision = "SR1.0" },
 	{ .family = "AM62AX", .revision = "SR1.0" },
 	{ .family = "AM62PX", .revision = "SR1.0" },
+	{ .family = "AM62DX", .revision = "SR1.0" },
 	{ /* sentinel */ }
 };
 
@@ -457,6 +458,7 @@ static const struct of_device_id ti_cpufreq_of_match[]  __maybe_unused = {
 	{ .compatible = "ti,omap36xx", .data = &omap36xx_soc_data, },
 	{ .compatible = "ti,am625", .data = &am625_soc_data, },
 	{ .compatible = "ti,am62a7", .data = &am62a7_soc_data, },
+	{ .compatible = "ti,am62d2", .data = &am62a7_soc_data, },
 	{ .compatible = "ti,am62p5", .data = &am62p5_soc_data, },
 	/* legacy */
 	{ .compatible = "ti,omap3430", .data = &omap34xx_soc_data, },
-- 
2.51.0


