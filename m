Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F39340481
	for <lists+linux-pm@lfdr.de>; Thu, 18 Mar 2021 12:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhCRLXN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 07:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhCRLWx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Mar 2021 07:22:53 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965E1C06174A;
        Thu, 18 Mar 2021 04:22:53 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id n79so1551786qke.3;
        Thu, 18 Mar 2021 04:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=igLo7E1TqI8DXL9cfvgTwKgs58VUMuubou9K8KRZFhM=;
        b=WaCh3WJ9y8EJTc/fLwEV1mV1H/LQAwoNPpLd+KhYtkRFY1r4uJFJGuZgQAlNUI5Uik
         XA33guqUlOUUC5tgQdthAlPIUYtCgkAxSZZBzaB4y3HRKmmmjhFZjs9gk1heZYvhtxbh
         wf2WLf1A47+8ZXgpZi/1BAhSfAy6vm39cssZ5dF0NZUCWVxtOK+D6XRy31ZMH46QZt7y
         IElB103SYdrAmONSIEpqQzqlTtCP+CyPPDSVTO453ra32naZKnGeuX9FAe0igbr3HqDs
         pjS0hafS59eAwEaqY+SZPRY9Eksppy9ZJGjY+663fxIXMGU8Qy9ZMUZL6VYWINETKe+5
         GljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=igLo7E1TqI8DXL9cfvgTwKgs58VUMuubou9K8KRZFhM=;
        b=qpf2SYWdfEpBB+pbabgVbMYxAguEmy2w2y6QvKE2arFIgQCeI6BWFm348WR73Tw0Fh
         Q7QXvb972w6njOoiNKnmi5Sva7XnzSEDo951pn0EA8qAUNCnoWI0NTtOx/9SdbCPGKQ+
         KzTy/5x4ZE1wkc+QJMb9+fSDEe8FMUOTzR/uNrpRPAcWpFKWOnbBbYtZUBQ/sInMrWIn
         fX3eJLHI9oLAefmpEOkdaB814iff8dkJp3LLuzjjKBMZnO63ZkaE/k4x4wDQuZ676w/f
         lgBVr/gHi71YBpUz3Lobt361Tsu9uyswy+1MR0P8Q7/gEbD3418RsufHEwJtvCVQ8mCk
         +mzg==
X-Gm-Message-State: AOAM533Y5lP9QLmSjm6g0UsZnISKjHXHmoZjfL3+aPLjtyYIUh8BWZtw
        TpPdWM3ycSVB0XK0yZ7PQpk=
X-Google-Smtp-Source: ABdhPJytXZh2KZCwGHg2QIA+G/qW+BUqphxbM+XsrkQjzckb1wWvKO/s15VHDN/XeMY4HuLkqvLGkQ==
X-Received: by 2002:a37:4553:: with SMTP id s80mr3731449qka.167.1616066572921;
        Thu, 18 Mar 2021 04:22:52 -0700 (PDT)
Received: from localhost.localdomain ([156.146.54.246])
        by smtp.gmail.com with ESMTPSA id w13sm1200967qtv.37.2021.03.18.04.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 04:22:52 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] PM: devfreq:  Couple of typo fixes
Date:   Thu, 18 Mar 2021 16:50:25 +0530
Message-Id: <20210318112025.22755-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


s/stoping/stopping/
s/opeations/operations/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/devfreq/devfreq-event.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
index 6765c03334bc..2f841d7d9d8d 100644
--- a/drivers/devfreq/devfreq-event.c
+++ b/drivers/devfreq/devfreq-event.c
@@ -155,7 +155,7 @@ EXPORT_SYMBOL_GPL(devfreq_event_set_event);
  * @edata	: the calculated data of devfreq-event device
  *
  * Note that this function get the calculated event data from devfreq-event dev
- * after stoping the progress of whole sequence of devfreq-event dev.
+ * after stopping the progress of whole sequence of devfreq-event dev.
  */
 int devfreq_event_get_event(struct devfreq_event_dev *edev,
 			    struct devfreq_event_data *edata)
@@ -184,7 +184,7 @@ int devfreq_event_get_event(struct devfreq_event_dev *edev,
 EXPORT_SYMBOL_GPL(devfreq_event_get_event);

 /**
- * devfreq_event_reset_event() - Reset all opeations of devfreq-event dev.
+ * devfreq_event_reset_event() - Reset all operations of devfreq-event dev.
  * @edev	: the devfreq-event device
  *
  * Note that this function stop all operations of devfreq-event dev and reset
--
2.26.2

