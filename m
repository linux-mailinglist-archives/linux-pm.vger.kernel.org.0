Return-Path: <linux-pm+bounces-10593-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7231392732B
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 11:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E13E3B2125A
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jul 2024 09:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF151AAE06;
	Thu,  4 Jul 2024 09:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MruRNUHP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEF01A4F22;
	Thu,  4 Jul 2024 09:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720085825; cv=none; b=XNZavQJ8dMith+KOeKjGsTpo5Unlab2DziS2ZK5hHz6mZKbd4fga+gXLNL9juMn6054O5IuSXXr5s9Lu+m81hM+DwILklPh/kAd6XLCF2zGjxH+Sc657jC7F1Np4Bri8YRWOXbnejj2fqS2PwHiNUCUpzkujUhTThNCRsTjExgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720085825; c=relaxed/simple;
	bh=Y5ZZ4NJ9EbtCr2Y9omXiRAO1MHjSjiox9FbqVaEaEwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rrAo6C/pV9Fq9UBJSTdVkqJ7KVRBCdrqxtPrmbBXt7WT/RQRSLZXou04mS66D/APHJF41MkMnqz9Wh3FY0qpHlRxjMy/RT+heZ0ML2MTIAkRlZZ+AL1Nb/vQFOS9e0Flfk7/8bcgOJ+unq9hK6wgB+lLT7nw0MMNy3cGXCp3q9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MruRNUHP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641E9C4AF0E;
	Thu,  4 Jul 2024 09:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720085824;
	bh=Y5ZZ4NJ9EbtCr2Y9omXiRAO1MHjSjiox9FbqVaEaEwU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MruRNUHPf/Q6j7rKgP/iwgqp/Y3ezohxwnrCOY+a2rJZ+JpW/Zc970RIBugYAQpgw
	 hlcktUALLCz7oRHAU9yDYy8+DWYx4zOLPmC+ZBoTh0tgL7p+P6RTmyBEjW9uKHEQs9
	 C8WOMpHj/YjsGCfx5UwTOpP1Xwntx4zGWMJ39wOMv9LjJNgaQqf8k0fjuZFO3XeD53
	 U4LfFb2F3jEtePLraUWpBrwOv//pXSpUI3n9zuTp955bLgmos8UqEjnzsdLoytvGLG
	 N/HJ/VT9M2mP9ey1LYh8oOgWZJRfoEXnFl0qhC5stHPRoiyRYpU7dCMyQmLxOwIWnm
	 vIG79AZxw+gHw==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa69dso12055a12.3;
        Thu, 04 Jul 2024 02:37:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVhkF4qY8ejne0KlITsGM8e0+STxRX9VuEHLngmgQJAEE4hs5DOPGy1irFZQ/iOZcIVl3ZWgbHAefrtVVKi+Ohpsb2w1691MbRO9Nm+f4aszkj+sdsgFEOc5utbY66jORgYIdHfO4Ub97N3c9m3wE509r98JSlPegVn2g8YAqa8ZauN
X-Gm-Message-State: AOJu0Yxf1sx9PqNaycSzq0pYixwAfHmfvqFxzf5BW5D09yYRIwvcfGPQ
	e3cX6gNAitIPLNbZlhQ+WmwQ60fYCYsq60d1VQ2MQZ9REZA7Mj2wzJeMdMr9DfPeIWUC9hxmizp
	A/Lesf0JGeolFJap0f+h+dBZ0eUc=
X-Google-Smtp-Source: AGHT+IEfnVppQjNn4Xl/+dYerNkiNX2JL+01n+mxYMdoqIoBLf5oc1L9HAY5x2Xlahb+pNBKpQBSUMpPXkJFEtcGhp4=
X-Received: by 2002:a17:907:94d0:b0:a77:a403:f260 with SMTP id
 a640c23a62f3a-a77ba44c776mr91053066b.4.1720085822929; Thu, 04 Jul 2024
 02:37:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1720075640.git.viresh.kumar@linaro.org> <f09ee1fa731db0c1565b5d4b919d54d5f258957b.1720075640.git.viresh.kumar@linaro.org>
In-Reply-To: <f09ee1fa731db0c1565b5d4b919d54d5f258957b.1720075640.git.viresh.kumar@linaro.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 4 Jul 2024 17:36:49 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7S5jruSvkt6PcuChxNEbuZQ=75Oj6VSgSvDqeydGvFLw@mail.gmail.com>
Message-ID: <CAAhV-H7S5jruSvkt6PcuChxNEbuZQ=75Oj6VSgSvDqeydGvFLw@mail.gmail.com>
Subject: Re: [PATCH 2/4] cpufreq: loongson2: Remove empty exit() callback
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-pm@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>, linux-mips@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

On Thu, Jul 4, 2024 at 2:56=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.or=
g> wrote:
>
> The exit() callback is optional, remove the empty one.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/loongson2_cpufreq.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/cpufreq/loongson2_cpufreq.c b/drivers/cpufreq/loongs=
on2_cpufreq.c
> index afc59b292153..6a8e97896d38 100644
> --- a/drivers/cpufreq/loongson2_cpufreq.c
> +++ b/drivers/cpufreq/loongson2_cpufreq.c
> @@ -85,18 +85,12 @@ static int loongson2_cpufreq_cpu_init(struct cpufreq_=
policy *policy)
>         return 0;
>  }
>
> -static int loongson2_cpufreq_exit(struct cpufreq_policy *policy)
> -{
> -       return 0;
> -}
> -
>  static struct cpufreq_driver loongson2_cpufreq_driver =3D {
>         .name =3D "loongson2",
>         .init =3D loongson2_cpufreq_cpu_init,
>         .verify =3D cpufreq_generic_frequency_table_verify,
>         .target_index =3D loongson2_cpufreq_target,
>         .get =3D cpufreq_generic_get,
> -       .exit =3D loongson2_cpufreq_exit,
>         .attr =3D cpufreq_generic_attr,
>  };
>
> --
> 2.31.1.272.g89b43f80a514
>
>

