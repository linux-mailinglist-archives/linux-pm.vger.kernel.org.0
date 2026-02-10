Return-Path: <linux-pm+bounces-42414-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMLGKqT3imn2OwAAu9opvQ
	(envelope-from <linux-pm+bounces-42414-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 10:17:24 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10567118C59
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 10:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E7A6302A04C
	for <lists+linux-pm@lfdr.de>; Tue, 10 Feb 2026 09:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C22340264;
	Tue, 10 Feb 2026 09:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRhPEZ9L"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B097930BBA5;
	Tue, 10 Feb 2026 09:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770715041; cv=none; b=m2a+4xeoLf5nOGOSfq17CVjLEbO0lQgUN6fX8gzq4AEaUGKCCzK/diPfaVCrkLHir2aU14ehBPP6xTDvG2P815QoiVqu+kE31NVPHY5CPBN6tlaXOHUmZrbDBRTdq1t7JMs+FFqR6H6dd1oYeXLHwzrrowrb08zEadLrfpxMHko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770715041; c=relaxed/simple;
	bh=rb2/o7aZd/FlPId0sF/rBdA5xJ85JKApUpjqnwPWbBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmZEeUDFXsmkjGLyzByJSe9V3KxrPB+J4Ev3tGUyCc2pSYxZR/9b0PCxpxCT7eSxVSJzCi2mXBG8LKO9H1rCFqP/gL9sc1hvTP3XfZmbYPTNwZRxayydMWi9281ckBpr8AzTInLY3za/3aklQoVAIy11zlpdKzd/eLchbZgbqG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRhPEZ9L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8C1C116C6;
	Tue, 10 Feb 2026 09:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770715041;
	bh=rb2/o7aZd/FlPId0sF/rBdA5xJ85JKApUpjqnwPWbBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CRhPEZ9Lr+dNpMlYV/QcmkjBphNgaUFxaYB/3XEA3HKUgCbOtQrThkJDnmbABl5EN
	 EmiQl45fOlvrGd2EjaM6YWwk+VDtFx5iV1qFlZuqr0bKTC/Rs58woGcHDj4w9ba1wa
	 +Qr8dIm5qye5ddFszG0VmeuB8InGFW8ut5L9M+krzQr9wrJs5xLGqP7yHFJCQ84/xr
	 dZKA9QlWf//5d4BMzf9A4VuzEUKYCboVUCFcmgMY08ghMNf9KTOhwG06cnTu+6OVwZ
	 7k36DuavvY5UCi2wGaThw+oZOoyQxsD+CZo1qtEWs+3nShg5HXJ1C/F+6jPMlAUnRj
	 orwjgCrRCyaCw==
Date: Tue, 10 Feb 2026 10:17:18 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, sre@kernel.org, 
	heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org
Subject: Re: [PATCH v5 1/5] dt-bindings: soc: qcom: qcom,pmic-glink: Add
 Glymur and Kaanapali compatibles
Message-ID: <20260210-whimsical-unyielding-owl-bb3bec@quoll>
References: <20260209204915.1983997-1-anjelique.melendez@oss.qualcomm.com>
 <20260209204915.1983997-2-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260209204915.1983997-2-anjelique.melendez@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42414-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: 10567118C59
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 12:49:11PM -0800, Anjelique Melendez wrote:
> Glymur (a recent compute platform) and Kaanapali (a recent mobile
> platform) have the charger FW running on a new subsystem SOCCP (SOC
> Control Processor) instead of on ADSP like in previous platforms. Because
> of this, pmic_glink interface on Glymur and Kaanapali platforms are not
> compatible with previous platforms. Hence, add new compatible strings
> for Glymur and Kaanapali.
> 
> Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


