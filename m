Return-Path: <linux-pm+bounces-23993-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1A1A5FF3D
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 19:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A9F21881D6E
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 18:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6865118FC6B;
	Thu, 13 Mar 2025 18:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="T22dHYpG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB69C18952C
	for <linux-pm@vger.kernel.org>; Thu, 13 Mar 2025 18:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741890624; cv=none; b=JO6X9ZrWbnFyzEZe5cGZISwWVCOTnkDyuFbg/oJiZ4KdVgVvpsn+GYFMf/xSNhEjGDYKa0wJFf0e/RdkUupf5McOJejMoLVxg1bgDqqVkqbcbjgc99tSrd5bqB2LIBgKVnjeYc+EHHl/r5UyveV2geaQ8y8RXSDAYR/kfdDtnpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741890624; c=relaxed/simple;
	bh=huvOP2bgSwC/RqVOZlu8vXw8IzpufJ3/MNiOuVsntnU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UsDSob55a+jNYLtsi2wnuKsgvUclEgZU9cozHTXivpJFYZ4EArhmBTLsGKhGOtReH+mD0BNhZL4bcShSFo1q9uvsjkivy1Jm8E89vhhZQfEmTrhwbntACB6Z9dbgvux4cpkwXx0pLZef/614ZelN1fp0ipAsqJyFZuN1kZv/ksA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=T22dHYpG; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c5675dec99so147512785a.0
        for <linux-pm@vger.kernel.org>; Thu, 13 Mar 2025 11:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741890618; x=1742495418; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AoTnsd8iHVdgBepKxF/OkxysUaYLk1//1WxCqfRtAH0=;
        b=T22dHYpG1l+GB5dEEtz48WP58iGaExplTHWGo7YYCbpjtboHgd3F4Mc0uAYelsc+5m
         D4POQKV7riai+KBW/ZFWIORYnoIkFEDGj6Kqemq95iJ1XTwDXWjaJpZuSTob7VArRr9r
         V/cKKqp+1h0wcQNnBJ2E5HE5fa5ogkuImMjuQl2fR7lNflC/mFY26Jcl5lGSY1XB26dZ
         59UsgrxNB6eVWitlV+Xlab0p71Cwwzcn2f/ycqAx/+c1dJTJuHPKbCeVt1W6xnP83XaJ
         jWLbchIEMjImdmvYfRUY3YefPjOL+zFo/a8gpDn6vVsBowaizIIGyeT+yYI517d8rduR
         rkrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741890618; x=1742495418;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AoTnsd8iHVdgBepKxF/OkxysUaYLk1//1WxCqfRtAH0=;
        b=TO+1hJZFdwjBgq3rjbUL53zOEv7TfLw1NB7m0n3FGkD7YbT+bTHh3jpxU4domcIVQV
         K+XsGkOpyQL+QmaC42p9NWoWzS4vLEnrUdPp39f1PuYOm5r6Gnt1P36mgl+bsiZNAK5j
         mqtCfFedvvsE6j/TvE5XzoBTClRf4QsF15whCHpGt1jlLUUrGUuAgxlCHqStfJNsj6Ao
         oX+1EZq73LD19vYa1ci2KiFdOzSqlLhkLAQRgHV2Gl7/dpkwnf91PnZXZLmarWCIOU0h
         1m7dtk4yGUcO11G7cq3kJyhQdwnDaTryoBfvE1/JNI5LKiZ/x/WIOfolNf096t2PZyN4
         Mdbg==
X-Forwarded-Encrypted: i=1; AJvYcCUxhkH9ocxvP4rKZdv6GVDX1QTkIvPYi6EP4uhNRwb6HbAP+Tk9xtovcPR+pssAqFgBjjdzfIk73g==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf9t4jGGeujWyQBrTzlmYkrOeJ4VAG4KamhaM84HgNx1Nvgi1n
	NM3T/b4AVexQWTetLiv8mhMLUMdcbMhb56fCe3NU/0oscfcwF+dSim15hDYjCbNRyvkdnPZDE23
	D
X-Gm-Gg: ASbGncuGJFvGpZAL/cE+vfXP6XYpMiRAJ11gIR0Be2mQfXRmSxAWPSa4H/7QbWZBQdS
	vjZ0JdtIU1u8CMGwMxxCZwBvKkaFxBtXHDCklor5Pts7xD/OnYpiCbkCPTZZ1ywnCLgM7lNWVvn
	Vobh2+kK9XbOh7TGaZ82yUtM5j46wZnRVxyXswNlWmF7vVuHhSvJBhDjkPabZawHhXgHopNeMrv
	df+kdTLgZTdBtRtOUsMEDepiOMmXKjE8HauliIXc2y49m9qXkCF4G51hvSPy1mQ2I0dw1vxj+3h
	W7TW3a4F/xBijb3LhnVOQhna+a/rHLxR/sU0Y7EGsAFpRwz0xkAhXQW7NnAsR+YQHBo+Lq884gG
	dKpq9ODg=
X-Google-Smtp-Source: AGHT+IEi+OIJZ2CCHX/QDN3TCc9Ssw9n2ip3mNRDZzcn/kMPCoNhGIFe17eJ+clCONEScKD+6PgNAQ==
X-Received: by 2002:a05:620a:8083:b0:7c0:6419:8bd3 with SMTP id af79cd13be357-7c579f46d76mr116800685a.22.1741890618305;
        Thu, 13 Mar 2025 11:30:18 -0700 (PDT)
