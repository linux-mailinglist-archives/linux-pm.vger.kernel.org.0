Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D32C2EB25C
	for <lists+linux-pm@lfdr.de>; Tue,  5 Jan 2021 19:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbhAESUB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Jan 2021 13:20:01 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:45758 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbhAESUB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jan 2021 13:20:01 -0500
Received: from 89-77-60-66.dynamic.chello.pl (89.77.60.66) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.537)
 id 3070e0ba3920ff17; Tue, 5 Jan 2021 19:19:19 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH] ACPI: PM: s2idle: Drop unused local variables and related code
Date:   Tue, 05 Jan 2021 19:19:18 +0100
Message-ID: <3607102.xkEKTzvHZR@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Two local variables in drivers/acpi/x86/s2idle.c are never read, so
drop them along with the code updating their values (in vain).

Fixes: fef98671194b ("ACPI: PM: s2idle: Move x86-specific code to the x86 directory")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/x86/s2idle.c |   14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

Index: linux-pm/drivers/acpi/x86/s2idle.c
===================================================================
--- linux-pm.orig/drivers/acpi/x86/s2idle.c
+++ linux-pm/drivers/acpi/x86/s2idle.c
@@ -105,18 +105,8 @@ static void lpi_device_get_constraints_a
 
 	for (i = 0; i < out_obj->package.count; i++) {
 		union acpi_object *package = &out_obj->package.elements[i];
-		struct lpi_device_info_amd info = { };
 
-		if (package->type == ACPI_TYPE_INTEGER) {
-			switch (i) {
-			case 0:
-				info.revision = package->integer.value;
-				break;
-			case 1:
-				info.count = package->integer.value;
-				break;
-			}
-		} else if (package->type == ACPI_TYPE_PACKAGE) {
+		if (package->type == ACPI_TYPE_PACKAGE) {
 			lpi_constraints_table = kcalloc(package->package.count,
 							sizeof(*lpi_constraints_table),
 							GFP_KERNEL);
@@ -135,12 +125,10 @@ static void lpi_device_get_constraints_a
 
 				for (k = 0; k < info_obj->package.count; ++k) {
 					union acpi_object *obj = &info_obj->package.elements[k];
-					union acpi_object *obj_new;
 
 					list = &lpi_constraints_table[lpi_constraints_table_size];
 					list->min_dstate = -1;
 
-					obj_new = &obj[k];
 					switch (k) {
 					case 0:
 						dev_info.enabled = obj->integer.value;



