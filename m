Return-Path: <linux-pm+bounces-37757-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C21C4896A
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 19:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE3B74F232E
	for <lists+linux-pm@lfdr.de>; Mon, 10 Nov 2025 18:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E0F32E6AD;
	Mon, 10 Nov 2025 18:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmdgkZUw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE81632E6A0;
	Mon, 10 Nov 2025 18:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762799345; cv=none; b=K/lo6881LFE0Ox2mbizaQojDiNv9bUuKSAIPT9m+NRQitBYU0LDBcfz2gi/nwrzYP/3hVZYeUOxe/h15FMdfm69PI5aoBshSj7qfo6WaylcKj1mlIbWwsqMWliy8bFK8WSJQFuqXlEQdT2EzzuKGe0mOXb3/GEmSQSAbxPbsmaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762799345; c=relaxed/simple;
	bh=u9Jb89JkKBZeEXePVaq8UqB4TuhULaWnLyCjR38ppvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIPAsVfzqnC6HLkuO3lZ/k6LVTpuJVa+K7kCpvhTnv5jMINV8Iq0dK+CCXugUZxCmWNDAN+ZZzEi/9pDtIJLbu/jTZ9HS8at9BsR4ZecvYZU4FcwzcfCXJp0iqOD62AwnKxgbMr1/DO3svm+04urP/elGmdMxAo96DzUxF+3mLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmdgkZUw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63A2C4CEF5;
	Mon, 10 Nov 2025 18:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762799345;
	bh=u9Jb89JkKBZeEXePVaq8UqB4TuhULaWnLyCjR38ppvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nmdgkZUwBErlZ4R16rraci9mo0wDpQbaUlJ80M2tD0YhX2zZBk4FM55WGhg6jopmP
	 8TLIN7zJLQlkoApbwuqW02D6rWpvDo6pZcGSVwrqJ+OTOOZaFw477qCXI6ekqSD1wk
	 DAtMwRluIYZ2U1Uaz9xCCWzihVzLJH49FMJN77vrbtb4tvcilMbPkfiZng/AERMyb7
	 5pz8cAXv+gchZkSZRd34XnFwevKx+uRiARAzJbM3yYR4oS7zLY5zizhkSURATxvYST
	 1e/WDB6iTHrIsA757VXJ91Xey3mb7tPLIdrc9Hpg+xcEzyEevI13Vnwndb0fU+oeI2
	 8n/sodalpELIA==
Date: Mon, 10 Nov 2025 12:33:10 -0600
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
Message-ID: <zejaqakbtufwzlzs7xc7xzxezcylqjkmu4nne2mro4riuhgbkc@hlgu3u2w36bb>
References: <20251109-arm-psci-system_reset2-vendor-reboots-v17-0-46e085bca4cc@oss.qualcomm.com>
 <20251109-arm-psci-system_reset2-vendor-reboots-v17-3-46e085bca4cc@oss.qualcomm.com>
 <20251110134529.uljjqzb3vhda3vya@hu-mojha-hyd.qualcomm.com>
 <gzj4r4elqewjt2gjzhuamslvobz5fgyvt672brwknoozlsplaq@wsebzmi2l6pc>
 <681a72ba-d8fb-bfc2-d2bb-d80ac667bc5c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <681a72ba-d8fb-bfc2-d2bb-d80ac667bc5c@oss.qualcomm.com>

On Mon, Nov 10, 2025 at 11:22:40PM +0530, Shivendra Pratap wrote:
> 
> 
> On 11/10/2025 10:00 PM, Bjorn Andersson wrote:
> > On Mon, Nov 10, 2025 at 07:15:29PM +0530, Mukesh Ojha wrote:
> >> On Sun, Nov 09, 2025 at 08:07:16PM +0530, Shivendra Pratap wrote:
> >>> Current reboot-mode supports a single 32-bit argument for any
> >>> supported mode. Some reboot-mode based drivers may require
> >>> passing two independent 32-bit arguments during a reboot
> >>> sequence, for uses-cases, where a mode requires an additional
> >>> argument. Such drivers may not be able to use the reboot-mode
> >>> driver. For example, ARM PSCI vendor-specific resets, need two
> >>> arguments for its operation – reset_type and cookie, to complete
> >>> the reset operation. If a driver wants to implement this
> >>> firmware-based reset, it cannot use reboot-mode framework.
> >>>
> >>> Introduce 64-bit magic values in reboot-mode driver to
> >>> accommodate dual 32-bit arguments when specified via device tree.
> >>> In cases, where no second argument is passed from device tree,
> >>> keep the upper 32-bit of magic un-changed(0) to maintain backward
> >>> compatibility.
> >>>
> >>> Update the current drivers using reboot-mode for a 64-bit magic
> >>> value.
> 
> [SNIP..]
> 
> >>> +	if (magic > U32_MAX)
> >>> +		return -EINVAL;
> >>> +
> >>> +	magic_32 = magic;
> >>> +
> >>>  	syscon_rbm = container_of(reboot, struct syscon_reboot_mode, reboot);
> >>>  
> >>>  	ret = regmap_update_bits(syscon_rbm->map, syscon_rbm->offset,
> >>> -				 syscon_rbm->mask, magic);
> >>> +				 syscon_rbm->mask, magic_32);
> > 
> > As above, if we're no longer silently discarding bits, I think we should
> > compare the magic against syscon_rbm->mask.
> > 
> > No need for a local variable, just type cast after checking the validity.
> 
> Trying to summarize below why we added these check-
> 
> the patch in v11 used typecasting and did not have any of these checks(link below):
> https://lore.kernel.org/all/20250717-arm-psci-system_reset2-vendor-reboots-v11-2-df3e2b2183c3@oss.qualcomm.com/
> 
> As per below upstream review, type cast was removed and bound checks were added all-over patchset:
> "As a general rule of thumb, code with casts is poor quality code. Try
> to write the code without casts." - 
> https://lore.kernel.org/all/8d4a42b6-657f-4c30-8e25-4213d8d53a89@lunn.ch/
> 
> We can revert to the typecast way. Please suggest.
> 

Okay, I'm okay with Andrew's original request, stick to that for the
nvmem case. Although I don't fancy the name "magic_32", and would prefer
that you just call it "value" or something.


For pon and syscon however, I'm wondering why you have ignored Andrew's
other request from that same email:

"""
You might be able to go further, and validate that magic actually fits
into the field when you consider the << pon->reason_shift.
"""

Writing "if (magic > U32_MAX)" in a snippet of code where magic isn't
allowed to be more than either 32 or 64 is misleading.

For syscon, it's true that the parameter is an unsigned long, but the
actual limit better be based on syscon_rbm->mask.

Regards,
Bjorn

> thanks,
> Shivendra

