Return-Path: <linux-pm+bounces-18044-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D83009D8220
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 10:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B66DB24D75
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 09:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A73919005F;
	Mon, 25 Nov 2024 09:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ArZCUDN0"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8272190079
	for <linux-pm@vger.kernel.org>; Mon, 25 Nov 2024 09:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732526558; cv=none; b=J4cbYSPfh7nOBYT+375V0XXjbmg5LC+48oVlfE1VnQy02p5lWfK+T6xOgZj9UTaQ6nvNtZSOcbQLq8me4Y2BADa1Yl7ZsNxyauNvZrr1pYzJ0UCX22U69vofzakqgOxWXGuoaqEefG+kTmNpaIC6f3r+oKccdwtwFKW4jHqNaxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732526558; c=relaxed/simple;
	bh=CexHKQl3FUmR0SZEFg5iSm6K5rX5Gc58iLRISMa0v0U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FvIL1jP4jbg5R4CK9E9mxmMXExotn12wTRL8kgtgP/7NV3pved8pc3C+aB0usuwh+Ooh1Del0Oxz4XLoyWtb7nBcerbUNtATAnfAqGbh++1UNFa4PR99C/liPTSaiEScrD1pJwW/ZMCHP4YgnA+GI2uJE2UzNQFvY2GRrCQTHy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ArZCUDN0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732526555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8OjrF0F+IpPYISzGBZP9zSBbVNmXB9V/jVcRVnoDrnQ=;
	b=ArZCUDN0IxoqxXwDFu2raNkqk6XZEoVsmvEa3dZAFtoLVY6aP1gGvup9+vE77x70IEIQ8u
	YrrLUDyRmXeu/6nJYnLMNuJGC+wmrdgY9mGlFixZ5s1wjcD1xa6kTvtwX3noIPyjxsv/mU
	lyBhtgsW3gOBCokc7XQQdAAa+HLz+Lw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-_pvWmf0wN867QzLIj5ft_w-1; Mon, 25 Nov 2024 04:22:33 -0500
X-MC-Unique: _pvWmf0wN867QzLIj5ft_w-1
X-Mimecast-MFC-AGG-ID: _pvWmf0wN867QzLIj5ft_w
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3823527eb9dso2401582f8f.1
        for <linux-pm@vger.kernel.org>; Mon, 25 Nov 2024 01:22:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732526552; x=1733131352;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8OjrF0F+IpPYISzGBZP9zSBbVNmXB9V/jVcRVnoDrnQ=;
        b=SDmXHohIX2d8caQfuxu3Qd2DIrOIODqFB0lY1ay5lao03MlyJWvlH6cJesbcZVB37R
         tV/0gaDWasZMawyw4ASijfpo2JW+4JkOfpIILOUK3lQeU7PUbGtlAr8iJmf4wqhjfC1e
         BWe8XxdGHJW6wGofYkmWd+fjifBEmQv1kLzOZRm/iqFSs22dteK0S9UXFxT3+TBEaUBL
         SBbnBa7BeMsHI2xEOn9Oy+M4uxiorxG6hE2MZJF9AK2fBSQFbNEG3WZ6dhxaCOgiuxlc
         xsU06UdeEi59I2rp4ZDWDf3mXL85KVpFeilx0yVB/k3vA9TzWHyCFtVb5U/k7C6xLCsf
         jvWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZFmgOe/YfcV+vcciBMDXGVp2zFx1q4pN7U6eCac1RkVcGDWai/4vWPLSdmEss+grwRLlfmtedqA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/4HkiRi65bf3Qpf0WAQmw1K14+mcmRitnsz3/DHWA7LrHxyor
	2Xct1mfonj5uqDiPWYT/4nR1PakIr5fOwLFs6eBfgPD+ybxS9mT0UKuSYslQSI0Lq2SnOoMXBZ3
	YNLd4e/QZN5Sb7x6iWDGRitMPTJELbeDumN+8bkkPKIZjh1kDrCHK5Znz
