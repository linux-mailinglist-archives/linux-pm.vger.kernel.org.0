Return-Path: <linux-pm+bounces-20486-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E12A1242C
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 13:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A10657A056E
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2025 12:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37121241A14;
	Wed, 15 Jan 2025 12:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfQatdoB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E76F241A05;
	Wed, 15 Jan 2025 12:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736945595; cv=none; b=nmV/40p8jG3lk7zw3U1acwIL+1hyxDL7XG8GqMX5Wj0P8Cw4oyVO+J+TpWRR42pB+Z+ampO1knmUKQATBk8qL62BFUJl1+MyC2bRAd+TZEpsFZmMtQ6Vn61sVEVA6/uc1B0hAn/nhwWeRpP4XcWa+JNsw6EM+WRc0iR6iHN0wdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736945595; c=relaxed/simple;
	bh=afZ/eCgRDCvsSYf4lJfOWhof/MLHpZSQrdPIT66q4hI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dDvf2LckmJjgiGxjAA6rI1zpUZjYzHIK2VjGKgsNcVuZg3jXuqqcRD8tcPXamK2yqHOa8kqWo01xVdaXGnDvm7DG9GZeRDsDzmHxUFdEzW58CBsYzAoSCS1+EX7u3MlMnYg8xyjeitdslstbiotiIFWqCJDkHImqX8Fze5DfkRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfQatdoB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3FD2C4CEE1;
	Wed, 15 Jan 2025 12:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736945594;
	bh=afZ/eCgRDCvsSYf4lJfOWhof/MLHpZSQrdPIT66q4hI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lfQatdoBLHUo3mAD6kcv0HfU7IE0L/NkZ48/s7KX2mJ0KCs+f+qKmGFJzKRZu1LGr
	 LsNCSwS+dx6kZ85gEr865f6WGKlcuIbpa8pOnLMmBtculalFl28Pyv5VWi7PtQC+Sv
	 5WMtdlnRPPhG9G8MpoMRl0Q6tJv8shVWk2R3N3LTy2yJFpaCO/hHOCsOvZAxBBeIVA
	 MsTTetryVSXbfztHmOUORdJWuqLLxnDp/5rc8iOXHAJiOBxXJcH2rhbq3DRxMhppaY
	 ltwIhji2JPf8T9kd7qWmm8l3Qq4U6E18L2eq2MmrxLumxhBMZiKcRIP3qDJgoQ5KE3
	 +I2w6t/lhR2Kg==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3eb7edfa42dso3051446b6e.2;
        Wed, 15 Jan 2025 04:53:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVYdof+C5VjfOZRHhIGM5Vane1H8k45saXXtryJpI2FX2BRMWjv/8JhErx8ibD2soS+zlr1IV9jGNDhJTE=@vger.kernel.org, AJvYcCX0O6cq0m4lXnxs/d1zjLYGFX0Li6q239aiIP8+RcIWE10ZFdyJpxrHTLHjcApAX+7b79ay36I60FU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwfYedlv+Sx7qc01HtUNzi9mMSLllkG+lwTmH6HJHr9LHjdbyA
	URUUG5Er3Fd53zhYhRwcAgxvPh3YeEMyffYcLTXgheamlglq3+XTfvyw2pn8BoPFzn3dmrpJSP8
	vHiYgJgwsWkQ8Aj6pivztd0rAjZ4=
X-Google-Smtp-Source: AGHT+IE9rBAFysSdRnS3pQBZdll8cnACAsuoO5KOcABWW7XC4zKqQqmgPr3nEN0nu9aDLab1/N4B4YWljRC3KOs67Gc=
X-Received: by 2002:a05:6808:1526:b0:3eb:8354:76c4 with SMTP id
 5614622812f47-3ef2ebc530dmr21097019b6e.9.1736945594261; Wed, 15 Jan 2025
 04:53:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115100123.241110-1-zhenglifeng1@huawei.com>
In-Reply-To: <20250115100123.241110-1-zhenglifeng1@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 15 Jan 2025 13:53:03 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gPMGg2ZvjOmvmfj9W6L9wKT2+ToFgDpi-1pcg_zc+Z2g@mail.gmail.com>
X-Gm-Features: AbW1kvb4ZYO12sOUz0YkKZg6NR1DbH8MMkG_Y4tTGBwG-6vkBBQg1SIkYPNdNFU
Message-ID: <CAJZ5v0gPMGg2ZvjOmvmfj9W6L9wKT2+ToFgDpi-1pcg_zc+Z2g@mail.gmail.com>
Subject: Re: [PATCH 0/2] cpufreq: Introduce a more generic way to boost when
 cpu is going online
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, lihuisong@huawei.com, 
	fanghao11@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 11:01=E2=80=AFAM Lifeng Zheng <zhenglifeng1@huawei.=
com> wrote:
>
> Since commit f37a4d6b4a2c ("cpufreq: Fix per-policy boost behavior on
> SoCs using cpufreq_boost_set_sw()") and commit 102fa9c4b439 ("cpufreq:
> Allow drivers to advertise boost enabled"), per-policy boost flag has
> already been set to mirror the cpufreq_driver boost during
> initialization. However, the current implementation doesn't work for all
> cpufreq drivers and may fail in certain situation. A more generic
> implementation is needed.

Can you please be more specific here?

What happens, why it happens and why do you think the way to go is to
reimplement this?

