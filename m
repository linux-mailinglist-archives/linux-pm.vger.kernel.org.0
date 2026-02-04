Return-Path: <linux-pm+bounces-42082-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFh1MWhMg2ktlAMAu9opvQ
	(envelope-from <linux-pm+bounces-42082-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 14:40:56 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC12E6970
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 14:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E16E30E604E
	for <lists+linux-pm@lfdr.de>; Wed,  4 Feb 2026 13:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E57523E340;
	Wed,  4 Feb 2026 13:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qXFNUdaY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8EA259CB6
	for <linux-pm@vger.kernel.org>; Wed,  4 Feb 2026 13:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770212022; cv=pass; b=dmjy2EGFtZ9cSQZMXzLOt4NPp+LlX33sU3MhqEDjiYs0bPXL97T4aAr3ReAKSmde4HmWm+7c7TSS06ZOxOz3Cznmtql19Iw8j5WrERBBg+e2UzoYPm7iw3wzhr7DUgi6Z2Awwd66d6/8AfymECuFYI9xUIHTQ+6cSbtxsJRRMiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770212022; c=relaxed/simple;
	bh=ttlTad9DbJx6oMk5pXXTJKyxin7dPAzArBty89YPo3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O7awG/7DhD59OUEJ+ROgwPJIXdG7hllASY40y+Z29GEL3dpj2nlzRyddftrtzrRwxOvYzcMUub6YlEUI00GjlnIiQoZQ+ODag4V0gLlq5ZqCEgJN900/sr9RNaSBx3P9HCnAcRDE0390MfKX0o+o4hwp1suQKddWoZ6c1FeJtI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qXFNUdaY; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59de77e2e30so8899888e87.2
        for <linux-pm@vger.kernel.org>; Wed, 04 Feb 2026 05:33:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770212020; cv=none;
        d=google.com; s=arc-20240605;
        b=NkVn1BWQyegQUJCkjBe1SpcZtFr3NSyOjHOdqJtM0d8jJ57oDBDyOWUBMApAdXyrTd
         WjP3TTKY8kFD2aOS42nzU4zNiN6Jl7lAAoAWMdHHh04xt4lkohtA/1q4amHM8s+Q/jbr
         tvKUPjE0bJO8byGI5aGav0rle4Nm8zZ8XLXE2bGLmZ2CtT7zXgni9BLoylaXB6I84F0+
         C99aoANbJKvxfaEewLjhGWo8b2JuKGhtyqdEcyI7b6S/0PihucICjuEdSZ37BLp3SzY5
         kmts61tZ+J8rEk1Ycsi5sZ+lRposLV+/h7pRw8mrZgzpTM084S4tpsso+vIlpiMcDyKG
         4E3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/FIWYACO8NHyREBDKDALatNvf55fws3dUcYhe7JKcyM=;
        fh=DvZTbirA04ffDRI5lHYAdysVqt5Ca9AlSoHmzG/0yNk=;
        b=JqtBuvDjhKS9QnNUFlgLGEAIM9RFDbgcWE529AIvnLU55wG0U2QdQvPjlsmRsGbpW7
         dSPAMIWmssQiE7ODbNup8YU8W7VyAKZiKK3K5QqH66Tods83sxgAQfR86mswmrScPaRA
         n5vxJG0XyTK/c5YRBQrzUVoeheFnrBSf3vpuyEcziiz4S7QEdKNHSBuP1Xh0nVo9pZ8G
         4kIbnGuLUOmpaFHBmk93YfKLA3+HE90M5Gn2jkTo0jcKVRfauybcoiR0Rylw3JcXllA8
         zzwLtdxYa18vwaMMkes7ocrnrYRcIC8VfurCygvuUIyEn+bEZnDrQ5CiVA11e0uLjm3Y
         viCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770212020; x=1770816820; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/FIWYACO8NHyREBDKDALatNvf55fws3dUcYhe7JKcyM=;
        b=qXFNUdaYcN6OScr58ZaoeGFyvLcsPVkKPn9CKjUmbKCzEzcEkMYO/heXjal+pyAg07
         /d2l0ewRDssrzCyxPPoaa336HOvb0/CQctrCRF8HNBy7oNJHVrxJy7ksLyi5WJqEvZlB
         2L75SxOg94XGlY0pnsr3/djUY+oOh/jiDni985al5ORCun7K0r+dWZ+Fr+2t+LUnL6U1
         9u1mrU3NfDh+sA554J//+zGhDiWgivODtR92HbnrTGDbKrW+NnwxdV8ttlFZsNliV29h
         NBmdYfVAhl6OAHvicnUxNvvbxp4JWnf0iY24/tnQZ6EDyH3L4pg6OBp9QrLqHuD9Uffd
         cM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770212020; x=1770816820;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/FIWYACO8NHyREBDKDALatNvf55fws3dUcYhe7JKcyM=;
        b=QwCr30G0MinGOHv08V/i3WSbrqsnIcsU2e/Gpd7Xz8dbay+mxNwTkktcESK2xfxeAq
         6TCnUGQuDCFA9BdOk/csZGcEPamISDGNfky1QdHvsPoZulxFmUbWOeGn9c+nQkZsBzF0
         bXM+XXtYIaNZe5lHv53raGMJbz3b9ILGLnJpH1O7UNjXoaLbfJchwvUclkOcCzQda3B4
         sVz0r+t2BH3iV4CBmAlSGd4h64DyXHr/1dApBI4hPW2LqfmiiJGZC9vuaMZThvb95V4X
         /XjBLu3RVeh20VmUAUrCtLjmSWuhFJVNh7FHY/S64Kyvg8JDkXMQwzzYhvd4b3mg29X8
         k8vg==
X-Forwarded-Encrypted: i=1; AJvYcCWN5XNQdsLveNshjTrJstpbwAS2DruntO+Uv20Vr8JnVnFwbBgUtbvrgrbFDzQE3EYbsAXScwO+zg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcUOWYovNZ79EtSTE0koaoxm9SYuUpnsbSORJZH8MAaaYutgGe
	WOaT+SuQfAfhSy1SChpsJ1f/4eptvwJDVG9366+5SgTrlHEYclMxNTC1zulo6piIsdWTHVwdFzr
	P/CIyLEicx6nzjSYZj8L0vWPEi1fK/uUZHJIIzaa5Sw==
X-Gm-Gg: AZuq6aJ5gYV3ntvB7HEcNIfSBy9xTvePhEncj/R3rxHxcOZXrQOtNI3HitiNUmGefax
	gEAo0TncAKI04Pn0+SrKlEAVBdhF1GAJ6904uEAwOydiL88I85tFuRpOUuHdmqcsyY3O19iWwRo
	VjJWqoWX8B3nQM3NODWA36Zj3HOPZy8GsZZKqwLIgBNp0eFsZaF8kNo1TYVcM1v3Iu9+EhcfSDP
	5nM+E839ERIp0G2SjTkf0CM3qxX/CyozhzgCXwR53vpGmrC8v5aFiuH5E3lC1t+VACi0kpX
X-Received: by 2002:ac2:4e01:0:b0:59e:38ae:4af9 with SMTP id
 2adb3069b0e04-59e38c2deb4mr1111648e87.38.1770212019433; Wed, 04 Feb 2026
 05:33:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120-topic-lpm-pmdomain-device-constraints-v1-0-108fc4cfafce@baylibre.com>
 <20260120-topic-lpm-pmdomain-device-constraints-v1-2-108fc4cfafce@baylibre.com>
 <CAPDyKFpq_mkyGfR-OYwTU3k62fkzXWiz07ZSR5j+FY72vYXxmQ@mail.gmail.com> <7hbji5za76.fsf@baylibre.com>
In-Reply-To: <7hbji5za76.fsf@baylibre.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 4 Feb 2026 14:33:02 +0100
X-Gm-Features: AZwV_QgmXIqA4ycV22NOBfzK-Cevprw9InFcjGfsYE7IX4VIzxjQQpES3D9dd-s
Message-ID: <CAPDyKFoKhnt-vz-vYO3Tnr93pe3b_2md9HL5XKo8MOX9_tkqnQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] pmdommain: add support system-wide resume latency constraints
To: Kevin Hilman <khilman@baylibre.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Dhruva Gole <d-gole@ti.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42082-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,linaro.org:dkim,baylibre.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2EC12E6970
X-Rspamd-Action: no action

