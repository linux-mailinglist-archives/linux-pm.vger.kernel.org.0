Return-Path: <linux-pm+bounces-26118-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD47A9AB3F
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 12:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B113D3AD7EE
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 10:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A64221285;
	Thu, 24 Apr 2025 10:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="AfYG2e2I"
X-Original-To: linux-pm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D192E481DD;
	Thu, 24 Apr 2025 10:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745492388; cv=none; b=G1pu4sQR8cKZmaPl2uQ/JjGK+YHYGQoQEz2oGDyF1ublZiOtyli5qy8V56z7gvNRX2qNIs/iDUqF3hPUFZzpjtzSNs2s5mMjgpGOR6SWbTwbC1C1ecULBwA/q/txN/EDwF8mPIbZJk7GJFK2+eIEMKb8geqDxbOsrDIz7ZjEv6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745492388; c=relaxed/simple;
	bh=Dm84OU/lxH2ISyHLfv2gSZjyyFNCmUX9PChR5lXrYp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pfBmlZz89xJqIVheOdi9ZM/v6fl+x2tCIHqyYuKXKA5b6WZ98TftS5w3SH/RSXjL6lI5+tj0RWEAdyqRdatultEi91YwZCihnzodvPxhfyVCNQ5IRC3T0dMvQYj1zZhBSFihFnwwbEOwaNXGAP9vZaC3xMerrgfdtSo7p8zAv8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=AfYG2e2I; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id AEDFC9CE;
	Thu, 24 Apr 2025 12:59:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1745492382;
	bh=Dm84OU/lxH2ISyHLfv2gSZjyyFNCmUX9PChR5lXrYp8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AfYG2e2Ixs4uncpPO1bBz9tvAAqYO1ecUFuNsK2/9RNQskV1r0LMxMKbX1TNYQPGv
	 /PHg1skHL5GjaiX2u+XVeTPaU6YRoJ/KX1Vuzdel0Vdq591imWjDHekxaY9PqOoPLp
	 BqkKb+nLOOcgSd6e7UgcGNgDCCQoRv5J0t7xvpnw=
Message-ID: <8e748129-3348-4bf1-9fc8-fadc569fa48e@ideasonboard.com>
Date: Thu, 24 Apr 2025 13:59:40 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] pmdomain: Add generic ->sync_state() support to
 genpd
To: Ulf Hansson <ulf.hansson@linaro.org>,
 Saravana Kannan <saravanak@google.com>, Stephen Boyd <sboyd@kernel.org>,
 linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Grzeschik <m.grzeschik@pengutronix.de>,
 Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
 Devarsh Thakkar <devarsht@lewv0571a.ent.ti.com>,
 Peng Fan <peng.fan@oss.nxp.com>, Johan Hovold <johan@kernel.org>,
 Maulik Shah <maulik.shah@oss.qualcomm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Kevin Hilman <khilman@baylibre.com>, Devarsh Thakkar <devarsht@ti.com>
References: <20250417142513.312939-1-ulf.hansson@linaro.org>
Content-Language: en-US
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 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
In-Reply-To: <20250417142513.312939-1-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 17/04/2025 17:24, Ulf Hansson wrote:
> If a PM domain (genpd) is powered-on during boot, there is probably a good
> reason for it. Therefore it's known to be a bad idea to allow such genpd to be
> powered-off before all of its consumer devices have been probed. This series
> intends to fix this problem.
> 
> We have been discussing these issues at LKML and at various Linux-conferences
> in the past. I have therefore tried to include the people I can recall being
> involved, but I may have forgotten some (my apologies), feel free to loop them
> in.
> 
> A few notes:
> *)
> Even if this looks good, the last patch can't go in without some additional
> changes to a couple of existing genpd provider drivers. Typically genpd provider
> drivers that implements ->sync_state() need to call of_genpd_sync_state(), but I
> will fix this asap, if we think the series makes sense.
> 
> *)
> Patch 1 -> 3 are just preparatory cleanups.
> 
> *)
> I have tested this with QEMU with a bunch of local test-drivers and DT nodes.
> Let me know if you want me to share this code too.
> 
> 
> Please help review and test!
> Finally, a big thanks to Saravana for all the support!

I had a quick test with this on TI's AM62 board. A few observations.

With this series, all the individual PDs seem to get a state_synced file:

...
/sys/devices/genpd_provider/pd:143/state_synced
/sys/devices/genpd_provider/pd:54/state_synced
/sys/devices/genpd_provider/pd:105/state_synced
/sys/devices/genpd_provider/pd:62/state_synced
/sys/devices/genpd_provider/pd:141/state_synced
...

Is that on purpose? What do these files represent? They all seem to be "1".

When I boot up, I see the sync_state pending:

