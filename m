Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6192F18DF1D
	for <lists+linux-pm@lfdr.de>; Sat, 21 Mar 2020 10:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgCUJ1o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 21 Mar 2020 05:27:44 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39965 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbgCUJ1o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 21 Mar 2020 05:27:44 -0400
Received: by mail-wr1-f68.google.com with SMTP id f3so10261106wrw.7;
        Sat, 21 Mar 2020 02:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=jIPT36F0dTY6bP/ENRWpZvdT+1C7xjAjzp5qPtZLNQs=;
        b=LNwheuTHavqHvWTE7iMHIo+Z4/RvA00DcrC9VYcYkzhhU3TejrH6w7aAzw7dnl9kYI
         PHvathUfZVAike6uFd4kSG5FprZmktZEq//4fA1pzL2cnqASfM+Pn34kGHa4Gq/c6iBg
         9vIVNkL2YbEOXzB+6ZWtHzwjJpcs3OMYLXhqTkfpGk+O2xtECUl4HhtEBNQJ1nBcGhhm
         9LbLMgi+PtTtdmGvXPcLsmWUzpoSQodzGWr0NvmGc/ifFVDmcL4FmHZ7v5MqRJ4r0CoL
         ZnBJizMjLLbSTC/pSC10HzAvFCAfxkOWLeenqyptDFE5lIa2pLyVJfaajnr5ll1lTaQA
         nwww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=jIPT36F0dTY6bP/ENRWpZvdT+1C7xjAjzp5qPtZLNQs=;
        b=rTm7jyT7hJDKPbofU8CG83GD7oL6GUoO2wDGsgJ/hLb21/Q5ba8OXLpSUzLZfbz7wc
         lXA0yVK5kNTBXWRi7LyvLIR5r9oR6QoQrTdi5mdbsASdBG5OVYO7mPZJdPRMkUmoHuoy
         C0M+3N/ND2YEedBN7wmZbS74Gbcqjn59EWaHfLmaZJjW2JR1IISV610Q7zDfe2paf/MR
         0/PD0uJ3HjYvTJYKyMOahjoYWdrq1EHFB6vI4iFtH1O0UDVOUfeD8QBSEK4ak4+FqpT6
         8d1mcAGx7H20krY4PeOTWcqBMZD51EBBFvD+XHixh9cf+XVD4JXQHaSRS24RkESO1aIC
         04kg==
X-Gm-Message-State: ANhLgQ3MxIVd9wqJIXv4pbWfKQJA/uZma1isiTMctgHGt2m8Iq4txQkv
        v/siTrx4n0YdlCNqt4vizoY=
X-Google-Smtp-Source: ADFU+vv+PtqUiwElJCMMpIq4d7WeO6iJseKC0LNjVV4sd1m0IP4cFu0cPgiGjzjP5UwlRnfWRsejCg==
X-Received: by 2002:adf:fa8d:: with SMTP id h13mr16405315wrr.155.1584782862249;
        Sat, 21 Mar 2020 02:27:42 -0700 (PDT)
Received: from macmini.local (181.4.199.77.rev.sfr.net. [77.199.4.181])
        by smtp.gmail.com with ESMTPSA id n6sm11549130wmn.13.2020.03.21.02.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 02:27:41 -0700 (PDT)
Date:   Sat, 21 Mar 2020 09:27:40 +0000
From:   Willy Wolff <willy.mh.wolff.ml@gmail.com>
To:     Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J.Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] thermal/drivers/cpufreq_cooling: Fix return of
 cpufreq_set_cur_state
Message-ID: <20200321092740.7vvwfxsebcrznydh@macmini.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The function freq_qos_update_request returns 0 or 1 describing update
effectiveness, and a negative error code on failure. However,
cpufreq_set_cur_state returns 0 on success or an error code otherwise.

Signed-off-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>
---
 drivers/thermal/cpufreq_cooling.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index fe83d7a210d4..af55ac08e1bd 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -431,6 +431,7 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 				 unsigned long state)
 {
 	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
+	int ret;
 
 	/* Request state should be less than max_level */
 	if (WARN_ON(state > cpufreq_cdev->max_level))
@@ -442,8 +443,9 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 
 	cpufreq_cdev->cpufreq_state = state;
 
-	return freq_qos_update_request(&cpufreq_cdev->qos_req,
-				get_state_freq(cpufreq_cdev, state));
+	ret = freq_qos_update_request(&cpufreq_cdev->qos_req,
+				      get_state_freq(cpufreq_cdev, state));
+	return ret < 0 ? ret : 0;
 }
 
 /* Bind cpufreq callbacks to thermal cooling device ops */
-- 
2.20.1

