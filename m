Return-Path: <linux-pm+bounces-41832-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id U/h9I5MvfmlfWQIAu9opvQ
	(envelope-from <linux-pm+bounces-41832-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 17:36:35 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F17C3099
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 17:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4DC783001A5C
	for <lists+linux-pm@lfdr.de>; Sat, 31 Jan 2026 16:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5D83376B8;
	Sat, 31 Jan 2026 16:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BcpJoA2H"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC4D1E98EF
	for <linux-pm@vger.kernel.org>; Sat, 31 Jan 2026 16:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769877389; cv=pass; b=rmfFKJfF8S6fJWvwcp+tGyNh5hlFtly5o7RQG2n1vVcgws2Wf7nTAoyPzHhcZ2ztfKXbvP9CQKW6oZGeQZM5UMMt1EM9d3A6IaZyz5NeYNKub3yi4kx4uKsTdIXKMDPHCXMnynQ/JiK+il27uzuX/aP9Y7vd2fFMhmV0WukqKj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769877389; c=relaxed/simple;
	bh=cspiXg9vERxGZYPxJBEfVZsrYjsoWCX6jFltpbRWE2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ROiVd7NlxXtKnW74/AkwxWDy8CADwegUf6Kk7h6SPTDh6jy9DIFlyMIDZZgEBXAP9HCfG5NCYLm4QnRMOIkf5NrVeHsPTHvOIvXtDivdgZy6YnVOZj92x2nbrwyVlYsp9TlxqL9sdLKEOvIX7bouNVNaqPjX1LS5C+0VxOiMrQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BcpJoA2H; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-658d4059b79so4366153a12.1
        for <linux-pm@vger.kernel.org>; Sat, 31 Jan 2026 08:36:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769877386; cv=none;
        d=google.com; s=arc-20240605;
        b=WYw97ifj5YUjS2289LlrProZ1wlZQmjCo4s470XcPhQbrYB0u18in7IGeE8pSca0NL
         2mDtcAPtsZ9UHU5p899vkXt1QdA1nG8pW3ScUEHOWKvjGyQ/EV2HNLSVKYg76sKa21hp
         vCkqSfwJsDGtEy54kxWhmpb/4TzAmt/c73e0YjqLvMVoFk3M2XevL/d4WRtIRW1QCOSE
         e8mFbV+QLO1iozgThW2q8vm0IQyVKrP0wB3QudczFY2zCA6LlUtbCSraTXrynE2ef9rb
         jiNdOLQ1tIXydJUWg8DRPwTZ0buoX8CratsI+6IWnMYl4P9DUdPWaVHsmnegR+6z6B1y
         J9tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=JnoW4al0mNbaBdedUE9Qyqhu6YNYU462VTLyz16vIq8=;
        fh=7bkUyUkUAcGmpvHdHXOc/8P7oC24Jlr6DYIth7+yV48=;
        b=dS5d5A4ndOSskyw1Hz89DVZiGUyr62GPCUfVs4rSnSfT9Fu9KYI09pa34v0xZxCHx9
         oiOxeOHTooHEoDHBNVrcRx0ArohbCwcwKBM8XDKnGu5Zcd/xR6aTb4GXOup0UdY73r3H
         dgFBKd047mLqQHcGN7E64GNHe9lVJ+sS9k8SSJ24h+LiMiYbdJd6tA4xm0oY//tz9ecM
         CQD3zeun9+hgCuKPriQ4wq/Ixgc+zJ6WkKpWNREctkqPavBpc35RLy4UPSCj0zhvOvB3
         ziMzJBuNghxc+HLpY43QF5WJUYx2k2lqI+8S14db8sBHU6jMUDUVesW/mJY35bfTfOUD
         Tr+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769877386; x=1770482186; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JnoW4al0mNbaBdedUE9Qyqhu6YNYU462VTLyz16vIq8=;
        b=BcpJoA2HlszzjkWwmwj67kYTGJaF6bvAbu3K49/4hyhvatkl0cwtwd4NlGHaDSAWAW
         On/pepS+QV0wPqPXuOyK5ejgtjYNJTp9iQ7iqOjIK9a3FsAEfwvnYi35YF5wJM9YSWs3
         K7Cs44067Z1hieFEbfg0eLzxvCfeGitTHppJFW/+DomVwQYshuejU/w8fR77BFCviEA1
         jK2Dql0UGhKMfH51CIBtmcJFAY6/02fpf1V0NmOt7FFVwWxmbdel27t3e9db35XA1SbN
         EOYCrKj3qxlCeKCCz3XLpQDiM2pkeqhUmoirCM//VzaLqzoru1VpvKjbHSqwhI8Ra6/T
         LfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769877386; x=1770482186;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JnoW4al0mNbaBdedUE9Qyqhu6YNYU462VTLyz16vIq8=;
        b=kRBL2QqIOiFYikX0Be6mpQNYi8dweTe0z7zHioNhwH+BumAmhXavQ+fKPXx5ymekTP
         8Oc163Dfofe4BQ+V9uHfJGw6arvhUyvbka1jQFZbxSAZR2M3VFf1RMEXwAEdPby5V3uM
         DSwyMtm26jAqGfxtMKmwaDeu2c6hrRM4WkOrKae/qWSDnnVmKDYfR2EVbynjT24qsBUa
         gYYctkHf21cJLxA21UitDCs0pcq25orYEmYp3wwK2x53VKX2GA2WIHyrOxPGglC+EooO
         FwFeTeV6n/kXVmkfO67TTbV79caXwO+10QN3oc2mS0A3l9jinnPP9h88qmPm8i6KUlRo
         9bRw==
X-Forwarded-Encrypted: i=1; AJvYcCWOz5dyQc2m+ZsJYOnpf+asz+dnWQ27W0Oe2qcACbFRneIt+/MktHn4POCPafeWzw/L1+RORtsIHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPaFmMU2XngxOmNv84E7CTZyLaMIOxWrrRbcAtIb4SryVnBJzk
	+ZiUw0jLHvzAHXrHpgBw8t+C/C1KZSiGg16uyZto1K6OAO7o4lEJ0uJl1u+3r0h+eOLj8OrmxPH
	m4MpuownOPGHLoZmykodZD9RtBKb7/VY=
X-Gm-Gg: AZuq6aLN24fh42ORPP/+470zzgDQ87mN/uLZewW9GokJZTcW2FSVqbIZKw2oJ+23Vz1
	WVELHe5KtVu/hgK12zc4HhoCzu2rkYdD7QI6Ba5jYn8JCMojvUPN67nCs9Hc2E2n74HjxY6FjXX
	knbnUgRZQabvSOElgDfzaSGGFGhfMyaLEk9xI7pdO5ABrzU9NsrgoTBt2eDry9mlRJDA6jK34RQ
	zNnJ6oCkw/LYWIKYOTWNOdHqHX0pTZRQyL1vp2+76IIEC6bMrfjEO+hmMJAF8VKPZo=
X-Received: by 2002:a05:6402:2102:b0:658:177a:292 with SMTP id
 4fb4d7f45d1cf-658de591688mr4030908a12.17.1769877386201; Sat, 31 Jan 2026
 08:36:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130163102.51757-1-macroalpha82@gmail.com>
In-Reply-To: <20260130163102.51757-1-macroalpha82@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 31 Jan 2026 22:06:20 +0530
X-Gm-Features: AZwV_QjchRCrYC_yJttjWPkEMkaWqVB5nZ0R-eksHarV0kTlv1jyKo_0fSMWdDU
Message-ID: <CANAwSgRB7KfkBeniXypjS+p5U4=WfXpZyE5pk8vyMVQGX+Ev7w@mail.gmail.com>
Subject: Re: [PATCH V2] pmdomain: rockchip: quiet regulator error on -EPROBE_DEFER
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, 
	jonas@kwiboo.se, pgwipeout@gmail.com, finley.xiao@rock-chips.com, 
	kever.yang@rock-chips.com, shawn.lin@rock-chips.com, 
	sebastian.reichel@collabora.com, heiko@sntech.de, ulf.hansson@linaro.org, 
	Chris Morgan <macromorgan@hotmail.com>, Diederik de Haas <diederik@cknow-tech.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41832-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,kwiboo.se,gmail.com,rock-chips.com,collabora.com,sntech.de,linaro.org,hotmail.com,cknow-tech.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linuxamoon@gmail.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,infradead.org:url,infradead.org:email]
