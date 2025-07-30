Return-Path: <linux-pm+bounces-31566-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECE6B1576A
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 04:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 667713A2CC7
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jul 2025 02:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839C817A31D;
	Wed, 30 Jul 2025 02:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="z8qrXkvY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6523EEBA;
	Wed, 30 Jul 2025 02:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753841212; cv=none; b=tCp7diN89xWy0MAYDuXRABtihu5x5zWYdWBSAHYkBvTAjfdUHotMkcMwue0Oe6b4RdNHnO5wE6sLH3uPtIDwk+lVpyFxLrewYismiGPvXaDHBGZpdKpMqBFNzKMsg/wvVgir3yaErrNJenKOuqx1y6M/XZEU4wUEwq8qMoLrx1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753841212; c=relaxed/simple;
	bh=0TN0JJ0sPEdY8+AEKsqH5z5n1c0D9g4cUEGihAx6U0I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZ9Lnoqkty1hLUO4tarxuz/eyuDrBxWZetlK+Kpul9ZLhtuAVsqmVPqUr/ukklGl0+HJS/9w3ntQ0bSpRMDr3P01djbwQ0TY/om42n63LmwojTpx0b0S2003YuFi4Ukz9FKQRorQTqeUKfONADZ7oZ1wZAxPOoTvbVSLkTgOALA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=z8qrXkvY; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1753841206;
	bh=aH1M1cXyquaTzAxijiw+AvsTfYNzXEKIaPK9sUyBhAM=; l=996;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=z8qrXkvYk8kFfhDd5w7oD5wF5e4qZTv0TuSMOAbuGcYR3z0zNzqxsEvYI1eAo7Ca8
	 JRZl/KTvuZ1wl24JauzwpEs3LRfAtUcamPNGRToUdsIYweWD6OGOOIRUGOxnJWw5/w
	 FZoCmxAv45R4a0rpmWCfwhPzHbbsxbCWclaLLnqjtIgXW0E2c2Uz4uuHOahyXGipj2
	 yuRSC88AAcXSMhWJRaQKE/ZE0D4LR7pUhLTwFEDwkudS2KbA050G/DynYwLbtyd3ui
	 xDJ0kaQcEuEvmYSszEdoTTfx64PXKV+dryI090UNtm+hNTjRcerYATEnadnkpdqJEC
	 pKi+LWGtsRsnA==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(244573:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Wed, 30 Jul 2025 10:06:32 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 30 Jul
 2025 10:06:32 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Wed, 30 Jul 2025 10:06:32 +0800
Date: Wed, 30 Jul 2025 10:07:16 +0800
From: ChiYuan Huang <cy_huang@richtek.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: power: supply: Add Richtek RT9756 smart
 cap divider charger
Message-ID: <aIl+VKFURqFfXKz3@git-send.richtek.com>
References: <cover.1753759794.git.cy_huang@richtek.com>
 <3fa997b42b4aec43fc182a043cf521f7e3e7fcb3.1753759794.git.cy_huang@richtek.com>
 <3603a744-e898-49ef-968a-2388e14cae54@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3603a744-e898-49ef-968a-2388e14cae54@kernel.org>

On Tue, Jul 29, 2025 at 05:40:32PM +0200, Krzysztof Kozlowski wrote:
> On 29/07/2025 06:21, cy_huang@richtek.com wrote:
> > +
> > +  shunt-resistor-micro-ohms:
> > +    description: Battery current sense resistor mounted.
> > +    default: 2000
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - wakeup-source
> 
> Why do you require this? I cannot find any use of it, so maybe I missed
> some change in Linux code (and that's second question like that for
> Richtek, so refer to your other patchsets for contexr).
> 

This will mark the interrupt as wakeup capable.
https://elixir.bootlin.com/linux/v6.16/source/drivers/i2c/i2c-core-of.c#L57
https://elixir.bootlin.com/linux/v6.16/source/drivers/i2c/i2c-core-base.c#L547
> > +  - interrupts
> > +
> 
> Missing ref to power supply.
> 
> > +additionalProperties: false
> > +
> 
Ack, will add the below lines to the document for next revision.

allOf:
  - $ref: power-supply.yaml#
> unevaluated instead
> 
Ack.

Thx.

