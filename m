Return-Path: <linux-pm+bounces-12054-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F14F294D563
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 19:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC9D3282AA2
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 17:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B7B4D8AD;
	Fri,  9 Aug 2024 17:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="Hi/QJeSM"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9349B14F70;
	Fri,  9 Aug 2024 17:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723224386; cv=pass; b=AptnPjM/aYlNWMCdn0QcOM07NP2/VNvLrkJSy5KBdXSqy4K54baFhf73Poo4sDkPzDcEUwX8z37k8radj/ulmeiXsg6ViIvRycfkceYb42e2ffcJOCBJwdqiTKDyb5P/iyLv4h1US4jt46X66wOpU8fwCkrvH3QH7OKmFWAwMao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723224386; c=relaxed/simple;
	bh=gIsbDqSuaUfGJi7NYRIeUHylwOZj9S28wR+BNU+1whE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dL7Ucun6EYSgOiaK1lPaUff5Ul09DUul3pZK/413C/Cp7CLbutv15RfFYUD5rb5XMHjFxVhVo+bEDtLRup9a2HcBsa+p4f50OCcIbNebQwF7m/E1PZRB4fGtj9ffH/bQM5XM/r7yIdGJQoclAwPaNURJIQQhYc9MHL3hjxxzlGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=Hi/QJeSM; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723224360; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iQBBvpC8vMJ99e7tPEJeC1lrhmU+/jexmlTqOoZ+995lMWieOIKa/s5uDT9qXsjWf8zbCmSTshziCVldb3YGDNMPxPMCC0CxD2wiBS8K25JTJrCAXZwkk4g5S9llOyHhQ3ieDE5XPC2cv/hU9G/MRT0893l3SFiUXLzMRBYzXHk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723224360; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=MlUROrStYAoAJMglAHXmhXbY9RBE077SVTGfqsg6ysY=; 
	b=R/1KB4AjFWPrhfm0PTCJmc1udbrhIScvCEelUDcMcAN+K95GEIVQe3Mef0ESN7xBXHeUo8BemfLOUk58A4+TPj1NrlynxjrdunusR6icUouuOE6cQwUCl5q8WOv+nfFz62/zRas73EE9RVYdmW2MbubJwl4hSet+q++ohPR8phs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723224360;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=MlUROrStYAoAJMglAHXmhXbY9RBE077SVTGfqsg6ysY=;
	b=Hi/QJeSMAgrDib/xF0r0jqeTdhA/dx5DYQRYIqiN/kKk+tEj7N40lK5lSGQbz/I7
	xHJcJty4BTWS/oGygqhUnh38BJdmcvM0nZI5oLrGMTqTSxWYIcylKqxhckllaCcdZsc
	KbfRapariThTbf4Rm3Wung1JlRuwJyV/mMimDmNY=
Received: by mx.zohomail.com with SMTPS id 1723224359034870.4612231906191;
	Fri, 9 Aug 2024 10:25:59 -0700 (PDT)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: Conor Dooley <conor@kernel.org>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Ulf Hansson <ulf.hansson@linaro.org>,
 Finley Xiao <finley.xiao@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>,
 Arnd Bergmann <arnd@arndb.de>, Elaine Zhang <zhangqing@rock-chips.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org,
 kernel@collabora.com
Subject: Re: [PATCH v2 1/2] dt-bindings: power: Add support for RK3576 SoC
Date: Fri, 09 Aug 2024 13:27:18 -0400
Message-ID: <2276665.iZASKD2KPV@trenzalore>
In-Reply-To: <20240809-constant-oxidize-8aed145179c7@spud>
References:
 <20240808163451.80750-1-detlev.casanova@collabora.com>
 <20240808163451.80750-2-detlev.casanova@collabora.com>
 <20240809-constant-oxidize-8aed145179c7@spud>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-ZohoMailClient: External

On Friday, 9 August 2024 10:59:58 EDT Conor Dooley wrote:
> On Thu, Aug 08, 2024 at 12:31:04PM -0400, Detlev Casanova wrote:
> > From: Finley Xiao <finley.xiao@rock-chips.com>
> > 
> > Define power domain IDs as described in the TRM and add compatible for
> > rockchip,rk3576-power-controller
> > 
> > Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> > [reword, add yaml]
> 
> To be honest, both here and in your other patch, you should remove this
> [] section and add a co-develop-ed-by instead.

That seems to be used quite often though, I like how it gives an idea of what 
has been adapted from downstream patches.

> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
> > Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> > ---
> > 
> >  .../power/rockchip,power-controller.yaml      |  1 +
> >  .../dt-bindings/power/rockchip,rk3576-power.h | 30 +++++++++++++++++++
> >  2 files changed, 31 insertions(+)
> >  create mode 100644 include/dt-bindings/power/rockchip,rk3576-power.h
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
> > b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
> > index 0d5e999a58f1b..650dc0aae6f51 100644
> > ---
> > a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
> > +++
> > b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml> 
> > @@ -41,6 +41,7 @@ properties:
> >        - rockchip,rk3368-power-controller
> >        - rockchip,rk3399-power-controller
> >        - rockchip,rk3568-power-controller
> > 
> > +      - rockchip,rk3576-power-controller
> > 
> >        - rockchip,rk3588-power-controller
> >        - rockchip,rv1126-power-controller
> > 
> > diff --git a/include/dt-bindings/power/rockchip,rk3576-power.h
> > b/include/dt-bindings/power/rockchip,rk3576-power.h new file mode 100644
> > index 0000000000000..324a056aa8512
> > --- /dev/null
> > +++ b/include/dt-bindings/power/rockchip,rk3576-power.h
> > @@ -0,0 +1,30 @@
> > +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> > +#ifndef __DT_BINDINGS_POWER_RK3576_POWER_H__
> > +#define __DT_BINDINGS_POWER_RK3576_POWER_H__
> > +
> > +/* VD_NPU */
> > +#define RK3576_PD_NPU		0
> > +#define RK3576_PD_NPUTOP	1
> > +#define RK3576_PD_NPU0		2
> > +#define RK3576_PD_NPU1		3
> > +
> > +/* VD_GPU */
> > +#define RK3576_PD_GPU		4
> > +
> > +/* VD_LOGIC */
> > +#define RK3576_PD_NVM		5
> > +#define RK3576_PD_SDGMAC	6
> > +#define RK3576_PD_USB		7
> > +#define RK3576_PD_PHP		8
> > +#define RK3576_PD_SUBPHP	9
> > +#define RK3576_PD_AUDIO		10
> > +#define RK3576_PD_VEPU0		11
> > +#define RK3576_PD_VEPU1		12
> > +#define RK3576_PD_VPU		13
> > +#define RK3576_PD_VDEC		14
> > +#define RK3576_PD_VI		15
> > +#define RK3576_PD_VO0		16
> > +#define RK3576_PD_VO1		17
> > +#define RK3576_PD_VOP		18
> > +
> > +#endif





