Return-Path: <linux-pm+bounces-29042-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE75ADFD1B
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 07:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3145717A501
	for <lists+linux-pm@lfdr.de>; Thu, 19 Jun 2025 05:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3C523D2BB;
	Thu, 19 Jun 2025 05:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLzVJl/M"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197427080D;
	Thu, 19 Jun 2025 05:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750311930; cv=none; b=TX9I1JQNjhMoSU39wsE2uf6ZglqLzxanI5zdnx3zZ1rdqcENMo0MqgrBk9Qi1AGMdWwwSCLxIwKx0GnS1FP7VEnIBmsJNGGmRE5OiBpfbEYGNdSbpkVBRauD7+TEcFsBZcUpATUB7zgIdJD17gRU+87hSMjX7mjNdfaXNQNwTyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750311930; c=relaxed/simple;
	bh=StMOoUU/VLe2CORNpqWRPlFdSO6J0UEZgGp+57km/8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y1KGFKvT79eNYfb7O9iwBJCebkQjxK6XdA+6Er1dqgWor79smuCSXRT9k2dzM0tPkRNI3pv5Lp55C52GcaPxqvxS4t5frldZ8h+Q4a154rp0Oi08FrjEG1wN8IUj1nRykmvPN9iEMtVdgCci8eeGEZkbCclT4w0WWuSetQmz7Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLzVJl/M; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ad89c32a7b5so56246266b.2;
        Wed, 18 Jun 2025 22:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750311927; x=1750916727; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hI3ZZc6ZIfeQWRhkKtoqqhZ+/gqSR8tSQPrVMAH9qpQ=;
        b=YLzVJl/Ms8oBRlPvuXNIgofuHQqWMgw59sd6v8B+dvVnJuqNsANSlH5nRkNctHlb78
         TxJ8fmUCUIOVMJLt7oaj5INb1WnFjS0AhrW4Z65mzTLhh7oaFbqNHOxgqs9QvA4hZMPS
         u1Ml6PS5+MXwumVCIKGY5RISYkSvVOZqW6IcFLnn7zw6fu4yV7yzb/+sOiAGR+36o0H6
         W89eUBJYl+6ZKiTHbleCvCrMa4J2Y3MDpZo5qTCjOCTlGemMfrH47+KbXoiXd+EW5gmn
         QGTwRQn7V/s4HMS0QAe4SElpHVtfZCzdyTK/+U7QBops204+cDUJ/aG1teqxpdu4+k0h
         Mxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750311927; x=1750916727;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hI3ZZc6ZIfeQWRhkKtoqqhZ+/gqSR8tSQPrVMAH9qpQ=;
        b=qZOOEfmWuMfhLU0Y4/M7732rcHy4AGvLF6bXW1brNstrAVG2MUQlqbauswG8xGvwcX
         HxauZhxGK3/sWaelBJkqaWASbnU0non2ocXZuYF1XG/AeCq1pnjZafJfVvdzU26FEqgr
         yf+GXnssAE80AU+73WrhZx++49PCAAVuyP/eMbsjj1x0dszZJanE3s0Yt3wO6l2YKz7B
         K2u0TPBYQDP5jzYnk5cT9aSsSx0qw9oDZHNG2NtKnCitx8t8tmstnTfsPGo8tvGVavar
         Mx+zZf7UOdfihi7HWGuULTgaYOL5vvQwBbv9ezmzvIGlphgOGMf4H8RKROfTDMzFxxAM
         3HtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUz0IDLJ8tbvtp0Re+5JTOvroQMqG556lnzmmncSHsxLFVvD0UHFsq9yUqyuOAWuKVj+kP8FZuP5SuruHQ=@vger.kernel.org, AJvYcCWomaAcwZ+RUIbLl4kBgfzCwsFvyCgpTxEeIPSJeAA5lgW1C8UZv4ghZLCalxPFRwZRBaVsiYPI/GAGXR0/BYr9R7o=@vger.kernel.org, AJvYcCXXMT9imp0bofOAEaj91TMSI7rw48xrMQ8gN1JWe/eWFIn4/3oOIXTkJjgAPksIzjBdi+FvnDL/QzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrHA4oQ20FrNjD15wz5eZ637RKE9myKzeJisKrbOehIcZdmdRS
	LbwNR11i0cPBjlYdnVdQ0Kg3FFrYhV15OJp8e7tQt/5T83jRhL6mEMOMyjZrLC+QXFOV720+KpD
	Nbmw/AhFVEFPVM5j5ngERLqrqHXyik5I=
