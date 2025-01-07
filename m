Return-Path: <linux-pm+bounces-20060-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0177CA049F5
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 20:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73A4518881BA
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2025 19:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2658C1F4E38;
	Tue,  7 Jan 2025 19:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQ6wiGvy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018631F470C
	for <linux-pm@vger.kernel.org>; Tue,  7 Jan 2025 19:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736277000; cv=none; b=d+YXECTpIxC3gwAh+1Om7Mds6tEVLm9l7lt+GLdVcpjoKYgQScJi9Ey8afop3Z8Hk1v4IdpnyK2IlkH7K+PRYxoTf+59Z4hq6U49rjir7SF7wVUcNpWNFAyy0cFs5nCWICB0k2uZFjLJa6FquDQjJss8QoD5Je0uxgDQ3QLpkXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736277000; c=relaxed/simple;
	bh=Yf2haJUFwDZ+lCJcbwEoQW+Q+h/XwQqCO+wx6ZW2EVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uLCjR/w5Boy26ERxiSWaeBEmEyWG40xFXDPHMOOivbti+h3LrOojcq007pYelzmIeZPCUMVlnODGfT8GfT2WH+eYSRFiXppcj19mGvBUh0XVZeBHkPzC/baaYzynuB4cul60tjHTJ18Mv5OTnWxugeMM0ID5anahJTsL+hETqjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQ6wiGvy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B4B7C4CEE3
	for <linux-pm@vger.kernel.org>; Tue,  7 Jan 2025 19:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736276999;
	bh=Yf2haJUFwDZ+lCJcbwEoQW+Q+h/XwQqCO+wx6ZW2EVs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WQ6wiGvykoc/d80XBgW3nCHFzw4WbwwxiJ8++8eZxcxSR/vbCBqNI4UwzhzdXQLdo
	 rLuFfZcEarkACUViyx095qXDNkh/gSV5TLYGPo3ZV/vZR9d2f9LgMtfa3PdJEtsPtb
	 Bl4cHD46UK8A2Ibzu0iI5qBES0F1dtnEn71zwXyFhrFRx8G5J/IfNeuymdrV6g0Lzm
	 1+lFWieiEaKxjoQ1F+RggdFPLCFMJbeix/6q2y23yy+A+REIB2nwNhyCqss+azU1/y
	 595SfwSodSqe5Ge4fOBDMTbSk9uecrf2gPYqj2oMnIH8iZEMtveJCBi8Ff8irEpRe0
	 WmYtmNQq4Ht+w==
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3ebb4aae80dso6619702b6e.2
        for <linux-pm@vger.kernel.org>; Tue, 07 Jan 2025 11:09:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW4jZF3djNptd6JhMZP5vi6IjlJXQSwkiLULM1gDa2GBku1E5h950yuawWjUZaTST4TSOE8VRLchQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yya+IeUOOSLM9jOeoqhoFLobr2cM1+dEHx4BswkgSdoO7fHxgje
	nF82BOWJdrVW88UlkG6anlrPGKZEU182fcFqVUuzH2HENYeUA9aSycuuFeeiO7dYZvGnpBAFN05
	ScqZYpMsSB8fzRovoYVvqscMoLX0=
X-Google-Smtp-Source: AGHT+IEsC19wjkk31RAubZkIUWoKB6vPyUvfqImleeICi44wb6SvGPdulY77av0XGMh0g2SNmpJt7NPQYu6C8ev4WBc=
X-Received: by 2002:a05:6808:180d:b0:3eb:777c:184e with SMTP id
 5614622812f47-3ef2ec252f7mr148056b6e.13.1736276998899; Tue, 07 Jan 2025
 11:09:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241224031809.950461-1-joe@pf.is.s.u-tokyo.ac.jp>
In-Reply-To: <20241224031809.950461-1-joe@pf.is.s.u-tokyo.ac.jp>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 7 Jan 2025 20:09:48 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jsyGLh0Vn4soGZtptNfv+QS2FT2GZskNyTN_t7paUR_A@mail.gmail.com>
X-Gm-Features: AbW1kvaNcdPMdqUgMmb8_UXdklRLGo8XdO_9vOPHI18Z5uvyESfOB5Sc4FLpXes
Message-ID: <CAJZ5v0jsyGLh0Vn4soGZtptNfv+QS2FT2GZskNyTN_t7paUR_A@mail.gmail.com>
Subject: Re: [PATCH] thermal: of: fix OF node leak in of_thermal_zone_find()
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 24, 2024 at 4:18=E2=80=AFAM Joe Hattori <joe@pf.is.s.u-tokyo.ac=
.jp> wrote:
>
> of_thermal_zone_find() calls of_parse_phandle_with_args(), but does not
> release the OF node reference obtained by it. Therefore, add a
> of_node_put() call when the call is successful.
>
> Fixes: 3fd6d6e2b4e8 ("thermal/of: Rework the thermal device tree initiali=
zation")
> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
> ---
>  drivers/thermal/thermal_of.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index fab11b98ca49..5ab4ce4daaeb 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -160,6 +160,7 @@ static struct device_node *of_thermal_zone_find(struc=
t device_node *sensor, int
>                                 return ERR_PTR(ret);
>                         }
>
> +                       of_node_put(sensor_specs.np);
>                         if ((sensor =3D=3D sensor_specs.np) && id =3D=3D =
(sensor_specs.args_count ?
>                                                                   sensor_=
specs.args[0] : 0)) {
>                                 pr_debug("sensor %pOFn id=3D%d belongs to=
 %pOFn\n", sensor, id, child);
> --

Applied as 6.13-rc material, thanks!

