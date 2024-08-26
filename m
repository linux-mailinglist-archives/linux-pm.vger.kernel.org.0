Return-Path: <linux-pm+bounces-12907-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C85AB95FABD
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 22:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B268280D92
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 20:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB8B199396;
	Mon, 26 Aug 2024 20:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eFN7TNmr"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773D318D65C;
	Mon, 26 Aug 2024 20:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724704795; cv=none; b=tz+54S+k2RrOO7LMYeXdrMDtOaXg8EJRUchdSh88lC8vsvD7F0+PpXb+uddCJFDJ4ewidgf/Y8kO9w+eMeov2M1BRTpVSEVRTWCsAzR6RRFlAntn1fgjfqqhr7wc/8hXdMDX6ZgAM21kIN7Esb7cCA5Bjov8MFQV4grXpvcrLTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724704795; c=relaxed/simple;
	bh=ueVOO8RbZQY2FSZBOZSaceKGAJ1QJCEei8KAE0hphNU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qMomDLX1md8mS5+qHvcH7WdSlL+khsJBWGEkqOzRjuCZ9TWdVZVuelR6QTlt9ndaxDP510AFsq6WrGIl4tgrjtth1R8klr50AXa4sy6uyEnyFRHVF+42yOq/9VhlIs5zjmMVHFpg37IanSfufZjUr/lqrnCZf9DnHsjsTHYWJhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eFN7TNmr; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724704793; x=1756240793;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=ueVOO8RbZQY2FSZBOZSaceKGAJ1QJCEei8KAE0hphNU=;
  b=eFN7TNmrcY3RHOdnsy60u6OurafdnEU3NqMPStP3Yjfgw6J1PHS7NyaF
   MDLz41Vi2xvpgLSMNGk6i82RSAHUxk1Ldd3qudPtacKQ3Q05dmN2j6Jq1
   w+k6SjgM1j4hbIj/KlJ+gl3c80ypFrMpD6vGs+mTRx/Tr2xjZxy0fGeHo
   yFxQRgYL2R9JM+GwiIiyrOLP93jwsEAfjvDzA52DdY9pJ53UUEvv4SC7w
   ziwBlo93Vwxk3WaAHgdtThq02m6P9e4D2Bbvy+80VHalmwKBFNHRm0vm3
   aASkPvAUt7IkvOpLkmexuGY+RwqzuMIN9cLC2qZogL197CIyrPij1zaZP
   g==;
X-CSE-ConnectionGUID: 6qusrx8mS12WJv6HWYHIuQ==
X-CSE-MsgGUID: SkOTDwbqSK+I2fwWModjxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="45669910"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="45669910"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 13:39:53 -0700
X-CSE-ConnectionGUID: YNsmcnObTtCBhboG+EMVaQ==
X-CSE-MsgGUID: L/3qT+tkTs2PL2iM1ZSm1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="67529886"
Received: from dgramcko-desk.amr.corp.intel.com ([10.124.223.43])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 13:39:53 -0700
Message-ID: <b327d0eababdde3224c6c466ce1819888389a9e3.camel@linux.intel.com>
Subject: Re: [PATCH] pm-graph: Update directory handling and installation
 process in Makefile
From: Todd Brandt <todd.e.brandt@linux.intel.com>
Reply-To: todd.e.brandt@linux.intel.com
To: Amit Vadhavana <av2082000@gmail.com>, skhan@linuxfoundation.org, 
	ricardo@marliere.net
