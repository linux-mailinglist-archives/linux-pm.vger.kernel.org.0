Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3731E2A4912
	for <lists+linux-pm@lfdr.de>; Tue,  3 Nov 2020 16:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgKCPNH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Nov 2020 10:13:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:56866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728331AbgKCPME (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Nov 2020 10:12:04 -0500
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36F36223C7;
        Tue,  3 Nov 2020 15:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604416324;
        bh=2SCeqACj03PGd/cs05vDhJgyNzXG+utuwLiAZJlMUp4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T4bhE4qhMBeVnfK/gOjND7vH3CAKvYAVu/1HctSbrnc5hJosFuhR9zkvSBJEJVUJK
         B2s98ckb0mGA19EfXL1iYlhgqT0fMdvrcEExLCoEwJ3384aC1i0/yyfZkE6ak/wKZB
         tpPz5WjyhlyOmqAy68+FjhqO6L9l02zzem1a4iBE=
Received: by pali.im (Postfix)
        id E45651A0C; Tue,  3 Nov 2020 16:12:00 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] cpufreq: st: Add missing MODULE_DEVICE_TABLE
Date:   Tue,  3 Nov 2020 16:11:35 +0100
Message-Id: <20201103151139.29690-6-pali@kernel.org>
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
Fixes: ab0ea257fc58d ("cpufreq: st: Provide runtime initialised driver for ST's platforms")
---
 drivers/cpufreq/sti-cpufreq.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cpufreq/sti-cpufreq.c b/drivers/cpufreq/sti-cpufreq.c
index 4ac6fb23792a..c40d3d7d4ea4 100644
--- a/drivers/cpufreq/sti-cpufreq.c
+++ b/drivers/cpufreq/sti-cpufreq.c
@@ -292,6 +292,13 @@ static int sti_cpufreq_init(void)
 }
 module_init(sti_cpufreq_init);
 
+static const struct of_device_id __maybe_unused sti_cpufreq_of_match[] = {
+	{ .compatible = "st,stih407" },
+	{ .compatible = "st,stih410" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, sti_cpufreq_of_match);
+
 MODULE_DESCRIPTION("STMicroelectronics CPUFreq/OPP driver");
 MODULE_AUTHOR("Ajitpal Singh <ajitpal.singh@st.com>");
 MODULE_AUTHOR("Lee Jones <lee.jones@linaro.org>");
-- 
2.20.1

