Return-Path: <linux-pm+bounces-35020-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 931D5B88C2D
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 12:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5128A4E0348
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 10:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4182D8393;
	Fri, 19 Sep 2025 10:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="PURFcqWF"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309AC2BEC2A;
	Fri, 19 Sep 2025 10:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758276572; cv=pass; b=RPVpnEssMfIZ+as1OmZ+XVx252sDPZYGwb0p2vst5RmlU3ZG78ZuBB/KZCsrKg6wf+Vr7H7dIsJw/bJEUSqsYGAmNgEVPcIgbOt2sb4tzZIqGc+5KGihcIVqh2EcTqyal9B6fvDbRDjhlRBMBwgX4qg/lw+fjELw1pGgwGqFQCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758276572; c=relaxed/simple;
	bh=hWIJFFgeIQPHspi4bQeADU9yEctBXMeZmyiinjylEpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nG4MLcwEIFv+wxr66NWkRx5OXlrpnzu5V6kRs/H3fGLrQRZCsotPSv33cbp5qAoi73NsRuM0A7nlkcMXNIF6HORMa1DfTmqxE9fk57THIjj7RxASBlFUljacN+S0V8iJfQ5EkYNZ4E0bTdMMR9qJLrWyzDVjMhw4Bly1PkZVN6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=PURFcqWF; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1758276537; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dicK+OMv5QSBObbMGKfy67NokELvGMR5Dt3pkAgFCwmR0HW+On81ioV7ohXumzVu/eaQM7UXvhHA7W4ZNe2BV4j1TpZuh0liTGx8qdsl5T9qvUKxhaEsRjWIGKa6aIqonpMrf1p4wECVjV9nfmHdkdh0XsC1p6gxjfSe1mMLeog=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758276537; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7bikftOXJFrKd3xRGDKSA0neTFb/TpOhRE/473mVa+k=; 
	b=k7x7q+WrdnAYmBcNentlAQJjvI1RD35H4m7uNM+Cy16elyxAilArii+RRx0qMZbxWaiSZc26nJXty4iU/NNSWhUR2kJxfpjJ0EIDG92VjSXSY063L93Piu7wLot6YN3uG7UgWZWhsyyFumQF532RBWuA8ovV0c144ZYxLQJ0Bw8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758276537;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=7bikftOXJFrKd3xRGDKSA0neTFb/TpOhRE/473mVa+k=;
	b=PURFcqWFKfQGye1p389YNk/IIuiOGIj3TXvOyo0vc3xrmKkCfgrEwlwYhmtvcq+H
	F9MIqfFjz87qRiLlB9XmBgGAv/7nDL78Ith2SlFaf+pRAQNbpFFpiTBlUajOZzuJroW
	ylq0yngeWq6e8rOwe+JNbAJfbNFC4n5v9iy/sPIg=
Received: by mx.zohomail.com with SMTPS id 1758276534307344.4153529447631;
	Fri, 19 Sep 2025 03:08:54 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Jassi Brar <jassisinghbrar@gmail.com>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Chia-I Wu <olvaffe@gmail.com>, Chen-Yu Tsai <wenst@chromium.org>,
 kernel@collabora.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org
Subject:
 Re: [PATCH v3 01/10] dt-bindings: gpu: mali-valhall-csf: add
 mediatek,mt8196-mali variant
Date: Fri, 19 Sep 2025 12:08:45 +0200
Message-ID: <6970929.lOV4Wx5bFT@workhorse>
In-Reply-To: <c210de74-6eb5-40a4-b87d-a4a5c3123e65@kernel.org>
References:
 <20250917-mt8196-gpufreq-v3-0-c4ede4b4399e@collabora.com>
 <5749727.31r3eYUQgx@workhorse>
 <c210de74-6eb5-40a4-b87d-a4a5c3123e65@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Friday, 19 September 2025 06:28:54 Central European Summer Time Krzysztof Kozlowski wrote:
> On 18/09/2025 23:01, Nicolas Frattaroli wrote:
> > On Thursday, 18 September 2025 02:30:09 Central European Summer Time Krzysztof Kozlowski wrote:
> >> On Wed, Sep 17, 2025 at 02:22:32PM +0200, Nicolas Frattaroli wrote:
> >>> The Mali-based GPU on the MediaTek MT8196 SoC uses a separate MCU to
> >>> control the power and frequency of the GPU.
> >>>
> >>> It lets us omit the OPP tables from the device tree, as those can now be
> >>> enumerated at runtime from the MCU. It also means the mali GPU node
> >>> described in this binding does not have any clocks in this case, as all
> >>> clock control is delegated to the MCU.
> >>>
> >>> Add the mediatek,mt8196-mali compatible, and a performance-domains
> >>> property which points to the MCU's device tree node in this case. It's
> >>> required on mt8196 devices.
> >>>
> >>> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> >>> ---
> >>>  .../bindings/gpu/arm,mali-valhall-csf.yaml         | 32 ++++++++++++++++++++--
> >>>  1 file changed, 30 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
> >>> index 7ad5a3ffc5f5c753322eda9e74cc65de89d11c73..ccab2dd0ea852187e3ab75923e19739622b2b3b8 100644
> >>> --- a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
> >>> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
> >>> @@ -38,7 +38,6 @@ properties:
> >>>        - const: gpu
> >>>  
> >>>    clocks:
> >>> -    minItems: 1
> >>
> >> I don't understand why.
> >>
> >> Best regards,
> >> Krzysztof
> >>
> >>
> > 
> > I am executing a Convex hull algorithm on the 3D space of "dt-bindings
> > maintainer opinions" to get a convex hull of acceptable dt-bindings
> > choices where two different choices are functionally equivalent.
> > 
> > With this additional opinion on the krzk axis, I now know that having
> > the base properties accurate for the general case is not required if
> > the per-compatible case sets the property to false anyway.
> > 
> > I hope no two opinions are collinear, as this would surely be my
> > undoing.
> > 
> > You get to pick which axis (X, Y, Z) you are. Right-hand rule, of
> > course.
> 
> 
> This piece of code is wrong and I could not deduce the reason. That's
> why I asked why you need that change. If you intend to waste my time, I
> will don't bother with this, but code is still wrong.
> 
> Best regards,
> Krzysztof
> 

The previous reply was in jest, I did not know that this was incorrect.
That's because it has no effect; there is no option for a bare
`arm,mali-valhall-csf` compatible with no other compatible preceding
it right now as far as I can parse the binding (which in of itself
seems wrong.) So minItems: 1 didn't do anything, because the RK3588
compatible would override it anyway, and the mt8196 compatible would
disable the property entirely.

Hence, this piece of code is not wrong, as it's functionally
equivalent to what was already there. Unless that is my reasoning
is erroneous, in which case I'd appreciate an explanation for how
it is wrong, rather than having to argue why I think you think
wrongly that it is wrong.

Kind regards,
Nicolas Frattaroli



