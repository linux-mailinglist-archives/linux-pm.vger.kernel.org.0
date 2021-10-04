Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3754211B0
	for <lists+linux-pm@lfdr.de>; Mon,  4 Oct 2021 16:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234563AbhJDOoa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Oct 2021 10:44:30 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:57220 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234703AbhJDOo3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Oct 2021 10:44:29 -0400
X-UUID: 0d4150efbb86459abbfb466af4ba53d7-20211004
X-UUID: 0d4150efbb86459abbfb466af4ba53d7-20211004
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1421367160; Mon, 04 Oct 2021 22:42:38 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 4 Oct 2021 22:42:37 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 4 Oct 2021 22:42:36 +0800
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        <hector.yuan@mediatek.com>
Subject: [PATCH v1 1/1] cpufreq:Fix parameter in parse_perf_domain
Date:   Mon, 4 Oct 2021 22:42:33 +0800
Message-ID: <1633358553-2842-2-git-send-email-hector.yuan@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1633358553-2842-1-git-send-email-hector.yuan@mediatek.com>
References: <1633358553-2842-1-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Hector.Yuan" <hector.yuan@mediatek.com>

Should pass per-cpu id to map perf_domain for related_cpus
rather than map policy_cpu several times.

Signed-off-by: Hector.Yuan <hector.yuan@mediatek.com>
---
 include/linux/cpufreq.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index ff88bb3..66a1f49 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -1041,7 +1041,7 @@ static inline int of_perf_domain_get_sharing_cpumask(int pcpu, const char *list_
 		if (cpu == pcpu)
 			continue;
 
-		ret = parse_perf_domain(pcpu, list_name, cell_name);
+		ret = parse_perf_domain(cpu, list_name, cell_name);
 		if (ret < 0)
 			continue;
 
-- 
1.7.9.5

