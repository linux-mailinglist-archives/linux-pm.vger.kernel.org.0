Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3B1671793
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jan 2023 10:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjARJZc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Jan 2023 04:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjARJUh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Jan 2023 04:20:37 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA385AA64
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 00:38:32 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id 207so9502873pfv.5
        for <linux-pm@vger.kernel.org>; Wed, 18 Jan 2023 00:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Seq1mX1XtKCwlcIcPQRmNyguKpAMYVn4ufk1mjtx/c=;
        b=H8yMg62Cq5wI/wHrn1Gcd5A/7UHoJqQ4Mc7NinTnr/5hGSO48NgbHgNQa2QuBVBHbN
         VJ/PSuW7KKTckTfWhC8lDoLWSpKEOynWhuH/7iskzZjvs8yBrnWYFOLH80zf2l9Gw59M
         XHUbEQxjaJKBLZLzxO9gYb+ZR2xX5ADI+P8oSTHiJNVH39HPPHqS5YqOqvb3b0h/rUI1
         0kXBUhgR3QjmsFl8l9T82o0xjBIGLcjidI2pWIOtagtqYjwtcQspYcV5YBQpjQpwM7bf
         AEPyic5C+u2QiF34C5tmEdiKMSUXuUvCatYasrKADxfUMeljP4QNsj900ZTbuEqTthgK
         S+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Seq1mX1XtKCwlcIcPQRmNyguKpAMYVn4ufk1mjtx/c=;
        b=dcFOOGNBYB2PQye4wRudQWP/0YoGPyRH6uh7LciyXodzp8gZ2KRGvMn4T0Q1rKTWGe
         oK+cahkJIzzzuBwQLyBBKJBhE4642UbVIxWBwFnr9Jn7QjGXI8ng9hMsoJtd19Z2HgIR
         CPLxNAnYHR1yAj09f3LMKt/5EdKyqE9ZWbKjXo1c8r9QbMAJxvrVxDHqS5hvc581YcYl
         1YMdoqiyv21TDIESwNN9O3Je+W1La2m4hl/NLt8sFeqMsHuP2JRw+TYcNn2J3qdSZHqz
         P2x2TPymU3L36LJ5XeUvk4tNAWfBPcmGr9Nl+xSMPAZY8TXtatPOirReAG3uZNNclYH3
         HLKg==
X-Gm-Message-State: AFqh2krUwd0QfbhWMJpS5SDCJUo4U1eymXeyVRSQHG4iYpYnzGI2XLIK
        sBRkTs2OTXijzGJd7xORqFAkww==
X-Google-Smtp-Source: AMrXdXuTJH4v7znJMxTMt9jc5jG0ofaVClDu4kQgHlioRTy6pjhtRH5jVqPmJ4Xz+BGXRqadTtX29g==
X-Received: by 2002:aa7:8283:0:b0:588:9c15:65c4 with SMTP id s3-20020aa78283000000b005889c1565c4mr5481132pfm.3.1674031111722;
        Wed, 18 Jan 2023 00:38:31 -0800 (PST)
Received: from localhost ([122.172.81.45])
        by smtp.gmail.com with ESMTPSA id d62-20020a623641000000b005800cb7cbcasm19709245pfa.120.2023.01.18.00.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 00:38:31 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 0/3] thermal: Fix/cleanup error paths in __thermal_cooling_device_register()
Date:   Wed, 18 Jan 2023 14:08:23 +0530
Message-Id: <cover.1674030722.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

The error paths in __thermal_cooling_device_register() are trying to free
un-acquired resources, fix that and clean it up a bit.

Caleb, can you please test this? I have just build tested it for now.

--
Viresh

Viresh Kumar (3):
  thermal: core: call put_device() only after device_register() fails
  thermal: core: Move cdev cleanup to thermal_release()
  thermal: core: Use device_unregister() instead of device_del/put()

 drivers/thermal/thermal_core.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

-- 
2.31.1.272.g89b43f80a514

