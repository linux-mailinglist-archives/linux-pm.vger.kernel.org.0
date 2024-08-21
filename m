Return-Path: <linux-pm+bounces-12638-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38191959C65
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 14:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50BF8B2145C
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 12:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC06F19259F;
	Wed, 21 Aug 2024 12:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGClIJKi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1319155307;
	Wed, 21 Aug 2024 12:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724244774; cv=none; b=b6v2sj6G49k4r0w3vCEm9Gqzp4KscOnxfZJMSeAak6vu7xEoDuiAhv6wO0osyBalZaRDet2WDb/AWiA1/Baukaqf/CsztXBU18yqEMLV2OU5WwXbXTP8cEkR3d1WnQLSdn84+/YMCjTTsL+9M04Ubf6WS/+ctSqh30tN3nOGqJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724244774; c=relaxed/simple;
	bh=Dba99MI+BlYszq2j+BXexV6UeuHE1UeB2W4uWN6BYvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dXeJN3OgXrcFW9VTM87EgkoSRn5S+VZONpF+BaDdAqwMz+GlxpHP53i5xmEQ3jsfGnWM7dQofmKzfg2y7WSpAKRMGxdxSmoGKeTd+s4nudH1JByLpbh50dqVDVp1UoK4RFh4/M/G/6jFq4HmBSMWl6aUOyjnGujgA6nYHW4a1RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qGClIJKi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F96AC4AF09;
	Wed, 21 Aug 2024 12:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724244774;
	bh=Dba99MI+BlYszq2j+BXexV6UeuHE1UeB2W4uWN6BYvA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qGClIJKi1ijerHHmChOyvJG70UfiGn2VFurz+Icc5uOSNidKUOiIJUpBftN/JvobT
	 2D8v/VbZ6v0C+JHbetWJ3X208JVwkXDfYwyBPI0BDyLuVXN4ucsxOjIej38SlqbvxR
	 eWxZg3xVWKlbsSE9STsIViQ5oLxwsuS8TJkjd+uqaD/kmpX23Kgp5p7WmJcx7mYcj2
	 1hPNwwg4SIOwb8U3Ed49HgPToL91VUjmgC1V3jwJbS8y10CxBk9McVDDLMuJAp7dQM
	 QBGXYinlSRIWgUPk385raQh9Z7pEwL9VgNwk4pYFfq8s3nGs3Tl7uiIS471WW+CZBO
	 YlKKIPm9ys8HQ==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3db13410adfso4307079b6e.2;
        Wed, 21 Aug 2024 05:52:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWlbCgnH4yw7HR2BAe/6O2/FW/F1aN87qnRgMvd4cIXmbWOOvDfgPLOYdXqn30vhgTuu39swfEdjK8=@vger.kernel.org, AJvYcCXSxO9ZoYvrleTevBjAesY1+kD8pSxd/R9aLGwB15aWRy8Mq6G0sNLbGm0GXPgnGgR427XiNbsOQwLqKMc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy03FD3E/HFFyZ6M4caH8F5N47LYU+edY2B+m50ShZHJdfoQqqY
	iujpKQ/wSI2kGk/wH4hqrLHW0gyaNipsxsXz0mNsqIKS6CeQNTGccywxeM/KzCCn+lgwrMiCXwG
	bca28NUTzM9KyfjrN6JTVyJMIRz4=
X-Google-Smtp-Source: AGHT+IGl6atFYOvYQ/8BEwcs4rBsgd4wRKtHqwdkIZ7t/rsbMhdMvZuiUG3qPER7ayJGocQ+hS7Ni1obnSOwTAGAyBI=
X-Received: by 2002:a05:6870:961a:b0:261:52d:1aef with SMTP id
 586e51a60fabf-2738becd8c7mr1907012fac.49.1724244773533; Wed, 21 Aug 2024
 05:52:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2205737.irdbgypaU6@rjwysocki.net> <10527734.nUPlyArG6x@rjwysocki.net>
 <c01ed2d7-964d-4b75-9a8e-8325d4cc9269@linaro.org> <CAJZ5v0gQvSouUcEH7CtxZptKHbRyy4=Nes_SjqAW0S7jOJXHqA@mail.gmail.com>
 <4a8d8f5a-122d-4c26-b8d6-76a65e42216b@linaro.org>
In-Reply-To: <4a8d8f5a-122d-4c26-b8d6-76a65e42216b@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 21 Aug 2024 14:52:42 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gd2Q-x9kVYUaDY05S+SNur50tEVnQ4UDK66G45xX2ywg@mail.gmail.com>
Message-ID: <CAJZ5v0gd2Q-x9kVYUaDY05S+SNur50tEVnQ4UDK66G45xX2ywg@mail.gmail.com>
Subject: Re: [PATCH v3 03/14] thermal: core: Drop redundant thermal instance checks
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 1:56=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 21/08/2024 13:11, Rafael J. Wysocki wrote:
> > On Wed, Aug 21, 2024 at 1:01=E2=80=AFPM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 19/08/2024 17:52, Rafael J. Wysocki wrote:
> >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>
> >>> Because the trip and cdev pointers are sufficient to identify a therm=
al
> >>> instance holding them unambiguously, drop the additional thermal zone
> >>> checks from two loops walking the list of thermal instances in a
> >>> thermal zone.
> >>>
> >>> No intentional functional impact.
> >>>
> >>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>
> >> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >>
> >> I'm wondering if the thermal_instance 'tz' field could be removed too =
?
> >
> > It is used in a debug printk in __thermal_cdev_update().  If that
> > message can be dropped, then yes, but that would be a separate patch
> > anyway.
>
> Yes, I don't think it is really worth the debug message here

OK

