Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE37D2FC256
	for <lists+linux-pm@lfdr.de>; Tue, 19 Jan 2021 22:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbhASV2S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jan 2021 16:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbhASV2K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2021 16:28:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B529DC0613CF
        for <linux-pm@vger.kernel.org>; Tue, 19 Jan 2021 13:27:29 -0800 (PST)
Date:   Tue, 19 Jan 2021 21:27:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611091646;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LpLdDO+zmHtQHBB3k3Q/TaAyg6b/fvnifERpYHK6BaI=;
        b=j7ZztcgyF0axRxBYxfGpnBlJ/8iraC3o/SFUHHmchnHWSAWCFUoitH6KifSzdTvhSSjt8d
        izaLoqcyTW73DodGcMuW0cuLFUlt9ppKy6sNyIXDtKzwEgeSPolT/wsrK36GXkeXLG/12H
        tuecvqdgqaq89oqQP58p/qIwvwPy/KFe4KCCeCbFV/M9PGODpwsl5q6CqS1r0QUn55HTuU
        XznlT/MT6ThzoTmm/WnCE5eIrWVVUSmwTdC2t1eKUC1cnCI/R82Np/AtLKZXuY4dVWv12b
        XMLPqwjAbI9xA1W7/BBH8a+B27VLBu7PDdldzIP5tVWByzKxLCXSEVjDgumfSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611091646;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LpLdDO+zmHtQHBB3k3Q/TaAyg6b/fvnifERpYHK6BaI=;
        b=ZNr6uAOZVgZT8FYXpmbgskX19TQU8Hkf8qeTkM4g/OC/RHw8Ka5rMiYtJe4IFYNvXCTqXD
        5Fbp2fcGxFd3u5BA==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/core: Remove unused macro THERMAL_TRIPS_NONE
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20201214233811.485669-6-daniel.lezcano@linaro.org>
References: <20201214233811.485669-6-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <161109164611.414.7470176935480207922.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     2121496fdc5f2d93eda9743c4b487469f0042e3c
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//2121496fdc5f2d93eda9743c4b487469f0042e3c
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Tue, 15 Dec 2020 00:38:09 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 19 Jan 2021 22:23:32 +01:00

thermal/core: Remove unused macro THERMAL_TRIPS_NONE

The macro THERMAL_TRIPS_NONE is no longer used, remove it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>
Link: https://lore.kernel.org/r/20201214233811.485669-6-daniel.lezcano@linaro.org
---
 include/linux/thermal.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index a57232a..060a216 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -17,7 +17,6 @@
 #include <linux/workqueue.h>
 #include <uapi/linux/thermal.h>
 
-#define THERMAL_TRIPS_NONE	-1
 #define THERMAL_MAX_TRIPS	12
 
 /* invalid cooling state */
