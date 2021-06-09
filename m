Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A28403A10D0
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jun 2021 12:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbhFIKE7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Jun 2021 06:04:59 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:38719 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbhFIKE6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Jun 2021 06:04:58 -0400
Received: by mail-lf1-f47.google.com with SMTP id r5so37179332lfr.5
        for <linux-pm@vger.kernel.org>; Wed, 09 Jun 2021 03:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c+obMq8PkB/J8Gdch4+1xb+KTFZm3rBY/BnhHmvQsV4=;
        b=eU39jTtEgR1GfHTSSAqzHh+RGy59HSkMiKWeIm09OWilH4HdLfnzNvGEZ0UIpD2qaY
         eoxivEtj4oox16nimgTMac45NRT/pF1gN2ujJrLOvRvG+JRR8NsY1uUqaAg7GxiSWsSh
         142XtSfyxIsOGCjxLemGLwdjL0Zx/6E/VT56/jWdUI0stijRfcsdP4kUK2zSGrwLYiC1
         lQCcxSAUBOQ38Mfn8B8pvm+dGOyj6ISEyKCR7KMPiziySnAvnvuCQk4yNn9xM71Zqhc6
         9aTJmbK39jfklrBfF7fkGAtQ7YVn9eN63Hktfra24OD+kyjQZp63g34zI6w5Cli6uqpa
         8iMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c+obMq8PkB/J8Gdch4+1xb+KTFZm3rBY/BnhHmvQsV4=;
        b=MlHs3bBSVHV1IQgvCPM4jdKxpPyPVldLIfTUqfkfjhkVzKU2CPS0EeM4xnCR90D7uk
         MxVU3Grp6UIp55npy9RDCiuTzbyLev5Ly6xMDizZoqddcOjjYaiAeRPImURE0cYNnhrI
         71gJYLk175gK0vYmIZPiO9jhPzRz9y8aBbY2ER2L4jF5M49MNuYkuGeVXUYWrS2+SsKw
         F6QVTAdh0ra2gHqcYjSI7yIknJiE5lwMkKPYQempvAwE9jo+Gcv6l7aQuUevSPqAvkhi
         U6TJlZ+ysqhHeowL9+DKdzFWAk70fqUShqbRJlPV8oFeJjRDk7THRYz3GSFXMCn11jlv
         pLHQ==
X-Gm-Message-State: AOAM533dK7YCgJ3ahzYS/YDJ6AhyySbm0lYOi4dx0W5610j1QWZmm2Tc
        JDb0Aae6+9IZjnpH6iM9P2n6pQ==
X-Google-Smtp-Source: ABdhPJz/JqTi8eCZ9SlLhcOgRDcSvhoHDrLDQjmIIP5Iq56QWpjOlyySou2dxMQOppHxqQHaBYMOlg==
X-Received: by 2002:ac2:5ccd:: with SMTP id f13mr18641335lfq.185.1623232923531;
        Wed, 09 Jun 2021 03:02:03 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id w24sm300041lfa.143.2021.06.09.03.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 03:02:02 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] PM: runtime: Clarify documentation when callbacks are unassigned
Date:   Wed,  9 Jun 2021 12:01:57 +0200
Message-Id: <20210609100157.97635-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Recent changes to the PM core allows ->runtime_suspend|resume callbacks to
be unassigned.

In the earlier behaviour the PM core would return -ENOSYS, when trying to
runtime resume a device, for example. Let's update the documentation to
clarify this.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- Fix spelling and further clarified the behaviour, according to
	comments from Alan.

---
 Documentation/power/runtime_pm.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
index 18ae21bf7f92..3d09c9fd450d 100644
--- a/Documentation/power/runtime_pm.rst
+++ b/Documentation/power/runtime_pm.rst
@@ -827,6 +827,14 @@ or driver about runtime power changes.  Instead, the driver for the device's
 parent must take responsibility for telling the device's driver when the
 parent's power state changes.
 
+Note that, in some cases it may not be desirable for subsystems/drivers to call
+pm_runtime_no_callbacks() for their devices. This could be because a subset of
+the runtime PM callbacks needs to be implemented, a platform dependent PM
+domain could get attached to the device or that the device is power manged
+through a supplier device link. For these reasons and to avoid boilerplate code
+in subsystems/drivers, the PM core allows runtime PM callbacks to be
+unassigned.
+
 9. Autosuspend, or automatically-delayed suspends
 =================================================
 
-- 
2.25.1

