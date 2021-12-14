Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70FDA473D3A
	for <lists+linux-pm@lfdr.de>; Tue, 14 Dec 2021 07:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhLNGbK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Dec 2021 01:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbhLNGbJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Dec 2021 01:31:09 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1C6C061574
        for <linux-pm@vger.kernel.org>; Mon, 13 Dec 2021 22:31:09 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id p133-20020a255b8b000000b006086e19f89fso16141670ybb.19
        for <linux-pm@vger.kernel.org>; Mon, 13 Dec 2021 22:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=4aquuHkNhx64QCRmus/ZeD4x0c+Y/d9J8MF5XvaCktU=;
        b=ChGuty2N/2029CJlfZ+b7EeyPWo1ibktr/pXOop6SSbwrEsyTKAZo4fNQ1rjIL4mzo
         kxTAC37PIbQXPgeISetIsa9bLRnuk4NgPjNGKuHsFJlYYLmlNZ6k/O4CpL1fO26F2+r+
         fx3otRciq3fCpupcTvUU2pgxQ2eIG1AykjvVvGMHXK/4b4k1LYJoFJxUW1NlNkIYaqRp
         AAkXb32euLE1+CGBBWu4zVtoHP1iWICGAakwBY3YVEQab74aDD8eWMBvJRTJh4Lrqen7
         Wf0UZgVG9JPYIL6gbpOkLm3kYZo5GwVTbddtf72rSJP/Evv3uGOD9g/5ZMvniHk2fEXB
         3CrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=4aquuHkNhx64QCRmus/ZeD4x0c+Y/d9J8MF5XvaCktU=;
        b=nXqqvArHxg10Q32LKQks5g/N5ylWUPoDCo8Cbl4urhBSttQEFms0qCKAO3f4egyEWh
         QyrZZBJnnKcO4NOzyXe92odoSYwUj4wPE6z3yvIaoyjYPvWo9ciRvr+3hGbVuZ7lWk3O
         IYeyH3UAKuMGRmNsxHUhs8Jg7WxJZfweQ2/jyE8Bu090C0t4bGaNOarIKvOw9poSBy1s
         g5+RAgfTtShycsNUG4aohogg+jkomgnjr7tqNusXzRt8hXU9XeFeji4zjyzCnMX/oXYO
         K5RqMzGGu75Z2vQv8vJEzFnKwsOXNBUzpszcEZzRbhScvF1wXR9eyrpkPk742zG7OyuM
         Lk4w==
X-Gm-Message-State: AOAM530Iro1fpubgv2QJNCMbP5KiEjSnhMjaGQIxUV8Pxf71W+Zc8lTd
        BA0acQISAaMX2rU04o2R7Hu86BCfMZ8G
X-Google-Smtp-Source: ABdhPJxPW5uDWSyJXd72mpZ7iA9irUszeWyKPlK6PbbABP1omAcy9nbX7bW/uXhth/GzZvF1756E/gSqeGzC
X-Received: from tzungbi-z840.tpe.corp.google.com ([2401:fa00:1:10:16cc:acbf:e9c5:6393])
 (user=tzungbi job=sendgmr) by 2002:a25:38cb:: with SMTP id
 f194mr4103910yba.446.1639463468788; Mon, 13 Dec 2021 22:31:08 -0800 (PST)
Date:   Tue, 14 Dec 2021 14:31:00 +0800
Message-Id: <20211214063100.3066579-1-tzungbi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH] PM / devfreq: Reduce log severity for informative message
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com
Cc:     linux-pm@vger.kernel.org, tzungbi@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Suppose devfreq_update_status() failure in devfreq_set_target() is not a
critical error, reduces the log severity.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 drivers/devfreq/devfreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 7906220d025c..a525a609dfc6 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -382,8 +382,8 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
 	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
 
 	if (devfreq_update_status(devfreq, new_freq))
-		dev_err(&devfreq->dev,
-			"Couldn't update frequency transition information.\n");
+		dev_warn(&devfreq->dev,
+			 "Couldn't update frequency transition information.\n");
 
 	devfreq->previous_freq = new_freq;
 
-- 
2.34.1.173.g76aa8bc2d0-goog

