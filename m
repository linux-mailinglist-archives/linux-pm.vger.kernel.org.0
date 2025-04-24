Return-Path: <linux-pm+bounces-26138-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E6AA9B4C0
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 18:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE3D95A79B5
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 16:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D42288CA1;
	Thu, 24 Apr 2025 16:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BELN2Xlj"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724AA2820D2
	for <linux-pm@vger.kernel.org>; Thu, 24 Apr 2025 16:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745513860; cv=none; b=ahwRuea5zdNLf0/m+H4IsKXsWWUhn36+Nzi/09+Ktnepp38QsDDGnS/hc6XKf0sIAWQYAYaAR7vkNKu3yfgqkm4umFku1iqL5Sw1D1UWR+TRRWod7BFSjZ2Gb3X9UKyLi41sgNbBdbHvJAvzcdhxn3V7cfV03lui0f2UWo8mA8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745513860; c=relaxed/simple;
	bh=hS6YdVyjaOxJfdDNyVfmlBPQQSzKuRq4dxje6DjD3Jg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MIITjej/lYXF9X/RY+W1PyMk2lh4iyo90SDAvRzBFZ75KfU7CTVu+qvuEJz6yRxmTxcP7Fgjbo+DT5rs8MJdK4w/IzH5kT9zC+XpcxHHxYqMttReZXxnPf9tuM1eU6YNcLCx02Abtlehv3knupLDRIZcg+vOZ7vmzNWbXPe0Kw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BELN2Xlj; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e6cea43bb31so1115478276.0
        for <linux-pm@vger.kernel.org>; Thu, 24 Apr 2025 09:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745513857; x=1746118657; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XMDqtfSsgswAHK2zMki+icWH9z9g6NMe+d35IYgU6n4=;
        b=BELN2XljavDZtosWC9tWlOifhW73t+TMCc+khWL/dze/lq2mIlef3Wiw2V2VOKfJln
         6h/Uu/nyyGHXWyiFh0VfBCJDQdGY6KzQ/WBgrIKcYKQ2KZiVGJjdHCKVAXk4qhQEf3wT
         vXkCn4QTHXa++N/Y8s7u7+VMNdbIM6uW69rlloBxeWcu8FJKO+x9nLPfPVWoGhyvbwzI
         hhv/hVyQZRud32Hl7CyB1kHaW1wzBedoVi7BOcOaKmiLxFujQ6qwetcqtHu9PZ/PiZae
         UFZYfQnPCx+qSQykZbRYD+R0dgS/HvVg+b73btWWpUd22S80299TICTu+t70VmI5tTFT
         fJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745513857; x=1746118657;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XMDqtfSsgswAHK2zMki+icWH9z9g6NMe+d35IYgU6n4=;
        b=KM3H5d5/fneuk6F7j2wYJyhFGLKfiRNrjPS4YzQHRBfSrh+J+yEWzDwjgycZxEGKBh
         tjDyGzYjfZg5W6FshOyLln/xEiBTXciK8o7ceyIitRbEtAS5cIPiTgay36Q+nxa1OU/c
         gkWocU2UHFXqaDfVoKyQ97zya/1EFSeH0IPYef6A8m4AJkNj6KfGEDbFJ1bwezM1lWM2
         G75WUuzYoYe4DPYhaKnQgVGtk7i7/aowZZdvDxMYFaxbn8lBmXp0c6if+CWZt3jKbDVu
         pOZRbHMAn5W1UBueXDiJPSgyNzErqIp5j9Z354lV7TaARq+uZU9FwHqcODtMNr0wmcn+
         gjFw==
X-Forwarded-Encrypted: i=1; AJvYcCVJSdwu8jZyNMnQogA5+qMfA0jAmvfqKjb4ze/tAqS64ba05yDyvYF0xMnzbBw8rqY8tfKcrcDALQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yye/6CNOR+5sjHVce+uM8IfmP5kMeCeM15KRR+rJDne0t6d9XDP
	3iLpeFqd6z47pR9zBHGe/8Mttweol+msHOt1+0E1hF61nW0Nq0gKktmghtidArm7xc5cJncI9B1
	yuwgAwdywDhvQTf289mVzb2z/peWXdiJAK7CMTg==
X-Gm-Gg: ASbGnct7YlUWlJCzk+fgbSzTs6+nNTJitUBP/qKohmHiTjfsh26IIkpVk0b13JWtL2J
	aFHiuxmFwFWQv8dRTIZ12xWucfovXHVsbGs23tU/Hg1EgkbbKFPWAUO0CuHrCm48JsmK1UtAkN3
	2Fbyo6Yv5C4/PY6Rgsih1Duu4=
X-Google-Smtp-Source: AGHT+IHIsM0JcIVkaYurwu7Xm76aeWCRBd2kXA94L1zA7HY4+kXgxndqZ0iWhzKWJZRbPN5Psmgt3hk6PaDxQyb1LIo=
X-Received: by 2002:a05:6902:13ce:b0:e6d:ecfc:2328 with SMTP id
 3f1490d57ef6-e73034f04f0mr5006786276.3.1745513857331; Thu, 24 Apr 2025
 09:57:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410143944.475773-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250410143944.475773-1-angelogioacchino.delregno@collabora.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 24 Apr 2025 18:57:01 +0200
X-Gm-Features: ATxdqUG-Jb1AZR77fk7uAdSggUmnOFrjqf9oHFUx6Q2HN7mjbQy7Up3T4KB7Soo
Message-ID: <CAPDyKFob2wB=stDXLPG0VG7mBso4Hid32pXpMvaP6WPbL0SyEA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] MediaTek Dimensity 1200 - Add Power Domains support
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	matthias.bgg@gmail.com, fshao@chromium.org, y.oudjana@protonmail.com, 
	wenst@chromium.org, lihongbo22@huawei.com, mandyjh.liu@mediatek.com, 
	mbrugger@suse.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 10 Apr 2025 at 16:39, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> In preparation for adding basic support for the OnePlus Nord 2 5G
> DN2103 smartphone, this series adds support for the power domains
> (MTCMOS) of the MediaTek Dimensity 1200 (MT6893) SoC.
>
> AngeloGioacchino Del Regno (3):
>   dt-bindings: power: mediatek: Support Dimensity 1200 MT6893 MTCMOS
>   pmdomain: mediatek: Bump maximum bus protect data array elements
>   pmdomain: mediatek: Add support for Dimensity 1200 MT6893
>
>  .../power/mediatek,power-controller.yaml      |   2 +
>  drivers/pmdomain/mediatek/mt6893-pm-domains.h | 585 ++++++++++++++++++
>  drivers/pmdomain/mediatek/mtk-pm-domains.c    |   5 +
>  drivers/pmdomain/mediatek/mtk-pm-domains.h    |   2 +-
>  .../dt-bindings/power/mediatek,mt6893-power.h |  35 ++
>  5 files changed, 628 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/pmdomain/mediatek/mt6893-pm-domains.h
>  create mode 100644 include/dt-bindings/power/mediatek,mt6893-power.h
>
> --
> 2.49.0
>

Applied for next, thanks!

Kind regards
Uffe

