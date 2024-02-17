Return-Path: <linux-pm+bounces-4033-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DED4A8591C1
	for <lists+linux-pm@lfdr.de>; Sat, 17 Feb 2024 19:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DBF01C20A61
	for <lists+linux-pm@lfdr.de>; Sat, 17 Feb 2024 18:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB647E117;
	Sat, 17 Feb 2024 18:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Z+fPtnzm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35401E501
	for <linux-pm@vger.kernel.org>; Sat, 17 Feb 2024 18:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708194749; cv=none; b=Pe0QSLsygbx7S9BS5MLEmeA45KB/DRmO2kXZp4CdaoGzkd33Kb8+KtmbMjWtWvKuOnfCAoWEl2fM6MMLko78DPv/3k3SUFGWn/Xg4u2f9DlBJ8I2kixBEjWCwrRVW+bXikuUAAfA5KDjm/U8CWxKRDgENIZP3MkywhvRmdIK38Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708194749; c=relaxed/simple;
	bh=L2GmIXaDMjW+EsDusq1kZEY2dBNutsr8EonFQw0X7ws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=St7ZJ7IrvEV5vRwl5JztC6kfADQtG9zEi9u/gcpeO86W4FQRVAwFwwUwmpclYKd8VweyltOMaCc7kUXGEmDtUcH6XB/5gkwnORD2F7qNMpmlr9v4UOZoiqfJkHlhlwsvhnl3aRJ/hS64jnt5ttc6r03JhGyJYavdpIy2eHpeJnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Z+fPtnzm; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7d2a67daa25so1760698241.0
        for <linux-pm@vger.kernel.org>; Sat, 17 Feb 2024 10:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708194747; x=1708799547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L2GmIXaDMjW+EsDusq1kZEY2dBNutsr8EonFQw0X7ws=;
        b=Z+fPtnzm85GoxFE32FQBUME5ZUSR/B4P1OWO4L1t7E3sqVZetWZ/72KdOfwtipiWk5
         L7IL5WriHIXVFjpLzRkqwRnr40KE9nz1pDYPt1iMp/DMN6tnPBuDAqv4ErOeszP2Haae
         vrQg61iaJjQt0OjTt7jUde5bvzeLZy8aQI3AbLDJEj+vYEGq7F06elox3Fa38mDRPCDP
         nogoVaSVwWsZcHH72Yh39cJKO4z4MXz3KyKH9pS4ssR/wQHwuSrcDfMDzWqbUALgJmf7
         UoQ4FCIDcP1Ox0OViAJzl+ZEQZT8MyVEUJGyPSz1CkYipW/7FOPhmsrcHz6yq9IH7F/i
         OZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708194747; x=1708799547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L2GmIXaDMjW+EsDusq1kZEY2dBNutsr8EonFQw0X7ws=;
        b=CtdX9neqGxnmcoHIweZuGH4kP0rBdkZe6tyoV9lTN9wAeQcb5gpcvBQxy4AnpRHTfc
         eRxV4q81smKUAqfHJ3UbtK3XcmwdCkeYbutTO1K/hsjf4nQupgSKin2Pq4AxML0RtxK8
         u2ijp0DW/No40Sig8DKoq7l3+XSvI2BxYZY/8iBZxhxTs6R0vWGkNsWzXD4oZvnRGJpW
         aS6/5LZHKlQODq7B8FwkAKgbQsuGddijw0GLHo04KZpNXNusG69c5YNvy8uEnT0UYb2X
         4+ddXruaonB3cjzD7xoEEdPXz2+j78BQPoSVr1r4l94t8d5Iyx7QcUKDoo427+MBIfvd
         YyQg==
X-Forwarded-Encrypted: i=1; AJvYcCVRYEYYX740L30QHDFWvDF7B8rhaEDMbL8FzUr3jh5l+EyaWGLQMxRkvzo6pBlatzA8GMEDk9F3sW3KzYP6Iq5pxEU+EAxKThE=
X-Gm-Message-State: AOJu0YxTmuYpzylsl0X5UKDEdmCqAAlXElqic4Agp3NStex2ck2g/o5o
	2NzpT4lGs/FEQRD2c9Cq9Pqn3X53QGjeIgLQOrV+1knKIVj9N3Oc2h15OhBknksbnxb/aRY22BU
	CJahQKRRO0YxS2QOKGGEdUUQAOIqyCYTYI712CQ==
X-Google-Smtp-Source: AGHT+IFEjgGW7fKzH9O8aPqylmVeeWs1rMw3O59IYiYOUkypD1mxg7ZgMbhhHM34XumhsF+9CITrBlLVb+C2zYLhdF0=
X-Received: by 2002:a67:fdc9:0:b0:470:419f:d42e with SMTP id
 l9-20020a67fdc9000000b00470419fd42emr1433176vsq.10.1708194747045; Sat, 17 Feb
 2024 10:32:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216203215.40870-1-brgl@bgdev.pl> <20240216203215.40870-4-brgl@bgdev.pl>
 <ZdDVNbjv60G9YUNy@finisterre.sirena.org.uk>
In-Reply-To: <ZdDVNbjv60G9YUNy@finisterre.sirena.org.uk>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sat, 17 Feb 2024 19:32:16 +0100
Message-ID: <CAMRc=Mf9Sro4kM_Jn8_v=cyO5PxCp6AnBdeS9XspqVDGKdA_Dg@mail.gmail.com>
Subject: Re: [PATCH v5 03/18] dt-bindings: regulator: describe the PMU module
 of the QCA6390 package
To: Mark Brown <broonie@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kalle Valo <kvalo@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Saravana Kannan <saravanak@google.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Arnd Bergmann <arnd@arndb.de>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Alex Elder <elder@linaro.org>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 4:48=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Fri, Feb 16, 2024 at 09:32:00PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > The QCA6390 package contains discreet modules for WLAN and Bluetooth. T=
hey
> > are powered by the Power Management Unit (PMU) that takes inputs from t=
he
> > host and provides LDO outputs. This document describes this module.
>
> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.

Mark,

This is quite vague, could you elaborate? I have no idea what is wrong
with this patch.

Bartosz

