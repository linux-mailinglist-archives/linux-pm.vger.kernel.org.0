Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220CD41F2BE
	for <lists+linux-pm@lfdr.de>; Fri,  1 Oct 2021 19:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbhJARQR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Oct 2021 13:16:17 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:64554 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbhJARQQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Oct 2021 13:16:16 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 3.0.0)
 id f0a72af3e010e61d; Fri, 1 Oct 2021 19:14:30 +0200
Received: from kreacher.localnet (unknown [213.134.175.164])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 229CF66A686;
        Fri,  1 Oct 2021 19:14:29 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>
Subject: [PATCH] thermal: Update information in MAINTAINERS
Date:   Fri, 01 Oct 2021 19:14:28 +0200
Message-ID: <11859976.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.175.164
X-CLIENT-HOSTNAME: 213.134.175.164
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrudekiedguddtiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepfefftefgleejgeffffdtheelieelleejveettdeuteeugeetjeejudehhefftedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdptddurdhorhhgpdhlihhnuhigthhvrdhorhhgnecukfhppedvudefrddufeegrddujeehrdduieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudejhedrudeigedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhl
 vgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehtohhrvhgrlhgusheslhhinhhugihfohhunhgurghtihhonhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=10 Fuz1=10 Fuz2=10
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael@kernel.org>

Because Rui is now going to focus on work that is not related to the
maintenance of the thermal subsystem in the kernel, Rafael will start
to help Daniel with handling the development process as a new member
of the thermal maintainers team.  Rui will continue to review patches
in that area.

The thermal development process flow will change so that the material
from the thermal git tree will be merged into the thermal branch of
the linux-pm.git tree before going into the mainline.

Update the information in MAINTAINERS accordingly.

Signed-off-by: Rafael J. Wysocki <rafael@kernel.org>
Acked-by: Zhang Rui <rui.zhang@intel.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 MAINTAINERS |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

Index: linux-pm/MAINTAINERS
===================================================================
--- linux-pm.orig/MAINTAINERS
+++ linux-pm/MAINTAINERS
@@ -414,7 +414,8 @@ T:	git git://git.kernel.org/pub/scm/linu
 F:	drivers/acpi/pmic/
 
 ACPI THERMAL DRIVER
-M:	Zhang Rui <rui.zhang@intel.com>
+M:	Rafael J. Wysocki <rafael@kernel.org>
+R:	Zhang Rui <rui.zhang@intel.com>
 L:	linux-acpi@vger.kernel.org
 S:	Supported
 W:	https://01.org/linux-acpi
@@ -18547,13 +18548,14 @@ T:	git git://linuxtv.org/media_tree.git
 F:	drivers/media/radio/radio-raremono.c
 
 THERMAL
-M:	Zhang Rui <rui.zhang@intel.com>
+M:	Rafael J. Wysocki <rafael@kernel.org>
 M:	Daniel Lezcano <daniel.lezcano@linaro.org>
 R:	Amit Kucheria <amitk@kernel.org>
+R:	Zhang Rui <rui.zhang@intel.com>
 L:	linux-pm@vger.kernel.org
 S:	Supported
 Q:	https://patchwork.kernel.org/project/linux-pm/list/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
 F:	Documentation/devicetree/bindings/thermal/
 F:	drivers/thermal/
 F:	include/linux/cpu_cooling.h



