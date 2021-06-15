Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C153A7D89
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jun 2021 13:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhFOLvj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Jun 2021 07:51:39 -0400
Received: from mail-m121144.qiye.163.com ([115.236.121.144]:50790 "EHLO
        mail-m121144.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhFOLvj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Jun 2021 07:51:39 -0400
DKIM-Signature: a=rsa-sha256;
        b=W1Cvo/+NZqZ9VxbAitK/kHlzo+N9vKHmzeOPazvGGfXugCiajk9i40AgKvnB44vP8M4CdRxWreWXvE0e/U8TRdoKLkWAsrwlyGees9ko2YexUMK0tNwcCjBV1ERDmDUBBltrfIHbsQ6IeprNYSgWiZe6XfFOlF6VnposU90hBNw=;
        c=relaxed/relaxed; s=default; d=vivo.com; v=1;
        bh=0/P63dEAOAi+kPvhAWGq4Q0ts3IqPeJedDxz2jbvCbk=;
        h=date:mime-version:subject:message-id:from;
Received: from Wanjb.localdomain (unknown [36.152.145.182])
        by mail-m121144.qiye.163.com (Hmail) with ESMTPA id BFE64AC028E;
        Tue, 15 Jun 2021 19:49:33 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Wan Jiabing <wanjiabing@vivo.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpuidle: remove unneeded semicolon in teo.c
Date:   Tue, 15 Jun 2021 19:49:20 +0800
Message-Id: <20210615114921.8340-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQ0NNHlYaQhpOQ0MdHx9JTkNVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NjY6Nww6Az8QN0gpC04cKz05
        FDxPC0hVSlVKTUlITE5MTExPSkxCVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKTkxKNwY+
X-HM-Tid: 0a7a0f815c41b039kuuubfe64ac028e
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix following coccicheck warning:
drivers/cpuidle/governors/teo.c:315:10-11: Unneeded semicolon

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/cpuidle/governors/teo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
index 1e0b2f828abb..7b91060e82f6 100644
--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -312,7 +312,7 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 
 	/* Check if there is any choice in the first place. */
 	if (drv->state_count < 2) {
-		idx = 0;;
+		idx = 0;
 		goto end;
 	}
 	if (!dev->states_usage[0].disable) {
-- 
2.20.1

