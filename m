Return-Path: <linux-pm+bounces-16429-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D049AF9B4
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 08:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 696371C22157
	for <lists+linux-pm@lfdr.de>; Fri, 25 Oct 2024 06:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A21A1AD3F5;
	Fri, 25 Oct 2024 06:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="srrnh1FG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2B819B59F
	for <linux-pm@vger.kernel.org>; Fri, 25 Oct 2024 06:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729836905; cv=none; b=ke9ZJ5hOK7bxsFMy7r4JWBHNRdkVNWQkVjx+z9WICgMMJ6LizMvyChK+ggEcZtN/VTlNefKbEQulZn2JhSqobq/bGp9lJfCM+amNDn0wNaddl9qwRvG4j7lxkWB4/Pysq/s1ug+65huooro7Ahd66Z9hFHKjeoxvKLx/Wzh3898=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729836905; c=relaxed/simple;
	bh=l37rPw0+hRN8iQEG8/Tq90tKbmUaifstnhH6mKJZa3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsF5GzF+dRLfF7koW/PvIdJzVuFlNGyK29xvFunZfM0mM0LahIKNfM2jMpzHwsK8tM0rz9A7A2l52yOFXHziisAnJMVKYUIWFhPIFKzcdSe787KinFks99r0M2M0z7AJ60sjEUa0C+Aw0iKVHgnNaVJRVzdaBb7RKaA99xZR+NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=srrnh1FG; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539f72c8fc1so2102152e87.1
        for <linux-pm@vger.kernel.org>; Thu, 24 Oct 2024 23:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729836901; x=1730441701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6dafrAS7mWtYzr7LttuBBIbNqQDmpOjzk4+u3c2ZQq4=;
        b=srrnh1FGEXCLJJHLa/Q34b9mrnpXft/rlv4W85m7o7bjVp9PRj/tWiNFav7+NR+OFN
         LvL/+deRadensGWCEfII9yvwmpvF8PHwq4EcscZVaGpSG27h/T8lCSSA9OuIy1oSZPQn
         OLacwvmIw/NrUPO1wsFFMitAJywwHaUAPW53OW7baiaADc0eXXZWj9ZbIL9ju38RE56Q
         Qp2T68GxqAttWB5Y9u2lWJefLgpSecCiYaM8G0fgLi4NvvRTaTfFXUzs941bmQgXnjyS
         8qbmbpJKegwNMoe1+dWwwZnGUhC2xvgOh2/WfamqusEEwcRZfS40CPEPcS49W0wV7pD7
         bG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729836901; x=1730441701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6dafrAS7mWtYzr7LttuBBIbNqQDmpOjzk4+u3c2ZQq4=;
        b=olSqtxCSLS2azqjuBMV04v0GzLWJxzgSAXAGQ3CPvxA2LkeZKICqXJF2nKNZ53eLQv
         s2lfQ2VpgtHEJD5JzZIt6vBqa45RZKXBeS9yTHDgdQLNHVD+78QpQrvHZwwA9bMcBx75
         JvMveq+OOIGiLlu1yzeq1cYgtPdAWZxVqXNgr5gXfYAJMn1YC4ziP0bRKqrjxLiEM8qH
         wcclpijpe5NNYxUTasEEPP8PJ8p5RpPcYUjcZFZDplnLwK41zaU/0RToxE8q70PfS/qU
         xCMNgbys6tXGCI3DiT7I1/STzWwyYG4xXE7sHyt3ccyOO1DNUBnntsHBfMdZGriH9gUg
         JzEA==
X-Forwarded-Encrypted: i=1; AJvYcCWNU4aaii80YYHrdA/7W61gKuOaRhGqBO0H9VHf+HhEI8NVd8LLLx9H5aOC+cOgph9MJLymT1/v0A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8mQPNJVBzRqPz25EIj7oZZzkI7M1Be82aqtVevYMOifrQTkrQ
	y5aN8ot4TQnkIvlWaEMoxRZEI8IoB8eKWBiBCdzGsXHDT/XN+vrshAnWlQ3cQ6Q=
X-Google-Smtp-Source: AGHT+IEj1g8Dwn/22dB4VOnNssyoLCJf860JbkqpJsBfmXzprn8TQfRv4vuKdN8e3pyTKN/OTDF1oA==
X-Received: by 2002:a05:6512:1256:b0:536:55ef:69e8 with SMTP id 2adb3069b0e04-53b1a2430a2mr4964368e87.0.1729836900985;
        Thu, 24 Oct 2024 23:15:00 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1de058sm66320e87.240.2024.10.24.23.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 23:14:59 -0700 (PDT)
