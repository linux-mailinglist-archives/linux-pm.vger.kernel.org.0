Return-Path: <linux-pm+bounces-17093-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EF49BFCC2
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 03:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB9F81C212C3
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2024 02:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC8244C94;
	Thu,  7 Nov 2024 02:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgrRiFhE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765B82746C;
	Thu,  7 Nov 2024 02:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730947853; cv=none; b=DlzCagJMrlnhv12wCDyQcCPFlcXooNxretGyBJpWC00KQlPSC3udTzxrHL7jOB/3L7zQz2ZTwI/l2f8Q/+YCOHSiXZ5UbrxehOLnRSHntW11V94JrgpvqKqCGpRLql0XYlqHS6RYsgKYrA9gyxwwR/7AKa/iGQFiBfGGVeqyNfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730947853; c=relaxed/simple;
	bh=cNwPsuiIyGxQeUIdb617CjxuRvDwe1uwZCuRptONgxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EzhqPXyomg2/MwkFrMUh5yawZmtkEe/BYs8M2gaFOQZ24RXxdn/FPcPeVoxBo6OinE1uMjNK6WXnJ5OPoskCVJ0kWzg2tJbn7Y3ezGQOvWjzRaprhSjF4RwRrmcyqI9P/HmE3dg/B1HLEfxGYdmW/ffUJrtWhv1bIBx43g9d6m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgrRiFhE; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5ebc04d495aso260820eaf.2;
        Wed, 06 Nov 2024 18:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730947851; x=1731552651; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ATfgC0XLRvBm06fDERV6Ea2aikqvpiSPnuP6UzWHmyg=;
        b=MgrRiFhEtolOmv88SjXD8nBREQEIfdqllBvMwSIjNUKOMZ4Fv0PPm4RCtYR8rsU3M+
         5IqR6+c4RX2SVJLob2j3bHRtkEikQ7jgSerfuHF8rg+eQDeUfn3GxA3IJ6wqKM+hfdDY
         ojreZjrYbyVPTwQjv5OooS87H9KkZCJXKARRxquKavKXvCfygkc4mEcZdVBLQ5nXCrqn
         W+JWvhVPZzNoFYPZOUAY1+2kadEu/nvE56yAJvBiWwwD8y7HBQgxcRz24/rCPsOzbM2D
         TjntMSDaO2DhnXC/N4OXUABBbsuGqS1bJ91N0WJoG5F0x1DjgauaU5yL/9f7xJuIBnKu
         u2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730947851; x=1731552651;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ATfgC0XLRvBm06fDERV6Ea2aikqvpiSPnuP6UzWHmyg=;
        b=QwIHmnkDbPTCKIuQ+pzRWMQDOOBPPI3wS2SaBF+GqO6qMeKORjnBV1vxqF70+7rq/V
         ACFDULWCnR0FGXn5ZyL16vI3wWo0jlgURZNH5kgqmquyzHdg++174vV0wXRQa9U94ce2
         9CTKY564it8sqwH1wI5HEqxH+rLwJRFhbSAvd8BnWUBynq79szT3OHh+5BVITPphZHpb
         DnKek2/pjVugdj9W+p/Xf9TsvghTSI3n6nQZk1td+tMGMP/mVeKkv/jQv2dwz4wKYnP2
         1JxqQ69CUHaZi08N/GqG4l5VyBRKpSFKezmDsxVMeizyfmakQX/kB43yPED4Vvb12FFt
         /3aA==
X-Forwarded-Encrypted: i=1; AJvYcCUTalDNFnlhlR0edAFlXZwRuP3eaOKS6nlvlzusmt8F4FBJCgnIhb0lz9LRmd1DH0N7XC0kUJtDPqvd@vger.kernel.org, AJvYcCWfospffdTxiD1qbjOFW4PBoX2UwZuAElB0JAtZR4Xmn0Jbdt9QWLNKqglNNk/ebtGlU56ZG/1SFyU=@vger.kernel.org, AJvYcCXtfB8mxXYGK2Dz6l8Qc/cw/VHVXmJbipez2vZDSgdQUKC/xUmAJpNoElVbbNUiKlqjRBea95mv1sO4ouZa@vger.kernel.org
X-Gm-Message-State: AOJu0YzoQJnLa4u7K3ijw2ToaMWo+q7Dpuk2WLwnjw8l/5el3EhoFifr
	zlPpIOYw4PrsigF0XNtGaGRu93mH6DPBl8FyeX7RzUVN736KGOhLsHCo0Rs39Jiizyb1CnwVH+R
	v2fY/JWRMZ6ze+LKUX4caOvYZCFk=
X-Google-Smtp-Source: AGHT+IHL3m7QA0Uy6taccrukDMm7SpxKN4v3xW2DK80sYwTstNUcojSaxTpgyZJ7ZxwcVu7QNkxKdF9c6CZesXfGNWA=
X-Received: by 2002:a05:6820:1ca2:b0:5eb:b282:5916 with SMTP id
 006d021491bc7-5ec23a8d4c4mr30471047eaf.7.1730947851535; Wed, 06 Nov 2024
 18:50:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730720720.git.stano.jakubek@gmail.com> <f334c973dd4e6390a0cd51dbde358277a07604d7.1730720720.git.stano.jakubek@gmail.com>
In-Reply-To: <f334c973dd4e6390a0cd51dbde358277a07604d7.1730720720.git.stano.jakubek@gmail.com>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Thu, 7 Nov 2024 10:50:15 +0800
Message-ID: <CAAfSe-vdf59GAhCsVZzSYYYpYmhj0eQBDTwLaJnTMVYvFM6Rtw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: power: supply: sc27xx-fg: document
 deprecated bat-detect-gpio
To: Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Nov 2024 at 21:04, Stanislav Jakubek <stano.jakubek@gmail.com> wrote:
>
> While the bindings have always used the correct 'battery-detect-gpios'
> property, the DTS and the Linux driver have been using the incorrect
> 'bat-detect-gpio' property. Document this property and mark it
> as deprecated.
>
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>

Reviewed-by: Chunyan Zhang <zhang.lyra@gmail.com>

Thanks,
Chunyan

> ---
> Changes in V2:
> - new patch
>
>  .../devicetree/bindings/power/supply/sc27xx-fg.yaml          | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.yaml b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.yaml
> index 9108a2841caf..b10f155afe68 100644
> --- a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.yaml
> @@ -27,6 +27,11 @@ properties:
>    battery-detect-gpios:
>      maxItems: 1
>
> +  bat-detect-gpio:
> +    maxItems: 1
> +    deprecated: true
> +    description: use battery-detect-gpios instead
> +
>    interrupts:
>      maxItems: 1
>
> --
> 2.43.0
>

