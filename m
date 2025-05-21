Return-Path: <linux-pm+bounces-27470-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E46ABFDF0
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 22:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 150033B1AAB
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 20:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBD629C354;
	Wed, 21 May 2025 20:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJYghkv5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A9E29B23A;
	Wed, 21 May 2025 20:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747859627; cv=none; b=APxpas0NxZM3WtNO+OE0/y9cwwnk4GcxFYH7OptcfvmZRAkPmvf+xbOQWim2MEu1TiYG2JTTMpqRgoDchpQLFmOwfoJnW4ipBP6vKXca/2MZPsMHpMOdyKYdwwC96ieS4G/1HpD/Q858nNLWU7kPSTmTgzUhFQZlUhQOQtG/Ki0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747859627; c=relaxed/simple;
	bh=eplGAvxyoXI1rViV7xw/TI7gP3WPlb9z385p5izBJ7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XLpTH8aBAVG8hwVk0Agm28JkPDruJaAAJcpZMLxlfI0t/pI9Cwf7ZNsVQ7YoAT1tba3eL4IJuZrWh3JS/vT5O6I18ddQumeTBZuaKhsg0xhYMtAudBXAyPZVDIJ9eANm9j+dq7udj4gpQnpvuAhwMVqx2aWR3vSuG8Ez6Ef8qJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJYghkv5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32BB4C4CEEA;
	Wed, 21 May 2025 20:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747859627;
	bh=eplGAvxyoXI1rViV7xw/TI7gP3WPlb9z385p5izBJ7g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SJYghkv5zj51OC1SL2jQENGuzs3sjIlrvFMx9kRgB0yybB5911spfSs4dklnxuG3N
	 QdNTFDwCnOlLq3+g6cZvSv/Z1olYwWHFZoiSXjfCuW6aTtq558cEiibmiEGiChmjqd
	 SwH30+GVv1pjhF/49wisJ6aW+xIMZibCse/O12FglZ0RaOVw3mVQbyViOo2lvrO1Ee
	 LM+/C0KFySxtNf/h4sEZAkKr3S1bT8X9nZVj3sClUBIBpiqaVUssbBgqNZA+Pm+Kww
	 nsQVgvJo1aXCDgNmosJ+l6UInpNARnZlFhKQtwyfsfUWizLQmahOXi7Sf9coFHPPRP
	 K+bFtT9RQ0acQ==
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3f6a92f234dso4849918b6e.3;
        Wed, 21 May 2025 13:33:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUV6WgriRshWHn75QW/OOdHg+lJocBun+MmP9D6Xsgj9qS8Tx7CS95TN0wdd878+ACwZUMa0pkwCfw=@vger.kernel.org, AJvYcCV0UoXiA8FVTqRXM9Pm8o8ukZ9gO0QKZ9lMV4gzES1Qj+QbWisIZIr9bCug4+fdl3gQ+vh3dlZVtAPZWaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxechZyDSbnm6qBeaqYwTVaSGhZGq1K4YJv63gcMNVzY9emf6Gw
	Pb+kmJufYd6eC2oQ6NNI6vy/97pEdukufizlEl/aX2e69Ph6ckGaEGzZMeQ0jtBknm1+f1FeviP
	wVmpNHbAb8QCg25E+7w274elPKVNboTI=
X-Google-Smtp-Source: AGHT+IE0hYjDzV10n3z2mF4z2bL96DKCbpbqLmh+wpb0MmeqRkeoKX2ztOe/49bSzkVzCdaJoI2fudozJFfiqslfH2k=
X-Received: by 2002:a05:6808:6b97:b0:3fc:1f7b:c3b3 with SMTP id
 5614622812f47-404da7b8d69mr13078378b6e.33.1747859626474; Wed, 21 May 2025
 13:33:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519070938.931396-1-yubowen8@huawei.com> <20250519224648.41f2460d@pumpkin>
In-Reply-To: <20250519224648.41f2460d@pumpkin>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 21 May 2025 22:33:34 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g-+Wgkm6V2T0c47sEw0Ow3QCBJnFSZJdLiNy4zW5uzHA@mail.gmail.com>
X-Gm-Features: AX0GCFuwkczzCQhZPcdTl9q5nE3CqXTvy29sphTXf_51BdxrL0eCDwHk5FrvIDA
Message-ID: <CAJZ5v0g-+Wgkm6V2T0c47sEw0Ow3QCBJnFSZJdLiNy4zW5uzHA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Update sscanf() to kstrtouint()
To: David Laight <david.laight.linux@gmail.com>
Cc: Bowen Yu <yubowen8@huawei.com>, rafael@kernel.org, viresh.kumar@linaro.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	zhanjie9@hisilicon.com, jonathan.cameron@huawei.com, lihuisong@huawei.com, 
	zhenglifeng1@huawei.com, cenxinghai@h-partners.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 11:46=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Mon, 19 May 2025 15:09:38 +0800
> Bowen Yu <yubowen8@huawei.com> wrote:
>
> > In store_scaling_setspeed(), sscanf is still used to read to sysfs.
> > Newer kstrtox provide more features including overflow protection,
> > better errorhandling and allows for other systems of numeration. It
> > is therefore better to update sscanf() to kstrtouint().
>
> This is a UAPI change.
> Since the value is a frequency there could easily be scripts
> that append Hz to the value.

Which would be incorrect because the value is in kHz.

They are not expected to do so in any case, though, so hopefully there
are none, in which case we don't want any to appear in the future.

> You're making them fail.

So if there are any, we'll get to know.

