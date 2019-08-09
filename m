Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59A26872C0
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2019 09:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405742AbfHIHK3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Aug 2019 03:10:29 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44640 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405700AbfHIHK3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Aug 2019 03:10:29 -0400
Received: by mail-pf1-f194.google.com with SMTP id t16so45513437pfe.11;
        Fri, 09 Aug 2019 00:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+d5t4lkL11qOJSaV7yGOJ7opndkU1RYl3l6/bnKTaps=;
        b=qH5p+7EfZpTvCWXaJf2rQvToIJyY8fGExGFmXTWpW5LIVKzGfBWCRmwMR2P8Fe5PtD
         A1ROzvUb5xtCtgIZWZMI47N96t7XZcSxPnzPuHEVHc9/yGElAVR/sJiKQ7YkNIwNokSe
         mcCFjFEnhiqVQkmFo29/MsJhaZlYT7Yq/FWGaMcyaCG0x4VJuNH9SCq+4WZufLWeCTwG
         x7NPB7A6zKoNu4FuPEZMLmrzOd3VHnO8mUk243wLLyG9m0333TNM0Xr9h2Ff2dXFnikw
         jMHp+qpVA8fYv38qUZN/vio71FYepuG48RrF+sxDKTkLBHO9qosk19mbNxj4JPar7Y6b
         N6VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+d5t4lkL11qOJSaV7yGOJ7opndkU1RYl3l6/bnKTaps=;
        b=W6TyL1vBBjHDGBwDtmhhNaj39r2oemrWzuCMGx28H7WxmIR43Uuu3pTgR1p9De065w
         ppOHPkNt9T57DTIkBa/AtB31ZOExE8WyGzi0+BCkTQLY1Qo74XMbN1zeLN9j3cK0vKl+
         eBPSRD3r7/UC4U3u16ssnxJzOb3tdhPFBzAt7x85e/2zKfIdywLVEJLVCrW6TL1Q7LmM
         YtaoLQ+czjKU0Ru4usKjNgOc8QFjSOw15Wc+guQdHxq+c05sKe4kCfn9XRW2SO3Gl+9w
         XTMAz/0sdVqc0P7NJr3uvCiGxyUBtFVox77ELhsiVmrITK+GYnQUvJDKfATwLbwlQh/S
         DIsw==
X-Gm-Message-State: APjAAAWTPCQrz+a6ItXaSoFX2pKbmqjC9IcMfQbDUTbrM7imvTlbpi7w
        T1fYeBimemHLJfDkVUnHFeU=
X-Google-Smtp-Source: APXvYqwoxMyVhTYXNckZ8XJ4rP4tbgD7QG8BKGKz2vfkXe00sq5sM/L1h8plQl5Sn0hdxRO24258Uw==
X-Received: by 2002:a65:44cc:: with SMTP id g12mr15990426pgs.409.1565334628486;
        Fri, 09 Aug 2019 00:10:28 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id x1sm514293pfj.182.2019.08.09.00.10.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 00:10:27 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v4 3/8] PM/sleep: Replace strncmp with str_has_prefix
Date:   Fri,  9 Aug 2019 15:10:23 +0800
Message-Id: <20190809071023.17224-1-hslester96@gmail.com>
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
So we prefer using newly introduced str_has_prefix()
to substitute such strncmp to make code better.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
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

