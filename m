Return-Path: <linux-pm+bounces-33696-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B35A6B41BEC
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 12:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74BF01698D5
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 10:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332A62D8781;
	Wed,  3 Sep 2025 10:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pNsa3txk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D75C279DA3
	for <linux-pm@vger.kernel.org>; Wed,  3 Sep 2025 10:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756895645; cv=none; b=PkuQXW0QPthq4hNHwRIm5Isck3cSHAJ6Gs/4LGPP1rHxqBWn4w1K5Sn1T5BMDONDBpqC9ghswFUI2BFdZsONIHCXbLYoDCeRVNxLChG3uCXqctl/0ipMS6D5mr1q/CfSKGG3gQYN2xO0k61JB5x+HNW7UeIgFepn+QmX0G+4iUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756895645; c=relaxed/simple;
	bh=HlSQD/VcE7uTwqqaKdqNmC0YhBGljeq3jMyA/8WahEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EtHNV5dMqydfl2yPTHGLaTibvwPTWXqLJgpWH2Rqf6OCH2BoZDn2E2c4a4PNTUvMLO4xmr2Gnew+l4hzWOZOqoXezwxTVLkZdezHysaoHOfT70ztmtOlKvWyMfNNOxHy52C5CvOp+Q5aXyolT6QUXANIUyLnHLtbaL/gDx9BQk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pNsa3txk; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-71d6059f490so63702917b3.3
        for <linux-pm@vger.kernel.org>; Wed, 03 Sep 2025 03:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756895642; x=1757500442; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z0EtKdPy1PWYpoHwEbU4TADx/7jEVJjgADRxCA2SS1U=;
        b=pNsa3txkMPk0JmkBQ6ost49GtUPwfNYEMlQLerpJLPJJuCY/OBJDQWrclT4nskjZKJ
         /GRSZPSVi067JuT9kt7hyNPv9AnHATRcVhY82Q7MV/30LnpSzWRbRjf/eEyOvz9Rc3vF
         QV707A1f1fZQ1H9CVIMXq90GDOLk3Z/xkI4GM6UHooTLGrG3RtVY4krgqoVQ0Q6nHdRg
         kQne6po2Vmg4Sjt9dYg82OByagYfX3fvTx5vOpohjri1dw9cE4rf3ZKtA3tAlM98WzAA
         rvXfGictDga7SPLbdJ1rn+kWlwkhFSKjBAYQq9sgsQinC4r7xAARoY6JtibDsXqAlRA2
         2wWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756895642; x=1757500442;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z0EtKdPy1PWYpoHwEbU4TADx/7jEVJjgADRxCA2SS1U=;
        b=KM2UUqs5WbsQqHYGyD3avERjAeL6+4aLEaGGph29tWuVMwPQZNkWaiIgr6cxZ/yhSc
         kUJDCoi/lsSt0w9SoNfhZUkD2JpeH4b7PNVd+Lz4sSDO4qow84HtbO36Fvu/cwQvffaQ
         qqwI/EXJ1vWKSOJCiBI1ydYtGYt7x1RtggsfIhq8rrvr0pgksFxbW6ijfYhJZAbMS7ie
         OU7bSRy0XupMRLh/hrXo/JJ2A7vrYa+Zac0QZm/PQi9DBc2ApMqX1MYIy5itwvvScKqw
         NAPOvnTTtrNncDdnTZKV3EpvsSsxO+6YD+GHiNn06p93C8/ItNJc65OE/XBVhu7j0W59
         /yBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMABYfbSNrU61Ptp745xkxGbaERsn+Ag7Zy4FcRu9TrCJa52hf/uT8rAXSrukAXq8nm7cBusC8lQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwxS83fT6POjmetXn64cW7YNjPndkQzaAMZgfj7WyRXBvWja697
	tmGorEB5Ple04vUF7eIl/yqPFlXqUQD7yPbytsYgkYbSQLiV1VbKkzKIfkXpUJtJdaITnRxd7j6
	hw32x2UGPVahPytDVQKmGoXI42CiAF3vK9o7XoTmgOw==
X-Gm-Gg: ASbGnctdq0HSAJbSH74qIfoKyHEfI8ZdpveWw9/8D/BiX11m5S72ENyLowaRlOWJU0i
	tpfORclUu5c0pXvYgXYGdKWun9mfVHVtYCC7/eFNeMs9gNkDxjEyjVKTyxNRRxSztrKqEr31dEM
	wQs/K6Kg2E0eVR09qniTqXt0TE4SLil+tE5+EcEfANRCRQQCCIhTaFYIPV34qMO1s5YTf/YdlZw
	Kbo/nCLHJnrpO9USQ8=
