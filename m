Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 622F319BBD
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2019 12:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfEJKf4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 May 2019 06:35:56 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:52764 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbfEJKf4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 May 2019 06:35:56 -0400
Received: from 79.184.254.161.ipv4.supernova.orange.pl (79.184.254.161) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id b41bd29227d1183f; Fri, 10 May 2019 12:35:53 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] cpufreq: Explain the kobject_put() in cpufreq_policy_alloc()
Date:   Fri, 10 May 2019 12:35:53 +0200
Message-ID: <2270903.5qkiGuZaYc@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It may not be particularly clear why the kobject_put() after
failing kobject_init_and_add() in cpufreq_policy_alloc() is not
redundant, so add a comment to explain that.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |    5 +++++
 1 file changed, 5 insertions(+)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -1133,6 +1133,11 @@ static struct cpufreq_policy *cpufreq_po
 				   cpufreq_global_kobject, "policy%u", cpu);
 	if (ret) {
 		pr_err("%s: failed to init policy->kobj: %d\n", __func__, ret);
+		/*
+		 * The entire policy object will be freed below, but the extra
+		 * memory allocated for the kobject name needs to be freed by
+		 * releasing the kobject.
+		 */
 		kobject_put(&policy->kobj);
 		goto err_free_real_cpus;
 	}



