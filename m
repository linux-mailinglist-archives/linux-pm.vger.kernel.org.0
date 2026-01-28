Return-Path: <linux-pm+bounces-41604-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNXDG1TweWnY1AEAu9opvQ
	(envelope-from <linux-pm+bounces-41604-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 12:17:40 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D547A02CF
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 12:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5140D301052E
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 11:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D4733D6D3;
	Wed, 28 Jan 2026 11:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1EflS+i"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D102BE632;
	Wed, 28 Jan 2026 11:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769599057; cv=none; b=iD1KWz8oK650KP6bR2F1yhaJhBOvWSmp/FNpzaOoBB0S169P+OyTf9oFbq22hnofdYwvLSGI/75N94uHmtRF3l+9afQqRKFna13D40tE/mZYc1jnMIQEgURz+6B4AqQOErr8Tu5RjH5yqNQKE6/PaA0c5EXU6qwQ2KXGNhhMW7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769599057; c=relaxed/simple;
	bh=dM6M+55JmMOXseD3l/QxOK7cVqbiLuI6OIDSIdS6maw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3DYWXPjgerqDdhEzVBh9ayXD6D/1WYus53jphdQeUOgnja9u0EKUi5Fib0Vg5ubXmAM8KqkCoKMDFIgAKoJGoKxK5GONgPnRwDRmb5UvkkP+cRJVtgpjUVQ96rpsPq4Nj3iMgoeDLgzmektD29NXIUg2O5eEt7ha8DboiIdF8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1EflS+i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C638AC4CEF1;
	Wed, 28 Jan 2026 11:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769599056;
	bh=dM6M+55JmMOXseD3l/QxOK7cVqbiLuI6OIDSIdS6maw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f1EflS+iOumdsYkVKUPXHviV+ixtqjCl0cSjw6SFIbisLSyioilwJwAaJBF/6D0LB
	 bv9FtYWxIP9B1AJGlixp2jPcjvPss63YgWmw0Mz1ufpIPRvPVGVpk6Is5jflfGOgOl
	 zjh+htghW5OZq/3DhjsABbsYypuI6FZqBaY+TumQCLsND6Ifx9Lp1lynRX1L7UwXp3
	 TtaoqMCK9VO/b3Zf39o48UEHSOdMmCKL87s8njcYPJ/iUbT3r0TbfWAHfnFfq076qk
	 fEMD63pF25AOk07qB9xFpFbciMRCaa069MdpLeclnRwsl1c8+fuXUYxUdmBAe9h4h2
	 vtKwz76Zwo56A==
Date: Wed, 28 Jan 2026 12:17:32 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: interconnect: document the RPMh
 Network-On-Chip interconnect in Eliza SoC
Message-ID: <20260128-handsome-elite-boa-1dc56f@quoll>
References: <20260127-eliza-interconnect-v2-0-b238a8e04976@oss.qualcomm.com>
 <20260127-eliza-interconnect-v2-1-b238a8e04976@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260127-eliza-interconnect-v2-1-b238a8e04976@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41604-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: 0D547A02CF
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 05:26:17PM +0200, Abel Vesa wrote:
> From: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> 
> Document the RPMh Network-On-Chip Interconnect of the Eliza platform.
> 
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> ---
>  .../bindings/interconnect/qcom,eliza-rpmh.yaml     | 141 +++++++++++++++++++++
>  include/dt-bindings/interconnect/qcom,eliza-rpmh.h | 136 ++++++++++++++++++++
>  2 files changed, 277 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


