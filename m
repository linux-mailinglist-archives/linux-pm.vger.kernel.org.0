Return-Path: <linux-pm+bounces-29363-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2ADAE48EE
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 17:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D5E31B608AA
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 15:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DCD2571BE;
	Mon, 23 Jun 2025 15:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEOEjuuW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B64246BCD;
	Mon, 23 Jun 2025 15:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750692725; cv=none; b=VAc/QW/yN4E5ZW3Dpw+QOsWrXk+IhV/tAaNJXJLogycL5zYE/NFI5ql+RfK0uxebK8lmmHsBaZCUiVWni+o9Qt729tjWj5prBam3Iazarz7Ivr0jV/crVAGjDJQAfgkFdecqmW0+nBI0oYJHhMwKFxESrtjLj2Ji+ajDXCqRsDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750692725; c=relaxed/simple;
	bh=xcSk7RYCIiHJkq9DU8Urzcplo6nl1Q/e6R4jl/xdA18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lAp/sqBf3HfCO7+3ZNbKl/DfiK4zJtp1TowokCiWIqjd6Lf7gTAOqcvib7YQcCR8cQqYA6x0DF5Wh7Gkl1sEAz5iZcirF8KdawHKL9sNzTBiMX6O7wr8GjlUI3zRfScunSKsQfEDMXK82BIvDou64Uo4tKnPTF86Tu1YIgkx49Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEOEjuuW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D036C4CEF1;
	Mon, 23 Jun 2025 15:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750692725;
	bh=xcSk7RYCIiHJkq9DU8Urzcplo6nl1Q/e6R4jl/xdA18=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YEOEjuuWRq2YQHQNvFI5L+VrXCrYuXHtlom1w066Nhfc6aGNAyOTJOzwymgzVO4ck
	 /NYeDpPzr2Xht6x+sWiDm9UtWOO00kFhAGhVoTvbGnVlFJAqSVYa84wScIzKuzpBbA
	 mG5TMU0I+mCLBY/dJonLh+tam6DMfVG73uHDE5OFOXbcX3zWQNqTvKPiLHWc+B0I6h
	 G29X2Y43rgJ2zYuXhx/1DxKxqVVVVYm5mrB78YgkCgi+odfkbCs0gU+hLP1+t25pcP
	 sv+TSV3KgfR33/F3BXhIIPfLnWOAqrnEv/UgqSAbxg9UEj7aMpfSx8LBBSL5AW2ZKH
	 EGp1tExF0ATNA==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-60ef6bf2336so3045987eaf.0;
        Mon, 23 Jun 2025 08:32:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVRJcskOaFM9OLxtjEmWcXxb2s+6l11BdrWWgh0UUAqN9uo3l29kSF2SCgo4Mi7/lPkEoRmVy0i3hqsnQI=@vger.kernel.org, AJvYcCVqkLOcUDkD7oouGH4/ud7M+s4T8WCBdYAigoTYHPf4cFRdyAbK2y56F9u3Mp7A7al+LlG1qwfIAQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3G0IF7sitAkwfUAcwxQQ6hP6mrPfTh36YtkcXNXf8Lsp1kzwW
	qvQGsEwNkbFlwR6zfkma0lG5ViC/kVD/U9/U82iZw/O+7o0lgxjavUurB/FSixcfbxjgBB4DAo5
	m+ZZnOxt/YfEau6kijOBhupHJXpCyeOc=
X-Google-Smtp-Source: AGHT+IEwbD6khw4wUsAVrr0ScWF5lRIpkaOyLCOiJpCf3Tl0xFfVlj3n6xpOJ67FTBWmAMlFxQ6G3zmzH2AriA/NuEY=
X-Received: by 2002:a05:6820:308a:b0:610:ee96:eca9 with SMTP id
 006d021491bc7-6115ba821c9mr7571417eaf.8.1750692724382; Mon, 23 Jun 2025
 08:32:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623133402.3120230-1-zhenglifeng1@huawei.com> <20250623133402.3120230-5-zhenglifeng1@huawei.com>
In-Reply-To: <20250623133402.3120230-5-zhenglifeng1@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 23 Jun 2025 17:31:52 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hgP3PKLqiHsw9bADvxRGsBqQ__DVVKzEmgb6stTmi+cQ@mail.gmail.com>
X-Gm-Features: AX0GCFur4NTs0QrPRXkjh7Z4TNi5EhcL2IDgNfmEDS9ZPG-Net6nXxLLV2dratI
Message-ID: <CAJZ5v0hgP3PKLqiHsw9bADvxRGsBqQ__DVVKzEmgb6stTmi+cQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] cpufreq: Remove duplicate check in __cpufreq_offline()
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, ionela.voinescu@arm.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, lihuisong@huawei.com, 
	yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 3:34=E2=80=AFPM Lifeng Zheng <zhenglifeng1@huawei.c=
om> wrote:
>
> The has_target() checks in __cpufreq_offline() are duplicate. Remove one =
of
> them and put the operations of exiting governor together with storing las=
t
> governor's name.
>
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>  drivers/cpufreq/cpufreq.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 2303890de0ba..c4891bf5dc84 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1692,14 +1692,13 @@ static void __cpufreq_offline(unsigned int cpu, s=
truct cpufreq_policy *policy)
>                 return;
>         }
>
> -       if (has_target())
> +       if (has_target()) {
>                 strscpy(policy->last_governor, policy->governor->name,
>                         CPUFREQ_NAME_LEN);
> -       else
> -               policy->last_policy =3D policy->policy;
> -
> -       if (has_target())
>                 cpufreq_exit_governor(policy);
> +       } else {
> +               policy->last_policy =3D policy->policy;
> +       }
>
>         /*
>          * Perform the ->offline() during light-weight tear-down, as
> --

This is fine by me, thanks!

