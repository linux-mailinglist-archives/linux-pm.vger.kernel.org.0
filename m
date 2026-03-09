Return-Path: <linux-pm+bounces-43944-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCVBOsPArmmRIgIAu9opvQ
	(envelope-from <linux-pm+bounces-43944-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 13:44:51 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2178D239120
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 13:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9FC0E3019FCB
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2026 12:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F173B3C18;
	Mon,  9 Mar 2026 12:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ki33jdWM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A905D3B3BE2
	for <linux-pm@vger.kernel.org>; Mon,  9 Mar 2026 12:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773059563; cv=none; b=VGxeIGM1H951By/kvVH6WhywcAxkmVCR+cnlsoXAfd+meXsfCfw72R0Xk+yxwOXW/MdgCO+A4EnKxyRkkJXU6vScAH3vt9+pf9tZCGr/SyiXl9Lci2+dwlInu4mZDB2Fh9YuJmqUgZZsX0vlx1f8rbh2260Ub6Rvt2mfa7GL/ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773059563; c=relaxed/simple;
	bh=0t9PL769plo69GiPNoeP8XmsLvwzogYcoHd0DNiVT7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b+U/zDHvz7HYG9JvIqjviAlCHKYp6Iq7H006RFYzsFfFetGm+SZQ2V7jM5XKk/3nHNS0noMnlH0OpeN2SV0l/ZqT+Wilq0VQG5WAK7dUSDWyBA3LG4uctLboAM6wusFfvWB/mOUdblHt6jPlL1FCRD6m5b1XFQs0IPLRhCbp2PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ki33jdWM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE3AC4AF09
	for <linux-pm@vger.kernel.org>; Mon,  9 Mar 2026 12:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773059563;
	bh=0t9PL769plo69GiPNoeP8XmsLvwzogYcoHd0DNiVT7M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ki33jdWM8JX+s5hiIJCTvjNgcYmQhNXLAseLSupj6jZq3MrPSLUyuEkfzUMZNXies
	 fnRZ8Q8goGz18osoVYefFD/CwLvdSbzuS5PCDOwS637JyCqHG689uT72NlFaEzPK/P
	 9oAMN/HksOCs81xBVOQinKdzR6M5skyppZPFY8tYL+dc/pIVBUNs6PA8acVLgDENgw
	 frtRdejtHbitnvxUM+hfo+ay75n833FY3qU8yijT/+ZqkCgxUtB3ZFtyWjtxnpayBS
	 hPcwicsRDR9gvvU+/wSElnKhjeGlrED3vyzUYzIEp/RVTRGFxOwDZjhypeuxs4GCdX
	 2RuyQg80OpUSA==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-67ba58c0220so1123383eaf.0
        for <linux-pm@vger.kernel.org>; Mon, 09 Mar 2026 05:32:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUgZhUkprltzKB8vkD+4MCF5uNqFG19v0NZ7EkbfbXt7Qtf3JJOYif7qxyYDvVb6YocWSxZSEQ6Rg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/EdoXlahW+gdBu0BkSACMbr6M8qjDXdu2Lqk2y8F3EFkYqtDG
	J0fdHyxvK8jc8ycBEpBTv1dO4dqmcWlf0gnW5w099Az1nZrKxW/VXa2lz4yH8NcB98OjdEjRKLk
	F4ML3f727ml7DkvU3MCjv08JWY+vIePc=
X-Received: by 2002:a05:6820:178b:b0:67b:abc9:9c7a with SMTP id
 006d021491bc7-67babc9ab2cmr3935314eaf.14.1773059561833; Mon, 09 Mar 2026
 05:32:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210115458.3493646-1-zhenglifeng1@huawei.com> <javy6tllyw7pcnri3s6s2gnpv3kewe2b4zkyoz3vj3jzmfu6c5@nikhlydadvcc>
In-Reply-To: <javy6tllyw7pcnri3s6s2gnpv3kewe2b4zkyoz3vj3jzmfu6c5@nikhlydadvcc>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 9 Mar 2026 13:32:30 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h1FHH0Cvn0CQ8gMk9Zzt=bcA-RUfya4hYH4Em3nDzm7w@mail.gmail.com>
X-Gm-Features: AaiRm50ucsOkpJ1e7GgfyGiHSA_clP0ot-KQtQ-ueNeQWt6fpV4UZpOZM3Oo61s
Message-ID: <CAJZ5v0h1FHH0Cvn0CQ8gMk9Zzt=bcA-RUfya4hYH4Em3nDzm7w@mail.gmail.com>
Subject: Re: [PATCH 0/2] cpufreq: governor: Apply limits with target_freq
 instead of policy->cur
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rafael@kernel.org, Lifeng Zheng <zhenglifeng1@huawei.com>, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, lihuisong@huawei.com, 
	yubowen8@huawei.com, zhangpengjie2@huawei.com, wangzhi12@huawei.com, 
	linhongye@h-partners.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2178D239120
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43944-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-0.944];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linaro.org:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 9:27=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.or=
g> wrote:
>
> On 10-02-26, 19:54, Lifeng Zheng wrote:
> > The motivation for this patchset cames from a test on our platform:
> >
> > With conservative governor and some pressure on CPU, the frequency rapi=
dly
> > reach the max supported frequency, such as 2GHz.
> >
> > Later, some frequency division strategies on our platform were triggere=
d
> > and the actual frequency become 500MHz -- 1/4 of the OS distribution
> > frequency.
> >
> > At that time, if someone excecutes 'cat cpuinfo_cur_freq', the actual
> > frequency will become 250MHz -- 1/4 of the min supported frequency.
> >
> > After the platform recovering from the frequency division, the frequenc=
y
> > will stay on 1GHz, until the pressure disappear.
> >
> > The reason this happens is that in cpufreq_verify_current_freq(), if
> > policy->cur !=3D new_freq, policy->update will be queued, which will
> > ultimately lead to a call to cpufreq_policy_apply_limits(), and update =
the
> > target frequency to policy->min. And then in cs_dbs_update(), since the
> > pressure never vanish, it will always hit the following branches:
> >
> >       if (load > dbs_data->up_threshold) {
> >               dbs_info->down_skip =3D 0;
> >
> >               /* if we are already at full speed then break out early *=
/
> >               if (requested_freq =3D=3D policy->max)
> >                       goto out;
> >
> > Therefore, the target frequency will always remain at the lowest freque=
ncy.
> >
> > The branching conditions in cs_dbs_update() may not be strict enough, b=
ut
> > the root cause of this problem is that the target frequency was updated
> > when querying cpuinfo_cur_freq. For ondemand and schedutil governor,
> > although the frequency will not always remain at the lowest level witho=
ut
> > rising, will still be min_freq in a short period of time when the query
> > action occurs.
> >
> > Using the freq requested by the governor to decide whether to update th=
e
> > target frequency is more reasonable in cpufreq_policy_apply_limits().
>
> I think I understand the problem now. We are tracking the current
> frequency state via two cached values, policy->cur and requested_freq
> and a mismatch (because of your hardware specific quirks/features)
> between them is making things tricky.
>
> Rafael, will this break anything we can think about ?

I can't recall, but the new code is simpler, so unless anyone has a
particular heartburn with it, go for it.

> diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpu=
freq_conservative.c
> index e0e847764511..c69577e4f941 100644
> --- a/drivers/cpufreq/cpufreq_conservative.c
> +++ b/drivers/cpufreq/cpufreq_conservative.c
> @@ -14,7 +14,6 @@
>  struct cs_policy_dbs_info {
>         struct policy_dbs_info policy_dbs;
>         unsigned int down_skip;
> -       unsigned int requested_freq;
>  };
>
>  static inline struct cs_policy_dbs_info *to_dbs_info(struct policy_dbs_i=
nfo *policy_dbs)
> @@ -59,10 +58,10 @@ static unsigned int cs_dbs_update(struct cpufreq_poli=
cy *policy)
>  {
>         struct policy_dbs_info *policy_dbs =3D policy->governor_data;
>         struct cs_policy_dbs_info *dbs_info =3D to_dbs_info(policy_dbs);
> -       unsigned int requested_freq =3D dbs_info->requested_freq;
>         struct dbs_data *dbs_data =3D policy_dbs->dbs_data;
>         struct cs_dbs_tuners *cs_tuners =3D dbs_data->tuners;
>         unsigned int load =3D dbs_update(policy);
> +       unsigned int requested_freq =3D policy->cur;
>         unsigned int freq_step;
>
>         /*
> @@ -72,16 +71,6 @@ static unsigned int cs_dbs_update(struct cpufreq_polic=
y *policy)
>         if (cs_tuners->freq_step =3D=3D 0)
>                 goto out;
>
> -       /*
> -        * If requested_freq is out of range, it is likely that the limit=
s
> -        * changed in the meantime, so fall back to current frequency in =
that
> -        * case.
> -        */
> -       if (requested_freq > policy->max || requested_freq < policy->min)=
 {
> -               requested_freq =3D policy->cur;
> -               dbs_info->requested_freq =3D requested_freq;
> -       }
> -
>         freq_step =3D get_freq_step(cs_tuners, policy);
>
>         /*
> @@ -113,7 +102,6 @@ static unsigned int cs_dbs_update(struct cpufreq_poli=
cy *policy)
>
>                 __cpufreq_driver_target(policy, requested_freq,
>                                         CPUFREQ_RELATION_HE);
> -               dbs_info->requested_freq =3D requested_freq;
>                 goto out;
>         }
>
> @@ -137,7 +125,6 @@ static unsigned int cs_dbs_update(struct cpufreq_poli=
cy *policy)
>
>                 __cpufreq_driver_target(policy, requested_freq,
>                                         CPUFREQ_RELATION_LE);
> -               dbs_info->requested_freq =3D requested_freq;
>         }
>
>   out:
> @@ -310,7 +297,6 @@ static void cs_start(struct cpufreq_policy *policy)
>         struct cs_policy_dbs_info *dbs_info =3D to_dbs_info(policy->gover=
nor_data);
>
>         dbs_info->down_skip =3D 0;
> -       dbs_info->requested_freq =3D policy->cur;
>  }
>
>  static struct dbs_governor cs_governor =3D {
>
> -------------------------8<-------------------------
>
> This always pick the next freq based on policy->cur instead of the
> real last request. The two can differ if:
> - the hardware plays with current frequency, as is the case here.
> - or the limits change and that changes the current frequency (in
>   which case we will be at policy->min/max anyway).
>
> --
> viresh

