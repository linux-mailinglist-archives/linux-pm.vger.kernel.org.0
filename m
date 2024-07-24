Return-Path: <linux-pm+bounces-11356-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2793693ABB0
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2024 05:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC0D328378B
	for <lists+linux-pm@lfdr.de>; Wed, 24 Jul 2024 03:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67FB219FC;
	Wed, 24 Jul 2024 03:58:39 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from utopia.booyaka.com (utopia.booyaka.com [74.50.51.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE203208D7
	for <linux-pm@vger.kernel.org>; Wed, 24 Jul 2024 03:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.51.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721793519; cv=none; b=iw4aQ1887gPqoxk80yRmDYqnIOeOQx8lpZStxRRQwUcfcKijfgFhpQOuQb3yjfwxOG9aPm92a1Vcl9KuUFfwX9gxZMfKdExIirZZlNPZoHOBWNZpMt/63W/1DIhmTBXhhwNvlmAydAJ9y+5LoTqBXogCaBjzSLd4X+ipxhDod3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721793519; c=relaxed/simple;
	bh=79Jh2c+fxWXX/U6oo0VkkZfgcMhV+v6w0FJ2+TfHJx4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=I2wGAbZxomwQ1+v/+1RhjkzOKTLJgANy1N2TJCdb6TQkpEXiXiBRxkNq4fWGywn5rMTg9IEvFqq5Q+ASaQwDDOWOmmt1JJQ7EXHwqPgCzi43s54+eYStEakTlEcOkgUx1O+ibatlDkxcK+vSew3qrBF0kpURkqPXI5pPlqOaz/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pwsan.com; spf=pass smtp.mailfrom=pwsan.com; arc=none smtp.client-ip=74.50.51.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pwsan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pwsan.com
Received: (qmail 13648 invoked by uid 1019); 24 Jul 2024 03:51:14 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Jul 2024 03:51:14 -0000
Date: Wed, 24 Jul 2024 03:51:14 +0000 (UTC)
From: Paul Walmsley <paul@pwsan.com>
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
    linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-mips@vger.kernel.org
Subject: Mourning the loss of Peter De Schrijver
Message-ID: <alpine.DEB.2.21.999.2407240345480.11116@utopia.booyaka.com>
User-Agent: Alpine 2.21.999 (DEB 260 2018-02-26)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

With an unspeakable sense of loss, I must sadly relate that Peter De
Schrijver (also known as p2 or p2mate) passed away two weeks ago.

Peter's overt contributions to the Linux kernel were primarily in
clock and power management on ARM SoCs.  Software he wrote or
co-developed set the foundation for modern Linux power management.
The SoC-specific code he wrote enabled millions of devices, many of
which are still in use today.  An incomplete list includes the Nokia
N900 and N9 Linux smartphones; an innumerable collection of OMAP- and
Tegra-based smartphones, tablets, E-readers, and development boards;
many Nest smart thermostats; and the Nintendo Switch.

Peter was a member of that rare class of engineer whose competence
transcends artificial boundaries.  He would regularly troubleshoot and
solve system-wide engineering problems that spanned the software,
digital hardware, and analog hardware domains.  I have fond
recollections of Peter tracking down an intermittent power
management-related glitch in the OMAP SDRAM controller.  This bug was
serious enough to halt production of devices containing the SoC.  the
SoC vendor itself could not find the bug.  Despite not having access
to the RTL, only being able to observe the problem as a black box,
Peter found it.

Despite his skill, Peter was never self-aggrandizing.  An ideal
collaborator, he was always willing to lend his powerful mind to think
through tricky problems that others, myself included, often struggled
with.

Peter loved the culture of free software.  He was a Debian Developer,
a regular presence at FOSDEM, and attended many demo parties and free
software meetups.  I came to realize that for him, this extended to a
deep philosophical commitment to the importance of transparent
engineering practices to the open societies that many of us still
enjoy.  Engineering system failures in the aerospace and energy fields
were regular topics of conversation.

Peter also knew how to enjoy life beyond engineering.  A evening with
friends at the pub with fine Belgian lambics was sacramental.  He
loved electronic music, loved to dance, and loved nature; and often
combined the three.  His same transcendence of artificial boundaries
in engineering extended to an open-minded approach towards life in
general.  He respected and was grateful for what his ancestors
bequeathed him.  In turn, he shared that pleasure, gratitude, and
knowledge with others.

As for me: I, like many others, have just lost a true and loyal
friend.  Peter was present for me when few others were.  The grief is
tempered with the joy of having known Peter during this lifetime, and
also, knowing the depth of the legacy he leaves behind.

A memorial web page is here: https://www.ingedachten.be/overlijdensberichten/overlijden-detail/12-07-2024/peter-de-schrijver


- - Paul

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElRDoIDdEz9/svf2Kx4+xDQu9KksFAmagehUACgkQx4+xDQu9
KkvyPg/8Drb7gBWg5d//101aORjRsLx1XDMQqdR8E+mo8n00f/NrkEPpdRoW0M/9
dAWFkpscOtQyQmycgEn3necn08CIp8X9zgvcfJmBwPJmFvdfFd9FluNpaAZeGylE
JYtS2rKhV4JRy2xaNrusK6c6kPH/azfUKLC62kNFPvNCFGtyoY9etn77pqj81JZu
PojDkCrL793NDpKW3MG3F8KuiPiCTngKDCboVE+3etwF+PgeDx2BOnEbFg8JNNlZ
3TbyV1ikMn1dv5gpVJDmhFQcLXFm9zA68y44NZ8Q+HWvTZjDPMmYGb8c8FGpytpx
Ko5Qo1sf+A+KX5y3sgRIVirJggDW4XA2WlhnM+YzDdK5E5t4RE+kiI4nIqqPXwm6
i6HNOTvjo00WFWCbqzBmpi245j8yjrPMR7NYFdGZDk1gGJXxRFDBCZNFwSYLOkyC
ZTvr6gzqe1vrMgC3NvU7A/1z3rGVURdWJGPgHGa/BOwxnH2NO+TmBpeBAntoy5Ly
NbKYFckdVlUrTZBarvkXd1BFiw8LtUGw7rQ2aoZ06Ib2UZaZmlDI94ch5HsibkJk
Lu0kACz/l1Ra6NL4+oTo23ElhTXWgS7ah8HDau7WewmuJ26fDUONGNh0maOW5E/3
vtkVrjYTZf6vRGY/tlhQL0sen1Z7C/IGD5oDKCbbkoL3mezNy20=
=GHEo
-----END PGP SIGNATURE-----

