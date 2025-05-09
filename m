Return-Path: <linux-pm+bounces-26908-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA20CAB06ED
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 02:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF02A4C2F75
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 00:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2001854;
	Fri,  9 May 2025 00:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="le26n8XI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B801373;
	Fri,  9 May 2025 00:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746749058; cv=none; b=u6RJD+q5hCOula3RtEunVF+96dIdduOiV7GgnEOZvUoFF5pAnI0VFuiTyXg+Ewlh8iR6Av+v5pzAN+uRCEmYk+l3NPnMiLWEeq7FIUcuYbKfyN5KI9GobVN7sbOuGuHkZXrUjgQHZ0JD4YZGhZiqGVpRy/wTll9ObNk9FaQwWlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746749058; c=relaxed/simple;
	bh=57Np20SdFeVQE9PtU0KXWCY9OLkd7sjux9udzUUqAks=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cVY4jsiRctv/AbceO5cXlcKuwnF3q7Bcgpgn1ufTWtBMEaiXFbcQZZfgQreYb8BNRXng9nO/Ql+jhbETlVc9uIzfpXvK28mJk7xC0h2nl97VVyXKTNLaLM45eGtNFJlgZBDYycH74IWDRSidVsfb9u6AHeKxTZI6ExkW/SOjtGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=le26n8XI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C651C4CEE7;
	Fri,  9 May 2025 00:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746749057;
	bh=57Np20SdFeVQE9PtU0KXWCY9OLkd7sjux9udzUUqAks=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=le26n8XIJXnC4by02F2+wZLbMGQw1Rvl8TzVb6et4zlhefBCjxKD9UuliOLZ8OaG5
	 1SOjpOMXQj64xJ/19EnD7RaQvZYVkiqr6EkKwHlAJuTQchXVPeKygZlkIl3omgyd6i
	 efEFVRzigh9LiPP3LR1w4HzztqGZISOvWk+cVkgdkI+oHO1XleNuGjqLQH8mIL6FXu
	 I1St7gnZiOzlwNEKqRNdxXuhatBi9NF1U/2OCP9fpOOnK24ltDi2xiEBFkqtjPBrQJ
	 a3e1wwPf3gzOXqQ7AeqIIhRoOEO1IgXZ6r+Gn/PtJi35Pj24B20bib3DCBaJEIbvNP
	 7z5noJe3Nu36Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E08C3ABBE;
	Fri,  9 May 2025 00:04:17 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Subject: [PATCH v4 0/2] Support building tegra124-cpufreq as a module
Date: Thu, 08 May 2025 19:04:13 -0500
Message-Id: <20250508-tegra124-cpufreq-v4-0-d142bcbd0234@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH1GHWgC/4XOSw6CMBCA4auQrq1ph+HlynsYF7VMoYk8LNhoC
 He3EBdETVz+k8w3M7GBnKWBHaKJOfJ2sF0bAncR07VqK+K2DM1AQCJQSD5S5ZQE5Lq/G0c3bso
 C0ZSaUtAsrPWOjH2s5OkcurbD2LnnesHLZfrGQHxjXnLBhcLMkIRUFPJYNcpe97pr2IJ52AI/v
 vEQADASc01Gocw/gfgfEAegSEhdVJHmmGZbYJ7nF4xzpOoyAQAA
X-Change-ID: 20250401-tegra124-cpufreq-fd944fdce62c
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746749056; l=1390;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=57Np20SdFeVQE9PtU0KXWCY9OLkd7sjux9udzUUqAks=;
 b=JuqRJq7vMFUtK4ZbxKkFFgQ6PSAQpueCmTe6GdZROXOGFE/WfKaQhYHoND47mWrNgLIlshy0V
 CE/Tf7s/CBEA23K7ZytwKZmYLGQxALudy4VnVWlOmSLAZit7C+Z19Hq
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

This adds remove and exit routines that were not previously needed when
this was only available builtin. It also converts use of an unexported
function to a more sane alternative.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
Changes in v4:
- Move clock puts to remove instead of exit
- Link to v3: https://lore.kernel.org/r/20250421-tegra124-cpufreq-v3-0-95eaba968467@gmail.com

Changes in v3:
- In patch 1, set cpufreq_dt_pdev to an error after unregister on fail
  to prevent a potential double unregister on remove
- In patch 2, clean up clocks on exit
- Link to v2: https://lore.kernel.org/r/20250421-tegra124-cpufreq-v2-0-2f148cefa418@gmail.com

Changes in v2:
- Replace patch 1 with a patch to not use the unexported function
- Update patch 2 to add remove and exit routines
- Link to v1: https://lore.kernel.org/r/20250420-tegra124-cpufreq-v1-0-0a47fe126091@gmail.com

---
Aaron Kling (2):
      cpufreq: tegra124: Remove use of disable_cpufreq
      cpufreq: tegra124: Allow building as a module

 drivers/cpufreq/Kconfig.arm        |  2 +-
 drivers/cpufreq/tegra124-cpufreq.c | 41 +++++++++++++++++++++++++++++++++-----
 2 files changed, 37 insertions(+), 6 deletions(-)
---
base-commit: 91e5bfe317d8f8471fbaa3e70cf66cae1314a516
change-id: 20250401-tegra124-cpufreq-fd944fdce62c

Best regards,
-- 
Aaron Kling <webgeek1234@gmail.com>



