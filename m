Return-Path: <linux-pm+bounces-41913-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +ALbKeC9gGl3AgMAu9opvQ
	(envelope-from <linux-pm+bounces-41913-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 16:08:16 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 409A5CDE7B
	for <lists+linux-pm@lfdr.de>; Mon, 02 Feb 2026 16:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D83B33094CBA
	for <lists+linux-pm@lfdr.de>; Mon,  2 Feb 2026 15:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106A6376BD1;
	Mon,  2 Feb 2026 15:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dcQ7YMOY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703381EB9FA
	for <linux-pm@vger.kernel.org>; Mon,  2 Feb 2026 15:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770044439; cv=pass; b=l6c1ZhoY7GCkbW3mFewOSZVryhItV7g4G4fil2hOcQqpWwyexlcrUlD65OPDTdC/QTWVd7yHjkOcN444VNYyonww0fln4fP9vM/ehyS4rFobvI5ma8jw8IMMPhfaAqCIi/wI0fBGyHD3eQrlC61p2guQOsJWzZRoXRN2Au0THtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770044439; c=relaxed/simple;
	bh=/f5J2Sr8vMu8D3rzhsrUy2kkF1nH8LK32/MXs2Qtic4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CF2Dqb5CNX9qbavLnF3lO0cGHwhrf3U4KfD3sdXmk5E3y5dYsO1bnFGnwq5Hn6xwj0JaJ7f7mxsslicMISxy95GnPAUPgucEHwOtisCRcIe2nfVA5AA7nRWlDqwaAGQtpypa04A1H4/ohtSB+M0Vx6bdAl+EVSUublFN8zN+2g0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dcQ7YMOY; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59dcdf60427so5188759e87.3
        for <linux-pm@vger.kernel.org>; Mon, 02 Feb 2026 07:00:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770044436; cv=none;
        d=google.com; s=arc-20240605;
        b=a6f2uJabZzct4PLn4029vU/cACTCat2CAawJ+G7ZusACSFLLLEA+r6s659vTIQFJiq
         s8hScf5VP/cQ/iotvnx/3LUEz2dvB5zfy5OB3ixvdXt4WFzZLkZc4PZpX1qnZ3lLD9ph
         KeaVtkKQih9H6zna2XoPXdpi8z7rI0R2uUedkjGrtDKB3NAa8Fq8WE0DHg/2NKExJLML
         DyFdssA8EOS1TAbcFwvLURKko83PNTuirx8mkP2LvqMRvkCNWx46tsE3Awc3UjNd99vf
         IkeR5cHQ2atRY8zmuGoV5FgbJca+nh5Mwyvfc08XH+aJCrP0AHdHUhVjBXsfj2CVdP7j
         R6xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tjY8IMEcwraRaAcklulnPu0XEgItry8qPQsBSr8viBU=;
        fh=aYfVLpN6F0CdxecC39FKyZVdAUqvlsIvil+5nJRCAcI=;
        b=Ymp7whCPENDV1epjy8rlf6xX6B4y8Ek1E9VczANOoDegaDPSDApeghUsMtBliDnWOY
         ySTerwzYGgesA7AQXjsTcE7H8becgqerFhkPrH4jrd3VicX0KrJCMQ15Rk5EOjn1V51p
         /re/plHooUe1YuVRZ2MHWLcoccsNQOLC3Iznm901VaiDMVVwQbeulKILgyXciGbidPxq
         Jc8/fgvfWoA3NpxOKMpU0Pt9rwHfFudaSNS1sFoHHtR81UqyzU+pN8s3f2CNNoUGPGZ7
         foipyKC6U40ABsZ85k4Uvsui4ZQ+0gciQtDMmB4Jowdej4c989DKzDWYNWBxxDWAHstq
         XmWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770044436; x=1770649236; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tjY8IMEcwraRaAcklulnPu0XEgItry8qPQsBSr8viBU=;
        b=dcQ7YMOYW9wxccJztqL+nbMIdmfMOz/nk2Lx1NVMIg5y6Dhx2/JHttwfR2tHklV2xC
         FJBqp7QYagpI398/2Orvbahpk87XlxanjEVYErOAU9BruEhTbSjyRSS8VpSBRWsMqZu8
         +tqvlXUVIAZ0aIgXnDkozhFJd1VX2ztzNnQajpO21iJx0fRqyi0PxGkERL9w2J5potYL
         frglArS7XtjUz2vIVeNfVm7NxggpmQeiNv8rfOZWane5iDczTkaCK9O0baFxTQjby8EM
         5bdWDVneEpGic2u3sUE1iE58MRTBMxx8HyEfeAB3P76HIOMo5ah7uUnsgtv4FC/NUv0D
         0uXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770044436; x=1770649236;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjY8IMEcwraRaAcklulnPu0XEgItry8qPQsBSr8viBU=;
        b=viIH+FNR2XkPcb32txJW6D8m8poGcYQ1Uv9+J/8Pm9tAh/SG9cF6klIc/YIAnphWZZ
         +Ix6xAf2kFx1s20jm0WAFIskAGW9p7ZKPUAGJOOj1VVpw/FnTVqWyH9Rf2a+vv/LG5CL
         KM84y7aAV0GOZGtLh1MzTYk2xig5b2nHbfK5M2Au2Ygkxwp4QzPPE9A8DmFjD1UgxIze
         DGqi3stGuiBKDb0UDpdAf4S7Y1ETMDSbd6x8d7pBViXynefBG3Yjo3XGIWrtHREUK+h9
         pDru0lLBmNacUQKra5QAQm9ogUPS+VWKYfFNJCojgKBhj23BamDVVKzOP77HMHoF6Kd5
         3GWg==
X-Forwarded-Encrypted: i=1; AJvYcCVD3Imvb5u6WxMX/x+J/0wYhU765yASCQTzuz6kF9WpqqcIBzyvMUIP3fWc4nzUS/+QqfagYzGXyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz56D0w1wJNl6KXKCMXYUd74synwQCigtb2nEEuhfX3RdDi3eam
	we2BqU4RkYenfrvFIElGUkeTnAX7mpypUmvHzwj7yap/WSkCUg2uL2/7/edwvfbAAgnhz4M+Jlq
	33ssauyXa7wuw+YAi9vXdM47F/524JY3ew+7HBnAJUg==
X-Gm-Gg: AZuq6aIyal6dKTVyGzVaqE04SFm+lX11jgvMGt2mDg7L5RFQUhDrnBwCAn1ZQAwVU30
	7rEHhyo0ICKVDou5kIYBnc2Zzf2fUfD+poLFkppYbEM5bMehz/2z1uS3EGOuva0HXmlk7IdvQq+
	Dl1+RDLNinIcu/CuzupKeAmxzviKlq24vN58RbtZW4gwsNBXfcwR7EzraAOgYhvvkpC2CeA4lEW
	3YTwuAFhluMbUsKErl4ggQM6XGV8rcn6TZwVGveaCqv2VEu2pkB6eR2yXulXg0VxhbAJlro
X-Received: by 2002:a05:6512:1114:b0:59d:cb2c:9b60 with SMTP id
 2adb3069b0e04-59e16443c8cmr3908427e87.40.1770044435428; Mon, 02 Feb 2026
 07:00:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202064820.347550-1-irving-ch.lin@mediatek.com>
In-Reply-To: <20260202064820.347550-1-irving-ch.lin@mediatek.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 2 Feb 2026 15:59:57 +0100
X-Gm-Features: AZwV_QgUchHwCanQC14NjkrQfkr08G0f7AUahWDnGm1YzWor4lHgCWR2MlI4fGQ
Message-ID: <CAPDyKFokrMP05rqbACON-ov+=diKpRfxywEqyuJHNnUk72L4kA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add support for MT8189 power controller
To: "irving.ch.lin" <irving-ch.lin@mediatek.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Matthias Brugger <mbrugger@suse.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com, 
	Qiqi Wang <qiqi.wang@mediatek.com>, sirius.wang@mediatek.com, 
	vince-wl.liu@mediatek.com, jh.hsu@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41913-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,collabora.com,suse.com,vger.kernel.org,lists.infradead.org,mediatek.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 409A5CDE7B
X-Rspamd-Action: no action

On Mon, 2 Feb 2026 at 07:48, irving.ch.lin <irving-ch.lin@mediatek.com> wrote:
>
> From: Irving-CH Lin <irving-ch.lin@mediatek.com>
>
>   This series add support for the power controllers
> of MediaTek's new SoC, MT8189. With these changes, other modules
> can easily manage power resources using standard Linux APIs,
> such as the pm_runtime API on MT8189 platform.
>
> Irving-CH Lin (3):
>   dt-bindings: power: Add MediaTek MT8189 power domain
>   pmdomain: mediatek: Add bus protect control flow for MT8189
>   pmdomain: mediatek: Add power domain driver for MT8189 SoC
>
>  .../power/mediatek,power-controller.yaml      |   1 +
>  drivers/pmdomain/mediatek/mt8189-pm-domains.h | 485 ++++++++++++++++++
>  drivers/pmdomain/mediatek/mtk-pm-domains.c    |  36 +-
>  drivers/pmdomain/mediatek/mtk-pm-domains.h    |   5 +
>  .../dt-bindings/power/mediatek,mt8189-power.h |  38 ++
>  5 files changed, 560 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/pmdomain/mediatek/mt8189-pm-domains.h
>  create mode 100644 include/dt-bindings/power/mediatek,mt8189-power.h
>
> --
> 2.45.2
>

The series applied for next, thanks!

Kind regards
Uffe

