Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3E64E929F
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 23:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfJ2WGl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 18:06:41 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35197 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728582AbfJ2WGb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2019 18:06:31 -0400
Received: by mail-lf1-f65.google.com with SMTP id y6so11721729lfj.2;
        Tue, 29 Oct 2019 15:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jbUWlE4N7GHEhDeg6Rs3vg2Hd4wEPrYqqxEHl2ZIB0Q=;
        b=DkeswJ2tL37hW10JTWqtUBukW5tFU5kBVvkPmpKLwGwrNdCIAuBpTOziB2AlxeHBBO
         CdMkCLDjX6VBtjUqsmEXF/H/cJVryGnD86mrZH8LROg+KFAYnAnNSADG7BJ+NtDZlcOf
         eTsCSJQHLqbRFR1pgPu+VG3fwQKInQiIVOQsacymAAZXKVit2PwnMA4u0yzpfy9uyvRs
         UVpXOIX+n6wNxlpFDZrH0/Vz9rmcYSeKttACpNyTCjVRGAmK9bju1E22QERD1snyLtmG
         fQdzpoY0x1KSDv6UFespLGYpmHG3jqIlFXDnQkw0WHzsmeULXdx0RyKtOKwiHetPuJWp
         ttqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jbUWlE4N7GHEhDeg6Rs3vg2Hd4wEPrYqqxEHl2ZIB0Q=;
        b=WuFWn9qZiRAmL33r5zjw0FQBcQ1XlGAaRIo6/1qOkWMXq7LMSgwklROcAGuLxwLOLE
         6aLcPVv92TYXazzp8r28gy70gR35kdMLZzUpYbPgls3z3RHI33aJ89w9eVBAWziRD9SQ
         Nhv/ysGv73kxVDyP0SAurJQXbvFdbr7vg6liSlDikA/gv6IXY29rPXaT7BVdOmBxPVNj
         RlCmQlGgJTETQ3rmBMTrLidKtSqCgZCuFHy+pNlHsONk5NkQfA1NyAus6GaJTBw977Ji
         yw79JpTrvdA80HxzHbtdYv5m+O3Wpwy2DbuWMdFa5zQcqWKCiAE2k4yupUeV90jtbFzj
         XvxQ==
X-Gm-Message-State: APjAAAU34NWQfRoBAUxQ2R44RnYC2nljejUh2Y2Vzpk8/I+tmUwFfy0h
        KIKP7NqDW/gZAhqcV+9xiS0=
X-Google-Smtp-Source: APXvYqynfve6kSCNW//RN6HZE3BSciRBSzH+sPZi0ac52KbVktmu7Nj2VQb+LfeIo9fNRrHPKAsi9Q==
X-Received: by 2002:ac2:4ac1:: with SMTP id m1mr3882976lfp.182.1572386788661;
        Tue, 29 Oct 2019 15:06:28 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id 12sm51536lje.92.2019.10.29.15.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 15:06:28 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 19/19] PM / devfreq: tegra20/30: Add Dmitry as a maintainer
Date:   Wed, 30 Oct 2019 01:00:19 +0300
Message-Id: <20191029220019.26773-20-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191029220019.26773-1-digetx@gmail.com>
References: <20191029220019.26773-1-digetx@gmail.com>
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
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2cd4937356fe..a64a4aa34f2a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10595,6 +10595,15 @@ F:	include/linux/memblock.h
 F:	mm/memblock.c
 F:	Documentation/core-api/boot-time-mm.rst
 
+MEMORY FREQUENCY SCALING DRIVERS FOR NVIDIA TEGRA
+M:	Dmitry Osipenko <digetx@gmail.com>
+L:	linux-pm@vger.kernel.org
+L:	linux-tegra@vger.kernel.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git
+S:	Maintained
+F:	drivers/devfreq/tegra20-devfreq.c
+F:	drivers/devfreq/tegra30-devfreq.c
+
 MEMORY MANAGEMENT
 L:	linux-mm@kvack.org
 W:	http://www.linux-mm.org
-- 
2.23.0

