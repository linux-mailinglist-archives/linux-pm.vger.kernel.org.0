Return-Path: <linux-pm+bounces-8123-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BF58CF5FD
	for <lists+linux-pm@lfdr.de>; Sun, 26 May 2024 22:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0A6B2810D1
	for <lists+linux-pm@lfdr.de>; Sun, 26 May 2024 20:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC4A13247D;
	Sun, 26 May 2024 20:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="snmUQUxi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114D71A2C2C;
	Sun, 26 May 2024 20:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716755709; cv=none; b=P73PjeMUlagsqFg11c/z5wuiYmYJySt5p806rsDhHTY9e+9iZ1uOgCUT1aN5F1KUBdAlEM5tbWBEey6prswj3IajnkxUIHVmS0IGExxMednsMou5kn23Ct0i1pU4C4S805gN2pYSxYFjWdC8M6z7k+nPp+A7W663aUQDdD/0U/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716755709; c=relaxed/simple;
	bh=s3fzU9xLUyopB+xxjtsuUvzYPzqZ1wnTdOoykRk+6wE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICgNbV4sexZn8Xp80/yRFnUyQ7E9LHlfw/Hn1rfVwrobt+Lt0a6EZ78cdnnuXkMtTcGxp96PrbluKyKcbp8U40jFSgpbe3AecLyMi+DJN1eawNzirzwgfTKjnkRuei/sYrrCrrLBFkg6p6y8qp2S+pgNa7V2LVeXFi3sYX1OTYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=snmUQUxi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C75C2BD10;
	Sun, 26 May 2024 20:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716755708;
	bh=s3fzU9xLUyopB+xxjtsuUvzYPzqZ1wnTdOoykRk+6wE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=snmUQUxifnpj21C4i8CB6fqQz3QqVrm3h5ugNVkiaJA1Iypl5rzQ/6WVAgtjIRSm/
	 xve/4sK642zKmpwEDjuPKlVx7E4kahL6/jBt2eW61ijbL1yTnKxFz4AnAJhV2SMpFd
	 3/XHOAVeb5lveXrhX2idtUyzan6AOrZF8UBeNQf/tqODf8V7IdpqNtGqsc7ZiifElq
	 DIDyBAVzIfheLFeg4323W7krQT+uU0gKhX31U5FUZf8uIVy0XqsPnyl3RUGoY0zqPN
	 50tAv3tndnvdw+/le8pO1ecta1Jr6/IDyTLGR/8YrkVPxHPi0JO0v5bZGYzPrOSvJG
	 D9N1SGBRFdbcg==
Date: Sun, 26 May 2024 15:35:05 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: Re: [PATCH 1/2] dt-bindings: cpufreq: cpufreq-qcom-hw: Add sc8180x
 compatible
Message-ID: <ycwz2sezvspzfeqeatghhctjmip4kbguw7dyf4nzgjlk6cm5xe@apway7oub2od>
References: <20240525-sc8180x-cpufreq-compatible-v1-0-febf0f17909c@quicinc.com>
 <20240525-sc8180x-cpufreq-compatible-v1-1-febf0f17909c@quicinc.com>
 <de70a80c-8c7f-42e5-aa7b-e9549f10636b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de70a80c-8c7f-42e5-aa7b-e9549f10636b@kernel.org>

On Sun, May 26, 2024 at 08:23:24PM GMT, Krzysztof Kozlowski wrote:
> On 25/05/2024 19:48, Bjorn Andersson wrote:
> > From: Bjorn Andersson <quic_bjorande@quicinc.com>
> > 
> > The SC8180X platform has a EPSS block, add a compatible for the SC8180X
> > platform.
> > 
> > Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > ---
> >  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> > index 1e9797f96410..24c02ee33266 100644
> > --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> > +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> > @@ -36,6 +36,7 @@ properties:
> >                - qcom,qdu1000-cpufreq-epss
> >                - qcom,sa8775p-cpufreq-epss
> >                - qcom,sc7280-cpufreq-epss
> > +              - qcom,sc8180x-cpufreq-epss
> 
> I think you forgot to update the allOf:if:then: entry.
> 

Indeed, failed to spot that.

Thanks,
Bjorn

