Return-Path: <linux-pm+bounces-16390-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 630099AE978
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 16:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C0911F230AC
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 14:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB091B3937;
	Thu, 24 Oct 2024 14:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmsnmuZ9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656651D8E18;
	Thu, 24 Oct 2024 14:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729781899; cv=none; b=rKQ7//AQtt28nTs/mqBroNrpv+vqp+5jLtJQm9s4eXOAIS+Q1k08KG9Arj5PdBiYzw5EBamSP1bLix3xLm0Ju8sMS1jvB1wG1BzBUSJkP2SNMPFpK9qreoDsWgEnL4R7IHRjSgnwl7ivXJmWgbS44UGj7E5Iq1it+TrxTFCqrOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729781899; c=relaxed/simple;
	bh=WMuced0vaG9vgW81c5xcCRNiamdOoqzC+tfHF7zsheo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bipWvEjUeWTRE4wYDdqDlFffZOPWtHJQqVPgHLMbaXdA9Mk/zhSrStCp7LDQdnZtzS8hn/EPPkUl/wudLx2QLRpNN2U6ub7gmstSKA0gDJYZuo2oIsNQaX3QXmOm/xKkPQwC4R3QtvRAWXJxQjbFVF9I+FBOZmnaFTk3xsj+hcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmsnmuZ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5F8C4CEE3;
	Thu, 24 Oct 2024 14:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729781898;
	bh=WMuced0vaG9vgW81c5xcCRNiamdOoqzC+tfHF7zsheo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HmsnmuZ9jUKrGRaD94bbQLIQLewgExkwGAL38we6Q0KmtSVTPdW+FVQMs6ROhTniH
	 HPD6XaGNBF/UtVcXip5C37QavvvXuKXXd0cIgNrTCmZNx9YSEhRjdDM+VWRGb0klPu
	 6riMImVP2ARI5kZigD8K4m9pvK+wItNmAUYh/WTyrNeF1A3Z22UBuPyoOps7ZPLPcQ
	 lz2puGZqFqCRyL6Bwb2HNfU+Nmy6AGy8nB2v8g/TgqbJ/2wCXa/8kZZ2j7NgV1n3Zj
	 4NJGFQE+qwit9L+qlUVzjJrYn6THMCIyggHKL0yDhl7d9VavNwaz+TbZxI0Zavet0F
	 fQ7gDyiC46w0w==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-288fa5ce8f0so532264fac.3;
        Thu, 24 Oct 2024 07:58:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV5kdOXnT2H726nwihXMfQUIhADmMlCsMA7/jHOFHM0Nj7LsnDd+YKGXjrItLskeb02N3YcL1OjXQI=@vger.kernel.org, AJvYcCXsrHmoIgKP5f9gdL2bs1W4GnyJnTGY7vpVda28YuO+3PBru5+9muISk8iLxLU8I0YHGre1nhXdFZ1xFdI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+7YMjEB8CQxefY2iudG2ykYMAjflZ6eSld1WA1wuP02/rYuBf
	IBhy8NP4aRezTWwyhubAFz1s26pmRkeKEQ0HXt1K9dY9oK01HWZhq1hTQuQtQ9qdjvYgKPRvl54
	fWJU0gn9Kbh2rESQLv/TFurypP7U=
X-Google-Smtp-Source: AGHT+IHNihae96z9eqtqsVaIOQLO/p2kssxb6pBkaTPtDcOx/puM2UCJjY3nySqLgzB1TSGTG0epO+wpRioBGHVq0u0=
X-Received: by 2002:a05:6870:b4a9:b0:261:22a4:9235 with SMTP id
 586e51a60fabf-28ccb985595mr6693222fac.32.1729781898134; Thu, 24 Oct 2024
 07:58:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024142629.1146298-1-daniel.lezcano@linaro.org>
In-Reply-To: <20241024142629.1146298-1-daniel.lezcano@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 24 Oct 2024 16:58:06 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iFxkOVg6FZa4Ut5FRaa0uC0ngSuOuacVn6yc3JFiw-Bw@mail.gmail.com>
Message-ID: <CAJZ5v0iFxkOVg6FZa4Ut5FRaa0uC0ngSuOuacVn6yc3JFiw-Bw@mail.gmail.com>
Subject: Re: [PATCH v2] thermal/lib: Fix memory leak on error in thermal_genl_auto()
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rafael@kernel.org, Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>, 
	"open list:THERMAL" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 4:26=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The function thermal_genl_auto() does not free the allocated message
> in the error path. Fix that by putting a out label and jump to it
> which will free the message instead of directly returning an error.
>
> Reported-by: Lukasz Luba <lukasz.luba@arm.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   Changelog:
>     - V2:
>       - Return when the allocation fails instead of going to the out
>         label resulting in a NULL pointer passed to nlmsg_free()
> ---
>  tools/lib/thermal/commands.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/tools/lib/thermal/commands.c b/tools/lib/thermal/commands.c
> index bcf0f14d035a..4998cec793ed 100644
> --- a/tools/lib/thermal/commands.c
> +++ b/tools/lib/thermal/commands.c
> @@ -375,6 +375,7 @@ static thermal_error_t thermal_genl_auto(struct therm=
al_handler *th, cmd_cb_t cm
>                                          struct cmd_param *param,
>                                          int cmd, int flags, void *arg)
>  {
> +       thermal_error_t ret =3D THERMAL_ERROR;
>         struct nl_msg *msg;
>         void *hdr;
>
> @@ -385,17 +386,19 @@ static thermal_error_t thermal_genl_auto(struct the=
rmal_handler *th, cmd_cb_t cm
>         hdr =3D genlmsg_put(msg, NL_AUTO_PORT, NL_AUTO_SEQ, thermal_cmd_o=
ps.o_id,
>                           0, flags, cmd, THERMAL_GENL_VERSION);
>         if (!hdr)
> -               return THERMAL_ERROR;
> +               goto out;
>
>         if (cmd_cb && cmd_cb(msg, param))
> -               return THERMAL_ERROR;
> +               goto out;
>
>         if (nl_send_msg(th->sk_cmd, th->cb_cmd, msg, genl_handle_msg, arg=
))
> -               return THERMAL_ERROR;
> +               goto out;
>
> +       ret =3D THERMAL_SUCCESS;
> +out:
>         nlmsg_free(msg);
>
> -       return THERMAL_SUCCESS;
> +       return ret;
>  }
>
>  thermal_error_t thermal_cmd_get_tz(struct thermal_handler *th, struct th=
ermal_zone **tz)
> --

Applied, thanks!

