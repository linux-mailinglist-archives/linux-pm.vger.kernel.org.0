Return-Path: <linux-pm+bounces-41223-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJJDOpezcGndZAAAu9opvQ
	(envelope-from <linux-pm+bounces-41223-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 12:08:07 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD08355B83
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 12:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F1672664DF7
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 11:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43D73BC4C9;
	Wed, 21 Jan 2026 11:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="g8BT0PRT"
X-Original-To: linux-pm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E834D3A900B;
	Wed, 21 Jan 2026 11:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768993241; cv=none; b=hxum0oisPbgkPMWx6ljZfTq9FP38cd4IRwnUDVNhz1WeAHPUBqYOGA7THtupk/w30hDJ2tg0PXiiHRSC/k8KzQu75UACbGMNNmHPv1Keq2hMw95ohV3f9waZHbe7VusFrXRGKaaAmEEB9aFQvfam46FjEkViQj0XuMDnbrcquxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768993241; c=relaxed/simple;
	bh=CPqjiGgQY57li5aXt25BpNtAGFutGP2VOe84plwT8Eo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tax54bvo2Zzm4k/qW13WzTLpaNd2cDgUd0ztnBfX9gHYMouU8EItaR/llSepL6rdevexdXQx08uEa60cz03h3u7/HXoYfVRZ32oSEt3oEPpg1m0qsxaiahmL29KqOLoiZdnJPaj51D7HaCL8WetOPL1/Rfb18vLMYoEuqnpvI9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=g8BT0PRT; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1768993236;
	bh=CPqjiGgQY57li5aXt25BpNtAGFutGP2VOe84plwT8Eo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=g8BT0PRTHGg2kixBPhMdHWcTZwQNGQh0wRQ2n1fI4CzGGuCXoibcIHd9XhepPyf64
	 QXoL0OTfuj1fpnWNBN8vgUTI3G2zW2f0p6NWj5yIAoRjK0k4P2hJrloe8JDQE6U0dN
	 6T3hzmTc/aYdCSHwaMeaqRV7OLAUdMQi4zqSAPrENWdoIWnRwc8ws893TKD7mkI1uh
	 m4ZtTM4QmU1Y4WFAiYjvD2RL++SXUdj1O+LaA3hZKYuuxV7qEF+S1k9tVPSeLdxK01
	 RplFVIodHnydB6udEqgf3itY7St4gQtQ7JKR3fQC+Kd0CvU/O41R/C2g+XiY6eECgn
	 IEfQ9UL4VzOhw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DEF4217E0DB7;
	Wed, 21 Jan 2026 12:00:35 +0100 (CET)
Message-ID: <de08d697-4202-499c-9784-2bb8d3d614b6@collabora.com>
Date: Wed, 21 Jan 2026 12:00:35 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/10] SPMI: Implement sub-devices and migrate drivers
To: jic23@kernel.org, sboyd@kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 arnd@arndb.de, gregkh@linuxfoundation.org, srini@kernel.org,
 vkoul@kernel.org, neil.armstrong@linaro.org, sre@kernel.org,
 krzk@kernel.org, dmitry.baryshkov@oss.qualcomm.com, quic_wcheng@quicinc.com,
 melody.olvera@oss.qualcomm.com, quic_nsekar@quicinc.com,
 ivo.ivanov.ivanov1@gmail.com, abelvesa@kernel.org, luca.weiss@fairphone.com,
 konrad.dybcio@oss.qualcomm.com, mitltlatltl@gmail.com,
 krishna.kurapati@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, kernel@collabora.com
