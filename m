Return-Path: <linux-pm+bounces-41774-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGalGR6WfGkQNwIAu9opvQ
	(envelope-from <linux-pm+bounces-41774-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 12:29:34 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A46BA154
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 12:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 588C430065EB
	for <lists+linux-pm@lfdr.de>; Fri, 30 Jan 2026 11:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35ACD367F42;
	Fri, 30 Jan 2026 11:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EbOV50pV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46FB285073
	for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 11:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769772570; cv=pass; b=K6gtH4w2D15OdCt4Uj+W8q1ZYRMGOIAkYoFyAsziWpU+iakgIVjxdo2661MB6hZGt5Z468QKXUBc52ipd9PIPh0n5VKZ4qidPspxQ2hIdTz/FdYnX2r9W0PO+wY0GqeH0ggymr69LR7XgRQh1Lll1WrqlLq9gnOhmRT/E9GPaak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769772570; c=relaxed/simple;
	bh=wFOcMo2tbzJO2qV63c870tTsa6KEv3ciZMWj7P7OD20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VbIcMQ6Br4qzb8AzfrtaIYa0iWJb8RynDLWdyBD8QECD80lID1AQM8Ha10Y2mGWP/KvsvwsDqf+yGDPh3YaXSt8LrHPom3DMB12nY3uKndsxBsjLnhkHLicaxThuVD/KABdCZXzfbuHi42NNDbRpgdxb2hHLfMMgVDTD2ZIVVoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EbOV50pV; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-382fb535b73so17444441fa.0
        for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2026 03:29:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769772567; cv=none;
        d=google.com; s=arc-20240605;
        b=Ga16F0iho7GjHhZJMOUDRGRwBXY65QX/64RmC3O9RmqO6wsG8NnX7/L35p6PwJ7R4I
         UthVCnejUdlIVBp2DPOrmEqADtSSaxHGh5uGWE658b74f8bOIikXyaGoFYfgJwcbjbv/
         fdlQskO638vZKXC1p3TjpATNrxLEyiWnqnOgqVrLZOdzm/AFArAG3ZuvCg3myLAAvtRM
         yQMWtId9eTdKe5iIBDIF5iRrk1wJS9ISkgI8w564jYgdux4TCswsGPuUQRkNebO1IlJM
         9Paw5KDw90e0iQmgrZNJ2+gS20MhHAoKcNilA/EbitU4VnaIAsUeqS4K6buXkxBh9vaD
         B6uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SbEnXixljZraid29u+TVBlnssG6MakYScyhKGxGYZ0g=;
        fh=wAl0fW/HsyjlJh95wMBezgA2kxXRsTjj5x1dTuarJg0=;
        b=OvzOq7CQX/3RjkLYrWjVpgTplKfVuiDfd4MTxRM/qiXHDX120FFE0PoX3zsQcxtJ9+
         CHPGiN0yfUilOWCqPzXWKJi5Dm1+3FNPmjlVXYdiz1ixWP2jj3nyXqncgLquzmPUouLG
         jRXpF5YcvVKGbG7GQTkVLHqO6AdFb/N8/iqlX9G3Z+JPN72h55k6SZG2P6oU3TA8CRcx
         Swl0CRT+j4zr8jbUavUmixrr9CDdMxoToQcgkaGT0HPZlw29r99hSzHkCsR00berFTsk
         j5KyR+IjGmf0cfCGe4HT2ChVGL4vW0bMIvlHdf+xVtPqwXZ0T//7MB8lzhrZ5QHwNWTj
         diUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769772567; x=1770377367; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SbEnXixljZraid29u+TVBlnssG6MakYScyhKGxGYZ0g=;
        b=EbOV50pVqRBBGQAKlQ/D9wVEmnrAeOgqloiYPCOMKSvEXOMy8Yc/EL8IOsSyCq9LnC
         aeGCzPaEmoJE8azZgUAaDcfp+hzerqsIVKr62NZcXJw19jmQDKJnOIRhXkS3Y6fMKpFg
         EWeed2oI71n5qNfiWV+QVaTUmvTj+mlbzoxzl+B8uPRpi1ELHRumoCaagammVA+drwdx
         QVIg9CBOBGMd4sB/3Bcu8yDg7AyHy2ZCpfo1s4FGtOeu0vpmisZYLjOh3Nv/d4x29LUO
         A3IQLofR5rB2mrtoI7T+e5YEtjam5a3M1ERd8moC4umiJbml2hST4vi1g7zVaLShqMn5
         2EUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769772567; x=1770377367;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SbEnXixljZraid29u+TVBlnssG6MakYScyhKGxGYZ0g=;
        b=tsuMtkoKw25lF7gLTdwBmCHd2sJXN/sf9u5VWfXCW4E8qCfUOwIPOIz2gqPZg6Kkj8
         woRZH9a+oItQmwgipm4y/BCm26EwK+rQdijmmEsT35wySNLqOSfBwX21RKziSecO9eOw
         M67/lUd/28Vuov509S34xfxYiKSqU5m2+BFRT0EyU3N5DdnjViNJQC+/G9dS7YtOBks3
         IGCs1FtDWc0gjr2WJW5GSslLeb6SZ+Kiqvf1pWnaggwIep1hQSHerJHQXYMieeMSv33F
         iiwegB/e9HNgDYNCf75Iv9Q1/FFLruZFfovpaEL6HynJRakzCpkNW49QrfUZa9ZS9t/c
         5ctg==
X-Forwarded-Encrypted: i=1; AJvYcCWTez+daunG/ak70DcCvidTaYJV3u5QAupWtJC8Hq0vDnUxvn27dCfbHWy/6oipwxfA6e8IhVbnkg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4ywdRj8X/N+9O9jEiXu950QxdwdHgyq8wOHrt7ySM0RnIAqj7
	ttJ8AyNvAS5l8LvXcbSvZ1mfhyhOxAopAVJIWhbnZLWmmDANkn3NF+AyGaUeoreRxd9OfGTD975
	ZdEvRgbZmNH2mlYtSmYVA4QvQFwaelMyAUREEv9D/+w==
X-Gm-Gg: AZuq6aL+vsONrWP72sfxTLVdC0+0oovARDAzfFlw6Vv5PMwWriBwL2IVVmxveSDGPUy
	JFHpCbYY3Sfokj3vqW2Ce95xI90LLaSuK7tzPmLNZzEp30BMW4M9BoX77fENl8xPfqp7zQ6+4+7
	6c3jPqSFw7fTHuJPZNS2sCRLJtCxn7EdPzRJPZnAhmDMw3F8ACrdtAQgKUa9eg2CSR85G0JZdE5
	16D/ywRRx4g2DXg4f6f1ofbE43NoC2V0ZVH4rj2l3lB5RBLNB5F/AR77lh66KeqOALzB707
X-Received: by 2002:a05:6512:224a:b0:59e:417:27f9 with SMTP id
 2adb3069b0e04-59e16429e70mr896593e87.44.1769772566817; Fri, 30 Jan 2026
 03:29:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130051107.2130200-1-xu.yang_2@nxp.com>
In-Reply-To: <20260130051107.2130200-1-xu.yang_2@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 30 Jan 2026 12:28:50 +0100
X-Gm-Features: AZwV_QibZsm573nlfq_ooYxHiuwgVu5XH3YEh5JOtPYvggTnLni4Oi1IejkPYVA
Message-ID: <CAPDyKFpAiFSUXBahWzEbqPnyT_R9FFxryohCKHA=REdcv-vyiQ@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: imx8m-blk-ctrl: fix out-of-range access of bc->domains
To: Xu Yang <xu.yang_2@nxp.com>
Cc: s.hauer@pengutronix.de, Frank.Li@nxp.com, kernel@pengutronix.de, 
	festevam@gmail.com, khalasa@piap.pl, benjamin.gaignard@collabora.com, 
	frieder.schrempf@kontron.de, p.zabel@pengutronix.de, shawnguo@kernel.org, 
	l.stach@pengutronix.de, linux-pm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41774-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[pengutronix.de,nxp.com,gmail.com,piap.pl,collabora.com,kontron.de,kernel.org,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,linaro.org:dkim]
X-Rspamd-Queue-Id: 06A46BA154
X-Rspamd-Action: no action

On Fri, 30 Jan 2026 at 06:11, Xu Yang <xu.yang_2@nxp.com> wrote:
>
> Fix out-of-range access of bc->domains in imx8m_blk_ctrl_remove().
>
> Fixes: 2684ac05a8c4 ("soc: imx: add i.MX8M blk-ctrl driver")
> Cc: stable@kernel.org
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/imx/imx8m-blk-ctrl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> index 74bf4936991d..19e992d2ee3b 100644
> --- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> @@ -340,7 +340,7 @@ static void imx8m_blk_ctrl_remove(struct platform_device *pdev)
>
>         of_genpd_del_provider(pdev->dev.of_node);
>
> -       for (i = 0; bc->onecell_data.num_domains; i++) {
> +       for (i = 0; i < bc->onecell_data.num_domains; i++) {
>                 struct imx8m_blk_ctrl_domain *domain = &bc->domains[i];
>
>                 pm_genpd_remove(&domain->genpd);
> --
> 2.34.1
>

