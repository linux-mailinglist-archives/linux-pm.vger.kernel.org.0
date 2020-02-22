Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D18481691FE
	for <lists+linux-pm@lfdr.de>; Sat, 22 Feb 2020 23:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgBVWEr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 22 Feb 2020 17:04:47 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36064 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgBVWEr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 22 Feb 2020 17:04:47 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so5538086wma.1;
        Sat, 22 Feb 2020 14:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f6UYYZbApbZsahGyunKgNImaPux/N+TMxTyzK7wQqbw=;
        b=RZWyUZLk97pzOEiYzgmzB89sc1Bwnug6G48w+yV9zxEwhg9oHn+Qmtun6mlEam4R9N
         ynpl4GU03wIY6egej0Y4nKvJTZg1LagXZe8vNXvkgpMSKK3uRWSGmuKDmUyS6EcfDWXL
         8iz0foFlztubOEBwp2SnkeB3tKp+6HoQ/XCbof/bWtKxhg/VLogkEu7JrK58uKSRtWaI
         imNLZ4cP90wkcvLjshM/r9OI3pjUs4YIGjvTapAa139M7P+oalYArnnA4+ECw+lazk2w
         X60iiorwqugsI5DkIZd+lk+5F1a07+J+6WTKHb6UxQf3Z6v/cDjQOOu4xN5R0nHUy+aA
         4bBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f6UYYZbApbZsahGyunKgNImaPux/N+TMxTyzK7wQqbw=;
        b=bKPGet99jBjF7gK3RfDGRz/GKCG+h5c2sOI2z+pTOJF2oW9HxHEHchsM2PWpx1gQap
         1j5n1Zvhgbd7Z7mfI7jj9enwQOr/qgMzhYpebyxe55TdtwxO6FbU9fDJuiRGekr9YB9g
         BfHjlstvSnmQDrN5HvPdgvz9qRM212gklmnFRbZbJUoxcVZn/ETixI6kJip3QFkwxR3X
         oRPl8Hlx0HXYYXyIEKDzfSlpQoV8j/abvUAn8QNFtUkVR3YCXMMR6GY1RVhJ+CUfiTPe
         YxNrvUAL7HjegZwmOhoUI7Ri/HRa2bRdxHiraPjQF4n4lKmRP9OaQ0StWwH9xWiTgOaj
         r6qA==
X-Gm-Message-State: APjAAAV4j8DcDXwOq24x0+cGQxFiWTdIEkMqWj+jApv5NvfVD5OcjBpD
        17cTLTGzuNkvBXb/xW/biyui4CpH
X-Google-Smtp-Source: APXvYqyfdi+JXp0MxngH5Bq+GtkY2TQMY1vKoP54zc4iYXW8MDmAPUoZxpWIHiELs6qqIKdd6Qb55A==
X-Received: by 2002:a1c:b0c3:: with SMTP id z186mr11652445wme.36.1582409084970;
        Sat, 22 Feb 2020 14:04:44 -0800 (PST)
Received: from localhost.localdomain (p200300F1373A1900428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:373a:1900:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id q130sm11151738wme.19.2020.02.22.14.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2020 14:04:44 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     yuq825@gmail.com, dri-devel@lists.freedesktop.org
Cc:     airlied@linux.ie, daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        tomeu.vizoso@collabora.com, robh@kernel.org, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org, wens@csie.org,
        linux-pm@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH RFC v3 0/2] drm: lima: devfreq and cooling device support
Date:   Sat, 22 Feb 2020 23:04:30 +0100
Message-Id: <20200222220432.448115-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is my attempt at adding devfreq (and cooling device) support to
the lima driver.

Test results from a Meson8m2 board:
TEST #1: glmark2-es2-drm --off-screen in an infinite loop while cycling
         through all available frequencies using the userspace governor

     From  :   To
           : 182142857 318750000 425000000 510000000 637500000   time(ms)
  182142857:         0      1274      1274      1273      1279   5399468
  318750000:      1274         0      1274      1273      1272   5114700
  425000000:      1276      1274         0      1272      1271   5122008
  510000000:      1909      1273      1273         0       636   5274292
* 637500000:       640      1272      1272      1273         0   5186796
Total transition : 24834

TEST #2: glmark2-es2-drm --off-screen in an infinite loop with the
         simple_ondemand governor
     From  :   To
           : 182142857 318750000 425000000 510000000 637500000   time(ms)
  182142857:         0         0         0         0       203    318328
  318750000:        53         0         0         0        21     56044
  425000000:        27        18         0         0         2     34172
  510000000:        27         6        14         0         1     41348
* 637500000:        95        50        33        48         0   2085312


Changes since RFC v2 at [1]:
- added #cooling-cells to the dt-bindings (new patch #1)
- skip devfreq initialization when the operating-points-v2 property is
  absent
- call dev_pm_opp_set_regulators() so devfreq will actually manage the
  mali-supply regulator
- rebased on top of drm-misc-next-2020-02-21

Changes since RFC v1 at [0]:
- added lock to protect the statistics as these can be written 
  concurrently for example when the GP and PP IRQ are firing at the
  same time. Thanks to Qiang Yu for the suggestion!
- updated the copyright notice of lima_devfreq.c to indicate that the
  code is derived from panfrost_devfreq.c. Thanks to  Chen-Yu Tsai  for
  the suggestion!
- I did not unify the code with panfrost yet because I don't know where
  to put the result. any suggestion is welcome though!


[0] https://patchwork.freedesktop.org/series/70967/
[1] https://patchwork.kernel.org/cover/11311293/


Martin Blumenstingl (2):
  dt-bindings: gpu: mali-utgard: Add the #cooling-cells property
  drm/lima: Add optional devfreq and cooling device support

 .../bindings/gpu/arm,mali-utgard.yaml         |   4 +
 drivers/gpu/drm/lima/Kconfig                  |   1 +
 drivers/gpu/drm/lima/Makefile                 |   3 +-
 drivers/gpu/drm/lima/lima_devfreq.c           | 215 ++++++++++++++++++
 drivers/gpu/drm/lima/lima_devfreq.h           |  15 ++
 drivers/gpu/drm/lima/lima_device.c            |   4 +
 drivers/gpu/drm/lima/lima_device.h            |  18 ++
 drivers/gpu/drm/lima/lima_drv.c               |  14 +-
 drivers/gpu/drm/lima/lima_sched.c             |   9 +
 drivers/gpu/drm/lima/lima_sched.h             |   3 +
 10 files changed, 283 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/lima/lima_devfreq.c
 create mode 100644 drivers/gpu/drm/lima/lima_devfreq.h

-- 
2.25.1

