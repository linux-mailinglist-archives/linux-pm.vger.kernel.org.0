Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0252C55D9B
	for <lists+linux-pm@lfdr.de>; Wed, 26 Jun 2019 03:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfFZBfQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 21:35:16 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42826 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfFZBfP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2019 21:35:15 -0400
Received: by mail-lj1-f194.google.com with SMTP id t28so402285lje.9;
        Tue, 25 Jun 2019 18:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BUdUWTVBTb79ShDTghVClnAglKKtZu5mKsirPQrlfLI=;
        b=VKglz/FDbn1OhUHTaYNudawoF8YKq/c/gpdT8/OIlPIb5idbxCTUITBR0OV9gpGI7n
         yrLQist4pZHwVpnTpTo/R+9vGqVAWDtux8ac7XMJvn9xCLwd5Zqj82U2Yj0NDSeWa2KQ
         of9Vg+5g+Z613tuWgXkbH1OXXCfVxUOt41dxvfxU7ostcdmX5oXTt21zLDDBhibCUwi4
         qlk7O0+mcwtHGbVzTypVsfgYDWJWMUtY5k0r2clw8MV4DRynCxsrVNO6YX1T4EB8WZD+
         4Aj0WPuG3XCW4KCVFE8JAPOM4kbWO9A4hOctSt4BZp6/R/lIK88x6pZ17RjBduzer2in
         +cqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BUdUWTVBTb79ShDTghVClnAglKKtZu5mKsirPQrlfLI=;
        b=SXAV6gsMiMhzmv7J2SCte1IcFSabhJc/vx30iu4yFZkOFeJM9La8qB6RyP2OYXeYSr
         T4r+oIGCFEKerPAz2EyNHW1x0xH5ZBhdnrgbnr+M9ANlnLVOQO/5N9+PINcx4zIxe/8M
         rri53OKq1giHuGX6GCTqbkoRCG+vfGJ6fN45/W7Ij7fOYY3bEqzuQw2I30kKwJjLGKox
         /F45Z4qBeJlegIt8aTU5KmIrxHxfpP3vgo3kPyPEyGYYmMdFyQksZYhMhs1SdbNChIDl
         CdG4ct9wZGOiYoTpnMZ0vv1r5sEv3IObTMoXs+uGdtTrxmw1zFPg0zGixy4kNbOpTkcs
         KGIw==
X-Gm-Message-State: APjAAAUDXnnUWHIw7v9e807t/2FBqxDNOi6Kp1NKI/wzKNL0TY0ZyVy6
        vJcmUrWbvQfgTJGELQt/V1XmD/Qk
X-Google-Smtp-Source: APXvYqwznj8GWn1ttqhcfxa2m5bjBKiHSvHOjswdfkXI+wmI3vCRs8fpWZxljazmyQHGTpu7iWyaMw==
X-Received: by 2002:a2e:63cd:: with SMTP id s74mr900911lje.164.1561512913370;
        Tue, 25 Jun 2019 18:35:13 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id 199sm2549581ljf.44.2019.06.25.18.35.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 18:35:12 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 17/17] PM / devfreq: tegra20/30: Add Dmitry as a maintainer
Date:   Wed, 26 Jun 2019 04:32:51 +0300
Message-Id: <20190626013252.30470-18-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190626013252.30470-1-digetx@gmail.com>
References: <20190626013252.30470-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

I was contributing to the NVIDIA Tegra30+ devfreq drivers recently and
want to help keep them working and evolving in the future.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 792d2d927712..bfd827417a27 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10250,6 +10250,15 @@ F:	include/linux/memblock.h
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
2.22.0

