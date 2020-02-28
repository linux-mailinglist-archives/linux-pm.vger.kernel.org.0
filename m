Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5DEB173547
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2020 11:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgB1K0j convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pm@lfdr.de>); Fri, 28 Feb 2020 05:26:39 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37341 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbgB1K0j (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Feb 2020 05:26:39 -0500
Received: by mail-oi1-f193.google.com with SMTP id q84so2390440oic.4;
        Fri, 28 Feb 2020 02:26:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=/2wWBljI3pqok1pAzElv5E6shSe+mwLsPBa4DozoQaI=;
        b=Fd69Mp45GlX1uhNQuRvxWdJvvO2AnUF1t0iYg7gn8x8Q4Fg3TnD1yxt2V/YasHGswX
         LPjCBsWCc3MVmKqvKrhydwxZAe/UxQs4WAhMlgK5nRJ/V/0h9RO5WwVeJFFIakqAWO/m
         Bs8MBk7xLlCz2D6P8cJ7h2D367/DE+ikB1Ev3OIWlvc2U/6lWT/9GW0Tho43nDrV8hzL
         0Z8L3Qe7IXOQQz4eG6h9/1LAQek7bqQCUN6PHKDuSRezJmg26CnpgZZ7+R1QnQAlB2wH
         XW8I01L+9iNxJFQk7/7JstJco6G8CzF5lXHPe1xRWKUTtHpDevw7r0eCKbHtUzqmUgxg
         HmHA==
X-Gm-Message-State: APjAAAXjTMX1MP0XpUCQQzLwXZzQGSNE99F5cFG0T+B9flsQJc87dXFD
        DRNTz1rVrpoMt0GodJiN9pErXDfRJv1FseZ7MSU+bPlR
X-Google-Smtp-Source: APXvYqwrCbXjL1lD9ksqBAXzUNh1E8EUx9WP7n/PhsY2yIVm+9bRMCsvdJBReO1eFWEDJocwVaco5snbr+73zbNykmI=
X-Received: by 2002:a54:4e96:: with SMTP id c22mr2739283oiy.110.1582885598134;
 Fri, 28 Feb 2020 02:26:38 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 28 Feb 2020 11:26:27 +0100
Message-ID: <CAJZ5v0gWVkz7Denfz59r6xXbUjvXWOifEVO4T2tr7EZpWL3oJw@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for v5.6-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.6-rc4

with top-most commit 189c6967fe61729fa7e9cdc32690b08fc7eebe41

 Merge branches 'pm-sleep' and 'pm-devfreq'

on top of commit f8788d86ab28f61f7b46eb6be375f8a726783636

 Linux 5.6-rc3

to receive power management fixes for 5.6-rc4.

These fix a recent cpufreq initialization regression (Rafael Wysocki),
revert a devfreq commit that made incompatible changes and broke
user land on some systems (Orson Zhai), drop a stale reference to
a document that has gone away recently (Jonathan Neuschäfer) and
fix a typo in a hibernation code comment (Alexandre Belloni).

Thanks!


---------------

Alexandre Belloni (1):
      PM / hibernate: fix typo "reserverd_size" -> "reserved_size"

Jonathan Neuschäfer (1):
      Documentation: power: Drop reference to interface.rst

Orson Zhai (1):
      Revert "PM / devfreq: Modify the device name as devfreq(X) for sysfs"

Rafael J. Wysocki (1):
      cpufreq: Fix policy initialization for internal governor drivers

---------------

 Documentation/power/index.rst |  1 -
 drivers/cpufreq/cpufreq.c     | 12 ++++++++++--
 drivers/devfreq/devfreq.c     |  4 +---
 kernel/power/snapshot.c       |  2 +-
 4 files changed, 12 insertions(+), 7 deletions(-)
