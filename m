Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07BCA28F93B
	for <lists+linux-pm@lfdr.de>; Thu, 15 Oct 2020 21:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbgJOTKN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Oct 2020 15:10:13 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:28416 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728431AbgJOTKN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 15 Oct 2020 15:10:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602789012; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=zAQJQUCgdRRjT6p0To1xBZqcCKI1odXJLI89jNF6pYA=; b=PC21Jpplhh/kxNjPn0C3rdwgEVP/i/34O+0yF4gqjL/cPJMu3Xem70HFWINnEdjijWJ/GKs0
 TS1xArgZHQmDoD7dgBFYmkh5ePH+AvHVGJcoG7HIIHSpfjLXpSMXbdGV5hcsupoGi7Nxl/3i
 rHf2ulTrgMfT/3Yiqv0Cs/5n7hg=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5f889e9183370fa1c17818ea (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 15 Oct 2020 19:10:09
 GMT
Sender: ilina=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 53844C433CB; Thu, 15 Oct 2020 19:10:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7EA38C433FE;
        Thu, 15 Oct 2020 19:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7EA38C433FE
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     rjw@rjwysocki.net, ulf.hansson@linaro.org, linux-pm@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v2 0/2] Better domain idle from device wakeup patterns
Date:   Thu, 15 Oct 2020 13:10:01 -0600
Message-Id: <20201015191003.1413-1-ilina@codeaurora.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Changes since v1 [2]:
- Update documentation and commit text
- Remove check for runtime PM when setting next_event
- Fix kernel-test robot reported issue

Changes since RFC [1]:
- Organized the code to make it cleaner
- Fixed some issues with idle state determination
- Add documentation and update commit text

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

Would appreciate your thoughts on this.

Thanks,
Lina

[1]. https://lore.kernel.org/linux-pm/010101746eccb270-05beb27f-e1e4-40eb-92da-ad1bb48feb41-000000@us-west-2.amazonses.com/T/
[2]. https://lore.kernel.org/linux-pm/20201012223400.23609-3-ilina@codeaurora.org/T/#u

Lina Iyer (2):
  PM / runtime: inform runtime PM of a device's next wakeup
  PM / Domains: use device's next wakeup to determine domain idle state

 Documentation/power/runtime_pm.rst   | 23 +++++++-
 drivers/base/power/domain_governor.c | 83 ++++++++++++++++++++++++++--
 drivers/base/power/runtime.c         | 24 ++++++++
 include/linux/pm.h                   |  2 +
 include/linux/pm_domain.h            |  1 +
 include/linux/pm_runtime.h           |  1 +
 6 files changed, 126 insertions(+), 8 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

