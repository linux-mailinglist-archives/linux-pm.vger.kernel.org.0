Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8B63A45E3
	for <lists+linux-pm@lfdr.de>; Sat, 31 Aug 2019 21:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbfHaTfS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 31 Aug 2019 15:35:18 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45319 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbfHaTfS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 31 Aug 2019 15:35:18 -0400
Received: by mail-io1-f67.google.com with SMTP id f12so3579447iog.12
        for <linux-pm@vger.kernel.org>; Sat, 31 Aug 2019 12:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MJ/iD/oPEHsEzGQ/DDA12QMxceMO733MKRlP0ppxKvc=;
        b=NRWOynWHa8i0D5JOZmMY7F/HlWjXlV0WqOCqvtSEmQQE8rMq+wyB/sVIidvNVONZKZ
         /OPTdEGwM934pi92OAyQzSc7UFEkqjHfkMygsFFXlrpq34zeW3MqtLXdb1qxJxbtTab+
         Vkb1y8yIc3uPvmnrO9Pr2bMkyafV7dd04AwM6al6mYF3yxF5+6o4VFMd/kiB20Ls5nAw
         196dg5NLbKJ//4vjn7P/j/bGpplbmUTOHqTwH1Th2wmfpg7NgBgiPsrPwwWQTOHnMSpV
         P1TFMaBUiJnxTV8b4SBw8zOpggeAf1YOd9eZ8EG0n/m58gcdEkWuomCrdz1JH8k3puT8
         SiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=MJ/iD/oPEHsEzGQ/DDA12QMxceMO733MKRlP0ppxKvc=;
        b=HkJBKGXLH7PH3gOzTAuURLiAdEz7HMA5I8Y9vo6zOGIPsrZQk52sThNmL9mlR801lc
         hsTWQFLZtyVASqlnKAa1cZ76kaolqlHt0k72ieWwiPq1FutGBbQ8NF7bIJEh2F/nFWgD
         tqvE3ksX6NyUdNrknuAMdCt1xzKVbWJTxa2HDTNTfUnX4YtcDyHDAgPHBTJXPxwBzxX1
         hCQUIfNk29PNJrzBYX6sUZSPVoZotU6xWStZ+YfQfguhMzK/cHZX822McaQKaEfhFcw4
         HUCD5eX1Z96apshC6CFI9kpYZ3774eoHiYk9a+IwmSPoyPny9cxdaY3azS7kznZOB6RH
         yMcw==
X-Gm-Message-State: APjAAAXUZYrYZwmNj+vF0Zfx+1bMSkeTk49NaTbSVZbmjaQ8n5ECIOhz
        vXMiVypmJ9iKFJVr2Sgytu/KPPPN
X-Google-Smtp-Source: APXvYqzrpm3f9wM9sXqpFUtbZ/70qgn8+jEceqr99s/n7b0FZKtJSY26Owt/vYxrybdz1Nctyybokw==
X-Received: by 2002:a6b:5a0b:: with SMTP id o11mr25364136iob.98.1567280117768;
        Sat, 31 Aug 2019 12:35:17 -0700 (PDT)
Received: from nuc8.tds (h69-131-112-51.cntcnh.dsl.dynamic.tds.net. [69.131.112.51])
        by smtp.gmail.com with ESMTPSA id r2sm6937376ioh.61.2019.08.31.12.35.16
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2019 12:35:17 -0700 (PDT)
From:   Len Brown <lenb@kernel.org>
To:     linux-pm@vger.kernel.org
Subject: turbostat 19.08.31 is available
Date:   Sat, 31 Aug 2019 15:34:39 -0400
Message-Id: <20190831193458.12698-1-lenb@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thanks for the patches everybody!

You can download the latest turbostat (and x86_energy_perf_policy) for testing here:

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat

 tools/power/x86/turbostat/Makefile                 |   3 +-
 tools/power/x86/turbostat/turbostat.c              | 101 ++++++++++++++-------
 tools/power/x86/x86_energy_perf_policy/Makefile    |   3 +-
 .../x86_energy_perf_policy.8                       |   2 +-
 .../x86_energy_perf_policy.c                       |  28 +++---
 5 files changed, 90 insertions(+), 47 deletions(-)

[PATCH 01/19] tools/power x86_energy_perf_policy: Fix "uninitialized variable" warnings at -O2
[PATCH 02/19] tools/power/x86: Enable compiler optimisations and Fortify by default
[PATCH 03/19] tools/power: Fix typo in man page
[PATCH 04/19] tools/power x86_energy_perf_policy: Fix argument parsing
[PATCH 05/19] tools/power turbostat: remove duplicate pc10 column
[PATCH 06/19] tools/power turbostat: Make interval calculation per thread to reduce jitter
[PATCH 07/19] tools/power turbostat: fix leak of file descriptor on error return path
[PATCH 08/19] tools/power turbostat: fix file descriptor leaks
[PATCH 09/19] tools/power turbostat: fix buffer overrun

Prarit, Naoya,
For now, I went with your initial 1-line fix,
as I currently don't have an appetite for a 400-line patch
when 1-line spending 1KB / CPU will float the boat.

Yeah, it is a bummer that this "bundle formatted output into
a single buffered write" optimiation is even necessary...
you'd think that stdio could be smarter to automatically buffer
multiple prints into a single write...

[PATCH 10/19] tools/power turbostat: add Jacobsville support
[PATCH 11/19] tools/power turbostat: Fix Haswell Core systems
[PATCH 12/19] tools/power turbostat: rename has_hsw_msrs()
[PATCH 13/19] tools/power turbostat: Add Ice Lake NNPI support
[PATCH 14/19] tools/power turbostat: read from pipes too
[PATCH 15/19] tools/power turbostat: do not enforce 1ms
[PATCH 16/19] tools/power turbostat: Fix CPU%C1 display value

[PATCH 17/19] tools/power turbostat: Fix caller parameter of get_tdp_amd()
[PATCH 18/19] tools/power turbostat: Add support for Hygon Fam 18h (Dhyana) RAPL

Although these were marked RFC instead of PATCH, I applied them,
because they were otherwise properly signed, and seemed ready.

[PATCH 19/19] tools/power turbostat: update version number

cheers,
-Len

