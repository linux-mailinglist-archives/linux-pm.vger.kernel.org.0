Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF95431DD0
	for <lists+linux-pm@lfdr.de>; Mon, 18 Oct 2021 15:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbhJRNzH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Oct 2021 09:55:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:23048 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232511AbhJRNxL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Oct 2021 09:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634565059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qjhsAvx8w+oYRIFOaj5rM7aAnP8fTCLavzHgMZZ1QV0=;
        b=Jl9b1xfivMpwA3B+Kfr3jPl91LGRhZt/r0+hFNBJSpiclDghTK34VIJFFVwclTXY4iVDyd
        Yavq0bSU6M6C0ZFGuXfkfRglGLIuSL2D6ZNNLoJSxkRx2jdRr5630Q0wkRkQptnVUFBOk6
        pzLx62LEVCVMz2el0kaSas52J6iRJUw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-uetrZFm8Pam_rMVGkHo7qg-1; Mon, 18 Oct 2021 09:50:58 -0400
X-MC-Unique: uetrZFm8Pam_rMVGkHo7qg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5758F36300;
        Mon, 18 Oct 2021 13:50:57 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A5B0B70911;
        Mon, 18 Oct 2021 13:50:54 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Kate Hsuan <hpa@redhat.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH 0/3] power: supply: axp288-charger: cleanups + fixes
Date:   Mon, 18 Oct 2021 15:50:50 +0200
Message-Id: <20211018135053.213310-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi All,

Here are 3 patches for the axp288-charger driver which apply on top of
commit ed229454856e ("power: supply: axp288-charger: Optimize register
reading method") in linux-power-supply/for-next .

The first patch is a build fix and the other 2 are 2 small cleanups.

Regards,

Hans


Hans de Goede (3):
  power: supply: axp288-charger: Add depends on IOSF_MBIO to Kconfig
  power: supply: axp288-charger: Remove unnecessary is_present and
    is_online helpers
  power: supply: axp288-charger: Simplify axp288_get_charger_health()

 drivers/power/supply/Kconfig          |  2 +-
 drivers/power/supply/axp288_charger.c | 37 +++++----------------------
 2 files changed, 8 insertions(+), 31 deletions(-)

-- 
2.31.1

