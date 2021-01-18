Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E122F9730
	for <lists+linux-pm@lfdr.de>; Mon, 18 Jan 2021 02:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730521AbhARBPW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 17 Jan 2021 20:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730583AbhARBOg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Jan 2021 20:14:36 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFC9C061573;
        Sun, 17 Jan 2021 17:13:54 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id v24so15046631lfr.7;
        Sun, 17 Jan 2021 17:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XcOh2xAP7VZKJ2ySQGqyTzs8gZeIcwyB1WogfvPY5Tg=;
        b=jwMdfO03LYllUg/SmQv5V0IyTz6rRHafgK7yVjJLnaYbh1QHDZfQA6+wg4WjNueUnj
         9FbsJVqGj6A4Rfpz33uKcze/8s6eUFZ24LcVL11sPtUP82qZGVTIPPl0FqgZ5sp81PEi
         jXqf1Y+RRqnUt/Kp5Usi3oYXfVSGqpelKiMQvFTTUKwiRuAeu8PWnstgc9zdpnWsbdpR
         Gxe+xFCY2GH4EUc/2aKTzYPeaTIfkFY/G3IQB1MMUq9PgYv4dEK0tzOIIbVntPrCCxrt
         YuJ723qycWEq1iK5negTXvkTQjCX5wbODDG2E3VIF3MQOOryUM4bTKNXeBLvoh8Bl/Dk
         w9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XcOh2xAP7VZKJ2ySQGqyTzs8gZeIcwyB1WogfvPY5Tg=;
        b=bBrpqKvUBPkwVPijomtkpcurVS1AUDsgKamNAoW/P6xa/QuvMqKyY2JZhIwmXCgxkq
         W+w5qTKDwP+HA2On+3OmZPUuv7NwcdpGq02U6h9+b2UJ8V0o5mTWux92TDndtz6GUzK0
         UL5ZMWQZyEZdd/isRNVyLVlExAvhm5fb4IE55cXNqYxPfKDcOlgBf0S2DTgjG7l0RwBO
         zqUdB4jK4rR5qYhmWN9TXVLxE48Sjp5k84g00vOiWQOsyM3LfbuRCiUiirchZ20boOyV
         fLR0y3WhVUx7qbXiMYibqhR5cg6jB5yDJEv6wEjSyiIRtS3BI1clbv20qTTuJL35Ut3b
         e27A==
X-Gm-Message-State: AOAM532WZ0c/NXg3SueNkFK6hpk7nmDkhtecoI+QHJ5Ljcpbmr5f31Vf
        XfmChE6YfCpwL04FlVPlZFE=
X-Google-Smtp-Source: ABdhPJxKlbuErs5/kZ5sbgaR/zrvu00CfzF9pCQWh/7rECWFKpoUl30ragGPVNw4E0Ebeo/UfN1GYQ==
X-Received: by 2002:a19:8343:: with SMTP id f64mr10329900lfd.542.1610932433355;
        Sun, 17 Jan 2021 17:13:53 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id l84sm1710836lfd.75.2021.01.17.17.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 17:13:52 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 0/3] GENPD API improvements
Date:   Mon, 18 Jan 2021 04:13:27 +0300
Message-Id: <20210118011330.4145-1-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

This is a continuation of [1], where Ulf Hansson suggested to factor out
GENPD patches into a separate series. This series is a prerequisite of
the power domain driver for NVIDIA Tegra SoCs.

[1] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=221130

Changelog:

v3: - Added r-b from Ulf Hansson.

    - Added new patch "Make of_genpd_add_subdomain() to return -EPROBE_DEFER",
      which was suggested by Ulf Hansson.

    - Improved "Add "performance" column to debug summary" patch by
      correcting the formatting of debug output, which had a superfluous
      whitespace.

Dmitry Osipenko (3):
  PM: domains: Make set_performance_state() callback optional
  PM: domains: Add "performance" column to debug summary
  PM: domains: Make of_genpd_add_subdomain() to return -EPROBE_DEFER

 drivers/base/power/domain.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

-- 
2.29.2

