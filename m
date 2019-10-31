Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B883EB021
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 13:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfJaMXh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Oct 2019 08:23:37 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40652 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbfJaMXg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Oct 2019 08:23:36 -0400
Received: by mail-pg1-f193.google.com with SMTP id 15so3957306pgt.7
        for <linux-pm@vger.kernel.org>; Thu, 31 Oct 2019 05:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=L7FbNq4GtcEGuMrNoamJkpzDtDF+1hg78dDxcjF8GrA=;
        b=yoTArB90N55H99xOlmJsXTlX5Q4PdrQV2uSRnS11/me3WlG9q7aAWgOJjafBlLqLz2
         JOi5ezGa/Q/VE6g75yQmuFb29m7vFH7/gKIGz3b/RvsoUWVYM21Hj0Ly7PoDvYb45wHP
         ntHx4AkgwlGfAIHnOfHVMcQVxHhOMr0n/xikhaRl+QVGIqAHdOLFRkChL7eKRtHP+Ise
         pRoH/2YffkBa92Mlswd0f/wyi3PU9lIhTE0dtndJ5v3tf2JGgDdfc8vm2SJQrp/cTeGY
         3WLB3mIXHHn0OKZzq4FbUHFHaQlAAProeAAcniPwRBNNllznqIZHTQIlVd5Vndg+1hDW
         y0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=L7FbNq4GtcEGuMrNoamJkpzDtDF+1hg78dDxcjF8GrA=;
        b=U4stpQpTcgJj0DUCRWBlhysrIkDJ4sdy7wUtn6FMMO/NWSDBDEbXhK/VVzOK9w15tL
         mVRIYkzrpLrx5B0sCuOoxbox4XFgjKBonQLuqbaDS/Y6XO2rgVPkAiS7alOhogaxSQxN
         iq7kKp79zTwOWqVQnOS6Kr6a0DY6Fna6aH7Tv3K0A8dpU6bsqxJt/8uTIRfkP6iX3qPf
         kaIeSpBv2uuYbpGaZ64l9+k19DWheToQH/Aygenq8/yBqnUm+DrtFAK8xwtI8QflevKX
         OIw/0DFCB5SQdvJu6Tl9BXIYGole19SqyXQMmSdZ/09yyeaSiiJjTl5+J/I7fb/sX1sC
         ETLw==
X-Gm-Message-State: APjAAAVLmvIOAmHaNnwCRkxY894ZFOU/Wpl37SMNGUuuSPFjdhKjgOE6
        7s8aK1zS/VGMzs0S/CQ6dZ1HZQ==
X-Google-Smtp-Source: APXvYqzkMwwYEMRk7E7iMmBJE8XD9e61/YS3XuGQMYPLmQolNAnvK2BAUeKzmOayGe1Fd76SpxyXug==
X-Received: by 2002:a17:90a:48:: with SMTP id 8mr6777617pjb.82.1572524616055;
        Thu, 31 Oct 2019 05:23:36 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j25sm2983077pfi.113.2019.10.31.05.23.31
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 31 Oct 2019 05:23:34 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, baolin.wang7@gmail.com,
        zhang.lyra@gmail.com, orsonzhai@gmail.com
Subject: [PATCH v2 0/5] Improve the SC27XX fuel gauge controller
Date:   Thu, 31 Oct 2019 20:22:39 +0800
Message-Id: <cover.1572523415.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

This patch set adds one battery resistance-temperature table to optimize
the real battery internal resistance in different tempertures, and
calibrates the resistance of coulomb counter to improve the accuracy
of the coulomb counter.

Any comments are welcome. Thanks.

Changes from v1:
 - Fix the order of values in resistance-temp-table property's description.
 - Add an unit suffix for FGU resistance property.

Baolin Wang (4):
  dt-bindings: power: Introduce one property to describe the battery
    resistance with temperature changes
  power: supply: core: Add battery internal resistance temperature
    table support
  dt-bindings: power: sc27xx: Add a new property to describe the real
    resistance of coulomb counter chip
  power: supply: sc27xx: Calibrate the resistance of coulomb counter

Yuanjiang Yu (1):
  power: supply: sc27xx: Optimize the battery resistance with measuring
    temperature

 .../devicetree/bindings/power/supply/battery.txt   |    5 ++
 .../devicetree/bindings/power/supply/sc27xx-fg.txt |    3 +
 drivers/power/supply/power_supply_core.c           |   67 +++++++++++++++++++-
 drivers/power/supply/sc27xx_fuel_gauge.c           |   49 +++++++++++++-
 include/linux/power_supply.h                       |   10 +++
 5 files changed, 130 insertions(+), 4 deletions(-)

-- 
1.7.9.5

