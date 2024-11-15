Return-Path: <linux-pm+bounces-17641-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E619CF1FD
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 17:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D11A295763
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2024 16:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1441E22FC;
	Fri, 15 Nov 2024 16:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hagLj4hw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9711D5145
	for <linux-pm@vger.kernel.org>; Fri, 15 Nov 2024 16:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731689081; cv=none; b=DpDByoYdNq+SUjx0zY19U0pkKANekSlt97xKMomrenuUCaaHyBKrhu8/KpfNUlmkE4vD3CQgyC0v7yztUtQ/lGv3QVlJiITwWX72l7G6AcyJ2BAh/auPzSnUaCWdEtfjkNiupL0hfYxMrW87io6t3sZjHJMe4+A7fLHyqAHHxBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731689081; c=relaxed/simple;
	bh=w1FTAecBOFTmyqoMAH2DfbSi1/WWutIqszTuyzR8ob0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFdfLQ7od2W/oDpL7Q46ihg46K18X8wPFL7bCi6UpN6d8FhRuNxi0s0b9blkBgwRC6EoaYLqDdunepkYQ8ORglGG6tHd3vu8tFbbq8yqv4OiJkybc3xoNgA8i+Xuz4mCE9vvcpsVHQpBXJcQLzqSdyZhmkpnKS11IDOF6nM3Kv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hagLj4hw; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb559b0b00so17591851fa.0
        for <linux-pm@vger.kernel.org>; Fri, 15 Nov 2024 08:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731689078; x=1732293878; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tvSbr212wnBXWgkPqBMZFxm+xf5y5TiTLHopInfDcas=;
        b=hagLj4hwjBJ6cOEPXcyzU57D7AXQkt4DTrdYQQn7J7uLCTgQWPCebeRWZ7eAdOuk1V
         YqmBCj7e72NzazEGrmhIulvdZjuqZmCE9MUNv4knJp/1r3/gyu7EW2OWg9Fs9Q15DvAB
         WLqYBLJgt2C1LsR5+pkkbEM4SbKREWKbXyhvjuUoYn4KycSQj9izrseEHoy1OWlZdwO8
         sNCj4qsxz2QfIUBJMJCoydyo/ZHd3cllhElRTpdx+Z3e4sSpY3OAN0KBKCCFYexo2kpn
         siQj6wGdeuXq5YPih8ctDScLwZz1HMt9FFF/te0pjPj5gIceh7/51a4LnYZN764pPLnF
         dfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731689078; x=1732293878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvSbr212wnBXWgkPqBMZFxm+xf5y5TiTLHopInfDcas=;
        b=uvRmtELy1QTWNpzlqP7NO5hoI8YoPO+EE1wsMyCWb5hmrYOgSalqwbw0enj1A1OI65
         754JacDOH5qqN0+JVYKPbD74YDWV8LkXiNlYPB/IeAYq8XPb3v3jLjAFjtw+SpsQar0J
         FA1gHmztAzf+iAT8K5sOWouTqD3aiBBuxZTMZvpmcqXNLyMBJbIrDOriqNmuzasG/Ey1
         XA0iElnjR3aRaiQ1/TRXgbBeyON6QtmGDKqaYP/3Y77N0C1ZruOBAzGYg2XqYiIqpfYx
         A/btG4Tr+A/zJRFuH96U54W821XKPSmapOiDupRKTTHBuT7hrgPTQqJT6H5G0Pb4pQVr
         XZKg==
X-Forwarded-Encrypted: i=1; AJvYcCU7q/gf8sGTSU/VX+FHLZUtTCJjDAWxa0BrD9myF1RQBTp/slMKUPaci8jjrJdiP9aBtj7t+PLY/w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6CmfMMXoicwU0P0TKQTdZguOeUKQGCqaCepiHTjSa0nIulGHO
	NbPk4tPgf9qzQfc9PtQgAIY/Fjvsjn+SYCCbtV1/GTzZ1M+B23Ro/Tdbiothwdk=
