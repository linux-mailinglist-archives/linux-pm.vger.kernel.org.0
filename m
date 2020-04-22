Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE701B4E5D
	for <lists+linux-pm@lfdr.de>; Wed, 22 Apr 2020 22:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgDVUdC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Apr 2020 16:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgDVUdB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Apr 2020 16:33:01 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46DCC03C1AA
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2020 13:33:01 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a32so1428981pje.5
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2020 13:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=jCeWYCnhhC9ToX7slZfdTEYBZQCUrwfYBXRcN7qT7U8=;
        b=UO+xX3Q8r1JCfKH7BgXpnctxhkm0rF0cWVV0/oTCDm8iddC0e5NK5D1EOwY022FRdW
         Bi0sBJrCPebYJq7AqSJJrRWw21juBierZTOVm+RQTetM7+GDmcbuCdjJ0WqZIpXOIrs8
         iQLahSkNgGH0zJaY++9gFkeL+GjcQIzEKBzamWhVu1ubE6+Swx8u5M8vJ0/Nx+FQjMTS
         bXZpJsKM9OYQzFTBGIf5A7Y7hGTh//MYPcNQJIrVACeR/ppD76PdnLzX0ZnumTQi/Cfa
         AVQThatK0ynQj7UNkZKTMjLjE5ouv6pGreF/WAMocMiWmSKs4gqdFSsWoXmxOaZpyaos
         2doA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jCeWYCnhhC9ToX7slZfdTEYBZQCUrwfYBXRcN7qT7U8=;
        b=tckACJOTSG3jwnAdeHJIFyRDJyIDMaxwTdffLCy6RXADvUSeRlSTX8DzjJ/b48wkgZ
         /gpZ5hqVEFcUHNggJYcmWXFzDSPEpucoG7btm58OM4AKS14ZtEMHaPoeGAkKLBxDstMa
         eQnCSQrbqqGVsej9psEslWL264hDhPL9DqLiVxH5DOzJ/YRvGeVtJlM8dxYeB+hvLob3
         yqEEpTIr72DtyJfqTHT3KuRnB1REG5RYvfh08NIZU2A4hly2jec/okywAyqq//D69AXn
         LrmiqEG/qh6IA7cwY98nEn/Jdis/ZYgVRcdSDJs2y4IuryEBc9N2+5ysv19WzBLB/coj
         36sA==
X-Gm-Message-State: AGi0PuY7NUXRvW/lc6rhGjzehVIFgQVpGi4e/zKUS1ScfgertAvMFk1c
        cszn3bQv5TL6gFjo3WxWszM4Pg==
X-Google-Smtp-Source: APiQypIfHEK//oiAX9sm4588S3qKU/T9URBCuUpssWXapCXyk5kx73342FZOAyetJVSKhA9ugHqyWw==
X-Received: by 2002:a17:902:9004:: with SMTP id a4mr408660plp.275.1587587581021;
        Wed, 22 Apr 2020 13:33:01 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id b24sm360292pfd.175.2020.04.22.13.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 13:33:00 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Basil Eljuse <Basil.Eljuse@arm.com>,
        Ferry Toth <fntoth@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        netdev <netdev@vger.kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH v3 0/3] Fixes for deferred_probe_timeout cleanup
Date:   Wed, 22 Apr 2020 20:32:42 +0000
Message-Id: <20200422203245.83244-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Just wanted to resubmit these three fixes for the
deferred_probe_timeout cleanup that landed in the v5.7-rc1 merge
window.

The first resets the default timeout value back to zero so we
have no behavioral change from 5.6. This avoids regressions on
boards that have "optional links" in their device tree.

The second changes the code to use dev_warn() instead of
dev_WARN() to address complaints about unnecessary backtraces in
the boot log.

The last fixes an issue discovered by Yoshihiro Shimoda
and Geert Uytterhoeven, where if a timeout was set, things
like NFS root might fail due to wait_for_device_probe()
not blocking until the timeout expires.

thanks
-john

New in v3:
* Just included the previously posted dev_warn() fix into the
  series, so they didn't collide.


Cc: "David S. Miller" <davem@davemloft.net>
Cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Rob Herring <robh@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Basil Eljuse <Basil.Eljuse@arm.com>
Cc: Ferry Toth <fntoth@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Anders Roxell <anders.roxell@linaro.org>
Cc: netdev <netdev@vger.kernel.org>
Cc: linux-pm@vger.kernel.org

John Stultz (3):
  driver core: Revert default driver_deferred_probe_timeout value to 0
  driver core: Use dev_warn() instead of dev_WARN() for
    deferred_probe_timeout warnings
  driver core: Ensure wait_for_device_probe() waits until the
    deferred_probe_timeout fires

 drivers/base/dd.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

-- 
2.17.1

