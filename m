Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E299461ED2
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 14:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbfGHMxB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jul 2019 08:53:01 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:60851 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728615AbfGHMxA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jul 2019 08:53:00 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MHFwM-1hg19V14PQ-00DGIK; Mon, 08 Jul 2019 14:52:49 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Nandor Han <nandor.han@vaisala.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] power: reset: nvmem-reboot-mode: add CONFIG_OF dependency
Date:   Mon,  8 Jul 2019 14:52:39 +0200
Message-Id: <20190708125247.3769080-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:6SS/gq7IcyGSOSLVilP5dnwencoI/sgZf1Q7EHXRRfw4T53FImx
 fllqWL3XPVyjpEn+CJQB6vqES0JOQaHwOOCQd7bC/VI8gBI3QS/jyYGT3O4FoV52w4p3OJi
 wAKwyvDEQ2CNRU5O70xpuWAb/LXovIVRo+2+t1MbY8o0ha1LeLXJg1KQMWpM8inpG9KhNa9
 tET+QfjwwoYGBFkCyt1Nw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VtOFB+BMYi0=:hzt+AkclHU2thQ/96Q3iF5
 HeNLWY8WERSwAqx61XqJVJtDQ5b533C1HEYdMNT8KnO4n4Xipe7/FnHuGvm7RoW4lwMyH6BEc
 3q8d3ZJQitOlsodPxVmKtSgkYGWWrurHWUcRbwdLqI8XXIazH0KUt5Mh4xzL7I/pgienngNy1
 u+W+Mr5prj7jMZNAYX9U87VGIcKCXj+oRmSOTvxSpugmH69fUuZX4jYT6QWDjHPhcJOqHXPFd
 JtlbTRC4YG5K5l6AShTVbohH5p6GZmrQCG4/U5OT4pKHEfR6ZNvFxldAXWnJk0R3DhfDLUHlW
 JZsNhYVVYaHem05rcuwSDxvHizcbRlR3Wd7qIDrfUciwpy796Qy5e8Mx/XPn2hOPFCCBABWFE
 pF92c1gBDs9SAFqeItuCkxl9FRXkbEtOKVIRNhT5LJ3eJN+OrfPCPbW0vEY5BZt6tUlXEeFqn
 LdcUwAfN5RDlIJSzDEgw/TP46LOwJsDa3bE0+t0lZMmWPFaBMcuda/6BxDQSRMdlgq2MqvbJP
 1cbn8vVec1kjiuN0vqPFdq8wKqHPdKFf/kbLXXPAMTFsU545Gpj1Td/zLvY815q2Ol1a7yu2I
 xxb/25n7ghWxWOb9mgXVdniAjItBQz8EQBOaFfs/9RjSRFHqavEfvOKzJ9kGKNcf7lJnKdJM+
 n8I6P2IuyfZIr3b5Zld8UEeQdtTzyRWseGWnWkFoipUOYIM4iKinOUhCjsgbtgxKUKWFmXEPV
 0JMZ9P5rcBQKI514HvRjY9VjcY6fnZDCPxAH1g==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Without CONFIG_OF, we get a build failure in the reboot-mode
implementation:

drivers/power/reset/reboot-mode.c: In function 'reboot_mode_register':
drivers/power/reset/reboot-mode.c:72:2: error: implicit declaration of function 'for_each_property_of_node'; did you mean 'for_each_child_of_node'? [-Werror=implicit-function-declaration]
  for_each_property_of_node(np, prop) {

Add a Kconfig dependency like we have for the other users of
CONFIG_REBOOT_MODE.

Fixes: 7a78a7f7695b ("power: reset: nvmem-reboot-mode: use NVMEM as reboot mode write interface")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/power/reset/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 8dfb105db391..a564237278ff 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -248,6 +248,7 @@ config POWER_RESET_SC27XX
 
 config NVMEM_REBOOT_MODE
 	tristate "Generic NVMEM reboot mode driver"
+	depends on OF
 	select REBOOT_MODE
 	help
 	  Say y here will enable reboot mode driver. This will
-- 
2.20.0

