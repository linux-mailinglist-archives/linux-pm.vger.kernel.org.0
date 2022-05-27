Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC0453579B
	for <lists+linux-pm@lfdr.de>; Fri, 27 May 2022 04:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235323AbiE0CfE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 May 2022 22:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233346AbiE0CfE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 May 2022 22:35:04 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832DEE64C1;
        Thu, 26 May 2022 19:35:02 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id gh17so6234423ejc.6;
        Thu, 26 May 2022 19:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KmXUALSYCz1YkRyOIiggDW14b0uhcvG02BsnyFMThRs=;
        b=pTAMrfacp0moRUsOl+72PoK2KuZ5XouJm8NwvVi2BqispTEg1SmsbOEYoCGsICuS8f
         FXdot3GCwdeVFrY0V42husRVvLZwS53rJHfp6aA6DHU2bKMkZf5oGGPqvyVgt2KO+2gj
         9E0Ynh2v+OKA6zUhizgkqu6PjwHKDF/7NgGDTuz15FKKr1MiR/8KFzjIl4aRNTvvg/Vd
         KZitgyzV/lcM5xoH0P+YXpcZSqH8qwHW/7FnxHhzL8Vjfk7PCjvW92b0FuyJ5jFnPY+7
         wX5qBsC25oTihhS7hdIbe0xxea1AUkN9nSXFDQnEvrFr5b2mlO7l7h19VXHdgdV6bBBl
         AspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KmXUALSYCz1YkRyOIiggDW14b0uhcvG02BsnyFMThRs=;
        b=Mt2bH933PVqnzuoKKSK3sgXJ3HMAhMQyYgJB+Pt2LN92sLCbsgarEx/HRRX/ZuBooW
         f6qdOOYLONMa7Mp/5OwKu3Ks3HD8pndNzT526FmNjXgFVvHZ9s/o/mjY8wQ08GWnnQmi
         Uc/A7gSwK0WyOE8jX+8qRNBZjOG9kFXKAWOw0/DZ/JPJxxkdg+nVd0FyyLY7IL/vRaM+
         t6eXa2/bEvo9r+AoNkv4DztJmFv4ghiocEjJB3iK2zc1vh5YpmjctgLRJG9nnSq5diYL
         93rMnNAYvlrDcN4N5tZci01gvO0CbkWlNT3BqtbAB4h4EPd1/8dBb/OjZj51Ngdcw3HO
         bEBQ==
X-Gm-Message-State: AOAM5329jzDfaat+N2YJUK+moqPTDwWSJm9tzaXiqdoWLMJB+Xg/NQdO
        w3bUQk3/3PqxOB/NVhQ2qAQ=
X-Google-Smtp-Source: ABdhPJxhkb/c+U9RFr/h9uFuF/9VANJAtbzM5g6A/AMXwYRLKM31oyW6EzVl54AGCYeVEsa0VceZQw==
X-Received: by 2002:a17:907:868e:b0:6fe:293:e7cc with SMTP id qa14-20020a170907868e00b006fe0293e7ccmr35726916ejc.716.1653618900920;
        Thu, 26 May 2022 19:35:00 -0700 (PDT)
Received: from xws.localdomain ([37.120.217.83])
        by smtp.gmail.com with ESMTPSA id qn12-20020a170907210c00b006fe89cafc42sm1025167ejb.172.2022.05.26.19.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 19:35:00 -0700 (PDT)
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
Subject: [PATCH v2 00/12] platform/surface: aggregator: Add support for client hot-removal
Date:   Fri, 27 May 2022 04:34:35 +0200
Message-Id: <20220527023447.2460025-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.36.1
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

Summary:

  Add support for the HID type cover input devices on the Pro 8 and all
  requirements for that.


Blurb from v1:

  This series adds support for the type cover of the Surface Pro 8. On
  the Pro 8, the type cover is (unlike on previous generations) handled
  via the Surface System Aggregator Module (SSAM). As the type cover is
  detachable, care needs to be taken and the respective SSAM (HID)
  client devices need to be properly removed when detached and
  re-initialized when attached.
  
  Therefore, this series does three things:
  
   1. Improve hot-removal support for SSAM client devices. When
      hot-removing clients, subsequent communication may time out.
  
      In the worst case, this can lead to problems when devices are
      detached and re-attached quickly, before we can remove their
      respective kernel representations. This can then lead to devices
      being in an uninitialized state, preventing, for example, touchpad
      gestures from working properly as the required HID feature report
      has not been sent.
  
      Therefore, handle hot-removal of devices more gracefully by
      avoiding communication once it has been detected and ensure that
      devices are actually removed.
   
   2. Generify SSAM subsystem hubs and add a KIP hub. On the Surface Pro
      8, the KIP subsystem (only that abbreviation is known) is
      responsible for managing type-cover devices. This hub acts as the
      controller for device removal similar to the BAS (detachable base)
      subsystem hub on the Surface Book 3 (therefore we can share most
      of the code between them).
  
   3. Add the (HID) type-cover clients of the Surface Pro 8 to the
      aggregator registry.


Changes in v2:

 - Introduce "platform/surface: aggregator: Allow is_ssam_device() to be
   used when CONFIG_SURFACE_AGGREGATOR_BUS is disabled" to fix an
   undefined reference  build issue when CONFIG_SURFACE_AGGREGATOR_BUS
   is disabled.

 - Make SSAM hub device UIDs consistent.
    - Introduce "platform/surface: aggregator_registry: Change device ID
      for base hub" to make association between hub and subsystem target
      category more obvious.
    - Change hub device ID for KIP subsystem hub to be consistent with
      the id of the already existing BAS hub.


Maximilian Luz (12):
  platform/surface: aggregator: Allow is_ssam_device() to be used when
    CONFIG_SURFACE_AGGREGATOR_BUS is disabled
  platform/surface: aggregator: Allow devices to be marked as
    hot-removed
  platform/surface: aggregator: Allow notifiers to avoid communication
    on unregistering
  platform/surface: aggregator_registry: Use client device wrappers for
    notifier registration
  power/supply: surface_charger: Use client device wrappers for notifier
    registration
  power/supply: surface_battery: Use client device wrappers for notifier
    registration
  HID: surface-hid: Add support for hot-removal
  platform/surface: aggregator: Add comment for KIP subsystem category
  platform/surface: aggregator_registry: Generify subsystem hub
    functionality
  platform/surface: aggregator_registry: Change device ID for base hub
  platform/surface: aggregator_registry: Add KIP device hub
  platform/surface: aggregator_registry: Add support for keyboard cover
    on Surface Pro 8

 .../driver-api/surface_aggregator/client.rst  |   6 +-
 drivers/hid/surface-hid/surface_hid_core.c    |  38 +-
 .../platform/surface/aggregator/controller.c  |  53 ++-
 .../surface/surface_aggregator_registry.c     | 403 +++++++++++++-----
 drivers/power/supply/surface_battery.c        |   4 +-
 drivers/power/supply/surface_charger.c        |   4 +-
 include/linux/surface_aggregator/controller.h |  24 +-
 include/linux/surface_aggregator/device.h     | 125 +++++-
 include/linux/surface_aggregator/serial_hub.h |   2 +-
 9 files changed, 513 insertions(+), 146 deletions(-)

-- 
2.36.1

