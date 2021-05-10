Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2769378203
	for <lists+linux-pm@lfdr.de>; Mon, 10 May 2021 12:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbhEJKbm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 May 2021 06:31:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:60168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231807AbhEJKaF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 10 May 2021 06:30:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB51C6186A;
        Mon, 10 May 2021 10:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620642443;
        bh=m8Om0d0gr6VAcd5Jczu3eLDDIMDn68u18OnEK7cqiXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BGAaeysxa3iFzSZ1FfjZ5/y2eL3suXE253gMCE7F7vm8zA9OeZDiYnUB+LQW/5hRH
         FnndwxxTEmQ2DJ3uv7HyZXdGu5z5eIuzuN85zhz93xn3PvYoTrI1MbO/ie7vK1kSR4
         r9sZK7ntrIYeFN8ZNWHi2TbYdY9KQBFWBqSqXJsOoWApq/8HJ5UdmmjcOacrW9euWe
         TuQrCnXzSf3JG0Wk08bKAi7oUlaz1DFeeiRzQUkIKOnMQYChOf4ytHJLKFxv/rqMKc
         Cw9HOT9RG5dG6aqVcNFdt3JvTxwc092kb5bghisnH/RJtvOjZ9k8FcUUVuYyvLrlrP
         OMGHhZJn5zWPQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lg38C-000UOy-QM; Mon, 10 May 2021 12:27:20 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 10/53] docs: admin-guide: pm: avoid using UTF-8 chars
Date:   Mon, 10 May 2021 12:26:22 +0200
Message-Id: <79d5dca9b4bd0cc3b128ece6ffa16c07b7178626.1620641727.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620641727.git.mchehab+huawei@kernel.org>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

While UTF-8 characters can be used at the Linux documentation,
the best is to use them only when ASCII doesn't offer a good replacement.
So, replace the occurences of the following UTF-8 characters:

	- U+2019 ('’'): RIGHT SINGLE QUOTATION MARK

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/admin-guide/pm/intel_idle.rst   | 4 ++--
 Documentation/admin-guide/pm/intel_pstate.rst | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/pm/intel_idle.rst b/Documentation/admin-guide/pm/intel_idle.rst
index 89309e1b0e48..c3c4f5d4c806 100644
--- a/Documentation/admin-guide/pm/intel_idle.rst
+++ b/Documentation/admin-guide/pm/intel_idle.rst
@@ -28,7 +28,7 @@ logical CPU executing it is idle and so it may be possible to put some of the
 processor's functional blocks into low-power states.  That instruction takes two
 arguments (passed in the ``EAX`` and ``ECX`` registers of the target CPU), the
 first of which, referred to as a *hint*, can be used by the processor to
-determine what can be done (for details refer to Intel Software Developer’s
+determine what can be done (for details refer to Intel Software Developer's
 Manual [1]_).  Accordingly, ``intel_idle`` refuses to work with processors in
 which the support for the ``MWAIT`` instruction has been disabled (for example,
 via the platform firmware configuration menu) or which do not support that
@@ -261,7 +261,7 @@ restrict the range of permissible idle states to the ones with core-level only
 References
 ==========
 
-.. [1] *Intel® 64 and IA-32 Architectures Software Developer’s Manual Volume 2B*,
+.. [1] *Intel® 64 and IA-32 Architectures Software Developer's Manual Volume 2B*,
        https://www.intel.com/content/www/us/en/architecture-and-technology/64-ia-32-architectures-software-developer-vol-2b-manual.html
 
 .. [2] *Advanced Configuration and Power Interface (ACPI) Specification*,
diff --git a/Documentation/admin-guide/pm/intel_pstate.rst b/Documentation/admin-guide/pm/intel_pstate.rst
index df29b4f1f219..d881a32acb6d 100644
--- a/Documentation/admin-guide/pm/intel_pstate.rst
+++ b/Documentation/admin-guide/pm/intel_pstate.rst
@@ -26,7 +26,7 @@ than just an operating frequency or an operating performance point (see the
 LinuxCon Europe 2015 presentation by Kristen Accardi [1]_ for more
 information about that).  For this reason, the representation of P-states used
 by ``intel_pstate`` internally follows the hardware specification (for details
-refer to Intel Software Developer’s Manual [2]_).  However, the ``CPUFreq`` core
+refer to Intel Software Developer's Manual [2]_).  However, the ``CPUFreq`` core
 uses frequencies for identifying operating performance points of CPUs and
 frequencies are involved in the user space interface exposed by it, so
 ``intel_pstate`` maps its internal representation of P-states to frequencies too
@@ -756,7 +756,7 @@ References
 .. [1] Kristen Accardi, *Balancing Power and Performance in the Linux Kernel*,
        https://events.static.linuxfound.org/sites/events/files/slides/LinuxConEurope_2015.pdf
 
-.. [2] *Intel® 64 and IA-32 Architectures Software Developer’s Manual Volume 3: System Programming Guide*,
+.. [2] *Intel® 64 and IA-32 Architectures Software Developer's Manual Volume 3: System Programming Guide*,
        https://www.intel.com/content/www/us/en/architecture-and-technology/64-ia-32-architectures-software-developer-system-programming-manual-325384.html
 
 .. [3] *Advanced Configuration and Power Interface Specification*,
-- 
2.30.2

