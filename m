Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65C2E116C97
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 12:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfLILzZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Dec 2019 06:55:25 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33237 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbfLILzY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Dec 2019 06:55:24 -0500
Received: by mail-oi1-f195.google.com with SMTP id v140so6079245oie.0
        for <linux-pm@vger.kernel.org>; Mon, 09 Dec 2019 03:55:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qChWNNC6lBoSx+UD6nLIwQREf77TmVAYYWLgeOcERAI=;
        b=HC+OoVEygUQvIfevt21sHvgDHVCMNDQqqXiXkeIf3Mzky9fTFld/1zcIeDZ9UabTmX
         024geVbE85TXf5jV7Dn+UsWPxIdP4EtGgVKG+YkL0UIDH16tz0TvBl4omTcKP0Nozjii
         Va0jjcF2uAAuPYxBOh/Fukj2J/8O6lZTztPlrI3mgUtuMjmdzYa71vAuSSWxrw6PWF0M
         tfgtyFPGkKnMOlx1C9x1kWPIIAwrC6YIp4FM8miY8kTdKnrUryEIEJ06zLyewrOZOTp/
         VUnhh2KwAeizShSzluJITUVZoafSyLHR4H+x8BY9uJDHcdY0P9W/15jduki2R5xrA2Pc
         QMFw==
X-Gm-Message-State: APjAAAWYWoJ7MPNdwR3HzKhIUK5KZ7WUmsMz6H6itzhjm/ncbDU/a2/Y
        CKNqd7bNAZHMc+YiAsqHBcOIhs8lg6JvKp2whj4=
X-Google-Smtp-Source: APXvYqwwmb0S6u9ZachQZuBlmciz+xZndqvUhoSb6xEXedYSOyET7ieCj8CMqMK1Tx65uax0o55RxLtJtnASA+DygrQ=
X-Received: by 2002:a05:6808:1c5:: with SMTP id x5mr17509862oic.57.1575892523951;
 Mon, 09 Dec 2019 03:55:23 -0800 (PST)
MIME-Version: 1.0
References: <7b0313c4-0d2b-fbd9-469b-1e0ce79aacc3@linaro.org>
 <CAJZ5v0iXJz5yAbr_Dhk4k0FqGW6nhn2QF1oGf7Xi4Kfdvc83Wg@mail.gmail.com>
 <62b866a1-739f-8349-81bc-4ccff4ad3a28@linaro.org> <CAJZ5v0i44Rb8PeB65sZmnu=8Ctzjw4BeSHqQC2XTG5A7K2pcsw@mail.gmail.com>
 <a2f4c5f4-e416-93dd-24f9-431308a692a0@linaro.org>
In-Reply-To: <a2f4c5f4-e416-93dd-24f9-431308a692a0@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 9 Dec 2019 12:55:13 +0100
Message-ID: <CAJZ5v0hkdGGkioVpmMPtroBYEt-42jgkG_zMfReuZUWDH8WHYQ@mail.gmail.com>
Subject: Re: cpuidle regression ?
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Dec 9, 2019 at 12:35 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 09/12/2019 11:50, Rafael J. Wysocki wrote:
> > On Mon, Dec 9, 2019 at 11:32 AM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 09/12/2019 10:26, Rafael J. Wysocki wrote:
> >>> On Sun, Dec 8, 2019 at 11:40 AM Daniel Lezcano
> >>> <daniel.lezcano@linaro.org> wrote:
> >>>>
> >>>>
> >>>> Hi Rafael,
> >>>>
> >>>> the latest linux-next kernelci report indicates a kernel bug for the
> >>>> imx6 platform. I don't have this board so it is not possible to
> >>>> investigate it.
> >>>>
> >>>> https://storage.kernelci.org/next/master/next-20191208/arm/multi_v7_defconfig/gcc-8/lab-collabora/boot-imx6q-sabrelite.html
> >>>>
> >>>> [ ... ]
> >>>>
> >>>> [    3.372501] Unable to handle kernel NULL pointer dereference at
> >>>> virtual address 00000000
> >>>>
> >>>> [ ... ]
> >>>>
> >>>> [    3.408898] PC is at _find_first_bit_le+0xc/0x2c
> >>>> [    3.413785] LR is at cpuidle_driver_state_disabled+0x40/0xa0
> >>>>
> >>>>
> >>>> Not sure if it is related to the latest changes or not.
> >>>
> >>> It does seem so, in which case the attached patch should address it.
> >>>
> >>> Is there a way to test the patch alone or do I need to push it
> >>> somewhere to be tested?
> >>
> >> Is the bleeding-edge branch monitored by kernelci ?
> >
> > No, it is not right now, AFAICS.
>
> I have a imx7, I will try to reproduce the issue on it. Otherwise, I can
> test on the 'testing' thermal branch temporarily.

Thanks, that'll help!
