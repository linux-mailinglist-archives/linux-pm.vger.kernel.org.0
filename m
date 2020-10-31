Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31BC72A1524
	for <lists+linux-pm@lfdr.de>; Sat, 31 Oct 2020 11:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgJaKXQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 31 Oct 2020 06:23:16 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:19180 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726708AbgJaKXQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 31 Oct 2020 06:23:16 -0400
X-IronPort-AV: E=Sophos;i="5.77,437,1596492000"; 
   d="scan'208";a="475156652"
Received: from palace.lip6.fr ([132.227.105.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES256-SHA256; 31 Oct 2020 11:23:08 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: PM: correct path name
Date:   Sat, 31 Oct 2020 10:39:39 +0100
Message-Id: <1604137179-29537-1-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

cpu/ is needed before cpu<N>/

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 Documentation/admin-guide/pm/cpuidle.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/pm/cpuidle.rst b/Documentation/admin-guide/pm/cpuidle.rst
index 37940a0584ec..26a9d648b88c 100644
--- a/Documentation/admin-guide/pm/cpuidle.rst
+++ b/Documentation/admin-guide/pm/cpuidle.rst
@@ -478,7 +478,7 @@ order to ask the hardware to enter that state.  Also, for each
 statistics of the given idle state.  That information is exposed by the kernel
 via ``sysfs``.
 
-For each CPU in the system, there is a :file:`/sys/devices/system/cpu<N>/cpuidle/`
+For each CPU in the system, there is a :file:`/sys/devices/system/cpu/cpu<N>/cpuidle/`
 directory in ``sysfs``, where the number ``<N>`` is assigned to the given
 CPU at the initialization time.  That directory contains a set of subdirectories
 called :file:`state0`, :file:`state1` and so on, up to the number of idle state

