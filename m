Return-Path: <linux-pm+bounces-9229-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3089098AF
	for <lists+linux-pm@lfdr.de>; Sat, 15 Jun 2024 16:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55E7F1C20D0B
	for <lists+linux-pm@lfdr.de>; Sat, 15 Jun 2024 14:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B7231A8F;
	Sat, 15 Jun 2024 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uoT0Ppcl"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1A01DFD2;
	Sat, 15 Jun 2024 14:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718462630; cv=none; b=McVHNdpAzJFmFcELkyJRE3CneOgS84ReslC4kbr7WWAjF9pDfRTf3x+3TZdSbtdlPgooItBUwTGOvSl9NZCNjlZtlVf1rpvFhki7lqYjpnKJcP/CvgYLNy3AoYZXW96iSR+Xiy4V/0c3FOa2yCj3TzDEE29vWd7JedbRXfGRGJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718462630; c=relaxed/simple;
	bh=8RJiP7FCS0sZfvR0laSimR4Ji9IM/l5QeRHx0jchhYg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyiiPKTq2AwDPKqJQRNKQ1ahxZE+ruWxciKdQ3tD3Cl9BtTNPAZcGxPh1Yo9Jr+Z72qfBPIw4PKAo4zVbClIDzvILdDB4HYL/XL7Ip1zS4QWRYDk0psskS9EIRUHRZXmje+oj9I1dehxQQLDIhOO7z+Lr6k5mkm73Vc7b9f5z7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uoT0Ppcl; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45FEhhBR001041;
	Sat, 15 Jun 2024 09:43:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718462623;
	bh=ZyID5zbcPnMF1p3meO7TvGheIaJkcI0vPW1j4oZrrTo=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=uoT0PpclgzKfRb3UTM6Iss229Y4eOow6uMDmwMgAYgFj/ILc5wbL1UC3OotfhsII7
	 K+GBAhqJbfEay9OeNFvdlSQiHfQaq2nsRt7Z4jdF1MuoovWp7K/9MMoevQBpmiDOky
	 PJUpRMVTqoT+ysyxe9PPHYYuMJNOjKohcomXOgC0=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45FEhheE128645
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 15 Jun 2024 09:43:43 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 15
 Jun 2024 09:43:42 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 15 Jun 2024 09:43:42 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45FEhgaZ022894;
	Sat, 15 Jun 2024 09:43:42 -0500
Date: Sat, 15 Jun 2024 09:43:42 -0500
From: Bryan Brattlof <bb@ti.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar
	<viresh.kumar@linaro.org>, Lee Jones <lee@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Vibhore Vardhan
	<vibhore@ti.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 3/5] dt-bindings: mfd: syscon: add TI's opp table
 compatible
Message-ID: <20240615144342.5gjgp3rt3ewfbfu2@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20240612-ti-opp-updates-v2-0-422b6747a254@ti.com>
 <20240612-ti-opp-updates-v2-3-422b6747a254@ti.com>
 <faf04961-f8ac-446c-a558-42ef6e98b3ac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <faf04961-f8ac-446c-a558-42ef6e98b3ac@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On June 13, 2024 thus sayeth Krzysztof Kozlowski:
> On 13/06/2024 01:17, Bryan Brattlof wrote:
> > The JTAG_USER_ID_USERCODE efuse address, which is located inside the
> > WKUP_CTRL_MMR0 range holds information to identify the speed grades of
> > various components on TI's K3 SoCs. Add a compatible to allow the
> > cpufreq driver to obtain the data to limit the maximum frequency for the
> > CPUs under Linux control.
> > 
> > Signed-off-by: Bryan Brattlof <bb@ti.com>
> > ---
> >  Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> > index 7ed12a938baa3..ab1fcbe2148f7 100644
> > --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> > @@ -88,6 +88,7 @@ properties:
> >                - rockchip,rv1126-qos
> >                - starfive,jh7100-sysmain
> >                - ti,am62-usb-phy-ctrl
> > +              - ti,am62-opp-efuse-table
> 
> These are ordered alphabetically.
> 

Ha! I guess I don't know how to spell after all :)

~Bryan

