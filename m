Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36813D5A3E
	for <lists+linux-pm@lfdr.de>; Mon, 26 Jul 2021 15:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbhGZMmu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Jul 2021 08:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbhGZMmu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Jul 2021 08:42:50 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF68CC061757;
        Mon, 26 Jul 2021 06:23:18 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id k14-20020a05600c1c8eb02901f13dd1672aso7712454wms.0;
        Mon, 26 Jul 2021 06:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YoTT5JSM0KXApnvSxTPPv5lEEtSTHE0jP5EJ2+BXK/4=;
        b=mZSYePYuhUR/H3XVrwsU6Pb4g2MT7EECN5Cfd2yiEbYJ7qmp4aFq18eFxjOlVwMmP2
         kRQ7FUs21J0PgfqMlAAAhIUukxUnMLiuwrt32ICQEAGSS+0HmFrd7l56WAeliPPxlMjx
         /w2NgI7Ofztw49O206jJEC48oVhlZo3bjwq6kXYRSyMJGznu0kUO8k9JAP5p4bYVakIA
         v2pHs9uGvg170OMBHB0Gi6w4oR8LEtgHLGbNOnMDvMNZAB+EbobO7LhAPfK6V9IUpVAB
         zjJ4YHiihD4btVY6jvBIL8gmKDV2neqjmxcToa+7knOKfbABsOLYpnoTZ/Xw/fnqRZRO
         pevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YoTT5JSM0KXApnvSxTPPv5lEEtSTHE0jP5EJ2+BXK/4=;
        b=Lu9/KpXubo8i4QpJDc8FUqay4Bf8fmo0FDzExqQ3Yw7llfiqNet3H/OH964ZnFBbyf
         BSMLqg6XUMj6jSrd2R78gj7rZRqyBHIeO5NOei3TUkZlXFZ0HhsmKZdS54b6GlJm0hHn
         L6MTcGJYk45dfIF1kY8Jr4xlYR7vtIxEU8ta0MBXxT7Vr18g/jJ5c26zyR9+tMrBXYRa
         98degBGzepGWp+/yq/9YqXSOb1EChCrz2SHOI9/WjL9Thc92DmBd9reUdzh8PGQYMPbb
         ECWrIN2b+sd2EsanKOLCGibgLMIiL2fywGRcAj/tqKH/EzCKjOfr5pHXy/9b+UojrTdY
         ArTQ==
X-Gm-Message-State: AOAM531lbjv0d30tg8zJ7O/b3movENJMyMdMDNYAEaY+a9ThFtOgAKJB
        kvwpiTPHfeGfN2FOoUPaBgk=
X-Google-Smtp-Source: ABdhPJxU5jilS297dc5rkI2UEbiBQRYHMTgzJueVTM3EwBDy7lQOv2gWHV/Psmf1QdzuaNGEu/uiDA==
X-Received: by 2002:a05:600c:4f4d:: with SMTP id m13mr27309380wmq.31.1627305797286;
        Mon, 26 Jul 2021 06:23:17 -0700 (PDT)
Received: from microndev.lxd (ip5f5ac0ff.dynamic.kabel-deutschland.de. [95.90.192.255])
        by smtp.gmail.com with ESMTPSA id w15sm8580wmi.3.2021.07.26.06.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 06:23:16 -0700 (PDT)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com,
        linux-pm@vger.kernel.org, kbusch@kernel.org, axboe@fb.com,
        hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: [PATCH v2 0/2] Abrupt Shutdown for NVMe SSD
Date:   Mon, 26 Jul 2021 13:22:21 +0000
Message-Id: <20210726132223.1661-1-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Shivamurthy Shastri <sshivamurthy@micron.com>

In the platform with a limited backup power supply, devices like NVMe
SSD does unsafe shutdown.

These two patches address this issue by adding a power loss imminent
flag. The platform will enable the power loss imminent flag if the
platform's power is running on the limited backup power supply. During
the shutdown, the driver checks this information and pwerforms the
abrupt shutdown.

Shivamurthy Shastri (2):
  PM: introduce power loss imminent
  nvme: Add abrupt shutdown support

 drivers/nvme/host/core.c |  7 ++++++-
 drivers/nvme/host/pci.c  |  6 ++++--
 include/linux/suspend.h  | 28 +++++++++++++++++++++++++---
 3 files changed, 35 insertions(+), 6 deletions(-)

-- 
2.25.1

