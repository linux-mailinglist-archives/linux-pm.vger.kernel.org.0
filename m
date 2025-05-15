Return-Path: <linux-pm+bounces-27203-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCA5AB8E66
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 20:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 955601BA6B63
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 18:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF4E258CED;
	Thu, 15 May 2025 18:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYLu+Rx1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D0F2586C7;
	Thu, 15 May 2025 18:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747332132; cv=none; b=j+RwZbzQCxmtIoH+gMp3R1NhMVEFSeq8vb6RP0KLZ/37Xh/UWp1cdhwYkJ+S+E0l6v2yO7Qo9ocd5gKFm1Rf986LPpdoEgOSc/Zcw1nf8H2yz5TChzLdkjIcQWgdZzOYVUnvEEtWdJ3lzPDRfYkxeOWvB8gdkCeMsPYxlLjuMtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747332132; c=relaxed/simple;
	bh=xYxE3KmAJuDBwEUTV/7JBSyd7GH9iHMFGQRs1lUAZlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QgKXzeBV/tgDxLGJOx+tea9/HxzvrI0vPQRPDAX0w92GkQCNn4gk3V5sWVyUVwmhHuMVLl1cstdCluDEQ08QB8pX2toTLnpTUY5wQs6LxgwqyTQcDJ+1sT/sFzjtSdCWvS5vBpfGlAzr86xwwWdKQIUoitzEkYPlgNeUFd4xigw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYLu+Rx1; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-600210e4219so793017a12.0;
        Thu, 15 May 2025 11:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747332129; x=1747936929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNN+vfuMJJgSzRBBX1dcv69JrH0Sd8EtzpYEboDV/q8=;
        b=fYLu+Rx1EldXlJSmKgme1AVOXXw/BgC3RyBSt2P4eMUCEM3HVvFt3kpsWb/0sfGID0
         FyGnh7lpEBHGl/Fua/VuI+7iUdjaRnaUkh4CY1hsvpT6qtUki4+YyshD9LNDVqXZEv43
         uP7QVnMP/en4EhYOJTFVDf+M/MEZFmlqRJJ7OLkBDZCuYBgURO7BGGM8JLagYG94lDHQ
         C6L5PV8jVeGuWUKqwJ6h0yl1y7qxOpDveRmf9A+/XnNd17qcWAJM2sj+M8rXS3qOzcIo
         YTrybl6x7QVQglBhxFEP6wVyFWqHqpfiG5hYXVX4EODm8YZmNLj5uV80J/Vaft+a+CC5
         sGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747332129; x=1747936929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bNN+vfuMJJgSzRBBX1dcv69JrH0Sd8EtzpYEboDV/q8=;
        b=Ywrfz4eQL8CIEGfspD2HyEhxyBipRYCOjorM1qAxKniCeS7tLhU4AP4/2lpRIZBAJa
         r+ovJZTV6g8FuKx+JnovFxBrtKIrCijjuE/Qh/j0KLVVGLLPCPtJSqhwKB0eosXCc0u5
         e6DYg3GTRRg4jqWwmQLoTzFXl1cxl/OAfYiuaPiKvmf0Db65mmmmGUKeO4PBAUeIJsqY
         vVBIEDTJ5BxVimWBVy6hxQPnuE12uG8FfjJ8kOSyQHDX0mHvycoepudYWRCOD0F7l5En
         vrv62Y/IziDQeNWbQSLJfEDhfEUJCt2Q65FnbEnAuLpJ1/sVbRq+zW3qHe6cP//SavI7
         YnbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKe15P+uT21THv7UTC82c3jHL6cP/lo8qSgqdYv2fwS/CAqh2wZBKM1TmAWvBWE7VA0NP5wpEqIeNf0Es=@vger.kernel.org, AJvYcCWePnP5eKI31ey6ZTaYog2s1KD1b5pAierqV9U1vU2bWckzvSp8CZbnOmELt1fA/g2HU0ORm6cjN3E=@vger.kernel.org, AJvYcCXWJqD4OqJeSy4p9uUyEWxuvudpSx9czuxS2F3/C1lU5zvyYjis6oDKQ26DU7TOsWj3POQxaqhwUGcf7I6O5BSHMe8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMWRDtVd5HgyMEOIB2wz5QnegNaSWquzKeWCUITj0vuFNEkswu
	GAUfWiW+XF0SXjlUS+qgCMspOLlf00K8KFz9VLThs1byE5tHc2CfqHGcXhPxiTKrZrPSzMpshVK
	3gs0Z/yYHvLBMjiehNSAEJUkoUHSx4mc=
X-Gm-Gg: ASbGncuLsrkE+MT4S8L38gD+DRWoXuqr0o/rK9Q16nCwvtx/15fCyUz9mFQiBMwEeYO
	r9nOD6luk1t2t994UDWC3hhUON+T1b38vzORQihfE2BLO/PFEvCN50hjmyOVbOSnZ22r3zIZbUj
	Ccuay4D8H00lIDzljsz7YN/Ef4JoYj4yU=
