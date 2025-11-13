Return-Path: <linux-pm+bounces-37970-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76100C59467
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 18:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C7AC4E9F93
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 17:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0332FA0C4;
	Thu, 13 Nov 2025 17:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtO+0+Xg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0612F3608;
	Thu, 13 Nov 2025 17:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763055276; cv=none; b=dH8xLI7UtVyv7KpKOzIp1ZGlgx6PMDa9IhBGdmo38ljLHJY8Woe8Fi96GMrs0EFfTH1HAyQYXlwoEVx/geR6DGvVsD0MzaMOAFa8cvv38jLlhfLHQEFR4b/ol4n6cI6tfPUvKt5ggs+VON7kGwXiwDj38uQqizlx53btEu2+52o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763055276; c=relaxed/simple;
	bh=PsQ43iPC+m7NY165IqqewmgolKO/wnPlHwhX1BL3SAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXlAtrVogu/4Ddu+wTtwHSbuU6T7eSk7UeBmc7dKUoKumLNAQ3uffbRo4rV/SYUJn7JCUL/ZRNGsKXJlVUaCzWgGMSUPiuYdv8rmclfvTnynozgrDwJIvMgr23g6c4gVlqV2Kz3hWh57P8b19k+qsU1ToM5Q5eQ9AEucPNEiVUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtO+0+Xg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05936C4CEF5;
	Thu, 13 Nov 2025 17:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763055275;
	bh=PsQ43iPC+m7NY165IqqewmgolKO/wnPlHwhX1BL3SAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DtO+0+XgKr0OVQWinfPOXS7/kpI4avPTAHNWYAFyFbQ2HSF9G8m0lLuFMPF6GzVeQ
	 VziZc2IGT0vjEa1CMVxv6DqyKrsnr/LMgQO8ePUQgOFnzZ9uC9MVU+9N6RuMsqk2AB
	 uC9Kmml+ZwcG9W7cI62XOxmJW4509GGucf39A5Ye/SgnpAhuyrCVY5Ay0C7xTgS2xs
	 dmAm+u8iZ/TVlkzN+LjzabAod36RsSE+FYTgKz0GACITCaz+wo5rLrZWdzs3c3F8lf
	 CTwUDx1SPasXxHI9pVefGS5YiNrxYITTMlzg8n9Gxw3F0wuqMWBVUXeAHtVNfQj8kt
	 fFsxM6r5kr8kA==
Date: Thu, 13 Nov 2025 11:38:58 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>, konradybcio@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, sre@kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/5] dt-bindings: firmware: qcom,scm: Document reboot mode
Message-ID: <7dxmrq2u4fn4cck5mxfmge4rr7v7zqxp33pkj2v22dzzs7vqfb@mx6ja6cu343f>
References: <20251103182006.1158383-1-loic.poulain@oss.qualcomm.com>
 <20251103182006.1158383-4-loic.poulain@oss.qualcomm.com>
 <aqoxdaq72prkeqwxmmohlmbpx7icuc32sej7did6vt6rzrgfib@bvmt7ppkvloc>
 <CAFEp6-2GGA2gvBKfO0fZemVmJmjQpTQEJ0vLfEewfhHKOYQGSQ@mail.gmail.com>
 <be0a418b-5e8f-4895-a3b8-482b6ad6a40e@oss.qualcomm.com>
 <sdhnchve6r5i4frhlx5q7lod5npzosbfdjjyd56l2z5ksoe4t4@lhm6d2pzsztm>
 <fcb093e3-05e6-4e77-9150-25f9a76f8937@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fcb093e3-05e6-4e77-9150-25f9a76f8937@oss.qualcomm.com>

On Thu, Nov 13, 2025 at 12:00:40PM +0100, Konrad Dybcio wrote:
> On 11/12/25 5:36 PM, Bjorn Andersson wrote:
> > On Wed, Nov 05, 2025 at 10:44:05AM +0100, Konrad Dybcio wrote:
> >> On 11/4/25 10:19 PM, Loic Poulain wrote:
> >>> On Tue, Nov 4, 2025 at 3:12 AM Bjorn Andersson <andersson@kernel.org> wrote:
> >>>>
> >>>> On Mon, Nov 03, 2025 at 07:20:04PM +0100, Loic Poulain wrote:
> >>>>> SCM can be used to support reboot mode such as Emergency Recovery Mode.
> >>>>
> >>>> "such as"? Do we have any other useful bits in here?
> >>>
> >>>  I heard we may have different EDL modes supported like USB or SD
> >>> based EDL, but I don't know much about the details.
> >>>
> >>>>
> >>>>>
> >>>>> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> >>>>> ---
> >>>>>  Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 4 ++++
> >>>>>  1 file changed, 4 insertions(+)
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> >>>>> index b913192219e4..c8bb7dacd900 100644
> >>>>> --- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> >>>>> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> >>>>> @@ -121,6 +121,10 @@ properties:
> >>>>>            - description: offset of the download mode control register
> >>>>>      description: TCSR hardware block
> >>>>>
> >>>>> +patternProperties:
> >>>>> +  "^mode-.*$":
> >>>>
> >>>> I'd only ever expect mode-edl = <1>. Do we have additional modes that
> >>>> warrant the generic nature of this?
> >>>
> >>> We may extend this to mode-ramdump if it makes sense, but as of now
> >>> it's indeed only edl, will fix it.
> >>
> >> Would adding ramdump here be a matter of:
> >>
> >> + mode-ramdump = <0xmagic>
> >>
> >> ?
> >>
> >> If so, please add it too
> >>
> > 
> > But what does that mean? "Hey computer, perform a graceful shutdown and
> > when you're done, give me a ramdump"?
> 
> I.. guess?
> 
> Perhaps it could be useful for registering a panic handler to reboot
> into ramdump in case that's not enabled by deafult (but is that
> possible with our fw?)
> 

That should be covered the other way around today, if the user asks for
ramdumps to be collected then we set that up at boot, which we then
clear on a clean shutdown.

So, that should cover the panic() case as well - although I've not
figured out how to load the ramdump in crash, so it's been a long while
since I had reason to test this myself.

Regards,
Bjorn

> Konrad