Date: Fri, 25 Oct 2024 09:14:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: Johan Hovold <johan@kernel.org>, sudeep.holla@arm.com, 
	cristian.marussi@arm.com, ulf.hansson@linaro.org, jassisinghbrar@gmail.com, 
	linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, konradybcio@kernel.org, linux-pm@vger.kernel.org, 
	tstrudel@google.com, rafael@kernel.org
Subject: Re: [PATCH V3 0/4] firmware: arm_scmi: Misc Fixes
Message-ID: <ik4dyfbphm7lkeipm2dbr7cmdfxewxd4jtuz2jfnscfwcyo2r4@lrin5hnsqvyd>
References: <20241007060642.1978049-1-quic_sibis@quicinc.com>
 <ZwfsmqInJlqkQD_3@hovoldconsulting.com>
 <ae5eaef9-301f-7d3f-c973-faa22ae780ee@quicinc.com>
 <ZxkjqEmkBAsC6UkL@hovoldconsulting.com>
 <c8e7420b-a7b4-89cd-1b6e-c1f6693c062d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8e7420b-a7b4-89cd-1b6e-c1f6693c062d@quicinc.com>

On Fri, Oct 25, 2024 at 11:38:36AM +0530, Sibi Sankar wrote:
> 
> 
> On 10/23/24 21:56, Johan Hovold wrote:
> > On Wed, Oct 23, 2024 at 01:16:47PM +0530, Sibi Sankar wrote:
> > > On 10/10/24 20:32, Johan Hovold wrote:
> > > > On Mon, Oct 07, 2024 at 11:36:38AM +0530, Sibi Sankar wrote:
> > > > > The series addresses the kernel warnings reported by Johan at [1] and are
> > > > > are required to X1E cpufreq device tree changes [2] to land.
> > > > > 
> > > > > [1] - https://lore.kernel.org/lkml/ZoQjAWse2YxwyRJv@hovoldconsulting.com/
> > > > > [2] - https://lore.kernel.org/lkml/20240612124056.39230-1-quic_sibis@quicinc.com/
> > > > > 
> > > > > The following warnings remain unadressed:
> > > > > arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> > > > > arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> > > > 
> > > > Are there any plans for how to address these?
> > 
> > > Sorry missed replying to this. The error implies that duplicate
> > > opps are reported by the SCP firmware and appear once during probe.
> > 
> > I only see it at boot, but it shows up four times here with the CRD:
> 
> https://lore.kernel.org/lkml/d54f6851-d479-a136-f747-4c0180904a5e@quicinc.com/
> 
> As explained ^^, we see duplicates for max sustainable performance twice
> for each domain.

If existing products were shipped with the firmware that lists single
freq twice, please filter the frequencies like qcom-cpufreq-hw does.

> 
> > 
> > [    8.098452] arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> > [    8.109647] arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> > [    8.128970] arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> > [    8.142455] arm-scmi arm-scmi.0.auto: Failed to add opps_by_lvl at 3417600 for NCC - ret:-16
> > 
> > > This particular error can be fixed only by a firmware update and you
> > > should be able to test it out soon on the CRD first.
> > 
> > Can you explain why this can only be fixed by a firmware update? Why
> > can't we suppress these warnings as well, like we did for the other
> > warnings related to the duplicate entries?
> > 
> > IIUC the firmware is not really broken, but rather describes a feature
> > that Linux does not (yet) support, right?
> 
> We keep saying it's a buggy firmware because the SCP firmware reports
> identical perf and power levels for the additional two opps and the
> kernel has no way of treating it otherwise and we shouldn't suppress
> them. Out of the two duplicate opps reported one is a artifact from how
> Qualcomm usually show a transition to boost frequencies. The second opp
> which you say is a feature should be treated as a boost opp i.e. one
> core can run at max at a lower power when other cores are at idle but
> we can start marking them as such once they start advertising their
> correct power requirements. So I maintain that this is the best we
> can do and need a firmware update for us to address anything more.

Will existing shipping products get these firmware updates?

-- 
With best wishes
Dmitry

