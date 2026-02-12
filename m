Return-Path: <linux-pm+bounces-42552-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EL4XM9q6jWl96AAAu9opvQ
	(envelope-from <linux-pm+bounces-42552-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 12:34:50 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7F412D0A5
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 12:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEC20303C2AE
	for <lists+linux-pm@lfdr.de>; Thu, 12 Feb 2026 11:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318D0314A6B;
	Thu, 12 Feb 2026 11:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MHK3JeyG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CBD305E2E
	for <linux-pm@vger.kernel.org>; Thu, 12 Feb 2026 11:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770896087; cv=pass; b=W4rCH7HeDvBzTtgEb5Jt4raUai7IyOi7fH+yV/rRJbkJOHpDfdXhpioM/VeyiwVLGGrPtIszpjbEXDHqxi00qPJp4utwYanVkZvuadlIjhmUqXEumwzx0v0Z8+xlZCco0OX5E7Hw+tumWFT1kE2Pz85CafPmqzsohbdFMnpTjZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770896087; c=relaxed/simple;
	bh=PyOdwR8RmEZLeNzaYMYibBHCDqDFlBy+4FJ9rtN8PaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=muf2jg9JHHuDhktiiwj238pf6Uxh+M+xA8BNyGpEfLp2kXlCFI35h0sWPmMwMlyLWpMQBk08GeCG3Qnl+jDswqJpjivjF5aglSLH5JBvtpZHrXctaSkbeBlrACLfRD4J0mnIltsGKcS6L59CuJTYnCDZRHBtpVxSpBCLQ7iZCbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MHK3JeyG; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59e4989dacdso5909957e87.1
        for <linux-pm@vger.kernel.org>; Thu, 12 Feb 2026 03:34:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770896084; cv=none;
        d=google.com; s=arc-20240605;
        b=FLU2rW9ucIw/u9hmh6rEHsCtkzP+g2Ll6coJZd/y/xcd5ouD+cj+RIfHHsc00C7o/l
         9LIIPhzONPSaBEYEvwLadYpRZIbz3c92Tsmqx4XeFn0fpLMOE8foyp10Oo9xKnPEb3tP
         0Dvn4m5U7mCdPEi5bWeb69wesuD54gjEP7N/Y8d4ICRd3F16qhb+RB40PXotc0Q7L1v6
         exbxrXexokYYpJxRGystddExynllQnQK8Y94NsI/gFBJMUlPzPKW4vwFfLtG9mgMYEtV
         +JOr5OEnVkKmkMLGNza6Xt1RsHCEBJ1cRzb2abE7jy2gLHuWjbUjfDyDnPz9gIMwkKyL
         kOWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Ct48jaILiyeWuqBIUxAF+6ly5hlTe20+NjTg9trJyi0=;
        fh=hljeu5hZqVkWDifWMNN3ogCasfsyz/wDnNgCN2APpMs=;
        b=MMLRhMvv5h58I3kZn3hHkvbS+qaHE2tcRJ8WyOhpW418reRFvTH64GImRfegxIw2rJ
         LfdhGIjwDh3KbjGOX4zCrPA23bGqiUmW3XBVogjWsDA8VzlbZzBxhU8A4+GuD7wDIPPC
         IdyIPsxyoWyTZ8ce9Yoju66DNkmabMF5zaYoXb3Z/STKeWtavHl3xNs7GMlyaS/31/Ok
         zmQCY7v7ese4d/Vm7ApcZlq0WVudgmJmbK2XT4T5PuiiMBoH5RHbuVvyuz8MDbtUbTkO
         pojSfIS0i3Ma1Tfnht7Q07pIJZkvOTVih41bENwP1wG/3Cb9VJJZxg78I4KdxKrz41QB
         P84A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770896084; x=1771500884; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ct48jaILiyeWuqBIUxAF+6ly5hlTe20+NjTg9trJyi0=;
        b=MHK3JeyGHT9ejXB37U64B5DN96uJY5TTXSMnTYyIUrxlpCQC4fySv7PkAbRK7kV7Dq
         DfjiKMipvsv90pCGV1WYMMmyPGoNqXn+oyHHfZ3QHNkAlnlywF1siKhuttds5+bbGaoi
         Op/MPUQB9DWfSsrB4s2J6ljO2CqL7HWz0OduunRZFkbm4JDDHN7LekN24DgQLyLxs0SN
         Xeg0PRI04ESilKLfMxUGStyEyUJu6He8h0k+6xItZYBYVDifsh53W7Mx2/dNS8Rh6SSw
         dkmrym58vkr0BRd9kJio0S9Y5TIUbfgTgHvxzu0pLBFd2txLe7Y7bMXIqtMAsjA73SmE
         EwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770896084; x=1771500884;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ct48jaILiyeWuqBIUxAF+6ly5hlTe20+NjTg9trJyi0=;
        b=sbuAauAYpwxZmwye+ET5hOuJQQHS88xCEG1BZ8hzR57Wzgqun1evjHhOMqsXpVGoU/
         mzkgI7SWw6Zh+KeqHWAzUQdyyhx6E6zsSFPKUA+kQuFHm2J4zWi5HcRjCJjpICTNgeRY
         2Ns7JDgrlLcbbCOdMzGFRKbMPthLGu+J8qlJP06Fw+2hWTAg9J+A4Jx5wDR0/e2Pzw/M
         UpIW56O8pUeXBCQim8W4vdnoKxfN6hZqXA1mC00yqnEQGEKBx0zypIECbpb8K/yXeeWM
         MgpY0uWxvxGT+ZG7TqVBtM992OYzYLGcF9lj727DXbl431QeZn7/sNS1e4GpVGmURxzJ
         rj9g==
X-Forwarded-Encrypted: i=1; AJvYcCVDwFRxOUmM7O+pDYWFj4eTyT5bSaGft+naVzV0xd1tr1Y6tEOx7lPM4xVnmPG42RbzFiEbR696eA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAIApIIxx53le6CMFIrVPzsqwGBVGNSuRNtj0s4pW3lVMXULOu
	fUHvfJny7kvdu0cHsGs+eV7Zu9sACy3mOuOFL0//m9RG0QJxu5exqZJjZ0/OaKUJLn+EFbnONIA
	ZSs3APDkuxMY9QDr6DHvzDJsNlA0kKbGDOWIgPrBihg==
X-Gm-Gg: AZuq6aKA5WH8rXA4pD0UFrnqR2dtYf0IGHmYpVqluwQzjOtiUbQCfbrbh4j96oF6tFS
	BT4Js9i3logJHxwZRGKzNT46vham+IHhVcE7xEr4PxfqwVCvyo9Thznv+Lls9UHjZaySIIcagdp
	RvFdPn2F2bLPkURGF1B7i9jtnZnPa+tIBvblrPn0xr/RKbSswHDrBg5Ow1hCHY7lqP63YgMZeCe
	NaorECzctOoCrRpAwUVD5hfLHhmC5/XeGk5sCT1fe/ztg9bV0yitmyYgy62C1wvDNZXoQag8gKB
	kPL1cxzU
X-Received: by 2002:a05:6512:22d5:b0:59e:5d0c:e2 with SMTP id
 2adb3069b0e04-59e6414e8bemr537633e87.30.1770896083713; Thu, 12 Feb 2026
 03:34:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210053708.17239-1-aford173@gmail.com>
In-Reply-To: <20260210053708.17239-1-aford173@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 12 Feb 2026 12:34:07 +0100
X-Gm-Features: AZwV_QgO3Ow5QyeJg9yfF4esWqYhwcZC_L0GtKjw3_i47HZRQkNGD5zGxr2FDM4
Message-ID: <CAPDyKFrsMY8q+rvrbOdppYnefX6TA1-EhF+e+pGG6k49KpeTRA@mail.gmail.com>
Subject: Re: [PATCH 1/5] pmdomain: mediatek: Fix power domain count
To: Adam Ford <aford173@gmail.com>, angelogioacchino.delregno@collabora.com
Cc: linux-mediatek@lists.infradead.org, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Laura Nao <laura.nao@collabora.com>, 
	=?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,collabora.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-42552-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[linaro.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-pm@vger.kernel.org];
	FREEMAIL_CC(0.00)[lists.infradead.org,baylibre.com,kernel.org,gmail.com,collabora.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:dkim,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2F7F412D0A5
X-Rspamd-Action: no action

On Tue, 10 Feb 2026 at 06:40, Adam Ford <aford173@gmail.com> wrote:
>
> The wrong value of the number of domains is wrong which leads to
> failures when trying to enumerate nested power domains.
>
>  PM: genpd_xlate_onecell: invalid domain index 0
>  PM: genpd_xlate_onecell: invalid domain index 1
>  PM: genpd_xlate_onecell: invalid domain index 3
>  PM: genpd_xlate_onecell: invalid domain index 4
>  PM: genpd_xlate_onecell: invalid domain index 5
>  PM: genpd_xlate_onecell: invalid domain index 13
>  PM: genpd_xlate_onecell: invalid domain index 14
>
> Attempts to use these power domains fail, so fix this by
> using the correct value of calculated power domains.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>

We should have a fixes tag for this too I think:

Fixes: 88914db077b6 ("pmdomain: mediatek: Add support for Hardware
Voter power domains")


> ---
>  drivers/pmdomain/mediatek/mtk-pm-domains.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> index 58648f4f689b..d2b8d0332951 100644
> --- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
> +++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> @@ -1228,7 +1228,7 @@ static int scpsys_probe(struct platform_device *pdev)
>         scpsys->soc_data = soc;
>
>         scpsys->pd_data.domains = scpsys->domains;
> -       scpsys->pd_data.num_domains = soc->num_domains;
> +       scpsys->pd_data.num_domains = num_domains;

Not sure this is the complete fix, as scpsys_add_one_domain() seems to
be using the wrong value of "num_domains" too, no?

>
>         parent = dev->parent;
>         if (!parent) {
> --
> 2.51.0
>

Kind regards
Uffe

