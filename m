Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD641140A2
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 13:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbfLEMMw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 07:12:52 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54285 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbfLEMMw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Dec 2019 07:12:52 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so3464404wmj.4
        for <linux-pm@vger.kernel.org>; Thu, 05 Dec 2019 04:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a/bPYKhe1GakALad5JS+KohOI4Rn9GZiH2J9WIdwc2g=;
        b=eQ+1PV5VQO68lWKbY0CiRjbOCXUvk9IqTevetqN1VUeD+A1udFd5dLT6cf1RvvZ6wt
         mrufu8kKbABKImB3RGorm8BMdrWTK7tPIhGF9SLK38AwNqJAUGJJ1yx0uM+IdwT2dwov
         46MrFSDjGsI6vCQ/h3Y/6NUELcfaa8RRoEdpVKC2Zx5kseovT7rDSDXwZW0QeB+GbzY2
         /MPrdi5znrW6xHE8E8CjDr6PWfYRrhgB+jW8i9SK/3QFDfpwsyHc8zanEXNauIkGCpA7
         LQRH2GiW10bv8/tzEyHGRdgfnzi8uiQ9uULSZd2Ame9NMS/zbGBUKGku3l8WJ5AivnM6
         ZZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a/bPYKhe1GakALad5JS+KohOI4Rn9GZiH2J9WIdwc2g=;
        b=p/v+LXMRDqrGolpTmkU2iTEU/C4lV+Px0iXKaDBljkrJeQaP7V6fWVu5n87vk3F3fV
         KFrA1rEUOePh8OYuzKhA4wocN69alJYuO2zeMInpJlgZnRpwDVH8yOk4raJa8g/25wXg
         oNLFCh6U8X7+TQuK0jLJEvaFij9K2y7Y8R4tJwG1zwNVP8bx3z98rFkdIOcFORXCcZne
         TgU+0kefuwgWnuM3+yjpY/d2Cl7f1CENINeOzq/IxXI+XMC2bHL3OhXnmGAGJRrh1c2H
         uxwLfaiAvW1mVYJIZqsEOLR12YKbJBAGWqe+ugLZerF3daK/Q4n7dFlHOZCc5cRbRMMZ
         tDyA==
X-Gm-Message-State: APjAAAWgAggOZcabLJEFW2raq0SMBUbgqzeI+tH9PBlSGCYzn/uwoBee
        NIRS8Awp+NjJZFR+tV/vbpD6lA==
X-Google-Smtp-Source: APXvYqxrJ1eTzRC9uENcWl0MEdd35pt9HGUDr70Y0oxbdzxufNnPN/k0IDOyYdewbNB7eNeTLNscnA==
X-Received: by 2002:a1c:1f51:: with SMTP id f78mr4793040wmf.60.1575547969849;
        Thu, 05 Dec 2019 04:12:49 -0800 (PST)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:24c3:ebb3:9dd5:81c6])
        by smtp.gmail.com with ESMTPSA id f1sm12232732wrp.93.2019.12.05.04.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 04:12:49 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rui.zhang@intel.com, ulf.hansson@linaro.org
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH] MAINTAINERS: thermal: Change the git tree location
Date:   Thu,  5 Dec 2019 13:12:27 +0100
Message-Id: <20191205121227.19203-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAPDyKFqFswOjqNn0s7Y3BAeYuVr+z2NrX3fbn+yu+O1vgWb8tA@mail.gmail.com>
References: <CAPDyKFqFswOjqNn0s7Y3BAeYuVr+z2NrX3fbn+yu+O1vgWb8tA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The thermal trees were merged into a single one shared with the
maintainer of the subsystem.

Update the location of this group git tree.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8acaf4f205a1..10607a4f1b04 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16082,8 +16082,7 @@ M:	Zhang Rui <rui.zhang@intel.com>
 M:	Daniel Lezcano <daniel.lezcano@linaro.org>
 R:	Amit Kucheria <amit.kucheria@verdurent.com>
 L:	linux-pm@vger.kernel.org
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
 Q:	https://patchwork.kernel.org/project/linux-pm/list/
 S:	Supported
 F:	drivers/thermal/
-- 
2.17.1

