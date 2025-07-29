Return-Path: <linux-pm+bounces-31557-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0751B1505E
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jul 2025 17:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D24E93A972E
	for <lists+linux-pm@lfdr.de>; Tue, 29 Jul 2025 15:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF542951B3;
	Tue, 29 Jul 2025 15:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sOyPiMQb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488CB2949E5
	for <linux-pm@vger.kernel.org>; Tue, 29 Jul 2025 15:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753803867; cv=none; b=db5/lzn+uMNhCPT4lKQYKqN9jFzRq7ElBxeIa5wbeuYKeZEoq6GAOy4pnF5gp7F+XE760YUCe8c8yQqDySCx8Sr6TsOVCPNzkAfdroxTOOS40rnA3zrBifTpde3Tvpjp3aRySjjvKdM6RJCReweWwrK5z8lH3XiWS4slw4Bne+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753803867; c=relaxed/simple;
	bh=gTKUAoQOVNfDwrKXIlmuLwCfGQF/GjTu9mg9ZtnCU4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0lvCa2aPTwiNATvkmyZfHHE7rhOqWFexyhxmk5VGuBMpP3V//+LU0nW+KcyV7ZY9DYrVfyHfh2aae8iQVi8lER+jsoXUtZtWVrMPZiIKULCLHnCN1ZB0MV666POjySPxzLXZExOzB53h0jeQCFkbv6QX7ft3DS5QLE5b30u3LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sOyPiMQb; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-615398dc162so4079523a12.3
        for <linux-pm@vger.kernel.org>; Tue, 29 Jul 2025 08:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753803863; x=1754408663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LN18dTJK3bUZCImiyE0FuNTJ8LDUzXGgTCqf/lUFg3U=;
        b=sOyPiMQbFbwAU1KXWqOcUWZdn5zUoGvE7JeWbvckjDCECR3gQCuHb2H3Y7CoYrCfPL
         nwBXLA3rXeiALkieOxZmUrQsRuMCwCGy2WJYZbUOrCSExr7TnNNyR6gF2/MEZGh5Emo3
         GKcaQoBsZYDWUVPet4ixy8X+v+L+YE1IYd7R8bACHQanvDjKjg5WAceXvKUr87YnYHke
         bl84LwuJ5dgwWefB0qTrz11gihk0GcWmAiFvRvm1BGrrsZ0Cwo0CwJaZGnoTG45BffkJ
         CkTVXglWtK9T7aiPtR1G+vW64S9Dnf/SQI4ed00qsYzARio03t8GguNgtoAeGGTaEx9/
         0wdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753803863; x=1754408663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LN18dTJK3bUZCImiyE0FuNTJ8LDUzXGgTCqf/lUFg3U=;
        b=o4QS9Fu46rdvTjVHMozR6ZGfkka2KGE6Mi5lYvd5evG2Bcj+VSzhJtgRrkkglcjRSU
         nagdzDt7n8N4icEmet2VjSUByKUouyp4FHTSkRrgTZYkokqb+bl4RRN0ZOTrr0HQz1fv
         3q4RE90pJVOI/hBkzikcTDSb2eOy9Kv2pGuZZdRtX6hU6Tuzt90jCasp2o/BdN+mzSnA
         TXBA3/HOxvg6rlM5eICT31QY6PUn6dgsvBIfNbgD//rQS+NLRIoHCP+gXlLt4so/q6fA
         2Tj8QI/XPD+x+oLBiVdCVzJZ3mxHbGxY0l0gE66bY9IPPwQzzmwqe25cCbkR7CaYgtLQ
         G7+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXhs4Zsjc7+eeXzW/FcJOeDlwyO+nqOLF2Jy4MSIyfU1kXcxWnLKdqwRI6l7Tp4+xetoMSJLxXJng==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVbKio4PmoBiX5FICUtVvLAThU+Wl5KVxQ1wIS+//OLgZZeGV9
	xpNP3Fxp+XkPyLH2synWWrA/90FyJH5fZHNesTtNiVjLMSmbqVcZ5vkOalhGgEKsezc=
