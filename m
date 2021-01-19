Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F462FC512
	for <lists+linux-pm@lfdr.de>; Wed, 20 Jan 2021 00:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbhASXhb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Jan 2021 18:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395123AbhASOGz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2021 09:06:55 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD50CC0613D6
        for <linux-pm@vger.kernel.org>; Tue, 19 Jan 2021 06:05:45 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id c12so8150786qtv.5
        for <linux-pm@vger.kernel.org>; Tue, 19 Jan 2021 06:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K6Vqc+23VASYsYGFP+qO4Y3EIsmnhbqAWUtWDpTUg5U=;
        b=aoBbgWW+1jyixAOrGCq8jS4cB5lnojmj9EUiBVefvGrNFKnsPv53QoXk63zgdS5qAe
         URGwCTa/dAK9xSDwGdna0fivCB2IS90ZvxfHS7qrFvU9lEHFPEkGjmntFbRZFgcrpWRY
         wGvFC5Be6CbYFw4gXVuH/9GSwygjS5aue/fjWzYZvWkU3R8srXVhFQKB+WJzi10oMuWf
         Mbul/Ca1tPg18oGr4oI+TQbHP3JMuRdK1v5P28+qmmfEnSkrvQNutwdpiRagj010gu7i
         SEj44zseOJcDBI+rL4Y9uRs8rROCF7iFLrGNwS6Vs/jacPsfadVMjuMKcG90sSzg9WBY
         QihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K6Vqc+23VASYsYGFP+qO4Y3EIsmnhbqAWUtWDpTUg5U=;
        b=Gq/MS62zVM5WbXIOnTJFDM191l98S2ZvyvRVESknuulpw9zUoFZ3/JpTAa4/3Yh4pr
         QrzZKm4cUOV9uXwpEFv1aQkKE2EIAJUzU8Eu6lJfWvQ0ala29xh7Ml5ABjDncsgNmGxT
         JtXxkkJezWgazac95FObJvPB0AK24KUEyStioI+lyjlu9Zy2qZsxG6x6PAfJO2+i9Arf
         ZMHy358A6ZY7Pb7dfT64xk7p9/hF4RmxJ8eGICOJ2/OmGs+2Q76lq9gqMAY1ZobwDXGl
         ejXxDnIhU13Tb0BkrPXP7atlCC8RQQy6FwnueqNeFdssWZqLpqeZ+hQfEI02e+Ef+Y/B
         ag8w==
X-Gm-Message-State: AOAM530YmYqx+ME+ezkLYOXYFxtL5JHS+lhPliE9cpUYVtQyT6aiAopB
        Gm4nXhypXFhl0lHB1M5/5hLP3Q==
X-Google-Smtp-Source: ABdhPJwo6oA6QD2i4L3dX6pk5dPtyn5nSwGwlebGrIfIWPShQk6upexxNl8NkiF3jBNdlEw6/NQM2Q==
X-Received: by 2002:ac8:5cd0:: with SMTP id s16mr4195712qta.309.1611065144384;
        Tue, 19 Jan 2021 06:05:44 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id f134sm12910308qke.85.2021.01.19.06.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 06:05:43 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org,
        luciano.coelho@intel.com
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-pm@vger.kernel.org, amitk@kernel.org,
        nathan.errera@intel.com
Subject: [PATCH 1/2] net: wireless: intel: iwlwifi: mvm: tt: Replace thermal_notify_framework
Date:   Tue, 19 Jan 2021 09:05:40 -0500
Message-Id: <20210119140541.2453490-2-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210119140541.2453490-1-thara.gopinath@linaro.org>
References: <20210119140541.2453490-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

thermal_notify_framework just updates for a single trip point where as
thermal_zone_device_update does other bookkeeping like updating the
temperature of the thermal zone and setting the next trip point etc.
Replace thermal_notify_framework with thermal_zone_device_update as the
later is more thorough.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
index 507625f96dd7..a0c6be03903a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
@@ -146,8 +146,8 @@ void iwl_mvm_temp_notif(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 	if (mvm->tz_device.tzone) {
 		struct iwl_mvm_thermal_device *tz_dev = &mvm->tz_device;
 
-		thermal_notify_framework(tz_dev->tzone,
-					 tz_dev->fw_trips_index[ths_crossed]);
+		thermal_zone_device_update(tz_dev->tzone,
+					   THERMAL_TRIP_VIOLATED);
 	}
 #endif /* CONFIG_THERMAL */
 }
-- 
2.25.1

