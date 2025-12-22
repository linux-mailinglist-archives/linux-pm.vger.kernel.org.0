Return-Path: <linux-pm+bounces-39787-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FA1CD6DDE
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 19:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AC46302A112
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 18:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7850433373D;
	Mon, 22 Dec 2025 18:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ry6vyLnW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="c3FHLG6d"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B8925F98B
	for <linux-pm@vger.kernel.org>; Mon, 22 Dec 2025 18:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766426446; cv=none; b=aM3h0X0AZBUQ1je8cRuciaRUAIxQj43AoQmsQghMGGAsns1lPgMPAR9JjzlRV8VFuTM6Hhf8H8ZK/iIsVmgFLvUXqL7HW/3l4zZzoynK+Ad4bIb0ujFyojDuXn+wIAJ9inFJdGDY8BQtjKOgTvEqZpr3+8go3wm0xfOIkQso4As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766426446; c=relaxed/simple;
	bh=cbyuGkfXpqUbhzcI1BkQa3K8cyZUe/N+4bGTpsNbH5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gfy6I9ZaBe98+VDX8ZlXQ5TeNc1jZGS9+kZjV9NGBc6/Cy2Ol6wpvnBDWU6sU5km9pZjKHTgAeYe6QW6QG9gyfdhYneDCtduBPHj871PhkOb4187RvK20c5ovXSh8SVve7T/AGMvVtP0YWOLUmUKx0IVs0h7JzLZEkabAZWtnHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ry6vyLnW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=c3FHLG6d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766426443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dXo0XmPhzaeXOxCnEx9hH+u3QjRF1RyUWpvNBcumJRc=;
	b=Ry6vyLnWOpv6vdCtcaxjD6ub2uDlsXaj2G/lFujiZUG/YLehECkr8BAT5TM/MSGW/Jo9Wo
	T5z6dK8KIELK0NDltbV2MLsSjJ4ei+6LcNShzLA8d2uWfh6n/oi510EAgmgdjg4vUszIvM
	kuSaGpoK51c5pvPCPBEUl4xfGXNGH0U=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-kL4JEjnWMUaf5NavTgcQAg-1; Mon, 22 Dec 2025 13:00:41 -0500
X-MC-Unique: kL4JEjnWMUaf5NavTgcQAg-1
X-Mimecast-MFC-AGG-ID: kL4JEjnWMUaf5NavTgcQAg_1766426441
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-88a3929171bso89675146d6.3
        for <linux-pm@vger.kernel.org>; Mon, 22 Dec 2025 10:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766426441; x=1767031241; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXo0XmPhzaeXOxCnEx9hH+u3QjRF1RyUWpvNBcumJRc=;
        b=c3FHLG6dt1utePC4BAhCOu9bsRZBsYxoAjdwgugSfG2kwnsR9xoQY2c8lm8j0YrcDy
         M+lX19ls1AlHMCcFSvHxmN/kcFgWd7SwRSVd1zydUqsiVTZaMKn0/FpQpUBXX1vWQw4S
         M6EfyBys6JvnnpynZbpenEdTazny5H+3wqe78ZD7tS9lpqpsWKv8JPlEXO+78QhPd+H5
         dfoSALSttX1C+oo+nbRg258lBYwWPT/zRcNhuuCCf8HNOZqgnCN/+s/RX7088DKiIipn
         kLPso4ZirxBnefCbTOV3GFWgojQWRrfEQ92GtDGfz7M1Ni2zO6xZGNq6mQpGtaSuVHbM
         tFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766426441; x=1767031241;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dXo0XmPhzaeXOxCnEx9hH+u3QjRF1RyUWpvNBcumJRc=;
        b=H8qpCFWFB+xPVFcaaWHrEbHa4kYoUaNH2XGTj+urA+z/FXdYdF2QoSDIXkHMnqLyJk
         3R0oTTRAj1kW8tlM7M8vkifYOhH+TCrqWbrAgFCMIgiPh2aUxeYgk2z3liN4gxhRTEOn
         r6EeNTIKlBC/E3+q3PvjAY6LsOZc38dNHuGOghdARQi8b4UVEOQsJ/ntEvzNY0Ge5RwX
         hH/C4rXGFkBW3lGBvj2MV89z47RmNPw0287hb95vWIXQDpGo2W7XIeLN/+QsYayOz4yi
         47f0vTIfNNC782DkpMMFkX3/4dNt2EShqV+P/V5WUhc74bYQLBCqwLKNxEprNFZNAFiX
         eaOw==
X-Forwarded-Encrypted: i=1; AJvYcCXZL/4nSeYvXu7L/PYNcLHKvtQdvpJsWZMm8ZYehbQiACrz5vz6kT804WGge+rbLsqw2Eyd78sExg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXUQEuyxSm5KiEJ2rOb7RKHJs3Nudll0uVrsRobHz6CPmqJgDD
	w+50dg4xubBH7uxKR/fwa/soxTs7+53n8sPS/KB/gcLr5b0TSYfUfohtX4nC9H7a73FGFTy+89J
	Uyz7mVGrvMiVQvAdQxDJbSdiWqU6FMh3fzCrYaeuZ4vxs8A+hRrCUvKq57ZDv
