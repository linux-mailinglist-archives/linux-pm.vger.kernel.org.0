Return-Path: <linux-pm+bounces-43570-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOp5JhMQqGk8ngAAu9opvQ
	(envelope-from <linux-pm+bounces-43570-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 11:57:23 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EFE1FE9D9
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 11:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93CE33044BBF
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 10:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0013A6F19;
	Wed,  4 Mar 2026 10:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TdQtjZ5X"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD12036A00F
	for <linux-pm@vger.kernel.org>; Wed,  4 Mar 2026 10:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772621798; cv=pass; b=t/8HB3JkuKuOHdbVKtLmihMevyo2aoLytzynDibmgpjA1OggClxMpeetbUY51Bcj1JDCBVIEGEpMUb1F6iFbY8TsUGaZbBfCFQD46sAEFLEmlKFMiemUzgC1la4HAsnRzqJ1nDunTCNM0o/TW4x6d9aWR1igzrupmy3CGO7L2yo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772621798; c=relaxed/simple;
	bh=gFAXJW6wqNB4bFP8Bd67zykCDJIItcLQlhgPjD2ytvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o89EOk68fYj/CZ8uRYcb7Q3xgw1Nt0rqaPmQoLi4i/o7zD5mQhruXUDqhNKFVuirdfwds5qXu9FFl0sDktAa9AbdjdzcP8KrTFS9DQ6Avu/zkuSxdRVn02g1eoZXEeXFCrOeFutlHQMRpf0ltFL/YGn9+ZVUfHHuWE+/hMJyvGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TdQtjZ5X; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-38a2a59baa6so4866301fa.2
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 02:56:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772621795; cv=none;
        d=google.com; s=arc-20240605;
        b=Z/lv/Kr5zQXUqi9nHwMht+TUwI2e5IP4VU5i5ZonofiB0S5UCvOQS8HtRQy6fNKVMT
         Z0Lnmszp20xzuu/PxW/57GUSFStbhpDRiQ83F1vKFjDtuwd/6QltZW89QvwPi3wSz92t
         +E68HGWDPMSBQ3AF1hmgrfKG8Ni1aPYfEdJ9rAGZa/ZNZcEEzx32Q6CC4pQ8uFzfYv1S
         GUeAQnxdoGLBo1/0Cmv6pbM5xQF9fXgT4w9FuvnC+yzkTygNh/v28zMIuKvhKlMXjY7R
         wtO0eEdVSY/EEtzNIVx4WPxgtsNVbNKfDEra8WPx+NKztTX4BJEs1S00zuaaOqXGV45h
         6zAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Fo/8L1vqlOfM+seM66MGkBVDWRE/a0s5YAa4O57zdbc=;
        fh=r6ndeZY5/ZcI0GbHWvt92VEqKV+tIXjQAdPBMVLOqJU=;
        b=jRY3HN+ckMu1h/QwKAb/f+B0LQVpvSdpj3osZBNiq2caT8cxxgEa/4OspI08XaPrFG
         4/xOcwFdPDpGLJfc3VgaH0uXKinMwL1Xrib6Y5hp+0B1Xa40mU4CMsTq3QNKLgh3+OiI
         teFbL80blOnmvyg4BkCN2EyYpAePD8Ljwrmfe2M3cS3tNKpvdvuUJQaLnLH9/7cRbiv/
         aS4sN7rTAVSTLkgQ+T72t4UmBZtbGvNQQzSKcV1GoO8WkD/w3tbrLwMFXt8Nt2JGVqTB
         o7aOiC4MGDNX3PYOXIvyanOTn4yLpJYbM/6BNYAgL1pFAh1zRyOaWq05r5UKV6Qdn5N7
         09Hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772621795; x=1773226595; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fo/8L1vqlOfM+seM66MGkBVDWRE/a0s5YAa4O57zdbc=;
        b=TdQtjZ5Xn9e1vshCgilzGsR8u1s7gp/1zt2uIc2EvSPyB7Tf8WlCryQnGJ7cDZVmmq
         BOPCX1yU2LgZCneCArCIJ5h6kL2b/KZXqrYZR7tSsBuDnEKcqDCbaihbghd1E7agjlnT
         BH69l91bxRpB8rJlx7I4ijQi3yOOQYHoqdSD23vkF9ch2wBqX0zt4sYfFPushWg0sN5P
         F8ujZ/l3Rzwugj+5DySqx+h0AF6fIMfPiq8VZ+9j6JgUfnAB4wzDP7O9MTvu+hiOcoqZ
         0M+4mDv16D7i9widoo/8/xQ6wuse4FVBdNX7G7/m+7jASWRqdUn+Tw+if0EiNgunYu8y
         60eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772621795; x=1773226595;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fo/8L1vqlOfM+seM66MGkBVDWRE/a0s5YAa4O57zdbc=;
        b=qTvfOn4FWm+ZYXXMtRYu1gKnOgRzBoLF8XhD3iQxxBnT6Nagy8x2eaFNzoPAoLPMIw
         Zoe0J9Zc+eibu588j6wFO7XP0xwgv9rYoo20VPG9ycny6YHmj5hmAjZHBq87mXzV0llP
         +RNteUeh/cQYbZ6QnUFHwzrtmbuNSWjP+VlH+x/ghZFyzithSHTxy45SF618lRB4Qd3O
         E3jVb+ZEDZaBl2Nj/F1sgZ2Oh7+/COOmbWe/NO1RAiS3xHWYHtnhukapn0V7h47doRbm
         VSbJc3Hq3xwOJBsA6I2CGUC3La9FZ2ThXvS+oe3s6iMAAr8gQHWhGHpdhTzJ+B61Jc5y
         onJQ==
X-Gm-Message-State: AOJu0YyrM1aBHw24g+4wrRVYBUr5+MFNS2lxnRlIJBlsAeIu0H3gSZ05
	QZ4Lh/2FxZIm+/++hVUw/8tBEkNlfaDxsIUhYeaWrH0hJqmjoZRW+LtW1gexU4s5TSrhE9cj4Rg
	F3JDsqtrB72nhFx7V5QaLCAC1J4Ey65B+yv2eEm+/1VYkm6bVX7+XK3U=
X-Gm-Gg: ATEYQzw94w5xisGXAWnfLJqGxkp5XqFp0swYSsTla8Y6GVcdqseSfdZTPJEwXxYQDz5
	URXgs4+gvJ2eyCq0rpUTTDPq7h0g8yoGA1ffTLznCH1ARXGvs2M7GlXd01imqA1Tl5Vwa824HVX
	yDSMR7XMK/iYrrN5OiTI6D4ZvIDPgfg2YNOGaaMki2E8lBLk0SqjqJ1k6DLVonBhDXtNboaqNER
	SuKq5P1pxi1aKs0J0tszZUkxMx/jPXOsm1EyYlRy3ZmfCnAyF1g3OuArw5n+U2qb9IKY3UBze8j
	zpPPDEMt
X-Received: by 2002:a05:651c:19a7:b0:38a:921:ddfa with SMTP id
 38308e7fff4ca-38a2c7bb11emr16394421fa.34.1772621794800; Wed, 04 Mar 2026
 02:56:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1cfa86b72b2a5aa2ade92f247dd318c9cb6ef2a1.1771267504.git.geert+renesas@glider.be>
In-Reply-To: <1cfa86b72b2a5aa2ade92f247dd318c9cb6ef2a1.1771267504.git.geert+renesas@glider.be>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 4 Mar 2026 11:55:59 +0100
X-Gm-Features: AaiRm50xV0aTIf57r0Zo9-XIoeEBUsqVQ_XIKC2m6BAZ6n8Tqg5EToJh3NdooZ0
Message-ID: <CAPDyKFotV3bUEQic6X3PEC8m4fcXtc0JF0u7HTj9nRF1koowgA@mail.gmail.com>
Subject: Re: [PATCH/RFC] pmdomain: core: Support pd_ignore_unused with sync_state
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 32EFE1FE9D9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43570-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-pm@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,renesas];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linaro.org:dkim,glider.be:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, 16 Feb 2026 at 19:47, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> Since the introduction of the sync_state mechanism, the
> "pd_ignore_unused" kernel command line option doesn't really work
> anymore.  While genpd_power_off_unused() still checks for that flag
> before powering down unused domains, the new sync_state callbacks lack
> such checks, thus powering down unused domains regardless.
>
> Fix this by adding checks to the sync_state helpers and callbacks.
> Factor out the printing of the warning message, to make sure it is
> printed only once.
>
> Fixes: 002ebddd695a5399 ("pmdomain: core: Restore behaviour for disabling unused PM domains")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> RFC as I have no need for this in upstream.

