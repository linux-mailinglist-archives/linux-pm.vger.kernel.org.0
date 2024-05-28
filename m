Return-Path: <linux-pm+bounces-8267-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDB68D2238
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 19:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93DC3B22B78
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 17:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00105173359;
	Tue, 28 May 2024 17:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMFZs+x7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BC817333F;
	Tue, 28 May 2024 17:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716916439; cv=none; b=LSBWWlYEVK6pIpvh7M/Vr7rci9b7yCBHIZGV2fjE4pWULQ/W4awiyljjBxKrRkls8LNYSHrLozbJNHHTBsofqQlYbzihPVWqLzEDPbaA9e78R5MZg78a8Y3EsJqgUUwp6ucVB3f6iTFniSbyYzZiESFKzZqtve82KJv4uM3u6j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716916439; c=relaxed/simple;
	bh=BF+bAtAxxwKCW4DJkeefBZDu0K+wuFNxBHFCPnA8enU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtXAs8aDfiVjAwkGMxjkvt/L1fnsFpPTjH3QEWc1zqp/q47QQzelGEUHXOT9R2vLBEBAucDmpd4ff+pqNdjKDgRSfet4rzle9ZejgDOOtkRZjvH4lQc1f2NftksbOreyjlJPuT7xBcdL42ElgKSDfgVlDtuhJA0wYOMFI23IlTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMFZs+x7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1717C3277B;
	Tue, 28 May 2024 17:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716916439;
	bh=BF+bAtAxxwKCW4DJkeefBZDu0K+wuFNxBHFCPnA8enU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bMFZs+x7bluwgOhDpFWlsScecIjnUIpA8wwy44nKxYfhDp21ArJ9EGTXYy1VxEqF1
	 x9TXpM9QxBZGm4o1v1LqS9mcped9va6UK0lmdFFjkVQ9ubrudgoiehZ3Lz7aYPrcDS
	 CZcV2KWPGVRc9MF9lJzhe3nDHeJLsvlpYexFNRC/2rCxoOXnChmiFs16/e7IXF/nqt
	 F+AaJqFSCY3pOPE41ePOAPSLd5WO3qXFyNJl/Bc8i7b3U3AI+tfMNrgblQ08Yw03i1
	 ZEfdCsCbwqcPqzrlId7esYThtQvQQznFeYTPpondJK/woStogcP0VwGFHXeCNnFk87
	 kQ0K44ux1N8jg==
Date: Tue, 28 May 2024 12:13:56 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hans de Goede <hdegoede@redhat.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Nikita Travkin <nikita@trvn.ru>
Subject: Re: [PATCH v3 6/6] arm64: dts: qcom: c630: Add Embedded Controller
 node
Message-ID: <njgvpbk4b26qs7zp675xdlmh3pcha6pm2vvvhyrxvrimtltgfx@slyweemaxmhs>
References: <20240527-yoga-ec-driver-v3-0-327a9851dad5@linaro.org>
 <20240527-yoga-ec-driver-v3-6-327a9851dad5@linaro.org>
 <bbsdvqjo2ikljnuvupolpdfstsaegfqyg2ct7bt24evcorcfjt@3fw5eicxxuik>
 <CAA8EJpr9i=+uJGqxeeVYKwJeMqzQFg6FvqnChKNQqXLLVcB66w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpr9i=+uJGqxeeVYKwJeMqzQFg6FvqnChKNQqXLLVcB66w@mail.gmail.com>

On Tue, May 28, 2024 at 06:12:58PM GMT, Dmitry Baryshkov wrote:
> On Tue, 28 May 2024 at 18:06, Bjorn Andersson <andersson@kernel.org> wrote:
> >
> > On Mon, May 27, 2024 at 01:03:51PM GMT, Dmitry Baryshkov wrote:
> > > From: Bjorn Andersson <andersson@kernel.org>
> >
> > Please align this with the S-o-b - feel free to use either form.
> 
> Ack. I'll check what went wrong.
> 
> >
> > >
> > > The Embedded Controller in the Lenovo Yoga C630 is accessible on &i2c1
> > > and provides battery and adapter status, as well as altmode
> > > notifications for the second USB Type-C port.
> > >
> > > Add a definition for the EC.
> > >
> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > ---
> > >  .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts      | 76 ++++++++++++++++++++++
> > >  1 file changed, 76 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> > > index 47dc42f6e936..d975f78eb3ab 100644
> > > --- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> > > +++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
> > > @@ -370,6 +370,66 @@ zap-shader {
> > >  &i2c1 {
> > >       status = "okay";
> > >       clock-frequency = <400000>;
> > > +
> > > +     embedded-controller@70 {
> > > +             compatible = "lenovo,yoga-c630-ec";
> > > +             reg = <0x70>;
> > > +
> > > +             interrupts-extended = <&tlmm 20 IRQ_TYPE_LEVEL_HIGH>;
> > > +
> > > +             pinctrl-names = "default";
> > > +             pinctrl-0 = <&ec_int_state>;
> > > +
> > > +             #address-cells = <1>;
> > > +             #size-cells = <0>;
> > > +
> > > +             connector@0 {
> > > +                     compatible = "usb-c-connector";
> > > +                     reg = <0>;
> > > +                     power-role = "dual";
> > > +                     data-role = "host";
> >
> > I was under the impression that this port is wired directly to the SoC
> > and as such this would support data role switching as well.
> >
> > No concern with that, but just out of curiosity, is this not the case?
> 
> It is wired through the external Type-C port controller RTS5437, which
> also controls the vbus pins, etc. The UCSI firmware reports both ports
> as host-only and doesn't implement data role switching. So, having it
> as "host" is a safe bet.
> 

Thanks for the explanation, that makes sense.

> I must admit, I also hoped to be able to use this port in gadget mode,
> but it seems to be nearly impossible.
> 

Someone must have managed to use the device in peripheral mode to get
the firmware on there originally...just saying... ;)

Regards,
Bjorn

