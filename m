Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F2F20AFFC
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jun 2020 12:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgFZKpd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jun 2020 06:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbgFZKpd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jun 2020 06:45:33 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68097C08C5C1;
        Fri, 26 Jun 2020 03:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QevtFY5/fU0gz6JXyEA/JwvKh73ONa/vbnOzBREqNno=; b=voVg1Z74JA9zQSFyYsBqBErK3/
        eNPaVDvEtjc6B0kKMdbhupAg/k14KecsHOuiMIpQ90cNhZv3AGkFeu4jL58gsVCAON52P8FLlMtt4
        wgN7sahP4rf4N6CXInQPr9p58er2qRuNmAM4wFXbfr3wNrIdNfxg66VTPkV+pJVN9oPeQKoPEM/3y
        dXcjqG6caa380q5Qdmz0FIGuoyl9U0z2fpd3gvbdyOKBwYsj8Ma6VVHi0T9NODZbRZSnu8j6VHwKp
        mLRgZP5Jd6VqDDB7n2Qsg5dPL9UZuel+KB1YovP8Q4j5LOgThA3J6Wfy4AGNEYE6k10oxw4UG1wu4
        KM7Cmm2g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jolqf-0003ff-Oa; Fri, 26 Jun 2020 10:44:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5D39C301A32;
        Fri, 26 Jun 2020 12:44:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4AAE720BEAD9B; Fri, 26 Jun 2020 12:44:42 +0200 (CEST)
Date:   Fri, 26 Jun 2020 12:44:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        rjw@rjwysocki.net, viresh.kumar@linaro.org, lenb@kernel.org,
        dsmythies@telus.net, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org, jic23@cam.ac.uk,
        keescook@chromium.org, akpm@linux-foundation.org
Subject: [PATCH] lib: Extend kstrtobool() to accept "true"/"false"
Message-ID: <20200626104442.GF117543@hirez.programming.kicks-ass.net>
References: <20200625224931.1468150-1-srinivas.pandruvada@linux.intel.com>
 <20200626084903.GA27151@zn.tnic>
 <20200626102255.GZ4817@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626102255.GZ4817@hirez.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jun 26, 2020 at 12:22:55PM +0200, Peter Zijlstra wrote:

> > This is too lax - it will be enabled for any !0 value. Please accept
> > only 0 and 1.
> 
> kstrtobool() ftw

And looking at that, I find it really strange it does not in fact accept
"true" / "false", so how about this?

---
Subject: lib: Extend kstrtobool() to accept "true"/"false"

Extend the strings recognised by kstrtobool() to cover:

  - 1/0
  - y/n
  - yes/no	(new)
  - t/f		(new)
  - true/false  (new)
  - on/off

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 lib/kstrtox.c | 60 ++++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 15 deletions(-)

diff --git a/lib/kstrtox.c b/lib/kstrtox.c
index 1006bf70bf74..b8b950325097 100644
--- a/lib/kstrtox.c
+++ b/lib/kstrtox.c
@@ -325,9 +325,17 @@ EXPORT_SYMBOL(kstrtos8);
  * @s: input string
  * @res: result
  *
- * This routine returns 0 iff the first character is one of 'Yy1Nn0', or
- * [oO][NnFf] for "on" and "off". Otherwise it will return -EINVAL.  Value
- * pointed to by res is updated upon finding a match.
+ * This return return 0 on success, otherwise it will return -EINVAL.
+ * It will accept (case invariant):
+ *
+ *  - 1/0
+ *  - y/n
+ *  - yes/no
+ *  - t/f
+ *  - true/false
+ *  - on/off
+ *
+ * and set @*res to either true/false respectively.
  */
 int kstrtobool(const char *s, bool *res)
 {
@@ -335,30 +343,52 @@ int kstrtobool(const char *s, bool *res)
 		return -EINVAL;
 
 	switch (s[0]) {
+	case 't':
+	case 'T':
+		if (!s[1] || !strcasecmp(s, "true"))
+			goto have_true;
+
+		break;
+
 	case 'y':
 	case 'Y':
+		if (!s[1] || !strcasecmp(s, "yes"))
+			goto have_true;
+
+		break;
+
 	case '1':
+have_true:
 		*res = true;
 		return 0;
+
+	case 'f':
+	case 'F':
+		if (!s[1] || !strcasecmp(s, "false"))
+			goto have_false;
+
+		break;
 	case 'n':
 	case 'N':
+		if (!s[1] || !strcasecmp(s, "no"))
+			goto have_false;
+
+		break;
 	case '0':
+have_false:
 		*res = false;
 		return 0;
+
 	case 'o':
 	case 'O':
-		switch (s[1]) {
-		case 'n':
-		case 'N':
-			*res = true;
-			return 0;
-		case 'f':
-		case 'F':
-			*res = false;
-			return 0;
-		default:
-			break;
-		}
+		if (!strcasecmp(s, "on"))
+			goto have_true;
+
+		if (!strcasecmp(s, "off"))
+			goto have_false;
+
+		break;
+
 	default:
 		break;
 	}
