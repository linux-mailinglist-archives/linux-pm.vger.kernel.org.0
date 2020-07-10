Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1DF521B67F
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 15:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgGJNeB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 09:34:01 -0400
Received: from cmta16.telus.net ([209.171.16.89]:38369 "EHLO cmta16.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbgGJNeB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 10 Jul 2020 09:34:01 -0400
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id ttA5jRQFl5b7lttA6jbKJf; Fri, 10 Jul 2020 07:33:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1594388039; bh=3k6WC3lq7Nya483IlFpmai+sfNvwOM16loKCBwrE1o4=;
        h=From:To:Cc:Subject:Date;
        b=IWS3Bbn1o+O+J6IKVqQVP/NFcuVZUNIBDM7lSg0KwxbX6xBqF2m1RbK/QUfeZgRwL
         KXxt7WkctF8k4NgdLfdo591OxW1Yp+VwZ1HS0bEghkW3Hu+aoCag3RBIrE+DO+WxG9
         9mAq32v2HiNptjlpqP2K4eqJ8gQEEEI1n89rd6UEmSZ/vZ2AOwWkLAkbtT3F79PjdH
         uJ5iL8bQ0nWEqGGngenqdnUvIW0I3ww7NQdlgysh+/jynnsITqOGQk9040ibhqnt9V
         B1YCq+eBdEk2RVHPHB+oHY5upQCVbkb/Kyd45pKnFgrFnnJXzn8fUdGgIXnwz9KOJd
         9qw9GNRvGwv1w==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=YPHhNiOx c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=kj9zAlcOel0A:10 a=ndZCF_r969jSBklO3fMA:9
 a=CjuIK1q_8ugA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc:     "'Linux PM'" <linux-pm@vger.kernel.org>
Subject: cpufreq: intel_pstate: EPB with performance governor
Date:   Fri, 10 Jul 2020 06:33:57 -0700
Message-ID: <000701d656be$c48083e0$4d818ba0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdZWvsLAIXyppszvS8W5WAMzng3ZNw==
X-CMAE-Envelope: MS4wfIs4Av5iRFn/nPv4oBElZedK/j7yg04WZgZ3VuX0nexacLdeyRm66j00v7bNLt9Se3zfkMpNAs4e+GZO+UWmjJ3UopNS3WiuV12sXw6daGVfJ03uKJ/L
 g+nFP5zzALls5iDO9S21nkcv4yhVyEgrmC/5SFSQE91u+zp0J8eLz+wsNpxJgWSXvX3/tozOw0+d8S4oq6zNYXn41d9yoQqSuyEOyk9RQU+gR9f2EHNPs8v+
 Tad8Y0kQF5pTly1lWW8Q7g==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Srinivas and/or Rafael,

Can you please confirm or deny that an older
commit:

commit 8442885fca09b2d26375b9fe507759879a6f661e
cpufreq: intel_pstate: Set EPP/EPB to 0 in performance mode

has been superseded by:

arch/x86/kernel/cpu/intel_epb.c

and that now there is no way to have some default EPB (say 6) for
governors other than performance, while still getting an EPB of 0
for the performance governor.

... Doug

Additional notes:
Both my test computers have EPB as 0 upon startup,
But I also tried this:

diff --git a/arch/x86/kernel/cpu/intel_epb.c b/arch/x86/kernel/cpu/intel_epb.c
index f4dd73396f28..b536e381cd56 100644
--- a/arch/x86/kernel/cpu/intel_epb.c
+++ b/arch/x86/kernel/cpu/intel_epb.c
@@ -74,7 +74,8 @@ static int intel_epb_save(void)

 static void intel_epb_restore(void)
 {
-       u64 val = this_cpu_read(saved_epb);
+//     u64 val = this_cpu_read(saved_epb);
+       u64 val = 6;
        u64 epb;

        rdmsrl(MSR_IA32_ENERGY_PERF_BIAS, epb);

which did get rid of this message:
kernel: [    0.102158] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'


