Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC74017B2CD
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2020 01:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgCFAX5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Mar 2020 19:23:57 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:60703 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgCFAX5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Mar 2020 19:23:57 -0500
Received: from 2.general.alexhung.us.vpn ([10.172.65.255] helo=canonical.com)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <alex.hung@canonical.com>)
        id 1jA0mP-0000j5-FO; Fri, 06 Mar 2020 00:23:53 +0000
From:   Alex Hung <alex.hung@canonical.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, corbet@lwn.net,
        linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
        alex.hung@canonical.com
Subject: [PATCH] Documentation: intel_pstate: update links for references
Date:   Thu,  5 Mar 2020 17:23:50 -0700
Message-Id: <20200306002350.9166-1-alex.hung@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

URLs for presentation and Intel Software Developer’s Manual are updated
as they were using "http" which are gradually replaced by "https".

Signed-off-by: Alex Hung <alex.hung@canonical.com>
---
 Documentation/admin-guide/pm/intel_pstate.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/pm/intel_pstate.rst b/Documentation/admin-guide/pm/intel_pstate.rst
index 67e414e34f37..ad392f3aee06 100644
--- a/Documentation/admin-guide/pm/intel_pstate.rst
+++ b/Documentation/admin-guide/pm/intel_pstate.rst
@@ -734,10 +734,10 @@ References
 ==========
 
 .. [1] Kristen Accardi, *Balancing Power and Performance in the Linux Kernel*,
-       http://events.linuxfoundation.org/sites/events/files/slides/LinuxConEurope_2015.pdf
+       https://events.static.linuxfound.org/sites/events/files/slides/LinuxConEurope_2015.pdf
 
 .. [2] *Intel® 64 and IA-32 Architectures Software Developer’s Manual Volume 3: System Programming Guide*,
-       http://www.intel.com/content/www/us/en/architecture-and-technology/64-ia-32-architectures-software-developer-system-programming-manual-325384.html
+       https://www.intel.com/content/www/us/en/architecture-and-technology/64-ia-32-architectures-software-developer-system-programming-manual-325384.html
 
 .. [3] *Advanced Configuration and Power Interface Specification*,
        https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf
-- 
2.17.1

