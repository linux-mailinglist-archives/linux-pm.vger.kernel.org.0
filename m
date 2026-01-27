Return-Path: <linux-pm+bounces-41539-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHhWON7MeGmNtQEAu9opvQ
	(envelope-from <linux-pm+bounces-41539-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 15:34:06 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F9795C90
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 15:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E00DB312779E
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 14:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805C035B62C;
	Tue, 27 Jan 2026 14:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mWP6p7ZA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5967350285
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 14:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769524066; cv=pass; b=TeGGxqrLHlbRgrIhm9KM6u00QchsBrVYXytIzKe4w3w56iQPR45vcq63gWyxheM/hq6UIl5CkMS+eUhQTNnr1H/ytp5R9y/+CjrHy8RkTQpisVZ0e5hhzofNR/XD8muQvZYuITO0KWbs+fTtWMV7dVw1+dBUbmwkf1Q6wG1kAtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769524066; c=relaxed/simple;
	bh=LmoyJc0U7t64dEBkJj7rqwEVKdsAUJvHf8RCJP0N1OM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aw8IBQyN92olbgQzGUyNn/kMQ8PVj4CcKxM7HHjfU1ahchk7MAIsdIA9A0lD90irs4Qtna6lN4a2T9KvwnoiIGR/UdN9X7e52vqJKt7VTaV7TcicBWTHJx7P8JF6MrTAO9OG8VMyRdO7nu6tYGYOvW64VFzhi8WAZdK8YsKdbTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mWP6p7ZA; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59dd34f8120so6854038e87.3
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 06:27:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769524063; cv=none;
        d=google.com; s=arc-20240605;
        b=fV1O1uS+V/KlED3tDh3NWQp3wUfcbdjz9o2LFJdLQfVjysMIUzmX6kP4PbbjNaNPLg
         xZDYS6hh/0o1tRPZk/51jBQEOgzjpgLhG5adG2gCS3c6itY6lE2QdpVfwX8WJjY7VV1L
         vC3WqV3ta8CgeCtjkYMX/FVYHE7WDacGTFK1y5IzQjvtHY1iLSbJB1SErVgRg/iJgU8F
         o1qIk7vJ4iJ+Ivyvg41kwgyft5vhJCc3g6/BoP2qHW6d3Wc3ciOMoEfCQenY1pidY6bK
         /myL9IkzRlIEfm8A7VNkZ94tnBl5T3zm/YcTN5iRzTsDxizPagBve5u9W3XWs4QVVZIe
         nKPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RxLJbyzq0obe4KNPLIQmlRLpVx7gXGsUdWL42nC0oZU=;
        fh=ar1dGXMnvFPU0O/7TdXXe7UG3TrNCdq11L0dl03wQ+4=;
        b=KaPcrDkTne9bkQ2CJsfUkVitMZTpYEwoFefh0Jyx0H1XF7tQ8zL/gLskrCvQ/OYtoD
         jc04hvPjJWhBvg3LxBZYUqGevRqbEwPGCbFXpQPSCb6NkTdb7y4HF6bVPertcWXc2mbI
         L1GRVqvrdTwD5Z16VrqAKvLcyW0UrylaeKQNimj6X2a+nYq0IJO6inEp4ir42JppLhpo
         aF+GCW4NZguR3Y6qxqLtBrk9KlXWxefWMnAqMw4admjRNHDvN2sZC9PKqDUgdSCPRA72
         k43LaW6+nR4csr/o1ax2x9LL119+DSvScxDYT6i76YtdzYfz2L85FA5t5LvHiOQDUxbQ
         vrLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769524063; x=1770128863; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RxLJbyzq0obe4KNPLIQmlRLpVx7gXGsUdWL42nC0oZU=;
        b=mWP6p7ZAhhV0BJjzyRC3AY2aOWNE1uyYmXJuDIq06k9aPJVd8kQAOgQYHZqPTvwZJG
         ri93B0JaqIaLWbO7djC2LySrS+/5Dt95bdhwlcZRrk8r7Du9ARBVPWcvk5MaF7f3bFFV
         sujiOoO0yOPAnZxerQz4ckCP09O2rrYVOnDoAJHopibP3Ghs/zDPzzAOizfcqK+m1zky
         GLjl438tZS0nzeKcDp0FzR6yuFvi+71RqPiEMO8ZPdxcVfzqBNQzCpwXh4PjrpngkPmb
         qD/U7Rvo19SVvutBL3e5keeHWwRNuf6w0UuRXbaNIwpF318KXXXipCnAQEc/o4jtg4/t
         eeQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769524063; x=1770128863;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RxLJbyzq0obe4KNPLIQmlRLpVx7gXGsUdWL42nC0oZU=;
        b=vuraO8MpE8th7tALSoH+8rbJh1bENiKGWb4qYyrbTRh4vVpGYd5DXghDqDUkVk7J33
         o+l45icSBED+rXNs1bGijbqzZ+NmbSPvlVoBZjFQy5tZIW9/amqSc8fYPR84H4GxXOrA
         2WIvTKmKfa65koF990ErioFtSZLcFiKlYix4/RfOTpglNszafR6aAkhtGQxJdgYv7Atc
         K7UcSA2Vcl3eryPiYeoIxG+JYaLIjAbTU0G8cy0Xgteyb1MJoL9ImeaWb8h+VRf+jyko
         CRYxA8wCjqxmLrE++9NKBd9pOpVE0gjnzDjtqWu0ZXVM+4SwKmHPGCJYEbPOSLANZ5f5
         e56w==
X-Forwarded-Encrypted: i=1; AJvYcCUN3lhsyHTcknAkSeTM/E9PmPQE2LWVNb+/ZhqFuthMnWxI23xiWsO0dIwSSmTfSPLcPymDMGx4Vw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs4wugTgKeHk2S+68cjD2BO1+5q2oyPGAo4wJLO4h2nPf8W/B0
	47pEWfcgLDgsjZRF7wEVpzovHWUv412G20DLPDCcQOdOEHiaAhiLNkuQETkuLlb901PLKNySF23
	iHL84PiBw7b7i77MfrVcQsrNCJEE42WdkZ02mDkMwJw==
X-Gm-Gg: AZuq6aJ/VZYXRyWeKym4V7EkAozlvlqXFzSzLrAt0TqIl5WV6U6lAAS5FUm1yQFY+9t
	klDNBl9Qh6p/4+xSiWL7SerY14EjrXFEnshTfCss9h0iS4MoygycjWBkUMK40eOkHoXFUvrKBgL
	ll7E79XUNFCh7rjC/3Sz9qHVrc9OFsIxq2cS+DQtPWJk9106PU0epfvELOJl5N5Sby4Jbxuke8w
	GmYWNOy5dKTpVGywEci5XpYFfbw0jyDSr8hsSZX5dz+/B84ZRmXPp/ymrtIOSK+GGIkYGhm8u6H
	Hn4+ArI=
X-Received: by 2002:a05:6512:3b9d:b0:59d:e774:db0e with SMTP id
 2adb3069b0e04-59e0401a133mr1025420e87.23.1769524063038; Tue, 27 Jan 2026
 06:27:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_E20B88FB4461F8F299301AE67009CF1E8708@qq.com>
In-Reply-To: <tencent_E20B88FB4461F8F299301AE67009CF1E8708@qq.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 27 Jan 2026 15:27:07 +0100
X-Gm-Features: AZwV_Qhi8UzxlF5LVwmX4f7HQZtYZhiLDcb_EwLIgdqVDsG5Rq1NvMoa6p6uOA0
Message-ID: <CAPDyKFqCewZeQV6UVGXXuuxjPa_amThaHz0TmLpLksP1A=G9Eg@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: ti: omap_prm: Fix a reference leak on device node
To: Felix Gu <gu_0233@qq.com>
Cc: Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41539-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[qq.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pd_args.np:url,qq.com:email,linaro.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 36F9795C90
X-Rspamd-Action: no action

On Fri, 16 Jan 2026 at 13:27, Felix Gu <gu_0233@qq.com> wrote:
>
> When calling of_parse_phandle_with_args(), the caller is responsible
> to call of_node_put() to release the reference of device node.
> In omap_prm_domain_attach_dev, it does not release the reference.
>
> Fixes: 58cbff023bfa ("soc: ti: omap-prm: Add basic power domain support")
> Signed-off-by: Felix Gu <gu_0233@qq.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/ti/omap_prm.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pmdomain/ti/omap_prm.c b/drivers/pmdomain/ti/omap_prm.c
> index 5142f064bf5c..64a187f79a1a 100644
> --- a/drivers/pmdomain/ti/omap_prm.c
> +++ b/drivers/pmdomain/ti/omap_prm.c
> @@ -655,6 +655,7 @@ static int omap_prm_domain_attach_dev(struct generic_pm_domain *domain,
>         if (pd_args.args_count != 0)
>                 dev_warn(dev, "%s: unusupported #power-domain-cells: %i\n",
>                          prmd->pd.name, pd_args.args_count);
> +       of_node_put(pd_args.np);
>
>         genpd_data = dev_gpd_data(dev);
>         genpd_data->data = NULL;
>
> ---
> base-commit: 9b7977f9e39b7768c70c2aa497f04e7569fd3e00
> change-id: 20260116-omap_prm-c7bdd9726abc
>
> Best regards,
> --
> Felix Gu <gu_0233@qq.com>
>

