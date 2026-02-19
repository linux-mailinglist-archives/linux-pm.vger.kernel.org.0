Return-Path: <linux-pm+bounces-42859-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eA3fDh7ElmnjmAIAu9opvQ
	(envelope-from <linux-pm+bounces-42859-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 09:04:46 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7A215CEAC
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 09:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 830103027685
	for <lists+linux-pm@lfdr.de>; Thu, 19 Feb 2026 08:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF00E332EBC;
	Thu, 19 Feb 2026 08:04:42 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B372FA0DF;
	Thu, 19 Feb 2026 08:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771488282; cv=none; b=eE5UzhOmp0NC3GT6DWQF+cmFelVw2iqt1LlQNdbgDYnDdpzsTslxw83wGSbl0pOpD/ElPRwqlCf38vShqaCf0N5Vz/MVaRjBneTxsSk/JMg9R2ATI6oQH8IajbYJe0/o/RKdJjpnTIwOFeb0Z+3c6RN7ThVLBqy/lM7hWULU75Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771488282; c=relaxed/simple;
	bh=KENZGoGHKiImavRPgS9WMN9g1zcbTQmt4gksF5UhIxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kf8J7bucli+8qSuZfLVib63QPqdersQz5+irBx2OqzxU6dEL8+6FH+SuwhWhW9ABvcEfkmasMpZP4NIX/Ad5D+z7B+sfGy312wW7KckqShr3tq1EE2QW2C0HMRuW2o00is45pq0QtJSu2Y9UM/p7t25B9R0owaypF117Pr6BIMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id C010A2020231;
	Thu, 19 Feb 2026 09:04:30 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id AB74E4B2DA; Thu, 19 Feb 2026 09:04:30 +0100 (CET)
Date: Thu, 19 Feb 2026 09:04:30 +0100
From: Lukas Wunner <lukas@wunner.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] PCI: pciehp: Fix hotplug on Catlow Lake with
 unreliable PME status
Message-ID: <aZbEDldZxV1KG_5B@wunner.de>
References: <20260213231428.613164-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <9b639ed0-1765-4cca-814e-18a1260e01b9@linux.intel.com>
 <CAJZ5v0iaKU6QJ7sxYCS21H0fv99DBNny-_bXzKH4g8RXgFuN6w@mail.gmail.com>
 <7b4dd756-2ab7-4331-b560-268f9cff0887@linux.intel.com>
 <CAJZ5v0gcZ5vs4WcS0GhvQrG9Kf05LNrNfd+oXz3WDdCA0xGjjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gcZ5vs4WcS0GhvQrG9Kf05LNrNfd+oXz3WDdCA0xGjjw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42859-lists,linux-pm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[wunner.de: no valid DMARC record];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukas@wunner.de,linux-pm@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.969];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CF7A215CEAC
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 06:33:15PM +0100, Rafael J. Wysocki wrote:
> First, keeping the ports in D0 may gate runtime PC10.  Does it not?

The Root Port in question is on the PCH.  I'm not sure, does keeping a
PCH Root Port in D0 also prevent PC10 entry or is that only the case
for Root Ports on the CPU die/tile?

If this does cause a power regression, the pme_is_broken() approach
suggested upthread might be a viable alternative.  It'll allow the
Root Port to go to D3hot but will keep interrupts enabled in the
Slot Control register.

Thanks,

Lukas

