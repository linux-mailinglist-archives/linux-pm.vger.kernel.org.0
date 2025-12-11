Return-Path: <linux-pm+bounces-39444-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BFECB69E7
	for <lists+linux-pm@lfdr.de>; Thu, 11 Dec 2025 18:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 08985300CAFF
	for <lists+linux-pm@lfdr.de>; Thu, 11 Dec 2025 17:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FAB30F922;
	Thu, 11 Dec 2025 17:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1v34x/yT"
X-Original-To: linux-pm@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A0723EAA1;
	Thu, 11 Dec 2025 17:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765472686; cv=none; b=LmjSGJqnSn0+KR2+UFNEoVnzWNfu8F1og46KcAVEpv+PISJajfXo70wQbDrWxr1i1v2Wm1h1JQfS32fthJeVueCevuE9cnd6hKHJ4pUwn5GclHV2fH5P5T4TiZuN06WYCnRJU5Bb5HG83+ycDOoVFni4NpgTkNmhd6DqzlswZIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765472686; c=relaxed/simple;
	bh=qc8Dcat8IfmTLFAzBpY8S8inTi0h7zGf5brO5vjMD9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KcyRTqL+gPCi6tRdKqiP4LYiFimhq+B2iiFLYbT8MOcMtI4szMWEZg17eBYOQz37aYJxnmRz/9h0ktPmr5p9bz24RCWyiR4mskPk+Pklj/suh85FfxUeCyK6Y9t2HBWW1zz9MjlfjBtyBVVbJycsDApaIMiDTObImjWzSjzXehI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1v34x/yT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/8fudvWYx6KnznAMIqnibJkczp9Q9NAQ5IeRxWGxqxk=; b=1v34x/yTRTHj5Wz2e3RaJQBndJ
	84bLYQRVbmNRfkYeEZcd1oCBk0im5aVvDT/ebqIvyPO6L4FGNqYUGjI3WZ9ATyWCa+to7IesEY/tB
	ksfL/ERokFYGpiF/Lx4h7TGEWDr45zFv0kSZFe6vXbklN3n/TUGueLPkZboK7FKICy80=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vTk5p-00GfNK-VM; Thu, 11 Dec 2025 18:04:41 +0100
Date: Thu, 11 Dec 2025 18:04:41 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: Changwoo Min <changwoo@igalia.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org, sched-ext@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Concerns with em.yaml YNL spec
Message-ID: <fc7dede0-30a4-4b37-9d4c-af9e67e762c7@lunn.ch>
References: <CAD4GDZy-aeWsiY=-ATr+Y4PzhMX71DFd_mmdMk4rxn3YG8U5GA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD4GDZy-aeWsiY=-ATr+Y4PzhMX71DFd_mmdMk4rxn3YG8U5GA@mail.gmail.com>

On Thu, Dec 11, 2025 at 03:54:53PM +0000, Donald Hunter wrote:
> Hi,
> 
> I just spotted the new em.yaml YNL spec that got merged in
> bd26631ccdfd ("PM: EM: Add em.yaml and autogen files") as part of [1]
> because it introduced new yamllint reports:
> 
> make -C tools/net/ynl/ lint
> make: Entering directory '/home/donaldh/net-next/tools/net/ynl'
> yamllint ../../../Documentation/netlink/specs
> ../../../Documentation/netlink/specs/em.yaml
>   3:1       warning  missing document start "---"  (document-start)
>   107:13    error    wrong indentation: expected 10 but found 12  (indentation)
> 
> I guess the patch series was never cced to netdev or the YNL
> maintainers so this is my first opportunity to review it.

Maybe submit a patch to this:

YAML NETLINK (YNL)
M:      Donald Hunter <donald.hunter@gmail.com>
M:      Jakub Kicinski <kuba@kernel.org>
F:      Documentation/netlink/
F:      Documentation/userspace-api/netlink/intro-specs.rst
F:      Documentation/userspace-api/netlink/specs.rst
F:      tools/net/ynl/

adding

F:	Documentation/netlink/specs

I'm also surprised there is no L: line in the entry.

	Andrew

