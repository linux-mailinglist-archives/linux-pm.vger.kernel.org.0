Return-Path: <linux-pm+bounces-33816-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 290BCB436D1
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 11:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4D431C24587
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 09:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029AF2F0698;
	Thu,  4 Sep 2025 09:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jxqybr8P"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63282EE262
	for <linux-pm@vger.kernel.org>; Thu,  4 Sep 2025 09:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756977460; cv=none; b=rTKB6sPBt2Mt3jADjtVeagVezEb/vrdHtOr+UgKsEiiGjYV3eT2fjgVpoDlPGr0OkTEqK6tw3cbKaA2tjuD6qtw93M4R5E0mRE9Wt6HO484qALpJlGJe0XwsKxsfcicTQSoT+4tqTu4W/MWQcfZ6nO4C56PhO8DUWe/aPt8q9+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756977460; c=relaxed/simple;
	bh=ro6tj71dTmsOqIOJ+tUbjhJhj25R+AsTQuUycVEX07Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DAFkQJdpHXc2qB+6gtf3pcLn2ybJKD0OfkmSA2MQSE2wpgCA+PwJbl8fE31PcRLmj7+PQpqbkgvWl73PE7Aa+Lb1DAl3Il5rs5ov860EQ2dnoiLpuimrM7/xJ2ljbNrYuDylC2pu+VUPAbrox/a6hJl8ZxjwITKuXj7e9cpFkW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jxqybr8P; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e98b7071cc9so833618276.3
        for <linux-pm@vger.kernel.org>; Thu, 04 Sep 2025 02:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756977457; x=1757582257; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1IHfxiKHVZcoZdK5eedXi9AzrICaFJavMXaL5eOAwNU=;
        b=jxqybr8PyN5QzvIo66/9Tjjl0wnTHynUL96InODseeyIlE7Zc0CG4PZ2qUeI+7fTje
         44+D45v3nIYzIVEIRw24phJecF51sg2tN0Xa64Rpqh+BvWIVZCJ1wbjLZcVgJm6NYOSC
         OzDIJu5E2+X7LAEZA36iT08bQPBLznT/+zN4jiB0iCG2w8Vkklb1pIl+YPl4cjqtpbnF
         npPPztlTR0yYCl4MYrpja0iajvIrfeNPZMWmDkKvv0/itLCpFfV5uoA/azpgsF7PvQWF
         b2QZwSwIDPs7qKjsFcUq15Wcbq4X4EMGf9m4ofG90OvtFd5qqiOC6Y35AEAx9nycmPUH
         k+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756977457; x=1757582257;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1IHfxiKHVZcoZdK5eedXi9AzrICaFJavMXaL5eOAwNU=;
        b=CTVr/4Z7t40+ThTbiqV0PFeT3v2xS/vw5oz4SqePCqzCy2WuAmsJD0SQ2LROBmG8Yh
         pbTRLwFp2OUw+3323G7iYQG9i0MyGqwxdqjy6ApJo8dZKadbvMPFwtk9sBvYiB4RZPMu
         IkGKolK1XFU1kd61dv+zBThD3hpZgRRh24lCXkGMfx5M8jw4WM2LclLzWfXos80lOisI
         sPjxbEdrIDI/KrlLaa+cGLbfQdWffJXa2iQPkLW0JOfIXgQOEUFTfr66W8q+U6uu1tqm
         YMHWPdGPH9K3T6Z1pdZS/PrdSkng2IjWWm7mEcUXwL00NJuyI7iwbT8ifMxwzZt24BUw
         6KhA==
X-Gm-Message-State: AOJu0YyXCmN0movvi1nhvAICwdue/HBJg4ETsS/xOkAFprrnMTRspvK+
	qC1szhkaD9/pwbpSUcz23AQdn+t/aF+rbmRoDLVOeoNVcqj2BYimkaD6Ui8IQykf47w8h6vKDgU
	3t97iKzWAu/hx+cpVVD5w4PR7JzZCl4xVRrU//fSgVw==
X-Gm-Gg: ASbGncs1Y19vCtrdMquAYW2P1NYyk2a4o6xrFgAXkA5t/A+J5DlSshGtzErZmyS6qEv
	ZrRdFb+SEexawTZ1CbFPyp/LYaezaYHJpHnonXFReo4heHLYToOG+7pTviZ6NeNw/dC0f73RZG+
	5h6oqXLQaPAXxP+GJuC6r4R18tcOoknopX1XHqWid459apAtMf8zRFrU7qVif47uTuR7HLJsBlf
	1y27jjDx+S8ysi/+Hc=
