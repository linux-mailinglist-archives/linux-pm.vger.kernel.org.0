Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E0E67B07A
	for <lists+linux-pm@lfdr.de>; Wed, 25 Jan 2023 11:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235024AbjAYK7m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Jan 2023 05:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbjAYK7l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Jan 2023 05:59:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5943F2A6
        for <linux-pm@vger.kernel.org>; Wed, 25 Jan 2023 02:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674644338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8QBPIkJF1Z1Jse8Nf83Wd71gpn8BUJ8t82VW1i2uvdg=;
        b=dDeExInyBPYahTT5h3OZ4W0+CBxOAQVqctaIbm80kEBLEwUBnCJTVK0cnJ7BuL6cEEFQxt
        SiWMEPVWG6V+M9hIacHAr6XMweWpJAQMRTzAT/mOWSuLUpyzT5Kelq3yaX24hoAhUKn+1z
        7K6APjSltVlLF4OWU2KMT2StkRChliE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-483-6vt4q7DGN92ruhZITONTEg-1; Wed, 25 Jan 2023 05:58:52 -0500
X-MC-Unique: 6vt4q7DGN92ruhZITONTEg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 770183813F27;
        Wed, 25 Jan 2023 10:58:52 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.193.104])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 68A5551FF;
        Wed, 25 Jan 2023 10:58:51 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>, Marek Vasut <marex@denx.de>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org
Subject: [PATCH v2 0/2] power: supply: bq25890: Remaining dual-charger support patches
Date:   Wed, 25 Jan 2023 11:58:48 +0100
Message-Id: <20230125105850.17935-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian, Marek,

Most of my recent bq25890 series has been merged into:
linux-power-supply.git/for-next except for these 2.

AFAIK there are no outstanding review remarks wrt this 2 patches,
so I'm resending them to avoid them falling through the cracks
(or to restart / renew the discussion surrounding them if
necessary).

Regards,

Hans


Hans de Goede (2):
  power: supply: bq25890: Add support for having a secondary charger IC
  power: supply: bq25890: Add new linux,iinlim-percentage property

 drivers/power/supply/bq25890_charger.c | 76 ++++++++++++++++++++++++--
 1 file changed, 72 insertions(+), 4 deletions(-)

-- 
2.39.0

