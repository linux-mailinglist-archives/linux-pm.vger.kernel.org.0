Return-Path: <linux-pm+bounces-34963-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60031B84F27
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 16:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE97D7A2FE6
	for <lists+linux-pm@lfdr.de>; Thu, 18 Sep 2025 14:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4778E21FF23;
	Thu, 18 Sep 2025 14:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="hAogMFSP"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0D4212566;
	Thu, 18 Sep 2025 14:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758204140; cv=pass; b=PL3EP3JhqdkpyfJZG3oxyHORnqEF+/zlqpOJNfNYi3LewNMRQvI+hFvzcQqrtOtYadwQhIMDCD4sOb6r3xySiysdekriiJlvn9EhHtmnH5pBR8Ws+jiidz3BkfPwuvCRqLH8l5rVdkm2TNXB0kYRI3q265X9LobDbAWNNF7KWBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758204140; c=relaxed/simple;
	bh=B5K/UPnWupbru9h0H9/zvNShGLKsQiiUktaCENK/6U8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HphNDWLOa9MFCD6zMZEKhGaawc40hkdXbNmkscqIkOkkRsN9a9jDNv1a4eKYyTx6s10tf4Egm3WqSUHbJEncF0Q0JFGU6eOon3nW29zvkubbelmr7yN16USWZqxEWt9qI52e66a3NfJG/9No7BFlHrWuJtBHcwjWWUfgtLLp/zA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=hAogMFSP; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1758204103; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nYwqjkuaJd7z0MOkUp0DgfN53CXjxJ8VD6pq4qgAghNfmvnA3vgnX5pK17ASOg1fr82DmoBQiEwzoIcEOU0kMcH/IXTOc3x4mOmsA1BE4UWokJ5VwMw3JbW0UIGi57KnolqmBLNbrQF08F9nxwd01FMcbj6E2CAqV15MVEGLk+s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758204103; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=D+h5guwEJBXYPr6x/4BoU3yk32WsocIYZRObOc2SD7E=; 
	b=Cu5B0fFQGxjhlexh70bmK9sj0JsAbY8IHD9Sn6ukiIq6IIBUQ85Y7OgndtebASrN5nnDV54v8AUXQIN3AwUH8rQQhSs12nsRNRvVSOr+hsO/WCgXWFyUGK+tUKLwuoRVNCCi35FZC0QANVXWBuJVQoja3ApO8EM2o7hXGv3cCVM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758204103;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=D+h5guwEJBXYPr6x/4BoU3yk32WsocIYZRObOc2SD7E=;
	b=hAogMFSPwKq/tEvbgDxEAdbZWwp+FACMmjl1d2HM2d9ucBx6Nct3HTBzQRdCcPX3
	Q14+J4hiqYfWRQ+3mZzqx1+2bVa9ts2cpR1a2MFl28notvkZLDxQ8Zk3A2H/iVa1V7j
	vMYYWOob+ruYusn+fJBEnGV4TP2+rk+mU3Mntpco=
Received: by mx.zohomail.com with SMTPS id 1758204100007491.1116048037495;
	Thu, 18 Sep 2025 07:01:40 -0700 (PDT)
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
Date: Thu, 18 Sep 2025 16:01:31 +0200
Message-ID: <5749727.31r3eYUQgx@workhorse>
In-Reply-To: <20250918-festive-chowchow-of-joy-5a51de@kuoka>
References:
 <20250917-mt8196-gpufreq-v3-0-c4ede4b4399e@collabora.com>
 <20250917-mt8196-gpufreq-v3-1-c4ede4b4399e@collabora.com>
 <20250918-festive-chowchow-of-joy-5a51de@kuoka>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Thursday, 18 September 2025 02:30:09 Central European Summer Time Krzysztof Kozlowski wrote:
> On Wed, Sep 17, 2025 at 02:22:32PM +0200, Nicolas Frattaroli wrote:
> > The Mali-based GPU on the MediaTek MT8196 SoC uses a separate MCU to
> > control the power and frequency of the GPU.
> > 
> > It lets us omit the OPP tables from the device tree, as those can now be
> > enumerated at runtime from the MCU. It also means the mali GPU node
> > described in this binding does not have any clocks in this case, as all
> > clock control is delegated to the MCU.
> > 
> > Add the mediatek,mt8196-mali compatible, and a performance-domains
> > property which points to the MCU's device tree node in this case. It's
> > required on mt8196 devices.
> > 
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > ---
> >  .../bindings/gpu/arm,mali-valhall-csf.yaml         | 32 ++++++++++++++++++++--
> >  1 file changed, 30 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
> > index 7ad5a3ffc5f5c753322eda9e74cc65de89d11c73..ccab2dd0ea852187e3ab75923e19739622b2b3b8 100644
> > --- a/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
> > +++ b/Documentation/devicetree/bindings/gpu/arm,mali-valhall-csf.yaml
> > @@ -38,7 +38,6 @@ properties:
> >        - const: gpu
> >  
> >    clocks:
> > -    minItems: 1
> 
> I don't understand why.
> 
> Best regards,
> Krzysztof
> 
> 

I am executing a Convex hull algorithm on the 3D space of "dt-bindings
maintainer opinions" to get a convex hull of acceptable dt-bindings
choices where two different choices are functionally equivalent.

With this additional opinion on the krzk axis, I now know that having
the base properties accurate for the general case is not required if
the per-compatible case sets the property to false anyway.

I hope no two opinions are collinear, as this would surely be my
undoing.

You get to pick which axis (X, Y, Z) you are. Right-hand rule, of
course.

Kind regards,
Nicolas Frattaroli



