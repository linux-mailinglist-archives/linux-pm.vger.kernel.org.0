Return-Path: <linux-pm+bounces-41956-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJkFAOXWgWlYKgMAu9opvQ
	(envelope-from <linux-pm+bounces-41956-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 12:07:17 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E25CD813E
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 12:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0C51D300699C
	for <lists+linux-pm@lfdr.de>; Tue,  3 Feb 2026 11:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2702832F753;
	Tue,  3 Feb 2026 11:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ovxU0G58"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE7A32D7FB
	for <linux-pm@vger.kernel.org>; Tue,  3 Feb 2026 11:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770116828; cv=pass; b=G186fHkhnUhZ3jFek2Re737U7cgnaHKaY71Y0UFw4L/4Ku3mAdc5DNkuqZcLLRuLyRa2Qj7FYqWKQSJXOHtM08auIdOa2lFbKA3KC+xVIhPznqwVt6jNAaDbhUeO7fR5rrSrQO2CQB7zEfkzepTegj0kVaLPNjiZ9+oeVQUmIno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770116828; c=relaxed/simple;
	bh=OH7+HSlnA2x81hRfL4m4AByJ0bZZKFk99H50SaARSyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QYslYaN5QRrIwWGF1HqbXC4IejWFBC/kmj0lK2YWh8ofR3+pgd9WzXf5ACP9yvwTWILQ9+u5X982eQcNztaa/ELqwBfcw492lyuGSJOda9+FdojEEk52Ahp2uG8ilx2x6IZ+/LNa+MLUYhHPetjHeRIXFX+xkXdDXXpJeV3Li4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ovxU0G58; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59b672f8ec4so6089837e87.1
        for <linux-pm@vger.kernel.org>; Tue, 03 Feb 2026 03:07:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770116825; cv=none;
        d=google.com; s=arc-20240605;
        b=VyxNyfq8ZR5YmD0TjE3dwEQNpMJiauAoxO+a+16nmGuMxw/6M/Kj+5nd9SGhQOXg7e
         zrCNqggufSvSMeFsuus9ewRqunlFawbwV3nQleZaa80E1U4qPaKlll1Nx0ieRjKXEt2c
         jW2wa0NBLOtBFP6nU595DuenafoekZY4wFo+Ef8DduWODo18NrKsnDoVXZLdxeHPZvKV
         1PzVgHbj3hxRZBhT8cev4I3zacRs6ObodVd8MTNCjA51Ug7vdEEXJIf2yVwSD76SCOso
         dpV0Ijh7vFEkMYSP6nn4MzhIZ0sr4KyaBLzUmvSzHeodyH50t6s4X3Cp3Inx7Ugc9QGW
         ljtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mpau5hvO+i/E0AiXJ5P3htmR+ezocch+kVwOVkTz9TQ=;
        fh=O23JTvWBBlu9UjjxgR/lGl29SbH2cMU/3Ah1AzmMlXk=;
        b=X/yDU5BP53wrmtbFslAH0BlYRez4c6A9JSx6QfypNOAsyPd+o1jjI4bkK7tTTD2328
         hueDDXMKP49zD4DsEm2Ab1SYgopE+DDj1XhNuHdqv587GVmIh/ixxHyaPxt0ruqHqSEV
         5lIvq3kmgDrDGdXUMuTfLVDeiIL1KqoveN0bCCMNHlOboNqudGLmMmA0Vj6hQYvG+L/+
         947YnpqMbwH2VC1UNcFJuGk8zZhkcrwNTNFLWttqRBI1wDHPpn/t/AVbx9YLrzXOI5TV
         aPt6wBsDd+zxyEj8XPs0ByIzyIwZmxbEXzRzxqBctDdHgTrdJ+P56MMmOvhH72idC8Li
         67kQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770116824; x=1770721624; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mpau5hvO+i/E0AiXJ5P3htmR+ezocch+kVwOVkTz9TQ=;
        b=ovxU0G58i/m4Q0Uz+/0XRnDV3liD+GhF7Is8sjvMq8PxNzFmeUhwUrKwHOVJkRf4ad
         Lwpb8Emr8sSgMbx/BaLiYM+13DEqQYNCkvUf3Q8mszJezihuMlEzVffC6sIBZ/7/2bmi
         kHP6Or7HYkIWUpgusEh+baC5nS3S94ebazilBW9kmEf3kCKM3ndZfh84tVHDPmdTTWzN
         gHPqxscfc5/3pcaFLcqvNifKv6HmC7BezPO7zkcxfZU0H3E7IoRbRAA4yOWvyGPWSBtI
         2oiAf7B39IQE5GuVnWtMklIKDb05NcJAGMgdYG0MRhZIAiMCzX8TXMeMQO7EKMGONWui
         O1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770116824; x=1770721624;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpau5hvO+i/E0AiXJ5P3htmR+ezocch+kVwOVkTz9TQ=;
        b=dwRWNHtKWJ5AK8T364D0vxLq/fKE3ePj6Cld/cHm4l0urZRLXK4k2GQLudecl11Y3g
         Nqkl9d4VnAOi8KNIStWfWMZvtCg4DPg/f6Bio0KRmmrx8u5g/mvM7rIWC1zVJjYGwunO
         TMZ5UwfRbz67INafiNRnjKI5eyXABTOqhh7noD/s7qRqa/+yICTIjtYp4XPYvCAXciC1
         rcVuPsItTmRw5hFQHxsDiedigIKkjtJ2HiO1yJL4XMxHOAmcnqo1DpObXce3ClR3qt2Y
         GMzLVGZ7pD/VV4V+qSCNEu9hIqdKExDzyDw1VkTV3QqIlQkjmscnaa7L75GX6tj1hSPq
         VN6g==
X-Forwarded-Encrypted: i=1; AJvYcCXdWJqryNcawJxyK6RglJbQrY6IlSIABoB6XZngD86Bztd9pHriSOzPhYVfNuS2hc5PtL5vWSVV9g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/x2DytBqgAo7SsdbEVGW2rpDAPfTaCQQguMMraPX2oOOPVuJz
	gcIUaNXbakLwqDeK1+jzWsLhmi+saXQp237i0IOcd5LpfeYvATpuvIJPaOFLyaGYDGlSpZTWvJk
	H8IJRj98PJ62VVOKTw+Ity1XQy+gT1wFreZxcYEqzDw==
X-Gm-Gg: AZuq6aLYtG9wEl5loaf6kibmnXNlBQQvVxEqO0gJh03FK7ZFnEIQrgtI4pHHF3D/GHF
	Cm3ovT5fp3pr3b8VbeEpaTtYkN2BpqM4KvLFgErwblUJ7Qc0z04Z46YTL7OQPrfTwx2vxMSRSr9
	EEviESGSxNcmSNVf0TKnQSlTA8fvtnVba72xUGvMQ9Dt3hOjugxOT/RwN1GvXlIMA2UTtukb5lu
	gjn3GTtl2R7V8aOuvYWLorZVcndSdm7lU4ZNIBcia4kRmhyXOQSv0457HkGMpURQNedkwWf
X-Received: by 2002:a05:6512:10c2:b0:59d:a4ed:1aee with SMTP id
 2adb3069b0e04-59e16424bf4mr4915624e87.40.1770116824273; Tue, 03 Feb 2026
 03:07:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202074730.738760-1-xu.yang_2@nxp.com>
In-Reply-To: <20260202074730.738760-1-xu.yang_2@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 3 Feb 2026 12:06:28 +0100
X-Gm-Features: AZwV_Qh2hAOTL2iZXhJf4HtRUDzm3SZegUCoMSRIOsgW54neZTtXwIBhuC9chV8
Message-ID: <CAPDyKFpqfo1R8Qkq284L9DTURjZnvm_n8W3a6KQTomg7A-M_Ug@mail.gmail.com>
Subject: Re: [PATCH 1/2] pmdomain: imx8mp-blk-ctrl: set awake path for
 power_dev if attached device needs wakeup
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41956-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linaro.org:dkim]
X-Rspamd-Queue-Id: 1E25CD813E
X-Rspamd-Action: no action

