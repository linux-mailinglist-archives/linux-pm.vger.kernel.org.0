Return-Path: <linux-pm+bounces-12370-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8CB954FD8
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 19:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 457DD1F25CC1
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 17:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3799C1C0DE8;
	Fri, 16 Aug 2024 17:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCq0Mz+P"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC9713D890;
	Fri, 16 Aug 2024 17:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723828616; cv=none; b=KyOwU1Lw5BAYC+nHp5bvuqcaqADechduBYU2bzth+8H9Ex6EfCYlifqmgR4lwLvmNIwTa1Npbphx4kpb+35xilacCTlv+W+XxqgiTK6wcCqylKQ1u7hzt5xGncuoCHwEIMUGqbsNwHXr2hstveplTLGJWFLTHG5060lOZ/fZ2yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723828616; c=relaxed/simple;
	bh=9kUaEkBKVrddA6ehNI5rt8ivnb+VNnbtDi1g/tdPzEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVhopwpeflMPQC00tCwhTbEpCabVSOaMxRjIPNsw3cWuN7radveckUT8mXvz9NEvUCPwMMIGWTn01xyTCwGmIWb6H7au0nprXzdAwMgyk/JiG3z9QJjtuekgyPIyTjLa4Fmh9E+p4VgwgVbGxHvB1crzJtNq88OU3meBDScRoKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCq0Mz+P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C17AC32782;
	Fri, 16 Aug 2024 17:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723828615;
	bh=9kUaEkBKVrddA6ehNI5rt8ivnb+VNnbtDi1g/tdPzEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DCq0Mz+Px5ji1b8//XtfqVqrt7o0FE16snOY6bew0PsSuOY7s/D9AzD2PkJQEQ24e
	 kmyAKxwVmJOzmFBA+xLOQ+HydSLE5X/ZRH/aKMoEKXT2UrNfaIbs8lTzr8zbtU0uft
	 dWCZAUvrHzlhChbSZUpm9POoS/GaEPmD+2Eak92nEaCH8IX2v3Ir8tLhOP2u6R/i8g
	 LgyXSdRaW+XOxrxQnPyXMnWrs/TWZwx8iP6MCTYoRn1XPOXaGNXJt6668FYqWoOcOY
	 TSoaiPeq6usam1WqlO/SaB2sdjM5f5gwhAiBkovPwnJN0RU4YswAhDUkh66l8R8cmU
	 m0eL4l8YH2GAA==
Received: by pali.im (Postfix)
	id 38AD87B7; Fri, 16 Aug 2024 19:16:51 +0200 (CEST)
Date: Fri, 16 Aug 2024 19:16:51 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Andres Salomon <dilinger@queued.net>
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Sebastian Reichel <sre@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	linux-pm@vger.kernel.org, Dell.Client.Kernel@dell.com
Subject: Re: [PATCH v3 1/2] platform/x86:dell-laptop: Add knobs to change
 battery charge settings
Message-ID: <20240816171651.jmqa7tmfkc3jmsm4@pali>
References: <20240815192848.3489d3e1@5400>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240815192848.3489d3e1@5400>
User-Agent: NeoMutt/20180716

Hello Andres,

I have just comments for this change. It looks good. After resolving
them you can add my tag: Reviewed-by: Pali Rohár <pali@kernel.org>

On Thursday 15 August 2024 19:28:48 Andres Salomon wrote:
> The Dell BIOS allows you to set custom charging modes, which is useful
> in particular for extending battery life. This adds support for tweaking
> those various settings from Linux via sysfs knobs. One might, for
> example, have their laptop plugged into power at their desk the vast
> majority of the time and choose fairly aggressive battery-saving
> settings (eg, only charging once the battery drops below 50% and only
> charging up to 80%). When leaving for a trip, it would be more useful
> to instead switch to a standard charging mode (top off at 100%, charge
> any time power is available). Rebooting into the BIOS to change the
> charging mode settings is a hassle.
> 
> For the Custom charging type mode, we reuse the common
> charge_control_{start,end}_threshold sysfs power_supply entries. The
> BIOS also has a bunch of other charging modes (with varying levels of
> usefulness), so this also adds a 'charge_type' sysfs entry that maps the
> standard values to Dell-specific ones and documents those mappings in
> sysfs-class-power-dell.
> 
> This work is based on a patch by Perry Yuan <perry_yuan@dell.com> and
> Limonciello Mario <Mario_Limonciello@Dell.com> submitted back in 2020:

I think that the information below is not needed to have in commit
message. We also do not include links or information about previous
version of patch sent by you.

> https://lore.kernel.org/all/20200729065424.12851-1-Perry_Yuan@Dell.com/
> Both of their email addresses bounce, so I'm assuming they're no longer
> with the company. I've reworked most of the patch to make it smaller and
> cleaner.

...

> +static ssize_t charge_type_store(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf, size_t size)
> +{
> +	bool matched = false;
> +	int err, i;
> +
> +	for (i = 0; i < ARRAY_SIZE(battery_modes); i++) {
> +		if (!(battery_supported_modes & BIT(i)))
> +			continue;
> +
> +		if (sysfs_streq(battery_modes[i].label, buf)) {
> +			matched = true;
> +			break;
> +		}
> +	}
> +	if (!matched || !(battery_supported_modes & BIT(i)))
> +		return -EINVAL;

Check for "!(battery_supported_modes & BIT(i))" is redundant here.
"matched" can be true only in case if the i-th mode is supported and was
specified in buffer.

> +
> +	err = dell_battery_set_mode(battery_modes[i].token);
> +	if (err)
> +		return err;
> +
> +	return size;
> +}

