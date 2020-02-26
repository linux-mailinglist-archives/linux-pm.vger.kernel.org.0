Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 891DB16F567
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2020 02:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbgBZB61 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Feb 2020 20:58:27 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46959 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbgBZB60 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Feb 2020 20:58:26 -0500
Received: by mail-qt1-f196.google.com with SMTP id i14so1123105qtv.13
        for <linux-pm@vger.kernel.org>; Tue, 25 Feb 2020 17:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3W6dUjneFw3Iq5j0LRHddz/04ra8gT9SV1GqromcUcA=;
        b=p1b6DIB/zaPCoKDbRHx56Ttn3E//aAfWWDn5ysoYfvW9M17pCbsmV09+Z/c1eYrgYT
         RLTBR6fyj9srVTEglPmT6kRF5IjSO/9MH40LH7aL2K5L0ywykQNdGuGmcBoh7+g20L/S
         4Hz0X55LGUiN8wlKC5ak0ibUvEkrv71+M1Ue6SrYDgJEVxuPB10/Dvy3waU+0NZTGszW
         afkV03q05woG9KXAuYUXZPHO9kcMr2Wf0wussfbM34enqv7vS26F6o//x03jcLx9zOXc
         QpBHg9A0nAt62FEphlR4ouYHAs0nsgfx0P/SuHe5AWaKE/CuSIpB55fBGtOCmOfS7LCj
         ha0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3W6dUjneFw3Iq5j0LRHddz/04ra8gT9SV1GqromcUcA=;
        b=sEGP9luRy31WDL+ZFn1vp7TuMYTc0NoaT7gMKmQIjIUlvbrRyfWbhhfl7nMlFIt30o
         S9Q+H4PVLE5KsAsdD7uuo+1sTgHlW5ZtNLtit+OJY+Tp4wKbw3z1pDsDmeWVAH4WVClp
         SaGrwQDB7/EfiAa+WUAM4ZQfvSycu7A4WLCMGT0NFUt/oiA5j9U9iWRJiu22g6rIjrpz
         VWjZTqnm1gFZG1wBbJogwWuTJ39eRr/Q3WtUUPjTNd/2+cPGtYVWyQmQbqYPBskkwnjO
         4XhRsYok+1xStClsl0j0vJC6d3zfT0O+r+xARwOOx8JnkKPHlB9xVw2pISxwwX6KP8Qa
         Uw8Q==
X-Gm-Message-State: APjAAAX7wyZfvdjZvJ/Ui9kpgGxfnmU587rH8teDs1V1en1KMSXn4KZB
        Z7smVvwCMwBAwUb/OdBe4p/xEw==
X-Google-Smtp-Source: APXvYqzceBcyktKssUogh3JQAjPXAwym222xlUpuJoB/bKA9+80nAwe3RJB1ejMlWvXgtr7v8/21HA==
X-Received: by 2002:ac8:1b18:: with SMTP id y24mr2071113qtj.158.1582682304323;
        Tue, 25 Feb 2020 17:58:24 -0800 (PST)
Received: from ovpn-121-122.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id v80sm283450qka.15.2020.02.25.17.58.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Feb 2020 17:58:23 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     rafael@kernel.org
Cc:     elver@google.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next v2] power/qos: annotate data races in pm_qos_*_value
Date:   Tue, 25 Feb 2020 20:58:13 -0500
Message-Id: <20200226015813.987-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The target_value field in struct pm_qos_constraints is used for lockless
access to the effective constraint value of a given QoS list, so the
readers of it cannot expect it to always reflect the most recent
effective constraint value.  However, they can and do expect it to be
equal to a valid effective constraint value computed at a certain time
in the past (event though it may not be the most recent one), so add
READ|WRITE_ONCE() annotations around the target_value accesses to
prevent the compiler from possibly causing that expectation to be unmet
by generating code in an exceptionally convoluted way.

Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: borrow the commit log from Rafael.

 kernel/power/qos.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index 32927682bcc4..db0bed2cae26 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -52,7 +52,7 @@ static DEFINE_SPINLOCK(pm_qos_lock);
  */
 s32 pm_qos_read_value(struct pm_qos_constraints *c)
 {
-	return c->target_value;
+	return READ_ONCE(c->target_value);
 }
 
 static int pm_qos_get_value(struct pm_qos_constraints *c)
@@ -75,7 +75,7 @@ static int pm_qos_get_value(struct pm_qos_constraints *c)
 
 static void pm_qos_set_value(struct pm_qos_constraints *c, s32 value)
 {
-	c->target_value = value;
+	WRITE_ONCE(c->target_value, value);
 }
 
 /**
-- 
2.21.0 (Apple Git-122.2)

