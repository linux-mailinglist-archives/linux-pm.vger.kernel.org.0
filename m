Return-Path: <linux-pm+bounces-29001-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6F5ADF50A
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 19:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11E0B4041C0
	for <lists+linux-pm@lfdr.de>; Wed, 18 Jun 2025 17:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C192FE334;
	Wed, 18 Jun 2025 17:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XtVg23cV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724D22FE31A
	for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 17:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268893; cv=none; b=JL9UMdUeyDZFZ+oYrec8/XPGvdlcw8Km/EzgPQlzcdKFAqLuoiFTkEph/HHCT4/b0I9NWRMw8M6kFotFxw3cLEVTXRBnvL6M1BJ79TtFeyHnCxNVqUxMkSGTbq0Oim/4AkbyTc9l1g9fIIM4JqIsPkFOpKKoH1VaSZJmoXLfB2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268893; c=relaxed/simple;
	bh=qke53PIux3r1jvNanvydCzc4TxGBVxK2sWSp7M4ghek=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZP2jKb7l0qaf1fJuq2uTblNTnKdLZbedkmJslyns2UNpEaw7VOTvKmXDTpXer28M/XrFBpiud/JE3m76gpVDrzasUwnwYm5Yr37VA0GKJpolkqDtW+B+N3dQ2Ubinl5HHy82573Ur670r6c+Vv0w+4bmxl4cGo9mSldeIvyWSPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XtVg23cV; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b2f1032e1c4so8198709a12.3
        for <linux-pm@vger.kernel.org>; Wed, 18 Jun 2025 10:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750268891; x=1750873691; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ma1DFqOXL5hx5mQJvRhg1LAJlyxCckkOphqVxa1A73o=;
        b=XtVg23cVGsWONpuw7Z7ScLt4//Vq9B9tLfDFr+55Cz7O3Hy98z1OobQna2V2PhX8as
         d5ujOlG9sYIrqHAgaqzzMTrbhkdA+YUVqwv23bsDcjwh/cVhFnlb0sq/2hpvk/uXekiB
         /8DQCy6BYvKAvivVMkiBwmnNrFXR6PImJk5P3LcdIZZcwB+m75uWykSK97Qgr9kEh7WJ
         S0nZLf0E98FRVNUDwR6mR5E1L3ioThUzTte4X/jv9Vlh2UP7KmxFbnKeCAJDkuc8BL5h
         1yy6aHNJJwxB/dKijjl81vnWOFZnYWpg04cCJHU6Hs8nYoSVMcKNHQpX1ZsIivvQAhJE
         Hy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750268891; x=1750873691;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ma1DFqOXL5hx5mQJvRhg1LAJlyxCckkOphqVxa1A73o=;
        b=bqvzfR1VfBWfzJQ7hdk1SARk5cSNwRU2gHgYnxY8g5Qca/xs/SNc+7o/jWkhe1jXkl
         tSc0quu2NXtbC5GDWXOXXsVRbe/lXb4X1ZcyFu+yW+gMlEhpYgYRd6n935CdSEeTZRtJ
         BaSb4i0ZkIxMO3Z/wAukw+k/Hk6Q5NQoFx06uiG9ebcZt3Mvi3B2wod72ZO2iw1w2tPn
         inCfzQjNXICHDHfq3lpNJOgK9q95PkzmD6gTHJPvpNNnC29qBlWSuJeZsm1bXk8pDqJy
         E6rvUNyklgw6Nsy9iXULjJ80xkAQlc364viEigJOpV+KIIIE0xzXIy5v+XtCYT/FWiCE
         w5XQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVxF5JGOfvRzAd7fpN5D6y6/87ThNcEw7Z+yYphLijLSpw8NL/h26qVviYIpjMlMzjourNLsVpNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl/EXe1lWRzTGf96d3xcnQILjWyNGoGoUsyEUzaVbxSOugQxfe
	bevwfIhGSQlSX/bdWE6RHv+8ynGyMsRe+eE0XQqctulp+8idMGwQmCIVP6bnPdSYDOk=
