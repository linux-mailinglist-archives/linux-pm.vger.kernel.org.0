Return-Path: <linux-pm+bounces-8641-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D93568FCCC8
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 14:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 467F7288EBC
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2024 12:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776D619924D;
	Wed,  5 Jun 2024 12:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDLRTeKl"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5B8199241;
	Wed,  5 Jun 2024 12:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588951; cv=none; b=U3IAgF1mKbPD1w4SbrlpI3cmjO/U+63UMiMbSkjKbq+3KDHOajUw01zSJ740iGtT7nlsKxi5e3NCto9XRgjYJkP8mwciq4CSX0aB0I4Dp3brqEykpR5G9qvtkZqfWxwlSAnWb9AuJ0+2GEFbYHBlVnnXvm9Wp60prz+3gKptDBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588951; c=relaxed/simple;
	bh=hGDS1MidQGjaw2AvQaBkZlpc9DSRzLZnAViFmyzxi0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pNcUHrvJf9cye+UCZul5aH13LdvIpqu1X6BReRnb1leoB0bgwUVqpftuYoA1v5KLiKND/PFC0+0ZC5yP2ATpalvpW1jFmypOD4nsaw5qIfohwKsMkfaOXKmzJAdsaHagvTeH+c+7CMZzLHUc8ordQ7PSHfDbWIRsJOIjvT1MC/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDLRTeKl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D3BC4AF0B;
	Wed,  5 Jun 2024 12:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588951;
	bh=hGDS1MidQGjaw2AvQaBkZlpc9DSRzLZnAViFmyzxi0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JDLRTeKl07VU272zYxcJGan5M+dFiD016QWljQ6lO44FK7EqfpfTUIj65oj0+LcMZ
	 gHMznnMZMqV9hT7qbH/IoTqi1v0NnYGWgagrIi0CpIinz2QWe7Z2EAI6QQUUSopffH
	 jkD4H9f15DmDV8DHSV/4zPolgKr9UY2hIeUnnI+81utCVx5tBYE9wap2L9NfjhiZk1
	 63LAwnHs2ymTlJor98eJtsvPnRP1BI0X1xFvtiocJbCP9/0pz3m0+tMVClk3UYuMnx
	 PW+A9MtkdZhWYXDtO/DQ8lcXjm7aI/rukP6EVRQ6Y3ipl1x4D2h5nx9WJ84AQjpdER
	 N9f4LeInqxmUw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Petri Kaukasoina <petri.kaukasoina@tuni.fi>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	len.brown@intel.com,
	pavel@ucw.cz,
	linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 05/23] swap: yield device immediately
Date: Wed,  5 Jun 2024 08:01:48 -0400
Message-ID: <20240605120220.2966127-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120220.2966127-1-sashal@kernel.org>
References: <20240605120220.2966127-1-sashal@kernel.org>
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

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 712182b67e831912f90259102ae334089e7bccd1 ]

Otherwise we can cause spurious EBUSY issues when trying to mount the
rootfs later on.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=218845
Reported-by: Petri Kaukasoina <petri.kaukasoina@tuni.fi>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/power/swap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 5bc04bfe2db1d..c6f24d17866d8 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -1600,7 +1600,7 @@ int swsusp_check(bool exclusive)
 
 put:
 		if (error)
-			fput(hib_resume_bdev_file);
+			bdev_fput(hib_resume_bdev_file);
 		else
 			pr_debug("Image signature found, resuming\n");
 	} else {
-- 
2.43.0


