Return-Path: <linux-pm+bounces-37375-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8235AC32182
	for <lists+linux-pm@lfdr.de>; Tue, 04 Nov 2025 17:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D8273BF703
	for <lists+linux-pm@lfdr.de>; Tue,  4 Nov 2025 16:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E76433344C;
	Tue,  4 Nov 2025 16:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dgukZ9Wt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A02D1946C8
	for <linux-pm@vger.kernel.org>; Tue,  4 Nov 2025 16:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762274069; cv=none; b=peyVU0A6ninZbmQw7Fis8ywKG0AXsmfRpztUxNHb0taJiKebz8XRFfG93IM1/xYEU9bZ4ribI97IiZefszvs5aGDcFGrm9mElTnh2Xh2NNSUwLBdNDwwOo8djl8YKYeNHCN2OVlUiXM8YLF51R5qySA5WTO6aOmLbIBA25lSJRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762274069; c=relaxed/simple;
	bh=K0YyegNjV3CrpjVAJkKYS2lK+2AdnL3qhw0eEMQppNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MT0+s8qsmcy1FbAnYmJsBtGwChwV29DMQM5iXXfndMvaUaIxtIProCYfmvLh3jtD7qul2SAWMtiFrPNM7yJJ99IsTfVS/BmSs48iF5YlWqf/34cTcVwPG4llOE0xfwYCrCbQo59bnjI/AyrbSm0TrCEfn4v7TVSK2lEXRCy0VIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dgukZ9Wt; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-63e393c49f1so5257146d50.0
        for <linux-pm@vger.kernel.org>; Tue, 04 Nov 2025 08:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762274067; x=1762878867; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZURaLbDo3dwoVqwyM02ToCv5MutkNZmPeTZy84rbNEQ=;
        b=dgukZ9WtimTXIEowesZB5thCKlLVP3GbkE05sE4lrkuNRASQOoqFXPl71pfCBbaHAN
         6LC91WExLd++ugRZJCUyLBCULNIVgHKqNaCibUjCS5EvvdGacpMxLrmztnEYWT2i+NV5
         fS4iha/okSN/8/h0t76wL+nQmi5gqZQ65ICFZD/fF+2r0bZ0dZe6OkjlSZjh83k75eOY
         46CnfYCYK0iK+XOI91eMD6UkFHWCsSlV2id7oRjBRuifD6n6KHhF9AfOS1GQV/Jsg4Cw
         E56r43rMCDPwAGlHyAMJ7F7E/s07Z2NWqVQTYOmhUwwVTn4MpSq2U/7QYmA4AXYDxVnj
         slIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762274067; x=1762878867;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZURaLbDo3dwoVqwyM02ToCv5MutkNZmPeTZy84rbNEQ=;
        b=P/NLGPqOasPqKeVkFq4ZRjBt6VgBrZY5gIs3yaCBUdwqPnuWyLc4aPVSCKx+N7kwr5
         AgPSQ78HriDZHS/eLIJlvtxe50WDIZ2u9omHiG3efBVnTZKEz8vZGFStRRHJ+3c+8Nxb
         wRWhNs9iNaqAklqGt0R7KSgaqXH2zApHmti/vgi3S0F0CvDM/WAnfxkRsJ/lVfmzwfl3
         pV7UmHAj4yvQYjSKoJZH9vIrO43JYn02Oab+54xAc73kGcF3KBNhZP4n55f4Sg26uAWH
         0/xx9U2I994Yi5VqYKjO3rAqhLnt7LU7b98C3WKOoHjpxg8clEZiHWAxiC2TZ3Unx/Mx
         XxXg==
X-Forwarded-Encrypted: i=1; AJvYcCXGi/uP2df65qRnIRaDcPBg/wznuZ0A1TmApc/JjkOHjhOmRgTnyEJ/WjxkWzvI4ygRNqLkD3opLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc3/mb2GZfgcWRmcGHXuj7wF9r47h+dle45NYbIMdDBK7uIp0z
	rWyW3PsXEfa+sShty4U943kDEcbahuRGi4K6TIbcz2/cW+8uW89KYj+CezF/YQcL3Da5b5d6gif
	DJET+WAzeN+FOVr96Ev6uaDTzk9b9GfxMNpI8XgUugMqz/Liak+PrbTk=
X-Gm-Gg: ASbGncvM6yfc9guPkm36Q6f75HMlgFNk/P5cw8mUl0LLao4Glrs/BkP2s/aQ09WaWMA
	fPesbWXm9WSal71uH3JmCwSJya/AEfVmV4A1Klwhjeu0tbKxnayM3KEDIXJyge635e3h/Mbhykq
	b7ehhAuur3K73uitiu7345zDV1ueL2iy7GswrhaW4g1u3QSkaVSV5tuRxUiNQtbs/lCR77JCt2q
	U6szvNdV1KUTXtj+gzErp4QGxYklP4J4EcWnmPDCU8amFQSyHxU6msbC9vOCQ==
X-Google-Smtp-Source: AGHT+IGVTYPjRbvY2dc+1i1hVKSl6/mUpbt8rBD57n2a05T5582PeM1IiJduGFBi48QQYI8y525MVnCW3dK3LdtTGiE=
X-Received: by 2002:a05:690e:419b:b0:63f:c10e:6401 with SMTP id
 956f58d0204a3-63fd358fe2bmr57363d50.59.1762274067017; Tue, 04 Nov 2025
 08:34:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030-mfg-mailbox-dep-v1-1-8a8c591aff27@collabora.com>
In-Reply-To: <20251030-mfg-mailbox-dep-v1-1-8a8c591aff27@collabora.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 4 Nov 2025 17:33:50 +0100
X-Gm-Features: AWmQ_blVz8oV6Q800iTY_FXK63-gujrHnWpwcZPlwshpI-BtZsgfevwVde_Zipk
Message-ID: <CAPDyKFrJdN_6FyyjMrfNCKwXt6kFPEPAxcuosdasoxtbJHk2GA@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: mediatek: mtk-mfg: select MAILBOX in Kconfig
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, kernel@collabora.com, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 Oct 2025 at 14:17, Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
>
> The mtk-mfg pmdomain driver calls common mailbox framework functions. If
> the common mailbox framework is not selected in the kernel's
> configuration, the build runs into a linker error, as the symbols are
> absent.
>
> The hardware mailbox Kconfig system, MAILBOX, has no dependencies of its
> own. It's therefore safe to "select" it rather than use "depend on".
>
> Declare this "select" dependency in the Kconfig for the driver.
>
> Fixes: 1ff1f0db6aec ("pmdomain: mediatek: Add support for MFlexGraphics")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202510301311.TcOCnZ1s-lkp@intel.com/
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> I assume this can be squashed into the mtk-mfg driver addition commit of
> the maintainer that merged it.
> ---
>  drivers/pmdomain/mediatek/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pmdomain/mediatek/Kconfig b/drivers/pmdomain/mediatek/Kconfig
> index b06aaa9690f0..8923e6516441 100644
> --- a/drivers/pmdomain/mediatek/Kconfig
> +++ b/drivers/pmdomain/mediatek/Kconfig
> @@ -32,6 +32,7 @@ config MTK_MFG_PM_DOMAIN
>         depends on PM
>         depends on OF
>         depends on COMMON_CLK
> +       select MAILBOX
>         select PM_GENERIC_DOMAINS
>         imply MTK_GPUEB_MBOX
>         help
>
> ---
> base-commit: d78b0fee454c25d292fb6343253eca06d7634fd9
> change-id: 20251030-mfg-mailbox-dep-ec32ef510e6a
>
> Best regards,
> --
> Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
>

