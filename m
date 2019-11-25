Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D61A3109032
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2019 15:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbfKYOkF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Nov 2019 09:40:05 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40348 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbfKYOkF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Nov 2019 09:40:05 -0500
Received: by mail-lj1-f195.google.com with SMTP id q2so16173491ljg.7;
        Mon, 25 Nov 2019 06:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/SvzLSQc9NaZmiRAfhKzbEgi5swALfQM0gwLxj/g1X4=;
        b=BwfnTrBZIsf+YbKNO1Y09SKRcT/7JpfVe5u9XdIKMFF3vFkXXD09OebLH+/j2ARwh9
         1UBsASBFYnpZ7Ar6c/L8nHzM0Xfqfs422qdX0ctAKCgI6tI/rKPsjOKVatdVdp8kqJP0
         K3cRMjzd/SmBmsAq/X8a8B/4z7CUO2aS6k+gls6PZjaQOfdq4KqNXHSE3FkX38mEg01z
         xprQHlhqwXFTWSyAKCm1HSJpb3EthA5hG11JB+PnE5YIRJvNkr163ZR++uBnx499Zz+X
         lIMoKPo3k+/c+gF2+Elw+iJ7EBFbVxZkYH1Ca8nAVKdb35aAptffJ4OLimFdUFjeWn41
         A8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/SvzLSQc9NaZmiRAfhKzbEgi5swALfQM0gwLxj/g1X4=;
        b=pIDmWiJrkdO3p/xLyAS7qYy/rZOWJCX/JiugpyqDUWZae+ZKXX/KRd5d3+OI4rMDpb
         Y7FVM5zdU+KOeoLlfxzb78qhKag1BLx1bKnYhQIm8WExVNVXxwU2/JJO7zHtYsYG5agg
         ca59TkT8ZKCWfj3t++rgygh13ohi2hMLyizEy4ucdpReZI/h61yox7byaaVRYGRLbEO/
         JvTY9ddyiTXioHZFsPPgNa6zQsk74S9goEcD0n+53I35rZc5PPcAZXFBNqZVRGSvwTjY
         gGNPyNd+FHRNbPNN3pPH6zXM8s7PPm7VhLC0XAE8qfDgicyDq2iKcFWSRf3hKC9iw+3Z
         CKYA==
X-Gm-Message-State: APjAAAXNJkAFk+PPG0zBV6cJDv4egSvgHYLQ0zkr3UxqekbBOUoIMyEt
        zLB9+LEIourS40gxcdNnu1Uo5guscGjkMoNkyQ8=
X-Google-Smtp-Source: APXvYqxnV6QXzPFLNYYbJkreFA5LHHLQRoa+mUvd3RVfemUmE7NzO9TeNGK9jW4ohjEjbkzC5MK9lxV+ELGJbAuF4NI=
X-Received: by 2002:a2e:9842:: with SMTP id e2mr22522578ljj.93.1574692801789;
 Mon, 25 Nov 2019 06:40:01 -0800 (PST)
MIME-Version: 1.0
References: <1574604530-9024-1-git-send-email-akinobu.mita@gmail.com>
 <1574604530-9024-9-git-send-email-akinobu.mita@gmail.com> <CAHp75Vc6e8xq==QGtEX0MGLoV8QCGQf+vP0x-SauNHyjveZrnQ@mail.gmail.com>
In-Reply-To: <CAHp75Vc6e8xq==QGtEX0MGLoV8QCGQf+vP0x-SauNHyjveZrnQ@mail.gmail.com>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Mon, 25 Nov 2019 23:39:50 +0900
Message-ID: <CAC5umyiMoByGhd6b2xWA4SLO1Lcn2+ag-yEgw6uirsCmj37mkQ@mail.gmail.com>
Subject: Re: [PATCH 8/8] thermal: remove kelvin to/from Celsius conversion
 helpers from <linux/thermal.h>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        linux-hwmon@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

2019=E5=B9=B411=E6=9C=8825=E6=97=A5(=E6=9C=88) 5:00 Andy Shevchenko <andy.s=
hevchenko@gmail.com>:
>
> On Sun, Nov 24, 2019 at 4:09 PM Akinobu Mita <akinobu.mita@gmail.com> wro=
te:
> >
> > This removes the kelvin to/from Celsius conversion helpers in
> > <linux/thermal.h> which were switched to <linux/temperature.h> helpers.
> >
>
> > DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET() is only used by ACPI thermal
> > zone driver and the usage is specific to the driver.  So this macro
> > is moved to the ACPI thermal driver rather than generic header.
>
> I didn't get this point. If we split all helpers, let's do it for all,
> and not spreading macro per driver.

OK, I'll add deci_kelvin_to_millicelsius_with_offset() in the header.
But the unit of 'offset' argument will be in millidegree instead of
decidegree, because it's a bit more generic.
