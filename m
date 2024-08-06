Return-Path: <linux-pm+bounces-11952-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AF69495A0
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2024 18:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 351031C2130B
	for <lists+linux-pm@lfdr.de>; Tue,  6 Aug 2024 16:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C220F3A268;
	Tue,  6 Aug 2024 16:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="AqFJDYCd"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD982C182;
	Tue,  6 Aug 2024 16:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722962031; cv=pass; b=LlSZPGKKEZoQDd1C0nxe1sh+jSfj4K6C15aOAADgLAwzT7+vJGCDFqiIRvpgxbd3/yjznAa3oT/WTQtbzqCOG/za/3YITc2PN4UOLHW1PCiWg1Kb84qZDJfbN8vNSYDtwtNptvagewGcalNx5I97NThwgFvoDgptyi2SBMHZqlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722962031; c=relaxed/simple;
	bh=puiEd1SRm3ADc828HACBfKNH+QKdUIB7UI3diIKs2AA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IHwpMHVRcBoTmQx16ezizbI68nUnFobbKrX/E92WInnfyaw53PWq7VWyCmaLxmqU3KMKoczg1/6XdahN4Itawszkiv4YEOTiGorHnODhAGZrCUgvdz7eDpdge0OnmaXfTqSR2pmuF1xjYF6n8FAQfNAiRGb7nhBL0iAHdgvTx1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=AqFJDYCd; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1722962010; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nVmjkx2NYYfGexWUTXG6+br7K+/tYNcm2BTNaHP0pmFRRUF6ugYmgQNdE1Z4TgZeOsBp4IWtKiRsYRVcx4LkEdgW5NMOcFdNYbTecmOXjMHwkj1saTbQw/ng9eOW0VYI7I9+0R3Xa0qXjOLqYMnRZAmrgi5gzUp/2gUkgllXlLc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1722962010; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=l/JHjYFYD5hXu+XbGOm+SC68og+CQ6amBp7xMsiP/Lo=; 
	b=CsIS/Zd0X+HOmXOqsWJsKqIQT07/9srdSQNwHL6RoqLJaMD9Y7UgQFJDZlOIfmDqWpuGwgErLkyLoDibyGeJbGBU4/MH4oUSKMRMUfT3DV8t98XX8dQFQcQEUv5AgtcB6RaxxkM77B4O7oCmvoyML5/04OYGhINcMrEJWljfpwI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1722962010;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=l/JHjYFYD5hXu+XbGOm+SC68og+CQ6amBp7xMsiP/Lo=;
	b=AqFJDYCdobJ60Kpe/ZGzSVKMoNEWj3yVbIBcC+9Q5Pm9KxZG5CRvJ6KdXceQzpe0
	oTPRGkOL6pPFlfJdmaHXdCx6ZHWo1MpTI8HyNji7wYzk/OsF9zTgIQ861Gn/BzZk1Gc
	TNyFVoh6ilAbmNIrlRYMu/halSDBLbAqVtm76XCE=
Received: by mx.zohomail.com with SMTPS id 1722962009873809.7480289049981;
	Tue, 6 Aug 2024 09:33:29 -0700 (PDT)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Finley Xiao <finley.xiao@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>,
 Elaine Zhang <zhangqing@rock-chips.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: Add power-domain header for RK3576 SoCs
Date: Tue, 06 Aug 2024 12:34:41 -0400
Message-ID: <3310992.44csPzL39Z@trenzalore>
In-Reply-To: <e04258dc-07c4-45c7-90d4-bc1ed9eb100b@kernel.org>
References:
 <20240802151647.294307-1-detlev.casanova@collabora.com>
 <20240802151647.294307-3-detlev.casanova@collabora.com>
 <e04258dc-07c4-45c7-90d4-bc1ed9eb100b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-ZohoMailClient: External

On Sunday, 4 August 2024 05:56:39 EDT Krzysztof Kozlowski wrote:
> On 02/08/2024 17:14, Detlev Casanova wrote:
> > From: Finley Xiao <finley.xiao@rock-chips.com>
> > 
> > Define power domain IDs as described in the TRM.
> 
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching. For bindings, the preferred subjects are
> explained here:
> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patche
> s.html#i-for-patch-submitters
> > Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> > [reword]
> > Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> > ---
> > 
> >  include/dt-bindings/power/rk3576-power.h | 30 ++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> >  create mode 100644 include/dt-bindings/power/rk3576-power.h
> 
> This is part of bindings.
> 
> > diff --git a/include/dt-bindings/power/rk3576-power.h
> > b/include/dt-bindings/power/rk3576-power.h
> Missing vendor prefix. This should be named after compatible.

Looks like all other rockchip power bindings use the include/dt-bindings/
power/rkXXXX.h format. Should I keep that way ?

> > new file mode 100644
> > index 0000000000000..cb33a32c1aed9
> > --- /dev/null
> > +++ b/include/dt-bindings/power/rk3576-power.h
> > @@ -0,0 +1,30 @@
> > +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> 
> Weird license.
> 
> Best regards,
> Krzysztof





