Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00822A29F2
	for <lists+linux-pm@lfdr.de>; Mon,  2 Nov 2020 12:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbgKBLwr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Nov 2020 06:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbgKBLwr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Nov 2020 06:52:47 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0102C0617A6;
        Mon,  2 Nov 2020 03:52:46 -0800 (PST)
Received: from zn.tnic (p200300ec2f086a00ac0ac1fe147e3571.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:6a00:ac0a:c1fe:147e:3571])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 551751EC037C;
        Mon,  2 Nov 2020 12:52:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1604317965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nvkCeHJ7MHk9KMXE9OOj/Ye/DWciXmw2Tl/YkyXNILY=;
        b=NIdvJgXcd+FRtkoP4RVcFzs1jRJ84cLq/r/f5Ld3yTfq2TrcSPPnv9mweA3hF9WbqjJYxd
        wxpvI+WnIwzWDxgtLJyqBmAkQyHl/AZyrzMOB4BxG88WIaI6abEuBIow9kUfLVGdJ3RfG5
        XVtIFW2Xx3CLBE/RHApsBBV7MlpeR4w=
Date:   Mon, 2 Nov 2020 12:52:35 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     X86 ML <x86@kernel.org>, Thomas Renninger <trenn@suse.com>,
        Shuah Khan <shuah@kernel.org>, Len Brown <lenb@kernel.org>,
        linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] tools/power/cpupower: Read energy_perf_bias from
 sysfs
Message-ID: <20201102115235.GB15392@zn.tnic>
References: <20201015144603.27933-1-bp@alien8.de>
 <20201015144603.27933-2-bp@alien8.de>
 <7806e3c0-f435-18a0-c50d-eee3f1f7fccf@linuxfoundation.org>
 <20201016083754.GB8483@zn.tnic>
 <ca53e90a-f4eb-5007-a137-62729e3d74f0@linuxfoundation.org>
 <20201029215929.GF31903@zn.tnic>
 <e0d61fa5-03b9-1761-1578-f4fb5ce54d96@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e0d61fa5-03b9-1761-1578-f4fb5ce54d96@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 29, 2020 at 04:32:43PM -0600, Shuah Khan wrote:
> > Because a patch should do one thing and one thing only. So a separate
> > patch which converts them all in one go should come ontop. But if you
> > insist for the ones I'm adding to have error handling, I can do that, of
> > course.
> > 
> 
> A separate patch is fine.

Here's how it could look like, I've converted two users for now to get
your opinion first before I convert the rest.

Thx.

---
diff --git a/tools/power/cpupower/bench/Makefile b/tools/power/cpupower/bench/Makefile
index f68b4bc55273..d4ac380f7a56 100644
--- a/tools/power/cpupower/bench/Makefile
+++ b/tools/power/cpupower/bench/Makefile
@@ -9,13 +9,14 @@ endif
 ifeq ($(strip $(STATIC)),true)
 LIBS = -L../ -L$(OUTPUT) -lm
 OBJS = $(OUTPUT)main.o $(OUTPUT)parse.o $(OUTPUT)system.o $(OUTPUT)benchmark.o \
-       $(OUTPUT)../lib/cpufreq.o $(OUTPUT)../lib/cpupower.o
+       $(OUTPUT)../lib/cpufreq.o $(OUTPUT)../lib/cpupower.o $(OUTPUT)../utils/helpers/string.o
 else
 LIBS = -L../ -L$(OUTPUT) -lm -lcpupower
-OBJS = $(OUTPUT)main.o $(OUTPUT)parse.o $(OUTPUT)system.o $(OUTPUT)benchmark.o
+OBJS = $(OUTPUT)main.o $(OUTPUT)parse.o $(OUTPUT)system.o $(OUTPUT)benchmark.o \
+       $(OUTPUT)../utils/helpers/string.o
 endif
 
-CFLAGS += -D_GNU_SOURCE -I../lib -DDEFAULT_CONFIG_FILE=\"$(confdir)/cpufreq-bench.conf\"
+CFLAGS += -D_GNU_SOURCE -I../lib -I../utils -DDEFAULT_CONFIG_FILE=\"$(confdir)/cpufreq-bench.conf\"
 
 $(OUTPUT)%.o : %.c
 	$(ECHO) "  CC      " $@
diff --git a/tools/power/cpupower/bench/parse.c b/tools/power/cpupower/bench/parse.c
index e63dc11fa3a5..54ba48ad0983 100644
--- a/tools/power/cpupower/bench/parse.c
+++ b/tools/power/cpupower/bench/parse.c
@@ -18,6 +18,8 @@
 #include "parse.h"
 #include "config.h"
 
+#include "helpers/helpers.h"
+
 /**
  * converts priority string to priority
  *
@@ -84,11 +86,12 @@ FILE *prepare_output(const char *dirname)
 		}
 
 		filename = filename_tmp;
-		snprintf(filename, len - 1, "%s/benchmark_%s_%s_%li.log",
-			dirname, sysdata.nodename, sysdata.release, time(NULL));
+		if (!cpupower_snprintf(filename, len - 1, "%s/benchmark_%s_%s_%li.log",
+		    dirname, sysdata.nodename, sysdata.release, time(NULL)))
+			return NULL;
 	} else {
-		snprintf(filename, len - 1, "%s/benchmark_%li.log",
-			dirname, time(NULL));
+		if (!cpupower_snprintf(filename, len - 1, "%s/benchmark_%li.log", dirname, time(NULL)))
+			return NULL;
 	}
 
 	dprintf("logfilename: %s\n", filename);
diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
index 37dac161f3fe..dadd919ee599 100644
--- a/tools/power/cpupower/utils/helpers/helpers.h
+++ b/tools/power/cpupower/utils/helpers/helpers.h
@@ -171,4 +171,6 @@ static inline unsigned int cpuid_ecx(unsigned int op) { return 0; };
 static inline unsigned int cpuid_edx(unsigned int op) { return 0; };
 #endif /* defined(__i386__) || defined(__x86_64__) */
 
+extern char *cpupower_snprintf(char *str, int size, const char *fmt, ...);
+
 #endif /* __CPUPOWERUTILS_HELPERS__ */
diff --git a/tools/power/cpupower/utils/helpers/string.c b/tools/power/cpupower/utils/helpers/string.c
new file mode 100644
index 000000000000..bbd5e90bdc6e
--- /dev/null
+++ b/tools/power/cpupower/utils/helpers/string.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stdarg.h>
+
+#include "helpers/helpers.h"
+
+/*
+ * A helper with error handling for less code clutter.
+ */
+char *cpupower_snprintf(char *str, int size, const char *fmt, ...)
+{
+	int sz = 0;
+	va_list ap;
+
+	va_start(ap, fmt);
+	sz = vsnprintf(str, size, fmt, ap);
+	va_end(ap);
+
+	if (sz < 0) {
+		perror("vsnprintf");
+		return NULL;
+	}
+
+	if (sz >= size) {
+		fprintf(stderr, "Output truncated: [%s]\n", str);
+		return NULL;
+	}
+
+	return str;
+}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
