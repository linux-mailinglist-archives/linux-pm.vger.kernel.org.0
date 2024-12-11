Return-Path: <linux-pm+bounces-19035-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBAF9ED099
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 16:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D40928F8D9
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 15:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0F21D63F9;
	Wed, 11 Dec 2024 15:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avLHJdc0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED09B18BC3F;
	Wed, 11 Dec 2024 15:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733932755; cv=none; b=IAWju/YZSIG81qbCUdVNLaKjVe3GCMsp8oVi4K0SBf8vXp5XnryVHrEJ2BltBZ4p5s2M7Qu0IkHrgE1uDLhnHYmeQJJF7fqGPStzlxNgX9ToXn9YbL2jDsQs7sjcMAXZleIGE1FsnfP5aHIVNJYBODhq1gjWjWg82+SEAWdUk0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733932755; c=relaxed/simple;
	bh=PStEIKVCBoB+LDS+e+Ey3xMizBgpYogWYnRK02FOek8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DavYW6oMWhFhgSqruil6m5HyGgWTE4vvGTV2WTfAw9lLkoFgDZ6rsrjldtFdO3BJlw9M/ZhRWi7QlL+hUlVxOLL9yL/mbXFVoZ/5DLKeIPn7bkfPF8I3u67NKTxo3W+RA6M8QAxvYnPuDyJTH/1hX6jM9+3EtF1ccfZWnFCaEMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avLHJdc0; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3022c61557cso27593361fa.0;
        Wed, 11 Dec 2024 07:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733932752; x=1734537552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZChbzObT8yiyu3oc7dwGuAXjmHiQ0fUscqfsIIfuVr0=;
        b=avLHJdc0N50d29IBi/AhmkPQFD8sANprxI6tVSoK8spV/drT7FabCFzJx8Z47kaP4H
         /iRLjjoKpVJ+hpbmdxAhY0E5QgmJ1Xa9QQRKtp2+XLz99MaBq1coalYtB7FwpgdwKNtr
         er75q8p3pLTzcyj8VdNvKz3hFpyyai3Nl3DdaI9O8zTc5QLMiSSBOt7KMvjozYRmh8vu
         CCYet5Lp5t4+L2c+BPCq0JQ+D4gw2raooKoYov0RstrWlZ7ygTtOAWk7WQgmOSv9/1IC
         j5rraPmgDy5XVKrhPyGjPDjhnr9wUejRkHxKQAPRSJJqSR+2O4twnSmA6+lPymKgJXl2
         Pggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733932752; x=1734537552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZChbzObT8yiyu3oc7dwGuAXjmHiQ0fUscqfsIIfuVr0=;
        b=ZjQwC1cZE9RipRlKKOvucdWx8zEa5xvhFlYjWWGaiANbUtx7r9+kWCgnHzbr4bt2Ua
         m2G1M9K3qzeIsxJMyMEw2PK5P+nAHGy0CayjcCz7L27bRxCnO5yaztlMfcDRPj2qTPVs
         eUBrY+7DONL3Y7ZDlzdZklTXXPoXKqezIVw7n1xYqywANzQeiVX+ErV68iGcuLe7ndop
         9dRCYV5uyaQxQcBEIfceMWFVeA+bNZQ1lYGqh+FgPfpV5Iz7dbd5+44so8lKUTNeKGBr
         wpjpr9PY3IMF+qSE8Tmkz12xobBq4OuoHrlrA8sp3Ai28QlAccTE0cXgWiwK9oh3F6Az
         rJdg==
X-Forwarded-Encrypted: i=1; AJvYcCW/Yd7lNLUn/nj6saqg+PY+8GFbc1DLoN6qEa0pvgnuIc5lWpxcsNhVU8uOGDRBL4DXMLR6xESfB03enleY@vger.kernel.org, AJvYcCWBzSvFY5P2sHSNDHuUwSVoCh7zlVIT9/bKhv45mm+dB6K1CQaIyEyaHDESnE5Z2e1me/aQ3L1+KOM=@vger.kernel.org, AJvYcCWy5TJ5TjuCEMO9P1UX5w1QmWdspE/nleHJ3plqjEZ+sat3Ef6PvBl6yxmEEO4fptas8pUpBe5nh4x+@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu/5H7ETiqADrq4sNRQaRy9FwvS7KrFaMc1RpKUwX+AQUrBJs4
	IEVIR0ETf6izdX5YVn5wlPsTHK63jAVhY2hyQUnaco+FjegRpDjcLe9rPwqzel98BAEwhJtdcDb
	Lheddpu9ZsljJ8ugSwD0peOsZEH4=
X-Gm-Gg: ASbGncs3qoIIeYdzmfRyGfc7YAq3Bsu/anONYdGteHigNwVqR5WGq33nJ7/u2MhPbJL
	HhFWbSs7IFIoSi/FzwM9w/oyC1VDzpkc/ZDrXEG5kNvOxwYvYLZ1otRpW8BX7BcU1PSY=
X-Google-Smtp-Source: AGHT+IGjjd845gZqD6VbvGu8xD0QWI1LY7dIDKnnhm4caENDAWdY8siyqutCix247rdvw0pP+hHXXkECcEPStZBxUKE=
X-Received: by 2002:a2e:be89:0:b0:2fa:d2c3:a7e8 with SMTP id
 38308e7fff4ca-30240d4a03emr12884291fa.13.1733932751765; Wed, 11 Dec 2024
 07:59:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210-imx91tmu-v2-0-5032aad4d88e@nxp.com> <20241210-imx91tmu-v2-2-5032aad4d88e@nxp.com>
In-Reply-To: <20241210-imx91tmu-v2-2-5032aad4d88e@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 11 Dec 2024 12:59:00 -0300
Message-ID: <CAOMZO5DC=Y=BU-MX0B_ecOBnkhbiUXXKDDYgn4-uhDNyihOXoA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] thermal: imx91: Add support for i.MX91 thermal
 monitoring unit
To: Frank Li <Frank.Li@nxp.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Pengfei Li <pengfei.li_1@nxp.com>, 
	Marco Felsch <m.felsch@pengutronix.de>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 6:27=E2=80=AFPM Frank Li <Frank.Li@nxp.com> wrote:

> +#define CTRL0                  0x0
> +
> +#define STAT0                  0x10
...
> +#define DATA0                  0x20

These generic short macro names can easily clash in the future.

It would be better to add a better namespace definition.

For example:

IMX91_THERMAL_CTRL0
IMX91_THERMAL_STAT0
IMX91_THERMAL_DATA0