X-Gm-Gg: ASbGnct1BdfkQB0k5d2c2+iA42kij6CAnEpdl/yLYQVpQmPKENJjxg5umeBc04CTAvd
	/OnmPzISMzT+xEfyMJd9Y+dtSqSzKztce9fJRTj1NTAudrmoambFZPL7LwVmcXRrduwjCILbvNb
	xXtrRfMmou5rdttVSYQ4aKiYp5JWrPdQu8s6friYF/mQVELrTav4Zmb+Vg1pNOsjYS5ux5v0w9S
	4GwGFDBHoSaCpbN2eSjz/3CJrXpWv5hqJcU2qBxiZpz/GBeOd0PxfD7RMR4BNOj8aXRS2rbxsm5
	bJksRDDzQv83gXX/C6A5qX0EEEyQ1Mje1GpMPYGHfVIvDUc2Vlk3+M65Mh5QrwbER+9r87o=
X-Google-Smtp-Source: AGHT+IGr+yslmQQtEPbzvrjSktOlRycOtQIi03QuXPccny65/icW3k6Q8MFLfTx4kGxdf1Sa3ChN/w==
X-Received: by 2002:a05:6a20:1586:b0:21f:4459:c032 with SMTP id adf61e73a8af0-21fbd4f0504mr26157499637.18.1750268890645;
        Wed, 18 Jun 2025 10:48:10 -0700 (PDT)
Received: from localhost ([97.126.182.119])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900d252esm11346290b3a.163.2025.06.18.10.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 10:48:10 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 arm-scmi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v3 2/2] pmdomain: core: add support for subdomains
 using power-domain-map
In-Reply-To: <CAPDyKFo-iPBPgkM43q+5cGR2sptkLk4E6TAERCQbCu24o1RfFQ@mail.gmail.com>
References: <20250613-pmdomain-hierarchy-onecell-v3-0-5c770676fce7@baylibre.com>
 <20250613-pmdomain-hierarchy-onecell-v3-2-5c770676fce7@baylibre.com>
 <CAPDyKFrO9rb0eDb2qO+EGaVjOFG=7emgca8511XACDhWY=dt5g@mail.gmail.com>
 <7hsejzp4xg.fsf@baylibre.com>
 <CAPDyKFo-iPBPgkM43q+5cGR2sptkLk4E6TAERCQbCu24o1RfFQ@mail.gmail.com>
