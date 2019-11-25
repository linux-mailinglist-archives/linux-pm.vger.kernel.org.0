Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 404DE1093F6
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2019 20:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfKYTHm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Nov 2019 14:07:42 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33277 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfKYTHm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Nov 2019 14:07:42 -0500
Received: by mail-pf1-f195.google.com with SMTP id c184so7839679pfb.0;
        Mon, 25 Nov 2019 11:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=V6RCMCu0u2OME2YGHfLS+ptk7Pmu3SS68O9Jky4kB7Y=;
        b=gNuYAtvklCeB3PPdPcDxP20KNQXOsNyDP66uuHFOCxg8ce7xWrfKR4uD7H/U5tQSa7
         3Vi2vOJqV4PN2Ar2XZxdNxYHoiaSOkTYjh85Ts+vtNQtL2mLU6cJbeKjkbc0a5Zt/Tuf
         OudAAcbtq20THMsD6fNKGGDw7eDdVF1DfNHWFuRLYGIvXrTBs11NDhEDh7r5o+8gzxvI
         KENfZ51WYIN2CsFXPvoW5JhM6vIAY66DR6+s0wTUQq+9u2nkh9JFx09rmn9jrtPhWz4p
         OQ0XIFcRCNRwk3QVCgqdHOhwb16cxXPNmCl+YfaOlScoOYn+RNQB5HkEysOHxmsOenIC
         Dr1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=V6RCMCu0u2OME2YGHfLS+ptk7Pmu3SS68O9Jky4kB7Y=;
        b=BHX2mGDE6DnTE4/F2WArTITwPAntYnyc78cHKqV7dSR3et+ivCZhLCrwTDorELPrXl
         a5nKhnyc/bcOI9wDI07sGgPSbmEYcro1LF0AemRgqbAxhrdk6w/XTht1efn7ZUAkUWDZ
         iSJWFhrzkDyVwjMCeB0VUsujt6QP8Fdw2xJsqnLX9SMLx4XS2cJbXvmxQeZ8oSQJZ3yM
         vItvunSQxuk7TWnDyQGbhkIS7errRzlutVvW/lZ0xAWE9cORf/VqE2bNWaZWfmWDwjwJ
         DuNTnbh6PN97gxq5YzH+gQVSm9npxT/PQPM8bu1MANm+qDCSSc4GL+xbCZG+S1iLJ/Ko
         OP4w==
X-Gm-Message-State: APjAAAU1sj/6yBb29Mtued/TMYB/sYgRbibwfTwM0RRGHxMrwmMClBqZ
        5imRQFTctq8R6OL6xAhOR0Z7rflNid46c3+068M=
X-Google-Smtp-Source: APXvYqwdv0gIuwtCK0KGXjB0lvaltYm5Uyb+DZ4bp5hvIaqB0rUkOYH37caKpsTrlUZiHIJyhhqBYx9R9AUwrZCpeRA=
X-Received: by 2002:a65:6118:: with SMTP id z24mr35095773pgu.203.1574708861836;
 Mon, 25 Nov 2019 11:07:41 -0800 (PST)
MIME-Version: 1.0
References: <1574604530-9024-1-git-send-email-akinobu.mita@gmail.com>
 <1574604530-9024-5-git-send-email-akinobu.mita@gmail.com> <CAHp75VfOUiN_2bW+o-AqGmAY32mmdNxP54B2f2+gj0NTEr9FTQ@mail.gmail.com>
 <CAC5umygc95VBWz1L5CTZO9kmkZL2MCEL2_z9d2TJ6Ow5+fKYPw@mail.gmail.com>
In-Reply-To: <CAC5umygc95VBWz1L5CTZO9kmkZL2MCEL2_z9d2TJ6Ow5+fKYPw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 25 Nov 2019 21:07:31 +0200
Message-ID: <CAHp75VfPR7JSa7Mn5s_wJs22tXy7rC+W8x1jHLP=Npyd06BJ5w@mail.gmail.com>
Subject: Re: [PATCH 4/8] platform/x86: intel_menlow: switch to use
 <linux/temperature.h> helpers
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

On Mon, Nov 25, 2019 at 4:35 PM Akinobu Mita <akinobu.mita@gmail.com> wrote=
:
> 2019=E5=B9=B411=E6=9C=8825=E6=97=A5(=E6=9C=88) 4:58 Andy Shevchenko <andy=
.shevchenko@gmail.com>:
> > On Sun, Nov 24, 2019 at 4:09 PM Akinobu Mita <akinobu.mita@gmail.com> w=
rote:

> > > -       return result ? result : sprintf(buf, "%lu", DECI_KELVIN_TO_C=
ELSIUS(value));
> > > +       return sprintf(buf, "%ld", deci_kelvin_to_celsius(value));
> >
> > Can you explain the change %lu to %ld?
>
> Isn't it possible for aux values to be lower than 0 degrees Celsius?

If it's a change due to requirement of new helpers, put it in the
commit message, otherwise leave as is.

--=20
With Best Regards,
Andy Shevchenko
