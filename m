Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C469940599B
	for <lists+linux-pm@lfdr.de>; Thu,  9 Sep 2021 16:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236520AbhIIOsS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 10:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345189AbhIIOrv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Sep 2021 10:47:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67482C0560C8
        for <linux-pm@vger.kernel.org>; Thu,  9 Sep 2021 07:38:45 -0700 (PDT)
Date:   Thu, 09 Sep 2021 14:38:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631198324;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MZpEvtZywnnpvQb3J8m+utd/YaYPmlgMESXdyKL6o7U=;
        b=X5x7ZZVtYXUfH4f8AQuzDEpOfbkBFMTdTd7NOODTsp+9rZvm3Ir/N9cs6BZWMHAqA4HtFR
        RZNckpYi/8bnJGtJ2+HegQNcfG7DOF8iR2HEMXDryZGTk+TBdjB5whr5NZwvpojeuGQm2i
        SRNU4vq2VtiTvBmq3UNsiA78+b9O0O6Pb5VJY4rqbHZDxxGxD8YoTwrBYCjx1IA86GvUw/
        BMWtFMWd+1ct64NHmnT6amOd6ga86aMQMHkqIAeJnJ93kCczSaP7bZndtgR8fZDhJiF2R3
        O3JX6Rbw2vZ+xGOK/dToso4gomcjvAd3vJEbPU59zVn5wtc39R9Ah2Ay6iYUyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631198324;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MZpEvtZywnnpvQb3J8m+utd/YaYPmlgMESXdyKL6o7U=;
        b=xOPVlqUkZg1qyCXNxdVcAt7xS7C7a1ZqbuBxwPE3V98SFzdP9/uoy22vtcdf9GiJmXvEyN
        kr33R8q+Mnmkm9Dg==
From:   "thermal-bot for Sumeet Pawnikar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] drivers/thermal/intel: Add TCC cooling
 support for AlderLake platform
Cc:     Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, amitk@kernel.org
In-Reply-To: <20210809115635.10100-1-sumeet.r.pawnikar@intel.com>
References: <20210809115635.10100-1-sumeet.r.pawnikar@intel.com>
MIME-Version: 1.0
Message-ID: <163119832328.25758.10664973868857564234.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     a414a08aefe6343492b812a50a1b2f3a30ce8b6e
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//a414a08aefe6343492b812a50a1b2f3a30ce8b6e
Author:        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
AuthorDate:    Mon, 09 Aug 2021 17:26:35 +05:30
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sat, 14 Aug 2021 12:41:36 +02:00

drivers/thermal/intel: Add TCC cooling support for AlderLake platform

Add tcc cooling support for the AlderLake platform.

Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210809115635.10100-1-sumeet.r.pawnikar@intel.com
---
 drivers/thermal/intel/intel_tcc_cooling.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/thermal/intel/intel_tcc_cooling.c b/drivers/thermal/intel/intel_tcc_cooling.c
index 8ec10d5..cd80c7d 100644
--- a/drivers/thermal/intel/intel_tcc_cooling.c
+++ b/drivers/thermal/intel/intel_tcc_cooling.c
@@ -79,6 +79,8 @@ static const struct x86_cpu_id tcc_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE, NULL),
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L, NULL),
 	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE, NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE, NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, NULL),
 	{}
 };
 
