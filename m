Return-Path: <linux-pm+bounces-39445-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6E6CB69FC
	for <lists+linux-pm@lfdr.de>; Thu, 11 Dec 2025 18:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E45BA3007614
	for <lists+linux-pm@lfdr.de>; Thu, 11 Dec 2025 17:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73997313541;
	Thu, 11 Dec 2025 17:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q79214zR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB3A248F6A
	for <linux-pm@vger.kernel.org>; Thu, 11 Dec 2025 17:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765472964; cv=none; b=WzR3YLaM5kJXFYlNjsfZlo8F30mrYtXvDs5WExt53NAI8z+5NWBKrLh2UOE2fz48XEAt2CTruELZCyM4A7a0feL0Sx8LtH8TKsKjncdjK/zlLM4p3b6lYdsyrSW3S0Gfz/P+mvHpfrL49E+lumedbjUJZ6uR4DJ+zx+VhkaFe8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765472964; c=relaxed/simple;
	bh=dh/HDIXzktuGWQSITg9LVH40sJ2hdSzo5/AZggWSBpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zn0Wk1piE03rMGep/kJeJ59lwLv2HXvDWko0su1+yokrg30oByzv4vVQnol0hsQtRgZI9tAFLdnlP+hhUBUWdYcXeHZXLPAAOq/yGwjy5EjSaNVcQvtyWjUpzCzPI5kuexVzreDPoDaDOjyaoCcvQ/iYOcHLJEvMFUbqohsW3wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q79214zR; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4511f736011so215362b6e.0
        for <linux-pm@vger.kernel.org>; Thu, 11 Dec 2025 09:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765472962; x=1766077762; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FW2VUCo7IK1n+Kn8KgoCJTzuM+/Fk/IPBhEby/pihF0=;
        b=Q79214zRLQTrtfy55PB9mcNpTTY5Uczwi11HN0wq2jDJLMAOtaT17KrTtAgo25jRJ3
         o7jPIS30D72tS7kcINTJJ0pQbj/aDjisRzyRiWAko3upbUAHGu0shiXoMOfak4t1Te3y
         TaqKY+2RQi+HiA9l/G0F9Lv7TFPgHl2pQD/msiiLOdVOH7cMlObeVXtUDGHhxmQ51HNR
         Kbavh0jBn6cF7d/spmZ+LqKagNgAbOIvmpsgVlxZ6wjKljxoF6Pt0//Aiz6QrwJYJs66
         sQTyTpScjT3UkN4IseJNCpe6yoeFTBYhncI/eHiUip8R+I6qflc2yyhjgJFnb9/nQGwh
         ibkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765472962; x=1766077762;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FW2VUCo7IK1n+Kn8KgoCJTzuM+/Fk/IPBhEby/pihF0=;
        b=cd+/yy66cNtX3fUtoajIfXCy0wg7uP4ARSsQxWIHvFxKR+cs4rKNtqesogevbCWEHG
         tP/agYMsW45twiHhqSGPGll3/e5Yl7xqa8jkiz3rHZWnophp6pRzrODSK3/Q8bTrwXjw
         k8VF3mUyS6WMHDvaqCcUXT8/EFnAN24jnoNc5YvPDrpxL80r0PAa7ClWkpOCYnKprcBJ
         MYTNW4Ev2y0y1fI3VwtSNQ0QrsjmQusjzDQEOcZHZUZtlYORLPS3Y2bocYWly3MkRlHF
         lSbd4yxB5nj1K2qpFsYfaP6EXlbgoUmWT37hqc6emW4z8G6VUikPFsx/+d7HwRBVCsp0
         khqQ==
X-Forwarded-Encrypted: i=1; AJvYcCX40ogCJN8d5cLFf7rPH9hT98qE2TjM5JNFK26/zKKs49FcsvDuv3Og1JY9Bg4D64GxF6rJxpsXKw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+JvzAfxLSdS4ErrbmO/21R0q0HvOSLWFeNzmWj3rHzx60KjsP
	SUmRLzUIBtq5AuzPkCi75zK4K0OTO77fFJqxME9S35Ni7jBPtNZNVr43WUz+z1pMJvDlnAOKJPD
	onvWLpcIDnrpJAGw/5fvKy0GzbZmcYxc=
