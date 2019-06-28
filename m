Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC28459B88
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2019 14:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfF1Mdm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jun 2019 08:33:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39066 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfF1Mah (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jun 2019 08:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SXOYVTl3M1/xi35QFTDKR/sPXV+7ZjeQCuuCvcU7tFI=; b=TZKUuqlBJ2IlI6W1VoUFZ/+5wt
        Ws8d7+ZWhWNlT0luYYBVicFsQvfocGHORu39jWxEwv9+QOifyUMDSdT3DxDsuL7ijx7edwfyY0DxC
        vGxKNHjhPB6y7gvQlIQrKiiXQvRokXv+OrmRELKWy0veHmR18ERvYRoyK38Mkl4fZIujnzyPOSqDB
        tIU4rJ39jNN5U0q4u4kOLvVQyWs/NjJkjLbLMh6yaERJrrCbP/qVsSyb6Gjv7/29VWVooM0/WIbNy
        /Vrg82XTFSTBVjAEpw8FavzLAI5S6y+xH0xGn9CNxQlaMtknuv5WZxnMrwRE6/LQEG1dAjVwALUVf
        4iF0Gx4g==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgq1U-000558-64; Fri, 28 Jun 2019 12:30:36 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgq1S-0005Rs-8E; Fri, 28 Jun 2019 09:30:34 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH 12/39] docs: interconnect.rst: add it to the driver-api guide
Date:   Fri, 28 Jun 2019 09:30:05 -0300
Message-Id: <feb5e217face2ff3f2ccd5c3726192bf1250dd0d.1561724493.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561724493.git.mchehab+samsung@kernel.org>
References: <cover.1561724493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is intented for Kernel hackers audience.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/driver-api/index.rst                          | 1 +
 Documentation/{interconnect => driver-api}/interconnect.rst | 2 --
 MAINTAINERS                                                 | 2 +-
 3 files changed, 2 insertions(+), 3 deletions(-)
 rename Documentation/{interconnect => driver-api}/interconnect.rst (99%)

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 2a0b57f12d1a..97bab578ea72 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -35,6 +35,7 @@ available subsections can be seen below.
    spi
    i2c
    i3c/index
+   interconnect
    hsi
    edac
    scsi
diff --git a/Documentation/interconnect/interconnect.rst b/Documentation/driver-api/interconnect.rst
similarity index 99%
rename from Documentation/interconnect/interconnect.rst
rename to Documentation/driver-api/interconnect.rst
index 56e331dab70e..c3e004893796 100644
--- a/Documentation/interconnect/interconnect.rst
+++ b/Documentation/driver-api/interconnect.rst
@@ -1,7 +1,5 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-:orphan:
-
 =====================================
 GENERIC SYSTEM INTERCONNECT SUBSYSTEM
 =====================================
diff --git a/MAINTAINERS b/MAINTAINERS
index 55996c9f2e0a..524e2c4300dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8273,7 +8273,7 @@ INTERCONNECT API
 M:	Georgi Djakov <georgi.djakov@linaro.org>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
-F:	Documentation/interconnect/
+F:	Documentation/driver-api/interconnect.rst
 F:	Documentation/devicetree/bindings/interconnect/
 F:	drivers/interconnect/
 F:	include/dt-bindings/interconnect/
-- 
2.21.0

