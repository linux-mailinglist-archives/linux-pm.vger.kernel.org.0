Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD463AFF65
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jun 2021 10:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhFVIlR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Jun 2021 04:41:17 -0400
Received: from lucky1.263xmail.com ([211.157.147.132]:60642 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbhFVIlQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Jun 2021 04:41:16 -0400
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id 5CCCDF720B;
        Tue, 22 Jun 2021 16:38:52 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.240.82.166])
        by smtp.263.net (postfix) whith ESMTP id P1335T140034875209472S1624351127067953_;
        Tue, 22 Jun 2021 16:38:52 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <f5f00ebfe2d2a2f399da45cc6c926f25>
X-RL-SENDER: pingshuo@uniontech.com
X-SENDER: pingshuo@uniontech.com
X-LOGIN-NAME: pingshuo@uniontech.com
X-FST-TO: rjw@rjwysocki.net
X-RCPT-COUNT: 7
X-SENDER-IP: 58.240.82.166
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   pingshuo <pingshuo@uniontech.com>
To:     rjw@rjwysocki.net
Cc:     len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pingshuo <pingshuo@uniontech.com>
Subject: [PATCH] hibernation:stop resume screen during hibernation
Date:   Tue, 22 Jun 2021 16:38:44 +0800
Message-Id: <20210622083844.13892-1-pingshuo@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The display will be woken up during hibernation,
if the computer equipment is poor, it will cause the screen to flicker.
Skip to reusme the display devices in "thaw".

Signed-off-by: pingshuo <pingshuo@uniontech.com>
---
 drivers/base/power/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index c7f51c94969d..376b2eca65c7 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -707,7 +707,7 @@ static int dpm_resume_skip_display_devices(struct device *dev, pm_message_t stat
 {
     struct pci_dev *pci_test = to_pci_dev(dev);
     if (state.event == PM_EVENT_THAW) {
-        /*
+	/*
         *Filter out the display devices
         */
         if((pci_test && ((pci_test->class&DISPLAY_PCI_CLASS_VALID_BIT) == DISPLAY_PCI_CLASS))||(dev->driver&&dev->driver->name&&strncmp(dev->driver->name,"video",6)==0))
-- 
2.20.1



