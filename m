Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD651116B69
	for <lists+linux-pm@lfdr.de>; Mon,  9 Dec 2019 11:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfLIKuo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Dec 2019 05:50:44 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45354 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbfLIKuj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Dec 2019 05:50:39 -0500
Received: by mail-ot1-f65.google.com with SMTP id 59so11740973otp.12
        for <linux-pm@vger.kernel.org>; Mon, 09 Dec 2019 02:50:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UC7AvoCdNcfMyT4cEGv9QofTisZaPLpOJc/AiIOtbp0=;
        b=a3KiJcvXYyfidvxc+fW8Qvw1xpzlzE5QAkXorp84oMi+dZcShUSoLCGadd4zKfviym
         wGfA1iB6nE5EHM5DXg2DASPShLboZXOcTivoSTQEGpL8x5RDWEinVUGUGDNHbqED5Y/V
         tEKaTStQkUsyloQOAh6TuxhrUKbLwuJY9lKXkxJDg7ZSlnejwjn/o6WfR0Ri/H4qm8yx
         iCiLdRLEz4Tvm3Jm7zctHF2PsCaq9MiL2zZfUN0hM/dYa8RCxaAx/lY2d1H/09uuxu5z
         PC1ArpxHPgytrQ4N1SV8Y6/rq93QozDwu0nfUxq74uAMsru3u+CVOd30sIQ8BxXJUrTx
         7mYw==
X-Gm-Message-State: APjAAAWTK2tslYaVxch+bgcozKA7DAdb7zfkYefy/zvYt3i/kxDsntwu
        fEBJe8c5DK7+p1Aw2ZXvsbmb/Q/UPuGEIHpld8Y=
X-Google-Smtp-Source: APXvYqxH/9kGSqqhO2cG2JYJVbK/EGCsRnq/wuz6R7gcxjRllaww6IMNRIQS+yk9hztiM1Ym8SBY1Jj+5kuqeSKIzdE=
X-Received: by 2002:a05:6830:4b9:: with SMTP id l25mr21414305otd.266.1575888638429;
 Mon, 09 Dec 2019 02:50:38 -0800 (PST)
MIME-Version: 1.0
References: <7b0313c4-0d2b-fbd9-469b-1e0ce79aacc3@linaro.org>
 <CAJZ5v0iXJz5yAbr_Dhk4k0FqGW6nhn2QF1oGf7Xi4Kfdvc83Wg@mail.gmail.com> <62b866a1-739f-8349-81bc-4ccff4ad3a28@linaro.org>
In-Reply-To: <62b866a1-739f-8349-81bc-4ccff4ad3a28@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 9 Dec 2019 11:50:27 +0100
Message-ID: <CAJZ5v0i44Rb8PeB65sZmnu=8Ctzjw4BeSHqQC2XTG5A7K2pcsw@mail.gmail.com>
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

On Mon, Dec 9, 2019 at 11:32 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 09/12/2019 10:26, Rafael J. Wysocki wrote:
> > On Sun, Dec 8, 2019 at 11:40 AM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >>
> >> Hi Rafael,
> >>
> >> the latest linux-next kernelci report indicates a kernel bug for the
> >> imx6 platform. I don't have this board so it is not possible to
> >> investigate it.
> >>
> >> https://storage.kernelci.org/next/master/next-20191208/arm/multi_v7_defconfig/gcc-8/lab-collabora/boot-imx6q-sabrelite.html
> >>
> >> [ ... ]
> >>
> >> [    3.372501] Unable to handle kernel NULL pointer dereference at
> >> virtual address 00000000
> >>
> >> [ ... ]
> >>
> >> [    3.408898] PC is at _find_first_bit_le+0xc/0x2c
> >> [    3.413785] LR is at cpuidle_driver_state_disabled+0x40/0xa0
> >>
> >>
> >> Not sure if it is related to the latest changes or not.
> >
> > It does seem so, in which case the attached patch should address it.
> >
> > Is there a way to test the patch alone or do I need to push it
> > somewhere to be tested?
>
> Is the bleeding-edge branch monitored by kernelci ?

No, it is not right now, AFAICS.
