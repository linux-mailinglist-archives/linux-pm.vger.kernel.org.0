Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D06840E4A8
	for <lists+linux-pm@lfdr.de>; Thu, 16 Sep 2021 19:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344568AbhIPRFG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Sep 2021 13:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347629AbhIPRAJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Sep 2021 13:00:09 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C92C0363C2
        for <linux-pm@vger.kernel.org>; Thu, 16 Sep 2021 09:16:56 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id g21so18885281edw.4
        for <linux-pm@vger.kernel.org>; Thu, 16 Sep 2021 09:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jHK/xqguCKv/MR4fwXjRmcM93cFgGl6Y32a4+3LOaBY=;
        b=AEUDd7pV9a8fv9MoUDEB/1YV70rMjNiwVqjYNgqTmuPYQlb1B3XhWOa3d679adVJ1E
         yucOpTQI81iMxVqcjE4I4GH8h1VX8cX9L+/GbDlsGNjaAVM+nDBZwolEYFKL46Asg7yf
         aCV1dEkCnEnXFNAm1oYZ/DEX1e0ck8XCctPsdWmi/r2kKFhjLS04LvsSZDvd03uxy3Yi
         MdVNYkbcdoL3QP80/FjoKc7utwQ48v5GgYsNiYjYmtHubR4bzdsBR9nMYbB9yjptvtWe
         M09nZawvADViSrIUS5uN8IeAYk3n+awW2JwptYIlPhErLsMeiTVXUAtd+YBsP8EiEaef
         qrgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jHK/xqguCKv/MR4fwXjRmcM93cFgGl6Y32a4+3LOaBY=;
        b=RODPK7/AvfNLu71RxNL5IZSQGY0gSFl2TqBG71hKTBXTe6so0DgkDB1k0aG40hkNzo
         ntB0Kcxdt09PfBwhsALGFZLQqTY4scY7W/oEitt10Vex7QzYfBHkU5OijNGXrE4HpNoI
         TH/5bHMRjgFwlxGIsHA1O0COU5l2hHpa07Mexva8zvRocyITtqOPFavlWauTtQzE82vy
         bVniS7FuhwG3cVw+TeC9FaYu7ImT0f03YBrF4PNawR4U/ImVhar1YAUDntsAeTU4if9e
         an2emgeQyDY1oS33N5myz4uVSsyLsmVoyBwd1Q+yM5fvPwE7rbN5qKaJd+2EA3oboZSY
         VLvQ==
X-Gm-Message-State: AOAM531zs8bfuZYYsCoNKQ8V4V7ZLCaniKNaqZuFjM3jrGSo3735ftfY
        fe8Iv1mj8Qfp+N4iXg11OkYbDrGsjSBX34Qi71FJTw==
X-Google-Smtp-Source: ABdhPJywm65+5K+5MtjZwOa+gT94NK9qMFMnMUQZ9zRxmdOUE7/YQqlEaOPAkgsSWxQBRmlekY5+t6DIIQjKQFelvXE=
X-Received: by 2002:a17:906:5ac5:: with SMTP id x5mr7074596ejs.271.1631809014344;
 Thu, 16 Sep 2021 09:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210902213500.3795948-1-pmalani@chromium.org>
 <20210902213500.3795948-3-pmalani@chromium.org> <YT9SYMAnOCTWGi5P@kuha.fi.intel.com>
 <DB9PR10MB4652B4A6A2A2157018307AE380D99@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <YUB16up3JDwi3HfI@kuha.fi.intel.com> <YULwz8NsoA3+vrhA@google.com>
 <YUMbGp0aemx1HCHv@kuha.fi.intel.com> <DB9PR10MB46525E6CA4C6BB101059D93C80DC9@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <DB9PR10MB46525E6CA4C6BB101059D93C80DC9@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Thu, 16 Sep 2021 09:16:17 -0700
Message-ID: <CAPTae5Kxmp0L35KnkYaHARrBmysX9wkMYZhGhJsu6tX4bcHuAA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] power: supply: Add support for PDOs props
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
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

