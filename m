Return-Path: <linux-pm+bounces-25680-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4102FA92EFF
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 02:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB99D1B6335A
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 00:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFCA224F6;
	Fri, 18 Apr 2025 00:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EsmQukaM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594388836
	for <linux-pm@vger.kernel.org>; Fri, 18 Apr 2025 00:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744937657; cv=none; b=ndpnMkYZRvLurjiIjBs7wj5atA4A3SFgI6uiDHDFDHZN4bpJtvNq7RwUmxMK0H33JBXnFNQjcgV+9tWPzicF5VJEmuptQUkBNn7nH7obvNcgLf6/4iypajNWrgvdTPyGdghRaBMD5DLZUHtQxudZX5E40btOHirN+oJ6+gL5VSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744937657; c=relaxed/simple;
	bh=kYw96PJDZxr1gtwXp/xI+3EWhFmokKT4Hr/AtyA3lAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EJIk/abf+Q64Fbx5FB3Hk1GckivatJXDsQwzHT4aSdykPrKkUSXy/0c9mD0e5dNofl/HGKlPZF+nSYVk4QMiEYSKKcDPDg56AcCAzwGfmItCFQukbHf/0Fxo97qvvsBxcfpVaR85uAga4ZkSiDi9hKt5LohXGgJv9ZQ2N1WOpqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EsmQukaM; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54b10594812so1487077e87.1
        for <linux-pm@vger.kernel.org>; Thu, 17 Apr 2025 17:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744937653; x=1745542453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7v6a64FwreaJA0pCAKVOqC5CViB7StYRn/BcrMkSKM=;
        b=EsmQukaM/yx+SlqeXxgDNAaNfMRfKcG1hh/W4CEAdUGfwRIMqnLA4Y7/czczNqHoaV
         q6BvLDjY9S9p0m0wWpcqyC1exuQ4gSIB/2aqnt4adrt5OQrbnTZBNvAlFLbxlwMj0DBj
         z4lUgcBxthS2Rs6XfHOD7QAScm62ynGsHB3Vw4fYAGVRjq1VrENtajhDGl/dwLMqnfiB
         ZZUuSHoUcm5ya7tlcMx1CTtOlTIcjlg+TtC78getfOh7UgXD4XOo/lbd2xZmraj6CiY+
         5pnYKcKz1eOka4ePN4u440D2t5LQQstRCKVTAJL54AjFJN++H/3JX/SY8GuZvvefRclA
         +g5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744937653; x=1745542453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7v6a64FwreaJA0pCAKVOqC5CViB7StYRn/BcrMkSKM=;
        b=IyUOUU1WjzkZXHkL4It1h5sdx5iAcf8xVxEojiqRcBPsCeadUCN0KW4WEf0yzyVkZf
         WDCgIVU6QdtjtKaM4VUgZH+Y9bVRQculUwfpVbO56Pg204mMonQg/X1z0jTnc86BZRcr
         3eeiS6f34L89afKsd3LZsrS0uLdZ6pS4BH4LmXj8PHCk1fsU0pyOiJ4LabKle9B1QDYb
         OYkaBvUAo2Vm/KBhd1vehXTFo4CigAPCFliSv4hz6LJsenAVNJzqT5s2TDx006ulrt7D
         PD297mCphLbf9dV6T8F6GA/D/4nUV0jb812jAXAhfdWRMlnl4ergG9Dw6C2YD7O1RxPu
         Bjgw==
X-Forwarded-Encrypted: i=1; AJvYcCWnvM3GIY0iRR68LMrSO5H0PDFVMVP/YvqTbVoTRojIN9yfQTJ00yWYg9Nxys3QHaagp14ZFRqkqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxpTiTdCnGMHJj5n31vdgAE0VFu+IPWrIuxTR1y+XuWpsj/bok4
	1Vy48IH2iP7vIuQvDOK1NE+On/xH67JeyhAiytdAoT6URtMnuox3meX18XPdQ69R3xvdOVdVJt0
	97AdIJya1PalE5a7no2FaDMDQe2F7vjYknr4n
