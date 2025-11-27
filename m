Return-Path: <linux-pm+bounces-38813-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EE4C8E93D
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 14:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C5A64EA559
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 13:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358662D8376;
	Thu, 27 Nov 2025 13:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Mqi7wt8o"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56674296BB3
	for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2025 13:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764251248; cv=none; b=TfAv8YRvFrfInik+mcb0ebaTLQ1/+5gfAVmbx1vDSVuzKo1m3TnOL7EhgWKDAKI9PGDBADYVLnP+bAVaUN+X9apmSK/g07fAPe8wY5e54bCigEiow3njFKkU1yXlTYZllLPJ7IBRtCAwCIPEkldaOEl4bHxqwdNPNmfYpLBSgjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764251248; c=relaxed/simple;
	bh=27yd/l6012XaQH/g8Ixa+D6cMcVdfn8d9/IVn2JOVCI=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IChJOKx1oUMxnzmqjS4zeRcAZFzrqjZz0/KlR7AiS8ksBDX+fRYkvyUKI9E9p2SwFakoEL39tEp8pZKcpxTmXGX4RCXm6CgcY1grbuTXXaC3TjL9muF9AQov2FRM5PyfMM9G6EukKiNkemodRS7oImDGMZCrom9nUs+pAX2/C9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Mqi7wt8o; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5943b62c47dso816032e87.1
        for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2025 05:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1764251243; x=1764856043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:in-reply-to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=27yd/l6012XaQH/g8Ixa+D6cMcVdfn8d9/IVn2JOVCI=;
        b=Mqi7wt8oNrr+2+e4XNhQBFHjbbJlNk2prXtZZdeiWDpubDuSNPjtqVuc6fFI7gQTNW
         vlhDRF8Ikv07ZhquMqzkqlRbUqUBvhhznOF0yf+VzMxYMKnOLOCd6txDRXhkTGnAwFfn
         9q/AFxkcnrl71n9rhoZuu/08jdMh/RFnG0Cl63G8H+FblB9m8ujHai9LfGR+WngJj2Dd
         TjMLWQA1KgMyWpako1U/QHpPDjlp8y4V15h620/0cvt4YsBCRXEygHzP/Lbbhj6NIsYB
         DsZitljR6hDpZnbRH3U5UlgO5Ha0pWvDDCPBmOt/Z+Dos4I7Or/n2AinAFdgzuAfJvVY
         hiLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764251243; x=1764856043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=27yd/l6012XaQH/g8Ixa+D6cMcVdfn8d9/IVn2JOVCI=;
        b=qlwOWJHKBf9tBEH5r3Zf30d7PYPx2J4+8uZMFxPBUV6LEQ6S6+s+uakY6j4Osi1Xo7
         vSTSm2xDk1iLcgCynb1+X9R5lqX3CFPctRvwpKaqUcTdENwt3tttqAAMZIGAhnuINILp
         TTJcuZQ2wKvxJ/jXLMb1NVeNvMGSVwZ0/F10vvFTCqbm7SjEAn94o/GvNOKCmAezgdY9
         T44ZCRlIQEWpql2C/mDirrpwGBQ9GMyAwF/EbNmPk5U6HfsM00lE/3Nw9Zg+EwuV+wtT
         9M+JXmEdYAQV43BQJvAlu3i768Zu6W1NCzGb1wZ0fm8LdRv7BtmzP0Y89gt8ZTc71+/B
         +3ew==
X-Forwarded-Encrypted: i=1; AJvYcCUCqVtasKX0s2uzOqdYfxlcZVi63Kv7IbpQo7WPEBhA/qhdzO38DJg66Ibtnob2IXeionBsNxsOdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwajrpFKZXW2kY89wnZwtCf144WArnzu4kOiN6qs7xRnmAkvGVD
	hbirC3mOAW7qOk4HjkbFzUEpJDpRixGBcIcvoTbpeQgLsOWdVhEIcvp1m6GuekyMmvW0d5x1s0A
	4yotxU/9bYeYj2BAuBkFv+IO9peFesRgKiChSV1Gapg==
X-Gm-Gg: ASbGncv7zodJlxJ9mry9R/yDLp4p4e5uynMO0FUIjW0xui30ZS+cNqvYwTicMDlgDb5
	i8CrvCwY/sFKE0GtuHcV5UwlY1Nv+DGuC69eiEdIVmntQFOUj6NY/gf+QhbbWHh5Di+G4FURrqn
	iPE0iTbAyjFzPsRrA/oyKROm8EF1sJ4X48GUED1Is1NG0Lbolb6R7tJ12B2Reqs+3dAk+k8KN4O
	lnQhWEJehadsv+nH535GIfBA/a1+BwGihH6UX97dZB9Akl6EESgw4yfYagOusOVyx+9lzfi011V
	Q3Mxc5KQaLEkPz5HoB6cJXZsJpM=
X-Google-Smtp-Source: AGHT+IHIByvzTN9XhwquV0dZ7CSOzT2wtZW2aRAexw9uGkGjWx9uXnsQQnkc0lHm6G8MnJ63g3o+AbKWIIpqZ/ETI6E=
X-Received: by 2002:a05:6512:2354:b0:594:36b3:d1f9 with SMTP id
 2adb3069b0e04-596a3ec4221mr8118131e87.25.1764251243268; Thu, 27 Nov 2025
 05:47:23 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Nov 2025 08:47:21 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Nov 2025 08:47:21 -0500
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <20251125-pci-m2-e-v2-1-32826de07cc5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125-pci-m2-e-v2-0-32826de07cc5@oss.qualcomm.com> <20251125-pci-m2-e-v2-1-32826de07cc5@oss.qualcomm.com>
Date: Thu, 27 Nov 2025 08:47:21 -0500
X-Gm-Features: AWmQ_blvAAM2uq578ciPVCG4M9rg3fVM1qAGhRvJTTtDZYm9qOnYz1mkG_i5iVY
Message-ID: <CAMRc=Me+mWYaa4ZKTmch-NtuvP-2ifbY1Zwi9E9KMyUgFSt0fA@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] serdev: Convert to_serdev_*() helpers to macros
 and use container_of_const()
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, 
	Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Nov 2025 15:45:05 +0100, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> If these helpers receive the 'const struct device' pointer, then the cons=
t
> qualifier will get dropped, leading to below warning:
>
> warning: passing argument 1 of =E2=80=98to_serdev_device_driver=E2=80=99 =
discards 'const'
> qualifier from pointer target type [-Wdiscarded-qualifiers]
>
> This is not an issue as of now, but with the future commits adding serdev
> device based driver matching, this warning will get triggered. Hence,
> convert these helpers to macros so that the qualifier get preserved and
> also use container_of_const() as container_of() is deprecated.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.=
com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

