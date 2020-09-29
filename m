Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873AA27D924
	for <lists+linux-pm@lfdr.de>; Tue, 29 Sep 2020 22:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbgI2UnB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Sep 2020 16:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728301AbgI2UnB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Sep 2020 16:43:01 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737D1C0613D0
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2020 13:43:00 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k15so6906089wrn.10
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2020 13:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yxgmFTxkf8Q7snkiRmdFU3li5pqox2TGA0gnwiFInxo=;
        b=UgbWx+QLzIaXuWGj5Ky/C2Dh/s+6ClhTiU6nRCRCCG20Ucbaw5PclR+ti4GKk1j6hL
         NofBXmiD6yIiLMFyhMH3RjbPc+RNM/1FW/q6az8FGjQHm3++YOp1Pv+HcKrfVcU9/F2A
         TF0cltucY5XzKDSvLpA+BNJB7ZmkaYuBI6ihPuSvYpaGZiOYHrhikW9LlzVLUQq/O7rx
         rwWQZvd0t65zBXomYpYV0yU+Dv+qRr8+/cEAwaGzelE5JwgYRiPhYqJAbVkp3tdl1zz9
         n2XQeXgqPY+KipSXI1az0+ZSFubPhOWpaAMOiIKE+5UKO6YpC4c+0jZqGGDkj931pc+j
         oxHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yxgmFTxkf8Q7snkiRmdFU3li5pqox2TGA0gnwiFInxo=;
        b=YZPW5Jjpx4/Ap4Uj649Tox6bIW5FpDsUbfr2EL5qIN++utqZ26E2rXytI/uW4T/vgv
         9w6f5bhcdu6ofWFOvZ3OnF0wEOXwv7duYKNWKJytT7Lwr45Mo97zXNgA1kyowzEUy6wN
         Ki9ufV6aGnDP7mvPBgku7lmePWo28sJHd8Wnswbk43t81mhb+55tW61GQLLWSLlThdUw
         AePy8cNhnMNnV+bBi0tnV7VOayY4ZgXBd6om5f55PvBvfn/rYU5sSZVB1Rmi6ZnSOwKn
         isq69QgX/BsZgeOrS9gCVB4CYmwwZCFiqf1DY6VWdGKA3aENuaJAA1B6zBNcIKUgfctY
         Jacg==
X-Gm-Message-State: AOAM531styOldeFz4BlcL3o+TLyh28sANVJPaRPYD9S+tSdrL9ynwqtk
        tszJgGV8oLnN6GZqDqJLdMegGg==
X-Google-Smtp-Source: ABdhPJw9IC5utvm4ax9rkKU/A7/jQf1cuLDFaUdt5CEfnkoqvrM2W2ynFzUbR7P/w7Jw/uEaYSl2xw==
X-Received: by 2002:a5d:56cd:: with SMTP id m13mr6120637wrw.261.1601412179072;
        Tue, 29 Sep 2020 13:42:59 -0700 (PDT)
Received: from P-ASN-KEVALD.idf.intranet (85-170-108-21.rev.numericable.fr. [85.170.108.21])
        by smtp.gmail.com with ESMTPSA id a10sm6780755wmj.38.2020.09.29.13.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 13:42:58 -0700 (PDT)
From:   Yoann Congal <yoann.congal@smile.fr>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yoann Congal <yoann.congal@smile.fr>
Subject: [PATCH] Documentation: PM: Fix a reStructuredText syntax error
Date:   Tue, 29 Sep 2020 22:41:58 +0200
Message-Id: <20200929204157.26127-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix a reStructuredText syntax error in the cpuidle PM admin-guide
documentation: the ``...'' quotation marks are parsed as partial ''...''
reStructuredText markup and break the output formatting.

This change them to "...".

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 Documentation/admin-guide/pm/cpuidle.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/pm/cpuidle.rst b/Documentation/admin-guide/pm/cpuidle.rst
index e70b365dbc60..191cfa4a450b 100644
--- a/Documentation/admin-guide/pm/cpuidle.rst
+++ b/Documentation/admin-guide/pm/cpuidle.rst
@@ -690,7 +690,7 @@ which of the two parameters is added to the kernel command line.  In the
 instruction of the CPUs (which, as a rule, suspends the execution of the program
 and causes the hardware to attempt to enter the shallowest available idle state)
 for this purpose, and if ``idle=poll`` is used, idle CPUs will execute a
-more or less ``lightweight'' sequence of instructions in a tight loop.  [Note
+more or less "lightweight" sequence of instructions in a tight loop.  [Note
 that using ``idle=poll`` is somewhat drastic in many cases, as preventing idle
 CPUs from saving almost any energy at all may not be the only effect of it.
 For example, on Intel hardware it effectively prevents CPUs from using
-- 
2.20.1

