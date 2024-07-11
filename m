Return-Path: <linux-pm+bounces-10968-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F25AD92E464
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 12:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FF001F229D4
	for <lists+linux-pm@lfdr.de>; Thu, 11 Jul 2024 10:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E9F15B10D;
	Thu, 11 Jul 2024 10:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t4Pb4xmu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84267158D98
	for <linux-pm@vger.kernel.org>; Thu, 11 Jul 2024 10:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720693232; cv=none; b=jted51lQODnOsA984NpuMRD8LKpodPDq6q5/g8/5iSWWgOOVU6hAOSsVD+y01nHeNO98KWxkKbWoJ5Nh0HPmpusq9u2QZaC+2mkZaN3F3HGD5E7TXuhhzDVLhA02AcJdmVvCCSylLYAYGIaZVYJePF3pfzDjGmR7i69pyIOCDqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720693232; c=relaxed/simple;
	bh=atFigx0T1LVGe14ZAvm1oql6R4jmd8118+NKg9FdPio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LLBCUZVhseJEYf9L+SP9Z3r5mgchKWOw+Q7HtjqlpZGKuIRm20lHhiTzWRkB67Lj/mzI225DGFnasEeclxYy6SSUCxnXF364+gzJj3AoZjrajSCXk1TP5J9VV6cldR2CI2zfaW0P73Je3XqlY0PqTcZTc1DbUS+0b2K3nHyXhFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t4Pb4xmu; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e057c4885b3so595485276.3
        for <linux-pm@vger.kernel.org>; Thu, 11 Jul 2024 03:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720693229; x=1721298029; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wx798dgzG8dNc2c2k8oAMTgPjHa/fzRaZJmr2infrms=;
        b=t4Pb4xmuSY5alFYOA8oE1QyVdRFxmh2bC5/n2kXQ/l8cuRPp80OqEt4IkvkTl7KrbD
         KsDDlWbQ9jHgVVAIyvS2m+ABUIPQ1iNjh18lxNouIqCuR0KIPRv2Ntp0tT3u8CHYwaGW
         EY/YG1niDPSwFRevNFSAlccl8koVImHZ8S/ZU9WjXXPQ63hob6UmQV6diMUNgoiSMv6v
         Y+PaxgSy7OXkNJpWoUttWt9c4O5Znh7FpAUzkdO4v5xQfsgUt3aL/1aTPGp8Lc+FnJ2A
         aa0XNHMqj/Byg1O08VJoltZRac8w5lQqRSNEwDhzabknF4tiXF1bODdUUUwZDAHUFw87
         pfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720693229; x=1721298029;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wx798dgzG8dNc2c2k8oAMTgPjHa/fzRaZJmr2infrms=;
        b=sqwwVJh7q17QWKKYn7DSmU1cYZF8IzT6gX0UkgYaweMCAoTVbj5JuUVcEyNc6emKiu
         S3eStq+t8LwXLCwiQ1KCWaHjs5tdlE5NTAP9QlBP/VWFFVGAZRAupdT5o9abaAhLDzIJ
         1InJf6aOG/zFBtxujamBNdJBX52VBRzWCKMxqGADy2A/XQWHZhdw9+qJQDjaxV4TTduh
         6AZ2lhzbP4MZO73KN36c+oDW/fc4hX6tjY3uxERCRlY/Xq7XFfkfMxBlR52OUO1uQGZj
         9llXA3ps0uEPv3GHFPXmgJXHDr9KDTNDTuPkcnoYxvKdchZcVPRI8dH/wWJQljgEwtyl
         WK8w==
X-Forwarded-Encrypted: i=1; AJvYcCU4O1/Heog+G33jtnOAeKNfZ2TB03Vlj6tp3Y7kmyzjE927lwwzL4r7HUCPmkcPA7iEDkbd7JkOiAw2/u0e6JqsBDWlPDgpqpc=
X-Gm-Message-State: AOJu0YxEKTQPZsBgKB6odwo2kb1yIOnZfhgBuh+XGMoVwECIEKWc8H6e
	lvULSkbRfR19dwkrQLmU34JUIgH46XwlH2xPJDGMDhFBCmEEZSsFyj+nWsXzZ7UVEtEC2oLLwNN
	P2svLJrL0ZUtDNkS5hRwIFXhGnHp819R5MC/8e9YDj6eNp9yMDKs=
