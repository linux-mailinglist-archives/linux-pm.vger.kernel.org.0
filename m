Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 300FB711B5
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2019 08:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388163AbfGWGOx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jul 2019 02:14:53 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38354 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388176AbfGWGOx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jul 2019 02:14:53 -0400
Received: by mail-pg1-f194.google.com with SMTP id f5so10041572pgu.5
        for <linux-pm@vger.kernel.org>; Mon, 22 Jul 2019 23:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pE9tUu3P/8w1bftggmV11VxGbS0rl+eqvKACn21icvM=;
        b=ukFG103PF/bL7cLvjS/DEUm8Y+TFfzbryVSM7lnY7E2JAgqNadFQXZ+zzONmjxQRvN
         /UNtFxcDJE9E6GT1fFhmaNEdT0U6LY+fM7OLyuzdFbiF9pq/AOtrPPYgpCD7pQyMpqT8
         RxNXI3sOAH+3hgE3B2gEyn6lDVa9opE8HSLJBn14tv10YYA8aPxKAtF8dkorCTcbJOLV
         JO7eYBtRjWSkQ5J09nJfN2iaEb1vbuaov0kgzMGIN6hiJzic3uaEe2jgeHQrAJIqdUZn
         DjqcHIFUYDCeqAjsTvjUIo5ZGlM7ySIuaLaeWa7YvtT2/mQ9Y+PamXkRp5Yyii2rH4zi
         ipuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pE9tUu3P/8w1bftggmV11VxGbS0rl+eqvKACn21icvM=;
        b=Ggz4vbJpAkk69HrXCNBGjkzSWveyUm3P3Hpn4zRNZS1ST8yjdo76d7T3fKDoOCnyR7
         3wv0YaDruIlQ+Sf9r0apFUhoSIfyt7jtz2ILpOwnHT8qCuJ9RWNHrqQjwMJIKaCdfWDL
         v1U5bHgT7Fr9l+j2UEL00MMOk4ihST5UGB64k9/irvlMUztG5EQhTipOEXyZ1Z1i2ams
         2xgANhwf+oR35mO7iNt3oN+RvGrRr4PqESeQH9MNcU7mr/LjfrLv2YhH5VjM1fg/IVcj
         UtkyTg0Ys9Z1IWatLNYLQBumiEnqj2zG1iKxJpJ9MfKGWFZ2+y99xAayY2/vyat12j8+
         Mdaw==
X-Gm-Message-State: APjAAAXqEqTyPXG8mSe88FRhbCjh/FwgNtDr3g/kR5YAYN0xdzZ2QjOr
        9ZAtMwEDFhu7xPsUNFtvMVQBVYM0oQI=
X-Google-Smtp-Source: APXvYqwGQ+U0AMsik4H8UPxZf/Ydr0V0LliUR9Neva7b1FE5jVZtVNnSanLdcxXeoCgYKlNZL4RE1w==
X-Received: by 2002:aa7:90d8:: with SMTP id k24mr4051781pfk.115.1563862492359;
        Mon, 22 Jul 2019 23:14:52 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id f3sm65402869pfg.165.2019.07.22.23.14.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 23:14:51 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 10/10] Documentation: cpufreq: Update policy notifier documentation
Date:   Tue, 23 Jul 2019 11:44:10 +0530
Message-Id: <c90b601734b9828aeb93b8317205aff791660a2d.1563862014.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
In-Reply-To: <cover.1563862014.git.viresh.kumar@linaro.org>
References: <cover.1563862014.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Update documentation with the recent policy notifier updates.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/cpu-freq/core.txt | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/Documentation/cpu-freq/core.txt b/Documentation/cpu-freq/core.txt
index 55193e680250..ed577d9c154b 100644
--- a/Documentation/cpu-freq/core.txt
+++ b/Documentation/cpu-freq/core.txt
@@ -57,19 +57,11 @@ transition notifiers.
 2.1 CPUFreq policy notifiers
 ----------------------------
 
-These are notified when a new policy is intended to be set. Each
-CPUFreq policy notifier is called twice for a policy transition:
+These are notified when a new policy is created or removed.
 
-1.) During CPUFREQ_ADJUST all CPUFreq notifiers may change the limit if
-    they see a need for this - may it be thermal considerations or
-    hardware limitations.
-
-2.) And during CPUFREQ_NOTIFY all notifiers are informed of the new policy
-   - if two hardware drivers failed to agree on a new policy before this
-   stage, the incompatible hardware shall be shut down, and the user
-   informed of this.
-
-The phase is specified in the second argument to the notifier.
+The phase is specified in the second argument to the notifier.  The phase is
+CPUFREQ_CREATE_POLICY when the policy is first created and it is
+CPUFREQ_REMOVE_POLICY when the policy is removed.
 
 The third argument, a void *pointer, points to a struct cpufreq_policy
 consisting of several values, including min, max (the lower and upper
-- 
2.21.0.rc0.269.g1a574e7a288b