X-Gm-Gg: ASbGncsG3riWB2khtqS/iNVMGi/H+oAZXGIpeFhS08WAsxM6h5Qo93vklTFxh3KBQbW
	6E5DVNXzjHHVXNzNbIg3xMz023ypL8WYPRALhGDyA+MV77NX2MXyOJFpYv7dFFE0XLoU5zARmjA
	O21Bd8Ve7YUSHZs/lW0tM3CHU3R7v5dSQJiIcMaowR6C+1e4g=
X-Google-Smtp-Source: AGHT+IHUdZc5HDjrZYA8LWyh9msnR6W71lP04fz39bJlOI9JeLCz/9ra+wyxcFCuEbg77rntJwlmJg7XBKEi694wwtw=
X-Received: by 2002:a05:6512:1045:b0:545:2d4d:36de with SMTP id
 2adb3069b0e04-54d6e6352a2mr234675e87.31.1744937653242; Thu, 17 Apr 2025
 17:54:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417142513.312939-1-ulf.hansson@linaro.org>
In-Reply-To: <20250417142513.312939-1-ulf.hansson@linaro.org>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 17 Apr 2025 17:53:36 -0700
X-Gm-Features: ATxdqUHzOUVh8E2tR73MoZ4FAVpBQN57AXnmN-9HADX6gA9CnvHoa6p8qDTye_I
Message-ID: <CAGETcx_=hEuOs09=gRe58+34PFa0bfsYoAK9kYOn90FP5nDjmw@mail.gmail.com>
Subject: Re: [PATCH 00/11] pmdomain: Add generic ->sync_state() support to genpd
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@linaro.org>, Devarsh Thakkar <devarsht@lewv0571a.ent.ti.com>, 
	Peng Fan <peng.fan@oss.nxp.com>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Johan Hovold <johan@kernel.org>, Maulik Shah <maulik.shah@oss.qualcomm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 7:25=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> If a PM domain (genpd) is powered-on during boot, there is probably a goo=
d
> reason for it. Therefore it's known to be a bad idea to allow such genpd =
to be
> powered-off before all of its consumer devices have been probed. This ser=
ies
> intends to fix this problem.
>
> We have been discussing these issues at LKML and at various Linux-confere=
nces
> in the past. I have therefore tried to include the people I can recall be=
ing
> involved, but I may have forgotten some (my apologies), feel free to loop=
 them
> in.
>
> A few notes:
> *)
> Even if this looks good, the last patch can't go in without some addition=
al
> changes to a couple of existing genpd provider drivers. Typically genpd p=
rovider
> drivers that implements ->sync_state() need to call of_genpd_sync_state()=
, but I
> will fix this asap, if we think the series makes sense.
>
> *)
> Patch 1 -> 3 are just preparatory cleanups.
>
> *)
> I have tested this with QEMU with a bunch of local test-drivers and DT no=
des.
> Let me know if you want me to share this code too.
>
>
> Please help review and test!
> Finally, a big thanks to Saravana for all the support!

You are welcome! Thank you for getting this series done! Happy to see
sync_state() support being added to another framework.

I skimmed the series and at a high level it looks right. Not too
familiar with power domain code, so I didn't go deep. Just reviewed
the fw_devlink and driver core parts of it.

-Saravana

>
> Kind regards
> Ulf Hansson
>
>
> Saravana Kannan (1):
>   driver core: Add dev_set_drv_sync_state()
>
> Ulf Hansson (10):
>   pmdomain: core: Convert genpd_power_off() to void
>   pmdomain: core: Simplify return statement in genpd_power_off()
>   pmdomain: core: Use genpd->opp_table to simplify error/remove path
>   pmdomain: core: Add a bus and a driver for genpd providers
>   pmdomain: core: Use device_set_node() to assign the fwnode too
>   pmdomain: core: Add the genpd->dev to the genpd provider bus
>   pmdomain: core: Export a common ->sync_state() helper for genpd
>     providers
>   pmdomain: core: Add internal ->sync_state() support for genpd
>     providers
>   pmdomain: core: Default to use of_genpd_sync_state() for genpd
>     providers
>   pmdomain: core: Leave powered-on genpds on until ->sync_state()
>
>  drivers/pmdomain/core.c   | 273 +++++++++++++++++++++++++++++++-------
>  include/linux/device.h    |  12 ++
>  include/linux/pm_domain.h |  11 ++
>  3 files changed, 249 insertions(+), 47 deletions(-)
>
> --
> 2.43.0
>

