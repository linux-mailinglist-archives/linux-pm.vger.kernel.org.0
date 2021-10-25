Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D37543A5F9
	for <lists+linux-pm@lfdr.de>; Mon, 25 Oct 2021 23:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbhJYViH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Oct 2021 17:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234106AbhJYViF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Oct 2021 17:38:05 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D54C061220
        for <linux-pm@vger.kernel.org>; Mon, 25 Oct 2021 14:35:42 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id x194-20020a627ccb000000b0047c01bf74a4so1305198pfc.9
        for <linux-pm@vger.kernel.org>; Mon, 25 Oct 2021 14:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MZF5VEKMYWbB/Dv8KErRk2fZA5ZJJGAkLiY8ScjRBG4=;
        b=qUonqI8VkIEIoLRHJKaKhq8KLWGGNxSUVTwOxm56x0OQTmIBsG7yKviyP3spqedJ10
         ahH53ZJP2AxEcJP8GPMIV0ogmkx6grO1n2x2jj+vLWDmd3XvAJ3vJN0FzauiSxU8lfsM
         DhHWacNRnjI0rRvWk63n/XvcE1HScTPNrCTSAC1mx8oNZ7v7qg86WyF2gguA18RqekM2
         J01pNe2hEZ3O3uPPqjPRhoYteLtLF9MluKAofQ8k2Lc9/sZWg4tqB0CKcesX2slwSL5m
         omHXC4rzRNEdJF0qXy8Qg9HzLCGQzcJXF1ofBylBo+h2JseqtrUC11J1uNPR8BN/ntJ9
         aZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MZF5VEKMYWbB/Dv8KErRk2fZA5ZJJGAkLiY8ScjRBG4=;
        b=sQXG6emeIacQrkupw7xLOAThbxUxswGfLngMMFTcG9IR6P6YtZdf6p4+5z8tgvVfMS
         TSxVWnYy77s4kHx0/R+x2F8MvaaLWjRwJTbyMJ9izP9ZxquFf6NfKA+HrY6L48Rw1Jdx
         khq9KCOpJ+Z/rpwdZQKKIOSHSxHE5jkEtOeC1mIcilen1kljtlg46jEHgyASPMzSpEao
         0LZi7jAmTMYpev2Km6S1EImIKE6GRo6STophaWVZdZ2hSI2nJaqVAHw+frtR+3DqKKFT
         +4X+haIz+KnAV0cFqRZ4E95N49InJGlSdwfXa8IrT6wbuhicndIp5qJ953njOsR4vtc2
         7QYA==
X-Gm-Message-State: AOAM531V4tVl5MuCMOphd/fvBXQtACMBKiBf22g4lEoXJUywDz0ZSi4f
        rs05UxIOvifdTJznxtpFfKLiEY4Ml0dS
X-Google-Smtp-Source: ABdhPJzkfDZRrjaYWKYgmFVfnQaT5jQQ4wlclsz+xzDo5mAEHNEVhQiN2cDHkhnNVcX+7MJsyJ14Vo+5S6Yk
X-Received: from rajat2.mtv.corp.google.com ([2620:15c:202:201:5478:3d15:6893:1074])
 (user=rajatja job=sendgmr) by 2002:a17:902:b616:b0:13f:7983:21b6 with SMTP id
 b22-20020a170902b61600b0013f798321b6mr19108199pls.42.1635197741760; Mon, 25
 Oct 2021 14:35:41 -0700 (PDT)
Date:   Mon, 25 Oct 2021 14:35:31 -0700
In-Reply-To: <20211025213532.2349161-1-rajatja@google.com>
Message-Id: <20211025213532.2349161-4-rajatja@google.com>
Mime-Version: 1.0
References: <20211025213532.2349161-1-rajatja@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH 3/3] i2c: enable async suspend/resume on i2c client devices
From:   Rajat Jain <rajatja@google.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dtor@google.com
Cc:     Derek Basehore <dbasehore@chromium.org>, rajatxjain@gmail.com,
        Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Derek Basehore <dbasehore@chromium.org>

This enables the async suspend for i2c client devices. This reduces
the suspend/resume time considerably on platforms where i2c devices
can take a lot of time (hundreds of ms) to resume.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
Signed-off-by: Rajat Jain <rajatja@google.com>
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
v2: Add Jarkko's tested by

 drivers/i2c/i2c-core-base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 8d4f2be54e17..70d32efb68ef 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1047,6 +1047,7 @@ i2c_new_client_device(struct i2c_adapter *adap, struct i2c_board_info const *inf
 	client->dev.of_node = of_node_get(info->of_node);
 	client->dev.fwnode = info->fwnode;
 
+	device_enable_async_suspend(&client->dev);
 	i2c_dev_set_name(adap, client, info);
 
 	if (info->swnode) {
-- 
2.33.0.1079.g6e70778dc9-goog

