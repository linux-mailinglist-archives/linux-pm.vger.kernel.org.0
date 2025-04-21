Return-Path: <linux-pm+bounces-25771-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CFEA94C66
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 08:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 752FF3AEAF1
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 06:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AEA20AF9A;
	Mon, 21 Apr 2025 06:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROQk3gyZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03FC25742B;
	Mon, 21 Apr 2025 06:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745215669; cv=none; b=Fd3fhkJ8guRTllIycU+m4UsqKCBS9e4VJZ7mj4hXSBsrTAFVUEgkjkjFAa5RVf8OeOfdjSzIK6M1ngZwjWWd235Pijg5y+rZdKVdg0ikjyhkXzyf+U7uuY8xN4IBqoWGbjSCyfmx7HVYPjZYCCIOD35DRkc9tEWAE6i5y4L1cAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745215669; c=relaxed/simple;
	bh=0G0qtCrdJU3R3LaRw8xxHSCrpQEZS8ucNHMTc5ZfEfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kSmP9I2fTur+6zVQf6CFKlEsQFcv5Cr1rwhvu7f7UenpzSEBVWeJSTdCs85P4A02p90WVHLyBjZ9skCXRHrKWtO21X3UY8EGq/VktiqwyZwaXREHibKT5ynJX3o8obZRfGKQFqCUlpgwtq144FPcJWRPRs+/urDxyL6DfAMkSaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROQk3gyZ; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-548409cd2a8so4946680e87.3;
        Sun, 20 Apr 2025 23:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745215666; x=1745820466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0G0qtCrdJU3R3LaRw8xxHSCrpQEZS8ucNHMTc5ZfEfQ=;
        b=ROQk3gyZkpvxqo0dB11hkYrvBoiMGj5IG717em6nzPpLQp0g+IFR8/gGtyZ3bnUfCW
         di8jdYjsJfd0RTUxp88Jij/SQiTA1hCSnhAMMFK9aeknoCj6zyZafqBBuaB9qVJ1KZwU
         DGfz3Gb3cKe7rb/7uzNbpleJJfYAUrFlb5tx+58jlmrEWuSNS4H7ZxZ2CYsloT2GGGSm
         UE7uAPH3alOJkLQXmxsmCeIb19QXG+Z8odmVuQCs/2oXQ8Ey4YGEVreGHsO1MhKLcHZf
         A+h8+XZRlmNPYNDn8fwQGuDOSnhy53NOpLEOVyftcx/FvAqK0cxsnE99LnhRRr09RXsL
         o7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745215666; x=1745820466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0G0qtCrdJU3R3LaRw8xxHSCrpQEZS8ucNHMTc5ZfEfQ=;
        b=kEqqsq6WMnL9EOY6TTW693A36eIsQfNiZeG/qPzMi2u+87GlN8U7CJD9IYfmI4iuSE
         1i0iskSOsheSc+3eaBP5NnQ6GGXSHfLyBPvILWqEnKcD5i001M/dg0DDhd/bQ1NOEcdY
         MGfK7Tx7GWCP6fJOShFLplX0YwaMc255QTfP1xu1q9o39CbGHI4Y1CMxSHTrekOH5NVF
         epvnhtHvfdwaYXhszfs5RtYhN+vvir95YzCIdnCfAPH9y611gywgsD1KP/GRESjE9C0Z
         n09+veomjaCDCWcjtRBX1yORfLmz1/itStZSjRjHlYxUWqKwqCFxKLgeumkGYFdF1Uei
         PdHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3SXqddn4QZdCENKRF/Lv9A0ToesGiS+MnliBIq3PwS134p5jyOxkRkKoMspPhLfQffGQNjvMAOarcqb0=@vger.kernel.org, AJvYcCUgrZ1LehNIHDQXyJKUuFPPRSEYr9pyJQH0RliIxOQoYMMOftkDhnp0laZsj9C7rUZuLCpyHD2if3M=@vger.kernel.org, AJvYcCV4NYYBz8iT6IGsi0Avbha8cDP27dNoyzlKucCWZE1ZOPSsWB6g+ltBEb0LNRpe76XqUmkGvjvUMlynlj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwowVLJIzDyTjs9wocb4wr/GkHzE1ebhYfVeb2+AU0ndlPB/TO1
	yfDg9Mc6Vyry8nHKtldetSSwMuM8B2Chas7AvFkKjwohnmkBWcKGFxGKigPuPaKmSnCDuiy8PPC
	HsHHzEnkAeiG/Y/f3dHKkFXDr5CU=
X-Gm-Gg: ASbGncvIg79Z3B2CW8aaoiIqTDvKZgp4vrBDBAyL9EDYjbVsGofgRaf7wHOKgcOaf7D
	vx/mk6umCVGXROHdGpfOykk/J2hS5wigTl90S6bSgCoZvn+pZGXwFNl2ZaDgSDekrKED3HhKb1U
	as3sfTMaKJCtVIzICQtmQshQ==
X-Google-Smtp-Source: AGHT+IG/Av/QKmMIbq5pRY7GxDjyRhQyC+/4TYuLc4CygcpMyqa1lVvtO8QXV456oVMtLA6XkY6fXKtic5JxbrDhALM=
X-Received: by 2002:a05:6512:2254:b0:549:b0f3:439e with SMTP id
 2adb3069b0e04-54d6e6275cbmr2409676e87.19.1745215665592; Sun, 20 Apr 2025
 23:07:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250420-tegra124-cpufreq-v1-0-0a47fe126091@gmail.com>
 <20250420-tegra124-cpufreq-v1-2-0a47fe126091@gmail.com> <20250421054555.oavale3xjqlrc236@vireshk-i7>
 <CALHNRZ-1XfbN8nOt33Ktsq9z2cjGL8AiWKEZwigXO6OYd64fFw@mail.gmail.com> <20250421055808.ol4bu3vsdphv4pvs@vireshk-i7>
In-Reply-To: <20250421055808.ol4bu3vsdphv4pvs@vireshk-i7>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Mon, 21 Apr 2025 01:07:33 -0500
X-Gm-Features: ATxdqUEG5g-3C8VcEnce3OxdDTjuIjX3fna825GYgk-HqO2wejR75SaK8xuvaf0
Message-ID: <CALHNRZ_abv1P6o7sf9qCjUpOhYCNV1Ms3vr-zAUsX-QgWePu6Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] cpufreq: tegra124: Allow building as a module
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 12:58=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.=
org> wrote:
>
> On 21-04-25, 00:52, Aaron Kling wrote:
> > lsmod lists the module as "[permanent]" and if I try to rmmod the
> > module, the command throws 'device or resource busy'.
>
> Ahh, I thought kernel will give error on double insertion instead. But
> it looks like we keep some sort of refcount for the devices registered
> by the driver and don't let it unload.

This situation piqued my interest since I was unfamiliar with the
permanent flag in lsmod. And I found this stackoverflow answer [0]
that explained it. If no module_exit is defined, the module cannot be
removed.

>
> Anyway, if you want it to be a module, then it must unload as well I
> guess.
>
> You need to do the reverse of tegra_cpufreq_init() from module_exit to
> get it working I guess.
I will look into adding an exit for v2.

Sincerely,
Aaron

[0] https://stackoverflow.com/a/33464275