X-Google-Smtp-Source: AGHT+IFfKLxV9tyzOQnEikdZaazb4yoGYzUJMKmsuTzVmQ83iHm/xqY/KhFL0iCqSoFlmWwQqKTl/pZIy8pjx3bEoRs=
X-Received: by 2002:a05:690c:9992:b0:71f:b944:1015 with SMTP id
 00721157ae682-7227656cde8mr166303267b3.48.1756895642243; Wed, 03 Sep 2025
 03:34:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701114733.636510-1-ulf.hansson@linaro.org> <97231ac9-5cde-49bf-931b-d5baf6d2d2d1@ti.com>
In-Reply-To: <97231ac9-5cde-49bf-931b-d5baf6d2d2d1@ti.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 3 Sep 2025 12:33:25 +0200
X-Gm-Features: Ac12FXxVFiRwM0u9ulXeQmiXI7_oecrVOWSFM0H3YtDXDfcwWKQ-S2uZTHsACkk
Message-ID: <CAPDyKFr8AYuS2aEVs8X2As1NzXnbea4rPLKiF5=fKjq=PAeZgg@mail.gmail.com>
Subject: Re: [PATCH v3 00/24] pmdomain: Add generic ->sync_state() support to genpd
To: Sebin Francis <sebin.francis@ti.com>, Saravana Kannan <saravanak@google.com>
Cc: Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@oss.nxp.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Johan Hovold <johan@kernel.org>, 
	Maulik Shah <maulik.shah@oss.qualcomm.com>, Michal Simek <michal.simek@amd.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Hiago De Franco <hiago.franco@toradex.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Sept 2025 at 09:39, Sebin Francis <sebin.francis@ti.com> wrote:
>
> Hi Ulf,
>
> On 01/07/25 17:17, Ulf Hansson wrote:
> > Changes in v3:
> >       - Added a couple of patches to adress problems on some Renesas
> >       platforms. Thanks Geert and Tomi for helping out!
> >       - Adressed a few comments from Saravanna and Konrad.
> >       - Added some tested-by tags.
> >
> > Changes in v2:
> >       - Well, quite a lot as I discovered various problems when doing
> >       additional testing of corner-case. I suggest re-review from scratch,
> >       even if I decided to keep some reviewed-by tags.
> >       - Added patches to allow some drivers that needs to align or opt-out
> >       from the new common behaviour in genpd.
> >
> > If a PM domain (genpd) is powered-on during boot, there is probably a good
> > reason for it. Therefore it's known to be a bad idea to allow such genpd to be
> > powered-off before all of its consumer devices have been probed. This series
> > intends to fix this problem.
> >
> > We have been discussing these issues at LKML and at various Linux-conferences
> > in the past. I have therefore tried to include the people I can recall being
> > involved, but I may have forgotten some (my apologies), feel free to loop them
> > in.
> > > I have tested this with QEMU with a bunch of local test-drivers and
> DT nodes.
> > Let me know if you want me to share this code too.
> >
> > Please help review and test!
>
> During testing on a TI platform, I observed new kernel warnings after
> applying this patch series:
>
> ti_sci_pm_domains 44043000.system-controller:power-controller:
> sync_state() pending due to fd00000.gpu
>
> These warnings occur when a device (in this case, the GPU) has no driver
> bound to it. The fw_devlink_dev_sync_state[0] in the core has a check
> before printing this warning. It checks whether the device driver has a
> sync_state handler OR the device bus has a sync_state handler in the
> dev_has_sync_state[1]. If both conditions are false,
> fw_devlink_dev_sync_state[0] performs an early return before printing
> the warning.
>
> Before this patch series, both handlers were absent for device driver
> ti_sci_pm_domains and the device bus, so both conditions failed and no
> warnings were printed.
>
> This patch series adds a sync_state handler for the bus, which now
> satisfies the second condition. So it doesn't do an early return and
> proceeds to print the warning.

Thanks for the report and testing!

Indeed this is the new and expected behaviour. I agree that it's
certainly questionable if those prints should be at the warning level.

We should probably downgrade those to dev_info(), at least. Let me
send a patch to see what Saravana and others are thinking about it!

>
> [0]: https://elixir.bootlin.com/linux/v6.16/source/drivers/base/core.c#L1777
> [1]:
> https://elixir.bootlin.com/linux/v6.16/source/include/linux/device.h#L909
>
> Thanks
> Sebin

[...]

Kind regards
Uffe