X-Google-Smtp-Source: AGHT+IFgzXgQ4IjxGhewB1vh2xQBTf7ORjLEOV0LXbis36gnE75+Wti65ULJO+Xnk5bUahD0MBiHug==
X-Received: by 2002:a2e:b8cf:0:b0:2fb:34dc:7beb with SMTP id 38308e7fff4ca-2ff6067407bmr19160471fa.12.1731689078308;
        Fri, 15 Nov 2024 08:44:38 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff5988f321sm6038021fa.95.2024.11.15.08.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 08:44:37 -0800 (PST)
Date: Fri, 15 Nov 2024 18:44:34 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jishnu Prakash <quic_jprakash@quicinc.com>
Cc: jic23@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org, 
	konrad.dybcio@linaro.org, daniel.lezcano@linaro.org, sboyd@kernel.org, 
	quic_subbaram@quicinc.com, quic_collinsd@quicinc.com, quic_amelende@quicinc.com, 
	quic_kamalw@quicinc.com, amitk@kernel.org, lee@kernel.org, rafael@kernel.org, 
	rui.zhang@intel.com, lukasz.luba@arm.com, lars@metafoo.de, quic_skakitap@quicinc.com, 
	neil.armstrong@linaro.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	cros-qcom-dts-watchers@chromium.org
Subject: Re: [PATCH V4 2/4] dt-bindings: iio: adc: Add support for QCOM PMIC5
 Gen3 ADC
Message-ID: <i7opxhkgukcshdcc7j6ai6jt62egag3jgfiqsghakjhgt2ikg6@eap7l64amcci>
References: <20241030185854.4015348-1-quic_jprakash@quicinc.com>
 <20241030185854.4015348-3-quic_jprakash@quicinc.com>
 <ag3wqsjdec7ujcba2jpvhzgcbbc5vnyjyes5ljyyf5b4edw7j3@rj23a25wvoyd>
 <ee8f0b70-77a2-4a5e-85c8-715fd02d4437@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee8f0b70-77a2-4a5e-85c8-715fd02d4437@quicinc.com>

On Wed, Nov 13, 2024 at 07:36:13PM +0530, Jishnu Prakash wrote:
> Hi Dmitry,
> 
> On 10/31/2024 11:27 PM, Dmitry Baryshkov wrote:
> > On Thu, Oct 31, 2024 at 12:28:52AM +0530, Jishnu Prakash wrote:
> >> For the PMIC5-Gen3 type PMICs, ADC peripheral is present in HW for the
> >> following PMICs: PMK8550, PM8550, PM8550B and PM8550VX PMICs.
> >>
> >> It is similar to PMIC5-Gen2, with SW communication to ADCs on all PMICs
> >> going through PBS(Programmable Boot Sequence) firmware through a single
> >> register interface. This interface is implemented on an SDAM (Shared
> >> Direct Access Memory) peripheral on the master PMIC PMK8550 rather
> >> than a dedicated ADC peripheral.
> >>
> >> Add documentation for PMIC5 Gen3 ADC and macro definitions for ADC
> >> channels and virtual channels (combination of ADC channel number and
> >> PMIC SID number) per PMIC, to be used by clients of this device.
> >>
> >> Co-developed-by: Anjelique Melendez <quic_amelende@quicinc.com>
> >> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> >> Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
> >> ---
> >> Changes since v3:
> >> - Added ADC5 Gen3 documentation changes in existing qcom,spmi-vadc.yaml file
> >>   instead of adding separate file and updated top-level constraints in documentation
> >>   file based on discussion with reviewers.
> > 
> > I think it has been better, when it was a separate file. Krzysztof asked
> > for rationale, not for merging it back. Two different things.
> 
> Actually I made that change in a separate file due to a misunderstanding at that time - 
> I thought a separate file was the only way to accommodate a change in the top-level 'reg' and 'interrupts'
> constraints, but I realized later that they could be updated.
> 
> From our side, we would prefer to add ADC5 Gen3 documentation in the same file, as it is
> mostly the same functionality which reuses all the existing properties present in this file.

Export the existing properties and reuse them in the new file. Gen3 (in
my opinion) changed the hardware too much. Having all the differences
via conditionals bloats the schema and makes it significantly unreadable
in my opinion.

But please refer to DT maintainers (Rob/Krzysztof/Conor) for the final
opinion.

-- 
With best wishes
Dmitry

