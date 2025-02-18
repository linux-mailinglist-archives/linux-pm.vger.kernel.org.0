Return-Path: <linux-pm+bounces-22305-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC798A39C77
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 13:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB3BE7A2607
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 12:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0CA25A35C;
	Tue, 18 Feb 2025 12:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7gvC9vf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294272594B7
	for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2025 12:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739882991; cv=none; b=miVXHiawotQ7o2UKj+uivf51rC9XU296gbEOa+F8lDfK1klLEQt6W2EB1Fk1Iu+6HMYt+rZcdfhhxLxENoBlDbDxEDvVCQzNAF7qXu3EL0pJqziwkyqLuojnVHZT5V53wT1Y26SJB9XmKw7er+guh40j1+qjnnvEinD9/h5c8q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739882991; c=relaxed/simple;
	bh=idynLg+n570UxVJEbZQbALLGH9flYbfL7QB8Dvg2Dy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GqBvzwnlZVW6Tk/E9UwRiNDU968ejBmw6GUInx6S3HGiJM/S7+vNEX/E89qu7NHuOGFEUiqCMu57+EgdNzrKFT54RjACCUGMxr0JtN32SflsLQI5QxJpgSq+wCn7GL7x+r1RUnzbSAFhL+MX4pzDM0+7dogy1dLGYLvbCK5KPA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7gvC9vf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07EECC4AF09
	for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2025 12:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739882991;
	bh=idynLg+n570UxVJEbZQbALLGH9flYbfL7QB8Dvg2Dy0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=L7gvC9vfHxanFQbTTJckDSdF23pLkWbMSEjvFP48eIxRuGw68hjxx22QkMIB2TNlt
	 WVDA1He0tDYGAwcdu/YPcl0axXw7v+OGwljDTCdTCSaJ8ksIyrkyuGRH89pqjGny/o
	 U7ngJBiwqlSVk3UlijEipDbg8ftBypgo/grIHcqRQmu6Vtk2yLGTWXtjrRT2koKOTL
	 /7ICUvJIWD7UX0pcVA65/8HKXHsQR8c1izYWpKH32jJslHB7g+y6Z2Jko5XfxyZsvQ
	 pJdgHgZ3aE3bsk1RKky++79ADecsLfW9ghx50Ia9fqLt0Dl/1T8zmuP0Fn7VOAvdkA
	 tHoMCqy8ahsuA==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5fa2685c5c0so2701070eaf.3
        for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2025 04:49:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVfdHk4xVj1LpKDBsB9u0DBSrq9XgIq+svzZAjZDTDTpoA1dEW58euRa4oOqJM9UpkY+2QCuBOAjA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBQyZTVh3SI6FnJcaJgiYYurvpoiTvncEPYhB9z+GgDajtq63F
	+f9HW2TD/Yj3Vwt9JZ0aGKcK78b51Ln98uRZIkNUiV6W+SHzYROhlO/5lF8SWv+wcNIbgtGFZh0
	Ax4ZzQ7Jw/RNOaz89r+foFUekxNg=
X-Google-Smtp-Source: AGHT+IG+SLdXSLCPwCNvc4DsALlMiNwh9q34pP7mQ9K/SG4mXQKD8pehW7+aYG8ousnGCC7owq7qWMSB1mEK25v+Vok=
X-Received: by 2002:a05:6808:2024:b0:3f0:403a:3db9 with SMTP id
 5614622812f47-3f3eb15ab78mr8430544b6e.35.1739882990327; Tue, 18 Feb 2025
 04:49:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218082021.2766-1-lirongqing@baidu.com>
In-Reply-To: <20250218082021.2766-1-lirongqing@baidu.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 18 Feb 2025 13:49:39 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gHUQzjk9vdSrHOU6tCoN0hx291ALW7tVN-JPxW9cVSiw@mail.gmail.com>
X-Gm-Features: AWEUYZnP7fuWYD5K1U2bn0Uij2nRPMuqaZhvU4CKR28vffnqfgdViyv-y3myEEo
Message-ID: <CAJZ5v0gHUQzjk9vdSrHOU6tCoN0hx291ALW7tVN-JPxW9cVSiw@mail.gmail.com>
Subject: Re: [PATCH] PM: EM: use kfree_rcu to simplify the code
To: lirongqing <lirongqing@baidu.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: rafael@kernel.org, pavel@kernel.org, len.brown@intel.com, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+Lukasz Luba

On Tue, Feb 18, 2025 at 9:20=E2=80=AFAM lirongqing <lirongqing@baidu.com> w=
rote:
>
> From: Li RongQing <lirongqing@baidu.com>
>
> The callback function of call_rcu() just calls kfree(), so use
> kfree_rcu() instead of call_rcu() + callback function.
>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

This looks fine to me.  Lukasz?

> ---
>  kernel/power/energy_model.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 3874f0e..72655ef 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -161,14 +161,6 @@ static void em_debug_create_pd(struct device *dev) {=
}
>  static void em_debug_remove_pd(struct device *dev) {}
>  #endif
>
> -static void em_destroy_table_rcu(struct rcu_head *rp)
> -{
> -       struct em_perf_table __rcu *table;
> -
> -       table =3D container_of(rp, struct em_perf_table, rcu);
> -       kfree(table);
> -}
> -
>  static void em_release_table_kref(struct kref *kref)
>  {
>         struct em_perf_table __rcu *table;
> @@ -176,7 +168,7 @@ static void em_release_table_kref(struct kref *kref)
>         /* It was the last owner of this table so we can free */
>         table =3D container_of(kref, struct em_perf_table, kref);
>
> -       call_rcu(&table->rcu, em_destroy_table_rcu);
> +       kfree_rcu(table, rcu);
>  }
>
>  /**
> --
> 2.9.4
>

