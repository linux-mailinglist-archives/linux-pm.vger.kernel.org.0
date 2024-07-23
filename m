Return-Path: <linux-pm+bounces-11340-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E90793A318
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 16:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9AC41C20BC4
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jul 2024 14:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39C0155757;
	Tue, 23 Jul 2024 14:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wNLoBGfA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6156C15573D
	for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2024 14:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721745890; cv=none; b=bQe2ETKd+vBGS6agXFPVhhjwei2LjPyGG2SshJFGNfJdf+eOvVZ0z0sFPmnd8danySNSU+iqq6fIRlTDRI+G1G4SXCZJrNtKeDd40gkLY5CcvNLfYyr7MWN5wyhzFGcl3Glq/Yd9imWkkiLj5ZUvnbVr5c3ZJ22FGbfcCmJBu4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721745890; c=relaxed/simple;
	bh=/DhszLUQm78wMoJ8KfR7NpJ/TCjeTVmSlYGYshTQDR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PR1yLszPYqpXWuuaJ3stXRh9JaKaCn7imC3WLh2CbuouVbbCNCR2gafATZ0XpfjdemuJbCxYar4ciwHdZmaeCPd/FYII2hTmwE9stpqzHTh92y7SdTttvbKcalpIGbBqUGJfjDT6ZVVxbvVxxqB22aok2UL2VE7Gdus4N4KU/gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wNLoBGfA; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6659e81bc68so57690207b3.0
        for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2024 07:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721745888; x=1722350688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/DhszLUQm78wMoJ8KfR7NpJ/TCjeTVmSlYGYshTQDR4=;
        b=wNLoBGfADIe/jSTAwATqYvqBwNRF6FQQAzIXRfgsRxSE2HG+soZGkdnHP89cNSsVpk
         y7mnNCGneMpwQmwDfANAu6ZwnHf+rdBUpb0/wRwae66U/xyvu1yf3J1/ahTziaYHrPOt
         Kzy4bjq/bOyrGHr/n5HxAmh85T32b04M/J4+sPbeYEMALCEoO2Xgg9alk3Pzm6+4/YHk
         LBJo58HtdvYGL7n6Im/jAfTuUC5wYWdTJVDc8N+k5EhUsYqoM3jmlR0LqeDrH8kU1CL0
         AQ7qdUa3WWkT+LwUprQR80lFn1arsuaBHqHeE7q/gUmPJi9U0SkOz9QELTIkEWa4PTqA
         AEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721745888; x=1722350688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/DhszLUQm78wMoJ8KfR7NpJ/TCjeTVmSlYGYshTQDR4=;
        b=j4zuH/7MoWFyn7j8w6kLRXl5lbaj7E3KfCrwiGxM3ZwXgOR5aawJ5TZfUk9T6/2WeC
         WU2rQ/MfbJ+o88sf6ryEMnuFO6fOANUyJN4vAvOheALcaUnjJwaUmkPHDSqDUXw8lzzr
         7gN9Qp9I/FyZXERHh+bfMY9gNf6eULnMmJp7Nfy5VbfFPC6jNv7LmdHyJa+kIed/zpGP
         59J70Vxs/+X+B/lVKB2DPUDt/tQ9kjRw3fPob+12+B7s4CgWIUNLqHbBkCwNUt5ojv77
         rzlo9p3rjwq5BzRk9/lknnBxg8bsZ9FjBFHRPz8akNerAUO/n/62XYX/Qk8RVAv39WWI
         lnSw==
X-Gm-Message-State: AOJu0Yy/OOCjb2c1NTiLdhJoBLUn0bvBVL3hY/M0X3I5FjgYdbwfaBHn
	Nm8RBBki8poZRutqm0NvqtJ49eQavDRylI6fozyKo/Dmslzx1JKIh5EBtZFEJIfHCp7RGi8WNjt
	LEmCxpPTz3itudNiZ985rIprXA9U9AbysXZz8Rw==
X-Google-Smtp-Source: AGHT+IFGjfjFX/FJh03F1MKKrGFIVaAs0XDkGFgTDf72tmLxkemD7JLVTcN+JvnaLeLNBvOdMegKN1zpNtKOUb737uw=
X-Received: by 2002:a05:690c:10c:b0:627:d23a:4505 with SMTP id
 00721157ae682-66ad8309fcfmr141173287b3.3.1721745888405; Tue, 23 Jul 2024
 07:44:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240723141654eucas1p2deadd470e2ceda1601042dad4acfc17e@eucas1p2.samsung.com>
 <CAPLW+4m0xG5yHOT_ucGdrOhLZvjhga8caqHQZmVH6HHKUnBgkw@mail.gmail.com> <20240723141638.374742-1-m.majewski2@samsung.com>
In-Reply-To: <20240723141638.374742-1-m.majewski2@samsung.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 23 Jul 2024 09:44:37 -0500
Message-ID: <CAPLW+4nYfVytXnpDs02QQGms59dL+=pAv7NMNPK6Ymsemmi_cw@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add initial Exynos 850 support to the thermal driver
To: Mateusz Majewski <m.majewski2@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 9:16=E2=80=AFAM Mateusz Majewski
<m.majewski2@samsung.com> wrote:
>
> Hi :)
>
> > Thank you for the contribution! Did you by chance test it on any
> > hardware, perhaps on E850-96 board? Just noticed there are no dts
> > changes in this series (or as separate patches). If no -- I'll be glad
> > to assist you on that, if you can share dts definitions for E850-96
> > and the testing instructions with me.
>
> I did test it on our copy of E850-96. I used this for testing:
>

Good to know, thanks for the detailed info, Mateusz! Just wanted to be
sure it was tested properly and my help is not needed. Btw, I'm
curious what is the reason for implementing TMU? Do you have some use
cases where it's needed?

