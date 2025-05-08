Return-Path: <linux-pm+bounces-26858-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BC8AAF0F7
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 04:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17DCB1BA0C3C
	for <lists+linux-pm@lfdr.de>; Thu,  8 May 2025 02:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70841953A1;
	Thu,  8 May 2025 02:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+XXStZM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25B633FD;
	Thu,  8 May 2025 02:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746670087; cv=none; b=rztyqfZG6CM8ZzXrKnUhpfZ2YS5jijQz3+fBX5h2WY/1oGd1XvfV+eZ3WJGLmZ0jZZSDCdu+XNXSTL8EoyyKq/gnOu4avMPJFzfGIKYkZm7EcwaURpVs5uP467TrHQQXePCxVT/T5a7PFU7Ut1COQt6wY83VPFD1DFHo8Ik5Eqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746670087; c=relaxed/simple;
	bh=J3b/UUQA6iXH+tQkT36vkOUsbgBL/i+qp8A0/9VdBC4=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Gr7kmR3dPjqoVz7VHXcA+H+huhkRkp/4htJBPR1W8T0Vyb5wIBRl7v5NcNQPsESDX8cKQl+bNZWiEehXM/LhMdXUCUeQjqwTuuBA2MZ5DnX40mF8YPCiFgg96LcL3qnt9g77UjOQ4QrsWk4HKCQ9kxazIBS2KI7l6W1ukvUs2Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+XXStZM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3A4C4CEE2;
	Thu,  8 May 2025 02:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746670087;
	bh=J3b/UUQA6iXH+tQkT36vkOUsbgBL/i+qp8A0/9VdBC4=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=E+XXStZMIPJmNzaQvdM4tWEBQKd8W3/cchXFqNsnghig5javnyCf6M+L4Jl0lcvWY
	 op4BJFrALjst41v+mnWNESfBqbSmllqZ8fzaR1MurFDiKVJvXobSWvn5vrbAQCkjHw
	 eSpllkEvEQlgr5yCy8MVT9BRgtNjbswA93yVVVX6/QL3Tb6WqWbBnlBC5rlhxOObOB
	 0WGRBtiQevwK5sxAQTPHbluw1Ls4NhxNVe6c9XdVGhHUOUhClJDZN/0pOHzq+b/hTk
	 iRfL8UN5z9Oylxq9/SUAR38kEs/1xOwRuE2XPcg0ShTwRjjs+CIey+3VuIryHp0Pm2
	 4vUJTig7gH4fg==
Date: Wed, 07 May 2025 21:08:05 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Len Brown <len.brown@intel.com>, Kyle Tso <kyletso@google.com>, 
 linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
 devicetree@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, 
 Badhri Jagan Sridharan <badhri@google.com>, Pavel Machek <pavel@kernel.org>
To: Amit Sunil Dhamne <amitsd@google.com>
In-Reply-To: <20250507-batt_ops-v2-1-8d06130bffe6@google.com>
References: <20250507-batt_ops-v2-0-8d06130bffe6@google.com>
 <20250507-batt_ops-v2-1-8d06130bffe6@google.com>
Message-Id: <174667008518.3134866.16860556665392127379.robh@kernel.org>
Subject: Re: [PATCH v2 1/5] dt-bindings: connector: extend ports property
 to model power connections


On Wed, 07 May 2025 18:00:22 -0700, Amit Sunil Dhamne wrote:
> Extend ports property to model power lines going between connector to
> charger or battery/batteries. As an example, connector VBUS can supply
> power in & out of the battery for a DRP.
> 
> Additionally, add ports property to maxim,max33359 controller example.
> 
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> ---
>  .../bindings/connector/usb-connector.yaml          | 20 +++++++++++------
>  .../devicetree/bindings/usb/maxim,max33359.yaml    | 25 ++++++++++++++++++++++
>  2 files changed, 38 insertions(+), 7 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250507-batt_ops-v2-1-8d06130bffe6@google.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


