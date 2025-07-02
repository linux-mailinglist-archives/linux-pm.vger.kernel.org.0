Return-Path: <linux-pm+bounces-29977-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 386DAAF1526
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 14:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E0717AD49B
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 12:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C954E26D4E4;
	Wed,  2 Jul 2025 12:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZU28WMT7"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CE6272E7A
	for <linux-pm@vger.kernel.org>; Wed,  2 Jul 2025 12:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751458380; cv=none; b=VIf7DWlHWxJI/ChZQTT8sYZhvTAoqZngPrjAsXpgKvZvVeExXadFoUpw2FrVV1Hjju0MCNOeB9znHDwGgXxMt4BtRLSzPgPu9ph0G12n7HIUbwBFmUZvu/NYbydn+aohrvaskfC1MjwGhDeRXOKNFhRj8VWqlHLs7aVj/qlnvew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751458380; c=relaxed/simple;
	bh=oClDJcT0mTELwPMf1uIqlxpRObpfhkuJDcTpu4d7ylI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kLiZLgdmOPjQh3KI1m0PYPUzsLmAJU5eno4BKARJx1wod4s7VKz75dkWMBlyDX9X/woW10LgGzs+4Sg+qg3KVh9f2XhgsRji9pCHn+SwTi3jAr56mlSd0Z3oYVNeoxYUY6KlNtGW3Rbyl4xq/la7tjdzhUlBt05Hoi2pXea7bYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZU28WMT7; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e8187601f85so5975885276.2
        for <linux-pm@vger.kernel.org>; Wed, 02 Jul 2025 05:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751458377; x=1752063177; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9gk4s+SONPpEB34QsQQb13XEXrE5uFgXKOQWW3pBsTo=;
        b=ZU28WMT7BcvN/b+AqfWX8nv6lqhMzC6PC4DdDm2j5uJVs79wLIa8LdUIviL6C7YjL1
         GMcdbXoY3xo7hW5zBHIE7xHjDNz9r4ZaFjXE1bzPil/JUC9UhKGyVUsfzZOZ8inqN62J
         Plfj2RXo6eL4sNHPV3cRUhwPnOZwi/6vgEOm71FPCvOVNe04b20L9eUMFXx/E8l4Wdrf
         qIPn+QAgvh8pxl252LaP3bHn8u+W2uqnpIdTf9lQE1vZhAf15zV6jipEMgbUJ86xWPJu
         rwUOYzW9qguirxoq7aqMyOfL+8vxyxu+V+dddJOj13U55QcP4o79Zjdwi97WpQfRUy+Z
         1rZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751458377; x=1752063177;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9gk4s+SONPpEB34QsQQb13XEXrE5uFgXKOQWW3pBsTo=;
        b=XsYrtzKMDXImCD3ZVX62wC7PLc0JHEhDU0SPcJvum+TYwM/y1MHgOnL+bCJphgVYK9
         OTi7v1r1inP2wA78Qm7sbAxa4wzhNkn9xgdgas1ACUGhfsREO+umA1O10XR4HHmhTHSK
         H7bn8DbW6oYgoZRsWtjd9vqhbNVQsdVV5vp3qL7z0fSdzcIi0O4hQnRHaMLuDNbq2p4A
         LED4j9QBC20LdJ4I6DG4164KX12lRvyyG2tDWLANXUC7A2tw0OKzYO5oyOgCUtDzeiZh
         oIxA4fKox5O+v0EjxdbCk99tc8tbHbv0PldExZYdgh6iuAEph/LnzWcu+xC9CVtdxvg2
         pimg==
X-Forwarded-Encrypted: i=1; AJvYcCXrdFBI0caGl3nQuOfXvUuDWRCXevp0eEvSoaZX2RzmWjInh4Vy78uOpfUCd4yetfghvcVPMZnGhg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvZiJLbwtBV3INkN5+yNUtUzRS3N+TIIXPUT7ToYPNjpm45KH7
	GWWrBLQlyViGZUFoerDFt8T4DPpG9WVChSRs2yj3pHRrvsJGNQdXL3ynRevzGK85sWsfLwjhHDe
	YaI62h0wbnQKsjQ6Osv92UeUqmKZDO3ztUzJVke03uQ==
X-Gm-Gg: ASbGncvBmzZag3Lus7DwVPSuoqBpmHO2GEHmI8Gmhb60+9kKP88E6iFPBSgjse4juA+
	t1Ih4/AfKXH05perbImBxkLjYcvUBnOXbrLnTWw8+MZumq2kMxAr8IXqV3gslEAuXBpcovse/wh
	julw1MkwxTPZxQPFLFAoc2sX4W8H1FYcbhUI8gndbOD0vkN0ME7bFU/Vs=
X-Google-Smtp-Source: AGHT+IG3NWai+ZP/un1xZG3CzZCkLzSMLJaFL3JR+EQ/9jK23FydSpvbz+8ZOtgLz/en/MyFioW+0zHkRi1p3FqLmno=
X-Received: by 2002:a05:690c:4a0b:b0:6fb:a696:b23b with SMTP id
 00721157ae682-7164d571f91mr35480447b3.33.1751458376965; Wed, 02 Jul 2025
 05:12:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613-pmdomain-hierarchy-onecell-v3-0-5c770676fce7@baylibre.com>
 <20250613-pmdomain-hierarchy-onecell-v3-2-5c770676fce7@baylibre.com>
 <CAPDyKFrO9rb0eDb2qO+EGaVjOFG=7emgca8511XACDhWY=dt5g@mail.gmail.com>
 <7hsejzp4xg.fsf@baylibre.com> <CAPDyKFo-iPBPgkM43q+5cGR2sptkLk4E6TAERCQbCu24o1RfFQ@mail.gmail.com>
 <7hcyb1os9y.fsf@baylibre.com> <CAPDyKFpTgAmLBq2ZExPoxWM0wL756zH96vW7M6wHSA1MTTG1wA@mail.gmail.com>
 <7hjz4tnlg6.fsf@baylibre.com>
