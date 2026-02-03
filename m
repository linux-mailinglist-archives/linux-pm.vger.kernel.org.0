Return-Path: <linux-pm+bounces-41997-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBrlFalYgmmkSgMAu9opvQ
	(envelope-from <linux-pm+bounces-41997-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 21:20:57 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9465DE724
	for <lists+linux-pm@lfdr.de>; Tue, 03 Feb 2026 21:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7C5330292CD
	for <lists+linux-pm@lfdr.de>; Tue,  3 Feb 2026 20:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E1B36B062;
	Tue,  3 Feb 2026 20:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHIYu1qj"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EA230CDBD
	for <linux-pm@vger.kernel.org>; Tue,  3 Feb 2026 20:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770150054; cv=none; b=FR3b2iICsOAg6UWTLgFMUc2HbKEAwnhbfdiQ5CSBzEzADpYfk9rKPrBdEUdtb9VWxj6grw51Bl9Q6nCdvMIk2brgKeBMCkfyVcNTtMGgpInjH3T29yJff763KcsiulsYavhKRqty/nKyK0eR1WuK3LjPxlED7H9y6KPqR6Xb/MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770150054; c=relaxed/simple;
	bh=uRdo9T/JxdN5Vvo7QBrwNhie6atlsh3Wku65n0I6LWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p58fwgvwpT+Tfr69ntPpPWMYqPZ77sAEgFKeNE6+2huMmr33b0s4GYJ7R1X6R5r3IEOFtXG9Nn0lgNTta0Dx/VytFczgAS/cIvl2N3wWCSb03jiaIwTv1oz992RZZ7kKjRuDvu7cxpcndSZeP6uTk4Payxhmn8f6Lk/2isr8POc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHIYu1qj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF13C4AF0B
	for <linux-pm@vger.kernel.org>; Tue,  3 Feb 2026 20:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770150054;
	bh=uRdo9T/JxdN5Vvo7QBrwNhie6atlsh3Wku65n0I6LWM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MHIYu1qjcDf2C0nqjowuyKGYQF2Suv8A7QJtOeA2HWRzO94wHHo3w0xMSSIFC7Tyn
	 vYDbIbfQtnNVq+kfWjuSMBPvGDjmtNugqeA9v/XZTkS5Olv16IsSLCGr3iHPvkkmqE
	 F1lwyca6Rn8OCKLCJG+HB+1Z5TBS9g3MujuK/lvowSS3rOqIx3G9Q2EKvjMN/7WjWQ
	 eIDXQIjRLClh5rtEOZmCjyUKHe/5ITVCYN1IlzZw9203ENxSRSLTOAuJAGu1PRGkQx
	 DDZAiqpnucFxZO38p+kff31cVzOJ+zVQm3DVdFpeciglcssJb9cyy0/VtkNo+MJ0ja
	 BCnmS4+DkR8GA==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-3f9ebb269c3so2931659fac.3
        for <linux-pm@vger.kernel.org>; Tue, 03 Feb 2026 12:20:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWkhOUAAT696U5injJKdxj3Ym1JyGekPn6XuFHKMKvFZ/ZheqhjZ7d1Z2q2IjcQzwyk9HBj+PFbWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YweKWpHdqRuuScYvhHjChfiZdTEEiruNUdJUTxO0TrXMTnvvg+2
	JIqtA7D79mMSFHpeqtG7gPjH+T+LFvZaivzBPIZ6dw5ClEhpCVKnCEpsmmqTAx/F0wt63h59i1/
	hf05lHzIzAybhejKtL6gBAIdBa78SKDw=
X-Received: by 2002:a05:6820:994:b0:662:f4cb:208f with SMTP id
 006d021491bc7-66a22690aedmr413471eaf.51.1770150053603; Tue, 03 Feb 2026
 12:20:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129181841.130864-1-adrian.hunter@intel.com>
 <20260129181841.130864-6-adrian.hunter@intel.com> <aXu8TiFpMiIVk5Iq@lizhi-Precision-Tower-5810>
 <dd681a97-de37-436b-b09e-5173c1de2f24@intel.com> <aXvKZK8tTnCDGzth@lizhi-Precision-Tower-5810>
 <a8a608c8-c6ce-415b-ac02-db1246edb15e@intel.com> <aXzIeLLDxsmzUhI+@lizhi-Precision-Tower-5810>
 <09622627-2ff3-4fb7-80f2-686d6474e417@intel.com> <aYDP847mgleQBF5Y@lizhi-Precision-Tower-5810>
 <eb335daa-ab6b-4cff-bea2-90160892bc8f@intel.com> <aYIbZ3PwiKUfp/eL@lizhi-Precision-Tower-5810>
 <73f7fc6b-d3cc-46d0-a07b-45c2a4190434@intel.com> <a6525228-2abf-4177-acc7-858843941ba4@intel.com>
In-Reply-To: <a6525228-2abf-4177-acc7-858843941ba4@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Feb 2026 21:20:42 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ha8VG2k42qCgWXmx96Rn9WY7x10dLEipJMj2kRFEfHmw@mail.gmail.com>
X-Gm-Features: AZwV_QgLjR1iW-ulNpU1td_J9ICfk9E7_Ru6m1VZ-sWnr4Ijfl0Ej8Z3FZ0IR8I
Message-ID: <CAJZ5v0ha8VG2k42qCgWXmx96Rn9WY7x10dLEipJMj2kRFEfHmw@mail.gmail.com>
Subject: Re: [PATCH 5/7] i3c: mipi-i3c-hci: Allow parent to manage runtime PM
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Frank Li <Frank.li@nxp.com>, 
	alexandre.belloni@bootlin.com, linux-i3c@lists.infradead.org, 
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
	TAGGED_FROM(0.00)[bounces-41997-lists,linux-pm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C9465DE724
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 5:57=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.c=
om> wrote:
>
> On 03/02/2026 18:22, Wysocki, Rafael J wrote:
> >
> > On 2/3/2026 4:59 PM, Frank Li wrote:
> >> On Tue, Feb 03, 2026 at 02:54:44PM +0200, Adrian Hunter wrote:
> >>> + Rafael
> >>>
> >>> Rafael, this is not at all urgent, but when you have time
> >>> please have a look at this patch set.  There is also some
> >>> more explanation below.  Is it acceptable?  Is there a
> >>> better way?
> >>>
> >>> On 02/02/2026 18:25, Frank Li wrote:
> >>>> Does your device Hierarchy look like
> >>>>
> >>>>             PCI device
> >>>>                 |
> >>>>         -----------------
> >>>>        HCI1            HCI2
> >>>>         |               |
> >>>>       I3C M1          I3C M2
> >>> Yes and no.  There is only 1 real device : the PCI device.
> >>> It implements the MIPI I3C HCI standard which allows multiple
> >>> I3C bus controllers in one device (in our case 2 controllers).
> >>>
> >>> The PCI driver mipi-i3c-hci-pci creates 2 platform devices,
> >>> one for each controller.  The platform driver is mipi-i3c-hci:
> >>>
> >>>   Driver                        Device                     Bus
> >>>
> >>>   mipi-i3c-hci-pci            0000:00:11.1                 PCI
> >>>                              /            \
> >>>   mipi-i3c-hci      intel-lpss-i3c.0  intel-lpss-i3c.1     Platform
> >>>
> >>> LPSS I3C also supports wake-up from in-band interrupt (IBI) via
> >>> PCI PME.  The PME only works when the PCI device is in a low power
> >>> state (D3hot in our case).  Also the PME is effectively shared by
> >>> the 2 controllers i.e. an IBI signal (the controller's SDA line
> >>> pulled low) for either controller will cause the PME.
> >>>
> >>> That means there are only 2 valid configurations:
> >>>
> >>>     1: Both controllers enabled to receive IBIs
> >>>         PCI device    D0
> >>>         Controller 1    Enabled
> >>>         Controller 2    Enabled
> >>>
> >>>     2: Both controllers disabled to enable PME wakeup
> >>>         PCI device    D3hot
> >>>         Controller 1    Disabled
> >>>         Controller 2    Disabled
> >>>
> >>> However, represented as platform devices, the 2 controllers
> >>> runtime suspend and resume independently from each other.
> >>> Whereas they effectively need to runtime suspend (or resume)
> >>> at the same time.
> >>>
> >>> The proposed solution is for the PCI driver mipi-i3c-hci-pci
> >>> to take over managing runtime PM for both controllers, calling
> >>> into mipi-i3c-hci when it is safe to do so, to save/restore state
> >>> and disable/enable the controllers one after the other.
> >>>
> >>> Current situation (I3C next branch):
> >>>
> >>>     PCI device    Runtime PM enabled, dependent on child devices
> >>>             PCI subsystem controls PCI device power state
> >>>
> >>>     Controller 1    Runtime PM enabled plus auto-suspend
> >>>             I3C subsystem runtime PM gets/puts the Platform device
> >>>             Runtime suspend: disable and save state
> >>>             Runtime resume: restore state and enable
> >>>
> >>>     Controller 2    Runtime PM enabled plus auto-suspend
> >>>             I3C subsystem runtime PM gets/puts the Platform device
> >>>             Runtime suspend: disable and save state
> >>>             Runtime resume: restore state and enable
> >>>
> >>> Proposed (this patch set):
> >>>
> >>>     PCI device    Runtime PM enabled plus auto-suspend
> >>>             I3C subsystem runtime PM gets/puts the PCI device
> >>>             For each controller:
> >>>                 Call into mipi-i3c-hci (when it is safe)
> >>>                     Runtime suspend: disable and save state
> >>>                     Runtime resume: restore state and enable
> >>>
> >>>     Controller 1    Runtime PM disabled
> >>>
> >>>     Controller 2    Runtime PM disabled
> >> Controller 1/2 is child device of PCI device.
> >>
> >> So first patch "i3c: master: Allow controller drivers to select runtim=
e PM device"
> >> is not necessary.
> >>
> >> You can enable controller 1 and 2 Runtime PM with dummy operation.
> >>
> >> When controller 1 run time suspend, parent PCI device will reduce ref =
counter
> >> when controller 2 run time suspend, parent PCI device will reduce ref =
counter
> >>
> >> Only runtime pm reference counter of PCI device is 0, PCI device's run=
 time
> >> suspend will be called, you can do actual disable and save work.
> >
> > This sounds to me like it should work.
> So, like this, then?
>
>         PCI device      Runtime PM enabled
>                         For each controller:
>                                 Call into mipi-i3c-hci (when it is safe)
>                                         Runtime suspend: disable and save=
 state
>                                         Runtime resume: restore state and=
 enable
>
>         Controller 1    Runtime PM enabled plus auto-suspend
>                         I3C subsystem runtime PM gets/puts the Platform d=
evice
>                         Runtime suspend: does nothing
>                         Runtime resume: does nothing
>
>         Controller 2    Runtime PM enabled plus auto-suspend
>                         I3C subsystem runtime PM gets/puts the Platform d=
evice
>                         Runtime suspend: does nothing
>                         Runtime resume: does nothing

I would think so.