X-Google-Smtp-Source: AGHT+IGJ3VLgyC5oRyYT9SJhjLgRqlja96rlJ3f3rzeXshYp1J9lbgDhqI7B6B7Y0eDrmuUni3A/DX8mMtH0+4aqo58=
X-Received: by 2002:a17:907:980f:b0:ad2:41ae:a1e4 with SMTP id
 a640c23a62f3a-ad50f7c4f3dmr407267966b.24.1747332128837; Thu, 15 May 2025
 11:02:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250430123306.15072-1-linux.amoon@gmail.com> <aCR9RzGMWEuI0pxS@mai.linaro.org>
 <CANAwSgSA-JHMRD7-19wijOY=TSWD-sv6yyrT=mH+wkUJuvxFAw@mail.gmail.com> <92c2949e-2fc1-40e9-9dea-e3d9f7aa571d@linaro.org>
In-Reply-To: <92c2949e-2fc1-40e9-9dea-e3d9f7aa571d@linaro.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 15 May 2025 23:31:50 +0530
X-Gm-Features: AX0GCFsEAXplwRDB3NXZqHZ-d-ohJ2IJuxMQMC4KvVGNnVidBm-TZoRYGMggWAM
Message-ID: <CANAwSgQryVLdRVd9KRBnaUcjtX8xR9w9BBTCvoqKH6funkj=2A@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Exynos Thermal code improvement
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	"open list:SAMSUNG THERMAL DRIVER" <linux-pm@vger.kernel.org>, 
	"open list:SAMSUNG THERMAL DRIVER" <linux-samsung-soc@vger.kernel.org>, 
	"moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Thu, 15 May 2025 at 18:59, Daniel Lezcano <daniel.lezcano@linaro.org> wr=
ote:
>
> On 5/15/25 13:10, Anand Moon wrote:
> > Hi Daniel,
> >
> > On Wed, 14 May 2025 at 16:53, Daniel Lezcano <daniel.lezcano@linaro.org=
> wrote:
> >>
> >> On Wed, Apr 30, 2025 at 06:02:56PM +0530, Anand Moon wrote:
> >>> Hi All,
> >>
> >> Hi Anand,
> >>
> >> if the goal of the changes is to do cleanups, I recommend to rework
> >> how the code is organized. Instead of having the data->soc check all
> >> around the functions, write per platform functions and store them in
> >> struct of_device_id data field instead of the soc version.
> >>
> >> Basically get rid of exynos_map_dt_data by settings the different ops
> >> in a per platform structure.
> >>
> >> Then the initialization routine would be simpler to clean.
> >>
> >
> > Thanks, I had previously attempted this approach.
> > The goal is to split the exynos_tmu_data structure to accommodate
> > SoC-specific callbacks for initialization and configuration.
> >
> > In my earlier attempt, I tried to refactor the code to achieve this.
> > However, the main challenge I encountered was that the
> > exynos_sensor_ops weren=E2=80=99t being correctly mapped for each SoC.
> >
> > Some SoC have multiple sensor
> > exynos4x12
> >                      tmu: tmu@100c0000
> > exynos5420
> >                  tmu_cpu0: tmu@10060000
> >                  tmu_cpu1: tmu@10064000
> >                  tmu_cpu2: tmu@10068000
> >                  tmu_cpu3: tmu@1006c000
> >                  tmu_gpu: tmu@100a0000
> >   exynos5433
> >                  tmu_atlas0: tmu@10060000
> >                  tmu_atlas1: tmu@10068000
> >                  tmu_g3d: tmu@10070000
> > exynos7
> >                  tmu@10060000
> >
> > It could be a design issue of the structure.or some DTS issue.
> > So what I found in debugging it is not working correctly.
> >
> > static const struct thermal_zone_device_ops exynos_sensor_ops =3D {
> >          .get_temp =3D exynos_get_temp,
> >          .set_emul_temp =3D exynos_tmu_set_emulation,
> >          .set_trips =3D exynos_set_trips,
> > };
> >
> > The sensor callback will not return a valid pointer and soc id for the =
get_temp.
> >
> > Here is my earlier version of local changes.
> > [1] https://pastebin.com/bbEP04Zh exynos_tmu.c
> > [2] https://pastebin.com/PzNz5yve Odroid U3 dmesg.log
> > [3] https://pastebin.com/4Yjt2d2u    Odroid Xu4 dmesg.log
> >
> > I want to re-model the structure to improve the code.
> > Once Its working condition I will send this for review.
> >
> > If you have some suggestions please let me know.
>
> I suggest to do the conversion step by step beginning by
> exynos4210_tmu_clear_irqs, then by exynos_map_dt_data as the first
> cleanup iteration
>
Ok you want IRQ handle per SoC call back functions?
so on all the changes depending on SoC id should be moved to
respective callback functions to reduce the code.

Thank  you for having a look into my changes

Thanks
-Anand
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog

