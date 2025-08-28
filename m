Return-Path: <linux-pm+bounces-33262-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D413B39EDB
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 15:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2409C56134C
	for <lists+linux-pm@lfdr.de>; Thu, 28 Aug 2025 13:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565ED311957;
	Thu, 28 Aug 2025 13:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eQjSZpjV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793642D73A1
	for <linux-pm@vger.kernel.org>; Thu, 28 Aug 2025 13:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756387619; cv=none; b=kPpBl5Wrv3kbINQ6ddcfrhOq+tmLcdAiPBE1q9qFjNJekmll8hFSXxxKeDnUmzEojbZSsfya3NsozKF5b2TQcbpTGhk/q8je4yJpWw7nxO1Hm7yAYI0vbtZ/Tp3fMRfcZRXHNibpzHUqAptMyEEoNCW6BZskvsGuGeZjSHDaWPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756387619; c=relaxed/simple;
	bh=vfWvNgcav3r9QFMJfVoU8AERgLXxQbSnW2pOQXqJYpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RzJFsWr9k0FIYhJax1Dhl4iUKtnOgqnaIg3h8AQvFvVD9y3k2T469NGcpOBZsnv2A7YPf0nyy6OHR0k8PbcXapodidDQ5Cd8wssLIgXU4Q444tnLYmfAmuGDNvvRQi3+nq8MYwvLG2rebpP1QXCGJEa+YrNm/GknZOVLN7PKYaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eQjSZpjV; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55f469ad067so1052930e87.0
        for <linux-pm@vger.kernel.org>; Thu, 28 Aug 2025 06:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1756387616; x=1756992416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTOF6xiQv0qzQRLjdqMkKKYD5QGR1e1uQsj6mloKX+U=;
        b=eQjSZpjV9rKP15YQ3go4WwVeY+ZnwIvipTMMTUwTRVhPQJ407h7XKrdiYzTVROtk13
         8U3vefWj46W9q1lAheGjCgtmBFiQ/TogitDT0KsoTHUtUQE1TUspvIFHecteD7KHo3HL
         sRmWxV2QEA4z1VRy05Hdl1k5UMEz4d74iyDwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756387616; x=1756992416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UTOF6xiQv0qzQRLjdqMkKKYD5QGR1e1uQsj6mloKX+U=;
        b=CNTsGOPs3C2s4T7BTUE09TvtU3kMAQsa5R0iQETqWJ8ieCMbY5v3PB79bMuxIWs7vB
         JDAwh57odsMpb3vXxRqMPEk92Y/9zBWorTiK8lVyYUwZJqM8sCv6LeXX1sJyRZ8NZsfK
         T27uVBcI/yyejDHosQ0ioDOaY8pVptXWpEA3GXve9vTjiM4u/VuGbPHkTkfJV49HlBhC
         YKNW+BmYQZ7FIEuo72KdFS189eLjgY/tcgbV/Twbotp3UjRYd/AWEbFjLZ4tiQ0nCvLM
         sEpG6v/WB0aBktj0UlLJDL4CnfCHbUuR4PDfZTkzRZIBxKENeLilKP/cOW3srWAax5jf
         nytQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWdXRF99CDhoDt0yTyJJJ578aZdb08SqsYupIepPP8lIIA+Ji87a/gtSvwQpsaDBz9ktV6x6I/+g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnat43w7iCtOOl99S63tRy3Jy/Lybxv01cBmU/Utuo6CTSuAsr
	vJq1Y5IaMCkcYUU7VbTRY5z//p1axjcVOoM7E4I+H1th4dpAN+wRTAIBV31ar2p4o/Wjkt6pjD/
	Ner3RK512/0WyHQQ3MqmcFTOsnCU5x9Wryb229FJl
X-Gm-Gg: ASbGncsP8uRVKUPr19xkj2gixrZzmMiyWTIhJs8XvuyH9SGsSDEGwVTG0nvqqvF7EwU
	TKWPAmbeF9wLWSAH2OiJPlEHl9cIuvgzj6+olHLtHXVT6mPm4XslB3Q3ZcWhyux5G3wI9UqFL0E
	OnES3ycxTvt2+NP9OMllNFUe2OhM5oPQXSyA5Hj0gWUSYNO1YjXjnas4FyUa9paKPvrlp2X6zTW
	KiPHuom9P2L6wEeMOIbw2iUYAOSx4XHF+AJuA==
