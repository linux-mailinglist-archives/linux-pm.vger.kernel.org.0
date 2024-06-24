Return-Path: <linux-pm+bounces-9896-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 965AB915149
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 17:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F0151F235A7
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 15:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9235919B3CB;
	Mon, 24 Jun 2024 15:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UsHTLzEO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0396413B2A9
	for <linux-pm@vger.kernel.org>; Mon, 24 Jun 2024 15:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719241414; cv=none; b=WZJR05qVoDU72rC+bA5Mp7VvMc16NhReaD02i6Whe+bdBwkw3RQCb0v7lnMgMrw8swCrP1898whz5jJgfNTxPkoUgX4GYF0247FEorTPeaPOph1K6OOJSb5VSTDL9l69gqwa2NGhv8aSMQfum9xWlZ3A+27aOtn/N013EeTYfnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719241414; c=relaxed/simple;
	bh=Ex/w9v0ggVRKNBzIpeN9n70AI3dUUvfOjWRl1ppkA0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R7W8e11cPoGhzncEuJcuLHYWr3I33lG6Xemu8L4Q6rZGMlh3BhimzWpPbi6Ew7+sMN3ZDkG22uH7h4XNjh7BQBFCW2/8mPiOtc0lGwvtnRBwgWjspZgTjFqTnzhyI1F1qQ9OCUvnTClUnYW1x4BwbYEwIwHhQIc1ZJbtga38Mxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UsHTLzEO; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dff02b8a956so3945710276.1
        for <linux-pm@vger.kernel.org>; Mon, 24 Jun 2024 08:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719241412; x=1719846212; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OsE3fTT5myBrFEQHKtx08Zi/1nBt7udSIXRFFLGo1WU=;
        b=UsHTLzEOAfLzsiibJUGbXzLmcduUUcSnxobGfufnUMGou9vIAqsPXDMkpz0J82J5A9
         d7YVawuaPtQnS4zPLx4SKGW1A1B5/nar1Bn8WL+Tvyhx8djAHNkANR9SSAbOKYNHn6c1
         2I1jJk50+4CgkY0KDle+qdcR4MHckElM+OvKo+RFZWqkyiLuiZMBQmgLP/55z0wW73iu
         XRIml5ScssTFmf+DEWeMbPU2hu8DNt/26army5eXXwqTDuSckZweZZZm/lsCa8dWnXnV
         4QaOqJdb5JxfF0Se4HcJVYaVy1FuApO2RggXo+RjclKgoSESZEMM508upLkF26u6hsIJ
         O5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719241412; x=1719846212;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OsE3fTT5myBrFEQHKtx08Zi/1nBt7udSIXRFFLGo1WU=;
        b=Gx7iK/GVQ5kjumiVikYXC9b47fVlBuQWsfn6mU7qp1eR6F4s4g8ELgA0CKE85xrBzZ
         S5MggA9EqJodjqP9/9kzqky+0OzU9VHs/g/ujdpEvkmh0cBb9lAOJv3UK1G3mW7af8nt
         OfyaLbPR2Tzx/wwG43U2mXJy8ztfxHFojbLzyX/gITfqOP2RgJ6icuW7RVzLYtTizCFA
         eVtVcYMBlzDBcGmTdbBpYAPpvN3MaDkk15RCVWQlrUSuEmvVrpi6wWiYnzZRWYA5vk5g
         iIpm+dgya5O8k86k5jPu8vXMfPjW+moTMn1VqkQX0hiqP4BqssfgylBXar/SS0Ktl2/y
         9EjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUObrgzIhxDSwOxUxQTFngyFNi5Sgj6UDKPexTBwk8MC5NEODKxlmdUse+ufP4S9PWI6v6QEul5oywbBYYB+Yl/2hBG2VNq9XI=
X-Gm-Message-State: AOJu0YypXTNwY9K4OI1VNy6izw2ydJTkpEriZhwcqd7Gq6XHlzW2t50J
	YMOGGnyvmG5l8mZ3pi1FB4rH2Cu00EcNUerVpB3EADa6F7U4CVIcXS9E4wdVaUZnvTKBakqxyCY
	v19pyYkqFqvnDq8KHv85RdeEkETBDcRpbUamQAw==
X-Google-Smtp-Source: AGHT+IFgZJP9TONG6Jdr6OwJ5dbwU5KibjnajMQumI5uC2m49JmAMbhUf6jDpZqQJR81wrPLtZsJyh+DTLgw9R0rJzA=
X-Received: by 2002:a25:c789:0:b0:dfa:d056:a901 with SMTP id
 3f1490d57ef6-e03010ba58dmr4935858276.56.1719241411838; Mon, 24 Jun 2024
 08:03:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619140849.368580-1-ulf.hansson@linaro.org> <12b17db6-2649-4b7e-a35e-797ba2d9f2aa@linaro.org>
In-Reply-To: <12b17db6-2649-4b7e-a35e-797ba2d9f2aa@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 24 Jun 2024 17:02:55 +0200
Message-ID: <CAPDyKFpPvsEhVMpxjJt1+QmY0LsHrDZ+RkFMfYrHQnWUcaVSbQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] OPP/pmdomain: Assign required_devs for required OPPs
 through genpd
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Nikunj Kela <nkela@quicinc.com>, 
	Prasad Sodagudi <psodagud@quicinc.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 22 Jun 2024 at 14:18, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> On 19.06.2024 4:08 PM, Ulf Hansson wrote:
> > Through dev_pm_opp_set_config() the _opp_attach_genpd() allows consumer
> > drivers to hook up a device to its PM domains. This works for both a single
> > and multiple PM domains. Their corresponding virtual devices that are
> > created by genpd during attach, are later being assigned as the
> > required_devs for the corresponding required OPPs.
> >
> > In principle this works fine, but there are some problems. Especially as
> > the index for a "required-opps" may not necessarily need to match the index
> > for the "power-domain" in DT, in which case things gets screwed up.
>
> So, is this series essentially tackling a problem like this:
>
> pdp_A: power-domain-provider@aaaaaa {
>         [...]
>
>         opp-table {
>                 pdp_A_opp0: opp-0 {
>                         opp-level = <0>;
>                 };
>         };
> };
>
> pdp_B: power-domain-provider@bbbbbbb {
>         [...]
>
>         opp-table {
>                 pdp_B_opp0: opp-0 {
>                         opp-level = <0>;
>                 };
>         };
> };
>
> nice-device@ccccccc {
>         [...]
>
>         power-domains = <&pdp_A>,
>                         <&pdp_B>;
>         // order doesn't match /\
>         required-opps = <&pdp_B_opp0>,
>                         <&pdp_A_opp0>;
> };
>
>
> ?
>

Correct, this should be taken care off by $subject series.

Kind regards
Uffe

