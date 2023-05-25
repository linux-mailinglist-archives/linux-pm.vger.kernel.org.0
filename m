Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71EF37118E3
	for <lists+linux-pm@lfdr.de>; Thu, 25 May 2023 23:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjEYVRK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 May 2023 17:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236434AbjEYVRJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 May 2023 17:17:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375DD195
        for <linux-pm@vger.kernel.org>; Thu, 25 May 2023 14:17:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5706B64ABF
        for <linux-pm@vger.kernel.org>; Thu, 25 May 2023 21:17:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D04C433D2;
        Thu, 25 May 2023 21:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685049426;
        bh=DQxM8XApi5rLqlMCf+lHIxyPqRLumBasZXh4YO+D3DI=;
        h=From:To:Cc:Subject:Date:From;
        b=TDw2aqfkn1TTO1ekWOhPLVL8P/Cqk8ezqOd2HK3uiTJ7OAmUKPnkdqKIIM5/G6vVS
         wrrfFp706sCo7YaVVBIeTezUMh6gDjeapeA/V1AsCmD+gFMU5yVXVzkO2Fxc996GgG
         dy8K4LUmWlerJE+/zBdf4Zc5R/Btu/ERZweQ5GviJq7fqRjnGO1MWH7PmnCAnKM3FR
         z1HT37+djQQYvw876TTN4J5E8+NYtB4EEuvLwSa4sYdIcDDHYsbpFgG8xcxpn839V6
         /5pJFfYgPbL/nOudWm09zYhc3ZO3w8+XUsOW7Q0pF3N2oQQbRZJg+Oy+xOw9Jnf5X3
         fdLNZXEu38raw==
From:   Eduardo Valentin <evalenti@kernel.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org,
        linux-pm@vger.kernel.org
Cc:     Eduardo Valentin <eduval@amazon.com>
Subject: [PATCH 0/3] thermal: hook in with reboot and crash
Date:   Thu, 25 May 2023 14:16:52 -0700
Message-Id: <20230525211655.627415-1-evalenti@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Eduardo Valentin <eduval@amazon.com>

Hello,

This small series of changes teaches thermal core about
reboot and crash callbacks. The intention is to have the core
to get notified and the pass in the event to thermal governors
that are willing to perform actions during reboot or crash events.
The thermal workers will be teared down in the process too.

There is no code dependency this series was built on top of:
https://lkml.org/lkml/2023/5/18/1207

Separate governor changes will be sent in another series.

BR,

Eduardo Valentin (3):
  thermal: core: introduce governor .reboot_prepare()
  thermal: core: register reboot nb
  thermal: core: register a crash callback

 drivers/thermal/thermal_core.c | 54 ++++++++++++++++++++++++++++++++++
 include/linux/thermal.h        |  4 +++
 2 files changed, 58 insertions(+)

-- 
2.34.1

