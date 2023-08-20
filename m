Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067F0781EED
	for <lists+linux-pm@lfdr.de>; Sun, 20 Aug 2023 19:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjHTRLi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 20 Aug 2023 13:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjHTRLf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 20 Aug 2023 13:11:35 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E56E83C3D;
        Sun, 20 Aug 2023 10:08:46 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,188,1684767600"; 
   d="scan'208";a="173400400"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 21 Aug 2023 02:08:46 +0900
Received: from localhost.localdomain (unknown [10.226.92.18])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id DA59440062AF;
        Mon, 21 Aug 2023 02:08:43 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-pm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 0/2] Convert enum->pointer for data in the tmp51x match tables
Date:   Sun, 20 Aug 2023 18:08:39 +0100
Message-Id: <20230820170841.82501-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Convert enum->pointer for data in the match tables, so that
device_get_match_data() can do match against OF/ACPI/I2C tables, once i2c
bus type match support added to it. see [1]

This patch series extend support for retrieving match data for ID lookup.
The first patch fixes the driver_data for ID table and second patch
convert enum->pointer to avoid non zero values as the proposed
solution returns NULL for non-match.

This patch series is only compile tested.

[1] https://lore.kernel.org/all/20230804161728.394920-1-biju.das.jz@bp.renesas.com/

Biju Das (2):
  power: supply: sbs-battery: Make similar OF and ID table
  power: supply: sbs-battery: Convert enum->pointer for data in the
    match tables

 drivers/power/supply/sbs-battery.c | 42 ++++++++++++++++++------------
 1 file changed, 26 insertions(+), 16 deletions(-)

-- 
2.25.1

