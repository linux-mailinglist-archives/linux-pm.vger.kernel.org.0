Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8286129AC61
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 13:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408999AbgJ0Mnb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 08:43:31 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:46624 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406492AbgJ0Mnb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 08:43:31 -0400
Received: by mail-il1-f193.google.com with SMTP id a20so1334925ilk.13;
        Tue, 27 Oct 2020 05:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/heI+LfLgziLGJ60RM8gGheob87eQ914pvQOUOMmLFQ=;
        b=lZsMreU9ST2gn3t4bSN3hBbKtesDEZtmhJU2DsroyfZ5d8/X04EF1y89wrsZFnP8au
         VF+NyzzsAVfUXrd1JAWwG2PAHNEnwyPsIDc1d7+LhL2J+7bOFCVDlVrdSF+L14KE8WNq
         HywBiQuDj5C8KQ7N97vKzxV1EAfetY5RBakaGeeosJwHZz9TkIe+qouCgDDwiYoAf919
         o4BWXWtmbge9X8+/lxzAuSt/w+obcUTKbkiJ9pwutp+dvqt3waXiAkRJgDpX7CqtW1gW
         L5bjb5PljJYZMtcs8TL3V/RKj++8FkgHwLpdgXdJaXUsJc7KtV+ODWhKlobR65FfR9Ss
         3TEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/heI+LfLgziLGJ60RM8gGheob87eQ914pvQOUOMmLFQ=;
        b=gD/vPHyCP++K+C/M544hUgSOhP5AkGElAYLopf351a/FSusgCahzTz7btC7QL6Tead
         XkpmnN83nkM/jygaDvH9QoDyskMLm48fisN4Dk9ZnWD2pS7O+V2pe8KtJ+8lqVpVDaJ3
         w2TdUm5qIY71SZXbTQz+2exefwL2yY0pofX/5OpsttbuLHZUWveXmRmgSwwktgH37ozc
         lc72tCwtmqGbM9o8wcuRug8MRUOOu5VRrf4ppcgRh/YvJ699qscTqmcByNY6/lO/hUUp
         a3eYyPv+knZxIA5hLu6kiCk5V/VzL3Y/YJmhxqnz7yiRx9lXI3B5SqiExVDvFrMcV3z8
         CmZA==
X-Gm-Message-State: AOAM5336GqY3N6EDbXdUmqvhN+G6UN7403zAP4/3j1lKVlTGUgewVKKY
        +O6d7TOt91NvsE+oh/7MAinZP0qGLGrzkobc
X-Google-Smtp-Source: ABdhPJwXtb2mxLksz1l1pGSuod4wpwFnPkIp2B6PQQOKjLTghLCdw51dW6f1uAsZPungR0lmNdMatQ==
X-Received: by 2002:a05:6e02:60c:: with SMTP id t12mr1518702ils.297.1603802609130;
        Tue, 27 Oct 2020 05:43:29 -0700 (PDT)
Received: from penguin.lxd (c-24-245-2-95.hsd1.mn.comcast.net. [24.245.2.95])
        by smtp.gmail.com with ESMTPSA id y26sm834030iol.24.2020.10.27.05.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 05:43:28 -0700 (PDT)
From:   Jackie Zamow <jackie.zamow@gmail.com>
To:     rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz
Cc:     Jackie Zamow <jackie.zamow@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] power: fix typo in kernel/power/process.c
Date:   Tue, 27 Oct 2020 07:43:19 -0500
Message-Id: <20201027124319.1448-1-jackie.zamow@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch fixes a typo found in the function freeze_processes()

Signed-off-by: Jackie Zamow <jackie.zamow@gmail.com>

---
 kernel/power/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/process.c b/kernel/power/process.c
index 4b6a54da7e65..45b054b7b5ec 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -146,7 +146,7 @@ int freeze_processes(void)
 	BUG_ON(in_atomic());
 
 	/*
-	 * Now that the whole userspace is frozen we need to disbale
+	 * Now that the whole userspace is frozen we need to disable
 	 * the OOM killer to disallow any further interference with
 	 * killable tasks. There is no guarantee oom victims will
 	 * ever reach a point they go away we have to wait with a timeout.
-- 
2.20.1

