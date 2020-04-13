Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8821A6D79
	for <lists+linux-pm@lfdr.de>; Mon, 13 Apr 2020 22:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388516AbgDMUnH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Apr 2020 16:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388506AbgDMUnD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Apr 2020 16:43:03 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D7FC0A3BE2
        for <linux-pm@vger.kernel.org>; Mon, 13 Apr 2020 13:43:03 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id b7so4356989pju.0
        for <linux-pm@vger.kernel.org>; Mon, 13 Apr 2020 13:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Jzl9zw+WWi+s6Kx4ZBqfebz2iDt6ayXKGXNZZjJo2Pk=;
        b=VT1Z726v06Ujmb0lEnnzZAtHRT4apvVynE5ed5Ktp3UGwkACAebRQ9zx2/tlMYHO5F
         rywIuPMKAUti5V6eK/5urkFIHTA2avL3pBcpv8gN80Owcdom1iv5VfXqsI01rnIAsKJM
         rhph9sz5PVaOOwI3UNEZQRB4o7SSiuZeWuVIfQT2JqASu3CFmZUlpXfo30toXIzJhl94
         Ho65K0a43xa3bx6V4R+etOwnd0T+g1i7+JU+XRFRXnG4mBVArkSUa7KSxBRF8wIRSwaP
         kS6YP99wSgijh6YDO/COskWhGnToZT/yF2UvsM9LBykI/oQZrBYpXSEtLHX9qU8G7Haq
         TQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Jzl9zw+WWi+s6Kx4ZBqfebz2iDt6ayXKGXNZZjJo2Pk=;
        b=UgB/rOdcTLNpguuNYSG/KxMFUyNL527BTWMCa2eoacgMcQzQB0tdpqD283s0zns5pP
         mlGu7jwcizZ92oFUyHVvQCceqkn/L90WmoHyGfgkKP3LnW0/JXmLC2IQ5Ligm++P8nOG
         ihM7R9ln7G4eD5qIxfkcPjU5XYFZR2TlpifswfZRP6XgTW2/3H4tWGBRPkCZxuq8HI0n
         zblLLqMJxNsVedRbLGfu6NiKFiSlR4zhghxlhQdUREFcrDt7JlLZgCbCxu8Sp8KvpnxV
         sUtkPkiVJuS5W+ULrxnFyl0TRQ5nisPfzbPIKT9lsngX/mVH/o+cJZTC7gpPqX3FVqXi
         jCjQ==
X-Gm-Message-State: AGi0PuaaORF3gK3CF3/hLKLOQgue6VmnCO5KLr4VYbW9VakJlSDvGwoq
        VgQwDAGgFceEluLYBZZAOxNrVQ==
X-Google-Smtp-Source: APiQypIRvteVMg0gNs6DmMEEBBIlRcc/01DPdawXCFZi7iOutYc4cJYrlnAN1psu50sBspsa1M3cjw==
X-Received: by 2002:a17:90a:77cb:: with SMTP id e11mr24567922pjs.0.1586810583200;
        Mon, 13 Apr 2020 13:43:03 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id o21sm4763340pjr.37.2020.04.13.13.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 13:43:02 -0700 (PDT)
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
        netdev <netdev@vger.kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH v2 0/2] Fixes for deferred_probe_timeout cleanup
Date:   Mon, 13 Apr 2020 20:42:51 +0000
Message-Id: <20200413204253.84991-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Just wanted to submit these two fixes for the
deferred_probe_timeout cleanup that landed in the v5.7-rc1 merge
window.

The first resets the default timeout value back to zero so we
have no behavioral change from 5.6. This avoids regressions on
boards that have "optional links" in their device tree.

The scond fixes an issue discovered by Yoshihiro Shimoda
and Geert Uytterhoeven, where if a timeout was set, things
like NFS root might fail due to wait_for_device_probe()
not blocking until the timeout expires.

thanks
-john

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Rob Herring <robh@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: netdev <netdev@vger.kernel.org>
Cc: linux-pm@vger.kernel.org

John Stultz (2):
  driver core: Revert default driver_deferred_probe_timeout value to 0
  driver core: Ensure wait_for_device_probe() waits until the
    deferred_probe_timeout fires

 drivers/base/dd.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

-- 
2.17.1