On Mon, 2 Feb 2026 at 08:46, Xu Yang <xu.yang_2@nxp.com> wrote:
>
> Current design will power off all dependent GPC power domains in
> imx8mp_blk_ctrl_suspend(), even though the user device has enabled
> wakeup capability. The result is that wakeup function never works
> for such device.
>
> An example will be USB wakeup on i.MX8MP. PHY device '382f0040.usb-phy'
> is attached to power domain 'hsioblk-usb-phy2' which is spawned by hsio
> block control. A virtual power domain device 'genpd:3:32f10000.blk-ctrl'
> is created to build connection with 'hsioblk-usb-phy2' and it depends on
> GPC power domain 'usb-otg2'. If device '382f0040.usb-phy' enable wakeup,
> only power domain 'hsioblk-usb-phy2' keeps on during system suspend,
> power domain 'usb-otg2' is off all the time. So the wakeup event can't
> happen.
>
> Let's propagate wakeup path to virtual power domain device so the wakeup
> event can happen properly.
>
> Fixes: 556f5cf9568a ("soc: imx: add i.MX8MP HSIO blk-ctrl")
> Cc: stable@kernel.org
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> ---
>  drivers/pmdomain/imx/imx8mp-blk-ctrl.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> index 34576be606e3..f3bfd6d22722 100644
> --- a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> @@ -804,12 +804,20 @@ static int imx8mp_blk_ctrl_suspend(struct device *dev)
>
>         for (i = 0; i < bc->onecell_data.num_domains; i++) {
>                 struct imx8mp_blk_ctrl_domain *domain = &bc->domains[i];
> +               struct pm_domain_data *pdd;
>
>                 ret = pm_runtime_get_sync(domain->power_dev);
>                 if (ret < 0) {
>                         pm_runtime_put_noidle(domain->power_dev);
>                         goto out_fail;
>                 }
> +
> +               list_for_each_entry(pdd, &domain->genpd.dev_list, list_node) {
> +                       if (device_awake_path(pdd->dev)) {
> +                               device_set_awake_path(domain->power_dev);
> +                               break;
> +                       }
> +               }

This is really messy in my opinion. Ideally the above should not be
used by a genpd provider as it's internal data structures are managed
by genpd itself.

If I understand correctly, this problem boils down to the fact that we
should have tried harder to model child/parent domains, rather than
using runtime PM to manage the parent domains. I understand there are
problems with that, due to specific power on/off sequences we have for
imx power-domains, but I wonder if those could be managed better by
using genpd on/off notifiers?

Anyway, that said. Rather than walking through the list of devices as
above, I suggest that you use the ->power_off() callback for the
corresponding genpd(s) to dev in combination with a genpd power on/off
notifier for the corresponding genpd that the power_dev is attached
to.

More precisely, if the "child domain(s)" that corresponds to "dev" has
not been powered-off (because device_awake_path() is set for some
device) during system suspend, the power-off notifier should return
NOTIFY_BAD to prevent the "parent domain" that corresponds to
power_dev from being powered-off.

Would that work, you think?

Kind regards
Uffe

