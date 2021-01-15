Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B5A2F89B0
	for <lists+linux-pm@lfdr.de>; Sat, 16 Jan 2021 00:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbhAOX6V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Jan 2021 18:58:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31855 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727954AbhAOX6U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Jan 2021 18:58:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610755014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8BoaeYSbnhYHGMsWAgpt+dfteZsuHNcO9/b1daInITU=;
        b=Byc2f/WOvSV/1FJfDUbKFUjiepJ0yiqyoApqZucdC/rbBJxef4iDKtaeogbYkTISbBndot
        OsB+EsOsIIZkqRTM0ZIigpAXeCDaxuZHNR/1nK8CVevXrhH7dFQc4mkwi/UYNzdDE1p+u8
        O7r4DUE8JCG9553RnxodPJ2fkaZbEJY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-DuoO5ET6PNOIGiMyqjiGOw-1; Fri, 15 Jan 2021 18:56:52 -0500
X-MC-Unique: DuoO5ET6PNOIGiMyqjiGOw-1
Received: by mail-qv1-f71.google.com with SMTP id t17so9232859qvv.17
        for <linux-pm@vger.kernel.org>; Fri, 15 Jan 2021 15:56:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8BoaeYSbnhYHGMsWAgpt+dfteZsuHNcO9/b1daInITU=;
        b=Q5X3lc825ZCiI9pTyxF0HajCe27EeIxsH2A9rkhZ8rsOzFW/h760B0vj5wpa5Mbg8L
         GUZ/eRPhqX+OGjCJl/4tHhQ1O0pylj3az4XAH/g3Zuoan2scxkTFBom7iPGO/YjLurnu
         qWdnCGgBMutF41XQf0x0q5o44Yg4cmjEGF1GAKenv8VJRCXgmq3xt0ENkYozRxgzXeW7
         U3AZnkvtkxwqzSq5HebTaSRsrEf/frIg1dZyn5OepuIhfbEaS3jotPo7kdD71xXpWX/G
         9s8ZQI9XE/PGSMu2kRszylUDhuiZ730k/V8EZcf/N2wSOqtsCi8G4r9HIpT09Uazh2zh
         r16A==
X-Gm-Message-State: AOAM532LDUwgFvVwz1ig1GTupoDRFC8bdaK1h1M/ReKlm6sotwDuTygW
        uzK5zzYiYy56WKvUDezml32TZqXLR7Fi/HoWtnWPR3gWnQXhBW2f9hyoALpnZ2kOMR3p8drLWw0
        3th+6gZojJCnlO3rw/gI=
X-Received: by 2002:a0c:d403:: with SMTP id t3mr14890953qvh.4.1610755011963;
        Fri, 15 Jan 2021 15:56:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxjKSLexl7Fp6MgKjz16sscMkGaxTgQOsQ1o4HAxGadnjYl7TlbGw+xYpjqr7eylu8ADlekUg==
X-Received: by 2002:a0c:d403:: with SMTP id t3mr14890942qvh.4.1610755011823;
        Fri, 15 Jan 2021 15:56:51 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id m64sm6010151qkb.90.2021.01.15.15.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 15:56:51 -0800 (PST)
From:   trix@redhat.com
To:     jacob.jun.pan@linux.intel.com, lenb@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] intel_idle: remove definition of DEBUG
Date:   Fri, 15 Jan 2021 15:56:46 -0800
Message-Id: <20210115235646.290819-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Defining DEBUG should only be done in development.
So remove DEBUG.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/idle/intel_idle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 28f93b9aa51b..3273360f30f7 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -37,7 +37,7 @@
  */
 
 /* un-comment DEBUG to enable pr_debug() statements */
-#define DEBUG
+/* #define DEBUG */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-- 
2.27.0

