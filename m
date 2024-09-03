Return-Path: <linux-pm+bounces-13443-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F77496A436
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 18:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6626DB2A0BE
	for <lists+linux-pm@lfdr.de>; Tue,  3 Sep 2024 16:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA94818B47C;
	Tue,  3 Sep 2024 16:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIyd3Fj1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8146B2A1BF;
	Tue,  3 Sep 2024 16:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725380649; cv=none; b=CB1ctUzSUQlqr+AixN0WVh40NqtbFechAk2lMKIRbd7yLBiWfxUB808YGiymAyvAZhUu7ihf0MzIIhMNzoyoDPExMdWT/HVH5v1fylGbWzhtxgKS19Alaw2s/FYgtJ673ajUdJseDBuxOhN1KCACgiUfU0mTKikUpd/LCii3Yt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725380649; c=relaxed/simple;
	bh=3V5UAV3qrzsjjrbeRFb6IMor9fxYQ0KupVcRounHnp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ccQXy9t158lMx2J8J6oxwez6NcKmr+BrwoXHk+fHasJ6UVcoYKxbG6aQoG8mBYi3OSCKL46Vg3HyR3WhipeUmhgYSo32BdIP7mQs2bCjwAmuXeLk42fqYFZVq7XsDEkFHf7h7GR3Bc/m/lgYpes5Waj/Sj1W+INgKKj+8huTinM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIyd3Fj1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0479CC4CECC;
	Tue,  3 Sep 2024 16:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725380649;
	bh=3V5UAV3qrzsjjrbeRFb6IMor9fxYQ0KupVcRounHnp4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PIyd3Fj10xrmUgywMfbhVi8IYXfMGB6J2oj6Dczs+yl8UQR7jEsMMX7g9CBg4HQ4P
	 jzEr8Zt51KPCeJ85sfJSe8cayzzY6FHzr5NA/UwkwBmiPsaA2/YREtTyF0iwuVbRXR
	 yuSz2fAZ414s7XzKnWhl+THFR5Z517W/FmT+KYSpdqwI+B5pFClAJF7+3eXgUWksKG
	 BVuxX4iR4IeWq+DoPb5yJ/pjBL2bt8TOAsybgbaLG75ebb8asZ37Se4Eo/mfHSWKg2
	 R6+4FNC9Lf1hPxutpg3qASpK3sxPTelIaJvsgU4jDNBQpzk2G8rf+nOzhG1HHEWHQB
	 LVTPHY96uQcog==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5de8b17db8dso3303794eaf.2;
        Tue, 03 Sep 2024 09:24:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV6A+i4WdbNtz9au/ybvwl5K+fyVmHeHv2SZzL19OHYtLxi0jI8mGZRz5hN/CD44b2k1TW/KxkKfTM=@vger.kernel.org, AJvYcCVty5h4irjeAIoW20e0hdHIQThlsDbjIg6IAvu72KYrbEc/i/a9KhWegRs1ESvGghAzeaXGda3j17ScyYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAYRAF5oIX7HPcUgytOMnLRgor4pJK5DxVZzMJ0Msbzvrt2+UY
	lygFY1Ai7V+eSWN9GIinDj94maBtSW64xHwifTW6lvZrEkh4GiuK1/J6UozKFypZAVcMuqLG6cS
	Q5JD9Qt9OCa3uJ6OFIgB1SCwfksM=
X-Google-Smtp-Source: AGHT+IG/P/qyT0Fjzyu27zYv+VWMRDXaH1H9JEoqvSRz2HDgEWC9OIATibQ9Z5RpM62r61gADsz/vDdOHnz9dZGGP8Q=
X-Received: by 2002:a05:6870:2253:b0:277:df58:1647 with SMTP id
 586e51a60fabf-277df582090mr10519281fac.35.1725380648337; Tue, 03 Sep 2024
 09:24:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902054959.28073-1-00107082@163.com> <CAJZ5v0gZ9oAByawssaARFN1_crTuMZ-CnU5Fy9D1sWv+Moo-sg@mail.gmail.com>
 <CAJZ5v0itLuorOY-4PyDL5eFkWTf2s9JX++oBkzqi1cYcaHYdmA@mail.gmail.com> <408f4579.bfd0.191b8ac0e66.Coremail.00107082@163.com>
In-Reply-To: <408f4579.bfd0.191b8ac0e66.Coremail.00107082@163.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Sep 2024 18:23:57 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gFnHX982G96aU51tirmdQPiQAYExS5CFcjQc4vgXHAtQ@mail.gmail.com>
Message-ID: <CAJZ5v0gFnHX982G96aU51tirmdQPiQAYExS5CFcjQc4vgXHAtQ@mail.gmail.com>
Subject: Re: [PATCH] PM: add: move warn message out of mutex lock.
To: David Wang <00107082@163.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, len.brown@intel.com, pavel@ucw.cz, 
	gregkh@linuxfoundation.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 6:16=E2=80=AFPM David Wang <00107082@163.com> wrote:
>
> Hi,
>
> At 2024-09-03 22:10:16, "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> >On Tue, Sep 3, 2024 at 3:01=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >>
> >> On Mon, Sep 2, 2024 at 7:50=E2=80=AFAM David Wang <00107082@163.com> w=
rote:
> >> >
> >> > dpm_list_mtx does not protect any data used by
> >> > dev_warn for checking parent's power, move
> >> > dev_warn out of mutex lock block make the
> >> > lock more efficient, especially when the warn
> >> > is triggered.
> >>
> >> It does protect the power.is_prepared flag of the parent.
> >
> >In fact, the update of it in device_resume() is racy with respect to
> >the check in device_pm_add(), but the purpose of it is mostly to allow
> >the device driver's resume callback to add children without triggering
> >the warning.
>
>
> Kind of confused by this... if dpm_list_mtx could protect power.is_prepar=
ed,
> then codes that change power.is_prepared should also hold this lock, but =
normally
> they only use device_lock(dev);

It is confusing, sorry about that.

The bottom line though is that you want to get rid of the spurious
warning in device_pm_add() AFAICS.

To that end, can you please try the patch I sent in the other thread:

https://lore.kernel.org/linux-pm/CAJZ5v0hMnnDjKJLMgcT_p1nnejyyAyaqaA_AF5t+_=
=3DPsSMfceQ@mail.gmail.com/

