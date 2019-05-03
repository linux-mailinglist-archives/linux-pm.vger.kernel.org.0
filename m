Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBB7313272
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2019 18:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfECQqy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 May 2019 12:46:54 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45577 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728547AbfECQqy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 May 2019 12:46:54 -0400
Received: by mail-pl1-f194.google.com with SMTP id o5so2941918pls.12
        for <linux-pm@vger.kernel.org>; Fri, 03 May 2019 09:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I6Kj7J5O6mOYwdObKv7gUJ8XCyM1RwJ3zMEkMb1FKIA=;
        b=CyQ4K5S6LZCPez3P3h4Yxxkjx5MBxsP5BHCmBIL6WSY0qUlz3mMC4lIpY2Vhriry6a
         oXx9z7VzntcU6eC6xQcsSIzOqmACQmL8DeTBYaE8HymEL4qWrTlVSAmi/F6yKSegpaUY
         yzTiLzZgcSRyaY8DoLKKDvUdX+If3vo60mwTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I6Kj7J5O6mOYwdObKv7gUJ8XCyM1RwJ3zMEkMb1FKIA=;
        b=i77/86cHyjOeSHJ8lJTY+/8MXIRGtaa+qGIjTja/QFRX8/i2qzi+gHlD+lRhy4Ok//
         ytsoPUzJVGfFY9+tqGNmgjvnMI477BioYohliIbf8Ars4e6i17XbTvAr7Rz95NCMCKWo
         9xz2VjLZxU4kO0CnrsHwvK26UvjETb/P2OCLy+R4frqVj4Xebwgf2kaBtTINrozuP/cd
         PApW+nlRCAWnfCO9xCVIjOPS9iPUjkq64nZnTOYY4ANK0DGk9OY5sOZcRW5yWX9NWq3Z
         /u3zebn1b0g5tvl0SozcN3ZEkrh1wYD3br2ewMbhb31hj0Ig/AWNLJYFJmFlQnJ3KjoA
         YCNQ==
X-Gm-Message-State: APjAAAVwNtKEOlNMuFNd9p3GALGSNm9OWG37uGUzajh2Gxq4+ki1qprG
        DEYpbNSMcYOwLeULFGkoWI46+g==
X-Google-Smtp-Source: APXvYqxWg5BvQCMW5sbTPT2MdGAVLNcxxY3llDZ9nW22Kb9AR5oS4k2LVUS2tXpLJVTQ1tgp8Uwwrg==
X-Received: by 2002:a17:902:1c1:: with SMTP id b59mr11866780plb.182.1556902013175;
        Fri, 03 May 2019 09:46:53 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id f21sm3394538pfn.30.2019.05.03.09.46.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 09:46:52 -0700 (PDT)
Date:   Fri, 3 May 2019 09:46:51 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     "michael.kao" <michael.kao@mediatek.com>, fan.chen@mediatek.com,
        jamesjj.liao@mediatek.com, dawei.chien@mediatek.com,
        louis.yu@mediatek.com, roger.lu@mediatek.com,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/8] arm64: dts: mt8183: add thermal zone node
Message-ID: <20190503164651.GB40515@google.com>
References: <1556793795-25204-1-git-send-email-michael.kao@mediatek.com>
 <1556793795-25204-2-git-send-email-michael.kao@mediatek.com>
 <CAJMQK-isJf6f+OubbCdoXs8L2cup=rm3Z8Mr7Q26QshMP-0wxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJMQK-isJf6f+OubbCdoXs8L2cup=rm3Z8Mr7Q26QshMP-0wxA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Fri, May 03, 2019 at 04:03:58PM +0800, Hsin-Yi Wang wrote:
> On Thu, May 2, 2019 at 10:43 AM michael.kao <michael.kao@mediatek.com> wrote:
> >
> > Add thermal zone node to Mediatek MT8183 dts file.
> >
> > Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 64 ++++++++++++++++++++++++++++++++
> >  1 file changed, 64 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > index 926df75..b92116f 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > @@ -334,6 +334,67 @@
> >                         status = "disabled";
> >                 };
> >
> > +               thermal: thermal@1100b000 {
> > +                       #thermal-sensor-cells = <1>;
> > +                       compatible = "mediatek,mt8183-thermal";
> > +                       reg = <0 0x1100b000 0 0x1000>;
> > +                       interrupts = <0 76 IRQ_TYPE_LEVEL_LOW>;
> > +                       clocks = <&infracfg CLK_INFRA_THERM>,
> > +                                <&infracfg CLK_INFRA_AUXADC>;
> > +                       clock-names = "therm", "auxadc";
> > +                       resets = <&infracfg  MT8183_INFRACFG_AO_THERM_SW_RST>;
> > +                       mediatek,auxadc = <&auxadc>;
> > +                       mediatek,apmixedsys = <&apmixedsys>;
> > +                       mediatek,hw-reset-temp = <117000>;
> > +                       nvmem-cells = <&thermal_calibration>;
> > +                       nvmem-cell-names = "calibration-data";
> > +               };
> > +
> > +               thermal-zones {
> > +                       cpu_thermal: cpu_thermal {
> > +                               polling-delay-passive = <1000>;
> > +                               polling-delay = <1000>;
> > +
> > +                               thermal-sensors = <&thermal 0>;
> > +                               sustainable-power = <1500>;
> > +                       };
> > +
> > +                       tzts1: tzts1 {
> > +                               polling-delay-passive = <1000>;
> > +                               polling-delay = <1000>;
> > +                               thermal-sensors = <&thermal 1>;
> Is sustainable-power required for tzts? Though it's an optional
> property, kernel would have warning:
> [    0.631556] thermal thermal_zone1: power_allocator:
> sustainable_power will be estimated
> [    0.639586] thermal thermal_zone2: power_allocator:
> sustainable_power will be estimated
> [    0.647611] thermal thermal_zone3: power_allocator:
> sustainable_power will be estimated
> [    0.655635] thermal thermal_zone4: power_allocator:
> sustainable_power will be estimated
> [    0.663658] thermal thermal_zone5: power_allocator:
> sustainable_power will be estimated
> if no sustainable-power assigned.

The property is indeed optional, if it isn't specified IPA will use
the sum of the minimum power of all 'power actors' of the zone as
estimate (see estimate_sustainable_power()). This may lead to overly
agressive throttling, since the nominal sustainable power will always
be <= the requested power.

In my understanding the sustainable power may varies between devices,
even for the same SoC. One could have all the hardware crammed into a
tiny plastic enclosure (e.g. ASUS Chromebit), another might have a
laptop form factor and a metal enclosure (e.g. ASUS C201). Both
examples are based on an Rockchip rk3288, but they have completely
different thermal behavior, and would likely have different values for
'sustainable-power'.

In this sense I tend to consider 'sustainable-power' more a device,
than a SoC property. You could specify a 'reasonable' value as a
starting point, but it will likely not be optimal for all or even most
devices. The warning might even be useful for device makers by
indicating them that there is room for tweaking.

I'm not an expert in the matter though, just happend to look into this
recently :)

Cheers

Matthias