Date: Wed, 18 Jun 2025 10:48:09 -0700
Message-ID: <7hcyb1os9y.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On Tue, 17 Jun 2025 at 02:50, Kevin Hilman <khilman@baylibre.com> wrote:
>>
>> Ulf Hansson <ulf.hansson@linaro.org> writes:
>> --text follows this line--
>> > On Sat, 14 Jun 2025 at 00:39, Kevin Hilman <khilman@baylibre.com> wrote:
>> >>
>> >> Currently, PM domains can only support hierarchy for simple
>> >> providers (e.g. ones with #power-domain-cells = 0).
>> >>
>> >> Add more generic support for hierarchy by using nexus node
>> >> maps (c.f. section 2.5.1 of the DT spec.)
>> >>
>> >> For example, we could describe SCMI PM domains with multiple parents
>> >> domains (MAIN_PD and WKUP_PD) like this:
>> >>
>> >>     scmi_pds: protocol@11 {
>> >>         reg = <0x11>;
>> >>         #power-domain-cells = <1>;
>> >>
>> >>         power-domain-map = <15 &MAIN_PD>,
>> >>                            <19 &WKUP_PD>;
>> >>     };
>> >>
>> >> which should mean that <&scmi_pds 15> is a subdomain of MAIN_PD and
>> >> <&scmi_pds 19> is a subdomain of WKUP_PD.
>> >>
>> >> IOW, given an SCMI device which uses SCMI PM domains:
>> >>
>> >>    main_timer0: timer@2400000 {
>> >>       power-domains = <&scmi_pds 15>;
>> >>    };
>> >>
>> >> it already implies that main_timer0 is PM domain <&scmi_pds 15>
>> >>
>> >> With the new map, this *also* now implies <&scmi_pds 15> is a
>> >> subdomain of MAIN_PD.
>> >>
>> >> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
>> >> ---
>> >>  drivers/pmdomain/core.c | 24 ++++++++++++++++++++++--
>> >>  1 file changed, 22 insertions(+), 2 deletions(-)
>> >>
>> >> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
>> >> index d6c1ddb807b2..adf022b45d95 100644
>> >> --- a/drivers/pmdomain/core.c
>> >> +++ b/drivers/pmdomain/core.c
>> >> @@ -2998,8 +2998,8 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>> >>                                  unsigned int index, unsigned int num_domains,
>> >>                                  bool power_on)
>> >>  {
>> >> -       struct of_phandle_args pd_args;
>> >> -       struct generic_pm_domain *pd;
>> >> +       struct of_phandle_args pd_args, parent_args;
>> >> +       struct generic_pm_domain *pd, *parent_pd = NULL;
>> >>         int ret;
>> >>
>> >>         ret = of_parse_phandle_with_args(dev->of_node, "power-domains",
>> >> @@ -3039,6 +3039,22 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>> >>                         goto err;
>> >>         }
>> >>
>> >> +       /*
>> >> +        * Check for power-domain-map, which implies the primary
>> >> +        * power-doamin is a subdomain of the parent found in the map.
>> >> +        */
>> >> +       ret = of_parse_phandle_with_args_map(dev->of_node, "power-domains",
>> >> +                                            "power-domain", index, &parent_args);
>> >> +       if (!ret && (pd_args.np != parent_args.np)) {
>> >> +               parent_pd = genpd_get_from_provider(&parent_args);
>> >> +               of_node_put(parent_args.np);
>> >> +
>> >> +               ret = pm_genpd_add_subdomain(parent_pd, pd);
>> >> +               if (!ret)
>> >> +                       dev_dbg(dev, "adding PM domain %s as subdomain of %s\n",
>> >> +                               pd->name, parent_pd->name);
>> >> +       }
>> >
>> > Please move the above new code to a separate shared genpd helper
>> > function, that genpd providers can call build the topology. This, to
>> > be consistent with the current way for how we usually add
>> > parent/child-domains in genpd (see of_genpd_add_subdomain).
>>
>> Yeah, you had the same comment on v2, and I'm not ignoring you.  But I
>> thought that moving this code to when devices are attatched to domains
>> (instead of when providers are created) would solve that problem.  IOW,
>> in this approach, `power-domain-map` is handled at the same time as a
>> devices `power-domains = ` property.
>
> Even if this may work for your particular use case, in general it does not.
>
> We simply can't defer to build the topology (parent/child-domains)
> until there is a device getting attached to some part of it.

OK, not defering building topology makes a lot of sense.  Thanks for the
explanation.

>>
>> So, while I don't really understand the reason that every PM domain
>> provider has to handle this individually, I've given that a try (see
>> below.)
>>
>
> See above.
>
>> > Moreover, we also need a corresponding "cleanup" helper function to
>> > remove the child-domain (subdomain) correctly, similar to
>> > of_genpd_remove_subdomain().
>>
>> Yes, I'll handle that better once I get through this RFC phase to make
>> sure I'm on th right path.
>
> Okay.
>
>>
>> OK, so below[1] is a shot at just adding helpers to the PM domain core.  I
>> will then uses these from the SCMI PM domains ->attach_dev() and
>> ->detatch_dev callbacks.
>
> No, not during ->attach|detach_dev(), but during ->probe() of the SCMI
> PM domain, immediately after the genpd OF providers has been added.
>
> See more comments below.
>
>>
>> If you think this is better, I'll send a v4 tomorrow.
>>
>> Kevin
>>
>> [1] NOTE: this is based on v6.12 because that's where I have a functioning BSP
>> for this SoC.  If you're OK with this, I'll rebase to v6.15 and submit upstream.
>>
>> From 12a3e5669dc18f4a9fdf9f25398cba4245135a43 Mon Sep 17 00:00:00 2001
>> From: Kevin Hilman <khilman@baylibre.com>
>> Date: Fri, 13 Jun 2025 13:49:45 -0700
>> Subject: [PATCH 2/3] pmdomain: core: add support for subdomains via
>>  power-domain-map
>>
>> ---
>>  drivers/pmdomain/core.c   | 60 +++++++++++++++++++++++++++++++++++++++
>>  include/linux/pm_domain.h | 11 +++++++
>>  2 files changed, 71 insertions(+)
>>
>> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
>> index 88819659df83..a0dc60d4160d 100644
>> --- a/drivers/pmdomain/core.c
>> +++ b/drivers/pmdomain/core.c
>> @@ -3100,6 +3100,66 @@ struct device *genpd_dev_pm_attach_by_name(struct device *dev, const char *name)
>>         return genpd_dev_pm_attach_by_id(dev, index);
>>  }
>>
>> +/**
>> + * genpd_dev_pm_attach_subdomain - Associate a PM domain with its parent domain
>> + * @domain: The PM domain to lookup whether it has any parent
>> + * @dev: The device being attached to the PM domain.
>> + *
>> + * Check if @domain has a power-domain-map.  If present, use that map
>> + * to determine the parent PM domain, and attach @domain as a
>> + * subdomain to the parent PM domain.
>> + *
>> + * Intended to called from a PM domain provider's ->attach_dev()
>> + * callback, where &gpd_list_lock will already be held by the genpd
>> + * add_device() path.
>> + */
>> +struct generic_pm_domain *
>> +genpd_dev_pm_attach_subdomain(struct generic_pm_domain *domain,
>> +                             struct device *dev)
>
> A couple of comments below:
>
> *) I think the function-name should have a prefix "of_genpd_*, to be
> consistent with other names. Maye "of_genpd_add_subdomain_by_map"
> would be a better name?
>
> *) We need to decide if we want to add one child-domain (subdomain)
> per function call - or whether we should walk the entire nexus-map and
> hook up all child-domains to its parent in one go. I tend to like the
> second one better, but I'm not really sure what would work best here.

