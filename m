Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602AC3633F4
	for <lists+linux-pm@lfdr.de>; Sun, 18 Apr 2021 08:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbhDRGJr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 18 Apr 2021 02:09:47 -0400
Received: from mout02.posteo.de ([185.67.36.66]:43351 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230036AbhDRGJr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 18 Apr 2021 02:09:47 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id C785B2400FD
        for <linux-pm@vger.kernel.org>; Sun, 18 Apr 2021 08:09:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1618726157; bh=Hys3wSiOeJhvOKQ7pSM10m47FDA0/U/l+4h/F03Ansc=;
        h=From:To:Cc:Subject:Date:From;
        b=MxRZRHV4YB1khdI5VX16TZJ4ERNpDkvS4Z3DzDJjycyhXvpfiShM0CNU7wVY7gT/Z
         StB/ELij8ZCrB3oUIYSXwnHSP+EPFMM5fxkFMc/4SJP8NinrlutfWuXttFpWuAkzQU
         xFh/roS/DQs0+DtdkSJCWeQqB6iV3zXmqN9htWFqGAm0+rWlL6GuLvOgnwWXIPMQRy
         xJSsfs0iABs3fYRd7M2tOoUQzKYJK5yQ/1XhaKJ9C2KNEPnEksBcjtDX3yqFsTj/d8
         CtHlcGIzqdC9qJC8WLPrYveQKT65qT/XRoHccINAYjFgC1vSoH0aUuSH2ZxlLyCv2K
         fKWdMyOvLUI8g==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4FNKK56xG8z6tmF;
        Sun, 18 Apr 2021 08:09:13 +0200 (CEST)
From:   Sebastian Fricke <sebastian.fricke@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     Sebastian Fricke <sebastian.fricke@posteo.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH] base: power: runtime.c: Remove a unnecessary space
Date:   Sun, 18 Apr 2021 06:08:01 +0000
Message-Id: <20210418060800.8833-1-sebastian.fricke@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Remove a redundant space to improve the quality of the comment.

Signed-off-by: Sebastian Fricke <sebastian.fricke@posteo.net>
---
Side-note:
I found this while reading the code, I don't believe it is important but
I thought it doesn't hurt to fix it.
---
 drivers/base/power/runtime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 18b82427d0cb..499434b84171 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -786,7 +786,7 @@ static int rpm_resume(struct device *dev, int rpmflags)
 	}
 
 	/*
-	 * See if we can skip waking up the parent.  This is safe only if
+	 * See if we can skip waking up the parent. This is safe only if
 	 * power.no_callbacks is set, because otherwise we don't know whether
 	 * the resume will actually succeed.
 	 */
-- 
2.25.1

