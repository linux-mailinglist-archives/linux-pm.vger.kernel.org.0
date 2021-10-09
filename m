Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFD84279B3
	for <lists+linux-pm@lfdr.de>; Sat,  9 Oct 2021 13:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244791AbhJILxV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 9 Oct 2021 07:53:21 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:43205 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244777AbhJILxL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 9 Oct 2021 07:53:11 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 8DD47580542;
        Sat,  9 Oct 2021 07:51:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 09 Oct 2021 07:51:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=5B7osALGkMq4z
        6TfUD8C4USTTOHwH17luAiTHWn99ns=; b=Vb1pAROwysxO4IATx/iEZxsvwJA3K
        zVf3Y8AmAgrzke2OPYeoJtZBQ3c4bA2hy6EJ86Nb3x7XEv++Utltwyb4IUnHFGQs
        R45VP2ZcAZutb8HjavRxyrvVhe1Zq72Dk2UowYHQofEsP3wYjZbTUPdouibDB9Ng
        17N2CUIyWepxC/CkJnd9ZwFxf0XSv9lytcpFbgjDxOeeOgLpt4rPs8pbPWqFSIvQ
        WUkFHkmAgK81tLE4TmJlTgDp4qQbJrL8HL1hODmrB83nN+V/qIE/mEPTeh0Sz+Xd
        +/GJpzmXXSDWYma0IvzWm+x5fjTDAmqYcBN8dFsk4SVOMEIlM2K6CFIQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=5B7osALGkMq4z6TfUD8C4USTTOHwH17luAiTHWn99ns=; b=gUEfmhWg
        mplpy4yPWtX1gOtKXYj5x9xafH1A7COtvZBzLSzZcvLxl2Oc1sQYUfvivpTcFsvE
        AuiHyRoWUIfR+s8XgrCvruautCr8DCLApokLOHvq/CLBz1g3d/+G1b796UETCnXe
        bxASw6IX1AkdD0q80LVfRsiIxKqkGLKxRruW8QH8Vgp3uR8za5fcsV6r2+cL32wB
        wIKOOvsbwI+VqSmPjpYMQ7gQfdifXCxpY/XThdw+hP0k/lngAuFl6X9RGysSJ3V2
        OlAlEna0q9QWWh50nKma3H+20pMnUhutQHsUON6M6hEcuCBoKZKwoCwSTWQMq2ne
        j/k/yOzJGdiT5g==
X-ME-Sender: <xms:MoJhYX4-c8klrckoGCsCeLzR8C0vvaoeslM6iiIrlBWtmthvIrADQg>
    <xme:MoJhYc7rVHgJU2uKb1l_dfTEq5WCqTm4tOYWWiZr67OJqTz59m1zQTIaEkvY5MIEn
    uk2cJZ4O0r8uyd97f4>
X-ME-Received: <xmr:MoJhYefSS4Ww9ZI6xtVdUQeuhLzRXAkEW09gOJLVmmcBExJrrWWOuyG_zRpkqaKR3f3AsqjsH6zWoSbIaiZRzk1mTdTElQJWJxM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddtvddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeggedtteejke
    eggeeugfehueevudegvdetjeeviedugedvtdekffekhedtteduhfenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:MoJhYYLCm-TBX80z7DSpD5dGdnRZX-oB3OKqpyg1YbcxxSerN3BpkQ>
    <xmx:MoJhYbJhLo97rDO_ywmPYG92cveMgiy8J7-sWjA5WY0FTal4SC8weg>
    <xmx:MoJhYRwhhI86qGongx7w-t3ZI0gKK_9rQ2LH7L5r2Tmmcum-HL4WQw>
    <xmx:MoJhYc54iq16IdeDtYudXJLQjKbp4PIG-seHFd4iu5weSWnrzv79sw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Oct 2021 07:51:09 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, kernel@pengutronix.de
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, linux-imx@nxp.com,
        amitk@kernel.org, rui.zhang@intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 4/7] capsules: sha: Continue reducing code size
Date:   Sat,  9 Oct 2021 21:50:24 +1000
Message-Id: <20211009115031.18392-6-alistair@alistair23.me>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211009115031.18392-1-alistair@alistair23.me>
References: <20211009115031.18392-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Alistair Francis <alistair.francis@wdc.com>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 capsules/src/sha.rs | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/capsules/src/sha.rs b/capsules/src/sha.rs
index a296bc6bc..0d2667e22 100644
--- a/capsules/src/sha.rs
+++ b/capsules/src/sha.rs
@@ -443,28 +443,27 @@ impl<
         allow_num: usize,
         mut slice: ReadOnlyProcessBuffer,
     ) -> Result<ReadOnlyProcessBuffer, (ReadOnlyProcessBuffer, ErrorCode)> {
-        let res = match allow_num {
-            // Pass buffer for the data to be in
-            1 => self
-                .apps
-                .enter(appid, |app, _| {
-                    mem::swap(&mut app.data, &mut slice);
-                    Ok(())
-                })
-                .unwrap_or(Err(ErrorCode::FAIL)),
+        let res = self
+            .apps
+            .enter(appid, |app, _| {
+                match allow_num {
+                    // Pass buffer for the data to be in
+                    1 => {
+                        mem::swap(&mut app.data, &mut slice);
+                        Ok(())
+                    }
 
-            // Compare buffer for verify
-            2 => self
-                .apps
-                .enter(appid, |app, _| {
-                    mem::swap(&mut app.compare, &mut slice);
-                    Ok(())
-                })
-                .unwrap_or(Err(ErrorCode::FAIL)),
+                    // Compare buffer for verify
+                    2 => {
+                        mem::swap(&mut app.compare, &mut slice);
+                        Ok(())
+                    }
 
-            // default
-            _ => Err(ErrorCode::NOSUPPORT),
-        };
+                    // default
+                    _ => Err(ErrorCode::NOSUPPORT),
+                }
+            })
+            .unwrap_or(Err(ErrorCode::FAIL));
 
         match res {
             Ok(()) => Ok(slice),
-- 
2.31.1

