Return-Path: <linux-pm+bounces-43070-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UC+PD2CznGnsJwQAu9opvQ
	(envelope-from <linux-pm+bounces-43070-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 21:06:56 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A805317CB99
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 21:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C763313535B
	for <lists+linux-pm@lfdr.de>; Mon, 23 Feb 2026 20:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0AA376BC2;
	Mon, 23 Feb 2026 20:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8NCt8LA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A92537649D
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 20:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771876993; cv=none; b=k7bFKfbQ4SrCk6M3H/Ost/G10ht436BxKQfWDgqRqmKbXH3H7J2i999Pl0FL9PLuZVyJqJkMPoOfLXO//lV6ZlKjqPFoZrZSdhXeKz96p/qdzKq2iXfsp9EkSpLU98SkwEOqruqm8STVw3rG6qmY3IwXEwnjJ+9iYgGQqAuF9fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771876993; c=relaxed/simple;
	bh=JBhOcyNghPQnyLeqt4d+gn4z6mbPuf4O77nqGdBnWZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WDA0fHCT0+QeTdz+wYFEPwKyKOsv2e9FGSklsaLUAShUC/O/Dc406ZnhRxgNX/FML67mWqv+kcQeXTT29OPwMZiQBChF/cCqdTQl4ewuR/wzjT8/E9nwxbE71/QvYrXvzq/CrIA8FfbEuugvNDXk4fahgyJS5oFI7KOq1Io+0cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8NCt8LA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C964BC2BCB2
	for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 20:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771876992;
	bh=JBhOcyNghPQnyLeqt4d+gn4z6mbPuf4O77nqGdBnWZs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Y8NCt8LAVnc0fbhRneGkNB1037xboOU/bLB7M7bbAQh2oLQ+SLsY7k4Bw9TGV0/b8
	 P1bzud//oT1dhKXG+aIzV1cIWYeZmt36GZszk5pEhqO8u8SHChut/2qccJxtk4d7up
	 5rPqkUTH0Goe0PH6fyi0Lji0Wdyb8AZTV4JLE+ErQHB3jQn0QfrzEOx7YzaP2aAJOz
	 Fn205da8dhwryiZCDsERBy3sZfFcszk7cCOmpxivSQQGSQVV+Eo/1ZIOs07AP0jiyh
	 Nknfbsq73UupsR9/tjgClbiUAwtPlmhzCNPORHgAGR0C8mFrkP98CGQ4jWjRckvddg
	 mE70jldWC/VRg==
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d18f80b5c2so4012495a34.3
        for <linux-pm@vger.kernel.org>; Mon, 23 Feb 2026 12:03:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX0fqlwhpgdj+xav/91v7XSu1FcJcDrctEbT61miyaau9w6GtygU0LrBLMXgjDALpoNUwYlYZljfA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyBFvKSGHV+kipmuLd/5sCwtkgfryOU7NpsMyYi9GySsPxgocYY
	+T2EG4MikrMRrqZChmKOzF2NWsy9MwEnIuH/kfrKSksnroi0xxhFvMg3dMrfbo7wJ/MErSPsmEH
	UBT16f2gYGZcnD3yXMQS0PsAOyqjTUGY=
X-Received: by 2002:a05:6820:160f:b0:679:2797:7a0f with SMTP id
 006d021491bc7-679c44e39dbmr4828682eaf.45.1771876991832; Mon, 23 Feb 2026
 12:03:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0h8dQ10oH4KQM8Pdv0jvXyTE6yD1fn5eBPkS_jDYgA8gQ@mail.gmail.com>
 <20260223195508.GA3703404@bhelgaas>
In-Reply-To: <20260223195508.GA3703404@bhelgaas>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 23 Feb 2026 21:03:00 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0haUg8VtzfQ4U8PV2ww2NDHx8jbL9HTer3P6jJe+mfr7w@mail.gmail.com>
X-Gm-Features: AaiRm522tekkYjnNwAaBXy4xZO6OyIG3-2vg_uzvGJPeWrFp-lyBHkYh-K_XrN4
Message-ID: <CAJZ5v0haUg8VtzfQ4U8PV2ww2NDHx8jbL9HTer3P6jJe+mfr7w@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] PCI: host-common: Add helper to determine host
 bridge D3cold eligibility
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Will Deacon <will@kernel.org>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	jonathanh@nvidia.com, bjorn.andersson@oss.qualcomm.com, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43070-lists,linux-pm=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,gmail.com,google.com,vger.kernel.org,lists.infradead.org,nvidia.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A805317CB99
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 8:55=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Mon, Feb 23, 2026 at 07:46:08PM +0100, Rafael J. Wysocki wrote:
> > On Mon, Feb 23, 2026 at 7:10=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.o=
rg> wrote:
> > > On Tue, Feb 17, 2026 at 04:49:06PM +0530, Krishna Chaitanya Chundru w=
rote:
> > > > Add a common helper, pci_host_common_can_enter_d3cold(), to determi=
ne
> > > > whether a PCI host bridge can safely transition to D3cold.
> > > >
> > > > This helper is intended to be used by PCI host controller drivers t=
o
> > > > decide whether they may safely put the host bridge into D3cold base=
d on
> > > > the power state and wakeup capabilities of downstream endpoints.
> > > >
> > > > The helper walks all devices on the bridge's primary bus and only a=
llows
> > > > the host bridge to enter D3cold if all PCIe endpoints are already i=
n
> > > > PCI_D3hot. This ensures that we do not power off the host bridge wh=
ile
> > > > any active endpoint still requires the link to remain powered.
> > > >
> > > > For devices that may wake the system, the helper additionally requi=
res
> > > > that the device supports PME wake from D3cold (via WAKE#). Devices =
that
> > > > do not have wakeup enabled are not restricted by this check and do =
not
> > > > block the host bridge from entering D3cold.
> > > >
> > > > Devices without a bound driver and with PCI not enabled via sysfs a=
re
> > > > treated as inactive and therefore do not prevent the host bridge fr=
om
> > > > entering D3cold. This allows controllers to power down more aggress=
ively
> > > > when there are no actively managed endpoints.
> > >
> > > This series is currently structured so it's only applicable to native
> > > host bridge drivers, i.e., things using DT.  Is there anything that
> > > prevents using D3cold for host bridges in ACPI systems?
> >
> > Do you mean in principle or in practice?
>
> Just in principle.  I was hoping for some way to tie this decision
> making back to a spec.  Everything downstream being in D3 already, and
> any wakeup devices supporting PME from D3cold sounds plausible to me,
> but I don't know about any prescriptive spec language, and I wouldn't
> want to get locked into a scheme that couldn't be supported on ACPI.

In principle, I guess someone might want to add ACPI PM support to a
PCI host bridge device object.

In theory, there may be a problem with message-based PME wakeup unless
the host bridge device has some D3cold aux power, but it at least
seems to be doable.

I think that this question is for non-x86 folks who use ACPI in their
platforms because they may just have this use case.

