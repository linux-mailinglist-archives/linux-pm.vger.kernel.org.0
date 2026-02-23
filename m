Return-Path: <linux-pm+bounces-43063-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPFCBIKgnGnqJgQAu9opvQ
	(envelope-from <linux-pm+bounces-43063-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 19:46:26 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C28217BB81
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 19:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57A12302F6AA
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 18:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45640369228;
	Mon, 23 Feb 2026 18:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbSkKlPs"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AE036827F
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 18:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771872381; cv=none; b=lktwl3m+LW1XAySNl7hv40oHRxag/cHHE95CV047HgKwQ/IXi9P/QUQDFyqB7KUuyCegLPzxTfjujhacRY2QV3aBrS4H0ARv8IOv0rLn0GEuyV/PGCW4k2owPYTOmLitsblxYN7MjD6/9YU/6Q3yLWYi+k8Xe4Wmo3Qs/yUqUhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771872381; c=relaxed/simple;
	bh=6y9wgSQ25UN1x75PZbsuS9ifUoczwEmoG+d0hEiX4TE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KhNYwZTy843YiKj9zgHfPZ3eKOL7CzEfOBuV4u71hohZ35hxBVGaqYlrJllLuLJ2jTECLP0mMWUD+AEylyHLdXQeCwrX5ciw24nd1Yov5V87KeKaxLl9+oOtG5u4rHKMpERAeaKhBslznSKslNru/L0GzB5sg5C8HMzIVzW+dwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SbSkKlPs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C8BC116C6
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 18:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771872380;
	bh=6y9wgSQ25UN1x75PZbsuS9ifUoczwEmoG+d0hEiX4TE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SbSkKlPsREO0rm0ChhEnt01WYkTT0t7V0kGBB1Sgj1h/rOagqckkUoE2FaxTYA5oK
	 kXtx0KWU2nIV6TgXlwm2loLVDFkVd8DCt7A59qYdTJNaWTyHMQYCG0UOovfTXQL1W5
	 QUh3Q8m9/mMIk/G9vxAhI3om6He7+intS/Jm6rvgLGeGCWzGZ04KbxR73EVgOKxO1F
	 lriX9G1yOYLeXG6mSza0rCNJPWFr87JCiYKRhpkDmOhUX1cLGGKW5e6bLCzoKo+mzJ
	 MeUjTNzgAx8oJsORBPgUNU9RePXdvmZcYHxN0MqufgeUKAlNNGyDDJTwtN1UXRpb5q
	 iV1EZQL96q7JA==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-4043b27ddeaso2737074fac.1
        for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 10:46:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX0IDwRGcZPqcsp04DX2Z/HYhobr9vJUMgrIn/7Xe1ntTBfcyBC22+qxryCj/YR2yo8laPgPXsTiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4DoWf1fK4VubyXqXsXKpPjlxnWAOYU1yekgp4E8syslGm3vxf
	LumwgRZ+MEEkT9eOZZp0MafucsikcOl6lTjMKGgp2DdN8S8lbejlBipsD9XFNWxd6c+1MyO4PZ6
	yfhxhEd18peF8DhuuRQmjIw45rVU8LiE=
X-Received: by 2002:a05:6820:2108:b0:678:cf78:1e9a with SMTP id
 006d021491bc7-679c44eb59bmr4946365eaf.35.1771872379888; Mon, 23 Feb 2026
 10:46:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260217-d3cold-v2-1-89b322864043@oss.qualcomm.com> <20260223181019.GA3700351@bhelgaas>
In-Reply-To: <20260223181019.GA3700351@bhelgaas>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 23 Feb 2026 19:46:08 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h8dQ10oH4KQM8Pdv0jvXyTE6yD1fn5eBPkS_jDYgA8gQ@mail.gmail.com>
X-Gm-Features: AaiRm50BsGbnxI8_7fxOA2OT7oiK5grddQjgSgxcA9FV4RG6FtL9qb_y2TUSt-g
Message-ID: <CAJZ5v0h8dQ10oH4KQM8Pdv0jvXyTE6yD1fn5eBPkS_jDYgA8gQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] PCI: host-common: Add helper to determine host
 bridge D3cold eligibility
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Will Deacon <will@kernel.org>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	jonathanh@nvidia.com, bjorn.andersson@oss.qualcomm.com, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43063-lists,linux-pm=lfdr.de];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,gmail.com,kernel.org,google.com,vger.kernel.org,lists.infradead.org,nvidia.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 8C28217BB81
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 7:10=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> [+cc Rafael, linux-pm]
>
> On Tue, Feb 17, 2026 at 04:49:06PM +0530, Krishna Chaitanya Chundru wrote=
:
> > Add a common helper, pci_host_common_can_enter_d3cold(), to determine
> > whether a PCI host bridge can safely transition to D3cold.
> >
> > This helper is intended to be used by PCI host controller drivers to
> > decide whether they may safely put the host bridge into D3cold based on
> > the power state and wakeup capabilities of downstream endpoints.
> >
> > The helper walks all devices on the bridge's primary bus and only allow=
s
> > the host bridge to enter D3cold if all PCIe endpoints are already in
> > PCI_D3hot. This ensures that we do not power off the host bridge while
> > any active endpoint still requires the link to remain powered.
> >
> > For devices that may wake the system, the helper additionally requires
> > that the device supports PME wake from D3cold (via WAKE#). Devices that
> > do not have wakeup enabled are not restricted by this check and do not
> > block the host bridge from entering D3cold.
> >
> > Devices without a bound driver and with PCI not enabled via sysfs are
> > treated as inactive and therefore do not prevent the host bridge from
> > entering D3cold. This allows controllers to power down more aggressivel=
y
> > when there are no actively managed endpoints.
>
> This series is currently structured so it's only applicable to native
> host bridge drivers, i.e., things using DT.  Is there anything that
> prevents using D3cold for host bridges in ACPI systems?

Do you mean in principle or in practice?

x86 platforms don't support PCI host bridge PM AFAICS and the ACPI
driver doesn't support PM either.  I'd rather not add it ad hoc
because of this patch series.

> > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.=
com>
> > ---
> >  drivers/pci/controller/pci-host-common.c | 45 ++++++++++++++++++++++++=
++++++++
> >  drivers/pci/controller/pci-host-common.h |  2 ++
> >  2 files changed, 47 insertions(+)
> >
> > diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/con=
troller/pci-host-common.c
> > index d6258c1cffe5ec480fd2a7e50b3af39ef6ac4c8c..b0a4a3c995e80e0245657f0=
273a349334071013c 100644
> > --- a/drivers/pci/controller/pci-host-common.c
> > +++ b/drivers/pci/controller/pci-host-common.c
> > @@ -106,5 +106,50 @@ void pci_host_common_remove(struct platform_device=
 *pdev)
> >  }
> >  EXPORT_SYMBOL_GPL(pci_host_common_remove);
> >
> > +static int pci_host_common_check_d3cold(struct pci_dev *pdev, void *us=
erdata)
> > +{
> > +     bool *d3cold_allow =3D userdata;
> > +
> > +     if (pci_pcie_type(pdev) !=3D PCI_EXP_TYPE_ENDPOINT)
> > +             return 0;
> > +
> > +     if (!pdev->dev.driver && !pci_is_enabled(pdev))
> > +             return 0;
> > +
> > +     if (pdev->current_state !=3D PCI_D3hot)
> > +             goto exit;
> > +
> > +     if (device_may_wakeup(&pdev->dev) && !pci_pme_capable(pdev, PCI_D=
3cold))
> > +             goto exit;
> > +
> > +     return 0;
> > +exit:
> > +     *d3cold_allow =3D false;
> > +     return -EBUSY;
> > +}
> > +
> > +/**
> > + * pci_host_common_can_enter_d3cold - Determine whether a host bridge =
may enter D3cold
> > + * @bridge: PCI host bridge to check
> > + *
> > + * Walk downstream PCIe endpoint devices and determine whether the hos=
t bridge
> > + * is permitted to transition to D3cold.
> > + *
> > + * The host bridge may enter D3cold only if all active PCIe endpoints =
are in
> > + * %PCI_D3hot and any wakeup-enabled endpoint is capable of generating=
 PME from
> > + * D3cold. Inactive endpoints are ignored.
> > + *
> > + * Return: %true if the host bridge may enter D3cold, otherwise %false=
.
> > + */
> > +bool pci_host_common_can_enter_d3cold(struct pci_host_bridge *bridge)
> > +{
> > +     bool d3cold_allow =3D true;
> > +
> > +     pci_walk_bus(bridge->bus, pci_host_common_check_d3cold, &d3cold_a=
llow);
> > +
> > +     return d3cold_allow;
> > +}
> > +EXPORT_SYMBOL_GPL(pci_host_common_can_enter_d3cold);
> > +
> >  MODULE_DESCRIPTION("Common library for PCI host controller drivers");
> >  MODULE_LICENSE("GPL v2");
> > diff --git a/drivers/pci/controller/pci-host-common.h b/drivers/pci/con=
troller/pci-host-common.h
> > index b5075d4bd7eb31fbf1dc946ef1a6afd5afb5b3c6..18a731bca058828340bca84=
776d0e91da1edbbf7 100644
> > --- a/drivers/pci/controller/pci-host-common.h
> > +++ b/drivers/pci/controller/pci-host-common.h
> > @@ -20,4 +20,6 @@ void pci_host_common_remove(struct platform_device *p=
dev);
> >
> >  struct pci_config_window *pci_host_common_ecam_create(struct device *d=
ev,
> >       struct pci_host_bridge *bridge, const struct pci_ecam_ops *ops);
> > +
> > +bool pci_host_common_can_enter_d3cold(struct pci_host_bridge *bridge);
> >  #endif
> >
> > --
> > 2.34.1
> >

