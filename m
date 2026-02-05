Return-Path: <linux-pm+bounces-42140-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCQEGtd4hGk23AMAu9opvQ
	(envelope-from <linux-pm+bounces-42140-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 12:02:47 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B66FEF19BB
	for <lists+linux-pm@lfdr.de>; Thu, 05 Feb 2026 12:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1E863033F84
	for <lists+linux-pm@lfdr.de>; Thu,  5 Feb 2026 10:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D343A9D91;
	Thu,  5 Feb 2026 10:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Baw4xbMg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DFE3A9D82
	for <linux-pm@vger.kernel.org>; Thu,  5 Feb 2026 10:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770289045; cv=pass; b=NXe2TP1VThgbeQFHr5ZU85oGMnQMlHvV/oiHKB0soyyiE6d3WLwfsSmYSMA/5hPRIXKm1KukAbyJJAZt7FiUzw7st/iYGuS5ha1rNbR+5t/lvOxhVHjqcW/+x6RUznP3YgTTeKXxqX+NktPY8wS6Lkmkyu06MbGgdePASyYR3wE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770289045; c=relaxed/simple;
	bh=zxHjp/AfzcPTWsBZcOJW1GYjfCe/ewvij7lQ92qSCA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AFCX651gGmo2qRNXsbVRvVKzCMGWXG+Skde5ANbbyxrVkIzPHDAgryPe21mAfqvU7eJ2xIUL/QjrlkF/cSrTIBV53zPEMk8SbQ8PYnwx7tlTA4qsoNlIjuI4S3Eb6+N2WEpjNXb82QRnufe4F0A4/ggHFMR53GhkQllIVu8LOdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Baw4xbMg; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59e3810df30so1067413e87.0
        for <linux-pm@vger.kernel.org>; Thu, 05 Feb 2026 02:57:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770289043; cv=none;
        d=google.com; s=arc-20240605;
        b=LfG3BFB9YGx/5nlFyTsd18mSF3T5V8QTnS4Ixykgc62bKyWftPvEgBz0heBVbN9wAf
         lph249O2GiqubVK7tQKvckN8si/brGxBzwDTzLv9RqY3078813G+9G4V97L6Yv4oIuE7
         Bm3mD2z6/SUlpNaMjT/v4elnvdcOV9kbN2MUxNcs3r7/DLWA7RFdoAD5Z2SC7Ocr5UL8
         0Kzvgyp6VxZczu0ruaFhWdc55EO98XpzPCUgx89V953ukQOguytCbCA4Dc/Musw+gcpQ
         a5jqbu+L3rHUannS+suwDNb0iYNbwCK20l4OTKCcbbcIDFhTJ8RmyvMCwYUF0tnc4FoM
         RbZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UbQJDXfJQp3l0owu271/9ErzB2CssEZ2WkwBrKRmRCk=;
        fh=7X7RwF6X3PnThf/uAR7Tb9Od1+qPGhNXqvzGb79bqds=;
        b=PYyAuXITCyfgxl+wfgSgFtpWBm526VCNbNPMZB1JSWvbmIIt0rDrsqh/XQ23Ke11jt
         DzLOe75mfgeXf5STHf91rCag7yz70DjBf3GSuQC/5TI80gYuPa0J99NpXj7iMKpCmRg0
         rvETwBR4h//FmAFlIphmVTFdfsNxp796GoAiq0eR/pAVUgP9bGbHOdmCJNPh3DKTStd7
         w9EyDd17MTcOF0LR0HcQFZwFR8xyOyFG79oVhu2Z8AS/YBOktaGrKCV+X/jI/CO6qIwN
         uweJqUX3Qzn8mchlxNzngoA5WiNiYkAJW8X3QIjmALuLWr2++KytI+ldoDjzkW3YaDDI
         7t0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770289043; x=1770893843; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UbQJDXfJQp3l0owu271/9ErzB2CssEZ2WkwBrKRmRCk=;
        b=Baw4xbMg5Wl//y4psnQFUS2K/d5iyMBpar8UeyYch7bDyEDswyh49UDnY+POr6DyrE
         MzdwMY6ro+XvqPTifZ3gnk+jwhO4ASchYx2SwJ0GBMShyGukAwVGZYNVf2EYYn3li2W0
         9HqiyHepCCJhz0HxmLIfgy2vSWXVfPr5vj9k11owgvPTGNslmNbiE9rONciENMwn/ntB
         lVOcE6i0MtlEWY8kUFoIYE6vJSusR2JGpd4WhYQVx+BOY14JWpRRHkczaKEiCC14k2o7
         zXOQnxOVL+jI1lmb5fLxbrqGzABr5b1OiVAH32BuonTYSx5DbxCml0BU4qysh03hGo8Q
         YnMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770289043; x=1770893843;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UbQJDXfJQp3l0owu271/9ErzB2CssEZ2WkwBrKRmRCk=;
        b=Go0VY55nw3cGAvcclHn6YQtI+zEpsP7EKdbS7Jdrt5BUTiqC9K69q1IDoVgHpTpLzt
         MiLLBC7VGkpGJF7nLLXrhpne4WVAcAsHNsI7sPwmoZIfPq+WMhY83I9jMIi8VEvLA/sq
         SYRva2N1+ZXtFoEPkVXZeCdRNuFTu5H742Ub8iCOl1HI0bQTFKw2lFOhg5Ud7Opb4Sxx
         boasDQDLaZlf6cljFf6tm7nlty66dMZ7QlB/7WBboJ69aCQZDokJwBPZ2liSfDGQLmtZ
         5YaH/LRpIXrJmBujsjz8/fNLzvUTX1JONi0RUPHIayM4E3jcnlS3M3mfMWyjEi8/oRLO
         qX4g==
X-Forwarded-Encrypted: i=1; AJvYcCUu51eDCpWH7j6ESRMSPVolg6UJOlwYkB0A/R+/uCX9uYKx8qqFhNTZl9pJC3wZmZlhOIvlk1Fueg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKxK9Fb/mheppQtfsSZp44UuNXGkKGeGOykkIUf5TCcPfLMiCN
	JBSrhVdlIiG5cOYX3N2WWX/mRIC3g4cN/dvawXg9iGx5jPiSfXPnVMW3i3t8lzEtG7TBcsB3MaX
	HV8fGNdxW5liCcFBBEnSYHc0RHuK/F3SrS/Wu/H8RUw==
X-Gm-Gg: AZuq6aLa6Y0F4lRB5v7OBjizFn0sq90Z/QfbeXR127sUGXZQ9LkxynTCfU/nmNC5V3z
	RydgRMvhNRtyLqsRaqEyGr8jMq0hc7glka1IgkhxX+MhEs8AvQDDVR/f1iTSsg3KJ7muGnYQh1B
	r7QVIS2HKDrwwzsSVD5Yerc6yc4yTWrVF/5k72dMVPCNwJL7XL5R0pvZbmG3pzoLv6jL/BpsaAB
	mQR1uYmwp8y5hurTBAe/i9BsJ7iUdzMWlBN+Ymi6h1lc//PvLdJ4mdkUoMrytUgdoOv+z4q
X-Received: by 2002:ac2:5691:0:b0:59e:4095:8ac4 with SMTP id
 2adb3069b0e04-59e40958afdmr326028e87.9.1770289042830; Thu, 05 Feb 2026
 02:57:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204111142.2147646-1-xu.yang_2@nxp.com> <20260204111142.2147646-2-xu.yang_2@nxp.com>
In-Reply-To: <20260204111142.2147646-2-xu.yang_2@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 5 Feb 2026 11:56:46 +0100
X-Gm-Features: AZwV_Qh83Z_dpPdJhPeihOR5dVWzbbZZkHZdMTDNgM3o1uPYj_8fR3Ht0j6JmE0
Message-ID: <CAPDyKFpzygoVuDNV1fYN+zfzFHfoXzJCddydNfRvUN9KuxSX5w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pmdomain: imx8mp-blk-ctrl: keep usb phy power
 domain on for wakeup
To: Xu Yang <xu.yang_2@nxp.com>
Cc: Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, peng.fan@nxp.com, jun.li@nxp.com, 
	rafael.j.wysocki@intel.com, a.fatoum@pengutronix.de, ping.bai@nxp.com, 
	shawnguo@kernel.org, l.stach@pengutronix.de, linux-pm@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-42140-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nxp.com,pengutronix.de,gmail.com,intel.com,kernel.org,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,linaro.org:dkim]