Received: from xanadu (modemcable179.17-162-184.mc.videotron.ca. [184.162.17.179])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c4f53csm128517685a.22.2025.03.13.11.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 11:30:17 -0700 (PDT)
Date: Thu, 13 Mar 2025 14:30:16 -0400 (EDT)
From: Nicolas Pitre <npitre@baylibre.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
cc: Matthias Brugger <matthias.bgg@gmail.com>, 
    Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, 
    linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dts: arm64: mediatek: mt8188: add more thermal trip
 points
In-Reply-To: <dcc62684-0579-4d03-a430-d4a276153ca1@collabora.com>
Message-ID: <85710oso-p1pp-647q-498p-23583s7nnn45@onlyvoer.pbz>
References: <s2sp5o57-o534-qso0-2733-o0prs6028por@onlyvoer.pbz> <dcc62684-0579-4d03-a430-d4a276153ca1@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 13 Mar 2025, AngeloGioacchino Del Regno wrote:

> Il 13/03/25 16:43, Nicolas Pitre ha scritto:
> > Provide the "switch on" thermal trip point to be used by the power
> > allocator governor.
> > 
> 
> As far as I know, the power allocation is not supposed to be 
> SoC-global, as that does play with sustainable power values...
> 
> Sustainable power depends on multiple factors - besides the power that 
> is actually sustainable by intrinsic properties of the silicon, this 
> mostly depends on the PCB that it is soldered to.
> 
> Translated, this depends on the heat capacity of the copper layer(s) 
> and of the eventual additional passive heatsink, which is a physical 
> property relative to a board and not to the SoC by itself.
> 
> ....which means.... that those nodes shall go to board specific devicetrees
> and
> not to the SoC devicetree :-)
> 
> Unless I'm wrong - but if I am, please explain why :-)

I agree with everything you wrote above.

But this patch isn't about power allocation. This is about temperature 
thresholds. And temperature tolerance is rather SOC specific, no?


> > diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> > b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> > index 338120930b..262eab8fd3 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> > @@ -472,6 +472,12 @@ cpu-little0-thermal {
> >      thermal-sensors = <&lvts_mcu MT8188_MCU_LITTLE_CPU0>;
> >   
> >   			trips {
> > +				cpu_little0_switch_on: trip-switch-on {
> > +					temperature = <68000>;
> > +					hysteresis = <2000>;
> > +					type = "passive";
> > +				};
> > +
> >       cpu_little0_alert0: trip-alert0 {
> >        temperature = <85000>;
> >        hysteresis = <2000>;
> > @@ -510,6 +516,12 @@ cpu-little1-thermal {
> >      thermal-sensors = <&lvts_mcu MT8188_MCU_LITTLE_CPU1>;
> >   
> >   			trips {
> > +				cpu_little1_switch_on: trip-switch-on {
> > +					temperature = <68000>;
> > +					hysteresis = <2000>;
> > +					type = "passive";
> > +				};
> > +
> >       cpu_little1_alert0: trip-alert0 {
> >        temperature = <85000>;
> >        hysteresis = <2000>;
> > @@ -548,6 +560,12 @@ cpu-little2-thermal {
> >      thermal-sensors = <&lvts_mcu MT8188_MCU_LITTLE_CPU2>;
> >   
> >   			trips {
> > +				cpu_little2_switch_on: trip-switch-on {
> > +					temperature = <68000>;
> > +					hysteresis = <2000>;
> > +					type = "passive";
> > +				};
> > +
> >       cpu_little2_alert0: trip-alert0 {
> >        temperature = <85000>;
> >        hysteresis = <2000>;
> > @@ -586,6 +604,12 @@ cpu-little3-thermal {
> >      thermal-sensors = <&lvts_mcu MT8188_MCU_LITTLE_CPU3>;
> >   
> >   			trips {
> > +				cpu_little3_switch_on: trip-switch-on {
> > +					temperature = <68000>;
> > +					hysteresis = <2000>;
> > +					type = "passive";
> > +				};
> > +
> >       cpu_little3_alert0: trip-alert0 {
> >        temperature = <85000>;
> >        hysteresis = <2000>;
> > @@ -624,6 +648,12 @@ cpu-big0-thermal {
> >      thermal-sensors = <&lvts_mcu MT8188_MCU_BIG_CPU0>;
> >   
> >   			trips {
> > +				cpu_big0_switch_on: trip-switch-on {
> > +					temperature = <68000>;
> > +					hysteresis = <2000>;
> > +					type = "passive";
> > +				};
> > +
> >       cpu_big0_alert0: trip-alert0 {
> >        temperature = <85000>;
> >        hysteresis = <2000>;
> > @@ -658,6 +688,12 @@ cpu-big1-thermal {
> >      thermal-sensors = <&lvts_mcu MT8188_MCU_BIG_CPU1>;
> >   
> >   			trips {
> > +				cpu_big1_switch_on: trip-switch-on {
> > +					temperature = <68000>;
> > +					hysteresis = <2000>;
> > +					type = "passive";
> > +				};
> > +
> >       cpu_big1_alert0: trip-alert0 {
> >        temperature = <85000>;
> >        hysteresis = <2000>;
> 
> 
> 

