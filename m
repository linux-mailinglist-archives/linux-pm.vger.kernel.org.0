Return-Path: <linux-pm+bounces-41565-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPC3K8nmeGmHtwEAu9opvQ
	(envelope-from <linux-pm+bounces-41565-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 17:24:41 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 306A797B58
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 17:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C111302D943
	for <lists+linux-pm@lfdr.de>; Tue, 27 Jan 2026 16:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF6435EDC3;
	Tue, 27 Jan 2026 16:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/F01GEr"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486C735CBD6
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 16:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769530819; cv=none; b=E+Y1tHWYDMMe8wZJlfGUib/x18BF4iJ76Q3fqslWQU97zd1h+u3dBM53L35r37e5Tu78H8AXVcBCoxiq7mcqCJi6ZqCKdq3gxxwIFJH5+otnWgY41H0sSmewgi7Vrsy0JCpoYQuuhtOl+HQNWf7SqcFKHamSAcQ8ktmbthAu4As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769530819; c=relaxed/simple;
	bh=j/r81l60+n988XDhJwp9gqtIu+KCrFA7s3sahB6LIzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nshl6SjXPtWqoznyDpic8lmy2HS4le2/WZ1zibflU/XR1oY8BRPyLSeV5ucyVS4keV1Tw+YwZMJVDv9P3xULaEb05ZyGyTCDWgAzqRYbXpsKfHDFxA0kS3rTm91hNPDK8xr+Kv79lhhqeBW/1pF1g+o6RXtVx+Dw7LDTnPbhhdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/F01GEr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1DFAC2BC86
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 16:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769530819;
	bh=j/r81l60+n988XDhJwp9gqtIu+KCrFA7s3sahB6LIzs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=O/F01GErlnwsLhFiBFG06g2ucdpz5wibUnH7aRuKmZRZG7P9nZ7xHKCFUftjaYWtB
	 bC92/HSB0XSQ29jW8vDCRUPvDZha97oZc1vITntEZbhkG8LWAs51tF0nT4QMBOCVP8
	 +pC+eto+YYi4md037X6yP8BB160sPGlCTjyt+V2+rGyw6jeqCotCJUfh5XbVa6EbeA
	 xaiN9DCn+F7y8Lmx1gguQNUo9ZkXzceeRiZnsE78PfrC/XiqnkAYIFk2zrUh36PLVN
	 74obBXbj0Ofc23PNYIWTE+aeQ2D6lO4h4l28HcKxEZuMBM+CMzUvy4fHvYe1/8hM/z
	 NZPLTH1+c6Ksg==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-409521ba360so119218fac.2
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 08:20:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV2TXVIPnvE8e6UFvRygzhEaHMsonD4JewLs89d/9BpqWT5Y8zJkgpdGQkEnLCDBz1QILLoXyPC/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVEQ1xlhw62FL2RZFx5o7lLnUP+NJpR20tWz21SYh20DOP9hnH
	10Yr0DZf2pTubPPuoTQ0mj8iAxFh9JLeBbkVjBC0X7b6VHyanAJJTJtufCMXRdISEEbSoZXhItx
	NnYr9ypAn0HPosM585d1fHCbnVC9vi7o=
X-Received: by 2002:a05:6820:f012:b0:65d:88b:c00d with SMTP id
 006d021491bc7-662f20d44b8mr1392185eaf.66.1769530818018; Tue, 27 Jan 2026
 08:20:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120-topic-lpm-pmdomain-device-constraints-v1-0-108fc4cfafce@baylibre.com>
 <20260120-topic-lpm-pmdomain-device-constraints-v1-1-108fc4cfafce@baylibre.com>
In-Reply-To: <20260120-topic-lpm-pmdomain-device-constraints-v1-1-108fc4cfafce@baylibre.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 Jan 2026 17:20:06 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h4fp5zsT0HL1FYo8W08ABLViEOqcwapH77GiFiM9x1DA@mail.gmail.com>
X-Gm-Features: AZwV_QiyblyFdXrKKbywWhXRtjyRSWEN-afFMgeFqCd9ejBl2IWF0qVtbLbr3eM
Message-ID: <CAJZ5v0h4fp5zsT0HL1FYo8W08ABLViEOqcwapH77GiFiM9x1DA@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM / QoS: add flag to indicate latency applies system-wide
To: "Kevin Hilman (TI)" <khilman@baylibre.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, 
	Dhruva Gole <d-gole@ti.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-41565-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,baylibre.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 306A797B58
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 2:54=E2=80=AFAM Kevin Hilman (TI) <khilman@baylibre=
.com> wrote:
>
> By default, the QoS resume latency currenly only applied to runtime PM
> decisions.
>
> Add new PM_QOS_FLAG_LATENCY_SYS flag to indicate that the
> resume latency QoS constraint should be applied to system-wide
> PM, and *not* runtime PM.
>
> Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>

This is fine with me, so

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

Or do you want me to pick it up?

> ---
>  drivers/base/power/sysfs.c | 27 +++++++++++++++++++++++++++
>  include/linux/pm_qos.h     |  2 ++
>  2 files changed, 29 insertions(+)
>
> diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
> index 13b31a3adc77..9136c13c17e4 100644
> --- a/drivers/base/power/sysfs.c
> +++ b/drivers/base/power/sysfs.c
> @@ -316,6 +316,32 @@ static ssize_t pm_qos_no_power_off_store(struct devi=
ce *dev,
>
>  static DEVICE_ATTR_RW(pm_qos_no_power_off);
>
> +static ssize_t pm_qos_latency_sys_show(struct device *dev,
> +                                      struct device_attribute *attr,
> +                                      char *buf)
> +{
> +       return sysfs_emit(buf, "%d\n", !!(dev_pm_qos_requested_flags(dev)
> +                                         & PM_QOS_FLAG_LATENCY_SYS));
> +}
> +
> +static ssize_t pm_qos_latency_sys_store(struct device *dev,
> +                                        struct device_attribute *attr,
> +                                        const char *buf, size_t n)
> +{
> +       int ret;
> +
> +       if (kstrtoint(buf, 0, &ret))
> +               return -EINVAL;
> +
> +       if (ret !=3D 0 && ret !=3D 1)
> +               return -EINVAL;
> +
> +       ret =3D dev_pm_qos_update_flags(dev, PM_QOS_FLAG_LATENCY_SYS, ret=
);
> +       return ret < 0 ? ret : n;
> +}
> +
> +static DEVICE_ATTR_RW(pm_qos_latency_sys);
> +
>  #ifdef CONFIG_PM_SLEEP
>  static const char _enabled[] =3D "enabled";
>  static const char _disabled[] =3D "disabled";
> @@ -681,6 +707,7 @@ static const struct attribute_group pm_qos_latency_to=
lerance_attr_group =3D {
>
>  static struct attribute *pm_qos_flags_attrs[] =3D {
>         &dev_attr_pm_qos_no_power_off.attr,
> +       &dev_attr_pm_qos_latency_sys.attr,
>         NULL,
>  };
>  static const struct attribute_group pm_qos_flags_attr_group =3D {
> diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
> index 6cea4455f867..aededda52b6b 100644
> --- a/include/linux/pm_qos.h
> +++ b/include/linux/pm_qos.h
> @@ -37,6 +37,8 @@ enum pm_qos_flags_status {
>  #define PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT (-1)
>
>  #define PM_QOS_FLAG_NO_POWER_OFF       (1 << 0)
> +/* latency value applies to system-wide suspend/s2idle */
> +#define PM_QOS_FLAG_LATENCY_SYS                (2 << 0)
>
>  enum pm_qos_type {
>         PM_QOS_UNITIALIZED,
>
> --
> 2.51.0
>

