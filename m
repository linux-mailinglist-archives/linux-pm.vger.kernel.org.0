Return-Path: <linux-pm+bounces-26240-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB30A9D14A
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 21:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C6933B7781
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 19:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA4B219A70;
	Fri, 25 Apr 2025 19:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="AX6+kZK6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F241D5CC4
	for <linux-pm@vger.kernel.org>; Fri, 25 Apr 2025 19:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745608612; cv=none; b=UhwPOYqcw6iMMtcQD3nWkIgGgZl1NuCBhZTG51HwR3icm7n3GwdkIMBTLljLMsVp0szHks3DmWOWg5RLGvN1U3xGOWMpbjYTOIYtEdfRG2QcPt9rl/8t0KB1sXxVktSkfjuGOwa5XWZgpUE2an+Oztt9EYmeZHh/tz/CDoKwSS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745608612; c=relaxed/simple;
	bh=aaF5KoonwPXnBEeEYX5de2+bpxSx1NBVU3iFsDtiboQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AB32nm7gAiERzO4ss3v5mxWFhR9BLN1DxIDA1fQ87Y4Ft6ZfkShmRJ+/gtwFp6n4NKV0c7Q3McUi/+jHwVnbCGMVc5jMYqsJQZxQ25JFAYYpQosk+O6usMJO6n2orQBuUbAZKRetuw+LEMgcqR+Vf4c70Xdf6ygCZfkdC7QJ068=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=AX6+kZK6; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22435603572so32363065ad.1
        for <linux-pm@vger.kernel.org>; Fri, 25 Apr 2025 12:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1745608609; x=1746213409; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XNI+wkZfospHmLOr+2+jXX5pJdTmqRckjghLYfMtBgk=;
        b=AX6+kZK6ovgYV1OXg4LN+fg8H6PBJfhIUQTz8JijOzGPflZA1GuWotgMtDF+ppDsPt
         hrOrCgpu+YWTVnnXYJYXnnNmxciITMZGPTnJ/XK69nSJh2VyAwMCMqliDrmdszKnkaLr
         QHGcYS0EkDoWsvobRcvCSwmIKh1L0RuLTOph3rOOvmUZaT4KFWbZEidBcdA20HH+TLES
         krPH0yzYlT2TPvQqQgNSI4bJS417IH7jp5A0AZZv/vfx9nb5TX9mo3lteFbLr9UsAG35
         RmqEnWcZT2IgWiZsIDhB07k0RYQALhdTY0jtw8UYOK0zRKIKcfhSeRKVxecLcWRCg/8x
         jO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745608609; x=1746213409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XNI+wkZfospHmLOr+2+jXX5pJdTmqRckjghLYfMtBgk=;
        b=pp1iOCPkymEAj9XvPSht3HFxNyWwiLPQ26dtLdyD/2fyi0cvy5Q1aWdNXsF/vAiZUB
         X/6KiKHm/mQaSxeR/JhGV34fgC2ta0x8qnAEyriWOW4AuWaEjuY2NDKsjFePzykTQl31
         fnH4oSssvjcx4rrWPBnjhQGFwf4Y+5hVLlN/hWmlikqJb32j0TVq4Po8CZldhq58VrPl
         hDrudRRYR2LyVZoqMqIGFdiF1WKMiQNWInOijaU0D/ZvDoYk4nWxTAT3oVg3BpnM486t
         ZIOsUfIfKaNTkT4OCg4xjso4fexgxWd/VFi/FQ/5CgYT45fHKL9EHhHfE5+SGfjaA1HH
         1Inw==
X-Forwarded-Encrypted: i=1; AJvYcCUAeyngqxJDLZwcqzi8yiApHr2Tqs6CsVbNB/h8rSyP+5DtsWo3PjLPAhN/hJV1XC0fupz8bZ+y8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnGzJRLVb9iZhru8fWjI4QtQ7rx1vdgkSgx3GIr1pUOcxcxDYS
	PQ+jLUfPyV8I51jGEdp7Ry4CaoR55STWRfFiOHNmatdPdd2eznZAin5SHZLbLdw=
