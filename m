Return-Path: <linux-pm+bounces-31256-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E8FB0D3E6
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 09:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFE2617C506
	for <lists+linux-pm@lfdr.de>; Tue, 22 Jul 2025 07:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39D12DFA20;
	Tue, 22 Jul 2025 07:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LcJS1hv7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB582DEA93
	for <linux-pm@vger.kernel.org>; Tue, 22 Jul 2025 07:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753170035; cv=none; b=SZ5snAFL/qpNpw1z1m1gIJKUKWbD3FLO2nGK2n/XoTHfFVkDfs+qEKbd7mM4BnoxOs+UXtN7nRbgukW5Xj99/giMRwfvBjlr077LnbuzvXfRfnQ9AWWiXOs2zAkT3vC1iEPFpugPjxf3uKbZjSbT9G3eEFectYeI/Wf7hNlwWmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753170035; c=relaxed/simple;
	bh=PMCF5ES/3ZTia8Zi2R1TmRc2+w6IRtpnMyRVCb/pk3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AVtu8y5qP7tqfY6yjjzm9n8xZcWcltou1zYzlbtW7fMfC0KUKpGsCj7Z65eKhgz8gQpS0FZsKbj/mZpKf+Z2086R4wxIeA/ybVGjC/sCidcBLmPY09QsW7oz40OpRyrpOS6wvoINo/ZYzvfpms7wumFJCa9QzeQsCNyH9qsExf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LcJS1hv7; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-32b43846e8cso38299421fa.0
        for <linux-pm@vger.kernel.org>; Tue, 22 Jul 2025 00:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753170032; x=1753774832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=41B/ekEx4m/gKNRr2HYhyza2JcZwd1YnIux2XMK+KqY=;
        b=LcJS1hv7Dnvkmpmd3enHoh0/aBteDEftmoXfwpD6OxOmIvHyq5E69z7T7eWISBXLXe
         6n2dVeHuqHbJWgqsD11EYSbpw54u6d69PospkeBWMDOYmLKdD1dRXpBUv3CQcIVSRbbg
         X/JLOTQaLaWj4pbzvUdqAUG9SonpBa5MGGRuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753170032; x=1753774832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=41B/ekEx4m/gKNRr2HYhyza2JcZwd1YnIux2XMK+KqY=;
        b=gh8PsMGj4LJgxaCVLzKA0vOG24TXOlnSFGHKwqlBPjZJIcekvodUU1V+C1tC1Tw0b1
         dEBICzeRBM+Tpm9rIa7lSMhTosY7pxtL2qphftQuh1Spu1fqIlhhFblcfCyJ6/mlMqij
         jxwk/2FW3q+srIi8QNwKCG7gwmUi0MTL53dqdt7EFwrwpA+7wwJlyyeUcFyJ/Yi+zc9m
         hseS5oL5b5Sb9LrsKCi8SLQdAasmGpXQYkKzzyTBux93VV0FhrTA2yFHdG0saQbv8/VF
         CiFwm4ajJOCp91QqV1hAJMRrSuESFTUypItZKf0Yx5AADk8yTHw0L89NT8KpLeliJpPu
         GmmA==
X-Forwarded-Encrypted: i=1; AJvYcCUxC7UqfMK2xmmUz+D7AVuWih6XG02PFzjErmPPR056oG5ppubJ/0iWniFksvSuGxu2vzPuWXmkWw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEJaG0oOXY8fGxzi9XJDlTtHj10HYso+LF5ZbkTVHA3ZmfP8AP
	Mihaho3y2HgKmpbRmG7rc7/m2r+hnf04WWvajTNQhV8EUWy3XCT/rg0omWdbd0vVOqrR85Yfov6
	NAs4HPAQLWc6EsJwFWD3Gbd+sFWN3ZDAlu0gT26iT
