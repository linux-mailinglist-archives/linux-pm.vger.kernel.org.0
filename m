Return-Path: <linux-pm+bounces-43362-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJI0KM3Aomlc5QQAu9opvQ
	(envelope-from <linux-pm+bounces-43362-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 28 Feb 2026 11:17:49 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AE61C1EE8
	for <lists+linux-pm@lfdr.de>; Sat, 28 Feb 2026 11:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D276304810F
	for <lists+linux-pm@lfdr.de>; Sat, 28 Feb 2026 10:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BFB41C2E7;
	Sat, 28 Feb 2026 10:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCL+/l+Z"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001F41B424F;
	Sat, 28 Feb 2026 10:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772273864; cv=none; b=hEl9/S6pxBrFKMfvlVevyucyZhth6whsierrUXAlxnNCXJX78IPmlfMk/qrKteUUwsnQluxRYELJb1i2aK9srnN/7+c8cbXl7L8XLkednB9fLM3O+3jGEFXj/j2cxdxYQPLWp1DNaSw7yUPKtyYWlZLCQXBIq+ZU4ZxH2eKMtL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772273864; c=relaxed/simple;
	bh=EckrghYgO+qfxkWHzcIKDRTlZk9IpJptkpYgpiRxzR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MsKbPh0xRutk89xyX0EhS17waaRCWRq0rT0HBdEB8Ff+BxH3Q+oS9ctJOEv7QmcUnpgHRNOqwsZhfvW2coXQDvJfKjWGZCGHpf7VfFFag0cyl2Pw48/DiR11tXubRxQVULMNoT7+liHXHTaE77j/Wt+U6W6g5zKbaXLxDxOG/tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCL+/l+Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130C3C19425;
	Sat, 28 Feb 2026 10:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772273863;
	bh=EckrghYgO+qfxkWHzcIKDRTlZk9IpJptkpYgpiRxzR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OCL+/l+Z6xUpmf+hoGp/Xp5+7kceLNkgzqwP+zsknztiAYQXgOHqlnrfUQDeLZTYL
	 JTAKnm3DOG7Chc7I3+9RIJRTiLs52JF9/VfSLHmVeg7X6IAADoGbgq3jVJxs0KFHvl
	 2XXm0+aufa+GdgZExg95q1j4nsVXjvv2Z36OOEfB26l9YtKneVw/3i7j73fTX4zkHy
	 SwKzl1ipvkiHnItZbVR+Z55kh+9Pqn/Ylefahm8xnqCMSSfGcZlWU8+OJPeDQS1aw3
	 Wtn4Egk0zndHsvSfIxx+W3fZczQBgBLWz4wp8RVv/EmYY+VNA4btb8i4tKM9/TpevV
	 v/sDdC3yhP1Yg==
Date: Sat, 28 Feb 2026 11:17:41 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: power: reset: qcom-pon: Add new
 compatible PMM8654AU
Message-ID: <20260228-polite-swine-of-potency-56e61a@quoll>
References: <20260227-b4-add_pwrkey_and_resin-v3-0-61c5bb2cdda9@oss.qualcomm.com>
 <20260227-b4-add_pwrkey_and_resin-v3-1-61c5bb2cdda9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260227-b4-add_pwrkey_and_resin-v3-1-61c5bb2cdda9@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43362-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 34AE61C1EE8
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 06:02:28PM +0530, Rakesh Kota wrote:
> PMM8654AU is a different PMIC from PMM8650AU, even though both share
> the same PMIC subtype. Add PON compatible string for PMM8654AU PMIC
> variant.
> 
> The PMM8654AU PON block is compatible with the PMK8350 PON
> implementation, but PMM8654AU also implements additional PON registers

So does that mean that PMM8654AU has 2 address spaces and PMK8350 has
only one? At least it looks, so I expect fixing the last if:then: - you
need to drop contains from PMK8350 if clause and add new if:then: for
PMM8654AU.

Although the binding says "pbs" and here you say "PON".


> beyond the baseline. Use the PMM8654AU naming to match the compatible
> string already present in the upstream pinctrl-spmi-gpio driver, keeping
> device tree and kernel driver naming consistent.

And all this is partially confusing. This is reset/PON, not SPMI Pinctrl
GPIO binding.

Best regards,
Krzysztof