[   22.541292] ti_sci_pm_domains 
44043000.system-controller:power-controller: sync_state() pending due to 
2b10000.audio-contro
ller
[   22.554839] ti_sci_pm_domains 
44043000.system-controller:power-controller: sync_state() pending due to 
e0f0000.watchdog
[   22.566550] ti_sci_pm_domains 
44043000.system-controller:power-controller: sync_state() pending due to 
e030000.watchdog
[   22.577854] ti_sci_pm_domains 
44043000.system-controller:power-controller: sync_state() pending due to 
e020000.watchdog
[   22.589239] ti_sci_pm_domains 
44043000.system-controller:power-controller: sync_state() pending due to 
e010000.watchdog
[   22.600674] ti_sci_pm_domains 
44043000.system-controller:power-controller: sync_state() pending due to 
e000000.watchdog
[   22.611875] ti_sci_pm_domains 
44043000.system-controller:power-controller: sync_state() pending due to 
30200000.dss
[   22.622813] ti_sci_pm_domains 
44043000.system-controller:power-controller: sync_state() pending due to 
fd00000.gpu
[   22.633565] ti_sci_pm_domains 
44043000.system-controller:power-controller: sync_state() pending due to 
b00000.temperature-s
ensor
[   22.645540] ti_sci_pm_domains 
44043000.system-controller:power-controller: sync_state() pending due to 
2b300050.target-modu
le
[   22.657067] ti_sci_pm_domains 
44043000.system-controller:power-controller: sync_state() pending due to 
chosen:framebuffer@0

The "real" state_synced file on this platform is:

/sys/devices/platform/bus@f0000/44043000.system-controller/44043000.system-controller:power-controller/state_synced

In strict mode, this shows 0, and if I echo 1 (interestingly "echo 1 > 
/sys/..." doesn't work, I need "echo -n 1 > /sys/...), I see PDs getting 
powered off (added a debug print there):

[   87.335487] ti_sci_pd_power_off 88
[   87.342896] ti_sci_pd_power_off 87
[   87.347404] ti_sci_pd_power_off 86
[   87.356464] ti_sci_pd_power_off 128
[   87.361296] ti_sci_pd_power_off 127
[   87.368714] ti_sci_pd_power_off 126
[   87.373349] ti_sci_pd_power_off 125
[   87.378077] ti_sci_pd_power_off 62
[   87.382587] ti_sci_pd_power_off 60
[   87.387194] ti_sci_pd_power_off 59
[   87.391759] ti_sci_pd_power_off 53
[   87.396648] ti_sci_pd_power_off 52
[   87.400801] ti_sci_pd_power_off 51
[   87.405131] ti_sci_pd_power_off 75
[   87.409238] ti_sci_pd_power_off 143
[   87.413328] ti_sci_pd_power_off 142
[   87.417403] ti_sci_pd_power_off 141
[   87.421494] ti_sci_pd_power_off 105
[   87.425632] ti_sci_pd_power_off 104
[   87.429815] ti_sci_pd_power_off 103
[   87.433941] ti_sci_pd_power_off 102
[   87.438054] ti_sci_pd_power_off 158
[   87.442151] ti_sci_pd_power_off 156
[   87.446324] ti_sci_pd_power_off 155
[   87.450463] ti_sci_pd_power_off 154
[   87.454549] ti_sci_pd_power_off 153
[   87.458671] ti_sci_pd_power_off 152
[   87.462571] ti_sci_pd_power_off 43
[   87.466425] ti_sci_pd_power_off 42
[   87.470254] ti_sci_pd_power_off 41
[   87.474032] ti_sci_pd_power_off 40
[   87.477825] ti_sci_pd_power_off 39
[   87.481609] ti_sci_pd_power_off 38
[   87.485432] ti_sci_pd_power_off 37
[   87.489256] ti_sci_pd_power_off 36
[   87.493077] ti_sci_pd_power_off 95
[   87.496845] ti_sci_pd_power_off 132
[   87.500780] ti_sci_pd_power_off 107
[   87.504583] ti_sci_pd_power_off 114
[   87.508429] ti_sci_pd_power_off 79
[   87.512050] ti_sci_pd_power_off 148
[   87.515859] ti_sci_pd_power_off 147
[   87.519644] ti_sci_pd_power_off 106
[   87.523414] ti_sci_pd_power_off 149
[   87.527203] ti_sci_pd_power_off 50
[   87.530971] ti_sci_pd_power_off 49
[   87.534708] ti_sci_pd_power_off 48
[   87.538401] ti_sci_pd_power_off 35
[   87.542040] ti_sci_pd_power_off 186

We do have a lot of "extra" PDs enabled by the bootloader...

With the timeout mode, I see the sync_state() getting called some 
seconds after the boot has finished.

So... I think it all works as expected. You can take this as some kind 
of Tested-by, but it'd be good if someone from TI who knows more about 
PDs would test this too =).

Interestingly, I see a difference in behavior to the old patches from 
Abel: with the old patches, if I boot up with the DSS (display 
subsystem) enabled by the bootloader, it looks the same as with these 
patches. However, with the old patches, when I load the DSS driver, and 
it probes successfully, the DSS PD will get managed correctly, i.e. if I 
blank the screen, the DSS PD will go to off, even if the sync_state has 
not been called.

With these patches the DSS PD will stay on, no matter if I load the DSS 
driver or not, and will only go off after sync_state has been called.

I'm not quite sure here, but I think the behavior with the old patches 
makes sense: when the driver for a particular PD loads, the PD no longer 
needs to be kept on. Or... Is this about the case where a PD has 
multiple consumers? The PD provider cannot know how many consumers there 
are for a single PD, so it must keep all boot-time-enabled PDs on until 
sync_state() (i.e. all the consumer drivers have probed)?

  Tomi


