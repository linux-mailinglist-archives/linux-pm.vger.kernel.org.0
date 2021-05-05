Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF98374C2A
	for <lists+linux-pm@lfdr.de>; Thu,  6 May 2021 02:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhEFAFm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 May 2021 20:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhEFAFm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 May 2021 20:05:42 -0400
X-Greylist: delayed 323 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 05 May 2021 17:04:44 PDT
Received: from forward106o.mail.yandex.net (forward106o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::609])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46CBC061574
        for <linux-pm@vger.kernel.org>; Wed,  5 May 2021 17:04:44 -0700 (PDT)
Received: from forward103q.mail.yandex.net (forward103q.mail.yandex.net [IPv6:2a02:6b8:c0e:50:0:640:b21c:d009])
        by forward106o.mail.yandex.net (Yandex) with ESMTP id 70BC7506073D
        for <linux-pm@vger.kernel.org>; Thu,  6 May 2021 02:59:18 +0300 (MSK)
Received: from vla1-86dffdbd85ea.qloud-c.yandex.net (vla1-86dffdbd85ea.qloud-c.yandex.net [IPv6:2a02:6b8:c0d:1787:0:640:86df:fdbd])
        by forward103q.mail.yandex.net (Yandex) with ESMTP id 6C1A261E0002
        for <linux-pm@vger.kernel.org>; Thu,  6 May 2021 02:59:18 +0300 (MSK)
Received: from vla1-1bc5b51c612f.qloud-c.yandex.net (vla1-1bc5b51c612f.qloud-c.yandex.net [2a02:6b8:c0d:89c:0:640:1bc5:b51c])
        by vla1-86dffdbd85ea.qloud-c.yandex.net (mxback/Yandex) with ESMTP id TG6afsXRTY-xIJ8MJo0;
        Thu, 06 May 2021 02:59:18 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1620259158;
        bh=3I4+tXrr4mB7zRa9n4Iy8H2JREFdJ0Qilg1WxCVZ5Y8=;
        h=To:From:Subject:Message-ID:Date;
        b=cjZWhi991m5UcA4EUatIgVnGKd0m7wH2jrY12o48blPQoIC9+7zaBX33kLy3QAQE7
         UTSXZagCUaCq+LHhoBI0Klfew4qQAM4D0btRLuk9jh1Y8I2oP7BSQhma9wYGcEavQg
         GbGsjvyNDw52bwmmloOyMMnmMftbnyElH6pDRJMA=
Authentication-Results: vla1-86dffdbd85ea.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla1-1bc5b51c612f.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id iBNjEPUJTe-xHL85GrK;
        Thu, 06 May 2021 02:59:18 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Message-ID: <83426b2264f23a3a790aa6c1cc631669ede81e66.camel@yandex.ru>
Subject: How to detect s2idle from a drivers/pci/quirks.c ?
From:   Konstantin Kharlamov <hi-angel@yandex.ru>
To:     linux-pm@vger.kernel.org
Date:   Thu, 06 May 2021 02:59:18 +0300
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello! I'm solving a bug where s2idle (as opposed to a deeper `mem` suspend) results in external monitor no longer detected, and `dmesg` having PCI-related errors and a stack trace.¹

I pinned down the problem to the fact that `quirk_apple_poweroff_thunderbolt()` should not be called upon s2idle.

Now, the last bit is: how do I detect from within this function that the ongoing suspend-mode is the s2idle (aka freeze) ? That is, so I can return from the function early in this case, without powering down any hw. I studied code there and in suspend.c, to no avail so far.

1: https://bugzilla.kernel.org/show_bug.cgi?id=212767

