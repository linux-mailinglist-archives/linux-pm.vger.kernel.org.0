Return-Path: <linux-pm+bounces-41905-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKUfHF+PgGkl+wIAu9opvQ
	(envelope-from <linux-pm+bounces-41905-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 12:49:51 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 897E6CBEB0
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 12:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 777223002D21
	for <lists+linux-pm@lfdr.de>; Mon,  2 Feb 2026 11:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87390361DD9;
	Mon,  2 Feb 2026 11:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qAg5KWSf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC80835BDBF
	for <linux-pm@vger.kernel.org>; Mon,  2 Feb 2026 11:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770032984; cv=pass; b=BCddW/q/kUKfRHE4rkJeQSIru4JOYKMiFxBAxBLam+y1c3uBeeafN3YLKUahPkbGn6u4xuWLW12BBUH+OV9s9r27OOYTBn5E//wkZmCCuUxsBTJfsJelkFL2WjTwFA7CCXvxAgpicz1XkRTbwykRD+e84MCC1qEMkml17QYS0y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770032984; c=relaxed/simple;
	bh=V6UT7YJf7SzVhSaId4KL5+brO2XmYYoegjx1xiRkqP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FxFightjikHI1Q8WEWPw/Q6/osHrm3FSIAxJv/EOBSKD/H02mKbvBeqpgWAowGtniQhIDnIYPWYx1WViEXe4szUa3PdzHMHWtrSU3vPos7bSCdLptpoxfgIX1Jo7sT9rOLf+jSJVcqt1i88fsq9iFTqnaAuipXzMmM+zazANEaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qAg5KWSf; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59dd22b9895so5691877e87.0
        for <linux-pm@vger.kernel.org>; Mon, 02 Feb 2026 03:49:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770032981; cv=none;
        d=google.com; s=arc-20240605;
        b=dDQk3GugdplqgX5xSDBLpFU1sfLJpd5hvYKybkitBsQGLawGAGaWZCwmPX+Zd97VHH
         jQGfUj8GQoQ3s41jrYVKAbnwadr1jS5gTFCoZlLLDHOXxgBMEYFt80zNUrtIPQg/EXGp
         o05DWJReSXKGY+rBOV9ZnZKYVW9c50CQZ6LJDDyQfZ/83/vlry7x81E+fjMo3QsQYyLv
         pQpXd8RFJEM0DLwJpo4WuolDbkVtMysPvYKc/zQwx3DyP0gYIQLvUxu0TiC22BvRRrdb
         czwNDVv+KcfxjHbG/f+n0S8uVv9uAPf81Q/vPhNT+0Zqiinn/sthhO/lfySJFm7R5wma
         e3FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lflCJMMdLfW+SFIu98NAJWWvfB8S8GTPpoPz2kFLSCk=;
        fh=UFV4BNnqxg8o50Ned/Aq391sgVpkx/kSKAxf4s61drk=;
        b=kmZ/dbmxewrPrzebys9Bht4iU2H/9mcoPNe4Ha89ycalOcmc+59beJs9K0ZfQgeOQN
         iKQZPnIq4pfB8GrEGlE2uApMUAEg0gRKAftTbQUCO0/7HCxqVj2+hZ6v/x+V07VA0gV7
         1MwEgDzMasWd7B9wrUqTv6xUWowjw1F6AIrfVvzX3bQjee4DAxPUcLb1L9kIYteQL2xn
         B3eR43aDdAHk7+rQlhsIIZXxi+JtuPHAdxxWvmUpk7+zalJdLN7XF3kkUKiFTkuzqaB+
         wjwOADunybJR5Rbax5Fb4AAvDjh6a5F6gD0FMUt6bgmNLIelilkwkgfeUubFrrrEGMzR
         S4nw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770032981; x=1770637781; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lflCJMMdLfW+SFIu98NAJWWvfB8S8GTPpoPz2kFLSCk=;
        b=qAg5KWSfeE6n5yTmpyTc/JbEM8x1gwx6mrwxt7By1qZtA7fThHpaJiW2E6YBxFg30E
         tS3lVRz2Ei4TK/dJmDgLSCLl7MBTjbrvOafGUpHNWWq+oE5HclZyyTHe8ERgkn46a2S/
         kKYH42NNAEyRzKt73nzyJgVMCXvjAmU80L3l6u9clqKH6oBSaWxWiQYi4HKQVuBnx5xB
         0TGXOyss6Xj6kBTNqWBQUnVr2WV0faboyD9GUCa4IYUH5WwgrSmQpzR+NuY+LzpPqATA
         b9bQ8TcpL4Z4jfP3mnXtyM8WWDjTOGSB1Aw1DEJagjn3cywH0AYjqV1cCFVoDBhQhCHt
         zWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770032981; x=1770637781;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lflCJMMdLfW+SFIu98NAJWWvfB8S8GTPpoPz2kFLSCk=;
        b=kHkSrXpInYAaEtwdWU8uVXxoi8Y78uLltr7D0Fdril1jQXYl0ZggfgGYQoRUYg4uJF
         HYHEBPD1mFgTASv/hletSDi/ywBq7JV+3cu+hBeTu5mfO7V9mqJk8ZJZYAs3AFXZg2V2
         Lsi4lDUQFJMNjwUSVb5hJK21AeQeU5/UJtrmCQ8zmJzMGj+kDN/iMWpB05t/KPvoS55d
         1JphmJAQ5T2vv+bi93553FKQ0LfMP9+wGHzC8932fc7kKAv1as8CtOG585FJ+iE3BaNJ
         ZNIiTmvxYOt1I38oOnltz27NSQpgKMNxed3BgpP+jefCzVbTWxrBzvoR0sWHjixwsymE
         adxA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ5KeSwz/wFmZ1jYSBKjG322Q1ZjF09xkdPdJQl7x53SqC0K+d1AsXZhrTopQYsDfdj2CiOI8uiw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yys80FhBi9dUgXqrRqV7sQK4D9ifuvMb6m/fHqGsq0NwAJevg0Y
	SumMBoiLwp1WXYa0388i1zp3W7SRwH2v8vMI3ATjpwBwwzuGegWDiRdYUnbeyA6e5jatH+M17Jp
	8i5Is1iKIeF6ysMjjwapi/lREa3UMpWK2v7kE/4ezTod0M0Hln4Wdm8WNlw==
X-Gm-Gg: AZuq6aJrsJI3TH4Q/ptD0ijAnkIIHmyx8zkw3An46Hvjul+9md+Lhnu/CLxMUgGp6TT
	M1iEiaysQHfWapUTgJTMdX4TR15701EVRzvh3wzWKNwQc5jlhNBFtu4N+y0ZiSG0We3IGVdP0NO
	XWuUdh86R4Lsqbce5fRYSk/HXhzHbqm3YFWm0kjFrM5lL739Swh6bUIKIo9jeJPxhM+4vkem4JM
	a6GurEfjLDQmA1mQgMAayJYkPpJJganmdeC+QQj3xU6NCRsCPc2lGs40yuirm2T1CmG0Pkc
X-Received: by 2002:a05:6512:33ca:b0:59d:f5a6:bea9 with SMTP id
 2adb3069b0e04-59e163d444bmr4514178e87.1.1770032980842; Mon, 02 Feb 2026
 03:49:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120-topic-lpm-pmdomain-device-constraints-v1-0-108fc4cfafce@baylibre.com>
 <20260120-topic-lpm-pmdomain-device-constraints-v1-2-108fc4cfafce@baylibre.com>
In-Reply-To: <20260120-topic-lpm-pmdomain-device-constraints-v1-2-108fc4cfafce@baylibre.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 2 Feb 2026 12:49:05 +0100
X-Gm-Features: AZwV_QhrpV7fvBdDsFiviU0WjKpezClDXoKKLPIVYotLrUQyDFwLnVqTP2ip1-0
Message-ID: <CAPDyKFpq_mkyGfR-OYwTU3k62fkzXWiz07ZSR5j+FY72vYXxmQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] pmdommain: add support system-wide resume latency constraints
To: "Kevin Hilman (TI)" <khilman@baylibre.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Dhruva Gole <d-gole@ti.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41905-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,baylibre.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 897E6CBEB0
X-Rspamd-Action: no action

