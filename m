Return-Path: <linux-pm+bounces-546-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6C37FEDF5
	for <lists+linux-pm@lfdr.de>; Thu, 30 Nov 2023 12:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC791282467
	for <lists+linux-pm@lfdr.de>; Thu, 30 Nov 2023 11:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3513D385;
	Thu, 30 Nov 2023 11:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5486D170F;
	Thu, 30 Nov 2023 03:31:15 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3b41132c33aso127523b6e.1;
        Thu, 30 Nov 2023 03:31:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701343874; x=1701948674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZ7wq3n3DhrJeyQna6lVndn1rATyyoXPNxb3aRmLfHg=;
        b=CaTy3wzdccr3TV/5KYAycWVgr076E/J9WPXqZSgdAZTWckwRC9ylLOhpcH9+zClx6h
         x8THO/oiCWYZ0TN4ylP6XGOcgUBU9RA4YLeVGH8U+0zIo5tvpPdzFypkJ6Snuvi2LMfo
         wIT2HR+A84WCZHDRfOAIqm0KfUbmjRX6s/ULCPJDedSaeC2uxLBbOaGgCXDHAebjo+Ih
         Ebcv+AdrN882wtbBrf4K9Am1Dt2Vb/fCMWvnj+4HR2xOTo/EGrmxgktjJ8GcgRjS7h50
         8Ejo+/RhxDnm0vNl9csqnyV1tVQSGbNslOemDlFHTCw8qNh0dI1x+JQkxKXWa4mCeHuX
         qiOQ==
X-Gm-Message-State: AOJu0YzmA3yWQUUjxi/msurRbeD8AaFQmXXxsRcXVf9u+Qj1jG35nR0g
	szjSGDTsXkU+giAqpi/0aQVbrdowwhSKe5n38q8=
X-Google-Smtp-Source: AGHT+IGhTQyTA9lsvqa9Gj1f55YlUXC0bKVfU/bClyfVlV9ztKG3V9/92aph3S0VvjhMaQ5UXh6wnqt34aZeCCrfWaM=
X-Received: by 2002:a05:6870:168d:b0:1fa:132a:ad11 with SMTP id
 j13-20020a056870168d00b001fa132aad11mr23156531oae.2.1701343874466; Thu, 30
 Nov 2023 03:31:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12350772.O9o76ZdvQC@kreacher> <4869676.GXAFRqVoOG@kreacher> <d83a54db-4dc8-483e-9f4e-4c7d853f4c46@linaro.org>
In-Reply-To: <d83a54db-4dc8-483e-9f4e-4c7d853f4c46@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 30 Nov 2023 12:31:02 +0100
Message-ID: <CAJZ5v0jWr6F4Ge_MAgK1zHNv1sWAPNO3Q=Lr01C+j16_tzGasg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] thermal: trip: Rework thermal_zone_set_trip() and
 its callers
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 11:40=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
>
> On 29/11/2023 14:38, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Both trip_point_temp_store() and trip_point_hyst_store() use
> > thermal_zone_set_trip() to update a given trip point, but none of them
> > actually needs to change more than one field in struct thermal_trip
> > representing it.  However, each of them effectively calls
> > __thermal_zone_get_trip() twice in a row for the same trip index value,
> > once directly and once via thermal_zone_set_trip(), which is not
> > particularly efficient, and the way in which thermal_zone_set_trip()
> > carries out the update is not particularly straightforward.
> >
> > Moreover, some checks done by them both need not go under the thermal
> > zone lock and code duplication between them can be reduced quite a bit
> > by moving the majority of logic into thermal_zone_set_trip().
> >
> > Rework all of the above functions to address the above.
>
> The resulting change looks to me over complicate for the code it is
> supposed to improve. One new function, one enum and leaking the sysfs
> buffer to a function located outside of thermal-sysfs.c. That does not
> improve the readability IMO.
>
> The function thermal_zone_set_trip is only called from thermal_syfs.c
>
> Why not directly change the trip point temp/hyst value in the array in
> the thermal_sysfs functions and remove the function
> thermal_zone_set_trip() ?

I can do that if you prefer it.

