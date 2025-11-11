Return-Path: <linux-pm+bounces-37793-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69653C4F02E
	for <lists+linux-pm@lfdr.de>; Tue, 11 Nov 2025 17:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB8EE3BB6A0
	for <lists+linux-pm@lfdr.de>; Tue, 11 Nov 2025 16:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9359E36CDFC;
	Tue, 11 Nov 2025 16:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUjvpjMb"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613D036C59A;
	Tue, 11 Nov 2025 16:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762878063; cv=none; b=RDh726Ui86PJtPROAqm9U7Q7J8be5P/YFoMBEbPfTCZYIita8cdGIc6rRRBZsfEkVhVelTXJwEBTtS5xAMrGyQRrRsDYuShdZyYDW9OX3N9qkuJBtzRTVJXozvqBF7NXJWBPn9jCNmOHlxJNaeZbkqrC1Mrz7nXHPrKWPUr+njE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762878063; c=relaxed/simple;
	bh=iovQHCOTUN55wUvNH0b2ic0AbO7TgNyy9k87I1v/EvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Utc2oQOLLDJfPuYjPK+bvLspUVjrqcvhNKx12rmwDrcJpyDtUlHLofvHDgQOixKdiwDs1/4SybO6JnKyLZikKyekmvaTJH23e5TZVTJ4Dt9OmEwiFfbKy6Vc+yUjX6FNBKGjIt0/CfV5CWAj6dqXb+8t/sZy8MntBRoHnkzycBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUjvpjMb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63CBC4CEF5;
	Tue, 11 Nov 2025 16:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762878063;
	bh=iovQHCOTUN55wUvNH0b2ic0AbO7TgNyy9k87I1v/EvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mUjvpjMb5nWSH3Ej5Z6ekUtxyctHK1iWozXPaNNnLbgkyXsh7sIh6/wpN3U2Kqtaz
	 pgz1NYRD0Ge54tnICRqeTqxB/U709bSsmp4nAMLBENSYcuJi8j88LicRiTH55yp1R4
	 4cmPMfvFaaN+92h00ZpxOjncZfiqBh79fYETDtMIf0zKtsslp11kNiiwXUmSO8ZRue
	 xt4sold8J7PsWbk5uoXkPaG23sxeWhlUHlK75vxwyGliH7XfqyVMKLNFo626dsivUn
	 1v2iVu4b1OzKgn8BBC9Zl4bWdMRk0OiLJiwUxAAB8dhZmQtzERxkkTVdLvrn8ElOpu
	 BdA50TiZ+15XQ==
Date: Tue, 11 Nov 2025 10:25:13 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Sebastian Reichel <sre@kernel.org>, 
	Rob Herring <robh@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
	Souvik Chakravarty <Souvik.Chakravarty@arm.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Andy Yan <andy.yan@rock-chips.com>, 
	Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Konrad Dybcio <konradybcio@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Moritz Fischer <moritz.fischer@ettus.com>, 
	John Stultz <john.stultz@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Stephen Boyd <swboyd@chromium.org>, Andre Draszik <andre.draszik@linaro.org>, 
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, Elliot Berman <quic_eberman@quicinc.com>, 
	Xin Liu <xin.liu@oss.qualcomm.com>, Srinivas Kandagatla <srini@kernel.org>, 
	Umang Chheda <umang.chheda@oss.qualcomm.com>, Nirmesh Kumar Singh <nirmesh.singh@oss.qualcomm.com>
Subject: Re: [PATCH v17 03/12] power: reset: reboot-mode: Add support for 64
 bit magic
Message-ID: <axle2c3i3vfyxpql43dqb4zwzjj65xhsjuhojyf5x26wqo352v@z3nwctubwanx>
References: <20251109-arm-psci-system_reset2-vendor-reboots-v17-0-46e085bca4cc@oss.qualcomm.com>
 <20251109-arm-psci-system_reset2-vendor-reboots-v17-3-46e085bca4cc@oss.qualcomm.com>
 <20251110134529.uljjqzb3vhda3vya@hu-mojha-hyd.qualcomm.com>
 <gzj4r4elqewjt2gjzhuamslvobz5fgyvt672brwknoozlsplaq@wsebzmi2l6pc>
 <681a72ba-d8fb-bfc2-d2bb-d80ac667bc5c@oss.qualcomm.com>
 <zejaqakbtufwzlzs7xc7xzxezcylqjkmu4nne2mro4riuhgbkc@hlgu3u2w36bb>
 <5c83c9a1-e123-95bb-1434-588ee8c52b25@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c83c9a1-e123-95bb-1434-588ee8c52b25@oss.qualcomm.com>

