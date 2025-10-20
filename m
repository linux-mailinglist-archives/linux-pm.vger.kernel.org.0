Return-Path: <linux-pm+bounces-36516-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6435CBF359A
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 22:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 224974EDFCA
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 20:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103AC2DF6E3;
	Mon, 20 Oct 2025 20:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDKVsLMP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4092DAFD8
	for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 20:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760991260; cv=none; b=Ayzjn85JRkKwK/bsO6nkBc8HuiJHKvnAarXCDb50ZjKhhbSOMTg3LJlk+g4lWoBYGIwLyyGAvlWCtZYZukrzw1eV7eSr3b4hJKo0XGbkTa7mqSxxKYdn11iG+H3fZHlQy6FDsN5vwbJu23qxhK9JUvHSkNZfx5D5T91M+iJ8a7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760991260; c=relaxed/simple;
	bh=cW0NrS3XvfmefHojKNpPlFwBgfzDJ5SAdW6H/5DCfJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nEE83jX7jot3DrNRKTH5bUtQFUyIShLhqaNiF0JJM09KcVOVrn9Rzp+9TRFhjqgo9pb5NilgZXvW/aDSjvKEMb712HVfMFtIFXdC609+OR555OJjGt94KmxtKwkeWlR/WzbmgoCDK/nd0MWTApeGJmJGlS/MhIkWq37vhLHWa/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDKVsLMP; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-57dfd0b6cd7so5335222e87.0
        for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 13:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760991256; x=1761596056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cW0NrS3XvfmefHojKNpPlFwBgfzDJ5SAdW6H/5DCfJc=;
        b=VDKVsLMPM20J15S3GLLr20r5MXIkau6rpxVYq3D0Y5zDQEGdGfsgoYmLpFvR3Aw17o
         T23W680+65Pei+gQysdvQgWcnVnj5fysoWlA0hJVt75WcS03PRf1HmWWgaKm7HUZX/zS
         iCtX+z3a6N5AOCkJuVuww7yZGMLEb2j0Ziy+g3WeTYPlAP2p6IPB7T32WFGxfAc9T6zy
         hwMQaxetN9tvKMrkZgpjzXl/oOrZXNE4BzHaLUoUh1+N7G4ebabKBKc3czuZ8ccZyQIs
         KFfdLw6aE72VAA6DO4qeD6nyCdpvQtb+8HblZXd1gy6dR/EFL+lSS3/lnJTDSDLsvSA5
         ig0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760991256; x=1761596056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cW0NrS3XvfmefHojKNpPlFwBgfzDJ5SAdW6H/5DCfJc=;
        b=eyJFXJVRSGt5EOo425LlcDuueIyu9EZ66iS8fsMvq5j0Sy2dpdHw72cx2VhhECY6tw
         suMMR7hFGHEF8QHa/3Qiq63tXfQtCixdwbyGL0S5zUqxmD9ZmhNCF7NddsEoSGgXDiGv
         2t3xJhTqLDPfBMAP4bPl/PzTJMUdJ4KAAr8bALc2jGxcnCuCgaKB/Fi2NTTAg7PQNrQ0
         GeVGAMaMHHVJJcVbv6zIuC6TdPeIxCVulHR5FcWw42su6iKObJ6Fy64W+vihaBaXeglC
         r/FoMxkQz+A0MqTpesx4fz8fhwyEQZAlPmLo91orJnfacNeDCPSeQ31pE6cpGrhniYaN
         4TeA==
X-Forwarded-Encrypted: i=1; AJvYcCVkv6qdo3DQrguZl9LkoDXZBUOvc+xOgr8FtxOJBI2QZmRxyhUxf0Z2da5og4FcbMkgGJJNhynNjw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi8r7PU2uyv7Jm5SjCGI4dqTObQEUDiQIfYq3ajMkdPb5bDbKi
	ux567t5nrnxcqG8uKGgkljTHeS3pZVmPY6Mjmypg4VjQXY1L3g5EGyE1+DvDIddePVdhDAaw2c0
	EUqncj2zfdsFZmFxajUgkfEP9fdGBuaw=
