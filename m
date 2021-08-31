Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5CE3FCFA8
	for <lists+linux-pm@lfdr.de>; Wed,  1 Sep 2021 00:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240300AbhHaWsS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Aug 2021 18:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238727AbhHaWsR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Aug 2021 18:48:17 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D5EC061764
        for <linux-pm@vger.kernel.org>; Tue, 31 Aug 2021 15:47:21 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id c206so1379610ybb.12
        for <linux-pm@vger.kernel.org>; Tue, 31 Aug 2021 15:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/zrrWu3vyZW/zYrRbYJvlBVVQeFSlAL8q0o+fZ41WYo=;
        b=Bcv/iQ909ld9LZrqWRLP3Rtu9r8i6QUWzOktnuuGS3/2SjjZvDuwXpvSLSGnDz/y4J
         ZBWF3SmMQRUIUeuQTucLNQyEsrIzFmhD2HMZjebZPnUDdf88Uz97hLjpV5B1a0caFgN2
         PHRi/xtklW4zzZgRVJxpRkQDv3s2mfAtsXHraoeaRZqbCaU3GNlWX1LWj2zxvDZQD5sL
         ZWwa4pxfHI2d/+GlEnfmFhUJpf2LMW64aATeRyH51uOgk7RcESwOVKj2pFS+0vDez6C6
         YwsIMNfK59uZuriv29WaQpAMK3QIv4AB7z9N27Hd2gA6zAaWMbFsq7GYE2nXvpsWI9jH
         jvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/zrrWu3vyZW/zYrRbYJvlBVVQeFSlAL8q0o+fZ41WYo=;
        b=WjS2eeSCrsp15TQ1lAEj3I36amJGrRErxzs/K4kD13Hm6EqVaQ+H/aI9g6uTiBm4e8
         RXRvP0grvPP9Yw/7xZqrpH0h3FfeJPoTVVY2P9RrxkM5HQXMVHDohCkEKqLdnlxfrKYN
         VU+6d58SF+Z/qsLUQSnVWU96mmtvMplKJguq7xim9EJHZOFIKF6DylAs7czEwu3dGMu3
         FdVSHT3UvN/L+B4hNfRVAsCYB1bOudu7qWPGYzex04KogEVL3S64nbhd9cfe7pBYG1wy
         t7c5V4WoaQst7c6al6wy8gLabkQrZ+uJDNaNgXupyzobMC4p9sxlXn6Lb7VlOlqUUalC
         9ZMw==
X-Gm-Message-State: AOAM530ZnpuswN+avsPWYjBSp+IoBwVNdKyR+3ZNiRE/Oc1HtJUtJP0a
        padfAX2SoD9nOt6xL8RXLwq+uKUhLSgV6UaYOqU/Tw==
X-Google-Smtp-Source: ABdhPJxxMUxoFE7oLhACb3rJ3U1OAxHhXTAmtgpJpd5QqtINesrpTxsSkzeI6UNbEuFYIHJ6yFg/FYdWYgePuorb7Uc=
X-Received: by 2002:a25:d213:: with SMTP id j19mr34806819ybg.20.1630450040916;
 Tue, 31 Aug 2021 15:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAPDyKFo9Bxremkb1dDrr4OcXSpE0keVze94Cm=zrkOVxHHxBmQ@mail.gmail.com>
 <CAGETcx8JDR+5Aj2uwnQJ9sL+8-p=Cxix+P4sP8-ygMQ8_2AcXA@mail.gmail.com>
