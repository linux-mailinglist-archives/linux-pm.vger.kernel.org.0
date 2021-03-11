Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2969A337AB2
	for <lists+linux-pm@lfdr.de>; Thu, 11 Mar 2021 18:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhCKRYN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Mar 2021 12:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbhCKRXv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Mar 2021 12:23:51 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BFAC061574;
        Thu, 11 Mar 2021 09:23:51 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id u4so3168989ljo.6;
        Thu, 11 Mar 2021 09:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NLoHiP3d+5lNwT7CIKnzK9m4XZbys2sERvq2/PuPWts=;
        b=OjWK3wFbksojHdfmupqd5gy+Mg37v24f6j+8Ol8GghZXgYnlKwjv0D+10szaRXsatR
         Oah/RPo7tgEpMBJvtNSlw0maRM+Sy/z6e7DURhN2dDk/0BLd9NniGeCDGeycTjsx+L8E
         4UMAh+a7sNYJQFfJOsTBYMQv/v48mlax2rcic89sVYfdHzmpUrULmLBDcYK1Z7GwuyRl
         cNgSclfnXPb2kTyAkNE4QRXrg2GSwJYRhApcLxH8VbA0uhwWzXpWSbwu4ZfpXCw8Rz63
         VjQ4PcqUSKPdcy1A+adzAjOr/G75y9nppt6Wc9Rl8SkKovZ2g5jDen6onnP4LRhGSFFD
         dY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NLoHiP3d+5lNwT7CIKnzK9m4XZbys2sERvq2/PuPWts=;
        b=OMySTh6FovhfwIAOO1I7jPQ2mAsi781yaayIunrUG4b8UQAGHDK6Ayz7T7W0YNPUne
         R1S+uEbOqeP4tvwgFI/Fo2IzO5auycbK6Yq/R8RTN6BUt5Bw00VcJGn9XjESkzwfBQiK
         wl7FH7el3ZYFwpGCEaHrr4xh6Jl4xzeWULJGt7scaP7d4PZ8sgMUvnnhqrLWieuD3WLl
         8WbwQlD2QWTnN4nWiOallFZVtu4VYnBFmvtM/phB+BJWQ+hqBMrrsPQWCovH6saciahl
         /Gb+wPrJeULC730vfkGdycltxgusTRJCR92h6hvV/nprdKnYe3sj58ImpPK9DTzy/6Ni
         8OPQ==
X-Gm-Message-State: AOAM532mNJAMJnvDCD7ILxv2fqDxJc/4w7DbHmzxu7kNGWZJqIm4Wf1P
        EL6bbWrR+87W//FK4khGk8MXnBBYE8k=
X-Google-Smtp-Source: ABdhPJxudYcrz6shnnCY/yzrTieJmSXgC6cgM00Md07ielNo75CBMq/9vqKKoCu2ueg5MihZZ1OejQ==
X-Received: by 2002:a2e:8111:: with SMTP id d17mr5366586ljg.337.1615483429543;
        Thu, 11 Mar 2021 09:23:49 -0800 (PST)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id p5sm1180088ljj.26.2021.03.11.09.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 09:23:49 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v15 0/2] Add memory bandwidth management to NVIDIA Tegra DRM driver
Date:   Thu, 11 Mar 2021 20:22:53 +0300
Message-Id: <20210311172255.25213-1-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
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
 drivers/gpu/drm/tegra/plane.c | 127 ++++++++++++
 drivers/gpu/drm/tegra/plane.h |  15 ++
 7 files changed, 541 insertions(+)

-- 
2.29.2

