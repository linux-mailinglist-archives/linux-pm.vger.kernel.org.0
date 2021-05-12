Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3535837BD4B
	for <lists+linux-pm@lfdr.de>; Wed, 12 May 2021 14:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbhELMxq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 May 2021 08:53:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:52776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231676AbhELMxD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 May 2021 08:53:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E3C461937;
        Wed, 12 May 2021 12:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620823903;
        bh=OVSqy/JSKyWtBY0OErxo4l2GIuXyNKw7839n8D1BuyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SQTmXH4aLBXFpWGx46uYHjS01fSUGZJomKzH6pcv+Rkv47JgYZg+V1RG/pN5sG+cj
         RJkxxcLnAa0jVvVlBZwKEDV2Qb/tBqB4lcEYgqGWbnkBYfMx1TZHBFOJZU35o2wemv
         zbtTSFf2+VRa32d/ri6xuNvs22Y9PiTfXwaf9mmYxiPDdHAqz61TzbHJR/tOLl475P
         awyx55/ZOlKtNuqtpxjRAqm2tYvTs9cjLJrmTry8MPzTGZZL/mrNMdZT/kVEvhCE0Q
         C9w9jhf6O4cP815hDSQy/Qe4hal18DwXPXwkVQrz9hJtq76Ag6qWNW8zTE/6Hxi+pt
         5+FCjf0vtZFEA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lgoKy-0018h7-8A; Wed, 12 May 2021 14:51:40 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v2 05/40] docs: admin-guide: pm: Use ASCII subset instead of UTF-8 alternate symbols
Date:   Wed, 12 May 2021 14:50:09 +0200
Message-Id: <f24d5bd469a42f4a97b9fa5de13575698789dcd6.1620823573.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620823573.git.mchehab+huawei@kernel.org>
References: <cover.1620823573.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The conversion tools used during DocBook/LaTeX/Markdown->ReST conversion
and some automatic rules which exists on certain text editors like
LibreOffice turned ASCII characters into some UTF-8 alternatives that
are better displayed on html and PDF.

While it is OK to use UTF-8 characters in Linux, it is better to
use the ASCII subset instead of using an UTF-8 equivalent character
as it makes life easier for tools like grep, and are easier to edit
with the some commonly used text/source code editors.

Also, Sphinx already do such conversion automatically outside literal blocks:
   https://docutils.sourceforge.io/docs/user/smartquotes.html

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

