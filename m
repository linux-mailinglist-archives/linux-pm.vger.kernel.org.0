Return-Path: <linux-pm+bounces-42099-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WL03HBFxg2mFmwMAu9opvQ
	(envelope-from <linux-pm+bounces-42099-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 17:17:21 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B1CEA115
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 17:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7855300A50A
	for <lists+linux-pm@lfdr.de>; Wed,  4 Feb 2026 16:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E777E425CF7;
	Wed,  4 Feb 2026 16:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yu2PN//I"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AB93F0774
	for <linux-pm@vger.kernel.org>; Wed,  4 Feb 2026 16:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770221803; cv=none; b=aP88WOI617y5zkZ2anNkYLX8U1h5fZc146PONx9Y4xWw9EeW6+Ylr2aA9hsYjKIZ3kAyjDvEgntLjfflYn/V1El2hlU0i0qPQU3EME8cOwZyNUEtwCTga41sO7veLB93NN9jxQnsT4f40WTgrQd1+nwjueFfbmJO2oQeD7aUDfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770221803; c=relaxed/simple;
	bh=kuTzrDTASSkVJ4OoaiWI0gBTvugmCRaWgpO8sRuvlLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ja6+VFpKtfAwV/tx/9kTrNEmInwF/inMuEb15UI+Agn7ww9eOkMVO4MaoD1TWHKFm894a5iynfsXj5DUmps7mdBrq/GfmSysSbrEKPN9+i7qNraVt0gorGrwvVJdJdQIclAUtDMyY25gXpsHljXBqFBzatewjUNq/aaliN7XC5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yu2PN//I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762EFC19424
	for <linux-pm@vger.kernel.org>; Wed,  4 Feb 2026 16:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770221803;
	bh=kuTzrDTASSkVJ4OoaiWI0gBTvugmCRaWgpO8sRuvlLw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Yu2PN//IJuiShIhF6H5FgrEe8LdDuh80Q8mWNjUvOoPzsw4/rACEZ40KgNVA8Ci6K
	 DfOd9wplAzmtomKAxGpjQGsfhWdwnIqb6MkLrT9x9f10elaNy+JbaxXg2eN25sj5e7
	 Nul53Fm/fcGGhpAGnGbH86nxJcNK+DvByA8KJeHuDjOQQGxhfoHoNmVWIt+VoIlk5T
	 7l87EctP5TLUAt7m9HmW+t9/Hr9zLQZeLdM5uLLtf8mhIZsqbxvj6zsc9A1UlaJmc3
	 JHLZMXluzzN6tec1QkHyKEHodjB6OENIezwk2b1KrDzjSLQ0xMWH+me8i1UAAxBJvd
	 LbKGBbHsQ2E6A==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-45efe81556fso4671868b6e.2
        for <linux-pm@vger.kernel.org>; Wed, 04 Feb 2026 08:16:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX7/KxdmLOuf+wpPa++takiZOwrOF4fexXYD15d5/lN9tokyURSlAIjZI9dYRR9oRfk39oDGZFVYA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVO52ypIxP8noMCknbstKo9TotdvwWiZiCUhWck+Da21gQF4GE
	8MjdQyKPnIKvOpQVejzIFyjbOkv5gZ6YvQ47vFsnLhhJPYJt4tOWl7iO2zgqaI5Kpix4KP8QSsx
	FzkrFvhzaPxFzdLyK7yidfFPlDu5VzKw=
X-Received: by 2002:a05:6808:f0a:b0:45e:b650:c798 with SMTP id
 5614622812f47-462d5a5e779mr2392449b6e.58.1770221802451; Wed, 04 Feb 2026
 08:16:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204111511.78626-1-adrian.hunter@intel.com>
 <20260204111511.78626-6-adrian.hunter@intel.com> <aYNumA0-FvE-g7nl@lizhi-Precision-Tower-5810>
In-Reply-To: <aYNumA0-FvE-g7nl@lizhi-Precision-Tower-5810>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 4 Feb 2026 17:16:30 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0goZmY08MQccrYfQPUhoGKHxv-CbQZfWSv4+O3xGMsrrQ@mail.gmail.com>
X-Gm-Features: AZwV_Qgr6vLt5tJ0f_J-XLTAgmPSqe75ihBd8-EDyOVAoNcIZ2R5UcY2Sv2d4ZA
Message-ID: <CAJZ5v0goZmY08MQccrYfQPUhoGKHxv-CbQZfWSv4+O3xGMsrrQ@mail.gmail.com>
Subject: Re: [PATCH V2 5/6] i3c: mipi-i3c-hci-pci: Add optional ability to
 manage child runtime PM
To: Frank Li <Frank.li@nxp.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, alexandre.belloni@bootlin.com, 
	rafael@kernel.org, linux-i3c@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42099-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: D9B1CEA115
X-Rspamd-Action: no action

On Wed, Feb 4, 2026 at 5:06=E2=80=AFPM Frank Li <Frank.li@nxp.com> wrote:
>
> On Wed, Feb 04, 2026 at 01:15:10PM +0200, Adrian Hunter wrote:
> > Some platforms implement the MIPI I3C HCI Multi-Bus Instance capability=
,
> > where a single parent device hosts multiple I3C controller instances.  =
In
> > such designs, the parent - not the individual child instances - may nee=
d to
> > coordinate runtime PM so that all controllers runtime PM callbacks are
> > invoked in a controlled and synchronized manner.
> >
> > For example, if the parent enables IBI-wakeup when transitioning into a
> > low-power state, every bus instance must remain able to receive IBIs up
> > until that point.  This requires deferring the individual controllers'
> > runtime suspend callbacks (which disable bus activity) until the parent
> > decides it is safe for all instances to suspend together.
> >
> > To support this usage model:
> >
> >   * Add runtime PM and system PM callbacks in the PCI driver to invoke
> >     the mipi-i3c-hci driver's runtime PM callbacks for each instance.
> >
> >   * Introduce a driver-data flag, control_instance_pm, which opts into
> >     the new parent-managed PM behaviour.
> >
> >   * Ensure the callbacks are only used when the corresponding instance =
is
> >     operational at suspend time.  This is reliable because the operatio=
nal
> >     state cannot change while the parent device is undergoing a PM
> >     transition, and PCI always performs a runtime resume before system
> >     suspend on current configurations, so that suspend and resume alter=
nate
> >     irrespective of whether it is runtime or system PM.
> >
> > By that means, parent-managed runtime PM coordination for multi-instanc=
e
> > MIPI I3C HCI PCI devices is provided without altering existing behaviou=
r on
> > platforms that do not require it.
> >
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > ---
> ...
> > +
> > +static int mipi_i3c_hci_pci_suspend(struct device *dev)
> > +{
> > +     struct mipi_i3c_hci_pci *hci =3D dev_get_drvdata(dev);
> > +     struct mipi_i3c_hci_pci_pm_data pm_data =3D {};
> > +     int ret;
> > +
> > +     if (!hci->info->control_instance_pm)
> > +             return 0;
> > +
> > +     ret =3D device_for_each_child_reverse(dev, &pm_data, mipi_i3c_hci=
_pci_suspend_instance);
> > +     if (ret) {
> > +             if (ret =3D=3D -EAGAIN || ret =3D=3D -EBUSY)
> > +                     pm_runtime_mark_last_busy(&hci->pci->dev);
>
> This should not neccessary, the runtime suspend API already call it now.

I'm not sure what you mean.

This is an error path in a system suspend callback, so when exactly
runtime PM will update the last busy time?

> > +             for (int i =3D 0; i < pm_data.dev_cnt; i++)
> > +                     i3c_hci_rpm_resume(pm_data.dev[i]);
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +static int mipi_i3c_hci_pci_resume(struct device *dev)
> > +{
> > +     struct mipi_i3c_hci_pci *hci =3D dev_get_drvdata(dev);
> > +     struct mipi_i3c_hci_pci_pm_data pm_data =3D {};
> > +     int ret;
> > +
> > +     if (!hci->info->control_instance_pm)
> > +             return 0;
> > +
> > +     ret =3D device_for_each_child(dev, &pm_data, mipi_i3c_hci_pci_res=
ume_instance);
> > +     if (ret)
> > +             for (int i =3D 0; i < pm_data.dev_cnt; i++)
> > +                     i3c_hci_rpm_suspend(pm_data.dev[i]);
> > +
> > +     return ret;
> > +}
> > +
> >  static void mipi_i3c_hci_pci_rpm_allow(struct device *dev)
> >  {
> >       pm_runtime_put(dev);
> > @@ -323,6 +455,8 @@ static void mipi_i3c_hci_pci_remove(struct pci_dev =
*pci)
> >
> >  /* PM ops must exist for PCI to put a device to a low power state */
> >  static const struct dev_pm_ops mipi_i3c_hci_pci_pm_ops =3D {
> > +     RUNTIME_PM_OPS(mipi_i3c_hci_pci_suspend, mipi_i3c_hci_pci_resume,=
 NULL)
> > +     SYSTEM_SLEEP_PM_OPS(mipi_i3c_hci_pci_suspend, mipi_i3c_hci_pci_re=
sume)
> >  };
> >
> >  static const struct pci_device_id mipi_i3c_hci_pci_devices[] =3D {
> > --

