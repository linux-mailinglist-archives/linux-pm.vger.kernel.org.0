Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE6E1F5FBC
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jun 2020 03:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgFKByV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jun 2020 21:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbgFKByE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jun 2020 21:54:04 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EA4C08C5C3
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2020 18:54:03 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ne5so1587776pjb.5
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2020 18:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7FIHdEi8UE53+gw/wkyvavC5pix798rp5qt0URRecvU=;
        b=XtvA4Ph3g3MspYhX7MexC/1pPRVk8clbXmFgZwPX+0uFXwvuCcMAkL3nYEuJBoOnuJ
         tZmkRbXGrnZRApp9+PDNUzEZPdvrhqhgOfv6hBlfHM1W2PnxmDhEmspyc0hRZHz167Wg
         QO0Zsa+OSzvbCLDiAAW1FEy5j6torlfwDO6+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7FIHdEi8UE53+gw/wkyvavC5pix798rp5qt0URRecvU=;
        b=NyjZT0t4j3SonB+SjjRiKQmv6qxpLqk1Zj7+NeNY97HZkREUdpbu8bZSIk1zu9zVJ2
         6+Mrql2W/pWgi2ETs+kxabK7c9wPU/kajPYhBxKUBYgSJOYzM0meANAZOYIH0LKgxSWq
         rVatZl/+zSr466AXeDL/9HtZLBaDiFYKsvuy0BBB3zW/4vc2N7dpkmbQneUkjNtZ3RBW
         8VNS5m2oAvYgI6P7dBXiuI5REfJN5K8VEnhNcPytZFwdvMOUj9eap/WSX2uTY5z6A4Ro
         RR50s5o2zdvoIwGKr/DY6dtWXaZOUsWLaEu8zdA5IzWtQ7DlWEOnaNGQJ889/jnHYjn4
         2NBQ==
X-Gm-Message-State: AOAM532Oqi80g7W91c11YznMeol1BDr/AGwV/uMLk36wMxmHHMvst2DY
        mXlqzs4g2NxKDb5UFOly+rTHHg==
X-Google-Smtp-Source: ABdhPJwm1qpCZt/RJk/duXvKTfZz6w74AwJtNSO3tuhVfXLQAx19+C/jnR6GatyZcF1ohWTIaI2+SQ==
X-Received: by 2002:a17:90a:ae04:: with SMTP id t4mr5472625pjq.131.1591840443230;
        Wed, 10 Jun 2020 18:54:03 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id b191sm998661pga.13.2020.06.10.18.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 18:54:02 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtman.org, linux-bluetooth@vger.kernel.org
Cc:     alainm@chromium.org, chromeos-bluetooth-upstreaming@chromium.org,
        mka@chromium.org, dianders@chromium.org, linux-pm@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Bluetooth: btmrvl_sdio: Refactor remote wakeup support
Date:   Wed, 10 Jun 2020 18:53:52 -0700
Message-Id: <20200611015355.186666-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi linux-bluetooth,

This patch series is refactoring the btmrvl driver to add better support
for controlling remote wakeup during suspend. Previously, the hci device
was getting created as /sys/devices/virtual/bluetooth/hci0 and there
wasn't a way to control wakeup for the device from userspace. This
series of changes adds the proper parent for the hci device, allows irq
configuration via power/wakeup and properly disables scanning during
suspend if wakeup isn't enabled.

This was tested on a Veyron Mighty Chromebook running the 4.19 kernel
with these patches. It passes both automated and manual suspend+resume
tests that make sure wakeup is working properly.

Thanks
Abhishek



Abhishek Pandit-Subedi (3):
  Bluetooth: btmrvl_sdio: Set parent dev to hdev
  Bluetooth: btmrvl_sdio: Implement prevent_wake
  Bluetooth: btmrvl_sdio: Refactor irq wakeup

 drivers/bluetooth/btmrvl_main.c | 11 +++++++++++
 drivers/bluetooth/btmrvl_sdio.c | 13 ++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

-- 
2.27.0.278.ge193c7cf3a9-goog

