Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46D9375281
	for <lists+linux-pm@lfdr.de>; Thu,  6 May 2021 12:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbhEFKng (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 May 2021 06:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbhEFKnf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 May 2021 06:43:35 -0400
X-Greylist: delayed 308 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 06 May 2021 03:42:37 PDT
Received: from forward103j.mail.yandex.net (forward103j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720B8C061574
        for <linux-pm@vger.kernel.org>; Thu,  6 May 2021 03:42:37 -0700 (PDT)
Received: from iva1-fcc2a0b4c175.qloud-c.yandex.net (iva1-fcc2a0b4c175.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:7ab:0:640:fcc2:a0b4])
        by forward103j.mail.yandex.net (Yandex) with ESMTP id 6E9256741A6B;
        Thu,  6 May 2021 13:37:25 +0300 (MSK)
Received: from iva8-a4a480c9f089.qloud-c.yandex.net (iva8-a4a480c9f089.qloud-c.yandex.net [2a02:6b8:c0c:da5:0:640:a4a4:80c9])
        by iva1-fcc2a0b4c175.qloud-c.yandex.net (mxback/Yandex) with ESMTP id mPWALw7ZyW-bPIOWsHf;
        Thu, 06 May 2021 13:37:25 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1620297445;
        bh=iW64rvJKc9IB6oWUIC2MgCDPb89NJPS8uJMtoZR6OKI=;
        h=In-Reply-To:Cc:To:From:Subject:Message-ID:References:Date;
        b=Fs6KLRdLUAd7uHgutQKNUBvyJmreOCnSVpfINTOsXgnWJ6TAMJlJiUWqp9OCZt3av
         Lo7fe+AYZRSZoEhyZ4XJ+sqquyAbL/5S1BpUY9OieOZECkjIhNGhBqRjnK6DfzIv7j
         eZSI38gW5LX4wwBIL8FsTlqoFyJ9PIJmzqlMeOqY=
Authentication-Results: iva1-fcc2a0b4c175.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
Received: by iva8-a4a480c9f089.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id uTgWIEcJ6p-bOLu8J6U;
        Thu, 06 May 2021 13:37:24 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Message-ID: <9b40e11dfda8bee1adb34d6b3243496adc89087f.camel@yandex.ru>
Subject: Re: How to detect s2idle from a drivers/pci/quirks.c ?
From:   Konstantin Kharlamov <hi-angel@yandex.ru>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Date:   Thu, 06 May 2021 13:37:24 +0300
In-Reply-To: <CAJZ5v0id_5yY8P=Nc+psNmxb_PTmgxryxMDZ2taxOKfynojWfQ@mail.gmail.com>
References: <83426b2264f23a3a790aa6c1cc631669ede81e66.camel@yandex.ru>
         <CAJZ5v0id_5yY8P=Nc+psNmxb_PTmgxryxMDZ2taxOKfynojWfQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thank you, that worked! Gonna send a patch soon (though that gonna be for linux-
pci ML)

On Thu, 2021-05-06 at 11:22 +0200, Rafael J. Wysocki wrote:
> On Thu, May 6, 2021 at 2:04 AM Konstantin Kharlamov <hi-angel@yandex.ru>
> wrote:
> > 
> > Hello! I'm solving a bug where s2idle (as opposed to a deeper `mem` suspend)
> > results in external monitor no longer detected, and `dmesg` having PCI-
> > related errors and a stack trace.¹
> > 
> > I pinned down the problem to the fact that
> > `quirk_apple_poweroff_thunderbolt()` should not be called upon s2idle.
> > 
> > Now, the last bit is: how do I detect from within this function that the
> > ongoing suspend-mode is the s2idle (aka freeze) ?
> 
> There are a couple of ways.
> 
> The one that I would most likely choose is to call
> pm_suspend_via_firmware() and skip the quirk if that returns 'false'.
> 
> 
> 
> 
> > That is, so I can return from the function early in this case, without
> > powering down any hw. I studied code there and in suspend.c, to no avail so
> > far.
> > 
> > 1: https://bugzilla.kernel.org/show_bug.cgi?id=212767
> > 


