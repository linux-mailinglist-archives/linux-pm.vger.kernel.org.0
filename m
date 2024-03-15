Return-Path: <linux-pm+bounces-4992-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE9387D284
	for <lists+linux-pm@lfdr.de>; Fri, 15 Mar 2024 18:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5055E1C20A16
	for <lists+linux-pm@lfdr.de>; Fri, 15 Mar 2024 17:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A653EA97;
	Fri, 15 Mar 2024 17:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mcvYeFXS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95227482D7
	for <linux-pm@vger.kernel.org>; Fri, 15 Mar 2024 17:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710522751; cv=none; b=L8CedP8Zi2Ir42nM4u9aaZvM32Y/tY0r07IZTO6L9tEb815WswOXVuiwTgaxztsPDu87pVVaX+X2PM58ViQuJ/kq/Il15Ht76mY80LpWSGDl5w1EVIEEWfeC9px3OQO4wXc6xKDnm2vlUKonjbIVw/0+GD7x6mIFhXy7a5Y7rRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710522751; c=relaxed/simple;
	bh=kWzlo4AaZeWtEkzCy8TJZmtsYDqVVCm/XwSPAebW3DI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OJ6Uqq24QJ+IgwSMoDh7/wPqKrujEhOTCBk5PmYow9SHX339eKzU9rsbDoabOFWi1ZH1v1tlsyOy7P+q0eF+cHbzE5O1KwJ9TBO4rn055ZDLoU50XZQ0HWatKz3ncboMtiX2L4EFr9qLeoHOiPCZYzSN2gx8R1qpqJJhK8B7Gn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mcvYeFXS; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-430b6e9936aso2994281cf.3
        for <linux-pm@vger.kernel.org>; Fri, 15 Mar 2024 10:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710522748; x=1711127548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBgzsheMyMt2wDXPPT0VYLjrPGEmgjQ97XLNs9yUYLg=;
        b=mcvYeFXSE6MZxzpuKV/zc1qk1DMAFtYtxUcE0LgQR+i3HQivAiBG16+lNCCcJv7P12
         CeuH68DWGw3nDflzUI+X+ov/e1yvx+WjtC1r9Xd9e3C1FIspjNOAGC1OeRS700g0oDoB
         brU+HeBeIdrHYY9xwzseILBibCrNzKSi+OUXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710522748; x=1711127548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBgzsheMyMt2wDXPPT0VYLjrPGEmgjQ97XLNs9yUYLg=;
        b=dFHI3c/O9bntC3plHsckGT50+dLLhSfn4Het+fDgSEfONOmKfvGqzwq7xoRuYCqeUh
         pmOexa4WYgvmtJ7x0FxAcoXZMtxRmrlOwhODhv7IgbH4QoGpX1IUQvsJyOZ3s1MF2jLc
         5RIjEep5orapC5VnxECwn5HwnHrF1OKijsLo2dBKjQq1XI/5n5m9UdjQngUBk4qVH1wE
         eqF6MNWzQ93zi79fyShY4cD4Igeph5NHtCniM93YHWkOFEaWMpPK5fB4aMwbjlDNhh1u
         M5oZo1tUVP4bWMGkwQSt3tlYyDhZVlu5Y+YoYMph4B20PnjHkH/aCGDejXtRTMhAkbS2
         H49g==
X-Forwarded-Encrypted: i=1; AJvYcCU6u64YWEtMODaspHW1VJ5+qBL2sXkCSZbnVCaDpKiadRXu2ozYbqVriTwk8C423ITf5uENdC2Qr8v6ZgvKICNzWKtibr1Yj/g=
X-Gm-Message-State: AOJu0YzjTg/xvOdtOKAnGiCSHAbpoxBG873Z7VHs9qHtGi49e1wunOZ+
	L7l6BEhRrReDaCHc0jz4EgN6tS+o72ew/Dlmbt/siLf4dAwoUn1A/q0EoJHYOtdWEPE4pZMUnUI
	=
