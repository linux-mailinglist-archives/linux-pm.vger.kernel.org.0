Return-Path: <linux-pm+bounces-40004-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B410CE641B
	for <lists+linux-pm@lfdr.de>; Mon, 29 Dec 2025 09:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F8CA30052C3
	for <lists+linux-pm@lfdr.de>; Mon, 29 Dec 2025 08:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035A0271476;
	Mon, 29 Dec 2025 08:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPGlNMJ0"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E7B1A76BB;
	Mon, 29 Dec 2025 08:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766998227; cv=none; b=YvEWdToif0X7CJnZeqZZ9cNchjuxwu+FC6IYuADKl9DaZ6oqNJQwRhTuL31EpDUPIGA8DzpngkaF0o4IMtZU60yA3fbs+MU3Hdh3F0MarWRZlzfUEO/ujq2k8VF7d5OHR00xZV7/AhNrmcjR2zBxt6TNHSd0Pmpuh568aKQwbTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766998227; c=relaxed/simple;
	bh=1ALaMKIKCuUSWUA/hqdR0oh36sJOQQUkFqyRUJxVq8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcLAmBgbXhhGzI+vq/uZRJXAbFg1KAOCqut/wGC23RIWUk+8pfowE2GbAzGAmtHxCUOd0jhe2irC95v8A+7CSp7ZIrSW+IeCnY9bKMYGJe2BTG8d05sRw1JVYzCsTvhBVsQj193/HlAFg1oOGSa0uNFCHQQEYKFJZENBwFBw+fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPGlNMJ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED90EC4CEF7;
	Mon, 29 Dec 2025 08:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766998227;
	bh=1ALaMKIKCuUSWUA/hqdR0oh36sJOQQUkFqyRUJxVq8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WPGlNMJ0UXYHJcsqCEaS1my2hsbVfQVdY80vjpFT94ZU4pgNs7kZpm4hP54TKyQmI
	 T7OzJ6dvD2qe9+1lOx0x0whza1dWAE5ssNw3HqZfiefgl72zx4CbTNj1PanRNPtMQG
	 vO5ScDQHramGt/9VJX9CgSQ5c0jJR4vIoR4zVj3XliPDgJwHyzYYghlXArpnEjP65G
	 b2L7VmhVywVYU8zUsEfZCvkHvJoOLWdFNhcGo1EB+NwqrdjCw/Xhy71fjvRVQoVRfO
	 m8ZWXGUFa8PYpkS7vFjlgMmV2HFbwA7jMdXdywpFAIBRGKVp5KGgVUGSyz0PCLISIH
	 Kw2lQYaG4ONJw==
Date: Mon, 29 Dec 2025 09:50:24 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Amit Sunil Dhamne <amitsd@google.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>, Lee Jones <lee@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Badhri Jagan Sridharan <badhri@google.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Peter Griffin <peter.griffin@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>
Subject: Re: [PATCH v3 1/5] dt-bindings: mfd: maxim,max77759: reference
 power-supply schema and add regulator property
Message-ID: <20251229-festive-daft-boobook-838fb6@quoll>
References: <20251227-max77759-charger-v3-0-54e664f5ca92@google.com>
 <20251227-max77759-charger-v3-1-54e664f5ca92@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251227-max77759-charger-v3-1-54e664f5ca92@google.com>

On Sat, Dec 27, 2025 at 12:04:21AM +0000, Amit Sunil Dhamne wrote:
> Extend the max77759 binding to reference power-supply schema, so that
> PMIC node can reference its supplier. Also, add regulator property to
> control CHGIN (OTG) voltage.
> 
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> ---
>  .../devicetree/bindings/mfd/maxim,max77759.yaml          | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