On Wed, 21 Jan 2026 at 02:54, Kevin Hilman (TI) <khilman@baylibre.com> wrote:
>
> In addition to checking for CPU latency constraints when checking if
> OK to power down a domain, also check for QoS latency constraints in
> all devices of a domain and use that in determining the final latency
> constraint to use for the domain.
>
> Since cpu_system_power_down_ok() is used for system-wide suspend, the
> per-device constratints are only relevant if the LATENCY_SYS QoS flag
> is set.
>
> Because this flag implies the latency constraint only applies to
> system-wide suspend, also check the flag in
> dev_update_qos_constraint(). If it is set, then the constraint is not
> relevant for runtime PM decisions.
>
> Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
> ---
>  drivers/pmdomain/governor.c | 42 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/governor.c b/drivers/pmdomain/governor.c
> index 96737abbb496..03802a859a78 100644
> --- a/drivers/pmdomain/governor.c
> +++ b/drivers/pmdomain/governor.c
> @@ -31,6 +31,8 @@ static int dev_update_qos_constraint(struct device *dev, void *data)
>                 constraint_ns = td ? td->effective_constraint_ns :
>                                 PM_QOS_RESUME_LATENCY_NO_CONSTRAINT_NS;
>         } else {
> +               enum pm_qos_flags_status flag_status;
> +
>                 /*
>                  * The child is not in a domain and there's no info on its
>                  * suspend/resume latencies, so assume them to be negligible and
> @@ -38,7 +40,14 @@ static int dev_update_qos_constraint(struct device *dev, void *data)
>                  * known at this point anyway).
>                  */
>                 constraint_ns = dev_pm_qos_read_value(dev, DEV_PM_QOS_RESUME_LATENCY);
> -               constraint_ns *= NSEC_PER_USEC;
> +               flag_status = dev_pm_qos_flags(dev, PM_QOS_FLAG_LATENCY_SYS);
> +               if ((constraint_ns != PM_QOS_RESUME_LATENCY_NO_CONSTRAINT) &&
> +                           (flag_status == PM_QOS_FLAGS_ALL)) {
> +                       dev_dbg_once(dev, "resume-latency only for system-wide.  Ignoring.\n");
> +                       constraint_ns = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT_NS;
> +               } else {
> +                       constraint_ns *= NSEC_PER_USEC;
> +               }
>         }

