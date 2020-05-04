Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7991C483E
	for <lists+linux-pm@lfdr.de>; Mon,  4 May 2020 22:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgEDU3x (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 May 2020 16:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgEDU3w (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2020 16:29:52 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481C6C061A0E
        for <linux-pm@vger.kernel.org>; Mon,  4 May 2020 13:29:52 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 18so6149157pfx.6
        for <linux-pm@vger.kernel.org>; Mon, 04 May 2020 13:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q6DSmsBJKt2DQfLRYsNho1OzzZKZZ7TrpLhucHJGeDU=;
        b=CtUHuD2HM6xhWKDF3wYinVyJ5yfU8h3iMv+4Jgb/2SnYJaXO580t11nnYxa+9FlNDK
         U6TGMzQwU+V7RChMHxwXZtyt+SewvPLvCCLh1uwla15xqrRU0z1ghpA1H7ZH1pJ46AdY
         SEXFhpaX8gu/FTKTebFQeFBwGadqxAUhyR9ME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q6DSmsBJKt2DQfLRYsNho1OzzZKZZ7TrpLhucHJGeDU=;
        b=ndUPKkLSH5vtzOTOpJ4L3yvjjhQ4l1F34tAOtx6eA42/tqsAkTWN/j1AAXllrhXWKg
         2B5V8PG/ZN0zg2CYS3fkiQHZomGwQr2A67/JCQUZyhtLy1BkwFfbtASrHiuXjp1++iL6
         CYLAvlXGOCrpYRJg1YmrLXZbtdKP3tuxPamgdzI9Y01zGW4I6dNpya3x5JZmQeDwAw4B
         IzG01grtHuAtzzv0AGEOQsCxJVzivo5TjxkBxA+6Wj5c6n5Hr+70CiYC8qehtfu88g3T
         I2c9VUzmgfTWH50YxvIaqBgMcjQRP4yFrMkOM1IKD4RBhh8XmQwahlibzJVc+QmWN1+J
         evTg==
X-Gm-Message-State: AGi0PuZrmg1VWp4X4mK4R7WCVA53HLptxdxh+qmrWXHmnPUUzTZRiRr0
        D4P1jS5Raj4vUixprEmGwPdX6Q==
X-Google-Smtp-Source: APiQypJFsSvliJI9R20jNekDhiFtU17acQVf014rcrlhyg8R1X6m8Sc86MkUoQNu9jpjNd5H+2HQbA==
X-Received: by 2002:a63:a012:: with SMTP id r18mr30263pge.352.1588624191724;
        Mon, 04 May 2020 13:29:51 -0700 (PDT)
Received: from mathewk1.lan ([161.97.192.125])
        by smtp.gmail.com with ESMTPSA id z23sm9511737pfr.136.2020.05.04.13.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 13:29:51 -0700 (PDT)
From:   Mathew King <mathewk@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mathew King <mathewk@chromium.org>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH v2 0/4] Cleanup power_supply_sysfs.c
Date:   Mon,  4 May 2020 14:29:26 -0600
Message-Id: <20200504202930.228453-1-mathewk@chromium.org>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A few various patches to cleanup the power_supply sysfs implementation.
---
v2: - Don't create attributes for unlisted properties
    - Use a char array for lower case name so no allocations neeed in
      init
    - Fix patch #2 does not compile because of change meant for patch #3

Mathew King (4):
  power_supply: Cleanup power supply sysfs attribute list
  power_supply: Use designated initializer for property text arrays
  power_supply: Add a macro that maps enum properties to text values
  power_supply: Add power supply type property to uevent env

 drivers/power/supply/power_supply_sysfs.c | 471 ++++++++++++----------
 1 file changed, 255 insertions(+), 216 deletions(-)

-- 
2.26.2.526.g744177e7f7-goog

