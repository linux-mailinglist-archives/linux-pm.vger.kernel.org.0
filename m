Return-Path: <linux-pm+bounces-34162-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08844B4930D
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 17:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A857044733F
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 15:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758E330CD89;
	Mon,  8 Sep 2025 15:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJExGRa1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABCF25634;
	Mon,  8 Sep 2025 15:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757345067; cv=none; b=dJkTKY+bChF0ZEFbXqe5pmgVLkEw3gxjmtbwc4KQpzaGMk+2ERQh4pJLsaRZmcbTDsTWw4pr+i5MHx9G4DB9Kq1J6zkw4988PKAFp2h5C8zsIH+oYsoMUtrHMYsUf/NecZyHFMPCe3HMo9yTaJiiaT5MyuOLfusRGz+G3Ale4ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757345067; c=relaxed/simple;
	bh=XGZbwTONSmzAq2Qk/5cr9aqST0TZSvlYH6pzLmFcKTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CcjvYRXLc8/LDKyFeGrMN2c27qnKjknG8w4vaHrgUKrnl8ECFuz643c9lBq+M02ceoA1P7LaRsoERu20mFE6o9xZq4064vIIMn2u0gKbKs39b8tOOKTzD0lZAOHNgQbYq/Ili2ETt/3I54MkpzX/N+VFVKKFdmmHRhOGHHPNUuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJExGRa1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 066D2C4CEF7;
	Mon,  8 Sep 2025 15:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757345067;
	bh=XGZbwTONSmzAq2Qk/5cr9aqST0TZSvlYH6pzLmFcKTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aJExGRa1uSAxPPR69okuzb67kOPyztd18IYtOdhu0fYc5ebUNgG8Ggdamq70Rnd1k
	 om35DBKqj7KGW5lC8KvGxRTavvHqMky4CgbPXfCB9IDAjwTWqZt+Ors2aeM1hmeVCG
	 FH++ZOBq8YTdp4Ca0aXnqGuyikQQaP0cfxelz4DR2VuNG5PRW+Jt/NvAoHz/JaCCvK
	 z0dKmFu5r22sQStLq2nNsSjGq4mmA82vTfOZYxPrutUMisoKfPMPEIzet64LkORUD2
	 2VcIrdGiZOM/6CQm3NamnfMsxGlolC4YoSdaNRjzYfxPTYs3uk9U0ivoQGtj9hHPM4
	 xl0buuyk04Xuw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1uvdjF-0000000080c-22Mh;
	Mon, 08 Sep 2025 17:24:25 +0200
From: Johan Hovold <johan@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/2] cpuidle: qcom-spm: drop unnecessary initialisations
Date: Mon,  8 Sep 2025 17:22:13 +0200
Message-ID: <20250908152213.30621-3-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250908152213.30621-1-johan@kernel.org>
References: <20250908152213.30621-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the unnecessary initialisations of the platform device and driver
data pointers which are assigned on first use when registering the
cpuidle device during probe.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/cpuidle/cpuidle-qcom-spm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-qcom-spm.c b/drivers/cpuidle/cpuidle-qcom-spm.c
index f60a4cf53642..7ab6f68b96a8 100644
--- a/drivers/cpuidle/cpuidle-qcom-spm.c
+++ b/drivers/cpuidle/cpuidle-qcom-spm.c
@@ -86,9 +86,9 @@ static const struct of_device_id qcom_idle_state_match[] = {
 
 static int spm_cpuidle_register(struct device *cpuidle_dev, int cpu)
 {
-	struct platform_device *pdev = NULL;
+	struct platform_device *pdev;
 	struct device_node *cpu_node, *saw_node;
-	struct cpuidle_qcom_spm_data *data = NULL;
+	struct cpuidle_qcom_spm_data *data;
 	int ret;
 
 	cpu_node = of_cpu_device_node_get(cpu);
-- 
2.49.1


