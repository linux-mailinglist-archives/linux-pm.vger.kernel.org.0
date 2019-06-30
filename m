Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39F0E5B02C
	for <lists+linux-pm@lfdr.de>; Sun, 30 Jun 2019 17:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfF3PCk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 30 Jun 2019 11:02:40 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46369 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbfF3PCk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 30 Jun 2019 11:02:40 -0400
Received: by mail-qk1-f194.google.com with SMTP id x18so9001857qkn.13;
        Sun, 30 Jun 2019 08:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5lx5bobu9/exdQA9ScehUUIHniGcpbQg/3rhLERFmFU=;
        b=ANB4+oPVTXKbrn3gwLwrInQVorEEVfLz1AenzOULMh5ogimvvH9zfX7OdX182mzQ14
         tzwUwmvm6i8aaFAGWYQALivl8JJagQhUD+79zEg01qNPAO+CP7qjaR77XAKnBDiYGuLi
         9G9oxkOQqa2OELtJ/vkpKDlLCDmpdcuCLhLl4aPi5ilzmEVkoxLQZ02Q5jn5OehSfuBf
         XHGvi1mOvTmCFWCWiXTqWluvIthT9jInjrzzVk6Fn4pp7cstTRq0oDod3kldzK/xoJer
         OA+dHSMHIangPMRQabPVmwlVFpoSfRW1u2EFeeDdZ8jeFVRJqASdOE56yzeqJfF/cohL
         naxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5lx5bobu9/exdQA9ScehUUIHniGcpbQg/3rhLERFmFU=;
        b=hyBukGSpefq1C4EouOaKUL8yhhjSihegNn4Nit14u6jHnKCQKaa/lZAHA3mhJfYfgR
         lAKuXGcqJ5kElGXN1oBEb6CzMtjHJNXPbGqVuB/eYUnKhdLkZ6nrH3sWQLCQglKcM+2s
         buu7bkdzHQK0vDQb32jbsO38WOD9PKoZf1qTd9MNUapeYACI1QKjHsbzs3QG6dp4V9N9
         mW7PmX0mu70bGxSLj/agAfTdEK4BmvInNZIyyoOLbioWxDz823PkRgYV5+O7x5tsVVd8
         uI/8gkd4hSrJwTFDiglB4FE/iY/o5WnjK/TJatjRY998UmaGG13huOJCrQirUnUN2JLj
         pM5A==
X-Gm-Message-State: APjAAAWC7gOtIUsnRoJuGI1Q+cyVGvF2y3uEsr/nVIdZL7JULbuWJAXe
        UA0N8TOPQw35qS9sBr3zs2U=
X-Google-Smtp-Source: APXvYqwpXAyQFSxCpHHjU7XY2qL+Bo4Tffb/HW97wxtLTMlnaORSn5dfNhcRe9Ku9lyC4TNU2Y+Tng==
X-Received: by 2002:a37:9cf:: with SMTP id 198mr16688485qkj.351.1561906959260;
        Sun, 30 Jun 2019 08:02:39 -0700 (PDT)
Received: from localhost ([2601:184:4780:7861:5010:5849:d76d:b714])
        by smtp.gmail.com with ESMTPSA id y3sm3956962qtj.46.2019.06.30.08.02.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 30 Jun 2019 08:02:38 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org
Cc:     freedreno@lists.freedesktop.org, aarch64-laptops@lists.linaro.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>
Subject: [PATCH 0/5] drm+clk+genpd: support for bootloader enabled display
Date:   Sun, 30 Jun 2019 08:01:38 -0700
Message-Id: <20190630150230.7878-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

The aarch64 laptops which ship with windows, have the display by the
bootloader, and efifb (yah!).  But unlike x86 laptops, device power
management isn't handled via ACPI[1].  Currently the CCF and genpd
frameworks will turn off power domains and clocks that they think are
unused.  This is rather unfortunate, as it kills efifb scanout before
getting to userspace and getting to the point where we can try to
probe the real display driver.

Also it has a few side-effects in that we can't set rate on running
clocks (in many cases).

The first two patches let us flag clocks and power domains which
might have been enabled by the bootloader, so we know not to disable
them in late_initcall.

The next two update drm/msm to cleanly shut down clocks which might
already be running.  *Eventually* we'll want to detect that scanout
is already running, and readback the hw state, to avoid briefly
disabling the screen while the driver loads.  But that is a big pile
of (mostly) drm/msm work.  (Windows also seems to have this problem,
it appears to do a modeset during boot.. so I guess the first step
is to at least not suck more than windows ;-))

The last patch updates the bridge driver to handle the case where
display is already active.  (AFAICT it is the same bridge chip used
so far on all the aarch64 laptops.)  Because the bridge driver can
be probed before the drm driver, and in fact you might end up with
a bridge driver but no drm driver, care must be taken to not disable
the bridge until the drm driver is ready to go, so:

  * Request enable gpio ASIS to avoid pulling down the enable
    gpio

  * Defer enabling runpm in the case that the bridge is already
    running until bridge->attach().  This is a point where we
    know the drm driver is ready to do a modeset.

(There are a couple related cleanups in drm/msm to avoid touching
the hw until we are past the point where we might -EPROBE_DEFER[2]
which I sent seperately as they are probably interesting to fewer
people.)

This has been tested on a lenovo yoga c630.  I've a wip/c630 branch[3]
with this and various other work-in-progress stuff for this laptop.
Next step, figuring out how to pick the proper panel driver, from
the two or three possibilites that ship on this laptop ;-)

[1] On windows, they use a "Platform Extension Plugin" (PEP) driver
[2] https://patchwork.freedesktop.org/series/62999/
[3] https://github.com/freedreno/kernel-msm/commits/wip/c630

Rob Clark (5):
  clk: inherit clocks enabled by bootloader
  genpd/gdsc: inherit display powerdomain from bootloader
  drm/msm/dsi: split clk rate setting and enable
  drm/msm/dsi: get the clocks into OFF state at init
  drm/bridge: ti-sn65dsi86: support booloader enabled display

 drivers/base/power/domain.c                | 10 ++++
 drivers/clk/clk.c                          | 48 +++++++++++++++++++
 drivers/clk/qcom/common.c                  | 25 ++++++++++
 drivers/clk/qcom/dispcc-sdm845.c           | 24 +++++-----
 drivers/clk/qcom/gcc-sdm845.c              |  3 +-
 drivers/clk/qcom/gdsc.c                    |  5 ++
 drivers/clk/qcom/gdsc.h                    |  1 +
 drivers/gpu/drm/bridge/ti-sn65dsi86.c      | 12 ++++-
 drivers/gpu/drm/msm/dsi/dsi.h              |  2 +
 drivers/gpu/drm/msm/dsi/dsi_cfg.c          |  3 ++
 drivers/gpu/drm/msm/dsi/dsi_cfg.h          |  1 +
 drivers/gpu/drm/msm/dsi/dsi_host.c         | 56 +++++++++++++++++-----
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c |  1 +
 include/linux/clk-provider.h               | 10 ++++
 include/linux/pm_domain.h                  |  4 ++
 15 files changed, 178 insertions(+), 27 deletions(-)

-- 
2.20.1