On Wed, 4 Feb 2026 at 00:19, Kevin Hilman <khilman@baylibre.com> wrote:
>
> Ulf Hansson <ulf.hansson@linaro.org> writes:
>
> > On Wed, 21 Jan 2026 at 02:54, Kevin Hilman (TI) <khilman@baylibre.com> wrote:
> >>
> >> In addition to checking for CPU latency constraints when checking if
> >> OK to power down a domain, also check for QoS latency constraints in
> >> all devices of a domain and use that in determining the final latency
> >> constraint to use for the domain.
> >>
> >> Since cpu_system_power_down_ok() is used for system-wide suspend, the
> >> per-device constratints are only relevant if the LATENCY_SYS QoS flag
> >> is set.
> >>
> >> Because this flag implies the latency constraint only applies to
> >> system-wide suspend, also check the flag in
> >> dev_update_qos_constraint(). If it is set, then the constraint is not
> >> relevant for runtime PM decisions.
> >>
> >> Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
> >> ---
> >>  drivers/pmdomain/governor.c | 42 +++++++++++++++++++++++++++++++++++++++++-
> >>  1 file changed, 41 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/pmdomain/governor.c b/drivers/pmdomain/governor.c
> >> index 96737abbb496..03802a859a78 100644
> >> --- a/drivers/pmdomain/governor.c
> >> +++ b/drivers/pmdomain/governor.c
> >> @@ -31,6 +31,8 @@ static int dev_update_qos_constraint(struct device *dev, void *data)
> >>                 constraint_ns = td ? td->effective_constraint_ns :
> >>                                 PM_QOS_RESUME_LATENCY_NO_CONSTRAINT_NS;
> >>         } else {
> >> +               enum pm_qos_flags_status flag_status;
> >> +
> >>                 /*
> >>                  * The child is not in a domain and there's no info on its
> >>                  * suspend/resume latencies, so assume them to be negligible and
> >> @@ -38,7 +40,14 @@ static int dev_update_qos_constraint(struct device *dev, void *data)
> >>                  * known at this point anyway).
> >>                  */
> >>                 constraint_ns = dev_pm_qos_read_value(dev, DEV_PM_QOS_RESUME_LATENCY);
> >> -               constraint_ns *= NSEC_PER_USEC;
> >> +               flag_status = dev_pm_qos_flags(dev, PM_QOS_FLAG_LATENCY_SYS);
> >> +               if ((constraint_ns != PM_QOS_RESUME_LATENCY_NO_CONSTRAINT) &&
> >> +                           (flag_status == PM_QOS_FLAGS_ALL)) {
> >> +                       dev_dbg_once(dev, "resume-latency only for system-wide.  Ignoring.\n");
> >> +                       constraint_ns = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT_NS;
> >> +               } else {
> >> +                       constraint_ns *= NSEC_PER_USEC;
> >> +               }
> >>         }
> >
> > dev_update_qos_constraint() is called only to take into account the
> > QoS constraints for the device's *children*.
> >
> > It looks like we should also be checking the PM_QOS_FLAG_LATENCY_SYS
> > flag in default_suspend_ok() for the device in question.
> >
> > That said, there seems to be more places in the kernel where we should
> > check the PM_QOS_FLAG_LATENCY_SYS flag, like in cpu_power_down_ok(),
> > cpuidle_governor_latency_req(), etc.
>
> OK.  But now that we've agreed to drop the userspace interface for this,
> I wonder if the better approach is now to consider the flag to mean that
> the latency applies to runtime PM *and* system-wide PM.   Then, without
> the flag set, the latency applies *only* to runtime PM.
>
> That approach would allow the current default behavior to stay the same,
> and not require adding checks for this flag throughout the runtime code,
> and only require checking for the flag in the system-wide PM paths.

