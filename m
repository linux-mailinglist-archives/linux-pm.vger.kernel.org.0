Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 863F312B3D0
	for <lists+linux-pm@lfdr.de>; Fri, 27 Dec 2019 11:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfL0KVs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Dec 2019 05:21:48 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42876 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfL0KVs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Dec 2019 05:21:48 -0500
Received: by mail-ot1-f65.google.com with SMTP id 66so35813457otd.9;
        Fri, 27 Dec 2019 02:21:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=BNozEkFQwJDe/ZH+qVhHoHwdDuhlvg4ivwtzO8Pa6xg=;
        b=I1jYO6Sf3zSHEdGxe7mJ7K2cxjZrYOo3OJkjeWvSRyariGUUx4GuWa4h/M4bqZmGf6
         GVDq6UNCLFVpJKtaF/dOkainsyRckz/1sfuwHaR0nEO7cR8TptRUlAC4b0ssozDdcEsk
         S/glSkQljhZwUwDM0dVdq6HazTOHLCWKYGtj5rBXlDNphCf6QQGoM/hR6lApVmVPo3Ir
         jYGktUO5uDX0+g7HjLLMKg3ChDKYKOyNjXdsztB2hiNxKliIuOLD033GVORsC7sZkPvj
         MN5TcQ9kJzMcnYZZ5r5xbAEQwW8Uai0Tt6wneahM5ovC6PoOO1sR+qVAcjc5FPywFEGH
         hwRA==
X-Gm-Message-State: APjAAAVY4ekIdLUlk0iGziIjxUntovA1z9g0j34HaEiNEJlmzJWx48Dh
        LLL60Mh8Ufb7LyXhLT0QoY2hKPzQjbLjHwyrgppw+rV5
X-Google-Smtp-Source: APXvYqxlydIBPjCsSMvnEjO+VOHBR4LNZQiX+rMNcvWG42Wv+Jgl6P9tBnssQ1bkjK8cb/PRZS646jD50rmGEuixb9E=
X-Received: by 2002:a05:6830:1e67:: with SMTP id m7mr52522912otr.262.1577442107741;
 Fri, 27 Dec 2019 02:21:47 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 27 Dec 2019 11:21:37 +0100
Message-ID: <CAJZ5v0i02hjtkXqxo=38XByY=G7LEDxdMbagAAvf207tSHXA2w@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v5.5-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.5-rc4

with top-most commit 2cb7bfc1ca9a34ca148ed77f5f6f07373312bb0a

 Merge tag 'devfreq-fixes-for-5.5-rc4' of
git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux

on top of commit 46cf053efec6a3a5f343fead837777efe8252a46

 Linux 5.5-rc3

to receive power management fixes for 5.5-rc4.

These fix compile test of the Tegra devfreq driver (Arnd Bergmann)
and remove redundant Kconfig dependencies from multiple devfreq
drivers (Leonard Crestez).

Thanks!


---------------

Arnd Bergmann (1):
      PM / devfreq: tegra: Add COMMON_CLK dependency

Leonard Crestez (1):
      PM / devfreq: Drop explicit selection of PM_OPP

---------------

 drivers/devfreq/Kconfig | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)
