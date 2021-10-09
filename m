Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 521DC4279A8
	for <lists+linux-pm@lfdr.de>; Sat,  9 Oct 2021 13:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbhJILxC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 9 Oct 2021 07:53:02 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:59423 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244743AbhJILxB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 9 Oct 2021 07:53:01 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 055FF580542;
        Sat,  9 Oct 2021 07:51:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 09 Oct 2021 07:51:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=7oUy5FVjT9iAK
        qFIxT+XtiIGQTMJHnJ02eLfXVTDuKk=; b=JuEFxeR8pA8RO+DJ9Hb5Q0RcGWRlB
        8cbuhdArZm6D6WgFDf34iizeJ+5zFbdRRQWiELo8lt6Nj5k/iHwcdOQrpIVOcIph
        +K5dnceU194uJedaiJCcOr2LV4uJwyduW7aPzTvBBtuMAM9rRRWlyY7u7oE8wwJ+
        hlsvuzzTrBPHFHbGQQCK+qjbJwaGetSwkxD3jcxHvy6ab3tM0QMgio6bsefajJ0I
        M4/XaSQk3J62AZPwuXmHPlKid1cPSM/htdFJQ3mmjRDbbsAaz69NyMbxVPTiYnKh
        TLRy4nIkq7ludVToJrmjo6xCekp0IqCRGk4yPuJbjPla1JCCW0RauQmjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=7oUy5FVjT9iAKqFIxT+XtiIGQTMJHnJ02eLfXVTDuKk=; b=HlwJMmtD
        EUF6aJrNu6AOYUWTuA6rPX9e+LkrKpmu4dPSbwR93KjdGsXumg4zcq09MKuN/1zw
        //uqpT3IrzfclHRGK+u2USzORm10op+w4zozkOog6vAbcfY9pwAC8+Sz9jBizrhr
        Pmiaka00xYlTGPs+6I0U9UMC5JJy+hGjIzR1n4b7GFArdxJSXc6eAEQc6pMFukGm
        +6bkKTeOcZeysLATaLMztuVar8L5/FbmDVJMIzLK8z+r7WYqiQe2dmEQ/M8SqF4N
        8MF/ld1y9SfzPkccV7mqNkfvxzva5bhxrGnjZOoASxQtk7iNh1xJRssOyq2NH38U
        6kjYGGXhv2Gmiw==
X-ME-Sender: <xms:J4JhYZcBtMiiZDmhJ3wZ9SMvvDbXdZY1Qflp1HYQtqGGa3ZlWSkMOg>
    <xme:J4JhYXNzPN-SkhKykcfD6NnVeyZecufzMa18GooEGDnWayySClqBTPSUqZ3KDJwct
    FNK1fCNSMm9-dZ0Ptc>
X-ME-Received: <xmr:J4JhYSjS2nuR9DpVEvfvv5xPshSM55V_f4Ram92IB5YjcULsZKPjMDY1Mmlu8QLWzBAhLOEXTyquKc3LaCLrJZcLqqQIxOLIR4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddtvddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpedvveduleefje
    fgudfggeevkefhgeffteejhfejieelieeileefuddtfeevveevvdenucffohhmrghinhep
    rghpphhiugdrmhgrphdpghgvthdrihhsnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:J4JhYS_XvgapTwoe4VxrR81CE0kIvR7-aGsA4SLi0S3pqOQ-X0g2ew>
    <xmx:J4JhYVudLbJGcfI2zzRa1dLaHpFFIXFZmPO5lyQt5rCNprSDjtLA9Q>
    <xmx:J4JhYRFellNM9cfD6AzDyZ3Sj6VWvcm6mM0RjVcf6wZMvjZ0YKciqg>
    <xmx:J4JhYVPL611w9vjIoeR7VhQuzLll6fdAo8tyrZWN9WfKyKnmO6viYQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Oct 2021 07:50:58 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, kernel@pengutronix.de
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, linux-imx@nxp.com,
        amitk@kernel.org, rui.zhang@intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 3/7] capsules: symmetric_encryption/aes: Reduce code size
