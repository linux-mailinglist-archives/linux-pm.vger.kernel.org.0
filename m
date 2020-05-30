Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CF31E92A3
	for <lists+linux-pm@lfdr.de>; Sat, 30 May 2020 18:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgE3Qdm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 30 May 2020 12:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbgE3Qdm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 30 May 2020 12:33:42 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395A5C03E969;
        Sat, 30 May 2020 09:33:42 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id x1so5116840ejd.8;
        Sat, 30 May 2020 09:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=KnghmerSNdwoxGexYivjS5o548htuxNSrbhg+RVRtPQ=;
        b=er6kemQP2Y+MzHzHZ6ORCyJ9vb1OE6uFyoA2okXI7qTG75+1L0Vnkzvtts0aVlb9zL
         fkmJxEzxXIKXf1dF1CZnjdrn2VjpeM4qE8XR+fb314nrzpKRgJTeV4UR4lDlkxvJLVM7
         OBW2UhrkdG1RluWyQAtwLuU3t48IboIl1W/RNob5Kdjo1jgAvjFBDO48PemxgjvyF1rZ
         gFOfdWCKcdgnk7k3YVVxPGZS92jxjiylqFQUOBA8F9LsRws0zlKgdZA1RtitcUJwSXgC
         N1IdP3YKOK2VxutVGp01G5x5bF/I4Uc8OwDIb6EHm56t3Peaix8mg9n1xCUZJgoAWXLd
         nJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=KnghmerSNdwoxGexYivjS5o548htuxNSrbhg+RVRtPQ=;
        b=JosgYOvICUdKdXLM2F5MZYT4u7ExdOc8fvN/gE89osmkUuYPQGsgva8l+DRyDGS3f2
         4De5snt/JgbHRku1ekV3oM6DWNdveaui4ZpjegLJ/AvXge7ezpTXRFCiTFFN0QDntFQz
         xlYxlJYZEleEUu7fkkVozX+mESWzpcJETPmPswol1iTi3NuUilHj98/M/yj5oU3Tj0OD
         8757Bv661ZkPoM3JKgTjsmTyCdJ6uYhx+lgsU7qofLWltwarj8Gk5ROIhEvCCJZhASpB
         5/PEXF6O4GrjY9x9X5S+LE5vxIGAP6n5UtvI33CY6HjqMXLb4Aj+ongstJ4wFHjx/L2H
         S3hg==
X-Gm-Message-State: AOAM530cxaAtyl8Ij9QRs1muRXiGOidK5E7/IBbGvmXj73+6tCi5//Zw
        QsZSYfjBDc93Xdoy500N4uq3Vq7g
X-Google-Smtp-Source: ABdhPJz7Rpf0OLy1MxXwnNbI9BzsI4rayT0P5TXJKfzVinlbJpTcf36wPBgioNd8W07VmIUwCWsMTQ==
X-Received: by 2002:a17:906:1442:: with SMTP id q2mr12064078ejc.33.1590856420605;
        Sat, 30 May 2020 09:33:40 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f23:5700:9c9f:9224:f2fc:26c2? (p200300ea8f2357009c9f9224f2fc26c2.dip0.t-ipconnect.de. [2003:ea:8f23:5700:9c9f:9224:f2fc:26c2])
        by smtp.googlemail.com with ESMTPSA id b15sm10685016edj.37.2020.05.30.09.33.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 May 2020 09:33:40 -0700 (PDT)
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] PM: runtime: add RPM_IDLE_SUSPEND / RPM_IDLE_NO_SUSPEND
 constants
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <94fe944c-c528-9459-fc75-7c94273dd2b1@gmail.com>
Date:   Sat, 30 May 2020 18:33:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

runtime_idle() callback implementations have to return a non-zero value
if they don't intend to suspend now. Several drivers use an errno like
-EBUSY for this purpose. This can be problematic because the return
value is propagated up the call chain, from rpm_idle() to
__pm_runtime_idle(), and from there to callers like
pm_runtime_put_sync(). A driver author checking the return value of
e.g. pm_runtime_put_sync() may as usual check for retval < 0 and
bail out.
Therefore a positive value should be returned. To facilitate this
add constants RPM_IDLE_SUSPEND and RPM_IDLE_NO_SUSPEND.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/base/power/runtime.c |  6 +++++-
 include/linux/pm.h           | 10 ++++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 9f62790f6..4f529075e 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -453,7 +453,11 @@ static int rpm_idle(struct device *dev, int rpmflags)
 
  out:
 	trace_rpm_return_int_rcuidle(dev, _THIS_IP_, retval);
-	return retval ? retval : rpm_suspend(dev, rpmflags | RPM_AUTO);
+
+	if (retval == RPM_IDLE_SUSPEND)
+		return rpm_suspend(dev, rpmflags | RPM_AUTO);
+
+	return retval;
 }
 
 /**
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 121c104a4..971ed3d77 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -227,8 +227,9 @@ typedef struct pm_message {
  *
  * @runtime_idle: Device appears to be inactive and it might be put into a
  *	low-power state if all of the necessary conditions are satisfied.
- *	Check these conditions, and return 0 if it's appropriate to let the PM
- *	core queue a suspend request for the device.
+ *	Check these conditions, and return RPM_IDLE_SUSPEND if it's
+ *	appropriate to let the PM core queue a suspend request for the device.
+ *	Return RPM_IDLE_NO_SUSPEND if you don't want to suspend now.
  *
  * Several device power state transitions are externally visible, affecting
  * the state of pending I/O queues and (for drivers that touch hardware)
@@ -523,6 +524,11 @@ enum rpm_request {
 	RPM_REQ_RESUME,
 };
 
+enum rpm_idle {
+	RPM_IDLE_SUSPEND = 0,
+	RPM_IDLE_NO_SUSPEND,
+};
+
 struct wakeup_source;
 struct wake_irq;
 struct pm_domain_data;
-- 
2.26.2

