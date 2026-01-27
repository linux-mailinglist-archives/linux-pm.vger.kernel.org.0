Return-Path: <linux-pm+bounces-41540-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MBCD+zMeGmNtQEAu9opvQ
	(envelope-from <linux-pm+bounces-41540-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 15:34:20 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FD795CA8
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 15:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0CB03137573
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 14:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340F135B139;
	Tue, 27 Jan 2026 14:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l6p9OPYd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5233587A4
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769524073; cv=pass; b=FIC6/1Pv4RUkWi3nqptDZVBSN5W5etTKF5C1lHhIz0aUqQ3bawmzzZOEIppYPSEKvTcbDKCO0vjZP11KN8OCJ87JoLXAQ9dC4tL3GvEmjWD3gX4kJdPtRGLfUo7Z7bgNf2BsIbbBtWykZVa9cHgNT81+uz2bmA8DsL/EH4Pt/t8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769524073; c=relaxed/simple;
	bh=+6hira2PqCv4Dp6+TEfz3Cq4R6dRyt8LBQxDtVxSs/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B7QWqXaa8K/Hxaxqc0C7ID5DH+IxfM4nG0eA3/7IonPQHvZf/12qjD+lwCqsXauHxxnx6HKHqCaW2tuKkH58RxO5qgeATVzDAfECCqNEndfkY2uC3sI2F0gEkvKqgAC6kL52FX8nlHmPLFeT73cHQSMBaxS66OAmJiF4qwYCLmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l6p9OPYd; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59dd22b9895so6853070e87.0
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 06:27:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769524070; cv=none;
        d=google.com; s=arc-20240605;
        b=D0BffO9vg5W8kyR59s//t+aC/9fB/VIQeKruIBxloLFihnxslJn1DHKj5kiLeI/S1+
         bE+njADAaQEps+VN8xGbbZMY2O5deRkaATbwh3KJBLbydlvHDYvAe2H/464lszuIk2e2
         RSkgtzldjRo/4PT5GPG9Hqzy28A86z81CD6PO5QAZRB7w82dw6zAUDTW1t0SwC7UYMmb
         F1qxvdO62o3I2p67mA+mzaf3d1Jk775X9wk/Ix/YXkj2NIzRAm+7oFXFTuAfgC3LmDky
         KWmqqZwQT8p5naRcRot6fznu1OpkqGRrHy/HSS1w2ZLjYZStqsunt1J47iG4LnAPEyyv
         giag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1B+ZgAK0ulFf8Rg/ERS29Nw9Z/V30A92LHGwn+CwqEs=;
        fh=L7zV6gJG9TxM0x4NInFCj6WuhaSo5/iVInuFkuUV9Qk=;
        b=LkedDkhvCjkqS/nWoYYp5pJQIvZawlZv4PaVlG977S3H74YUos+QU1q8M7qcGoDUeo
         2KBbV9ZB9bDouhGuRtMyZQ2ZgbHBUvSlT6K7p7Uof1VocW4a892pJKH+ZET6QPieMfbR
         5QEL3o+6nGzizO0sel3CR/lLdTj0k8L0gISB9coVgR3quKZGVVlKM+o/QX2BHryupVwz
         /qwKli8hnXHrRGqoNsQ14CJeR6snkDpK+9DUxYxgtz0QSOwT+aZOdu5OhPY9ntmjB9Nl
         Z7pd6mktcXOny14LbKU7cnD0K3QjuHoM7dtC3ArMqtOKvVlBqlwZR8GxOriHvGcWPYgJ
         sO8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769524070; x=1770128870; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1B+ZgAK0ulFf8Rg/ERS29Nw9Z/V30A92LHGwn+CwqEs=;
        b=l6p9OPYd2NTdsvixaUH0Zc5UeZaGojXhLljp5gc8xS1OvwAAHucF8NNa0akoLPcfGJ
         hIgSC9r4XKsp9GJ+ajtNEANeqtPacH+kHE7w8pjaXUqz89jEohvREMHNi/ZDZEuz/5IW
         nUtW1DeQ54TaHXtA8nAP4Jt62QDdqa1KwcrvuIVSuqVROYaNc3HrRgUJGQVTRgGoCkMS
         HFCewLmgp/h10rxzyFKKf8rDTbV0cgvwKBg5ARt6jyPXUq6YfilZZ66xrH2SjernOd7Y
         gq6IPWXjLbuptCC9xC/IB1ZM51lh7Zh43mRITZhH3ocg5c7reovZ2cR0YWdwLP+irfpN
         F1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769524070; x=1770128870;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1B+ZgAK0ulFf8Rg/ERS29Nw9Z/V30A92LHGwn+CwqEs=;
        b=hVs5zcfc81ndiL8L7i/45rS7fr61WwMzVAgVhDoGx3KquJ34ManzwZZQW3wemp3g8w
         x/byWeq16Z9hNEfjcVyQy8Lghz6TVnrmPwpc1mb6kxzWFRxQxebcmXoCTptKVosgETg3
         iJ3hb7QPxLp7KDBpJHgoGA8lCzpYK/M9PTKwgnrazYS0099cuYg4Odxufhy8pEnto9vm
         cB0YxuV6963zkJLH+N+LINZrPoJOrGUFAJJyvf0sGa/iQByEXGmw2Ik9nEGVDCSeJ4nd
         MvqUMZdFDb58aBoFDlsVHkE5AWxR+puCbflRGMXzO9DOQGsHaId93gBo2N5WR6ad6vxY
         d5dQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKAnjxiKIrKHn4YfTtAtrpyl9XhD27kDTBQxEE1pwwI3+PvicLkynKHMrteypjqpkLfx8y3lU7VA==@vger.kernel.org
X-Gm-Message-State: AOJu0YypzA4A7YdpGzlNNF3LOvkqKV+z1F/hT9S18Nus8LxLtdh8m1sT
	zr+6PHJoiCmqWBXdFWoDPqIhuUooT469FvNwX44ZrCX5vYFFajk/7h3ArBEqAeZwo9bwst/RVva
	GKl1mdlPI/sypcD5s0x3ckiUKaAkVAVdaHT7aayh85w==
X-Gm-Gg: AZuq6aJbNr+B9XRm5n5BLz2p7/U57gLoHYnMhn6nEjHx5SEAcXFRy8DiKSXP3qHAyog
	IFgRCCPtLTaiTz4fvIjOCork0DECMJb+gqSnTsnTKj+b43NoKCW1qAD+rSsOO0xHGl/t4uHEfmQ
	iO9oBB37FzdEv3d9nJNz7gEzVw5/2dLl1OJdKw2CJMdZDOu04nwy4+m0+JYx7O6DnTG1R/l901z
	I19yELwrvCKRWJAeoAKNULJZROjxGz+HUoT+fjpRS1ByS088VUElx0qcVKZB+W+WPqSQgbC
X-Received: by 2002:a05:6512:234e:b0:59b:6a9c:530b with SMTP id
 2adb3069b0e04-59e04142c1bmr857103e87.26.1769524069786; Tue, 27 Jan 2026
 06:27:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121-b4-scu-pd-v1-1-f993e4082089@gmail.com>
In-Reply-To: <20260121-b4-scu-pd-v1-1-f993e4082089@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 27 Jan 2026 15:27:13 +0100
X-Gm-Features: AZwV_QjMAX96nvdaiHP7TCZjGVMhp0ccF964SK-rZQQO1W4Cw8JdkkpQ3MeW438
Message-ID: <CAPDyKFr+USco=KMAnQWz8J_VkqftYwKFV9QtRN0vyc=ERJK8ew@mail.gmail.com>
Subject: Re: [PATCH] firmware: imx: scu-pd: Fix device_node reference leak in imx_sc_pd_get_console_rsrc()
To: Felix Gu <ustc.gu@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Dong Aisheng <aisheng.dong@nxp.com>, linux-pm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41540-lists,linux-pm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,pengutronix.de,gmail.com,nxp.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,specs.np:url]
X-Rspamd-Queue-Id: 59FD795CA8
X-Rspamd-Action: no action

