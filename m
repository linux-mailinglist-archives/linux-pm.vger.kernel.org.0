Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB7F630B306
	for <lists+linux-pm@lfdr.de>; Mon,  1 Feb 2021 23:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbhBAW6V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Feb 2021 17:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhBAW6U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Feb 2021 17:58:20 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1551FC061573;
        Mon,  1 Feb 2021 14:57:40 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id m22so25166602lfg.5;
        Mon, 01 Feb 2021 14:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UNajX5UMrbnSG6Fhci3CxkEOGk0tBEGF42Ela8560Tk=;
        b=p8VQaPLMnmqiEjs0ut449xBUdX/7teONVrKGqE10nq3ZNH8tul7mTRtVN4XMSvIf8b
         po/VvPp8Su8zI6nXc6CmkujmL0ggbhQfl3DFbi2QlSMqqjjCxZmgPBKwb1OZta0D63Cp
         boorR2IVtRKeY9YcEBessj49VFFZIMCsbrdesTfhbSPjit7kbyXVMmXiqmXONu60St5A
         0maGy0jHMkLkwBZsgfey2AcZwv1Atrv9WFGsjSNacuLKnXC3vvKClePUITEuqi22bgK4
         5qED2vu+SgjdmY5soj1Niha+2aJJ0nPMay/G7FmmhCr4EJ9NJ/DA/05R1+IRCbnaewIC
         F4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UNajX5UMrbnSG6Fhci3CxkEOGk0tBEGF42Ela8560Tk=;
        b=e9OMFREIyE/o+TpFZgKeT/AjrcCbjvsKq9wdflycsEPM+Zx1F66bfDggOFxByAFp3l
         kKaPMbjp+DK9X+xL5mGs3pCLCEEJf8uworlffQLLZtQtSxZk3WICEF28U+ATkIXQvBky
         4B2XRckaf2pFL+Dbyu73ZHulOi4kLDOkVFx06f4odLOrez8gfuvLRo/C2C/tTiltxENF
         ctEYkFR9OwZU8yb03x3oiRJOitDWBZNLF8XgeX+cL5S3qBQHXUEjbqQC2VQw6tjQZJd8
         QAq+JSVN2mccof0E9LINQa0Qp2vrcmDthXSUpL+qw8xJ/oZipTQl7NGrYS5V5nZcyPP4
         OhgA==
X-Gm-Message-State: AOAM531NrG8D08wZ/29g3pmUanNa0P+MUtm/rJbUvRMJssYqTyUbfj1P
        HNt6BsEWAAQHIzwWaPTBEGM=
X-Google-Smtp-Source: ABdhPJxv7UL9syEhm1ffk2mXyjn9923gfgEjJq2a/MZlyuXDpAGLJciG/llvqOqDNv7BDOA3jUxBDw==
X-Received: by 2002:a19:8156:: with SMTP id c83mr9728619lfd.546.1612220258642;
        Mon, 01 Feb 2021 14:57:38 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-164.NA.cust.bahnhof.se. [158.174.22.164])
        by smtp.gmail.com with ESMTPSA id c9sm4060727ljk.130.2021.02.01.14.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 14:57:37 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] PM: Constify static struct attribute_group
Date:   Mon,  1 Feb 2021 23:57:35 +0100
Message-Id: <20210201225735.86163-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The only usage of suspend_attr_group is to put its address in an array of
pointers to const attribute_group structs. Make it const to allow the
compiler to put it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 kernel/power/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index 0aefd6f57e0a..12c7e1bb442f 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -387,7 +387,7 @@ static struct attribute *suspend_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group suspend_attr_group = {
+static const struct attribute_group suspend_attr_group = {
 	.name = "suspend_stats",
 	.attrs = suspend_attrs,
 };
-- 
2.30.0

