Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA7CE10A05E
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2019 15:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfKZOev (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Nov 2019 09:34:51 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38753 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfKZOev (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Nov 2019 09:34:51 -0500
Received: by mail-lj1-f194.google.com with SMTP id k8so9949183ljh.5;
        Tue, 26 Nov 2019 06:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=o6Aof0yAWGeShjgJcUg1Y0lQGsYW6In2/ZZmFux/330=;
        b=LOhTfDCbXM8wo5cGG2LnHtN506MEG78VOZmbVbs05lxPZSuAEdB7bxPlo15f6tqb4J
         IYVlqXY0WPPU7xgoWiSMgFW+r6o0s0fpbuPMeI2eRUAhpwplaU3GJUz2meBOFt6AbqOP
         pUEsHlqK6njDTIyJ5bjf6xX3TUT9ZndPzz6JZZ94Nf+MsSO6gLGwDwfhWN7Ol6SspLIy
         TuCdLhNq5q7zXHVbBRz7Qs4gaN/3dwUt9vkZhjHEFUWHGRtGyaKDxDoL2CGF4u882hLI
         bhD+YCUgZFqAr21busgL++mfQmz2mVg6dhyYgCzsz2ryvknKULP0XxUaNj8Lbt7QajAq
         JwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o6Aof0yAWGeShjgJcUg1Y0lQGsYW6In2/ZZmFux/330=;
        b=phmCViNZtg55XGt79D601g4TcrN+SgpL++5wM6bXYMVtkXF3UL3+RVZjKzZXGzaoxy
         /mfRyKfBUpft2KPGAjfnfdSTJXImOGO9cN8XWu+U6BgJrtr9F55u4Ma22MciRhQr0Ihd
         kLfU4Do4HcGO8wrA/vjpsUIDNBmDKEP02yFitjq1a3SmTRw5+JVE8gFZBfXyPGaJrqFh
         le2y5thuCgw+eOt+Wjc7RnLcVzHJy8ZpFj3LlH1y+0oOLS+x5MI72p8hVBc8d9GVkjgh
         TnTsa25RP+JgOIFB38+AY9xeGD/ngHkpmWLnDoaWtfMkoruMN+XnpE5iQ9+Yhlo/7Lv1
         Tykw==
X-Gm-Message-State: APjAAAVdrcEMUCnZcZgXEORM9JefcdVcJl96ce8AIUNBFm+N2qHvREyU
        icDYMObVXEsmekBlemsBrWqf5yKuYPGOcQ2x+OII7qLKWF0=
X-Google-Smtp-Source: APXvYqxom9w1r9meKO7BwtGxZ8J84olw1mlQR/g2adENixyRp0DFx+OrWkHvlSUo6GpFwxHjIqzoDQ7OSEXi60qRUaA=
X-Received: by 2002:a05:651c:20f:: with SMTP id y15mr26375869ljn.31.1574778889212;
 Tue, 26 Nov 2019 06:34:49 -0800 (PST)
MIME-Version: 1.0
References: <1574604530-9024-1-git-send-email-akinobu.mita@gmail.com>
 <1574604530-9024-5-git-send-email-akinobu.mita@gmail.com> <CAHp75VfOUiN_2bW+o-AqGmAY32mmdNxP54B2f2+gj0NTEr9FTQ@mail.gmail.com>
 <CAC5umygc95VBWz1L5CTZO9kmkZL2MCEL2_z9d2TJ6Ow5+fKYPw@mail.gmail.com> <CAHp75VfPR7JSa7Mn5s_wJs22tXy7rC+W8x1jHLP=Npyd06BJ5w@mail.gmail.com>
In-Reply-To: <CAHp75VfPR7JSa7Mn5s_wJs22tXy7rC+W8x1jHLP=Npyd06BJ5w@mail.gmail.com>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Tue, 26 Nov 2019 23:34:36 +0900
Message-ID: <CAC5umyiHsidih_VBvEOT4ApXR_ocBTqCvfFcg-gs9imcZczf6Q@mail.gmail.com>
Subject: Re: [PATCH 4/8] platform/x86: intel_menlow: switch to use
 <linux/temperature.h> helpers
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

2019=E5=B9=B411=E6=9C=8826=E6=97=A5(=E7=81=AB) 4:07 Andy Shevchenko <andy.s=
hevchenko@gmail.com>:
>
> On Mon, Nov 25, 2019 at 4:35 PM Akinobu Mita <akinobu.mita@gmail.com> wro=
te:
> > 2019=E5=B9=B411=E6=9C=8825=E6=97=A5(=E6=9C=88) 4:58 Andy Shevchenko <an=
dy.shevchenko@gmail.com>:
> > > On Sun, Nov 24, 2019 at 4:09 PM Akinobu Mita <akinobu.mita@gmail.com>=
 wrote:
>
> > > > -       return result ? result : sprintf(buf, "%lu", DECI_KELVIN_TO=
_CELSIUS(value));
> > > > +       return sprintf(buf, "%ld", deci_kelvin_to_celsius(value));
> > >
> > > Can you explain the change %lu to %ld?
> >
> > Isn't it possible for aux values to be lower than 0 degrees Celsius?
>
> If it's a change due to requirement of new helpers, put it in the
> commit message, otherwise leave as is.

OK, I'll leave it as is.
The format string will be fixed by a separate patch.
