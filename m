Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC1122963B
	for <lists+linux-pm@lfdr.de>; Fri, 24 May 2019 12:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390539AbfEXKo3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 May 2019 06:44:29 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53319 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390535AbfEXKo3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 May 2019 06:44:29 -0400
Received: by mail-wm1-f68.google.com with SMTP id 198so8862703wme.3;
        Fri, 24 May 2019 03:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0jy20rK00X/Jpvye1eiZdw+BT0nVJunFQCUMU0sD3iQ=;
        b=X1PxbDFgBqLM2NhmlrzxN/Z4MQHhxPSqs6aIHaPvF6iBAMLHzmH4nUvsmk//1HfYtC
         M7+RiqIUBnxnUqtQ25FtAlI9TYUuDf8FA0WWWY/sJW0s+MvmNdXDzLauptvrWs2cUaqj
         xB+/SW80bPKdsBGtHWxc3y8FmFHI5GngHXc59KD+O5Lr2DZmG38IJpvxIEkC6uuIeR/7
         wWJu9Qn8qPhvMRywg+V6bnzPeOFiQ/IORcoYGzLsMY7vtwENi1rb4BA++E0rVIYk3rnv
         Y0vPlbwObLKxWrwWEwMTrgKOWFImoQkdIM62Bc2RaeWmlzzqiOrhfp4C5RF5aK4p4H/c
         49DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=0jy20rK00X/Jpvye1eiZdw+BT0nVJunFQCUMU0sD3iQ=;
        b=dxKknvKYCf+qdGu5T4HpBMZ1JuqQ4tf9CezMFm2bmpuxekMSz8gPS2sPR2q9L5+qP3
         OzbC77RH80chMLppMfi5jeucEsRVgVJy0rtDFM3+ecdmdsT5B/uaxdFQN2453zwwDT0g
         +PMLK4hENioCAxCZaV+fgkbkUtBWintsQm0G8DqYntHfBLid4nCx1gVQQVi8U/DU/bwx
         pXK2DEuNbWG3GwI6gPkGk3jfD71/O+Bw/7dGeqLRokXarfpvBvU8PdGedmZMFGj2pX/X
         f+7GFNUvRR0ZkmEkydnr7VmBbuqywDD1UKi1p+5aC6lIpruVzoE9Wxpt4Kc9SgUDpG27
         u4dw==
X-Gm-Message-State: APjAAAUysrWhKLDeQyJi2f+YbeDLqUxBzXOhzSgN5KO/Vl561VLV7zKs
        ksYYVOTwpDGNfhk2XX3eBoc=
X-Google-Smtp-Source: APXvYqyeytuN8l7DauI//G/eM6aGcU8yhn6PWpRVKMHeZ4rs7BNDg9Pkie2MVw5YsStjKFsnchTflQ==
X-Received: by 2002:a1c:6c0a:: with SMTP id h10mr16235945wmc.135.1558694666632;
        Fri, 24 May 2019 03:44:26 -0700 (PDT)
Received: from macbookpro.malat.net ([2a01:e34:ee1e:860:6f23:82e6:aa2d:bbd1])
        by smtp.gmail.com with ESMTPSA id o6sm4589463wrh.55.2019.05.24.03.44.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 03:44:25 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 9E40B11415E7; Fri, 24 May 2019 12:44:24 +0200 (CEST)
From:   Mathieu Malaterre <malat@debian.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v2] powerpc/power: Expose pfn_is_nosave prototype
Date:   Fri, 24 May 2019 12:44:18 +0200
Message-Id: <20190524104418.17194-1-malat@debian.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523114736.30268-1-malat@debian.org>
References: <20190523114736.30268-1-malat@debian.org>
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
missing include to avoid a warning on powerpc. Also remove the
duplicated prototypes since not required anymore.

Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v2: As suggestion by christophe remove duplicates prototypes

 arch/powerpc/kernel/suspend.c | 1 +
 arch/s390/kernel/entry.h      | 1 -
 include/linux/suspend.h       | 1 +
 kernel/power/power.h          | 2 --
 4 files changed, 2 insertions(+), 3 deletions(-)

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
 
diff --git a/arch/s390/kernel/entry.h b/arch/s390/kernel/entry.h
index 20420c2b8a14..b2956d49b6ad 100644
--- a/arch/s390/kernel/entry.h
+++ b/arch/s390/kernel/entry.h
@@ -63,7 +63,6 @@ void __init startup_init(void);
 void die(struct pt_regs *regs, const char *str);
 int setup_profiling_timer(unsigned int multiplier);
 void __init time_init(void);
-int pfn_is_nosave(unsigned long);
 void s390_early_resume(void);
 unsigned long prepare_ftrace_return(unsigned long parent, unsigned long sp, unsigned long ip);
 
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 6b3ea9ea6a9e..e8b8a7bede90 100644
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
diff --git a/kernel/power/power.h b/kernel/power/power.h
index 9e58bdc8a562..44bee462ff57 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -75,8 +75,6 @@ static inline void hibernate_reserved_size_init(void) {}
 static inline void hibernate_image_size_init(void) {}
 #endif /* !CONFIG_HIBERNATION */
 
-extern int pfn_is_nosave(unsigned long);
-
 #define power_attr(_name) \
 static struct kobj_attribute _name##_attr = {	\
 	.attr	= {				\
-- 
2.20.1

