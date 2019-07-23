Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F281E711BC
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 08:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388128AbfGWGOl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 02:14:41 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42848 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388122AbfGWGOl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jul 2019 02:14:41 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so18569239pff.9
        for <linux-pm@vger.kernel.org>; Mon, 22 Jul 2019 23:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jB85xxBwApqxzP5t70awnp6QUVo8jjK/SH2bjct3MZE=;
        b=G5ctZVOyf1e2+mEbnsRNWd8L4HRAYyjqt9+LW4CUAh8H5q1QIFrn68m3DxIA1i/Ola
         XOm1L6f/TFr3BLsK/WRE9ka7TxXewhH3vqqKhEt5lrHGCaTxB+i9oKHNY2JalB7+nQZz
         W4FrpBrZ76Ci8SwLkhQ+H61D9Hi8YB9BsEFLjYpj7n9p6zZe19Pmitda/4B/N8NCCRrc
         XBtt1T/Gq4Bg0Kk/8GWDxdLw8w98y/jeZhrqcToiBoVkXh0DBpddlpEOMlqsU64KdWzF
         WxedSaGzqwXztSOwKn2w+K8gz7NFPiTwtsBnotow/RWB/EPeQtW681nVz/fFoikGlctk
         gXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jB85xxBwApqxzP5t70awnp6QUVo8jjK/SH2bjct3MZE=;
        b=eugqC+VNJ1fSzfGIiI1F0KMxG6uj1skVYi/7vuIoFT4PgjIj0Zp7x9QK2vf6upTaAz
         7qdmFUnrob5rZNW4YNBS4JIWI9T4Zhsw6RVyWCOuxAPc4ZHNozXLaUAhIAYC8tbptWBJ
         T9zIstoz/02x3vbQcfAKZb4a19Kw797o20ZtACOBXSXvSPIJjtGd1fap1J4rlu27XQDc
         uRGSHU32K9AXvkJ5+oid4ZxXi6Z5AnlGqyEA73waJEOUIwKTXEw/ADcawknt/uBdjhhX
         y5A/+/xSJzuECMnWB7GC8cPcNxESBzAi0/nSQ1zUGTI0j35AlA+cohBa49aN2bHN6Typ
         VXTA==
X-Gm-Message-State: APjAAAXd1Rprbjeu16g8civZdFTQZA2XL6O81nDcSPx/k/z43aHjd+8g
        xS/Ks8xFwY0N57mFcwzuM3p0JA==
X-Google-Smtp-Source: APXvYqwU0A/TlI3oMcWf9epZVKEkNmKmLXf4L5BQu4ya3hv/M2F2HVj14WlyVn1mUnpdkXuC3LZuZQ==
X-Received: by 2002:a62:6344:: with SMTP id x65mr4282837pfb.111.1563862480370;
        Mon, 22 Jul 2019 23:14:40 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id q1sm49359764pfg.84.2019.07.22.23.14.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 23:14:39 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 06/10] arch_topology: Use CPUFREQ_CREATE_POLICY instead of CPUFREQ_NOTIFY
Date:   Tue, 23 Jul 2019 11:44:06 +0530
Message-Id: <3afc5046ba9435d229a004c17b005197488006d4.1563862014.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1563862014.git.viresh.kumar@linaro.org>
References: <cover.1563862014.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

CPUFREQ_NOTIFY is going to get removed soon, lets use
CPUFREQ_CREATE_POLICY instead of that here. CPUFREQ_CREATE_POLICY is
called only once (which is exactly what we want here) for each cpufreq
policy when it is first created.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/arch_topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 63c1e76739f1..8cab1f5a8e0c 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -174,7 +174,7 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 	if (!raw_capacity)
 		return 0;
 
-	if (val != CPUFREQ_NOTIFY)
+	if (val != CPUFREQ_CREATE_POLICY)
 		return 0;
 
 	pr_debug("cpu_capacity: init cpu capacity for CPUs [%*pbl] (to_visit=%*pbl)\n",
-- 
2.21.0.rc0.269.g1a574e7a288b

