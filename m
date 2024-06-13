Return-Path: <linux-pm+bounces-9098-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B169079F5
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 19:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 924781C22BA6
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jun 2024 17:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443CB149C79;
	Thu, 13 Jun 2024 17:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="srvTU2Cw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F33149E06;
	Thu, 13 Jun 2024 17:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718300141; cv=none; b=rc5w9oQT57hC06DLrl+e1brVr3P87PwB88hvmsk2Y4viVax3/2y9yGiwNqSG4mRb+RYdqDA9lKnDpFufK0LpAARYM5rBFyjiznH0Q1rzKgkOlK4VQ5WxupqAyEfBq9GEtDPmNJn1VAX36UbMlaCyxaLfCWrcxf2x8JzmQ25i/g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718300141; c=relaxed/simple;
	bh=dqedMryWpbzl0sexd5pEVn7GsbPtPLflViufTU17X2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYgJCWu4QtMKUiMwmq1BZTuyVlI7C3X6TPeyacIq+dLwIGWYbNWcL/GZxIXd4CBeQ7c2X7kA6438w7aJpxmqzaNOVyLcxlT0egphLr1phhPnfEkmdlC2DAatEERnSDmeyljHin5tXDuhcW/16rDoevXiqkByRyXT5lVuhEhF/BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=srvTU2Cw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED7CC2BBFC;
	Thu, 13 Jun 2024 17:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718300140;
	bh=dqedMryWpbzl0sexd5pEVn7GsbPtPLflViufTU17X2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=srvTU2CwwxSfnEgA+OEIWVKvmvAZzBfMTfliMCDbBnbax16Ci4Uya6fkokhEoQCjQ
	 80u5y6cK3vN/UD92pSZceNgfXW5mcFtsd7LRqKxTKlkmwkTk2x1BPUnChwHm3zHNJ5
	 MRJPyAbq8UmDq4j+6fVcpIxVgTnRJuI6N7Djfm2mSELEkzey5+3Lv4Zahp5KLv0hsO
	 ucYOgLSaV2jHyU2zh68B9lypdYsuk0csfaFTTbxYN9HCFOsnreNvWgkzj7huab+Smn
	 jsEaZV9wkPDXNfrkUzxH81V9dSpaRo4P1qCEpfZLhboJ+RzmryTKXOUC6bPNnqLq0r
	 rLum7QWy4xzKw==
Date: Thu, 13 Jun 2024 11:35:39 -0600
From: Rob Herring <robh@kernel.org>
To: Elliot Berman <quic_eberman@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Andy Yan <andy.yan@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
	Melody Olvera <quic_molvera@quicinc.com>,
	Shivendra Pratap <quic_spratap@quicinc.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 1/4] dt-bindings: power: reset: Convert mode-.*
 properties to array
Message-ID: <20240613173539.GA2038101-robh@kernel.org>
References: <20240611-arm-psci-system_reset2-vendor-reboots-v4-0-98f55aa74ae8@quicinc.com>
 <20240611-arm-psci-system_reset2-vendor-reboots-v4-1-98f55aa74ae8@quicinc.com>
 <20240611204001.GA3026541-robh@kernel.org>
 <20240611160619020-0700.eberman@hu-eberman-lv.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611160619020-0700.eberman@hu-eberman-lv.qualcomm.com>

On Tue, Jun 11, 2024 at 04:23:00PM -0700, Elliot Berman wrote:
> On Tue, Jun 11, 2024 at 02:40:01PM -0600, Rob Herring wrote:
> > On Tue, Jun 11, 2024 at 08:35:13AM -0700, Elliot Berman wrote:
> > > PSCI reboot mode will map a mode name to multiple magic values instead
> > > of just one. Convert the mode-.* property to an array. Users of the
> > > reboot-mode schema will need to specify the maxItems of the mode-.*
> > > properties. Existing users will all be 1.
> > > 
> > > Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> > > ---
> > >  .../devicetree/bindings/power/reset/nvmem-reboot-mode.yaml        | 5 +++++
> > >  Documentation/devicetree/bindings/power/reset/qcom,pon.yaml       | 8 ++++++++
> > >  Documentation/devicetree/bindings/power/reset/reboot-mode.yaml    | 4 ++--
> > >  .../devicetree/bindings/power/reset/syscon-reboot-mode.yaml       | 5 +++++
> > >  4 files changed, 20 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.yaml b/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.yaml
> > > index 627f8a6078c2..9b9bbc0f29e7 100644
> > > --- a/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.yaml
> > > +++ b/Documentation/devicetree/bindings/power/reset/nvmem-reboot-mode.yaml
> > > @@ -31,6 +31,11 @@ properties:
> > >  allOf:
> > >    - $ref: reboot-mode.yaml#
> > >  
> > > +patternProperties:
> > > +  "^mode-.*$":
> > > +    items:
> > > +      maxItems: 1
> > 
> > Drop 'items'. Otherwise, you are defining constraints of a matrix.
> > 
> 
> If I do this, I also have to add $ref: .../uint32-array as well so
> the property can be picked up as an array type. Let me know if this isn't
> right, otherwise I'll send out a fixed version in a few days.

Ah, I suppose the tools get confused with what to do here. That's an 
issue I'm working on addressing. The issue is everything is a matrix 
because without other information for a property we don't know how to 
decode them. But with the schemas being fairly complete now and the move 
away from DTB->YAML decoding, we can decode properties to the right 
type. One issue to switch over is places where this 'everything is a 
matrix' crept into schemas. I've been fixing these. The above is an 
example of this.

So for now, just drop 'items'. It won't enforce anything, but once we 
switch over it will.

Rob

