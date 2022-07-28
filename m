Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520F558434A
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jul 2022 17:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbiG1Plq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jul 2022 11:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiG1Plp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2022 11:41:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA8C68DD8
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2022 08:41:44 -0700 (PDT)
Date:   Thu, 28 Jul 2022 15:41:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659022903;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M8v3l4tAhPIy96li4I6zQH6NtW/O+ne/NHp6zkMpdKs=;
        b=SbR7E1T/YVr0fROPkr9laAKOX13XJoenhIFDpUcDwkmD+LDow5HMHUFiXqWw3Z2aMXXGes
        jduh/4oQiPtkaqhDIITlc8zjMAvxoOPZxBzFeiDGKkcAe8yfPtOunJzDsp+1lqwl+EsUVs
        7OBplDSIjz5jNinfz9JBxHtPCsX9jI3m/PK3aZf4OtOtEn057J0+G28OhXc+aeVc1YIh07
        556XKgMo1tXv3yGulnA4fnGhAejSP11m82jJwpTpv2F39yNYvg6je3eE6AFgHFGnc9SEVx
        NI48K10pXFQrox/72M9Xvsg6cg/ttA4nNzgrr53nWAXqKm2hXUmTqqGgPb6NDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659022903;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M8v3l4tAhPIy96li4I6zQH6NtW/O+ne/NHp6zkMpdKs=;
        b=epozQc04Fy+6APoUiSKX8xABh9/GF96DFW4qJotJhi4IOkGLvrIAGeCq+oF+PZIZVfYW7Q
        q87rBiHRnGFP/NDA==
From:   "thermal-bot for Markus Mayer" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/tools/tmon: Include pthread and time
 headers in tmon.h
Cc:     Markus Mayer <mmayer@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        alejandro.gonzalez.correo@gmail.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220718031040.44714-1-f.fainelli@gmail.com>
References: <20220718031040.44714-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Message-ID: <165902290212.15455.15524124968973893519.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     0cf51bfe999524377fbb71becb583b4ca6d07cfc
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//0cf51bfe999524377fbb71becb583b4ca6d07cfc
Author:        Markus Mayer <mmayer@broadcom.com>
AuthorDate:    Sun, 17 Jul 2022 20:10:39 -07:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 28 Jul 2022 17:29:51 +02:00

thermal/tools/tmon: Include pthread and time headers in tmon.h

Include sys/time.h and pthread.h in tmon.h, so that types
"pthread_mutex_t" and "struct timeval tv" are known when tmon.h
references them.

Without these headers, compiling tmon against musl-libc will fail with
these errors:

In file included from sysfs.c:31:0:
tmon.h:47:8: error: unknown type name 'pthread_mutex_t'
 extern pthread_mutex_t input_lock;
        ^~~~~~~~~~~~~~~
make[3]: *** [<builtin>: sysfs.o] Error 1
make[3]: *** Waiting for unfinished jobs....
In file included from tui.c:31:0:
tmon.h:54:17: error: field 'tv' has incomplete type
  struct timeval tv;
                 ^~
make[3]: *** [<builtin>: tui.o] Error 1
make[2]: *** [Makefile:83: tmon] Error 2

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Acked-by: Alejandro Gonz=C3=A1lez <alejandro.gonzalez.correo@gmail.com>
Tested-by: Alejandro Gonz=C3=A1lez <alejandro.gonzalez.correo@gmail.com>
Fixes: 94f69966faf8 ("tools/thermal: Introduce tmon, a tool for thermal  subs=
ystem")
Link: https://lore.kernel.org/r/20220718031040.44714-1-f.fainelli@gmail.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 tools/thermal/tmon/tmon.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/thermal/tmon/tmon.h b/tools/thermal/tmon/tmon.h
index c9066ec..44d16d7 100644
--- a/tools/thermal/tmon/tmon.h
+++ b/tools/thermal/tmon/tmon.h
@@ -27,6 +27,9 @@
 #define NR_LINES_TZDATA 1
 #define TMON_LOG_FILE "/var/tmp/tmon.log"
=20
+#include <sys/time.h>
+#include <pthread.h>
+
 extern unsigned long ticktime;
 extern double time_elapsed;
 extern unsigned long target_temp_user;