On Tue, Nov 11, 2025 at 08:20:43PM +0530, Shivendra Pratap wrote:
> 
> 
> On 11/11/2025 12:03 AM, Bjorn Andersson wrote:
> > On Mon, Nov 10, 2025 at 11:22:40PM +0530, Shivendra Pratap wrote:
> >>
> >>
> >> On 11/10/2025 10:00 PM, Bjorn Andersson wrote:
> >>> On Mon, Nov 10, 2025 at 07:15:29PM +0530, Mukesh Ojha wrote:
> >>>> On Sun, Nov 09, 2025 at 08:07:16PM +0530, Shivendra Pratap wrote:
> >>>>> Current reboot-mode supports a single 32-bit argument for any
> >>>>> supported mode. Some reboot-mode based drivers may require
> >>>>> passing two independent 32-bit arguments during a reboot
> >>>>> sequence, for uses-cases, where a mode requires an additional
> >>>>> argument. Such drivers may not be able to use the reboot-mode
> >>>>> driver. For example, ARM PSCI vendor-specific resets, need two
> >>>>> arguments for its operation – reset_type and cookie, to complete
> >>>>> the reset operation. If a driver wants to implement this
> >>>>> firmware-based reset, it cannot use reboot-mode framework.
> >>>>>
> >>>>> Introduce 64-bit magic values in reboot-mode driver to
> >>>>> accommodate dual 32-bit arguments when specified via device tree.
> >>>>> In cases, where no second argument is passed from device tree,
> >>>>> keep the upper 32-bit of magic un-changed(0) to maintain backward
> >>>>> compatibility.
> >>>>>
> >>>>> Update the current drivers using reboot-mode for a 64-bit magic
> >>>>> value.
> >>
> >> [SNIP..]
> >>
> >>>>> +	if (magic > U32_MAX)
> >>>>> +		return -EINVAL;
> >>>>> +
> >>>>> +	magic_32 = magic;
> >>>>> +
> >>>>>  	syscon_rbm = container_of(reboot, struct syscon_reboot_mode, reboot);
> >>>>>  
> >>>>>  	ret = regmap_update_bits(syscon_rbm->map, syscon_rbm->offset,
> >>>>> -				 syscon_rbm->mask, magic);
> >>>>> +				 syscon_rbm->mask, magic_32);
> >>>
> >>> As above, if we're no longer silently discarding bits, I think we should
> >>> compare the magic against syscon_rbm->mask.
> >>>
> >>> No need for a local variable, just type cast after checking the validity.
> >>
> >> Trying to summarize below why we added these check-
> >>
> >> the patch in v11 used typecasting and did not have any of these checks(link below):
> >> https://lore.kernel.org/all/20250717-arm-psci-system_reset2-vendor-reboots-v11-2-df3e2b2183c3@oss.qualcomm.com/
> >>
> >> As per below upstream review, type cast was removed and bound checks were added all-over patchset:
> >> "As a general rule of thumb, code with casts is poor quality code. Try
> >> to write the code without casts." - 
> >> https://lore.kernel.org/all/8d4a42b6-657f-4c30-8e25-4213d8d53a89@lunn.ch/
> >>
> >> We can revert to the typecast way. Please suggest.
> >>
> > 
> > Okay, I'm okay with Andrew's original request, stick to that for the
> > nvmem case. Although I don't fancy the name "magic_32", and would prefer
> > that you just call it "value" or something.
> 
> sure will make it proper wherever applicable. 
> 
> > 
> > 
> > For pon and syscon however, I'm wondering why you have ignored Andrew's
> > other request from that same email:
> > 
> > """
> > You might be able to go further, and validate that magic actually fits
> > into the field when you consider the << pon->reason_shift.
> > """
> > 
> > Writing "if (magic > U32_MAX)" in a snippet of code where magic isn't
> > allowed to be more than either 32 or 64 is misleading.
> > 
> > For syscon, it's true that the parameter is an unsigned long, but the
> > actual limit better be based on syscon_rbm->mask.
> 
> May be i was not able to interpret it correctly. Basically tried to
> make sure that magic that now coming in a "u64 magic" should be passed
> ahead only it its a 32 bit value.
> 

That is the correct interpretation of the original ask. But what I'm
saying is that if you write:

if (magic > U32_MAX)

then that means "check that magic isn't larger than 32 bits". So the
reader will see that and understand that magic can only be 32 bits.

But the actual PON magic value is 5 or 6 bits, not 32 - so you should
check that the value fits in 5 or 6 bits.

> So should i get rid of the checks done here for syscon and pon?
> 

Continuing to silently ignoring other bits would be one option, but
you've been asked to sanity check the values, so please do that. You
have the code, just compare with the correct value.

Regards,
Bjorn

> thanks,
> Shivendra