Date:   Sat,  9 Oct 2021 21:50:22 +1000
Message-Id: <20211009115031.18392-4-alistair@alistair23.me>
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
 capsules/src/symmetric_encryption/aes.rs | 587 ++++++++++++-----------
 1 file changed, 300 insertions(+), 287 deletions(-)

diff --git a/capsules/src/symmetric_encryption/aes.rs b/capsules/src/symmetric_encryption/aes.rs
index ed3bf74e6..1aa736ce0 100644
--- a/capsules/src/symmetric_encryption/aes.rs
+++ b/capsules/src/symmetric_encryption/aes.rs
@@ -90,21 +90,25 @@ impl<'a, A: AES128<'static> + AES128Ctr + AES128CBC + AES128ECB + AES128CCM<'sta
                                 key[..static_buffer_len]
                                     .copy_to_slice(&mut buf[..static_buffer_len]);
 
-                                match app.aes_operation.as_ref().unwrap() {
-                                    AesOperation::AES128Ctr(_)
-                                    | AesOperation::AES128CBC(_)
-                                    | AesOperation::AES128ECB(_) => {
-                                        if let Err(e) = AES128::set_key(self.aes, buf) {
-                                            return Err(e);
+                                if let Some(op) = app.aes_operation.as_ref() {
+                                    match op {
+                                        AesOperation::AES128Ctr(_)
+                                        | AesOperation::AES128CBC(_)
+                                        | AesOperation::AES128ECB(_) => {
+                                            if let Err(e) = AES128::set_key(self.aes, buf) {
+                                                return Err(e);
+                                            }
+                                            Ok(())
                                         }
-                                        Ok(())
-                                    }
-                                    AesOperation::AES128CCM(_) => {
-                                        if let Err(e) = AES128CCM::set_key(self.aes, buf) {
-                                            return Err(e);
+                                        AesOperation::AES128CCM(_) => {
+                                            if let Err(e) = AES128CCM::set_key(self.aes, buf) {
+                                                return Err(e);
+                                            }
+                                            Ok(())
                                         }
-                                        Ok(())
                                     }
+                                } else {
+                                    Err(ErrorCode::FAIL)
                                 }
                             })
                         })
@@ -125,21 +129,25 @@ impl<'a, A: AES128<'static> + AES128Ctr + AES128CBC + AES128ECB + AES128CCM<'sta
                                 iv[..static_buffer_len]
                                     .copy_to_slice(&mut buf[..static_buffer_len]);
 
-                                match app.aes_operation.as_ref().unwrap() {
-                                    AesOperation::AES128Ctr(_)
-                                    | AesOperation::AES128CBC(_)
-                                    | AesOperation::AES128ECB(_) => {
-                                        if let Err(e) = self.aes.set_iv(buf) {
-                                            return Err(e);
+                                if let Some(op) = app.aes_operation.as_ref() {
+                                    match op {
+                                        AesOperation::AES128Ctr(_)
+                                        | AesOperation::AES128CBC(_)
+                                        | AesOperation::AES128ECB(_) => {
+                                            if let Err(e) = self.aes.set_iv(buf) {
+                                                return Err(e);
+                                            }
+                                            Ok(())
                                         }
-                                        Ok(())
-                                    }
-                                    AesOperation::AES128CCM(_) => {
-                                        if let Err(e) = self.aes.set_nonce(&buf[0..13]) {
-                                            return Err(e);
+                                        AesOperation::AES128CCM(_) => {
+                                            if let Err(e) = self.aes.set_nonce(&buf[0..13]) {
+                                                return Err(e);
+                                            }
+                                            Ok(())
                                         }
-                                        Ok(())
                                     }
+                                } else {
+                                    Err(ErrorCode::FAIL)
                                 }
                             })
                         })
