Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE9133B315
	for <lists+linux-pm@lfdr.de>; Mon, 15 Mar 2021 13:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbhCOMwB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Mar 2021 08:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhCOMv4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Mar 2021 08:51:56 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190A5C061574
        for <linux-pm@vger.kernel.org>; Mon, 15 Mar 2021 05:51:56 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id r7so9238382ilb.0
        for <linux-pm@vger.kernel.org>; Mon, 15 Mar 2021 05:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fEp3PhWB+rwhzY23E6LakAinje+x1Nsdlyiqc/sdllE=;
        b=KC3SBbjEh9xAYpoGnZNoN53Qpq0L3j0x5E/fPurYpY7X3eca2AEdq37RWUZ8eJ29Bl
         1zCaBCqlTGSoOHvj7eLcBXMkb5/GxkxqC1R9/08kepEYpIl4PgTXAs1/XA/Okp9VKtEn
         m+gAameRhIDKtagzKQd8Pn8bgUQNDWiFWfo60jZfUbFB0BAG3aDcQoduYMItgtWMG5lC
         HkdEXtzi2V5XAvMHftnnKB2OUNlOSN3LIySdDosdpGc7AgbSkQmKXk6xL9JD/iFPp/fV
         Bgp+oqH8vFUtjgpaH5BN6FQhFZ2b9I2QiQA5EI5/na7cBwN1Ieif3WJt68cChr3uCm2Q
         2U/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fEp3PhWB+rwhzY23E6LakAinje+x1Nsdlyiqc/sdllE=;
        b=LBZy40iHdNqN510HOKwDCoTzBofWx84EqUpq2kalCKtBhGxNZNYKL6kOglShgPI/q8
         tZ3WinEv2mNhd4YQHHI7KjAh7Z5HItubB9yjqRcxlg35MGIChnv1hzYqVUy53JQIeYr4
         d4e7gatQkiq7wxvkSA6PrXWC5cJgfHk4fdfy74v5PlZg2ysUg6atmv3qEg2MsWn9dpBc
         fz1goto7R1/nEEI1pFma6gq1UlIlarOGCFFO456dccW2E5R8yH2Gftbpo83VnZo8iDP+
         3y4sFvw/XNoRFg5vB3evm9jROt6NRSQkXIx0zHekzcHbhiEvGku+P/Zm7Cv2/HQCE01W
         wYVQ==
X-Gm-Message-State: AOAM5328XyXP9IRmMH1la0ujPIC5k/99Sk2dOI3zHpWYl950eJ+Qzn8h
        V7L6XOc0vKtJaqOZ/Y1hjbTsKEVlRrPs/rnjHYx22A==
X-Google-Smtp-Source: ABdhPJx6hGkau1UU6AGWxfUSlGwuCNIFgPeuShJdww4l+aJpEaQ9eVh61k41OHqgsSg9uEfMszAEhOOfNZX1SnOkfO0=
X-Received: by 2002:a92:c607:: with SMTP id p7mr11768526ilm.148.1615812715349;
 Mon, 15 Mar 2021 05:51:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210308133146.3168995-1-raychi@google.com> <20210309185807.ka4iljasq5cmpmil@earth.universe>
 <CAPBYUsCJ3ftC4ur412rFZGeeM_kDHrCh=BVci3=8SE2eFdPcQg@mail.gmail.com> <20210314223513.tznvhuq7phxxvjfo@earth.universe>
In-Reply-To: <20210314223513.tznvhuq7phxxvjfo@earth.universe>
From:   Ray Chi <raychi@google.com>
Date:   Mon, 15 Mar 2021 20:51:44 +0800
Message-ID: <CAPBYUsAb5Jghok-8d2ypdEBaqoahVPUAqYt0F8H0VocDMDW7Qg@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3: fix build error when POWER_SUPPLY is not enabled
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Kyle Tso <kyletso@google.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Mon, Mar 15, 2021 at 6:35 AM Sebastian Reichel <sre@kernel.org> wrote:
>
> Hi,
>
> On Fri, Mar 12, 2021 at 09:57:56PM +0800, Ray Chi wrote:
> > > While I'm fine with merging this after fixing up the subject, the
> > > original patch for dwc3 [0] looks completly incorrect to me.
> > >
> > > First of all it uses wrong scale (power-supply uses uA, not mA),
> > > so you are charging 1000x slower than expected. Then the patchset
> > > introduces a new DT property to get the power-supply device, but
> > > does not update the DT binding documentation and does not Cc the
> > > DT binding maintainer.
> >
> > Yes, it should use uA and send this information, and I will update a
> > patch to fix it and add the DT binding documentation.
>
> Considering your programming is off by a factor 1000 I wonder how
> this patchset has been tested.

Since our corresponding charging driver also uses mA as the unit, I
don't find this problem.

>
> > > Next the property itself looks not very
> > > smart to me. Usually one would use a device reference, not the
> > > Linux device name.
> > >
> > > Finally all existing devices solve this by registering a usb
> > > notifier from the charger, so why are you going the other way
> > > around? This is going to break once you want to use one of the
> > > existing chargers with dwc3.
> >
> > Only the USB controller will know USB state/speed so that I think
> > it is better to send this information from the USB side. For
> > example: For USB high speed, charging current should be limited to
> > 500 mA in configured state.  For USB super speed, charging current
> > should be limited to 900 mA in configured state.
>
> usb_register_notifier registers a callback to receive information
> from the USB subsystem. Then power-supply drivers can query specific
> info, e.g. call usb_phy_get_charger_current(). This is already being
> done by some power-supply drivers, so using one of those
> power-supply charger drivers in combination with dwc3 will now result
> in potentially racy behaviour as far as I can see.

Since these functions are defined in driver/usb/phy/phy.c, only the
devices which support usb_phy can use them.
If the device supports generic PHY drivers, it needs an additional way
to provide the information.
BTW, when there are two or more ways to provide the information, I
think it is fine to return the result directly if one of the ways is
executed successfully.

>
> > > I suggest to drop/revert the whole patchset.
>
> -- Sebastian
