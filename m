Return-Path: <linux-pm+bounces-30314-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7748AAFBD50
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 23:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 528B57A813F
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 21:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF81F286D5E;
	Mon,  7 Jul 2025 21:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmuBv55P"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FC2285CB3;
	Mon,  7 Jul 2025 21:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751923040; cv=none; b=nZ4JkzP4RU45UYDaFsajgFW6PwbREdzIYwNCg1cCXr1ZxuF2vz8uze2BOeh0NYgLMvtDjXV3OtRq5SreZE4GEvl7qBidK+A3SVGOX9SmidyUG0IArgo0l2Ykjbzg4eIejU0hpRsSjn2C/nyUchHQWXF0gcjc/Dm5aZKnr6W89B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751923040; c=relaxed/simple;
	bh=XUqrxevcySUgm7p5WtPmWVKyUTemkuPq3v/8JCmiCIk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cVhJX+Tc2tI3V0Op/OWEtyGGWA4Muzf/FULNghCmLEoBQye1Fj/zrkP0O+DITj2b6dfeYnjBLHipfB+NNMPdxnXFQ1RmIEmuMx02PjKTTCRIAUR+mbNJfqBewB+7ZLvUlx2qMX9MBhzc4jBoMJHd2fE5OIZGC27MLgJisYmSn4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BmuBv55P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25CCEC4CEF1;
	Mon,  7 Jul 2025 21:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751923040;
	bh=XUqrxevcySUgm7p5WtPmWVKyUTemkuPq3v/8JCmiCIk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BmuBv55PvgbYzuUKw+KxCe73ssXdUEZvdcR4DN4i3yxSl8qOg3t4SNxF+52IDIZmu
	 ADdww0aiAAgQ2btC3P5ZuUk1cnfOzycA+uaLyKDikqI4YEae3wcsnD9KBBYzh1t2A5
	 ICCCjQKyefx+mBQYLpKCHp/peORB4Gw1DOqGmWLvoMkKU4rNHTnTcud69uVq309J8b
	 3w7Aj8ghfN/e674jqcVwD2OmnhK/LonT/LcOfTnnAgRRvajjPog89PlwhbZAf5i4OQ
	 tFOYQ47EECiavNN5hP/HNY9nnX8mtgWzhFSuI1anMpbMbrCFLAwTEB4SHTv0wkEoAe
	 X/BsHHvpNTiKw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148BAC83030;
	Mon,  7 Jul 2025 21:17:20 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Mon, 07 Jul 2025 16:17:13 -0500
Subject: [PATCH v6 1/3] cpufreq: Export disable_cpufreq()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-tegra124-cpufreq-v6-1-fe69c0f9bbab@gmail.com>
References: <20250707-tegra124-cpufreq-v6-0-fe69c0f9bbab@gmail.com>
In-Reply-To: <20250707-tegra124-cpufreq-v6-0-fe69c0f9bbab@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751923039; l=614;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=NFHbo8ZLsnmTINee5fdPYY+g47zvEQ1GnvuQon0Ga54=;
 b=SYN1C3omppLTHmdh/N3jYvRNM8zPPiu4wxHYor/Ky6k+sIPYa4crIEGfGSX57vy0vWPOK/foB
 gQ9x/Dj5oIdBijvZaiyJm9kq2v+uDeC4ISAuyxTqTnU2IkMzcLzjEpy
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

This is used by the tegra124-cpufreq driver.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 drivers/cpufreq/cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 0cf5a320bb5e864709b259249fb1af8bfbc0b04b..78cddc78ee98630f99ccc332c64c94f437297177 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -109,6 +109,7 @@ void disable_cpufreq(void)
 {
 	off = 1;
 }
+EXPORT_SYMBOL_GPL(disable_cpufreq);
 static DEFINE_MUTEX(cpufreq_governor_mutex);
 
 bool have_governor_per_policy(void)

-- 
2.50.0



