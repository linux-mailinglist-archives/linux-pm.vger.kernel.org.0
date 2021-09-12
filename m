Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B94407F7C
	for <lists+linux-pm@lfdr.de>; Sun, 12 Sep 2021 20:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235228AbhILSrY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Sep 2021 14:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234680AbhILSrY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Sep 2021 14:47:24 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E8BC061574;
        Sun, 12 Sep 2021 11:46:09 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id r3so13058274ljc.4;
        Sun, 12 Sep 2021 11:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q56JrzkcHqlDDYAqTVxBga8cYlObhzJYEpHH2EZ3m9E=;
        b=mi1+8LsKBCHLkR+4F39hcz+K5JnpEdGR/HM34uZ3Hl6/dxkDRJqAtOUCxqKqoQKtNW
         MCJlcjBPDy8gEU6M7MnS9mDiWzKpvjomd1LJUX8IgrfX+WCViVzHE+Zg+FZ8kiPn4E0w
         0pSIcBAXxK91/DkkxuY85mJGgitr9u5cHttnGLo+ImJIEKicMwvRj9cc/c+Z3UJYd5Jf
         5q4Nfjdh9ebmkUz9qF+S7Bw4UM3H06E4WJhUNOL65K9/7LE1hxyUnGeF90fvBsC7bG2a
         fHzcimUWihOzigG5i5mR5Ip6kSMVKrBnClCi58CJyjHqTXd0/qDKyycPg6fnhsxz5MZS
         9PbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q56JrzkcHqlDDYAqTVxBga8cYlObhzJYEpHH2EZ3m9E=;
        b=WakH9yPLZdd47MIbV/HFsCEScNIgFp2y1GoTNhYvM476TG+Bk01hmOEXag6yo+bOs4
         q/JHiUqc5k1lOGnEVUXdJDNklG9Cw00ENxA0SKUk3bRE2uQg7eVOM7MAv4tRXpG7XOZC
         EptkCDOkh/ZBgLgf/VW/IWMoTWxyFWeavFahhcO6aFGHWysQWuurWbmCT+PuuXk9YSjS
         AHceWJ7tYFfyb7g/cM7h1/mhalko95A0sUH6y22LW+YpULqnaviPc5FiIxlCDHvRXVim
         DiYgL1R3wvixObN/BUV0BvHauHIxeIs5TUPSYVZErzuCJhEP5Zse+czKadE9Gf60ZvdX
         onBw==
X-Gm-Message-State: AOAM533rTeUsjL+ePo0TUDUYcxMhzDB/A8M3E5PTt6bMbdCRF9Q7vDw7
        KvCMSUsOHKfIj19fOL+MhlXjsHTShO8=
X-Google-Smtp-Source: ABdhPJxPTzAx2s58MURkXqHJUIV52ouK5bUuydkhvZlQyUBpIh4vJ0dRfchw8wAf+23aHJuMVgHT+g==
X-Received: by 2002:a05:651c:1541:: with SMTP id y1mr6969424ljp.226.1631472368231;
        Sun, 12 Sep 2021 11:46:08 -0700 (PDT)
Received: from localhost.localdomain (46-138-83-36.dynamic.spd-mgts.ru. [46.138.83.36])
        by smtp.gmail.com with ESMTPSA id q5sm588570lfg.36.2021.09.12.11.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 11:46:07 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v1 0/4] Make probe() of Tegra devfreq driver completely resource-managed
Date:   Sun, 12 Sep 2021 21:44:54 +0300
Message-Id: <20210912184458.17995-1-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series adds new resource-managed helpers and makes Tegra devfreq
driver to use them, improving the driver's error-handling code.

Dmitry Osipenko (4):
  opp: Add more resource-managed variants of dev_pm_opp_of_add_table()
  PM / devfreq: Add devm_devfreq_add_governor()
  PM / devfreq: tegra30: Use resource-managed helpers
  PM / devfreq: tegra30: Check whether clk_round_rate() returns zero
    rate

 drivers/devfreq/devfreq.c         |  26 +++++++
 drivers/devfreq/governor.h        |   3 +
 drivers/devfreq/tegra30-devfreq.c | 109 +++++++++++++-----------------
 drivers/opp/of.c                  |  46 +++++++++++--
 include/linux/pm_opp.h            |  12 ++++
 5 files changed, 127 insertions(+), 69 deletions(-)

-- 
2.32.0