X-Gm-Gg: ASbGnctQ9/pNwKfeWapVGddhOvAlH9gFYFCrUZwAlkZFKw9mkkoKer82vEql29x/Wvx
	2/35wuBqJb2Q7WRNGfrgfunWc/NFCa5o1En8IcZFUCOnD0whNvjLZKI7gUzbdfOwPCoFauxLF+K
	RxK7g8rN4fftYzQNKW+YSX2lZYtGPb03VAWbO6CU/JiqZbplOxWc4xqWMU6LTLIwPX0pSBaetDF
	iIjTBXojh6qtohldFVgCWgVUZKN7O6Wshx/ToRoQ5mGNp+/behWV+nDbLaiPBXh/Dc91WMYznuD
	CTX1o0t/Uf2R0byw4ujrmFbUCZa3r4qXDMggSh1NajBPMKc=
X-Google-Smtp-Source: AGHT+IFhMLeZWxbEN2BcydszBZXCVk7gJnHRAGc8GbZQro6UfqEPZMk7uHs43lBLaNwzfikdBQk+ag==
X-Received: by 2002:a17:903:1cf:b0:224:721:ed9 with SMTP id d9443c01a7336-22dbf73e8bfmr61560135ad.44.1745608609541;
        Fri, 25 Apr 2025 12:16:49 -0700 (PDT)
Received: from x1 (97-120-122-6.ptld.qwest.net. [97.120.122.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db510304csm36179535ad.204.2025.04.25.12.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 12:16:49 -0700 (PDT)
Date: Fri, 25 Apr 2025 12:16:47 -0700
From: Drew Fustini <drew@pdp7.com>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, guoren@kernel.org,
	wefu@redhat.com, jassisinghbrar@gmail.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, frank.binns@imgtec.com,
	matt.coster@imgtec.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	simona@ffwll.ch, ulf.hansson@linaro.org, jszhang@kernel.org,
	p.zabel@pengutronix.de, m.szyprowski@samsung.com,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 20/21] riscv: dts: thead: Introduce reset controller
 node
Message-ID: <aAvfn2mq0Ksi8DF2@x1>
References: <20250219140239.1378758-1-m.wilczynski@samsung.com>
 <CGME20250219140316eucas1p29a76023868946f090f261bf78d5103e3@eucas1p2.samsung.com>
 <20250219140239.1378758-21-m.wilczynski@samsung.com>
 <aAP1BW3RmMb/Irya@x1>
 <81e53e3a-5873-44c7-9070-5596021daa42@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81e53e3a-5873-44c7-9070-5596021daa42@samsung.com>

On Tue, Apr 22, 2025 at 09:47:34AM +0200, Michal Wilczynski wrote:
> 
> 
> On 4/19/25 21:09, Drew Fustini wrote:
> > On Wed, Feb 19, 2025 at 03:02:38PM +0100, Michal Wilczynski wrote:
> >> T-HEAD TH1520 SoC requires to put the GPU out of the reset state as part
> >> of the power-up sequence.
> >>
> >> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> >> ---
> >>  arch/riscv/boot/dts/thead/th1520.dtsi | 7 +++++++
> >>  1 file changed, 7 insertions(+)
> >>
> >> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
> >> index 474f31576a1b..6b34aab4b455 100644
> >> --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> >> +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> >> @@ -7,6 +7,7 @@
> >>  #include <dt-bindings/interrupt-controller/irq.h>
> >>  #include <dt-bindings/clock/thead,th1520-clk-ap.h>
> >>  #include <dt-bindings/power/thead,th1520-power.h>
> >> +#include <dt-bindings/reset/thead,th1520-reset.h>
> > 
> > Are you okay if I omit this hunk? My thead-dt-for-next branch is based
> > on 6.15-rc1 but thead,th1520-reset.h only exists in next until the merge
> > window.
> 
> Yeah, I'm not exactly sure how to coordinate such stuff, obviosuly it
> would be best if this chunk would make it to the 6.16, but if you think
> it would be problematic then omit it, no problem.
> 
> I will then update this patch series v3 [1] to gracefully handle lack of
> reset, as the 6.16 will not contain the required reset line for sure.
> 
> [1] - https://lore.kernel.org/all/20250414-apr_14_for_sending-v2-2-70c5af2af96c@samsung.com/

I've applied this patch to my thead-dt-for-next tree:
https://github.com/pdp7/linux/commit/1b136de08b5feca37ebdb6d28db3c9c6285aba5a

We should be able to test with the driver in next once a new next is
published (which I assume will be on Monday in Austrlia).

Thanks,
Drew

