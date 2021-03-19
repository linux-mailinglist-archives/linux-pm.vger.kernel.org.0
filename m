Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B62673412D3
	for <lists+linux-pm@lfdr.de>; Fri, 19 Mar 2021 03:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhCSC2E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Mar 2021 22:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbhCSC1g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Mar 2021 22:27:36 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1272FC06174A;
        Thu, 18 Mar 2021 19:27:36 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id q3so1472602qkq.12;
        Thu, 18 Mar 2021 19:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r3gQFACQh2J2voYdbNJbhk2x5hfKRQ+CwodIJFBLLlQ=;
        b=D+pwhdG+PGHcEsrNP/dfpimJNAx4nfhh12lcLCxSvnoc0HPoSyG4SjJLxM3q1IagdJ
         j/HbKS6aAoN8k8lYBqSSnSfzLT/ZZ0+2i+qbUgSazKKmu/piE88cbJKZBmnoAWhcBJ72
         9Nl+wZDHYNvSrVa8Jsu8fpV+2pGndfDoY+v447STh/abD8TsKfhznc0LSsjJx39FbHRx
         Of4U5la11acCkAWI+QuUG4nIKVGOfxrGZaIEV4eFwwI8/XRu29A3vsltbaJ0W9FnwYx7
         KOMNpQqAwWglqD+04KlPx+r1TnemF1S9OY73jONTzQBz//OocyBN0qaZXbVUQUsZJcxA
         EtKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r3gQFACQh2J2voYdbNJbhk2x5hfKRQ+CwodIJFBLLlQ=;
        b=lPfOJ1uVMFcZaTfbHioYA1R2nGSL0UYVe9zlk09R9LpEYt1mwQ/zyr0TP4v/2d6MSa
         B0I06R/4I6SM1OO75sudF4nMLBeIWzJ9g0S453oXPf4ebmMGvUTMDXKkwioH0tk95x+5
         C5GJ4P9KfxEVCvWE3QrHb1tuq0r5cxLu9u0xp7FGVzNjgJ0763zcXAPN8NyM02MG/0WZ
         Zur7qK7jj9hvMbgQB35RbDJXhkQ6DlHHtHSzgyBLip2QDhwci6udsy6+aEXhRD0ZLo/9
         WgamZ21A6pHq4TInxM2b0HLfjdxnClZje0RH7tyXVWPc6J5DuHtULYLoxaCFv9HpQCJV
         /P7Q==
X-Gm-Message-State: AOAM531rqTQyulihNLLv1rDFaLAcFuYKm7t4bZU323mac18x4Lb4vXc7
        tbAWOt4nwCdZ5y6BNPsEvgM=
X-Google-Smtp-Source: ABdhPJy6oti7JVZmuM/u6IKcBhsExqWFVLcxTxAp6GtYiHE1339H5lXW1yhBwpkf92CY6cR0HXc+wQ==
X-Received: by 2002:a37:8905:: with SMTP id l5mr7679827qkd.321.1616120855354;
        Thu, 18 Mar 2021 19:27:35 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.87])
        by smtp.gmail.com with ESMTPSA id o7sm3460814qkb.104.2021.03.18.19.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 19:27:34 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     cw00.choi@samsung.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] PM/devfreq: event: A typo fix
Date:   Fri, 19 Mar 2021 07:55:21 +0530
Message-Id: <20210319022521.20663-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


s/devie/device/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 include/linux/devfreq-event.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/devfreq-event.h b/include/linux/devfreq-event.h
index 4a50a5c71a5f..2489d11e0513 100644
--- a/include/linux/devfreq-event.h
+++ b/include/linux/devfreq-event.h
@@ -56,7 +56,7 @@ struct devfreq_event_data {
  * @disable	: Disable the devfreq-event device.
  * @reset	: Reset all setting of the devfreq-event device.
  * @set_event	: Set the specific event type for the devfreq-event device.
- * @get_event	: Get the result of the devfreq-event devie with specific
+ * @get_event	: Get the result of the devfreq-event device with specific
  *		  event type.
  *
  * This structure contains devfreq-event device operations which can be
--
2.26.2

