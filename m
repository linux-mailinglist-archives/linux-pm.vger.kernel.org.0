Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43F7211C9E0
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2019 10:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbfLLJu7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Dec 2019 04:50:59 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:46843 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728396AbfLLJu7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Dec 2019 04:50:59 -0500
Received: by mail-ua1-f65.google.com with SMTP id i31so591466uae.13
        for <linux-pm@vger.kernel.org>; Thu, 12 Dec 2019 01:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Th0Gxjy39UzyWkgaaSlqfUVGyatOKXBlhrJ1etVX5js=;
        b=Lr4zFJbm8S7HgAMSDwABkA/wyND+xwdWGQnbqBjKgGo7aCnTiK8exjImHHk9GVigub
         OaEkvndf8/JCWjrVQnkebzikIg3uTiUuNMj9PK+Hdz5dbj8KOi1h7JaRhq4Ez9J8mYN8
         7GY99n0HWRrJq8+wjtLytVQYXZpJHijWwBw8hvMh5YDK0gY9LpzoPD4hzf6bjwToMqTF
         BXYVG570RYgua0JseTb5oaqV7jIcHoZd6nBTTnYqs1ev1K36YKDKg2oPPhbyY5JbQT6G
         EQhIA+/kNaa5FMfQh/+KDZ9zr9pZf/sXj42yi6Fu1wwHRpA+yK6HeCzVmaEhNuZBgrh8
         Atmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Th0Gxjy39UzyWkgaaSlqfUVGyatOKXBlhrJ1etVX5js=;
        b=kItnkmILLzIk+lyG1kqHs1FBjOnVFeGVx45BifkLvE7wcCaSAmfP5Anw80qpkHEXQL
         8lbFU3jGzXpKmARDofwPumd4ULeUdaZrcEXnihuysZkPF0d/x6Fc2puaL1vx0PfudUgs
         AGvREPW3ihGSR3gEnFCgQJWGcUL82BQjnr8YK8vnjE5vruSUy5xuh1yUrfoQjNr7+kVV
         RKHXjZK03s8gNsrvmbkD9YXBgJSgm+OtE1k6sGeVAVBmSCl+9QCz6yAeXIFbfVt20j1I
         eCCWH74APEbisMfEoFCdYOei38ZJfPg5T5WfilSNIugPhYieNUOzfYtJF4HP0Lp8TMle
         f8kg==
X-Gm-Message-State: APjAAAXpI7xO9lnU2ojGl1eOnG5ONkf2aqjsUvIeSzpE9oPrlTzIiCjl
        qRJmUFhMpAVM8f97ATUE2MUJVKgSxb7nuDtiDPvz+Q==
X-Google-Smtp-Source: APXvYqwKZRVjkZ142WpeRsqhhDVJVdjOwhdMN2XDbdsfhAIXiWHisLYDXPMxFD1KaEHk4XY7A7F6pkHxDLP4o1kLsjo=
X-Received: by 2002:ab0:7352:: with SMTP id k18mr7176180uap.77.1576144257519;
 Thu, 12 Dec 2019 01:50:57 -0800 (PST)
MIME-Version: 1.0
References: <cover.1576058136.git.amit.kucheria@linaro.org>
 <39d6b8e4b2cc5836839cfae7cdf0ee3470653b64.1576058136.git.amit.kucheria@linaro.org>
 <aa9174c2-c851-4769-0f9c-5541047a7901@linaro.org>
In-Reply-To: <aa9174c2-c851-4769-0f9c-5541047a7901@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 12 Dec 2019 15:20:44 +0530
Message-ID: <CAHLCerPNMBFgFv6zAdKtzs21p9Y18d8fohJEMJe7o4ufNwdS6Q@mail.gmail.com>
Subject: Re: [PATCH] drivers: thermal: tsens: Work with old DTBs
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Olof Johansson <olof@lixom.net>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 11, 2019 at 9:42 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 11/12/2019 10:58, Amit Kucheria wrote:
> > In order for the old DTBs to continue working, the new interrupt code
> > must not return an error if interrupts are not defined.
> >
> > Fixes: 634e11d5b450a ("drivers: thermal: tsens: Add interrupt support")
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  drivers/thermal/qcom/tsens.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> > index 015e7d2015985..d8f51067ed411 100644
> > --- a/drivers/thermal/qcom/tsens.c
> > +++ b/drivers/thermal/qcom/tsens.c
> > @@ -109,7 +109,7 @@ static int tsens_register(struct tsens_priv *priv)
> >
> >       irq = platform_get_irq_byname(pdev, "uplow");
> >       if (irq < 0) {
> > -             ret = irq;
>
> 'ret' remains uninitialized here.
>
> > +             dev_warn(&pdev->dev, "Missing uplow irq in DT\n");
> >               goto err_put_device;
> >       }
> >
> > @@ -118,7 +118,8 @@ static int tsens_register(struct tsens_priv *priv)
> >                                       IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> >                                       dev_name(&pdev->dev), priv);
> >       if (ret) {
> > -             dev_err(&pdev->dev, "%s: failed to get irq\n", __func__);
> > +             dev_warn(&pdev->dev, "%s: failed to get uplow irq\n", __func__);
> > +             ret = 0;
> >               goto err_put_device;
> >       }
>
> The code now is unable to make a distinction between an error in the DT
> and the old DT :/
>
> Why not version the DT?

Versioning the DT is probably overkill for this driver. Just checking
for ENXIO as suggested by Stephan seems to be enough. We don't lose
the error checking for devm_request_threaded_irq either.

Regards,
Amit
