Return-Path: <linux-pm+bounces-16214-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D8B9AA0EF
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 13:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A0941C22144
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 11:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD14819ABBF;
	Tue, 22 Oct 2024 11:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ut+NdWpx"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B1E19AA5F
	for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 11:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729595686; cv=none; b=i4UVOSUcr2hr5mD2lIF06Z7XOyhnK9UWyoajA2rkoVd+FlW4sgY+HwkixuWy2bFnrAq33yWYJAJMddrFgkGZmc+8q2MSLIgp+u1Sq+WYM5urwcszs8NmM7E+4Dmbp2Ah/w05dlLAxM4FlXKzWV0yfWLfUfHRz5RfnLUet1Vt5P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729595686; c=relaxed/simple;
	bh=Nqbq6HVlCD/pyon59zbflZXy/veJIQ3UwY03iuf6S/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FRc+yVscgpAOJeycgJfcd0NzXj7I86HmDJufin/73RA2e6l2MHbXnr/IAafC6Lnl2Mxj6IX9JyoYnIUHRV1OdvbrXJEWv+MWFpcAhOZBANk9sRwHOC13qYOYtkmbnabUxLWCuF35NA6JbRanKtCWRagLPy0j97JUPWY1GhrFcJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ut+NdWpx; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e29267b4dc4so5049731276.0
        for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 04:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729595684; x=1730200484; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0lIW4Wb18nTyhM0bbi98WhNBwSHn7JFubcRs4dz0PzM=;
        b=ut+NdWpxIB1/j7BSDdabsGDVi4alX1RpCKaQPk+inlmzDP24aOxtfqhS+RuXukXLz4
         gSDLNBbk3oc90vO1y6DKBtrIxvTvNYRVAWmr0Yo18GQtzp+JCC6GKx3ekrwUyDP40xDV
         RYDJIQWKJToNw87azqYzbPbarjufsuILYzbKmNjHEN2MkE+XyCciYd0W25qel6pthT0f
         B8+j5n7EsSZn4iUtgyl/GPZHAqKbOxXx1gKrRmEeH1T7aGKT607QDG5Hw+r85XSOhDR4
         /4nnANlZa27eAoJSWHIY0TMwsoGc7FRlsjzk5DOXKly/Zumd/SpK6hrZ27f7vz4RTrJ0
         0woQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729595684; x=1730200484;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0lIW4Wb18nTyhM0bbi98WhNBwSHn7JFubcRs4dz0PzM=;
        b=AtqvQz9Y2dQulmUd2L1LCue2D/u5Yi6X2xB3cUw2wFpmYdBgXzlGRyQkt4wiCEE2Dn
         s4PmCBYCzOg7/TqtZdXA6DA7++gECLH0wFiUO6qJnaGhTPtenE9DgSrNMXSSn458KwPW
         pdaRVvRg0qHIU3x7ZkU8CCLEOaUgKjoCqTVxS/6qJENVWO8wKGqWJP3ZkXgD5ex7xVTY
         59C4L6wIPaeZIm0UHelu0aZ4aqF+ANI7uT6BocK+o4MSd2ATcPEDqYWhPq/Oo5kGQU1o
         jMK0AGvXnj/q7BhFijQ2YN8e893YEQRRTBDQaI+o7nrziowY7RIHl+U6Pv9Bjp+aojbd
         QpGA==
X-Forwarded-Encrypted: i=1; AJvYcCUxk78xXFsQ4+9eHSFQ2B59OwOqkGMvOYH+R22g+wE1Es/d4WBjo9H8apeeR67JVM6qldkaiEdRAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyO6/e7lwlwZN+R0qwXIPwf+w11G3P2mi+IJ/ZDTtGtJiVwa5o4
	IWmWMi3WcteRPWjb5+W3h85KdDdatYfj8xpG0Hmo4vtHaSxZdUE7OP+bK0X2h/SIzNs+Y1840Jz
	LWjTBdYjzqzR9/9F0V419gdhBP5tGaHOxpqxC5A==
X-Google-Smtp-Source: AGHT+IFpse40o4X8e1WY4RLX2IO8eNJPCGg/k4PLRJOFjrePcxo0X9oUrn9Lc5Wix32KzQ4Lv5WuGRPtSxG1lG0RICc=
X-Received: by 2002:a05:6902:2b06:b0:e2b:db9c:5366 with SMTP id
 3f1490d57ef6-e2bdb9c5505mr7783762276.37.1729595684226; Tue, 22 Oct 2024
 04:14:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017085136.68053-1-y.oudjana@protonmail.com>
In-Reply-To: <20241017085136.68053-1-y.oudjana@protonmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 22 Oct 2024 13:14:08 +0200
Message-ID: <CAPDyKFqck_0vwNVLzAubHArF2XH_S5pWNwPOfFkom1pPE0hoVg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] MediaTek MT6735 SCPSYS support
To: Yassine Oudjana <yassine.oudjana@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Alexandre Mergnat <amergnat@baylibre.com>, Fabien Parent <fparent@baylibre.com>, 
	Markus Schneider-Pargmann <msp@baylibre.com>, Alexandre Bailon <abailon@baylibre.com>, 
	Chen-Yu Tsai <wenst@chromium.org>, Eugen Hristev <eugen.hristev@collabora.com>, 
	MandyJH Liu <mandyjh.liu@mediatek.com>, Yassine Oudjana <y.oudjana@protonmail.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 17 Oct 2024 at 10:51, Yassine Oudjana <yassine.oudjana@gmail.com> wrote:
>
> From: Yassine Oudjana <y.oudjana@protonmail.com>
>
> These patches are part of a larger effort to support the MT6735 SoC family in
> mainline Linux. More patches (unsent or sent and pending review or revision)
> can be found here[1].
>
> This series adds support for most SCPSYS power domains on MT6735. See patches
> for details.
>
> Changes since v2:
> - Rename DT bindings header to mediatek,mt6735-power-controller.h
> - Remove comment citing header from DT bindings
> Changes since v1:
> - Squash DT binding patches
> - Dual-licence DT binding as GPL/BSD
> - Switch to mtk-pm-domains driver
> - Add MFG bus protection bit
>
> [1] https://gitlab.com/mt6735-mainline/linux/-/commits/mt6735-staging
>
> Yassine Oudjana (2):
>   dt-bindings: power: Add binding for MediaTek MT6735 power controller
>   soc: mediatek: pm-domains: Add support for MT6735
>
>  .../power/mediatek,power-controller.yaml      |  1 +
>  .../bindings/soc/mediatek/scpsys.txt          |  1 +
>  drivers/pmdomain/mediatek/mt6735-pm-domains.h | 96 +++++++++++++++++++
>  drivers/pmdomain/mediatek/mtk-pm-domains.c    |  5 +
>  drivers/pmdomain/mediatek/mtk-pm-domains.h    |  2 +
>  .../power/mediatek,mt6735-power-controller.h  | 14 +++
>  include/linux/soc/mediatek/infracfg.h         |  5 +
>  7 files changed, 124 insertions(+)
>  create mode 100644 drivers/pmdomain/mediatek/mt6735-pm-domains.h
>  create mode 100644 include/dt-bindings/power/mediatek,mt6735-power-controller.h
>

Applied for next, thanks!

While applying I took the liberty to change the prefix of patch 2 into
"pmdomain: mediatek".

Kind regards
Uffe

