Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8BA134F60
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jan 2020 23:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgAHW3H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jan 2020 17:29:07 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:33432 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgAHW3H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jan 2020 17:29:07 -0500
Received: by mail-ot1-f42.google.com with SMTP id b18so5277931otp.0;
        Wed, 08 Jan 2020 14:29:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+a/lGXYfLEUg+4efxvfGj3tzvmxmZTietPHkfeZLMXY=;
        b=F1XyY4ZBUrK9RamkVbpnu0sachGo0KbTNBmfChaPL/+U0izr6UwJ0941Lj8Dp2a9cy
         VEb+trRn6MGg6sPGK8+H8jUYQdsc3kWWWZkVQBQDKAcTpU+bEzPrwd/E69kipHM0GWDN
         3l2xwrmWRltXHTnZuM88mIX4E+WiQd6MCQanQR7zVycAiiw8BYMpZENAvcY1Nem2TEzY
         CY02Dfl9QHfKmwyM5Sd+goC7EiAS0d7xKXNZOwC5UW7dCocbRMfQehmRu9SjzDXu2fRa
         L3bV2682OF7zdvHGhpq6TZIS81yunRkothtncpjc5l/9KgYOhHewRYjRccE5RqCbXBnw
         mtXA==
X-Gm-Message-State: APjAAAUyhj3M4USjiufZboGp7Umag/wVy33kwbpecHkxYnKdd81hk3To
        CrQKAUsnrUpFJ6cTW/eY76ddulCeHmFdAx1APFN/TA==
X-Google-Smtp-Source: APXvYqwvIgS83UK9jzFqkaszIl5FpXWSY+MfLb4T3V5879VzzZHhi+yzF4uTQb4OpUTqlO9IJwE+cbz0t+TFbTwupDU=
X-Received: by 2002:a05:6830:1e67:: with SMTP id m7mr6087797otr.262.1578522546582;
 Wed, 08 Jan 2020 14:29:06 -0800 (PST)
MIME-Version: 1.0
References: <20200108015849.54289-1-yuehaibing@huawei.com> <20200108094545.o5o4tpwt4eu5fpye@flawful.org>
In-Reply-To: <20200108094545.o5o4tpwt4eu5fpye@flawful.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 8 Jan 2020 23:28:55 +0100
Message-ID: <CAJZ5v0g3PXB=iCad20+Xsmbn5ewjFNB6WTURe-FhDLJrb3rXZw@mail.gmail.com>
Subject: Re: [PATCH -next] power: avs: qcom-cpr: remove duplicated include
 from qcom-cpr.c
To:     Niklas Cassel <nks@flawful.org>, YueHaibing <yuehaibing@huawei.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Nishanth Menon <nm@ti.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jan 8, 2020 at 10:45 AM Niklas Cassel <nks@flawful.org> wrote:
>
> On Wed, Jan 08, 2020 at 01:58:49AM +0000, YueHaibing wrote:
> > Remove duplicated include.
> >
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---
> >  drivers/power/avs/qcom-cpr.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/power/avs/qcom-cpr.c b/drivers/power/avs/qcom-cpr.c
> > index 9247f53550b3..9b1d7d919ee9 100644
> > --- a/drivers/power/avs/qcom-cpr.c
> > +++ b/drivers/power/avs/qcom-cpr.c
> > @@ -25,7 +25,6 @@
> >  #include <linux/regulator/consumer.h>
> >  #include <linux/clk.h>
> >  #include <linux/nvmem-consumer.h>
> > -#include <linux/bitops.h>
> >
> >  /* Register Offsets for RB-CPR and Bit Definitions */
> >
> >
> >
>
> Thank you for this fix.
>
> Acked-by: Niklas Cassel <nks@flawful.org>

Applied, thanks!
