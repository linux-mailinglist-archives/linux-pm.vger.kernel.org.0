Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665434127A6
	for <lists+linux-pm@lfdr.de>; Mon, 20 Sep 2021 23:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbhITVEc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Sep 2021 17:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237221AbhITVCa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Sep 2021 17:02:30 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C961C05935E;
        Mon, 20 Sep 2021 10:23:15 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id p29so69934560lfa.11;
        Mon, 20 Sep 2021 10:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6HY+i9xFe3394dw3mtZ4CqFXOI8zy8KUlBKvEvhmMp8=;
        b=n3k7TyFqg0XBwNTE2AGgCInmHSWCTj33UHgEliRKebOrsN2m0FTCDpw/xK0HGi0O5P
         /r888sQrIXBSAo+spsctvLKGo8+PgZi/KDV45LRZvEFy2ALAj2ulsFxoGccr+DgE1SzV
         sOgVU+sN8IuPdRRSdB7odoc3UArpDpTtqGrcry/YNaeGzpW2eeQ2I58t6iGnFkteHzDL
         5SeKS/cRWmxhvZyLrHHn3xUkklp0qIHyw+mNuYur52hs8dmSBp2Ji2mVYzV42/rndYR9
         QzeDf8up+aALvHAgAEeK/qntRBHtIFJxXdElDdJnihwDYZ1Bb/amf8fmGxcj++yfKPP+
         3t1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6HY+i9xFe3394dw3mtZ4CqFXOI8zy8KUlBKvEvhmMp8=;
        b=HSHnDRZylAQfEp6GgEXyBA6bHkN/eVYufDIwVpzGGogd+VP0fiaTnA7qaDUcUAuhlJ
         gu22rTEKmmnSKvXdfJIl8Ht6NiO1RIjExYJu+FG+lX1lGp4YZos8YtnIlFmPqfhH07Hl
         ggd3rL3jTJPrrkER8lsVxT/dwUeplml+kky2cp79xMRXUa52Pg/IBTw8KkviV8bpkkvr
         WSUdf3L9PGbfS7Ncf1IQGp5FTYBLK7kUjSKNnHTnm+7s0kyYyPUhnHHQN8d97ogmbCwl
         WpkuYYH57E5S1rGcgzBTJM6dytveYRFVRyfjzqTxvRQpWVLtInJiL6RH7gGyqigo8Bee
         IVZg==
X-Gm-Message-State: AOAM533v1NMjU8BFtoAlqaMbYoJHehE242zS0v2J5tPgFBMQpmHDBwqJ
        TH9pn8GbI2Z4RR3Xl5NjwAXtNjhcWic=
X-Google-Smtp-Source: ABdhPJwTloJA4iBH7B9NOu/+JLk7WaRxunP7Al/3ucERMI1UHOynNHOHAzAjvExvOGSQjVnax2FCww==
X-Received: by 2002:ac2:5d71:: with SMTP id h17mr19342342lft.670.1632158593940;
        Mon, 20 Sep 2021 10:23:13 -0700 (PDT)
Received: from localhost.localdomain (46-138-151-206.dynamic.spd-mgts.ru. [46.138.151.206])
        by smtp.gmail.com with ESMTPSA id t13sm1311038lff.279.2021.09.20.10.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 10:23:13 -0700 (PDT)
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
Subject: [PATCH v2 0/4] Make probe() of Tegra devfreq driver completely resource-managed
Date:   Mon, 20 Sep 2021 20:22:45 +0300
Message-Id: <20210920172249.28206-1-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series adds new resource-managed helpers and makes Tegra devfreq
driver to use them, improving the driver's error-handling code.

Changelog:

v2: - Added WARN_ON() to devm_devfreq_remove_governor() and moved
      devm_devfreq_add_governor() as was requested by Chanwoo Choi.

    - Added ack from Chanwoo Choi to the "Check whether clk_round_rate()
      returns zero rate" patch.

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

