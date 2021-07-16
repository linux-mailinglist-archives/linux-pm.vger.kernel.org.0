Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 608E43CBD47
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jul 2021 22:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhGPUD4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Jul 2021 16:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbhGPUDx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Jul 2021 16:03:53 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1209BC06175F
        for <linux-pm@vger.kernel.org>; Fri, 16 Jul 2021 13:00:57 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id bu12so17006763ejb.0
        for <linux-pm@vger.kernel.org>; Fri, 16 Jul 2021 13:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rammhold-de.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kdw0IQFcrZt6p5a2Ip3t1Stcax4FglAn7CAcnCq9/SM=;
        b=dh6cUHAnOvTvoIvocM9kSSSzAyojdxBbrfoWEW3dOuT5r8XB6/86iQo+3RCoDsYTPy
         I/Y7BFgrEnEIz5nruIlu7cg7itgBAodiL66lQFqVhS+g+1oZxhgLu6z1PqL2dHCsXMLz
         nixLpfPwT0m5S9alqIl68ZVJAcivcE2mN6yqguSBAU8/9efhLPUEBDm7A4DGWEThu3V+
         ZxdXYMA4IrErXxZXuC+HYLlwmQFWsyyTxkvPHPcg8zI1R30jPg3HF/V+koL7ESQfgsdC
         M2T4xMAn0hhKKt84vCSVOpQqPtumGaW83aQ/mAzv57Ey5irZxD1lpIsMdT+D027uIN1S
         /eHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kdw0IQFcrZt6p5a2Ip3t1Stcax4FglAn7CAcnCq9/SM=;
        b=JL7PIR/ocRd/EjMCxN1UMFWwfXd4Sa1RSa848tWZxUkXAB5O7LZrXFd0IQfdqN0yV5
         g2VpXS47R/RK5YTK2sGvZm2NP5BIgVuGjcpGOYGV3soMvmuXA5qqBxHu9yXlW/nd8GGp
         23UnGwYOq6MzTbmk80F0rWORBQRJq8LZCq8RgPc8oiT7cDlrVD3DJBjHu4GlcluYfe3r
         /oMa0ZrwUXcfJPkvqoSuTyfsFI1RK8AXczoZO3wGfIIbmLRhrhqcxG0lbudJwVyBPlw8
         Uc8MRG7j8htxPK+dFrekOZrbGK3iEVatXerKeaTc6Ejf/w4SMgqHiz1AZe3d+cxnLry9
         jGnQ==
X-Gm-Message-State: AOAM530gJhtyPyNycLUwczBNSTs+mLwec4OqYT9hyWh5MMPnIQC5djZ1
        uFciZaNA7SBcIIaffLMBVZI/UjciVAqoF6cK
X-Google-Smtp-Source: ABdhPJy4BwHJ6z5T0auOOYDx4/jEfFccIT9YPIMcZinqkT5hbGkCQFtenoLlumCpqJmyBznubvNkag==
X-Received: by 2002:a17:906:6dc5:: with SMTP id j5mr13500151ejt.364.1626465655654;
        Fri, 16 Jul 2021 13:00:55 -0700 (PDT)
Received: from localhost ([2a00:e67:1fd:a:4a4c:28ed:97af:54ad])
        by smtp.gmail.com with ESMTPSA id l16sm1717539eje.67.2021.07.16.13.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 13:00:55 -0700 (PDT)
From:   andreas@rammhold.de
To:     Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andreas Rammhold <andreas@rammhold.de>
Subject: [PATCH] tools: cpupower: fix typo in cpupower-idle-set(1) manpage
Date:   Fri, 16 Jul 2021 22:00:34 +0200
Message-Id: <20210716200034.2158602-1-andreas@rammhold.de>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Andreas Rammhold <andreas@rammhold.de>

The tools name was wrong in the SYNTAX section of the manpage it should
read "idle-set" instead of "idle-info".

Signed-off-by: Andreas Rammhold <andreas@rammhold.de>
---
 tools/power/cpupower/man/cpupower-idle-set.1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/man/cpupower-idle-set.1 b/tools/power/cpupower/man/cpupower-idle-set.1
index 21916cff7516..8cef3c71e19e 100644
--- a/tools/power/cpupower/man/cpupower-idle-set.1
+++ b/tools/power/cpupower/man/cpupower-idle-set.1
@@ -4,7 +4,7 @@
 cpupower\-idle\-set \- Utility to set cpu idle state specific kernel options
 .SH "SYNTAX"
 .LP
-cpupower [ \-c cpulist ] idle\-info [\fIoptions\fP]
+cpupower [ \-c cpulist ] idle\-set [\fIoptions\fP]
 .SH "DESCRIPTION"
 .LP
 The cpupower idle\-set subcommand allows to set cpu idle, also called cpu
-- 
2.32.0

