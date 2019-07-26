Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB1976678
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jul 2019 14:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfGZMwK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jul 2019 08:52:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39990 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfGZMvo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jul 2019 08:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9b5Epm2c2jNoQlY6d+GFbWG+r895kunbW+hUEth2imM=; b=iHWhH0xReM4Jjxoxep/sNm0iH/
        88sSYbpB5LPgFeNm/YZSJmXqroOYwGitYaaCKyJf0dK1nTfEkF37GqF2hkSOb8+9hALT4EbmWd13S
        6bJ1Fi5RRf6WLMPjviKEWvwQp37Uu0eIuJVpLra0yS3LMSi2oo7ZGnqr69mj9Q479ZxbQIrOUkMIq
        GopAfkKFutpJbyMQi+x+MZBHaYONRuiXa+HQkCaRARAHZojuVgSnecsZ/bFvteY0puu7RT3PltCpd
        q0/ibQVGeRtXqpGLYjyMO+MCSVdKX5hAbkxduBcR0z1SOLZ5M0zI7VXY830QjASaxRk6A7i30fdsw
        JqippHIA==;
Received: from [179.95.31.157] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hqzhE-0006AT-AA; Fri, 26 Jul 2019 12:51:40 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hqzhB-0005a8-Th; Fri, 26 Jul 2019 09:51:37 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-doc@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v2 01/26] docs: power: add it to to the main documentation index
Date:   Fri, 26 Jul 2019 09:51:11 -0300
Message-Id: <5417112ea7a391e6622c46bf833b7d6a5725c158.1564145354.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1564145354.git.mchehab+samsung@kernel.org>
References: <cover.1564145354.git.mchehab+samsung@kernel.org>
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
index 70ae148ec980..230e550e9741 100644
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

