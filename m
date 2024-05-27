Return-Path: <linux-pm+bounces-8195-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A15278D0ED0
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 22:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF471B21774
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 20:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20F24C618;
	Mon, 27 May 2024 20:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xk/9zLJs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A71DDC1
	for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 20:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716843441; cv=none; b=OeCrXkYzWFXlZWw8k0qb1KlZcz49iZ12rGwA5FbkbjFzHvM7hSUj7Idneag6h0EnFBnkX3dsEfOVoCsmfF+KX/36uIiTXXJ7K0vwmE9o16u92Nrym5+B+rhgbyEzbxJtwDvlhGpMPOxy3idUdjsKfN+jMdS0P9K7vSVJfxGIe1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716843441; c=relaxed/simple;
	bh=dAU5llq+VJ28lxxQTUliN3NMu/FYRlPYmr6Zg5lTeRw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fWfzJrE7sphORuASl6TcmmX437Smrp0oX51O+IHIHy5Ne1k04OqHsughWJcD1xvpJQtMMx/OEk+hCnYPnlch8xxY25Uxu/QUewX0qt/endzM3I/Psy7GwUwK/dR2gVpBqEmDpMt893sJbLkoOIdAWmNV7fw05HlKbFVxLFinjdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xk/9zLJs; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-794c1a4e5f7so14912785a.1
        for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 13:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716843437; x=1717448237; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e8bs9EbhcdQK3rxulMupHjqyar0ItbldeLVgIYJXmjo=;
        b=xk/9zLJsYTdy5GboBJBk1PckN7qbHsJ28bSv94nGlbu4vNHE1KgSbbI/zHJSEO2PM2
         HR59YbS+iiNv5SDz8EnHmqjsJyuDjHrNc8agtfcGqQYRkd80j5D+XIPWn9j4nNNaWcUi
         un4xBingd9aE2h9SQwviCLc0/eHbCWq+TfkQPbResU27InRA9/4t/3KJg0O8PAN6FwZl
         6J/w3dQxyR4PS1rY7dQjGqv6Ei/QIvhaHeaChQVUQuG9w5hkJ9Vv7NRvzVkhmGJTv9uQ
         xJAUlQU/0c5txpRVm18n2lpuZ+VWhIBM5oU/nHLcPxNlZHyX+dKkUVSZXzSpiAvCXPUM
         cQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716843437; x=1717448237;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e8bs9EbhcdQK3rxulMupHjqyar0ItbldeLVgIYJXmjo=;
        b=EVxHPqFjUD6glG0Wd7eiRZsxu31dPif0I4X9vjO7/PrOe3JLFumf36YQg2XC/AJJ3v
         jEKJgn6QVx0Cve4FlNzf2HprbMo2r1kNgvhqbhXjq7Kvxm2Wf+EE6UAO3gsdydnHdnYs
         h8LFptnJcTAZY/Gh9NGo+dnfHxvwkB+rojdjVlGbHH1UYE2blLwmG/TQ/vQJRxl02SaB
         0MwqN4CcFkrmQ3dayh3NCxVjuqHDwUSGn2YBP5RxCmQwFwol/HbMbo84yhQerSXfTujL
         ve4FAHr0sqlS41lBp3Xqt0NP828yXaVhiuBSm5D1V6T9w17MebCTgv7vcgRWy7zoDmpG
         OzeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDwqpHn/MPFlY/l4H5EDH/SiUNp+YbXzLn+FtdIk15bG+KPEJV2awP1GoAofB/34y1JyKvonlp17PPEusTvEAo/hi90aCOWpE=
X-Gm-Message-State: AOJu0YxSo197HARyrt2yshOWZwk2dqaHJ7601n3WRKizLqloJ7E9dGxw
	ViAF6UgaD8UIJae2o7NyL4Qfn6zRaoGvU42ZTwRY/2uchNIQ3UC6eoBG2Z0tUCM=
