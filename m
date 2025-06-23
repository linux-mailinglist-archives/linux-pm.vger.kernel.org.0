Return-Path: <linux-pm+bounces-29361-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D05AE48AF
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 17:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 323CF4A033D
	for <lists+linux-pm@lfdr.de>; Mon, 23 Jun 2025 15:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D237F27511C;
	Mon, 23 Jun 2025 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKkmCXui"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62E125EFB7;
	Mon, 23 Jun 2025 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750692607; cv=none; b=Dv+hFMhPN8Dfe+DAQJc0EhRXVkdoJ8MfaR/zJ8+oMex2A/G82Pew5X+ugNOmh8ORAqCJVJdD5HNjKV1Fg+i+3ip3bZBNzYPuIz/eJk6uTSmuMEhj9imv9ZyGAZZqViSymbAV0PohhcHZ84wTkKlmnEDB9BNoH/Ky3xeOv87ctSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750692607; c=relaxed/simple;
	bh=Eb1qtumKaPEcaprn5jJjJ+Tu3cZ38rObUv31uO8b3Ok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TnG9XA9/5qIi3SzYm/5XLfoBJq+2qsLFUT+tq5G93Q111vMKksGSxJNu4vtf1TpeyrwDQbcVSRE8/vQaVuT16RX8LtG9QHYtx4Eu4S8bUnhP+XdQCnCv59RQ5cyJ6iDcf3eGH2rUg4HxjP/5I9UyPouDYoAZVDPpi6hNW6/aUlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKkmCXui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85BD7C4CEF1;
	Mon, 23 Jun 2025 15:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750692607;
	bh=Eb1qtumKaPEcaprn5jJjJ+Tu3cZ38rObUv31uO8b3Ok=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eKkmCXui95ztxd1SFL0sm2EgauUr2k01BfySwHyNlqVckwYQNCEl5fk9cPbvaFIIA
	 NpFAVgO2S6eye+y9OYV/B3z9II8/JfeSJdCorYE4HmzbHdX1dbQNEMG6MKMduccQqn
	 fuTMwKIz5batspjIe1HPEc4bfrOqGjtaMakMPMGAfp/4/GxKCNZigm3IMjHuw8I1iL
	 ssaRa3kHQxUTijjqwhbVvPIVRN0RijIijaY2Z0wWhH5AgP1xSeY38872+RMJPIBcLw
	 n5hjrO/x50udDoasuUyA3+srHjjuSgODxerwyuE4EP+mUVJsSCJn9MVbSVAM3X5xBz
	 qqnYtMbnV077Q==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-61169c35f2aso350359eaf.2;
        Mon, 23 Jun 2025 08:30:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWwZQmdMXlnsOgAEnhQVE1CQA+QSL5IMT7+5DqVmk9NNTbG+3/6HQ3OzQJEKpSmtYs3qvCwAxF9Hdz3dCU=@vger.kernel.org, AJvYcCXqAb5wBHxfK8mFlqmTZ9xylkXr43pJGKoDttzDPAtDvkc/Me9LCPMzKfk3M25zJY+MtCj+SOwwCB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcgpiSs/xvmF0J2fH8kOPYmjnQYJc5Ip6MX6ykbzFwCyewuWh3
	Go5V7k1xd62cqBeHHIPGO5G+SHiuJ919nv+LMqvEFI9KKE9ubpD/zz7nNSRyj3Jj1wc2aom4Y/L
	+4x1pDLZiW8Ii8JePqiNOYIv5JGtpYew=
X-Google-Smtp-Source: AGHT+IFFL7m7Qo7NPdpY3eP9SKj0mBjebXyUNx9s83DBB9Vomv5GfTKEsxNpU2NwYwJHstACx5mOWEEb7+MCnmOZj1g=
X-Received: by 2002:a05:6820:4c15:b0:611:436e:6125 with SMTP id
 006d021491bc7-6115ba9f7e0mr8042011eaf.8.1750692606854; Mon, 23 Jun 2025
 08:30:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623133402.3120230-1-zhenglifeng1@huawei.com> <20250623133402.3120230-3-zhenglifeng1@huawei.com>
In-Reply-To: <20250623133402.3120230-3-zhenglifeng1@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 23 Jun 2025 17:29:54 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jHjyPMwB5dt9qv01nXAN5z+Kbztb_Mho0Py0cUqZO+sg@mail.gmail.com>
X-Gm-Features: AX0GCFs3M8uu4RFZdHQZjRnse-TgnYFhUcRUEm3KknvfChvm7S8JMOFkCQmPTh8
Message-ID: <CAJZ5v0jHjyPMwB5dt9qv01nXAN5z+Kbztb_Mho0Py0cUqZO+sg@mail.gmail.com>
Subject: Re: [PATCH 2/7] cpufreq: Init policy->rwsem before it may be possibly used
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
> In cpufreq_policy_put_kobj(), policy->rwsem is used. But in
> cpufreq_policy_alloc(), if freq_qos_add_notifier() returns an error, erro=
r
> path via err_kobj_remove or err_min_qos_notifier will be reached and
> cpufreq_policy_put_kobj() will be called before policy->rwsem is
> initialized. Thus, the calling of init_rwsem() should be moved to where
> before these two error paths can be reached.

Since this is a fix, any chance to add a Fixes: tag here?

> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>  drivers/cpufreq/cpufreq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 1bc665b5bba8..efc1f4ac85cb 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1284,6 +1284,8 @@ static struct cpufreq_policy *cpufreq_policy_alloc(=
unsigned int cpu)
>                 goto err_free_real_cpus;
>         }
>
> +       init_rwsem(&policy->rwsem);
> +
>         freq_constraints_init(&policy->constraints);
>
>         policy->nb_min.notifier_call =3D cpufreq_notifier_min;
> @@ -1306,7 +1308,6 @@ static struct cpufreq_policy *cpufreq_policy_alloc(=
unsigned int cpu)
>         }
>
>         INIT_LIST_HEAD(&policy->policy_list);
> -       init_rwsem(&policy->rwsem);
>         spin_lock_init(&policy->transition_lock);
>         init_waitqueue_head(&policy->transition_wait);
>         INIT_WORK(&policy->update, handle_update);
> --
> 2.33.0
>

