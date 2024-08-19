Return-Path: <linux-pm+bounces-12437-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB6B956CB9
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 16:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6562C1F22B73
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 14:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303FE16C879;
	Mon, 19 Aug 2024 14:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avXuoOnL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC8116CD01
	for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2024 14:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724076484; cv=none; b=kolNmCaPGLO7qHUVP2P09pQcfgPc9v8pS2RpPo6Yj6hJMB4G7PttzaHIYgYSHUH/Bg84MNfFciGFKecXO1fdkFRnuD9q2IZACviO2DjzKYgVltbML/fkgHd5y6sWJXk+IwsUzBeDw0teQ/YTbQK5ThV7XIrU+a4adnHG2kawQc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724076484; c=relaxed/simple;
	bh=oO2rA83OOIsuPzeAiZWcP09+Pv0YDhQSjoFvrIxxRB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DwdbmUHbWcaWlMYqUv74ViKVuHSledbAfTjyr7Lfl9HS7b5D1WXD5OjKY/7d3J2WGSv4xLWX0dXMMAWnxGQ/12bMD5mlDXKi4MCZOK7Bzb4ENr6NPfCBBm0V2VKhvTN1FJce1K/yMaXDBB8cUXQTNNifmmdBDkpGp9ixlj3LtCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avXuoOnL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C906EC4AF0F
	for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2024 14:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724076483;
	bh=oO2rA83OOIsuPzeAiZWcP09+Pv0YDhQSjoFvrIxxRB8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=avXuoOnLpkRAX0lGKdwp5EqQ5fMeNJyeFoV+Pl3vwt3oB/SNDum+mHT2X5kCUQYQo
	 HcVen29G87mu3eJ47gYe2sRv/W1hcxbPVoIiW/6hMaUScebh7DnyEha93lOHdNcaPn
	 FOd/GrFd1Ow+riYB92IQIpOD5ePL0KK+RGNum0JChYfaBzAAGas+xsAGJ9MlVPpxPK
	 fUew4IMv4WO0/Ma+lpmEK/Btbt3iFobTNMlWYWZlWKFdF0M8kAaAK9pVz+QszShD4j
	 +99jjXKto49YMt6trU2pQ0Saz2KqylVsMoapuWlz+zq1yw7hyD5Eb/ffumZQQs06u4
	 3agELaCyRli/w==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-26456710cfdso616292fac.0
        for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2024 07:08:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX9McjLrMDKiNfjFXOToPJgKzFms4xEpsUpe7cwpG+6VBFzJ/dUTjpeD0YgUtjDbgNtvbhND1Z+FrEHKDn5kwyAn0XbBFGEIF8=
X-Gm-Message-State: AOJu0Yx4gMT6slbzXQwrCVgVixG5NdayjrXv//T9saYHkSg55g/XZNyt
	iqmAzWXftL1JBPOGUpGFHRAJ50FiwiqlB0/hDwWORwgcRYkCoAKhw8dTRMYWhalFEzHyKfOvn+o
	iNiDoEy0I3vkWIRXacfsTBepHVZI=
X-Google-Smtp-Source: AGHT+IEX1qx0RxpWM4AsaxrVi/qcjul5EpfddSW5m+SBscXl7ubxrdW4NQZgX6U7sBAurhs0SotMsElWj37R4x3HAZY=
X-Received: by 2002:a05:6870:c6a1:b0:261:934:873d with SMTP id
 586e51a60fabf-2701c522026mr5806993fac.5.1724076483053; Mon, 19 Aug 2024
 07:08:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816081241.1925221-1-daniel.lezcano@linaro.org>
 <20240816081241.1925221-2-daniel.lezcano@linaro.org> <CAJZ5v0iS+iJBsURzfeipum2ekPfxDGLKrotEkH10_FQhUKvbiA@mail.gmail.com>
 <5bc4655d-ab7c-48b1-b1b0-443fe0a7bd1b@linaro.org>
In-Reply-To: <5bc4655d-ab7c-48b1-b1b0-443fe0a7bd1b@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 19 Aug 2024 16:07:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gm6ZabA3vbzg_E4PU4bi-qNv4pWLAn96xNVRcZ8UXidQ@mail.gmail.com>
Message-ID: <CAJZ5v0gm6ZabA3vbzg_E4PU4bi-qNv4pWLAn96xNVRcZ8UXidQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] thermal/core: Compute low and high boundaries in thermal_zone_device_update()
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, lukasz.luba@arm.com, 
	quic_manafm@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 2:06=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 16/08/2024 13:34, Rafael J. Wysocki wrote:
> > On Fri, Aug 16, 2024 at 10:12=E2=80=AFAM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> In order to set the scene for the thresholds support which have to
> >> manipulate the low and high temperature boundaries for the interrupt
> >> support, we must pass the low and high values to the incoming
> >> thresholds routine.
> >>
> >> The variables are set from the thermal_zone_set_trips() where the
> >> function loops the thermal trips to figure out the next and the
> >> previous temperatures to set the interrupt to be triggered when they
> >> are crossed.
> >>
> >> These variables will be needed by the function in charge of handling
> >> the thresholds in the incoming changes but they are local to the
> >> aforementioned function thermal_zone_set_trips().
> >>
> >> Move the low and high boundaries computation out of the function in
> >> thermal_zone_device_update() so they are accessible from there.
> >>
> >> The positive side effect is they are computed in the same loop as
> >> handle_thermal_trip(), so we remove one loop.
> >>
> >> Co-developed-by: Rafael J. Wysocki <rjw@rjwysocki.net>
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >
> > Looks good to me and I'd like to apply it earlier separately as I have
> > material depending on it in the works.
>
> Sure

Applied as 6.12 material, thanks!

