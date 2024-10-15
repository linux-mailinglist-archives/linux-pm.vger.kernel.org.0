Return-Path: <linux-pm+bounces-15652-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BC399E9CA
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 14:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 469561C20AD0
	for <lists+linux-pm@lfdr.de>; Tue, 15 Oct 2024 12:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAD81F709E;
	Tue, 15 Oct 2024 12:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwggUooR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974B4206975;
	Tue, 15 Oct 2024 12:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728995205; cv=none; b=UCz94UtV/zZAAFD0073iAN12/rbnuIBj0poOMaON/yQQs4kt3sZY2Z0487LRiYCQqGMbVwsLxk/6Qk3KVmZv/4c/PHcV45JSkVlGBg4TZiEFrqe+h5fEraFbqHgE+c8GgYI46q5/+oYQmY99/zj61IFQ7jO8uMiOEaGKEoWp4u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728995205; c=relaxed/simple;
	bh=NYbHOMwMrdG/wiT8RCznhicJLT/5UcM5sidpVpTNIvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7aGNfXqwWSThW4M20knv2XDTk9M6HqgL5oFK3XAoVI2XFAuaISllxHPZ4X2qxm/C5qMsjippv6loThxd8hAOeNI3xp+RhRQiUAzerb/T+uotJc9Asr2wI+YJOsjthGb6OYXzBGQJ0pRCUzrmFVqHTcV43MHuLMmuIPh3WgApig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwggUooR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D3D8C4CEC6;
	Tue, 15 Oct 2024 12:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728995205;
	bh=NYbHOMwMrdG/wiT8RCznhicJLT/5UcM5sidpVpTNIvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EwggUooRAbrIXkMRbaDLuwY6cbRSNxUb+yU2CwJ8fCkc/gqjuOIZLjldGepu1+/SE
	 iQ9eC7BABbaFAqW41FBAwXx8xUaoYChyUjU5yEEYWLnI6S6eH2654d7JDoOp9oUAHZ
	 J5vIVUt5tzvwtaBYO3Gadc0irVHL2LT8BK4gV9gAiiXE9ED7LV4KAHDgp2L0T44+3V
	 q327O+flBAflHrT2wqg3/lq/fWKx+PyGbs1+ZQ09IpqNfsbcnsuE74maVopIa2X2uK
	 pOSRS8G4kWcWoAQPdKhm8yuKOQ+kcRSzClntfW6W716yrOjj81aHuXUcb30OS8WKQQ
	 hiiwZXIvaAgeg==
Date: Tue, 15 Oct 2024 14:26:37 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Elliot Berman <quic_eberman@quicinc.com>
Cc: Shivendra Pratap <quic_spratap@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Andy Yan <andy.yan@rock-chips.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
	Melody Olvera <quic_molvera@quicinc.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	quic_spratap@qucinc.com
Subject: Re: [PATCH v5 3/4] firmware: psci: Read and use vendor reset types
Message-ID: <Zw5ffeYW5uRpsaG3@lpieralisi>
References: <20240617-arm-psci-system_reset2-vendor-reboots-v5-0-086950f650c8@quicinc.com>
 <20240617-arm-psci-system_reset2-vendor-reboots-v5-3-086950f650c8@quicinc.com>
 <ZrOMjomTTWZ91Uzf@lpieralisi>
 <20240807103245593-0700.eberman@hu-eberman-lv.qualcomm.com>
 <ZrYZ/i1QFhfmv0zi@lpieralisi>
 <20240809090339647-0700.eberman@hu-eberman-lv.qualcomm.com>
 <28c8bc92-4a55-8a07-1ece-333316d78410@quicinc.com>
 <Zr4Td7PiKhKl3Et3@lpieralisi>
 <20240815100749641-0700.eberman@hu-eberman-lv.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240815100749641-0700.eberman@hu-eberman-lv.qualcomm.com>

