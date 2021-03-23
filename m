Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744A1346168
	for <lists+linux-pm@lfdr.de>; Tue, 23 Mar 2021 15:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbhCWOYr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Mar 2021 10:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbhCWOYh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Mar 2021 10:24:37 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C66FC061763
        for <linux-pm@vger.kernel.org>; Tue, 23 Mar 2021 07:24:37 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id n21so17851110ioa.7
        for <linux-pm@vger.kernel.org>; Tue, 23 Mar 2021 07:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f3ffjUDEfdpupg8pOxs1DbNdOM7s/25GYVkBS3ZIJKU=;
        b=QQLotKf2dEUsBufVdFz/Gwl322r+MKxtGAJ4yMe4ovpBB+GAEUYmXcMk1rcijaSgCA
         ZufTsf7XG9FlO57lBCmtHvPhREGIEYl6VhEC6TUEMwLX8/v6oJkS50uuUKlR+sxNJvFj
         RSnu71Cuo8NtjPEKaBP2yY/qiSjGA5uqSSCqmmDSSBkmwV4MQi2q56PZttTu2GwTsEpU
         lFEpDWQqBfYDYyMA7PF4eMiMYU5LXGXeDugJOht6oPhb36sBVXVsWBgoU9Ru4z5i+OiP
         FO+HF0XKyMa7R6kY8q/5fNspiQXGW2Zkl6ICBTfBkQxuj94a8dAJxtYiFG8Kuz2Gs7LK
         vuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f3ffjUDEfdpupg8pOxs1DbNdOM7s/25GYVkBS3ZIJKU=;
        b=nSxCSYbdEOP6yTcynmlF7xykX+1EICN9hAHMLL+A6cSXHEi67nRcQWdMXgILGF7Vkh
         nQLSy2OIldac5EjoGZrJMCaBgaci1Jsl88nOklTptDf+of5MlWe7XLkyjDgypq0r0qyY
         oua1T4cv7iHmVvfiM8NSpIg35LkGoaGSpx2dImjdlpYANoym1jEoZKLC3He8z0KZtHWx
         mz/qt4xpsDhRmymgrs70DmGTkKO4Tjgaeen1xHFcQgZMR28/Ex3yGWJnxDxRZJlqdSD3
         ShrwwU8/Q9ECZSXYM0uvP2dm8u9RyFmCJ8rQxfj9Flo9ET4yfK1NK7zUtJVQ+hasamoM
         ntFg==
X-Gm-Message-State: AOAM530nD19r4ozYXOpnFHLiuT3UFstjelDjhL8J2meZMAtU51bstnAU
        lWxEUiqb1k9DCHtUWj0K33vmry5PIck67/XnFzIhRQ==
X-Google-Smtp-Source: ABdhPJzZSN+E9lqMeu6pwYPPzrV612O72rKDlSb2lCnDk6sNkgU1WgQRlF/q8JGKLmFjKwqzZNH+xI4C7iIS7SU8lWQ=
X-Received: by 2002:a6b:ea04:: with SMTP id m4mr4499897ioc.160.1616509476421;
 Tue, 23 Mar 2021 07:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210308133146.3168995-1-raychi@google.com> <20210309185807.ka4iljasq5cmpmil@earth.universe>
 <CAPBYUsCJ3ftC4ur412rFZGeeM_kDHrCh=BVci3=8SE2eFdPcQg@mail.gmail.com> <YFnxY7AW9QGQApKQ@kroah.com>
In-Reply-To: <YFnxY7AW9QGQApKQ@kroah.com>
From:   Ray Chi <raychi@google.com>
Date:   Tue, 23 Mar 2021 22:24:25 +0800
Message-ID: <CAPBYUsCo4p+4qy551+3=3PXmnKR96K6qN+CP=Y7sjKGwpemXSw@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3: fix build error when POWER_SUPPLY is not enabled
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Kyle Tso <kyletso@google.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Greg,

I will upload fixes for power supply usage in dwc3 and dt-binding
documentation for the new device tree this week.

Thanks,
Ray

On Tue, Mar 23, 2021 at 9:47 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Mar 12, 2021 at 09:57:56PM +0800, Ray Chi wrote:
> > Hi Sebastian,
> >
> > Sorry for the late reply.
> >
> > On Wed, Mar 10, 2021 at 2:58 AM Sebastian Reichel <sre@kernel.org> wrote:
> > >
> > > Hi,
> > >
> > > On Mon, Mar 08, 2021 at 09:31:46PM +0800, Ray Chi wrote:
> > > > Fix build error when CONFIG_POWER_SUPPLY is not enabled.
> > > >
> > > > The build error occurs in mips (cavium_octeon_defconfig).
> > > >
> > > > mips-linux-gnu-ld: drivers/usb/dwc3/core.o: in function `dwc3_remove':
> > > > drivers/usb/dwc3/core.c:1657: undefined reference to `power_supply_put'
> > > > mips-linux-gnu-ld: drivers/usb/dwc3/core.o: in function `dwc3_get_properties':
> > > > drivers/usb/dwc3/core.c:1270: undefined reference to `power_supply_get_by_name'
> > > > mips-linux-gnu-ld: drivers/usb/dwc3/core.o: in function `dwc3_probe':
> > > > drivers/usb/dwc3/core.c:1632: undefined reference to `power_supply_put'
> > > >
> > > > Fixes: 59fa3def35de ("usb: dwc3: add a power supply for current control")
> > > > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > > > Signed-off-by: Ray Chi <raychi@google.com>
> > > > ---
> > >
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
> So should I revert what we currently have in my usb-next tree, or do
> you have a fix for this?
>
> thanks,
>
> greg k-h
