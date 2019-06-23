Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB3054FE7A
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2019 03:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfFXBmO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 23 Jun 2019 21:42:14 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46328 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfFXBmO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Jun 2019 21:42:14 -0400
Received: by mail-lf1-f65.google.com with SMTP id z15so8703075lfh.13;
        Sun, 23 Jun 2019 18:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MIhByliPUZqKEV+ccmmIqHNl1GcApYUdE2mUQ8FYMHU=;
        b=mW5mbLVFEYFVu5tGaCTMS7E1JTJsIMI3IyTPm/d/TNT2vGZ16gb4QlXclgr7eqBIOx
         rW2i+3VPnZGuRWkVukvVc3nlHi8sJ4MqGav3TW7UW5yhpv6S+X5kqWH3GJu9UK5tT3/c
         8KYMn8/84z0zzEQ2/VwKs4Z8DBV5GdAFS3Z3v6Kbzu70xn6sA1GTdZ+3XhaU6PKLySet
         yhoBoLw6LvBHpzaQGfVnhvfkgJffa9+NnZegixgh64J5Fk2wyZTPft7xxXpf0/7xz0bX
         RLL7x22jfsSR6oYxB+veoIX251WneidKAALXnQ+tGDBrbDc95SMZsqfQIdYI8wdwzIz+
         e/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MIhByliPUZqKEV+ccmmIqHNl1GcApYUdE2mUQ8FYMHU=;
        b=A23Zlac95N4YiU3MeXSZddH3LrBsfkklPezqbT1QeL0qD/bbvOX4SndnAVyHW+lTDr
         6Gm0H5nF4oMTjPJcDvA9RLbqRwj3WZNzE2FS+LC9Mdq7PBKvj2GBkNjpIcpfd6zcbVkg
         QSn9ip5GyLb4UNjUVucwESCx9IeX/8YEDIao4+dybpMasQj7J1fsIuMHGAIioYY9uW9e
         1oqhOhXZIB84SQeeiPBERKldB8qIzHy8DZoDioV8KbVgtD/7uxZKMH3NvuROTuEGpvYg
         NNwaL/5wQeTjVPlB0xyn+nB/VxGIhyW1AqMNvcJVUUZ5FYrMUb+or6ZA4R9fi2FG0Ji4
         iLdQ==
X-Gm-Message-State: APjAAAVJdnSGGjUdAG3U2YkA+G8xUuiFKOxkrvgytGDE50A3bBe6uglU
        htW6bX+3phxP+jbiYgnBYpDCBLnA
X-Google-Smtp-Source: APXvYqyPvAr7gNVBaEEV2vjpR8MeGHeI080ygDMK72Ba030tMSyRVcQ4+ujSFRagVoa//VPqWkGrBw==
X-Received: by 2002:a19:a550:: with SMTP id o77mr20745789lfe.81.1561326525960;
        Sun, 23 Jun 2019 14:48:45 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id m17sm1460029lfb.9.2019.06.23.14.48.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 14:48:45 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 11/11] PM / devfreq: tegra30: Add Dmitry as maintainer
Date:   Mon, 24 Jun 2019 00:46:58 +0300
Message-Id: <20190623214658.11680-12-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190623214658.11680-1-digetx@gmail.com>
References: <20190623214658.11680-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

I was contributing to the NVIDIA Tegra30+ devfreq driver recently and want
to help keep it working and evolving in the future.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6c203278700f..ac347278f1fc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10214,6 +10214,14 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git
 S:	Maintained
 F:	drivers/devfreq/tegra20-devfreq.c
 
+MEMORY FREQUENCY SCALING DRIVER FOR NVIDIA TEGRA30-TEGRA210
+M:	Dmitry Osipenko <digetx@gmail.com>
+L:	linux-pm@vger.kernel.org
+L:	linux-tegra@vger.kernel.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git
+S:	Maintained
+F:	drivers/devfreq/tegra30-devfreq.c
+
 MEMORY MANAGEMENT
 L:	linux-mm@kvack.org
 W:	http://www.linux-mm.org
-- 
2.22.0

