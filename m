Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2B3424CFE
	for <lists+linux-pm@lfdr.de>; Thu,  7 Oct 2021 08:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbhJGGGH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Oct 2021 02:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbhJGGGG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Oct 2021 02:06:06 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F43C061746;
        Wed,  6 Oct 2021 23:04:13 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id e16so5084955qte.13;
        Wed, 06 Oct 2021 23:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dBN3ZOc4rIGxY71pVig+HVRej67TgqncSg74vvP7BUw=;
        b=JXOnfsSTnD6HRNgX0lY36iktHqYIUULJV7n/yDP5E/nqd8chzcsNGstczBeNv6t3F4
         LU+0iGHruaspNY4XBUMPUjVMANP3YD04dpM4jnt7IpuZXMjZYyx0jUAqg6hRnKXiVvBg
         /M1Z6TlJ0DJNSMmSAc9kjpYiwjKdBzQj+aggE+Tx8UOTh/T3B2W/+JFLdOEBK0QIqKDK
         KztPVU9Xao8hsuXzXa9nC/1TUt4LvXgQgLxKvB7IQQd0OR4mj4mmBuO58zftKC/vTo2g
         1GB0rGI1IfuDbdG0CywOFomzsQqzSxLYqgWmlRjtCXh5JIt5uHtd3uX40ySnNl2cKgGT
         W6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dBN3ZOc4rIGxY71pVig+HVRej67TgqncSg74vvP7BUw=;
        b=dAsn3fkZADUgE5fe34YGilUiV2sxkIu7hdG9iVwDfAZ80gsipzqBLBnfqGtUxYalFT
         KKgWtajB3LMY4rkenJ9lL+WQ07qqdZBMXG0nbHaMCrN4LjGI+4sPH2ODqLId1K3eyq8h
         t3x4GCVt7z0cutCpbD2kIRqQKWmdE8MQDTDYHmHtL3CfiOlAD4G0vrOyF7cUvtA7qq9w
         yli0qM4Y6xowWXEw1e/ypmjl/ao6hDeUGJxFWneAEG8Lz7qtOG5jomJLA+Jbq8OMgURA
         HWsKrWEYaV59isY3VKZIqA+GtxU1BovJSAyFsO12lqEyOiTxFqZli0wtzX4mwVTizNwK
         6rVw==
X-Gm-Message-State: AOAM531a2QaWYb0qYfB1i7x1HEphcv3ubHKs+jiSMQvs/+EotcYHmN6/
        Nvm8ukA8+Zbl5FRXFe8UUfs=
X-Google-Smtp-Source: ABdhPJydC1X+ItLATCkXacxNpOykA0MMGOCCmCBVdLBlADUbJK/3aAw3JmE54yzEk1VUiRmtHEetuQ==
X-Received: by 2002:ac8:7d4b:: with SMTP id h11mr2785430qtb.333.1633586652890;
        Wed, 06 Oct 2021 23:04:12 -0700 (PDT)
Received: from localhost.localdomain (79-139-163-57.dynamic.spd-mgts.ru. [79.139.163.57])
        by smtp.gmail.com with ESMTPSA id x79sm13235042qkb.65.2021.10.06.23.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 23:04:12 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v1 0/6] Introduce power off call chain API
Date:   Thu,  7 Oct 2021 09:02:47 +0300
Message-Id: <20211007060253.17049-1-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce power off call chain API that is inspired by the restart API.
It allows to have multiple power off handlers invoked along the chain
until system is powered off. For the starter this series converts couple
NVIDIA Tegra drivers to the new API. Existing pm_power_off() method
stays around and may be removed once all users will adopt the new API.

There were couple attempts in the past to add power off API from
Guenter Roeck and Thierry Reding, but they were never completed. This
is a somewhat simplified version which doesn't try to convert whole kernel
to the new API at once, but solves immediate practical problem that we
have on Nexus 7 Android tablet where device needs to chain power off
methods.

Dmitry Osipenko (6):
  notifier: Add blocking_notifier_call_chain_empty()
  kernel: Add power off handler call chain API
  kernel: Add devm_register_restart_handler()
  mfd: max77620: Use power off call chain API
  soc/tegra: pmc: Use devm_register_restart_handler()
  soc/tegra: pmc: Add power off handler

 drivers/mfd/max77620.c       |  22 ++++--
 drivers/soc/tegra/pmc.c      |  62 ++++++++++++----
 include/linux/mfd/max77620.h |   2 +
 include/linux/notifier.h     |   2 +
 include/linux/reboot.h       |   7 ++
 kernel/notifier.c            |  14 ++++
 kernel/reboot.c              | 138 ++++++++++++++++++++++++++++++++++-
 7 files changed, 225 insertions(+), 22 deletions(-)

-- 
2.32.0

