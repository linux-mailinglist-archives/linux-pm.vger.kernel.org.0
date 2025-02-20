Return-Path: <linux-pm+bounces-22577-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A2EA3E55F
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 20:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 833A719C301E
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2025 19:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07ADF2116F4;
	Thu, 20 Feb 2025 19:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSQR28Mt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F961DED7C
	for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2025 19:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740081304; cv=none; b=AroxngnPhLlCB31LEgic7hcnW6OI2X165VnrNTzCu//SE9r1TWpiv+XkTgi25h9H8HNE61b9j0KZQn3oOu34bBKvcNeg1pmleG6+rJEueanPO6whgaK/+jKsIROT2bai6Ds4WpEDSM2A9ysUDK8foOaiNwfLH3s4d2pmtcbVRlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740081304; c=relaxed/simple;
	bh=2rBM/Bm5GUWqaK009IYMUNwH4GYxPxmbh/7PFCOhdjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iXk6FcVPfaKX3muu2QcgpkvKDDeGppTZ0KV7bdGinlLsEipvRi/3LhTnvHaQn7VyigVJUE1HegZxnKw3vpLiN7C2xMAljSYbqco6DOPraEjGj+FCXoP1w9xcVny8LmR8Z9UMAaJkdlSlDBOrwH8P6BtgMfFyDwFQLIEZ8eBDNFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSQR28Mt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC042C4CED1
	for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2025 19:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740081304;
	bh=2rBM/Bm5GUWqaK009IYMUNwH4GYxPxmbh/7PFCOhdjk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QSQR28Mt2Whd0wb5iCce3T8tbX0VY9FtEleX417LMHSRiQN4UPzjGoVa8qoDRY390
	 Hhbux94r9rDbd3QfNM3XCs63xegga3iIT6b59mfMingKm4DgPJszTIWzUDQ8MVSKJ/
	 JACBQ18tbwFiQ2WL9be3frcdhOhwUr8NqTAN7toXiUphTIcEy9x7/yo5YR1rqtw/32
	 eTLY/FsF8vZ8VDtGM87M3BMvdxy836bjhmv1341zHl+qOdGczsobYH19U8c0Q++Naw
	 ve1/dqZy44zd/60wlr99+mv+l4XC0Td5YrMxzz87dV7awxr5Krd8ne/oj3M9Rkl052
	 qPYNRIOor2pkw==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2a01bcd0143so1002399fac.2
        for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2025 11:55:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVdh0Fr008P45xQaJXUyOQ7kCp0euIqQ1VuDNi6KdYsc7KU15nS3QAtTXLIwoQL8As/+oS/+gmzmA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvmWc33BQWJvLp9dntFio3OsI8/ZlM1zkR4Bo2F+gR84/xjnjR
	Aok9IQK+8uwTKVhezIggCuYo2AOiUwZA0cP3fYbTQlSBJ+bp0DWb475QSYfn/9gabatyDMLgsQz
	eATgVvZ2wQ2zfjdv5xrv+Yn+H8sY=
X-Google-Smtp-Source: AGHT+IFoCGxeqmUel0IvtdmoEq+077bP/2uS8fPtPtwG/hH51o7y5JuQMqO47gMxAx7NyiZ7O9lNqHv7a3IQwLS0KCA=
X-Received: by 2002:a05:6871:358d:b0:29e:4d0e:a2b6 with SMTP id
 586e51a60fabf-2bd50cf31edmr292129fac.10.1740081303997; Thu, 20 Feb 2025
 11:55:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218082021.2766-1-lirongqing@baidu.com> <CAJZ5v0gHUQzjk9vdSrHOU6tCoN0hx291ALW7tVN-JPxW9cVSiw@mail.gmail.com>
 <95135302-9a9f-46c0-a786-8a20ac26801d@arm.com>
In-Reply-To: <95135302-9a9f-46c0-a786-8a20ac26801d@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 20 Feb 2025 20:54:52 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jB7cFS5ZX1SLa2iV3UhxYDhPscbmX7=LyzqipvSgHH_w@mail.gmail.com>
X-Gm-Features: AWEUYZnLWsVgRUXSIhq-bXcYRlF7Dy88Tf-eECHAwJpOulBObdFbzqsEI2XP6Gw
Message-ID: <CAJZ5v0jB7cFS5ZX1SLa2iV3UhxYDhPscbmX7=LyzqipvSgHH_w@mail.gmail.com>
Subject: Re: [PATCH] PM: EM: use kfree_rcu to simplify the code
To: Lukasz Luba <lukasz.luba@arm.com>, lirongqing <lirongqing@baidu.com>
Cc: pavel@kernel.org, len.brown@intel.com, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 3:32=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
>
>
> On 2/18/25 12:49, Rafael J. Wysocki wrote:
> > +Lukasz Luba
> >
> > On Tue, Feb 18, 2025 at 9:20=E2=80=AFAM lirongqing <lirongqing@baidu.co=
m> wrote:
> >>
> >> From: Li RongQing <lirongqing@baidu.com>
> >>
> >> The callback function of call_rcu() just calls kfree(), so use
> >> kfree_rcu() instead of call_rcu() + callback function.
> >>
> >> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> >
> > This looks fine to me.  Lukasz?
>
> Thanks Rafael for letting me know.
>
> >
> >> ---
> >>   kernel/power/energy_model.c | 10 +---------
> >>   1 file changed, 1 insertion(+), 9 deletions(-)
> >>
> >> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> >> index 3874f0e..72655ef 100644
> >> --- a/kernel/power/energy_model.c
> >> +++ b/kernel/power/energy_model.c
> >> @@ -161,14 +161,6 @@ static void em_debug_create_pd(struct device *dev=
) {}
> >>   static void em_debug_remove_pd(struct device *dev) {}
> >>   #endif
> >>
> >> -static void em_destroy_table_rcu(struct rcu_head *rp)
> >> -{
> >> -       struct em_perf_table __rcu *table;
> >> -
> >> -       table =3D container_of(rp, struct em_perf_table, rcu);
> >> -       kfree(table);
> >> -}
> >> -
> >>   static void em_release_table_kref(struct kref *kref)
> >>   {
> >>          struct em_perf_table __rcu *table;
> >> @@ -176,7 +168,7 @@ static void em_release_table_kref(struct kref *kre=
f)
> >>          /* It was the last owner of this table so we can free */
> >>          table =3D container_of(kref, struct em_perf_table, kref);
> >>
> >> -       call_rcu(&table->rcu, em_destroy_table_rcu);
> >> +       kfree_rcu(table, rcu);
> >>   }
> >>
> >>   /**
> >> --
> >> 2.9.4
> >>
>
> That should work the same way, nice cleanup.
> Thanks Li!
> LGTM,
>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Applied as 6.15 material, thanks!

