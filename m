Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5169C1E6944
	for <lists+linux-pm@lfdr.de>; Thu, 28 May 2020 20:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405755AbgE1SZk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 May 2020 14:25:40 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:56330 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405788AbgE1SZj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 May 2020 14:25:39 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id D7FFB30DD34;
        Thu, 28 May 2020 11:19:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com D7FFB30DD34
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1590689965;
        bh=GQcrRpTxCYDTqBkDDmPavBT5QqGizo4E8hzdCo8uCqY=;
        h=From:To:Cc:Subject:Date:From;
        b=B5VSgSdIrnCNhxOhx6YodBzpTnSID5q/PxH7oLjWaJgyIdeopDHcD+d5DAOFmwwlz
         IvuBLGdYcJShBlK5FOzL+XxP2ShGQatyW+X/tO6OXo/6akRn9DsW4L15HvVOqsD+eW
         wf5lLOU4Dik0BFS29AIaGLeMau9dRDvYpCnYH81w=
Received: from lbrmn-mmayer.ric.broadcom.net (lbrmn-mmayer.ric.broadcom.net [10.136.28.150])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 21A61140069;
        Thu, 28 May 2020 11:19:25 -0700 (PDT)
From:   Markus Mayer <markus.mayer@broadcom.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Markus Mayer <markus.mayer@broadcom.com>,
        Linux Power Management List <linux-pm@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] brcmstb-avs-cpufreq updates
Date:   Thu, 28 May 2020 11:19:18 -0700
Message-Id: <20200528181921.19846-1-mmayer@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

Here is a collection of little, independent improvements to the
brcmstb-avs-cpufreq driver.

- more flexible interface for __issue_avs_command()
  This change makes the function more versatile as it can handle input
  and output parameters at the same time.
- Support polling AVS firmware
  This change allows the driver to use polling if interrupt driven mode
  doesn't work for some reason.
- send S2_ENTER / S2_EXIT commands to AVS
  Let the AVS firmware know when we are about to enter, or have just
  exited, S2 mode.

Regards,
-Markus

Florian Fainelli (1):
  cpufreq: brcmstb-avs-cpufreq: Support polling AVS firmware

Markus Mayer (2):
  cpufreq: brcmstb-avs-cpufreq: more flexible interface for
    __issue_avs_command()
  cpufreq: brcmstb-avs-cpufreq: send S2_ENTER / S2_EXIT commands to AVS

 drivers/cpufreq/brcmstb-avs-cpufreq.c | 89 ++++++++++++++++++---------
 1 file changed, 59 insertions(+), 30 deletions(-)

-- 
2.17.1