I like the first one better since most other related functions work on
single domains, not groups.

> No matter what, I think the in-parameters to the function should be of
> type "struct of_phandle_args * or maybe struct device_node *", similar
> to how of_genpd_add_subdomain() works.

I've done an implementation with struct device_node *.  This works
better (IMO) than struct of_phandle_args * because the caller (in my
case scmi_pm_domain.c) already has device nodes, but not phandle args.

The result will be that the pmdomain helper will call
pm_genpd_add_subdomain() instead of of_genpd_add_subdomain().  

Below[1] is the current working version, which includes adding the
helper to the PM domain core and showing the usage by the SCMI provider.

How does this look?

Note that doing this at provider creation time instead of
<genpd>->attach_dev() time will require some changes to
of_parse_phandle_with_args_map() because that function expects to be
called for a device that has a `power-domains = <provider>` property,
not for the provider itself.  But I have it working with some local
changes to make that helper work if called for the provider directly.
If you're OK with the PM domains approach, I'll post another rev of this
series which includes the OF changes for review by DT maintainers.

Kevin

[1]
---
 drivers/pmdomain/arm/scmi_pm_domain.c | 12 ++++++++--
 drivers/pmdomain/core.c               | 34 +++++++++++++++++++++++++++
 include/linux/pm_domain.h             | 11 ++++++++-
 3 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/drivers/pmdomain/arm/scmi_pm_domain.c b/drivers/pmdomain/arm/scmi_pm_domain.c
