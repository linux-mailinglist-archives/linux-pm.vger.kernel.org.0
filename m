Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24AC36878E1
	for <lists+linux-pm@lfdr.de>; Thu,  2 Feb 2023 10:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjBBJdr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Feb 2023 04:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjBBJdo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Feb 2023 04:33:44 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34ED222A1A
        for <linux-pm@vger.kernel.org>; Thu,  2 Feb 2023 01:33:17 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id m13so1215434plx.13
        for <linux-pm@vger.kernel.org>; Thu, 02 Feb 2023 01:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLvTiqdVeQuNLqX6XetgQClkA62J66I5SMvrcQs0Rf0=;
        b=2XOHzynzk4U3u6ifO7GFUgwC6BXN9AkvK+e5OfuXdVbvhnG+wzF3a6TXzI2tWS/vB/
         yV4yJa5rPXpSAoGrMEOjmxvkwG0Kt8vcXizpyA2l7/E4b5Vci9AgJqg30/cXP9jV5knf
         8+VSET+bN0sjj1TKqJIA9k5bupCldlGtEVKqyeO9/a55BZR27crppO3XH2FeQLdQ0lsh
         EXJfN3wxtP0jNJ5zcZt+HiZDFyc0XsI1vlUTL5tVPIXQrHh13kg7sdxx4VoFcv4O75fH
         /1wT52Ji2xyxCn2mi7urI2F/fvO1/wQMPJNQw/bTyZJ5LnaTo3RH2kQ5wbnqE4jvHPNP
         9fjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mLvTiqdVeQuNLqX6XetgQClkA62J66I5SMvrcQs0Rf0=;
        b=JFq2EoIjZ+nx5ocHQ1NMw5W00cdxbxfti1zrLKmjEvmc7yYAbjonEqTHuNHZ/A3BBR
         LlmKkY2tsKPHecHnjydkNb6cxnqXHbXGkqxLPRiAPXsGuYrXqjqOLkXYeTeQsnDqjFhh
         62+thR7BrirZIRXnGMl5ccsx3jEWMEAMCqKveSqNXkL6kIQP1m7rreFRB6iJxAatS3i/
         qAjLfJwJopCMXTPFPioW9Vs9GC53YCmSYhKUX73kJm1x2zpmqXw6ysYv3m/aXBw5uxCN
         wIoe/vCuzxhTKFkQ6csJvk4hC+5VaPA7F1Mwj9SqFRnEL2Gl8l2bGjes976lYx0t/Lo6
         C3Vg==
X-Gm-Message-State: AO0yUKU4awaFVzT+boUbjwc0nvG4eQ6Rqi2M6mc6yEtXig4hDuma7EXP
        Mip3tIK9QPR98GTNfhDYQ6Fx2w==
X-Google-Smtp-Source: AK7set80oPmJ11Kv4uUsseC+fddoDACFnXK/7wdkTVS9L04sA1zk7sOd8C4EQsmVheptDU1mqbvKkw==
X-Received: by 2002:a17:902:ecd0:b0:197:8e8e:f15 with SMTP id a16-20020a170902ecd000b001978e8e0f15mr6852515plh.6.1675330396764;
        Thu, 02 Feb 2023 01:33:16 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id c10-20020a170902848a00b0019254c19697sm13153343plo.289.2023.02.02.01.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 01:33:16 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        j.vosburgh@gmail.com, vfalico@gmail.com, andy@greyhouse.net,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        netdev@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 1/3] debugfs: update comment of debugfs_rename()
Date:   Thu,  2 Feb 2023 17:32:54 +0800
Message-Id: <20230202093256.32458-2-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230202093256.32458-1-zhengqi.arch@bytedance.com>
References: <20230202093256.32458-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since commit ff9fb72bc077 ("debugfs: return error values,
not NULL") changed return value of debugfs_rename() in
error cases from %NULL to %ERR_PTR(-ERROR), the comment
of debugfs_rename should also be updated so as not to
mislead readers.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 fs/debugfs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 2e8e112b1993..58a35afb7c5d 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -802,8 +802,8 @@ EXPORT_SYMBOL_GPL(debugfs_lookup_and_remove);
  * exist for rename to succeed.
  *
  * This function will return a pointer to old_dentry (which is updated to
- * reflect renaming) if it succeeds. If an error occurs, %NULL will be
- * returned.
+ * reflect renaming) if it succeeds. If an error occurs, %ERR_PTR(-ERROR)
+ * will be returned.
  *
  * If debugfs is not enabled in the kernel, the value -%ENODEV will be
  * returned.
-- 
2.20.1

