Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876C36D31DB
	for <lists+linux-pm@lfdr.de>; Sat,  1 Apr 2023 17:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjDAPH7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 1 Apr 2023 11:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjDAPH6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 1 Apr 2023 11:07:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9D31EA2A
        for <linux-pm@vger.kernel.org>; Sat,  1 Apr 2023 08:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680361622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=bOT5mXIUQVhaWpcuVWro14YhSwAh7rnWJWD/RMTj92s=;
        b=SAxBlfaVLlO7YAUAjhA9xfpc06n59ZwesFr27N7UyEcMJFTDdvirYoWLRsQ/qOvFEVFjjo
        ZU81k/b94xOM3r/m+H2FK+PRIpxG4b/gOzUG+TidfD0JRMPZXwdTaEJTPQwFmMURVDENdt
        SAOaP27CQzvcy15huRozRYjkZ4SS+Qg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-pawNyDSQNFycMd0mCPl1FQ-1; Sat, 01 Apr 2023 11:07:00 -0400
X-MC-Unique: pawNyDSQNFycMd0mCPl1FQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 881721C09500;
        Sat,  1 Apr 2023 15:07:00 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF09F440D8;
        Sat,  1 Apr 2023 15:06:59 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org
Subject: [PATCH 0/1] power: supply: axp288_charger: Use alt usb-id extcon on some x86 android tablets
Date:   Sat,  1 Apr 2023 17:06:50 +0200
Message-Id: <20230401150651.597155-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian,

This patch used to be part of a patch set with 2 ACPI patches which
introduce the acpi_quirk_skip_gpio_event_handlers() which this patch
depends on.

Rafael has picked up the 2 ACPI patches and submitted them to Linus
as fixes for this cycle:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5adc409340b1fc82bc1175e602d14ac82ac685e3

But this patch was not picked up.

So I'm resubmitting this patch hereby for direct inclusion into
your linux-power-supply tree.

Note this relies on commit 5adc409340b1 ("ACPI: x86: Introduce an
acpi_quirk_skip_gpio_event_handlers() helper") which is in Linus
tree, but only in v6.3-rc3 and later.

Regards,

Hans


Hans de Goede (1):
  power: supply: axp288_charger: Use alt usb-id extcon on some x86
    android tablets

 drivers/power/supply/axp288_charger.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

-- 
2.39.1