index a7784a8bb5db..8197447e9d17 100644
--- a/drivers/pmdomain/arm/scmi_pm_domain.c
+++ b/drivers/pmdomain/arm/scmi_pm_domain.c
@@ -54,7 +54,7 @@ static int scmi_pd_power_off(struct generic_pm_domain *domain)
 
 static int scmi_pm_domain_probe(struct scmi_device *sdev)
 {
-	int num_domains, i;
+	int num_domains, i, ret;
 	struct device *dev = &sdev->dev;
 	struct device_node *np = dev->of_node;
 	struct scmi_pm_domain *scmi_pd;
@@ -115,7 +115,15 @@ static int scmi_pm_domain_probe(struct scmi_device *sdev)
 
 	dev_set_drvdata(dev, scmi_pd_data);
 
-	return of_genpd_add_provider_onecell(np, scmi_pd_data);
+	ret = of_genpd_add_provider_onecell(np, scmi_pd_data);
+	if (ret)
+		return ret;
+
+	/* check for (optional) subdomain mapping with power-domain-map */
+	for (i = 0; i < num_domains; i++, scmi_pd++)
+		of_genpd_add_subdomain_map(np, domains[i], i);
+
+	return ret;
 }
 
 static void scmi_pm_domain_remove(struct scmi_device *sdev)
diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 88819659df83..3ede4baa4bee 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -3220,6 +3220,40 @@ int of_genpd_parse_idle_states(struct device_node *dn,
 }
 EXPORT_SYMBOL_GPL(of_genpd_parse_idle_states);
 
+int of_genpd_add_subdomain_map(struct device_node *np,
+			       struct generic_pm_domain *domain,
+			       int index)
+{
+	struct of_phandle_args parent_args;
+	struct generic_pm_domain *parent_pd;
+	struct device *dev = &domain->dev;
+	int ret;
+
+	if (!domain)
+		return -ENODEV;
+
+	/*
+	 * Check for power-domain-map, which implies the primary
+	 * power-doamin is a subdomain of the parent found in the map.
+	 */
+	ret = of_parse_phandle_with_args_map(np, NULL, "power-domain",
+					     index, &parent_args);
+	if (!ret && parent_args.np) {
+		parent_pd = genpd_get_from_provider(&parent_args);
+		of_node_put(parent_args.np);
+
+		if (IS_ERR(parent_pd))
+			return -EINVAL;
+
+		ret = pm_genpd_add_subdomain(parent_pd, domain);
+		if (!ret)
+			dev_dbg(dev, "adding PM domain %s as subdomain of %s\n",
+				domain->name, parent_pd->name);
+	}
+
+	return ret;
+}
+
 static int __init genpd_bus_init(void)
 {
 	return bus_register(&genpd_bus_type);
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index cf4b11be3709..65d459d703bb 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -402,9 +402,11 @@ int of_genpd_add_subdomain(const struct of_phandle_args *parent_spec,
 int of_genpd_remove_subdomain(const struct of_phandle_args *parent_spec,
 			      const struct of_phandle_args *subdomain_spec);
 struct generic_pm_domain *of_genpd_remove_last(struct device_node *np);
+int of_genpd_add_subdomain_map(struct device_node *np,
+			       struct generic_pm_domain *genpd,
+			       int index);
 int of_genpd_parse_idle_states(struct device_node *dn,
 			       struct genpd_power_state **states, int *n);
-
 int genpd_dev_pm_attach(struct device *dev);
 struct device *genpd_dev_pm_attach_by_id(struct device *dev,
 					 unsigned int index);
@@ -443,6 +445,13 @@ static inline int of_genpd_remove_subdomain(const struct of_phandle_args *parent
 	return -ENODEV;
 }
 
+static int of_genpd_add_subdomain_map(struct device_node *np,
+				      struct generic_pm_domain *genpd,
+				      int index)
+{
+	return -ENODEV;
+}
+
 static inline int of_genpd_parse_idle_states(struct device_node *dn,
 			struct genpd_power_state **states, int *n)
 {
-- 
2.49.0



