Return-Path: <linux-pm+bounces-8636-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 768488FCB47
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 13:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1A04B21AA5
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 11:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103FB19ADAB;
	Wed,  5 Jun 2024 11:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6Wehzt3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB2519ADA6;
	Wed,  5 Jun 2024 11:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588228; cv=none; b=ERAeFgWdunHaiwreZaVKTv0TvV5t2I0yQ29ZaQItKPSa18a5Qy6PStgNiRJEzETFJ8ih/pBuRlK+RECzm/SUW4quqVApO9QGjoJE7oDwblhLVHTftGnL4YaGuRjV1DIvM2fcTx+cpAuLgdAWM0REz1KeW9AbINLzO61L8JpU6w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588228; c=relaxed/simple;
	bh=NcXz8TapCZDDTdXu2QlDm8BCujGH0K94hgrdOa/LTzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dx3TlYbFg41u2jjS3iuVwQNsWQx+hcbn5CUSAK+T5c5l90t3d8+RomA1GnzLQaX+IFvB9UKjctzRY+oUF4UP9W+1ja9HhyHX6BrSIMNaBqyXb6k9IRrSSajQKSy600oqAuyUos5QlAtdhiONZ6elSDIWbqm+F8LINEec+teFZc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6Wehzt3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CC0C32786;
	Wed,  5 Jun 2024 11:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588227;
	bh=NcXz8TapCZDDTdXu2QlDm8BCujGH0K94hgrdOa/LTzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k6Wehzt3cEtTkT9I6cH2XkMW1VthKW8eiZN0P0j8eRT/wzT9K65IbLTFMk/POCza0
	 KlFg6nstaK3C/akQi0K7DHBfaWI/XIEym2tbjwAOVVvbr03xJzc6mY8UoFefsxd6LY
	 L/Re5KHD7zFmA01nMabAcb4ek5vezAXO8hTdhWlKLQisC+JBIxnLVhPrGmNcbu0krs
	 rfHezQgRxXKPJ3CBeQ0twkrmnI9iO0XZULfUB/Wcky1HrnZNP69mxz66Haaiwqy5wV
	 W+FCNjkUL3XNNzcHqQ8FEYV7UTIBrR86xEzZjxy+/LKGNOqUTS1BXal1m1b0c386Pa
	 ZkN5rSY3Ye+Tw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peng Ma <andypma@tencent.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <Perry.Yuan@amd.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	ray.huang@amd.com,
	gautham.shenoy@amd.com,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 25/28] cpufreq: amd-pstate: fix memory leak on CPU EPP exit
Date: Wed,  5 Jun 2024 07:48:54 -0400
Message-ID: <20240605114927.2961639-25-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605114927.2961639-1-sashal@kernel.org>
References: <20240605114927.2961639-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.3
Content-Transfer-Encoding: 8bit

From: Peng Ma <andypma@tencent.com>

[ Upstream commit cea04f3d9aeebda9d9c063c0dfa71e739c322c81 ]

The cpudata memory from kzalloc() in amd_pstate_epp_cpu_init() is
not freed in the analogous exit function, so fix that.

Signed-off-by: Peng Ma <andypma@tencent.com>
Acked-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Perry Yuan <Perry.Yuan@amd.com>
[ rjw: Subject and changelog edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/amd-pstate.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 2015c9fcc3c91..097268e7b0aa8 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1378,6 +1378,13 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 
 static int amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
 {
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	if (cpudata) {
+		kfree(cpudata);
+		policy->driver_data = NULL;
+	}
+
 	pr_debug("CPU %d exiting\n", policy->cpu);
 	return 0;
 }
-- 
2.43.0


