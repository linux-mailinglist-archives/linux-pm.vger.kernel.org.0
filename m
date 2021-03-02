Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4F632B339
	for <lists+linux-pm@lfdr.de>; Wed,  3 Mar 2021 04:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352495AbhCCDuQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Mar 2021 22:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572944AbhCBOIH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Mar 2021 09:08:07 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996F8C061225;
        Tue,  2 Mar 2021 04:45:15 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id h4so23555388ljl.0;
        Tue, 02 Mar 2021 04:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RODns9c8niEuo2cR8Tivcksr+gvQ6B3mB5cKu2wOr5k=;
        b=sHlezPC1K+hQ2MvLnVoZTzrGOimIYa8oVDmfP4r4C4JOXwQGq+gkbMFn8966V11zVa
         2nmO5IkDvXtncMumYS7YEyVoNKBl7rigd6JGEUKKLI/M/NqvQhpVmr/Lc1ZiHf10t7by
         kb7jZZMhcEHqLa6aAaf/LOnKcKfxi7kocDp8dcBeZI1LWTs1REvkZHyNP3IS2AnJy4nu
         h9X8Kg3XI/UCcb/ciaqOI5HArHPD8EblMwWnBhfFyNbV6oopQ94x9KrYDHjK9cMhcSdS
         Isw4r/ERYp5zZ+8GqBSGjbnXU8CjDfMjMNkXPCrbM9oJQf9OsBimXzwQf1nuFwq5gF+W
         Yh9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RODns9c8niEuo2cR8Tivcksr+gvQ6B3mB5cKu2wOr5k=;
        b=TM2hdfY6sWQ61iuU4E6s4mJnNHgwDhGEAZtapfgt7/WBVmD2+9jbtR3NCN9oaPFvPI
         cszcLxb4Yo7574k13h3Co106Mso8WKM+JTud8+A808NX/AMkqRRG+zhPgxvlKOfat3Yv
         z/oBIUztQeplQ44OxUYzNBh3lHKxu64tXoGwzY75X94vKxo/O0G/K0FX62ImqNHL1QrU
         8CnM8QQsc3mkmJwH5qJZCyefEIrQt48bf/t3hBuOpShOAt2rtOkhddROgYkmlwnxsvoi
         emxkhOOIbvBfPiM4NM8gkA+vTtyg+bJ0RmSb+dgyaYUqpwgv14O/yH1gRw7+jfh01aM0
         74Rw==
X-Gm-Message-State: AOAM531KTWgT8LiiA43dpDvijz8ay2UQx8Nqk1nqFi20XmoZYjvrAxzL
        zV3DOUZJgidRiIaOsbFsbi4=
X-Google-Smtp-Source: ABdhPJyu8IppM2jrWh9AXXl+HFGQgEQ6h8mGp7coHcqpb6q77syOlTkR6BmPxcAqrLBBq24PC/N9qw==
X-Received: by 2002:a2e:7604:: with SMTP id r4mr12550406ljc.60.1614689114186;
        Tue, 02 Mar 2021 04:45:14 -0800 (PST)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id m16sm2634705lfh.109.2021.03.02.04.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 04:45:13 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v13 0/2] Add memory bandwidth management to NVIDIA Tegra DRM driver
Date:   Tue,  2 Mar 2021 15:44:43 +0300
Message-Id: <20210302124445.29444-1-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series adds memory bandwidth management to the NVIDIA Tegra DRM driver,
which is done using interconnect framework. It fixes display corruption that
happens due to insufficient memory bandwidth.

Tegra memory drivers already got the interconnect API support and DRM patches
were a part of the series that added ICC support to the memory drivers, but
the DRM patches were left out unreviewed and unapplied. Hence I'm re-sending
the DRM changes in this new standalone series.

Changelog:

v13: - No code changes. Patches missed v5.12, re-sending them for v5.13.

Dmitry Osipenko (2):
  drm/tegra: dc: Support memory bandwidth management
  drm/tegra: dc: Extend debug stats with total number of events

 drivers/gpu/drm/tegra/Kconfig |   1 +
 drivers/gpu/drm/tegra/dc.c    | 359 ++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/tegra/dc.h    |  19 ++
 drivers/gpu/drm/tegra/drm.c   |  14 ++
 drivers/gpu/drm/tegra/hub.c   |   3 +
 drivers/gpu/drm/tegra/plane.c | 121 ++++++++++++
 drivers/gpu/drm/tegra/plane.h |  15 ++
 7 files changed, 532 insertions(+)

-- 
2.29.2

