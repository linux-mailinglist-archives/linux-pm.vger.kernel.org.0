Return-Path: <linux-pm+bounces-26216-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0377EA9C8CC
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 14:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 293234C3C45
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 12:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A859B248895;
	Fri, 25 Apr 2025 12:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sRFvOrVP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF44145346
	for <linux-pm@vger.kernel.org>; Fri, 25 Apr 2025 12:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745583460; cv=none; b=lISJFrYI1rL69JPMA6d9MQ4jX1caAmkIaq+o4we5vYT+GGuePUEFUjEst1qWaiT7ZP96ytHFlmSjeFL+qMOeMf5NWWzLvxhQhkug09Ehdwz+CF4HSKJN19svOK5YN+rJSxbeSubajL0Bi/B2x8hpMv2kl+YAuMTmI/AqIQZzfOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745583460; c=relaxed/simple;
	bh=PrhApg1ld6f3w5PMm+xwxo8UUKj9Su2NGanHz9pKXwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O+IiwH4qpHsD65FtEIoDGStH9/w8O8X49FfBEhQ3y7CDt0fNUur5l9deAofaORg0kB3rz+lGnsgmSX1cuWoofEoe6Iemn5G8o7ug4rSTIHEB5Fr1msoImbJNzuk5pe1klfA4yGxrDJk9E+NBltoFtUVCTYahJtvP0q8/Z4eTDIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sRFvOrVP; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-708154c2a80so18897437b3.1
        for <linux-pm@vger.kernel.org>; Fri, 25 Apr 2025 05:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745583457; x=1746188257; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MzOovnCFz7a1pN3eCV+0adUMbLsCWU/yLERT/IqWY78=;
        b=sRFvOrVPGGE3lTUyZhKmlhAzbFIcU/4hMe3cPghPWRenzNwR7ID90ly8oEQba5bIfi
         KjZvWWmx8qmhrlrXrQqaqDS4CIxBKLxdtEEUotRZ9fPy8bNm6rupE+NjDdZQD6IsL0Yp
         ifgHamDAAsYBWI+PN7VpWU3igiVFLiuBGcMdK5IX/duS4Vk8JC0/rhUTn0qRqmo0DIz5
         IbFAhLfJ2cK7Ho0xvvWd5SzJA8snyObDg/kiQnRvB1YJfQEreHjzDij4KC/bT1UpyUiC
         XaKRN8S/RCK0e7JkjVmiiR1vdJbtRHcU/IjqOQPfeIvkl6piJfyGz1C2+kCPLl6JMM9o
         Hn9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745583457; x=1746188257;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MzOovnCFz7a1pN3eCV+0adUMbLsCWU/yLERT/IqWY78=;
        b=oiT/BKKeOuRWH8qjodJ+Yd2tEMk+9DikslLHWYtfVT3H/keRqhRA4RRgxigAAVuOar
         l5hbozDH2Gjx7AX1M8eR/G8VtQy/btPtZMSc2WdxdqkrwawL72KqyqBTF2aMtGCRWh8m
         YfSgSmz3GFKgOosHpJRAc8kLi1Pdra7iiXHL902UUHD+LGj90cF86cxYUgb/R5txJr7s
         f4/SxnmZhMpJUhX8FEs0vsRt9vjhJ74ugJ6cjoJ0i0P00ZJsO7eGtwV3TBk2VHMS/75a
         XIgO52cXiw0hoI3y8RvCaAJS6VAfcmUmNk6vbggJKac/WJ2kJLmRegIqTZJiNJMnCaEc
         TGPw==
X-Forwarded-Encrypted: i=1; AJvYcCUVsnP67tUWtKztRFnyZkT1x8A90wEAZ3idBHQowcByXyucJn84FRfZpO1rcmYKSut+eKOeTiQaLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOB+4S/yUjqETy+OQrAfIYrfEPdkWG/la32wec31ywBgbEh8VR
	FwMQ8f5AOaFmDw3eY+uAR0iQxnMuZA8aR9Uac3lLB5jaVRlZh9XAo/z5FgNHomHkE8FmK8O0xYH
	tOaVvtANYeG6MKx8w5hEgxyPx3AOEiahclET1Pw==
