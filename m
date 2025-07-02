Return-Path: <linux-pm+bounces-29962-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3293DAF0CEB
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 09:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C4357B2533
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 07:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B11E23371F;
	Wed,  2 Jul 2025 07:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNrvLHRm"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDC523184F;
	Wed,  2 Jul 2025 07:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751442409; cv=none; b=Y33ESIi1ZIkRwoVHjsAOgjN03BSTn+v6Mpo4W2A8hmQkvwlznav9sYrh9V5qfhr6ckkHWTMF7RiG1Jh/V17rbxFDVK50nt6G2O+GfNXq2TFIobuNguE0sPL9Yqqbg7E2gt5VhdGf1/8EfJq8xvM3FtkNE08zh56wpQgJO65hOpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751442409; c=relaxed/simple;
	bh=XUqrxevcySUgm7p5WtPmWVKyUTemkuPq3v/8JCmiCIk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MVLvUCaQl7I3QRMYZvWBptce4vTq8reDMlNEOjk7jCPH+1u0u4AfmpE9GRi2qhYcDEdFwgG8CM/JvhGdbyh1yQNlBcIaOf+ePhq9lcreZ75Ew1rwHKTvGp5c/1b4MM8SsRkM4rDfMqCrb2nd4SV33g3hQ2fwpOBl1McHUn9CAws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uNrvLHRm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8228BC4CEF4;
	Wed,  2 Jul 2025 07:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751442408;
	bh=XUqrxevcySUgm7p5WtPmWVKyUTemkuPq3v/8JCmiCIk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uNrvLHRmHFhS9zvL8WtcBmE++kWowUWrlPjQnXjdE6ZrJzhEreCH3Tc6AwW7fV3CP
	 TpywUflfGMyd5g1eJqCkyEVAr1EJvioHMWYsoFiBiUrJG7JMGB4XvXKTTtmmmvZd5A
	 fBRcTZEuc+JVmtS8XFqHYtQ+A7BqRjwPwnM/p0JQoQUBUAK54Ns9uV70wSFh+3sx13
	 JJslhFAUXbmfGclqby/buvYGGqhowGOJadiiWmuWZF4t/hQkYC5BWZAGcxQjbiRoiZ
	 HhePmSawDursio8OtZGUj2j2zuVv48wRB3dXW+Fauj+Of3pnzeDWTwebr0HI0YqQOO
	 kxjzH793CxH3A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C2EC7EE30;
	Wed,  2 Jul 2025 07:46:48 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Wed, 02 Jul 2025 02:46:24 -0500
Subject: [PATCH v5 1/3] cpufreq: Export disable_cpufreq()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-tegra124-cpufreq-v5-1-66ab3640a570@gmail.com>
References: <20250702-tegra124-cpufreq-v5-0-66ab3640a570@gmail.com>
In-Reply-To: <20250702-tegra124-cpufreq-v5-0-66ab3640a570@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751442407; l=614;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=NFHbo8ZLsnmTINee5fdPYY+g47zvEQ1GnvuQon0Ga54=;
 b=sq6Fw3hxaW3eVkR+hfnJhFHsc/U13j7iTnX1Xm2A9scCGSGp/1xKOrUm7kVL2qH6+umGrfeU2
 mUmZ6u+16wcBVh4AW8pEGX/z9PL6B4I8/Ftnr9HnUPtc/OR+tKWLZ8C
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



