Return-Path: <linux-pm+bounces-35019-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4251DB88698
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 10:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1810E1C8604B
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 08:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFD130147D;
	Fri, 19 Sep 2025 08:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="Y/wXleBu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AE62FDC4E;
	Fri, 19 Sep 2025 08:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758270425; cv=none; b=UZgri5eW7KFZPQMlKvIV6lAOjJ/VqD8buYsyJdDBi8jOxU9edvQfFgRBPOXRCg4Dp4qodvnKQzbD2EwDRRrVDixWRUpaXVqLuZd1EhuyrROzNC2plxwxasu4ZmpLkp7sVYw7lcgIDVyRJai6bQMvVAOJ1/JgBfu0D13fWwRWhjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758270425; c=relaxed/simple;
	bh=/CB0cwOmhbgSy12uwrIEf0k4JswvKeJ/Fi2YKoa5O7Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKQ7APYIuunN3nspYGgHdNwmT8sxf8ImOLSXEruaRG+sB4LI4BCu64owkbiLhplpkUYiEqMNyFljQf25yB02ys0Wci2nFPqR9ql/hHP4cjLWoZt7WgODlJEwK9gzGn3DW6eb3EYwIH1pb1gLCx28kg0h0oRAOkgOh1544Ok4PKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=Y/wXleBu; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1758270413;
	bh=K02hNlRBxyxBeAOesGR89UhJH2sHlmv3taRcii4Mw/I=; l=1728;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=Y/wXleBunM2yJxC2XT6Et7h2lPCA6z2DVxcCv/89222IAH5Ss4+tB6USqhmlSLM2V
	 sU4M4fLiNxw1wSpxeHEi/WRmjMwmSu8ta7EiVet9jnWjpq1u3TxcgQ8l+7TRK0xSI0
	 oO9ew7DFwsuCdZAh2vEZR6tbo9XBbdfWZ1OCDluXF7hykF7p1ee19ScNjyS1czYNuF
	 xzYLyDHCT8NRYZqXrHPiouaIPw/dh4vjC6lgvw2vTVIkwyxTBFqdGP3KXx73pP5jk4
	 iOw5yy0I5G8OMhtPzwhUcUdc6/7Whyrc7cf9AZ2u1ca8dBMSYk4avv2hynfM83dgus
	 VVG7uygTpISvw==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(2461094:1:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Fri, 19 Sep 2025 16:26:38 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.26; Fri, 19 Sep
 2025 16:26:37 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1748.26 via Frontend
 Transport; Fri, 19 Sep 2025 16:26:37 +0800
Date: Fri, 19 Sep 2025 16:27:50 +0800
From: ChiYuan Huang <cy_huang@richtek.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND v2 2/3] power: supply: rt9756: Add Richtek RT9756
 smart cap divider charger
Message-ID: <aM0UBoynaX7ln2Tw@git-send.richtek.com>
References: <cover.1755154950.git.cy_huang@richtek.com>
 <2bceb1be91e8841cd373c1d04f0a79d88c888dd8.1755154950.git.cy_huang@richtek.com>
 <uarjdpyemkqnwneoj6kdj7vfzzllbqmsurjnsjr5hkujao6thx@2ysih3s7mftj>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <uarjdpyemkqnwneoj6kdj7vfzzllbqmsurjnsjr5hkujao6thx@2ysih3s7mftj>

On Fri, Sep 19, 2025 at 01:43:02AM +0200, Sebastian Reichel wrote:
Hi, Sebastian:
> Hi,
> 
> On Thu, Aug 14, 2025 at 03:31:07PM +0800, cy_huang@richtek.com wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> > 
> > Add support for RT9756 smart cap divider charger.
> > 
> > The RT9759 is a high efficiency and high charge current charger. The
> > maximum charge current is up to 8A. It integrates a dual-phase charge
> > pump core with ADC monitoring.
> > 
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> 
> Sorry for the delay. This looks mostly good, but I really don't like
> the custom properties for the battery voltage and current. Instead
> of handling via custom properties, register a second power_supply
> device with POWER_SUPPLY_TYPE_BATTERY and use the normal 
> POWER_SUPPLY_PROP_VOLTAGE_NOW and POWER_SUPPLY_PROP_CURRENT_NOW
> properties. Having custom properties for the watchdog and the
> operating mode is fine with me, as these two things are quite
> specific to the RT9756 chips.
> 
> While you are at it, you can also add this constant property for
> the battery device:
> 
> POWER_SUPPLY_PROP_TECHNOLOGY = POWER_SUPPLY_TECHNOLOGY_LION
> 
> Also the charger's power_supply_config should set the
> .supplied_to, listing the battery device, so that the kernel
> is aware of the link between those two devices.
> 
Essentianly, these two attributes are only used for battery monitoring
from charger side perspective.

As you know, RT9756 is a charger, not fuelgauge. To register a second
power supply seems weird. If what you cares is the keyword 'battery',
I can change it to 'vout'. What do you think?

Regards,
ChiYuan.
> Greetings,
> 
> -- Sebastian

