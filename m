Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF9E1559A
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2019 23:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfEFV14 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 May 2019 17:27:56 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:38409 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfEFV0i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 May 2019 17:26:38 -0400
Received: by mail-it1-f196.google.com with SMTP id q19so22338597itk.3;
        Mon, 06 May 2019 14:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :reply-to:organization;
        bh=qcB7eahk6uost1tJIP3FkNXq29ur/hHJU+gIkVwerH0=;
        b=q5OWpwQmt3ihZwn6+0+iOR3Ozwna/GEu5ONUl36Mg3W0TrTRlt2nD+dY8xrLQnOMFP
         j3DC6j4uOsTZPuk0nWTQ1J4i5dY3uY0y3Ch64y+lS4ky/44Dg+1GokaWRwEOwBajTIsh
         DFBRdOu9Ta4rUK5bXtla6z7UKR8TXuPP9xzr9t7+FfnvMd8gp3WShLGRJ91XWMRlDnuO
         SnJcdt6J455s/DJ2rNjOf6mZNUqMz/XR9EKa3RO8Gr+nOK65fYxfRnQ8zQjqrS6WHR65
         p9icqkCpHSTaNRTqCZF3uRj8Yp4COX8/y4kTnnnXRElHfuv/tvh5yGGiqNvdR4EkCJjs
         zGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:reply-to:organization;
        bh=qcB7eahk6uost1tJIP3FkNXq29ur/hHJU+gIkVwerH0=;
        b=sZ9F0aF2K45PP2uTBe3Xi+5BoYVBAkznK+M54cU2lsndvTit1P7AWReyJwOeaezHuA
         Hog38rCApS6hSJJr5sw10KgvFTuYR4l25RMePEa+ZS9tVQk4/tNZlkdWLmSRzlCHJI4Y
         cjgvIG1MqwN0SNpedysfq/T4moa+EU8KmIWS+Dg081Vq/naFSBEMHDg2r7fPGlcOlIL7
         hBe+u4RrdT2v8TNZRPLZCVs5EDYOX+ejM04JYN0qFO+ZhBi0gUTh3+7TF5v1Mk9MTqZa
         5nHkkaX8i8JVVPyIOlpLFYYE265W6cflfknv+KGxY2hmsCeWCI9vaW1m0MzPS8efHMsT
         0CDg==
X-Gm-Message-State: APjAAAWZnCEecH2juL250fs7qESTCXkNO+5laWbBsLohUUAPg8kbL1Mw
        b72MdAK8XwLcRVn+vISpMZw=
X-Google-Smtp-Source: APXvYqwXCwaaGWP0hjS8QE8jdCYc7Jd5NQVzaYKFOrFORKOOkYH0yuev6xBl8cFoijSYhx9qffd3ZA==
X-Received: by 2002:a24:2901:: with SMTP id p1mr10418138itp.54.1557177997999;
        Mon, 06 May 2019 14:26:37 -0700 (PDT)
Received: from nuc8.lan (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id v25sm4268009ioh.81.2019.05.06.14.26.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 14:26:37 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: [PATCH 10/22] powercap/intel_rapl: Support multi-die/package
Date:   Mon,  6 May 2019 17:26:05 -0400
Message-Id: <9f6958c231347e639e322de8d8c3de6859559345.1557177585.git.len.brown@intel.com>
X-Mailer: git-send-email 2.18.0-rc0
In-Reply-To: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1557177585.git.len.brown@intel.com>
References: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1557177585.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Zhang Rui <rui.zhang@intel.com>

RAPL "package" domains are actually implemented in hardware per-die.
Thus, the new multi-die/package systems have mulitple domains
within each physical package.

Update the intel_rapl driver to be "die aware" -- exporting multiple
domains within a single package, when present.
No change on single die/package systems.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-pm@vger.kernel.org
---
 drivers/powercap/intel_rapl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 3c3c0c23180b..9202dbcef96d 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -266,7 +266,7 @@ static struct rapl_domain *platform_rapl_domain; /* Platform (PSys) domain */
 /* caller to ensure CPU hotplug lock is held */
 static struct rapl_package *rapl_find_package_domain(int cpu)
 {
-	int id = topology_physical_package_id(cpu);
+	int id = topology_logical_die_id(cpu);
 	struct rapl_package *rp;
 
 	list_for_each_entry(rp, &rapl_packages, plist) {
@@ -1459,7 +1459,7 @@ static void rapl_remove_package(struct rapl_package *rp)
 /* called from CPU hotplug notifier, hotplug lock held */
 static struct rapl_package *rapl_add_package(int cpu)
 {
-	int id = topology_physical_package_id(cpu);
+	int id = topology_logical_die_id(cpu);
 	struct rapl_package *rp;
 	int ret;
 
-- 
2.18.0-rc0

