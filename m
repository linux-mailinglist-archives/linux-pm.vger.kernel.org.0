Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA21F424D01
	for <lists+linux-pm@lfdr.de>; Thu,  7 Oct 2021 08:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237220AbhJGGGL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Oct 2021 02:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236997AbhJGGGJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Oct 2021 02:06:09 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74736C061746;
        Wed,  6 Oct 2021 23:04:16 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id p4so4986436qki.3;
        Wed, 06 Oct 2021 23:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VM/3QqT61sEu6/tGSpWiy3SXMXIkh6EIpUzphFMdS6s=;
        b=SI7tM5D90t1doaIZuK+x0lCkecGfwH/buE9WdfWMP0wHreV9DiYhU7aM+6EDow56zJ
         S+AtGbjt8+0w73TVLkM33MOfJZJfTI72r3kJqirGE1D1JgGnbggBpdMCnnO/OWnn32aD
         4NoPSl+abAqx4rTLIQ3ODiniUACsJNfurv6Qt9mqH8Ow6bBgyz6YVeEUnxeV/BDjfJ5U
         mYhL8WlAub40VVSnXkgTd/2AhK8z1fu698jtV0HuBcAuteGQGtZQ6a8gYv4L4YfwPq9C
         r0gaoqREI/t5YAKhLunNCAjk6AcPhonbZOQ2mJSTA5FpmsjLkjUncFRAum1aNU/Kf8XG
         cU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VM/3QqT61sEu6/tGSpWiy3SXMXIkh6EIpUzphFMdS6s=;
        b=tTSSePcdFLGDGisKwTG3QJqRUXdgwM1u+0QN76gqgAWyKZl2Gkwni3un0yF2W71169
         SKgyRmtPqL/uMM56eG7fwYJlmZZHIewAdrLYqKoaL9NdFWvpSs7MATZ5Uq4ZZAAH/Q5d
         P0cMw78f6BIIEUb17W7N78+VTEmtzHZD8icuvnIu8+oWUJvVtKVIxHS82wX0UGIo0UlS
         wB6f89ogB8ey12dojpnYPm9PxQdtx2FOhuyOs88HmklBPsFC6zV0DNnZ3xKqboH3llt3
         rWqewhh/GGB6rs58QdsPUHbBRC6bIkb/STEiB+rWoU43eOyyG772uvsl/t56PfccKJ1k
         CGlA==
X-Gm-Message-State: AOAM530TrCObaKpd2FNAF2/OGHgmqfBtUXZNSgIy2Eoe4XSNI9rA89Ey
        3lgC/WspWe7NhUGCZR9HbIlL1Eu62gw=
X-Google-Smtp-Source: ABdhPJz2tgUx/RBVJ2NREFJxdllSwwqTwVQ4NsAcTwz5lpnULdJBLqzVSULU0El9cZA9nmlilFm49w==
X-Received: by 2002:ae9:df45:: with SMTP id t66mr1836886qkf.335.1633586655677;
        Wed, 06 Oct 2021 23:04:15 -0700 (PDT)
Received: from localhost.localdomain (79-139-163-57.dynamic.spd-mgts.ru. [79.139.163.57])
        by smtp.gmail.com with ESMTPSA id x79sm13235042qkb.65.2021.10.06.23.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 23:04:15 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v1 1/6] notifier: Add blocking_notifier_call_chain_empty()
Date:   Thu,  7 Oct 2021 09:02:48 +0300
Message-Id: <20211007060253.17049-2-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211007060253.17049-1-digetx@gmail.com>
References: <20211007060253.17049-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add blocking_notifier_call_chain_empty() that returns true if call chain
is empty and false otherwise.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/linux/notifier.h |  2 ++
 kernel/notifier.c        | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/notifier.h b/include/linux/notifier.h
index 87069b8459af..f0b1d600d9f6 100644
--- a/include/linux/notifier.h
+++ b/include/linux/notifier.h
@@ -173,6 +173,8 @@ extern int blocking_notifier_call_chain_robust(struct blocking_notifier_head *nh
 extern int raw_notifier_call_chain_robust(struct raw_notifier_head *nh,
 		unsigned long val_up, unsigned long val_down, void *v);
 
+extern bool blocking_notifier_call_chain_empty(struct blocking_notifier_head *nh);
+
 #define NOTIFY_DONE		0x0000		/* Don't care */
 #define NOTIFY_OK		0x0001		/* Suits me */
 #define NOTIFY_STOP_MASK	0x8000		/* Don't call further */
diff --git a/kernel/notifier.c b/kernel/notifier.c
index b8251dc0bc0f..1f7ba8988b90 100644
--- a/kernel/notifier.c
+++ b/kernel/notifier.c
@@ -322,6 +322,20 @@ int blocking_notifier_call_chain(struct blocking_notifier_head *nh,
 }
 EXPORT_SYMBOL_GPL(blocking_notifier_call_chain);
 
+/**
+ *	blocking_notifier_call_chain_empty - Check whether notifier chain is empty
+ *	@nh: Pointer to head of the blocking notifier chain
+ *
+ *	Checks whether notifier chain is empty.
+ *
+ *	Returns true is notifier chain is empty, false otherwise.
+ */
+bool blocking_notifier_call_chain_empty(struct blocking_notifier_head *nh)
+{
+	return !rcu_access_pointer(nh->head);
+}
+EXPORT_SYMBOL_GPL(blocking_notifier_call_chain_empty);
+
 /*
  *	Raw notifier chain routines.  There is no protection;
  *	the caller must provide it.  Use at your own risk!
-- 
2.32.0

