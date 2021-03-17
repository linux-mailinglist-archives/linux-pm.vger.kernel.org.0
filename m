Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A77C533F1AC
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 14:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbhCQNtx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 09:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbhCQNtP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Mar 2021 09:49:15 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E54C061760;
        Wed, 17 Mar 2021 06:49:15 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 31CDE1F44AAB
Received: by jupiter.universe (Postfix, from userid 1000)
        id 2C6ED480120; Wed, 17 Mar 2021 14:49:06 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv2 38/38] dt-bindings: power: supply: Drop power_supply.txt
Date:   Wed, 17 Mar 2021 14:49:04 +0100
Message-Id: <20210317134904.80737-39-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210317134904.80737-1-sebastian.reichel@collabora.com>
References: <20210317134904.80737-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The file has been replaced by power-supply.yaml and all links
have been updated to the new file.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 Documentation/devicetree/bindings/power/supply/power_supply.txt | 2 --
 1 file changed, 2 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/supply/power_supply.txt

diff --git a/Documentation/devicetree/bindings/power/supply/power_supply.txt b/Documentation/devicetree/bindings/power/supply/power_supply.txt
deleted file mode 100644
index d9693e054509..000000000000
--- a/Documentation/devicetree/bindings/power/supply/power_supply.txt
+++ /dev/null
@@ -1,2 +0,0 @@
-This binding has been converted to yaml please see power-supply.yaml in this
-directory.
-- 
2.30.2

