Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27B6F19CCBB
	for <lists+linux-pm@lfdr.de>; Fri,  3 Apr 2020 00:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388218AbgDBWUE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Apr 2020 18:20:04 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40818 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbgDBWUD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Apr 2020 18:20:03 -0400
Received: by mail-lj1-f193.google.com with SMTP id 19so4946854ljj.7;
        Thu, 02 Apr 2020 15:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=55th5sY/tJDdmgw47Yk8n/xwE+j1OiKzwjzTyfprGYQ=;
        b=d+G7a3ZUzsJ8J4aJMaGwf1PsqRYWjI8ODyaI3P5Pb7vr+xgeR7mklVJE7Fize23iTv
         7e31Sxr4kCfJiEOMo6KpoinpO7DR0jvucQpDBtsnnrqpSW2oc4o4Ut7KODBnTJXqbjri
         vg5PFTJL2hwCYFCkUWA29FnsZLFTmV9Ac8MrCTc6Flpj1xhURmFzrkWgtB+DcBiPz+Ra
         VOMiwENpcagifJ7Olatk1k64I9E+Q4FYrlb5QLODiVZVbJJyP5+SMidLprX9rvDjUc+t
         14LTedDIpw+SACHn0azr+L5fiJLedjBpHkxH0qtspDEFC26pdm/gzBug0vTsaDvYDVe7
         PjvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=55th5sY/tJDdmgw47Yk8n/xwE+j1OiKzwjzTyfprGYQ=;
        b=T8AxnZhyR9hWP5xk50gDbHfEv29c3JfWG/P/EgqOjtCoFdNB2dYK60leJE2l+ylwmp
         /PDy+A0MApN6bo6vUulwnRt49UCH6f1wr4bf5nYqU+yh4KBd9WSwt7sxtFv8ZbkzrKjb
         b5zdqeAe2+QQ5r9u9tRgi4dTsEbTcrR0j7/mg/oBg1xNHWU9uUWzIZqz8t6o1vebX+Up
         HHXK9KSPuMNtiGCazQEIV9RxoLUM7Rt95+1Gw/Ij5wATlJ5PuvjqLm6pXKVanBbL2vA7
         IiVO8fvSMGo/2zbTToX1sL4qkZjUkzqslmyLh3Xe1qkp0bEuywX6J7tz5y83/88T2Zha
         iR+A==
X-Gm-Message-State: AGi0PuZfYZCrYjPezOHH/mPQzpW6aTP1D286ONOLLNQNl/b/ct8lwfa2
        1NCUTrhbqPM6jCcB+qsi+p4=
X-Google-Smtp-Source: APiQypKZDrsGOKzHLNWdA6sf763EVRlnf4o8ombxUNU7YjIjeV0UEaGDTkXwH0Ny0Tv/9eS0gklNIg==
X-Received: by 2002:a2e:6c0a:: with SMTP id h10mr3077105ljc.195.1585865999798;
        Thu, 02 Apr 2020 15:19:59 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id v10sm4645712lfb.61.2020.04.02.15.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 15:19:59 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] PM / devfreq: tegra: Add Dmitry as a maintainer
Date:   Fri,  3 Apr 2020 01:17:23 +0300
Message-Id: <20200402221723.6064-1-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

I was contributing to the NVIDIA Tegra20+ devfreq drivers recently and
want to help keep them working and evolving in the future.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

Changelog:

v2: - Addressed review comments made by Chanwoo Choi to v1 by correcting
      git's address, making this patch standalone and adding Rafael Wysocki
      to the list of email recipients.

 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 245a96316636..0a694e20ea19 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10922,6 +10922,15 @@ F:	include/linux/memblock.h
 F:	mm/memblock.c
 F:	Documentation/core-api/boot-time-mm.rst
 
+MEMORY FREQUENCY SCALING DRIVERS FOR NVIDIA TEGRA
+M:	Dmitry Osipenko <digetx@gmail.com>
+L:	linux-pm@vger.kernel.org
+L:	linux-tegra@vger.kernel.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git
+S:	Maintained
+F:	drivers/devfreq/tegra20-devfreq.c
+F:	drivers/devfreq/tegra30-devfreq.c
+
 MEMORY MANAGEMENT
 M:	Andrew Morton <akpm@linux-foundation.org>
 L:	linux-mm@kvack.org
-- 
2.25.1