X-Gm-Gg: ASbGncvIqASttUbeG+6So5KpPw+RP7QwQStUGsK7z4n7ApzbjD1RScXplFgp6LkrSXS
	A32y6k65pKKbcfd4DTND4T9yfuo+NZSM38QpRrs+Vv+4hGhOX9bzy5XkTcd4o6WD5MEVo0glXmg
	JtS3qto0V8csrG4J/RLG5vi6YtW2wL4lKnIuNG6Wh1eyh8rbA2KyTU0lepymG0K47PA+IumIOdk
	VmQIR/H3Xhek5H45FBM8HxLpu9e5MGnNyg=
X-Google-Smtp-Source: AGHT+IEQ22SyB/ySXRKt1KC3gl7QbzYcQMLoMwBK32ZhmBBhXQtJp8OUPSRF0MOxntL5QFsaUhmhC/a9dY2DEPGCwaM=
X-Received: by 2002:a2e:a58f:0:b0:32b:34c5:225d with SMTP id
 38308e7fff4ca-330a7ae1057mr36760231fa.1.1753170031911; Tue, 22 Jul 2025
 00:40:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721081459.16278-1-laura.nao@collabora.com>
In-Reply-To: <20250721081459.16278-1-laura.nao@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 22 Jul 2025 15:40:21 +0800
X-Gm-Features: Ac12FXwHVu2xheACj_ug47v0VGmRzFUiGV73WGs8r_Guigs_NEMfWXqCZqRQckQ
Message-ID: <CAGXv+5EmigF=m1zDZ71AMv02XwyYWQxpiRpiwc7YMg=8vc2FZA@mail.gmail.com>
Subject: Re: [PATCH 0/9] Add thermal sensor driver support for Mediatek MT8196
To: Laura Nao <laura.nao@collabora.com>
Cc: srini@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, andrew-ct.chen@mediatek.com, 
	lala.lin@mediatek.com, arnd@arndb.de, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nfraprado@collabora.com, 
	devicetree@vger.kernel.org, u.kleine-koenig@baylibre.com, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	kernel@collabora.com, colin.i.king@gmail.com, bchihi@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 21, 2025 at 4:18=E2=80=AFPM Laura Nao <laura.nao@collabora.com>=
 wrote:
>
> This patch series extends the MediaTek LVTS thermal driver to support the
> MT8196 SoC.
>
> MT8196 uses a positive temp_factor for temperature conversion, requiring
> slight adjustments in the conversion logic.
>
> To support this, the series introduces:
>
> - A new struct lvts_platform_ops to allow platform-specific
>   conversion logic between raw sensor values and temperature
> - A variant of the lvts_temp_to_raw() implementation for SoCs with positi=
ve
>   temp_factor values
> - Platform data and controller definitions for MT8196

I see the GPU and APU thermal sensors were left out. Was there a reason
for this?

Thanks
ChenYu

> Laura Nao (9):
>   dt-bindings: thermal: mediatek: Add LVTS thermal controller support
>     for MT8196
>   thermal/drivers/mediatek/lvts: Make number of calibration offsets
>     configurable
>   thermal/drivers/mediatek/lvts: Guard against zero temp_factor in
>     lvts_raw_to_temp
>   thermal: mediatek: lvts: Add platform ops to support alternative
>     conversion logic
>   thermal/drivers/mediatek/lvts: Add lvts_temp_to_raw variant for
>     positive temp_factor
>   thermal/drivers/mediatek/lvts: Add support for ATP mode
>   thermal/drivers/mediatek/lvts: Support MSR offset for 16-bit
>     calibration data
>   thermal/drivers/mediatek/lvts_thermal: Add MT8196 support
>   dt-bindings: nvmem: mediatek: efuse: Add support for MT8196
>
>  .../bindings/nvmem/mediatek,efuse.yaml        |   1 +
>  .../thermal/mediatek,lvts-thermal.yaml        |   2 +
>  drivers/thermal/mediatek/lvts_thermal.c       | 315 ++++++++++++++++--
>  .../thermal/mediatek,lvts-thermal.h           |  26 ++
>  4 files changed, 325 insertions(+), 19 deletions(-)
>
> --
> 2.39.5
>
>

