Return-Path: <linux-pm+bounces-30789-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B61B03DE6
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 13:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E050189E58C
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 11:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA79A24728D;
	Mon, 14 Jul 2025 11:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="aj0QdiFV"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD32246BB9;
	Mon, 14 Jul 2025 11:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752494362; cv=pass; b=EHPmUzKuiss/9ivnam7bABUo3Ueb/NMJIAUyWRdVshPuamGD+BCTcDLr3I3u/sg5OmQGkRBEPcMAxckWSSIbGLiLroaTWiX2R6G1iA6HDnep/pPvTlqrF3P7RzoXrjrAY9fu1dbSGSmv0VoU6FQjRqzm1C6SDpmvQ1QWjqov3C4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752494362; c=relaxed/simple;
	bh=tDV9/Q7u6+pOYicayxwt8pwpLClJb9GzCkMGqZQIKxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QIgfucfmydoOYPiaYMPTSWq8uecpJ3k+e2GnWvQOhnInxfn7hAiotqtqVGz2X2RvVHC2KR42w0aToB/eUVilrdIGYOpvb/sDP3a+2KrIbTmGewEAJJFbElWMKNF7UJ20pXuspwzGw2NxynnjNAZhpCOd+VSiK6ufsoti4NxfH6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=aj0QdiFV; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752494332; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iGxMupPycqjxa9mYweKkM1w0s56YuVBdz40VSohqHJ3DXNzUCYRc0iDuCpWhd1e1iQCtv+NNjNDg9xPLYXdOL006E1zaX0LDHjqO8w9yGeXqJe7lKw+DDb3YBdN41kehkm8w1fxfZc1a+NC+/qy+9J8PITBiq2rV+10PPyJxUTA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752494332; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=l+1LS81FGm60dIyP9CaATX2ddHWIPZWWedbPOybtiZA=; 
	b=FOFJails5Ae40soxsPBXDAMaGs6GdcMZ9fthL+58TXmaBHN1pRpOTIby7gN85neyM8wi9quxpIlfq5ly00RUP3SL6TwLmEToc7CTcioKIhaK8V6fvNd7OgDuWphAyIFq+HMJbzE3GZNb+dEmdu8whdIK8oPFuHLyoQA9EWuAGwk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752494332;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=l+1LS81FGm60dIyP9CaATX2ddHWIPZWWedbPOybtiZA=;
	b=aj0QdiFV/CZDv8u7a2xKrN6idNVJH5GSz9novrbYVUgsWiDx/znyr52+XSR2b85x
	hmj6oKZLj+9eTDZAY0wlEAp10Lx86SU71uQzRdkFW+al/wNl2BJ4qfNCPVrUsb0Vfgz
	Cjsqj8X6ekiU7rdpt5mtI9G7NA5CT9t53O457SRI=
Received: by mx.zohomail.com with SMTPS id 1752494328917431.64095668770517;
	Mon, 14 Jul 2025 04:58:48 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Hector Yuan <hector.yuan@mediatek.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: mfd: syscon: Add mt8196 fdvfs syscons
Date: Mon, 14 Jul 2025 13:58:44 +0200
Message-ID: <2866261.BEx9A2HvPv@workhorse>
In-Reply-To: <4537173f-7f79-4629-a2ef-cbf1edd2ed81@collabora.com>
References:
 <20250711-mt8196-cpufreq-v1-0-e1b0a3b4ac61@collabora.com>
 <20250711-mt8196-cpufreq-v1-1-e1b0a3b4ac61@collabora.com>
 <4537173f-7f79-4629-a2ef-cbf1edd2ed81@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Monday, 14 July 2025 10:47:32 Central European Summer Time AngeloGioacchino Del Regno wrote:
> Il 11/07/25 16:57, Nicolas Frattaroli ha scritto:
> > The MT8196 SoC uses two syscon ranges for CPU DVFS that are separate
> > from each other. One, mt8196-fdvfs-config, is used to check for a magic
> > number at that memory address to verify that fdvfs should be used. The
> > other, mt8196-fdvfs, is used to configure the desired frequency for the
> > DVFS controller for each CPU core.
> > 
> 
> What is the reason why you're using syscons here?
> 
> Can't we simply assign the FDVFS MMIO to the cpufreq-hw node?

