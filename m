Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57822A4926
	for <lists+linux-pm@lfdr.de>; Tue,  3 Nov 2020 16:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgKCPN3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Nov 2020 10:13:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:56784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728325AbgKCPMD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Nov 2020 10:12:03 -0500
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FBA7221FB;
        Tue,  3 Nov 2020 15:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604416322;
        bh=ijYhyjbLqPbwjVrs3lfxc8yZiJOX/V7n4LDzw/kbS/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZiVUnbGQRuFAsmqKbhAXsTNk5gnGW8r8y78fYttndKTVv1g2nD7PqqCnZgea+I3Ob
         tZxOsA7fJjXZvL9+WNKk22j+JgE/s0F25+t4mjpBNB9iRxE2y/2M/DF4HkKLHrSpP3
         9LAVVjo3Xgx+IwWoHvc2m1QQr/pp8I7ymc19BXZQ=
Received: by pali.im (Postfix)
        id 6936616AA; Tue,  3 Nov 2020 16:12:00 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] cpufreq: mediatek: Add missing MODULE_DEVICE_TABLE
Date:   Tue,  3 Nov 2020 16:11:33 +0100
Message-Id: <20201103151139.29690-4-pali@kernel.org>
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
Fixes: 501c574f4e3a5 ("cpufreq: mediatek: Add support of cpufreq to MT2701/MT7623 SoC")
---
 drivers/cpufreq/mediatek-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index 7d1212c9b7c8..a310372dc53e 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -540,6 +540,7 @@ static const struct of_device_id mtk_cpufreq_machines[] __initconst = {
 
 	{ }
 };
+MODULE_DEVICE_TABLE(of, mtk_cpufreq_machines);
 
 static int __init mtk_cpufreq_driver_init(void)
 {
-- 
2.20.1

