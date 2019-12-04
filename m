Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B462D113554
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2019 20:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbfLDTBY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Dec 2019 14:01:24 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:35125 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbfLDTBX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Dec 2019 14:01:23 -0500
Received: by mail-ua1-f65.google.com with SMTP id y23so201684ual.2
        for <linux-pm@vger.kernel.org>; Wed, 04 Dec 2019 11:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kLLyy4J1Ke9PrZQ4Qj04E9LcGP1qYhIJ+e8+Ik/qzcQ=;
        b=zvKuifqq2fTHKGaaySG8Ii7zKmTTY9KKpiGE8IyRXZiOwcFumS4AWFjMNkscTipP8G
         gTGDombWwvw1Z+YF38r87v7LJjM4hOMwpNu4XSvVd0lAcMpkab47C1XxotXliGl0Yzu5
         l8tWJhjBrk7Mwbr0JGLCsugek5MhtWEZD0zFOIsavSkPrJUkk2ouWFD+IHjYjfJAR/3W
         RO54ryk3Fh90qb1ZPrAw7iAxKkWDad/YNn3tiA6Cgf9XwVzZv3WoF4r+rbkV9YR8OiG7
         ojNZMcczVKCGSzgnwC3IzyYr8c84tPdMij/fTS9Qcr+GaM2OTnLw2USSCLIgrP1HBYLt
         8HVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kLLyy4J1Ke9PrZQ4Qj04E9LcGP1qYhIJ+e8+Ik/qzcQ=;
        b=D4kW2y1H5ZEVF0J4rsUV7jc/PhKjJiaNez3MuSXo1RYgF3DjGmd1zJ/81CtOQ+Fg5Z
         tsZB0923f6KHy+7+riuGrojH1wlJL/uw/HgRt/NXFdGqFMHbTrJgYHF/9fnTn99Wse9p
         4QJAseCzP4rsTZdbk+OAm0NegmR8IPG/QF7trExa8LWQILvnPJUJpEHktKJCOsbblWN/
         6jQpFrSanZIwiDDCxZm8tyFWQHlILvbSdiTfOL7ojs0DPmj2yCNEeVZ1BPcR3g0ak264
         Uu53eT8/0cIB2DQ0EcVe8QWg25UiwuhW47Fi4YhB++PYDShicll+5SUK9fg+i0g0FijV
         dmgQ==
X-Gm-Message-State: APjAAAX5i6n7sdjBKwTZhafuQSUKqxanRwY5kATXchu9CV14qU5hTTLn
        ACJHsUVamW4eBa4agU6CG+6mRhvjtzrdCO3A7DSUdQ==
X-Google-Smtp-Source: APXvYqxXFbilFYCqRDvgO+JIAEXdda9SxuFIcHboobOrP9MObrVUHhvF1mZrUcbPZchI10idx8MMEc5SqXHZ02Drnoc=
X-Received: by 2002:a9f:3f46:: with SMTP id i6mr3792634uaj.60.1575486082135;
 Wed, 04 Dec 2019 11:01:22 -0800 (PST)
MIME-Version: 1.0
References: <20191030182132.25763-1-f.fainelli@gmail.com> <20191030182132.25763-2-f.fainelli@gmail.com>
 <CAHLCerP6ricempeG=x-a2_aA6__YqADPKAEG5y7qPYNcD2=47Q@mail.gmail.com> <9adf0bd8-99ee-0f38-4608-67c92ba42c88@gmail.com>
In-Reply-To: <9adf0bd8-99ee-0f38-4608-67c92ba42c88@gmail.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Thu, 5 Dec 2019 00:31:11 +0530
Message-ID: <CAHLCerN0bJC0sMtZ2DneZSStkeTjQKHZeTNjJ4A31yV07hPb_A@mail.gmail.com>
Subject: Re: [PATCH 1/6] thermal: brcmstb_thermal: Do not use DT coefficients
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Markus Mayer <mmayer@broadcom.com>,
        "maintainer:BROADCOM STB AVS TMON DRIVER" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:BROADCOM STB AVS TMON DRIVER" <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 4, 2019 at 11:12 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 12/4/19 12:41 AM, Amit Kucheria wrote:
> > On Wed, Oct 30, 2019 at 11:51 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> >>
> >> At the time the brcmstb_thermal driver and its binding were merged, the
> >> DT binding did not make the coefficients properties a mandatory one,
> >> therefore all users of the brcmstb_thermal driver out there have a non
> >> functional implementation with zero coefficients. Even if these
> >> properties were provided, the formula used for computation is incorrect.
> >>
> >> The coefficients are entirely process specific (right now, only 28nm is
> >> supported) and not board or SoC specific, it is therefore appropriate to
> >> hard code them in the driver given the compatibility string we are
> >> probed with which has to be updated whenever a new process is
> >> introduced.
> >>
> >> We remove the existing coefficients definition since subsequent patches
> >> are going to add support for a new process and will introduce new
> >> coefficients as well.
> >>
> >> Fixes: 9e03cf1b2dd5 ("thermal: add brcmstb AVS TMON driver")
> >
> > I think you should fix the computation formula as the first patch and
> > then merge the rest of this patch into your second patch.
> >
> > I don't think the intermediate state of converting named constants to
> > magic numbers is needed just to convert it over to another set of
> > parameters.
>
> ok, so you would rather see this patch using the defined constants while
> fixing the formula, and in a subsequent patch getting rid of the
> constant names since they are going to be added to a per-process table,
> does that sound reasonable?

Yes, that way the first patch would fix a bug (and with a Fixes tag
potentially gets backported to stable), the second would convert over
to the per-process table.

Regards,
Amit

> >
> > Regards,
> > Amit
> >
> >> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> >> ---
> >>  drivers/thermal/broadcom/brcmstb_thermal.c | 37 ++++------------------
> >>  1 file changed, 6 insertions(+), 31 deletions(-)
> >>
> >> diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
> >> index 5825ac581f56..42482af0422e 100644
> >> --- a/drivers/thermal/broadcom/brcmstb_thermal.c
> >> +++ b/drivers/thermal/broadcom/brcmstb_thermal.c
> >> @@ -48,15 +48,6 @@
> >>  #define AVS_TMON_TEMP_INT_CODE         0x1c
> >>  #define AVS_TMON_TP_TEST_ENABLE                0x20
> >>
> >> -/* Default coefficients */
> >> -#define AVS_TMON_TEMP_SLOPE            -487
> >> -#define AVS_TMON_TEMP_OFFSET           410040
> >> -
> >> -/* HW related temperature constants */
> >> -#define AVS_TMON_TEMP_MAX              0x3ff
> >> -#define AVS_TMON_TEMP_MIN              -88161
> >> -#define AVS_TMON_TEMP_MASK             AVS_TMON_TEMP_MAX
> >> -
> >>  enum avs_tmon_trip_type {
> >>         TMON_TRIP_TYPE_LOW = 0,
> >>         TMON_TRIP_TYPE_HIGH,
> >> @@ -108,23 +99,11 @@ struct brcmstb_thermal_priv {
> >>         struct thermal_zone_device *thermal;
> >>  };
> >>
> >> -static void avs_tmon_get_coeffs(struct thermal_zone_device *tz, int *slope,
> >> -                               int *offset)
> >> -{
> >> -       *slope = thermal_zone_get_slope(tz);
> >> -       *offset = thermal_zone_get_offset(tz);
> >> -}
> >> -
> >>  /* Convert a HW code to a temperature reading (millidegree celsius) */
> >>  static inline int avs_tmon_code_to_temp(struct thermal_zone_device *tz,
> >>                                         u32 code)
> >>  {
> >> -       const int val = code & AVS_TMON_TEMP_MASK;
> >> -       int slope, offset;
> >> -
> >> -       avs_tmon_get_coeffs(tz, &slope, &offset);
> >> -
> >> -       return slope * val + offset;
> >> +       return (410040 - (int)((code & 0x3FF) * 487));
> >>  }
> >>l
> >>  /*
> >> @@ -136,20 +115,16 @@ static inline int avs_tmon_code_to_temp(struct thermal_zone_device *tz,
> >>  static inline u32 avs_tmon_temp_to_code(struct thermal_zone_device *tz,
> >>                                         int temp, bool low)
> >>  {
> >> -       int slope, offset;
> >> -
> >> -       if (temp < AVS_TMON_TEMP_MIN)
> >> -               return AVS_TMON_TEMP_MAX; /* Maximum code value */
> >> -
> >> -       avs_tmon_get_coeffs(tz, &slope, &offset);
> >> +       if (temp < -88161)
> >> +               return 0x3FF;   /* Maximum code value */
> >>
> >> -       if (temp >= offset)
> >> +       if (temp >= 410040)
> >>                 return 0;       /* Minimum code value */
> >>
> >>         if (low)
> >> -               return (u32)(DIV_ROUND_UP(offset - temp, abs(slope)));
> >> +               return (u32)(DIV_ROUND_UP(410040 - temp, 487));
> >>         else
> >> -               return (u32)((offset - temp) / abs(slope));
> >> +               return (u32)((410040 - temp) / 487);
> >>  }
> >>
> >>  static int brcmstb_get_temp(void *data, int *temp)
> >> --
> >> 2.17.1
> >>
>
>
> --
> Florian