X-Gm-Gg: ASbGnctN/GwPqR3ZaiovVvjRzgUoNt1SewrSh7i9PsuzX3nrH5ykPFE0ro463fnUxsz
	UWk/a8GXO47RCfcVrNh1hccrsBF6x5aEh+IlnVprgw3ZlZATVyq2ymP2g88wgR7SpbthyhGpR+q
	/snQNRQt8jne8Is0NPq9ujLOhaYVuDWwvGcgBTMLLGe1tOpmgpx9x8qOx1iDWA/p3yVeOIO70Ui
	0q0+wExNDbPeWb9zI0k1Hme4aeAiAgQBgNb5wBLzhSSaR3ako5D4h+UvZBIWh1H7fCk+I1ZvwMD
	e2A6RpPJtmg70Phn8ofAGgLTV+US0tL3
X-Received: by 2002:a05:6000:210f:b0:37d:46e3:4e88 with SMTP id ffacd0b85a97d-38260b486ccmr7454996f8f.9.1732526552582;
        Mon, 25 Nov 2024 01:22:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwyCHgi6TDm1d8egePLc7qwiwGO8MXpIKcAGGB2QysITZzSXmv4g+RZJTgzvGV+e5dLLCdDA==
X-Received: by 2002:a05:6000:210f:b0:37d:46e3:4e88 with SMTP id ffacd0b85a97d-38260b486ccmr7454979f8f.9.1732526552281;
        Mon, 25 Nov 2024 01:22:32 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825faf9dd2sm9735534f8f.26.2024.11.25.01.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 01:22:31 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Radu Rendec <rrendec@redhat.com>, Viresh Kumar
 <viresh.kumar@linaro.org>, robh@kernel.org, arnd@linaro.org,
 linux-kernel@vger.kernel.org, Zhipeng Wang <zhipeng.wang_1@nxp.com>,
 javier@dowhile0.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH] cpufreq: dt-platdev: Fix module autoloading
In-Reply-To: <20241125-eminent-devious-zebu-ec2caf@houat>
References: <20241119111918.1732531-1-javierm@redhat.com>
 <20241121071127.y66uoamjmroukjck@vireshk-i7>
 <87iksh3r4x.fsf@minerva.mail-host-address-is-not-set>
 <20241121090357.ggd4hc43n56xzo4m@vireshk-i7>
 <87frnl3q63.fsf@minerva.mail-host-address-is-not-set>
 <1c5e13b7472917b5fa303553da04ae16590f3105.camel@redhat.com>
 <87cyin42mb.fsf@minerva.mail-host-address-is-not-set>
 <20241125-eminent-devious-zebu-ec2caf@houat>
Date: Mon, 25 Nov 2024 10:22:30 +0100
Message-ID: <877c8r4qi1.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Maxime Ripard <mripard@kernel.org> writes:

Hello Maxime,

> On Fri, Nov 22, 2024 at 06:09:16PM +0100, Javier Martinez Canillas wrote:

[...]

>> > FWIW, the OPP table is defined at the top of r8a779f0.dtsi and
>> > referenced just a few more lines below, where the CPU nodes are
>> > defined.
>> >
>> > As far as I understand, there are two options to fix this:
>> >    1. Revert the patch that allows the cpufreq-dt-platdev driver to be
>> >       built as a module. There's little benefit in allowing that anyway
>> >       because the overhead at init time is minimal when the driver is
>> >       unused, and driver can't be unloaded.
>> >    2. Modify the driver and create an explicit of_device_id table of
>> >       supported platforms for v2 too (like the existing one for v1) and
>> >       use that instead of the cpu0_node_has_opp_v2_prop() call and the
>> >       blacklist. That would of course also eliminate the blacklist.
>> >
>> 
>> Agreed with this. Likely (1) is the easiest path and (2) would make the
>> driver more aligned with the rest of the kernel (that have a list of OF
>> device IDs to autoload / match instead of some custom logic).
>> 
>> But I guess that (2) would be riskier, since not adding a platform that
>> uses v2 will cause a regression.
>
> Also, 2 probably wouldn't work. Devices under /cpus don't get a struct
> device created for them, so it wouldn't probe.
>

Yeah, but the cpufreq-dt-platdev driver has a of_device_id table for the
OPPv1 that matches the actual SoC, not the cpu device nodes.

So for (2) I was thinking to do the same. But yes, agreed tha (1) is the
best option here.

> Maxime

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


