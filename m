Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99CDF43BD34
	for <lists+linux-pm@lfdr.de>; Wed, 27 Oct 2021 00:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240033AbhJZW33 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Oct 2021 18:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237280AbhJZW3X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Oct 2021 18:29:23 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4069CC061570
        for <linux-pm@vger.kernel.org>; Tue, 26 Oct 2021 15:26:58 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id x192so1845083lff.12
        for <linux-pm@vger.kernel.org>; Tue, 26 Oct 2021 15:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4v28znH3ilP2dY+qktW1gaanvklLYwkJDiEGKPadfko=;
        b=g83eg0nDZaoDqbwau4PfYXiKLyApLtNQQZjgkFI2uJT4wRoBdiBcPsQWJrwHRtBqw/
         U72PT+Lsa5nbGS1RgRlfoMNVeUEw1poXMnFXI+llKwbD6jRD0AvzN3LlUUlic2VHqNJM
         wwSLDLHxj8mz6iu2Q0ojGZUtLrRfG2jX7McF9grT9aJG6UUDer1p2mnevW7mtM6Cdvon
         t9WcCNTe0mJmwqRHHVSuYG9QlH/w0RAXwmwS1Xg5QekVOzFQtgJzXWQbrOnyUZktxjgy
         DzRXGIpIcQb6rw1dXdNinj+6faePaRQhrtlYpGfKsjwOaMdVUzgUrA8cvnOlc27GOXB2
         XDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4v28znH3ilP2dY+qktW1gaanvklLYwkJDiEGKPadfko=;
        b=6Eqpu8Aav0mktvOZNDNfXzNnKlahWR/Y8LlvbX0xKOsAG1z2aCLMFqrji+GcAGuUwT
         JMxGgA/CUfzuKtrAMv1dL3i3MCmM8KFO3oDKX8J+qSz+Ql2nSETwyFI6wBiDuZ0QzbBf
         EDxmghRJYgd3IrXCn1treVK0FgrKGOS4Nkgd2jvOiSFdf1PPRO/o2NVVzBn+Q6PZnl5Y
         SslHqpiDx2TK/ZhRgLjaIvOomzGp/bWuUufy2UtACKybWxkMDerYCJc/US9oes0yVmLW
         zOg3ed2YrqtliBwWO3U2h4rmUUOzcIGLirfnea7z1kFxs7nLZDwO60UACTZQ5uN6a3EU
         hrFQ==
X-Gm-Message-State: AOAM531cFwYhi29+5/AWMo333ZTzrUTIlZMl56Q4w9wDjS/1NpgMcTBh
        GMmpvcpGfgl1eM9RYF10+UM8mVadrD0Y2A==
X-Google-Smtp-Source: ABdhPJwzvk4FW4H7re68fFiY28R3LYk0CfvwdIfxKZJste2wqi2lNxLbAoljso4qwy0hmcnrtLLhoQ==
X-Received: by 2002:ac2:4bc1:: with SMTP id o1mr25286148lfq.553.1635287216613;
        Tue, 26 Oct 2021 15:26:56 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id bp13sm790352lfb.100.2021.10.26.15.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 15:26:55 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Kevin Hilman <khilman@kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PM: runtime: Allow rpm_resume() to succeed when runtime PM is disabled
Date:   Wed, 27 Oct 2021 00:26:26 +0200
Message-Id: <20211026222626.39222-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

During system suspend, the PM core sets dev->power.is_suspended for the
device that is being suspended. This flag is also being used in
rpm_resume(), to allow it to succeed by returning 1, assuming that runtime
PM has been disabled and the runtime PM status is RPM_ACTIVE, for the
device.

To make this behaviour a bit more useful, let's drop the check for the
dev->power.is_suspended flag in rpm_resume(), as it doesn't really need to
be limited to this anyway.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/runtime.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index ec94049442b9..fadc278e3a66 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -742,8 +742,8 @@ static int rpm_resume(struct device *dev, int rpmflags)
  repeat:
 	if (dev->power.runtime_error)
 		retval = -EINVAL;
-	else if (dev->power.disable_depth == 1 && dev->power.is_suspended
-	    && dev->power.runtime_status == RPM_ACTIVE)
+	else if (dev->power.disable_depth > 0 &&
+		dev->power.runtime_status == RPM_ACTIVE)
 		retval = 1;
 	else if (dev->power.disable_depth > 0)
 		retval = -EACCES;
-- 
2.25.1

