Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE446A865
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jul 2019 14:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733104AbfGPMLD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 08:11:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39156 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733037AbfGPMLC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 08:11:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=79eC0tu5XeYLyVMNzpLTHyI1bupm/FqacAsZ9g1T3Zk=; b=Jc2BykXbBfJUb/SwoPH3QP+esJ
        dBVKnxZRJw83ucI0vrFtU272RuuSuE1jsYg4N/zssx8uSBwOB0jTnHjdaaumMaTEDW+KY7NtBGucd
        I0lpga4maMnxKv45F8zzVKRmmG0G2jEGk/zFgJ3flAb2tbNPG7zwP+iYtGW6yRXOOcmaO2FFHDXFV
        /WdZ0vLHbHM5XljEcMKgKZVVK2xWz+lu5Qoj55gSJnXR7A/DHscT6Y9wFFuWWxF/bYsOicblcrLwO
        aBijFuls8C3mg/d2joF+jsShVZxabWDSHdN109JFVxrJlkxAA9oGIMfvuYv4oouxmX+JdnSmhEwoH
        dGDbG9Hg==;
Received: from [189.27.46.152] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hnMIL-0004hy-AM; Tue, 16 Jul 2019 12:10:57 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hnMII-0000Qe-ML; Tue, 16 Jul 2019 09:10:54 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-doc@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 02/14] docs: power: add it to to the main documentation index
Date:   Tue, 16 Jul 2019 09:10:41 -0300
Message-Id: <95abe2e389f5bfb9dd03d55de384c2b9b5bb78da.1563277838.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1563277838.git.mchehab+samsung@kernel.org>
References: <cover.1563277838.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The power docs are orphaned at the documentation body.

While it could likely be moved to be inside some guide, I'm opting to just
adding it to the main index.rst, removing the :orphan: and adding the SPDX
header.

The reason is similar to what it was done for other driver-specific
subsystems: the docs there contain a mix of Kernelspace, uAPI and
admin-guide. So, better to keep them on its own directory,
while the docs there are not properly classified.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/index.rst       | 1 +
 Documentation/power/index.rst | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/index.rst b/Documentation/index.rst
index 3fe6170aa41d..68ae2a4d689d 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -111,6 +111,7 @@ needed).
    netlabel/index
    networking/index
    pcmcia/index
+   power/index
    target/index
    timers/index
    watchdog/index
diff --git a/Documentation/power/index.rst b/Documentation/power/index.rst
index 20415f21e48a..002e42745263 100644
--- a/Documentation/power/index.rst
+++ b/Documentation/power/index.rst
@@ -1,4 +1,4 @@
-:orphan:
+.. SPDX-License-Identifier: GPL-2.0
 
 ================
 Power Management
-- 
2.21.0

