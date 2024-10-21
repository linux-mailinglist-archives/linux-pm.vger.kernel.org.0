Return-Path: <linux-pm+bounces-16089-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C05FD9A677C
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 14:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80A5B282FAF
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 12:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A941E9093;
	Mon, 21 Oct 2024 12:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jh+DtB2T"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ED81E8820;
	Mon, 21 Oct 2024 12:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729512226; cv=none; b=L5mda+wYmQbyEzTGdyVyrCxYsZ4OvLft1zchfThaeDgY7nHwh8NyloOMHLDxacyLm8990YTKLdr7qlMmH3HLhpOBHC317dQexy0I3ygoqKiMS4DVOmHyqaXCzN1/4OGRV3Mq9wTntP0LoRL5RDTVBWdo6rNxxJBCijvFy/FsQBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729512226; c=relaxed/simple;
	bh=9epohfJmZxLsUdXZ/zc+G8wpo+sIrJshlK6G6pUw5zs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fRzcb+vQNFekiKzKe/fQoxmUSoKEFDFxb2aeGE8qVbxc6+3nobOHEN8nGd2CirnAjCMgLYxhMWzO5Clf2/2VJFkAg3nPCNzypvrJVZt9Lc0S8++byJ9L/rIc7X6Ac6jEQU35blaGp1FMymH9uSFzK8f61Q+8uKA300MJ1Zm+BLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jh+DtB2T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA95C4CEE5;
	Mon, 21 Oct 2024 12:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729512225;
	bh=9epohfJmZxLsUdXZ/zc+G8wpo+sIrJshlK6G6pUw5zs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Jh+DtB2T8eaWx7crSQOIW7QzNXZMDuKQovDDqZF3d3sde8DjE/ZjBi0xmGPO8g71j
	 MZeFMA3yy7dPrwI6vXHdt41C8veWk0ln76pdnDa2/seOLXtaUR5FekcQSk3wPGAEzO
	 pfKNGfNZqGBChknoKUC2nqUULOq7Kx2BPrz7fSis4Uu8MgXE6MEnx5soN4AjXVkcLo
	 7ec3/9m0mq/5bun8vxYx3rEauNDBHVXzeNw48lKx/pY1NSI205YNfB4fuKvxx1hGpA
	 y92Lx53Bt8DSuHwmGXdr/gpYneq243SlEt+vwo6rp2fKhxAq4QPOUgqATX5LidrprR
	 8i1uIf2tw+8WA==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5ebc4e89240so327555eaf.1;
        Mon, 21 Oct 2024 05:03:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVeY+6/eewd5O/kDb7ZT/8WGoGRAbHLS/YIXW7N6J/dQkjRVKGafgtqCQHC9SULUdf1eC57czU+N1o=@vger.kernel.org, AJvYcCX60V3Nstw+4h25CXtM/LiSURU4EveOTU30uWzX3i4slr/8InjYps3aoAcvy2NoIcJ3GXLs4DKZVEeFufE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw34S2lzt3+JpFgP1QOBtwVw3CNYPCYaLbBAJbuVThDp8SmlhL/
	uyNhX1OWtCANFWa+/8YVEUIsbyM0Z0+F2gYuaCVZrEj3ywD34+NnkoV+x0zlhtXA4+rRjoRlY41
	P4FMyCKYdjqrdiG/a0Gbtxk2aO68=
X-Google-Smtp-Source: AGHT+IEfjlA2YhXSUpCd4226cJ7vdxG3hlbzsF1xwlcqyFU47ucXUepbqKtJr8r+yti1hMvnM2onuZKudAvlqoV3/PY=
X-Received: by 2002:a05:6870:a10e:b0:277:ca2f:905 with SMTP id
 586e51a60fabf-2892c527fc8mr8273047fac.29.1729512224713; Mon, 21 Oct 2024
 05:03:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1930069.tdWV9SEqCh@rjwysocki.net> <40ec7bb0-02ef-4af7-8934-9f960fa15355@web.de>
 <CAJZ5v0iaR1e6OMpY=wMBKhqg8F6DAX5KUqa+YACEr0z3EZxo-w@mail.gmail.com> <45cbf165-770e-4e28-8936-edd6f18964fd@web.de>
In-Reply-To: <45cbf165-770e-4e28-8936-edd6f18964fd@web.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 21 Oct 2024 14:03:28 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gV+NHZiAwQdeG_0Cjg-s1ugdTDJDkhRwZ9AmBsy80Giw@mail.gmail.com>
Message-ID: <CAJZ5v0gV+NHZiAwQdeG_0Cjg-s1ugdTDJDkhRwZ9AmBsy80Giw@mail.gmail.com>
Subject: Re: [v2 01/11] thermal: core: Add and use thermal zone guard
To: Markus Elfring <Markus.Elfring@web.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 2:02=E2=80=AFPM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> >> =E2=80=A6
> >>> +++ linux-pm/drivers/thermal/thermal_helpers.c
> >>> @@ -60,13 +60,13 @@ bool thermal_trip_is_bound_to_cdev(struc
> =E2=80=A6
> >> =E2=80=A6
> >>
> >> Would you become interested to apply a statement
> >> like =E2=80=9Cguard(mutex)(&cdev->lock);=E2=80=9D?
> >
> > Well, please see
> > https://lore.kernel.org/linux-pm/5837621.DvuYhMxLoT@rjwysocki.net/
>
> Will the separation of source code adjustments according to cooling devic=
es
> and thermal zones trigger any related clarifications?

I'm not aware of any.

