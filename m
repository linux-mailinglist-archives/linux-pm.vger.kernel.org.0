Return-Path: <linux-pm+bounces-2485-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 110CD836BCE
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jan 2024 17:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80BCBB31368
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jan 2024 16:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62A55A7A9;
	Mon, 22 Jan 2024 15:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kCq97zwi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5935A796
	for <linux-pm@vger.kernel.org>; Mon, 22 Jan 2024 15:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936950; cv=none; b=NMCZqHObl+/imSbBgTq69YUECQ1VUeFEvEcPIR42efgztGs/bFdyvF1mRsKII7sJTOrqlJwaEgD5KYhydYcGNlLEVC/PAJ/WJF4cTBVhbaF98bNHV47zwZhjIAFsQ22j7P16uPF/b1xgOHw+hq3EZrTNrf4FATIcS5mDXtqNWMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936950; c=relaxed/simple;
	bh=iehecb528leRzyo9EGBQ3VZAVNJQWB829o9SIxb+duk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KbxYIvKKdCeYtYy/iV83jqOxBltsKBhrlHX39mPymHSZMsT+mP2tCLlBlkcR14yAIUXDoGmDS9h2ZEElOB7NsrYWcjN541SWnFItkeB4UJgU16MxHp62f7MSLouY9c+EQ6nS8GgSeGlYatmo2L046zTdaUCRZMfpo9TsyYWUc0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kCq97zwi; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5ebca94cf74so30191817b3.0
        for <linux-pm@vger.kernel.org>; Mon, 22 Jan 2024 07:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705936948; x=1706541748; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JgiZtCrMuZLXNw6xrqc0GV9xSUaAfBF4r7Sl8Qdw7jA=;
        b=kCq97zwi56PjcBbUpc2uVv5/p+yY7J/+X7kx2/TSEz6Zv8TXuP4IPeywh+Q4HNvPdK
         hZy4KmtBwPh9b6k/Dk17TanTvkXLh60+vC7grNbN4Vpec1GmGj4rF9hJNZ7wDbp5YJDS
         1fylbaINnRILuz3VJTxP/6jbC95z6XCNBhKBjaffCNHth1/FXlOUfxLTd6Waqmg11cdk
         yw5UNbiNe+IDTVbernQbiDoKGQBSBBQsm3jRygr/ulKGT/g9AAvfgxuAa7FESu8LfPLG
         8BiDuPzCF6Qc9sjAF4aqnKLnsk66Yj302xvgiAfjNoWAita4VkE5Nd8aogI8/R2XKuCg
         DqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705936948; x=1706541748;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JgiZtCrMuZLXNw6xrqc0GV9xSUaAfBF4r7Sl8Qdw7jA=;
        b=bGVQjLpn2pY4pcW4TafVMbeQKkLlyRrIBpLN2J2djo4DRddK9DluYUXa7Bxmn94UGZ
         W/kHSOmIdwEcef2vTKH6v3dBghicSXY/HQ02ZhkObri54Ju8+3r4XGbgBdaXGygCwFLz
         WhlluKwOKN4+F+TcpJsKkG3+BW0Y0WCbo6VHlbQrr8KGIk4YcfLVpuJd9evNF1FxJ2h9
         2QE1MIQNGAQjDg6miqj6gGDnNmja5OBwhUVuy2xM7W8ZKrCmQxcn8NuIk++jK9dH/V7g
         3Qenu6FoPLPUVBi22XfTvt8Fm+hFDEawgJs5tezFYeNXHLzQjUxkyhBJXlZYi7FGAio0
         0aYw==
X-Gm-Message-State: AOJu0YxyStVpHamFUyzKmPyGM1j8ATQXEOcmJ5AYB33sZWNBQW3L3BPT
	GSM2olNNVNa4uLrv3uQryX9bepaPXC9cYpRJk5FtGXKTOhynU2pYh8ZQabUAfXDz4ERyegTw+v/
	l09KjN7PRkaldosH6R9XyWnaEE+jMjbIPNJ23mA==
X-Google-Smtp-Source: AGHT+IHOaa3SNYwCf68k2MmEZ+Vul7ql0avy2YB111DnZq3iZ38/pX3VQpszd24XmWino4rYa0tTrsM3A3651pm14P8=
X-Received: by 2002:a81:9113:0:b0:5e3:320b:7c with SMTP id i19-20020a819113000000b005e3320b007cmr3683898ywg.37.1705936948280;
 Mon, 22 Jan 2024 07:22:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118054257.200814-1-chentao@kylinos.cn>
In-Reply-To: <20240118054257.200814-1-chentao@kylinos.cn>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 22 Jan 2024 16:21:52 +0100
Message-ID: <CAPDyKFp=s7aOnpXti=rGTri=exW7sHdH693TEz7cQTiv=2gnFw@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: Add a null pointer check to the omap_prm_domain_init
To: Kunwu Chan <chentao@kylinos.cn>
Cc: nm@ti.com, ssantosh@kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Jan 2024 at 06:43, Kunwu Chan <chentao@kylinos.cn> wrote:
>
> devm_kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure. Ensure the allocation was successful
> by checking the pointer validity.
>
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/ti/omap_prm.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/pmdomain/ti/omap_prm.c b/drivers/pmdomain/ti/omap_prm.c
> index c2feae3a634c..b8ceb3c2b81c 100644
> --- a/drivers/pmdomain/ti/omap_prm.c
> +++ b/drivers/pmdomain/ti/omap_prm.c
> @@ -695,6 +695,8 @@ static int omap_prm_domain_init(struct device *dev, struct omap_prm *prm)
>         data = prm->data;
>         name = devm_kasprintf(dev, GFP_KERNEL, "prm_%s",
>                               data->name);
> +       if (!name)
> +               return -ENOMEM;
>
>         prmd->dev = dev;
>         prmd->prm = prm;
> --
> 2.39.2
>

