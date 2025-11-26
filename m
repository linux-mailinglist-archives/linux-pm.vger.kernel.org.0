Return-Path: <linux-pm+bounces-38734-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 350ADC8B2BC
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 18:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AAE63357F26
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 17:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60657274FDB;
	Wed, 26 Nov 2025 17:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHor0WDv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7658E27056F;
	Wed, 26 Nov 2025 17:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764177521; cv=none; b=c3S6QWSkZbEDvM9ciOCrdqDZW5s2L7TGe9YLGcNK6Ymge3XvAKmMCUsY6VX4oManFS22lGUhCLImKv7Y4meQrfi/U5xDoGvLr8qJjFOGarvNL0m6GO1v0hnPE2OidF6T+xhucXEX40bJCB1PYVqvoSmVIRE4ailM+J0qwMUeuaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764177521; c=relaxed/simple;
	bh=QNpZf3xUex3YCkCt1bo+5+Se1H+g3kaaOupJjR57dYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rr62WNFP7atC1QzbgfL/GWyuLWkxuBoUHFiEzX21CFNwe9iqbjJ/a9hQb8mo57kYkV7s0/29LtefOvZ8yNPwtypghHB19e94T6QydA+40UiIwXmN+/utteJT+aeNuMHpEgluBiiJPRCYAkPc+tgQ867Ky1x9hZnBO+1ONKDQ1qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHor0WDv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5784C4CEF7;
	Wed, 26 Nov 2025 17:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764177521;
	bh=QNpZf3xUex3YCkCt1bo+5+Se1H+g3kaaOupJjR57dYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BHor0WDvsu5cCGZ1MM77lOYKzwX+hbRxkuaEXcL4019i0PaMKsd3bqxDwrrzDaQbb
	 K6+Gm2jD0vhvIHIW60L7Sw1iLEMhnB9NlxEKOr3eQHzjmo4GAk0kX8lRXndMVB/qdV
	 yUeFFG1dNicKXHyOiH1f2lx4pNyisGTsVEAPo7SRAkPEQlrbsh+opctTnQc5yYRloa
	 BQUXa/PrpdBzWI6iDu2XagLLQzk7lH+hi4riT6+c9I6fm2cOYIMLKcffik434bQO2N
	 j+Q62yza6zPdMoNkqUeFQm3uFpRn13I+iL+ObWlX8TK/R65xVGwXaqe+20Q4gCtQ2b
	 /hT+PcTGi7VTw==
Date: Wed, 26 Nov 2025 18:18:26 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Yan <andy.yan@rock-chips.com>,
	Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	Konrad Dybcio <konradybcio@kernel.org>,
	cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Moritz Fischer <moritz.fischer@ettus.com>,
	John Stultz <john.stultz@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Stephen Boyd <swboyd@chromium.org>,
	Andre Draszik <andre.draszik@linaro.org>,
	Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	Elliot Berman <quic_eberman@quicinc.com>,
	Xin Liu <xin.liu@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Umang Chheda <umang.chheda@oss.qualcomm.com>,
	Nirmesh Kumar Singh <nirmesh.singh@oss.qualcomm.com>
Subject: Re: [PATCH v17 07/12] firmware: psci: Implement vendor-specific
 resets as reboot-mode
Message-ID: <aSc2Yh3AvLXOBvcz@lpieralisi>
References: <20251109-arm-psci-system_reset2-vendor-reboots-v17-0-46e085bca4cc@oss.qualcomm.com>
 <20251109-arm-psci-system_reset2-vendor-reboots-v17-7-46e085bca4cc@oss.qualcomm.com>
 <aRIfc9iuC2b9DqI+@lpieralisi>
 <80e68e44-a8e0-464a-056e-9f087ad40d51@oss.qualcomm.com>
 <aRxmWrAkD0Vu4pF+@lpieralisi>
 <1da024e7-efb1-3a1c-cc13-0ae5212ed8bd@oss.qualcomm.com>
 <aR2P4CxQNebac6oU@lpieralisi>
 <682b1a0c-644f-2aff-1860-cbf9a53bc62b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <682b1a0c-644f-2aff-1860-cbf9a53bc62b@oss.qualcomm.com>

On Wed, Nov 19, 2025 at 05:32:42PM +0530, Shivendra Pratap wrote:
> 
> 
> On 11/19/2025 3:07 PM, Lorenzo Pieralisi wrote:
> > On Tue, Nov 18, 2025 at 11:11:33PM +0530, Shivendra Pratap wrote:
> > 
> > [...]
> > 
> >>> Yes this could be a potential way forward but that's decoupled from the
> >>> options below. If we take this route PSCI maintainers should be added
> >>> as maintainers for this reboot mode driver.
> >>
> >> you mean the new psci_reset driver? yes. Maintainer would be PSCI maintainer,
> >> if we create a new  psci_reset reboot mode driver.
> > 
> > Yes.
> > 
> >>>> - struct with pre-built psci reset_types - (warm, soft, cold). Currently
> >>>>   only two modes supported, anything other than warm/soft defaults to cold.
> >>>> - vendor resets to be added as per vendor choice, inside psci device tree(SOC specific).
> >>>> - psci_reset registers with reboot-mode for registering  vendor resets. Here, we
> >>>>   have a problem, the pre-built psci reset_types - (warm, soft, cold) cannot be added via
> >>>>   reboot-mode framework.
> >>>
> >>> Why ?
> >>
> >> If we want the new psci_reset to take the reboot-mode framework route, is it ok to
> >> add default modes (warm, cold) in the device tree?
> >> If not, then the design of reboot-mode framework(power:reset:reboot-mode.c) needs to be
> >> further changed to equip this new feature. 
> > 
> > Well, yes, all it needs to do is allowing prepopulated reboot modes on top
> > of which DT based ones are added.
> 
> The mode-cold , adds a third variable to reboot-modes as the first parameter for 
> invoke_psci_fn is different for cold vs warm/vendor.
> 
> cold reset call       : invoke_psci_fn(PSCI_0_2_FN_SYSTEM_RESET, 0, 0, 0);
> vendor/warm reset call: invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2), vendor, cookiee, 0);
> 
> Each mode will have 3 argument - like:
> _ _ _ _ _ _ _ _ _ _ _ _ _  _ _ _ _ _ _ 
> MODE   , cold reset, reset_type, cookie
> _ _ _ _ _ _ _ _ _ _ _ _ _  _ _ _ _ _ _ - 
> COLD   ,   1       ,    0      ,     0
> WARM   ,   0       ,    0      ,     0
> vendor1,   0       ,0x80000000 ,     1
> vendor2,   0       ,0x80000010 ,     0
> 
> So reboot-mode framework will now define and support upto three 32 bit arguments for each mode?

The cookie value is unused for SYSTEM_WARM_RESET, you can encode there whether
it is a cold (SYSTEM_RESET) or warm (SYSTEM_RESET2 - SYSTEM_WARM_RESET) architectural
reset when the magic value(aka reset_type) == 0x0 ?

The reboot mode parameters do not necessarily need to map to PSCI function
calls parameters - provided we define that explicitly.

Lorenzo

