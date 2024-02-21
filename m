Return-Path: <linux-pm+bounces-4212-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB93C85EB6A
	for <lists+linux-pm@lfdr.de>; Wed, 21 Feb 2024 22:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E81FE283220
	for <lists+linux-pm@lfdr.de>; Wed, 21 Feb 2024 21:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14521272A9;
	Wed, 21 Feb 2024 21:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZ/k9Eke"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AADF10953;
	Wed, 21 Feb 2024 21:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708552440; cv=none; b=mwWaAtxla8Sl5YJeIfEc4NsMBIwrK+SWQfLzpxFyvCB8KC8t+UL7kUX4IoB01D9vqZDHZbYtR9EJMB6geRlzL5GDOdnzk6dUU5kYfjoDi6w5+EMWsNI56mZ+reXn0XbSarsaXaxPMoHJzbtoQPJQgQB8uZWwYw2p4pZ/aS+lMzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708552440; c=relaxed/simple;
	bh=4yH6g5tamOusVbcyW0SRdI3swoDz3DS9OYnuqNk6+z8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eo6gfBZyckemM9lceXhxOT44oR2qX2MyqLdMcyYLOArqfbXRuMIeZr6yVbVrDcUIBmxNLDcnoMZSKJL1CHn+8fvAxwU32jUBqkr8inl5g/N+i3+adKXLf4qsK+sn5QScl3GBGl5xmrKBpG1odsdUxuujR8vIke9dzhiZbAaPqeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZ/k9Eke; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33d8b14715bso21802f8f.0;
        Wed, 21 Feb 2024 13:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708552437; x=1709157237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFRJDpPchYGhggcYn82/GAyKEim/RW8WyZ7494NwPio=;
        b=QZ/k9EkeIah1Cwzc8ayVELADFfkm3VdeDnAYJnJSRyb4BsJLPp/DsEtVreRZVqxqfF
         FjbllVU+A9FtG78mNT50KRNmy0YoMmz8pPrUoTD9GRwZ0/jSspR2h7EqPPsXRg1M7KES
         5QJcygVtoXEjWkK8MdS41OKSxXiogrTT2OJn7EUAO9EPEmMcxnZ280WUpY0tOC+0SG9s
         qYD9yxRncz2yEIFHHasNgVwyMzYY1ct/qEqUbvn+aCoghN4s3JDqxKmKU19Pw5WuL4Ar
         TZyRpXZzxgu5s6XiiOkVsI8ruCD8fuKeMW3Orqcswlz/BuLi/e/E+N5kfYfHf/wIKQ/X
         DJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708552437; x=1709157237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFRJDpPchYGhggcYn82/GAyKEim/RW8WyZ7494NwPio=;
        b=HFaXmgXe6YwOKLWDZFq2z+XFKCoSBQ/G98pwoUR1rduGCv9SKsaOXPGl2ip+JfY4N5
         2kgv3+ZMy7nvFrJHQjQCj4WyHkm1NN7yilwYXqZ0Q/krsOYYcs0YghP3mTXYYcsojSFa
         +b35rrM4+LxSHDStVPvcRXlMlqFAdiZ+adXeVRBqLc4ckm427PmfBmy2p4V/naNDLI/q
         c2ys/GT0YnlJKDeIsRb71Ue7Yg1sZWaqw38e1PkhPqA7rafqCq2dPLeteXuGgo6Lh3Sz
         j5HNPD+uc1vIi2LB/PuYDXyLD4ZW0PII9D2rKRzF337U8czs5x9DXKvQnO+nlz0Ar4Qt
         ftcA==
X-Forwarded-Encrypted: i=1; AJvYcCUZnVEarpJtE9nlQGV008vTm9iaYY8zuv1kpsPPNY0hk6cS19A7vhTHZ75jc42t8Z1YQzDmDPP5JjkTJu9alc3Vs0vrr0LJ/NgnsWn0Fbxu0lBjJENJ8QGB7J3O5GpsEtIj9wE2
X-Gm-Message-State: AOJu0YxFr/WBXQOZH/dCRS94VDFFu8Zrbl4+45UsTE0RVW4XSMHeODyq
	FIKVEpmv6sAqE1CUEKD5Ats+XckE5w0RfCj3O7ihzyvtf2AA/KI/nXVw8WN4bEs7Etd3/hSul3N
	cfgrJM+BVoU74bIsm73hOquH41pQ=
X-Google-Smtp-Source: AGHT+IHV55akNwFuAIFfQvhZOuT8lK5D89kMCL3mGgzrAcnXttcgmEDXvmr7PnYnEg/aTKh3F7l+YPToHA0Ndcz8jzo=
X-Received: by 2002:a05:6000:71b:b0:33d:32f7:c85 with SMTP id
 bs27-20020a056000071b00b0033d32f70c85mr8694215wrb.0.1708552437408; Wed, 21
 Feb 2024 13:53:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219153639.179814-1-andre.przywara@arm.com> <13c957a9-6021-46a7-9243-b3658c26a333@linaro.org>
In-Reply-To: <13c957a9-6021-46a7-9243-b3658c26a333@linaro.org>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Wed, 21 Feb 2024 13:53:30 -0800
Message-ID: <CA+E=qVeMnQNrT8tNnHBnCL2Efy3VjbRAYQGMXstziCThRsiBDw@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] add support for H616 thermal system
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Andre Przywara <andre.przywara@arm.com>, Yangtao Li <tiny.windzz@gmail.com>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Martin Botka <martin.botka@somainline.org>, Maksim Kiselev <bigunclemax@gmail.com>, 
	Bob McChesney <bob@electricworry.net>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 5:43=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 19/02/2024 16:36, Andre Przywara wrote:
> > Hi,
> >
> > this is v5 of this series originally by Martin, only some cosmetic
> > changes this time, for instance  mentioning experiments with the SRAM
> > controller registers to confirm that it's not an SRAM region which fixe=
s
> > the temperature reporting issue.
> > See the Changelog below for more details.
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > This series introduces support for the thermal sensors in the Allwinner
> > H616 SoCs, which includes its siblings H618 and T507. The actual
> > temperature reading turns out to be very similar to the H6 SoC, just
> > with support for two more sensors. One nasty complication is caused
> > by reports about temperatures above 200C, which are related to the
> > firmware being run (because the vendor U-Boot contains a hack avoiding
> > this problem). Some investigation and digging in BSP code later
> > we identified that bit 16 in register 0x3000000 (SYS_CFG) needs to be
> > cleared for the raw temperature register values to contain reasonable
> > values.
> > To achieve this, patch 1/7 exports this very register from the already
> > existing SRAM/syscon device. Patch 5/7 then adds code to the thermal
> > driver to find that device via a new DT property, and query its regmap
> > to clear bit 16 in there.
> > Patch 4/7 reworks the existing H6 calibration function to become
> > compatible with the H616, many thanks to Maksim for figuring this out.
> > This makes the actual enablement patch 6/7 very easy.
> >
> > The rest of the patches are straightforward and build on Martin's
> > original work, with some simplifications, resulting in more code sharin=
g.
> >
> > Please have a look!
>
> Thanks for the detailed explanation.
>
> I'm willing to pick the patches 1-6 and let the last one to go through
> the allwinner tree.
>
> However I need the blessing from the different designed maintainers for
> the thermal driver and from the sunxi_sram

For sun8i_thermal:

Acked-by: Vasily Khoruzhick <anarsoul@gmail.com>

> Thanks
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>

