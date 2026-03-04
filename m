Return-Path: <linux-pm+bounces-43574-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDGWLrUWqGlTnwAAu9opvQ
	(envelope-from <linux-pm+bounces-43574-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 12:25:41 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 589001FEF11
	for <lists+linux-pm@lfdr.de>; Wed, 04 Mar 2026 12:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3692F302F7FD
	for <lists+linux-pm@lfdr.de>; Wed,  4 Mar 2026 11:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0035B3ACA5D;
	Wed,  4 Mar 2026 11:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XbkvQoPz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159763A875E
	for <linux-pm@vger.kernel.org>; Wed,  4 Mar 2026 11:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772623532; cv=pass; b=NJmPA2RFR0bLqnUcMt8l/qIS6QmeBmRLH11Q9Myz+5+gwdLbvzmHA+3e4pBve6KmURplOPuLEoWKgImpRPMlUdbFRpEM9b+vkBmJQMa6LQBR+BnQs9yNYhgeRADwrt0T7KAiXyyZW79puN9IqeyXSYJe/6IoZG34EWUhY7/h+TY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772623532; c=relaxed/simple;
	bh=vaFKWCxd8ZTBId2T/qJaZ2Y9EtjCIKwEhTuJSKgdHgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DxR0l0KFpfonLyLs1Xvf3R+uZ+ee1ziyGcgFs30dZhyxUZOFA4ULDmMwNkY57rn59eCkKINAzk/t+SoswRGAjv7AC97WxiESu1Yxyy3LtwuEfCdxkh3JM1hJr5J4w9H0cz2AIif7+MLNDXxdwrTgsV3+xuASrVYXrSQ3Cqgh/0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XbkvQoPz; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-38a2cc31e20so10690421fa.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Mar 2026 03:25:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772623529; cv=none;
        d=google.com; s=arc-20240605;
        b=ePovmJP7uOVNdorv2XbRUZS4rk0VCqzthKRzyXqksAY1Vg8J93ytm7K4lVAU0d/X9c
         7363xVjEY2gPLOpGB5h0eW8ByFxM868WoJkuntzcRqsRLNQv95nP+f9qskxSn8FJzqzX
         J3SVW4HMcI7wg2aKZbLNofcJpsWoJj5VXPX9u3Lgg66zVKxsW/T86AIo6bftvTmVAAJ8
         /TTQ2WwJtvSXeXVxBGymlMkrGJLWXiawF8xfk2xcAoRlEIDLkWUb3D+K34pk77XGybyn
         Kjys/ZEJ6Zj9XW8cXYIn/kK/DuUidThFTkJ1ggIbj8ju6piNQ9YO94qJEVfEwhXiUq61
         jK9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9EMh8wUgn0IgQJLSLJ0VUslGZv8eXjoOaloL2TpWxi0=;
        fh=OnMddJ/+cgx3YJcXf/bITMiaSrllrPY2ivrkkpMn/Js=;
        b=PDPcDBrzXEEyxEDDHeIqH07IDvNLI44EaXfgTRmigVj+CScM2LzIkvFuMET0WF3Iqu
         ihBUBtO5ILzhVYuO+Yri0Lrn+svwXzCOnDQUd8OnSQLBPGPgIgC4fIpakBPHWN4V+rcg
         QgnqFhxSJ1Mz+1Y3iz9FBLf7+JzGewUW+a5uxdy2RDdPhxAb4aXmnqweh1omlE/pTfXh
         uRBAaTbQghhL7SkQgDgPvcKrXhJetxKUSvYX1peppe4CW1Ya1AZEP2JAAuRMxC2935uk
         se7nDFQYLOp8H87FQbAc49jD79ovGwtps8QxZkCnfS/br6pON6ow882Ql4ZQOAiNeyjd
         0MKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772623529; x=1773228329; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9EMh8wUgn0IgQJLSLJ0VUslGZv8eXjoOaloL2TpWxi0=;
        b=XbkvQoPzdNYB7AOcrt9aQKAz146JikIjVc1nKKjoumuP0vKAu8ti4rS4uC+SuG/OGv
         hHdfQUOg9BNhk1vfVL+ozrn1DRaU2pH6GAoSgSti5qUuEHoswwJUelebAWptxf7bp8Fq
         WasPtAcQrga0oVPr16jwklce0s9PmZRdmeN6G5TJmxAJLBqP2WG7U4K7voKDktVdtXl/
         zdv39kBw5Hsd6FXT8i21A3AB4iBSofI4Ykjn+n2whe/54+gKpHgWj/fX1WTY12kEJiIn
         2WVfa/cGyZ7jmsIYXv270rSEeOs1d903hncRVMKtiFn0tHEHtOI94KnbZlU8x9vuAfN1
         At+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772623529; x=1773228329;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9EMh8wUgn0IgQJLSLJ0VUslGZv8eXjoOaloL2TpWxi0=;
        b=hJ+9RtOeyuejdZr3HAtcKiOHLtK8RdRJyHiIpxPiHjyc+aimpi3O74AYUQEjNkviEb
         qKbZzv0jsvgXePcYq6P6KBZ9EvTXWxPrbaIeBgnuCzpAza/3oijI7b7NnGeh0GQ0f/9h
         TRm+7z7SE8CuLZJR8ubuT1/Mv0E+LHA/0h9AqTt1pNZSjDYpZyBMiGOg9Mr9u+dRkWHT
         TB+JOk05QfZwTg4Md8CKJE2mCByqY0dNNlz0SviKM5b7r6eVpUiM10FBcc9iXmPbviie
         H9O07C7jKsDiAkq9tMy1v4cDL9jhGaDIyA5VffmKIB0yEgxXwFm62W2f6WVPwaUVyYF2
         oODQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0wEDB1FskUy6Q95KrQwVqD8XShEC+PLgcpQPEba09qi1faj1TBSUORgC1iKRjS6HBGZeMB0t2iw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yye3z/9MBeHH8MAeM45zBajOrHqSvxmcnSdusLnAoKuF+mF5ZK5
	icohQE9FrEXRiqNRURLgYOZdLs4zHsFTS7UsOc/tUMWPhwC+diKmhTWmjVTo8d+iA3qaOJZbZOB
	dyQZMOm5uFbzyRnzp5DBSHNFN0MyXA12sF6dvfxp2nTIIoii4GNsFEFM=
X-Gm-Gg: ATEYQzw7j2+5FZqequNx039ih8izvifuWLlFyYiJmupIrnfli0Nqr78zSvJRf0G5Yr0
	9CVyQsN8Zuk/lzxErhGdkequNfYTZ+Pl9iol20gOCHne67ENYBHHe+zApTE8GeENY+e46Dnk+5j
	TGh6PijTVbuzA9gDkzilMliKy73nDkEhlSTkHMWy0RxoJbFZ9kw/FaYAyN0r/Mq+LiG6PC31DEx
	KswGy7K8qRjUiUcB0A4cBvHKJcWgIHk7ZxHkNrG+b5TG0vEgUyyZV2BvEBip06MZ7tcVund5lRD
	O3mxPcKB
X-Received: by 2002:a2e:9659:0:b0:38a:1eb8:b435 with SMTP id
 38308e7fff4ca-38a2c7c6255mr9876541fa.38.1772623528965; Wed, 04 Mar 2026
 03:25:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130163102.51757-1-macroalpha82@gmail.com>
In-Reply-To: <20260130163102.51757-1-macroalpha82@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 4 Mar 2026 12:24:52 +0100
X-Gm-Features: AaiRm51vwLJRv4uMlhHz56lEDfVHnRw03Pv2ZO-dJihRDJQnOhTHepTLjORfXlA
Message-ID: <CAPDyKFpCp+EJRmaPhSZQ0fmitM=+0ocGzjKx172Nv9UhKH8FAg@mail.gmail.com>
Subject: Re: [PATCH V2] pmdomain: rockchip: quiet regulator error on -EPROBE_DEFER
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, 
	jonas@kwiboo.se, pgwipeout@gmail.com, finley.xiao@rock-chips.com, 
	kever.yang@rock-chips.com, shawn.lin@rock-chips.com, 
	sebastian.reichel@collabora.com, heiko@sntech.de, 
	Chris Morgan <macromorgan@hotmail.com>, Diederik de Haas <diederik@cknow-tech.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 589001FEF11
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-43574-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,kwiboo.se,gmail.com,rock-chips.com,collabora.com,sntech.de,hotmail.com,cknow-tech.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linaro.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,cknow-tech.com:email]
X-Rspamd-Action: no action

On Fri, 30 Jan 2026 at 17:33, Chris Morgan <macroalpha82@gmail.com> wrote:
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

Applied for next, thanks!

Kind regards
Uffe


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