On Thu, Aug 15, 2024 at 11:05:09AM -0700, Elliot Berman wrote:
> On Thu, Aug 15, 2024 at 04:40:55PM +0200, Lorenzo Pieralisi wrote:
> > On Mon, Aug 12, 2024 at 11:46:08PM +0530, Shivendra Pratap wrote:
> > > 
> > > 
> > > On 8/9/2024 10:28 PM, Elliot Berman wrote:
> > > > On Fri, Aug 09, 2024 at 03:30:38PM +0200, Lorenzo Pieralisi wrote:
> > > >> On Wed, Aug 07, 2024 at 11:10:50AM -0700, Elliot Berman wrote:
> > > >>
> > > >> [...]
> > > >>
> > > >>>>> +static void psci_vendor_sys_reset2(unsigned long action, void *data)
> > > >>>>
> > > >>>> 'action' is unused and therefore it is not really needed.
> > > >>>>
> > > >>>>> +{
> > > >>>>> +	const char *cmd = data;
> > > >>>>> +	unsigned long ret;
> > > >>>>> +	size_t i;
> > > >>>>> +
> > > >>>>> +	for (i = 0; i < num_psci_reset_params; i++) {
> > > >>>>> +		if (!strcmp(psci_reset_params[i].mode, cmd)) {
> > > >>>>> +			ret = invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2),
> > > >>>>> +					     psci_reset_params[i].reset_type,
> > > >>>>> +					     psci_reset_params[i].cookie, 0);
> > > >>>>> +			pr_err("failed to perform reset \"%s\": %ld\n",
> > > >>>>> +				cmd, (long)ret);
> > > >>>>> +		}
> > > >>>>> +	}
> > > >>>>> +}
> > > >>>>> +
> > > >>>>>  static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
> > > >>>>>  			  void *data)
> > > >>>>>  {
> > > >>>>> +	if (data && num_psci_reset_params)
> > > >>>>
> > > >>>> So, reboot_mode here is basically ignored; if there is a vendor defined
> > > >>>> reset, we fire it off.
> > > >>>>
> > > >>>> I think Mark mentioned his concerns earlier related to REBOOT_* mode and
> > > >>>> reset type (granted, the context was different):
> > > >>>>
> > > >>>> https://lore.kernel.org/all/20200320120105.GA36658@C02TD0UTHF1T.local/
> > > >>>>
> > > >>>> I would like to understand if this is the right thing to do before
> > > >>>> accepting this patchset.
> > > >>>>
> > > >>>
> > > >>> I don't have any concerns to move this part below checking reboot_mode.
> > > >>> Or, I could add reboot_mode == REBOOT_COLD check.
> > > >>
> > > >> The question is how can we map vendor specific reboot magic to Linux
> > > >> reboot modes sensibly in generic PSCI code - that's by definition
> > > >> vendor specific.
> > > >>
> > > > 
> > > > I don't think it's a reasonable thing to do. "reboot bootloader" or
> > > > "reboot edl" don't make sense to the Linux reboot modes.
> > > > 
> > > > I believe the Linux reboot modes enum is oriented to perspective of
> > > > Linux itself and the vendor resets are oriented towards behavior of the
> > > > SoC.
> > > > 
> > > > Thanks,
> > > > Elliot
> > > > 
> > > 
> > > Agree.
> > > 
> > > from perspective of linux reboot modes, kernel's current
> > > implementation in reset path is like:
> > >
> > > __
> > > #1 If reboot_mode is WARM/SOFT and PSCI_SYSRESET2 is supported 
> > >     Call PSCI - SYSTEM_RESET2 - ARCH RESET
> > > #2 ELSE
> > >     Call PSCI - SYSTEM_RESET COLD RESET
> > > ___
> > > 
> > > ARM SPECS for PSCI SYSTEM_RESET2
> > > This function extends SYSTEM_RESET. It provides:
> > > • ARCH RESET: set Bit[31] to 0               = > This is already in place in condition #1.
> > > • vendor-specific resets: set Bit[31] to 1.  = > current patchset adds this part before kernel's reboot_mode reset at #0.
> > > 
> > > 
> > > In current patchset, we see a condition added at
> > > #0-psci_vendor_reset2 being called before kernel’s current
> > > reboot_mode condition and it can take any action only if all below
> > > conditions are satisfied.
> > > - PSCI SYSTEM_RESET2 is supported.
> > > - psci dt node defines an entry "bootloader" as a reboot-modes.
> > > - User issues reboot with a command say - (reboot bootloader).
> > > - If vendor reset fails, default reboot mode will execute as is.
> > > 
> > > Don't see if we will skip or break the kernel reboot_mode flow with
> > > this patch.  Also if user issues reboot <cmd> and <cmd> is supported
> > > on SOC vendor reset psci node, should cmd take precedence over
> > > kernel reboot mode enum? may be yes? 
> > > 
> > 
> > Please wrap lines when replying.
> > 
> > I don't think it is a matter of precedence. reboot_mode and the reboot
> > command passed to the reboot() syscall are there for different (?)
> > reasons.
> > 
> > What I am asking is whether it is always safe to execute a PSCI vendor
> > reset irrispective of the reboot_mode value.
> 
> The only way I see it to be unsafe is we need some other driver using
> the reboot_mode to configure something and then the PSCI vendor reset
> being incompatible with whatever that other driver did. I don't see that
> happens today, so it is up to us to decide what the policy ought to be.
> The PSCI spec doesn't help us here because the reboot_mode enum is
> totally a Linux construct. In my opinion, firmware should be able to
> deal with whatever the driver did or (less ideal) the driver need to be
> aware of the PSCI vendor resets. Thus, it would be always safe to
> execute a PSCI vendor reset regardless of the reboot_mode value.

It is hard to understand history behind reboot_mode and
the LINUX_REBOOT_CMD_RESTART2 cmd, at least *I* don't
understand it fully.

What I do understand is:

- reboot_mode can be set from userspace and kernel params
- It affects some drivers restart handler behaviours
- Incidentally, I noticed that reboot_mode affects the EFI reset
  being issued (and EFI ignores the cmd and platform specific
  resets AFAICS). This is not related to this thread but may provide
  some guidance
- if reboot_mode is set to REBOOT_GPIO - it is impossible to understand
  what PSCI code should do other than ignoring it ? It is not that
  REBOOT_WARM/COLD/HARD/SOFT are easier to fathom either to be honest,
  would be happy if anyone could chime in and shed some light.

My biggest fear here is that after merging this code, various quirks
based on what SYSTEM_RESET2 platform specific parameters are set-up
will appear, whereby a driver needs to do this or that in its restart
handler depending on the specific reset being issued in PSCI
(an example was provided in this same thread).

Thoughts ? I'd like to see some progress on this but it is proving
to be ways more complex than I thought initially.

Thanks,
Lorenzo

