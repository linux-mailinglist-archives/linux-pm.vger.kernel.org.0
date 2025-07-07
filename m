Return-Path: <linux-pm+bounces-30315-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EEEAFBD4D
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 23:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6758E3AF173
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 21:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFF8286D77;
	Mon,  7 Jul 2025 21:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqbgVe9Q"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F5426F461;
	Mon,  7 Jul 2025 21:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751923040; cv=none; b=b0LX4tMKcehZ24zGyS/4Lb5xvZ2dDakb6Y9BepLYmqtXhEeL2guQ9bGQgItf5bw5fjEymq9imbk8E/3G3uBkxMdc+nuMnQKZVs5Shiv/9VmyMQZrl2ZfrldJ8lZOhlWF/yWXx6GuTdOvbvT6P8QoNLOc7W0vtPZsL6lMRlrjfXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751923040; c=relaxed/simple;
	bh=spVKuusUmls0x7fzhA+IZ9QsKyxKwuvpvw4aONaFEBA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fE5h6sO/kvOM9gk5z/XWv+jkH4c4RdU8qRNj/hbRRiCv8kKHxHOkcn7W0/GrThosJ9Cmt2rVhNyIYk8MDRferLScS8msiuj+X6G+IaFaW6iqcW/GwYEN8ObcUkdHBUEf99yesC8pPE6DWuYgcSfkd8LqG8+Sx6qqPuO0WU4B7gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqbgVe9Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17297C4CEE3;
	Mon,  7 Jul 2025 21:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751923040;
	bh=spVKuusUmls0x7fzhA+IZ9QsKyxKwuvpvw4aONaFEBA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=qqbgVe9QGURaFA1os5vtPY2rXmNQMIUzuFdqv3aBhh1R6QzcrREQTQto9GX3SQuEV
	 h2g/SPKgFG1UxCat/LfTLAbKaHX2rlEtj380BynUvk4tlNThR8XxdxN4Q3SWLeIkDC
	 40t/jz2fg1bHmR3qPKwEKDyOTHp07E85QlMY7BibmDNx+/LsU8fy6S3x+WP8m0G3ra
	 FFJgfsxCI86f5jFEhcpSCd26SVM8kfSuMwqKbZZWlAF00GJoLa5bdNinvgy6M380Ab
	 BcCsv4imKZeB0w1Cph5nm2QU/ycVF+a5UbDJkCea7Wtg1LS/6WmfgKLP6dC6juN+nv
	 nyMIo5SktiaZA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CA6C8303C;
	Mon,  7 Jul 2025 21:17:19 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Subject: [PATCH v6 0/3] Support building tegra124-cpufreq as a module
Date: Mon, 07 Jul 2025 16:17:12 -0500
Message-Id: <20250707-tegra124-cpufreq-v6-0-fe69c0f9bbab@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFk5bGgC/4XOwW7CMAyA4VdBOS/IcZ205cR7oB3SxCmRBoUUo
 k2o776AkEBdpR1/S/7smxg5RR7FZnUTiXMc43AsYT5Wwu3tsWcZfWmBgBoIlLxwn6xCku50DYn
 PMviWKHjHBp0oa6fEIX4/yN1n6X0cL0P6eVzI6j59Ygh/sawkSLBUB1ZooFXb/mDj19oNB3HHM
 r4DC99kLAAGRY3jYEk1c6D6D6gK0Gq2nW1NQ6aeA/QCNDQLABXAK8LOdR6wojmgX0ANuADoAhh
 ju8oQWF3DOzBN0y8A62bptAEAAA==
X-Change-ID: 20250401-tegra124-cpufreq-fd944fdce62c
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751923039; l=2020;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=spVKuusUmls0x7fzhA+IZ9QsKyxKwuvpvw4aONaFEBA=;
 b=ZIYCBHEkyiHMhdu1xPPrsifbiCYlpAHHiKY2853/pG8Z+lW4CYu5R/n70dC2fcV0sg+dTb3pH
 X2k/tC7i+BjBmhN2ADIMKGN1D/aRBylO7LO8Fqo0ywa7b8xjYebtUDl
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
Changes in v6:
- Simplify one of the error checks, per review
- Rename the global platform device to be more descriptive
- Link to v5: https://lore.kernel.org/r/20250702-tegra124-cpufreq-v5-0-66ab3640a570@gmail.com

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



