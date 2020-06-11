Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D90E51F5FB3
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jun 2020 03:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgFKByF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jun 2020 21:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgFKByE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jun 2020 21:54:04 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937BDC08C5C3
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2020 18:54:04 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bg4so1705967plb.3
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2020 18:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YeNSbkNZdz3UbDAq71dC4QETLSzCwObNDb/ZTU7KYpw=;
        b=a7jVBd3hCZ19FEnc7qi+cVMxFYFf1JeFjV78BrHVBioQuynMLoW65YnsQ2L8URbTCh
         dzN1oF+HlLtzojDsVmi2NIlE6YNxhzUgWX5r6LHEeGAeYXZ9Fjl1NJ6bgRowMNa1TQHy
         1mcQupHAKBJCcpt1tDvQDfTJSWKVhR3zIhgxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YeNSbkNZdz3UbDAq71dC4QETLSzCwObNDb/ZTU7KYpw=;
        b=ljeg8M5rDOamyjNrlaBlWEXRFXK6YoGndey75P1ne9JadyceFSn7CaMFGq9CmnVQF0
         tWcaP0HIH5yvj560xpNKI7ydDNT12j2NTmz8uQi3vcLE/UrJ13hGGBJ5ucLikja2CDuw
         AOsPoXwJYVx55PNbZk3qEXKom/t6W3e8Qgk5SfboI5UtMEvR3l0yCj5Keebt0iqbXSm7
         Rs4K7qBBs5gFBuFQoSerWMFBX8zgOKo6XbpYxNpTRw63oFAsJuV2gEMbwyqGAfk5TTVn
         CP6SWqcjVWuz3569i+z1t05wFk11qPwXF/t5s42NiOXMY9+3JPdqGclZ0S3Vc9BJQhMR
         ommg==
X-Gm-Message-State: AOAM532ibJimSTqIc37YLrp34z93HMQCwI9vfWx3qow083tUSawt+M+W
        hRcS8d8zjeCV5ElWPVqHCGKfEA==
X-Google-Smtp-Source: ABdhPJyQ0PcHB0iCZQspTboInbpc7xgj3WxD4rgaVgP/Trqg3JM+eHRga3w2hzppB+O7T33cf1Z46g==
X-Received: by 2002:a17:902:a515:: with SMTP id s21mr5315672plq.334.1591840444165;
        Wed, 10 Jun 2020 18:54:04 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id b191sm998661pga.13.2020.06.10.18.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 18:54:03 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtman.org, linux-bluetooth@vger.kernel.org
Cc:     alainm@chromium.org, chromeos-bluetooth-upstreaming@chromium.org,
        mka@chromium.org, dianders@chromium.org, linux-pm@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: btmrvl_sdio: Set parent dev to hdev
Date:   Wed, 10 Jun 2020 18:53:53 -0700
Message-Id: <20200610185214.1.I01cfe07344286bc26109a3eba1f5582d307309ee@changeid>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
In-Reply-To: <20200611015355.186666-1-abhishekpandit@chromium.org>
References: <20200611015355.186666-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Set the correct parent dev when registering hdev. This allows userspace
tools to find the parent device (for example, to set the power/wakeup
property).

Before this change, the path was /sys/devices/virtual/bluetooth/hci0
and after this change, it looks more like:
/sys/bus/mmc/devices/mmc1:0001/mmc1:0001:2/bluetooth/hci0

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/bluetooth/btmrvl_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index 708ad21683eb31..47e450903af423 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -669,6 +669,7 @@ static int btmrvl_service_main_thread(void *data)
 int btmrvl_register_hdev(struct btmrvl_private *priv)
 {
 	struct hci_dev *hdev = NULL;
+	struct btmrvl_sdio_card *card = priv->btmrvl_dev.card;
 	int ret;
 
 	hdev = hci_alloc_dev();
@@ -687,6 +688,7 @@ int btmrvl_register_hdev(struct btmrvl_private *priv)
 	hdev->send  = btmrvl_send_frame;
 	hdev->setup = btmrvl_setup;
 	hdev->set_bdaddr = btmrvl_set_bdaddr;
+	SET_HCIDEV_DEV(hdev, &card->func->dev);
 
 	hdev->dev_type = priv->btmrvl_dev.dev_type;
 
-- 
2.27.0.278.ge193c7cf3a9-goog

