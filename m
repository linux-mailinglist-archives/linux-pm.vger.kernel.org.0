Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5327E7A2
	for <lists+linux-pm@lfdr.de>; Fri,  2 Aug 2019 03:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731827AbfHBBrS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Aug 2019 21:47:18 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35333 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728937AbfHBBrR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Aug 2019 21:47:17 -0400
Received: by mail-pl1-f196.google.com with SMTP id w24so32979849plp.2;
        Thu, 01 Aug 2019 18:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ONZiznhobYR+f5xk60p2BwYZtKTcGSGm/L1sszvHa2c=;
        b=TRwPM+KQM9hE3nz0Nhu2Q2geO1Z6+GeIrltAOcRiZRZ16xzPajdJ36LhQc83SUVEjL
         p3Qm2WOq7cixmqukHdJfVdBXu9+iZpFzOkelpo6ZWhzEdxgcTw/AeIDnUl+bpIWTqsyF
         Mk3nm1PEAEGLiS2tYKhUNLRIh0PRuxQJWiH+9YFsLLhsPcxlbDfM4393ttL/0MMOs62o
         xe/CiGHP+hY30hmPCgYYEszh9WfFdudsng0ElgrcU7tC24OHu57HwsxVV/E9klgA+nm1
         bDysvl1J+lkbrb8wlwMI2Dpy2++wWc6u7242Y3xjYvzCSJO/gpYKm6qo3g2ED3LvVTzp
         uq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ONZiznhobYR+f5xk60p2BwYZtKTcGSGm/L1sszvHa2c=;
        b=MT0Qb4Y4AEskMbnxnea/pGXtjEDNtGDXjxMAXqlRw87FU4qgQMJMHtNQlWIr3R9M+E
         6PXtXQT1wraMlWnspKLbyOrbdwAXFAy7bHFBIGX4pnQxDqnSKLj4b0abpD1+PISE3qFY
         Zot5ZQQh/BvBomshS4sZ0TOLi/GtLmCHTXWYYf4B7QeBa/1/frDpm6oIThCJVvFo8G6w
         HxyfhwOyU3DUqWPcAS5tPOstzDqK6h6AePJ68C6iHqQodF49+OrGn4eavudE/tp+VKeA
         hTa03L59E1pylE6FqWphkFrEwsVspxhjkJgHeLQyc0cInSLJMksp7GEKav9E2YnEGrmb
         f4kg==
X-Gm-Message-State: APjAAAW7GfSN2G83GgJz4bfZ75rwoSqFOG38E9hhiznVHpXYpW/tlbT2
        GF95lpvbI01lH+FCcgF2H6Q++xzHM7xGAg==
X-Google-Smtp-Source: APXvYqzfhjAOsNI8Is63Vl3EsVVe5PbFpcP6ek6kbP90u57/p2+K5PgMVuApyVDGaDGeLBl32TlNCw==
X-Received: by 2002:a17:902:2ae7:: with SMTP id j94mr128750572plb.270.1564710437181;
        Thu, 01 Aug 2019 18:47:17 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id b37sm11498552pjc.15.2019.08.01.18.47.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 18:47:16 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v2 05/10] PM / sleep: Replace strncmp with str_has_prefix
Date:   Fri,  2 Aug 2019 09:47:11 +0800
Message-Id: <20190802014711.8898-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

strncmp(str, const, len) is error-prone because len
is easy to have typo.
The example is the hard-coded len has counting error
or sizeof(const) forgets - 1.
So we prefer using newly introduced str_has_prefix
to substitute such strncmp.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v2:
  - Revise the description.

 kernel/power/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index bdbd605c4215..5e5f64bb3a43 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -495,7 +495,7 @@ static suspend_state_t decode_state(const char *buf, size_t n)
 	len = p ? p - buf : n;
 
 	/* Check hibernation first. */
-	if (len == 4 && !strncmp(buf, "disk", len))
+	if (len == 4 && str_has_prefix(buf, "disk"))
 		return PM_SUSPEND_MAX;
 
 #ifdef CONFIG_SUSPEND
-- 
2.20.1