X-Gm-Gg: ASbGncsNgm4lPXB6gN8VzXwkWQbd5VXytdlWMWB/jTOyk+XFv1/RexP9UBl1+5aBT32
	n8tmAm8x98gPJk0CoZxYrdXHgv4U69Id3FtSFOEhniHnp3q9UpiNa90g+tVosnU1/4JxJu7tzEd
	LzbudskS0VAjYVv6/aIpOMjeA=
X-Google-Smtp-Source: AGHT+IGhJmRc9wirk6fDwzA3gjt9BfQcDnkXr8+Xu6rh22RdL/tZq9C8iOaUX31C0gPRlQRgIZCpM52uZZvwSlBctd0=
X-Received: by 2002:a05:690c:60c8:b0:6fb:5498:70fa with SMTP id
 00721157ae682-7085412a5c0mr29991187b3.18.1745583457456; Fri, 25 Apr 2025
 05:17:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417142513.312939-1-ulf.hansson@linaro.org> <8e748129-3348-4bf1-9fc8-fadc569fa48e@ideasonboard.com>
In-Reply-To: <8e748129-3348-4bf1-9fc8-fadc569fa48e@ideasonboard.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 25 Apr 2025 14:17:01 +0200
X-Gm-Features: ATxdqUHCfnRVoNINH1KaYmw86rw8GwFvpw8gSk9J6VyXy12y2iJ3WN0VKIVIR6M
Message-ID: <CAPDyKFqEgJPn-e-FooG_3h=Eqfw511c9_b+ywPcrfao8_p=u+Q@mail.gmail.com>
Subject: Re: [PATCH 00/11] pmdomain: Add generic ->sync_state() support to genpd
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Saravana Kannan <saravanak@google.com>, Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@linaro.org>, Devarsh Thakkar <devarsht@lewv0571a.ent.ti.com>, 
	Peng Fan <peng.fan@oss.nxp.com>, Johan Hovold <johan@kernel.org>, 
	Maulik Shah <maulik.shah@oss.qualcomm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>, 
	Devarsh Thakkar <devarsht@ti.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 24 Apr 2025 at 12:59, Tomi Valkeinen
<tomi.valkeinen@ideasonboard.com> wrote:
>
> Hi,
>
> On 17/04/2025 17:24, Ulf Hansson wrote:
> > If a PM domain (genpd) is powered-on during boot, there is probably a good
> > reason for it. Therefore it's known to be a bad idea to allow such genpd to be
> > powered-off before all of its consumer devices have been probed. This series
> > intends to fix this problem.
> >
> > We have been discussing these issues at LKML and at various Linux-conferences
> > in the past. I have therefore tried to include the people I can recall being
> > involved, but I may have forgotten some (my apologies), feel free to loop them
> > in.
> >
> > A few notes:
> > *)
> > Even if this looks good, the last patch can't go in without some additional
> > changes to a couple of existing genpd provider drivers. Typically genpd provider
> > drivers that implements ->sync_state() need to call of_genpd_sync_state(), but I
> > will fix this asap, if we think the series makes sense.
> >
> > *)
> > Patch 1 -> 3 are just preparatory cleanups.
> >
> > *)
> > I have tested this with QEMU with a bunch of local test-drivers and DT nodes.
> > Let me know if you want me to share this code too.
> >
> >
> > Please help review and test!
> > Finally, a big thanks to Saravana for all the support!
>
> I had a quick test with this on TI's AM62 board. A few observations.
>
> With this series, all the individual PDs seem to get a state_synced file:
>
> ...
> /sys/devices/genpd_provider/pd:143/state_synced
> /sys/devices/genpd_provider/pd:54/state_synced
> /sys/devices/genpd_provider/pd:105/state_synced
> /sys/devices/genpd_provider/pd:62/state_synced
> /sys/devices/genpd_provider/pd:141/state_synced
> ...
>
> Is that on purpose? What do these files represent? They all seem to be "1".

