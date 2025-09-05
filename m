Return-Path: <linux-pm+bounces-34016-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13394B462F5
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 20:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BED97A3AD0
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 18:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10295303A15;
	Fri,  5 Sep 2025 18:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JW94pD62"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD41303A10;
	Fri,  5 Sep 2025 18:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757098409; cv=none; b=LM5jbiICsIy9YkyEY+MW1qbBOyUvI49nm9TbAO9xlC4yAFoZz9sxW4OdyQ4IUr1lS6eVIpYtSVB6zC1JY8MAR2dSEZZAkX9OpveOcoNvTuMtn8m0Prefxx7trR3Dqcj9ig9N6f4eO9q1kZkFJAFVgQwh2XlcEVAGDVZjeqQlQpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757098409; c=relaxed/simple;
	bh=Uk+8a2MRxRxE9hEls54PJ4aU7Ef63Kv5ju07iXhVOvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LBRFYAQdUGlQlAAQdt5cZPImYaA/m6K1JEKzOVdF5oOdu5uXuMMLM45QaE/Z+9XZStW9vA5M+q6Wi1o6wOWTKc1bwSwOd0nd0tLk4ve4YbmGWe+KaKDUyiO44Hs37UDLpMMot08442b6s/HolcL+PTbSMayvF81C6riQCnwNZlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JW94pD62; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2AC2C4CEFB;
	Fri,  5 Sep 2025 18:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757098408;
	bh=Uk+8a2MRxRxE9hEls54PJ4aU7Ef63Kv5ju07iXhVOvA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JW94pD62hORvWJXJ71j4O3PApCk+RnMMyJ7uV/iZgGwFl7KXpPOXrw9upqoiIA3gc
	 PrNjVjym3eladd8ZU3/Op4Tx20hTzvqyGYSWfVVDfD0904KFOfoNQoxqAO74DkDczm
	 f+Qq7sRnHw0VRnxEr5CnX1WOyDhrG60KOFC3WaqQqi+61KMfZTCb6KeHb60r064icD
	 j2uFyxj2FjjnW1aXpKvO4svLbltCeI4v4mzlhi6lZDrq7uzZBzhNEwFmTJ7rtSV0dC
	 Yhf65muCHhUmczl1f+UcpplPiB7WMc3C/jyNW6ckox19arLCmQulwGRJjX/OgPHGnm
	 pTMcPvaV8A4dw==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-61e74d053cfso568117eaf.1;
        Fri, 05 Sep 2025 11:53:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVAtXDb+b9oeMFVR8qOzdkDk1efXCZpH3n276bsXWSkdvPAPodexygMmsiNKDbcYxpJ908Hp45/XQM2hQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUVrOP8Nb+LUjbkzN/787sXjK/f+5Tpb6Rm61V2FnPCkXDTUlS
	ZCgLYnuIKhKWfKGZogZ8bBQZYxiPLGx7ia1H7KTfvpYdc763n6lbYh5gklfmFEILYzrAH+TbwA+
	4kS5669SqhTPHR2nXcs9et0+CQNGUvjY=
X-Google-Smtp-Source: AGHT+IF5l8iyIDclG52ch+WMIMtjzYgWGF4FfZqnmg7QL3Kq7H+uEJ6+K5dpA0GurwaVCSFzWURyRNnRS4NFFp54PkQ=
X-Received: by 2002:a05:6820:1623:b0:61e:77ca:2a57 with SMTP id
 006d021491bc7-61e77ca2b48mr4470188eaf.0.1757098407965; Fri, 05 Sep 2025
 11:53:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903192059.11353-1-osama.abdelkader@gmail.com> <a7dfd3da-fb55-411a-8410-062931c97e3d@arm.com>
In-Reply-To: <a7dfd3da-fb55-411a-8410-062931c97e3d@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 5 Sep 2025 20:53:17 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iL=zDAzu7xUCYmr7OgSD_-ynqA03sOTJ3SWUT72RfngA@mail.gmail.com>
X-Gm-Features: Ac12FXyX9Qd5cSy3tUC2TSqjrjQgpGL4ULEvzf46gt1LfADg85lvs1LryFRuOhY
Message-ID: <CAJZ5v0iL=zDAzu7xUCYmr7OgSD_-ynqA03sOTJ3SWUT72RfngA@mail.gmail.com>
Subject: Re: [PATCH v2] thermal: hwmon: replace deprecated strcpy() with strscpy()
To: Lukasz Luba <lukasz.luba@arm.com>, Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	daniel.lezcano@linaro.org, rui.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 9:45=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.com> wr=
ote:
>
>
>
> On 9/3/25 20:20, Osama Abdelkader wrote:
> > strcpy() is deprecated, use strscpy() instead for consistency with ther=
mal
> > subsystem since this is the only strcpy there.
> >
> > Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> > ---
> > v2:
> > Improve the commit msg: add that this is the only strcpy left in therma=
l subsystem
> > ---
> >   drivers/thermal/thermal_hwmon.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_=
hwmon.c
> > index 0ecccd4d8556..64cc3ab949fe 100644
> > --- a/drivers/thermal/thermal_hwmon.c
> > +++ b/drivers/thermal/thermal_hwmon.c
> > @@ -96,7 +96,7 @@ thermal_hwmon_lookup_by_type(const struct thermal_zon=
e_device *tz)
> >
> >       mutex_lock(&thermal_hwmon_list_lock);
> >       list_for_each_entry(hwmon, &thermal_hwmon_list, node) {
> > -             strcpy(type, tz->type);
> > +             strscpy(type, tz->type);
> >               strreplace(type, '-', '_');
> >               if (!strcmp(hwmon->type, type)) {
> >                       mutex_unlock(&thermal_hwmon_list_lock);
>
>
> LGTM, that was indeed the single occurrence in thermal sub-system.
> Thanks!
>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Applied as 6.18 material, thanks!