Cc: linux-kernel-mentees@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 26 Aug 2024 13:39:52 -0700
In-Reply-To: <20240825110620.30109-1-av2082000@gmail.com>
References: <20240825110620.30109-1-av2082000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-08-25 at 16:36 +0530, Amit Vadhavana wrote:
> - Standardize directory variables to support more flexible
> installations.
> - Add copyright and licensing information to the Makefile.
> - Introduce ".PHONY" declarations to ensure that specific targets are
> always
> =C2=A0 executed, regardless of the presence of files with matching names.
> - Add a help target to provide usage instructions.
>=20
> Signed-off-by: Amit Vadhavana <av2082000@gmail.com>
> ---
> =C2=A0tools/power/pm-graph/Makefile | 111 ++++++++++++++++++++++---------=
-
> --
> =C2=A01 file changed, 73 insertions(+), 38 deletions(-)
>=20
> diff --git a/tools/power/pm-graph/Makefile b/tools/power/pm-
> graph/Makefile
> index b5310832c19c..aeddbaf2d4c4 100644
> --- a/tools/power/pm-graph/Makefile
> +++ b/tools/power/pm-graph/Makefile
> @@ -1,51 +1,86 @@
> =C2=A0# SPDX-License-Identifier: GPL-2.0
> -PREFIX=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0?=3D /usr
> -DESTDIR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0?=3D
> +#
> +# Copyright (c) 2013, Intel Corporation.
> +#
> +# This program is free software; you can redistribute it and/or
> modify it
> +# under the terms and conditions of the GNU General Public License,
> +# version 2, as published by the Free Software Foundation.
> +#
> +# This program is distributed in the hope it will be useful, but
> WITHOUT
> +# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
> or
> +# FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the GNU General Public
> License for
> +# more details.
> +#
> +# Authors:
> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Todd Brandt <todd.e.brandt@linux.i=
ntel.com>
> +
> +# Prefix to the directories we're installing to
> +DESTDIR ?=3D
> +
> +# Directory definitions. These are default and most probably
> +# do not need to be changed. Please note that DESTDIR is
> +# added in front of any of them
> +
> +BINDIR ?=3D=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/usr/bin
> +MANDIR ?=3D=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/usr/share/man
> +LIBDIR ?=3D=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/usr/lib
> +
> +# Toolchain: what tools do we use, and what options do they need:
> +INSTALL =3D /usr/bin/install
> +INSTALL_DATA=C2=A0 =3D ${INSTALL} -m 644
> =C2=A0
> =C2=A0all:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0@echo "Nothing to build"
> =C2=A0
> =C2=A0install : uninstall
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0install -d=C2=A0 $(DESTDIR)$(P=
REFIX)/lib/pm-graph
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0install sleepgraph.py $(DESTDI=
R)$(PREFIX)/lib/pm-graph
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0install bootgraph.py $(DESTDIR=
)$(PREFIX)/lib/pm-graph
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0install -d=C2=A0 $(DESTDIR)$(P=
REFIX)/lib/pm-graph/config
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0install -m 644 config/cgskip.t=
xt $(DESTDIR)$(PREFIX)/lib/pm-
> graph/config
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0install -m 644 config/freeze-c=
allgraph.cfg
> $(DESTDIR)$(PREFIX)/lib/pm-graph/config
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0install -m 644 config/freeze.c=
fg $(DESTDIR)$(PREFIX)/lib/pm-
> graph/config
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0install -m 644 config/freeze-d=
ev.cfg
> $(DESTDIR)$(PREFIX)/lib/pm-graph/config
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0install -m 644 config/standby-=
callgraph.cfg
> $(DESTDIR)$(PREFIX)/lib/pm-graph/config
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0install -m 644 config/standby.=
cfg $(DESTDIR)$(PREFIX)/lib/pm-
> graph/config
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0install -m 644 config/standby-=
dev.cfg
> $(DESTDIR)$(PREFIX)/lib/pm-graph/config
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0install -m 644 config/suspend-=
callgraph.cfg
> $(DESTDIR)$(PREFIX)/lib/pm-graph/config
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0install -m 644 config/suspend.=
cfg $(DESTDIR)$(PREFIX)/lib/pm-
> graph/config
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0install -m 644 config/suspend-=
dev.cfg
> $(DESTDIR)$(PREFIX)/lib/pm-graph/config
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0install -m 644 config/suspend-=
x2-proc.cfg
> $(DESTDIR)$(PREFIX)/lib/pm-graph/config
> -
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0install -d=C2=A0 $(DESTDIR)$(P=
REFIX)/bin
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ln -s ../lib/pm-graph/bootgrap=
h.py
> $(DESTDIR)$(PREFIX)/bin/bootgraph
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ln -s ../lib/pm-graph/sleepgra=
ph.py
> $(DESTDIR)$(PREFIX)/bin/sleepgraph
> -
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0install -d=C2=A0 $(DESTDIR)$(P=
REFIX)/share/man/man8
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0install bootgraph.8 $(DESTDIR)=
$(PREFIX)/share/man/man8
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0install sleepgraph.8 $(DESTDIR=
)$(PREFIX)/share/man/man8
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0$(INSTALL) -d=C2=A0 $(DESTDIR)=
$(LIBDIR)/pm-graph
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0$(INSTALL) sleepgraph.py $(DES=
TDIR)$(LIBDIR)/pm-graph
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0$(INSTALL) bootgraph.py $(DEST=
DIR)$(LIBDIR)/pm-graph
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0$(INSTALL) -d=C2=A0 $(DESTDIR)=
$(LIBDIR)/pm-graph/config
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0$(INSTALL_DATA) config/cgskip.=
txt $(DESTDIR)$(LIBDIR)/pm-
> graph/config
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0$(INSTALL_DATA) config/freeze-=
callgraph.cfg
> $(DESTDIR)$(LIBDIR)/pm-graph/config
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0$(INSTALL_DATA) config/freeze.=
cfg $(DESTDIR)$(LIBDIR)/pm-
> graph/config
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0$(INSTALL_DATA) config/freeze-=
dev.cfg $(DESTDIR)$(LIBDIR)/pm-
> graph/config
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0$(INSTALL_DATA) config/standby=
-callgraph.cfg
> $(DESTDIR)$(LIBDIR)/pm-graph/config
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0$(INSTALL_DATA) config/standby=
.cfg $(DESTDIR)$(LIBDIR)/pm-
> graph/config
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0$(INSTALL_DATA) config/standby=
-dev.cfg
> $(DESTDIR)$(LIBDIR)/pm-graph/config
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0$(INSTALL_DATA) config/suspend=
-callgraph.cfg
> $(DESTDIR)$(LIBDIR)/pm-graph/config
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0$(INSTALL_DATA) config/suspend=
.cfg $(DESTDIR)$(LIBDIR)/pm-
> graph/config
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0$(INSTALL_DATA) config/suspend=
-dev.cfg
> $(DESTDIR)$(LIBDIR)/pm-graph/config
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0$(INSTALL_DATA) config/suspend=
-x2-proc.cfg
> $(DESTDIR)$(LIBDIR)/pm-graph/config
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0$(INSTALL) -d=C2=A0 $(DESTDIR)=
$(BINDIR)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ln -s ../lib/pm-graph/bootgrap=
h.py
> $(DESTDIR)$(BINDIR)/bootgraph
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ln -s ../lib/pm-graph/sleepgra=
ph.py
> $(DESTDIR)$(BINDIR)/sleepgraph
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0$(INSTALL) -d=C2=A0 $(DESTDIR)=
$(MANDIR)/man8
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0$(INSTALL) bootgraph.8 $(DESTD=
IR)$(MANDIR)/man8
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0$(INSTALL) sleepgraph.8 $(DEST=
DIR)$(MANDIR)/man8
> =C2=A0
> =C2=A0uninstall :
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rm -f $(DESTDIR)$(PREFIX)/shar=
e/man/man8/bootgraph.8
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rm -f $(DESTDIR)$(PREFIX)/shar=
e/man/man8/sleepgraph.8
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rm -f $(DESTDIR)$(MANDIR)/man8=
/bootgraph.8
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rm -f $(DESTDIR)$(MANDIR)/man8=
/sleepgraph.8
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rm -f $(DESTDIR)$(PREFIX)/bin/=
bootgraph
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rm -f $(DESTDIR)$(PREFIX)/bin/=
sleepgraph
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rm -f $(DESTDIR)$(BINDIR)/boot=
graph
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rm -f $(DESTDIR)$(BINDIR)/slee=
pgraph
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rm -f $(DESTDIR)$(PREFIX)/lib/=
pm-graph/config/*
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if [ -d $(DESTDIR)$(PREFIX)/li=
b/pm-graph/config ] ; then \
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0rmdir $(DESTDIR)$(PREFIX)/lib/pm-graph/config; \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rm -f $(DESTDIR)$(LIBDIR)/pm-g=
raph/config/*
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if [ -d $(DESTDIR)$(LIBDIR)/pm=
-graph/config ] ; then \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0rmdir $(DESTDIR)$(LIBDIR)/pm-graph/config; \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rm -f $(DESTDIR)$(PREFIX)/lib/=
pm-graph/__pycache__/*
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if [ -d $(DESTDIR)$(PREFIX)/li=
b/pm-graph/__pycache__ ] ; then
> \
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0rmdir $(DESTDIR)$(PREFIX)/lib/pm-graph/__pycache__; \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rm -f $(DESTDIR)$(LIBDIR)/pm-g=
raph/__pycache__/*
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if [ -d $(DESTDIR)$(LIBDIR)/pm=
-graph/__pycache__ ] ; then \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0rmdir $(DESTDIR)$(LIBDIR)/pm-graph/__pycache__; \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rm -f $(DESTDIR)$(PREFIX)/lib/=
pm-graph/*
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if [ -d $(DESTDIR)$(PREFIX)/li=
b/pm-graph ] ; then \
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0rmdir $(DESTDIR)$(PREFIX)/lib/pm-graph; \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rm -f $(DESTDIR)$(LIBDIR)/pm-g=
raph/*
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if [ -d $(DESTDIR)$(LIBDIR)/pm=
-graph ] ; then \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0rmdir $(DESTDIR)$(LIBDIR)/pm-graph; \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi;
> +
> +help:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0@echo=C2=A0 'Building targets:=
'
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0@echo=C2=A0 '=C2=A0 all=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Nothin=
g to build'
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0@echo=C2=A0 '=C2=A0 install=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Install the program and cre=
ate
> necessary directories'
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0@echo=C2=A0 '=C2=A0 uninstall=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Remove installed files and
> directories'
> +
> +.PHONY: all install uninstall help
This does look much nicer, and it's good to use the absolute path of
install in case the system doesn't have the PATH setup. Thank you for
cleaning this up!

Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>

