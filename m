Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8987437828E
	for <lists+linux-pm@lfdr.de>; Mon, 10 May 2021 12:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbhEJKgI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 May 2021 06:36:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:41606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231338AbhEJKcc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 10 May 2021 06:32:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2596B6192F;
        Mon, 10 May 2021 10:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620642444;
        bh=cLg46e9/YeifDGAuTIUxyVNGgRec++ObTANYcNmIf8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S/5qN/rNEKpOPrWZtzAMnSnoOE1/5nLCxJdQqQkO6kDOLzegk1nZFbRKJd8sTni1W
         xTq7QGHY5d6ZYz+Xievfcjk5iZlfoarvSddw2mCVy+D9/mRZQVb7nCcoSNsMinSsf3
         m5j105wxHMCOOWZN2LQ/M1EQpatZNx9r7ENVU5iixD38GL76eOf872FigByhjVUVYq
         Y3TN3OdN1INBTh/iaXM2N1O2s1RQde4f57z86TA4UVrP/vBoH86PNsfAhsZyt8uULn
         LG56P/lXLoNfG8hf4pW++bzekO8vRUdmK5YxUhYGzUcEuKzbKL/mnkLk+mQu8ePQ5x
         ks9Bque1rJQlQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lg38E-000UQu-8r; Mon, 10 May 2021 12:27:22 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 40/53] docs: power: powercap: powercap.rst: avoid using UTF-8 chars
Date:   Mon, 10 May 2021 12:26:52 +0200
Message-Id: <3eac877511acf0d8f33af2177e831ebde1927be8.1620641727.git.mchehab+huawei@kernel.org>
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

	- U+00a0 (' '): NO-BREAK SPACE

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/power/powercap/powercap.rst | 210 +++++++++++-----------
 1 file changed, 105 insertions(+), 105 deletions(-)

diff --git a/Documentation/power/powercap/powercap.rst b/Documentation/power/powercap/powercap.rst
index e75d12596dac..c99122e0a1c8 100644
--- a/Documentation/power/powercap/powercap.rst
+++ b/Documentation/power/powercap/powercap.rst
@@ -34,113 +34,113 @@ Example sysfs interface tree::
   /sys/devices/virtual/powercap
   └──intel-rapl
       ├──intel-rapl:0
-      │   ├──constraint_0_name
-      │   ├──constraint_0_power_limit_uw
-      │   ├──constraint_0_time_window_us
-      │   ├──constraint_1_name
-      │   ├──constraint_1_power_limit_uw
-      │   ├──constraint_1_time_window_us
-      │   ├──device -> ../../intel-rapl
-      │   ├──energy_uj
-      │   ├──intel-rapl:0:0
-      │   │   ├──constraint_0_name
-      │   │   ├──constraint_0_power_limit_uw
-      │   │   ├──constraint_0_time_window_us
-      │   │   ├──constraint_1_name
-      │   │   ├──constraint_1_power_limit_uw
-      │   │   ├──constraint_1_time_window_us
-      │   │   ├──device -> ../../intel-rapl:0
-      │   │   ├──energy_uj
-      │   │   ├──max_energy_range_uj
-      │   │   ├──name
-      │   │   ├──enabled
-      │   │   ├──power
-      │   │   │   ├──async
-      │   │   │   []
-      │   │   ├──subsystem -> ../../../../../../class/power_cap
-      │   │   └──uevent
-      │   ├──intel-rapl:0:1
-      │   │   ├──constraint_0_name
-      │   │   ├──constraint_0_power_limit_uw
-      │   │   ├──constraint_0_time_window_us
-      │   │   ├──constraint_1_name
-      │   │   ├──constraint_1_power_limit_uw
-      │   │   ├──constraint_1_time_window_us
-      │   │   ├──device -> ../../intel-rapl:0
-      │   │   ├──energy_uj
-      │   │   ├──max_energy_range_uj
-      │   │   ├──name
-      │   │   ├──enabled
-      │   │   ├──power
-      │   │   │   ├──async
-      │   │   │   []
-      │   │   ├──subsystem -> ../../../../../../class/power_cap
-      │   │   └──uevent
-      │   ├──max_energy_range_uj
-      │   ├──max_power_range_uw
-      │   ├──name
-      │   ├──enabled
-      │   ├──power
-      │   │   ├──async
-      │   │   []
-      │   ├──subsystem -> ../../../../../class/power_cap
-      │   ├──enabled
-      │   ├──uevent
+      │   ├──constraint_0_name
+      │   ├──constraint_0_power_limit_uw
+      │   ├──constraint_0_time_window_us
+      │   ├──constraint_1_name
+      │   ├──constraint_1_power_limit_uw
+      │   ├──constraint_1_time_window_us
+      │   ├──device -> ../../intel-rapl
+      │   ├──energy_uj
+      │   ├──intel-rapl:0:0
+      │   │   ├──constraint_0_name
+      │   │   ├──constraint_0_power_limit_uw
+      │   │   ├──constraint_0_time_window_us
+      │   │   ├──constraint_1_name
+      │   │   ├──constraint_1_power_limit_uw
+      │   │   ├──constraint_1_time_window_us
+      │   │   ├──device -> ../../intel-rapl:0
+      │   │   ├──energy_uj
+      │   │   ├──max_energy_range_uj
+      │   │   ├──name
+      │   │   ├──enabled
+      │   │   ├──power
+      │   │   │   ├──async
+      │   │   │   []
+      │   │   ├──subsystem -> ../../../../../../class/power_cap
+      │   │   └──uevent
+      │   ├──intel-rapl:0:1
+      │   │   ├──constraint_0_name
+      │   │   ├──constraint_0_power_limit_uw
+      │   │   ├──constraint_0_time_window_us
+      │   │   ├──constraint_1_name
+      │   │   ├──constraint_1_power_limit_uw
+      │   │   ├──constraint_1_time_window_us
+      │   │   ├──device -> ../../intel-rapl:0
+      │   │   ├──energy_uj
+      │   │   ├──max_energy_range_uj
+      │   │   ├──name
+      │   │   ├──enabled
+      │   │   ├──power
+      │   │   │   ├──async
+      │   │   │   []
+      │   │   ├──subsystem -> ../../../../../../class/power_cap
+      │   │   └──uevent
+      │   ├──max_energy_range_uj
+      │   ├──max_power_range_uw
+      │   ├──name
+      │   ├──enabled
+      │   ├──power
+      │   │   ├──async
+      │   │   []
+      │   ├──subsystem -> ../../../../../class/power_cap
+      │   ├──enabled
+      │   ├──uevent
       ├──intel-rapl:1
