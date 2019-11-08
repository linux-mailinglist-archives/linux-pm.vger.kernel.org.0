Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A395BF579E
	for <lists+linux-pm@lfdr.de>; Fri,  8 Nov 2019 21:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731850AbfKHTcZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Nov 2019 14:32:25 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:55634 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729896AbfKHTcZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Nov 2019 14:32:25 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1AE0361278; Fri,  8 Nov 2019 19:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573241545;
        bh=pcBY0JDgChjopWSMafJKNgPysJW8h1LmeUzT499LVRY=;
        h=From:To:Cc:Subject:Date:From;
        b=CS52kG1tEHjltWvV93NkL6lmtm/RJ0z7sgW5JcKgDNhIEqALby2nxgSDQZgCshxV+
         8+mG2F8XvwQ8c6wjT0tj6ylTFiE2vo5Z4R8gGzhpRz+06U0TLJm2Cd8uX3HqHkODEF
         ITxhuaJOfjiilGnnG03J/2RHN13lAN52VtqtRMr4=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from eberman-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: eberman@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 379E060D5C;
        Fri,  8 Nov 2019 19:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573241544;
        bh=pcBY0JDgChjopWSMafJKNgPysJW8h1LmeUzT499LVRY=;
        h=From:To:Cc:Subject:Date:From;
        b=VnYSHnWuK/Ci+gauRQl8dk2aAHGUa4lFUrcxZqfxc9nct0mH4NUA8fqzTbk14AfuM
         0VANaZpj+BF5ak1gqtVkkGJZNE59QRMRlTKCwnbjan4lrYjj8Wu7PaSD8VB0cc0OLq
         HuBMO+xiZ4Tw7JewXsZSlP8rVyeA5oAhOfbLiUzM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 379E060D5C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=eberman@codeaurora.org
From:   Elliot Berman <eberman@codeaurora.org>
To:     sre@kernel.org, tkjos@google.com
Cc:     tsoni@codeaurora.org, rananta@codeaurora.org,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Elliot Berman <eberman@codeaurora.org>
Subject: [PATCH 0/2] Support reboot power-off driver as module
Date:   Fri,  8 Nov 2019 11:32:10 -0800
Message-Id: <1573241532-21554-1-git-send-email-eberman@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series supports reboot power-off driver as a module by exporting
reboot_mode symbol.

Elliot Berman (2):
  reboot: Export reboot_mode
  power: reset: Enable tristate on restart power-off driver

 drivers/power/reset/Kconfig | 2 +-
 kernel/reboot.c             | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

