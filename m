Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68ECC3EDBB7
	for <lists+linux-pm@lfdr.de>; Mon, 16 Aug 2021 18:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhHPQxX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Aug 2021 12:53:23 -0400
Received: from server34.i7host.com.br ([186.227.200.26]:47090 "EHLO
        server34.i7host.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbhHPQxX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Aug 2021 12:53:23 -0400
X-Greylist: delayed 2006 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Aug 2021 12:53:22 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=smartgreen.net; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kaujpLkHTzp+AFdivFztPDuqgCjSQCzDQFwNHpFbg7I=; b=21mvHC26UMKImymtYAxT3h+X1G
        koslLtyhg3MD6JMCzpdUGn5FUFwLX0axSqoR4QtPURo6KR4cqyyl/t/Vpa74qIslBB2Uxg1DI6bnc
        QKaxNWzyJ/QpLl4lpmfy4auSR71V01Pj+0tfudIadBHxy/PlCJMFaLTyBLwmgExBQcz+OXVdayzvr
        Ko5FDkeOaFbwOExEknGtswB5VOj+Qx/JZnJR4rij/N0JrLDvbStB/qbdD9yaqm8ZXE1lG8+vYBjTi
        2CtVwHWN01aCGmvFA2oHoU/vo26b7kEaFiCW2OtSsfqAM6khw7GxsvL+U/Vjrbksv73V6MTn3sIxC
        uzaIP1rQ==;
Received: from [177.220.172.187] (port=34283 helo=localhost)
        by server34.i7host.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <bruno.meneguele@smartgreen.net>)
        id 1mFfqx-00GtZ0-OA; Mon, 16 Aug 2021 13:52:48 -0300
From:   Bruno Meneguele <bruno.meneguele@smartgreen.net>
To:     sre@kernel.org, robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bruno Meneguele <bruno.meneguele@smartgreen.net>
Subject: [PATCH v4 0/2] add Watchdog Timer delay support for BQ24735
Date:   Mon, 16 Aug 2021 13:52:43 -0300
Message-Id: <20210816165245.40416-1-bruno.meneguele@smartgreen.net>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server34.i7host.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - smartgreen.net
X-Get-Message-Sender-Via: server34.i7host.com.br: authenticated_id: bruno.meneguele@smartgreen.net
X-Authenticated-Sender: server34.i7host.com.br: bruno.meneguele@smartgreen.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The IC BQ24735 has the ability to suspend the battery charging in case the
system freezes for some reason: the IC observes consecutive writes for
either CargeCurrent of ChargVoltage registers in a maximum period of time.

This period of time can be configured by the user through the ChargeOption
register in the bits 13 and 14, but it's only possible to change if the user
sends the value directly accessing the I2C bus through userspace, because
the kernel driver doesn't read or write to the Watchdog bits.

This patchset enables the user to configure the value through the
device-tree option "ti,wdt-timeout".

Changelog:
  v3 - add specific patch for the dt bidings change.
     - patch 1/2 was already queued to the tree, so it's not present in this
	   patchset anymore.
  v2 - unfortunately I used a default gitconfig that was pointing to my
  default user.email and email smtp. This new version corrects it.

Bruno Meneguele (2):
  power: supply: bq24735: add watchdog timer delay support
  dt-bindings: power: supply: bq24735: document the watchdog timer delay
    feature

 .../bindings/power/supply/bq24735.yaml        | 15 ++++++
 drivers/power/supply/bq24735-charger.c        | 54 +++++++++++++++++++
 include/linux/power/bq24735-charger.h         |  1 +
 3 files changed, 70 insertions(+)

-- 
2.31.1

