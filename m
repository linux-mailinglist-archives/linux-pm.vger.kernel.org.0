Return-Path: <linux-pm+bounces-38772-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B530EC8D77B
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 10:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B3FC84E72F1
	for <lists+linux-pm@lfdr.de>; Thu, 27 Nov 2025 09:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C113271F6;
	Thu, 27 Nov 2025 09:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="WYFUaeHT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CF832693C
	for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2025 09:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764234891; cv=none; b=ZHcabYf5WXPvvPvNIo7UpzM3yyCItyOOsZ+BEGHFVoKhzyO+NvB3DNkFcVQCdNcSpZrZlRR7cjKXaMaVLULhcPYxsFbTD9i/Pvldx1RwNs4aDRyEGn2U9Pxn1jppOBs3/s0WPssLlBZJRCtdv7zbHqg5Uype5WK6HvG7vdpkmJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764234891; c=relaxed/simple;
	bh=X03jox/gV8bqLBLEBTR625O9w1oSc+eeKS2ioi2DhKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jNUKZ9Vm4oTs2zKtUpnPhOCKMsEqVbu3e1YTIH04CEmQKb1b83jrePJ+1AqdwYBEZegkRsvoJWPyurG2/1BgBMrS50sHmw5PpvEf5QXhbdEEhiB7FSznfPn1NYNiVlgJMHABORIvrF76j603piUto3vyyJhPoY5gbOt0uNHk+i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=WYFUaeHT; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59583505988so825235e87.1
        for <linux-pm@vger.kernel.org>; Thu, 27 Nov 2025 01:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1764234887; x=1764839687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X03jox/gV8bqLBLEBTR625O9w1oSc+eeKS2ioi2DhKA=;
        b=WYFUaeHTCcZh99fNLyg4ZjCVWMHQInJ4eA1K7+hq/WQJjQDsK/MkEK+wSVvyqeuXla
         KQa1t3ugiAEhdhvw5FvDcYQF8hkf+S9JRACEIlFnj3VNJmxNFmVmloBvRI9XUUrMNNfO
         NmPNMA4MP0Rw/2YFqK6ctPM4s19cMSCQdeQgtQMihpOQsIDy96B/KeuwAEo1tirvPgTB
         pAev8SvLVNCUeU227JfrXqZ9bW0ISv9TY3tN8kx3JZMvbUwnG4hz8CC8GNCYSqsMUPVm
         4p4cqX3cEnv8LNJgZ6I2AGQm235EbNo/jgAtE2WSpViVqhBgk85pcb+xn31/dvq+fQgL
         1yhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764234887; x=1764839687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X03jox/gV8bqLBLEBTR625O9w1oSc+eeKS2ioi2DhKA=;
        b=xJZU4iJ/LlzTVYKMteFx3xuMdj0PIiYrRhPjdT67Odux3F4yuR3nr1xolf2Sqze2NE
         PNmnHU43ctJo5PaVk/s4BcQXV2r5kkFmllBYn4r9xy/TpLV0w8fuXILlfabkfydjt5Z2
         k/Ef4icsYbK10NVVNn5w2YckaOZjzheJUJNvJtWg6m27Dyn+VdlL6WPAaM1T5MUkwFLL
         t9ivIY/5m6M7hyLY1eiTqQU7pTP35IOV4egK1BX46gErvZgpabpad+6fdVso8VW5E2aB
         ibYFv9Xz0DStko1JJLFTDrmHsgZyEquMyyXtR/M2y4bpZ6pUAiaBPeGwDTm5bkxbGzWO
         0a+A==
X-Forwarded-Encrypted: i=1; AJvYcCUshmYADEaYYeF8dMlMaMoTq2eVXpSKPAJAZWjgXV9mmw0X6ukCQyExAh3vgZREXKOWCeAYoA70zg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhchvrS9/6EVoxvTgvkZvgTM7npUmBKL0puLNunx1W9bZ4dTLj
	yvsUWdmRITMwD6Lma7JXKzvVbl+iMQIABAED7h3/5XCQEm/PS+3Jo1YgitmQQEqOPFDSpB7XNoV
	P73Isx4ZBZeBJyg8MKlpqQvSJOZNRUriAfQsGMVmr7w==
X-Gm-Gg: ASbGncsDAKCLvlYS2OeJ5zN4HBPL4mgdtq+bHv/lb51l88+STuTcopHSVTORxMKFvGd
	lkcvFlUeUATldjkknBUoO/jGHAkshoSucr5FYdknVKRbb49qgNZg3uyu3iqNKX2y7onTHWz9zD5
	rfoxjIfwgk2tR6HPssZUuKlk5qWSrVVkzGfAakxJma7a+KGeBI6kXdSp/FXg4PzoMjsnOOvWA0b
	JxEEYHvLDSsgKbmTqbP4suofTEGz940Xh2YNN06+KaI2gvM40rR6vsK05tkjeNl+Kj0rUXzeGzL
	vZ7U0hplZJ25FrIFDYcQHG66EYI=
X-Google-Smtp-Source: AGHT+IEbc2TbO/tYVAauVYSWlsGPpU9aKscxV4CCCOtz2gTp8D6aQtAJcJ71cXNyLsAVeBjOKBJwqCStf35Mbf46OXA=
X-Received: by 2002:a05:6512:8010:20b0:596:9ebf:25a2 with SMTP id
 2adb3069b0e04-5969ebf25d0mr6811454e87.19.1764234887164; Thu, 27 Nov 2025
 01:14:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125-pci-m2-e-v2-0-32826de07cc5@oss.qualcomm.com> <20251125-pci-m2-e-v2-3-32826de07cc5@oss.qualcomm.com>
In-Reply-To: <20251125-pci-m2-e-v2-3-32826de07cc5@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 27 Nov 2025 10:14:35 +0100
X-Gm-Features: AWmQ_bkMx1pQI7KIzXZheaED5_3WOsSVYkYxsGF26N74WOl7tj2ktgI1roknym0
Message-ID: <CAMRc=Mc_=F3HiKCVh26RtJ-8vcFWbdRRFS5R8tJa7320W-Tcig@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] serdev: Allow passing the serdev device name to serdev_device_add()
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 3:45=E2=80=AFPM Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> wrote:
>
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> Instead of always setting the serdev device name from 'struct device' nam=
e,
> allow the callers to pass an optional name and set it as the serdev devic=
e
> name.
>
> This will be used by the future callers passing the serdev device ID as t=
he
> name.
>
> Acked-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.=
com>
> ---

Instead of modifying the existing callers with an unneeded argument,
I'd suggest adding a new call - serdev_device_add_full() or something
like that - that takes more arguments and make the existing function
wrap it.

Bart

