Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7E179EA26
	for <lists+linux-pm@lfdr.de>; Wed, 13 Sep 2023 15:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbjIMN4M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Sep 2023 09:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbjIMN4L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Sep 2023 09:56:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC30E19B1
        for <linux-pm@vger.kernel.org>; Wed, 13 Sep 2023 06:56:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA1DC433C7;
        Wed, 13 Sep 2023 13:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694613367;
        bh=cPW3ngQcLFNVapX0q9aS5nmb5CE6JzKHtu3Dbmcap1M=;
        h=From:To:Cc:Subject:Date:From;
        b=KKMvp/l1Rq1L9185vo8pIgTFQuMzeAq6JuWHg+TWaOmaNUXrYeUjRM+tKOOvDFDuQ
         zNZfsAEdV+e95VXY/g58J4djh6Ax8xrkc7e2qeDOsw6Z0j53jaHAu7KIpYJVD30wrl
         G3qHY0TCu19q3QO6/LvVTvjqkWZxp6BqSRhhr/rVVZpZAP+bEL03S1YNgkNAsTbBeJ
         LXtkcjwyhtzTsd25tV1cN7k4+EF6aSkgk9GkF+rwtnWt+DJGEH3LreOWSM6h7Qu4HG
         +BofmIevmezasMvQjD/fTbMTaX32VroLZVA8egkHzWGuTGpW8zlfMKJDjzxW72ZzG6
         IdV0Z863yOSbQ==
From:   Conor Dooley <conor@kernel.org>
To:     ulf.hansson@linaro.org
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        arnd@arndb.de, changhuang.liang@starfivetech.com,
        jiajie.ho@starfivetech.com, linux-pm@vger.kernel.org,
        linux-riscv@lists.infradead.org, robh@kernel.org,
        walker.chen@starfivetech.com
Subject: [GIT PULL 0/5] Missed starfive pmdomain changes for v6.6, now for v6.7
Date:   Wed, 13 Sep 2023 14:54:23 +0100
Message-Id: <20230913-bloomers-scorebook-fb45e0a2aa19@spud>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1129; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=EKO/JXotiZvRjrciydNKo5TqXwavOcF+4xIEn9RLlOY=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKmM+/nPGSu+vpKQG/txu+X0tv7YgENZZ4+tUpep27iQ/ WNU+zXujlIWBjEOBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAEyk6Cojw/I1Mxe/6xXT4k1w zXMsnDc5dtvas2KG0/dscDM97sCxtJqR4czvOEmOtnXxGjxRE9+HZIu2lLBssONaEtEoc1DyZq4 VGwA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Hey Uffe,

Here's those missed changes in patch form. I figured it might be a bit
easier this way given the name of the subsystem is in flux, doubly so if
you'd like to put the header change of Rob's on fixes.

I had this out for LKP last night, seemed to get a clean bill of health,
before I rebased it on top of the new name this afternoon, and ofc it was
in linux-next on top of v6.5 for quite a while...

Thanks,
Conor.

CC: arnd@arndb.de
CC: changhuang.liang@starfivetech.com
CC: jiajie.ho@starfivetech.com
CC: linux-pm@vger.kernel.org
CC: linux-riscv@lists.infradead.org
CC: robh@kernel.org
CC: ulf.hansson@linaro.org
CC: walker.chen@starfivetech.com

Changhuang Liang (4):
  dt-bindings: power: Add power-domain header for JH7110
  pmdomain: starfive: Replace SOC_STARFIVE with ARCH_STARFIVE
  pmdomain: starfive: Extract JH7110 pmu private operations
  pmdomain: starfive: Add JH7110 AON PMU support

Rob Herring (1):
  pmdomain: starfive: Explicitly include correct DT includes

 MAINTAINERS                                   |   1 +
 drivers/pmdomain/starfive/jh71xx-pmu.c        | 139 ++++++++++++++----
 drivers/soc/starfive/Kconfig                  |   4 +-
 .../dt-bindings/power/starfive,jh7110-pmu.h   |   5 +-
 4 files changed, 117 insertions(+), 32 deletions(-)

-- 
2.39.2

