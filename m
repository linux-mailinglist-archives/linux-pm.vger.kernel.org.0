Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA493411569
	for <lists+linux-pm@lfdr.de>; Mon, 20 Sep 2021 15:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbhITNWh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Sep 2021 09:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239225AbhITNWg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Sep 2021 09:22:36 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37ADC061574;
        Mon, 20 Sep 2021 06:21:09 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id p29so66937590lfa.11;
        Mon, 20 Sep 2021 06:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u6GB2XJ25N7du6+keolf1xpjOAUOuO0nlhOfiMwGosc=;
        b=WUl9raFZdZmVdrAFxYDDogwBxjqdYpNcL9Oh/UZvzQuu7Gfp5/W2NOpSfqiA51+3iv
         KEcbq5YHwo87woY05cQBjhpmuHr1x7hFVZW0s5yJh9VD5JCCZY7oX9Rr0tfwgamm81AH
         9vHPkw1gpBLMT3hICaOn6FAtG4zWmezf4MYTow3IpFOhkWvk2pkTK1EIRKQZNUkjxSRN
         TCaa/Y2GBjiodXB5j+3AA1iNO/RADOPMmOnz5h1F+nlyTWBkfYW/MDYhK/1aJRLImjLl
         PVSFEHcwNY5PpEkTL1P2/Nu+VDPYMQgAPHDe1MiBOpQU2nKXVEY/leq8x8vLIdwAVCEq
         K/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u6GB2XJ25N7du6+keolf1xpjOAUOuO0nlhOfiMwGosc=;
        b=6pokcTIzILjMejCMjjSV0UqSLQKC41Xs1ygieLbj7f9BqXyTz7laKtH2My0xvbbTDJ
         kWdMDX6O8l250A614KZ7A7P6pmxoDSenjzsVSGWUtASKQ/bQA6d4NBZFCHT8iyofRfpJ
         t0Q/LFUhCo9LlPZctbMAORenEXGVIUid9VTACKcrHaRDyImbMlw7djuCNQJ7SiXjdkmL
         a7XKUbraGvISJgSlapqw6MXXhCnZRBZVwmDXlpwNmbFzWs+ntjvj1ahDmwUtIbcoB8/X
         e9T0QiO5ciluUV/NxTN8Wre11m1RL1tSylf1qRM4fELv05AO+g//yPC49u3lUjqXgpZ8
         neYA==
X-Gm-Message-State: AOAM530GW+/KR4aF6c3NtOJTtpuTCVRtiC0nn9tDOAnG28UdQEW3ookI
        66dYWD9BcO0MWnN4EfSvJ0jIixlPEG/cbow/xS4=
X-Google-Smtp-Source: ABdhPJx0qPnmu+9JXcNEtDd+hROg13K9h163miZ0QCh31ioY/3l77YNaz2O02/6GOiUyEKu42BKCwwQrPryXg+4Yl9Y=
X-Received: by 2002:a05:6512:1284:: with SMTP id u4mr1063524lfs.395.1632144033466;
 Mon, 20 Sep 2021 06:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210902213500.3795948-1-pmalani@chromium.org>
 <20210902213500.3795948-3-pmalani@chromium.org> <YT9SYMAnOCTWGi5P@kuha.fi.intel.com>
 <DB9PR10MB4652B4A6A2A2157018307AE380D99@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <YUB16up3JDwi3HfI@kuha.fi.intel.com> <YULwz8NsoA3+vrhA@google.com>
 <YUMbGp0aemx1HCHv@kuha.fi.intel.com> <DB9PR10MB46525E6CA4C6BB101059D93C80DC9@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <CAPTae5Kxmp0L35KnkYaHARrBmysX9wkMYZhGhJsu6tX4bcHuAA@mail.gmail.com>
In-Reply-To: <CAPTae5Kxmp0L35KnkYaHARrBmysX9wkMYZhGhJsu6tX4bcHuAA@mail.gmail.com>
From:   Rajaram R <rajaram.officemail@gmail.com>
Date:   Mon, 20 Sep 2021 18:50:22 +0530
Message-ID: <CAOiXhaLpe7gHw6c8pCZDNeOC31WfxFum5G1RNiEbEG2Fn=6oeQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] power: supply: Add support for PDOs props
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Benson Leung <bleung@google.com>,
        Prashant Malani <pmalani@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "bleung@chromium.org" <bleung@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Sep 17, 2021 at 6:25 AM Badhri Jagan Sridharan
<badhri@google.com> wrote:
>
> On Thu, Sep 16, 2021 at 7:12 AM Adam Thomson
> <Adam.Thomson.Opensource@diasemi.com> wrote:
> >
> > On 16 September 2021 11:23, Heikki Krogerus wrote:
> >
> > > > Thanks for providing the clarification. So you're proposing a port-psy and a
> > > > port-partner-psy that are connected to each other (one supplying the other).
> > > > If PD is not present, those two will exist per port and partner, and there
> > > > will be information about Type-C current (and possibly BC 1.2 and other
> > > > methods?)
> > >
> > > Yes, exactly.


 As Benson mentioned PDOs contain more than power details like USB
Suspend indicator etc or Type-C only devices as Badhri mentioned here
may not integrate well with PSY class.  Additionally, it is also
important to consider cable properties here for power as they also
have a role to play in the power limits and necessitates change of
existing PDOs or power limits. ( Type-C Monitor charging a computing
system does not have captive cables)

Given too many possibilities, would an approach similar to
gadgetfs/configfs or cpu scaling say like "type-configfs" or "typec
scaling" ABI framework that allows USB=C port management under one
path /sys/class/typec that allows:

- Provision to manage USB-C port power (  Power supply class should
still represent power contract established, as remaining
characteristics are nested with functional aspects and relevant on a
power contract failure )
+ dynamically change Rp ( Rp(default) is required to enter USB suspend)
+ Set PDO Policy ( PPS, Fixed, etc)
+ Give back power
+ Expose complete PDO ( As we do for VDOs)
+ Change USB Suspend flag

- Provision for extended messages
+ Provides additional details regarding ports like Get Status etc.
This shall allow us to take system level decisions.

- Provision to manage USB-C modes
+ Provision to enter modes as provided by interface standards like UCSI

With this user tools like Chrome OS "typecd" be able to use a single
class and its ABIs to manage USB-C port power and mode. Kindly correct
me if I am missing something here.
