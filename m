Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE22B146BFA
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2020 15:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbgAWOz7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Jan 2020 09:55:59 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35269 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729108AbgAWOz6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jan 2020 09:55:58 -0500
Received: by mail-ot1-f68.google.com with SMTP id i15so3004860oto.2;
        Thu, 23 Jan 2020 06:55:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=YXaISo5MaVHwh2Txq2vFbb97VbWr9ak2q2WAWYCWfbs=;
        b=mebriUItxuosX47xnxW280w98A+V/Uz9hedGVlWtHZBPLDnYh7wjBpHtiA5Of1PBSN
         zArgWM4lBfLi3XkCyZX9hskBtt7Wrza+6G2HBJfh6eSFqXqX8UZybqJxFZYwqsY9+ao0
         lomiDZ5pPDA4J4Y5OpURglFpaIduJ5hjGWZ3K+0LogH1T4MpIxGzYPEXZ64t8BS+b9ue
         IGxgEucXucLIkSZ/tgvpE3kblGPhOVHKUN6JF//k/4nBcRIE8X57tL3Q54H6nV0PrNZc
         ejzg39faVvRbJEtup/ctDEiq41/MWgS5OXh2LTLH7sTVdGrpPDeCaZoASA2E9bvQ58bH
         CmVQ==
X-Gm-Message-State: APjAAAWMN3ma17DLLqmhiS4oUGjL6Tx5XBXvfBntCZwTr1uMa6PbF9d9
        3Z7KZ5ov+XAB2cexZlWnCUq1gZF5ciTWKSplU3DbCrfY
X-Google-Smtp-Source: APXvYqzBNEEvnwFVu0FTB6V3Sd/Ly8tvA1+lAaOF/1X6VPW93+Hnk/yUlvY9X4w6/uGF2ckWdDAtj3XCu1xDy8QIzNw=
X-Received: by 2002:a9d:7653:: with SMTP id o19mr11159197otl.118.1579791358139;
 Thu, 23 Jan 2020 06:55:58 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 23 Jan 2020 15:55:47 +0100
Message-ID: <CAJZ5v0g1n2ncCOe-y5dOHS3pGDLQ9e92Z761S86XV8GPKkG4iA@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v5.5-rc8
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
 pm-5.5-rc8

with top-most commit 18451f9f9e5810b8bd1245c5ae166f257e0e2b9d

 PM: hibernate: fix crashes with init_on_free=1

on top of commit b3a987b0264d3ddbb24293ebff10eddfc472f653

 Linux 5.5-rc6

to receive a power management fix for 5.5-rc8.

This prevents the kernel from crashing during resume from
hibernation if free pages contain leftover data from the
restore kernel and init_on_free is set (Alexander Potapenko).

Thanks!


---------------

Alexander Potapenko (1):
      PM: hibernate: fix crashes with init_on_free=1

---------------

 kernel/power/snapshot.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)
