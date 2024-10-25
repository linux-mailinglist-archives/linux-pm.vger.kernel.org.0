Return-Path: <linux-pm+bounces-16444-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C62759AFFCC
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 12:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8EF11C2481C
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 10:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF66C200B9E;
	Fri, 25 Oct 2024 10:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aRSMQB3T"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E99F1FF7CA
	for <linux-pm@vger.kernel.org>; Fri, 25 Oct 2024 10:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729851110; cv=none; b=Drq9CECfKUValBd3I7+OTbFYuW7VE4ysAMEYXx1vO9ifXV/lWb8QXqhuLvk0uruvuD2ghBKGk+ArX5SxCB6a2h2n/o3L5ZQZq87jFh+gaAF2Btp65oGHDkUw4w5jWuZXEoJInxj2mKef5nWd1qJuiiTvcW0KbbimCBKLFg59McI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729851110; c=relaxed/simple;
	bh=NcF5NlARhc9rttUph2fFDKtzjKKxMIsZR0rLXYMN1Bo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fPigSGxyHObWI/VHDx0kBsxhocXrVmwvINDlRy1BwLqJgpazozuz1KZe5jALEYjLK0FcrMTcPzGrZK7g0oTBguUNhNvSAKmtuw83xv8XE1/t5uVdtJRI6lAOlgwYHu2af6MpPHpoKZjqOKhxsbEt8/ZUQ18xZaxttWyfDoaDqSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aRSMQB3T; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e34fa656a2so19466117b3.1
        for <linux-pm@vger.kernel.org>; Fri, 25 Oct 2024 03:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729851107; x=1730455907; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pkf9nRBkB80Bq3MKpjBngWsWTtl6Rx4Rgdt86QJ7P7g=;
        b=aRSMQB3TM57x73eRl5o45dtTK6nzNQE+evnm+YY89CaOtL7UVu6Pbiu+r+quCnLih6
         y7maKjqoRblINWLbLHLB0HXVQZm84JBvEgrwuOsyBkwftJb+K+B4vZ24bYR7++NrHJKM
         NO91sJ2B6USbXF9Us76v+Chuf7zIdhEMMiABvpQ3U29gyuAmt0vjXMsTxB4LmoVW2XC0
         fqDYzE5pG5/Ioa2CRCHcYmRtgHJ9j6ZJyZ0Fp7GHdHCGpjB+Ba2rICDpZM0KTE+Mb1UO
         dD9bP1QznxgQGhOsQ4oe3pLf5IUh8ZcDZDhJA2uTlHBuW1Gc6DnIzCAByj0zWXMIjGRL
         QtKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729851107; x=1730455907;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pkf9nRBkB80Bq3MKpjBngWsWTtl6Rx4Rgdt86QJ7P7g=;
        b=iwZY8WCgrqzJsm50anwsCoMZz9LjlWNEw/xWNPzcbIF5zjSQ1dWLVCf1L0qw+dPSQR
         olTGfSSmBhGBFFhr+OMKdOJKV30D1pWCp5M/M2qI3DLZnuw7P+zapK+hX5CX1IeWR3e9
         ZJsf15GCPhXKSwbxQRfEvH8rn2ORuBLXUZbE9ofNFHB7Va2Jj7fOCn9VK8BoaShLjjoV
         IZZkNB6bUazUdLwj0SQFi31JxjKwDlV1JPWM/9DLB8ze0dQxHYfQ6gFVzNTw2JBEviay
         iRCBF0qZVEJfiPSWddHHmhwE37U/y8K2mKlWtt0bSWl+lcJ6fntw/UEgBYC2k48iTeZ9
         3/ew==
X-Forwarded-Encrypted: i=1; AJvYcCWwDOWl9GAvXu3RVdKW/KMR5IFLaF3jtNwrCBJt3reVnEnMN76GrgSfZNVaZ9iV3cnXGzHo7yPIjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/3Xqhm+ldyTPydsoTsH353wo1hjU2Xh/Mns4ulJaYyNw69Nvx
	6qn/WyIahio8huspzjzJyNLNNBPUmeWbB0QBf1TTaxfn7SXA08J0D7BWI5tqJRuzygZgPZWXSoL
	yu4ofgZjdlJ01zBOke5lwbfrGeGOgv2AqMEvyWQ==
X-Google-Smtp-Source: AGHT+IFhzLcgcs/L0Xo5eHIlOxVTVTCvGQpIJ8zLoYotZJwVqJXphpuLV/3wEhh+Pt3fgM55yJPxDK0IR2Fz1nW32AQ=
X-Received: by 2002:a05:690c:dd4:b0:643:92a8:ba00 with SMTP id
 00721157ae682-6e7f0c46d68mr94570857b3.0.1729851107335; Fri, 25 Oct 2024
 03:11:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007060642.1978049-1-quic_sibis@quicinc.com>
 <ZwfsmqInJlqkQD_3@hovoldconsulting.com> <ae5eaef9-301f-7d3f-c973-faa22ae780ee@quicinc.com>
 <ZxkjqEmkBAsC6UkL@hovoldconsulting.com> <c8e7420b-a7b4-89cd-1b6e-c1f6693c062d@quicinc.com>
 <ik4dyfbphm7lkeipm2dbr7cmdfxewxd4jtuz2jfnscfwcyo2r4@lrin5hnsqvyd> <83b635a7-fc69-7522-d985-810262500cb3@quicinc.com>
