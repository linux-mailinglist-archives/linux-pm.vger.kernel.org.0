Return-Path: <linux-pm+bounces-27348-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0D0ABC018
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 16:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE6EE3A6D8A
	for <lists+linux-pm@lfdr.de>; Mon, 19 May 2025 14:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43ED6281376;
	Mon, 19 May 2025 14:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x20Bq8eG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819A01DFFD
	for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 14:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747663288; cv=none; b=Os9bPdUrjcziNnkHyAz2Jlh1GvMA01iKU0IbAsOT5pUowPiQimfuzGc9P9cBALbKU0bAXGoeuSd9qYKLcwpdTcDgXbRJbm1/rF/s/MjeHspSZhqU9RGzqTcYMWeZEUdY3EbzQS8QBiUnBVHxG6vSYfVfjOyyYPujkcoHJtie96Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747663288; c=relaxed/simple;
	bh=aLuvRgvb3s7BTkwnIQO1uDxvC7yDCvP5XMIFuZd8GwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I57KS2/4p/vT/Nlmkf0qEVNBu5HxjxtXuPNjFA1YEBS93TdK/mSVPnZbd6TA9KK1IZa6yUNMNCi2iRV4V7eBE2GeYM/TmkzQNcwGFAMkTAoEXYeTaMFL86MyLIQMXAeFYDijpSlGs/lasRpaUzhalPZSGONOSLpquICHHk/7cM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x20Bq8eG; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e7387d4a336so3668446276.2
        for <linux-pm@vger.kernel.org>; Mon, 19 May 2025 07:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747663285; x=1748268085; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aLuvRgvb3s7BTkwnIQO1uDxvC7yDCvP5XMIFuZd8GwA=;
        b=x20Bq8eGf7mLbtjTWFTDZwS8k4G796nwUCkrhjxgJvWvuZSBSVIXJFPPoA/Y+4r1SL
         9jd0fs5Azlq25yqqkkZoM5kk3c2MoUH0Ysk2DDrnVzprSat5ktQu1Ib/cmLMy7wvEm6L
         XPjkCdly0yZw75C/MFhaMwpE6/qv45RFQaUcfeAuh1LgZsKbTlCkN0M6MBrYaRutQ9CJ
         EaeMEbO1zC4aoSyistnAtiAyFV/lmF0U2RyoUgFVgha9n4+N7ox6Gj18NRATZ/Fg6bXR
         8BU83oZuQwmZHuxNPmeQSS4eacauqzzQQrorQukcjnkX+pgeOyRAnu6oyZb2krZDxA6z
         cVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747663285; x=1748268085;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aLuvRgvb3s7BTkwnIQO1uDxvC7yDCvP5XMIFuZd8GwA=;
        b=XW86QxKsPQsbfYPMj+sVSYMe0neBJl9HhTN0e/1FaB/Nb3bMc+ARNlLALAWtZVd2mC
         QcjlFY6keo36KXk8FtJzpe+5as2oibU4t2oSG2U0gp1/9FLCJMBjiArJodM9zJaKLhIq
         AsRtaJpswWApH6IamcPyqc/qKngHnuekhRp/F+luIpNIU3vyFEJnPoMMrXWUXAsbFXWq
         1+PlkgWH/eE/PgsEokIRnaHCQNPuowgcWGVc1DBkRMcu6vRttA0MNVcanRxz164ZUH7a
         op6ByVOe77FH9kSNEUrXj20GCBFKfWh4780k/BPQBKUrpwNfCBQEqe65ktG+3OVYmTZo
         BhZw==
X-Forwarded-Encrypted: i=1; AJvYcCVYIRGo9gjluXk4JEcRunr+KS14SWwMbxoTzGA/9KJg5anA8kchl1BrG20fBTS0jf3bHym4BiVwLA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcNqZXctw6zeSrG+9nKLWVkkduXwlgfcwGN0UlnyO7B0jLg93x
	UzpdJYFK5SItG99gvSI/EpXGH1E5RswSFTMlAGgMuoNdAAHOBmlj1FsITL7ZQn7G4F36u52XbKm
	RCI5VoO0Xs0/oJV76q2jRHMKL7pD1dMFH+HTftiDSXg==
X-Gm-Gg: ASbGncvJVQVoyXhcAHvIYcTH1txKZxF0J0MTn/Orr5UjA0vwDM52EMiumIGfXt/LkMp
	ccwsKHBytWytGPUnaTsr810vqreILoW5SsB7Qts9QQ7Eo8Csbmypgim+aPU5BbT/DUCRRd1ASUJ
	7KtoqZXja2JOKoxdxT84KgGzh91GAlFnNmpA==