References: <20260114092742.13231-1-angelogioacchino.delregno@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260114092742.13231-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[baylibre.com,analog.com,kernel.org,arndb.de,linuxfoundation.org,linaro.org,oss.qualcomm.com,quicinc.com,gmail.com,fairphone.com,vger.kernel.org,lists.infradead.org,collabora.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41223-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[collabora.com,none];
	DKIM_TRACE(0.00)[collabora.com:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[angelogioacchino.delregno@collabora.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,collabora.com:mid,collabora.com:dkim]
X-Rspamd-Queue-Id: AD08355B83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Il 14/01/26 10:27, AngeloGioacchino Del Regno ha scritto:
> Changes in v8:

With this series being finally fully reviewed and having lots of acks, and
since I think that the main part of this is in SPMI subsystem rather than
others....

....Stephen or Jonathan, can you please pick at least the SPMI code so that
it goes in for this merge window and doesn't get forgotten again?

That also makes it easier for the other maintainers who didn't give an ack (and
that don't want their subsystem patches to go through SPMI) to apply the patches
in the next merge window, IMO.

Thanks,
Angelo


>   - Renamed *res to *sub_sdev in devm_spmi_subdevice_remove() (Andy)
>   - Changed kerneldoc wording to "error pointer" for function
>     spmi_subdevice_alloc_and_add() (Andy)
>   - Shuffled around some assignments in spmi_subdevice_alloc_and_add() (Andy)
>   - Used device_property_read_u32() instead of of_property_read_u32()
>     in all of the migrated drivers (Andy)
>   - Changed .max_register field in all of the migrated drivers from
>     0x100 to 0xff (Andy)
>   - Kept `sta1` declaration in reversed xmas tree order in function
>     iadc_poll_wait_eoc() of qcom-spmi-iadc.c (Andy)
> 
> Changes in v7:
>   - Added commit to cleanup redundant dev_name() in the pre-existing
>     spmi_device_add() function
>   - Added commit removing unneeded goto and improving spmi_device_add()
>     readability by returning error in error path, and explicitly zero
>     for success at the end.
> 
> Changes in v6:
>   - Added commit to convert spmi.c to %pe error format and used
>     %pe error format in spmi_subdevice code as wanted by Uwe Kleine-Konig
> 
> Changes in v5:
>   - Changed dev_err to dev_err_probe in qcom-spmi-sdam (and done
>     that even though I disagree - because I wanted this series to
>     *exclusively* introduce the minimum required changes to
>     migrate to the new API, but okay, whatever....!);
>   - Added missing REGMAP dependency in Kconfig for qcom-spmi-sdam,
>     phy-qcom-eusb2-repeater and qcom-coincell to resolve build
>     issues when the already allowed COMPILE_TEST is enabled
>     as pointed out by the test robot's randconfig builds.
> 
> Changes in v4:
>   - Added selection of REGMAP_SPMI in Kconfig for qcom-coincell and
>     for phy-qcom-eusb2-repeater to resolve undefined references when
>     compiled with some randconfig
> 
> Changes in v3:
>   - Fixed importing "SPMI" namespace in spmi-devres.c
>   - Removed all instances of defensive programming, as pointed out by
>     jic23 and Sebastian
>   - Removed explicit casting as pointed out by jic23
>   - Moved ida_free call to spmi_subdev_release() and simplified error
>     handling in spmi_subdevice_alloc_and_add() as pointed out by jic23
> 
> Changes in v2:
>   - Fixed missing `sparent` initialization in phy-qcom-eusb2-repeater
>   - Changed val_bits to 8 in all Qualcomm drivers to ensure
>     compatibility as suggested by Casey
>   - Added struct device pointer in all conversion commits as suggested
>     by Andy
>   - Exported newly introduced functions with a new "SPMI" namespace
>     and imported the same in all converted drivers as suggested by Andy
>   - Added missing error checking for dev_set_name() call in spmi.c
>     as suggested by Andy
>   - Added comma to last entry of regmap_config as suggested by Andy
> 
> While adding support for newer MediaTek platforms, featuring complex
> SPMI PMICs, I've seen that those SPMI-connected chips are internally
> divided in various IP blocks, reachable in specific contiguous address
> ranges... more or less like a MMIO, but over a slow SPMI bus instead.
> 
> I recalled that Qualcomm had something similar... and upon checking a
> couple of devicetrees, yeah - indeed it's the same over there.
> 
> What I've seen then is a common pattern of reading the "reg" property
> from devicetree in a struct member and then either
>   A. Wrapping regmap_{read/write/etc}() calls in a function that adds
>      the register base with "base + ..register", like it's done with
>      writel()/readl() calls; or
>   B. Doing the same as A. but without wrapper functions.
> 
> Even though that works just fine, in my opinion it's wrong.
> 
> The regmap API is way more complex than MMIO-only readl()/writel()
> functions for multiple reasons (including supporting multiple busses
> like SPMI, of course) - but everyone seemed to forget that regmap
> can manage register base offsets transparently and automatically in
> its API functions by simply adding a `reg_base` to the regmap_config
> structure, which is used for initializing a `struct regmap`.
> 
> So, here we go: this series implements the software concept of an SPMI
> Sub-Device (which, well, also reflects how Qualcomm and MediaTek's
> actual hardware is laid out anyway).
> 
>                 SPMI Controller
>                       |                ______
>                       |               /       Sub-Device 1
>                       V              /
>                SPMI Device (PMIC) ----------- Sub-Device 2
>                                      \
>                                       \______ Sub-Device 3
> 
> As per this implementation, an SPMI Sub-Device can be allocated/created
> and added in any driver that implements a... well.. subdevice (!) with
> an SPMI "main" device as its parent: this allows to create and finally
> to correctly configure a regmap that is specific to the sub-device,
> operating on its specific address range and reading, and writing, to
> its registers with the regmap API taking care of adding the base address
> of a sub-device's registers as per regmap API design.
> 
> All of the SPMI Sub-Devices are therefore added as children of the SPMI
> Device (usually a PMIC), as communication depends on the PMIC's SPMI bus
> to be available (and the PMIC to be up and running, of course).
> 
> Summarizing the dependency chain (which is obvious to whoever knows what
> is going on with Qualcomm and/or MediaTek SPMI PMICs):
>      "SPMI Sub-Device x...N" are children "SPMI Device"
>      "SPMI Device" is a child of "SPMI Controller"
> 
> (that was just another way to say the same thing as the graph above anyway).
> 
> Along with the new SPMI Sub-Device registration functions, I have also
> performed a conversion of some Qualcomm SPMI drivers and only where the
> actual conversion was trivial.
> 
> I haven't included any conversion of more complex Qualcomm SPMI drivers
> because I don't have the required bandwidth to do so (and besides, I think,
> but haven't exactly verified, that some of those require SoCs that I don't
> have for testing anyway).
> 
> AngeloGioacchino Del Regno (10):
>    spmi: Remove redundant dev_name() print in spmi_device_add()
>    spmi: Print error status with %pe format
>    spmi: Remove unneeded goto in spmi_device_add() error path
>    spmi: Implement spmi_subdevice_alloc_and_add() and devm variant
>    nvmem: qcom-spmi-sdam: Migrate to devm_spmi_subdevice_alloc_and_add()
>    power: reset: qcom-pon: Migrate to devm_spmi_subdevice_alloc_and_add()
>    phy: qualcomm: eusb2-repeater: Migrate to
>      devm_spmi_subdevice_alloc_and_add()
>    misc: qcom-coincell: Migrate to devm_spmi_subdevice_alloc_and_add()
>    iio: adc: qcom-spmi-iadc: Migrate to
>      devm_spmi_subdevice_alloc_and_add()
>    iio: adc: qcom-spmi-iadc: Remove regmap R/W wrapper functions
> 
>   drivers/iio/adc/qcom-spmi-iadc.c              | 109 ++++++++----------
>   drivers/misc/Kconfig                          |   2 +
>   drivers/misc/qcom-coincell.c                  |  38 ++++--
>   drivers/nvmem/Kconfig                         |   1 +
>   drivers/nvmem/qcom-spmi-sdam.c                |  38 ++++--
>   drivers/phy/qualcomm/Kconfig                  |   2 +
>   .../phy/qualcomm/phy-qcom-eusb2-repeater.c    |  55 +++++----
>   drivers/power/reset/qcom-pon.c                |  33 ++++--
>   drivers/spmi/spmi-devres.c                    |  24 ++++
>   drivers/spmi/spmi.c                           |  95 +++++++++++++--
>   include/linux/spmi.h                          |  16 +++
>   11 files changed, 290 insertions(+), 123 deletions(-)
> 


