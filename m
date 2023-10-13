Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D876F7C80A3
	for <lists+linux-pm@lfdr.de>; Fri, 13 Oct 2023 10:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjJMIsy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Oct 2023 04:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjJMIsw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Oct 2023 04:48:52 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA39C0
        for <linux-pm@vger.kernel.org>; Fri, 13 Oct 2023 01:48:50 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c9e95aa02dso7975485ad.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Oct 2023 01:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697186929; x=1697791729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cuwfdf7uPcP2Q86zjEqOgU6r207CIqSR0RYNAvAzT7M=;
        b=lF7CSnLK5WTJrDgdFGC6nm+su+9NGII7+2Qw1owjlacqVhY6ExjSaGGIHZnOy7Sw2X
         diwvuEylJS5pdgBffnDg18Q+rCmG4x47ANE+Mj0JrTOJo2jM4LgIW7Wb5FOmKHXItqbc
         x9Wwa0YkJyZZYFCE4yfDborl4uNkpIF0AgE1/NNqyVss5y33hsBls6wR1Mu0kJKkRKBI
         EQZzNyrtupd5d2eLLKYcE25fB1987u9KcmfK4X9KoVeN+OxK7sWGZGloMWj9yOXFkNd5
         IBBL6z8LlFYc4KXIjvCBuJmS6aEf19XF6cgFl7LoRCiev5osXdGYsxdNMHYAuneaE4Zp
         uboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697186929; x=1697791729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cuwfdf7uPcP2Q86zjEqOgU6r207CIqSR0RYNAvAzT7M=;
        b=MlV+dxb8ce0p7AjjSko7CYEQOIh/hyJxqpt4rYfed+IW0M7g57DLxmDKreAAfFazxK
         /s1eVxKqUyuDNnroZ+fzJvoGQzowFEqSqep5TFWG4Vmna5+GgCqSbuQuKTa4okbJK3X/
         Btw5HS1OoDS8Q/1dY2A/c7pFxvjqV8O7QD2wtjZIJ4sszkptReh8mVuYyCiqkSmOvSLA
         k0tX+fqmikod0iWohGIFyPS/nVs97KG5OUeq5303jJgFSgoRhjeKacqGUGGA0MCE4mi9
         Hl0l14KwjIj6pn+5CTgCs/caHWU4FrFFTSh2x7FBIEk9x5RCd/g4ezl5LaztVqGLe96f
         GbJA==
X-Gm-Message-State: AOJu0YzmcCrvIhmbwKlBFE7vxvj9VDkK5FSBL8Oar7tI808RR2ovHMbY
        ceCVaUOmdAXmC/RP17jrYsbcLA==
X-Google-Smtp-Source: AGHT+IH3f9cU14JXh2Hb6LKulH+gV6yDSQRozneYBR6cD7b82auAI9dBvLy+LU+tw3KaW/zbYV36RA==
X-Received: by 2002:a17:902:d2ca:b0:1c3:76c4:7242 with SMTP id n10-20020a170902d2ca00b001c376c47242mr39359589plc.22.1697186929320;
        Fri, 13 Oct 2023 01:48:49 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id ij25-20020a170902ab5900b001c755810f89sm3399949plb.181.2023.10.13.01.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 01:48:48 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] OPP: Minor cleanups
Date:   Fri, 13 Oct 2023 14:18:36 +0530
Message-Id: <cover.1697186772.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

While working on solving a bigger problem (which I will post separately), found
these minor issues which can be applied right away. Please let me know if
something breaks because of them.

--
Viresh

Viresh Kumar (5):
  OPP: Fix formatting of if/else block
  OPP: Add _link_required_opps() to avoid code duplication
  OPP: Reorder code in _opp_set_required_opps_genpd()
  OPP: Remove genpd_virt_dev_lock
  OPP: No need to defer probe from _opp_attach_genpd()

 drivers/opp/core.c | 67 +++++++++++++---------------------------------
 drivers/opp/of.c   | 66 +++++++++++++++++++++------------------------
 drivers/opp/opp.h  |  2 --
 3 files changed, 49 insertions(+), 86 deletions(-)

-- 
2.31.1.272.g89b43f80a514

