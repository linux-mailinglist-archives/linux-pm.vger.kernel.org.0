Return-Path: <linux-pm+bounces-4994-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3200087D2D5
	for <lists+linux-pm@lfdr.de>; Fri, 15 Mar 2024 18:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A184B22359
	for <lists+linux-pm@lfdr.de>; Fri, 15 Mar 2024 17:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2F6482EB;
	Fri, 15 Mar 2024 17:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f8bSTqO9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60005482EE
	for <linux-pm@vger.kernel.org>; Fri, 15 Mar 2024 17:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710523937; cv=none; b=o7JzMxN8mBho4ncWeCXi6yCM3bCOpUo637yUxccmCs7kYUo2B6divTPzNRbzXBeX9Q0R/TzMa7kDSYT6VdpSS/hvsHterKq/zFfx8n2hPHKyQzKvI02P7WCwAjvD2KdziRZd7Hl4oxjxpK1otM3KY0KeVLeaEqXGp6xIQtJtOJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710523937; c=relaxed/simple;
	bh=0LTEsN2O/FgSWhZk5KJW+7bWr7jqaVlwguZyG5cUT4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E3c2nyA/KPStCS2P5rK7jyniZKoTpQVGIUhHgnWMiKG4BC/2MUu/VuDicGjNx+YybcvFMRrOPVco8AHuGc0UP0v3wgfu2pigAvJNxCbDRcXNYYkc60U2NX0leD9SFDvfpRvSDtZciz/zpnwr8j+ic0Q49Io4heDbuffvJXRE+jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=f8bSTqO9; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bbc649c275so1374269b6e.0
        for <linux-pm@vger.kernel.org>; Fri, 15 Mar 2024 10:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710523933; x=1711128733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35pY7i/gjcm69pUN8AAJZNQoGf0jouiTU8qeW6pOlqY=;
        b=f8bSTqO97dV4NRJXwZOl8YCt1H6UwzdG2nE4ckdX1+3D8he/Z50iGd5+odKUcGv0QN
         wQlU5fCVL2DFGlklRH7dTu8rGNkw01oIdqgOpCWBBPol8FebO0CfWdT/THoa7Np1tKC6
         GesErz+qFnXqYhMXkAz7+5usnRQ7+gtJpuvGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710523933; x=1711128733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=35pY7i/gjcm69pUN8AAJZNQoGf0jouiTU8qeW6pOlqY=;
        b=CWJadntkZcYaIZl0LZN/+iEiQsRoWXe61CbS3k6VoaLq2hm53hAFdeyD7e6uZs/VEu
         XExU7tqr0UQCPdH/6XQQaTLQ+HRlBTogV6RUXWLl5X2bw5dIRQaV+EC7Bh7zCppm4yAU
         7JsisfLoethclWWNGid2DhWWlN+iWPtUHDpyfyBkjfqOg5Zildf6wxDfVhAU9KdXpe45
         +g5axKGCfYeiBTx5tBTIMXCDVSxh6u7i5RNNDZKSkvyuKenL1llM9KsU8ef1SDMnt6xb
         /kqSG8JjFlu5zQeVfapTU/NfFXCyaiFlGnGk53zOs9mKvVQBZwdISbApNva83Lb7jfni
         q9Xg==
X-Forwarded-Encrypted: i=1; AJvYcCXknL8FYyu6hQPdOlsMaxRv+aIIoOW2XC1cDSybjOFFvD7GPQmYpkiokdIMofTxrGeEKtrMo89o1PNbMZlHPmX8E7J6q8vVUZU=
X-Gm-Message-State: AOJu0Yxsg8T8y+I4lew+GxtCa+0WSscBAZq7a5CJMfF+LKSImLLb9Uie
	2OQv2QN+IgH1M1nTgogDSLwQ6MTYJH7prJ7XpyBQ+yYePoba1H+MJyKa+Ds/cprSKVU+6Feur+8
	=
X-Google-Smtp-Source: AGHT+IHUc/iaysYpxdwfAh4OH6mbRYuJpkzs5ge5G6+Ks+xziSx43m3azzRGd2MUx0YACYFTX30TJQ==
X-Received: by 2002:a05:6808:14c2:b0:3c3:660b:2884 with SMTP id f2-20020a05680814c200b003c3660b2884mr4760932oiw.25.1710523933304;
        Fri, 15 Mar 2024 10:32:13 -0700 (PDT)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com. [209.85.160.170])
        by smtp.gmail.com with ESMTPSA id bm12-20020a0568081a8c00b003c1e9fc1a20sm684526oib.28.2024.03.15.10.32.12
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 10:32:12 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-43095dcbee6so17891cf.0
        for <linux-pm@vger.kernel.org>; Fri, 15 Mar 2024 10:32:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVhz6Rg3YKMRo31IkHSX62wAaqKaIZXqjK4Fu699jCCPkL/NcLn7hFv7TN6hC8kz+H5wwEeuwaJfDahxknvzwVQhxK197GmiGU=
