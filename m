Return-Path: <linux-pm+bounces-42419-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDh9Otf6imlBPAAAu9opvQ
	(envelope-from <linux-pm+bounces-42419-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 10:31:03 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB07118E44
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 10:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2D4930427C4
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 09:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61C633A6FB;
	Tue, 10 Feb 2026 09:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JsnTMNrh"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25B818C03E;
	Tue, 10 Feb 2026 09:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770715860; cv=none; b=oCE6cX6CMqCaA9H2PFR99rGGD0W0l7kjsdkfqgydcPuNO6zmqIhAvM8/QSlTf8XmIvcZxY/6q3DBCYi52A4Msv0aqelTeU4Jz42z968Hz65We/kHNgiEnhLZrJaODXJ2pmEpu4Rya59aJVsOGsb4JdKtAXqlAJ43tj3k6UT9Gx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770715860; c=relaxed/simple;
	bh=8hC2JU7EQQsw93ovqufBkmsny73TdehiI+uHk7YImNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJrEhaUbl1JSgC704rKcF4JZIhaIjYo1kkseQcG7BYPK0Sqd4bslT+zKvb5xOKRytKQZqFkP8RuAi0EbMYX1fYzPdUDr4SabLyE6exbzis5AWMpRxGSdl6w6mD3snt44oj308obME0QOZAM2O4/ahMIZmTew930JG3vut7UJ//M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JsnTMNrh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AFFFC116C6;
	Tue, 10 Feb 2026 09:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770715860;
	bh=8hC2JU7EQQsw93ovqufBkmsny73TdehiI+uHk7YImNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JsnTMNrhOF1+TnovdDBGKw6c7ERwKvwCKjh17WPPxh+DST3heSLBcqKLfJ8DT5rq6
	 19M0kh6SCZKjodUbiXfIy+waT/UkwKiY7AYZ7rytnOkayHudCV4sISorv7uO8qfxws
	 zlhpzMMOiQurytn+fD6xjRJkW+pKVjFGEsePKtMqfCilqlm54R/mYE+IuXTxlBotZZ
	 mZTfFHyGh/34dP1CaxX0ms8F0XzKBEFM1d5McpC0vLyCJLDLVr1g6mJjFtmqyJ8oZi
	 NxPF6C45ygXf709oyLU8jgjZP+YGuao4HZ1v6OFl+lz5Zz7WHAvdq/NIu2SlVAh9qC
	 PH90m7j49KjXw==
Date: Tue, 10 Feb 2026 10:30:57 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Richard Acayan <mailingradian@gmail.com>
Cc: Amit Kucheria <amitk@kernel.org>, 
	Thara Gopinath <thara.gopinath@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: thermal: tsens: add SDM670 compatible
Message-ID: <20260210-stylish-burgundy-malkoha-b6f8b5@quoll>
References: <20260210021607.12576-1-mailingradian@gmail.com>
 <20260210021607.12576-2-mailingradian@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260210021607.12576-2-mailingradian@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42419-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-pm@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linaro.org,intel.com,arm.com,vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: 2DB07118E44
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 09:16:06PM -0500, Richard Acayan wrote:
> Add the compatible for the thermal sensors on the SDM670.
> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


