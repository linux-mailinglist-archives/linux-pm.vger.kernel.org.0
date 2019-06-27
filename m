Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E304858C9E
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2019 23:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfF0VM4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jun 2019 17:12:56 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33641 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfF0VMs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jun 2019 17:12:48 -0400
Received: by mail-lj1-f195.google.com with SMTP id h10so3824779ljg.0;
        Thu, 27 Jun 2019 14:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CeMarD4hqNHq1WSuy0GaGBvM3DFC+UAsO/kYojepr1Q=;
        b=N4VR9SXJX36Bsaa75+t9O+PVV5XextD3p/eZpf/U5TdKAc4UXmA2nrMgyxzHakpGIA
         mVQEiX7CseqV4Hk6uSTBbQbDz+7RxLY6Jstfxfcd6XqFyC9cEKI40gb9Mu43PWkHJsMO
         3B7Cdzn5GQ64F184oOqVhh+ZjMhzxcgPAwoMhTIa+jxgcSD2OI72w7qvLFQh9NJsRBwX
         5Av71S9SIXucdBr5HpGP98cxVRjsO/QLorn335qR11+K497FARh4R5Ur10pbWu4eNQup
         pFxXfx7LFVxeOnKBXp/n0+oulhzbuJA2uKAyTzsiPb/n4LqutzJhtLHOYYm7x8PJwN2D
         XLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CeMarD4hqNHq1WSuy0GaGBvM3DFC+UAsO/kYojepr1Q=;
        b=Dm8cF0jifkr/AiS/O36uPXSJZJyH96OHr/XEAjE+2NfNSZ6LNEyKOEtZjaaG2enfQP
         DL+lPRXP7nffBB25XcUdpFmGi67B3LA7V78i5hxUCjzEhc7Al2l4NGxlnWlH0hXKaL4O
         mqhqzqzo1lZkYeW5dD9DYcjsZiFjRx89OHltDtWKB9edFn2RsM3EYTKTggRFeJ4FXkAv
         h/6EoQhSVexo71+KTaDB/Ym7r838QJvjNLlibyj6OfzEM3THcfUviLcZPO5SswMwQwT9
         IiY9ZVj0Wvj73I5b/4FMkqVNCJM+FVfbU0L3jMdPw5WCMlPTiRYNoaUMH7pfe0cUPh3w
         cFKg==
X-Gm-Message-State: APjAAAVF26Hv73WxC74OAMQ+u4lkf4Dbi6/7oDCBmUhhmc2ojNByMRe/
        DYo3HzqTk8qwzEdbOq0ff9U=
X-Google-Smtp-Source: APXvYqwZU55S5p6XQUjCDvNUW2lo50OoD6/zee/XTUPeERX6OE5/oMefK56F31LjG+l3+uANh3DkQw==
X-Received: by 2002:a2e:870f:: with SMTP id m15mr3867623lji.223.1561669966292;
        Thu, 27 Jun 2019 14:12:46 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id p29sm30485ljp.87.2019.06.27.14.12.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 14:12:45 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 22/22] PM / devfreq: tegra20/30: Add Dmitry as a maintainer
Date:   Fri, 28 Jun 2019 00:11:15 +0300
Message-Id: <20190627211115.21138-23-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190627211115.21138-1-digetx@gmail.com>
References: <20190627211115.21138-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

I was contributing to the NVIDIA Tegra20+ devfreq drivers recently and
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