X-Google-Smtp-Source: AGHT+IHGzvL/SQ4HNYcJs3mSRbi/fwWJTLuJdCzWDRJrAdeSCUtGtaE9Ng6+Zgj8ZTj4BVLlXa5f1EsvUEu7/+8+iK0=
X-Received: by 2002:a53:d008:0:b0:5f3:317e:2e99 with SMTP id
 956f58d0204a3-601755b5082mr2503853d50.3.1756977456767; Thu, 04 Sep 2025
 02:17:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902-rk3576-lockup-regression-v1-1-c4a0c9daeb00@collabora.com>
In-Reply-To: <20250902-rk3576-lockup-regression-v1-1-c4a0c9daeb00@collabora.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 4 Sep 2025 11:17:01 +0200
X-Gm-Features: Ac12FXx39o4QIBpnfGjfT6nAmrw_ZkxKlyHGgS7cjK0YW1lPPw2TRrRJgZBu_s8
Message-ID: <CAPDyKFpAOLiBOoAhv+GQcobU_g_AWrB9iyOGmodROLtRmR30JA@mail.gmail.com>
Subject: Re: [PATCH] pmdomian: core: don't unset stay_on during sync_state
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@collabora.com, linux-rockchip@lists.infradead.org, 
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Sept 2025 at 20:23, Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
>
> This reverts commit de141a9aa52d6b2fbeb63f98975c2c72276f0878.

I can't find this commit hash. What tree are you using when testing this?

Are you trying to revert 0e789b491ba04c31de5c71249487593e386baa67 ?

>
> On RK3576, the UFS controller's power domain has a quirk that requires
> it to stay enabled, infrastricture for which was added in Commit
> cd3fa304ba5c ("pmdomain: core: Introduce dev_pm_genpd_rpm_always_on()").
>
> Unfortunately, Commit de141a9aa52d ("pmdomain: core: Leave powered-on
> genpds on until sync_state") appears to break this quirk wholesale. The
> result is that RK3576 devices with the UFS controller enabled but unused
> will freeze once pmdomain shuts off unused domains.
>
> Revert it until a better fix can be found.

This sounds a bit vague to me, can you please clarify and elaborate a
bit more so I can try to help.

What does "UFS controller enabled but unused" actually mean? Has the
UFS controller driver been probed successfully and thus its
corresponding device been attached to its PM domain?

Moreover, the behaviour of dev_pm_genpd_rpm_always_on() is orthogonal
to what 0e789b491ba0 ("pmdomain: core: Leave powered-on genpds on
until sync_state") brings along with its corresponding sync_state
series for genpd [1]. Again, more information is needed to understand
what goes wrong.

Kind regards
Uffe

[1]
https://lore.kernel.org/all/20250701114733.636510-1-ulf.hansson@linaro.org/

>
> Fixes: de141a9aa52d ("pmdomain: core: Leave powered-on genpds on until sync_state")
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/pmdomain/core.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 0006ab3d078972cc72a6dd22a2144fb31443e3da..4eba30c7c2fabcb250444fee27d7554473a4d0c2 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -1357,7 +1357,6 @@ static int genpd_runtime_resume(struct device *dev)
>         return ret;
>  }
>
> -#ifndef CONFIG_PM_GENERIC_DOMAINS_OF
>  static bool pd_ignore_unused;
>  static int __init pd_ignore_unused_setup(char *__unused)
>  {
> @@ -1393,7 +1392,6 @@ static int __init genpd_power_off_unused(void)
>         return 0;
>  }
>  late_initcall_sync(genpd_power_off_unused);
> -#endif
>
>  #ifdef CONFIG_PM_SLEEP
>
> @@ -3494,7 +3492,6 @@ void of_genpd_sync_state(struct device_node *np)
>         list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
>                 if (genpd->provider == of_fwnode_handle(np)) {
>                         genpd_lock(genpd);
> -                       genpd->stay_on = false;
>                         genpd_power_off(genpd, false, 0);
>                         genpd_unlock(genpd);
>                 }
> @@ -3522,7 +3519,6 @@ static void genpd_provider_sync_state(struct device *dev)
>
>         case GENPD_SYNC_STATE_SIMPLE:
>                 genpd_lock(genpd);
> -               genpd->stay_on = false;
>                 genpd_power_off(genpd, false, 0);
>                 genpd_unlock(genpd);
>                 break;
>
> ---
> base-commit: 5cc61f86dff464a63b6a6e4758f26557fda4d494
> change-id: 20250902-rk3576-lockup-regression-5b1f1fb7ff21
>
> Best regards,
> --
> Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
>

