Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6065137BBE2
	for <lists+linux-pm@lfdr.de>; Wed, 12 May 2021 13:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhELLgZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 May 2021 07:36:25 -0400
Received: from h4.fbrelay.privateemail.com ([131.153.2.45]:47819 "EHLO
        h4.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230037AbhELLgZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 May 2021 07:36:25 -0400
X-Greylist: delayed 449 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 May 2021 07:36:25 EDT
Received: from MTA-07-4.privateemail.com (mta-07.privateemail.com [198.54.127.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h3.fbrelay.privateemail.com (Postfix) with ESMTPS id 8375A8081E;
        Wed, 12 May 2021 07:27:56 -0400 (EDT)
Received: from MTA-07.privateemail.com (localhost [127.0.0.1])
        by MTA-07.privateemail.com (Postfix) with ESMTP id 7BD4760058;
        Wed, 12 May 2021 07:27:55 -0400 (EDT)
Received: from hal-station.. (unknown [10.20.151.208])
        by MTA-07.privateemail.com (Postfix) with ESMTPA id D9FD46004D;
        Wed, 12 May 2021 07:27:54 -0400 (EDT)
From:   Hamza Mahfooz <someguy@effective-light.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
        linux-pm@vger.kernel.org,
        Hamza Mahfooz <someguy@effective-light.com>
Subject: [PATCH 2/2] cpupower: removed a completed task from the list
Date:   Wed, 12 May 2021 07:26:58 -0400
Message-Id: <20210512112658.89965-2-someguy@effective-light.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512112658.89965-1-someguy@effective-light.com>
References: <20210512112658.89965-1-someguy@effective-light.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since this task has been completed, cpupower/ToDo should be updated so
that others know not to attempt this task as well.

Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
---
 tools/power/cpupower/ToDo | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/tools/power/cpupower/ToDo b/tools/power/cpupower/ToDo
index b196a139a3e4..39c870ea83e6 100644
--- a/tools/power/cpupower/ToDo
+++ b/tools/power/cpupower/ToDo
@@ -12,13 +12,3 @@ ToDos sorted by priority:
   -> This is to move the per_cpu logic from inside the
      monitor to outside it. This can be given higher
      priority in fork_it.
-- Fork as many processes as there are CPUs in case the
-  per_cpu_schedule flag is set.
-  -> Bind forked process to each cpu.
-  -> Execute start measures via the forked processes on
-     each cpu.
-  -> Run test executable in a forked process.
-  -> Execute stop measures via the forked processes on
-     each cpu.
-  This would be ideal as it will not introduce noise in the
-  tested executable.
-- 
2.31.1

