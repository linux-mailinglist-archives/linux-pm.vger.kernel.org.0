Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8902941D8
	for <lists+linux-pm@lfdr.de>; Tue, 20 Oct 2020 20:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732752AbgJTSEl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Oct 2020 14:04:41 -0400
Received: from z5.mailgun.us ([104.130.96.5]:64429 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408912AbgJTSEl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Oct 2020 14:04:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603217080; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=O6TrI1os+Nq6JaPzk+jrqIU+a9nVuxC0Tp0EqiN3xYU=; b=tNvjg8uypEJK7Hhamz1WZSjIfZ8jp/kr+LLnhBJwexTJZSxOe+EojFLPyPJLSFKozE4oDH+6
 Vy9JPERv2+XdxKlPsWlHF9vtvW7Tb+v9ZNxOBRCw/z+9MS4+r59s/xvRNckp4eck6omrMXxE
 gFmtE9LmLULlJxfN6jv3DhPcT7Y=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f8f26ae319d4e9cb581cd1b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 20 Oct 2020 18:04:30
 GMT
Sender: ilina=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A8E36C43385; Tue, 20 Oct 2020 18:04:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 80A5EC433CB;
        Tue, 20 Oct 2020 18:04:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 80A5EC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=ilina@codeaurora.org
From:   Lina Iyer <ilina@codeaurora.org>
To:     rjw@rjwysocki.net, ulf.hansson@linaro.org, linux-pm@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH v4 0/2] Better domain idle from device wakeup patterns
Date:   Tue, 20 Oct 2020 12:04:11 -0600
Message-Id: <20201020180413.32225-1-ilina@codeaurora.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Changes since v3 [3]:
- Move the next_wakeup info of the device deeper into the device's
  domain data. This should avoid overhead for devices that do not have a
  predictable wakeup pattern. 

Changes since v2:
- Fix unwanted change

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
[3]. https://lore.kernel.org/linux-pm/20201015193807.17423-1-ilina@codeaurora.org/

Lina Iyer (2):
  PM / domains: inform PM domain of a device's next wakeup
  PM / Domains: use device's next wakeup to determine domain idle state

 drivers/base/power/domain.c          | 36 ++++++++++++
 drivers/base/power/domain_governor.c | 84 ++++++++++++++++++++++++++--
 include/linux/pm_domain.h            |  9 +++
 3 files changed, 124 insertions(+), 5 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

