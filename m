Return-Path: <linux-pm+bounces-37334-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE573C2F018
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 03:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17A75189998D
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 02:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B54242D7F;
	Tue,  4 Nov 2025 02:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SyodFqsU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A0C1DF74F;
	Tue,  4 Nov 2025 02:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762224099; cv=none; b=VsG3j8pKIijIqN+kMqKlQgz6vjsTJrdsN2Qpcmatxtl2pF0N0ibTq9C5hHiQX5fD7oy35iC6UVHVNDe1t06Rn26GCEdHokBuPwnq/+huTQj2/kRRkIHytQmexZUUbWDJOnPGNarAgBdSTo9Gv/lPHqBJGpVJG3uIvvvP5O3s8P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762224099; c=relaxed/simple;
	bh=L1Vyy0PfGISfrRK/clj7TOjY02zLhIa3JzmfpiRF/eY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+uD27evuY692sw6C5BBAxDUcngJIsS6tA25dwFRjGFGY01XlZg991IuyWLARrAGTPaEb5anuOflSyvSv940mbt0bSVChfgob2aS4KRTIRgG3JTqT+4nwUKtt3ZHPHdmsNaZR8pjLXB7bX636cbYNksBQuT0bIbz6gQw+bjC8W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SyodFqsU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2608FC4CEE7;
	Tue,  4 Nov 2025 02:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762224098;
	bh=L1Vyy0PfGISfrRK/clj7TOjY02zLhIa3JzmfpiRF/eY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SyodFqsUDNkLnlBlqsquusKwwzas97COyReMM+17WQNUAiXjaGm/7hEVBBLGp15qS
	 QdNzXQ4qJW/wUykco1gUpfLNPZ8D3FwjV+Bm8uqp/FmIVCp0wvf2zgQKUIhXYCl4yO
	 fHHm8oPSLpZzkLKGtiE8Md0BySiiiYWsc0rE4KvN+/MHhRBZ8UJIa1pA8sHMhEAyQD
	 DgfYmBkBsgIIc/Vy6zJrpeNxSYFJ8xeTOsNUohDIR+ehlc4uCfdMVz3zDr/7gmz+Vv
	 L0eGmUFgYiSHJMuc1rWCPKH/pb+aHBx/4qZbK8YTMrM9foDLkjpRWpRd3v6UVi71lz
	 EUv6/pMCpaYdg==
Date: Mon, 3 Nov 2025 20:45:11 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>, konradybcio@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, sre@kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/5] dt-bindings: firmware: qcom,scm: Document reboot mode
Message-ID: <ary7qhe4gh2yixweoey6bl5euorzdephyp22pujrr623sbnmtu@fqqwvreujiod>
References: <20251103182006.1158383-1-loic.poulain@oss.qualcomm.com>
 <20251103182006.1158383-4-loic.poulain@oss.qualcomm.com>
 <aqoxdaq72prkeqwxmmohlmbpx7icuc32sej7did6vt6rzrgfib@bvmt7ppkvloc>
 <v5dbwbgic5cogxsf3lkmdwmlkpnqvo2niy3s7qu6ow3btpo7se@2altcz3nhbo2>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <v5dbwbgic5cogxsf3lkmdwmlkpnqvo2niy3s7qu6ow3btpo7se@2altcz3nhbo2>

On Tue, Nov 04, 2025 at 04:19:14AM +0200, Dmitry Baryshkov wrote:
> On Mon, Nov 03, 2025 at 08:16:30PM -0600, Bjorn Andersson wrote:
> > On Mon, Nov 03, 2025 at 07:20:04PM +0100, Loic Poulain wrote:
> > > SCM can be used to support reboot mode such as Emergency Recovery Mode.
> > 
> > "such as"? Do we have any other useful bits in here?
> > 
> > > 
> > > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > > ---
> > >  Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> > > index b913192219e4..c8bb7dacd900 100644
> > > --- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> > > +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> > > @@ -121,6 +121,10 @@ properties:
> > >            - description: offset of the download mode control register
> > >      description: TCSR hardware block
> > >  
> > > +patternProperties:
> > > +  "^mode-.*$":
> > 
> > I'd only ever expect mode-edl = <1>. Do we have additional modes that
> > warrant the generic nature of this?
> 
> fastboot / bootloader?
> 

They go in the PON_SOFT_RB_SPARE register, in the pon driver. But that
apparently doesn't tickle the EDL bit.

But it's a good question, I'd like for it to be answered in one of the
commit messages.

Regards,
Bjorn

> > 
> > Regards,
> > Bjorn
> > 
> > > +    maxItems: 1
> > > +
> > >  allOf:
> > >    # Clocks
> > >    - if:
> > > -- 
> > > 2.34.1
> > > 
> 
> -- 
> With best wishes
> Dmitry

