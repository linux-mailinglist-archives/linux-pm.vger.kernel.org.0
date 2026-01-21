Return-Path: <linux-pm+bounces-41218-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gN+SOkqLcGkEYQAAu9opvQ
	(envelope-from <linux-pm+bounces-41218-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 09:16:10 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D4C535BA
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 09:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E62D54011D
	for <lists+linux-pm@lfdr.de>; Wed, 21 Jan 2026 08:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970DD451079;
	Wed, 21 Jan 2026 08:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p6dCyyxK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EDB4418F8;
	Wed, 21 Jan 2026 08:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768983104; cv=none; b=mAowqfoq8NxozuOpgvPuUTXj/GHZ7zTSX+Gatp2iXw8RNRChBkqhV6I7WnyyWlG+vVQlBfZQ7lvtlBl9cGWqm6eOFOxsmk+n+XzFWlebMxoxQV8FHRLaun/OU91PWVj7KP2E6Q6T7re1s4PtISX+6/KP7ujF1r0vd+guLhMoE9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768983104; c=relaxed/simple;
	bh=E5z3qPhjZKsB9eel0+7JuOykrl9eTQ8EyNzewNZ1mVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKN9RHQjzRiSBLrgCAfrlcwHMt21fSar3ShOdYSyh0OAHieQwektGJ5D/JRoeha+jkt07OiT8V8XKkwDxDj8Ga6n/DkgfqIxA9oMp4P8dLKV4/Rw+FZx4p3W8jhL0a1QEhU27Z9WwcmP1ZexzzzZsDoCf/+nK7xMZgy5WbH/54o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p6dCyyxK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA9DC2BCFD;
	Wed, 21 Jan 2026 08:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768983103;
	bh=E5z3qPhjZKsB9eel0+7JuOykrl9eTQ8EyNzewNZ1mVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p6dCyyxKfU6VH1QKN6n15UaUzemo4WTaAq0S1OoOH/gwtxDkeYqo3F4Yk2mrCuGkI
	 7kLZ6BZZ+DWemOM02joLRgBC6SlhBQisl5X8SpT0EHuDljC1c10c3T3JFCiAo3KBQj
	 8xNWGk7glTCo1aG+JEKozyT8M75sEtz55KFr47yWNLP8JAAAPYX/DIemg0j6QTbXPv
	 PUvpKBDX27loIPKyw0X50QFIN+dm1wlLooC4rNQp31ioAbsth9PstLXyeul0SsJzOg
	 t8RcpvNDpMFLYXar1EkdtQCeOx5ge4/WnKt2kAQVMhnZDlzDg0HWBVQ7OPec/gvs/r
	 bAC+JV/jcA2Wg==
Date: Wed, 21 Jan 2026 09:11:41 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, rajendra.nayak@oss.qualcomm.com, 
	sibi.sankar@oss.qualcomm.com, pankaj.patil@oss.qualcomm.com
Subject: Re: [PATCH] dt-bindings: interconnect: qcom-bwmon: Document Glymur
 BWMONs
Message-ID: <20260121-wooden-nuthatch-of-cleaning-6723bf@quoll>
References: <20260120-glymur_bwmon_binding-v1-1-57848445eccf@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260120-glymur_bwmon_binding-v1-1-57848445eccf@oss.qualcomm.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TAGGED_FROM(0.00)[bounces-41218-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,qualcomm.com:email]
X-Rspamd-Queue-Id: 54D4C535BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 07:07:35PM +0530, Pragnesh Papaniya wrote:
> Document Glymur BWMONs, which has multiple (one per cluster) BWMONv4
> instances for the CPU->DDR path.
> 
> Signed-off-by: Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


