Return-Path: <linux-pm+bounces-38588-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 951A1C85047
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 13:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B69CA3B2439
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 12:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1AA31A81F;
	Tue, 25 Nov 2025 12:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tcKqkPaH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170EF2AE77
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 12:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764074953; cv=none; b=rsoSLPAaWCsON/ZS6ZmE3cNo+YAfvcONS/LdE4f8eVyRFmzH9KR+jzx1Jv7sUuBRLnzLgZfaxVj8u7hzi844q8I+BFYCBSDgw42opF93FaKLTiw1YcNFJT5KgpOAdI+Uu73TBd+DVZrFNUgl9BnLftwLQ0GKCFQGuc/xq4s0Mt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764074953; c=relaxed/simple;
	bh=ZB8VYIvPLbBhMOt5XYigtU/8VBWxGq+qAlfUfsEp/nA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A8pbtlIsHYheNFTafSLVASOQGXD8SHyd5bvu3dabzljgQa/ozBhqW4puk80JBe5pfK3CYIy5zIDxBhb2hUfXOyewtW5DueV86fkt2KkChnCmOjF2+D+ISdnhvrLfQgUttUQ/66dPPKKXY4GwBqH2POitUDC3cszWUKHV8VUDQYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tcKqkPaH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87035C4AF0B
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 12:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764074952;
	bh=ZB8VYIvPLbBhMOt5XYigtU/8VBWxGq+qAlfUfsEp/nA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tcKqkPaHjcvJj8zKT4Vxo1CskK/rYQ6Vye6BnceZDuwUPNwMXDGT17HtbltWlApCU
	 PqU1/TBm9R+6eKz61uW1O0FY4EuBuP9gL8hejhrtgs0Ji0+qeyqvuCJDPm6i4fCvRJ
	 Fn/04SAooK0+fJVsA+FdqnQkQqA6jt0T/JGlvLtrFzIBafJnj6WX6RtgxnKTzARVSr
	 V0ycSeOuJOeCineKkJHezywansx0O/shbuv8XVh3MddRu/Er4U+qCFbnVDln227gdO
	 h1WoeTx75+6l1tZhKyreBxNftO7d1CDgX6u82HmFSR3J63NG0PQLxRnho3YqVWLc+D
	 I/sgDRleW91jw==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-656b4881f55so2368475eaf.2
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 04:49:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU+IDL1eWaaTMSgvchMLnMm7Ukn7zku8viZX/lVOt+mwTbioEmMO1ZmiAkBCVIPeQS7sWIAuFA15A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOm3MHOwpSTTfBq89kxZ/eHaP5dXd+2X97+D9hUB0qxtZeZ3jk
	4QnvA93jJD7KazNyjxEf9jNdCZeSy1vYyuWRMPgyNM0DjOfHyqE9VZGbzd01VcUkvet8RqP5WLm
	irY58kbtOoKB6P8z7tKyNHQ5gctMkZE0=
X-Google-Smtp-Source: AGHT+IGgi82XC17/hdsOY8pzEFwacKonjgVRRFjzCcZw1Tc6ugqpmFKTGGqI0C05nofkZ6fLz6YUzvwS/sVvnVJnxJs=
X-Received: by 2002:a05:6820:2d01:b0:657:5202:4655 with SMTP id
 006d021491bc7-657bddbaad6mr823540eaf.8.1764074951827; Tue, 25 Nov 2025
 04:49:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125105453.471445-1-kaushlendra.kumar@intel.com>
In-Reply-To: <20251125105453.471445-1-kaushlendra.kumar@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 25 Nov 2025 13:49:00 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gfcwg1+o5-H5tQVd=xM=D1Gufyzdk-WeD4Vmyz_pstCw@mail.gmail.com>
X-Gm-Features: AWmQ_bnXVAfxFH49vcIkmKgtyFUxAAehqetDAYcvxbu-sBsQHXf4E35ffh8UbUc
Message-ID: <CAJZ5v0gfcwg1+o5-H5tQVd=xM=D1Gufyzdk-WeD4Vmyz_pstCw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: schedutil: Fix tunables_hook cleanup on init failure
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 11:57=E2=80=AFAM Kaushlendra Kumar
<kaushlendra.kumar@intel.com> wrote:
>
> If sugov_init() fails after registering the tunables_hook to the
> global list, the hook is not removed before freeing the tunables
> structure via kobject_put(). This leaves a dangling list entry
> pointing to freed memory.

Except that sugov_init() cannot fail after calling gov_attr_set_get(),
so how can it get to the error path with tunables_hook in the list in
the first place?

> Remove the hook from the list in the error path to prevent this.

There is no bug to fix here AFAICS.

> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_sche=
dutil.c
> index 9fdbc7a6063d..165c58a51a83 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -800,6 +800,7 @@ static int sugov_init(struct cpufreq_policy *policy)
>         return 0;
>
>  fail:
> +       list_del(&sg_policy->tunables_hook);

And this change is invalid.

>         kobject_put(&tunables->attr_set.kobj);
>         policy->governor_data =3D NULL;
>         sugov_clear_global_tunables();
> --

