Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014E0379AB3
	for <lists+linux-pm@lfdr.de>; Tue, 11 May 2021 01:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhEJX2i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 May 2021 19:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhEJX2h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 May 2021 19:28:37 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E617C061574;
        Mon, 10 May 2021 16:27:32 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id x20so25885300lfu.6;
        Mon, 10 May 2021 16:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p/hD7X1jxbNKIMZLjI4qd/QOlc+AoEvIWQQDsxFLaMg=;
        b=cFPpmm7z9+guC3U9hNO0K8s3a3FQtexzt4LAU0q9bPIj70X9tuPzKfDC29dVTQY2yc
         8axyeOCZjjo2kZeXCTocHWmx+QBcze6pZw94+0oGnFl9VMMnmHiILRsGeJ/cuvN2PYd/
         871X2X2AI8DEe4JOkuYdHq/76l50ftCWqzQXc1YPyPONnuJGi2yyybw73mxgKZtgKeOX
         vmiNBedWR++LHHqZ58tyiJA2VUrcwHmCeSjS7YtUv3gdUFfVCz95RkDCZYkWbvg+L4oN
         2nhKO0Wfb+SVxYYYBBENyHbs/HtIeF4XHQl28zfzmPNTVYIEvt6C+TyeTKWNzublzO+x
         qtRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p/hD7X1jxbNKIMZLjI4qd/QOlc+AoEvIWQQDsxFLaMg=;
        b=txf7ZqQ9uy0Dnl0XudgSGUxTEg+niF5E7vr4jXivR6BqoSK59IJLJ0NnVYUihE21T2
         5o7VdKDEHuchk691wIhvjCR4z+KjxNQtRH7X4UyjxMXr6MZDR7+fj14c49YXGmdwsvgM
         rtTiSpsrzM3N+TEbLi2TJHJNmzn66tUe6vCyNqpHVmy8avp07nM+wGeaooOzlKMCTyfc
         E6JsQbJrRRYk6OZYm5w77xCXlXEWAEG+T9b8REFWk36k94wm341Mvo5xgcWMUxALDjf9
         wjythXxUjLrzilCw1GzQGxBcvwz//Se6Zy5tjzrW6pbb7W/F+gKwA2lAkgtsK9pYSNts
         9Ecw==
X-Gm-Message-State: AOAM5332SEZY4hBF6TL+2R07PCuk/yD3W8Ww5VVLDBBAI2928fqCXikd
        JDjizUaTd4sifZbM81evmxc=
X-Google-Smtp-Source: ABdhPJx+Hhr9CpWnsQQ9nxO7xiBcgt0Ru42RZfBUAag3gPYRlwtdIOoT/EQHr68t1le+iAJi/lZjlg==
X-Received: by 2002:a19:4cd7:: with SMTP id z206mr4510093lfa.487.1620689250586;
        Mon, 10 May 2021 16:27:30 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-91.dynamic.spd-mgts.ru. [109.252.193.91])
        by smtp.gmail.com with ESMTPSA id f29sm3354203ljo.69.2021.05.10.16.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 16:27:30 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v17 0/2] Add memory bandwidth management to NVIDIA Tegra DRM driver
Date:   Tue, 11 May 2021 02:27:07 +0300
Message-Id: <20210510232709.1349-1-digetx@gmail.com>
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
 drivers/gpu/drm/tegra/dc.c    | 362 ++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/tegra/dc.h    |  19 ++
 drivers/gpu/drm/tegra/drm.c   |  14 ++
 drivers/gpu/drm/tegra/hub.c   |   3 +
 drivers/gpu/drm/tegra/plane.c | 116 +++++++++++
 drivers/gpu/drm/tegra/plane.h |  15 ++
 7 files changed, 530 insertions(+)

-- 
2.30.2

