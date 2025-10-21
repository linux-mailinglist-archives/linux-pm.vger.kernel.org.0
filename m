Return-Path: <linux-pm+bounces-36571-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7FABF6EA8
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 15:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 616F5468138
	for <lists+linux-pm@lfdr.de>; Tue, 21 Oct 2025 13:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3CA338F5A;
	Tue, 21 Oct 2025 13:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ocq0RCmc"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0141B3396E5
	for <linux-pm@vger.kernel.org>; Tue, 21 Oct 2025 13:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761054731; cv=none; b=oSbDA6rbkrvG+U4gXXjqGPDIluIppFsL6sNGcpvLiFOBeKKbGq+DXHgAVt1mx2/oWA1yidwKVt14F3XW7gNM6n8CdpIAt230s8/tO44Ud4rLeszno6TaFlm2Ap7U9oqKymkOuRQAPbDsrMLfNnPRBQ040zXVQXkNXifVaoWHgt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761054731; c=relaxed/simple;
	bh=6HYZyxfO9iFbzL/zXee0a1zOYg3eTijXuBn4O4T5f/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MSS1dOBvkbl6+OLbDQtSmwv3FNki1PzWJnopU78MY532KdYKi2hY6L9MyGP3Eol7qLB4fiuR29u3y5W7CM+CqfECVTYJjBufYoBYQYU0csRtsozApHf5WvNJgHMZ94i+GH23W657yzvJ3FGqIkH+43ojNhejes5YOnky/8yEc9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ocq0RCmc; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761054727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AbPelCfaCppufecbb4jO2PrWSc+xFeVMvqVbKUJbxG0=;
	b=Ocq0RCmcer8ptr29ntOH5jNR0A3phTJh/6MmLlfjd8JW2SRRwr1r6nTvNiFLxuoetLMGPl
	qcA9W+gfB+0IxOqfX5vxNKDlA5p23GRCMWI9fQmZpmnE++Hq3EYpA1MthlqhUs8rB5DcD3
	s8X0AUIURBQ7mNkagBl7P2JgBsqEzDA=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] cpuidle: psci: Replace deprecated strcpy in psci_idle_init_cpu
Date: Tue, 21 Oct 2025 15:51:53 +0200
Message-ID: <20251021135155.1409-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use strscpy() instead.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/cpuidle/cpuidle-psci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index b19bc60cc627..e75d85a8f90d 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -382,8 +382,8 @@ static int psci_idle_init_cpu(struct device *dev, int cpu)
 	drv->states[0].exit_latency = 1;
 	drv->states[0].target_residency = 1;
 	drv->states[0].power_usage = UINT_MAX;
-	strcpy(drv->states[0].name, "WFI");
-	strcpy(drv->states[0].desc, "ARM WFI");
+	strscpy(drv->states[0].name, "WFI");
+	strscpy(drv->states[0].desc, "ARM WFI");
 
 	/*
 	 * If no DT idle states are detected (ret == 0) let the driver
-- 
2.51.0