X-Google-Smtp-Source: AGHT+IGKaP7lckMwAVsqZkce2iGR63rMwp/YwXpHrLXd8d9BSHElcYzrrAlXcYiXDcwUU0dCjGA+bOrjwY+YJkMmFn0=
X-Received: by 2002:a05:6512:3b97:b0:55f:4c92:f4c8 with SMTP id
 2adb3069b0e04-55f4f4c6b92mr2765248e87.8.1756387615553; Thu, 28 Aug 2025
 06:26:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214074353.1169864-1-chun-jen.tseng@mediatek.com>
 <20250214074353.1169864-2-chun-jen.tseng@mediatek.com> <20250219054209.erwfp7sgzchaiuds@vireshk-i7>
 <e8337c5eee0cadb797bacf26b00f1ca303c5147f.camel@mediatek.com>
 <20250321045624.mwm2mnkqeow5uids@vireshk-i7> <2a73b5ca35692c8ffa68c9ff0df73e24a592967d.camel@mediatek.com>
 <20250321060148.adhxjexpnm4dkpnt@vireshk-i7> <e1c2c12bace22d1803d16ecbfb32129518d87157.camel@mediatek.com>
 <20250324054333.sgwwksawnybx3lp4@vireshk-i7> <06356a55cdb3c34dfc716349d1967f95655b0ab2.camel@mediatek.com>
 <20250416080517.feansrkpycsynk6t@vireshk-i7>
In-Reply-To: <20250416080517.feansrkpycsynk6t@vireshk-i7>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 28 Aug 2025 15:26:44 +0200
X-Gm-Features: Ac12FXxYNpnEAlBmbtFHr64VxND_7eVbeCYS5BHUQbSiC1qF3AAnoY211E0MhhA
Message-ID: <CAGXv+5FyR8bt16nLvS0V=_YRWM6G7V0OOpxctA+_4hVnnCjDtg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] cpufreq: mediatek: using global lock avoid race condition
To: Viresh Kumar <viresh.kumar@linaro.org>, 
	"myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>, 
	"kyungmin.park@samsung.com" <kyungmin.park@samsung.com>, "cw00.choi@samsung.com" <cw00.choi@samsung.com>
Cc: =?UTF-8?B?Q2h1bi1KZW4gVHNlbmcgKOabvuS/iuS7gSk=?= <Chun-Jen.Tseng@mediatek.com>, 
	"rafael@kernel.org" <rafael@kernel.org>, 
	Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_Upstream_Group@mediatek.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 4:07=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> On 14-04-25, 08:42, Chun-Jen Tseng (=E6=9B=BE=E4=BF=8A=E4=BB=81) wrote:
> > Hi Viresh,
> >
> > The CCI level choose by Max_Level(LCPU & BCPU frequency) in devfreq
> > driver.
> > without global lock, It may choose wrong CCI level and cause system
> > stall.
> >
> > I hope this flow is serial setting like, BCPU / LCPU set frequency ->
> > set CCI level -> BCPU / LCPU set frequency -> set CCI level -> ......
> >
> > without global lock, it could be LCPU / BCPU set frequency -> set CCI
> > level(during this time, it may change BCPU / LCPU frequency and cause
> > system stall.
> >
> > I also can only do global lock on ccifreq_support SoC.
>
> As explained earlier, I don't think there is a race here. May be I am
> wrong. And so I need a clear code path example from you, which proves
> that there is a race here.

Maybe a different set of eyes will help. I talked to Chun-Jen offline,
and I'll try to explain what I understand.

First of all, the issue lies not in cpufreq, but in the CCI devfreq,
and how the passive devfreq governor is linked to cpufreq.

The CCI hardware unit on the MT8186 is sensitive to frequency changes.
If the performance level of the CCI unit is much lower than either
of the CPU clusters, it  will hard hang the whole system. So the CCI
devfreq must always take into account the performance level of both
clusters, or in other words the settings of both cpufreq policies.

Since the cpufreq policies only serialize with themselves, it is possible
for one policy to change and trigger a devfreq update, and when the
CCI devfreq driver is doing its calculations, the other policy changes
and causes a big deviation from the assumed performance levels, leaving the
CCI into a non-matching performance level and causing a system hang.

So I think we need to handle CPUFREQ_PRECHANGE events for the frequency
increase direction, as well as enlarging the devfreq mutex to cover
the CPU frequency tracking bits in the passive governor.

I hope that makes sense.


Thanks
ChenYu