X-Google-Smtp-Source: AGHT+IEFA5Xl71Sl0vHc2fZVv9T+NoQ5HUfuJTzWManJsQ0IRn5ypl+K46w3nAeESk2lSwtK276CTA==
X-Received: by 2002:a05:620a:4548:b0:792:e0b0:7219 with SMTP id af79cd13be357-794ab1130a1mr1438768185a.77.1716843437229;
        Mon, 27 May 2024 13:57:17 -0700 (PDT)
Received: from xanadu (modemcable018.15-162-184.mc.videotron.ca. [184.162.15.18])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abd4406esm325258085a.128.2024.05.27.13.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 13:57:16 -0700 (PDT)
Date: Mon, 27 May 2024 16:57:15 -0400 (EDT)
From: Nicolas Pitre <npitre@baylibre.com>
To: Conor Dooley <conor@kernel.org>
cc: Julien Panis <jpanis@baylibre.com>, Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, 
    Matthias Brugger <matthias.bgg@gmail.com>, 
    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
    Daniel Lezcano <daniel.lezcano@linaro.org>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
    Lukasz Luba <lukasz.luba@arm.com>, devicetree@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
    linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 1/6] dt-bindings: thermal: mediatek: Rename thermal
 zone definitions for MT8186 and MT8188
In-Reply-To: <20240527-wife-dress-3ecaf1509506@spud>
Message-ID: <r9q3n5n4-4pqn-53so-4n65-33p432530793@onlyvoer.pbz>
References: <20240524-mtk-thermal-mt818x-dtsi-v5-0-56f8579820e7@baylibre.com> <20240524-mtk-thermal-mt818x-dtsi-v5-1-56f8579820e7@baylibre.com> <20240524-concerned-fritter-262f5e16293e@spud> <20240524-clatter-antivirus-b1939900ee58@spud>
 <61a1be10-7df3-4ba7-b7b4-ccc7f0379656@baylibre.com> <20240527-wife-dress-3ecaf1509506@spud>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 27 May 2024, Conor Dooley wrote:

> On Mon, May 27, 2024 at 05:25:35PM +0200, Julien Panis wrote:
> > On 5/24/24 20:27, Conor Dooley wrote:
> > > On Fri, May 24, 2024 at 07:24:47PM +0100, Conor Dooley wrote:
> > > > On Fri, May 24, 2024 at 11:04:34AM +0200, Julien Panis wrote:
> > > > > Use thermal zone names that make more sense.
> > > > > 
> > > > > Signed-off-by: Julien Panis <jpanis@baylibre.com>
> > > > Removing the defines is an ABI break. If these are all the same devices,
> > > > but with more accurate naming, then keep the old defines and add new
> > > > ones. However, the GPU1 define changes in the course of this patch which
> > > > is more problematic.
> > > > > [RFC] When PATCH 1/6 and 2/6 are squashed, checkpatch raises this WARNING:
> > > > > "DT binding docs and includes should be a separate patch." That's why I
> > > > > split them in this v5. The problem is that the driver can't be compiled
> > > > > any more at PATCH 1/6. It needs PATCH 2/6 to be compiled. Should the
> > > > > checkpatch warning be ignored here ? Should I finally squash PATCH 1/6
> > > > > and PATCH 2/6 ?
> > > Heh, and there's just one of the issues caused by your ABI break...
> > 
> > Conor,
> > 
> > Would Russell's suggestion be acceptable for you ?
> > I mean, this one:
> > https://lore.kernel.org/all/ZlDMNkdE2jmFgD8B@shell.armlinux.org.uk/
> > 
> > I could implement it, but before submitting it I would like to make
> > sure that it suits everyone.
> 
> How's that going to work? MT8188_AP_GPU1 currently means 1, after your
> series it means 2.
> You're gonna need to pick a different naming for the new defines to
> avoid that. Additionally, why even delete the old ones? Just define
> new names with the same numbering and you don't need to worry about
> any compatibility issues.

Isn't this making a mountain out of a molehill here?

Seriously... none of this was present in a released kernel. The naming 
can be adjusted "atomically" so compilation doesn't break, and 
it is within maintainers' discretion to bypass the checkpatch warning in 
such particular case.


Nicolas