X-Gm-Gg: AY/fxX4USna1qSAkPkWaAdt9fgDi95ZrXazZMZdnMDlVCUM2t6ZAfoSKnPYjaQqsqmo
	pCkwN6+m/v8sfdE3h/lxE+2U+PlfxVTcDt7nfJIrxxEyqwJF6OcTUdYWudmTyF4nuxNPhU/LBqs
	CwB9YCvIfNdbjZuQTrCMlrHO5HJb3AHFjM44Kh1E+Gvl9veyzBM830DeG2vQJw1ou11VHoyWtVS
	HiUBUVTKIihvOMPBeZ4ERZO07gGnJxVEE7npzSlKd0Qs+g4JiKUN1r6wm0ZIr2vMPbEJIjdbCHm
	6OwnXBd+7MeZUXj9uGI654OZ2g==
X-Google-Smtp-Source: AGHT+IFxpPbCdRMZz9XBjuHDTCZ9dsvF1etOQHeAP0z0LVfgm/LsQx3fse+ZuSSLzWCYXnUik92Z0mf6l8CpZRvS100=
X-Received: by 2002:a05:6808:470a:b0:453:5e88:29b9 with SMTP id
 5614622812f47-4559bf4860dmr1211437b6e.28.1765472961939; Thu, 11 Dec 2025
 09:09:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD4GDZy-aeWsiY=-ATr+Y4PzhMX71DFd_mmdMk4rxn3YG8U5GA@mail.gmail.com>
 <fc7dede0-30a4-4b37-9d4c-af9e67e762c7@lunn.ch>
In-Reply-To: <fc7dede0-30a4-4b37-9d4c-af9e67e762c7@lunn.ch>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Thu, 11 Dec 2025 17:09:10 +0000
X-Gm-Features: AQt7F2qtonLBE9deAK2-llt-SKUXbtrFWqqvYj6_-uA64Lmu8yrBroU6XbFO-mo
Message-ID: <CAD4GDZxYVwzxHBRnpG1RnkaD3wPW+-GUozhBg7hzO-_3X_PPpA@mail.gmail.com>
Subject: Re: Concerns with em.yaml YNL spec
To: Andrew Lunn <andrew@lunn.ch>
Cc: Changwoo Min <changwoo@igalia.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	sched-ext@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Dec 2025 at 17:04, Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Thu, Dec 11, 2025 at 03:54:53PM +0000, Donald Hunter wrote:
> > Hi,
> >
> > I just spotted the new em.yaml YNL spec that got merged in
> > bd26631ccdfd ("PM: EM: Add em.yaml and autogen files") as part of [1]
> > because it introduced new yamllint reports:
> >
> > make -C tools/net/ynl/ lint
> > make: Entering directory '/home/donaldh/net-next/tools/net/ynl'
> > yamllint ../../../Documentation/netlink/specs
> > ../../../Documentation/netlink/specs/em.yaml
> >   3:1       warning  missing document start "---"  (document-start)
> >   107:13    error    wrong indentation: expected 10 but found 12  (indentation)
> >
> > I guess the patch series was never cced to netdev or the YNL
> > maintainers so this is my first opportunity to review it.
>
> Maybe submit a patch to this:
>
> YAML NETLINK (YNL)
> M:      Donald Hunter <donald.hunter@gmail.com>
> M:      Jakub Kicinski <kuba@kernel.org>
> F:      Documentation/netlink/
> F:      Documentation/userspace-api/netlink/intro-specs.rst
> F:      Documentation/userspace-api/netlink/specs.rst
> F:      tools/net/ynl/
>
> adding
>
> F:      Documentation/netlink/specs

It is covered by the Documentation/netlink/ entry:

./scripts/get_maintainer.pl Documentation/netlink/specs/em.yaml
Lukasz Luba <lukasz.luba@arm.com> (maintainer:ENERGY MODEL)
"Rafael J. Wysocki" <rafael@kernel.org> (maintainer:ENERGY MODEL)
Donald Hunter <donald.hunter@gmail.com> (maintainer:YAML NETLINK (YNL))
Jakub Kicinski <kuba@kernel.org> (maintainer:YAML NETLINK (YNL))
[...]

>
> I'm also surprised there is no L: line in the entry.

That's something we should address, thanks!

