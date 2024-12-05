Return-Path: <linux-pm+bounces-18639-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA06A9E5F4C
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 21:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3267E28321E
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2024 20:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2DA22B8AD;
	Thu,  5 Dec 2024 20:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XChPQP//"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C1121323B
	for <linux-pm@vger.kernel.org>; Thu,  5 Dec 2024 20:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733429675; cv=none; b=LEhTI1H9m6XJB7KifQhW+cfTWU26eYfZAlROFpk6GBEZxWqbcid8o93GpsoZZBWy2KgRJVNQQ3m6H6hPKB9ORqbWOsAKiOlBI0JGHvyE6EGDI7S/CVXTmdEbVMxE6GpS4+OCU2p6+GLtCUukhfdFGSXOq6FWn7ZXIph+CEKs/T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733429675; c=relaxed/simple;
	bh=f5eqyhKVGnpVkF/wPyOpZrDNNpMh2nXC1um5w35dY3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V7PmGrmoipVnpT6Dzg3wME4nGBJDodQ3mc4pdhUWK3T53FyIeJiByoPSM8vyRpdGVmYFiDbii4eIzzeovFHWZGiCu1hMQxu7s/LSKbRXWAjkoZRncnFk9Tr5GLHCGbg81KHUKTrEm1TGKRQCoSG4/HdVsnT+CClxlRjR5KU9/gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XChPQP//; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53de771c5ebso1372985e87.2
        for <linux-pm@vger.kernel.org>; Thu, 05 Dec 2024 12:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733429672; x=1734034472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgqbKLEavaHLiZwSrnhECHdLW65ZvokO2Jg0XuF7dOY=;
        b=XChPQP//9J9IqxBgM8zboh/JpaP+YqXn/N/OxO0+RMRx12iMqCcKXMgK5beSZ5wvYt
         bdJNouXg5rqBGTJ2W6zm76+aqbWWfRq2pCfKwqMSLnrFg5MRwkdOI/5lFOYYJoD0iAqB
         5Q1UTbKiIGC9I+Dc+8DdkLBzLRamADTVlmw24exL03BxtB7TFc7nUhrnzGSMTKG3YadF
         BKiKKqk+KAt6Hrk8WYchB7W3A2mq9icLkwGeIGz1r3K5TyuE+hwYCD7avltpzpdf656q
         9PwNQnlFY8ZNIoGo/DD++OpsPRHuAAUIGipeodtTlKdAokSn341BoEF3fV55RZTMLnYd
         J8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733429672; x=1734034472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TgqbKLEavaHLiZwSrnhECHdLW65ZvokO2Jg0XuF7dOY=;
        b=bgQ1pK3ZM5ZPNSTNfnfnpkm4htdH9y4whlN0jIJlsbFuuN6/7wjWSGzbjdST9y+S5H
         rXJzUmtEhJthP8cfKFaJ7xaVhEPd6wiQAqqQ7DECL1cOwLNy3in4zotRmAKRmTTiwlC9
         GnAijL8H49tK0MZXlA7CFgykg2l/0b0kGTQTmi3QfftDUxzxkBnWGqfTzSG5N82jZCXX
         ZGvxFekBEZ2B2UC7Q89jCr/oBCJJelIF5Imp/UgPRhTHQiUHz19vSf3WQ1nLdgpewfKm
         ptkEQV+ViSfvxEfNhX/74ZiwXv6vuYG576gZrNQrJpyct0xL0RZpBbBDR2wjkkT4XSoo
         PrhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcPLDu5+4nE2yfJPzKG/FRwhsZvIXS+/oUjflJQD0Yy6NpeYXU00e5zcVcRJynfxDMkLc88Mk+Pg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNMMDlgp3RJ7Shk9JJoHQIlocTNbUQG0pFgDUm0JeadLEOCAYZ
	+l5lE2rQr4ooshHAcULXStQP7ZSHI5RgDKzceb2SX1wDTMiGIpbgw2bSuqa/eBraOiq1w5wMAeQ
	+0CvZQn3Tskml0+kwgUjA0Rr2npKOarm4wLCp
X-Gm-Gg: ASbGncs5hz62pZwfsYV8qyvpDDw6+LMjw13+VxsrNMbLJS6fR65rEdxqIWZCShBRq7A
	JQTYlN8QPS3KuJ4wkTCDm3ZluThWnNg==
X-Google-Smtp-Source: AGHT+IGFgkXtuPAnkojQK18RbIhqSfv7i03Oxy4ZIFKbCRFdxEWacRzHnAnPtUNduLvJgo8CdNg4Qw6xQAq+GxKER+s=
X-Received: by 2002:a05:6512:15a3:b0:53e:1bd3:889b with SMTP id
 2adb3069b0e04-53e2c2ac217mr89160e87.3.1733429671868; Thu, 05 Dec 2024
 12:14:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <087ef57d899c93f45ceffb8f9c5df3ad850b1e85.1733403513.git.geert+renesas@glider.be>
In-Reply-To: <087ef57d899c93f45ceffb8f9c5df3ad850b1e85.1733403513.git.geert+renesas@glider.be>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 5 Dec 2024 12:13:54 -0800
Message-ID: <CAGETcx8Wj8Ym-KHv6=J2aCSWn1YXKaXw0VVxdni+-qHJ5+14GQ@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: renesas: rcar-sysc: Drop fwnode_dev_initialized()
 call
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 5:00=E2=80=AFAM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> As of commit bab2d712eeaf9d60 ("PM: domains: Mark fwnodes when their
> powerdomain is added/removed") in v5.12, the pmdomain core takes care of
> marking the fwnode initialized, so there is no need to repeat it.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

If it works for you,

Acked-by: Saravana Kannan <saravanak@google.com>

-Saravana

> ---
>  drivers/pmdomain/renesas/rcar-sysc.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/pmdomain/renesas/rcar-sysc.c b/drivers/pmdomain/rene=
sas/rcar-sysc.c
> index b99326917330f5f1..dce1a6d37e80127d 100644
> --- a/drivers/pmdomain/renesas/rcar-sysc.c
> +++ b/drivers/pmdomain/renesas/rcar-sysc.c
> @@ -434,8 +434,6 @@ static int __init rcar_sysc_pd_init(void)
>         }
>
>         error =3D of_genpd_add_provider_onecell(np, &domains->onecell_dat=
a);
> -       if (!error)
> -               fwnode_dev_initialized(of_fwnode_handle(np), true);
>
>  out_put:
>         of_node_put(np);
> --
> 2.34.1
>

