Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAECCEBC30
	for <lists+linux-pm@lfdr.de>; Fri,  1 Nov 2019 04:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfKADE7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Oct 2019 23:04:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:54614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726793AbfKADE7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 31 Oct 2019 23:04:59 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68C6A217D9;
        Fri,  1 Nov 2019 03:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572577498;
        bh=nU6uqOVFaCsulLB14w3V7HfkrQ0IMKZJP3c9WxF8K20=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vTGvqh2b7quzmstG195V56puCkgWoM1VlheFQG+9axMEtSr28lRYaSTp9SsxJPjPP
         y3lQgR7VIvU4oOJ/5ZJZEtlnD4vvARiJgO/6v/sknd967OhCt7MEer9GFtUQS2PCsT
         oimyKhk9SY9UrQdaGwrnODbFMGvG9VExlwqKLxJ8=
Received: by mail-wr1-f50.google.com with SMTP id l10so8381405wrb.2;
        Thu, 31 Oct 2019 20:04:58 -0700 (PDT)
X-Gm-Message-State: APjAAAX3zofpHyg4xToctFH3YZ8SeCHas7rJrnFh5Ov43fkwi1Ayct7b
        7hOYJSvo0Af6awISVutaEU53ORFuKp3RIzFESjk=
X-Google-Smtp-Source: APXvYqzuh0xd7+aIhEcjOGh28vIL0qQI5LRMwwA+gux/Bnu7YhlsdGHN+j3Azg/o4pUMm36qhzBi0fLYag9m4IFhJUs=
X-Received: by 2002:a5d:6203:: with SMTP id y3mr8698187wru.142.1572577496753;
 Thu, 31 Oct 2019 20:04:56 -0700 (PDT)
MIME-Version: 1.0
References: <20191030163807.17817-1-wens@kernel.org> <91017889-2ae7-d467-eed3-6d3b2bb130b9@gmx.net>
In-Reply-To: <91017889-2ae7-d467-eed3-6d3b2bb130b9@gmx.net>
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Fri, 1 Nov 2019 11:04:45 +0800
X-Gmail-Original-Message-ID: <CAGb2v67quD_EGgck7QLaO+rwgyPT0G+FfzDiZuyEAb0E1yf=yw@mail.gmail.com>
Message-ID: <CAGb2v67quD_EGgck7QLaO+rwgyPT0G+FfzDiZuyEAb0E1yf=yw@mail.gmail.com>
Subject: Re: [PATCH] thermal: brcmstb: enable hwmon
To:     Stefan Wahren <wahrenst@gmx.net>
Cc:     Chen-Yu Tsai <wens@kernel.org>, Markus Mayer <mmayer@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        "open list:BROADCOM BCM281XX..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 31, 2019 at 9:09 PM Stefan Wahren <wahrenst@gmx.net> wrote:
>
> Hi Chen-Yu,
>
> Am 30.10.19 um 17:38 schrieb Chen-Yu Tsai:
> > From: Chen-Yu Tsai <wens@csie.org>
> >
> > By defaul of-based thermal driver do not have hwmon entries registered.
> >
> > Do this explicitly so users can use standard hwmon interfaces and tools
> > to read the temperature.
> >
> > This is based on similar changes for bcm2835_thermal in commit
> > d56c19d07e0b ("thermal: bcm2835: enable hwmon explicitly").
> >
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > ---
> >
> > This patch was only compile tested. A similar patch [1] was submitted to
> > the downstream kernel, which I did build and actually run on a Raspberry
> > Pi 4.
>
> just a note: from my understanding [2] the brcmstb_thermal isn't the
> right driver for BCM2711. Please consider the current downstream
> solution for BCM2711 support as a quick hack to avoid writing a new
> thermal driver. But must confess that i didn't test Florian's recent
> changes yet.

Thanks for the tip. I only saw the thread after posting this patch.

ChenYu

> Regards
> Stefan
>
> [2] -
> https://github.com/raspberrypi/linux/issues/3101#issuecomment-527554223
>
> >
> > This one for mainline is much simpler, as it does not need to deal with
> > the error path or device removal, due to the use of devres.
> >
> >  [1] https://github.com/raspberrypi/linux/pull/3307
> >
> > ---
> >  drivers/thermal/broadcom/brcmstb_thermal.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
>
