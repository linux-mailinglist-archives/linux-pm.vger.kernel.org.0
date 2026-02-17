Return-Path: <linux-pm+bounces-42766-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Al0K56ulGkPGgIAu9opvQ
	(envelope-from <linux-pm+bounces-42766-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 19:08:30 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EDB14EE93
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 19:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DDCE3038AD0
	for <lists+linux-pm@lfdr.de>; Tue, 17 Feb 2026 18:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CB929B8DB;
	Tue, 17 Feb 2026 18:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPnX4YSB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734AC296BD7
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 18:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771351698; cv=none; b=NAzPvV0WNNPFYCPwg6rgwRyKd5S8ztUhor8vz0p/5lOXzklcuown6ZlweLlxo8LjDOCplPwhn7SF0M9JnfpfbhP5TGFqkpus/ERfFGjIGIUiHP0IOqeiELBHlWeQLmvdLZXKSztc5ZS9NAFWoxP/MDDc0yjetaAgQbHkXYDA1EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771351698; c=relaxed/simple;
	bh=p5jlAeJWQT9jP36UEQY5+BLhULFC1X5SsO1VXhX+J3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dOI0kE6IUoZW75n664Q5eGgEnxCYy9BlzueoqpGdgBGUsR3fQkGrKmZvc0rAkNaRrUwAb+sWNL50V6f4AG6v0CiKPaKodI7PYZr8WnazxmZxBr37SthkZbu8Y1BOykf3YPsE/aeI4WegeKQQI9IIavkMLP2fd3hn0HTbnZy9l3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPnX4YSB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373B1C4AF09
	for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 18:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771351698;
	bh=p5jlAeJWQT9jP36UEQY5+BLhULFC1X5SsO1VXhX+J3Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PPnX4YSBjB+vIgvQVz5AeLwAul7wkZwJZ4GZ5r/mgjP00uHlM4SGOWjMfwwg6TfPi
	 Zprgk0kS7vWftAChkfS8Jdmt0h5iV5eSF5SBDJPRcG+iwkXHsLHpedGtxOtJz9yd2a
	 MzzkiN5C/XmeFNL9CL8w3XCVIg8ONTVHM6le7o7WXZ2g1rhJJtpMirTGYe3vT64ui9
	 /XVsHWbJjTCRXN30Ps6p8owndjVp6f0WYOMuNp+DTu3RMHM7O9AlmMOK3fmUSneuB4
	 6LF6rPDnnLIlo33m27qQ+OKKMagL0yA1gt3y3s+lGncvykni8og/r4uH714XFrZLcA
	 jvHu19NqwKDRw==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d4c12ff3d5so3966499a34.2
        for <linux-pm@vger.kernel.org>; Tue, 17 Feb 2026 10:08:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUViKYN7k6A4s1QpMF5tp0NLV5uiU4YUrVfuh/Qokl0lcizWDcm+ZnukJpUStRuKDICJFqF5H3rJg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEEgSHWGS0/mh6XdiKYR4KF79aCKU0G4oFbwvneGOcYSI8iKbT
	V1WZYzncOtm2tw3lDiFRby3PedhKQwntJvgsmHyoO1jhJDtLZeDyz1XF6VBUQFZA/DW49ofFgH8
	JhkFJcJqmRJNWMC1+8NASBxpDTXHduC8=
X-Received: by 2002:a05:6820:3095:b0:662:c0f7:bee1 with SMTP id
 006d021491bc7-67859a88133mr6052382eaf.26.1771351697181; Tue, 17 Feb 2026
 10:08:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213231428.613164-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <9b639ed0-1765-4cca-814e-18a1260e01b9@linux.intel.com>
In-Reply-To: <9b639ed0-1765-4cca-814e-18a1260e01b9@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 17 Feb 2026 19:08:06 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iaKU6QJ7sxYCS21H0fv99DBNny-_bXzKH4g8RXgFuN6w@mail.gmail.com>
X-Gm-Features: AaiRm50VBLOxg_JalVLz0F1rUg6ugsQjBC2M2nOiIbDavrZqpQwZovep0jNjUD8
Message-ID: <CAJZ5v0iaKU6QJ7sxYCS21H0fv99DBNny-_bXzKH4g8RXgFuN6w@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: pciehp: Fix hotplug on Catlow Lake with
 unreliable PME status
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42766-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wunner.de:email,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 15EDB14EE93
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 5:54=E2=80=AFPM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On 2/13/2026 3:14 PM, Kuppuswamy Sathyanarayanan wrote:
> > On Intel Catlow Lake platforms, PCH PCIe root ports do not reliably
> > update PME status registers (PME Status and PME Requester_ID in the
> > Root Status register) during D3hot to D0 transitions, even though PME
> > interrupts are delivered correctly.
> >
> > This issue manifests during PCIe hotplug operations as follows:
> >
> > 1. After a hot-remove event, the PCIe port transitions to D3hot and
> >    the hotplug interrupt enable (HPIE) flag is disabled as the port
> >    enters low power state.
> >
> > 2. When a hot-add occurs while the port is in D3hot, a PME interrupt
> >    fires as expected to wake the port.
> >
> > 3. However, the PME interrupt handler finds the PME_Status and
> >    PME_Requester_ID registers unpopulated, preventing identification
> >    of which device triggered the PME. The handler returns IRQ_NONE,
> >    leaving the port in D3hot.

I think that you mean the

if (PCI_POSSIBLE_ERROR(rtsta) || !(rtsta & PCI_EXP_RTSTA_PME))

check in pcie_pme_irq().  Or do you mean something else?

An alternative workaround might be to add a (new) "always poll PME"
flag for the port in question that will cause it to go to pci_pme_list
in pci_pme_active() every time wakeup is enabled (essentially, an
override for pme_poll clearing).

> > 4. Because the port remains in D3hot with HPIE disabled, the hotplug
> >    driver ignores the hot-add event, resulting in the newly inserted
> >    device not being recognized.
> >
> > The PME interrupt delivery mechanism itself works correctly;
> > interrupts arrive reliably. The problem is purely the missing status
> > register updates. Verification via IOSF-SideBand (IOSF-SB) backdoor
> > reads confirms that these registers remain empty when the PME
> > interrupt fires. Neither BIOS nor kernel code is clearing these
> > registers.
> >
> > This issue is present in all steppings of Catlow Lake PCH and affects
> > customers in production deployments. A public hardware errata document
> > is not yet available.
> >
> > Work around this issue by disabling runtime PM for affected ports,
> > keeping them in D0 during runtime operation. This ensures hotplug
> > events are handled via direct interrupts rather than relying on
> > unreliable PME-based wakeup.
> >
> > During system suspend/resume, PCIe ports are resumed unconditionally
> > when coming out of system sleep due to DPM_FLAG_SMART_SUSPEND set by
> > pcie_portdrv_probe(), and pciehp re-enables interrupts and checks slot
> > occupation status during resume.
> >
> > The quirk is applied only to Catlow PCH PCIe root ports (device IDs
> > 0x7a30 through 0x7a4b). Catlow CPU PCIe ports are not affected as
> > they are not hotplug-capable.
> >
> > Suggested-by: Lukas Wunner <lukas@wunner.de>
> > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@l=
inux.intel.com>
> > ---
>
> Could you please review this patch and let us know if calling
> pm_runtime_disable() from a PCI quirk is acceptable?
>
> The quirk keeps specific Catlow Lake PCH PCIe root ports in D0 to
> work around a hardware bug where PME status registers are not reliably
> updated during D3hot to D0 transitions, causing hotplug events to be
> missed.
>
> System suspend/resume is unaffected as DPM_FLAG_SMART_SUSPEND ensures
> ports are resumed unconditionally and pciehp checks slot occupation
> on resume.
>
>
> >
> > Changes since v1:
> >  * Removed hack in hotplug driver and disabled runtime PM on affected p=
orts.
> >  * Fixed the commit log and comments accordingly.
> >
> >  drivers/pci/quirks.c | 49 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> >
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 280cd50d693b..779cd65b1a8a 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -6340,3 +6340,52 @@ static void pci_mask_replay_timer_timeout(struct=
 pci_dev *pdev)
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_tim=
er_timeout);
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_tim=
er_timeout);
> >  #endif
> > +
> > +/*
> > + * Intel Catlow Lake PCH PCIe root ports have a hardware issue where
> > + * PME status registers (PME Status and PME Requester_ID in Root Statu=
s)
> > + * are not reliably updated during D3hot to D0 transitions, even thoug=
h
> > + * PME interrupts are delivered correctly.
> > + *
> > + * When a hotplug event occurs while the port is in D3hot, the PME
> > + * interrupt fires but the status registers remain empty. This prevent=
s
> > + * the PME handler from identifying the event source, leaving the port
> > + * in D3hot and causing the hotplug driver to miss the event.
> > + *
> > + * Disable runtime PM to keep these ports in D0, ensuring hotplug even=
ts
> > + * are handled via direct interrupts.
> > + */
> > +static void quirk_intel_catlow_pcie_no_pme_wakeup(struct pci_dev *dev)
> > +{
> > +     pm_runtime_disable(&dev->dev);

Personally, I would use pm_runtime_get_sync() here instead which would
really mean "never suspend".

> > +     pci_info(dev, "Catlow PCH port: PME status unreliable, disabling =
runtime PM\n");
> > +}
> > +/* Apply quirk to Catlow Lake PCH root ports (0x7a30 - 0x7a4b) */
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a30, quirk_intel_catlo=
w_pcie_no_pme_wakeup);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a31, quirk_intel_catlo=
w_pcie_no_pme_wakeup);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a32, quirk_intel_catlo=
w_pcie_no_pme_wakeup);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a33, quirk_intel_catlo=
w_pcie_no_pme_wakeup);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a34, quirk_intel_catlo=
w_pcie_no_pme_wakeup);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a35, quirk_intel_catlo=
w_pcie_no_pme_wakeup);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a36, quirk_intel_catlo=
w_pcie_no_pme_wakeup);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a37, quirk_intel_catlo=
w_pcie_no_pme_wakeup);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a38, quirk_intel_catlo=
w_pcie_no_pme_wakeup);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a39, quirk_intel_catlo=
w_pcie_no_pme_wakeup);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3a, quirk_intel_catlo=
w_pcie_no_pme_wakeup);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3b, quirk_intel_catlo=
w_pcie_no_pme_wakeup);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3c, quirk_intel_catlo=
w_pcie_no_pme_wakeup);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3d, quirk_intel_catlo=
w_pcie_no_pme_wakeup);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3e, quirk_intel_catlo=
w_pcie_no_pme_wakeup);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3f, quirk_intel_catlo=
w_pcie_no_pme_wakeup);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a40, quirk_intel_catlo=
w_pcie_no_pme_wakeup);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a41, quirk_intel_catlo=
w_pcie_no_pme_wakeup);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a42, quirk_intel_catlo=
w_pcie_no_pme_wakeup);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a43, quirk_intel_catlo=
w_pcie_no_pme_wakeup);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a44, quirk_intel_catlo=
w_pcie_no_pme_wakeup);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a45, quirk_intel_catlo=
w_pcie_no_pme_wakeup);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a46, quirk_intel_catlo=
w_pcie_no_pme_wakeup);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a47, quirk_intel_catlo=
w_pcie_no_pme_wakeup);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a48, quirk_intel_catlo=
w_pcie_no_pme_wakeup);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a49, quirk_intel_catlo=
w_pcie_no_pme_wakeup);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a4a, quirk_intel_catlo=
w_pcie_no_pme_wakeup);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a4b, quirk_intel_catlo=
w_pcie_no_pme_wakeup);
>
> --
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
>