On Wed, 21 Jan 2026 at 15:17, Felix Gu <ustc.gu@gmail.com> wrote:
>
> When calling of_parse_phandle_with_args(), the caller is responsible
> to call of_node_put() to release the reference of device node.
> In imx_sc_pd_get_console_rsrc(), it does not release the reference.
>
> Fixes: 893cfb99734f ("firmware: imx: scu-pd: do not power off console domain")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>

Applied for next by amending the commit-msg-header, thanks!

Kind regards
Uffe



> ---
>  drivers/pmdomain/imx/scu-pd.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pmdomain/imx/scu-pd.c b/drivers/pmdomain/imx/scu-pd.c
> index 01d465d88f60..3ec33667a308 100644
> --- a/drivers/pmdomain/imx/scu-pd.c
> +++ b/drivers/pmdomain/imx/scu-pd.c
> @@ -326,6 +326,7 @@ static void imx_sc_pd_get_console_rsrc(void)
>                 return;
>
>         imx_con_rsrc = specs.args[0];
> +       of_node_put(specs.np);
>  }
>
>  static int imx_sc_get_pd_power(struct device *dev, u32 rsrc)
>
> ---
> base-commit: 053966c344dbd346e71305f530e91ea77916189f
> change-id: 20260121-b4-scu-pd-257a9a40e84e
>
> Best regards,
> --
> Felix Gu <ustc.gu@gmail.com>
>

