Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC53224527E
	for <lists+linux-pm@lfdr.de>; Sat, 15 Aug 2020 23:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbgHOVwJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 15 Aug 2020 17:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728968AbgHOVwC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 15 Aug 2020 17:52:02 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333A3C0F26D0
        for <linux-pm@vger.kernel.org>; Sat, 15 Aug 2020 10:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JvLghbUswUlpt0JwASQDrmBEnasLkSkpyvZGI85Q00k=; b=P29QJOzu0baa+1b186//OqzMLC
        iyaoiYkT7I4CXjFyF3EGi0RV7HOXpwICKD+xd0NIS2nxjArB1qO4SDzzZXDPN4TolRk3tLt5JogxW
        WSvPphoXQU6iCad09MbfvCwoAD6QPLQ3IMmYgAs4rK2Ojz1SIQYKf2mLdHYpxeLmLDL8=;
Received: from p200300ccff3e9c001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff3e:9c00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1k6zTg-0007Ic-I3; Sat, 15 Aug 2020 18:56:20 +0200
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1k6zTf-0002mV-Go; Sat, 15 Aug 2020 18:56:19 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     lee.jones@linaro.org, sre@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, b.galvani@gmail.com, phh@phh.me,
        letux-kernel@openphoenux.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 0/2] power: supply: RN5T618/RC5T619
Date:   Sat, 15 Aug 2020 18:56:08 +0200
Message-Id: <20200815165610.10647-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series adds support for the RN5T618/RC5T619 charger and fuel gauge.
Battery and input power status can be read.

Andreas Kemnade (2):
  power: supply: Add support for RN5T618/RC5T619 charger and fuel gauge
  mfd: rn5t618: Add a power supply subdevice

 drivers/mfd/rn5t618.c                |   1 +
 drivers/power/supply/Kconfig         |   8 +
 drivers/power/supply/Makefile        |   1 +
 drivers/power/supply/rn5t618_power.c | 565 +++++++++++++++++++++++++++
 4 files changed, 575 insertions(+)
 create mode 100644 drivers/power/supply/rn5t618_power.c

-- 
2.20.1

