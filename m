Return-Path: <linux-pm+bounces-14680-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0680F98608E
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 16:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 374F81C2668A
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 14:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F131AC8B2;
	Wed, 25 Sep 2024 13:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cPUlUVSM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD9718C002
	for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2024 13:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727269780; cv=none; b=RtoZWkSmihWPwayzwfH3jUNl711UUajMiLwJ27pNtruwgeYASMqjDL5x1QQjaPp5H2KgBkE8zYYh5vvn2b8KIzbENBOt80gWPrrlP2mQomHv/5+ty68hubewZDr58Ou1Fl+eUu343o0yAdrN+OFkv6wvn0iZtYd5mbiW+j7EAcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727269780; c=relaxed/simple;
	bh=400VLpJnX0L0xiQATbyMSk/SgyweDznJoN7IlOnXi9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8MiaXa9tHJCOdERFhaZxtU54lMZASNHh0+Pp9uHg9PlXFyX6ce/SFnk7Ua5BMvIg3z6xQY+uYOZxUvSlgfmLRjBYfEXz4/Zx0X2D+BMigm1K7ctIrU2r8IAhSpx5kOcC+RGb2Fk2ETyweQ9gpn67FkHOqT18grSN1qkhPCOGwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cPUlUVSM; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53653682246so1257132e87.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2024 06:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727269776; x=1727874576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6+CnqVG7Ol3vAZLpol6YfXDCc1Ev7Iif7KCFWReCBmE=;
        b=cPUlUVSMn9b5POjZWuIw0gxnB7AvsCKKyyjFAjtvM5qEqtQQFDBo/CY6Ni7rKvVTym
         asqYZLPu6rc18pHbFp5DHHAOrVEIRiF0JDliXxLrH2Z8iKofJFnmTyk2103ywCQHR0Ev
         aVTwAlFHAgwguyMSN6+MnfzSeRRYgNW/QO7s/DOnBwueBEBPqQuJ0G/m45RwiUImEQqM
         cIVnxhnYFiGpk5Du4S1MEvKmzfXyxb91UT0KK2SN51gTAyjFUPUBSHIBJY2Xfk29gkk5
         9SUXhR8bYm4GTY6oH0kxSXm70mz+zx1n0ttso2+LEM/OM4swNAsRJTPzir4c/nHGG2w5
         j/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727269776; x=1727874576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+CnqVG7Ol3vAZLpol6YfXDCc1Ev7Iif7KCFWReCBmE=;
        b=T//RRsAVl48c7zgg4IwNsvpyA+ntPiNqCytGrBihbb1MGPJv8rylR8mGzm13/vdXni
         H2HVnSN/bD+1WPBLDc9bTtIETvos4AzmF2AM6p7f/2dE7Qkx9NwHLfs5D2HKQ32RMyjU
         ajJ8kzRNXeUUzZVNmJHR0fe17fCRRBcbHSOSTc1qCBva9NaKzH5KNDt/+TnMhAy9Ctgs
         mfxIEFqir/8j6daCdp7q7ZkT0nRUIjmP92qaFcWis7TQpajwS3yGH18W7lyM360Ra7zR
         BLAvkYZLu96IrIPQ3Xp1mTrUe3Q6a71XhfhWnz4g8v8Yu4OM9ZvU1vd8WbTz+H9YO2km
         fmUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTenCk09fUd9poed0oiB8XT2lnusFuGoNdSWxvxVYz61ExFZc4Z6hFNEwRqWeo1A2O7SazO0Xv/A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUwNuAeM54TqtbhIGwhWCKGIN5xKHD+t5KzoV6WJH1ViUCPV7p
	8V5RloyFN5qf5s6CFQ5eWgc6vIrHP/pZ/UXbgShMxQAH50MOLrw+sv/ZfPP879s=
X-Google-Smtp-Source: AGHT+IGinEuA7fG0XrYD7Gh+x6rhKbNFQASd37I1jxJgo4yxPpmtKwWyhB3+miirGI+5mAPiWag2Kg==
X-Received: by 2002:a05:6512:b01:b0:530:ae22:a6f0 with SMTP id 2adb3069b0e04-53873455f14mr1764608e87.5.1727269775663;
        Wed, 25 Sep 2024 06:09:35 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-537a85e12d0sm528981e87.12.2024.09.25.06.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 06:09:34 -0700 (PDT)
Date: Wed, 25 Sep 2024 16:09:31 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jingyi Wang <quic_jingyw@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, quic_tengfan@quicinc.com, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: interconnect: qcom-bwmon: Document QCS8300
 bwmon compatibles
Message-ID: <heemxrecy7hushqeebml3kavxby5jevlcisbpeggymb5a3n4ho@6gzucpr67h5e>
References: <20240925-qcs8300_bwmon_binding-v1-1-a7bfd94b2854@quicinc.com>
 <7ld327om75xpz53fb7itxp2i7gjqvhavywzuhmf52myynawwvo@rmb7yimjxxmy>
 <56b3ca36-e7b8-480f-99b8-c624acba8d65@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56b3ca36-e7b8-480f-99b8-c624acba8d65@quicinc.com>

On Wed, Sep 25, 2024 at 04:40:20PM GMT, Jingyi Wang wrote:
> 
> 
> On 9/25/2024 4:10 PM, Dmitry Baryshkov wrote:
> > On Wed, Sep 25, 2024 at 03:45:06PM GMT, Jingyi Wang wrote:
> >> Document QCS8300 BWMONs, which has two BWMONv4 instances for the CPU->LLCC
> >> path and one BWMONv5 instance for LLCC->DDR path.
> >>
> >> Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
> >> ---
> >>  Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> >> index 189f5900ee50..251410aabf38 100644
> >> --- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> >> +++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> >> @@ -26,6 +26,7 @@ properties:
> >>        - items:
> >>            - enum:
> >>                - qcom,qcm2290-cpu-bwmon
> >> +              - qcom,qcs8300-cpu-bwmon
> > 
> > In most other cases qcs8300 is being declared with the compat fallback
> > to sa8775p compat string. Is there any reason why bwmon is different?
> > 
> All the *cpu-bwmon are fallback to "qcom,sdm845-bwmon", so we add "qcom,qcs8300-cpu-bwmon"
> compatible and fallback to that.

Ack, thanks for the explanation.

> >>                - qcom,sa8775p-cpu-bwmon
> >>                - qcom,sc7180-cpu-bwmon
> >>                - qcom,sc7280-cpu-bwmon
> >> @@ -40,6 +41,7 @@ properties:
> >>            - const: qcom,sdm845-bwmon    # BWMON v4, unified register space
> >>        - items:
> >>            - enum:
> >> +              - qcom,qcs8300-llcc-bwmon
> >>                - qcom,sa8775p-llcc-bwmon
> >>                - qcom,sc7180-llcc-bwmon
> >>                - qcom,sc8280xp-llcc-bwmon
> >>
> >> ---
> >> base-commit: 4d0326b60bb753627437fff0f76bf1525bcda422
> >> change-id: 20240925-qcs8300_bwmon_binding-641d8e4bf376
> >>
> >> Best regards,
> >> -- 
> >> Jingyi Wang <quic_jingyw@quicinc.com>
> >>
> > 
> Thanks,
> Jingyi
> 

-- 
With best wishes
Dmitry

