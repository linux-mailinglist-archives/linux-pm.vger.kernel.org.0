Return-Path: <linux-pm+bounces-36999-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A59B5C17CA7
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 02:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C1F940414F
	for <lists+linux-pm@lfdr.de>; Wed, 29 Oct 2025 01:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AC82D8767;
	Wed, 29 Oct 2025 01:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="ZO99G+x3";
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="qLnEqdio"
X-Original-To: linux-pm@vger.kernel.org
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD8B1A5B9E;
	Wed, 29 Oct 2025 01:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700310; cv=none; b=WsEqYlk06a5zuttDwzPUQL/6hSnlSM/dXe/8aUT/+lO7qoKYPcBFhcINrhO+9lsI608lxG/dW8cJ8na68qZxa9eDTl7HVTveY/NbOCwojPC1f9Vx/lznEV8PYTNggHPLYLUQEBp2rVA9IKo1PB4lejf1MGKHWJHbJeP13Hud0ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700310; c=relaxed/simple;
	bh=HEVP5pJVSu/NFi9c5YqUEUuNnptViTfI445gGp6oJAQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYbj7vQWz8jDYBXNGITDQFuNBBEs2W9l/V31qCpxMdh1TkQFQnhAlIvRmgafek2SIMEdOtVlrqJHYjAeIRrUbkeT5Ym070rNWYxfYfU5xwGPhMoTsrgOcpTCeITWI9BWWFTVXujDrJ/lLQB5Is5zJl3RUHT65TkapRH3cIGRST4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=ZO99G+x3; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=qLnEqdio; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1761700305;
	bh=/kYXnlcjTx2RptL/+pUQVYtHYYa379gM+kIJaewL2Es=; l=1996;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=ZO99G+x3tRgNqJ6Jo+MKI4/DJZ+/1Xv+g9hj/vnvUrv328/DPaS3oBpogt9LLiki8
	 W0PTZ723U8r5pt40Plkcm125qdaVX+LJvqoqoQs12KObb285uF0bB0LnID6Y4eP3Kn
	 2PyCoaP2oNXsVUsHR9D270bKbmrsAs0FNpKiNGbslqiP3+QIA9xe7cAAkvRMWm5PF8
	 NbrVKlsD7YCYH51v/VZ2M87ic9oRxn1aUqnuCPYD+NLkUCQ8Voe+w4tqmEc3IEeRNn
	 juVJTkugHSQ5cFP8jEv5zovOy3BiH1FtFn0bHxmdQbmPlyofO6LNDVP56wIwhgQn5Y
	 Hl4A+VLRgmJCw==
Received: from 192.168.8.21
	by mg.richtek.com with MailGates ESMTP Server V3.0(1128079:0:AUTH_RELAY)
	(envelope-from <prvs=13948D43A7=cy_huang@richtek.com>); Wed, 29 Oct 2025 09:11:39 +0800 (CST)
X-MailGates: (compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1761700299;
	bh=/kYXnlcjTx2RptL/+pUQVYtHYYa379gM+kIJaewL2Es=; l=1996;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=qLnEqdioJ2zMYwoehJW5khnXeRgFTKH3/qL7vkeyS5FA/fDA+M9aPZHTp9UYZTzaw
	 n/eZzyFthCeckmIs3rn1NweIoUg3vN9RqbnNdpqBBwD2uvS/SwdhPuZEVprsTJ3pJQ
	 2jARaIWmM5TG7qLYbUyDfbzgdI9PtqlfCrZ1YPSPn1kA20CP+sJFPVN1YSu+FRRdRA
	 1J7Mt9riiy8LET7pHZakBz0Ha6rMeeCtqp63a42SymOPzHUah/qsZ57uoi2+RAkezq
	 onb2qCWrJpsRgTPgHUKmE0TD5YD4h9doYEhqyxZ9sXUpW6nkY/kjjQYcrf/QKBDn+j
	 dYcor5NBpQX5A==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3436935:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Wed, 29 Oct 2025 09:03:27 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.26; Wed, 29 Oct
 2025 09:03:27 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1748.26 via Frontend
 Transport; Wed, 29 Oct 2025 09:03:27 +0800
Date: Wed, 29 Oct 2025 09:05:00 +0800
From: ChiYuan Huang <cy_huang@richtek.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND v2 2/3] power: supply: rt9756: Add Richtek RT9756
 smart cap divider charger
Message-ID: <aQFoPKXDx2BfalXE@git-send.richtek.com>
References: <cover.1755154950.git.cy_huang@richtek.com>
 <2bceb1be91e8841cd373c1d04f0a79d88c888dd8.1755154950.git.cy_huang@richtek.com>
 <uarjdpyemkqnwneoj6kdj7vfzzllbqmsurjnsjr5hkujao6thx@2ysih3s7mftj>
 <aM0UBoynaX7ln2Tw@git-send.richtek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aM0UBoynaX7ln2Tw@git-send.richtek.com>

On Fri, Sep 19, 2025 at 04:27:50PM +0800, ChiYuan Huang wrote:
> On Fri, Sep 19, 2025 at 01:43:02AM +0200, Sebastian Reichel wrote:
> Hi, Sebastian:
> > Hi,
> > 
> > On Thu, Aug 14, 2025 at 03:31:07PM +0800, cy_huang@richtek.com wrote:
> > > From: ChiYuan Huang <cy_huang@richtek.com>
> > > 
> > > Add support for RT9756 smart cap divider charger.
> > > 
> > > The RT9759 is a high efficiency and high charge current charger. The
> > > maximum charge current is up to 8A. It integrates a dual-phase charge
> > > pump core with ADC monitoring.
> > > 
> > > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > > ---
> > 
> > Sorry for the delay. This looks mostly good, but I really don't like
> > the custom properties for the battery voltage and current. Instead
> > of handling via custom properties, register a second power_supply
> > device with POWER_SUPPLY_TYPE_BATTERY and use the normal 
> > POWER_SUPPLY_PROP_VOLTAGE_NOW and POWER_SUPPLY_PROP_CURRENT_NOW
> > properties. Having custom properties for the watchdog and the
> > operating mode is fine with me, as these two things are quite
> > specific to the RT9756 chips.
> > 
> > While you are at it, you can also add this constant property for
> > the battery device:
> > 
> > POWER_SUPPLY_PROP_TECHNOLOGY = POWER_SUPPLY_TECHNOLOGY_LION
> > 
> > Also the charger's power_supply_config should set the
> > .supplied_to, listing the battery device, so that the kernel
> > is aware of the link between those two devices.
> > 
> Essentianly, these two attributes are only used for battery monitoring
> from charger side perspective.
> 
> As you know, RT9756 is a charger, not fuelgauge. To register a second
> power supply seems weird. If what you cares is the keyword 'battery',
> I can change it to 'vout'. What do you think?

Since there's no reply for this discussion, I already followed your suggestion
for the next revision.

Thx.
> 
> Regards,
> ChiYuan.
> > Greetings,
> > 
> > -- Sebastian

