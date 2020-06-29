Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28CE20DAFB
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jun 2020 22:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388683AbgF2UCa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jun 2020 16:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387947AbgF2UC1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jun 2020 16:02:27 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1998C061755
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2020 13:02:27 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id v26so116615oof.7
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2020 13:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OH0rNBT9W84o9wS9VyW5dxui8DUCwiqdXYynayWRkhE=;
        b=gyfjAP1QH+9K8XAonMYDiORbrREk2hnAYmMygagJYnS/PeSTeo/N58LOXYMLWUahyG
         XVe20skhr9p6H53LmgIF8g0gvy6EN2HG3F6zTTW/6eQ4G5uHJSWsA1z4oExHLiRBxtfh
         sqIRG2ev1wRpRxVl5JxU+XKTd+loVqFw1rP8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OH0rNBT9W84o9wS9VyW5dxui8DUCwiqdXYynayWRkhE=;
        b=JLSPT8WDRLtffk3me1n7sKO7RTqc8+wL/hlX29I6lsBc7sA6MC2sdXrksF3RZvKJDo
         zChonEartA2vdafWwLqAzwcDOxR00Kq+x304J7JCXaQ5jeW5KNmehPKpkobyBFkPEp2W
         2Zo53yRRogIk1ZqEi9ehbkrL7ffrj7R2bUWUqvQ00BSg7WIc3k9fbRRf+G6GiLRs3fuo
         oM89AYZoLrPDI5xYCcSbPNpL+aFnRWBnxakE8CDQoGEFU1UsTbWWZLrElI8coxP8wkWa
         8DA8+O6sOcRAZ90xkBrpCwPt8HKbiQtu4IU4JeUqzoC/897wb89u/OKlVd/0qEE09p4B
         xNgQ==
X-Gm-Message-State: AOAM530h/RbmOmy3h+D989M2vuL595D0aRiVc/1A+Mn8AKSWpX95AfPI
        VIjdmdaVpvi1T1mLxfIf3SMHWg==
X-Google-Smtp-Source: ABdhPJzhXyOuVOdh8wAFssxnqlQ8dPjp+s+W0dbcr5Y+R9um/gLKAFxVscQBA7dUfd8gQbfYxG8Tzg==
X-Received: by 2002:a4a:2259:: with SMTP id z25mr14954165ooe.29.1593460947269;
        Mon, 29 Jun 2020 13:02:27 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id p73sm213895oop.36.2020.06.29.13.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 13:02:26 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     trenn@suse.com, shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpupower: Fix NULL but dereferenced coccicheck errors
Date:   Mon, 29 Jun 2020 14:02:23 -0600
Message-Id: <20200629200223.27322-2-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629200223.27322-1-skhan@linuxfoundation.org>
References: <20200629200223.27322-1-skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix NULL but dereferenced coccicheck errors found by:

make coccicheck MODE=report M=tools/power/cpupower

tools/power/cpupower/lib/cpufreq.c:384:19-23: ERROR: first is NULL but dereferenced.
tools/power/cpupower/lib/cpufreq.c:440:19-23: ERROR: first is NULL but dereferenced.
tools/power/cpupower/lib/cpufreq.c:308:19-23: ERROR: first is NULL but dereferenced.
tools/power/cpupower/lib/cpufreq.c:753:19-23: ERROR: first is NULL but dereferenced.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/power/cpupower/lib/cpufreq.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/power/cpupower/lib/cpufreq.c b/tools/power/cpupower/lib/cpufreq.c
index 6e04304560ca..c3b56db8b921 100644
--- a/tools/power/cpupower/lib/cpufreq.c
+++ b/tools/power/cpupower/lib/cpufreq.c
@@ -285,7 +285,7 @@ struct cpufreq_available_governors *cpufreq_get_available_governors(unsigned
 			} else {
 				first = malloc(sizeof(*first));
 				if (!first)
-					goto error_out;
+					return NULL;
 				current = first;
 			}
 			current->first = first;
@@ -362,7 +362,7 @@ struct cpufreq_available_frequencies
 			} else {
 				first = malloc(sizeof(*first));
 				if (!first)
-					goto error_out;
+					return NULL;
 				current = first;
 			}
 			current->first = first;
@@ -418,7 +418,7 @@ struct cpufreq_available_frequencies
 			} else {
 				first = malloc(sizeof(*first));
 				if (!first)
-					goto error_out;
+					return NULL;
 				current = first;
 			}
 			current->first = first;
@@ -493,7 +493,7 @@ static struct cpufreq_affected_cpus *sysfs_get_cpu_list(unsigned int cpu,
 			} else {
 				first = malloc(sizeof(*first));
 				if (!first)
-					goto error_out;
+					return NULL;
 				current = first;
 			}
 			current->first = first;
@@ -726,7 +726,7 @@ struct cpufreq_stats *cpufreq_get_stats(unsigned int cpu,
 			} else {
 				first = malloc(sizeof(*first));
 				if (!first)
-					goto error_out;
+					return NULL;
 				current = first;
 			}
 			current->first = first;
-- 
2.25.1

