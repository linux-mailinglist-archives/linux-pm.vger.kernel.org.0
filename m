Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63DABD772B
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2019 15:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731176AbfJONMp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 15 Oct 2019 09:12:45 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:47443 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728372AbfJONMp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Oct 2019 09:12:45 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iKMcy-0002nS-7l; Tue, 15 Oct 2019 14:12:40 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iKMcx-0006ib-QX; Tue, 15 Oct 2019 14:12:39 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Kevin Hilman <khilman@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: OMAP2+: SmartReflex: add omap_sr_pdata definition
Date:   Tue, 15 Oct 2019 14:12:38 +0100
Message-Id: <20191015131238.25781-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The omap_sr_pdata is not declared but is exported, so add a
define for it to fix the following warning:

arch/arm/mach-omap2/pdata-quirks.c:609:36: warning: symbol 'omap_sr_pdata' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 include/linux/power/smartreflex.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/power/smartreflex.h b/include/linux/power/smartreflex.h
index d0b37e937037..971c9264179e 100644
--- a/include/linux/power/smartreflex.h
+++ b/include/linux/power/smartreflex.h
@@ -293,6 +293,9 @@ struct omap_sr_data {
 	struct voltagedomain		*voltdm;
 };
 
+
+extern struct omap_sr_data omap_sr_pdata[OMAP_SR_NR];
+
 #ifdef CONFIG_POWER_AVS_OMAP
 
 /* Smartreflex module enable/disable interface */
-- 
2.23.0

