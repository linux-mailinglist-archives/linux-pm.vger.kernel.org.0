Return-Path: <linux-pm+bounces-12153-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 080AF95068C
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 15:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849A31F22E9E
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 13:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804D219B5B8;
	Tue, 13 Aug 2024 13:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GWtT1jQI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B8819AD56
	for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2024 13:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723556036; cv=none; b=qyia5+5/SaWsdG1yCC0k0DX48wMwZZ51W7UxJXOnFe9rl4EFySajWQGYATVyLvfRPZCTaC7Gr7O2Cq3LJnC9I6qeJm9b0JUTLzvKMO2j1e1PU9uLlDMLQu38drLDqCRJrLe4KxRtpXhj4mlY1B3jpDjEPSFuc70lL9/33tx8EwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723556036; c=relaxed/simple;
	bh=0crOXTx4a8LlWgDmrDjY+EHQjOfDJ2AZ8e/l1yBHrDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GlfG0OfCQZgnSEg15tmlaKIBzN5RX+L2/8G/VYSqIQ1JRk81nM1SA7GCYUVTZdcizKx4xHQI9mLatoTl0Br8q44mBl/5IJFekrDFhtZGetZo/GAm++BNIKcF8i/nZB43hmAr7RUGO8+8bvy0FRVn/KH5qB3c74qt15cIfsaanlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GWtT1jQI; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e0bfa541c05so4783064276.0
        for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2024 06:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723556034; x=1724160834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0crOXTx4a8LlWgDmrDjY+EHQjOfDJ2AZ8e/l1yBHrDU=;
        b=GWtT1jQIy5AxLY0x3hZx1TcG6477yr2bQJbp8YMo59Xbmr/btYWmebOjbJ+3YbKcgJ
         bfldiO0JFlMRiMdqN2ofDrhJzxRlNfnvQbwHjdruLRGZAEuSM2TPlDq6yvUAYmb1CSVx
         nJGreM6R8uFqZCzIteOyg6NDDDGcyFqHbc5M6DahRhzGPwDB8sk9BO+W4NKhVL9UdAmU
         S+j2IdQp5jn4AuGpk4SPPNIv6X+BX5g/Egwljk/HFNiVSBJtjWuDSsU/Mzw+H1U/U1OI
         eIMFyr2xdH3J1KHrp4zpbShLTfscuHeAjsv1eKNgOWnoUquRyl4jol0HFGh3JS4dfGIg
         /QUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723556034; x=1724160834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0crOXTx4a8LlWgDmrDjY+EHQjOfDJ2AZ8e/l1yBHrDU=;
        b=DOJaZDL2dUXTfijbUP2Uu0fyGb8vYZ9v8aBbmqnqml00wLy1j5tShESuQLIajHDgfs
         iUMeksGzYk02Q1pg6ThAglYfeEuH/53+/qLAyrWB+IPUI2y9XMINGIuiysyoyiucw+8l
         +8DYowsiGPVhvayzjuCYGKsFzQJNDjK57n60cooVTlQQCE9SJHZwIkq2GuWNzfMA2C56
         rccsXo0OD8HMdPDh++pbu7e+zeZzLuVfTdVfYhXGAtcIN13Tpxsfob9OL8p0DDx5QA5O
         BieXD+u8RyNVSU9Hy5GTL2XggHRoUdBIDfUJUA1CxWCKVUEL08071e3XLcbYEwlBOoLV
         T5uQ==
X-Gm-Message-State: AOJu0Yx2o6NGO2YroAvQUubIjKDDDmEBA7+7iUH4d6PXEHbjiTwkdx5j
	LDOdQsasXFXBhxszaUlrncevPci+EYcFoUF/0Ymy1H/vywjnxXjdB+aOucSfv7zsknDhlys1Tx/
	e5hT/8GcMXacMDPJjb8TQLYxwbvtic2VGG5bc8g==
