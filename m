Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4E17BDE3
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2019 12:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387613AbfGaKAv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Jul 2019 06:00:51 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46308 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387538AbfGaKAv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Jul 2019 06:00:51 -0400
Received: by mail-pf1-f196.google.com with SMTP id c3so8444010pfa.13
        for <linux-pm@vger.kernel.org>; Wed, 31 Jul 2019 03:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=zdY0mkeKz6wFUj2+Iv8tunD7YaIRXeWWDHoAU4rKgeM=;
        b=VVgGkcZXih1qP647R+vl7D9o6i6k9DG70z7bLhVqwiDo1I2LqOLWTfCxu1ekWU8Oya
         MwEwA/ZuDdiIjsYgsaiTci2krnAu1CwkbmYxrPbBvNPFQ9JFVDziVMAcSqPWRHs4lq04
         eI8Qlsc4M0rhnDkmVf3nL9eFWhg8iOfazXarSVuZhau84pupSABqznhLh2lILMK91nnT
         YGCyj4xbFKyuUDmEbJF1jY6Fm2EpIINazzDGWHkrMQoNsb0g439ecgk+ose0bATGLK5g
         hiheflMKKhsVqN9mrAHTwXt8/17bJZUvTS9PYUwqXvnXAZaFfSmuyVzGOpAmJBQqVv9m
         a4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zdY0mkeKz6wFUj2+Iv8tunD7YaIRXeWWDHoAU4rKgeM=;
        b=mcLvhVCal+wJgd5Lnrw0t7JZKLQ3wJfhlrE1kiUSb88P0I0m0KxJF4uUusPEne5kQh
         TC6lgrkxr7HpgvADoXELHpuCtBEoW/mbsqBZnozKwaduBSDgwGL/qJ0ECmq/4fjCtyEV
         fAaM6tRYLdOa+GEKr2FeisSNXI5/Phbjaa5yeIb9R0YGgv5MRm1WWEFA606XkT/+XIh3
         CqMQcl2HfVvO2ldqvkEFnGhNfDRwN9EY9keFbbHt8zreq2hPnahZYq0mhjFP/jLCeW6R
         bh7J6gFXttpptJ1fb6AruR8OiHIDIEV8c9Hh6T1+LvfKVS3Kew2TjGBjBXpid/mK4sDF
         vIRQ==
X-Gm-Message-State: APjAAAXJsAoWFG3E/CF3nUlhqmlm0VTDX3k2l9nc3zsKhuGBHepDLjzk
        VRHTUVMsJjMFefNPIYS4waSa44h+9zM1uw==
X-Google-Smtp-Source: APXvYqw0Y6Qj3vWMUij/ygCH6W9UuQ+3IAOIfy6H/S2xq+XR2JPcqDpQWOgNffD6qg6gLUIyLkFXiA==
X-Received: by 2002:a65:57ca:: with SMTP id q10mr116459163pgr.52.1564567250359;
        Wed, 31 Jul 2019 03:00:50 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id m6sm68611352pfb.151.2019.07.31.03.00.47
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 Jul 2019 03:00:49 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, vincent.guittot@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] Optimize the Spreadtrum SC27xx fuel gauge
Date:   Wed, 31 Jul 2019 18:00:22 +0800
Message-Id: <cover.1564566425.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

This patch set adds new attributes for userspace, and fixes the the
accuracy issue of coulomb counter calculation, as well as optimizing
the battery capacity calibration in some abnormal scenarios.

Any comments are welcome. Thanks.

Yuanjiang Yu (6):
  power: supply: sc27xx: Add POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN
    attribute
  power: supply: sc27xx: Fix conditon to enable the FGU interrupt
  power: supply: sc27xx: Fix the the accuracy issue of coulomb
    calculation
  power: supply: sc27xx: Optimize the battery capacity calibration
  power: supply: sc27xx: Make sure the alarm capacity is larger than 0
  power: supply: sc27xx: Add POWER_SUPPLY_PROP_CALIBRATE attribute

 drivers/power/supply/sc27xx_fuel_gauge.c |  175 +++++++++++++++++++++---------
 1 file changed, 124 insertions(+), 51 deletions(-)

-- 
1.7.9.5

