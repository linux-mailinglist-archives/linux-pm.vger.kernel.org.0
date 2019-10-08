Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26456CF762
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2019 12:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbfJHKqv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Oct 2019 06:46:51 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:50232 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730008AbfJHKqv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Oct 2019 06:46:51 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iHn0y-0005tQ-Lm; Tue, 08 Oct 2019 11:46:48 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iHn0x-00032n-V1; Tue, 08 Oct 2019 11:46:47 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     linux-kernel@lists.codethink.co.uk, linux-pm@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] PM: sleep: include <linux/pm_runtime.h> for pm_wq
Date:   Tue,  8 Oct 2019 11:46:46 +0100
Message-Id: <20191008104646.11658-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Include the <linux/runtime_pm.h> for the definition of
pm_wq to avoid the following warning:

kernel/power/main.c:890:25: warning: symbol 'pm_wq' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 kernel/power/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index e8710d179b35..e26de7af520b 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -15,6 +15,7 @@
 #include <linux/seq_file.h>
 #include <linux/suspend.h>
 #include <linux/syscalls.h>
+#include <linux/pm_runtime.h>
 
 #include "power.h"
 
-- 
2.23.0