On Thu, Sep 16, 2021 at 7:12 AM Adam Thomson
<Adam.Thomson.Opensource@diasemi.com> wrote:
>
> On 16 September 2021 11:23, Heikki Krogerus wrote:
>
> > > Thanks for providing the clarification. So you're proposing a port-psy and a
> > > port-partner-psy that are connected to each other (one supplying the other).
> > > If PD is not present, those two will exist per port and partner, and there
> > > will be information about Type-C current (and possibly BC 1.2 and other
> > > methods?)
> >
> > Yes, exactly.
> >
> > > Do you have an example hierarchy you could share that explains what it would
> > > look like in /sys/class/power_supply with PD with Source Caps and Sink Caps on
> > > both sides?
> >
> > I don't yet, but I'll prepare something. I did notice already that the
> > power supply class does not seem to display the suppliers nor
> > supplicants in sysfs. But we can always improve the class.
> >
> > I probable should not talk about "hierarchy". Maybe taking about
> > simply "chain" of power supplies is more correct?
> >
> > > I think this all makes sense if the connector class is a read interface
> > > for this info. Have you considered how the type-c connector class and this pd
> > > psy support will handle dynamic PDO changes for advertisement FROM the
> > ports?
> > >
> > > For example, let's say you wanted the kernel and user to manage two USB-C
> > ports
> > > with higher power support (meaning, 5V, 9V, 15V, 20V capable), but then your
> > > kernel and user needs to edit the Source Caps on the fly based on load
> > > balancing.

Adding a few more instances.

Editing Source Caps on the fly is also applicable for handheld devices
with just  one port !
For instance, the phone might want to conserve power and limit the
power supplied to the port partner by adjusting the source caps to
limit battery drain based on the system conditions.

The sink caps can potentially change on the fly as well based on the
charging phase the handheld device is in. For instance, in the last
phase of charging (say when the battery is charged to greater than
80%), it would not make much sense to step down voltage(power losses
due to conversion) from greater than 5V to battery voltage(say ~4.4V).

> > >
> > > If caps are represented as a group of psys together, how do you as a kernel
> > > and user create an modify the set of Source_Caps you put out on a port?
> >
> > My idea is to utilise the "present" property with the ports. You would
> > always display all the possible supplies, but only the ones that you
> > expose in your current capabilities will be present.
> >
> > The idea is also that the ports are always supplied by normal power
> > supplies of type "battery", "AC" and what have you. Those you can use
> > to see the maximum power your port can get, and to determine the
> > currently available power by checking the other ports that consume the
> > same supply.
> >
> > So if you need more power for one port, you most likely will need to
> > attempt to adjust the power levels of the source PDO power supplies of
> > the other ports that share the base supply (like battery), or possibly
> > disable them, and that way enable (make present) more source supplies
> > for your port. That is the idea, but I admit I have not thought of
> > everything, so I'm not completely sure would it work exactly like
> > that, but the power balancing should in any case be possible with the
> > chain of power supplies one way or the other.
> >
> > I hope I understood your question correctly, and I hope I was able to
> > give you an answer :-)
>
> Thanks for the additional updates. So is the intention here to move control of
> PDO selection away from TCPM, or add more flexibility to it? As I understand it
> from previous efforts around all of this, the intention was that TCPM makes the
> decision as to which PDO to select (and which APDO for PPS) based on the offered
> capabilities of the source and the sink capabilities which are described in FW.
> Am just trying to envisage the use-cases here and how the kernel/user is
> involved in selecting PDOs/voltages/currents.
>
> IIRC there used to be functions for updating source/sink capabilities but these
> never had users and were subsequently removed. I guess this would be essentially
> the functional replacement for those APIs?
>
> Personally, I think the idea of source/sink PSY instances supplying each other
> seems reasonable. Right now we represent the external PD/Type-C supply (partner)
> through TCPM as a PSY instance which is always present for the associated port,
> although obviously when no source partner exists we're marked as offline. For
> the partner side I'm guessing the PSY instance will be dynamically
> created/destroyed? From previous experience PSY classes have tended to be
> statically included so would be interested in seeing what this looks like in
> reality.
>
> Am still unsure on using PSY to expose individual PDOs though and this still
> feels quite heavyweight. I assume we're not wanting to expose everything in PDOs
> really, just the voltage/current info? Feels like we should be able to do this
> with individual properties which a user can be notified of changes to through
> the normal prop notifier, rather than a collection of PSY class instances.
> However, I'm happy to be convinced the other way so will await further
> details. :)
