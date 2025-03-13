Return-Path: <linux-pm+bounces-23965-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F16BA5EE55
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 09:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A9EF189FE4E
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 08:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC3A2620C1;
	Thu, 13 Mar 2025 08:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPQY6xqo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF233A8D2;
	Thu, 13 Mar 2025 08:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741855692; cv=none; b=aHeakW1v+MBEudsU5GPVXuuNqc+EqFvqCfo2mx6Ox7WQzSgpolfckdw8hUBlP8NDRH2WkEhlOYjyM89Cam8eOqnJ5zbWnhIIM5b68KlxaYlm5OVkk/R1FIU9yE1CeptZMDllhxbCmY2VdGcgJKYUUFygxL7CPdduZOOYZcUupaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741855692; c=relaxed/simple;
	bh=Hk3K9FqTOGbUtdb1NPCducwlxxGW7aeLrXgBAKioQXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXd7eyNLSRkjBf2jYqFQMuYxMesromiYxI2RzJ953fYmJWa2lNeIQK/yU1u66kObmweMM1QxJIOFn9uYQo9BKNak5mPF5+fDwZCHjej9S8ixwASL8g2Spxi+16KxCYFAp03TdCXjzqwQcwsa/Dz5U5qj66rm3vMBpaqWnYAT3Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPQY6xqo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40ED5C4CEDD;
	Thu, 13 Mar 2025 08:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741855691;
	bh=Hk3K9FqTOGbUtdb1NPCducwlxxGW7aeLrXgBAKioQXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VPQY6xqoIH5MlTjU2hWK+0T9qaC3UNqSTJRdEFJojusBnEsK6UnQA7BdnYibAf1TU
	 QLKNLsZ5cBF/KlQiWzJYl/QzHHd8K6wZthcZRm17DM8eVSl36R4rbzngAnBix/l+B5
	 LJaJxV+aOIu/k7I4FNU+984WncZikIgG3A550VYRNYgzkPs8AbGebZXKyz/3BnfVkn
	 mZ4A7SMe6Wpi2H0yxsgRelCrqsoVTKfTq/jmApiNzpouHy6aS3vjJ2IJXoLIO7N/80
	 vmtPDwb7p0CYyeOxn6PD2WktU7llh1Y0EE83KVENFcHR7vhUcMKFI18IQ8NiSCXtB8
	 Oh2tTt1Ejtf5Q==
Date: Thu, 13 Mar 2025 09:48:07 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Amit Sunil Dhamne <amitsd@google.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Badhri Jagan Sridharan <badhri@google.com>, 
	Sebastian Reichel <sre@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-pm@vger.kernel.org, RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>
Subject: Re: [PATCH 1/5] dt-bindings: connector: add fixed-batteries property
Message-ID: <20250313-tidy-kakapo-of-abundance-eebf91@krzk-bin>
References: <20250312-batt_ops-v1-0-88e0bb3129fd@google.com>
 <20250312-batt_ops-v1-1-88e0bb3129fd@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250312-batt_ops-v1-1-88e0bb3129fd@google.com>

On Wed, Mar 12, 2025 at 04:42:01PM -0700, Amit Sunil Dhamne wrote:
> Add a new "fixed-batteries" DT property to connector class. This
> property is populated with nodes associated with battery type power
> supplies powering the USB PD connector. This is needed by the Type-C
> Port Manager (TCPM) to query psy properties which are used to feed

What is "psy" in terms of bindings?

> Battery_Status & Battery_Capacity AMS.
> 
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> ---
>  Documentation/devicetree/bindings/connector/usb-connector.yaml | 8 ++++++++
>  Documentation/devicetree/bindings/usb/maxim,max33359.yaml      | 1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> index 11e40d225b9f3a0d0aeea7bf764f1c00a719d615..5e15bc060f5a2cfce842f83de738f1e8bae3ce2d 100644
> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> @@ -300,6 +300,14 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint8-array
>      maxItems: 4
>  
> +  fixed-batteries:
> +    description: Contains references to nodes associated with battery type power
> +      supplies powering the USB PD device. These batteries are fixed type and

What is a "battery type power supply"? If you just link here batteries,
then we have type for it - monitored-battery - but I doubt connector has
direct connection to the battery.

If you mean chargers, the OF graph is already there for this and no need
for this patch.

> +      not hot swappable.
> +    minItems: 1
> +    maxItems: 4
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +
>  dependencies:
>    sink-vdos-v1: [ sink-vdos ]
>    sink-vdos: [ sink-vdos-v1 ]
> diff --git a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
> index 3de4dc40b79192b60443421b557bd2fb18683bf7..66c99f0131f074f1c08e31d7481f555647e3b2f8 100644
> --- a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
> +++ b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
> @@ -75,6 +75,7 @@ examples:
>                                         PDO_FIXED(9000, 2000, 0)>;
>                  sink-bc12-completion-time-ms = <500>;
>                  pd-revision = /bits/ 8 <0x03 0x01 0x01 0x08>;
> +                fixed-batteries = <&batt1 &batt2>;

Two phandles, so two <>.

Best regards,
Krzysztof