X-Gm-Gg: AY/fxX53XdEf2mumyApQXUE2Rz7Z1FIZLyBohW21Cr28xvra0duVsjEquS9ru5mZrzm
	g8AKi2rsS96wdyJ+a6y84EgGp6mkSaxwRv5NjgQIgvpRNjs8GjvSb0TIRS4+MTPJTNObg7NaZ8f
	TWvzIOcYIC81UzjKhEwrVrFptKu4Cht8jbWmKrLXoEOMZBUBaEKPU9jBPU9xAwUX+w6o8VhXh81
	8rEObWUKXSJUNky2ZMqDcKaQF6XefalGgpN7VPGeeyVoM+mbwjXdZhaC3JY6D6pYBO4Kch19Ue0
	KTkWJd/PsRf7m84rwedneQ2ActZHptfoN6K63R82s5aZa2A8UQglNz9Qp5SYF2zkgXFojC0/Dh6
	RDCg80/rXXUF1cDbRVYoLZoPS8UmJI5hDzU/xdFoYzdMM
X-Received: by 2002:a05:6214:27c6:b0:88a:306b:820b with SMTP id 6a1803df08f44-88d83d670e7mr209995226d6.57.1766426440621;
        Mon, 22 Dec 2025 10:00:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFShBd6/ILCtyh9OhdnIzWfY3dp9JmiO74dGqZBOXDUCJ4lowAybkSiEsS44d+2GsPo84wwMA==
X-Received: by 2002:a05:6214:27c6:b0:88a:306b:820b with SMTP id 6a1803df08f44-88d83d670e7mr209994116d6.57.1766426440046;
        Mon, 22 Dec 2025 10:00:40 -0800 (PST)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9a63e296sm86625536d6.52.2025.12.22.10.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 10:00:39 -0800 (PST)
Date: Mon, 22 Dec 2025 13:00:36 -0500
From: Brian Masney <bmasney@redhat.com>
To: "irving.ch.lin" <irving-ch.lin@mediatek.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Qiqi Wang <qiqi.wang@mediatek.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
	netdev@vger.kernel.org,
	Project_Global_Chrome_Upstream_Group@mediatek.com,
	sirius.wang@mediatek.com, vince-wl.liu@mediatek.com,
	jh.hsu@mediatek.com
Subject: Re: [PATCH v4 04/21] clk: mediatek: Add MT8189 apmixedsys clock
 support
Message-ID: <aUmHRCXNy45PrVLG@redhat.com>
References: <20251215034944.2973003-1-irving-ch.lin@mediatek.com>
 <20251215034944.2973003-5-irving-ch.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215034944.2973003-5-irving-ch.lin@mediatek.com>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Mon, Dec 15, 2025 at 11:49:13AM +0800, irving.ch.lin wrote:
> From: Irving-CH Lin <irving-ch.lin@mediatek.com>
> 
> Add support for the MT8189 apmixedsys clock controller, which provides
> PLLs generated from SoC 26m.
> 
> Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
> ---
>  drivers/clk/mediatek/Kconfig                 |  13 ++
>  drivers/clk/mediatek/Makefile                |   1 +
>  drivers/clk/mediatek/clk-mt8189-apmixedsys.c | 192 +++++++++++++++++++
                        ^^^^^^^^^^^^^^^^^^^^^^^

This file, along with others in this series, is not listed in
MAINTAINERS. This is the current entry:

MEDIATEK MT6735 CLOCK & RESET DRIVERS
M:      Yassine Oudjana <y.oudjana@protonmail.com>
L:      linux-clk@vger.kernel.org
L:      linux-mediatek@lists.infradead.org (moderated for non-subscribers)
S:      Maintained
F:      drivers/clk/mediatek/clk-mt6735-apmixedsys.c
F:      drivers/clk/mediatek/clk-mt6735-imgsys.c
F:      drivers/clk/mediatek/clk-mt6735-infracfg.c
F:      drivers/clk/mediatek/clk-mt6735-mfgcfg.c
F:      drivers/clk/mediatek/clk-mt6735-pericfg.c
F:      drivers/clk/mediatek/clk-mt6735-topckgen.c
F:      drivers/clk/mediatek/clk-mt6735-vdecsys.c
F:      drivers/clk/mediatek/clk-mt6735-vencsys.c
F:      include/dt-bindings/clock/mediatek,mt6735-apmixedsys.h
F:      include/dt-bindings/clock/mediatek,mt6735-imgsys.h
F:      include/dt-bindings/clock/mediatek,mt6735-infracfg.h
F:      include/dt-bindings/clock/mediatek,mt6735-mfgcfg.h
F:      include/dt-bindings/clock/mediatek,mt6735-pericfg.h
F:      include/dt-bindings/clock/mediatek,mt6735-topckgen.h
F:      include/dt-bindings/clock/mediatek,mt6735-vdecsys.h
F:      include/dt-bindings/clock/mediatek,mt6735-vencsys.h
F:      include/dt-bindings/reset/mediatek,mt6735-infracfg.h
F:      include/dt-bindings/reset/mediatek,mt6735-mfgcfg.h
F:      include/dt-bindings/reset/mediatek,mt6735-pericfg.h
F:      include/dt-bindings/reset/mediatek,mt6735-vdecsys.h

Should the entries to MAINTAINERS be simplified to the following?

F:      drivers/clk/mediatek/
F:      include/dt-bindings/clock/mediatek,*

Brian


