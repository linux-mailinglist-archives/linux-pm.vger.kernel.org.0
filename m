Return-Path: <linux-pm+bounces-9898-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B37979152B5
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 17:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CBC31F212DF
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 15:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA7419CD10;
	Mon, 24 Jun 2024 15:41:50 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F9719D077;
	Mon, 24 Jun 2024 15:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719243710; cv=none; b=eIv2j73BcB/zsLuGJ3xvS3Z1+cXDNkU26u6Z/PYZPDJhOVpEmyKQjHBU8KCJ9W0jXX0j95FElRXMtI18EQja6azrxFJTNPGBRJ5V6Flab0PDzhV1yIHNW94/QzdTHungAKSCTSY0E4SYuDx515QHtI7eRBAuFVTNq0J4nf4ffS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719243710; c=relaxed/simple;
	bh=3dz1GFXIvgH5i6DZjwGNKWeBzYGIWxh02+vy/2Ekez0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpvdlEZdkdz7Qe71SRdi/2q+uVAcKAQ4qisRuHD8tTLkKsSNFjAIFTUhEbXh/3hvVmmKVqlBFTuGZ10NTaKcr31OXcrqLjW1Z2NzI6bnRvHEsQTvAfzBZT479tq2mN5+egFulauqiolx8qaAZf8+1Bf2pz5ky6ss2OIX1fudrzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A71DDA7;
	Mon, 24 Jun 2024 08:42:12 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DD2D3F73B;
	Mon, 24 Jun 2024 08:41:44 -0700 (PDT)
Date: Mon, 24 Jun 2024 16:41:42 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Elliot Berman <quic_eberman@quicinc.com>
Cc: Sebastian Reichel <sre@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Andy Yan <andy.yan@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Mark Rutland" <mark.rutland@arm.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
	Melody Olvera <quic_molvera@quicinc.com>,
	Shivendra Pratap <quic_spratap@quicinc.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	<linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v5 3/4] firmware: psci: Read and use vendor reset types
Message-ID: <ZnmTtmZB8epgbUTN@bogus>
References: <20240617-arm-psci-system_reset2-vendor-reboots-v5-0-086950f650c8@quicinc.com>
 <20240617-arm-psci-system_reset2-vendor-reboots-v5-3-086950f650c8@quicinc.com>
 <20240619135143.kr2tx4ynxayc5v3a@bogus>
 <20240619080933071-0700.eberman@hu-eberman-lv.qualcomm.com>
 <20240620162547309-0700.eberman@hu-eberman-lv.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620162547309-0700.eberman@hu-eberman-lv.qualcomm.com>

On Thu, Jun 20, 2024 at 04:37:09PM -0700, Elliot Berman wrote:
> Hi Sudeep and Sebastian,
> 
> On Wed, Jun 19, 2024 at 08:28:06AM -0700, Elliot Berman wrote:
> > On Wed, Jun 19, 2024 at 02:51:43PM +0100, Sudeep Holla wrote:
> > > On Mon, Jun 17, 2024 at 10:18:09AM -0700, Elliot Berman wrote:
> > > > SoC vendors have different types of resets and are controlled through
> > > > various registers. For instance, Qualcomm chipsets can reboot to a
> > > > "download mode" that allows a RAM dump to be collected. Another example
> > > > is they also support writing a cookie that can be read by bootloader
> > > > during next boot. PSCI offers a mechanism, SYSTEM_RESET2, for these
> > > > vendor reset types to be implemented without requiring drivers for every
> > > > register/cookie.
> > > > 
> > > > Add support in PSCI to statically map reboot mode commands from
> > > > userspace to a vendor reset and cookie value using the device tree.
> > > > 
> > > > A separate initcall is needed to parse the devicetree, instead of using
> > > > psci_dt_init because mm isn't sufficiently set up to allocate memory.
> > > > 
> > > > Reboot mode framework is close but doesn't quite fit with the
> > > > design and requirements for PSCI SYSTEM_RESET2. Some of these issues can
> > > > be solved but doesn't seem reasonable in sum:
> > > >  1. reboot mode registers against the reboot_notifier_list, which is too
> > > >     early to call SYSTEM_RESET2. PSCI would need to remember the reset
> > > >     type from the reboot-mode framework callback and use it
> > > >     psci_sys_reset.
> > > >  2. reboot mode assumes only one cookie/parameter is described in the
> > > >     device tree. SYSTEM_RESET2 uses 2: one for the type and one for
> > > >     cookie.
> > > >  3. psci cpuidle driver already registers a driver against the
> > > >     arm,psci-1.0 compatible. Refactoring would be needed to have both a
> > > >     cpuidle and reboot-mode driver.
> > > >
> > > 
> > > I need to think through it but when you first introduced the generic
> > > Documentation/devicetree/bindings/power/reset/reboot-mode.yaml bindings
> > > I also looked at drivers/power/reset/reboot-mode.c
> > > 
> > > I assumed this extension to that binding would reuse the same and
> > > PSCI would just do reboot_mode_register(). I didn't expect to see these
> > > changes. I might have missing something but since the bindings is still
> > > quite generic with additional cells that act as additional cookie for
> > > reboot call, I still think that should be possible.
> > > 
> > > What am I missing here then ?
> > > 
> > 
> > Right, if that was only thing to "solve" to make it easy to use
> > reboot-mode framework, I agree we should update reboot mode framework to
> > work with the additional cells. There are a few other issues I mention
> > above which, when combined, make me feel that PSCI is different enough
> > from how reboot mode framework works that we shouldn't try to make PSCI
> > work with the framework. Issues #1 and #2 are pretty easy to solve
> > (whether they should be solved is different); I'm not sure a good
> > approach to issue #3.
> > 
> 
> Does the reasoning I mention in the commit text make sense why PSCI should
> avoid using the reboot-mode.c framework?

Sorry, I completely missed to see that you had already answered those
in your commit message. As mentioned earlier I haven't looked at the
reboot mode framework completely yet, so I can't comment on it yet.

I don't want to be blocker though if others are happy with this.

--
Regards,
Sudeep