X-Google-Smtp-Source: AGHT+IGymy4KwEyW6tUTDmkKCdWsD1NdA2BXUsfFPtuQu5zTUxG8N+u0+twFQNQlgv1A85rUxSkjp/XUGAYDWxieAxI=
X-Received: by 2002:a05:6902:4aa:b0:e7b:8251:9904 with SMTP id
 3f1490d57ef6-e7b8251bc0cmr9661682276.34.1747663284841; Mon, 19 May 2025
 07:01:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101024421.26679-1-quic_msana@quicinc.com>
 <1e47ee3e-7439-4dc4-aef6-0ad2f82ee341@intel.com> <CAPDyKFrku7pEPz0xNbtJetK1XhUmhgsN9Sx9Ea8=tNNhTkxa7w@mail.gmail.com>
 <5cb72bb7-7393-6d3f-d003-e20a21bd607f@quicinc.com>
In-Reply-To: <5cb72bb7-7393-6d3f-d003-e20a21bd607f@quicinc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 19 May 2025 16:00:49 +0200
X-Gm-Features: AX0GCFtvt1Ewn2676BRWcozy6UpOsMiezUEmqWm-EAduBWMtSn60NlzHYQvLUBY
Message-ID: <CAPDyKFrXXLps31gqqWnqniSrEPcstE3wyCMK6L0TF--CoOJ9ug@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhc: Add PM QoS support for mmc driver
To: Ram Prakash Gupta <quic_rampraka@quicinc.com>
Cc: Madhusudhan Sana <quic_msana@quicinc.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	quic_cang@quicinc.com, quic_nguyenb@quicinc.com, quic_bhaskarv@quicinc.com, 
	quic_mapa@quicinc.com, quic_narepall@quicinc.com, quic_nitirawa@quicinc.com, 
	quic_sachgupt@quicinc.com, quic_sartgarg@quicinc.com, 
	Linux PM list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 May 2025 at 05:01, Ram Prakash Gupta
<quic_rampraka@quicinc.com> wrote:
>
> Thanks a lot Adrian and Uffe for your review and comment. The Qualcomm
> engineer who initiated this work, is no longer working on this and I am
> taking up the responsibility to continue on this work.
>
>
> On 11/12/2024 8:38 PM, Ulf Hansson wrote:
> > On Fri, 8 Nov 2024 at 15:43, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >> On 1/11/24 04:44, Madhusudhan Sana wrote:
> >>> Register mmc driver to CPU latency PM QoS framework to improve
> >>> mmc device io performance.
> >> Not sure host controller drivers should really be manipulating
> >> cpu_latency_qos in order to squeeze a bit more I/O performance.
> > I fully agree, this type of boosting doesn't belong in a low level
> > storage driver, as it is simply not capable of understanding the
> > use-case. Note that the cpu_latency_qos can also be managed from
> > user-space.
> >
> > Moreover, I guess there are use cases where it would make sense to
> > have some in-kernel governor to boost too for some conditions. But as
> > far as I can tell, we don't have a common way to do this, but rather
> > platform specific hacks via devfreq drivers for example.
> >
> > Kind regards
> > Uffe
>
> Hi Uffe/Adrian,
>
> In my opinion, many use case owners might not opt to control qos and
> may not use qos to gain better performance, and similar work was done
> in other driver eg.
> https://patchwork.kernel.org/project/linux-mediatek/patch/20231219123706.6463-2-quic_mnaresh@quicinc.com/
>
> Earlier this was done in Qualcomm specific file but later community
> suggested to make it into core driver, so that it applies for everyone.
> Having this thought in mind, here also this was made it into core driver.
> If this still doesn't fit here in mmc context, would like to refactor and
> move into Qualcomm specific file sdhci-msm.c please share your opinion.

Well, I think you need to look at the broader picture. I understand
what you want to achieve, but there are more than one use-case and
platform to keep in mind.

The UFS change that you point at above is an indication that there is
indeed a common problem - but the problem is not even limited to UFS.
For example, how do we make sure that the QoS constraint is the
correct one? Depending on the use-case and the platforms, things may
not necessarily get better, but worse and wasting energy for no good
reasons.

Don't get me wrong, I think this deserves to be discussed. My
suggestion is that you post an "RFD" to the linux-block
email-mailing-list, make sure to describe the problem from a top-level
point of view and ask for people's opinion/suggestions. I would be
happy to be cc:ed too.

[...]

Kind regards
Uffe

