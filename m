Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2105B2D1278
	for <lists+linux-pm@lfdr.de>; Mon,  7 Dec 2020 14:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgLGNr4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Dec 2020 08:47:56 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36532 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbgLGNr4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2020 08:47:56 -0500
Date:   Mon, 07 Dec 2020 13:47:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607348833;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=64RzUOtY+loPMkTbF/FjH+RXVYzZBIzgqL86y1HVHWc=;
        b=cBZcZRFnM3F41gp6wOx2Lmf4k7ni956/3xU6rbt+ojj/4J0/YdiRpq+gViuEJn6wTDuZDJ
        Yrp3IKLluTgUvHObsSnRfRqiwoxILtSgHFVz6zr8fQpk/yEd8dMXhB57/AN3kHCmVZwOkp
        wOpA1voVx1auHlyAGbvtDrF13C16V50CibcVthUJCSdd6nFDe8ggo9D4IH4VhyGv1XuEgq
        EC51rTVqA7BSBg7bzQMhntcsewRn3KPUBpXXM+OfbFnpzsjm4/bLdqq7qJdroH816eMxPB
        Ig2HpHuVNaKzs4iRgRkS+qoGU6vYC7xBz3ub6zQhqaXgNkvPJFUyFwUkrf2rVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607348833;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=64RzUOtY+loPMkTbF/FjH+RXVYzZBIzgqL86y1HVHWc=;
        b=iIhl0CQTPsVrziMcGI/fX0AWOz4RENq5cCFM58NvcLRGjBcUfHZaPi12fOC7OVxYXI3Hpc
        8kL5vdQ8WF72GkCg==
From:   "thermal-bot for Rikard Falkeborn" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: core: Constify static
 attribute_group structs
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20201128234342.36684-1-rikard.falkeborn@gmail.com>
References: <20201128234342.36684-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Message-ID: <160734883309.3364.10066479522798087490.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     f74bed6a4e0d7f51da7f624e47f6e9423920e1e0
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//f74bed6a4e0d7f51da7f624e47f6e9423920e1e0
Author:        Rikard Falkeborn <rikard.falkeborn@gmail.com>
AuthorDate:    Sun, 29 Nov 2020 00:43:42 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 30 Nov 2020 09:09:12 +01:00

thermal: core: Constify static attribute_group structs

The only usage of these structs is to assign their address to the
thermal_zone_attribute_groups array, which consists of pointers to
const, so make them const to allow the compiler to put them in read-only
memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201128234342.36684-1-rikard.falkeborn@gmail.com
---
 drivers/thermal/thermal_sysfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index a6f371f..0866e94 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -425,7 +425,7 @@ static struct attribute *thermal_zone_dev_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group thermal_zone_attribute_group = {
+static const struct attribute_group thermal_zone_attribute_group = {
 	.attrs = thermal_zone_dev_attrs,
 };
 
@@ -434,7 +434,7 @@ static struct attribute *thermal_zone_mode_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group thermal_zone_mode_attribute_group = {
+static const struct attribute_group thermal_zone_mode_attribute_group = {
 	.attrs = thermal_zone_mode_attrs,
 };
 
@@ -468,7 +468,7 @@ static umode_t thermal_zone_passive_is_visible(struct kobject *kobj,
 	return 0;
 }
 
-static struct attribute_group thermal_zone_passive_attribute_group = {
+static const struct attribute_group thermal_zone_passive_attribute_group = {
 	.attrs = thermal_zone_passive_attrs,
 	.is_visible = thermal_zone_passive_is_visible,
 };
