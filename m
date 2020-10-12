Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F44628B8E9
	for <lists+linux-pm@lfdr.de>; Mon, 12 Oct 2020 15:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390578AbgJLNz4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Oct 2020 09:55:56 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:59457 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390520AbgJLNzo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Oct 2020 09:55:44 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.3466635|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_news_journal|0.0583757-0.0215271-0.920097;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047213;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=20;RT=20;SR=0;TI=SMTPD_---.IiEO.rd_1602510932;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.IiEO.rd_1602510932)
          by smtp.aliyun-inc.com(10.147.41.137);
          Mon, 12 Oct 2020 21:55:38 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     robdclark@gmail.com, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        rjw@rjwysocki.net, jcrouse@codeaurora.org, eric@anholt.net,
        tiny.windzz@gmail.com, kholk11@gmail.com,
        emil.velikov@collabora.com, gustavoars@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Frank Lee <frank@allwinnertech.com>
Subject: [PATCH 0/3] Introduce devm_pm_opp_set_* API
Date:   Mon, 12 Oct 2020 21:55:14 +0800
Message-Id: <20201012135517.19468-1-frank@allwinnertech.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi, this patchset introduce devm_pm_opp_set_prop_name() and
devm_pm_opp_set_supported_hw().

Yangtao Li (3):
  opp: Add devres wrapper for dev_pm_opp_set_supported_hw
  opp: Add devres wrapper for dev_pm_opp_set_prop_name
  drm/msm: Convert to devm_pm_opp_set_supported_hw

 drivers/gpu/drm/msm/adreno/a5xx_gpu.c |  2 +-
 drivers/opp/core.c                    | 80 +++++++++++++++++++++++++++
 include/linux/pm_opp.h                | 14 +++++
 3 files changed, 95 insertions(+), 1 deletion(-)

-- 
2.28.0

