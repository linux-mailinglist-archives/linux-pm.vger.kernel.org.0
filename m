Return-Path: <linux-pm+bounces-21085-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D82D0A21A7D
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2025 10:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E3293A2515
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2025 09:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41761AF4E9;
	Wed, 29 Jan 2025 09:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ld5SlCTd"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A561AE005;
	Wed, 29 Jan 2025 09:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738144700; cv=none; b=ebna3ly006UiE7kku97A1N0u+LRDC4I/obqSRKnASRxaaDbap+be+b6TcBwlvJZn6hpIUNcHcmOgJXSBmS7JDoaUeXdwxm+9RwEy9mz3Knwk2t/wLVNd//i1gjokq/Z4VuczDhFy7L1hqjHAWUsuHWFhRzmfRLPFOw0s6YlqPOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738144700; c=relaxed/simple;
	bh=HLPvuEe4EPSdLs2KeGIixiMKBPNwPL7PucYfSurJfRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V7OPUTCzT3T3j/aZ6YoMiz7ngSP3wos6WXSGFiQ1reh3ZLa2lbQTv20wFIuD42YvZb5ykltDJC3/b0PPt/MOgaIKMJPxoV7Pc/dl/FYnx/54MWTdxXqlcbbzfzE/iW/VkHr2bK0Q2YPTfEDy+HFBa7r+lfQLJj4CcEooYiyQMa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ld5SlCTd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 109EEC4CED3;
	Wed, 29 Jan 2025 09:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738144700;
	bh=HLPvuEe4EPSdLs2KeGIixiMKBPNwPL7PucYfSurJfRk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ld5SlCTdTGgGzWzSMuu5sySev8TOHx7OuuY9nNNbjrBr/jg3J+kRPfzs6GGWtJiqm
	 4U0aPuJUpCum+J1W/33MeVcH+8S9hWeqyA5hkW8snYwxEct3F2yzCNh/TIgNfnluQO
	 NhwNDxKKcUl8wHCizprNIUXliK/Ja/TtsgAKBeT9UIlxV0JH9mwXnhDBtDPKS06M1L
	 TgaajIZFSjZyIEd03pOKFzWvMJcSsCG6XslT7SCv/5ad1d9pl2zC64j7iuv8+fMRM1
	 eNm4xrZsCiD/1cF99Hg+Rkvw6ghQJOYUiN6yUXyAxxGI9/go7yeFBD1TS8wTeqHZmD
	 Sa5QBNc1nVkGQ==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5f2efd94787so4322498eaf.2;
        Wed, 29 Jan 2025 01:58:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU4YtGN9Jx/inNMslVUAwVDyIkbjiKDhK3iDDxnZPikQPZHJwcJltVR8mwEIaeqhMtk8sHFDJnUNPA=@vger.kernel.org, AJvYcCVS+F/+E0JnJ6hPaKl3bR1Y5tsA9CYO/BCYvZuKV+8kN3CEro6ooaWtLSeJCCaasICb8kX975fSpkn5j5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyulekrwMgLWShtI+gwfkLgBFIVSiAg51JeQP57c/GgRCB1x0b/
	PtP+M5pvP4nBjx84m0DX+hca7MDmmvbnBY59SSrppvTSOjEWpf+wjFsWQz4/CCKJXG7q4Tu/hff
	tsVkI+vm5ct81LTNLwT8i0OQmahg=
X-Google-Smtp-Source: AGHT+IHAvSvTproHby0CG23Ns42GWLqzKybIZpVySwe/6iGYVEniblMuZNax9/EhZLrP4C8bshjPSl0xbt/q9P2zC5c=
X-Received: by 2002:a05:6820:c82:b0:5f8:d128:c7d6 with SMTP id
 006d021491bc7-5fc0028a9a0mr1418073eaf.1.1738144699271; Wed, 29 Jan 2025
 01:58:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <455e18c947bd9529701a2f1c796f0f934d1354d7.1738050679.git.viresh.kumar@linaro.org>
In-Reply-To: <455e18c947bd9529701a2f1c796f0f934d1354d7.1738050679.git.viresh.kumar@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 29 Jan 2025 10:58:08 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gjGvBxsEB-RgdtOiMzc4MRLvTVWi4DA3MbaLO3GckSpA@mail.gmail.com>
X-Gm-Features: AWEUYZkkM6krShFyORy91kg2gqndKAwrio9kMOXe2SNrHEJ9sxOaKtWrbyCn3Pk
Message-ID: <CAJZ5v0gjGvBxsEB-RgdtOiMzc4MRLvTVWi4DA3MbaLO3GckSpA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: airoha: Depends on OF
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 8:51=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> The Airoha cpufreq depends on OF and must be marked as such. With the
> kernel compiled without OF support, we get following warning:
>
> drivers/cpufreq/airoha-cpufreq.c:109:34: warning: 'airoha_cpufreq_match_l=
ist' defined but not used [-Wunused-const-variable=3D]
>     109 | static const struct of_device_id airoha_cpufreq_match_list[] __=
initconst =3D {
>         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202501251941.0fXlcd1D-lkp@i=
ntel.com/
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/Kconfig.arm | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 704e84d00639..0ee5c691fb36 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -17,7 +17,7 @@ config ARM_ALLWINNER_SUN50I_CPUFREQ_NVMEM
>
>  config ARM_AIROHA_SOC_CPUFREQ
>         tristate "Airoha EN7581 SoC CPUFreq support"
> -       depends on ARCH_AIROHA || COMPILE_TEST
> +       depends on (ARCH_AIROHA && OF) || COMPILE_TEST
>         select PM_OPP
>         default ARCH_AIROHA
>         help
> --

Applied as 6.14-rc material (or please let me know if you'd rather
apply it yourself).

Thanks!

