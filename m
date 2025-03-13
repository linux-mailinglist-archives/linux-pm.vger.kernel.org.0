Return-Path: <linux-pm+bounces-24000-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F1DA602EB
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 21:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E34B519C5CD5
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 20:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B521F3FF1;
	Thu, 13 Mar 2025 20:45:16 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B241F4639
	for <linux-pm@vger.kernel.org>; Thu, 13 Mar 2025 20:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741898716; cv=none; b=E8TsGakS1DNqcbmM3EeNBkY05iupp0xJf2RRFZLb+cFRV4TOCvRkr/qwkkJ8s4qTncYywyJA4EOjdXjsGq5x2xNnNc7Lce8t+3nwx9npaUnC1x+gQBosGntj5K0zMbwdjW5272La9z7V2L7INqAFzEx+8HHxJEEEFA5XoMA5LhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741898716; c=relaxed/simple;
	bh=Y5U+DOgetnHn658ydyXuPCdleyJixOYV6KFAnIkCuKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cXJ6XRkr4MOypnzq6yyUfLuaRjiOniS7flwXQbMYoZpgG2SffyK7pfwD1G2N8ZjCKYAyQ6rSmMpXc3YnczeE6l7uQ1oU3hIzn+VpCFFS7RCRkPQZmc7Ew+1nqcDde6s1ThNXSE0v9TFOprM3sEFmVDHBE3s2zpxD4dNivL1PJQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 05A27100B07A9;
	Thu, 13 Mar 2025 21:45:04 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id B773E1748B0; Thu, 13 Mar 2025 21:45:03 +0100 (CET)
Date: Thu, 13 Mar 2025 21:45:03 +0100
From: Lukas Wunner <lukas@wunner.de>
To: James Dutton <james.dutton@gmail.com>
Cc: Linux PM mailing list <linux-pm@vger.kernel.org>
Subject: Re: USB4 thunderbolt device suspend/resume problems. Unplug during
 suspend.
Message-ID: <Z9NDz7TUIEflQeee@wunner.de>
References: <CAAMvbhGRBhdz2RnReoGxDRM=bTws6s4qe5kh2nUqQDMRDYBh6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAMvbhGRBhdz2RnReoGxDRM=bTws6s4qe5kh2nUqQDMRDYBh6Q@mail.gmail.com>

On Mon, Feb 17, 2025 at 08:44:19PM +0000, James Dutton wrote:
> I have a thunderbolt / usb4 10Gbps ethernet adapter.
> While plugged in, it appears to handle suspend and resume OK.
> The problem is the following:
> 1) Thunderbolt device plugged in. Device appears in "lscpi".
> 2) Suspend Laptop
> 3) Unplug the device while it is asleep.
> 4) Resume the Laptop
> 5) Laptop locks up, no stack trace, nothing output.

There's a fix for a similar issue queued up for v6.15-rc1 in pci.git:

https://git.kernel.org/pci/pci/c/876d4518a87d

Does it help if you apply that small change?

It should get backported to v6.14 and v6.12 stable kernels once
v6.15-rc1 is tagged.

Thanks,

Lukas