X-Google-Smtp-Source: AGHT+IERa600I06iAf/xFfzU38LOfUlXor4Us6idxt/e9PK1zQyu9hvx+G0C/1q3WzSKTtcpxlTWqg==
X-Received: by 2002:ac8:5c10:0:b0:42e:57b7:b239 with SMTP id i16-20020ac85c10000000b0042e57b7b239mr6176310qti.20.1710522748544;
        Fri, 15 Mar 2024 10:12:28 -0700 (PDT)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com. [209.85.160.176])
        by smtp.gmail.com with ESMTPSA id u18-20020ac87512000000b0042f09265a34sm2145532qtq.91.2024.03.15.10.12.28
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 10:12:28 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-428405a0205so7781cf.1
        for <linux-pm@vger.kernel.org>; Fri, 15 Mar 2024 10:12:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVnhvVLhzyNF8ShXrjpIspDXVXxqJCTFz3LUPVHJZs/Dqu+QCcpmdOK8GanHwFMAvv0St7PEqpnvauxT6M9jO7llm5w5OsaO+o=
X-Received: by 2002:a05:622a:1706:b0:42f:a3c:2d53 with SMTP id
 h6-20020a05622a170600b0042f0a3c2d53mr822108qtk.20.1710522747755; Fri, 15 Mar
 2024 10:12:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230703085555.30285-1-quic_mkshah@quicinc.com>
 <20230703085555.30285-4-quic_mkshah@quicinc.com> <CAD=FV=XWH+Eoa9XjDns--NSDTZHeUwTdrX_r_QZhSPpbZNwz+w@mail.gmail.com>
 <20240315152431.sckqhc6ri63blf2g@bogus>
In-Reply-To: <20240315152431.sckqhc6ri63blf2g@bogus>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 15 Mar 2024 10:12:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UD1nuxryvWH=Mi7E+QzMoa7xCHebY0DtZCAVmEW3ZeAg@mail.gmail.com>
Message-ID: <CAD=FV=UD1nuxryvWH=Mi7E+QzMoa7xCHebY0DtZCAVmEW3ZeAg@mail.gmail.com>
Subject: Re: [RESEND v4 3/3] arm64: dts: qcom: sc7280: Add power-domains for
 cpuidle states
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Maulik Shah <quic_mkshah@quicinc.com>, andersson@kernel.org, ulf.hansson@linaro.org, 
	swboyd@chromium.org, wingers@google.com, daniel.lezcano@linaro.org, 
	rafael@kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, jwerner@chromium.org, 
	quic_lsrao@quicinc.com, quic_rjendra@quicinc.com, devicetree@vger.kernel.org, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Rob Clark <robdclark@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 15, 2024 at 8:24=E2=80=AFAM Sudeep Holla <sudeep.holla@arm.com>=
 wrote:
>
> On Thu, Mar 14, 2024 at 04:20:59PM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Mon, Jul 3, 2023 at 1:56=E2=80=AFAM Maulik Shah <quic_mkshah@quicinc=
.com> wrote:
> > >
> > > Add power-domains for cpuidle states to use psci os-initiated idle st=
ates.
> > >
> > > Cc: devicetree@vger.kernel.org
> > > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
> > > ---
> > >  arch/arm64/boot/dts/qcom/sc7280.dtsi | 98 +++++++++++++++++++++-----=
--
> > >  1 file changed, 73 insertions(+), 25 deletions(-)
> >
> > FWIW, I dug up an old sc7280-herobrine board to test some other change
> > and found it no longer booted. :( I bisected it and this is the change
> > that breaks it. Specifically, I can make mainline boot with:
> >
> > git revert --no-edit db5d137e81bc # arm64: dts: qcom: sc7280: Update
> > domain-idle-states for cluster sleep
> > git revert --no-edit 7925ca85e956 # arm64: dts: qcom: sc7280: Add
> > power-domains for cpuidle states
> >
>
> IIRC, this could be issue with psci firmware. There were some known
> issues which were discussed few years back but I am not aware of the
> details and if/how it is applicable here.
>
> Not sure if you are getting any logs during the boot, if you do have
> worth look at logs related to PSCI/OSI/Idle/...

Given that the new firmware fixes it I'm going to say it's not worth
looking into any longer.

-Doug