-      │   ├──constraint_0_name
-      │   ├──constraint_0_power_limit_uw
-      │   ├──constraint_0_time_window_us
-      │   ├──constraint_1_name
-      │   ├──constraint_1_power_limit_uw
-      │   ├──constraint_1_time_window_us
-      │   ├──device -> ../../intel-rapl
-      │   ├──energy_uj
-      │   ├──intel-rapl:1:0
-      │   │   ├──constraint_0_name
-      │   │   ├──constraint_0_power_limit_uw
-      │   │   ├──constraint_0_time_window_us
-      │   │   ├──constraint_1_name
-      │   │   ├──constraint_1_power_limit_uw
-      │   │   ├──constraint_1_time_window_us
-      │   │   ├──device -> ../../intel-rapl:1
-      │   │   ├──energy_uj
-      │   │   ├──max_energy_range_uj
-      │   │   ├──name
-      │   │   ├──enabled
-      │   │   ├──power
-      │   │   │   ├──async
-      │   │   │   []
-      │   │   ├──subsystem -> ../../../../../../class/power_cap
-      │   │   └──uevent
-      │   ├──intel-rapl:1:1
-      │   │   ├──constraint_0_name
-      │   │   ├──constraint_0_power_limit_uw
-      │   │   ├──constraint_0_time_window_us
-      │   │   ├──constraint_1_name
-      │   │   ├──constraint_1_power_limit_uw
-      │   │   ├──constraint_1_time_window_us
-      │   │   ├──device -> ../../intel-rapl:1
-      │   │   ├──energy_uj
-      │   │   ├──max_energy_range_uj
-      │   │   ├──name
-      │   │   ├──enabled
-      │   │   ├──power
-      │   │   │   ├──async
-      │   │   │   []
-      │   │   ├──subsystem -> ../../../../../../class/power_cap
-      │   │   └──uevent
-      │   ├──max_energy_range_uj
-      │   ├──max_power_range_uw
-      │   ├──name
-      │   ├──enabled
-      │   ├──power
-      │   │   ├──async
-      │   │   []
-      │   ├──subsystem -> ../../../../../class/power_cap
-      │   ├──uevent
+      │   ├──constraint_0_name
+      │   ├──constraint_0_power_limit_uw
+      │   ├──constraint_0_time_window_us
+      │   ├──constraint_1_name
+      │   ├──constraint_1_power_limit_uw
+      │   ├──constraint_1_time_window_us
+      │   ├──device -> ../../intel-rapl
+      │   ├──energy_uj
+      │   ├──intel-rapl:1:0
+      │   │   ├──constraint_0_name
+      │   │   ├──constraint_0_power_limit_uw
+      │   │   ├──constraint_0_time_window_us
+      │   │   ├──constraint_1_name
+      │   │   ├──constraint_1_power_limit_uw
+      │   │   ├──constraint_1_time_window_us
+      │   │   ├──device -> ../../intel-rapl:1
+      │   │   ├──energy_uj
+      │   │   ├──max_energy_range_uj
+      │   │   ├──name
+      │   │   ├──enabled
+      │   │   ├──power
+      │   │   │   ├──async
+      │   │   │   []
+      │   │   ├──subsystem -> ../../../../../../class/power_cap
+      │   │   └──uevent
+      │   ├──intel-rapl:1:1
+      │   │   ├──constraint_0_name
+      │   │   ├──constraint_0_power_limit_uw
+      │   │   ├──constraint_0_time_window_us
+      │   │   ├──constraint_1_name
+      │   │   ├──constraint_1_power_limit_uw
+      │   │   ├──constraint_1_time_window_us
+      │   │   ├──device -> ../../intel-rapl:1
+      │   │   ├──energy_uj
+      │   │   ├──max_energy_range_uj
+      │   │   ├──name
+      │   │   ├──enabled
+      │   │   ├──power
+      │   │   │   ├──async
+      │   │   │   []
+      │   │   ├──subsystem -> ../../../../../../class/power_cap
+      │   │   └──uevent
+      │   ├──max_energy_range_uj
+      │   ├──max_power_range_uw
+      │   ├──name
+      │   ├──enabled
+      │   ├──power
+      │   │   ├──async
+      │   │   []
+      │   ├──subsystem -> ../../../../../class/power_cap
+      │   ├──uevent
       ├──power
-      │   ├──async
-      │   []
+      │   ├──async
+      │   []
       ├──subsystem -> ../../../../class/power_cap
       ├──enabled
       └──uevent
-- 
2.30.2