X-Received: by 2002:ac8:470b:0:b0:42e:e40f:fca4 with SMTP id
 f11-20020ac8470b000000b0042ee40ffca4mr311095qtp.13.1710523931775; Fri, 15 Mar
 2024 10:32:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230703085555.30285-1-quic_mkshah@quicinc.com>
 <20230703085555.30285-4-quic_mkshah@quicinc.com> <CAD=FV=XWH+Eoa9XjDns--NSDTZHeUwTdrX_r_QZhSPpbZNwz+w@mail.gmail.com>
 <20240315152431.sckqhc6ri63blf2g@bogus> <CAD=FV=UD1nuxryvWH=Mi7E+QzMoa7xCHebY0DtZCAVmEW3ZeAg@mail.gmail.com>
 <20240315172632.6zxwj4enq4tddbb3@bogus>
In-Reply-To: <20240315172632.6zxwj4enq4tddbb3@bogus>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 15 Mar 2024 10:31:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X+d8E67fxk0FiLqp3bpR4ZCEB1+bN21V3Lw_XA5JNQag@mail.gmail.com>
Message-ID: <CAD=FV=X+d8E67fxk0FiLqp3bpR4ZCEB1+bN21V3Lw_XA5JNQag@mail.gmail.com>
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

On Fri, Mar 15, 2024 at 10:26=E2=80=AFAM Sudeep Holla <sudeep.holla@arm.com=
> wrote:
>
> On Fri, Mar 15, 2024 at 10:12:12AM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Fri, Mar 15, 2024 at 8:24=E2=80=AFAM Sudeep Holla <sudeep.holla@arm.=
com> wrote:
> > >
> > > On Thu, Mar 14, 2024 at 04:20:59PM -0700, Doug Anderson wrote:
> > > > Hi,
> > > >
> > > > On Mon, Jul 3, 2023 at 1:56=E2=80=AFAM Maulik Shah <quic_mkshah@qui=
cinc.com> wrote:
> > > > >
> > > > > Add power-domains for cpuidle states to use psci os-initiated idl=
e states.
> > > > >
> > > > > Cc: devicetree@vger.kernel.org
> > > > > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
> > > > > ---
> > > > >  arch/arm64/boot/dts/qcom/sc7280.dtsi | 98 +++++++++++++++++++++-=
------
> > > > >  1 file changed, 73 insertions(+), 25 deletions(-)
> > > >
> > > > FWIW, I dug up an old sc7280-herobrine board to test some other cha=
nge
> > > > and found it no longer booted. :( I bisected it and this is the cha=
nge
> > > > that breaks it. Specifically, I can make mainline boot with:
> > > >
> > > > git revert --no-edit db5d137e81bc # arm64: dts: qcom: sc7280: Updat=
e
> > > > domain-idle-states for cluster sleep
> > > > git revert --no-edit 7925ca85e956 # arm64: dts: qcom: sc7280: Add
> > > > power-domains for cpuidle states
> > > >
> > >
> > > IIRC, this could be issue with psci firmware. There were some known
> > > issues which were discussed few years back but I am not aware of the
> > > details and if/how it is applicable here.
> > >
> > > Not sure if you are getting any logs during the boot, if you do have
> > > worth look at logs related to PSCI/OSI/Idle/...
> >
> > Given that the new firmware fixes it I'm going to say it's not worth
> > looking into any longer.
> >
>
> But it would be good to know if that is the exact reason, see if it can
> be upgraded, or else we can disable them by default. The bootloader or
> something else can detect the f/w version and enable them so that the
> board with old f/w(if can't be upgraded) can still be used.
>
> Otherwise it is a regression IMO.

I think it only would really matter if the problematic firmware
actually made it out into the real world. In this case the only people
who run into this are developers at Google and Qualcomm who had early
versions of hardware and had old firmware sitting around on them. I
can count the number of folks affected on one hand, and that's even if
one of my fingers gets cut off. All of those folks can just upgrade
their firmware since there is no downside in doing so.

-Doug

