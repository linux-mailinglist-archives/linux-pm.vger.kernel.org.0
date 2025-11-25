Return-Path: <linux-pm+bounces-38545-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5EFC84521
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 10:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B31524E77C8
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 09:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4202ED151;
	Tue, 25 Nov 2025 09:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvMXhxjU"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346A32E9ECA;
	Tue, 25 Nov 2025 09:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764064614; cv=none; b=t6xECm8z26abQyxm+jORmcMEiGkJTcwe0K+p4KHagCNjdB9qGUzj/GUIZV2w6D/f8C8dEJVyIAXgJFTeOcLwHINx5evCYT+yfrw1PPlqiQAFRKVx34eEOhZx/iWyD/orhJcL5Dtwzx2seFz0NMhMkRYnwiTIt3aSK9lIx5am+ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764064614; c=relaxed/simple;
	bh=0GPu1l3zNMQ3cknQLptiKbWwXLYqK3TMJjD3o6Letn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4jDc4tVEMJDZz84uQ3asvdEPP2yA7XmkRaSgemTsRUOrVz9YMMQvFtcvs43VBzd6lkeyvvvdTePT+ElD3XgDY+xgAHhlnuVF3CXn/y3MLSwu6Yr5yDrrjwPveZ0AbirEh5wXlMMrIcDOnFnCzy5S9R54ptMYA0DNztv5LDPcN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvMXhxjU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB25C4CEF1;
	Tue, 25 Nov 2025 09:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764064613;
	bh=0GPu1l3zNMQ3cknQLptiKbWwXLYqK3TMJjD3o6Letn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mvMXhxjU+avdAPCZMwmTLGrOugXisDV8TxNjFd/ckVYx57F7wpBupaEDQmOp6ic5Y
	 hAt/4BAitYk3j7TWIENR3TiWTht/Hgi2ESqIAelLSMdw8FuZ0apEqBEKROwVTvyxKu
	 pu5ynsTF+1yT1X5eZSvVi5sVQlFSxCFQ9W0GonYMbB+XSpm+qF4g+1KLKnXArbKVMO
	 mAOahH8DOXmFKBL/mZhbXRQFtgNXXz8DigJMKfuRlvM7ubIORdO58Aa5zlB+DuVuty
	 mixV1treB52IwXJUUnyOyeMOtWzN4Sa1nT6+93MDHJGLzeV+mEYs1iipWgg+x1XR9o
	 keERpBjO7epxA==
Date: Tue, 25 Nov 2025 10:56:51 +0100
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
Subject: Re: [PATCH 1/6] dt-bindings: power: supply: Add Maxim MAX77759
 charger
Message-ID: <20251125-amorphous-bobcat-of-whirlwind-afdab1@kuoka>
References: <20251123-max77759-charger-v1-0-6b2e4b8f7f54@google.com>
 <20251123-max77759-charger-v1-1-6b2e4b8f7f54@google.com>
 <d4455f4b-2a0f-4bc0-b897-14f2e27af3ea@kernel.org>
 <c9b059f8-9219-4219-95c8-23a3733fea58@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c9b059f8-9219-4219-95c8-23a3733fea58@google.com>

On Sun, Nov 23, 2025 at 06:34:05PM -0800, Amit Sunil Dhamne wrote:
> Hi Krzysztof,
> 
> On 11/23/25 1:28 AM, Krzysztof Kozlowski wrote:
> > On 23/11/2025 09:35, Amit Sunil Dhamne via B4 Relay wrote:
> >> From: Amit Sunil Dhamne <amitsd@google.com>
> >>
> >> Add bindings for Maxim max77759 charger device.
> >>
> >> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> >> ---
> >>  .../power/supply/maxim,max77759-charger.yaml       | 36 ++++++++++++++++++++++
> >>  1 file changed, 36 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max77759-charger.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max77759-charger.yaml
> >> new file mode 100644
> >> index 000000000000..71f866419774
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/power/supply/maxim,max77759-charger.yaml
> >> @@ -0,0 +1,36 @@
> >> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/power/supply/maxim,max77759-charger.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Maxim Integrated MAX77759 Battery charger
> >> +
> >> +maintainers:
> >> +  - Amit Sunil Dhamne <amitsd@google.com>
> >> +
> >> +description: |
> >> +  This module is part of the MAX77759 PMIC. For additional information, see
> >> +  Documentation/devicetree/bindings/mfd/maxim,max77759.yaml.
> >> +
> >> +  The Maxim MAX77759 is a dual input switch mode battery charger for portable
> >> +  applications. It supports wired and wireless charging and can operate in buck
> >> +  and boost mode.
> >> +
> >> +allOf:
> >> +  - $ref: power-supply.yaml#
> >> +
> >> +properties:
> >> +  compatible:
> >> +    const: maxim,max77759-charger
> >> +
> > This should be just folded into parent node, no need for separate
> > charger device or is just incomplete.
> 
> Thanks for the review! You are right, the binding is incomplete. This
> charger block actually listens on its own I2C address, distinct from the
> main PMIC.
> 
> I will update v2 to include the reg property. I will also add the

AFAIK, the main (parent) device schema does not reference children via
any sort of addressing, so reg here would not be suitable.

> standard properties `constant-charge-current-max-microamp` and
> `constant-charge-voltage-max-microvolt` to configure the hardware
> limits, as this charger device does not manage the battery profile
> directly (that is handled by a separate fuel gauge).

Well, still, what's the benefit for the bindings to have it as a
separate child? Kind of depends on your example, which is quite small -
one regulator and supply. Grow the example with battery and other
independent resources (if they are) to justify it. Or show arguments why
this is re-usable.

Best regards,
Krzysztof


