Return-Path: <linux-pm+bounces-34869-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E703CB7F479
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 15:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C9007A8132
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 13:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4688F2FBE01;
	Wed, 17 Sep 2025 13:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QKP72mg9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D131E25FA
	for <linux-pm@vger.kernel.org>; Wed, 17 Sep 2025 13:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758115779; cv=none; b=QEIvx4ucc1PGR3TaBpBiMm5y4VgmiVsQAurTcMrI1y7jojjTaeRsjcLKnZzhZTmSKf5aWIzU4R6CvXR/HKra7hmMr/w1/vK7Xalfl1C4TsIRFM3DPj+KugUmcBHoWl0MaQyp75GB7UDjPd0IsyfF/pqgTa6/O/0bpmVaIMF9miQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758115779; c=relaxed/simple;
	bh=uW36CxPbpgNkRbAVrNYq1uP+W+fshOEviFJG8atk5HY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s2Ete0mLLt8fRsYxqaJ8S0/iaGAAjgrn1CP1puGn/Yfjw3cxiB9JJs9d1wYqOzXSzghaJ+Pt6pJlIDh7/r+khgYBMgvYNIA5tVG1xEoNrqAL55fx7e99pGnk7nYzS1NTzm0YbF0mL2DZhKUqQ7qGAGZPPT3GU5y6Bj3AHVD5MEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QKP72mg9; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-632e9c6b411so1966792d50.2
        for <linux-pm@vger.kernel.org>; Wed, 17 Sep 2025 06:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758115776; x=1758720576; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QjnKuNKA4ji6kMyGHxtwUN6WBWnj7945LQCwoquyyQo=;
        b=QKP72mg9NETDbPyeuuJGP/MMuclTloXJMARWueksLytqigwlfpjbBWEoXh1OVyAulL
         ne7pZpPLq0dOUsLskgLx2GOcdjMNBWmb86G4cJgzz7eShI3rvGvqp0voimYaV9Z5S+80
         WaiYwN2HyE6InLr23R9CVuLWzqEC9ONgkbgXxJRJKe7Ky4zgHSCs2H9nnaOpmJDcJUkH
         GFslVvZnLuqLDOB87GaUJolG7MNLD8MzJpToLeNUjEYlbgHymzuB43apGDMdrt8/WQ0C
         OZNAKDBk37W476fqcaNMJZbCbbhcfKbpHsfNKGXlZr65EQO1QKjYlDHgu6vILtjbonEL
         UAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758115776; x=1758720576;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QjnKuNKA4ji6kMyGHxtwUN6WBWnj7945LQCwoquyyQo=;
        b=HNyeoXZBQI11yyCyYj3LcalY/su3XqgKhh00GB/Br4jyxDpHUlRnfiV7TxeWpl4Sh0
         5eovRV9HU629AE+gNxq6riGyUS4A0c0Zuq6N/bEhCxhj6unSAnq9PSci3pI/YC+SMhyH
         AJdhqCb0GV+c8naPdjh/unsse89RFQkkV6aPC607L5yCAotpz+Ry/4VmJdEx6y/jPDYv
         UlBKQ33kSHprV+fVG+iuyrvmwaE3sQLCHXYBnEYrQLo8mmCVP9RLYx5ydIk/nljNxX2W
         ug3+Y3Rl3KsJHvU4M5iiYx40xLlpFX5OFzyC/yEysKnEsgyONsJXPELzHNEPLOtjb8L0
         InhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXLyzBBSDoyjG0Rw6Zz/wJSVI6ng3rfy8SnUVBAAokt9FIMl0+UBvFw6/lmCIKaqs8fY6MjYb6BQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyS4bE2MfXpxPDJ/S+hUcfDYlTocWQ6zgbR+mms+vKlZ0iYhCtW
	9Vu8UXgMFMJPVYKzHlQAwyPAQv3U9T9S1VSD6yR7rFY1wNFOZ+a7O1s+9HjtGMkHbgpZQCvDtap
	HDRBPqmHDx9BeGxWol3XEdmtChkvDPD0IKyxEiEt8Qw==
