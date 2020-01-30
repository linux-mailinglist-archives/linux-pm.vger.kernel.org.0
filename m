Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F11714DAFD
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jan 2020 13:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbgA3MuF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jan 2020 07:50:05 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:36604 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbgA3MuF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jan 2020 07:50:05 -0500
Received: by mail-ua1-f67.google.com with SMTP id y3so1103798uae.3
        for <linux-pm@vger.kernel.org>; Thu, 30 Jan 2020 04:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cnMkth7hV/dDIq+IhUJB/NKhjbFoKZU6UHmqdZyzOvk=;
        b=iQ6sBgIOXFS+YVl144eNLc5JpHouW0m9Ee9ZuD1cG7XWSQpQUoXytyz8oSzkhZCStz
         RZTGG/UeztBrkUBjBdU05mofzifuN+nig9XaIVD2qP13ClQ5vzEm8mV0oGvgEyJ8eYhX
         /R9MYyfdejs+BAuK4dUK30jQUu74dDMfXqdAEp8GqbsFavOT/fcqJUZjdg3rJ8H7uw1G
         OrSnyslcxopXLgogDTR1IOuPbWj5/+AkuPooBC+mX2YegTo7ytERWHloqLQz77bLGvR/
         NeytO+8XzWfdENLpEts8kMEcNEHT/deUH8fwgQT339wOF7PF+oQBJr8l+TeJna6WzcGB
         15Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cnMkth7hV/dDIq+IhUJB/NKhjbFoKZU6UHmqdZyzOvk=;
        b=DyX9tq/Lpqikxh8uPbW9qbWtRmJnzPYzLuByUSs32P6RioWbMhjCKGiccqJjr8BDfO
         rQKzUkWA6bX95A6D4ut55Elx2QCY0LnY8qCoPyKkGeAJ1mFHoiaJN9wQrD6Zbknms8Rc
         /uWGzuSV2ja7v23cWLBVlyErjbjlvgrr7CREqJskuCKF4NnA+nRCPSjaGtzuZgTGtiRL
         kN5nfIGFSEpD5oTLSsX3gXs8PSl1jItoSmRmAUCYF8/Fx+RE0lpfZaQGsznQr9VjI2Hg
         YA0GrxfDesFckQcSxvsHfjFU7QZAXp18pMpiFrpy8xilaM5DEK7L6QOx/dJepWqlnuKL
         nVlw==
X-Gm-Message-State: APjAAAX2Dp1eejFe9KRrHjnfWQh5aRpuTj/6meb3A0uiXM8bpWjKHkPR
        EkD7xS3+8BmWvHWG/ruV/LfnLHQx/mY06i9ybUD+Cw==
X-Google-Smtp-Source: APXvYqzLFBjElA1AVzS3KAO1ZGYE8/2SstCFpuQS0BXBp8tlomfa/2p+73irPnPNVb+1+IYb+1jx8pAZxBMw4U6rzlY=
X-Received: by 2002:ab0:b94:: with SMTP id c20mr2456278uak.67.1580388603038;
 Thu, 30 Jan 2020 04:50:03 -0800 (PST)
MIME-Version: 1.0
References: <cover.1577976221.git.amit.kucheria@linaro.org>
 <0a969ecd48910dac4da81581eff45b5e579b2bfc.1577976221.git.amit.kucheria@linaro.org>
 <20200102192925.GC988120@minitux>
In-Reply-To: <20200102192925.GC988120@minitux>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 30 Jan 2020 18:19:52 +0530
Message-ID: <CAHLCerM-zB=7P4Si88Hhyt8J7ojPGa6J9SmwTm8d8Jh3syiMtQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] drivers: thermal: tsens: Release device in success path
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jan 3, 2020 at 12:59 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Thu 02 Jan 06:54 PST 2020, Amit Kucheria wrote:
>
> > We don't currently call put_device in case of successfully initialising
> > the device.
> >
> > Allow control to fall through so we can use same code for success and
> > error paths to put_device.
> >
>
> Given the relationship between priv->dev and op I think this wouldn't be
> a problem in practice, but there's two devm_ioremap_resource() done on
> op->dev in this function. So you're depending on op->dev to stick
> around, but with this patch you're no longer expressing that dependency.
>
> That said, it looks iffy to do devm_ioremap_resource() on op->dev and
> then create a regmap on priv->dev using that resource. So I think it
> would be better to do platform_get_source() on op, and then
> devm_ioremap_resource() on priv->dev, in which case the regmap backing
> memory will be related to the same struct device as the regmap and it
> makes perfect sense to put_device() the op->dev when you're done
> inspecting it's resources.
>

Indeed, thanks for reviewing.

Will fix.

> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  drivers/thermal/qcom/tsens-common.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> > index 1cbc5a6e5b4f..e84e94a6f1a7 100644
> > --- a/drivers/thermal/qcom/tsens-common.c
> > +++ b/drivers/thermal/qcom/tsens-common.c
> > @@ -687,8 +687,6 @@ int __init init_common(struct tsens_priv *priv)
> >       tsens_enable_irq(priv);
> >       tsens_debug_init(op);
> >
> > -     return 0;
> > -
> >  err_put_device:
> >       put_device(&op->dev);
> >       return ret;
> > --
> > 2.20.1
> >
