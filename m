Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822015357A0
	for <lists+linux-pm@lfdr.de>; Fri, 27 May 2022 04:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235464AbiE0CfF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 May 2022 22:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiE0CfE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 May 2022 22:35:04 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4227E7300;
        Thu, 26 May 2022 19:35:03 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id gh17so6234482ejc.6;
        Thu, 26 May 2022 19:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RiwrNA996kdWGzH1MFQCP6Boy6kdU7mqM1tXmvyfu78=;
        b=Bjy3/VOMa2WGazW9CrIGuJsrXU9/WeLHaMbqeji/+j+QLKTxoGnGEJ7ButNmyGECxU
         tv1zLCFQO4tgho7tC/+ZzwY/fO998WIvDxygnYBMMd7wokmd35FuX2jScZ/5YB4jjymV
         C+QnnB/Qpw3bfbqclkFxjFdr6rcksh1itEU4WJjDQpPEj33LIgUtheYaQnY07uuntGCV
         gP2JbZJiFHyYR3vWydWmSvTexzR4xlmsFYj9fRE9qyXUdLKoIt7ldUgP/Y7aztXvMP3E
         LvrQm4NHh90K128qYRKgWrP8ngwaI8JzXrqehUNifXdcZZndZ23/VZhyV43bm5m1go+J
         enhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RiwrNA996kdWGzH1MFQCP6Boy6kdU7mqM1tXmvyfu78=;
        b=5Z8mCtIqQhiRBk4521kHoV1vHsk0Mk6pREVhQM+nGluLKz+eN9Q8oJrWqSoCsNHc1v
         B3uTebm4hmZjDF483wrIbb6DzaqNF3QnXZAxFSEBJklvq/DuiFHUNppJRolhcTPQcD1F
         yMOEpGxsKcVlowAUTwQt3cl0RJoh8PyDfQRdFXRFwdscLwGanSg66fK+azJIpiNMN2SM
         TJVbrfaPHkHT23B7SV2Nkj2UUnLYGMk4Gka03T4h3fOr4X2LTo08WnBq9Z28HKdzToTi
         EaYXt+/WSPBnGukA856KfXEc6MN+OeTZalzjdNu+Zgbipq4HnH6Fxk1Nu5J7zKN5RW8e
         D5rw==
X-Gm-Message-State: AOAM533WJgJgwYNswQfgmjCbBCE7l9ife1MER4aRyxaoeb4OAjaco0R8
        fQeeiTqM5uklxROYTpoEavw=
X-Google-Smtp-Source: ABdhPJzNCqnYPBOIYDXjV2MahCglVI6qk1f6JmrLebb19YURq1ha3mx5age0zNCh6HcR53bip51sqg==
X-Received: by 2002:a17:907:3f8c:b0:6fa:8b15:66fe with SMTP id hr12-20020a1709073f8c00b006fa8b1566femr36452843ejc.142.1653618902228;
        Thu, 26 May 2022 19:35:02 -0700 (PDT)
Received: from xws.localdomain ([37.120.217.83])
        by smtp.gmail.com with ESMTPSA id qn12-20020a170907210c00b006fe89cafc42sm1025167ejb.172.2022.05.26.19.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 19:35:01 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Mark Gross <markgross@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH v2 01/12] platform/surface: aggregator: Allow is_ssam_device() to be used when CONFIG_SURFACE_AGGREGATOR_BUS is disabled
Date:   Fri, 27 May 2022 04:34:36 +0200
Message-Id: <20220527023447.2460025-2-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220527023447.2460025-1-luzmaximilian@gmail.com>
References: <20220527023447.2460025-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In SSAM subsystem drivers that handle both ACPI and SSAM-native client
devices, we may want to check whether we have a SSAM (native) client
device. Further, we may want to do this even when instantiation thereof
cannot happen due to CONFIG_SURFACE_AGGREGATOR_BUS=n. Currently, doing
so causes an error due to an undefined reference error due to
ssam_device_type being placed in the bus source unit.

Therefore, if CONFIG_SURFACE_AGGREGATOR_BUS is not defined, simply let
is_ssam_device() return false to prevent this error.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---

Changes in v2:
 - Introduce this patch to fix a build issue later on.

---
 include/linux/surface_aggregator/device.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/surface_aggregator/device.h b/include/linux/surface_aggregator/device.h
index cc257097eb05..62b38b4487eb 100644
--- a/include/linux/surface_aggregator/device.h
+++ b/include/linux/surface_aggregator/device.h
@@ -177,6 +177,8 @@ struct ssam_device_driver {
 	void (*remove)(struct ssam_device *sdev);
 };
 
+#ifdef CONFIG_SURFACE_AGGREGATOR_BUS
+
 extern struct bus_type ssam_bus_type;
 extern const struct device_type ssam_device_type;
 
@@ -193,6 +195,15 @@ static inline bool is_ssam_device(struct device *d)
 	return d->type == &ssam_device_type;
 }
 
+#else /* CONFIG_SURFACE_AGGREGATOR_BUS */
+
+static inline bool is_ssam_device(struct device *d)
+{
+	return false;
+}
+
+#endif /* CONFIG_SURFACE_AGGREGATOR_BUS */
+
 /**
  * to_ssam_device() - Casts the given device to a SSAM client device.
  * @d: The device to cast.
-- 
2.36.1