dev_update_qos_constraint() is called only to take into account the
QoS constraints for the device's *children*.

It looks like we should also be checking the PM_QOS_FLAG_LATENCY_SYS
flag in default_suspend_ok() for the device in question.

That said, there seems to be more places in the kernel where we should
check the PM_QOS_FLAG_LATENCY_SYS flag, like in cpu_power_down_ok(),
cpuidle_governor_latency_req(), etc.

>
>         if (constraint_ns < *constraint_ns_p)
> @@ -430,12 +439,43 @@ static bool cpu_system_power_down_ok(struct dev_pm_domain *pd)
>         s64 constraint_ns = cpu_wakeup_latency_qos_limit() * NSEC_PER_USEC;
>         struct generic_pm_domain *genpd = pd_to_genpd(pd);
>         int state_idx = genpd->state_count - 1;
> +       struct pm_domain_data *pdd;
> +       s32 min_dev_latency = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
> +       s64 min_dev_latency_ns = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT_NS;
> +       struct gpd_link *link;
>
>         if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN)) {
>                 genpd->state_idx = state_idx;
>                 return true;
>         }
>
> +       list_for_each_entry(link, &genpd->parent_links, parent_node) {
> +               struct generic_pm_domain *child_pd = link->child;
> +
> +               list_for_each_entry(pdd, &child_pd->dev_list, list_node) {
> +                       enum pm_qos_flags_status flag_status;
> +                       s32 dev_latency;
> +
> +                       dev_latency = dev_pm_qos_read_value(pdd->dev, DEV_PM_QOS_RESUME_LATENCY);
> +                       flag_status = dev_pm_qos_flags(pdd->dev, PM_QOS_FLAG_LATENCY_SYS);
> +                       if ((dev_latency != PM_QOS_RESUME_LATENCY_NO_CONSTRAINT) &&
> +                           (flag_status == PM_QOS_FLAGS_ALL)) {
> +                               dev_dbg(pdd->dev,
> +                                       "in domain %s, has QoS system-wide resume latency=%d\n",
> +                                       child_pd->name, dev_latency);
> +                               if (dev_latency < min_dev_latency)
> +                                       min_dev_latency = dev_latency;
> +                       }
> +               }

cpu_system_power_down_ok() is at the moment only used for CPU PM
domains. If the intent is to take into account QoS constraints for
CPUs, we should check the QoS value for CPU-devices as well (by using
get_cpu_device(), see cpu_power_down_ok(). For non-CPU devices
something along the lines of the above makes sense to me.

Although, please note, the above code is just walking through the
devices in the child-domains, there is nothing checking the devices
that belong to the current/parent-domain. Nor are we taking
child-devices into account.

> +       }
> +
> +       /* If device latency < CPU wakeup latency, use it instead */
> +       if (min_dev_latency != PM_QOS_RESUME_LATENCY_NO_CONSTRAINT) {
> +               min_dev_latency_ns = min_dev_latency * NSEC_PER_USEC;
> +               if (min_dev_latency_ns < constraint_ns)
> +                       constraint_ns = min_dev_latency_ns;
> +       }
> +
>         /* Find the deepest state for the latency constraint. */
>         while (state_idx >= 0) {
>                 s64 latency_ns = genpd->states[state_idx].power_off_latency_ns +
>
> --
> 2.51.0
>

Kind regards
Uffe

