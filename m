Return-Path: <linux-pm+bounces-32967-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D87BCB335B3
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 07:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D22761B2224F
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 05:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A5521ADA7;
	Mon, 25 Aug 2025 05:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDA6Ykw7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A257211F;
	Mon, 25 Aug 2025 05:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756098192; cv=none; b=EZYg9egADUX4PlICIhhYNU5/08QLuelpInaub5hAYk/DwNsjJFmlvoneTpQ1vtKlaAX4MtB3QEeLmdT4tlzE18ir8pWNfSC1Rs3HRRJ/b4ijjwS499Uld3SrLIuaZN388l8B6t3B8nttHSv9sUH/m8+MHzVEZ4DcswYu9UuE528=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756098192; c=relaxed/simple;
	bh=XVbqmF7jtp2Ja21RumkRR9Q09c1wFkJyPqA5r5bYEQs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=X6wtcj1ojA7uHOwEA6s+G54mkx4ptQNoxsUvM/LQlvGQljp9WcX8BD5jawM8mwUD17+2ptq3LxDYfcupXatgFWDiW6YRAahnmizkPDdFc8b5Q8VrydrLl7vaRnIdIbXJHPnS9zEGaXkF6n3+E5yd8fQ2TvHSpX/EOnSRm1kCRm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDA6Ykw7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1455FC4CEED;
	Mon, 25 Aug 2025 05:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756098192;
	bh=XVbqmF7jtp2Ja21RumkRR9Q09c1wFkJyPqA5r5bYEQs=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=VDA6Ykw7bZNm1d7yISzYb9gDZ6f1MoHRF7lzZJfq49t0QyWTT4ZqQzuuhcfStBJo2
	 cwh47lgbOCAO7sHoc9+uQF6/v2/4Kys8tUmAmshMuAD/gUYmSa9wf4hVXLud63VZPs
	 8q7qldmN+rXgceaax73wvCvsIpB69hTzXKMf8RjhGEP7dIusjb0043UGNRBSepmLe1
	 MIh1e13/v+Wg31lE0u1R0vL3TtCNzdkvXF+szeUUj0fc5njk8B/sD1Ag40Urw19ycq
	 i0UYgSh79/scKrG2yVTb/uKoXXF6ppSTLnF+hE+WAxR5Ocb6F6QUObM9RF9E7c0aeA
	 FqhaOC5Cg4kjQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BDFCA0FE1;
	Mon, 25 Aug 2025 05:03:12 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Mon, 25 Aug 2025 00:03:07 -0500
Subject: [PATCH] cpufreq: tegra186: Default divider to 35 if register read
 fails
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-tegra186-cpufreq-ndiv-v1-1-4669bf8f2992@gmail.com>
X-B4-Tracking: v=1; b=H4sIAIruq2gC/x3MQQqEMAxA0atI1hOwoWqdqwwuao2aTXVSFUG8u
 8XlW/x/QWIVTvAtLlA+JMkSM8yngDD7ODHKkA1UUlU6srjxpN64GsO6j8p/jIMc2Ie28UTOWN9
 CblflUc73++vu+wGbzNXbZwAAAA==
X-Change-ID: 20250824-tegra186-cpufreq-ndiv-bc97a22814a9
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756098191; l=1487;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=rfEcX8ls2L9Ghv6edI8v1CbFCLor3x2WRkwzlxZtph0=;
 b=Ut5weYR7xRwt2M+dlkUv1X8ffkKCHS5+SOthr91vOYmx3+lpcgnUN2WPB3d+b1HVn5TlJnnqE
 Y95qQ6uDk/uAb7Qt2A03opxPaUffsn0mbPZuC6O9sd+AU//d46EdphX
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

Several of the cores fail to read any registers and thus fail to
initialize cpufreq. With shared policies, this only affects the Denver
cluster, but one of the A57 cores also exhibits this behaviour. If the
value is initialized to match what is read by the downstream vendor
kernel, scaling works as expected. I have never seen this value be
anything other than 35, so it should be a relatively safe assumption.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 drivers/cpufreq/tegra186-cpufreq.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-cpufreq.c
index cbabb726c6645d2e5f1857a47e5643c8552d1933..f017f903c6843f1881e8311753f6269637c6bc69 100644
--- a/drivers/cpufreq/tegra186-cpufreq.c
+++ b/drivers/cpufreq/tegra186-cpufreq.c
@@ -115,6 +115,11 @@ static unsigned int tegra186_cpufreq_get(unsigned int cpu)
 
 	edvd_offset = data->cpus[policy->cpu].edvd_offset;
 	ndiv = readl(data->regs + edvd_offset) & EDVD_CORE_VOLT_FREQ_F_MASK;
+	if (ndiv == 0) {
+		dev_warn_once(get_cpu_device(policy->cpu),
+			 "Scaling registers invalid, using expected values");
+		ndiv = 35;
+	}
 	cluster_id = data->cpus[policy->cpu].bpmp_cluster_id;
 	cluster = &data->clusters[cluster_id];
 	cpufreq_cpu_put(policy);

---
base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
change-id: 20250824-tegra186-cpufreq-ndiv-bc97a22814a9

Best regards,
-- 
Aaron Kling <webgeek1234@gmail.com>



