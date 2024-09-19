Return-Path: <linux-pm+bounces-14494-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F29DB97CE2B
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 21:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37CF61C220D4
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 19:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C8438FAD;
	Thu, 19 Sep 2024 19:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BW3ZihHQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF06738DDB
	for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2024 19:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726774766; cv=none; b=j0NkZYU98asq82wNnzWMTeD4BK+slU6Gt5tZpWQf5r0HacTZzqybjmwi0TXkQK2k3pOxqtLj1u6RyGZ5DPGy7xLXELhWY9JDrh+Tvj8AROCsS9NVfWaZJD40JYt/cPvqN35Dk5WPSPU2v7/65XgPFuFCule9FaBhA5iXWFMEMXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726774766; c=relaxed/simple;
	bh=fof4Y+XqAIEawmDZiNjGYccb4vYXEW3pxTGZwYqjodc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mmb47MG4SscIr5OynIv23wnpLSbWIOn/jH+OBq5MDTMwvgL4bnhLBRzpMuAlbTADYBgI3DKLvQT2pPYayeIYJXX2uaPNLdeBhzgw0UKemkOXbTTe5zlYbqSedMWRMCdTdyfrwIUBtKvApEc9XEe7gQZtaVhbPC1C63yUuMsRwUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BW3ZihHQ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a83562f9be9so147411266b.0
        for <linux-pm@vger.kernel.org>; Thu, 19 Sep 2024 12:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726774763; x=1727379563; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W7DLrUqqQ4L4ci5VnJmW7hDeRDd57P0ACw668zHYYqg=;
        b=BW3ZihHQVyhgyRPxhILVRVsjkSI5rqeYl6iDkgXipNfyLE3B1Lvow+xh00k9du/1UI
         NL1nt0ILIkLN0I2SWbLfcFw2R5sMsmV0nW0p5n0kPNvDqe8KxIJktm5DWoxV9vbcbmki
         UeB/x9HGboOzDVz+w8FddXb8hbldwgpfh3OGt0UQo/4Lx309rXIoshV82vL7KR6VXkGq
         pQ864xa3z6pMX6wbKgn+XQZA5w9M9Af6DG3HYSVdly+FVui3pmpKh0V7z2xVpPKwTr6u
         6qss0myJTOfEFWrOwOmQgHrFY49CgQisVKOdd5TOnCv/MuLY1Ka2UzfrvTNIdV/V44C8
         TmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726774763; x=1727379563;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W7DLrUqqQ4L4ci5VnJmW7hDeRDd57P0ACw668zHYYqg=;
        b=TgonzLaAVycbPB10tEMqV0HHadEon2LYJsP5duRttK/f5rTK1vGNZKNlEFNky0WAnP
         BSPpE68jN4K+7tP1w9fUBOe4W5YmexY3ISxOeMfKz2WFVmg0rbPQuX8q0dYP3qHhQA+4
         dnPcgNSoYCfJlULULWzeV8/w9Ys9PtbV7to/IoDnNyVvkNHmpnI9SsMKWXuH1I7m5fMJ
         7wmJJ2RbkIRd0SEwIAsAlLaQv09xKoiq/F8gLS0lLQKZ+UCvCLkjsoXIopNvP4jlDWFG
         vsgnROllvnYktJ4eZtnfvef6An2oBQl1LyEGGYAuFxTBmop4JmwLyG9eWERM6EGurV6t
         21OQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVxZOjXw4xf8BYH9KrFEysGQl8GabYzadDJfQ2LOgmPbgUzroG9KWjFPdBN4XGKM65wqM6XAHXoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxB0DhyoflkggWT2tNrRWTo4STP0plj+mmbDRgQILe0ClwFYGn3
	SK5621JLJ7ujX8IE20Wv4KlmMEwJogn5lS2G6ZlRHnUlBt14/C0vEVcIhOiGLnOwkv2nTZ/f+Bm
	LoVqjEzMJsHPxCXqdRUZ3BJrcu9LGg774lqK5Cg==
X-Google-Smtp-Source: AGHT+IHFssq6SEY8xmjw8fzlMOVLwF7nUAg01vJG44H7tx5slPYYutozOjG4yTxIRsVA+zkzobhXmI1ODIc37gj+aQs=
X-Received: by 2002:a17:907:c897:b0:a86:8f7b:9f19 with SMTP id
 a640c23a62f3a-a90d50eec19mr23301766b.52.1726774763253; Thu, 19 Sep 2024
 12:39:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3f3660af-4ea0-4a89-b3b7-58de7b16d7a5@stanley.mountain>
In-Reply-To: <3f3660af-4ea0-4a89-b3b7-58de7b16d7a5@stanley.mountain>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 20 Sep 2024 01:09:11 +0530
Message-ID: <CAKohpo=x6CvzwcJjYscV6qTdj=K3qECjwNj-EV5L4n8O+-WoTw@mail.gmail.com>
Subject: Re: [PATCH] OPP: fix error code in dev_pm_opp_set_config()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Sept 2024 at 19:37, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> This is an error path so set the error code.  Smatch complains about the
> current code:
>
>     drivers/opp/core.c:2660 dev_pm_opp_set_config()
>     error: uninitialized symbol 'ret'.
>
> Fixes: e37440e7e2c2 ("OPP: Call dev_pm_opp_set_opp() for required OPPs")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/opp/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 494f8860220d..3aa18737470f 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -2630,8 +2630,10 @@ int dev_pm_opp_set_config(struct device *dev, struct dev_pm_opp_config *config)
>
>         /* Attach genpds */
>         if (config->genpd_names) {
> -               if (config->required_devs)
> +               if (config->required_devs) {
> +                       ret = -EINVAL;
>                         goto err;
> +               }
>
>                 ret = _opp_attach_genpd(opp_table, dev, config->genpd_names,
>                                         config->virt_devs);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

(Ulf should be picking this patch for now)

