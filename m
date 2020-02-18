Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECE4B162DCC
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2020 19:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgBRSI4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Feb 2020 13:08:56 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:46759 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbgBRSIz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Feb 2020 13:08:55 -0500
Received: by mail-ua1-f66.google.com with SMTP id l6so7789244uap.13
        for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2020 10:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R/hUNGk4SRM6kiHXV6o5gYzyAFxdFqq5txQCPei9mDM=;
        b=SH/AM7byq+GGZQOujD7y/pc9Z/jCNs8xRbvT3Xe26n4ObiDBca0/M1TL3iIp78G/R+
         KTx5VvRBK5p3StKKpsfLEm7H9wE343y6/5WBtpFIGos4DhvLfuVWpvX4GedZjL1+HaEc
         iJvH2r5Ftd+73Z/Pgaxa5yIH+MbzUINwlk1QetcQ2LojEZk8ZRig72UJrtiPm3RwCyO3
         sG7Bw8J0HX5+wDbWGKnHBCLC7AyVJAFKy5RAyYxDGpHixEcvDasdB20bLWeK3RlfFvXG
         19TGixZqnpV+mbILDmiWJHexNORo89AoO5/5humbXk7aszT1lJuRUya08rorJChwDm7k
         qKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R/hUNGk4SRM6kiHXV6o5gYzyAFxdFqq5txQCPei9mDM=;
        b=glEzvouQGkbk4zJCSmiP7AU+NydxMcJGKpB4l8XRlmyIAyvyPnBODDvxvoKWkjCSe4
         A79ZlANloPlE8MYP9LM1XeexP5DXskGDvN5TnMEZkk9Ykd3GyJbu4TX+BV0PIHJJ7cAx
         AF89vd+/PXClYBnANqniwkazMlfd0sKHs7yOKB+wljRXThfVW3TtMl5xwQQ+tjpbAdQe
         Rw1Yqk1eNVLhUFCsWFRipgas2yiWYqEC/iA/6LAAJHmPjo6RAXt0b3yXy8loafZXDWXw
         q2LDM52VLoZbSIdk7jfHeSK4Ye8qV81KPLtK+l4o6y9ZQ6QbGXrWjl1dAit2sfCAossW
         YC8Q==
X-Gm-Message-State: APjAAAW7x4wFbS+E+R+CzH478DKJypD0Z7PMRXkVH5V8IfzgA37dKD2j
        PymBAi3I8yjcvZKOYyacWNiiCj+82MOW5jtE52iIQQ==
X-Google-Smtp-Source: APXvYqyeUDwAdKkMhuDh2cUfhU3voe/Oj/lYB2U1rDCoNqf1S55cF1bQIpKWl5ZDtNg+HnjLQr+xWwKzvmFiPW+Dk2U=
X-Received: by 2002:ab0:7653:: with SMTP id s19mr11019733uaq.94.1582049334828;
 Tue, 18 Feb 2020 10:08:54 -0800 (PST)
MIME-Version: 1.0
References: <cover.1580390127.git.amit.kucheria@linaro.org>
 <932e07a83fed192678b8f718bbae37d0dc83590d.1580390127.git.amit.kucheria@linaro.org>
 <20200203181413.GF3948@builder>
In-Reply-To: <20200203181413.GF3948@builder>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 18 Feb 2020 23:38:43 +0530
Message-ID: <CAHLCerNi2kb-bU_xsmB4aGLtUKPXfUrqDMLJLU=XXTnk-Kk=+A@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] drivers: thermal: tsens: Add critical interrupt support
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

On Mon, Feb 3, 2020 at 11:44 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Thu 30 Jan 05:27 PST 2020, Amit Kucheria wrote:
>
> > TSENS IP v2.x adds critical threshold interrupt support for each sensor
> > in addition to the upper/lower threshold interrupt. Add support in the
> > driver.
> >
> > While the critical interrupts themselves aren't currently used by Linux,
> > the HW line is also used by the TSENS watchdog. So this patch acts as
> > infrastructure to enable watchdog functionality for the TSENS IP.
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
>
> Please do provide a changelog when respinning your patches.
>
> >  drivers/thermal/qcom/tsens-common.c | 120 ++++++++++++++++++++++++++--
> >  drivers/thermal/qcom/tsens-v2.c     |   8 +-
> >  drivers/thermal/qcom/tsens.c        |  24 +++++-
> >  drivers/thermal/qcom/tsens.h        |  71 ++++++++++++++++
> >  4 files changed, 212 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
> [..]
> > +irqreturn_t tsens_critical_irq_thread(int irq, void *data)
> > +{
> > +     struct tsens_priv *priv = data;
> > +     struct tsens_irq_data d;
> > +     unsigned long flags;
> > +     int temp, ret, i;
> > +
> > +     for (i = 0; i < priv->num_sensors; i++) {
> > +             const struct tsens_sensor *s = &priv->sensor[i];
> > +             u32 hw_id = s->hw_id;
> > +
> > +             if (IS_ERR(s->tzd))
> > +                     continue;
> > +             if (!tsens_threshold_violated(priv, hw_id, &d))
> > +                     continue;
> > +             ret = get_temp_tsens_valid(s, &temp);
> > +             if (ret) {
> > +                     dev_err(priv->dev, "[%u] %s: error reading sensor\n", hw_id, __func__);
> > +                     continue;
> > +             }
> > +
> > +             spin_lock_irqsave(&priv->crit_lock, flags);
> > +
>
> I see that I failed to follow up on the discussion on the previous
> revision. The handler is called from a single thread, so you don't need
> a lock to protect the irq handler from itself.

Makes sense now. Will fix.

Thanks for the review.

Regards,
Amit
