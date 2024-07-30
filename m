Return-Path: <linux-pm+bounces-11687-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97702941E1F
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 19:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51BF0285BDC
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 17:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC2B1A76C2;
	Tue, 30 Jul 2024 17:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CMSeGHBl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45E01A76A1
	for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2024 17:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722360356; cv=none; b=C/RXp6USk2MxNTS2UqYf9j0IyXtjPvKqKouKHlaF/6JSPAEOXMhEgq057QGdJ1z9YeCCnnebUX+Vm0xUh7uGR+glXLDTckkHUyc++1IwgzDCVz4wYaIS/tiwLfL9r0jj8GlMjGy64/yMCUUQvFlW93gWK5ozKpsAnTsK7A/na2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722360356; c=relaxed/simple;
	bh=SR4ep8u0jDhObX+j+vH22fJ0Ll1+cct0CntZJ+AgVsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n+UVr4W2cy0U1nJcb8kn8cDb6QLXxunrr9j0Ia9cV+mIgMA+IE1ApON3J/PDFw4PUf7v16fOWql9hN0XiOxrva9KcbK1miTADfFqEw9l2TapiGurie0kw5frG6kxKHhYqxW6mPeqMXNDOHU8D4CL5VDhTJqDUGrgoIOenr3Y6Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CMSeGHBl; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-67682149265so36006977b3.2
        for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2024 10:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722360354; x=1722965154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SR4ep8u0jDhObX+j+vH22fJ0Ll1+cct0CntZJ+AgVsk=;
        b=CMSeGHBlwIQhj3U0fyS/ew+XpR6cSHCzsagRO7YCSC7WQrMGvS8EfIEsJb21sn6QDW
         L0va3+a1qC8IW3lCuwUh65F7TRI770ywZGUKx+algIattbafZzgm5paSLRuNk2k21J3b
         4lItTkLrhSUJr8WZeF79SX/oMkSPbIbYjfZG+SIcqTM/gk1A4JK2E+vLqpPDH74qRPxU
         V0qlsekLQEToydkJkEsJaSP7iJKUHDD6OCil9b5Y4Fm52hIPXRLIkn5yFZi5nIABKk5D
         V3jmkSccPG9iSG/6ejG2H9jIZxrWo91cnBlCLtIvJes5w1GjpHWbqiUWAYRjGYj3s/nO
         2k4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722360354; x=1722965154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SR4ep8u0jDhObX+j+vH22fJ0Ll1+cct0CntZJ+AgVsk=;
        b=cVS43vm3dC7S1Zb0yssEiIoaT6PDl413juxlRfymLamWMDuRyOMKlXBtBnhd7camrV
         Nf5SBZbhr4yJ2GcNwfi2WBrSYhjLsp+L8pOROYFRl4wAyoC0YmyvTXV7aRJBC3VKfUBK
         Jm18P5CjEuDezoTOBj/w9adIELww4L2MGVWhDY0p0WaXvNcVVX4AJYMbd89ef5tvnzz6
         hPuBiezx8VNLI3GHhJd/YSOvdMDpAbza50/mFubb304f9zTSrHVcuWlH39+fA7752PGe
         7Z6/O2HRrS+sTH0Lwb6H2cVH0r+4IcIueePN+wrxR/JWxvUxJBnyZdAEGH6yd6TqEp0x
         Hx6w==
X-Gm-Message-State: AOJu0Yw0gDSq6uKlsMpqqvB+nnsdl1bALm/RVlWgFLQ2+r5eNZJpYm4s
	0deRgU9elup0ucmhI8HD0n+IaMXUcMPdMtdJymWF8La5oHXKIHToCUNqBfXtudYPgwHNhVftNpS
	HOGudDijVGm8oDVvNPm10KWVxjRubRAVAnjbCMg==
X-Google-Smtp-Source: AGHT+IE5wZhEQttbYW1SZcrl7UTaSkRi1X+/IcIlYkWNAtNbmsb6pPs3LqQs8Xr4/GbhKK2YKJn/GGcCRIMa4SAcUGI=
X-Received: by 2002:a05:690c:46c6:b0:675:a51b:fafd with SMTP id
 00721157ae682-67a097874e5mr154692857b3.31.1722360353870; Tue, 30 Jul 2024
 10:25:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726110114.1509733-1-m.majewski2@samsung.com>
 <CGME20240726110142eucas1p29f261e5e81c177456fd5bb5546871eb4@eucas1p2.samsung.com>
 <20240726110114.1509733-7-m.majewski2@samsung.com> <20240730161748.GA1414176-robh@kernel.org>
In-Reply-To: <20240730161748.GA1414176-robh@kernel.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 30 Jul 2024 12:25:42 -0500
Message-ID: <CAPLW+4=WsGikZ6qOi8dWg4wFsVbhp29cv=DKP06jc4TQn=yUeQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] dt-bindings: thermal: samsung,exynos: remove
 outdated information on trip point count
To: Mateusz Majewski <m.majewski2@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Conor Dooley <conor+dt@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Anand Moon <linux.amoon@gmail.com>, 
	Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 11:17=E2=80=AFAM Rob Herring <robh@kernel.org> wrot=
e:
>
> On Fri, Jul 26, 2024 at 01:01:10PM +0200, Mateusz Majewski wrote:
> > This is not true as of commit 5314b1543787 ("thermal/drivers/exynos: Us=
e
> > set_trips ops").
>
> What is not true?
>
> How can the h/w change? I already asked that. Please make your commit
> message summarize prior discussions so that the patch stands on its own
> and you don't get the same response again. Assume the reviewers have 0
> recollection of the prior versions because we don't. This is just one of
> 100s of patches a week...
>

Hi Mateusz,

Do I understand it correctly that the patch actually removes an
outdated description of *driver* implementation, and not outdated
hardware description? If so, then maybe it makes sense to rework the
patch title and commit message in a way Rob suggests. I.e. rather than
stating that the patch removes an outdated information, instead
mention it removes *software* (driver) description which was
incorrectly added earlier. Because bindings are only meant for
hardware description and should be completely independent of driver's
side of things. Also in that case it probably doesn't make much sense
referencing that commit for using set_trips ops. Just my two cents.

Thanks!

[snip]

