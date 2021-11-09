Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1195644ADAF
	for <lists+linux-pm@lfdr.de>; Tue,  9 Nov 2021 13:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244373AbhKIMp1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Nov 2021 07:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235574AbhKIMp0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Nov 2021 07:45:26 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA16BC061764
        for <linux-pm@vger.kernel.org>; Tue,  9 Nov 2021 04:42:40 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id z2-20020a9d71c2000000b0055c6a7d08b8so18447506otj.5
        for <linux-pm@vger.kernel.org>; Tue, 09 Nov 2021 04:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=swiecki.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ZxWs05PNgFFWkmMMVZIbCQopsY+aPrc9xqkCzhdaV0=;
        b=aDBWIiucwrR4twJxh1j09QBuXMtg+nFBsnO8yfr9inGfJNrTSt1egY7oqGSmhTfuwC
         vcaz3Sx1kbHlilCeGj3PMg6oXqs9z06/rThvqWJFf51LG1gitCUprW69S/+skNQV7nql
         CvQSW0VaO6vlINcuTpU/d89xxxnnJ05lBil0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ZxWs05PNgFFWkmMMVZIbCQopsY+aPrc9xqkCzhdaV0=;
        b=3g6XdzFbh5EumCUqfJTl9TqmH2HdlCdXTgpUayT5suCyhzPIimG9OPLMsKQBpYbExZ
         IMunwtHJA0Xbx00hNQovERm32z57gzKqZxx1a7arSGj3F0VIOmRWXbfGzFN5DQdIHCM5
         XutlADNHAyusrOox42EctNDf5Li2BJmPrfFPUjsDPLPb8KUOzXdOuL90DL4zJKULIdCz
         CQVqQvtimtRyjUTkEiXGi2/MVoL0X1UGAvBetvwI30Y2Ei7azSjna4dM0eQ0s8ImfDeT
         ApeL5voYvUKL+z23bnkR79YqfKt1HlpJV2y3/3ZBr7bpD+ND+DapgGS/Fp8FcVewN3Tg
         Jp/g==
X-Gm-Message-State: AOAM533BqAS7nI518/KDs5U5W8uw4Sol7VkEU7QFKYbOUYznZTtcGLAy
        2VOH/NQ49Hj+D4r6IuyaoOoiUscKP1rfQDW3SzA/9XFbVWtEdQ==
X-Google-Smtp-Source: ABdhPJy38nhRcMBXJpyq2S4dQ2zU3L9V/AZ8XtKJjs2aut3JvHhtudp4KIav7A/3isAEGLGD8gW0FtdtOdnqCmJmD80=
X-Received: by 2002:a05:6830:90f:: with SMTP id v15mr5661303ott.62.1636461760200;
 Tue, 09 Nov 2021 04:42:40 -0800 (PST)
MIME-Version: 1.0
References: <20211108212226.253mwl4wp7xjckqz@pengutronix.de>
 <20211109025619.GA1131403@bhelgaas> <20211109065927.26v6xn7d5yyuxw4h@pengutronix.de>
In-Reply-To: <20211109065927.26v6xn7d5yyuxw4h@pengutronix.de>
From:   =?UTF-8?B?Um9iZXJ0IMWad2nEmWNraQ==?= <robert@swiecki.net>
Date:   Tue, 9 Nov 2021 13:42:29 +0100
Message-ID: <CAP145pjO9zdGgutHP=of0H+L1=nSz097zf73i7ZYm2-NWuwHhQ@mail.gmail.com>
Subject: Re: [PATCH] pci: Don't call resume callback for nearly bound devices
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Also, this might be unrelated, but the following happened around this
patch (ie https://github.com/torvalds/linux/commit/0c5c62ddf88c34bc83b66e4ac9beb2bb0e1887d4)

I sometimes run Win11 under qemu/kvm/vfio (gfx card), and it stopped
booting (even with the latest patch for pci). Another Linux distro
boots fine under the same qemu/kvm/vfio, but Win11 stops at the boot
screen.

It worked well with 5.15.0 and a few PRs later - with the git tip it's
not booting - and it works well with 5.15.0-rc7

Maybe related to pci/vfio changes, maybe not, just leaving it here for
track record. I'll try to debug it a bit.
