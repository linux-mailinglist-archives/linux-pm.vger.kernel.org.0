Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2F5E1093FA
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2019 20:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbfKYTJF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Nov 2019 14:09:05 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44793 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfKYTJF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Nov 2019 14:09:05 -0500
Received: by mail-pl1-f196.google.com with SMTP id az9so6894763plb.11;
        Mon, 25 Nov 2019 11:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ikkTiJJF7DyuxBpIsOZUMlx8g8P8FFkwaJYiKXyPGkU=;
        b=Azlhce4pb1chMrQml/2O9Hb/ydwympIFo5rZug/EIB/hxnr1PPvdNLzsmrDScjvKhk
         Nq5NK059+n067h+MGhaJDlz8p/6G8KcOpQCWKVl8rM1ULKyRDZ+/7X6+1Njl5JGrMR5g
         9aKbWnuq9ZhQ1pRjzle4xjHqGwc47CvQU7taxtqLW40ujpmkK72XoxFyTDj6Lp1rIzn0
         eARRfPJpuDs0LMsgj2zWNpWcaJXPZwxU62b3cPXAE8B223lCG369o/ShkjmUNV9nR9T1
         ZTp9nzIKk1pP2xDyUfqMdStGB7tv+6mdkZFRX+s25PNiHI9fR/UPKL55ogXh1VCU44Wx
         dKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ikkTiJJF7DyuxBpIsOZUMlx8g8P8FFkwaJYiKXyPGkU=;
        b=W6MkgQblyLL3jocnAHtJRCcWeVzDmPMEltrg0MITSRQ/aa4vkJHdu8Tfdg6+WDEhzG
         WxpDwSqU9rCG2MsyqFFQTAW0LfY7umiDCL3pIFfLBW7TNdnl4E0dn56kbOmiDNRarm6X
         XLFMfiFj0a387TU2BOKG0BnDE17yjFY8gPep5qsYFM1DHblYKVadLtIGCGYR4AzfNUQM
         VgNyZ0FkpmQuFTZlUAOpy0xKwq+Xvlor4EceO+mOV6CQqFWS+WjTpPrmowEOgaChT87F
         9p+UUp+bO++dNtfE8exNSdf0PXWGd5+O6/hHqSLPJgUB9SxOafyeaYqCuxWw6Km9liGw
         UDCw==
X-Gm-Message-State: APjAAAX4JuqyPglOR2lXEhXXbm6gUeGsIMR0VorDSSIEZxjYM79EhisW
        NviJ66BHFulp8KvcssbDkHzdxdPvGUgBOIC033Y=
X-Google-Smtp-Source: APXvYqxdIMRqrIG6lbt22pFjiANsAscQpsPrJ9lvBLoBB04bsEreQiS1atTxsz6l1qN/h2K5PDmCfPmB5QPkSgEpBWw=
X-Received: by 2002:a17:90a:1b0e:: with SMTP id q14mr631126pjq.132.1574708944081;
 Mon, 25 Nov 2019 11:09:04 -0800 (PST)
MIME-Version: 1.0
References: <1574604530-9024-1-git-send-email-akinobu.mita@gmail.com>
 <1574604530-9024-9-git-send-email-akinobu.mita@gmail.com> <CAHp75Vc6e8xq==QGtEX0MGLoV8QCGQf+vP0x-SauNHyjveZrnQ@mail.gmail.com>
 <CAC5umyiMoByGhd6b2xWA4SLO1Lcn2+ag-yEgw6uirsCmj37mkQ@mail.gmail.com>
In-Reply-To: <CAC5umyiMoByGhd6b2xWA4SLO1Lcn2+ag-yEgw6uirsCmj37mkQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 25 Nov 2019 21:08:54 +0200
Message-ID: <CAHp75VfJ_+aTYWM6JXtENAD1=DbZwTaVELjDwP=aXnxtR_bHPQ@mail.gmail.com>
Subject: Re: [PATCH 8/8] thermal: remove kelvin to/from Celsius conversion
 helpers from <linux/thermal.h>
To:     Akinobu Mita <akinobu.mita@gmail.com>
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

On Mon, Nov 25, 2019 at 4:40 PM Akinobu Mita <akinobu.mita@gmail.com> wrote=
:
> 2019=E5=B9=B411=E6=9C=8825=E6=97=A5(=E6=9C=88) 5:00 Andy Shevchenko <andy=
.shevchenko@gmail.com>:
> > On Sun, Nov 24, 2019 at 4:09 PM Akinobu Mita <akinobu.mita@gmail.com> w=
rote:

> > > DECI_KELVIN_TO_MILLICELSIUS_WITH_OFFSET() is only used by ACPI therma=
l
> > > zone driver and the usage is specific to the driver.  So this macro
> > > is moved to the ACPI thermal driver rather than generic header.
> >
> > I didn't get this point. If we split all helpers, let's do it for all,
> > and not spreading macro per driver.
>
> OK, I'll add deci_kelvin_to_millicelsius_with_offset() in the header.

Thank you.

> But the unit of 'offset' argument will be in millidegree instead of
> decidegree, because it's a bit more generic.

It's fine as long as the helpers are consolidated and consistent.

--=20
With Best Regards,
Andy Shevchenko
