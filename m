Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB3B292F18
	for <lists+linux-pm@lfdr.de>; Mon, 19 Oct 2020 22:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgJSUDn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Oct 2020 16:03:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45751 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728542AbgJSUDl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Oct 2020 16:03:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603137820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=F3+eVVhD9pRO1Lc4WB7w+1NvqWHmj8ke9+eowsdGJTU=;
        b=ejWQKpFQG8xKIPLSPSGPz3eht2VzCxukEkWsCRzK2tCGmSFxUxrPsOoJJycXtVcXxSshAN
        nukK9Z9dkWb++LRQBSMtLIDHLSXwxq1IAp0oYHcWu+AytRWIpMZIMwmm4GVX2HmUAQ1VxX
        djq1yjfEYQMZj3/I7eQqO0M/l2onq+o=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-xd3tQLTWPEq_1fJejtsN_Q-1; Mon, 19 Oct 2020 16:03:37 -0400
X-MC-Unique: xd3tQLTWPEq_1fJejtsN_Q-1
Received: by mail-qk1-f200.google.com with SMTP id b7so542482qkh.20
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2020 13:03:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=F3+eVVhD9pRO1Lc4WB7w+1NvqWHmj8ke9+eowsdGJTU=;
        b=AGoggyG87cwCnF8HEV8KD8k9kKvMwRkYbK8RsZQVDhm0NyIOQSKgTqS0CUTM3NWeet
         s2l3z9WzjdtJt179tbQrmvHbNmfBvtte2adH1OEI71ImJPSt4J1KcLlwUux2D93w2Gjg
         YFxjntPf37V7PnZXo3tY4hrvBFLBQCuis1bqXqQBKdE9kIqB9775jzhleA2MEMzLu0IV
         7xFGOGtDSJdv2VvyoSgJ4ULnJjACHbX+A3yFozO8t4KHz93IOvkXaf2DNAZY0bgkT25R
         n7Hdlf7IYYyrGWvwXRkpy4Q42SySIH5sB76fLQF0Cz57Jb+Lqtf0KqEO8SR1k/+XIIJ8
         cXhw==
X-Gm-Message-State: AOAM530kXZ2mYTeRNzc5fig3bCFNis6KEwih/gO/UkqTpD9IGdnTmdrA
        IfJdYkiaDAbklOk2zSgW1eDhuk3K9oHgFsUAOjszq+xEAKTOc89mor4o1l5nrNNno83nEaPGOnO
        Hzen+oxWdLKdTwb3vwyw=
X-Received: by 2002:a05:622a:208:: with SMTP id b8mr1115067qtx.101.1603137816586;
        Mon, 19 Oct 2020 13:03:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXb/rxXb4baPbjkHkFnR27pl71Et9H9wJy5V10S3g9lhcLq1MOxErN1KlNZHkIc8VzD/YJ0A==
X-Received: by 2002:a05:622a:208:: with SMTP id b8mr1115049qtx.101.1603137816368;
        Mon, 19 Oct 2020 13:03:36 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id e19sm451471qkl.94.2020.10.19.13.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 13:03:35 -0700 (PDT)
From:   trix@redhat.com
To:     rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz,
        gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] PM: sleep: remove unneeded break
Date:   Mon, 19 Oct 2020 13:03:30 -0700
Message-Id: <20201019200330.16629-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a return

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/base/power/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 205a06752ca9..c7ac49042cee 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -363,7 +363,6 @@ static pm_callback_t pm_op(const struct dev_pm_ops *ops, pm_message_t state)
 	case PM_EVENT_THAW:
 	case PM_EVENT_RECOVER:
 		return ops->thaw;
-		break;
 	case PM_EVENT_RESTORE:
 		return ops->restore;
 #endif /* CONFIG_HIBERNATE_CALLBACKS */
-- 
2.18.1

