Return-Path: <linux-pm+bounces-34097-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6F7B4780F
	for <lists+linux-pm@lfdr.de>; Sun,  7 Sep 2025 00:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35C491BC66E8
	for <lists+linux-pm@lfdr.de>; Sat,  6 Sep 2025 22:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385711A23AC;
	Sat,  6 Sep 2025 22:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZdUqjPcC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEE8AD4B;
	Sat,  6 Sep 2025 22:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757198851; cv=none; b=UWFtvpowcB9kzzMf/UiUPuIr5MjN1mJsYdLnMxZE0VD+cykwA8GZVnpUtjsXuSZqLFDM9xJvhoOdP6OBzh9cMS9DzDn3T9OHf8m3lFSZLGkN2WqBETZW5wZSxyW8e9yYFsQSV/ISAVdFlvv1TuK+O0kLiR8Wl3hxyjaMgaCsXvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757198851; c=relaxed/simple;
	bh=M7YBY+PlDsud3ulKo1KwxdTk5HjWLgupena6NkeHIHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OElcDoK2UczCJRLZ5NqwWNdN+EfEBsxyjKl/k3voDpybsCBb+vBS6WferU2kWP4GAZD6ArO6rxSUXhyooC4+IQDD9YuSu6VJ3+aaxAdPEp9zCLOYXVuVtlp8FyrZ50IETloabeK6HV4n5rLpXQEY38h3QpeZvfsWGUPzKK7LjII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZdUqjPcC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5ACC4CEF5;
	Sat,  6 Sep 2025 22:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757198848;
	bh=M7YBY+PlDsud3ulKo1KwxdTk5HjWLgupena6NkeHIHw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZdUqjPcCFBZU+8Sntt/qoKCyGcPgXjIZ2nTgx/DSehkzWZ2IwIiXNiCIbXnKUupbc
	 3mlL4BU8Cwe2G4TRNuVG1Z7DXnsT3XXTY4c1XLiUQ5jRLrHsFOEyLNAgblpxoP+d22
	 crQuz6CGyFEcVfB3VslIAJ4yN0IlAe1pRjUe+ZLTPSVnc7lM7j0yxoJzpnpV7pk4QN
	 +7YcDnq0xMqdggvftm7sNM8YX5YbgoZznKbEiubiT4a51Nv2TYAqNLYtSuPxM4D8qZ
	 YZJ3S3yDLOTghMAKTp2Ezq9kI1ns0tScHi1rYFwB37MwGhwsZaXPlMkkZof3KhGV8r
	 RR8ja7xVL8+1g==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-30cce5be7d0so1678577fac.0;
        Sat, 06 Sep 2025 15:47:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVMg6PGozZbfj9ZWAN6QGZSn18HPHF0kDzACXoRLllgmwKLybATD70hZ2KWcZXUEs6bd+zgFi0Jde4lArY=@vger.kernel.org, AJvYcCXB0b9GezmdYzlZPFxGtCLWZ5zywmjY0aWdqlIe06bccFLvdSAuWOUtUoNE5L9ffgt0Q0qLgdiVYC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb0+ujRzlH6x/OnH1VXze1O51PRehsxd8cTmjBnP5/LvjZ7kdF
	/60LlpAi68A4tBC+dmgyu/eRgqXEsdNnPCCRiAqZ+FYAwOadXGDbua9EB2QPFulTKyGsdbzke2y
	7MFJP21a2WG01RRcKbmkm/xanFneTjMg=
X-Google-Smtp-Source: AGHT+IHBlQQx0DcSn8WrGT4miIP8Bx5UtUX4jRnhfFKte1qQJwWT9s2fgjzoWbt6eQoAFyWjweW4FuIn9+Y2+ALRETo=
X-Received: by 2002:a05:6820:2222:b0:61e:2938:640f with SMTP id
 006d021491bc7-62178ab6dd7mr1273240eaf.8.1757198848123; Sat, 06 Sep 2025
 15:47:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530-rk3588-dfi-improvements-v1-0-6e077c243a95@collabora.com>
 <20250530-rk3588-dfi-improvements-v1-2-6e077c243a95@collabora.com>
 <CAGTfZH1DzC9odJVDfYCYw4+Ph5_1CjmrpqR_NUFh1SsVVVLM0g@mail.gmail.com> <24752023.ouqheUzb2q@diego>
In-Reply-To: <24752023.ouqheUzb2q@diego>
From: Chanwoo Choi <chanwoo@kernel.org>
Date: Sun, 7 Sep 2025 07:46:50 +0900
X-Gmail-Original-Message-ID: <CAGTfZH3RikS1XRkxjs6vU3yvw4kayRK2u17_zpqodioKJF5mNA@mail.gmail.com>
X-Gm-Features: Ac12FXxhJBnicQpzbdTVw-Dc0dR90IgnZqqaWnW_MXUfhdwqDh4MQlNQ-InNBH0
Message-ID: <CAGTfZH3RikS1XRkxjs6vU3yvw4kayRK2u17_zpqodioKJF5mNA@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM / devfreq: rockchip-dfi: add support for LPDDR5
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, kernel@collabora.com, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Sep 7, 2025 at 3:38=E2=80=AFAM Heiko St=C3=BCbner <heiko@sntech.de>=
 wrote:
>
> Hi,
>
> Am Samstag, 6. September 2025, 18:09:53 Mitteleurop=C3=A4ische Sommerzeit=
 schrieb Chanwoo Choi:
> > I'm sorry for late reply.
> >
> > Looks good to me. But, this patch contains the change of following head=
er.
> > If there are ACK about change in include/soc/rockchip, I'll merge this =
series.
> >
> > include/soc/rockchip/rk3588_grf.h    |  8 +++-
> > include/soc/rockchip/rockchip_grf.h  |  1 +
>
> done :-)

Thanks.

Applied it.

(snip)

--=20
Best Regards,
Chanwoo Choi
Samsung Electronics

