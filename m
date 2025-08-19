Return-Path: <linux-pm+bounces-32633-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D49ABB2C3A1
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 14:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16D8F1C212A0
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 12:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20620305047;
	Tue, 19 Aug 2025 12:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pAaics+6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866A12C11EF
	for <linux-pm@vger.kernel.org>; Tue, 19 Aug 2025 12:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755606458; cv=none; b=eV6KVRhasp1iZOQ2ZDo7gZ6nsAFMjtfAg9ZDVmhGTtoHYytSubkzo6CKdiSKBjI8Phs4MSvBWugW0C70CmFZc7jJvuPxnpnkvd3lwaKGtDFZ63b+/Si4ilNBgsols7S1CfV0pQytCpOC3kZvruZTekG0lv2kNeZw4HhHAvFz4OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755606458; c=relaxed/simple;
	bh=DUkk+13M+Ynz7MT74/8ZBBYtodYcantx5Rg9z3JTBsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FjbABpk0A2t5PXG2gzXFftGjO67AEOKyXh5B3Lrg8b8R5Sh5t0ITDrSlJhKMWAP+ZQBR2sJfzSkVYlf6kjBuRfSZ/115UdVgAH/FffB05iiVEsx6o6luCLV2BVDF99ByKGA+fvqDAe9t5BkUq6fwjq7ENngfMkA+5c/SVqJ8v6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pAaics+6; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e934c8f9751so2340592276.2
        for <linux-pm@vger.kernel.org>; Tue, 19 Aug 2025 05:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755606454; x=1756211254; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+TPF1YkLiFTNQ8Ccb4IZIqIBMol4u9SbWTxln9EZmwI=;
        b=pAaics+6woih9u8HGrV2sFu6zwET3caftf3nyUjseWKpVppKPEDHQnBTGNCfYsyXlS
         ivWl6x+o/wSjQKvOX+On59lAXgc/wpVGGWpayyAbSOgv1lIdVdkudPN2XixXPx4woWNA
         q+t/8lpDppwpXLLeBMEOJXlcKCQsBXqzyuLV4mE9qb3ABRI+ST2H99EydXsaphDU3fAZ
         p8x8C3I85qv4ZUVXeoy8Rdih7yy6xkeHAuE4zequmEO9DLTQouDMSoFQu4YEsOG2p/c7
         lBkWcqDm/+fyYB9wKbWlB/Zgs2unvC8CZqP93p1sXJqsH/Fw1feUUA56Hho2vyeKpFIl
         R1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755606454; x=1756211254;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+TPF1YkLiFTNQ8Ccb4IZIqIBMol4u9SbWTxln9EZmwI=;
        b=gU8utWhzMB2zpC4gJkWrOTHQRo892NhxedaX1jFXhEgBLN6DkcTsn3VpBbs5x5IQaq
         62Z8UuN4oV9Km2eohu5Q4Ln0TqfQOwToYJ693BKCZ3zJK+8YebMAmUvsr/ZXceTa3jR3
         C/CSc3rsL6Z5LI5nrzL+0yvtXDRPZxbZprzS+oZ+SYaKFkBQCdRLKFfzm9KuJG0HuMdZ
         GWIJYVtDls0q0krvTmlmRfS+EehIzO0Fq7TNwQwhjTAfawEb8TcoH4IPC9Zdd9TOHWOr
         7Ea3hcsChXrQI3hJLI0oJn5UCpbB4yVOfPr5ffQl8WWy8WF/JchxXof4xO4F3++W5t3A
         9Z3w==
X-Forwarded-Encrypted: i=1; AJvYcCWBifQjUoIAd0x1cFJXwMUBc/mob5Qffv/W6glMWxQ+rZECql6+X4YeLVBLRt7rm3KuF3MX8f9AjA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/FmTWQBfrWVGJxESKL1MFPk2h3SIQdTlHttQFGgbpK/hKU2wm
	gEIJpYpqXEJREZEj4+hqRZmqPFec96X2jiHPlF8KbVhrIBo0n/ZAA9rpP/xEaB3axqwr7O3c+Nh
	9EJ7JO4rsKUWdYqwxdmPWVB68QF7D4APRhi/ZbfVahJU3d8D2rvQV
X-Gm-Gg: ASbGncswzBwJG59Ry/ibQvE1Ze+QfJ0rN0Gp/IZYa1u/3bJkwMSHEmGcMXOXGDqOe8T
	DgPm98WYENVZtRmhEL6auJhIpsj+aQwjHnplV2OYkBQ/3UpSTCY4bFZbzpX99uDvPMysL3RVN+/
	Lf3gh3KmN0Z4P6plw+bM2gUOiaNiMT+MG5kmJZJuZ8yE2A8Kxia8coCZHQ+332rlRtDc9OoAz8t
	bhVul8=
X-Google-Smtp-Source: AGHT+IEIU63/+GYGzAYDue+vg2X97jfjr+a6yrxDRh/QgcS+rLLZW/s7ptzQYuXL0ln6WvL4vzZQWJIIdTviE+KMReQ=
X-Received: by 2002:a05:690c:998e:b0:71f:9c53:bab7 with SMTP id
 00721157ae682-71f9d6aade3mr26181137b3.36.1755606454405; Tue, 19 Aug 2025
 05:27:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813161517.4746-1-wsa+renesas@sang-engineering.com> <20250813161517.4746-15-wsa+renesas@sang-engineering.com>
In-Reply-To: <20250813161517.4746-15-wsa+renesas@sang-engineering.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 19 Aug 2025 14:26:57 +0200
X-Gm-Features: Ac12FXzg8y3bcygw4HHi2EJ5hKpXkHEKEIKi8aknzoMhZGkielH4LokEZOomCVo
Message-ID: <CAPDyKFr=bnDZWmnBauWTZa2-2DNCP2swDJxPT1b_TK8Q2o8sXA@mail.gmail.com>
Subject: Re: [PATCH 14/21] pmdomain: remove unneeded 'fast_io' parameter in regmap_config
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-pm@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Aug 2025 at 18:16, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> When using MMIO with regmap, fast_io is implied. No need to set it
> again.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> No dependencies, can be applied directly to the subsystem tree. Buildbot is
> happy, too.
>
>  drivers/pmdomain/imx/gpc.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
> index f18c7e6e75dd..33991f3c6b55 100644
> --- a/drivers/pmdomain/imx/gpc.c
> +++ b/drivers/pmdomain/imx/gpc.c
> @@ -343,7 +343,6 @@ static const struct regmap_config imx_gpc_regmap_config = {
>         .rd_table = &access_table,
>         .wr_table = &access_table,
>         .max_register = 0x2ac,
> -       .fast_io = true,
>  };
>
>  static struct generic_pm_domain *imx_gpc_onecell_domains[] = {
> --
> 2.47.2
>

