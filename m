Return-Path: <linux-pm+bounces-42819-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ApyIer3lWlMXgIAu9opvQ
	(envelope-from <linux-pm+bounces-42819-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 18:33:30 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A3215853A
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 18:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E84593007AE8
	for <lists+linux-pm@lfdr.de>; Wed, 18 Feb 2026 17:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C47D33B6D7;
	Wed, 18 Feb 2026 17:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTFcljFB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3891F312828
	for <linux-pm@vger.kernel.org>; Wed, 18 Feb 2026 17:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771436007; cv=none; b=MgLiMjpJRCLT9js0tG08ZbsPi5DlDFhdT+gRcD+9lAAIHpWQgEbn4LlerdxWcJgzBOhbS5kSU/qZV/v6Y/FaBIHig63XD84O1LZCVMnWfIfvg0HwooE88QnZVvMcl05WAlIQHPnggsM2u7ZQHpPBpgNGpuI8WSaxn6Iqpyfm7aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771436007; c=relaxed/simple;
	bh=5v9J391b7L6dhILj2Qm9Fm20OyHnHPk6MpFqYhJWXwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dLabeDXOz/8c6BCBLaAb8ZXFP7LNHcoFkpi93yelQMqA8e0pmnZjzvjnW7AqFiyFeKbkN5GClm70Skbl36t99ZGk58uGoIY75DBRje7P+ONryZa5DbKwT5dS3C5wId3c3j7HI6hbrZ97VG20GPJgn+bn9OgTVPdM/p5RVM6aHvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTFcljFB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA5AC2BC87
	for <linux-pm@vger.kernel.org>; Wed, 18 Feb 2026 17:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771436007;
	bh=5v9J391b7L6dhILj2Qm9Fm20OyHnHPk6MpFqYhJWXwI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZTFcljFBRpYkPmuT42o/oS0GEXCstvA0/8oWtVkfV1ViqPW8Fzq31+sLP+FExZQps
	 qVB7owdVCp1RpQIUrwvFb+6vK93PIkGYghE+rsYpNf/pZm9HhZdfgaeooefTsxwznv
	 goRHHnEWFbhxUU8GkQvTpBF6PygqVWUqmfH5t3M1LrEXF4qFg943XPf81XxqcFMnZy
	 8ZFlGKTXXaYAixkAVKVt+G66HZXvyDplE2gY18diwb3DiEq5UcaBqrz92OdhH/cY07
	 FV1W8ZMXfvjXWm5bR3ML83hTlwecLQiQxfCOQD+rJdpbj88gkkoqqiD9tRVrCS01M2
	 vDGDIOibN/MHQ==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-676815e147dso43302eaf.3
        for <linux-pm@vger.kernel.org>; Wed, 18 Feb 2026 09:33:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWZ4lJzXbluph/wMfnUCK4TOnfnKGC5x6UEVr09EsiIhzLeNQtDuKf9R3OtggIeS30GRGZM8dfbxA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGH1HvqV6Um0WivRwsXYzGV6I3ad2NLluPBXgHR8o4ufd4XXHN
	A5LI1HsQbgUQXaX/y/mT6nHGIuIPF7s0AEDvEEsWF4v/CjNRRqix7wJH/Vq+tOU0GGnfhhsghJY
	FN0Q4h8byoAJSa/PjRpFHrn0oRqCkS78=
X-Received: by 2002:a05:6820:1518:b0:679:a463:c933 with SMTP id
 006d021491bc7-679a7468861mr1398503eaf.71.1771436006075; Wed, 18 Feb 2026
 09:33:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213231428.613164-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <9b639ed0-1765-4cca-814e-18a1260e01b9@linux.intel.com> <CAJZ5v0iaKU6QJ7sxYCS21H0fv99DBNny-_bXzKH4g8RXgFuN6w@mail.gmail.com>
 <7b4dd756-2ab7-4331-b560-268f9cff0887@linux.intel.com>
In-Reply-To: <7b4dd756-2ab7-4331-b560-268f9cff0887@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 18 Feb 2026 18:33:15 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gcZ5vs4WcS0GhvQrG9Kf05LNrNfd+oXz3WDdCA0xGjjw@mail.gmail.com>
X-Gm-Features: AaiRm51F3J8ThL5jliX9cNzWnrP1r0gGs-YSzm9jCj25p5MijccT6COJNOXZ5-0
Message-ID: <CAJZ5v0gcZ5vs4WcS0GhvQrG9Kf05LNrNfd+oXz3WDdCA0xGjjw@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: pciehp: Fix hotplug on Catlow Lake with
 unreliable PME status
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42819-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wunner.de:email,intel.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: D5A3215853A
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 5:27=E2=80=AFPM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>
>
> On 2/17/2026 10:08 AM, Rafael J. Wysocki wrote:
> > On Tue, Feb 17, 2026 at 5:54=E2=80=AFPM Kuppuswamy Sathyanarayanan
> > <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> >>
> >> Hi Rafael,
> >>
> >> On 2/13/2026 3:14 PM, Kuppuswamy Sathyanarayanan wrote:
> >>> On Intel Catlow Lake platforms, PCH PCIe root ports do not reliably
> >>> update PME status registers (PME Status and PME Requester_ID in the
> >>> Root Status register) during D3hot to D0 transitions, even though PME
> >>> interrupts are delivered correctly.
> >>>
> >>> This issue manifests during PCIe hotplug operations as follows:
> >>>
> >>> 1. After a hot-remove event, the PCIe port transitions to D3hot and
> >>>    the hotplug interrupt enable (HPIE) flag is disabled as the port
> >>>    enters low power state.
> >>>
> >>> 2. When a hot-add occurs while the port is in D3hot, a PME interrupt
> >>>    fires as expected to wake the port.
> >>>
> >>> 3. However, the PME interrupt handler finds the PME_Status and
> >>>    PME_Requester_ID registers unpopulated, preventing identification
> >>>    of which device triggered the PME. The handler returns IRQ_NONE,
> >>>    leaving the port in D3hot.
> >
> > I think that you mean the
> >
> > if (PCI_POSSIBLE_ERROR(rtsta) || !(rtsta & PCI_EXP_RTSTA_PME))
> >
> > check in pcie_pme_irq().  Or do you mean something else?
>
> Yes, I was referring to the above check.
>
> >
> > An alternative workaround might be to add a (new) "always poll PME"
> > flag for the port in question that will cause it to go to pci_pme_list
> > in pci_pme_active() every time wakeup is enabled (essentially, an
> > override for pme_poll clearing).
>
> I will check whether this approach works. I want to make sure the poll
> logic eventually triggers the hotplug handler to detect slot state
> changes.
>
> But if you think there is no power-related issue with keeping these ports
> in D0, then we can adopt the pm_runtime_disable() approach. I think this
> approach looks clean and simple.
>
> What's your preference?

First, keeping the ports in D0 may gate runtime PC10.  Does it not?

Second, I'd use pm_runtime_get_sync() in the quirk as I said because
pm_runtime_disable() generally breaks runtime PM dependency chains
between devices and may cause subtle side-effects to appear.

> >
> >>> 4. Because the port remains in D3hot with HPIE disabled, the hotplug
> >>>    driver ignores the hot-add event, resulting in the newly inserted
> >>>    device not being recognized.
> >>>
> >>> The PME interrupt delivery mechanism itself works correctly;
> >>> interrupts arrive reliably. The problem is purely the missing status
> >>> register updates. Verification via IOSF-SideBand (IOSF-SB) backdoor
> >>> reads confirms that these registers remain empty when the PME
> >>> interrupt fires. Neither BIOS nor kernel code is clearing these
> >>> registers.
> >>>
> >>> This issue is present in all steppings of Catlow Lake PCH and affects
> >>> customers in production deployments. A public hardware errata documen=
t
> >>> is not yet available.
> >>>
> >>> Work around this issue by disabling runtime PM for affected ports,
> >>> keeping them in D0 during runtime operation. This ensures hotplug
> >>> events are handled via direct interrupts rather than relying on
> >>> unreliable PME-based wakeup.
> >>>
> >>> During system suspend/resume, PCIe ports are resumed unconditionally
> >>> when coming out of system sleep due to DPM_FLAG_SMART_SUSPEND set by
> >>> pcie_portdrv_probe(), and pciehp re-enables interrupts and checks slo=
t
> >>> occupation status during resume.
> >>>
> >>> The quirk is applied only to Catlow PCH PCIe root ports (device IDs
> >>> 0x7a30 through 0x7a4b). Catlow CPU PCIe ports are not affected as
> >>> they are not hotplug-capable.
> >>>
> >>> Suggested-by: Lukas Wunner <lukas@wunner.de>
> >>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy=
@linux.intel.com>
> >>> ---
> >>
> >> Could you please review this patch and let us know if calling
> >> pm_runtime_disable() from a PCI quirk is acceptable?
> >>
> >> The quirk keeps specific Catlow Lake PCH PCIe root ports in D0 to
> >> work around a hardware bug where PME status registers are not reliably
> >> updated during D3hot to D0 transitions, causing hotplug events to be
> >> missed.
> >>
> >> System suspend/resume is unaffected as DPM_FLAG_SMART_SUSPEND ensures
> >> ports are resumed unconditionally and pciehp checks slot occupation
> >> on resume.
> >>
> >>
> >>>
> >>> Changes since v1:
> >>>  * Removed hack in hotplug driver and disabled runtime PM on affected=
 ports.
> >>>  * Fixed the commit log and comments accordingly.
> >>>
> >>>  drivers/pci/quirks.c | 49 ++++++++++++++++++++++++++++++++++++++++++=
++
> >>>  1 file changed, 49 insertions(+)
> >>>
> >>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> >>> index 280cd50d693b..779cd65b1a8a 100644
> >>> --- a/drivers/pci/quirks.c
> >>> +++ b/drivers/pci/quirks.c
> >>> @@ -6340,3 +6340,52 @@ static void pci_mask_replay_timer_timeout(stru=
ct pci_dev *pdev)
> >>>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_t=
imer_timeout);
> >>>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_t=
imer_timeout);
> >>>  #endif
> >>> +
> >>> +/*
> >>> + * Intel Catlow Lake PCH PCIe root ports have a hardware issue where
> >>> + * PME status registers (PME Status and PME Requester_ID in Root Sta=
tus)
> >>> + * are not reliably updated during D3hot to D0 transitions, even tho=
ugh
> >>> + * PME interrupts are delivered correctly.
> >>> + *
> >>> + * When a hotplug event occurs while the port is in D3hot, the PME
> >>> + * interrupt fires but the status registers remain empty. This preve=
nts
> >>> + * the PME handler from identifying the event source, leaving the po=
rt
> >>> + * in D3hot and causing the hotplug driver to miss the event.
> >>> + *
> >>> + * Disable runtime PM to keep these ports in D0, ensuring hotplug ev=
ents
> >>> + * are handled via direct interrupts.
> >>> + */
> >>> +static void quirk_intel_catlow_pcie_no_pme_wakeup(struct pci_dev *de=
v)
> >>> +{
> >>> +     pm_runtime_disable(&dev->dev);
> >
> > Personally, I would use pm_runtime_get_sync() here instead which would
> > really mean "never suspend".
> >
> >>> +     pci_info(dev, "Catlow PCH port: PME status unreliable, disablin=
g runtime PM\n");
> >>> +}
> >>> +/* Apply quirk to Catlow Lake PCH root ports (0x7a30 - 0x7a4b) */
> >>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a30, quirk_intel_cat=
low_pcie_no_pme_wakeup);
> >>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a31, quirk_intel_cat=
low_pcie_no_pme_wakeup);
> >>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a32, quirk_intel_cat=
low_pcie_no_pme_wakeup);
> >>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a33, quirk_intel_cat=
low_pcie_no_pme_wakeup);
> >>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a34, quirk_intel_cat=
low_pcie_no_pme_wakeup);
> >>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a35, quirk_intel_cat=
low_pcie_no_pme_wakeup);
> >>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a36, quirk_intel_cat=
low_pcie_no_pme_wakeup);
> >>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a37, quirk_intel_cat=
low_pcie_no_pme_wakeup);
> >>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a38, quirk_intel_cat=
low_pcie_no_pme_wakeup);
> >>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a39, quirk_intel_cat=
low_pcie_no_pme_wakeup);
> >>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3a, quirk_intel_cat=
low_pcie_no_pme_wakeup);
> >>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3b, quirk_intel_cat=
low_pcie_no_pme_wakeup);
> >>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3c, quirk_intel_cat=
low_pcie_no_pme_wakeup);
> >>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3d, quirk_intel_cat=
low_pcie_no_pme_wakeup);
> >>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3e, quirk_intel_cat=
low_pcie_no_pme_wakeup);
> >>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a3f, quirk_intel_cat=
low_pcie_no_pme_wakeup);
> >>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a40, quirk_intel_cat=
low_pcie_no_pme_wakeup);
> >>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a41, quirk_intel_cat=
low_pcie_no_pme_wakeup);
> >>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a42, quirk_intel_cat=
low_pcie_no_pme_wakeup);
> >>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a43, quirk_intel_cat=
low_pcie_no_pme_wakeup);
> >>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a44, quirk_intel_cat=
low_pcie_no_pme_wakeup);
> >>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a45, quirk_intel_cat=
low_pcie_no_pme_wakeup);
> >>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a46, quirk_intel_cat=
low_pcie_no_pme_wakeup);
> >>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a47, quirk_intel_cat=
low_pcie_no_pme_wakeup);
> >>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a48, quirk_intel_cat=
low_pcie_no_pme_wakeup);
> >>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a49, quirk_intel_cat=
low_pcie_no_pme_wakeup);
> >>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a4a, quirk_intel_cat=
low_pcie_no_pme_wakeup);
> >>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x7a4b, quirk_intel_cat=
low_pcie_no_pme_wakeup);
> >>
> >> --
> >> Sathyanarayanan Kuppuswamy
> >> Linux Kernel Developer
> >>
> >
>
> --
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
>
>

