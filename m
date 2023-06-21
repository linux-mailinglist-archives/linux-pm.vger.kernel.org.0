Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057D3738750
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jun 2023 16:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbjFUOka (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Jun 2023 10:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjFUOk2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Jun 2023 10:40:28 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515121739
        for <linux-pm@vger.kernel.org>; Wed, 21 Jun 2023 07:40:27 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51a324beca6so7884581a12.1
        for <linux-pm@vger.kernel.org>; Wed, 21 Jun 2023 07:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687358426; x=1689950426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2W3Kf4ey7QY4pTA3JpFMV/TNECBh7Gq30HfrcLuf2lU=;
        b=qvokshYUKY7HCe7qvXfL6wjYYLXu4sLS55Nbn5MMSRaW3ci8oSwdrPhew+rcuX2SGB
         ttF+BrNowbQuVuwKWys48yk9Pp0Rqcb8/qlhp3OiBdxnhHoN0cNYjwyl2jlRW3nIJnbP
         XSOR9VS87RpPQWiKFJHP5L0cJX0OAjgyeIkzIPN1YHYbGcaiD/eqsXgwwYd76a/cee65
         gOf3sJhWtsKrOBhZTFPntSptaEMNKExo8zFZoqU4t94AQH59SXnYGMOn8JeiYbbh1Tdo
         xgKZP+jAeulj6cyNtmCOXXXogsSB3bnXaTruagohS/wdx+Sfv8zc0cM4+ifmo9z/x7QA
         fBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687358426; x=1689950426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2W3Kf4ey7QY4pTA3JpFMV/TNECBh7Gq30HfrcLuf2lU=;
        b=Vw/p4JUyBynWlfmk19fnfeTzW7OCnYy9ApDcwWOjcTa4jdob37Af2XqY4U/rKO6tLz
         mabCiSJriNa0un+1xqz/r+3Le+rPTfruDx3xm3IJqWrT2AlWcCOMvePDCUxqPilWinRI
         N6yprUCQVTp4azxpFAH9bXjpPuo0xVFNrfCMKkQSB/k1F0RJAsBIT9aIaqJHmLlH/DTJ
         Lr6eBPBwnSV980UTgyMdtJEsvjNFgQi74irBONSGYChhzGJzlzUDE5uDtY00gBzxIDVI
         23s72wwIGsLKysOZn0YsSCJZBIe4NpYmhuKH7NSvV6474sPhxAyfsZBboIsV9vdTEvnl
         ooPA==
X-Gm-Message-State: AC+VfDwX4NAFoUyqFnXtZxuUc53roIYtdi49kDljcI9FFZpDdnnasVDT
        0DUpgBg5XtjJBb1KsUCky2wDGw==
X-Google-Smtp-Source: ACHHUZ41TS8wh8wraPOcFMSensNy0EVeaB1fuQHXmzdq80qlDOpEP1Dbjcjfb7T640VzWNcl1j9V2A==
X-Received: by 2002:a05:6402:642:b0:51a:5ebe:4ab9 with SMTP id u2-20020a056402064200b0051a5ebe4ab9mr5948602edx.14.1687358425839;
        Wed, 21 Jun 2023 07:40:25 -0700 (PDT)
Received: from hackbox.lan ([82.79.124.17])
        by smtp.gmail.com with ESMTPSA id l13-20020a056402344d00b0051879c4f598sm2689505edc.66.2023.06.21.07.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 07:40:25 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     Bjorn Andersson <andersson@kernel.org>, linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [RFC PATCH v5 2/4] driver core: Add dev_is_drv_state_synced()
Date:   Wed, 21 Jun 2023 17:40:17 +0300
Message-Id: <20230621144019.3219858-3-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230621144019.3219858-1-abel.vesa@linaro.org>
References: <20230621144019.3219858-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This can be used by drivers to figure out if a different device
driver has state synced or not for a specific device.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 include/linux/device.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index bae11928ef7e..8f042f04b5d9 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1007,6 +1007,20 @@ static inline int dev_set_drv_sync_state(struct device *dev,
 	return 0;
 }
 
+static inline bool dev_is_drv_state_synced(struct device *dev)
+{
+	bool ret = false;
+
+	if (!dev)
+		return ret;
+
+	device_lock(dev);
+	ret = dev->state_synced;
+	device_unlock(dev);
+
+	return ret;
+}
+
 static inline void dev_set_removable(struct device *dev,
 				     enum device_removable removable)
 {
-- 
2.34.1

