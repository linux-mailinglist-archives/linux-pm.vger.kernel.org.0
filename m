Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29CDF397CE1
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jun 2021 01:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbhFAXL5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Jun 2021 19:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234766AbhFAXL5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Jun 2021 19:11:57 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA184C061574;
        Tue,  1 Jun 2021 16:10:14 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id v8so288969lft.8;
        Tue, 01 Jun 2021 16:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2xCpI8rPenbsUCUOKhij+pbYq1iZHV9ikvSNITjWPKQ=;
        b=FpHUuTpk3xz6V9wFXg+LkxDmHRiBvyV41uffcTu2dTs92MGvmcahFdanYd9U9WZJTX
         Ass/Lu8j/VWJtDyRQOFqTQEVA//d5FSBhQtqPYqtzcRGxasZFDOYSar8NQoA5rkwh2R1
         x2gMCPq/Qpw5drD82+aWRP9+vOHBxKlC0rl9Eu/yjr1sdFl8q0ol2DlU9lfnRK0ztZ5C
         +JI1wWAXuP+UKue7EXx0M3UzNLCpi30s3Wl4pG/CSaszZ7MoJnATEaZ9DZ3um26DzONo
         o9t8uhZqzS6se6/7S7XYrU9wwF4enGVi1NY3R/7RkLzqsprcSqttrZtLZm7pqSYvP8hD
         z0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2xCpI8rPenbsUCUOKhij+pbYq1iZHV9ikvSNITjWPKQ=;
        b=RNP8gbY25UMt/3GKz7tTv92Lh7tlEfxhBL2Rse1xcuiBw/OI4jaGjRGFC9xIzYyfp/
         LjgtRrhd++tBEUg8rqWOjV7MOZKC0mtJViGuC3h1Y7wMDEyMKyehtSbry7Yc08wBgCuK
         ToctnMfoi83UNDjlDzCrEAKOFUa9GWG6lwqjIM7PYt1cB7RErDTBEOpgFa1AxGEIc7hh
         mk6FYAy0mHYaoIQFggVOpDJQHMXZJ1POYxpDTe4ekSaRfPSoeLTvcehExzSoe8VaS8w+
         NW37czgxCYEggmLfS5ro8vjAU5UrIEvkuiRgPErJ9g4Uov+PLVQDEpZiAEzjYSdAvRR8
         HJbQ==
X-Gm-Message-State: AOAM530+fd+68I+K2yFpYQM7K24SoWUdj5oZ5XR5kmYg5VqHTl1FI35a
        2nZD25mNcGiMvKQKMkCaZ5+d0F6QycI=
X-Google-Smtp-Source: ABdhPJxf35/VJ/GybpPLhB6zsky50LccSOL6k49ve9d2/YG0oSAZNPTL9I5GtzOR/cHdE1kYgk2hEA==
X-Received: by 2002:a05:6512:3f8c:: with SMTP id x12mr20119382lfa.146.1622589013038;
        Tue, 01 Jun 2021 16:10:13 -0700 (PDT)
Received: from localhost.localdomain (79-139-170-222.dynamic.spd-mgts.ru. [79.139.170.222])
        by smtp.gmail.com with ESMTPSA id s9sm1813574lfr.231.2021.06.01.16.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 16:10:12 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v1 0/2] NVIDIA Tegra core power domain follow up
Date:   Wed,  2 Jun 2021 02:10:01 +0300
Message-Id: <20210601231003.9845-1-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Remove the lockdep_set_class(), which Ulf Hansson asked for. And
prevent core domain syncing if domain node is missing in device-tree,
which I accidentally missed to add after squashing the standalone
domain driver into the PMC driver.

Dmitry Osipenko (2):
  soc/tegra: pmc: Don't sync core domain if it's missing in device-tree
  soc/tegra: pmc: Remove usage of lockdep_set_class()

 drivers/soc/tegra/pmc.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

-- 
2.30.2

