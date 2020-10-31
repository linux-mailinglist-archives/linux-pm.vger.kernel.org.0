Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492092A1522
	for <lists+linux-pm@lfdr.de>; Sat, 31 Oct 2020 11:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgJaKXK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 31 Oct 2020 06:23:10 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:19180 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726699AbgJaKXJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 31 Oct 2020 06:23:09 -0400
X-IronPort-AV: E=Sophos;i="5.77,437,1596492000"; 
   d="scan'208";a="475156637"
Received: from palace.lip6.fr ([132.227.105.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES256-SHA256; 31 Oct 2020 11:22:58 +0100
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: PM: correct typo
Date:   Sat, 31 Oct 2020 10:39:28 +0100
Message-Id: <1604137168-29502-1-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

cerainly -> certainly

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 Documentation/admin-guide/pm/cpuidle.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/pm/cpuidle.rst b/Documentation/admin-guide/pm/cpuidle.rst
index 37940a0584ec..a26a94bc0071 100644
--- a/Documentation/admin-guide/pm/cpuidle.rst
+++ b/Documentation/admin-guide/pm/cpuidle.rst
@@ -494,7 +494,7 @@ object corresponding to it, as follows:
 	residency.
 
 ``below``
-	Total number of times this idle state had been asked for, but cerainly
+	Total number of times this idle state had been asked for, but certainly
 	a deeper idle state would have been a better match for the observed idle
 	duration.
 