I agree with all of the above!

It would certainly make this less intrusive and it would also be more
consistent with what we did for CPU QoS.

>
> >>         if (constraint_ns < *constraint_ns_p)
> >> @@ -430,12 +439,43 @@ static bool cpu_system_power_down_ok(struct dev_pm_domain *pd)
> >>         s64 constraint_ns = cpu_wakeup_latency_qos_limit() * NSEC_PER_USEC;
> >>         struct generic_pm_domain *genpd = pd_to_genpd(pd);
> >>         int state_idx = genpd->state_count - 1;
> >> +       struct pm_domain_data *pdd;
> >> +       s32 min_dev_latency = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
> >> +       s64 min_dev_latency_ns = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT_NS;
> >> +       struct gpd_link *link;
> >>
> >>         if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN)) {
> >>                 genpd->state_idx = state_idx;
> >>                 return true;
> >>         }
> >>
> >> +       list_for_each_entry(link, &genpd->parent_links, parent_node) {
> >> +               struct generic_pm_domain *child_pd = link->child;
> >> +
> >> +               list_for_each_entry(pdd, &child_pd->dev_list, list_node) {
> >> +                       enum pm_qos_flags_status flag_status;
> >> +                       s32 dev_latency;
> >> +
> >> +                       dev_latency = dev_pm_qos_read_value(pdd->dev, DEV_PM_QOS_RESUME_LATENCY);
> >> +                       flag_status = dev_pm_qos_flags(pdd->dev, PM_QOS_FLAG_LATENCY_SYS);
> >> +                       if ((dev_latency != PM_QOS_RESUME_LATENCY_NO_CONSTRAINT) &&
> >> +                           (flag_status == PM_QOS_FLAGS_ALL)) {
> >> +                               dev_dbg(pdd->dev,
> >> +                                       "in domain %s, has QoS system-wide resume latency=%d\n",
> >> +                                       child_pd->name, dev_latency);
> >> +                               if (dev_latency < min_dev_latency)
> >> +                                       min_dev_latency = dev_latency;
> >> +                       }
> >> +               }
> >
> > cpu_system_power_down_ok() is at the moment only used for CPU PM
> > domains. If the intent is to take into account QoS constraints for
> > CPUs, we should check the QoS value for CPU-devices as well (by using
> > get_cpu_device(), see cpu_power_down_ok(). For non-CPU devices
> > something along the lines of the above makes sense to me.
> >
> > Although, please note, the above code is just walking through the
> > devices in the child-domains, there is nothing checking the devices
> > that belong to the current/parent-domain.
>
> Oops, yeah.  Good catch.
>
> > Nor are we taking child-devices into account.
>
> Indeed... double oops.
>
> This makes me wonder if we have any helpers to iterate over every device
> (and children) in a domain (and subdomains.)

Unfortunately there isn't, but it's a good idea I think.

If you decide to add helpers for this, please define them in a new
header-file internally for genpd, in drivers/pmdomain/core.h, so they
don't get publicly available via include/linux/pm_domain.h.

Kind regards
Uffe

