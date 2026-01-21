Return-Path: <linux-pm+bounces-41215-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEhPAfyFcGkEYQAAu9opvQ
	(envelope-from <linux-pm+bounces-41215-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 08:53:32 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AB953154
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 08:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 822A6502599
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 07:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2AA44E02C;
	Wed, 21 Jan 2026 07:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+u3e1m9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBC42DEA95;
	Wed, 21 Jan 2026 07:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768981960; cv=none; b=VMKoA+oAso+ULb/UccgdijTyddAPzVe8RFQtjznmhpxBaHJkp5ZrCOvVwgsrK0Xjf6RcIQmhfvGMy6XMo18f6kndZU+0t4bjlFP4WUIOvd2MxI9kRsEnNPO1Voqcz+h43okH98zeseXsKtYe7IekPr7Cn5JPnkdHYtZpqs8WUag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768981960; c=relaxed/simple;
	bh=oY9kkfuH0Ditjdy+JGL/WtyxAil2KCbor0Br2BgfSJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Od9TcMSXmNoKH+P3EgGXUQOuzLLQpQQ876ih/8q7UceLDkZeAV+Vl39bdWElIcc1VIkFGjt8gwqTU/BD0L6rJB+CbFvNaCXo0/y7TxRsJLKV2m7g0JR7QUwVxRsiWNa4TSUrFpDW5z9yLXzm2vh/RyNPVhVBlbG4XtmsyLOkHpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+u3e1m9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B00C116D0;
	Wed, 21 Jan 2026 07:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768981960;
	bh=oY9kkfuH0Ditjdy+JGL/WtyxAil2KCbor0Br2BgfSJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S+u3e1m9rHY7iuamrnV9iFcVuLPYLXko6sYxIy2vjGoDYi0SX/vRPdq60y4RbzcDr
	 FW/z6KRnw1+GHO8/GTnUQ0I/uweJfhLQWWUnhZoFHDXLMzgqG+8V89GP9csySkh1Od
	 hzamX13jHyv+OL7UOYu8S8iYq+vYVD0+Bz1Wt+YammLhZAspaqTOrMYUA3ZNi1b2fb
	 qRQ02Y2Nva0FypOzFKK0hpNjoOVMUIo4RhL4b+FlshR35gTnnnsaHLK0wI4yLKbTGp
	 EH4afsG5hPJlNS55ElkcQHuF+HGU5pVJBNbMXikbfgDNx1iETYIVUYQC/33CpGgtpx
	 fOOjsXiYpliOw==
Date: Wed, 21 Jan 2026 08:52:37 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Peter Griffin <peter.griffin@linaro.org>, =?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>, 
	willmcvicker@google.com, jyescas@google.com, shin.son@samsung.com, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 1/7] dt-bindings: thermal: Add Google GS101 TMU
Message-ID: <20260121-stoic-lavender-okapi-c27c51@quoll>
References: <20260119-acpm-tmu-v2-0-e02a834f04c6@linaro.org>
 <20260119-acpm-tmu-v2-1-e02a834f04c6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260119-acpm-tmu-v2-1-e02a834f04c6@linaro.org>
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41215-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,intel.com,arm.com,samsung.com,gmail.com,google.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-pm@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,qualcomm.com:email,linaro.org:email]
X-Rspamd-Queue-Id: 94AB953154
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jan 19, 2026 at 12:08:47PM +0000, Tudor Ambarus wrote:
> Document the Thermal Management Unit (TMU) found on the Google GS101 SoC.
> 
> The GS101 TMU utilizes a hybrid control model shared between the
> Application Processor (AP) and the ACPM (Alive Clock and Power Manager)
> firmware.
> 
> While the TMU is a standard memory-mapped IP block, on this platform
> the AP's direct register access is restricted to the interrupt pending
> (INTPEND) registers for event identification. High-level functional
> tasks, such as sensor initialization, threshold programming, and
> temperature reads, are delegated to the ACPM firmware.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  .../bindings/thermal/google,gs101-tmu-top.yaml     | 67 ++++++++++++++++++++++
>  1 file changed, 67 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


