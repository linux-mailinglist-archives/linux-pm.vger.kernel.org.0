Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1406617B38
	for <lists+linux-pm@lfdr.de>; Thu,  3 Nov 2022 12:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiKCLBT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Nov 2022 07:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiKCLBR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Nov 2022 07:01:17 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBE3B7DD
        for <linux-pm@vger.kernel.org>; Thu,  3 Nov 2022 04:01:16 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id p15-20020a17090a348f00b002141615576dso4806709pjb.4
        for <linux-pm@vger.kernel.org>; Thu, 03 Nov 2022 04:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ay8rIDfAS1vKzFBT8OPzZHG4KC+WK17k+CTXHHbF524=;
        b=F7u8vLHf3k4t6Ojxj0wPVNF0odVtSYGzJ7dal3LBHzOzk0NP6WfWAoqERZUf/n/lyy
         ro+jSMxTAhkSGSq25iMQbPtlIPrwh3oCl6vTw9Lg95AeMQvH22HLht+fOW1U8GPlC6Si
         6BNw7+oJJAFgCrFvGdwQ5mhW2G0tEk/+96qJngXj7L5JFjdWGtTwbQ2kHEBXWE1Qsh43
         sO4FCbk8xnS/2ho9xjGjd7nk/hUpeKtlB2tiHqCLWBtebcRor8a9dvrffix9a1Pzj8fL
         iaheCXDz7uZaNZF2o2ZdXErpkQCGNE1EsdiBp+vwpskuCQbp0UaqlNvsOif7TSOs0X6J
         cmSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ay8rIDfAS1vKzFBT8OPzZHG4KC+WK17k+CTXHHbF524=;
        b=zInIllZ4aqUZClkUuDYhTII0gECu16MmvE9vOMkp6Hkcghqdq31D8WYlJn2oDjKNKO
         VjcPtgJkcsIeTMsd+y05qGFCTA3AOu4gtdMyahjdhe9Nx0WlPTbXWHr/nSbgWmQY+B8d
         hcaYqqWytWH8tDafAfb++8WNudAxarZjG+OHRYXOMj7kBfMipu+CVW3cjN3GOZSc2+Rr
         K1+5SujJHmtnipx8UAylVlWT+a8nWMWlKvifYAqJ6VaPLkyOEaHLsbC+np8EyVx4dZAO
         tWQh2YzqONhmQ7n9plkTenC5j/ddMIuFKZOUCQOBOp+0eugxe7FKZaSJfngjnyrR9HBs
         rhTg==
X-Gm-Message-State: ACrzQf3alfuvTOKhIZBh6SgmlecfH2BrNwQWUyfSsdiMhRKfcXkkOu+5
        1sO+MUrAwAMZArFru5MV+6ewDQ==
X-Google-Smtp-Source: AMsMyM6YB+L8bLYmn+hlc1I5brGQsvzfYouZ8a2S+xu0StVwOU25oSYcJOX2kxEwJeAgcOxQ9BS6WA==
X-Received: by 2002:a17:903:cd:b0:186:878e:3b08 with SMTP id x13-20020a17090300cd00b00186878e3b08mr29228986plc.93.1667473276274;
        Thu, 03 Nov 2022 04:01:16 -0700 (PDT)
Received: from localhost ([122.172.84.80])
        by smtp.gmail.com with ESMTPSA id x15-20020a170902ec8f00b001868bf6a7b8sm363976plg.146.2022.11.03.04.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 04:01:15 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     James Calligeros <jcalligeros99@gmail.com>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] OPP: Allow power/current values without voltage
Date:   Thu,  3 Nov 2022 16:31:03 +0530
Message-Id: <cover.1667473008.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

Some platforms, such as Apple Silicon, do not describe their device's
voltage regulators in the DT as they cannot be controlled by the kernel
and/or rely on opaque firmware algorithms to control their voltage and
current characteristics at runtime. They can, however, experimentally
determine the power consumption of a given device at a given OPP, taking
advantage of opp-microwatt to provide EAS on such devices as was initially
intended.

But the OPP core currently doesn't parse the opp-microwatt property if
opp-microvolt isn't present. This patch series targets to change this approach.

This first fixes few mistakes in the DT bindings, followed by code
reorganization. And the last commit, from James, fixes the problem at hand.

I have tested all combinations on my Hikey board, hope it doesn't break
anything.

James Calligeros (1):
  OPP: decouple dt properties in opp_parse_supplies()

Viresh Kumar (4):
  dt-bindings: opp: Fix usage of current in microwatt property
  dt-bindings: opp: Fix named microwatt property
  OPP: Parse named opp-microwatt property too
  OPP: Simplify opp_parse_supplies() by restructuring it

 .../devicetree/bindings/opp/opp-v2-base.yaml  |   6 +-
 drivers/opp/of.c                              | 228 ++++++++----------
 2 files changed, 102 insertions(+), 132 deletions(-)

-- 
2.31.1.272.g89b43f80a514

