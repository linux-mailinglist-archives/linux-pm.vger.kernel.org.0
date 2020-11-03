Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E9C2A491D
	for <lists+linux-pm@lfdr.de>; Tue,  3 Nov 2020 16:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgKCPNa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Nov 2020 10:13:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:56810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728328AbgKCPMD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Nov 2020 10:12:03 -0500
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95C4422370;
        Tue,  3 Nov 2020 15:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604416322;
        bh=AJNvZQquMu11B4hKwW4R4Rgw+TUPue4FOo3NvQ7oduA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R+4aFSEDCifHTEwe8rdYaHUK37BU9CaHHHwq6/rKFgGjMgBVXd+OP7z6m9y3PEq6z
         kRj5+733BsWeWaC8GqLRzX/TbKATrhPx7cZGeG44bkJ0+p3GzzsPpAUuymLwdXUwPI
         lZp2TDJsre/Xyh3X1FZdW6YBbqyDTQ5ciblOBLC8=
Received: by pali.im (Postfix)
        id A28AA183B; Tue,  3 Nov 2020 16:12:00 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] cpufreq: qcom: Add missing MODULE_DEVICE_TABLE
Date:   Tue,  3 Nov 2020 16:11:34 +0100
Message-Id: <20201103151139.29690-5-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201103151139.29690-1-pali@kernel.org>
References: <20201103151139.29690-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds missing MODULE_DEVICE_TABLE definition which generates
correct modalias for automatic loading of this cpufreq driver when it is
compiled as an external module.

Signed-off-by: Pali Rohár <pali@kernel.org>
Fixes: 46e2856b8e188 ("cpufreq: Add Kryo CPU scaling driver")
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index d06b37822c3d..fba9937a406b 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -464,6 +464,7 @@ static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
 	{ .compatible = "qcom,msm8960", .data = &match_data_krait },
 	{},
 };
+MODULE_DEVICE_TABLE(of, qcom_cpufreq_match_list);
 
 /*
  * Since the driver depends on smem and nvmem drivers, which may
-- 
2.20.1

