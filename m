Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1AE1D216A
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 23:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbgEMVqv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 17:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729994AbgEMVqv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2020 17:46:51 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBFCC061A0E;
        Wed, 13 May 2020 14:46:49 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l18so1319283wrn.6;
        Wed, 13 May 2020 14:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GJdGXsHD0zUd2QbzbW/I0cKeP4IeBGCB2rpC+2MAeZI=;
        b=bdantqXwbJZtRf8K1mYSwY3s0rsnkVOn4KOdiGMmYTUs2SRGH3Jv8v3lfKjmVpKb0D
         dq+FPq86JI3gIcoKzUP72wPP275IDQqCyyRzzT29Cg8g61hXhvCo+Wu3kAFP2fv5wWre
         V7KVHZzm1R9X4+9eZLkyH86XAgi+HzvJ8nf1b050sHdvLfNZWcBZw96lLSpiVhW7MLae
         ts42GPrel78Xz6ct/586YopmRohDVkg+pQlWMfmWz067xJv8WxBGOk66DgtySkRuUEga
         xxjCqmxTf59JQK+NYgzHnegqg+aUHIA/7WfBrp9NoHOfdUKH8hsydlFTyWhHiZOIEdEg
         DoXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GJdGXsHD0zUd2QbzbW/I0cKeP4IeBGCB2rpC+2MAeZI=;
        b=fxLFN0DdUcUXyauGVIU6z58qU4Tuvgkyv7jiXhNDHevhqjiWMEHK7lUyO2Vbqvfy+Z
         l3r2BE4jxMWD6iOLpINFaAm3HARBhVHubtVAtjadWbPfx4rYhpKSAafXv/2bMtdC7bO4
         WgVsYZ98lNKUqRjhHxRcKvJKg2WFJlQwN2Lw5yig95UN9CIjWF0YMWi+KA49C9WKn93X
         xwq/rH1wPFgYa/GcFuar2yUUPfHLbBXeefsg/UPyNkOGRyYrSku2x27BGsIBsHMBg3rO
         BU4H2DUjTA32658W55FITgaCntCAU2oynm4wnSq7FeDSzO+RXLBexVSkBHeDaChUSG/T
         kTwQ==
X-Gm-Message-State: AOAM533w2fjaibEcFhWRAG21y9D2qgSfuuyF0d7gz3DG9KjZmw40jjyP
        uPE7viWd17M50MTt7zr3ijc=
X-Google-Smtp-Source: ABdhPJwOW0a96inUowDYevyxA5bBc6FGdx6sWbOmF82NP31eWee/F6lJtgBgJewXU8AVUAr+23bjgg==
X-Received: by 2002:a5d:684f:: with SMTP id o15mr1481873wrw.89.1589406408323;
        Wed, 13 May 2020 14:46:48 -0700 (PDT)
Received: from localhost.localdomain (cpc91192-cmbg18-2-0-cust374.5-4.cable.virginm.net. [80.6.113.119])
        by smtp.gmail.com with ESMTPSA id m23sm1699734wmg.45.2020.05.13.14.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 14:46:47 -0700 (PDT)
From:   Emil Velikov <emil.l.velikov@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     emil.l.velikov@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: [PATCH 10/11] kernel/power: constify sysrq_key_op
Date:   Wed, 13 May 2020 22:43:50 +0100
Message-Id: <20200513214351.2138580-10-emil.l.velikov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200513214351.2138580-1-emil.l.velikov@gmail.com>
References: <20200513214351.2138580-1-emil.l.velikov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

With earlier commits, the API no longer discards the const-ness of the
sysrq_key_op. As such we can add the notation.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
Please keep me in the CC list, as I'm not subscribed to the list.

IMHO it would be better if this gets merged this via the tty tree.
---
 kernel/power/poweroff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/poweroff.c b/kernel/power/poweroff.c
index 6d475281c730..562aa0e450ed 100644
--- a/kernel/power/poweroff.c
+++ b/kernel/power/poweroff.c
@@ -29,7 +29,7 @@ static void handle_poweroff(int key)
 	schedule_work_on(cpumask_first(cpu_online_mask), &poweroff_work);
 }
 
-static struct sysrq_key_op	sysrq_poweroff_op = {
+static const struct sysrq_key_op	sysrq_poweroff_op = {
 	.handler        = handle_poweroff,
 	.help_msg       = "poweroff(o)",
 	.action_msg     = "Power Off",
-- 
2.25.1

