Return-Path: <linux-pm+bounces-27154-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 965AEAB7610
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 21:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 287594A7D0D
	for <lists+linux-pm@lfdr.de>; Wed, 14 May 2025 19:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F825292915;
	Wed, 14 May 2025 19:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0sSOneI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7C038DD8;
	Wed, 14 May 2025 19:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747251772; cv=none; b=EGc4+CwQC25mIXMRRk2eVZ05WYT/lYXL8J0ZP/KF37+zKehl6CGZ2W3caNf5Ke8hsnez3OANVOk0SKQkl54T1+svk6zNQNKxJ25lrbMGXM5Sptv7+WWZeH6GwjS3JtaureMQ7OcAZSwQ2z8MXnEKuaydTnv6gEI3BZOWxG+d/5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747251772; c=relaxed/simple;
	bh=yWmJMSlaQvXI0wKYuylDSdZXkla4rjdIyeqAqSXswGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kNnQrV2SfS3+qGD+oC/zFmI9FggtOf2RvleFigtV3inO2dPVETBrMrACi8Xg0BD4iu2uHQXQbBhfXXqghy/cV+qB7kC4NbywbUyOQpZJMGJ+xiTaeizfgig+O0cTHVd6vb9/3bI17ImtZ+YAlth1QIXzE+PZopiAND4OVh7+Vg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0sSOneI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3244C4CEE3;
	Wed, 14 May 2025 19:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747251771;
	bh=yWmJMSlaQvXI0wKYuylDSdZXkla4rjdIyeqAqSXswGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g0sSOneIB/yT7Ra+DuX3Cl4V7LqjMXAFrh4oy/pgvSSOiunAGBn4yDO+xZpmtTMan
	 /f/JPRl9B0nHukXiIJgpv7DwsvqUuIjApdrz21HvU1XNR7NA60XLpAc8vLRUpazqcQ
	 61GQVdhF+jWSO8AUytkQK68mVgeTcNi6611lywYzaFTdxhj9bE4pqgPdw9Dmn9Ok63
	 mUCSsoi5dVKHvWwZwc678fxJ1Rly49y5HG3oTBj57U4qCCc/oxqBQfb3Dj58Nna9N4
	 2rIodqOnVOZbgw/Hsdscl5LfLeo1QmHkLy7KBsGv0F2jdobNw18hNTxeIUlTgMCetv
	 YiMmOmk8UY4CA==
Date: Wed, 14 May 2025 14:42:49 -0500
From: Rob Herring <robh@kernel.org>
To: Amit Sunil Dhamne <amitsd@google.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Badhri Jagan Sridharan <badhri@google.com>,
	Sebastian Reichel <sre@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@kernel.org>,
	Kyle Tso <kyletso@google.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: connector: extend ports property to
 model power connections
Message-ID: <20250514194249.GA2881453-robh@kernel.org>
References: <20250507-batt_ops-v2-0-8d06130bffe6@google.com>
 <20250507-batt_ops-v2-1-8d06130bffe6@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507-batt_ops-v2-1-8d06130bffe6@google.com>

On Wed, May 07, 2025 at 06:00:22PM -0700, Amit Sunil Dhamne wrote:
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
> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> index 11e40d225b9f3a0d0aeea7bf764f1c00a719d615..706094f890026d324e6ece8b0c1e831d04d51eb7 100644
> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> @@ -181,16 +181,16 @@ properties:
>  
>    port:
>      $ref: /schemas/graph.yaml#/properties/port
> -    description: OF graph bindings modeling a data bus to the connector, e.g.
> -      there is a single High Speed (HS) port present in this connector. If there
> -      is more than one bus (several port, with 'reg' property), they can be grouped
> -      under 'ports'.
> +    description: OF graph binding to model a logical connection between a device
> +      and connector. This connection may represent a data bus or power line. For
> +      e.g. a High Speed (HS) data port present in this connector or VBUS line.
> +      If there is more than one connection (several port, with 'reg' property),
> +      they can be grouped under 'ports'.

'port' and 'port@0' are equivalent. So you can't be changing its 
definition.

I'm not sure showing a power connection with the graph is the right 
approach. We have a binding for that already with the regulator binding. 
Perhaps the connector needs to be a supply. It's already using that 
binding in the supplying power to the connector case.

Rob

