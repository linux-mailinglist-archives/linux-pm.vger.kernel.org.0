Return-Path: <linux-pm+bounces-25808-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8920A9554F
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 19:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0964188E446
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 17:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99061E5718;
	Mon, 21 Apr 2025 17:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9hlLUlG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA461DF984;
	Mon, 21 Apr 2025 17:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745256839; cv=none; b=CMSkjXyf2QTA/DbbEauZh4Sd7HA1GlvMq2Tb5aKDZhi/Q1h8ee0CwqjRN1VzKc8kRWd+QT8dUPYP5lq+V+gCBI/6xt5MTKHLuLr7XfaPZw4MYVjtFtxy29NKYK3UYLav9rzPTxV1E7bP76xmE/AGLTPp6VlReIEgH1l4ZDNjMbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745256839; c=relaxed/simple;
	bh=an4XT5sgGD6GiQNc4+ujYYfFrngTMsWP8TIiMqbzahc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OItPGmQNGKIxymQ8rasMfC9xsEnTTv8/x2yvGBIehRF4z4LQhcffrHpuvdQpfR1UcDmiAG1oYYT/7TfXNJ6BTPTkc0gOOAgFMb5TDnhdc9DlpZs5gN7ux0S2VdoRGmuWV71/BTQYFhAuYkTF6kQRQwUkbLdLUaAboYvYy2P+YiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9hlLUlG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34DB4C4CEE4;
	Mon, 21 Apr 2025 17:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745256839;
	bh=an4XT5sgGD6GiQNc4+ujYYfFrngTMsWP8TIiMqbzahc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=M9hlLUlG0Q4rrdXhvxjYsrLsnoIVwluXJ72iGCoVqPXEk0hqF/lGbL04YCjPfJvmL
	 Bkol6+akiQJA67+Ry47+jnz4B6JeJ2qRgeq6u/BWnbrvtJOsZLFK2eroBmlGNhHod8
	 OYkBZSZ3nCx9n4TzAyOSowhDGEvb7I5fvdtk85lXUlicAbCYUSvN5xfOzf3iheTG7H
	 BF/uWAFrEu3Oz9FHmJvqQC53C8Q/Q4ZIsxP9slh6Fmy/LkWM5Sf8DHUAYcGCp1U0aV
	 kEewKAWmHnK7SDYx7Sgk8WJLE+mo1zmRDUE/V0AEx7Vqqw2B9m2yKQRTp32n7CknQg
	 u5FGEWMYkOO4A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D73C369AB;
	Mon, 21 Apr 2025 17:33:59 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Subject: [PATCH v3 0/2] Support building tegra124-cpufreq as a module
Date: Mon, 21 Apr 2025 12:33:52 -0500
Message-Id: <20250421-tegra124-cpufreq-v3-0-95eaba968467@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAICBBmgC/23OzQ6CMAzA8VchOzvT1ongyfcwHpbRwRL5cMNFQ
 3h3B/FAosd/k/7aSQT2joM4Z5PwHF1wfZfisMuEaXRXs3RVakFAR1CAcuTaayQlzfC0nh/SVqV
 StjKckxFpbfBs3Wslr7fUjQtj79/rhYjL9IsR/GIRJUjQ6mQZKYcSL3Wr3X1v+lYsWKQt8OebS
 Akgi6owbLXCYgvM8/wBg+CXXPEAAAA=
X-Change-ID: 20250401-tegra124-cpufreq-fd944fdce62c
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745256838; l=1232;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=an4XT5sgGD6GiQNc4+ujYYfFrngTMsWP8TIiMqbzahc=;
 b=xCB/vHo+bw5EXi3xw2qeWcQVcOddGFRZBrnWmZpWdWMTX3bX2BX5l8J7IIKyCqxuH7opso136
 qngoqLZo5SgDsIGoKhRCJEPLyDOlw4S73FUq4g80UWMQjEHFny2Sw3Z
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
 drivers/cpufreq/tegra124-cpufreq.c | 46 +++++++++++++++++++++++++++++++++-----
 2 files changed, 42 insertions(+), 6 deletions(-)
---
base-commit: 91e5bfe317d8f8471fbaa3e70cf66cae1314a516
change-id: 20250401-tegra124-cpufreq-fd944fdce62c

Best regards,
-- 
Aaron Kling <webgeek1234@gmail.com>



