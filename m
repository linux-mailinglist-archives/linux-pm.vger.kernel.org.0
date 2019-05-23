Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFE3F27C19
	for <lists+linux-pm@lfdr.de>; Thu, 23 May 2019 13:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbfEWLro (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 May 2019 07:47:44 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41276 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729949AbfEWLro (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 May 2019 07:47:44 -0400
Received: by mail-wr1-f66.google.com with SMTP id u16so2039280wrn.8;
        Thu, 23 May 2019 04:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9YqtCW0tbRef0Fm5cqvSOdlCFpzkVDTaJgcqIQyiBT8=;
        b=vIq7tLlXXXDRV0gFGARjH6SvTg2BRhRk+p7+wzeII7TToU58ZIRP19lTK0gPptdRKm
         6Qzk8l9R1faq5Z7bl1f+koGGaIjDcALA+jsrK5hJAvxR6Y+4p0igiPcj4pi9U56g1DnR
         EK0zS6hPscmlDdrQHPgtuJQR2o2Pq7kBF5G/8npIHz1ejhYwEQlrhEjg3n4GqGXAYmh6
         PUSfodzylh10zl+/38JW9GzShsYD6cxcw7009XvIoHMY4YYpDrXY085RMj20c7+YIafa
         DbKOw7r6H/NTN32XAvF6fUC5LjsYdimAXsRBZoTzBe98fDKZuCyVCkMxp2VYPBkh+rmK
         0V7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=9YqtCW0tbRef0Fm5cqvSOdlCFpzkVDTaJgcqIQyiBT8=;
        b=bQLSZnv6eKEZm52uLp3Qku3RxMvhM9Vq9KolX0IvGuMatyb1eisuOAZJD2/xG13a/1
         O2Dxpv8+cfV35hyX/WsRAVTVfHTkJflNWGaXcHfNoTywbVk1xkQO9VY2UJykslVuE0cF
         t/JAA2UgNdvwymRDjJVOqp9Rcgwu5ApZPpl93JPFfdUgvn+TnzEmZgdlOUMPq4tKyTl8
         o9zPiaydIyhj5XoK362zCMmRihQ7PvO3uaplHaBzrFaDx6vQUEgh9tpyEgbe9diB6Xyf
         mH9tV54bLsw1fkUzOA/rYXW/qkUrCB/CXvxsULD0kTPVGUXAvZ28p4HdoBnh3x6Uvzo/
         OwgA==
X-Gm-Message-State: APjAAAUaiCWOiCyjxwRVeZFUUnrctIfW429oTouQHroZboXkuDtC8jqs
        5+uFj4xHETytNHVPdhHsGUo=
X-Google-Smtp-Source: APXvYqyXDaVtFOjnuCjBHo3dqsM/hp9hs8h7Skl2dQIHLPNKdqJiMHf1WrYMBDLGZurDJsBXeQ7P+w==
X-Received: by 2002:a5d:4b52:: with SMTP id w18mr329581wrs.262.1558612061895;
        Thu, 23 May 2019 04:47:41 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id x68sm9075665wmf.13.2019.05.23.04.47.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 04:47:40 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id D6B341146D57; Thu, 23 May 2019 13:47:39 +0200 (CEST)
From:   Mathieu Malaterre <malat@debian.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH] powerpc/power: Expose pfn_is_nosave prototype
Date:   Thu, 23 May 2019 13:47:36 +0200
Message-Id: <20190523114736.30268-1-malat@debian.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The declaration for pfn_is_nosave is only available in
kernel/power/power.h. Since this function can be override in arch,
expose it globally. Having a prototype will make sure to avoid warning
(sometime treated as error with W=1) such as:

  arch/powerpc/kernel/suspend.c:18:5: error: no previous prototype for 'pfn_is_nosave' [-Werror=missing-prototypes]

This moves the declaration into a globally visible header file and add
missing include to avoid a warning in powerpc.

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/kernel/suspend.c | 1 +
 include/linux/suspend.h       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/suspend.c b/arch/powerpc/kernel/suspend.c
index a531154cc0f3..9e1b6b894245 100644
--- a/arch/powerpc/kernel/suspend.c
+++ b/arch/powerpc/kernel/suspend.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/mm.h>
+#include <linux/suspend.h>
 #include <asm/page.h>
 #include <asm/sections.h>
 
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 3f529ad9a9d2..2660bbdf5230 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -395,6 +395,7 @@ extern bool system_entering_hibernation(void);
 extern bool hibernation_available(void);
 asmlinkage int swsusp_save(void);
 extern struct pbe *restore_pblist;
+int pfn_is_nosave(unsigned long pfn);
 #else /* CONFIG_HIBERNATION */
 static inline void register_nosave_region(unsigned long b, unsigned long e) {}
 static inline void register_nosave_region_late(unsigned long b, unsigned long e) {}
-- 
2.20.1

