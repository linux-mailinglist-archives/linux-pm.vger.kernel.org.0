Return-Path: <linux-pm+bounces-21437-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08801A29A83
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 21:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BAA0168FA1
	for <lists+linux-pm@lfdr.de>; Wed,  5 Feb 2025 20:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7D51FF7CD;
	Wed,  5 Feb 2025 20:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdDQboQn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946A1F510;
	Wed,  5 Feb 2025 20:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738785636; cv=none; b=iGpnrMHidiWpAgeWWhOJtyp3i3gT3ppfNKOPeq4/VrMRWf1h42aUDeIq1Y6g2VzV/RXJVeYLdvkyeOtxmhQYa25mqOIkJED1NMeZlUIo3oUh9Z1iH/m0J1P1KYQmbAiNyodGI/bWZFHo8yum3+eN9qhjFNzWIpsP3nB6f+K6eIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738785636; c=relaxed/simple;
	bh=Uj39/i/LXxfV7kpZRDkzRbNTl7FP4NQW0dBpO0nGT4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EXW/8grabgks184+c99pMbwdNAdaRHznF3wtljI6WaRB3tYR07Ko1BnAPuOYrILI++USDXu2jf0UpTTCV07TpKBANZki3LQCyDB09J2qAUDiNlpJjhQF1mU0XTjf1KqafDQ5qbifUEKjmOd9ETV/5GbFZiwUKxc0hZsj67KeQ0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdDQboQn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02142C4AF09;
	Wed,  5 Feb 2025 20:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738785636;
	bh=Uj39/i/LXxfV7kpZRDkzRbNTl7FP4NQW0dBpO0nGT4Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FdDQboQn4PeFzfCgaykVmqRLZqR3/NeMFUxZNscSLXVB/rImuaiMZKhna0Z5IkgW1
	 vPrL/T5+vr9g8ealH0tWtc+wb+mBy8rHJtx6/DUBAK4yDHlXCPcWSxmzJ3PIzeA4jJ
	 66szce+dzOOdX/712UlSJCKz30Eh/HT8o8+qN5PPbcrDRMrP8P2zxJZf90qIL0dH9p
	 3d37cOQLPz1720u5cyh6wv/QsAnDG/8CJpItw8qP10Xxih+Prl3eWnKtAJDDJYNtPC
	 V088T/5HIWa8HDIIkctFPI0bF4S+5Ghxp1Kkt6TQuPTsAG+prGgrDembxcEpWK8Vss
	 1iQ02N0bkM39g==
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-724a5d042c0so125497a34.3;
        Wed, 05 Feb 2025 12:00:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUFHPscimP2WiSg+MWGr4YJ2RRu+PNZEu5MrBv6Bw5mB00P2pNYgPfHBTOsSf/gyYkY+gmfl9j9Ymk2bhE=@vger.kernel.org, AJvYcCUvAjGaIjNg+AZiQcpY+Bj3GbQeYCT7y4U0eAK4OFQcB5jh+9MhT3WawvcTUQcf+F/f2LA/HNoVSek=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqCd5kHHcxAD8atQ2pFNHoG/NeiI7XGqDH5eDqZEix9zzsLZtb
	fOYk3dByd7sWe6/X4xH6+QvXEDBTlNE+ERKfCNJ0MxVvEXIAqjNOd/eQ0tvUN1LPA389VNtZtch
	9G7T9N0x0/IvR7LbWdp1iU2CEBq8=
X-Google-Smtp-Source: AGHT+IH0ZH8/l+XiD2CbboEhK8b8qhy7FklQiRm5lBPJ3h2Y7TY5Gn/o3RDZUfzDZ64Ys/urVGcAaRO/kSZnWnfx5gA=
X-Received: by 2002:a05:6830:4186:b0:71e:4ce2:432d with SMTP id
 46e09a7af769-726a4253f0amr2651220a34.19.1738785635285; Wed, 05 Feb 2025
 12:00:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9d51d2710061dfa7f2568287c6ed125b858b7318.1738580005.git.viresh.kumar@linaro.org>
In-Reply-To: <9d51d2710061dfa7f2568287c6ed125b858b7318.1738580005.git.viresh.kumar@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 5 Feb 2025 21:00:24 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gX9pfhanX3ZQkaQ6-rYN7AwHXtGh7kznZskQbWvf7XqQ@mail.gmail.com>
X-Gm-Features: AWEUYZmql8rr2RDUji3MBFCFbrRskc4Dk78cKgfZjy5rynmaOOah9vqA8cDEJ4E
Message-ID: <CAJZ5v0gX9pfhanX3ZQkaQ6-rYN7AwHXtGh7kznZskQbWvf7XqQ@mail.gmail.com>
Subject: Re: [PATCH V2] cpufreq: airoha: modify CONFIG_OF dependency
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Christian Marangi <ansuelsmth@gmail.com>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 11:54=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Compile-testing without CONFIG_OF leads to a harmless build warning:
>
> drivers/cpufreq/airoha-cpufreq.c:109:34: error: 'airoha_cpufreq_match_lis=
t' defined but not used [-Werror=3Dunused-const-variable=3D]
>   109 | static const struct of_device_id airoha_cpufreq_match_list[] __in=
itconst =3D {
>       |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~
>
> It would be possible to mark the variable as __maybe_unused to shut up
> that warning, but a Kconfig dependency seems more appropriate as this sti=
ll
> allows build testing in allmodconfig and randconfig builds on all
> architectures.
>
> An earlier commit, b865a8404642 ("cpufreq: airoha: Depends on OF"),
> tried to fix it incorrectly. ARCH_AIROHA already requires CONFIG_OF, so
> this change does nothing, and the dependency is still missing for the
> COMPILE_TEST case.
>
> Fix it properly.
>
> Fixes: 84cf9e541ccc ("cpufreq: airoha: Add EN7581 CPUFreq SMCCC driver")
> Fixes: b865a8404642 ("cpufreq: airoha: Depends on OF")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> [ Viresh: updated commit log and fixed rebase conflict ]
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V2:
> - Fixed rebase conflicts.
> - Updated commit log.
>
>  drivers/cpufreq/Kconfig.arm | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 0ee5c691fb36..9e46960f6a86 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -17,7 +17,8 @@ config ARM_ALLWINNER_SUN50I_CPUFREQ_NVMEM
>
>  config ARM_AIROHA_SOC_CPUFREQ
>         tristate "Airoha EN7581 SoC CPUFreq support"
> -       depends on (ARCH_AIROHA && OF) || COMPILE_TEST
> +       depends on ARCH_AIROHA || COMPILE_TEST
> +       depends on OF
>         select PM_OPP
>         default ARCH_AIROHA
>         help
> --

Applied as 6.14-rc material, thanks!