In-Reply-To: <7hjz4tnlg6.fsf@baylibre.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 2 Jul 2025 14:12:20 +0200
X-Gm-Features: Ac12FXx099YexnSX3D-jd8HuUZnwt5D-jZ9PNizBBy6pBlCC473WjWV1dygsTok
Message-ID: <CAPDyKFrY2kNaP=Hk-81B4WEGxyKUTYqBWJHQKtHnyTPWTFUOEQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 2/2] pmdomain: core: add support for subdomains
 using power-domain-map
To: Kevin Hilman <khilman@baylibre.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, arm-scmi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 30 Jun 2025 at 20:17, Kevin Hilman <khilman@baylibre.com> wrote:
>
> Ulf Hansson <ulf.hansson@linaro.org> writes:
>
> > [...]
> >
> >> I've done an implementation with struct device_node *.  This works
> >> better (IMO) than struct of_phandle_args * because the caller (in my
> >> case scmi_pm_domain.c) already has device nodes, but not phandle args.
> >>
> >> The result will be that the pmdomain helper will call
> >> pm_genpd_add_subdomain() instead of of_genpd_add_subdomain().
> >>
> >> Below[1] is the current working version, which includes adding the
> >> helper to the PM domain core and showing the usage by the SCMI provider.
> >>
> >> How does this look?
> >
> > It's a lot better in my opinion. Although, I have a few comments below.
> >
> >>
> >> Note that doing this at provider creation time instead of
> >> <genpd>->attach_dev() time will require some changes to
> >> of_parse_phandle_with_args_map() because that function expects to be
> >> called for a device that has a `power-domains = <provider>` property,
> >> not for the provider itself.  But I have it working with some local
> >> changes to make that helper work if called for the provider directly.
> >> If you're OK with the PM domains approach, I'll post another rev of this
> >> series which includes the OF changes for review by DT maintainers.
> >>
> >> Kevin
> >>
> >> [1]
> >> ---
> >>  drivers/pmdomain/arm/scmi_pm_domain.c | 12 ++++++++--
> >>  drivers/pmdomain/core.c               | 34 +++++++++++++++++++++++++++
> >>  include/linux/pm_domain.h             | 11 ++++++++-
> >>  3 files changed, 54 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/pmdomain/arm/scmi_pm_domain.c b/drivers/pmdomain/arm/scmi_pm_domain.c
> >> index a7784a8bb5db..8197447e9d17 100644
> >> --- a/drivers/pmdomain/arm/scmi_pm_domain.c
> >> +++ b/drivers/pmdomain/arm/scmi_pm_domain.c
> >> @@ -54,7 +54,7 @@ static int scmi_pd_power_off(struct generic_pm_domain *domain)
> >>
> >>  static int scmi_pm_domain_probe(struct scmi_device *sdev)
> >>  {
> >> -       int num_domains, i;
> >> +       int num_domains, i, ret;
> >>         struct device *dev = &sdev->dev;
> >>         struct device_node *np = dev->of_node;
> >>         struct scmi_pm_domain *scmi_pd;
> >> @@ -115,7 +115,15 @@ static int scmi_pm_domain_probe(struct scmi_device *sdev)
> >>
> >>         dev_set_drvdata(dev, scmi_pd_data);
> >>
> >> -       return of_genpd_add_provider_onecell(np, scmi_pd_data);
> >> +       ret = of_genpd_add_provider_onecell(np, scmi_pd_data);
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       /* check for (optional) subdomain mapping with power-domain-map */
> >> +       for (i = 0; i < num_domains; i++, scmi_pd++)
> >> +               of_genpd_add_subdomain_map(np, domains[i], i);
> >> +
> >> +       return ret;
> >>  }
> >>
> >>  static void scmi_pm_domain_remove(struct scmi_device *sdev)
> >> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> >> index 88819659df83..3ede4baa4bee 100644
> >> --- a/drivers/pmdomain/core.c
> >> +++ b/drivers/pmdomain/core.c
> >> @@ -3220,6 +3220,40 @@ int of_genpd_parse_idle_states(struct device_node *dn,
> >>  }
> >>  EXPORT_SYMBOL_GPL(of_genpd_parse_idle_states);
> >>
> >> +int of_genpd_add_subdomain_map(struct device_node *np,
> >> +                              struct generic_pm_domain *domain,
> >> +                              int index)
> >
> > Providing the struct generic_pm_domain *domain as an in-parameter for
> > the child-domain seems unnecessary and limiting to me.
> >
> > Instead I think we should parse the power-domain-map DT property at
> > 'index', to find the corresponding child-domain's specifier/index and
> > its corresponding parent-domain.
> >
> > In other words, we don't need the struct generic_pm_domain *domain as
> > an in-parameter, right?
>
> I'm not sure I follow.  The `struct generic pm_domain *domain` is the
> SCMI child domain.  From the map, we use the index to find the parent
> domain.  And then we add the child as a subdomain of the parent.
>
> Are you suggesting that I (re)parse the DT for to find the child domain
> also?

Correct!

The DT property ("power-domains-map") that you added in patch1/2,
contains all the information so let's just parse it and assign
child/parent domains based on it.

Kind regards
Uffe