X-Gm-Gg: ASbGnctCz4qYxNz3xY24l4M+b62ismEBzqcWJfNOaPnNM585QSXcuLsTuLRs2sWYyMp
	jisyd+1FOBzMkFqjfl87kFpjyNXDOImtzJIHfmuC/dfrA6HMjiQNmyy66BEqixknbHJkRk5hrPU
	o3s2sX6LC7aPnixXEdKQEYwUtTmOKnfw+BXdBrnkJ04Nn64+a1Gt1tPJwuUsOBTFys8hYG1GguT
	JoL9XRYw9QCI/TZsvPwrvsrRoXcev1E8vBp1OLiYTQoI4peAYVJdn5BgqshtIVyoDmDlk3O91jQ
	e1c21UZVxHC1iBzcvbI/+aSTyEmqGZqOwAArrr73Zg6dJfAXWxTeaX+GkfHE2PRCeQ6M1QxTLcu
	0vC0Bl4uQMKVz53fsyW3MfM4wYdJLzMbl6w==
X-Google-Smtp-Source: AGHT+IGq9wI3/lWh7E230ug5OoIqR7fJXimGz2+ajBqUWxDLFS2ckclMt/arQALpxqYLTlDmX5irhg==
X-Received: by 2002:a05:6402:2756:b0:609:d491:8d7c with SMTP id 4fb4d7f45d1cf-614f1f66f87mr15096225a12.33.1753803862494;
        Tue, 29 Jul 2025 08:44:22 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef30:dd5d:6e13:d8d2:7f2f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6154f4fac5fsm2166412a12.22.2025.07.29.08.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 08:44:22 -0700 (PDT)
Date: Tue, 29 Jul 2025 17:44:17 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Taniya Das <taniya.das@oss.qualcomm.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Taniya Das <quic_tdas@quicinc.com>,
	Imran Shaik <quic_imrashai@quicinc.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Dmitry Baryshkov <lumag@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Douglas Anderson <dianders@chromium.org>,
	Vinod Koul <vkoul@kernel.org>,
	Richard Acayan <mailingradian@gmail.com>,
	Ajit Pandey <quic_ajipan@quicinc.com>,
	Luca Weiss <luca.weiss@fairphone.com>,
	Jonathan Marek <jonathan@marek.ca>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jagadeesh Kona <quic_jkona@quicinc.com>,
	Akhil P Oommen <akhilpo@oss.qualcomm.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH RFC 24/24] arm64: dts: qcom: x1e80100: Describe GPU_CC
 power plumbing requirements
Message-ID: <aIjsTgA7O7UqS-Oz@linaro.org>
References: <20250728-topic-gpucc_power_plumbing-v1-0-09c2480fe3e6@oss.qualcomm.com>
 <20250728-topic-gpucc_power_plumbing-v1-24-09c2480fe3e6@oss.qualcomm.com>
 <aIevIuMDA5R8igmi@linaro.org>
 <50868cd8-68a9-4bad-99f3-8cf542886fb6@oss.qualcomm.com>
 <aIhrav7GKpsbVpto@linaro.org>
 <6b903628-9abf-4b9e-971e-e9338308d693@oss.qualcomm.com>
 <0a1337d7-ee3e-47de-a401-b25586e813e4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a1337d7-ee3e-47de-a401-b25586e813e4@oss.qualcomm.com>

