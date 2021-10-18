Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F371430D8F
	for <lists+linux-pm@lfdr.de>; Mon, 18 Oct 2021 03:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243003AbhJRBhG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Oct 2021 21:37:06 -0400
Received: from mx.socionext.com ([202.248.49.38]:40503 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243011AbhJRBhF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 17 Oct 2021 21:37:05 -0400
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 18 Oct 2021 10:34:54 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id ECC162059034;
        Mon, 18 Oct 2021 10:34:53 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 18 Oct 2021 10:34:53 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 6690EB62B7;
        Mon, 18 Oct 2021 10:34:53 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 0/2] thermal: Introduce UniPhier NX1 SoC support
Date:   Mon, 18 Oct 2021 10:34:49 +0900
Message-Id: <1634520891-16801-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series includes the patches to add basic support for new UniPhier NX1
SoC. NX1 SoC also has the same kinds of controls as the other UniPhier
SoCs.

Kunihiko Hayashi (2):
  dt-bindings: thermal: uniphier: Add binding for NX1 SoC
  thermal: uniphier: Add compatible string for NX1 SoC

 .../devicetree/bindings/thermal/socionext,uniphier-thermal.yaml       | 1 +
 drivers/thermal/uniphier_thermal.c                                    | 4 ++++
 2 files changed, 5 insertions(+)

-- 
2.7.4