X-Google-Smtp-Source: AGHT+IFGTZUKBH76h5uq4mjZBsgTm0ziinY4pRCuByE2zxYdVCK/mzXjbYiNoXBWXVtpl0KBz7KVFr7oFeDOJY8Bfro=
X-Received: by 2002:a25:d882:0:b0:dc2:5553:ca12 with SMTP id
 3f1490d57ef6-e041b059302mr8762819276.14.1720693229469; Thu, 11 Jul 2024
 03:20:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619140849.368580-1-ulf.hansson@linaro.org>
 <20240619140849.368580-4-ulf.hansson@linaro.org> <20240626063321.3x4cvyj7yiks5f3p@vireshk-i7>
In-Reply-To: <20240626063321.3x4cvyj7yiks5f3p@vireshk-i7>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 11 Jul 2024 12:19:53 +0200
Message-ID: <CAPDyKFqY_mNnaT8j4vCXxYtARkGb_bkvcwKkyXcLPwW+gutO8Q@mail.gmail.com>
Subject: Re: [PATCH 3/7] OPP: Rework _set_required_devs() to manage a single
 device per call
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Nikunj Kela <nkela@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Jun 2024 at 08:33, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 19-06-24, 16:08, Ulf Hansson wrote:
> > @@ -2494,36 +2495,68 @@ static int _opp_set_required_devs(struct opp_table *opp_table,
> >               return -EINVAL;
> >       }
> >
> > -     /* Another device that shares the OPP table has set the required devs ? */
> > -     if (opp_table->required_devs[0])
> > -             return 0;
> > +     /* Genpd core takes care of propagation to parent genpd */
> > +     if (opp_table->is_genpd) {
>
> A genpd can have non-genpd devices in the required OPPs and so this
> isn't sufficient. What we were ignoring earlier was genpd having
> another genpd as required opp.

Unless I am mistaken, I don't think that is a scenario we should care
about here.

_opp_set_required_dev() is being called for a device that is about to
be attached to its corresponding genpd.

Yes, in some cases, we attach a genpd provider's device to its
genpd-parent, but that is not to control the required-opps.

>
> > +             dev_err(dev, "%s: Operation not supported for genpds\n", __func__);
> > +             return -EOPNOTSUPP;
> > +     }
> >
> >       for (i = 0; i < opp_table->required_opp_count; i++) {
> > -             /* Genpd core takes care of propagation to parent genpd */
> > -             if (required_devs[i] && opp_table->is_genpd &&
> > -                 opp_table->required_opp_tables[i]->is_genpd) {
> > -                     dev_err(dev, "%s: Operation not supported for genpds\n", __func__);
> > -                     return -EOPNOTSUPP;
> > -             }
> > +             struct opp_table *table = opp_table->required_opp_tables[i];
> > +
> > +             /*
> > +              * The OPP table should be available at this point. If not, it's
> > +              * not the one we are looking for.
> > +              */
> > +             if (IS_ERR(table))
> > +                     continue;
> > +
> > +             /* Move to the next available index. */
> > +             if (opp_table->required_devs[i])
> > +                     continue;
> >
> > -             opp_table->required_devs[i] = required_devs[i];
> > +             /*
> > +              * We need to compare the nodes for the OPP tables, rather than
> > +              * the OPP tables themselves, as we may have separate instances.
> > +              */
> > +             if (required_opp_table->np == table->np) {
> > +
>
> We don't keep such empty lines in OPP core generally at this place.

Yep, let me drop it!

>
> > +                     /* Cross check the OPP tables and fix it if needed. */
>
> Copy the bigger comment from_opp_attach_genpd() here too. It helps
> understanding why required_opp_tables entry is getting replaced.

Right, makes sense!

>
> > +                     if (required_opp_table != table) {
> > +                             dev_pm_opp_put_opp_table(table);
> > +                             _get_opp_table_kref(required_opp_table);
> > +                             opp_table->required_opp_tables[i] = required_opp_table;
> > +                     }
> > +
> > +                     opp_table->required_devs[i] = required_dev;
> > +
> > +                     /*
> > +                      * Add the required_dev as a user of the OPP table, so
> > +                      * we can call dev_pm_opp_set_opp() on it directly.
> > +                      */
> > +                     if (!_add_opp_dev(required_dev, required_opp_table)) {
> > +                             dev_err(dev, "Failed to add the device to the required OPP table\n");
> > +                             return -ENOMEM;
> > +                     }
> > +
> > +                     return i;
> > +             }
> >       }
>
> --
> viresh

Kind regards
Uffe

