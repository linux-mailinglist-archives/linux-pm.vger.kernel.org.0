Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0FC243FDA8
	for <lists+linux-pm@lfdr.de>; Fri, 29 Oct 2021 15:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbhJ2N7H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Oct 2021 09:59:07 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:48950 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231506AbhJ2N7G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Oct 2021 09:59:06 -0400
X-UUID: e0c6f2afee1c4cbcaf0fb7a8492887a0-20211029
X-UUID: e0c6f2afee1c4cbcaf0fb7a8492887a0-20211029
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1191437217; Fri, 29 Oct 2021 21:56:36 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 29 Oct 2021 21:56:35 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by
 mtkmbs10n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 29 Oct 2021 21:56:35 +0800
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        <hector.yuan@mediatek.com>
Subject: [PATCH v1] cpufreq: mediatek-hw: Fix double devm_remap in hotplug case
Date:   Fri, 29 Oct 2021 19:42:22 +0800
Message-ID: <1635507743-17919-1-git-send-email-hector.yuan@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When hotpluging policy cpu, cpu policy init will be called multiple times.
Unplug CPU7 -> CPU6 -> CPU5 -> CPU4, then plug CPU4 again.
In this case, devm_remap will double remap and resource allocate fail.
So replace devm_remap to ioremap and release related resources in cpu exit.


Hector.Yuan (1):
  cpufreq: mediatek-hw: Fix double devm_remap in hotplug case

 drivers/cpufreq/mediatek-cpufreq-hw.c |   33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)
