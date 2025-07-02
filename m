Return-Path: <linux-pm+bounces-29963-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF148AF0CE7
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 09:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE9EC4E2A01
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 07:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211C6233D8E;
	Wed,  2 Jul 2025 07:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N51Rd8Yw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE22231852;
	Wed,  2 Jul 2025 07:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751442409; cv=none; b=bUURskA/4yG+qw3e1fLdfBKQMrPQb968iRVrr2KPlacqBd5dRRcuZ18slL5Tf2LgZuzterheXSDN49VuiYv7d7SZmNkpFF1nBm+px5+C+zY1kpco67PGXL4CCKigEX/rRr7po26rN4CmJaXuKw8MFSz2qmYHZeP9aYkPss2+RU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751442409; c=relaxed/simple;
	bh=f6OQCjZuWiov1eLKcBiyn9GOG0SInVztkbDL2cq2EXg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=I7LcPJvw+t6aI79W/EgdVhPD8IeZtJzoPFCi1KNvvCBkaEVT+Ys5tzGHSYRjvmpnH5VOVCqGEk2xXJpdFhqW0Imhhx/4aKBDIY4DIv2t4LhDZH1Cl+uVN92SSa5JbXyumH3ankbFMVpsqnhyOYK/CDrxkU/Mpmx8il9KYj49SOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N51Rd8Yw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6CD8CC4CEF5;
	Wed,  2 Jul 2025 07:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751442408;
	bh=f6OQCjZuWiov1eLKcBiyn9GOG0SInVztkbDL2cq2EXg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=N51Rd8YwqVHu80rZkjN/Ran0c6Z+Stg63cZcjJFF2zd72rjv5yBn6HanlroqPpkQg
	 laBW+rejx2COh+/3ORDq3nsp03JYEbi66MqLuJNHhrvJsGLORuWG/eiY4bbhh5hRLo
	 76eyfX3iSqkvjAbjsDpvbkkxNwmbx6Lhq5yHjO8Z/A2GnSUitt1kr/QkT23+pJgZ4i
	 mG9f5c/G1xkcywt6MxJEKB0RO48QHWdencdebsdIJf8zcfgaOQfo9H3SmBF+aLwYGB
	 b45qdzHkO5z34ixiYZClwZG7yer78uM13UI8RnW0kenJ+iWives4y1K1byO5phBWX/
	 1+eWTGIdR8ZJQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C762C83038;
	Wed,  2 Jul 2025 07:46:48 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Subject: [PATCH v5 0/3] Support building tegra124-cpufreq as a module
Date: Wed, 02 Jul 2025 02:46:23 -0500
Message-Id: <20250702-tegra124-cpufreq-v5-0-66ab3640a570@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANDjZGgC/4XO0arCMAyA4VeRXttDkmVz88r3EC+6Np0FdbPTo
 sje/VQ5cEQFL/9AvuSmRolBRrWc3VSUFMbQH3KU85myW3PoRAeXWxFQCQyoT9JFg8TaDmcf5ai
 9a5i9s1KRVXltiOLD5UGuN7m3YTz18fq4kPA+/cMI3rGEGjQYXnhBqqDBVbc3Yfdj+726Y4meg
 Q/fJMoAeeTaijeM9StQfAOKDDSlmNY0Vc3V4hXgf6CE+gPAGXDI1NrWARX8DEzT9AsupkNMcwE
 AAA==
X-Change-ID: 20250401-tegra124-cpufreq-fd944fdce62c
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751442407; l=1799;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=f6OQCjZuWiov1eLKcBiyn9GOG0SInVztkbDL2cq2EXg=;
 b=w/IpZgR+XXSVExwCySdXj0zT1TojJMleiNoC0DH5aGBf7aqM90Ee5bh+JrZAsNqmLvthmZXQK
 0dAvfOLbPiaDTCr7f7HV/JL/+5B1zHsFWDbTHMFNuR/q3Ai8Epux+Qh
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

This adds remove and exit routines that were not previously needed when
this was only available builtin.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
Changes in v5:
- Add register helper function to cpufreq-dt for kernel users to use to
  establish a depmod dependency
- Drop patch that removes use of disable_cpufreq and re-add the patch to
  export said function
- Link to v4: https://lore.kernel.org/r/20250508-tegra124-cpufreq-v4-0-d142bcbd0234@gmail.com

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
Aaron Kling (3):
      cpufreq: Export disable_cpufreq()
      cpufreq: dt: Add register helper
      cpufreq: tegra124: Allow building as a module

 drivers/cpufreq/Kconfig.arm        |  2 +-
 drivers/cpufreq/cpufreq-dt.c       | 11 ++++++++++
 drivers/cpufreq/cpufreq-dt.h       |  2 ++
 drivers/cpufreq/cpufreq.c          |  1 +
 drivers/cpufreq/tegra124-cpufreq.c | 44 +++++++++++++++++++++++++++++---------
 5 files changed, 49 insertions(+), 11 deletions(-)
---
base-commit: 91e5bfe317d8f8471fbaa3e70cf66cae1314a516
change-id: 20250401-tegra124-cpufreq-fd944fdce62c

Best regards,
-- 
Aaron Kling <webgeek1234@gmail.com>