X-Gm-Gg: ASbGnct8B86+v8C8n/ozH+rPVNlX+8Uyh7oop2t6QZuQtkl4PIYu4/HNEIlC0ymBgDH
	pBoRukLy5CulyyzQv3ztejBBVwDYun2DNPe4UClh5otQHQj2NNBuhCtomvMXexhymBPE3UCdnhk
	o9CXyO8ap/2v6lU1h0s9KohjIZqVyoSZQyea7gXhEH5aDgttrususQ2iVYa2OcCi2Fi+3c2krro
	DqBqmpL
X-Google-Smtp-Source: AGHT+IHuI5AyhviMUE8d04CZKMsxw84ERhd0y58MB1DDZatjUo51eJKV0sipZSi6vcJejXizNerBql3FasBKpx0EYU8=
X-Received: by 2002:a05:690e:1241:b0:62d:9854:f1c3 with SMTP id
 956f58d0204a3-633b0731376mr1875395d50.33.1758115776183; Wed, 17 Sep 2025
 06:29:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917-mt8196-gpufreq-v3-0-c4ede4b4399e@collabora.com>
In-Reply-To: <20250917-mt8196-gpufreq-v3-0-c4ede4b4399e@collabora.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 17 Sep 2025 15:28:59 +0200
X-Gm-Features: AS18NWAFYxfdM-z9P24XcfzEBx3NAZQo5nY3cbJlHEFPJOB1W-fi7_dweQlyxBc
Message-ID: <CAPDyKFoi9KcsP5k84cSxuXNuMHmcf3a8emfOc6hMjGm_0FMk8w@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] MT8196 GPU Frequency/Power Control Support
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Chia-I Wu <olvaffe@gmail.com>, 
	Chen-Yu Tsai <wenst@chromium.org>, kernel@collabora.com, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Sept 2025 at 14:23, Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
>
> This series introduces two new drivers to accomplish controlling the
> frequency and power of the Mali GPU on MediaTek MT8196 SoCs.
>
> The reason why it's not as straightforward as with other SoCs is that
> the MT8196 has quite complex glue logic in order to squeeze the maximum
> amount of performance possible out of the silicon. There's an additional
> MCU running a specialised firmware, which communicates with the
> application processor through a mailbox and some SRAM, and is in charge
> of controlling the regulators, the PLL clocks, and the power gating of
> the GPU, all while also being in charge of any DVFS control.
>
> This set of drivers is enough to communicate desired OPP index limits to
> the aforementioned MCU, referred to as "GPUEB" from here on out. The
> GPUEB is still free to lower the effective frequency if the GPU has no
> jobs going on at all, even when a higher OPP is set. There's also
> several more powerful OPPs it seemingly refuses to apply. The downstream
> chromeos kernel also doesn't reach the frequencies of those OPPs, so we
> assume this is expected.
>
> The frequency control driver lives in panthor's subdirectory, as it
> needs to pass panthor some data. I've kept the tie-in parts generic
> enough however to not make this a complete hack; mediatek_mfg (the
> frequency control driver) registers itself as a "devfreq provider" with
> panthor, and panthor picks it up during its probe function (or defers if
> mediatek_mfg is not ready yet, after adding a device link first).
>
> It's now generic enough to where I'll ponder about moving the devfreq
> provider stuff into a header in include/, and moving mediatek_mfg into
> the drivers/soc/ subdirectory, but there were enough changes so far to
> warrant a v3 without a move or further struct renames added, so that I
> can get feedback on this approach.
>
> The mailbox driver is a fairly bog-standard common mailbox framework
> driver, just specific to the firmware that runs on the GPUEB.

I had a brief look at the series and it seems to me that the devfreq
thing here, may not be the perfect fit.

Rather than using a new binding  (#performance-domain-cells) to model
a performance domain provider using devfreq, I think it could be more
straightforward to model this using the common #power-domain-cells
binding instead. As a power-domain provider then, which would be
capable of scaling performance too. Both genpd and the OPP core
already support this, though via performance-states (as indexes).

In fact, this looks very similar to what we have implemented for the
Arm SCMI performance domain.

If you have a look at the below, I think it should give you an idea of
the pieces.
drivers/pmdomain/arm/scmi_perf_domain.c
drivers/firmware/arm_scmi/perf.c
Documentation/devicetree/bindings/firmware/arm,scmi.yaml (protocol@13
is the performance protocol).

That said, I don't have a strong opinion, but just wanted to share my
thoughts on your approach.

[...]

Kind regards
Uffe