It's on purpose, but in this case there are no fw_devlink tracking
them, but instead that's done via..

/sys/devices/platform/bus@f0000/44043000.system-controller/44043000.system-controller:power-controller/state_synced

..as you point out below.

Depending on the DT layout these nodes may be useful, but not in the
TI PM domain case.

>
> When I boot up, I see the sync_state pending:
>
> [   22.541292] ti_sci_pm_domains
> 44043000.system-controller:power-controller: sync_state() pending due to
> 2b10000.audio-contro
> ller
> [   22.554839] ti_sci_pm_domains
> 44043000.system-controller:power-controller: sync_state() pending due to
> e0f0000.watchdog
> [   22.566550] ti_sci_pm_domains
> 44043000.system-controller:power-controller: sync_state() pending due to
> e030000.watchdog
> [   22.577854] ti_sci_pm_domains
> 44043000.system-controller:power-controller: sync_state() pending due to
> e020000.watchdog
> [   22.589239] ti_sci_pm_domains
> 44043000.system-controller:power-controller: sync_state() pending due to
> e010000.watchdog
> [   22.600674] ti_sci_pm_domains
> 44043000.system-controller:power-controller: sync_state() pending due to
> e000000.watchdog
> [   22.611875] ti_sci_pm_domains
> 44043000.system-controller:power-controller: sync_state() pending due to
> 30200000.dss
> [   22.622813] ti_sci_pm_domains
> 44043000.system-controller:power-controller: sync_state() pending due to
> fd00000.gpu
> [   22.633565] ti_sci_pm_domains
> 44043000.system-controller:power-controller: sync_state() pending due to
> b00000.temperature-s
> ensor
> [   22.645540] ti_sci_pm_domains
> 44043000.system-controller:power-controller: sync_state() pending due to
> 2b300050.target-modu
> le
> [   22.657067] ti_sci_pm_domains
> 44043000.system-controller:power-controller: sync_state() pending due to
> chosen:framebuffer@0
>
> The "real" state_synced file on this platform is:
>
> /sys/devices/platform/bus@f0000/44043000.system-controller/44043000.system-controller:power-controller/state_synced
>
> In strict mode, this shows 0, and if I echo 1 (interestingly "echo 1 >
> /sys/..." doesn't work, I need "echo -n 1 > /sys/...), I see PDs getting
> powered off (added a debug print there):
>
> [   87.335487] ti_sci_pd_power_off 88
> [   87.342896] ti_sci_pd_power_off 87
> [   87.347404] ti_sci_pd_power_off 86
> [   87.356464] ti_sci_pd_power_off 128
> [   87.361296] ti_sci_pd_power_off 127
> [   87.368714] ti_sci_pd_power_off 126
> [   87.373349] ti_sci_pd_power_off 125
> [   87.378077] ti_sci_pd_power_off 62
> [   87.382587] ti_sci_pd_power_off 60
> [   87.387194] ti_sci_pd_power_off 59
> [   87.391759] ti_sci_pd_power_off 53
> [   87.396648] ti_sci_pd_power_off 52
> [   87.400801] ti_sci_pd_power_off 51
> [   87.405131] ti_sci_pd_power_off 75
> [   87.409238] ti_sci_pd_power_off 143
> [   87.413328] ti_sci_pd_power_off 142
> [   87.417403] ti_sci_pd_power_off 141
> [   87.421494] ti_sci_pd_power_off 105
> [   87.425632] ti_sci_pd_power_off 104
> [   87.429815] ti_sci_pd_power_off 103
> [   87.433941] ti_sci_pd_power_off 102
> [   87.438054] ti_sci_pd_power_off 158
> [   87.442151] ti_sci_pd_power_off 156
> [   87.446324] ti_sci_pd_power_off 155
> [   87.450463] ti_sci_pd_power_off 154
> [   87.454549] ti_sci_pd_power_off 153
> [   87.458671] ti_sci_pd_power_off 152
> [   87.462571] ti_sci_pd_power_off 43
> [   87.466425] ti_sci_pd_power_off 42
> [   87.470254] ti_sci_pd_power_off 41
> [   87.474032] ti_sci_pd_power_off 40
> [   87.477825] ti_sci_pd_power_off 39
> [   87.481609] ti_sci_pd_power_off 38
> [   87.485432] ti_sci_pd_power_off 37
> [   87.489256] ti_sci_pd_power_off 36
> [   87.493077] ti_sci_pd_power_off 95
> [   87.496845] ti_sci_pd_power_off 132
> [   87.500780] ti_sci_pd_power_off 107
> [   87.504583] ti_sci_pd_power_off 114
> [   87.508429] ti_sci_pd_power_off 79
> [   87.512050] ti_sci_pd_power_off 148
> [   87.515859] ti_sci_pd_power_off 147
> [   87.519644] ti_sci_pd_power_off 106
> [   87.523414] ti_sci_pd_power_off 149
> [   87.527203] ti_sci_pd_power_off 50
> [   87.530971] ti_sci_pd_power_off 49
> [   87.534708] ti_sci_pd_power_off 48
> [   87.538401] ti_sci_pd_power_off 35
> [   87.542040] ti_sci_pd_power_off 186
>
> We do have a lot of "extra" PDs enabled by the bootloader...
>
> With the timeout mode, I see the sync_state() getting called some
> seconds after the boot has finished.
>
> So... I think it all works as expected. You can take this as some kind
> of Tested-by, but it'd be good if someone from TI who knows more about
> PDs would test this too =).

