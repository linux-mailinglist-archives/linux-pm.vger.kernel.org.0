Return-Path: <linux-pm+bounces-42141-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBRwMrF/hGl/3AMAu9opvQ
	(envelope-from <linux-pm+bounces-42141-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 12:32:01 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 370E3F1E48
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 12:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AE7F03003709
	for <lists+linux-pm@lfdr.de>; Thu,  5 Feb 2026 11:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069063A9DA7;
	Thu,  5 Feb 2026 11:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdNCEnFa"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69B136E472;
	Thu,  5 Feb 2026 11:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770291116; cv=none; b=jBwzxku/HQjz4W1TBJqpP3mETYkmU3GKEZegHYlQwn/ngtWb7aTIz7FN06bRrAN+gZm6Uaq8Zx92pBu9M8L1sumFJQu97+l+iyIOesSUmZq75UcdhyzKHIj2s3dl6mO/et0xfdZ9KBaukhqCp5QUBH/o2ZRuKT89WcTfbS4ET/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770291116; c=relaxed/simple;
	bh=nClnMfcGiJb0lXes9W5fj70hVgCTYeQ1O2ojMLWtWFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJ+IWazKt0KbEQa7IE2Cdn6gpGatoAylfldR2uzkvBrqhf0O/U+WC7rcthRHNzACL28fcPZ9955q156zUumF68Khf7F6NBLPmcf3Lvv/3A3be8qSZcD4wC9kUHkQsRy2VBDW5BCHXQpTBDY3Jb4L1+yajOm80U9w8vPBFV77EUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DdNCEnFa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F31C4CEF7;
	Thu,  5 Feb 2026 11:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770291116;
	bh=nClnMfcGiJb0lXes9W5fj70hVgCTYeQ1O2ojMLWtWFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DdNCEnFaXg6OtEYefCy7OI1s5wnQNUhbYlgt1bSYCqWbrPPErScwlDtgBntZEmnZT
	 2eTyHz8QnOVfXbBrpEZW798yfP4RUAJMngd7OmxeJx3EkpAkgjuZBE0pR6aT1rMS67
	 oMbH9ZdAxStLDAsY+s+iH3I8P0mJvx+YPlLaxh/HehBH00ZjwsMvM3bAfvgF+wWvJV
	 lFb+eAV5FmoOUmGPSDkjtxDoCFg7GIsHd+VxIoZ+u5NXRsfTYJsqoeHe2/LladBF3L
	 j64adrz1gU7IyyJg0QbVasPOVjyLtgwlQbRF/qcV0HYVcB9XVcOe8SAnuuSHIfeT6r
	 Z9tkU0R/3yekg==
Date: Thu, 5 Feb 2026 12:31:54 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Taniya Das <quic_tdas@quicinc.com>, Jonathan Marek <jonathan@marek.ca>, 
	Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Bryan O'Donoghue <bod@kernel.org>, Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Stanimir Varbanov <stanimir.varbanov@linaro.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
	Hans Verkuil <hverkuil@kernel.org>, Stefan Schmidt <stefan.schmidt@linaro.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Dikshita Agarwal <dikshita@qti.qualcomm.com>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-media@vger.kernel.org, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH v3 1/7] dt-bindings: clock: qcom,sm8250-videocc: account
 for the MX domain
Message-ID: <20260205-abiding-beautiful-locust-6ee1b5@quoll>
References: <20260204-iris-venus-fix-sm8250-v3-0-70fa68e57f96@oss.qualcomm.com>
 <20260204-iris-venus-fix-sm8250-v3-1-70fa68e57f96@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260204-iris-venus-fix-sm8250-v3-1-70fa68e57f96@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42141-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm,dt,huawei];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 370E3F1E48
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 02:59:49AM +0200, Dmitry Baryshkov wrote:
> To configure the video PLLs and enable the video GDSCs on SM8250,
> platform, the MX rail must be ON along with MMCX. Split the bindings
> file in order to provide separate file utilizing MMCX and MX power
> domains.

...

> +
> +description: |
> +  Qualcomm video clock control module provides the clocks, resets and power
> +  domains on Qualcomm SoCs.
> +
> +  See also::

Only one ':', please. It was a mistake to introduce ::

> +  clock-names:
> +    items:
> +      - const: iface
> +      - const: bi_tcxo
> +      - const: bi_tcxo_ao
> +
> +  power-domains:
> +    items:
> +      - description:
> +          A phandle and PM domain specifier for the MMCX power domain.
> +      - description:
> +          A phandle and PM domain specifier for the MX power domain.

This is an ABI break, so please say in the commit what was not working
or why this ABI break is really justified. Currently you just give a
hint that it is needed for PLL configuration, but honestly - why would
we care to configure PLL if everything was working correct before?


Best regards,
Krzysztof