X-Gm-Gg: ASbGncsSolqYm5s2Qes9ey8i7bN0/rU5qOpiYC8+Zt2qVxpDgLDgdLcCBt5iwZYx2TU
	R1HMwOgyKY4/TIDxEytBimVUW8I43q3836cDdoi1pUnsV7d+2LdgomMJTbKBrtpurfGMen2uPCg
	o3TbsiKRl7yZpXaXBb//EYi+C5uMuUiX1miPCDlEqBSBU04EUYgzsNQcoE/si7geMr6CgaMxq0H
	WzIu+7lfIG7c8Xi6mcGIbdwVi29zSZXidbsKnORPCckNH62vpEI4rbYyiFS3NOFjTOt5zNE40k9
	XguvEdBplqMyGaeENK7F2K+U72J4
X-Google-Smtp-Source: AGHT+IH5YbH/N0GzOG9KC4T3jdDKTBXy9E5rcby+9lA7Aeai++z/YKb5cv2iLVBi4oC0gn0ky+3LKbarimVH4bcAel0=
X-Received: by 2002:a05:6512:23a3:b0:576:d5df:fe1b with SMTP id
 2adb3069b0e04-591d84cfb78mr5033821e87.10.1760991256016; Mon, 20 Oct 2025
 13:14:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909-tegra186-icc-v2-0-09413724e781@gmail.com>
 <5d7491b1-8f9a-4040-b854-ff0b94bfd24e@kernel.org> <CALHNRZ-okVZ8tzKYa=jqudDu3dZ_Yq1CkeErdcvxi5xJEgJFbg@mail.gmail.com>
 <113725e3-3e82-4921-b045-8d5be3fed8bf@kernel.org> <CALHNRZ8r_bg-Pm1ZCoJT9sk++zQcq85R=8N6enL_Vcq=VziNwA@mail.gmail.com>
In-Reply-To: <CALHNRZ8r_bg-Pm1ZCoJT9sk++zQcq85R=8N6enL_Vcq=VziNwA@mail.gmail.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Mon, 20 Oct 2025 15:14:04 -0500
X-Gm-Features: AS18NWB_ZO-oT8U4UToGcdXsXZWXtPvNCoksa_QZNadvxO4znElXh9NUJcwBK4g
Message-ID: <CALHNRZ-2Hv2ix0Hr9veOPWdO=ekgpEWKBWtCiCsQa29DcfdkUA@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Support dynamic EMC frequency scaling on Tegra186/Tegra194
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 12, 2025 at 9:31=E2=80=AFPM Aaron Kling <webgeek1234@gmail.com>=
 wrote:
>
> On Sun, Oct 12, 2025 at 9:25=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.=
org> wrote:
> >
> > On 13/10/2025 04:18, Aaron Kling wrote:
> > > On Wed, Oct 8, 2025 at 7:05=E2=80=AFPM Krzysztof Kozlowski <krzk@kern=
el.org> wrote:
> > >>
> > >> On 09/09/2025 15:21, Aaron Kling via B4 Relay wrote:
> > >>> This series borrows the concept used on Tegra234 to scale EMC based=
 on
> > >>> CPU frequency and applies it to Tegra186 and Tegra194. Except that =
the
> > >>> bpmp on those archs does not support bandwidth manager, so the scal=
ing
> > >>> iteself is handled similar to how Tegra124 currently works.
> > >>>
> > >>
> > >> Nothing improved:
> > >> https://lore.kernel.org/all/20250902-glittering-toucan-of-feminism-9=
5fd9f@kuoka/
> > >
> > > The dt changes should go last. The cpufreq and memory pieces can go i=
n
> > > either order because the new code won't be used unless the dt pieces
> > > activate them.
> >
> >
> > Then cpufreq and memory should never have been part of same patchset.
> > Instead of simple command to apply it, maintainers need multiple steps.
> > Really, when you send patches, think how this should be handled and how
> > much effort this needs on maintainer side.
>
> To be honest, I was expecting all of these to go through the tegra
> tree, since all the drivers I touch are owned by the tegra
> maintainers. But getting stuff moved through that tree has been like
> pulling teeth recently. So Krzysztof, what's the alternative you're
> suggesting here?

What is the expectation for the series here, and related, the tegra210
actmon series? Everything put together here accomplishes the single
logical task of enabling dynamic frequency scaling for emc on tegra186
and tegra194. The driver subsystems do not have hard dependencies in
that the new driver code has fallbacks to not fail to probe if the
complementary driver changes are missing. But if I was to split them
up, how would it work? I send the cpufreq patch by itself, the memory
changes in a group, then the dt changes in a group with b4 deps lines
for the two driver sets? That seems crazy complicated for something
that's a single logical concept. Especially when as far as I know,
this can all go together through the tegra tree.

Aaron

