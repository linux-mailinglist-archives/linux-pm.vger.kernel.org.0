Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D83D6D8806
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 07:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfJPFXB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 01:23:01 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:38133 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbfJPFXB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 01:23:01 -0400
Received: by mail-ua1-f65.google.com with SMTP id 107so6831527uau.5
        for <linux-pm@vger.kernel.org>; Tue, 15 Oct 2019 22:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x84fnYes++VeBDbIo6qHMe1U6I3n9DWg2uJuSL1+ZRo=;
        b=mVVE9XDy13ZeRTLAxh6diSwqxs5+pFC+8NzUM1/Iufrxc92V1mff6IQ2f/lQ+SlJDn
         fwhahz8Fp0dOAM18EHJt+dW4hfdej+c/FrMv/bl+glt1rMaW7kwirXGR8+cTc4ngppJJ
         0NxASLZI6vL0oVsWKPbq4MKeyJZDk3DgC4I9XmM70t2nlAeoWwG6l/1kFVWI8Kn9d62l
         WGBmEd8F40veGIoAv7Rm/nx//5XTO3cI/HK2xVtXcniixv1LkJXgu5BQwuXNoCqzFRFX
         pRgdKV4oNe/IMGQB/OMGwh1dwjKnPXrePkBBF7btoaRH20gL0zeB3Bj0MpSNFwumrv6s
         IDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x84fnYes++VeBDbIo6qHMe1U6I3n9DWg2uJuSL1+ZRo=;
        b=HuAjr047rzEzrXupjPKAf6hb91rY2wwcdReXPVwNIwDuaFaeDYATJ+jPViVuJXx+Tu
         wjjbicj76o9Tv9NZDYc/vVmg/MyYOd/nED+yXzEKSaWkkpQdn/WSf1ZfM75AFHHNwcIa
         BmL3jdMDoMZfF9ZSIG5Obm/fdgAEQAqUm8khzjBncaI2qe4LuvrCYoBDfFWIWDUpu14d
         yKt+Eagn8iQ9atNLxLWxKurNYc+DuBCk5c1hdwLkFcglc+XtjdzGNr1zvcNW3lj2olhm
         Hf4mkWBDM+jnZERUPdyyufezzmPZCpdm72N4RjfLtPDWAVSRR6GN0Cl7/eA/JD72wIPR
         DVRQ==
X-Gm-Message-State: APjAAAWTN+RLzW8uUTLHvyP7p4hTZg0rLOTDNvb1dO5Z1fpTNfKbiABN
        5RJ62tm9s1cq40MHaQOxhKdlrTMRhd/o0SA+JvAelA==
X-Google-Smtp-Source: APXvYqys7H0IirmGn56W5Al1VbtX5v5sS8hQcM6/P5+54uaG3iq1JZw5FIQ3v0csjEffNlOhceV9HZ7UmmMXVsD17Tk=
X-Received: by 2002:a9f:364c:: with SMTP id s12mr15532433uad.77.1571203379780;
 Tue, 15 Oct 2019 22:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1571181041.git.amit.kucheria@linaro.org>
 <1b53ef537203e629328285b4597a09e4a586d688.1571181041.git.amit.kucheria@linaro.org>
 <5da6a33b.1c69fb81.64cc.6834@mx.google.com>
In-Reply-To: <5da6a33b.1c69fb81.64cc.6834@mx.google.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Wed, 16 Oct 2019 10:52:48 +0530
Message-ID: <CAHLCerOe=Cx0+uyLG1S9B297BbUFdqaAFKFCUVrjfy=p+qRuSQ@mail.gmail.com>
Subject: Re: [PATCH] of-thermal: Disable polling when interrupt property is
 found in DT
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 16, 2019 at 10:27 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Amit Kucheria (2019-10-15 16:13:16)
> > Currently, in order to enable interrupt-only mode, one must set
> > polling-delay-passive and polling-delay properties in the DT to 0,
> > otherwise the thermal framework will continue to setup a periodic timers
> > to monitor the thermal zones.
> >
> > Change the behaviour, so that on DT-based systems, we no longer have to
> > set the properties to zero if we find an 'interrupt' property in the
> > sensor.
> >
> > Following data shows the number of times
> > thermal_zone_device_set_polling() is invoked with and without this
> > patch. So the patch achieves the same behaviour as setting the delay
> > properties to 0.
> >
> > Current behaviour (without setting delay properties to 0):
> >   FUNC                              COUNT
> >   thermal_zone_device_update          302
> >   thermal_zone_device_set_pollin     7911
>
> thermal_zone_device_set_polling?

Yes, the script I was using restricted the width of the fn name while printing.

>
> >
> > Current behaviour (with delay properties set to 0):
> >   FUNC                              COUNT
> >   thermal_zone_device_update            3
> >   thermal_zone_device_set_pollin        6
> >
> > With this patch (without setting delay properties to 0):
> >   FUNC                              COUNT
> >   thermal_zone_device_update            3
> >   thermal_zone_device_set_pollin        6
> >
> > Suggested-by: Stephen Boyd <swboyd@chromium.org>
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
>