X-Google-Smtp-Source: AGHT+IHdeES8eEcxu5uKtvUwlh26T7DD6dQacN7o1MLYuvaviIQT/g26QrndD0AY4QWPe7cTAdBbVSJ6+xc8OrqrLjQ=
X-Received: by 2002:a05:6902:18c9:b0:e0b:b2d6:f551 with SMTP id
 3f1490d57ef6-e113d26c10emr4742724276.37.1723556033671; Tue, 13 Aug 2024
 06:33:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <LV3PR12MB92605C42C4B7BBA277395534E2852@LV3PR12MB9260.namprd12.prod.outlook.com>
In-Reply-To: <LV3PR12MB92605C42C4B7BBA277395534E2852@LV3PR12MB9260.namprd12.prod.outlook.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 13 Aug 2024 15:33:17 +0200
Message-ID: <CAPDyKFq-N71-g+UBve7qS_jFg+SW-VQxHkTBGFYjEVB+YiND9g@mail.gmail.com>
Subject: Re: Handling inconsistent power domain states with deferred power-off
 in device drivers
To: "Thangaraj, Senthil Nathan" <SenthilNathan.Thangaraj@amd.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 12 Aug 2024 at 23:51, Thangaraj, Senthil Nathan
<SenthilNathan.Thangaraj@amd.com> wrote:
>
> Hello everyone,
>
> I'm facing a challenge with power management in the Linux kernel, involvi=
ng the AMBA bus driver and the UART PL011 driver.
>
> ### Scenario:
> The issue occurs with a UART device, where two drivers are involved:
> Driver 1: AMBA bus driver (`drivers/amba/bus.c`) Driver 2: UART PL011 dri=
ver (`drivers/tty/serial/amba-pl011.c`)
>
> Here's the sequence of events:
> 1. Driver 1 (AMBA bus driver) attaches the UART device to read the periph=
eral-id. This triggers the GenPD to power on the device (`genpd->status =3D=
 GENPD_STATE_ON`). The attach happens at https://git.kernel.org/pub/scm/lin=
ux/kernel/git/torvalds/linux.git/tree/drivers/amba/bus.c?h=3Dv6.10#n141) in=
 the AMBA bus driver.
> 2. Driver 1 then detaches the device, scheduling a power-off operation us=
ing `genpd_queue_power_off_work(pd);`. The device's power-off is deferred, =
and the status is not immediately set to `GENPD_STATE_OFF`. The detach happ=
ens at https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/drivers/amba/bus.c?h=3Dv6.10#n203
> 3. Before the deferred power-off occurs, Driver 2 (UART PL011 driver) att=
aches to the UART device. GenPD finds `genpd->status` is set to `GENPD_STAT=
E_ON`, assuming the device is powered on and therefore does not power it on=
 again.
> 4. Eventually, the deferred power-off is executed, setting `genpd->status=
 =3D GENPD_STATE_OFF`, and the device is powered down.

Genpd doesn't power off the PM domain if there is an attached device
to it that isn't runtime suspended and runtime enabled. See the call
to pm_runtime_suspended() in genpd_power_off().

During the attach process, the device is added to genpd->dev_list and
in this case the PM domain gets powered-on too. Beyond that point, it
should stay powered-on unless the device that is attached to it, gets
runtime suspended.

>
> This creates an inconsistency: UART-Driver assumes the device is on, but =
it is actually powered off after the deferred operation, potentially leadin=
g to malfunctioning.
>
> ### Question:
> What is the best approach to resolve this issue, either by modifications =
in the genPD driver or through adjustments in the AMBA bus driver and UART =
PL011 driver? I'm looking for solutions that ensure the power domain status=
 accurately reflects the current and intended state of the device, even whe=
n deferred power-off operations are in play.
>
> Consideration I have is:
> - Introducing a transitional state (e.g., `GENPD_STATE_POWERING_OFF`) in =
the genPD driver and return error to UART-Driver when the UART-Driver try t=
o attach and let the UART-Driver return -EPROBE_DEFER to the kernel, so the=
 Kernel will have an opportunity to come back and probe again.
>
> I would appreciate any guidance or best practices from the community on m=
anaging such scenarios, especially any existing mechanisms in the Linux ker=
nel that can help.

I think you have made some mistakes in your analysis, can you please
double check to make sure what is going on?

Kind regards
Uffe

