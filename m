Return-Path: <linux-pm+bounces-12173-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9ED0950AD3
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 18:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83ADC1F23FF6
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2024 16:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4351A0B07;
	Tue, 13 Aug 2024 16:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKHRhKk8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1095154918;
	Tue, 13 Aug 2024 16:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723568147; cv=none; b=bd6UVSDpdokYBjcAYBdhv/e1OU72/RPxFZHKhTYlrZvpBLXwilw3bfE+hiE+zCnDQGDJOUd/Svk8KU1HLIIevfQLKoyn0f1IHEV34Xp/rFGejORBbVaqdW+WWMV3VnWe63XD7WjBRxqEQmHwnnB/T4YlsWUki6HwtKwBf3D8H4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723568147; c=relaxed/simple;
	bh=1EeeR6xvbEYsHpjGC575cAYMgmOuqaJxf/cgh2hpyXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sbPDl9SmSY3IrJA0hf9IBvhVcNAEFQipLKI+vFFCc9Rx1L+D7dpfrfCAxMRnVCQrAGq8X0ki+UhCUEObRywjxDaknpIEMonhtPoypDMMGUriuYJ9bNLOn+jatCsj5WA301wK2w0KhGs+OSO4yM0HwsfjgUMxKY+O7+vNtRaIf14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKHRhKk8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76BD8C4AF0F;
	Tue, 13 Aug 2024 16:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723568146;
	bh=1EeeR6xvbEYsHpjGC575cAYMgmOuqaJxf/cgh2hpyXE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MKHRhKk84jXFr/mGyfLN1Oi4A799JCNwM0GX71lPbrPmO1GgniBXmRYhrN89xuwIV
	 Dlf/40Xv9RIr5+vOB5MPZDhkQ6oXj4qngnd+7AUBevL6miLolaX65HwpsCEsb3pdCU
	 V8eBrkNrkmNUchPPE7TiRPyZQUDx/vRoXKtMyfrVjiC9mcTnoeZ6CR5uySde1D1quZ
	 SREGzrfU+KiXfMGCYSz2KtSBJk+H5Xwrxw8fv0P1N1Te60FSJICUNwgQohSczCpOMM
	 QDRLG4v69lQjTyajXDk/LY+FBXZ8lHoVHqSY/FiwNKIluc6cvw7h9c28H35al6Q61l
	 01pBphJiSF7mg==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2610c095ea1so666243fac.3;
        Tue, 13 Aug 2024 09:55:46 -0700 (PDT)
X-Gm-Message-State: AOJu0YyPrJzGBgCas7oUVSZuBBg2NUuTqXJTZutZd341URAvvl2MqJ+q
	jcvlQAtP3cbj6UjqeceyAw93+50giH8uprrzlsyXZZs3AC7cNdohymjFMqhaW53CI910hSrGkgS
	MLijzJHYAy+TUJtH1xgaBGHqrv5E=
X-Google-Smtp-Source: AGHT+IHR+I+Hgio3nA8QFrqAsFv0nUfgN4cL48N6lJgWVemibkoHNjBmDMW1463ISyqPnNu/UQAtoHqpUPttEC9gdmc=
X-Received: by 2002:a05:6870:d152:b0:260:eb27:1b83 with SMTP id
 586e51a60fabf-26fe5bf88bemr158969fac.5.1723568145723; Tue, 13 Aug 2024
 09:55:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <114901234.nniJfEyVGO@rjwysocki.net>
In-Reply-To: <114901234.nniJfEyVGO@rjwysocki.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 13 Aug 2024 18:55:34 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j_EHPANoxK38GbiMyLBX5tCesRzZRmwr3z=-sWQd1tzw@mail.gmail.com>
Message-ID: <CAJZ5v0j_EHPANoxK38GbiMyLBX5tCesRzZRmwr3z=-sWQd1tzw@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] thermal: Rework binding cooling devices to trip points
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Everyone,

On Mon, Aug 12, 2024 at 4:01=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:
>
> This is an update of
>
> https://lore.kernel.org/linux-pm/3134863.CbtlEUcBR6@rjwysocki.net/#r
>
> the cover letter of which was sent separately by mistake:
>
> https://lore.kernel.org/linux-pm/CAJZ5v0jo5vh2uD5t4GqBnN0qukMBG_ty33PB=3D=
NiEqigqxzBcsw@mail.gmail.com/
>
> It addresses several (arguably minor) issues that have been reported by
> robots or found by inspection in the v1 and takes review feedback into
> account.
>
> The first 10 patches in the series are not expected to be controversial,
> even though patch [05/17] requires some extra testing and review (if it
> turns out to be problematic, it can be deferred without too much hassle).
>
> The other 7 patches are driver changes and code simplifications on top of
> them which may require some more time to process.  For this reason, I'm
> considering handling the first 10 patches somewhat faster, with the possi=
ble
> exception of patch [05/17].

Since patch [04/17] in this series turned out to be broken, I decided
to drop it and rearrange the rest.  This mostly affects patch [05/17]
and patch [17/17] which is the only one that really depends on the
former.

Of course, patch [05/17] also clashes with the Bang-bang governor
changes that have just been posted:

https://lore.kernel.org/linux-pm/1903691.tdWV9SEqCh@rjwysocki.net/

For this reason, please skip patches [04/17] (broken), [05/17] (needs
to be rebased), and [17/17] (likewise) for now and focus on the rest
of the series which still is applicable (a couple of patches need to
be rebased slightly).

I'll send a rearranged v3 next week (I'll be mostly offline for the
rest of this week), most likely without the patches mentioned above
(I'll get back to them later).

Thanks!

