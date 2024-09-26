Return-Path: <linux-pm+bounces-14831-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 511879876E5
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 17:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FC2B28707C
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 15:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A72D14B086;
	Thu, 26 Sep 2024 15:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BKqJIntv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E492206E
	for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2024 15:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727365795; cv=none; b=rryjUWzmwElByIzn0Mp4+PNCJvX/bELHgy7SYTxdkUuZ3JI/4QDNNPdbGw6xKGjenS5j/9cikkMlB8z3cbgnVR7sn87Wc2sqUBmJWWaCyWVgFpW4kRcF+wO9gMHcecasgnRujseNEP4hT2Ol43J/tqJpSs+QQBoUDbjW7cYQcXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727365795; c=relaxed/simple;
	bh=w14sq6XUk0SsNzgK6mSSVRdxP/9svZ9tMx+UgCkG04M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dZSLnfY40kekac/ujHcK19GCinb6R1IFc8Ees6iP5VrT9p9m47cxDJbv1VzK1P2XGIZaY9uamneB2gA82th7vK5thxCz+AI3GUtqL7vabsZUOk3V+XTunBFbFaJKLKbJQ9Mjpgthv6JkqvHxZ0wHGT3OtL09+dmX7aPF8GWM5y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BKqJIntv; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e252d1c5b25so1065010276.3
        for <linux-pm@vger.kernel.org>; Thu, 26 Sep 2024 08:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727365793; x=1727970593; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q/C6W+i03PB1ReYtpl5/qyhBiUgWpLGUr9VE1GQJcEg=;
        b=BKqJIntvXVws/7R07F/j1FCDPj6qOhKIpd2KmHUBJcuxaUWEVjjEo5dgDkZDgZCv+V
         2cO5x/OUEKRKZ2Vu0b0jaqAMA4donXKuj0/fFGC71k4IcRAy1mH0oP/5lIJOW+CZo3ad
         V34y+/BkWraJHHk9qr6uRr+JIN342aBSHSFw+zBvQ6WHqyRyK2om3lQUryeCrQd2MZwt
         EdKkSQr+jB4M/JRiIayMxqjJnuGlCOq5XKURAFFvMsfjj4qZidLlKNOlXwrBHtk0/HIW
         uy9lOl/tDUs7pWlcJBFNRtU4+nSidi5Hs4ylXld0uclgPazBRrgrUFGM1E3ZSxtbSsWO
         lVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727365793; x=1727970593;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q/C6W+i03PB1ReYtpl5/qyhBiUgWpLGUr9VE1GQJcEg=;
        b=JlLk/36Yfin0tml4dKhSVIj7AZta72N0AbPqVlmbXtGOK9JmiMLZTiXw7Khy29e968
         cNi6sqrKG4RzNWii2P25tmbxD51RjK6pyUml6lvYA9Rkmrny7FqcwRy4Y4v8g+2gqm+T
         XINFvJx5b+rTeUmLuZEhvohgUit1LTtPsEPTF0D8LyPMoDSjiGX1CeROZ0KjWEG7jcfd
         95scUfX7VbV0SX3lgKJ3omVP/dj5opK/p80MFl3u3gMRk3tup09rsu7oAKA+A5bjzBQG
         wOdAj1UO+pYM4Ipy5gYlezNaDD6mi7tr7FNd98UVXeENgakexM62nyk7G9eL/6ewCZab
         dd8w==
X-Forwarded-Encrypted: i=1; AJvYcCWI9LUJ74n1QpjpFHHEC6/hObxSMoIoo/T7ezku3ms4XqAaanhiu3+rrkMja12uiHdHzc/OTMLUmg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzoHcAnDUinh6VmqPddqeCVKZLyX/8UcugR+9Xet9lX46RRaQfv
	IqZ/iDEn/XxuiDKqEncrvtAEA48KUGWcdfgKKWLZ1fUMPFslGL6l6OUxCHtLM/trSZzo0wtKNon
	uPxIDtFeJRgzIUpzpcT0M/rnIcRY4iTqJVLhoukIplx/Ocg46QJs=
X-Google-Smtp-Source: AGHT+IFqqGJreMRNFfnsSuthz64Gd/N9P25tYQ9qT6LFx4CM65znxx9CuUuNf/VeLj3Ht2p1xv5M9snqdM0j4M8TDec=
X-Received: by 2002:a05:6902:2583:b0:e25:e2f5:38ce with SMTP id
 3f1490d57ef6-e25e2f539e1mr696097276.37.1727365793039; Thu, 26 Sep 2024
 08:49:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925093807.1026949-1-wenst@chromium.org>
In-Reply-To: <20240925093807.1026949-1-wenst@chromium.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 26 Sep 2024 17:49:16 +0200
Message-ID: <CAPDyKFqoqppLipOG1vK-8oU_6cMdZ3DV5Gxqhs5-+7+cQJ6=qQ@mail.gmail.com>
Subject: Re: [PATCH v8 0/3] Add of_regulator_get_optional() and Fix MTK Power
 Domain Driver
To: Chen-Yu Tsai <wenst@chromium.org>, Mark Brown <broonie@kernel.org>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Douglas Anderson <dianders@chromium.org>, Johan Hovold <johan@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Pablo Sun <pablo.sun@mediatek.com>, 
	Macpaul Lin <macpaul.lin@mediatek.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Sept 2024 at 11:38, Chen-Yu Tsai <wenst@chromium.org> wrote:
>
> Hi folks,
>
> This series is split off from my "DT hardware prober" series [1].
>
> Changes since v7:
> - Added stub versions for of_regulator_get_optional() for !CONFIG_OF
>   and !CONFIG_REGULATOR
> - Added new patches for devres version and converting MTK pmdomain
>   driver
>
> At ELCE, Sebastian told me about his recent work on adding regulator
> supply support to the Rockchip power domain driver [2], how the MediaTek
> driver has been using the existing devm_regulator_get() API and
> reassigning different device nodes to the device doing the lookup, and
> how the new of_regulator_get_optional() is the proper fit for this.
>
> Patch 1 adds a new of_regulator_get_optional() function to look up
> regulator supplies using device tree nodes.
>
> Patch 2 adds a devres version of the aforementioned function at
> Sebastian's request for the two power domain drivers.
>
> Patch 3 converts the MediaTek power domain driver to use function.
>
>
> Each of the latter two patches depend on the previous one at build time.
> Mark, would it be possible for you to put the two regulator patches
> on an immutable branch / tag? Otherwise we could have Ulf ack the
> pmdomain patch and merge it through your tree. Sebastian was fine
> with converting the rockchip pmdomain some time later.

Thanks for providing some context!

In my opinion I would prefer an immutable branch/tag of the regulator
core changes, so I can carry the pmdomain changes for MTK through my
pmdomain tree, but also because I would prefer if Sebastian could make
the corresponding conversion for the Rockchip pmdomain driver. If this
can get queued soon, there is really no need to have an intermediate
step for Rockchip, I think.

Does it make sense - or do you prefer another way forward?

[...]

Kind regards
Uffe

