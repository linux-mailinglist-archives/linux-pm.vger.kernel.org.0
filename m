Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98DBA12BC56
	for <lists+linux-pm@lfdr.de>; Sat, 28 Dec 2019 03:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbfL1C5K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Dec 2019 21:57:10 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34624 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfL1C5K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Dec 2019 21:57:10 -0500
Received: by mail-pl1-f193.google.com with SMTP id x17so12420104pln.1;
        Fri, 27 Dec 2019 18:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pb2DHvI1SXHf14E2JlaRtrDtafVuGp2YeoyLpzVah6Y=;
        b=edvxL2YU4YXLE7Hn4+Usae7SN/vlPgH2HaFCqGNwS5mDpzAnQmCMvRyzZAzSBgPkRC
         K4RG1LkVSjPzkjI7hhIrfDo2qmsdxptlOE4QL8vTgF2duNnF62zBdV/NxP4M7kapDPIL
         KXk6moYe1Ya7F3EckbAbXZ1ffy0jkzR7lj/7TCRqJ87ma9BJGO7x3Z+5Ww521e1TwnN+
         x6PsP1rbGs5SSdplm0Qtm34eijryNDMY2JQMzkAvzBR8gxf/RLAIayfdvlS05NabaJdM
         Ba9yf9qqN8pGUghB+H1oA4O4F9oPE9VF9dkHuUtm2qeWQxif9e8uVfC4F+IjVrgtBSkP
         W2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pb2DHvI1SXHf14E2JlaRtrDtafVuGp2YeoyLpzVah6Y=;
        b=QO8priWyUaecPSFUxBGkVnVSpxxNCulf1KEI+0Mh0BLBnLCWnVbkTyGtegX7qLgX4V
         Et6j1+bNzva72YC530N+K65HAKPi+26a7WWdTkh/aXKRgQLveG1ILgWavcLKbDp+GN3C
         FN07CCvry7jXcylxP61fAyzUcz33mjenlraBxcw9v+9F/BUEtwg7i2uLSZqyjJaO8r8W
         0PVnoRGZ+ilvsctv+L6EXdfNXxUZOba2SicVK18XW1YIRoeofc5TB+gRIgjhd9B6r9gQ
         1lO0DJuAlUbZy3OhXXDqgWnltT3PPz04/H4wAPxAxwz+Idamwgc5FIvYS8u1CNLNeIh8
         VLAw==
X-Gm-Message-State: APjAAAVL5/xvcHQKyRdDr98IG5feLgdGgWBVOyN/6lHlwsjLhazSKgc4
        WWMXzOqgwVC06L+E/AAJ1hs=
X-Google-Smtp-Source: APXvYqyemc0lwdyanJC2mPL2Sdc4eud3lM6qr0Rnv7r9s3u3dDoRAqqReEWPQyaFv+aheWwpIGJ4lA==
X-Received: by 2002:a17:902:9a46:: with SMTP id x6mr2915914plv.7.1577501829675;
        Fri, 27 Dec 2019 18:57:09 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id x22sm40862904pgc.2.2019.12.27.18.57.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 27 Dec 2019 18:57:09 -0800 (PST)
From:   qiwuchen55@gmail.com
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        chenqiwu <chenqiwu@xiaomi.com>
Subject: [PATCH] cpufreq: powernow-k8: avoid use after free issue in cpufreq_notify_transition()
Date:   Sat, 28 Dec 2019 10:57:04 +0800
Message-Id: <1577501824-12152-1-git-send-email-qiwuchen55@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: chenqiwu <chenqiwu@xiaomi.com>

There is a potential UAF issue in cpufreq_notify_transition() that the
cpufreq of current cpu has been released before using it. So we should
make a judgement and avoid it.

Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
---
 drivers/cpufreq/powernow-k8.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
index 2db2f17..7391eb0 100644
--- a/drivers/cpufreq/powernow-k8.c
+++ b/drivers/cpufreq/powernow-k8.c
@@ -913,6 +913,11 @@ static int transition_frequency_fidvid(struct powernow_k8_data *data,
 	freqs.new = find_khz_freq_from_fid(fid);
 
 	policy = cpufreq_cpu_get(smp_processor_id());
+	if (!policy) {
+		pr_debug("cpu %d: CPUFreq policy not found\n",
+			 smp_processor_id());
+		return 1;
+	}
 	cpufreq_cpu_put(policy);
 
 	cpufreq_freq_transition_begin(policy, &freqs);
-- 
1.9.1

