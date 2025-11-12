Return-Path: <linux-pm+bounces-37856-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB604C53A1D
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 18:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 133675636EC
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 16:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3DB33F39C;
	Wed, 12 Nov 2025 16:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kolr7ydK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6A233C53F;
	Wed, 12 Nov 2025 16:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762965148; cv=none; b=lKs0v9C50Cj+JabJUkaeiq7LW8L8oMKQm03M7WDujCP5dEN9Aqr9fKeX0KSBvhPo8cXRrE55yoPelUWU2n3TQuyqDndTW9G6/K1WvfSM9tB8SM8Nk4dL6Xo13dJ3grdk6UTHbdV0UGfNBMd4LrF6OFyfIkowPZc+DYNg7XhftsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762965148; c=relaxed/simple;
	bh=TGE/p1r9FCUCFgwWgcDgzkM4sT69JijtRoehdTdV80o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtEz+wHo+n1PD6uL9DY1aLuogcYcOx/bxdsm4NNw+GBG2dpkRXRxUsLtvFFc5VinzCfK/fLxHuL0NbLV3ktJLC4xWgFR8TK6NoOGHr1Xx7LgiXF762tq/UdmpQ1zr6lzH1T+fCU1qyPz/xuFSe6ROpbkphxuKlQcxQ4dqLIZ8SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kolr7ydK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0FCC4AF0E;
	Wed, 12 Nov 2025 16:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762965147;
	bh=TGE/p1r9FCUCFgwWgcDgzkM4sT69JijtRoehdTdV80o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kolr7ydK7VpWICD1e82U3h5brfhIMjAi2+x3TRfMw8GqyuFndLrP+1N1giEH3461F
	 tbCcoc5oYdZfwmi3Ff830DyWNIQ6da5u+mScmMZOQs29A62bUkphhjn6yKXMsVdjuH
	 k2V2SOnBxneJi0qsbnemJKXLhrCaDuvjItw+7GbcscSKFPwDEinIKwpyz1sqzjRhzj
	 Xp3hIOgTQUaNiKOqIOFS3u5lwJ5emeCiA+PpC6E5RgbhO1FhpG7C/vxJnDuJWhGVP0
	 BDJ0SogafTioSnoPpd3yBNidLMLzmZ0no+DTvnqIo5LptKKT4ZFIq2/zddnItrbOXQ
	 FPlJXBHMwVNNA==
Date: Wed, 12 Nov 2025 10:36:45 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>, konradybcio@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, sre@kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/5] dt-bindings: firmware: qcom,scm: Document reboot mode
Message-ID: <sdhnchve6r5i4frhlx5q7lod5npzosbfdjjyd56l2z5ksoe4t4@lhm6d2pzsztm>
References: <20251103182006.1158383-1-loic.poulain@oss.qualcomm.com>
 <20251103182006.1158383-4-loic.poulain@oss.qualcomm.com>
 <aqoxdaq72prkeqwxmmohlmbpx7icuc32sej7did6vt6rzrgfib@bvmt7ppkvloc>
 <CAFEp6-2GGA2gvBKfO0fZemVmJmjQpTQEJ0vLfEewfhHKOYQGSQ@mail.gmail.com>
 <be0a418b-5e8f-4895-a3b8-482b6ad6a40e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be0a418b-5e8f-4895-a3b8-482b6ad6a40e@oss.qualcomm.com>

On Wed, Nov 05, 2025 at 10:44:05AM +0100, Konrad Dybcio wrote:
> On 11/4/25 10:19 PM, Loic Poulain wrote:
> > On Tue, Nov 4, 2025 at 3:12 AM Bjorn Andersson <andersson@kernel.org> wrote:
> >>
> >> On Mon, Nov 03, 2025 at 07:20:04PM +0100, Loic Poulain wrote:
> >>> SCM can be used to support reboot mode such as Emergency Recovery Mode.
> >>
> >> "such as"? Do we have any other useful bits in here?
> > 
> >  I heard we may have different EDL modes supported like USB or SD
> > based EDL, but I don't know much about the details.
> > 
> >>
> >>>
> >>> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> >>> ---
> >>>  Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 4 ++++
> >>>  1 file changed, 4 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> >>> index b913192219e4..c8bb7dacd900 100644
> >>> --- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> >>> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> >>> @@ -121,6 +121,10 @@ properties:
> >>>            - description: offset of the download mode control register
> >>>      description: TCSR hardware block
> >>>
> >>> +patternProperties:
> >>> +  "^mode-.*$":
> >>
> >> I'd only ever expect mode-edl = <1>. Do we have additional modes that
> >> warrant the generic nature of this?
> > 
> > We may extend this to mode-ramdump if it makes sense, but as of now
> > it's indeed only edl, will fix it.
> 
> Would adding ramdump here be a matter of:
> 
> + mode-ramdump = <0xmagic>
> 
> ?
> 
> If so, please add it too
> 

But what does that mean? "Hey computer, perform a graceful shutdown and
when you're done, give me a ramdump"?

Regards,
Bjorn

> Konrad

