Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE844DE6F
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2019 03:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfFUBUQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Jun 2019 21:20:16 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:50430 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbfFUBUQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Jun 2019 21:20:16 -0400
Received: by mail-pf1-f202.google.com with SMTP id h27so3234503pfq.17
        for <linux-pm@vger.kernel.org>; Thu, 20 Jun 2019 18:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JqSAbEGn1HiZP7c6GcuMsV6mwVA+ao3NtmgYDy/YB50=;
        b=uAl+pb5UgR8qbNWvTqgNyUdGrjYg0S8BfztU1IaK3wSoovw9zlPCjs+fxR/Zldidjt
         wn9jEjHX6zhp2cY/ATrv0Ui2iFYIO/84hN6Y9U0zSrxpdUGNw4l6ofnhy4DW6H1w1REh
         e7xaSuXohECGbWYKz7+urb02nPjB4dMxHHraE2pgWMJeOrKlP6Brq6ZYzgnti8M6knOD
         M5dofE5spcg4W1bE+A2c24KQml7+KGHeAK64yt51wq5qc77KvrpFdOMYA4aIUfufBhW/
         VF40DkSCXitcpI+sAdK9CQdmQyjHL8QEx8o56v+XmnMnicC0CjNjNkw0OspKK1lBtU/2
         MRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JqSAbEGn1HiZP7c6GcuMsV6mwVA+ao3NtmgYDy/YB50=;
        b=OYdhGdr2xsN/dfjStGRM60NXfhhusGlgL7ytxPTx0O/sM1J02PY6j3juR9abbYoe0T
         Pawnq+4enuoVZ4ntfG7p+jzDqE+k7tL8Ox8xiq2r8ZJsQqMOM5HBpTWrJ11zpMT8YMmp
         50XAghSzTLNOPFevup1yrHsHZda2lRS0NycTvl9EoYTxG4BVPjoW8XEx2aECfhIGTuV/
         1yEmqDvdfT8AG500M9fSrQggduMf0HHRwkVxSJ5Cm6Q7DepCWqFgQwuKImP1EcTM+RQu
         nTZxyCWURWgMachypHdZ7NAKtyzAh1aqT3w/S+8nNoeHk8qurQpj1BpJ8sNnpKCl9PfX
         PxRA==
X-Gm-Message-State: APjAAAUq2TggtdpBh+Zv602ia1XUk2KFCmb4H8fb750W0hyj1AV7PBYn
        j3jEF+gATW6nfN37RmO4CvMKz8OjSJuA+eIaWAKLvQ==
X-Google-Smtp-Source: APXvYqwT26wVJK6nFrq7e+H8nLKZxTkGEC6Cm+2MlyXrmHTpSaeB1v4qyUV96R/qlEsGT6gqXZ46YMXwlQeXlC7AVr9xzw==
X-Received: by 2002:a65:5006:: with SMTP id f6mr10257389pgo.402.1561080015411;
 Thu, 20 Jun 2019 18:20:15 -0700 (PDT)
Date:   Thu, 20 Jun 2019 18:19:22 -0700
In-Reply-To: <20190621011941.186255-1-matthewgarrett@google.com>
Message-Id: <20190621011941.186255-12-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V33 11/30] uswsusp: Disable when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>, linux-pm@vger.kernel.org,
        pavel@ucw.cz, rjw@rjwysocki.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Matthew Garrett <mjg59@srcf.ucam.org>

uswsusp allows a user process to dump and then restore kernel state, which
makes it possible to modify the running kernel.  Disable this if the kernel
is locked down.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
cc: linux-pm@vger.kernel.org
Cc: pavel@ucw.cz
Cc: rjw@rjwysocki.net
---
 kernel/power/user.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/power/user.c b/kernel/power/user.c
index 2d8b60a3c86b..8a8d7f1c8fbb 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -24,6 +24,7 @@
 #include <linux/console.h>
 #include <linux/cpu.h>
 #include <linux/freezer.h>
+#include <linux/security.h>
 
 #include <linux/uaccess.h>
 
@@ -52,6 +53,9 @@ static int snapshot_open(struct inode *inode, struct file *filp)
 	if (!hibernation_available())
 		return -EPERM;
 
+	if (security_is_locked_down(LOCKDOWN_HIBERNATION))
+		return -EPERM;
+
 	lock_system_sleep();
 
 	if (!atomic_add_unless(&snapshot_device_available, -1, 0)) {
-- 
2.22.0.410.gd8fdbe21b5-goog

