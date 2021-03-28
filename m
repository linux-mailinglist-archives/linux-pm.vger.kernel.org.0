Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 472F234BD80
	for <lists+linux-pm@lfdr.de>; Sun, 28 Mar 2021 19:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbhC1RQi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Mar 2021 13:16:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:57998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231424AbhC1RQb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 28 Mar 2021 13:16:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BDB866197C;
        Sun, 28 Mar 2021 17:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616951791;
        bh=2y5dOkMjCFC8qhy8AvW4/NLBXlZEDwLSPJ0Ud0dhU94=;
        h=From:To:Cc:Subject:Date:From;
        b=DbFdA/CWLPWMfZzMBWhWfCZiNJ83DFUmu0Lxt1sHogkNjeldIJuVbE74ZuvSwgWev
         VM8wxrWrs0jLssgyrCaK6J2aGEtdU1j4xkoETAy7HOZ6XW8PxVMa4LxQDNHZGHXhvQ
         ZyOK87B2D97+WuWmQicQ/SbBJ9acr79a8W/r/EOmmtQl0XnR1AgWp+CYf8ij9EAvwp
         10nXqvSLAqebO82xiXA6g9fpqB9er8AohmSCaMxwd0n4P0vdzZKRWGtmRle5yV/OSY
         Lj/EVL7P2doREdROhmwYTRbjdTtBG40U3vOfN6nTEAAjgk2yXEXWJeCchNGEC3vmEI
         rJ9/zecfFEzTw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: icc: add interconnect tree
Date:   Sun, 28 Mar 2021 22:46:18 +0530
Message-Id: <20210328171618.2759956-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

MAINTAINERS entry for ICC is missing the tree details, so add it

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6de606aeb9b1..e3f37d0b6de9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9290,6 +9290,7 @@ INTERCONNECT API
 M:	Georgi Djakov <djakov@kernel.org>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git
 F:	Documentation/devicetree/bindings/interconnect/
 F:	Documentation/driver-api/interconnect.rst
 F:	drivers/interconnect/
-- 
2.26.3

