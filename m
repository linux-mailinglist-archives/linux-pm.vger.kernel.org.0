Return-Path: <linux-pm+bounces-12585-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A30958EBB
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 21:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B10CB1F2312F
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 19:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBA41598E3;
	Tue, 20 Aug 2024 19:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKtMlnN3"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5A318E344;
	Tue, 20 Aug 2024 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724183098; cv=none; b=fXvG10q632PngVcSA3dyksUBTgE2ZpV8AujGzCgpkol91HBEf8yceiFY/4CQ3X2hqYLUu366o8pT4TXIGQZF/GF2A2sydJQ7Q09RGd/n64nowgKxMycHggfBwN9cPAV7cwLlN5gcgvDvdNZ2Q8/UlmcGms21YdTN/Ve1E4R10G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724183098; c=relaxed/simple;
	bh=5zNMj6jOkWngChBd/1xsuHniRvKqUbXx1HRiMAzGvUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hnxsrW54OdPE+k2HIbCz2uvEIWysS/TrDasqRykXulKLGD4K5TF+Q6oB9hRGgVg7rQYkCLBGY5ozWaOuncNlnuby5NQIWlb7EjV8fiFa3+ytDAvjKRktaZ+Z2DGVAN3NP/q1SsF/NOpXJNKVZxyUWMtNZttpJ3uBLazvp6Pkn9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKtMlnN3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E40C4AF0B;
	Tue, 20 Aug 2024 19:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724183098;
	bh=5zNMj6jOkWngChBd/1xsuHniRvKqUbXx1HRiMAzGvUI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hKtMlnN3srgkr78qdhVU8x+LRFQioBuWD9xyS5SuiQX5KnBrquFH7C+dtigb6+OdG
	 tbiYjSzBn2kVjf4NDhkvdgKodu2RPleOBVTsC68LHkthvEOjy38u7X4KQfTD9QJNET
	 4aWxwvdV3uGuOwSi8WXgPVR8DNinvSffRAVA8V+IpctDWMtbNOfOimr8RM43DaoZQb
	 4iX3JyU8mII1Tm3xhK5bGXurcJZ/Gb83pHdjfecb0rtB2os1CbBmzzD4kf+yCj7AIv
	 M5QlhdUNzl7t+r2EiksXEuSzS8Bq71YpUfM1XzC8rpEo6wrh1nCnYfhxVokwrK0yty
	 r5YwsYS16VDDQ==
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7093d565310so4454037a34.2;
        Tue, 20 Aug 2024 12:44:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUAct0MqKow3HZqzw/wAsp05+UKf0K57skVj150zacXOXIO3PR6nBc8eHa6G5O32knz1wDllrCVQKj5wIzJ@vger.kernel.org, AJvYcCWgSyhHILkOA8ssFLWWUp1b26Ngr4kPMXC17EfTbVUT9X2VT4mP7kNVbjAIfS2k9Klv7tgfQC6h+dCTK+hruPs=@vger.kernel.org, AJvYcCXgUaNkdOsp+nV6t4NizUxYujsBlDTaOUnaArajQG7r66KTLyEuG7/mv9Z85yDZDmwLpBPV/WdoLhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YymQPRkVR6NdoQXDTW5u1PpjLaCpvgETHettFbAMP9ou99DHFoY
	R2Ywmrn1dGMyha9nQP1rrxvCeD5pS6ZZaiNT6CrHI/2h9Ppy6VSaVFA5OvzHm1nOpbYoSaOWsxn
	f6Qb2YajSRKXaEQFmCUiDkLFpkRE=
X-Google-Smtp-Source: AGHT+IEv5xnvO58H1asFV+sqhstPmFN30r9iiFj5GLMWIrz4UaJDHnD6zG2CIWOSdjqPqqD8aC30Ankwg/xC7z4VbMI=
X-Received: by 2002:a05:6871:8a8:b0:260:e2ed:1abe with SMTP id
 586e51a60fabf-270815de11bmr3621294fac.39.1724183097689; Tue, 20 Aug 2024
 12:44:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <86e3a059-504d-4795-a5ea-4a653f3b41f8@stanley.mountain>
In-Reply-To: <86e3a059-504d-4795-a5ea-4a653f3b41f8@stanley.mountain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 20 Aug 2024 21:44:46 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ixtyB4FFEBAUru-hRh5bfCKeCEJw2+_0gvWMiboRrs2Q@mail.gmail.com>
Message-ID: <CAJZ5v0ixtyB4FFEBAUru-hRh5bfCKeCEJw2+_0gvWMiboRrs2Q@mail.gmail.com>
Subject: Re: [PATCH] powercap: intel_rapl: Fix off by one in get_rpi()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 10:41=E2=80=AFAM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:
>
> The rp->priv->rpi array is either rpi_msr or rpi_tpmi which have
> NR_RAPL_PRIMITIVES number of elements.  Thus the > needs to be >=3D
> to prevent an off by one access.
>
> Fixes: 98ff639a7289 ("powercap: intel_rapl: Support per Interface primiti=
ve information")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/powercap/intel_rapl_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/inte=
l_rapl_common.c
> index 8b7a5a31e8c1..67aec73511a7 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -740,7 +740,7 @@ static struct rapl_primitive_info *get_rpi(struct rap=
l_package *rp, int prim)
>  {
>         struct rapl_primitive_info *rpi =3D rp->priv->rpi;
>
> -       if (prim < 0 || prim > NR_RAPL_PRIMITIVES || !rpi)
> +       if (prim < 0 || prim >=3D NR_RAPL_PRIMITIVES || !rpi)
>                 return NULL;
>
>         return &rpi[prim];
> --

Applied as 6.12 material, thanks!

