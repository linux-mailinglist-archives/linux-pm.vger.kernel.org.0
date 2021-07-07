Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD5373BE891
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jul 2021 15:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhGGNQW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Jul 2021 09:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhGGNQV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jul 2021 09:16:21 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFF6C06175F
        for <linux-pm@vger.kernel.org>; Wed,  7 Jul 2021 06:13:41 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id l7so2076571wrv.7
        for <linux-pm@vger.kernel.org>; Wed, 07 Jul 2021 06:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rpnf5ui3+hnRrY8YGy8rXi5xfNzvjgI0JQwfh/q3EXQ=;
        b=A+dROaEL7bCBWiUmI8lBLdEC/lc9Sy2rh7+vdSTNbzjYBg3472ZuPMmdwRjufGy0fV
         It7dj4eHCpP6GQVHDvvOLEBi6XEs9TVzRFmKunJQGIrpKaIl8if09zuZ/8adMPOxnnS5
         H9zisXyoLmSKqosGfhTZU26j1910lTfn5ZaxMLY8TLmZwRJZDdwoZ4qP4jzFPbuI7b35
         vqqY5utc7W9mMtdaYFm3mgmvw4BL4ToVv+QYNUjG6xPWZvKiyUdMauRDfmry4QlJyFwO
         N2YWUR/xifzonDnRF3ekkMwOGQxIDuGYFvqZNGEXoAK+abkDBqVrb9WNEx3+ciQBmEi9
         7z/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rpnf5ui3+hnRrY8YGy8rXi5xfNzvjgI0JQwfh/q3EXQ=;
        b=sxUFsYDuHdLNEkUtCT6aoyaltlKiQsFL8Row7JK4VPd0F+CD3vY+2hUzUEQ85Or24V
         BIGef8x8UrNvD3BqgMNkdMrSdGz7ohejSNeLCWzaodOAYCARMDGLnpg2Z57hksKcipqD
         /3XD57coC7OjN8aoHXIjT8bPCfyuY9tjFuFhRgrWbx5HNN1cZ0Coi1rq/eq9+31TS3a4
         aLY6c+xlgBmlHW1RDlANI+vzuuB1Qws5i9v0xG3938rYl6maF9r+JYHcZESoaJL5PzNm
         GhJXeuomd7PKm4RdWfVnyx6XwraJ/PpcUEANEsFeXCDycXgUreVi2Ez8nMtvAnk3LgNw
         iNwg==
X-Gm-Message-State: AOAM530dHVTwuLopqUjmWkafnS0QICLR2BYARJzUjz1zT1roolBVTdo4
        B22sVeH5fXhrJvZJDCoLHYeqsQ==
X-Google-Smtp-Source: ABdhPJxpLc/cU0rZmKkqSAhSoisQ07hiLtrU/n9NHfWMJzu5RI/qj5Ap1lugexNGg5YdyYtl6V26cg==
X-Received: by 2002:adf:e743:: with SMTP id c3mr9100943wrn.354.1625663620040;
        Wed, 07 Jul 2021 06:13:40 -0700 (PDT)
Received: from bismarck.berto.se (p4fca2710.dip0.t-ipconnect.de. [79.202.39.16])
        by smtp.googlemail.com with ESMTPSA id l20sm19233670wmq.3.2021.07.07.06.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 06:13:39 -0700 (PDT)
From:   =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH 0/3] thermal: rcar_gen3_thermal: Add support for trip points
Date:   Wed,  7 Jul 2021 15:13:03 +0200
Message-Id: <20210707131306.4098443-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

This small series adds support for the .set_trips() to the 
rcar_gen3_thermal driver on the platforms that supports it.

Patch 1/3 prepares for the new feature by expanding the OF match data 
while patch 2/3 adds the actual change. Patch 3/3 is a drive-by fix of a 
datatype found while working on this feature.

The work is based on-top of thermal/next [1] and tested on M3-N and V3U 
without any regressions or other issues.

1. fe6a6de6692e7f71 ("thermal/drivers/int340x/processor_thermal: Fix tcc setting")

Niklas Söderlund (3):
  thermal: rcar_gen3_thermal: Create struct for OF match data
  thermal: rcar_gen3_thermal: Add support for hardware trip points
  thermal: rcar_gen3_thermal: Fix datatype for loop counter

 drivers/thermal/rcar_gen3_thermal.c | 170 ++++++++++++++++++++++++----
 1 file changed, 150 insertions(+), 20 deletions(-)

-- 
2.32.0

