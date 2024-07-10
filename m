Return-Path: <linux-pm+bounces-10932-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C84392D363
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 15:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 312BE1F22CB2
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2024 13:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8172193084;
	Wed, 10 Jul 2024 13:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I/YRcBEf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408EB193067
	for <linux-pm@vger.kernel.org>; Wed, 10 Jul 2024 13:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720619534; cv=none; b=Y1Gt9jBBNd8f5+27xPH4ipTxUFqGLMDgMtesrxUwlAjhjqKc3pD+doynbAKBBEwvK78DoKd0zwKuHeKNg5scgTgVuNOpe3PfRFjudVbskPk6TxceEATYK/VPWGPNWoglJHSsCPPG6xbrqF8mMl/N1vuAN4loMv/nChG2rQqInO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720619534; c=relaxed/simple;
	bh=3WiWOBn7pHdmhx9iPoez08ScqRj7WvY9UsQuBoxjbvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=igAN99tJxAaOTVZk5dCorRnqMyvQgIcf07SGf9Gezs8+lK5MILQReXlRO1ZPFGmNAenlSB6xsIeIOSfdJDHc5L7CuREKzHWTr2zz97q3i71JVuOUKrTXjdP4B7lGp9jiL7FLUeh7YLzBjm3Q75lQujTDdmscLiUj/qNPQL8q6xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I/YRcBEf; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e03a8955ae3so6265321276.1
        for <linux-pm@vger.kernel.org>; Wed, 10 Jul 2024 06:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720619532; x=1721224332; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s6ihtFgMXol2238V4wCVG6CHvKqmNcnW+Q3HHUXDtbg=;
        b=I/YRcBEff5PrvIhr8gqO5kZjyjr1Cb4kNaAidhFvpiOXYlphQF2XBfcEnxEeEo2a2a
         fVPYFO9VaKoanXiEB8wFOSRK8lzhUFSXn1h/08HFQEULyVj7CVH2ZQfJbuT4RJ4kNleX
         Wuf6pV2vbCBd+OQFoVtY4TrCQ0e7q3l8+Bk1x9UA4KxuyOcRAsnO4h9KFiXrADD8s6Fl
         izhrQRn3XhMhCMscVDvootI8LWke5iGTYCOI543vCh9OTV+E0IbDS/Mcc0+zyb9F0xG7
         Rr7MkHzUiTr724g9b4O+tGn97C9QdqSitWoiV3TNVUNE5bBSO1vOkEel6BqrahftsjC6
         NquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720619532; x=1721224332;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s6ihtFgMXol2238V4wCVG6CHvKqmNcnW+Q3HHUXDtbg=;
        b=tcbBFvyMAjHKsvQr8Tme3nB2Lm/iFR4CKomELyp6/ZhKEj/gXaBDnpJExv/yLdd58y
         w0TP3bDtccBclnLMOM4OUxyVA5Kx1tu1l3py8ODeTLSTLLYddP66ov3p5MIW1ufUyLT6
         qvSZs5HDQ9q67gpgZa+V/xAE34HQlxsjOEH5xkeNhzzoswKI93d/1mZKzci36dE2NecP
         AwNzwfPJMVdr/7sQ54bOofKh7Ae0VwOUDZd5vimoCV+7KPu9VAqesCG8cMTZ5FLm8vyY
         i+TNrldEqQnqgG8FXv7OQ9sTIKjOkFpJvVBJ7yF7NbIDGPLkhsWUwc4iWCnU4mwSYGpe
         UM2g==
X-Forwarded-Encrypted: i=1; AJvYcCU93MUYQokNVSIW2eV/8MqWuqvqjHo2eFphaIYXyxYDcAGF6Om8nb9PFkqhV5Z0NmMY3C0PWcdwVM+tomaRAU88F/VOqiuxo14=
X-Gm-Message-State: AOJu0YyPYiRboYoNRNsP+Je/3+PsttdEi9gnStQLENFsQjAKv+EMNPvV
	1W+ZxzqmzPtc+TW2Micvf77JiDcL7x/A2U4yzv0gt1t6XY1mFipdZphkTEdHaLWJ+jDLeW0omEQ
	NW3CCvq3ePNhglmpixyByYwY6O6IkQgPJ/YUzEw==
X-Google-Smtp-Source: AGHT+IEgGhImB1CZ9V2zyPwOjbF7xu90LRXOFMyWlUsr33fZ9RPD7FcjB6nD790/e/8piCgrefZcj52pseUw7tQZ7qs=
X-Received: by 2002:a25:bc8a:0:b0:e03:4ddd:49f0 with SMTP id
 3f1490d57ef6-e041b22a2c7mr6248368276.57.1720619532289; Wed, 10 Jul 2024
 06:52:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618155013.323322-1-ulf.hansson@linaro.org>
 <20240625105425.pkociumt4biv4j36@vireshk-i7> <CAPDyKFpLfBjozpcOzKp4jngkYenqSdpmejvCK37XvE1-WbBY2g@mail.gmail.com>
 <20240701114748.hodf6pngk7opx373@vireshk-i7> <20240702051526.hyqhvmxnywofsjp2@vireshk-i7>
In-Reply-To: <20240702051526.hyqhvmxnywofsjp2@vireshk-i7>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 10 Jul 2024 15:51:35 +0200
Message-ID: <CAPDyKFoA9O5a6xZ+948QOzYqsRjk_0jJaSxeYRwx=76YsLHzXQ@mail.gmail.com>
Subject: Re: [PATCH] OPP: Fix support for required OPPs for multiple PM domains
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nikunj Kela <nkela@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jul 2024 at 07:15, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 01-07-24, 17:17, Viresh Kumar wrote:
> > What about this patch instead ?
> >
> > diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> > index 5f4598246a87..2086292f8355 100644
> > --- a/drivers/opp/core.c
> > +++ b/drivers/opp/core.c
> > @@ -1091,7 +1091,8 @@ static int _set_required_opps(struct device *dev, struct opp_table *opp_table,
> >               if (devs[index]) {
> >                       required_opp = opp ? opp->required_opps[index] : NULL;
> >
> > -                     ret = dev_pm_opp_set_opp(devs[index], required_opp);
> > +                     /* Set required OPPs forcefully */
> > +                     ret = dev_pm_opp_set_opp_forced(devs[index], required_opp, true);
>
> Maybe better to do just this instead:
>
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 5f4598246a87..9484acbeaa66 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1386,7 +1386,12 @@ int dev_pm_opp_set_opp(struct device *dev, struct dev_pm_opp *opp)
>                 return PTR_ERR(opp_table);
>         }
>
> -       ret = _set_opp(dev, opp_table, opp, NULL, false);
> +       /*
> +        * For a genpd's OPP table, we always want to set the OPP (and
> +        * performance level) and let the genpd core take care of aggregating
> +        * the votes. Set `forced` to true for a genpd here.
> +        */
> +       ret = _set_opp(dev, opp_table, opp, NULL, opp_table->is_genpd);
>         dev_pm_opp_put_opp_table(opp_table);

I think this should work, but in this case we seem to need a similar
thing for dev_pm_opp_set_rate().

Another option is to let _set_opp() check "opp_table->is_genpd" and
enforce the opp to be set in that case. Whatever you prefer, I can
re-spin the patch.

Kind regards
Uffe