@@ -149,58 +157,65 @@ impl<'a, A: AES128<'static> + AES128Ctr + AES128CBC + AES128ECB + AES128CCM<'sta
                         .enter(|source| {
                             let mut static_buffer_len = 0;
 
-                            match app.aes_operation.as_ref().unwrap() {
-                                AesOperation::AES128Ctr(_)
-                                | AesOperation::AES128CBC(_)
-                                | AesOperation::AES128ECB(_) => {
-                                    self.source_buffer.map_or(Err(ErrorCode::NOMEM), |buf| {
-                                        // Determine the size of the static buffer we have
-                                        static_buffer_len = buf.len();
+                            if let Some(op) = app.aes_operation.as_ref() {
+                                match op {
+                                    AesOperation::AES128Ctr(_)
+                                    | AesOperation::AES128CBC(_)
+                                    | AesOperation::AES128ECB(_) => {
+                                        self.source_buffer.map_or(
+                                            Err(ErrorCode::NOMEM),
+                                            |buf| {
+                                                // Determine the size of the static buffer we have
+                                                static_buffer_len = buf.len();
 
-                                        if static_buffer_len > source.len() {
-                                            static_buffer_len = source.len()
-                                        }
+                                                if static_buffer_len > source.len() {
+                                                    static_buffer_len = source.len()
+                                                }
 
-                                        // Copy the data into the static buffer
-                                        source[..static_buffer_len]
-                                            .copy_to_slice(&mut buf[..static_buffer_len]);
+                                                // Copy the data into the static buffer
+                                                source[..static_buffer_len]
+                                                    .copy_to_slice(&mut buf[..static_buffer_len]);
 
-                                        self.data_copied.set(static_buffer_len);
+                                                self.data_copied.set(static_buffer_len);
 
-                                        Ok(())
-                                    })?;
-                                }
-                                AesOperation::AES128CCM(_) => {
-                                    self.dest_buffer.map_or(Err(ErrorCode::NOMEM), |buf| {
-                                        // Determine the size of the static buffer we have
-                                        static_buffer_len = buf.len();
+                                                Ok(())
+                                            },
+                                        )?;
+                                    }
+                                    AesOperation::AES128CCM(_) => {
+                                        self.dest_buffer.map_or(Err(ErrorCode::NOMEM), |buf| {
+                                            // Determine the size of the static buffer we have
+                                            static_buffer_len = buf.len();
 
-                                        if static_buffer_len > source.len() {
-                                            static_buffer_len = source.len()
-                                        }
+                                            if static_buffer_len > source.len() {
+                                                static_buffer_len = source.len()
+                                            }
 
-                                        // Copy the data into the static buffer
-                                        source[..static_buffer_len]
-                                            .copy_to_slice(&mut buf[..static_buffer_len]);
+                                            // Copy the data into the static buffer
+                                            source[..static_buffer_len]
+                                                .copy_to_slice(&mut buf[..static_buffer_len]);
 
-                                        self.data_copied.set(static_buffer_len);
+                                            self.data_copied.set(static_buffer_len);
 
-                                        Ok(())
-                                    })?;
+                                            Ok(())
+                                        })?;
+                                    }
                                 }
-                            }
 
-                            if let Err(e) = self.calculate_output(
-                                app.aes_operation.as_ref().unwrap(),
-                                app.aoff.get(),
-                                app.moff.get(),
-                                app.mlen.get(),
-                                app.mic_len.get(),
-                                app.confidential.get(),
-                            ) {
-                                return Err(e);
+                                if let Err(e) = self.calculate_output(
+                                    op,
+                                    app.aoff.get(),
+                                    app.moff.get(),
+                                    app.mlen.get(),
+                                    app.mic_len.get(),
+                                    app.confidential.get(),
+                                ) {
+                                    return Err(e);
+                                }
+                                Ok(())
+                            } else {
+                                Err(ErrorCode::FAIL)
                             }
-                            Ok(())
                         })
                         .unwrap_or(Err(ErrorCode::RESERVE))?;
 
@@ -223,40 +238,49 @@ impl<'a, A: AES128<'static> + AES128Ctr + AES128CBC + AES128ECB + AES128CCM<'sta
             AesOperation::AES128Ctr(_)
             | AesOperation::AES128CBC(_)
             | AesOperation::AES128ECB(_) => {
-                if let Some((e, source, dest)) = AES128::crypt(
-                    self.aes,
-                    Some(self.source_buffer.take().unwrap()),
-                    self.dest_buffer.take().unwrap(),
-                    0,
-                    AES128_BLOCK_SIZE,
-                ) {
-                    // Error, clear the appid and data
-                    self.aes.disable();
-                    self.appid.clear();
-                    self.source_buffer.replace(source.unwrap());
-                    self.dest_buffer.replace(dest);
+                if let Some(dest_buf) = self.dest_buffer.take() {
+                    if let Some((e, source, dest)) = AES128::crypt(
+                        self.aes,
+                        self.source_buffer.take(),
+                        dest_buf,
+                        0,
+                        AES128_BLOCK_SIZE,
+                    ) {
+                        // Error, clear the appid and data
+                        self.aes.disable();
+                        self.appid.clear();
+                        if let Some(source_buf) = source {
+                            self.source_buffer.replace(source_buf);
+                        }
+                        self.dest_buffer.replace(dest);
 
-                    return e;
+                        return e;
+                    }
+                } else {
+                    return Err(ErrorCode::FAIL);
                 }
             }
             AesOperation::AES128CCM(encrypting) => {
-                let buf = self.dest_buffer.take().unwrap();
-                if let Err((e, dest)) = AES128CCM::crypt(
-                    self.aes,
-                    buf,
-                    aoff,
-                    moff,
-                    mlen,
-                    mic_len,
-                    confidential,
-                    *encrypting,
-                ) {
-                    // Error, clear the appid and data
-                    self.aes.disable();
-                    self.appid.clear();
-                    self.dest_buffer.replace(dest);
+                if let Some(buf) = self.dest_buffer.take() {
+                    if let Err((e, dest)) = AES128CCM::crypt(
+                        self.aes,
+                        buf,
+                        aoff,
+                        moff,
+                        mlen,
+                        mic_len,
+                        confidential,
+                        *encrypting,
+                    ) {
+                        // Error, clear the appid and data
+                        self.aes.disable();
+                        self.appid.clear();
+                        self.dest_buffer.replace(dest);
 
-                    return Err(e);
+                        return Err(e);
+                    }
+                } else {
+                    return Err(ErrorCode::FAIL);
                 }
             }
         }
@@ -291,7 +315,9 @@ impl<'a, A: AES128<'static> + AES128Ctr + AES128CBC + AES128ECB + AES128CCM<'sta
     Client<'static> for AesDriver<'static, A>
 {
     fn crypt_done(&'a self, source: Option<&'static mut [u8]>, destination: &'static mut [u8]) {
-        self.source_buffer.replace(source.unwrap());
+        if let Some(source_buf) = source {
+            self.source_buffer.replace(source_buf);
+        }
         self.dest_buffer.replace(destination);
 
         self.appid.map(|id| {
@@ -384,22 +410,24 @@ impl<'a, A: AES128<'static> + AES128Ctr + AES128CBC + AES128ECB + AES128CCM<'sta
                             // Update the amount of data copied
                             self.data_copied.set(copied_data + static_buffer_len);
 
-                            if self
-                                .calculate_output(
-                                    app.aes_operation.as_ref().unwrap(),
-                                    app.aoff.get(),
-                                    app.moff.get(),
-                                    app.mlen.get(),
-                                    app.mic_len.get(),
-                                    app.confidential.get(),
-                                )
-                                .is_err()
-                            {
-                                // Error, clear the appid and data
-                                self.aes.disable();
-                                self.appid.clear();
-                                self.check_queue();
-                                return;
+                            if let Some(op) = app.aes_operation.as_ref() {
+                                if self
+                                    .calculate_output(
+                                        op,
+                                        app.aoff.get(),
+                                        app.moff.get(),
+                                        app.mlen.get(),
+                                        app.mic_len.get(),
+                                        app.confidential.get(),
+                                    )
+                                    .is_err()
+                                {
+                                    // Error, clear the appid and data
+                                    self.aes.disable();
+                                    self.appid.clear();
+                                    self.check_queue();
+                                    return;
+                                }
                             }
 
                             // Return as we don't want to run the digest yet
@@ -526,40 +554,35 @@ impl<'a, A: AES128<'static> + AES128Ctr + AES128CBC + AES128ECB + AES128CCM<'sta
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
-
-            // Pass buffer for the IV to be in
-            // This also contains the nonce when doing AES CCM
-            1 => self
-                .apps
-                .enter(appid, |app, _| {
-                    mem::swap(&mut app.iv, &mut slice);
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
 
-            // Pass buffer for the source to be in
-            // If doing a CCM operation also set the mlen
-            2 => self
-                .apps
-                .enter(appid, |app, _| {
-                    mem::swap(&mut app.source, &mut slice);
-                    app.mlen.set(app.source.len());
-                    Ok(())
-                })
-                .unwrap_or(Err(ErrorCode::FAIL)),
+                    // Pass buffer for the IV to be in
+                    // This also contains the nonce when doing AES CCM
+                    1 => {
+                        mem::swap(&mut app.iv, &mut slice);
+                        Ok(())
+                    }
+                    // Pass buffer for the source to be in
+                    // If doing a CCM operation also set the mlen
+                    2 => {
+                        mem::swap(&mut app.source, &mut slice);
+                        app.mlen.set(app.source.len());
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
@@ -622,77 +645,76 @@ impl<'a, A: AES128<'static> + AES128Ctr + AES128CBC + AES128ECB + AES128CCM<'sta
             }
         });
 
-        match command_num {
-            // check if present
-            0 => CommandReturn::success(),
+        // Try the commands where we want to start an operation *not* entered in
+        // an app grant first.
+        if match_or_empty_or_nonexistant
+            && (command_num == 2 || command_num == 2 || command_num == 4)
+        {
+            if command_num == 2 {
+                self.appid.set(appid);
+                let ret = self.run();
 
-            // set_algorithm
-            1 => self
-                .apps
-                .enter(appid, |app, _| match data1 {
-                    0 => {
-                        app.aes_operation = Some(AesOperation::AES128Ctr(data2 != 0));
-                        CommandReturn::success()
-                    }
-                    1 => {
-                        app.aes_operation = Some(AesOperation::AES128CBC(data2 != 0));
-                        CommandReturn::success()
-                    }
-                    2 => {
-                        app.aes_operation = Some(AesOperation::AES128ECB(data2 != 0));
-                        CommandReturn::success()
-                    }
-                    3 => {
-                        app.aes_operation = Some(AesOperation::AES128CCM(data2 != 0));
-                        CommandReturn::success()
-                    }
-                    _ => CommandReturn::failure(ErrorCode::NOSUPPORT),
-                })
-                .unwrap_or_else(|err| err.into()),
+                return if let Err(e) = ret {
+                    self.aes.disable();
+                    self.appid.clear();
+                    self.check_queue();
+                    CommandReturn::failure(e)
+                } else {
+                    CommandReturn::success()
+                };
+            }
+        }
 
-            // setup
-            // Copy in the key and IV and run the first encryption operation
-            // This will trigger a callback
-            2 => {
-                if match_or_empty_or_nonexistant {
-                    self.appid.set(appid);
-                    let ret = self.run();
+        let ret = self
+            .apps
+            .enter(appid, |app, upcalls| {
+                match command_num {
+                    // check if present
+                    0 => CommandReturn::success(),
+
+                    // set_algorithm
+                    1 => match data1 {
+                        0 => {
+                            app.aes_operation = Some(AesOperation::AES128Ctr(data2 != 0));
+                            CommandReturn::success()
+                        }
+                        1 => {
+                            app.aes_operation = Some(AesOperation::AES128CBC(data2 != 0));
+                            CommandReturn::success()
+                        }
+                        2 => {
+                            app.aes_operation = Some(AesOperation::AES128ECB(data2 != 0));
+                            CommandReturn::success()
+                        }
+                        3 => {
+                            app.aes_operation = Some(AesOperation::AES128CCM(data2 != 0));
+                            CommandReturn::success()
+                        }
+                        _ => CommandReturn::failure(ErrorCode::NOSUPPORT),
+                    },
 
-                    if let Err(e) = ret {
-                        self.aes.disable();
-                        self.appid.clear();
-                        self.check_queue();
-                        CommandReturn::failure(e)
-                    } else {
-                        CommandReturn::success()
+                    // setup
+                    // Copy in the key and IV and run the first encryption operation
+                    // This will trigger a callback
+                    2 => {
+                        // Some app is using the storage, we must wait.
+                        if app.pending_run_app.is_some() {
+                            // No more room in the queue, nowhere to store this
+                            // request.
+                            CommandReturn::failure(ErrorCode::NOMEM)
+                        } else {
+                            // We can store this, so lets do it.
+                            app.pending_run_app = Some(appid);
+                            CommandReturn::success()
+                        }
                     }
-                } else {
-                    // There is an active app, so queue this request (if possible).
-                    self.apps
-                        .enter(appid, |app, _| {
-                            // Some app is using the storage, we must wait.
-                            if app.pending_run_app.is_some() {
-                                // No more room in the queue, nowhere to store this
-                                // request.
-                                CommandReturn::failure(ErrorCode::NOMEM)
-                            } else {
-                                // We can store this, so lets do it.
-                                app.pending_run_app = Some(appid);
-                                CommandReturn::success()
-                            }
-                        })
-                        .unwrap_or_else(|err| err.into())
-                }
-            }
 
-            // crypt
-            // Generate the encrypted output
-            // Multiple calls to crypt will re-use the existing state
-            // This will trigger a callback
-            3 => {
-                if app_match {
-                    self.apps
-                        .enter(appid, |app, upcalls| {
+                    // crypt
+                    // Generate the encrypted output
+                    // Multiple calls to crypt will re-use the existing state
+                    // This will trigger a callback
+                    3 => {
+                        if app_match {
                             if let Err(e) = app
                                 .source
                                 .enter(|source| {
@@ -714,17 +736,21 @@ impl<'a, A: AES128<'static> + AES128Ctr + AES128CBC + AES128ECB + AES128CCM<'sta
                                         Ok(())
                                     })?;
 
-                                    if let Err(e) = self.calculate_output(
-                                        app.aes_operation.as_ref().unwrap(),
-                                        app.aoff.get(),
-                                        app.moff.get(),
-                                        app.mlen.get(),
-                                        app.mic_len.get(),
-                                        app.confidential.get(),
-                                    ) {
-                                        return Err(e);
+                                    if let Some(op) = app.aes_operation.as_ref() {
+                                        if let Err(e) = self.calculate_output(
+                                            op,
+                                            app.aoff.get(),
+                                            app.moff.get(),
+                                            app.mlen.get(),
+                                            app.mic_len.get(),
+                                            app.confidential.get(),
+                                        ) {
+                                            return Err(e);
+                                        }
+                                        Ok(())
+                                    } else {
+                                        Err(ErrorCode::FAIL)
                                     }
-                                    Ok(())
                                 })
                                 .unwrap_or(Err(ErrorCode::RESERVE))
                             {
@@ -735,87 +761,74 @@ impl<'a, A: AES128<'static> + AES128Ctr + AES128CBC + AES128ECB + AES128CCM<'sta
                                     )
                                     .ok();
                             }
-                        })
-                        .unwrap();
-                    CommandReturn::success()
-                } else {
-                    // We don't queue this request, the user has to call
-                    // `setup` first.
-                    CommandReturn::failure(ErrorCode::OFF)
-                }
-            }
+                            CommandReturn::success()
+                        } else {
+                            // We don't queue this request, the user has to call
+                            // `setup` first.
+                            CommandReturn::failure(ErrorCode::OFF)
+                        }
+                    }
 
-            // Finish
-            // Complete the operation and reset the AES
-            // This will not trigger a callback and will not process any data from userspace
-            4 => {
-                if app_match {
-                    self.apps
-                        .enter(appid, |_app, _upcalls| {
+                    // Finish
+                    // Complete the operation and reset the AES
+                    // This will not trigger a callback and will not process any data from userspace
+                    4 => {
+                        if app_match {
                             self.aes.disable();
                             self.appid.clear();
-                        })
-                        .unwrap();
-                    self.check_queue();
-                    CommandReturn::success()
-                } else {
-                    // We don't queue this request, the user has to call
-                    // `setup` first.
-                    CommandReturn::failure(ErrorCode::OFF)
-                }
-            }
 
-            // Set aoff for CCM
-            // This will not trigger a callback and will not process any data from userspace
-            5 => {
-                self.apps
-                    .enter(appid, |app, _upcalls| {
+                            CommandReturn::success()
+                        } else {
+                            // We don't queue this request, the user has to call
+                            // `setup` first.
+                            CommandReturn::failure(ErrorCode::OFF)
+                        }
+                    }
+
+                    // Set aoff for CCM
+                    // This will not trigger a callback and will not process any data from userspace
+                    5 => {
                         app.aoff.set(data1);
-                    })
-                    .unwrap();
-                self.check_queue();
-                CommandReturn::success()
-            }
+                        CommandReturn::success()
+                    }
 
-            // Set moff for CCM
-            // This will not trigger a callback and will not process any data from userspace
-            6 => {
-                self.apps
-                    .enter(appid, |app, _upcalls| {
+                    // Set moff for CCM
+                    // This will not trigger a callback and will not process any data from userspace
+                    6 => {
                         app.moff.set(data1);
-                    })
-                    .unwrap();
-                self.check_queue();
-                CommandReturn::success()
-            }
+                        CommandReturn::success()
+                    }
 
-            // Set mic_len for CCM
-            // This will not trigger a callback and will not process any data from userspace
-            7 => {
-                self.apps
-                    .enter(appid, |app, _upcalls| {
+                    // Set mic_len for CCM
+                    // This will not trigger a callback and will not process any data from userspace
+                    7 => {
                         app.mic_len.set(data1);
-                    })
-                    .unwrap();
-                self.check_queue();
-                CommandReturn::success()
-            }
+                        CommandReturn::success()
+                    }
 
-            // Set confidential boolean for CCM
-            // This will not trigger a callback and will not process any data from userspace
-            8 => {
-                self.apps
-                    .enter(appid, |app, _upcalls| {
+                    // Set confidential boolean for CCM
+                    // This will not trigger a callback and will not process any data from userspace
+                    8 => {
                         app.confidential.set(data1 > 0);
-                    })
-                    .unwrap();
-                self.check_queue();
-                CommandReturn::success()
-            }
+                        CommandReturn::success()
+                    }
 
-            // default
-            _ => CommandReturn::failure(ErrorCode::NOSUPPORT),
+                    // default
+                    _ => CommandReturn::failure(ErrorCode::NOSUPPORT),
+                }
+            })
+            .unwrap_or_else(|err| err.into());
+
+        if command_num == 4
+            || command_num == 5
+            || command_num == 6
+            || command_num == 7
+            || command_num == 8
+        {
+            self.check_queue();
         }
+
+        ret
     }
 
     fn allocate_grant(&self, processid: ProcessId) -> Result<(), kernel::process::Error> {
-- 
2.31.1

