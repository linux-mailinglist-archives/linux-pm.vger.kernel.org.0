Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E9221A9EB
	for <lists+linux-pm@lfdr.de>; Thu,  9 Jul 2020 23:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgGIVvp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jul 2020 17:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgGIVvo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2020 17:51:44 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A700C08C5CE;
        Thu,  9 Jul 2020 14:51:44 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id d18so3013618edv.6;
        Thu, 09 Jul 2020 14:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sZgQ/rgXy0f1txD21I1WuNSsdShPGwMiyPEgQmV+/ng=;
        b=UHBdHivVFTxqrWLNtuH5PWVTxCNw8Jb1ou33pWpC5DrQOgMMeEokn33wlzUDwHL8dm
         kBRzkfgS7VTxZihteeaPs9vGGEY25tPYkWZO4O3IRerLWcJeebM85HNi0U6BXZsALVDF
         qdYQ5nt34k68KaXEEc/VUYQkKT6da79x+OJtKQcPTdnBrHJbzH8hGWZs2is9rHf3PSsy
         I8/g/Fv8GvG01ozf6SohmC/g/1NtvyOeWgRyMWIUuDh1MWVI+Kkd6PyoixFAGSV2Hanv
         ZpsSLqhlS3noQeaoAmvkKrhxFGZDElpu6CYzCBkp4mrYkEbpOiv1kEpZu3EL/TCZumEH
         cNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sZgQ/rgXy0f1txD21I1WuNSsdShPGwMiyPEgQmV+/ng=;
        b=qmTrJeCBkMT1KTe2Ec3VvAwGIedhrKnCyjPfy9zrBkPXUNiWlONQO4xq+/KG82sHh1
         FsEQBZByY8Phnm15h6SjC3VRlvdJ/UHbtNAbIrqe0VLyK1wD+v1ONyLgTEdt386P05kM
         UoYMMbpsezoFpRBEKl+Swrl9t92KhxtD1Np30huoDybknUfBNlq7I0XL6cAnJx5v9DvE
         lxppOSxgMtW9BZCWRuSdGkrCRLLBbMOQNLk1wbkc/zmstZ2DxnxmOXy4TKj4x6RNtm/a
         xASvvdEn9P0mnPtrlP4My3Gw1lzPriNGzK9wC3UkrXIbiyez25pa0GXBKRsnw82289fe
         79Aw==
X-Gm-Message-State: AOAM533fBBbVsUCMAcHxcNsKjDJESqvTNMZdlHaTPJp4Gr/BqF1kv+tb
        WhyDpeuZHTaW2s3+6ypRya4=
X-Google-Smtp-Source: ABdhPJzw5f9c5v4M+O9fs6KhEgVVMRq60AaVUtOw7FiwE0aMNnXhOAKEjnViVMxPCjDxi3fsU2kQIA==
X-Received: by 2002:a50:cd53:: with SMTP id d19mr75655835edj.300.1594331502912;
        Thu, 09 Jul 2020 14:51:42 -0700 (PDT)
Received: from Ansuel-XPS.localdomain (host-87-16-250-164.retail.telecomitalia.it. [87.16.250.164])
        by smtp.googlemail.com with ESMTPSA id e16sm2498260ejt.14.2020.07.09.14.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 14:51:42 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] Add support for ipq8064 tsens
Date:   Thu,  9 Jul 2020 23:51:30 +0200
Message-Id: <20200709215136.28044-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Ipq8064 SoCs tsens driver is based on 8960 tsens driver. This patchset expand
the 8960 unused driver with interrupt support and set_trip point.
Ipq8064 needs to registed with a syscon phandle as the tsens regs on
this platform are shared with the gcc controller.

Ansuel Smith (6):
  drivers: thermal: tsens: load regmap from phandle for 8960
  drivers: thermal: tsens: add ipq8064 support
  dt-bindings: thermal: tsens: document ipq8064 bindings
  drivers: thermal: tsens: add interrupt support for 9860 driver
  drivers: thermal: tsens: add support for custom set_trip function
  drivers: thermal: tsens: add set_trip support for 8960

 .../bindings/thermal/qcom-tsens.yaml          |  51 +++-
 drivers/thermal/qcom/tsens-8960.c             | 283 +++++++++++++++++-
 drivers/thermal/qcom/tsens.c                  |   7 +
 drivers/thermal/qcom/tsens.h                  |   3 +
 4 files changed, 321 insertions(+), 23 deletions(-)

-- 
2.27.0

