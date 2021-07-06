Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15EA3BDE38
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jul 2021 21:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhGFT6U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Jul 2021 15:58:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31763 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229984AbhGFT6U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Jul 2021 15:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625601340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=l48cLKIP4BLYpRskzPjaknnhgQT9va3wQwvPL+4/Sx0=;
        b=ffpUIpbJE+J/GmMZKi6kc4KMbiSp9w2n/W2jyw280ctV/wta+c5tAJHnHppgs7FaClLpxv
        OTygzyXIq6SWMKZhb518ijDir02EdF7tyRyrYTpTj4eTFhOO9CcAwvJttbcFUe5z1UoI/j
        QT16dFc9k4yudDA84WFflpkatmw3pus=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-PTl6vPsJP-KKJVaaIutiZQ-1; Tue, 06 Jul 2021 15:55:39 -0400
X-MC-Unique: PTl6vPsJP-KKJVaaIutiZQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3B5D800D62;
        Tue,  6 Jul 2021 19:55:38 +0000 (UTC)
Received: from localhost (ovpn-113-53.rdu2.redhat.com [10.10.113.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9CBCF5D9D5;
        Tue,  6 Jul 2021 19:55:31 +0000 (UTC)
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH v2 0/2] add Watchdog Timer delay support for BQ24735
Date:   Tue,  6 Jul 2021 16:55:25 -0300
Message-Id: <20210706195527.371108-1-bmeneg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

Bruno Meneguele (2):
  power: supply: bq24735: reorganize ChargeOption command macros
  power: supply: bq24735: add watchdog timer delay support

 .../bindings/power/supply/bq24735.yaml        | 13 ++++
 drivers/power/supply/bq24735-charger.c        | 75 ++++++++++++++++---
 include/linux/power/bq24735-charger.h         |  1 +
 3 files changed, 77 insertions(+), 12 deletions(-)

-- 
2.31.1

