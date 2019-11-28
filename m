Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC2D310CC6E
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 17:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfK1QDX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Nov 2019 11:03:23 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39704 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfK1QDT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Nov 2019 11:03:19 -0500
Received: by mail-wm1-f65.google.com with SMTP id s14so5423733wmh.4;
        Thu, 28 Nov 2019 08:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uucM1tKJc5jWqCc67DTWheZ6n5xnlGm793Fj7re5sec=;
        b=ScUb3/Nie1rHzq0BskCOA9h4NfcMr0F3zMYSBP6ux5FKBJrjKCq6xrw7dTVdXSpxx6
         boXBSHDFKbdNVaY0UEIYFxoLOxQgBmIRwmEf7YAPHNY8EAEWPgBHQTTckOAlCK5GsDVT
         I2ydTL4+YjQME5K/Td+A27GPDACteFoDCNluHZaJIQSJwfVDLbkymJkL6a/kBuDORq0v
         2CwaOueAfH7P3jiwihGD+ujJxF/063K0Qi3ltXxkNi6IwV0fnx7YA7a4tFWv2FyGl+CZ
         9jelOAZUls0n71h/qXNZD9LHfe1E8zpYixdWpBvdk/dWt/MeDlqDlAGt4XxTucLXSwqm
         9kRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uucM1tKJc5jWqCc67DTWheZ6n5xnlGm793Fj7re5sec=;
        b=Csc48VjHxvgpVLa4suHjJBkWE90vrvEVoSeOY1Vm38/0nYH9ax7xhhEEHDSjMm8wTV
         huiIiM0T4N6xMily0agfG9hODJjLNrhR43WKcmt6Yj7S4PQ9z5f8qSIpksCI9/iScZs5
         NViepjZjLp8cq2ibpcFNnwRenCcSLzbrT2mKgBmiEspr1nnSIeXNZEKC3fz45eflIkXU
         eTVv1hz/Z7mQt0RnJGkAKZNfHH9PqtC8A947cEqIqzAOyuW7UegXkGEbjtOS+FsR7YKX
         J4JN6SkC+FioVez1vGZcleMD44ZTjSgX+Y6YWcqmykJzHwgCG9GMv4LNotTUiWzfBFnF
         uT3w==
X-Gm-Message-State: APjAAAVfbeabiWVULRysY1pGfgWjpreXVZqJrpED5/3OZFhzfFvvqynT
        VW6Ul+tJsHqhB4Sx6MdYSNk=
X-Google-Smtp-Source: APXvYqwWg14hIzEy7xtKUoZNjVc9x68LHyXjjnN6zGyvic3/XoEZKRwAtefKiOcnBebLDi3JrYU0wg==
X-Received: by 2002:a1c:a548:: with SMTP id o69mr10148533wme.31.1574956997396;
        Thu, 28 Nov 2019 08:03:17 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
        by smtp.gmail.com with ESMTPSA id a64sm12210356wmc.18.2019.11.28.08.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 08:03:16 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Osipenko <digetx@gmail.com>, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org
Subject: [PATCH 0/2] PM / runtime: Allow drivers to override runtime PM behaviour on sleep
Date:   Thu, 28 Nov 2019 17:03:12 +0100
Message-Id: <20191128160314.2381249-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

This is a result of looking into a more formal way of doing what was
proposed here:

	http://patchwork.ozlabs.org/patch/1145363/

The Tegra DRM driver is written such that runtime PM controls all
aspects of bringing up and shutting down the hardware associated with a
display pipeline. This works very nicely with the DRM/KMS atomic mode-
setting framework that has very rigorous call sequences. There are also
suspend/resume helpers for system sleep that are built on top of these
generic helpers and that cause the same code sequences to be run as if
users had simply chosen to disable all display pipelines at normal
runtime.

The current behaviour of the PM core to disallow runtime suspend/resume
during system sleep gets in the way of this because the devices do not
in fact runtime suspend/resume during that time. Most of the time this
causes display outputs to malfunction upon resume.

Now, there are good reasons for preventing runtime suspend during system
sleep, as given in commit eea3fc0357eb ("PCI / PM: Detect early wakeup
in pci_pm_prepare()") that originally introduced this mechanism. There
can, however, also be cases, like the one described above, where it is
safe to allow this. Add a flag and a set of helpers to set or clear that
new flag so that drivers that know it will be safe to runtime suspend a
device at system sleep time can mark the device as such.

If a device has the flag set, the PM core will no longer take a runtime
PM reference for it, thus allowing the device to runtime suspend at the
expected time.

Thierry

Thierry Reding (2):
  PM / runtime: Allow drivers to override runtime PM behaviour on sleep
  drm/tegra: Allow runtime suspend on system sleep

 drivers/base/power/main.c    |  6 ++++--
 drivers/base/power/runtime.c | 16 ++++++++++++++++
 drivers/gpu/drm/tegra/dc.c   |  1 +
 drivers/gpu/drm/tegra/dsi.c  |  1 +
 drivers/gpu/drm/tegra/hdmi.c |  1 +
 drivers/gpu/drm/tegra/hub.c  |  1 +
 drivers/gpu/drm/tegra/sor.c  |  1 +
 include/linux/pm.h           |  1 +
 include/linux/pm_runtime.h   |  2 ++
 9 files changed, 28 insertions(+), 2 deletions(-)

-- 
2.23.0