I am trying to understand the use case and whether we should consider
to land this upstream.

Would you mind elaborating on how this is useful for you?

Kind regards
Uffe

> ---
>  drivers/pmdomain/core.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> index 7b563757935071dd..1f7d90bcc30d12e5 100644
> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -1366,6 +1366,16 @@ static int __init pd_ignore_unused_setup(char *__unused)
>  }
>  __setup("pd_ignore_unused", pd_ignore_unused_setup);
>
> +static bool genpd_ignore_unused(void)
> +{
> +       if (pd_ignore_unused) {
> +               pr_warn_once("genpd: Not disabling unused power domains\n");
> +               return true;
> +       }
> +
> +       return false;
> +}
> +
>  /**
>   * genpd_power_off_unused - Power off all PM domains with no devices in use.
>   */
> @@ -1373,10 +1383,8 @@ static int __init genpd_power_off_unused(void)
>  {
>         struct generic_pm_domain *genpd;
>
> -       if (pd_ignore_unused) {
> -               pr_warn("genpd: Not disabling unused power domains\n");
> +       if (genpd_ignore_unused())
>                 return 0;
> -       }
>
>         pr_info("genpd: Disabling unused power domains\n");
>         mutex_lock(&gpd_list_lock);
> @@ -3510,6 +3518,9 @@ void of_genpd_sync_state(struct device_node *np)
>  {
>         struct generic_pm_domain *genpd;
>
> +       if (genpd_ignore_unused())
> +               return;
> +
>         if (!np)
>                 return;
>
> @@ -3544,6 +3555,9 @@ static void genpd_provider_sync_state(struct device *dev)
>                 break;
>
>         case GENPD_SYNC_STATE_SIMPLE:
> +               if (genpd_ignore_unused())
> +                       return;
> +
>                 genpd_lock(genpd);
>                 genpd->stay_on = false;
>                 genpd_power_off(genpd, false, 0);
> --
> 2.43.0
>

