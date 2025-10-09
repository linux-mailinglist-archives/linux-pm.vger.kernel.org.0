Return-Path: <linux-pm+bounces-35863-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 63232BCA10D
	for <lists+linux-pm@lfdr.de>; Thu, 09 Oct 2025 18:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D6D44FC3FB
	for <lists+linux-pm@lfdr.de>; Thu,  9 Oct 2025 16:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC2512CDA5;
	Thu,  9 Oct 2025 16:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecJTauXM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F11231830;
	Thu,  9 Oct 2025 16:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025625; cv=none; b=ZOMBUUyUjxgH+BfzstnEcOnvqND5zom1/l1cc2mZM33eE4baZp4k0nrOYFxNW1EK+7ijdj3R5VMPZqz6vf3tUZ8pLXSCErtXcbIJYyoZSsb5zjtKGj3MzmvPiPVdMaGvreoqZ19Mp4p15JAUq2PL+rSU5LGZ73/eeVghKnpZvMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025625; c=relaxed/simple;
	bh=smqM7IfJYbOM3LA97TKRF0RTFPNqepnOx+Rf4R8Kglw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ajbz5zYttdZHuDiGr5C4P426QlZ/4ibzVRG25LV9aA68uVxH57Ix5BEZD2HpG2Nu/0iA7xZPYjJ5ueuEaUTjjHmuFI6zPlFqJ9DNU7aXC3xP6lpWILLD7rHYl8ar0NpdCAunm8AcCyvntYYPCcmJD9CtbNNDt7Ek4vu7+FJuv2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecJTauXM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90DB5C4CEF8;
	Thu,  9 Oct 2025 16:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760025625;
	bh=smqM7IfJYbOM3LA97TKRF0RTFPNqepnOx+Rf4R8Kglw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ecJTauXMb5a1GnvfoaIGhf5xkh75lJ1llfR3/sE4QmgZmUp0Xwkr7j0EkPVHACs/6
	 HcMbc2mG9y1HJqpf4TzuAdBQXtEqGIITP3tMOkCVBQEcOQoRB6AKUM9m6JQqur1d9W
	 /RYDDT9DCdd6wchMyvneM1mJZ/sSPWm7WgB40jDALErJ1jEP3KM3oXVrxdV/wQLDt4
	 zzhwzwZNnItHgXcWQPLNZOBWcf1/GatJF3jFTRJRYl6Y+EFZ+FrAyNbacbmdR2mrhK
	 ta4t13+Ve9864iDJ632voOoNxohgyds8ZJGOnA78dpSsa3D7OnuCPeEfv2N2zsabDh
	 xMuvm9JFWUWqg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Kaushlendra Kumar <kaushlendra.kumar@intel.com>,
	Len Brown <len.brown@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lenb@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.16] tools/power turbostat: Fix incorrect sorting of PMT telemetry
Date: Thu,  9 Oct 2025 11:55:46 -0400
Message-ID: <20251009155752.773732-80-sashal@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>

[ Upstream commit cafb47be3f38ad81306bf894e743bebc2ccf66ab ]

The pmt_telemdir_sort() comparison function was returning a boolean
value (0 or 1) instead of the required negative, zero, or positive
value for proper sorting. This caused unpredictable and incorrect
ordering of telemetry directories named telem0, telem1, ..., telemN.
Update the comparison logic to return -1, 0, or 1 based on the
numerical value extracted from the directory name, ensuring correct
numerical ordering when using scandir.

This change improves stability and correctness when iterating PMT
telemetry directories.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES

- What it fixes
  - The comparator `pmt_telemdir_sort()` returned a boolean (`0`/`1`)
    instead of a strict ordering value (<0, 0, >0). This violates the
    `scandir()`/`qsort()` contract and can produce non-deterministic and
    incorrect ordering. In 6.17 the buggy line is `return aidx >= bidx;`
    in `tools/power/x86/turbostat/turbostat.c:1893`.
  - The fix changes it to return -1/0/1 based on numeric comparison of
    the index in the `telem%u` name, ensuring proper ascending numeric
    order. Mainline shows the corrected code as `return (aidx > bidx) ?
    1 : (aidx < bidx) ? -1 : 0;` in the same function.

- Why it matters to users
  - Turbostat iterates PMT telemetry directories with `scandir()` using
    this comparator at `tools/power/x86/turbostat/turbostat.c:1921`.
    With an invalid comparator, entries like `telem10` vs `telem2` can
    be mis-ordered.
  - The order is used to construct a linked list of PMT MMIO regions
    “preserving the ordering from sysfs” in `pmt_mmio_open()` at
    `tools/power/x86/turbostat/turbostat.c:9668` and
    `tools/power/x86/turbostat/turbostat.c:9688`. Wrong order can
    misassociate telemetry regions with the intended domains.
  - The order is also used to compute a “sequence” for identifying a
    specific PMT instance in `pmt_parse_from_path()` at
    `tools/power/x86/turbostat/turbostat.c:10526`. Mis-ordering yields
    wrong `seq` values and incorrect counter selection.

- Scope and risk
  - Change is a one-line, localized fix in a user-space tool
    (`tools/power/x86/turbostat/turbostat.c`), no architectural changes,
    no ABI impact, and no dependency on new kernel features.
  - It directly corrects comparator semantics expected by `scandir()`;
    risk of regression is minimal and behavior becomes deterministic.
  - Security impact is negligible; this corrects ordering logic for
    sysfs directories, not privilege or memory handling.

- History and applicability
  - The bug was introduced when the PMT directory iterator helper landed
    (commit “Add PMT directory iterator helper”); 6.17’s turbostat has
    the buggy `return aidx >= bidx;` line
    (tools/power/x86/turbostat/turbostat.c:1893).
  - The mainline fix (“tools/power turbostat: Fix incorrect sorting of
    PMT telemetry”) updates the comparator to return -1/0/1.
  - Any stable branch that includes the PMT directory iterator helper
    should take this fix.

- Stable backport criteria
  - Fixes a user-visible correctness bug in turbostat’s PMT handling.
  - Small, self-contained, and low risk.
  - No features added; purely a bug fix improving stability/correctness.
  - Touches only a userspace tool under `tools/`, not core kernel
    subsystems.

Given the clear correctness fix, minimal scope, and direct user impact
in PMT telemetry iteration, this is a strong candidate for stable
backport.

 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 72a280e7a9d59..931bad99277fe 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1890,7 +1890,7 @@ int pmt_telemdir_sort(const struct dirent **a, const struct dirent **b)
 	sscanf((*a)->d_name, "telem%u", &aidx);
 	sscanf((*b)->d_name, "telem%u", &bidx);
 
-	return aidx >= bidx;
+	return (aidx > bidx) ? 1 : (aidx < bidx) ? -1 : 0;
 }
 
 const struct dirent *pmt_diriter_next(struct pmt_diriter_t *iter)
-- 
2.51.0


