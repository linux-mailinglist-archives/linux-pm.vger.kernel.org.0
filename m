Return-Path: <linux-pm+bounces-29984-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9DBAF6149
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 20:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 726BA4E21B5
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 18:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCC72E499B;
	Wed,  2 Jul 2025 18:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRKSdAgW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AA32E4998;
	Wed,  2 Jul 2025 18:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751480856; cv=none; b=efWOFaZsRp45ru7Er/RcHF22XCEYgcr0nwHHcFprobBr6TcavLyIo/ye78OJjEJXvvs2/5jNE3w+73pQ/tMnxQmxsAcLW0c2ec/wpGu5ZwKXXUIpm0kNPxlVJ+5SmIhoXOFa0h570tlw/X/iNFjAtCt1V8hXP9xU9zj2TzYRUWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751480856; c=relaxed/simple;
	bh=pNoUeTu7G0NbNxqq9qt36c8lJLVHQ2RKe/l7TLJ0O9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KBuOG9ho8A5/BsDX2ArzqpIVk+rvFfhjs+h72toE/YBnmyhPpMvy73iaWlhLY0FGR/rMtE+J15O9//eupjk9GghcV6YumpOmVKzU5gK4cM9yszIn5ZJVVFOHHq+0qdxeFs9xnmu1VBva8h883yZgzTTgNq0YzzJToagoDQCSd7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRKSdAgW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95C5C4CEF2;
	Wed,  2 Jul 2025 18:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751480854;
	bh=pNoUeTu7G0NbNxqq9qt36c8lJLVHQ2RKe/l7TLJ0O9E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PRKSdAgWm2cfsj6bsDmWtPtvceAnx8eUDPE7hYVlHs5QfdJ7DpT62Yl9lxTu8qd5f
	 lr0+a+2MgfL9uePS86C4/+vkzbCuq8zPTlFciT2PzYUI1HsK12wmueGNAkricH5PhZ
	 YZzfsVEx4Q3mun5TkOsSZWRdgs1+H6uiQzMGlUAeoQwuvJ841c0zCbrXQpZe9pkCy/
	 qqr79oS/OeqYgEW6B9KTZAjE3+8sLyDEKUPi3BuBQtHEUAPHpN9qvkWKkW7un9e7tm
	 66rfLL1IdKBysz9AEMb8JWlVci1HS7VF6PH0tHYcaFAMuClDMMOjpXFjPmvipQUhCY
	 GzenHzMjptM3Q==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-610cbca60cdso2944919eaf.0;
        Wed, 02 Jul 2025 11:27:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUrVwx0S7Kpz1CdanxI8QwsnQo7ce0Hz7woAzMLdvyA016M43ofWJLT6vaRmF12vUYyl+3OsEuM87Q=@vger.kernel.org, AJvYcCV+h71oJoHgOmHkJEkjR9Ecqtm0tHUW56tSXLtF5Pc4WL9/D8RkxQ+oOVjUf+eHTbLzro07md+/DVr2eg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxCrdsqFnfdUOGYvuA2O0Q2iKOYawdg8ToDMqTvsjlzI40Uqj3
	5hByU4Pne1iv9W4aYOUPpqjjcsoDOm4x5g926ntN/MR2rJHw8vd+3tLMAKZLcnYRjC95uP1RPIR
	7d7R47f3GVcddu6BxdtVS6PeW4vjcxMI=
X-Google-Smtp-Source: AGHT+IHlc+VsrhwhEpRs0FX/jyEFX9C4vudKRU118Nti+kcNGX66mDwXnQzf+/vhMVELHlCQL3MBm3E0conkTgX3o7c=
X-Received: by 2002:a05:6820:1513:b0:611:9bc2:7cbd with SMTP id
 006d021491bc7-61201069e5bmr2819865eaf.1.1751480853824; Wed, 02 Jul 2025
 11:27:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604213908.27819-1-yury.norov@gmail.com>
In-Reply-To: <20250604213908.27819-1-yury.norov@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 2 Jul 2025 20:27:21 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h7CeO+vG4BVcdc=XxcWMRY+OmhrWxtrAS59T-uK1KDOw@mail.gmail.com>
X-Gm-Features: Ac12FXz-CnkLYTA0W8rkL9ONEVIW8nN9-3kwqg6RphwSwuoOf_kcqPMOXRJ3psI
Message-ID: <CAJZ5v0h7CeO+vG4BVcdc=XxcWMRY+OmhrWxtrAS59T-uK1KDOw@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: dt: fix opencoded for_each_cpu() in idle_state_valid()
To: Yury Norov <yury.norov@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 11:39=E2=80=AFPM Yury Norov <yury.norov@gmail.com> w=
rote:
>
> From: Yury Norov [NVIDIA] <yury.norov@gmail.com>
>
> The function opencodes the for_each_cpu_from() by using an open for-loop.
> Fix that in sake of readability.
>
> While there, drop the 'valid' variable as it's pretty useless here.
>
> Signed-off-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
> ---
>  drivers/cpuidle/dt_idle_states.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_s=
tates.c
> index 97feb7d8fb23..558d49838990 100644
> --- a/drivers/cpuidle/dt_idle_states.c
> +++ b/drivers/cpuidle/dt_idle_states.c
> @@ -98,7 +98,6 @@ static bool idle_state_valid(struct device_node *state_=
node, unsigned int idx,
>  {
>         int cpu;
>         struct device_node *cpu_node, *curr_state_node;
> -       bool valid =3D true;
>
>         /*
>          * Compare idle state phandles for index idx on all CPUs in the
> @@ -107,20 +106,17 @@ static bool idle_state_valid(struct device_node *st=
ate_node, unsigned int idx,
>          * retrieved from. If a mismatch is found bail out straight
>          * away since we certainly hit a firmware misconfiguration.
>          */
> -       for (cpu =3D cpumask_next(cpumask_first(cpumask), cpumask);
> -            cpu < nr_cpu_ids; cpu =3D cpumask_next(cpu, cpumask)) {
> +       cpu =3D cpumask_first(cpumask) + 1;

Doing

cpu =3D cpumask_next(cpumask_first(cpumask), cpumask);

here might save a few iterations for sparse cpumasks.

> +       for_each_cpu_from(cpu, cpumask) {
>                 cpu_node =3D of_cpu_device_node_get(cpu);
>                 curr_state_node =3D of_get_cpu_state_node(cpu_node, idx);
> -               if (state_node !=3D curr_state_node)
> -                       valid =3D false;
> -
>                 of_node_put(curr_state_node);
>                 of_node_put(cpu_node);
> -               if (!valid)
> -                       break;
> +               if (state_node !=3D curr_state_node)
> +                       return false;
>         }
>
> -       return valid;
> +       return true;
>  }
>
>  /**
> --
> 2.43.0
>

