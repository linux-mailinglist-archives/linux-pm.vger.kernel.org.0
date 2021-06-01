Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D096396C0E
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jun 2021 06:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhFAEXB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Jun 2021 00:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhFAEXB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Jun 2021 00:23:01 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C049C061574;
        Mon, 31 May 2021 21:21:19 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id f30so19727006lfj.1;
        Mon, 31 May 2021 21:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QsBXsRip3kFvEjWTa78PF0czB+uAdglJotlmv/X0+60=;
        b=KIes/EoqOnLs+HMpSZV8aLJX0vQSdJl1h8s1Y5WCdfl5BR5g8d9InmuQWKJ1KvMqjo
         DIK2yqGud36NQ8Klulu/6P9vRndNrIxdvwoVUi+tULWtOtPps9ZOL+rkZFNsnNSCGtDQ
         8H0LWouizgITaU5ewE97EJRQ+4y8kz3pdvDQC9D8ibE8hHbx58WzvOFfZHaQzD95VuRK
         w39Uhsm2ahQlohyyjl87TRkUOwUYAQk9P0Rjrzv3nFuXZb+vLFBi99o0FsiX2YO8anRX
         KlTPfUr3cf3THuh9oblpypq6kRFkTapqTfRxG2dfyVAiPHG5bfflneaIOOd/wTHGgVuS
         3aKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QsBXsRip3kFvEjWTa78PF0czB+uAdglJotlmv/X0+60=;
        b=VycCtcV1IAu+h7vT/ujUkVAsbqi+Cjqd77o4gYt0Mh/JI8T2u4CHzP+bZ0n9OcYbh9
         3cA6OYUsyUXM7iCIOAaUaalExApupAMwbaQF09+eZsU9JO4DkQAXDKQHPb8M3uBTfNeE
         ArXiuH8+1HGr5WbQdqomApFCybuIBZIyJkUVMQ8JJa4AFXzblHPFxWXd9FfJQ52NQKPL
         H4LmGXlejsKWDVKRRw5e5chM5uZ1d0R0GCNiVrcOv3IyxxlzslCZqjWIACCzV8LUSPgj
         r9q1G85o8U2+8UJSynfE+YcRRGkZM+ExsqeNTawBN7mpZONDK+680z3LZ/+cnNngTKCQ
         9jCA==
X-Gm-Message-State: AOAM533ZZWZvyY6ftzZPVAjH9gazWJocDGQd0/wQIFChaQfsRLsy/gNd
        1Wr2s/U8Wy4x7lQW2VpxzIg=
X-Google-Smtp-Source: ABdhPJwyMrkbVvF0P5gWTmcrAcTV0zklr3gP+9QZj6t/LpirjwZx1w4nMr2PW+3tEvnbskIgwL1FeA==
X-Received: by 2002:a05:6512:3c84:: with SMTP id h4mr13037767lfv.308.1622521278026;
        Mon, 31 May 2021 21:21:18 -0700 (PDT)
Received: from localhost.localdomain (79-139-170-222.dynamic.spd-mgts.ru. [79.139.170.222])
        by smtp.gmail.com with ESMTPSA id d9sm931627lfv.47.2021.05.31.21.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 21:21:17 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v18 0/2] Add memory bandwidth management to NVIDIA Tegra DRM driver
Date:   Tue,  1 Jun 2021 07:21:06 +0300
Message-Id: <20210601042108.1942-1-digetx@gmail.com>
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

v18: - Moved total peak bandwidth from CRTC state to plane state and removed
       dummy plane bandwidth state initialization from T186+ plane hub. This
       was suggested by Thierry Reding to v17.

     - I haven't done anything about the cursor's plane bandwidth which
       doesn't contribute to overlapping bandwidths for a small sized
       window because it works okay as-is.

v17: - No changes, re-sending for v5.14.

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
 drivers/gpu/drm/tegra/dc.c    | 358 +++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/tegra/dc.h    |  17 ++
 drivers/gpu/drm/tegra/drm.c   |  14 ++
 drivers/gpu/drm/tegra/plane.c | 117 +++++++++++
 drivers/gpu/drm/tegra/plane.h |  16 ++
 6 files changed, 521 insertions(+), 2 deletions(-)

-- 
2.30.2

