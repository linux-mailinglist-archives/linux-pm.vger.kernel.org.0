Return-Path: <linux-pm+bounces-43269-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIJRIZJmoGltjQQAu9opvQ
	(envelope-from <linux-pm+bounces-43269-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 16:28:18 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 010911A8B5A
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 16:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C880312C097
	for <lists+linux-pm@lfdr.de>; Thu, 26 Feb 2026 15:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF78425CC9;
	Thu, 26 Feb 2026 15:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+UD5mOY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBB53F0762;
	Thu, 26 Feb 2026 15:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772118738; cv=none; b=IYGB2J38kIkJ2fNmGA0Gh480kZR+jkJ+301nMysAgoCw0q338NJxTqe3q99tjXdvn9O5xfAjPTaMa1BoDLy6A7im9KhKGaC5I//W0gCPh5D8UXwU6XrauYq9Vs6W1919FtVUuT09fNqQeARrBGXhM/twuDCAZl5WzeR3RJcRA+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772118738; c=relaxed/simple;
	bh=VZxTvHvfZOPXSed1NbaTauV+tJ9rFQii5Qt2++LPPac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NCPabRqfSkzGpP15CzD/rlMa2UsCB+asq4tgWGetSY3cFVbGFYMKTclSpOQWJibImZhe8RNTAOPR5ikA6580JASTeKqXQL//Y+0RUb8H9n6et3n6jYXs6bIs+M+D1JfPESZoaw9cppqOsVE1PVLZAFU0vPbwFQa5uYGXDUCxuzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+UD5mOY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB96BC116C6;
	Thu, 26 Feb 2026 15:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772118737;
	bh=VZxTvHvfZOPXSed1NbaTauV+tJ9rFQii5Qt2++LPPac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t+UD5mOYoGYj18CwmriAuDeMuVf5Q/Nv2Bxw1HdzO6C1YQlpD5gIKuInUQTV66sCX
	 kE0nhZheidWLIwgeu5DNLD716RbIGFfpub70GxiompvXFy3SOt78ypZWKbmJec/Ugz
	 tZvYCNpmNC+B03vDsE/MbjPsCyeZXrDmQhW55Kma9GqUSQqzDw7RQxYuSpW6V+kSSf
	 2E4JtF4jRjtxWZ1xR/R+ensa2PXIogUP1vHu0qhZyiIXPtfycUpb3KFbDMLXRL53kz
	 u+tAzWRFzwLtMNBW+0EUqfsnNLtZI5sjESV64k0QaMPEGqGxXu7YwH3DJj1BRlJBdb
	 wanHdS28C/b2g==
From: Thierry Reding <thierry.reding@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	linux-pm@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 2/2] cpufreq: tegra194: Rename Tegra239 to Tegra238
Date: Thu, 26 Feb 2026 16:12:12 +0100
Message-ID: <20260226151212.4067944-2-thierry.reding@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260226151212.4067944-1-thierry.reding@kernel.org>
References: <20260226151212.4067944-1-thierry.reding@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43269-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[thierry.reding@kernel.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 010911A8B5A
X-Rspamd-Action: no action

From: Thierry Reding <treding@nvidia.com>

This chip identifies as Tegra238, so update the device tree compatible
string and data structures associated with it to use the correct name.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/cpufreq/tegra194-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index 7a41cfc71a46..c6375e14d445 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -196,7 +196,7 @@ static const struct tegra_cpufreq_soc tegra234_cpufreq_soc = {
 	.refclk_delta_min = 16000,
 };
 
-static const struct tegra_cpufreq_soc tegra239_cpufreq_soc = {
+static const struct tegra_cpufreq_soc tegra238_cpufreq_soc = {
 	.ops = &tegra234_cpufreq_ops,
 	.actmon_cntr_base = 0x4000,
 	.maxcpus_per_cluster = 8,
@@ -807,7 +807,7 @@ static void tegra194_cpufreq_remove(struct platform_device *pdev)
 static const struct of_device_id tegra194_cpufreq_of_match[] = {
 	{ .compatible = "nvidia,tegra194-ccplex", .data = &tegra194_cpufreq_soc },
 	{ .compatible = "nvidia,tegra234-ccplex-cluster", .data = &tegra234_cpufreq_soc },
-	{ .compatible = "nvidia,tegra239-ccplex-cluster", .data = &tegra239_cpufreq_soc },
+	{ .compatible = "nvidia,tegra238-ccplex-cluster", .data = &tegra238_cpufreq_soc },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, tegra194_cpufreq_of_match);
-- 
2.52.0


