Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD78933F89F
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 20:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbhCQTAX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 15:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbhCQS7v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 14:59:51 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AB2C06174A;
        Wed, 17 Mar 2021 11:59:50 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 16so4489911ljc.11;
        Wed, 17 Mar 2021 11:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aD+bgjnKcQpwKrmLfaSDWL9bnCurIUYHlVG+1S8dJKA=;
        b=GLqxKP2AkQDjOLk5j9uCP5FFyjIyG4W97tRtbx10R4PH/u3Ln9VZxZLz1DAC8C4dNr
         qo4LLTOSN5RtI6AYFPfDD/m9l6QHva4BWF6FfQW4AnMKR3pG6mw9UzWGWGDxdzgeYa83
         uUZOa9VQOs9fZ1fSsZzdJWkMOwDKAawrjvqwzInnBqocIhPbVSCvLUD/nKbc0JzaLlPR
         gbNZr8Poe5rQylaLaAymiEwLalXQXU8dVmRfWQR18Il1u5F5vA7kPtd0ot2S1/5jT9+p
         QWmgn4re6E6L+AnG1lRJUdyVwaGPQ1yjx2mjUdcyV9W9vG1i1N5zFb79k+OBOfsoch0M
         hJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aD+bgjnKcQpwKrmLfaSDWL9bnCurIUYHlVG+1S8dJKA=;
        b=WzvCYzrGDjq6fMmhwUdqhQNNQpnIhdbuNmGUK9gzXUvPh+2Ph7DWaJkUDL6CwFE0AB
         RNnTN61MjC46S0/Yj9iGhDi1o9VC9EYInYqaeZz4D2nCOsECgDnFVGJGZSxoEGkDxLwA
         V2PMUaOGhSROQ/7W3jXPZlSRaUdf+9rTo7qApu/QZ4qHZ6Www6niPWlCxgwOBd/SBTfk
         fmvKbXKAl3xLX2dP9bsWhpW30BNJ9XsX/znruVQQkbcr1wOjdJPLhKDq1fHuynHkO4DW
         eodu8w5MquUunkeBO2wGM5qOdHwF0u77oRBvIM1G1tqQi1zw0wf/tFPLXzAjuaChzxA4
         QzIA==
X-Gm-Message-State: AOAM530GexeEvecsIvAssL6nVqrX77R5u586ETwUBixKsk7UeMqpzE6A
        mwvl9xGXtZtvwSz/mf9OpSU=
X-Google-Smtp-Source: ABdhPJw7gmOvSc1phTvkBLht6+c1l9w9p/jqGkafXriP21VPiDj23QRwlBPp4ZpspzWV79C6lnb4QA==
X-Received: by 2002:a2e:8909:: with SMTP id d9mr3181547lji.442.1616007589343;
        Wed, 17 Mar 2021 11:59:49 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id b28sm3442482lfo.219.2021.03.17.11.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 11:59:48 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v16 0/2] Add memory bandwidth management to NVIDIA Tegra DRM driver
Date:   Wed, 17 Mar 2021 21:57:32 +0300
Message-Id: <20210317185734.14661-1-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series adds memory bandwidth management to the NVIDIA Tegra DRM driver,
which is done using interconnect framework. It fixes display corruption that
happens due to insufficient memory bandwidth.

Changelog:

v16: - Implemented suggestions that were given by Michał Mirosław to v15.

     - Added r-b from Michał Mirosław to the debug-stats patch.

     - Rebased on top of a recent linux-next.

     - Removed bandwidth scaling based on width difference of src/dst
       windows since it's not actual anymore. Apparently the recent memory
       driver changes fixed problems that I witnessed before.

     - Average bandwidth calculation now won't overflow for 4k resolutions.

     - Average bandwidth calculation now uses the size of the visible
       area instead of the src area since debug stats of the memory
       controller clearly show that downscaled window takes less bandwidth,
       proportionally to the scaled size.

     - Bandwidth calculation now uses "adjusted mode" of the CRTC, which
       is what used for h/w programming, instead of the mode that was
       requested by userspace, although the two usually match in practice.

v15: - Corrected tegra_plane_icc_names[] NULL-check that was partially lost
       by accident in v14 after unsuccessful rebase.

v14: - Made improvements that were suggested by Michał Mirosław to v13:

       - Changed 'unsigned int' to 'bool'.
       - Renamed functions which calculate bandwidth state.
       - Reworked comment in the code that explains why downscaled plane
         require higher bandwidth.
       - Added round-up to bandwidth calculation.
       - Added sanity checks of the plane index and fixed out-of-bounds
         access which happened on T124 due to the cursor plane index.

v13: - No code changes. Patches missed v5.12, re-sending them for v5.13.

Dmitry Osipenko (2):
  drm/tegra: dc: Support memory bandwidth management
  drm/tegra: dc: Extend debug stats with total number of events

 drivers/gpu/drm/tegra/Kconfig |   1 +
 drivers/gpu/drm/tegra/dc.c    | 362 ++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/tegra/dc.h    |  19 ++
 drivers/gpu/drm/tegra/drm.c   |  14 ++
 drivers/gpu/drm/tegra/hub.c   |   3 +
 drivers/gpu/drm/tegra/plane.c | 116 +++++++++++
 drivers/gpu/drm/tegra/plane.h |  15 ++
 7 files changed, 530 insertions(+)

-- 
2.30.2

