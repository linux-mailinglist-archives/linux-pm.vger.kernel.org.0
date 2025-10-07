Return-Path: <linux-pm+bounces-35795-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E278BC2FBC
	for <lists+linux-pm@lfdr.de>; Wed, 08 Oct 2025 01:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2DDB3BAE2D
	for <lists+linux-pm@lfdr.de>; Tue,  7 Oct 2025 23:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94FB25DB1D;
	Tue,  7 Oct 2025 23:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uWu2AdXP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D2A256C89
	for <linux-pm@vger.kernel.org>; Tue,  7 Oct 2025 23:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759880671; cv=none; b=TJ01Ti6fyMT/0TbL/fW+INu+ytJKIOdKCBITKcp4nKzux870Le6IPlK5spuh0sCmh50gSzzTLLiAyNYal4uSFyBCitPFcnFjG9wecW/miT/zC+gfzJ8j6gVffTt9cJ4L/4xASDbHpbwmvcbZhLp21Zd9Jp9H3+aJOsAT7I+ce94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759880671; c=relaxed/simple;
	bh=LWJxA9v9v2ScNAsEI7ZemXtMQHe79nNOKWmzAuesTmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uz3NX1yIDTyGoGmn4Jh5GRx1kQ8BMrh+1F8aUqJacmR9C+peyjhSw2TBnlVxfuGE1peSZeQ9K2HyaHbWRxPxk75bww2PIE9370q/hxGMIecuF1YY9qc0e5C6vUqTMZrnSH959kA6ZdOHylfb0bBGJGpV8EA5MWQCKBuh21UJcuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uWu2AdXP; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-58b025fce96so6070692e87.1
        for <linux-pm@vger.kernel.org>; Tue, 07 Oct 2025 16:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759880667; x=1760485467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PdDPwXrUCndSUHvhfKd8OTKngDnEJjImy29CDVr9yNY=;
        b=uWu2AdXPaveVhZ0hUvgOqjmNfSNf2Uo2JdOZSsr8dz3gBDGXWZ/sJL93qcb+ChbFMs
         KCTMq/ZaV1VE3G7Rxwh9j1210SrBac373v+TvFyFMJBQem4Va0MICrUVHZkQj4HoGr5B
         LOm3KNuid7PYV4aea4i5PoyMv74/x2aCSFvAkCnE+pbbCmzhbejqoKw3b8zeDfmQksBF
         F7awmeg4JuvIRafaT638NxxjWTKCkxovWVzyLA+fjurWMFNdKMvMwvqR7HPslbSmguou
         FkpVTCkCXtByT/5CRFhqduThb+gp8UIuuTaD/ln2AgvV9HImgINB+qA5yQhJ/U1HaVLm
         7QYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759880667; x=1760485467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PdDPwXrUCndSUHvhfKd8OTKngDnEJjImy29CDVr9yNY=;
        b=w146ciCF4gk+yjPBGm1cDjj5xWBz9EsOue5Bdg7iYf+FQyu37x/KExxuUWjTwl96kr
         3sCM426ux1l9OETcOmuvsJT2u5tPOcqXyFWGsszUyU72FpO9oJoCdIhpvxTIOAHHtNqY
         EzuksNSVl1iru2G3OEl2gmC8QgsyVIMNb4GreqtJLbx2Arv+d4rZzhSFO4Er4IKWAKFU
         pHTH4ZKCDinFWUZmP8/wpbuuNtSYIdkvuq3BINGWF0wlGUU9O3Hp5Z5pDzHejyHByAIq
         GFEUx27DwynpRgFzpWXHhQGvVvKCTYXEs7htjdRbS/C3VTcMoFrcr3NEpUECzuFxpcZq
         dloQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCkDtrCpQCih8nfmJgA+4z7RVJjusDi8SEm37EILYwBhh5W/P3di6oNcvcGJgLdkqgGmd1W8lcWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/7jrsmKOMsjiogQ/4tvlHrnzf/PoeYvAvkjUF9Xomtt8qTyU+
	yT8w1XJJlI39sgM3iLE+ut84vl7KIymVgBHzRMZtkA6X8dj3BmjpxOk934u6FYdMK1RU3pJLBEl
	g57ZuknIn5t8ud1DFBv3CzkzdCmRoLaCxtf63DK+9
