Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651AF1D1E63
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 20:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390583AbgEMS56 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 14:57:58 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51866 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732218AbgEMS4d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2020 14:56:33 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id D22F82A0188
Received: by jupiter.universe (Postfix, from userid 1000)
        id 6697A4800FF; Wed, 13 May 2020 20:56:29 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv1 01/19] kobject: increase allowed number of uevent variables
Date:   Wed, 13 May 2020 20:55:57 +0200
Message-Id: <20200513185615.508236-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513185615.508236-1-sebastian.reichel@collabora.com>
References: <20200513185615.508236-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SBS battery driver exposes 32 power supply properties now,
which will result in uevent failure on (un)plugging the
battery. Other drivers (e.g. bq27xxx) are also coming close
to this limit, so increase it.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 include/linux/kobject.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index e2ca0a292e21..75e822569e39 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -29,7 +29,7 @@
 #include <linux/uidgid.h>
 
 #define UEVENT_HELPER_PATH_LEN		256
-#define UEVENT_NUM_ENVP			32	/* number of env pointers */
+#define UEVENT_NUM_ENVP			64	/* number of env pointers */
 #define UEVENT_BUFFER_SIZE		2048	/* buffer for the variables */
 
 #ifdef CONFIG_UEVENT_HELPER
-- 
2.26.2