Thanks a lot for testing and sharing your information!

>
> Interestingly, I see a difference in behavior to the old patches from
> Abel: with the old patches, if I boot up with the DSS (display
> subsystem) enabled by the bootloader, it looks the same as with these
> patches. However, with the old patches, when I load the DSS driver, and
> it probes successfully, the DSS PD will get managed correctly, i.e. if I
> blank the screen, the DSS PD will go to off, even if the sync_state has
> not been called.
>
> With these patches the DSS PD will stay on, no matter if I load the DSS
> driver or not, and will only go off after sync_state has been called.
>
> I'm not quite sure here, but I think the behavior with the old patches
> makes sense: when the driver for a particular PD loads, the PD no longer
> needs to be kept on. Or... Is this about the case where a PD has
> multiple consumers? The PD provider cannot know how many consumers there
> are for a single PD, so it must keep all boot-time-enabled PDs on until
> sync_state() (i.e. all the consumer drivers have probed)?

You are correct!

ti_sci_pm_domains are modelled in DT by using:
#power-domain-cells = <1>;
or
#power-domain-cells = <2>;

fw_devlink doesn't look at those additional specifiers in DT. For
example, if a consumer has "power-domains = <&k2g_pds 5>;" the '5'
will not be considered as a separate domain, but instead all consumers
of &k2g_pds needs to be probed, before the ->sync_state() gets called.

Theoretically, if we could treat the specifier ('5' in this case) as
being a separate domain, that should would for most cases. The
question is, how difficult it would be to extend fw_devlink to support
this, so that when all consumers that has  "power-domains = <&k2g_pds
5>" has probed, the ->sync_state() get's invoked for the corresponding
genpd->dev.

If Saravanna want to comment on this, that would be nice, otherwise I
will chat with him offlist about this.

That said, it seems like this is working fine for the TI platforms,
which is great!

Kind regards
Uffe