X-Rspamd-Queue-Id: A2F17C3099
X-Rspamd-Action: no action

Hi Chris,

On Fri, 30 Jan 2026 at 22:03, Chris Morgan <macroalpha82@gmail.com> wrote:
>
> From: Chris Morgan <macromorgan@hotmail.com>
>
> Change the dev_err() to dev_err_probe() under rockchip_pd_power_on()
> to prevent errors early in the boot process when the requested
> regulator is not yet available. This converts errors like the following
> to debug messages:
>
> rockchip-pm-domain fd8d8000.power-management:power-controller: Failed to enable supply: -517
>
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> Tested-by: Diederik de Haas <diederik@cknow-tech.com>
Reviewed-by: Anand Moon <linux.amoon@gmail.com>

Thanks
-Anand
> ---
> Changes since v1:
>  - Simplified return to single line
> ---
>  drivers/pmdomain/rockchip/pm-domains.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
> index 997e93c12951..6d3fb18f4ab3 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -705,10 +705,9 @@ static int rockchip_pd_power_on(struct generic_pm_domain *domain)
>         int ret;
>
>         ret = rockchip_pd_regulator_enable(pd);
> -       if (ret) {
> -               dev_err(pd->pmu->dev, "Failed to enable supply: %d\n", ret);
> -               return ret;
> -       }
> +       if (ret)
> +               return dev_err_probe(pd->pmu->dev, ret,
> +                                    "Failed to enable supply: %d\n", ret);
>
>         ret = rockchip_pd_power(pd, true);
>         if (ret)
> --
> 2.43.0
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

