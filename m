Return-Path: <linux-pm+bounces-26423-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EADD3AA3D01
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 01:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27E014A0737
	for <lists+linux-pm@lfdr.de>; Tue, 29 Apr 2025 23:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFE93A8C1;
	Tue, 29 Apr 2025 23:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEq8u/jY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F162AEE1;
	Tue, 29 Apr 2025 23:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970612; cv=none; b=JFYoqtDFaDA+o3A0VOJY01X7O0eYqu21XCUY95DUtfMHDpdEJrYswFFHMSoJNSAnunUwJoNdMObEel0cZ0qUAgek6zPefkAX8GZBCWBx+wi0qg9WuPB81zgMk+rJ70qIc6IHK9v0yx+MtrBVaVqbZIC58Qpmv2Im9xDLrygvuwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970612; c=relaxed/simple;
	bh=HVEueuu+ENA76E+b+CMuWUBOKzqvlka+U7t0nkPV2EU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZnDl8WuUiMa/kShq3FPzJiRzHGa5oqo1db7hew7duMSJTf3EPj1uRMXO420kPz6vJr27nIwzp1ZOxYXOpiGMr1862XJOHUaddCWcfsai3WCiwk7m9oYymLHypPxuMMN+rhz8KZ3KQW1G10BoP9m0gJos13mf1y+3u0VlUi4I10Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEq8u/jY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E803BC4CEE3;
	Tue, 29 Apr 2025 23:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970611;
	bh=HVEueuu+ENA76E+b+CMuWUBOKzqvlka+U7t0nkPV2EU=;
	h=From:To:Cc:Subject:Date:From;
	b=iEq8u/jYX5MK2HLSWQ8qjcuiqdO6uWtQVzbsx1VQcexnSTab9dIxTv+J5Rre7yD5h
	 RQjE6464yctegHAhvrJ1aST83dEqeHbb4cQlicKRnxZPqr7hW76/o7liHgXcj3AuZ/
	 d+bY+Qy+GyVoffa8Qur9JcWshVhPMFWlcZwAuqi/9LsJqJgjW7VoYzKK6ptBpgsBPg
	 XecVGjjH5HmFF4OCjUpImrP67qDe0B+NzAwMNcoqnoBUa8WI17iDnw6A8yYNmBv1vt
	 k6RoLL7FQqGe0Um1K73EJCpki6LNqlnaTUjLnWxxMFzySWh8PmX0lz3HhzNB/HceXP
	 mWwTX3g5OzxdA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pengyu Luo <mitltlatltl@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 01/39] cpufreq: Add SM8650 to cpufreq-dt-platdev blocklist
Date: Tue, 29 Apr 2025 19:49:28 -0400
Message-Id: <20250429235006.536648-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.4
Content-Transfer-Encoding: 8bit

From: Pengyu Luo <mitltlatltl@gmail.com>

[ Upstream commit fc5414a4774e14e51a93499a6adfdc45f2de82e0 ]

SM8650 have already been supported by qcom-cpufreq-hw driver, but
never been added to cpufreq-dt-platdev. This makes noise

[    0.388525] cpufreq-dt cpufreq-dt: failed register driver: -17
[    0.388537] cpufreq-dt cpufreq-dt: probe with driver cpufreq-dt failed with error -17

So adding it to the cpufreq-dt-platdev driver's blocklist to fix it.

Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 2aa00769cf09d..a010da0f6337f 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -175,6 +175,7 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "qcom,sm8350", },
 	{ .compatible = "qcom,sm8450", },
 	{ .compatible = "qcom,sm8550", },
+	{ .compatible = "qcom,sm8650", },
 
 	{ .compatible = "st,stih407", },
 	{ .compatible = "st,stih410", },
-- 
2.39.5