In-Reply-To: <83b635a7-fc69-7522-d985-810262500cb3@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 25 Oct 2024 13:11:37 +0300
Message-ID: <CAA8EJppx1OmYnfSsMDebRRTbNb3dfAE_MM55T1SpLccP=s_K1A@mail.gmail.com>
Subject: Re: [PATCH V3 0/4] firmware: arm_scmi: Misc Fixes
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: Johan Hovold <johan@kernel.org>, sudeep.holla@arm.com, cristian.marussi@arm.com, 
	ulf.hansson@linaro.org, jassisinghbrar@gmail.com, 
	linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	konradybcio@kernel.org, linux-pm@vger.kernel.org, tstrudel@google.com, 
	rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 25 Oct 2024 at 09:46, Sibi Sankar <quic_sibis@quicinc.com> wrote:
>
>
>
> On 10/25/24 11:44, Dmitry Baryshkov wrote:
> > On Fri, Oct 25, 2024 at 11:38:36AM +0530, Sibi Sankar wrote:
> >>
> >>
> >> On 10/23/24 21:56, Johan Hovold wrote:
> >>> On Wed, Oct 23, 2024 at 01:16:47PM +0530, Sibi Sankar wrote:
> >>>> On 10/10/24 20:32, Johan Hovold wrote:
> >>>>> On Mon, Oct 07, 2024 at 11:36:38AM +0530, Sibi Sankar wrote:
> >>>>>> The series addresses the kernel warnings reported by Johan at [1] and are
> >>>>>> are required to X1E cpufreq device tree changes [2] to land.
> >>>>>>
> >>>>>> [1] - https://lore.kernel.org/lkml/ZoQjAWse2YxwyRJv@hovoldconsulting.com/
> >>>>>> [2] - https://lore.kernel.org/lkml/20240612124056.39230-1-quic_sibis@quicinc.com/
> >>>>>>
> >>>>>> The following warnings remain unadressed:
> >>>>>> arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> >>>>>> arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> >>>>>
> >>>>> Are there any plans for how to address these?
> >>>
> >>>> Sorry missed replying to this. The error implies that duplicate
> >>>> opps are reported by the SCP firmware and appear once during probe.
> >>>
> >>> I only see it at boot, but it shows up four times here with the CRD:
> >>
> >> https://lore.kernel.org/lkml/d54f6851-d479-a136-f747-4c0180904a5e@quicinc.com/
> >>
> >> As explained ^^, we see duplicates for max sustainable performance twice
> >> for each domain.
> >
> > If existing products were shipped with the firmware that lists single
> > freq twice, please filter the frequencies like qcom-cpufreq-hw does.
>
> That was a qualcomm specific driver and hence we could do such
> kind of filtering. This however is the generic scmi perf protocol
> and it's not something we should ever consider introducing :/

This depends on the maintainer's discretion.

>
> >
> >>
> >>>
> >>> [    8.098452] arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> >>> [    8.109647] arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> >>> [    8.128970] arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> >>> [    8.142455] arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> >>>
> >>>> This particular error can be fixed only by a firmware update and you
> >>>> should be able to test it out soon on the CRD first.
> >>>
> >>> Can you explain why this can only be fixed by a firmware update? Why
> >>> can't we suppress these warnings as well, like we did for the other
> >>> warnings related to the duplicate entries?
> >>>
> >>> IIUC the firmware is not really broken, but rather describes a feature
> >>> that Linux does not (yet) support, right?
> >>
> >> We keep saying it's a buggy firmware because the SCP firmware reports
> >> identical perf and power levels for the additional two opps and the
> >> kernel has no way of treating it otherwise and we shouldn't suppress
> >> them. Out of the two duplicate opps reported one is a artifact from how
> >> Qualcomm usually show a transition to boost frequencies. The second opp
> >> which you say is a feature should be treated as a boost opp i.e. one
> >> core can run at max at a lower power when other cores are at idle but
> >> we can start marking them as such once they start advertising their
> >> correct power requirements. So I maintain that this is the best we
> >> can do and need a firmware update for us to address anything more.
> >
> > Will existing shipping products get these firmware updates?
>
> They are sure to trickle out but I guess it's upto the oem
> to decide if they do want to pick these up like some of the
> other firmware updates being tested only on CRD. Not sure why
> warnings duplicates should block cpufreq from landing for x1e
> but if that's what the community wants I can drop reposting
> this series!

No, the community definitely wants to have cpufreq for X1E.
But at the same time some reviewers prefer to have a warning-free boot
if those warnings can't be really fixed. I don't have such a strict
position, but I'd prefer to see those messages at dev_info or dev_dbg
level.

Also, can we please have some plan or idea if somebody is actually
working with laptop vendors to get corresponding firmware updates onto
their hardware?

-- 
With best wishes
Dmitry

