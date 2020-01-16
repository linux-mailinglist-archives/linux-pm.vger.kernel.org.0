Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 334F413FCD7
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2020 00:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387472AbgAPXS1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jan 2020 18:18:27 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38982 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729351AbgAPXS1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jan 2020 18:18:27 -0500
Received: by mail-ot1-f68.google.com with SMTP id 77so21015769oty.6;
        Thu, 16 Jan 2020 15:18:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=9EAHGBuNSiTZ5l+4zkY1z64r39UtR5n6bdLL5+4kKYw=;
        b=b+jUIvN1fqe2yQJwN17tm5K0bnCqpeKpHEZDNXmoHmjsv9r37u4aySrAV/wv3DZbEM
         k08SjMNPSN35gUQ5uS5vbXgwyNpELMmjvOdWCi94jpFhh6RVp4YxD5pNAAJRWsqC749Z
         4ohQTOxvL6cqTdv64SEBY3evPYWmFvJiT+zpJFG7StueOVAF7w5tWRR6w+92nTNIcBgm
         9NXQOtGx8hkraHvyb8dyQ9p8/xe1OelU8427903oLzI04+SD+bvR4cmQpLALkogrC8C0
         BGMOdvgRZOOweTqDHXbDHnsd4w8ZNAs3omCeckUnt6eoKC3fj8FgSg/e6QfZ0liGV4Cb
         HHAw==
X-Gm-Message-State: APjAAAWqPFCo7dBuQFTILnZPnpC42hulTz1vuSuk3mmiM96FaqpgrHwl
        nooz4NeHNR+Z7s9Jo6dn6emE0Y5KFrf9MWK5gOsC96y5
X-Google-Smtp-Source: APXvYqwUZi+VXujTD0dJq+O3DBa1rtWtuoNRma2EaFrjX1F544jKaMnrJ4XSyslqHMl0UHvJxJbc4yTEuKlc5uInp7I=
X-Received: by 2002:a05:6830:1e67:: with SMTP id m7mr4139324otr.262.1579216706411;
 Thu, 16 Jan 2020 15:18:26 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 17 Jan 2020 00:18:15 +0100
Message-ID: <CAJZ5v0gx+Om02PH6t74R0d2F_sPZwncOSMWrhA0Yx77=xdpCyA@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v5.5-rc7
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
 pm-5.5-rc7

with top-most commit 57388a2ccb6c2f554fee39772886c69b796dde53

 cpuidle: teo: Fix intervals[] array indexing bug

on top of commit b3a987b0264d3ddbb24293ebff10eddfc472f653

 Linux 5.5-rc6

to receive a power management fix for 5.5-rc7.

This fixes a coding mistake in the teo cpuidle governor causing data
to be written beyond the last array element (Ikjoon Jang).

Thanks!


---------------

Ikjoon Jang (1):
      cpuidle: teo: Fix intervals[] array indexing bug

---------------

 drivers/cpuidle/governors/teo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