X-Rspamd-Queue-Id: B66FEF19BB
X-Rspamd-Action: no action

On Wed, 4 Feb 2026 at 12:10, Xu Yang <xu.yang_2@nxp.com> wrote:
>
> USB remote wakeup need its PHY on, so add USB PHY power domain on active
> flag.
>
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

Applied for fixes and by amending the commit message a little bit to
make it clearer, thanks!

I also added a fixes/stable tag, the same that we used for patch 1.

Kind regards
Uffe


>
> ---
> Changes in v2:
>  - add flag to block control related power domain
> ---
>  drivers/pmdomain/imx/imx8mp-blk-ctrl.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> index 56bbfee8668d..8fc79f9723f0 100644
> --- a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> @@ -53,6 +53,7 @@ struct imx8mp_blk_ctrl_domain_data {
>         const char * const *path_names;
>         int num_paths;
>         const char *gpc_name;
> +       const unsigned int flags;
>  };
>
>  #define DOMAIN_MAX_CLKS 3
> @@ -265,10 +266,12 @@ static const struct imx8mp_blk_ctrl_domain_data imx8mp_hsio_domain_data[] = {
>         [IMX8MP_HSIOBLK_PD_USB_PHY1] = {
>                 .name = "hsioblk-usb-phy1",
>                 .gpc_name = "usb-phy1",
> +               .flags = GENPD_FLAG_ACTIVE_WAKEUP,
>         },
>         [IMX8MP_HSIOBLK_PD_USB_PHY2] = {
>                 .name = "hsioblk-usb-phy2",
>                 .gpc_name = "usb-phy2",
> +               .flags = GENPD_FLAG_ACTIVE_WAKEUP,
>         },
>         [IMX8MP_HSIOBLK_PD_PCIE] = {
>                 .name = "hsioblk-pcie",
> @@ -724,6 +727,7 @@ static int imx8mp_blk_ctrl_probe(struct platform_device *pdev)
>                 domain->genpd.name = data->name;
>                 domain->genpd.power_on = imx8mp_blk_ctrl_power_on;
>                 domain->genpd.power_off = imx8mp_blk_ctrl_power_off;
> +               domain->genpd.flags = data->flags;
>                 domain->bc = bc;
>                 domain->id = i;
>
> --
> 2.34.1
>