X-Gm-Gg: ASbGncvCpd6Z/IlasTNxD8r7Rt4orCCOiPS7mgjWgoBNPLAS1TpPgKgXAKYTGCDdcWP
	jK/ygvkc/50TAYJSA3G4DM1R2GvylCZNIXmkb6kb+uJExjXaxNx5nbq5CMCxkAVv4t4VreeXOqH
	dSSCGRYIstDNr/OCxzk7rhunl34TbYIqmBUQSz6/WCrQ==
X-Google-Smtp-Source: AGHT+IGFg/QouhetKCeGlm2hpPOaEv9iGS/ZDHM9GFWAidTxlUSQGJypUzbVDg2JCtPaYb7KWe7s2hBaEa3XMYsvQxg=
X-Received: by 2002:a17:906:c109:b0:ad8:9e80:6bc6 with SMTP id
 a640c23a62f3a-adfad32dcd3mr1803340566b.22.1750311927097; Wed, 18 Jun 2025
 22:45:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250618125812eucas1p11a1ab5210d4efa95a51b3bc7c4f0924d@eucas1p1.samsung.com>
 <20250616163831.8138-2-linux.amoon@gmail.com> <20250618125806.2260184-1-m.majewski2@samsung.com>
In-Reply-To: <20250618125806.2260184-1-m.majewski2@samsung.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 19 Jun 2025 11:15:09 +0530
X-Gm-Features: AX0GCFtoTWQv-WPpIoBPQ69MBoxGVOjhzrs9aOAgkXxAX0olEdrXbf4tn774ZnA
Message-ID: <CANAwSgQ-NFBtUareFmRzNVuKTSC8Vp7HTA0psBqYu2r=aqAGxg@mail.gmail.com>
Subject: Re: [RRC v1 1/3] thermal/drivers/exynos: Remove unused base_second
 mapping and references
To: Mateusz Majewski <m.majewski2@samsung.com>
Cc: alim.akhtar@samsung.com, bzolnier@gmail.com, daniel.lezcano@linaro.org, 
	krzk@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org, 
	rui.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"

Hi Mateusz,

On Wed, 18 Jun 2025 at 18:28, Mateusz Majewski <m.majewski2@samsung.com> wrote:
>
> >       /* On exynos5420 the triminfo register is in the shared space */
> > -     if (data->soc == SOC_ARCH_EXYNOS5420_TRIMINFO)
> > -             trim_info = readl(data->base_second + EXYNOS_TMU_REG_TRIMINFO);
> > -     else
> > +     if (data->soc == SOC_ARCH_EXYNOS5420 ||
> > +                     data->soc == SOC_ARCH_EXYNOS5420_TRIMINFO) {
> >               trim_info = readl(data->base + EXYNOS_TMU_REG_TRIMINFO);
> > -
> > -     sanitize_temp_error(data, trim_info);
> > +             sanitize_temp_error(data, trim_info);
> > +     }
>
> If I understand correctly, this means that the triminfo will no longer
> be read on other SoCs calling this function (3250, 4412, 5250, 5260). Is
> this intended?
>
Thanks for your feedback.
I will remove the data->soc check for Exynos5420 in the next patch.

> By the way, are we sure that data->base_second really is unnecessary?
> According to the bindings documentation (in
> Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml),
> the different address is necessary because the triminfo registers are
> misplaced on 5420.

As per my Exynos5422 user manual and DTS mapping
thermal-sensor tmu@10060000 is mapped to CPU0 with tmu_apbif clock
thermal-sensor tmu@10064000 is mapped to CPU1 with tmu_apbif clock
thermal-sensor tmu@10068000 is mapped to CPU2 with tmu_apbif clock
thermal-sensor tmu@1006c000 is mapped to CPU3 with tmu_apbif clock
thermal-sensor tmu@100a0000 is mapped to GPU with tmu_triminfo_apbif clock.

Well, we are using tmu_triminfo_apbif to configure clk_sec, which is
using the data->base to enable the clk.
So, data->base_second is not used any further in the code after we set triminfo
>
> Thank you,
> Mateusz Majewski

Thanks
Anand

