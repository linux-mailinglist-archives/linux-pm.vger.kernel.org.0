Return-Path: <linux-pm+bounces-42936-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UO2LO2JMmGmaFgMAu9opvQ
	(envelope-from <linux-pm+bounces-42936-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 12:58:27 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 694D4167642
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 12:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 101A430120E4
	for <lists+linux-pm@lfdr.de>; Fri, 20 Feb 2026 11:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E4A341AD8;
	Fri, 20 Feb 2026 11:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3LBGCre"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04AA330672;
	Fri, 20 Feb 2026 11:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771588703; cv=none; b=pOH2pU9ql6kC+zFXaESMbSTrtUv73s0nK7tw0B9vvKv7eQSjl27FspifPXXuO827EKQ+kWhbkkD1v9H9D7NahhOVoz+gMNHsVTvSAxGNvocsP+cTgMx0QPX6P9khBNqDRAUgPDYdCofOFzu1RCbg+u7Zujb0UoU5auvGy0zDZU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771588703; c=relaxed/simple;
	bh=zxJ10CPWNenVjOytvEp2o8sITibPES2ZbboQs8lwLBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BBX5bzApP6kgexD+vZhhAdoSTfi+zrJiBk2IN8IFhmIaD7hRRyFpvBIFU2xZXHTfIT1z3NuqgIXImXp/NzfnOBVzdzCx312+gxoSnRD7HcyJT+MFR5Od5COeEBKQBXGmdoxSWdGbsW2ZG13AmnSamff3ntb0EvF869PS+ZOS5Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3LBGCre; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9102BC116C6;
	Fri, 20 Feb 2026 11:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771588703;
	bh=zxJ10CPWNenVjOytvEp2o8sITibPES2ZbboQs8lwLBQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H3LBGCre+QnYZCgpiFlnCLZlGip5xhDmJZJ4rJvQeDi9ffJQMQryqoMsmgbYgUgk9
	 IqD9ySuu+lL+WTVhEMIx7BKkECAxKPjs1cDbDl7N9+Q5wm5OgXNWXs0gJMOWXwWQDA
	 XfybsvujIGtqxp6wVRgAjyZbJhMIiWZj8SY1LZ/P3cnu2sziC/MXkH7tFyyz8PzAWq
	 hLEF/z1hDqBNr7nak1jfAuv2KhrfTK5zqFrukEKil3oKvbEVouMUC7mMYB3htzCk9H
	 MWxQQQTKPGIcWvbbmt9KuLKovkBazn4FPWNMi3otc10QQ2L98qgmV6tDzP1QVxMofn
	 TOpVADeeelEEg==
Message-ID: <23cd47a7-75a6-4ed7-af8e-c0ecedcda6ef@kernel.org>
Date: Fri, 20 Feb 2026 12:58:16 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] Battery temperature ADC plumbing on Qualcomm
 platforms
To: Luca Weiss <luca.weiss@fairphone.com>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Jens Reidel <adrian@mainlining.org>,
 Casey Connolly <casey.connolly@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20260220-bat-temp-adc-v2-0-fe34ed4ea851@fairphone.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20260220-bat-temp-adc-v2-0-fe34ed4ea851@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42936-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hansg@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 694D4167642
X-Rspamd-Action: no action

Hi All,

On 20-Feb-26 10:19, Luca Weiss wrote:
> This implements a solution to get battery temperature readings working
> on (for example) smartphones with Qualcomm SoCs.
> 
> The solution chosen in downstream Qualcomm kernels is exposing
> ADC_BAT_THERM_PU* in the ADC driver as temperature channels with the
> lookup table ("struct vadc_map_pt") for the specific NTC found in a
> device's battery patched to adjust the lookup table. Patching a kernel
> per-device is obviously nothing we can put upstream.
> 
> The high level solution proposed here:
> * ADC driver provides temperature channel in (milli)volt as IIO channel
> * generic-adc-thermal driver converts voltage to temperature based on
>   provided lookup table from DT (driver has one IIO channel input, one
>   IIO channel output)
> * The fuel gauge driver can use that temperature IIO channel to expose
>   battery temperature via the power supply device

Nice, I agree that this seems the best way forward, especially
taking into account that the generic-adc-thermal driver now
already supports the IIO -> IIO path case.

Regards,

Hans



