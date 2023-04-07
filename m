Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1796DB06F
	for <lists+linux-pm@lfdr.de>; Fri,  7 Apr 2023 18:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjDGQSe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Apr 2023 12:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjDGQSd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Apr 2023 12:18:33 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DE5BB88
        for <linux-pm@vger.kernel.org>; Fri,  7 Apr 2023 09:18:32 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-17ab3a48158so46133881fac.1
        for <linux-pm@vger.kernel.org>; Fri, 07 Apr 2023 09:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680884312; x=1683476312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hDt7IZUS9kKesRpAech9064dufC+bxuvlkUXuXgu1Vg=;
        b=dMGHYuHlm12vWFiHqJPsEMbQH6mTCBxEjrtiWQij2NXwmwn/LtIE8TV5NgGvAqQa/s
         dF7iwLz28HA7I5Zow6yXWxitKlmPZkfeF56rFf1jWPV8RXa5IvfIRGu0zhyJtpo/FcKB
         sSHmKgdhWdtTX3+xDHyhBLPg8KIUnAA2beT0Kifo6VLF3o7VRjyehbXiQZ3uuJsam5uI
         0hMUe3d2djbABbVHzxmZWJn0Y9n3NbJXCTrGpW35E1paQVAd/z2/AnfmnuanJwQR6vNO
         6789mGArb+ZRMUHkp90Q3/qwaIJtZhnpaRvdYca+dsFid5rxDxodgWgy++F+dzROi0Ku
         JkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680884312; x=1683476312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hDt7IZUS9kKesRpAech9064dufC+bxuvlkUXuXgu1Vg=;
        b=yEr0tbahLPB+tiKnXJnG+sxLLNFZTwXQwEQfy1xm6h2zy+Uqmang1GPHxv9ezvUvlj
         2Q2vqL5VeAzbJ5Oftb4ryKXTyuaQgUJaUyYOPL/mDThy6vweORfi0aZZap115U8MP+h6
         D4hewuUgSG/IxDPpotDcHItkCgHpfIcERxxINUChUJhDNYAKPZ+e7LtoFU4KniX9xG+L
         z3FkPzEkURQT+PFN6yqdup07IDER+pPSbTkyj8hYg/T7C2PkxsEg+1YWp0DAK9qVhR2Z
         DaLH8Z8dvS5mFUoVqmVpJWa4dJTHZ5IaxVit4doiWFpy38Wr01e4ZaKpwF9MRNfN9yPq
         5n+g==
X-Gm-Message-State: AAQBX9faVVa8j1znG9zQpdsd0gpDlPS03O1tS4jUCOlfO+mJe5YDv2Hq
        3FbNrPzNzPacVd72nJg7CJzfWYl453s=
X-Google-Smtp-Source: AKy350bynv7+ieKG0NLpaOdlK/e884wjZHGs7jjl0hOTwnU0whdMQT2gVbeD04+iCwQiT7Ns7uJvQQ==
X-Received: by 2002:a05:6870:a406:b0:17a:a737:9ef3 with SMTP id m6-20020a056870a40600b0017aa7379ef3mr1776467oal.43.1680884312104;
        Fri, 07 Apr 2023 09:18:32 -0700 (PDT)
Received: from localhost.localdomain (76-244-6-13.lightspeed.rcsntx.sbcglobal.net. [76.244.6.13])
        by smtp.gmail.com with ESMTPSA id zj18-20020a0568716c9200b00183f77dcdadsm1369212oab.33.2023.04.07.09.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 09:18:31 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     maccraft123mc@gmail.com, lee@kernel.org,
        jiapeng.chong@linux.alibaba.com, sre@kernel.org,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 0/2] Fixes for rk817_charger driver
Date:   Fri,  7 Apr 2023 11:18:25 -0500
Message-Id: <20230407161827.127473-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

After using the driver for a few months I noticed a few issues that
this patch series seeks to address. Namely, there appears to be some
left over code that was used for debugging during development that is
no longer needed. Additionally, when the state of charge drops to 0
there is an issue with reading the value on boot because the columb
counter appears to hold a signed value.

With these fixes in place the battery driver appears to operate better
and without the odd bug of an unsigned integer overflow on the columb
counter.

Chris Morgan (2):
  power: supply: Remove unneeded code in rk817_charger
  power: supply: Fix low SOC bugs in rk817 driver

 drivers/power/supply/rk817_charger.c | 48 ++++++++++++++++------------
 1 file changed, 28 insertions(+), 20 deletions(-)

-- 
2.34.1

