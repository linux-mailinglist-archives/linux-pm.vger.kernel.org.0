Return-Path: <linux-pm+bounces-12046-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E99C194D142
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 15:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FC131C20EF7
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 13:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1B5194C6E;
	Fri,  9 Aug 2024 13:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csOv73yL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEE2192B7F;
	Fri,  9 Aug 2024 13:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723210246; cv=none; b=Nf+fz2euZYHk+ePHW7i52ZH95+rDESa6xKnqxYNnz2SJB+hFBL1iG+t+WjeVri3HDkrrDsO+hPT0+Ooor0E37Oh6s1N/A0K0K8lQImxQirp7AYh9fz1dwPNL5sKcJf+9m70SkuYUOTzK/MBew7xKX3sjI68Qrw8bu1ksx7YUIIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723210246; c=relaxed/simple;
	bh=oARMjVvZYD+OyPOCWbo7ArhDj/Qls8CZ9DQ8yb3NHM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFD0TruAM4gjm7uwEJqXXXmqnOPtZ9CXtKl/4oVjq6mGh6zoBbGlpSEB96SEEXGaMgKxx/FOJPcWO5nlWQCBsuQaJ22+zEHyzk19H8OKDDlDQjZxDpxG8xwXgy0mjmad7d85/v37TsAovS2vWgad1uqDrBFH3GyPlfO4V16lens=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csOv73yL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 703FEC32782;
	Fri,  9 Aug 2024 13:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723210246;
	bh=oARMjVvZYD+OyPOCWbo7ArhDj/Qls8CZ9DQ8yb3NHM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=csOv73yLZ90h0Ejrvv6XpOOvcK8g+XMHhrjYGOHERFKIumDe7R+ByH7iHTyja5jtq
	 YfC77YOM5ktGxTbaliJW2j/StCrJEBd9brmXZG/99u0Wutgfe9hMyu0tR6a1+l+GIe
	 5MUWjBm/w4rbrkQxO5dZD3o3AU5kYrbQ7i0LwkLDoDm2qve77cVPw8OHgYEZuDIR9d
	 QlqTNqdZLUVl0nSM1BOid3+Chtug26gyyxLcExtFZUZs12LjLlo8as1Lr5YN4YBTkD
	 Am8Mb6kLxtT+uMDDwuicnohHJLoQXIQ6PYXmswv4MbQU5Ve5a/hYn4dzITmXfEq98s
	 T7kbNS+GxTUfA==
Date: Fri, 9 Aug 2024 15:30:38 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Elliot Berman <quic_eberman@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Andy Yan <andy.yan@rock-chips.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
	Melody Olvera <quic_molvera@quicinc.com>,
	Shivendra Pratap <quic_spratap@quicinc.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 3/4] firmware: psci: Read and use vendor reset types
Message-ID: <ZrYZ/i1QFhfmv0zi@lpieralisi>
References: <20240617-arm-psci-system_reset2-vendor-reboots-v5-0-086950f650c8@quicinc.com>
 <20240617-arm-psci-system_reset2-vendor-reboots-v5-3-086950f650c8@quicinc.com>
 <ZrOMjomTTWZ91Uzf@lpieralisi>
 <20240807103245593-0700.eberman@hu-eberman-lv.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807103245593-0700.eberman@hu-eberman-lv.qualcomm.com>

On Wed, Aug 07, 2024 at 11:10:50AM -0700, Elliot Berman wrote:

[...]

> > > +static void psci_vendor_sys_reset2(unsigned long action, void *data)
> > 
> > 'action' is unused and therefore it is not really needed.
> > 
> > > +{
> > > +	const char *cmd = data;
> > > +	unsigned long ret;
> > > +	size_t i;
> > > +
> > > +	for (i = 0; i < num_psci_reset_params; i++) {
> > > +		if (!strcmp(psci_reset_params[i].mode, cmd)) {
> > > +			ret = invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2),
> > > +					     psci_reset_params[i].reset_type,
> > > +					     psci_reset_params[i].cookie, 0);
> > > +			pr_err("failed to perform reset \"%s\": %ld\n",
> > > +				cmd, (long)ret);
> > > +		}
> > > +	}
> > > +}
> > > +
> > >  static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
> > >  			  void *data)
> > >  {
> > > +	if (data && num_psci_reset_params)
> > 
> > So, reboot_mode here is basically ignored; if there is a vendor defined
> > reset, we fire it off.
> > 
> > I think Mark mentioned his concerns earlier related to REBOOT_* mode and
> > reset type (granted, the context was different):
> > 
> > https://lore.kernel.org/all/20200320120105.GA36658@C02TD0UTHF1T.local/
> > 
> > I would like to understand if this is the right thing to do before
> > accepting this patchset.
> > 
> 
> I don't have any concerns to move this part below checking reboot_mode.
> Or, I could add reboot_mode == REBOOT_COLD check.

The question is how can we map vendor specific reboot magic to Linux
reboot modes sensibly in generic PSCI code - that's by definition
vendor specific.

Thanks,
Lorenzo

> I'm not sure how best to define the behavior if user sets
> reboot_mode = REBOOT_WARM and then user does "reboot bootloader". IMO,
> "REBOOT_WARM" is at odds with the "bootloader" command. We can have one
> take precedence over the other. I chose for the vendor resets to take
> priority, since if userspace is providing specific command at reboot
> time, that's probably what they want.
> 
> Let me know your thoughts and I'm happy to change the behavior around.
> 
> 
> Thanks,
> Elliot

