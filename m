Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8CBF5BEA
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2019 00:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfKHXlB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Nov 2019 18:41:01 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:38768 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfKHXlA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Nov 2019 18:41:00 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D946C61410; Fri,  8 Nov 2019 23:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573256459;
        bh=noLSgoNx5TgnrkBUB1ATBaEyb6JwUdPGlfUPxoqPH5w=;
        h=From:To:Cc:Subject:Date:From;
        b=lK0ON50fFrAC2Fzj626doKVR7dlV6HrCVeQCN9tfXL+iRaY3oO18rp8KdpXscyxCM
         +F/F6LoJ+v0rcmCtwMIIGBhWvXRkA4piP9uctVZjLQf2Ow33x3zcfE1fZFZn4a69AQ
         oHqLCq3XJ/VBY+NopLU+/tNab4ITol+xPlwq04Yg=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E066161135;
        Fri,  8 Nov 2019 23:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573256459;
        bh=noLSgoNx5TgnrkBUB1ATBaEyb6JwUdPGlfUPxoqPH5w=;
        h=From:To:Cc:Subject:Date:From;
        b=lK0ON50fFrAC2Fzj626doKVR7dlV6HrCVeQCN9tfXL+iRaY3oO18rp8KdpXscyxCM
         +F/F6LoJ+v0rcmCtwMIIGBhWvXRkA4piP9uctVZjLQf2Ow33x3zcfE1fZFZn4a69AQ
         oHqLCq3XJ/VBY+NopLU+/tNab4ITol+xPlwq04Yg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E066161135
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=eberman@codeaurora.org
From:   Elliot Berman <eberman@codeaurora.org>
To:     sre@kernel.org, tkjos@google.com, gregkh@linuxfoundation.org
Cc:     tsoni@codeaurora.org, rananta@codeaurora.org,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Elliot Berman <eberman@codeaurora.org>
Subject: [PATCH v2 0/2] Support reboot power-off driver as module
Date:   Fri,  8 Nov 2019 15:40:50 -0800
Message-Id: <1573256452-14838-1-git-send-email-eberman@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series supports reboot power-off driver as a module by exporting
reboot_mode symbol.

Changes since V1:
 - EXPORT_SYMBOL -> EXPORT_SYMBOL_GPL

Elliot Berman (2):
  reboot: Export reboot_mode
  power: reset: Enable tristate on restart power-off driver

 drivers/power/reset/Kconfig | 2 +-
 kernel/reboot.c             | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