In-Reply-To: <CAGETcx8JDR+5Aj2uwnQJ9sL+8-p=Cxix+P4sP8-ygMQ8_2AcXA@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 31 Aug 2021 15:46:44 -0700
Message-ID: <CAGETcx_p80WZYyDxh3n8a_xw60-vki0kMvxjdNJ9_PeNJk1skQ@mail.gmail.com>
Subject: Re: [RFD] drivers: base: A driver's ->sync_state() callback don't get called
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 31, 2021 at 9:59 AM Saravana Kannan <saravanak@google.com> wrote:
>
> On Tue, Aug 31, 2021 at 6:56 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > Hi Saravana, Rafael, Stephen,
> >
> > I have observed an issue with a driver's  ->sync_state() callback that
> > doesn't get called, even if consumers/supplier device links conditions
> > should have been satisfied. I have narrowed down the problem, but I am
> > not sure what is the best solution to fix it, hence I am turning to
> > you for some discussion/advice.
> >
> > I have two test platform drivers, one that matches on the
> > "test,pm-domains-test" compatible string (this driver also has the
> > ->sync_state() callback assigned) and another driver that matches on
> > "test,runtime-pm-test".
> >
> > This is the relevant part in my DTS file:
> >
> >        pm_domain_test {
> >                 compatible = "test,pm-domains-test";
> >
> >                 pdParent: power-domain-parent {
> >                         #power-domain-cells = <0>;
> >                 };
> >
> >                 pdChild: power-domain-child {
> >                         #power-domain-cells = <0>;
> >                         power-domains = <&pdParent>;
> >                 };
> >         };
> >
> >         soctest: soctest {
> >                 compatible = "simple-bus";
> >
> >                 rpmtest0 {
> >                         compatible = "test,runtime-pm-test";
> >                         power-domains = <&pdParent>;
> >                 };
> >         };
> >
> > During boot the fw_devlinks are being created and their corresponding
> > links. With some debug enabled this shows some of the interesting
> > parts that are being printed to the log:
> >
> > [    0.041539] device: 'pm_domain_test': device_add
> > [    0.041629] OF: Not linking pm_domain_test to pm_domain_test - is descendant
> > [    0.041718] device: 'soctest': device_add
> > [    0.041803] OF: Linking rpmtest0 (consumer) to pm_domain_test (supplier)
> > [    0.041829] device: 'platform:pm_domain_test--platform:soctest': device_add
> > [    0.041892] platform soctest: Linked as a sync state only consumer
> > to pm_domain_test
> > [    0.041957] OF:    create child: /soctest/rpmtest0
> > [    0.041995] device: 'soctest:rpmtest0': device_add
> > [    0.042072] device:
> > 'platform:pm_domain_test--platform:soctest:rpmtest0': device_add
> > [    0.042132] devices_kset: Moving soctest:rpmtest0 to end of list
> > [    0.042141] platform soctest:rpmtest0: Linked as a consumer to pm_domain_test
> >
> > The interesting thing here is the "sync state only" link that gets
> > created. I assume there are good reasons for creating this link, even
> > if I fail to understand exactly why.
>
> In general there's a good reason for creating these links from parent
> devices of the consumer to the supplier. It is documented in the code
> under __fw_devlink_link_to_consumers().
>
> /*
>  * If consumer device is not available yet, make a "proxy"
>  * SYNC_STATE_ONLY link from the consumer's parent device to
>  * the supplier device. This is necessary to make sure the
>  * supplier doesn't get a sync_state() callback before the real
>  * consumer can create a device link to the supplier.
>  *
>  * This proxy link step is needed to handle the case where the
>  * consumer's parent device is added before the supplier.
>  */
>
> and under __fw_devlink_link_to_suppliers().
>
> /*
>  * Make "proxy" SYNC_STATE_ONLY device links to represent the needs of
>  * all the descendants. This proxy link step is needed to handle the
>  * case where the supplier is added before the consumer's parent device
>  * (@dev).
>  */
>
>
> >
> > In any case, the sync state only link never gets dropped, which I
> > assume is because there is no driver getting bound for the "soctest"
> > device (it has only the "simple-bus" compatible).
>
> Yeah, you've identified the problem correctly. I've been thinking
> about this possibility (and all the side effects a fix might have). I
> can send out a fix for this soon (within a week or so).
>
> > In other words, it doesn't matter that both the rpmtest0 and the
> > pm_domain_test devices are probed, thus satisfying the
> > supplier/consumer conditions, the ->sync_state() callback doesn't get
> > called anyway.
> >
> > Can you perhaps help to point me in a direction of how to best fix this problem?
>
> I hope you are okay with me sending a fix.

Ulf,

Could you give this a shot please?

https://lore.kernel.org/lkml/20210831224510.703253-1-saravanak@google.com/T/#u

-Saravana
