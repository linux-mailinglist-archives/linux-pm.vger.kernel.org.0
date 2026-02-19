Return-Path: <linux-pm+bounces-42868-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIMHMZHvlmngrAIAu9opvQ
	(envelope-from <linux-pm+bounces-42868-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 12:10:09 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADFE15E2CC
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 12:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 95055300A312
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 11:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28EB33D6ED;
	Thu, 19 Feb 2026 11:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muHXkXDW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2E933D6C9
	for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2026 11:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771499406; cv=none; b=rv0t5iSvc3ZlXlcc/fMJcl9YHAz5THUljjxjyXJR11XTfRIANFUkTaLyyHarv5koTGLm5YcG5arUoq4WlR/934oVGaqbijnDh0TuysF55Dr77vfglMcDL2njqcSQQXxEtFTdPX3zGnA5ONrVGSIpbrMkEM9tqoMUFOC3/BwPhIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771499406; c=relaxed/simple;
	bh=jdHXiG+Zjon1kIoMLTsKMp9qCqagjcDQtQe0UL1HCxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fIqoYXqVx/nKI7Su5kzHhf3CxFEqJu6NJwv6zs+tMH2rEeaxonj3y8UejH6jOhFWWzIjmEx0f1CMLDxFzrVIGSnzVgOtPF24ksMi9W6FQw2tE6aZgvsDHUe7K32+aYXiwRD+6rAT01OaIXYgHKMijV+c9nqh9JpUzUXWLZyiiWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muHXkXDW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4B7C19424
	for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2026 11:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771499406;
	bh=jdHXiG+Zjon1kIoMLTsKMp9qCqagjcDQtQe0UL1HCxU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=muHXkXDW6OzSnp0MtREQQ44AdWCsmSUDMSt5m7zXRMWUkHnxJy2f1/rQgwRPGC/N4
	 dr3oXZ3H8jg65k3tgEkh4OEP32QP1UqDZzYDPpGQQJZrZz4QUc4LUX6spinTwsBQN/
	 ds/BQM2DVEjCwSPt7dUJb/cMGip48V/scRGFtN4StxXm0GtDOoWYPbZcckew7+ad9Q
	 IsmwEfniC/tVSzAHkN9mTdWksDu5lU81mOcwOyobS8uXQ5gYlJ1Va+k1iPJl5drNTo
	 2bkUzLJzoOPD4563xuGO+3eHnxlSWoig+39bJ+hbSqu/d7wWf6TDNWfutJObZqwZIO
	 yCEiL6Pf5r+mw==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-40ee196dd78so516808fac.1
        for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2026 03:10:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXXWRaj91XyPNd+epJcZpCkE0w5pWUQNWLOtXoaQPlpoxFprvhVUQ4ggEaoUGFMOnjZoPwXuVd25A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzjBYkvK4nvLF2ETaPNE+kaHa6vbxxMbeIW8Zzk4n6+ZFltDYk
	D9WmVEIIVPs57n3BjTK+uhU43jmoyuiObwgcQKgI9EfLDjX50oXkeSKrNlGkEjGvCBiTRVmKtwx
	VSCIpDqiEBkQmn882rAT94EKkRhX/UE4=
X-Received: by 2002:a05:6871:2b20:b0:409:62ce:83f6 with SMTP id
 586e51a60fabf-4154539f5a3mr795303fac.5.1771499405213; Thu, 19 Feb 2026
 03:10:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213231428.613164-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <9b639ed0-1765-4cca-814e-18a1260e01b9@linux.intel.com> <CAJZ5v0iaKU6QJ7sxYCS21H0fv99DBNny-_bXzKH4g8RXgFuN6w@mail.gmail.com>
 <7b4dd756-2ab7-4331-b560-268f9cff0887@linux.intel.com> <CAJZ5v0gcZ5vs4WcS0GhvQrG9Kf05LNrNfd+oXz3WDdCA0xGjjw@mail.gmail.com>
 <aZbEDldZxV1KG_5B@wunner.de>
In-Reply-To: <aZbEDldZxV1KG_5B@wunner.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 19 Feb 2026 12:09:52 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gF244JC5C9pLqmzxUuQkxMOXXBf92ckTKfeo9n8wgb1w@mail.gmail.com>
X-Gm-Features: AaiRm527QJf5y11Cuo8LtYdIEYVrrNAUXYnydvlX1VYcNxGiGxAQYCgufHCg68c
Message-ID: <CAJZ5v0gF244JC5C9pLqmzxUuQkxMOXXBf92ckTKfeo9n8wgb1w@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: pciehp: Fix hotplug on Catlow Lake with
 unreliable PME status
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42868-lists,linux-pm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,wunner.de:email]
X-Rspamd-Queue-Id: 6ADFE15E2CC
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 9:04=E2=80=AFAM Lukas Wunner <lukas@wunner.de> wrot=
e:
>
> On Wed, Feb 18, 2026 at 06:33:15PM +0100, Rafael J. Wysocki wrote:
> > First, keeping the ports in D0 may gate runtime PC10.  Does it not?
>
> The Root Port in question is on the PCH.  I'm not sure, does keeping a
> PCH Root Port in D0 also prevent PC10 entry or is that only the case
> for Root Ports on the CPU die/tile?

If it is located in the PCH, it should not gate PC10 if in D0 at least
in theory, but it would be good to verify that.

Of course, it will still gate S0ix entry through runtime idle, but
that's a bit moot if the platform is unable to enter S0ix through
runtime idle anyway for other reasons (which is quite likely), or if
the power difference between S0ix and PC10 is small.

> If this does cause a power regression, the pme_is_broken() approach
> suggested upthread might be a viable alternative.  It'll allow the
> Root Port to go to D3hot but will keep interrupts enabled in the
> Slot Control register.

Sounds reasonable to me.

