Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6102E813A7
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2019 09:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfHEHsV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Aug 2019 03:48:21 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41791 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfHEHsV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Aug 2019 03:48:21 -0400
Received: by mail-qt1-f194.google.com with SMTP id d17so1132263qtj.8;
        Mon, 05 Aug 2019 00:48:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PIF4PYPyygnM1ho5NzdMwBMUBtSeyQAwHUR2WJm17mU=;
        b=mYgD2r+VEJqZq4fowusYZzZ/RKV/blrA14mIsiNd3kuG5hqyNCUQS873515eQfl788
         AGEf395/NYRvYNsY/6Xgc4UVLh8AIb8pYGXhQcDjALjxDOVPHlj6SPvO/iijKcsLOIqc
         /Zi76ktQHjDLcQ/8b2ew9BIuAUbKSBeg9PIQpp7dUgZV6y3wH8C+MA22fL0e0EFg9rdJ
         Fp1yj6gDlZn/uSNVoS/84i5QR1S+lzXWEwi8jo416seCb+1Qc5NdPiGVKQuxw//N4EjO
         maupv7hASvRxx9DZaoLALBHa+gg3YCKGas2rM6m1sdxlBh4Elj9q2ZJExAW+ytFRA44C
         kxXA==
X-Gm-Message-State: APjAAAX2Z0f7nF6IDizZlDSBdbUBwddw8Soy4SJJD9WZVng5Ez1HrrLg
        6eW0LLHCBgx12wOe344mnTwdkhKPNAM26AwwPX0=
X-Google-Smtp-Source: APXvYqxiNlojiW3VMRgMyDRNUGmaUhkPF0Y2iM4dh4k+cbmySHUI5Tf81/3/PgsbXX9xChMbLn5UQE+B13awcg7mBK8=
X-Received: by 2002:a0c:ba2c:: with SMTP id w44mr106591931qvf.62.1564991299977;
 Mon, 05 Aug 2019 00:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190708125247.3769080-1-arnd@arndb.de> <6aa562a3-effe-12c2-25d8-47ecf583d724@vaisala.com>
In-Reply-To: <6aa562a3-effe-12c2-25d8-47ecf583d724@vaisala.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 5 Aug 2019 09:48:03 +0200
Message-ID: <CAK8P3a2_UtCDGG0qtTyTAADh4BoErS_q0PBMGmZ7UUHrQ9Y2ww@mail.gmail.com>
Subject: Re: [PATCH] power: reset: nvmem-reboot-mode: add CONFIG_OF dependency
To:     Nandor Han <nandor.han@vaisala.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 5, 2019 at 9:10 AM Nandor Han <nandor.han@vaisala.com> wrote:
>
> On 7/8/19 3:52 PM, Arnd Bergmann wrote:
> > Without CONFIG_OF, we get a build failure in the reboot-mode
> > implementation:
> >
> > drivers/power/reset/reboot-mode.c: In function 'reboot_mode_register':
> > drivers/power/reset/reboot-mode.c:72:2: error: implicit declaration of function 'for_each_property_of_node'; did you mean 'for_each_child_of_node'? [-Werror=implicit-function-declaration]
> >    for_each_property_of_node(np, prop) {
> >
> > Add a Kconfig dependency like we have for the other users of
> > CONFIG_REBOOT_MODE.
> >
> > Fixes: 7a78a7f7695b ("power: reset: nvmem-reboot-mode: use NVMEM as reboot mode write interface")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >   drivers/power/reset/Kconfig | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> > index 8dfb105db391..a564237278ff 100644
> > --- a/drivers/power/reset/Kconfig
> > +++ b/drivers/power/reset/Kconfig
> > @@ -248,6 +248,7 @@ config POWER_RESET_SC27XX
> >
> >   config NVMEM_REBOOT_MODE
> >       tristate "Generic NVMEM reboot mode driver"
> > +     depends on OF
> >       select REBOOT_MODE
> >       help
> >         Say y here will enable reboot mode driver. This will
> >
>
> Wouldn't this be more appropriate to add the "depends on OF" to "config
> REBOOT_MODE" section, since this is an error to `reboot-mode.c` unit?

It's too late for 5.3-stable now, as that would break existing configurations
that won't select REBOOT_MODE themselves, and it adds a bit of complexity,
but we could to it for 5.4 if you think that is necessary.

       Arnd
