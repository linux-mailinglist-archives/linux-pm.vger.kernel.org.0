Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC00A25B743
	for <lists+linux-pm@lfdr.de>; Thu,  3 Sep 2020 01:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgIBX1A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Sep 2020 19:27:00 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:10208 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbgIBX1A (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 2 Sep 2020 19:27:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1599089219; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=mLfSYK3OY8zJ6PTjapJaaKs8A12+ZVUJnELGF6xd22Y=; b=YWvEMwRarwm8BIKZ9oMoH/5Wa9vIChVhaRuQIv/yUVVONaAyKXGowzbd4ji/1KPM9h1Jj57e
 QFyygWWRTwTBdYUMdu52QNsZY6qKqQGLb6erHriCjNyzJ97628j3FJ+lnM1CZGIBGLaWYOXW
 o8tWA3RLJOe7XNqPnujqLCLI0Q0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f502a39ba408b30ce7352f4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Sep 2020 23:26:49
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D5BD0C433CB; Wed,  2 Sep 2020 23:26:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D5542C433C6;
        Wed,  2 Sep 2020 23:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D5542C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     rjw@rjwysocki.net, ulf.hansson@linaro.org, linux-pm@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>
Subject: [RFC PATCH 0/2] Better domain idle from device wakeup patterns
Date:   Wed,  2 Sep 2020 17:25:44 -0600
Message-Id: <20200902232546.31240-1-ilina@codeaurora.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

I was looking for an option to do better power management for some
domains where the devices enter runtime PM in a predictable fashion. For
example a display device that sends a vsync interrupt every 16 ms for a
60 Hz panel. These interrupts are not timer interrupts but tend to
interrupt periodically to service the workflow and the devices and
domains may go back to idle soon after. Two domains are affected by this
- the device's PM domain and the CPU PM domain.

As a first step, I am looking to solve for the device's PM domain idle
state (and hopefully solve for the CPU PM domains subsequently). The PM
domain could have multiple idle states and/or the enter/exit latencies
could be high. In either case, it may not always be beneficial to power
off the domain, only to turn it back on before satisfying the idle state
residency. When the wakeup is known for the device, we could use that to
determine the worthiness of entering a domain idle state. Only the
device can tell us when the future event would be and that could change
as the usecase changes. Like, when the panel refresh rate increases to
120 Hz. If this information was made available to runtime PM, we could
use that in the domain governor to determine a suitable idle state. This
is the idea behind these patches.

In the first patch, I am proposing an API for devices to specify their
wakeup as a time in the future and in the second patch, I am updating
the PM domain governor to use this information to determine the idle
state. I have not had a chance to test this out yet, but I wanted to
know if I am on the right track.

Would appreciate your thoughts on this.

Thanks,
Lina


Lina Iyer (2):
  PM / runtime: register device's next wakeup
  PM / Domains: use device's next wakeup to determine domain idle state

 drivers/base/power/domain_governor.c | 87 ++++++++++++++++++++++++++--
 drivers/base/power/runtime.c         | 31 ++++++++++
 include/linux/pm.h                   |  2 +
 include/linux/pm_domain.h            |  1 +
 include/linux/pm_runtime.h           |  1 +
 5 files changed, 116 insertions(+), 6 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

