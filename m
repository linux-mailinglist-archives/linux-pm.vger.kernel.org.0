Return-Path: <linux-pm+bounces-38435-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC5BC7FD35
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 11:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 68C62343A29
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 10:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A115221DB3;
	Mon, 24 Nov 2025 10:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yN/MTMQm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412F31419A9
	for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2025 10:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763979397; cv=none; b=Ivs67hcwVqx3oDlxFewYHTLZ1/MT/kd0ebAwYBOkPofQpqtbJHUGeF6IThQXmzYaXNMKFaEw5r8gOA/EAUEfxTjqgrSrlri8NMAehoMmVt1csho7/U6VrkVvfoYfwh4Ox+mTnC04H7ndn4AceXihglccNMNO7G7sqLVRaOmiDvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763979397; c=relaxed/simple;
	bh=p3+Wkeoi+awOerBEqliUtsZVxYdk/VvMuODr+mw3q18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YQ96xJizdwn6A89/Ncte9YY+pqDWfhjDrm3KZxwzSYhG23/DGP3iQRBwSRpCFNlCMDzZ+O3pTBFXgh7eiwAuBGR3nEhIjv+/mDr6GHDlgqLTHa8ALxAuuYo6IIW9J2NffqEA8K3kC2wmNYrgSYROfbtgY9B/Kseq2yH2w/8sH3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yN/MTMQm; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-78a76afeff6so40145617b3.0
        for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2025 02:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763979395; x=1764584195; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MUJocug23WNDU1Y6GfZPFr7BhDF2XBVjY51YTnPiJ9I=;
        b=yN/MTMQmuUbOKW/1haG1umPRA2w46BoaJ5y/QEiLCOrx0qQ4APqE0XiAY9E4VGvf8l
         Q9y5szUzSQqE8sRtO2FTnuUpUFPhAXHBpTwOBcAlcRa28L4nhckyVzFv5Y0GwBSHEzeu
         VCZSx/eUK1tyd9jqmbEHCIcFWs1NM7rFF9PGKbx/kqlwJxCHbvsd8sCgPtJYo/RNiL2d
         cfm4+1dvS7xy7Kpjb1wNbv/R+l1KJ+vKs3o+vxj2tkxJpcbKp7XQiS9FpGjdfAQT6ZeS
         sQ6Qd5i2rKGFMO56L5PV2HNeerPU3Z5Qfz8OCH7u8DF2v7W0eI2Zh8v9V23jUmBpq+PM
         CUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763979395; x=1764584195;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUJocug23WNDU1Y6GfZPFr7BhDF2XBVjY51YTnPiJ9I=;
        b=gv/yQWoMeZqLhPTREkv+XsnJjZFxjm565UnhEw5IjrYBPHJubgsqlY4RdRVaTZqAfc
         7Zjdml0aZHwocrieeNyOtrcyCeJEfY8CVMQnBESGkAi90E+U55Dt9CEVClmBZ0jqvpa/
         MKrXIKb7uupDa9k/bvM2KjD/BIeiSk1HbcloKkGhoZ084r3+wXPhbTqpj5IrCG5YGCw8
         25ixI/iACLSVeD4vjd9b4Qroy2FAEVg+dYMoFr7mMGE3lwZapFsB2BV3MM6XpwfV7jtT
         zPAvWc/Td5DUwLhiqRGuBFO6ml61iUBLShOw23xzvyHXQbs5jujwxy93cil3m94mGrCH
         sbCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzuMt1mTDpt+X1nYOW1O+qyODt3MNWIiFx4MdWwxRmRCaymH2Jf5S3L7V0Genr79enEsCtzPdxJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTCzpn3AiTtGj28QR02qLiMzsv0JPWzYG1Zync+46GwFhIkhAk
	yeZJoW3ziiT/Of+kQyKyIMkOp4SttjFpWKey2poDUYWoyOViO7ZgR+HgiDma2pTrfMHrcjg4eeT
	vzq78PFiVm0eOKz71U2Byt2g4FFHrnIShDrsvf00g3EITmg+G0LFd
X-Gm-Gg: ASbGncuZ2TB2UCxPKCFNp3nlK9dHc8lhNcHTNE7WjumFPVHk2dA8vMo6cmbm5Oe5fhs
	UZytPej2wCCibEG9sVg+/HjsIgGw3VrMbP4Vc1TdL/zrcfvoQmfKV5ntWkARvFhNGMmnEHbI/s2
	A9/WoAaHhZy4PG8KZdkh0wu2bQ0oBYxeulDPn3/TzZHNN6zyjjiAV/SCEC8CypDQ52JrrQkryQr
	dGpjzlsKmsQSaVFM+kIyE82QDxdKLgF1fYv4sX88Llgly7eXo1vLtgi9UBl+B5IIwmA32LQ
X-Google-Smtp-Source: AGHT+IFk5xPuC9WllFeYsMt+cAg6kWbQNM3KukyATnXbYdApjEIkRdeGdUKoq+5c0uXHzxg9wlZtxBQZ72ka+tuwxxk=
X-Received: by 2002:a05:690e:10cf:b0:63f:bab4:fde6 with SMTP id
 956f58d0204a3-64302a31c05mr5812050d50.13.1763979395064; Mon, 24 Nov 2025
 02:16:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121141003.1808684-1-jonathanh@nvidia.com>
In-Reply-To: <20251121141003.1808684-1-jonathanh@nvidia.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 24 Nov 2025 11:15:58 +0100
X-Gm-Features: AWmQ_bk3EBTHXt5C05GTGKRYiwOCqayqrpMK8udBn5ehvC6IZljccTyU6QUcoeI
Message-ID: <CAPDyKFrsXydSXEZYxtuqQRwydbuq+VawJ+J_8EvaeYUkMSizag@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: tegra: Add GENPD_FLAG_NO_STAY_ON flag
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pm@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Nov 2025 at 15:10, Jon Hunter <jonathanh@nvidia.com> wrote:
>
> Commit 13a4b7fb6260 ("pmdomain: core: Leave powered-on genpds on until
> late_initcall_sync") kept power-domains on longer during boot which is
> causing some GPU related tests to fail on Tegra234. While this is being
> investigated, add the flag GENPD_FLAG_NO_STAY_ON for Tegra devices to
> restore the previous behaviour to fix this.
>
> Fixes: 13a4b7fb6260 ("pmdomain: core: Leave powered-on genpds on until late_initcall_sync")
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe

> ---
>  drivers/pmdomain/tegra/powergate-bpmp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pmdomain/tegra/powergate-bpmp.c b/drivers/pmdomain/tegra/powergate-bpmp.c
> index b0138ca9f851..9f4366250bfd 100644
> --- a/drivers/pmdomain/tegra/powergate-bpmp.c
> +++ b/drivers/pmdomain/tegra/powergate-bpmp.c
> @@ -184,6 +184,7 @@ tegra_powergate_add(struct tegra_bpmp *bpmp,
>         powergate->genpd.name = kstrdup(info->name, GFP_KERNEL);
>         powergate->genpd.power_on = tegra_powergate_power_on;
>         powergate->genpd.power_off = tegra_powergate_power_off;
> +       powergate->genpd.flags = GENPD_FLAG_NO_STAY_ON;
>
>         err = pm_genpd_init(&powergate->genpd, NULL, off);
>         if (err < 0) {
> --
> 2.43.0
>

