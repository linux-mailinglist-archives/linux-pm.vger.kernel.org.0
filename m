Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B81B337A6A
	for <lists+linux-pm@lfdr.de>; Thu, 11 Mar 2021 18:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhCKRGZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Mar 2021 12:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbhCKRGQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Mar 2021 12:06:16 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DBEC061574;
        Thu, 11 Mar 2021 09:06:16 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id v9so40991537lfa.1;
        Thu, 11 Mar 2021 09:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PrdT1wQhy9IxbC6XumdouIDu0exhn3fHS2Os4khyfHU=;
        b=GMmSyrJfRU2L+dVXxXLx/8DqgviBZWz3HocHK7mj8r0efL5mxrYP0ppCFBnHBbxBGW
         U5o4ywGa8IIOH0Nz8MMgkoToZdddhZzlHLxxtQfnE29QrbN+OQKozJsL8xemqDgrrSCt
         BmC2kkjgTNn6jm7DqIUnMd0cl9OK0QFNTnY8EjAAmT43cIFRTts/SbLcWkBr//0YnciY
         kzBlmt89Y5M1gpGHpZk1ugljriB5kQWwZGUPj4k/iKWenQSOQw4D3HdjUf0MoEHwO2sq
         Lpuu74Hp3cQmRUPkl0LzDbswMDfJdRQK74ls9YHOyT2gKsDwNsW8kHB6efsFXdSSWmyB
         JkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PrdT1wQhy9IxbC6XumdouIDu0exhn3fHS2Os4khyfHU=;
        b=NjxmXc5JNTTRGrcIhwiyemsdlR+UdbwQ+gAD6DIa46qqJV+LJ5JEvNvR0AyhtC8naw
         1vRYhohkBG9XVOLxfqwY/QofcQsJaFZBtQLmUB/y3lffUWVfXPABOGyof/kZCZ531vxm
         B750Etm6J02PInHNeoe5pET0UUiPw327DspwO+LvcgElS7KiqvN5ivZ1hFQR/JayNZ8M
         ghBfm8JVqtkaXiNNLLYoqfTyec4cRcqyw7zi2S0wdKCpgx8QGaNIrEdLzEKrLCSAt5JU
         +BRW3NISQFE3Q/LEXgX+CRygybsaKw/QLON1aQUS7qJuaMjzRqLVtnDOAiqjmfxErB7M
         CyRg==
X-Gm-Message-State: AOAM532O7V8CesdBEB54Pd7IRPPMtlu+m3SDuzW1nvKwoL7flZ6x+fbz
        hDoXNgI3o8Mm+30RMgOAD94=
X-Google-Smtp-Source: ABdhPJwrJiFcYr+8LThGxa9P1GY6Znhfa3CkzooW8UnHgQLBu8SQXV3ps13DVvhLzlk92OR4brVbJA==
X-Received: by 2002:ac2:46d6:: with SMTP id p22mr2744651lfo.625.1615482374798;
        Thu, 11 Mar 2021 09:06:14 -0800 (PST)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id p5sm1166009ljj.26.2021.03.11.09.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 09:06:14 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v14 0/2] Add memory bandwidth management to NVIDIA Tegra DRM driver
Date:   Thu, 11 Mar 2021 20:06:04 +0300
Message-Id: <20210311170606.7543-1-digetx@gmail.com>
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

