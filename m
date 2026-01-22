Return-Path: <linux-pm+bounces-41326-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCMsHYF1cmlpkwAAu9opvQ
	(envelope-from <linux-pm+bounces-41326-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 20:07:45 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC036CE5F
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 20:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA2043002F87
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jan 2026 19:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EEB38B9A2;
	Thu, 22 Jan 2026 19:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTpNiTiC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1E9306B02;
	Thu, 22 Jan 2026 19:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769108813; cv=none; b=jP5Rz35PW6D+ItegrUrA3/z5R1TYWci/fuTgGd2jR3YwgsHARtnB2rNlGfajMdzPpCvhJYL1gdOJHmNiwBRGJAAm503zCQyzQyL5xW3ConkStFBT6nc59i1Xmz6g3FNd2ObFKmgfeWpGUlSYiYhLjHU10LPnJWm0hR5DuHETCt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769108813; c=relaxed/simple;
	bh=/P9jqTO2yxhg/1I6etBD3tzFEkg//jgh7lCeOUjZPWg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=J3a0mWg7xW/5xGhJkks26nbIQ3HelaL2Mn53l3mZVVmYd7tHNF1gvkPVMieVIUvEQbOgFeeo0L7ZH+K9IPjYKvxG32jkmvGKiYESlOfqUV8WjNF+PhqdK9EHOuUR2ihQNpDfIIUxdO5Dj1izI3tCIU0LFQpe0SW58jpJEf9w0s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTpNiTiC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3D7C116C6;
	Thu, 22 Jan 2026 19:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769108809;
	bh=/P9jqTO2yxhg/1I6etBD3tzFEkg//jgh7lCeOUjZPWg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=XTpNiTiCCFR8AJs11GeuoQCP8AgB4TCbMZAfyM9s3sl44LCeJEZ9rean02G3SwUsH
	 3q7Oiejjo33k3G8EOSu2xq5E3QLHpNvV0UdUASuG+p4Kw4ma4eolap3q+pRwhtJm/P
	 jEt0N0dk8IeALmuWssLZRSgbrskXkPy6OjebZpAa9tT0+qDNJBKxTCWdJs6sSPArRw
	 MDsEZvFh8bs1+4sGN98q4QHnKEJRMjsXGhxrxqprDiuAiYKDXqRU0p6xVroAOzLkNn
	 rYXM68OE7YMZlcjwE3c7qbYBW3UupZP2nl3FcJT8uGXgZnB3EmzgNgasN5rGn2bXa+
	 k+q2S/gmIxyvQ==
Date: Thu, 22 Jan 2026 13:06:48 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
	linux-pm@vger.kernel.org,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v5] PCI/PM: Prevent runtime suspend until devices are
 fully initialized
Message-ID: <20260122190648.GA37646@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXJsnh4HeiQ2oOBl@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41326-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,chromium.org:email]
X-Rspamd-Queue-Id: BAC036CE5F
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 10:29:50AM -0800, Brian Norris wrote:
> On Thu, Jan 22, 2026 at 07:17:21PM +0100, Rafael J. Wysocki wrote:
> > On Thu, Jan 22, 2026 at 6:49 PM Brian Norris <briannorris@chromium.org> wrote:

> > > @@ -379,6 +380,12 @@ void pci_bus_add_device(struct pci_dev *dev)
> > >                 put_device(&pdev->dev);
> > >         }
> > >
> > > +       /*
> > > +        * Enable runtime PM (and potentially suspend) only after we've fully
> > > +        * configured the PCI state.
> > > +        */
> > 
> > I would make it a bit more precise, something like "Enable runtime PM,
> > which potentially allows the device to suspend immediately, only after
> > the PCI state has been configured completely."

> > > @@ -3196,8 +3196,11 @@ void pci_pm_init(struct pci_dev *dev)
> > >  poweron:
> > >         pci_pm_power_up_and_verify_state(dev);
> > >         pm_runtime_forbid(&dev->dev);
> > > +       /*
> > > +        * Mark ourselves active now, to prevent our parent from suspending
> > > +        * while we finish configuring the PCI device.
> > > +        */
> > 
> > I would rephrase the comment this way:
> > 
> > "Runtime PM will be enabled for the device when it has been fully
> > configured, but since its parent and suppliers may suspend in the
> > meantime, prevent them from doing so by changing the device's runtime
> > PM status to "active"."

Updated both, thanks to both of you!