That would require refactoring the driver way more since it currently
gets the number of performance domains from the number of regs. If
you want me to do that, I'll need to know how we should disambiguate
performance domains from misc things like fdvfs. Stuff like string
comparisons on reg-names seems very ugly for the driver to do, but
adding a property to explicitly specify the number of performance
domains would then put into question what the existing binding did
by just assuming this information is something that implementations
can get without any ambiguity.

Even if we forget that Linux is the only kernel that cares about this
device tree, I'm not totally on board with having the smattering of
dozens of different tiny register ranges in every DT node on mediatek
like the vendor kernel does it. And not to forget, it'd change the
binding even more, to the point where I'd probably have to create a
new binding for mt8196.

> Or is there any reason why we can't declare it as mmio-sram? ...because I'm not
> entirely sure but the FDVFS space should effectively be a [c]SRAM memory range...

mmio-sram is fairly useless for the purposes of having something as
a fixed set of registers, hence why nobody else does it. From my
research, it appears to mainly be used if you want to actually treat
it like a pool of memory from which to then dynamically allocate
things.

To use it like a syscon, which is what we're doing, you'll have to
specify your mmio-sram node, then add a child node as a reserved range
for the "syscon-like" area, and then specify in ranges that you want
that child node's address translated into the global address space as
expected. Then in the driver, you can't just do a single function call
to get some regmap to write into, you have to follow a phandle in your
vendor property pointing to said sram range, then get its address,
translate said address to the global SoC address space, and then iomap
it. And the cleanup for error paths/driver remove isn't fun either.

Besides, we don't actually know whether this is an sram range, or how
large it is. The only confirmed sram range was the csram_sys thing at
like 0x11bc00 which is not used because it turned out to be useless,
and dealing with the kernel's sram interface to use it as a reserved
range just to read 4 bytes from it was a wasted afternoon. And that's
not even the real starting address of that sram area, that's just a
part we know is used because downstream uses 5 KiB there for a codepath
that's dead when fdvfs is present (except the one thing where it installs
a panic handler to shove something into a register to make it stop dvfs
logging if the kernel is in the process of crashing).

I can be convinced to go through the pain of making this mmio-sram if
I have documentation of the whole memory map of the SoC that shows me
where and how large each area of sram is, so that I don't need to come
up with my own starting addresses and offsets based on whatever random
stuff I can infer from downstream DT.

Really, every writable syscon is probably implemented as "sram" in
hardware. But an sram cell that is not general use memory but is
treated by the hardware as having some meaning is not mmio-sram. We
can't ever use it in any way other than as a syscon, and telling
implementations that they can except then slapping a huge reserved
range into it just makes them have to implement syscons twice, once
as syscons and once as syscons-except-it's-a-reserved-sram-mmio-range.

> 
> Cheers,
> Angelo
> 

Kind regards,
Nicolas Frattaroli

> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > ---
> >   Documentation/devicetree/bindings/mfd/syscon.yaml | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> > index 27672adeb1fedb7c81b8ae86c35f4f3b26d5516f..5ee49d2ba0cdb72dd697a0fd71c8416ad4fd2c1e 100644
> > --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> > @@ -88,6 +88,8 @@ select:
> >             - mediatek,mt8135-pctl-a-syscfg
> >             - mediatek,mt8135-pctl-b-syscfg
> >             - mediatek,mt8173-pctl-a-syscfg
> > +          - mediatek,mt8196-fdvfs
> > +          - mediatek,mt8196-fdvfs-config
> >             - mediatek,mt8365-syscfg
> >             - microchip,lan966x-cpu-syscon
> >             - microchip,mpfs-sysreg-scb
> > @@ -194,6 +196,8 @@ properties:
> >             - mediatek,mt8135-pctl-a-syscfg
> >             - mediatek,mt8135-pctl-b-syscfg
> >             - mediatek,mt8173-pctl-a-syscfg
> > +          - mediatek,mt8196-fdvfs
> > +          - mediatek,mt8196-fdvfs-config
> >             - mediatek,mt8365-infracfg-nao
> >             - mediatek,mt8365-syscfg
> >             - microchip,lan966x-cpu-syscon
> > 
> 
> 
> 





