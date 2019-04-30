Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C059EFB3
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 06:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbfD3Emu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Apr 2019 00:42:50 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39753 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD3Emt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Apr 2019 00:42:49 -0400
Received: by mail-pg1-f196.google.com with SMTP id l18so6239701pgj.6
        for <linux-pm@vger.kernel.org>; Mon, 29 Apr 2019 21:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XFladZcZaPZX3qydS53BZ4NhIvorW1o6i79f0yhX41c=;
        b=C2QQ038nRMeeh8liMY8vI3wnQ2mwGKvYVms4huqg7UAxAtABpfBMV6l1FL+hDRkO6I
         u2jr8RW8JL6VTLwGCLs8kUqbZHL6c7UtKdyc4Pu/4lpPavVQEy8d7XZuh/pMPiN12IGW
         UiCirF3FlwOaJsYJmP2x7nDfYywx/YOerO5iBHk0rzpj2llst/u4JE9VXXQf3b/1Uo2w
         wCj1uyZ7TTIXLVUGdNIZ/7zSJiRi0ETva8nrzIZJxolFFg0mffO2aMhTIhhspBagzbmu
         XmqnUgL3mgdnnIVdBPhKw4Cu4czy6uNwU23N5QntMVnr5fgjQ1Hv//wQ8AOG2HhdprsE
         KEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XFladZcZaPZX3qydS53BZ4NhIvorW1o6i79f0yhX41c=;
        b=Q305W42nUPoHtz9wpddWUHoTkMyCOAGi6h/sBUg2lgMxNh96sxlSOWmUXrrXcIeX2w
         NmJzXm8QPKbn1nlxQ1B+8Su9jbbMTIlTHmHGpJPw8+Q2YHfb3hi4IhdUL4rbWM3pRsHY
         7s/MrJhx2I/vvgiQzKk0KBaAETINzaJ3/9CjMqFzE2T0hlmHnMMIPD2ZtLAu9V3qCfmN
         tc+7K0ZbbII31Z7c+EoVNy5FtrCpq8wrAnAyvEpgHtzGLSGgQpOEQ0rTJk4zvqHXXbRP
         +2IFBjhJ976/g9DYjJXsXp7YjGG9tJr+KL9fhW639EnoAXq958pW/3VDwK4c1mGumkoV
         MzUg==
X-Gm-Message-State: APjAAAWIrAsSpmR+HOC/Q5+hRNr5Xl37xD0m4QH2tgbp2izfmZMhrkcF
        CCj9qIhi7WJBSIJKSawQC2HhyrNUWXI=
X-Google-Smtp-Source: APXvYqygvKowI2kLyaUya2a23iV207l9gYzdYkTC41i4qd+O8xsEnQL3jMCSsZ0U/rtNySeVwEg96g==
X-Received: by 2002:a63:b507:: with SMTP id y7mr31166599pge.237.1556599368986;
        Mon, 29 Apr 2019 21:42:48 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id t13sm70049624pgo.14.2019.04.29.21.42.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 21:42:47 -0700 (PDT)
Date:   Tue, 30 Apr 2019 10:12:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Frank Lee <tiny.windzz@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        David Miller <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: cpufreq: Document
 allwinner,cpu-operating-points-v2
Message-ID: <20190430044245.s4viduudej6q2eq6@vireshk-i7>
References: <20190410174139.20012-1-tiny.windzz@gmail.com>
 <20190410174139.20012-3-tiny.windzz@gmail.com>
 <20190426211540.GA890@bogus>
 <CAEExFWs2UwPLzgyO0apMOZf56um5isdZmf+7-wj_TqMozxZJQg@mail.gmail.com>
 <CAL_Jsq+0mQYyAqfY3nmF-oFx2X4qHU567chQ1s8p-rgD2GEFnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+0mQYyAqfY3nmF-oFx2X4qHU567chQ1s8p-rgD2GEFnw@mail.gmail.com>
User-Agent: NeoMutt/20180716-1615-c6e4b7
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29-04-19, 11:18, Rob Herring wrote:
> On Sun, Apr 28, 2019 at 4:53 AM Frank Lee <tiny.windzz@gmail.com> wrote:
> >
> > On Sat, Apr 27, 2019 at 5:15 AM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Wed, Apr 10, 2019 at 01:41:39PM -0400, Yangtao Li wrote:
> > > > Allwinner Process Voltage Scaling Tables defines the voltage and
> > > > frequency value based on the speedbin blown in the efuse combination.
> > > > The sunxi-cpufreq-nvmem driver reads the efuse value from the SoC to
> > > > provide the OPP framework with required information.
> > > > This is used to determine the voltage and frequency value for each
> > > > OPP of operating-points-v2 table when it is parsed by the OPP framework.
> > > >
> > > > The "allwinner,cpu-operating-points-v2" DT extends the "operating-points-v2"
> > > > with following parameters:
> > > > - nvmem-cells (NVMEM area containig the speedbin information)
> > > > - opp-microvolt-<name>: voltage in micro Volts.
> > > >   At runtime, the platform can pick a <name> and matching
> > > >   opp-microvolt-<name> property.
> > > >                       HW:             <name>:
> > > >                       sun50iw-h6      speed0 speed1 speed2
> > >
> > > We already have at least one way to support speed bins with QC kryo
> > > binding. Why do we need a different way?
> >
> > For some SOCs, for some reason (making the CPU have approximate performance),
> > they use the same frequency but different voltage. In the case where
> > this speed bin
> > is not a lot and opp uses the same frequency, too many repeated opp
> > nodes are a bit
> > redundant and not intuitive enough.
> >
> > So, I think it's worth the new method.
> 
> Well, I don't.
> 
> We can't have every SoC vendor doing their own thing just because they
> want to. If there are technical reasons why existing bindings don't
> work, then maybe we need to do something different. But I haven't
> heard any reasons.

Well there is a good reason for attempting the new bindings and I wasn't sure if
updating the earlier bindings or adding another one for platform is correct. As
we aren't really adding new bindings, but just documentation around it.

So there are two ways OPP core support this thing:

- opp-supported-hw: This is a better fit if we have a smaller group of
  frequencies to select from a bigger group, so we disable non-required OPPs
  completely. This is what Qcom did as they wanted to select different
  frequencies all together.

- opp-microvolt-<name>: This is a better fit if the frequencies remain same and
  only few of the properties like voltage/current have a different value. So we
  don't disable any OPPs but just select the right voltage/current for those
  frequencies. This avoids unnecessary duplication of the OPPs in DT and that's
  what allwinner guys want.

The kryo nvmem bindings currently supports opp-supported-hw, maybe we can add
mention support for second one in the same file and rename it well.

-- 
viresh