On Tue, Jul 29, 2025 at 03:28:55PM +0200, Konrad Dybcio wrote:
> On 7/29/25 10:23 AM, Konrad Dybcio wrote:
> > On 7/29/25 8:34 AM, Stephan Gerhold wrote:
> >> On Mon, Jul 28, 2025 at 11:31:10PM +0200, Konrad Dybcio wrote:
> >>> On 7/28/25 7:10 PM, Stephan Gerhold wrote:
> >>>> On Mon, Jul 28, 2025 at 06:16:24PM +0200, Konrad Dybcio wrote:
> >>>>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> >>>>>
> >>>>> A number of power rails must be powered on in order for GPU_CC to
> >>>>> function. Ensure that's conveyed to the OS.
> >>>>>
> >>>>> Fixes: 721e38301b79 ("arm64: dts: qcom: x1e80100: Add gpu support")
> >>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> >>>>> ---
> >>>>>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 6 ++++++
> >>>>>  1 file changed, 6 insertions(+)
> >>>>>
> >>>>> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> >>>>> index 5e9a8fa3cf96468b12775f91192cbd779d5ce946..6620517fbb0f3ed715c4901ec53dcbc6235be88f 100644
> >>>>> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> >>>>> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> >>>>> @@ -3928,6 +3928,12 @@ gpucc: clock-controller@3d90000 {
> >>>>>  			clocks = <&bi_tcxo_div2>,
> >>>>>  				 <&gcc GCC_GPU_GPLL0_CPH_CLK_SRC>,
> >>>>>  				 <&gcc GCC_GPU_GPLL0_DIV_CPH_CLK_SRC>;
> >>>>> +
> >>>>> +			power-domains = <&rpmhpd RPMHPD_CX>,
> >>>>> +					<&rpmhpd RPMHPD_MX>,
> >>>>> +					<&rpmhpd RPMHPD_GFX>,
> >>>>> +					<&rpmhpd RPMHPD_GMXC>;
> >>>>> +
> >>>>>  			#clock-cells = <1>;
> >>>>>  			#reset-cells = <1>;
> >>>>>  			#power-domain-cells = <1>;
> >>>>>
> >>>>
> >>>> To repeat your own message from a couple of months back [1]:
> >>>>
> >>>>> You shouldn't be messing with VDD_GFX on platforms with a GMU.
> >>>>>
> >>>>> Parts of the clock controller are backed by one of the MX rails,
> >>>>> with some logic depending on CX/GFX, but handling of the latter is
> >>>>> fully deferred to the GMU firmware.
> >>>>>
> >>>>> Konrad
> >>>>
> >>>> Please describe somewhere in the cover letter or the individual patches
> >>>> how this relates to the responsibilities of the GMU. I searched for
> >>>> "GMU" in the patch series and couldn't find any note about this.
> >>>>
> >>>> Also: How much is a plain "power on" votes (without a corresponding
> >>>> "required-opps") really worth nowadays? An arbitrary low voltage level
> >>>> on those rails won't be sufficient to make the GPU_CC actually
> >>>> "function". Do you need "required-opps" here? In the videocc/camcc case
> >>>> we have those.
> >>>
> >>> Right, I failed to capture this.
> >>>
> >>> The GFX rail should be powered on before unclamping the GX_GDSC (as
> >>> per the programming guide). The clock controller HPG however doesn't
> >>> seem to have a concept of RPMh, so it says something that amounts to
> >>> "tell the PMIC to supply power on this rail". In Linux, since Commit
> >>> e3e56c050ab6 ("soc: qcom: rpmhpd: Make power_on actually enable the
> >>> domain") we don't really need a defined level for this (perhaps it's
> >>> more ""portable"" across potential fuse-bins if we don't hardcode the
> >>> lowest level anyway?).
> >>
> >> Thanks, I forgot that we have this commit.
> >>
> >>>
> >>> However after that happens, the level scaling is done by the GMU
> >>> firmware. This holds for allOf CX/MX/GFX. I'm not super sure if
> >>> both MX and (G)MXC need to both be captured together - downstream
> >>> seems to describe MXC as a child of MX (in socname-regulators.dtsi),
> >>> but I'm not really sure this is true in hardware.
> >>>
> >>> The GPU driver currently first enables the GX_GDSC and only then
> >>> does it kickstart the GMU firmware. Downstream seems to do that as
> >>> well. So on a second thought, since we've not seen any errors so
> >>> far, it calls into question what role the GFX rail plays in the
> >>> GX_GDSC's powering up..
> >>>
> >>
> >> It might play a role, but we wouldn't know since AFAICT we don't support
> >> enabling the GX_GDSC. Look at the beautiful gdsc_gx_do_nothing_enable()
> >> function, it basically just defers the entire task to the GMU. The GDSC
> >> just exists in Linux so we can turn it *off* during GMU crashes. :D
> > 
> > OHHHHH snap! I, on the other hand, forgot we have *that* commit..
> > 
> >> I think we should identify precisely which votes we are missing, instead
> >> of making blanket votes for all the power rails somehow related to the
> >> GPU. In this case this means: Which rails do we need to vote for to make
> >> the GMU turn on? If there are no votes necessary after the GMU is on,
> >> it's better to have none IMO.
> > 
> > The GMU pokes at RPMh directly (see a6xx_hfi.c), so we indeed just
> > need to make sure that it can turn on.. Which in short means the
> > *C*X_GDSC must be able to power up, which doesn't have any special
> > requirements. The only question that's left is basically whether
> > MX_C must be on. I'll try testing that in practice.
> 
> So this is apparently difficult, at least on SC8280XP, where something
> seems to be voting on MXC and it only seems to shut down when entering
> CXPC. I would imagine/hope this is not the case on newer platforms, but
> I don't have a way to fully confirm this at the moment..
> 

If in doubt, I would suggest to leave everything as-is for now until
someone actually runs into an issue caused by this (if this is even
possible). There are plenty other actual gaps to address. ;)

Stephan

