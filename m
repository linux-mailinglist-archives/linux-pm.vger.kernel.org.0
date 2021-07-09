Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0221C3C24FA
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jul 2021 15:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbhGIN0M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Jul 2021 09:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbhGINZt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Jul 2021 09:25:49 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDECC0613F0
        for <linux-pm@vger.kernel.org>; Fri,  9 Jul 2021 06:23:04 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id r9so3570738ual.7
        for <linux-pm@vger.kernel.org>; Fri, 09 Jul 2021 06:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ieJX/m81ywKjheIkUfnQ/E3F4+uPDEYB7LnHCrngEok=;
        b=VclYjwS7bXZJDEksFLzyv6b4/ovnlQWrQOsOkO3JCI4lkKcS6ZcgqONoZxiKH0UtLH
         1k/vfccWQc9aNL8JrCGpyBzD/vdcJaJxXY6C2uO4JxqIGqTxQVNOxFADDxPLonUkl8D7
         HXVV0TfcjLn6iOPfhfDp2bRCPSKu3wQ3IggL1FQaSzcEUvbfPwor/vYiaLZ/q4u+1bsj
         Fi1lG72QWvYMevqI34EtCTfbE93uOaY0DytDx3Acq+fUY1B7W3LKlElglAOQCyNQ7fDg
         VI/DujxCZLdxqrIRxNX3jWhrYLQNThTsE6WIIKV19EksuWHvcfvl3l73ACKjycvaGNsh
         JUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ieJX/m81ywKjheIkUfnQ/E3F4+uPDEYB7LnHCrngEok=;
        b=BlRp2ODV7KCXPTZNL3uCvkZUjEex9V+ilQg82c18DMbtMftP92fWhMWhDGYz9RPXPp
         R8XeEge75WEmcT7YggV6KiW8xaH0VJKOhDVy5EEIz1tpkPgIIm6nOVbUczFVJq0jPWOE
         jKEfk2vh54g9ifkbv9wVFZvz26L+OW0mih7RxgDPBvvxgJXFaBGijezEDg4phT4Y9YQO
         QozaAw8YPRSZPAtYI+UbdZvQS9dDVfEd+lDvJf3Xtq3C0bVPB1jXB4RX4BX97R4yqRE5
         wHv80R/Yn8OsDaKQJCYhVBWrmt1EXe+HxotU1rsqzgCunTVyyFzsSDYhz6jvf2sZivw6
         Fc3g==
X-Gm-Message-State: AOAM5309gtiB/7YJV3XbIjqIjrVTUzCP9GnLzLeAnVwjR7CoVq/5rJRl
        TlI92po5AV4UATcCa442gMf7jVMOcl1xFIXhq5eZbQ==
X-Google-Smtp-Source: ABdhPJzUnwXfQhtV/n6pBvbfm0s5OM132bPHlFb8TEuznt+3QUJnBOpAC9TPbDy4qoKF0BvgpsIE4cf8ma9Ur7aFa0M=
X-Received: by 2002:ab0:42a6:: with SMTP id j35mr35173493uaj.129.1625836983706;
 Fri, 09 Jul 2021 06:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210709125611.135920-1-ulf.hansson@linaro.org> <CAMuHMdU0AVFVb3tXW4wkEibSx50nzYKW1GopgZPfKp1SS7Mf1g@mail.gmail.com>
In-Reply-To: <CAMuHMdU0AVFVb3tXW4wkEibSx50nzYKW1GopgZPfKp1SS7Mf1g@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 9 Jul 2021 15:22:27 +0200
Message-ID: <CAPDyKFpzw0mQPFs-jyMX=T6WpZ+vFqrWmoKUWD+9wW8LWqyHuA@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: Don't attach a device to genpd that
 corresponds to a provider
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 9 Jul 2021 at 15:07, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Ulf,
>
> Thanks for your patch!
>
> On Fri, Jul 9, 2021 at 2:56 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > According to the common power domain DT bindings, a power domain provider
> > must have a "#power-domain-cells" property in its OF node. Additionally, if
> > a provider has a "power-domains" property, it means that it has a parent
> > domain.
>
> OK.
>
> > It has turned out that some OF nodes that represents a genpd provider may
> > also be compatible with a regular platform device. This leads to, during
> > probe, genpd_dev_pm_attach(), genpd_dev_pm_attach_by_name() and
> > genpd_dev_pm_attach_by_id() tries to attach the corresponding struct device
> > to the genpd provider's parent domain, which is wrong. Instead the genpd
>
> Why is that wrong?

It may lead to that the struct device that corresponds to a genpd
provider may be attached to the parent domain. In other words, the
parent domain will not only be controlled by a child domain
(corresponding to the provider), but also through the provider's
struct device. As far as I can tell, this has never been the intent
for how things should work in genpd.

So wrong or not, I guess it depends on what you expect to happen.

Do you see an issue with changing this?

>
> > provider should only assign a parent domain, through
> > pm_genpd_add_subdomain() or of_genpd_add_subdomain().

Kind regards
Uffe
