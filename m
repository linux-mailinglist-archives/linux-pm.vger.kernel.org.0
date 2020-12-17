Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0E32DCCD9
	for <lists+linux-pm@lfdr.de>; Thu, 17 Dec 2020 08:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgLQHPz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Dec 2020 02:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgLQHPy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Dec 2020 02:15:54 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E909AC061794;
        Wed, 16 Dec 2020 23:15:12 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id 6so21714399ejz.5;
        Wed, 16 Dec 2020 23:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bGy7gLBy2hFyYL8nSs16yQL0Na8VVi6rxjiUYpw2umY=;
        b=hYJDilWH5PI0sM/ctM4XmnHMmy/VC9X9ze3GqvZytzsEnHTTT7JfJPcRe0wc+Oro2O
         UamTbMbmnYThx+VozwRfDpwHQv80X+SUNy+FUvJq/kDc0PfMhxlvc/XykW+jxX/oX5x4
         JdmtEAOqaV+dV64JeZyEX9AaQbAACElDz0SYbXsmsDQYnG977McOlzeSG1FNY3eUu1vd
         0tQQkZyrBLDXRKR81yY0dPHkJKAsFYssk3Un1qjxZoTM+Mnt3rS6rq3lh51KYkaPAhDA
         imCfA3ObkPTwWN9ln0DVugoDXF0b39MdTWFTj9r2uFy5L1krm+H91Ij/B9pBOpdICMtH
         0cIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bGy7gLBy2hFyYL8nSs16yQL0Na8VVi6rxjiUYpw2umY=;
        b=L4teNoQNRq0eHZiFQgfq51esAe8Dbj1ZbiYklV0pc8X5WH9o8u1rJSGwMU0a9VSTS9
         5WyRxzaVjT3pXNOTqMKgTm0rWR2qjaBzlJbsdfehamj1oCsJ6yjzCCeZ8oTcHxjbZx3c
         hquucjLgXE6tamE96kBIXHj9TASGEadfbKJ1J0B8YlTYCYIoWvyBho5vGXn7vNC0Dcii
         kwbhrp2BeXegMPpx0pVTriEx2s4hKlVgHzfkr2AX2onoOBzSNb5ZFKX91UH6lC6KpiOq
         DeV3/5diDbwMMYvQ+yYGIHhE2yxTR4GLR1+VHwY2bk8NhPUWcIBZtpibs0HEaQOd9SpE
         5/jg==
X-Gm-Message-State: AOAM531k5zyXZ8n3TRkR2RGa4Dx8aJHJhWYE3fYikPf03crruJ0BlDD5
        Y+hHBPIHqpl39fw5DQspy4jN25gQALQnyA==
X-Google-Smtp-Source: ABdhPJy1nSlTGWTs/AOPSz2icN7kkMpTQo4NU2ITDs0u8lTrYvpAd6c6H96zc8hAOhvnq6hRAJqxKw==
X-Received: by 2002:a17:907:20dc:: with SMTP id qq28mr33410118ejb.403.1608189311050;
        Wed, 16 Dec 2020 23:15:11 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2dfe:900:8cfe:59ae:f146:5d09])
        by smtp.gmail.com with ESMTPSA id mc25sm2961331ejb.58.2020.12.16.23.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 23:15:10 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: include governors into CPU IDLE TIME MANAGEMENT FRAMEWORK
Date:   Thu, 17 Dec 2020 08:15:01 +0100
Message-Id: <20201217071501.31267-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The current pattern in the file entry does not make the files in the
governors subdirectory to be a part of the CPU IDLE TIME MANAGEMENT
FRAMEWORK.

Adjust the file pattern to include files in governors.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on current master and next-20201215

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 952731d1e43c..ac679aa00e0d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4596,7 +4596,7 @@ B:	https://bugzilla.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 F:	Documentation/admin-guide/pm/cpuidle.rst
 F:	Documentation/driver-api/pm/cpuidle.rst
-F:	drivers/cpuidle/*
+F:	drivers/cpuidle/
 F:	include/linux/cpuidle.h
 
 CPU POWER MONITORING SUBSYSTEM
-- 
2.17.1

