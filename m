Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 511FF4279BA
	for <lists+linux-pm@lfdr.de>; Sat,  9 Oct 2021 13:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244837AbhJILxX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 9 Oct 2021 07:53:23 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:36661 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244798AbhJILxW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 9 Oct 2021 07:53:22 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 3B3C458055A;
        Sat,  9 Oct 2021 07:51:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 09 Oct 2021 07:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=JmrAk6lslDeRq
        3HtNAosrHiHpleBbi7+FujnFXzxuU0=; b=a9jASffo+ouzTcQbMF/wWeyVROh29
        Eq8LUJxa0ujsDLXo7W7UqO7LsGhSeJcIazKOG5Cua58Lk56XEy5kk1KDNQGFyHuw
        4ZQ4L+p9nnrCrR/redQsfd7++ZObqJX8IN6yOn9oXgA+I3Ms2QbZ++C/P6YU9MCM
        GWpKN9+KfeIcpFzHuSXhR9artJaEwIBXPywUeDXDm94Bxy37JqYzOZK4lmB0voSK
        t+QbUg46GnCQRIzwny4qg/p04Fxp/0vUIpPxlUzi/BkPveu2d6+uArgFnS3DMK3r
        BNv2/c7xFc+G4+HcCJAQrUK9VroD0kQkx3gZxwU+ki2HbIG/li0VY1WqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=JmrAk6lslDeRq3HtNAosrHiHpleBbi7+FujnFXzxuU0=; b=jifjRidy
        6ivREx2qZJVJnYB/SDTETrCzc0E6gNKxNGEmaLunPXlJH/NcaOfgE22JhTIZ65yh
        P5j12PxlXaHsCsdKlqUj4XEN+YEjEmpnmSebPZyCVGEUHWpZ09dNKELycPtNS0/N
        b60stEAEfwQ9vZQaPfffauAjkPYTyTg68K28DwXWyJDyEbIGBEo4f3/ZSI/7ZLze
        2aiY70HsZ+0qMtWrY4SSkF+8LkL5yLye7Tod34MV26ClKDargu5p9TES12FT41RQ
        HxtCVZKoWuXOHx9ZbrhFK4nkNXzc/6vu18FqNtLRbyQ3pIu3g6UaSD87oNXiojzf
        5tveUnbnRALvOg==
X-ME-Sender: <xms:PYJhYViqOaplLmfgcEr4zhiswb74dYYti8pDLYdJrlum-wxHR6UCeA>
    <xme:PYJhYaCzrur-wXiMbSZAlCKhglrkNagggCL8THsJtIFNQDiwu2SdAlJkr9shKKyqZ
    IpEphU_Qzi8Jp1MjqE>
X-ME-Received: <xmr:PYJhYVGTpDB9i-XwAYSAe3OnSnB0JNdepYCDJce1rxyR9FJErlCx9z5AYpD1xFiTEco4kG3uuEeO-QIz-OsUDT2XcG8ES_TBnVk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddtvddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeggedtteejke
    eggeeugfehueevudegvdetjeeviedugedvtdekffekhedtteduhfenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:PYJhYaTr_ONwvHB-55sfmf5BxVw6fkG3koQAhaU1jeNPj9jRAJie8A>
    <xmx:PYJhYSxx2f0BbTekdCkexhLOgZI0Y4si1Llz8C2bHqc9Wa62x6ZoKw>
    <xmx:PYJhYQ5UuW6_kpNl1ZBNrxiDm74-UHZoUk5b026IOVMCDStNWqRsHw>
    <xmx:PYJhYWDRJhgldM3j4X8re4tF2wpPkC9E3Cwpk79jUFc8p89ImVgmPg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Oct 2021 07:51:20 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, kernel@pengutronix.de
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, linux-imx@nxp.com,
        amitk@kernel.org, rui.zhang@intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 5/7] capsules: hmac: Continue reducing code size
Date:   Sat,  9 Oct 2021 21:50:26 +1000
Message-Id: <20211009115031.18392-8-alistair@alistair23.me>
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
 capsules/src/hmac.rs | 52 ++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 28 deletions(-)

diff --git a/capsules/src/hmac.rs b/capsules/src/hmac.rs
index 83d1e5ea5..0ea30635b 100644
--- a/capsules/src/hmac.rs
+++ b/capsules/src/hmac.rs
@@ -478,37 +478,33 @@ impl<
         allow_num: usize,
         mut slice: ReadOnlyProcessBuffer,
     ) -> Result<ReadOnlyProcessBuffer, (ReadOnlyProcessBuffer, ErrorCode)> {
-        let res = match allow_num {
-            // Pass buffer for the key to be in
-            0 => self
-                .apps
-                .enter(appid, |app, _| {
-                    mem::swap(&mut app.key, &mut slice);
-                    Ok(())
-                })
-                .unwrap_or(Err(ErrorCode::FAIL)),
+        let res = self
+            .apps
+            .enter(appid, |app, _| {
+                match allow_num {
+                    // Pass buffer for the key to be in
+                    0 => {
+                        mem::swap(&mut app.key, &mut slice);
+                        Ok(())
+                    }
 
-            // Pass buffer for the data to be in
-            1 => self
-                .apps
-                .enter(appid, |app, _| {
-                    mem::swap(&mut app.data, &mut slice);
-                    Ok(())
-                })
-                .unwrap_or(Err(ErrorCode::FAIL)),
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