X-Gm-Gg: ASbGncsziMQm9dbEe8sZ/qft0F2gZMU+GVOA0KGRrxe391RgBkRWu/QZNPkXFpjFVMo
	+yB4K2k9yEAzT9CbSBhuIAFQ8TpCGosjlX7/BTxJezmwzK3Y9ddXtd/QVQzYOfHp2GDMx5yTFt2
	sS572uVOjPpouu9hp9wrLaHyLJoBDeCMGV24ss5wYpN/jydjKt98EBSVoTRoSLzslbEI6TWCgW/
	AFngtqgFLmyToKARAlAH7uCeppwC9U6LW/asmDCREmAKBdC0UgAVb7NAeBNucutZqE=
X-Google-Smtp-Source: AGHT+IFdQL3eR/SOY67StQecANO2VnRWAmFtiPakOZFHiUlJOwj6Imv4TzH8+nP6L5X2EcxtVc6+58+BQM9eZ3HYWqg=
X-Received: by 2002:a05:6512:4026:b0:57e:c1e6:ba2 with SMTP id
 2adb3069b0e04-5906d77df4dmr344264e87.1.1759880667021; Tue, 07 Oct 2025
 16:44:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007094312.590819-1-ulf.hansson@linaro.org>
In-Reply-To: <20251007094312.590819-1-ulf.hansson@linaro.org>
From: Saravana Kannan <saravanak@google.com>
Date: Tue, 7 Oct 2025 16:43:48 -0700
X-Gm-Features: AS18NWCXcm6CMIZDapU-gXtRMN_nrbL2_9een9pVr80YceX_ze5s2D5g_553M3c
Message-ID: <CAGETcx_=_wAdozOvF6KcNiJj4NeGzBy6sXYQsJMLZLFb819Lrw@mail.gmail.com>
Subject: Re: [PATCH v2] driver core: fw_devlink: Don't warn about sync_state() pending
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-pm@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, Heiko Stuebner <heiko@sntech.de>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Sebin Francis <sebin.francis@ti.com>, 
	Diederik de Haas <didi.debian@cknow.org>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Jon Hunter <jonathanh@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 2:43=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
>
> Due to the wider deployment of the ->sync_state() support, for PM domains
> for example, we are receiving reports about the sync_state() pending
> message that is being logged in fw_devlink_dev_sync_state(). In particula=
r
> as it's printed at the warning level, which is questionable.
>
> Even if it certainly is useful to know that the ->sync_state() condition
> could not be met, there may be nothing wrong with it. For example, a driv=
er
> may be built as module and are still waiting to be initialized/probed. Fo=
r
> this reason let's move to the info level for now.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reported-by: Sebin Francis <sebin.francis@ti.com>
> Reported-by: Diederik de Haas <didi.debian@cknow.org>
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Changes in v2:
>         - Due to discussions on v1 and because the default Kconfig is to =
use the
>         FW_DEVLINK_SYNC_STATE_STRICT, I suggest that for now it may be be=
st to
>         keep the warning level for the "Timed out.." print and only chang=
e the
>         "sync_state pending..." message.

Acked-by: Saravana Kannan <saravanak@google.com>

-Saravana

>
> ---
>  drivers/base/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index d22d6b23e758..c62e428b95b0 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1784,7 +1784,7 @@ static int fw_devlink_dev_sync_state(struct device =
*dev, void *data)
>                 return 0;
>
>         if (fw_devlink_sync_state =3D=3D FW_DEVLINK_SYNC_STATE_STRICT) {
> -               dev_warn(sup, "sync_state() pending due to %s\n",
> +               dev_info(sup, "sync_state() pending due to %s\n",
>                          dev_name(link->consumer));
>                 return 0;
>         }
> --
> 2.43.0
>

