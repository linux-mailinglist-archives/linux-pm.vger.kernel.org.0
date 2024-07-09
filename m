Return-Path: <linux-pm+bounces-10890-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DB992C18A
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 19:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AA4E1F23584
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 17:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB461AD9EC;
	Tue,  9 Jul 2024 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lEV8ZWwO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330DA41C6D;
	Tue,  9 Jul 2024 16:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542660; cv=none; b=fMB37sfpfEDxmXKhu08cdHpN7kKM37iWCI5M11SzAmp9Kbuu38N27TQOpg3q59aQJUwQpoH86womQv8tsNFq5OQJTF2EmnkqRLtwYX+xy15Vu2iEI/XuD/ZpkLnPQPPBTGOqOj9MuSpdrtd8nvAi9IkDc+2WqrZCHQbjun0a1gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542660; c=relaxed/simple;
	bh=aZ0XXr0nDnQLLxUcNF9UReVDz1vfMZZfSrVsx0gtJVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RSlSSITLHGoH4jsMgQ+fJqcNdAwrvhQplN4K4ecVJJJjCrwgPSSknGStKVRf6/RIlddrfbq0d9aunUQekUXR5eevq+yPq9C1pqQE8O/r59a4PsaN9CDkrVusaEEqmmVJRLwqIa4Nhss/JO/qTkNUh4xBgboXDrDFRlMVpugO5iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lEV8ZWwO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09E6C32782;
	Tue,  9 Jul 2024 16:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542659;
	bh=aZ0XXr0nDnQLLxUcNF9UReVDz1vfMZZfSrVsx0gtJVg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lEV8ZWwOqa2+hjsQS8bf4Nx3aKCxGtFwb2epTvrNk88QN0p7jh6gPE0Yjb8RpHAvM
	 EHw9y8D6EyhphynGMwsQB+8XUzlCPM+EWdNW1ZLqsSn3uXewCeNwNAmcMz70xsJqZY
	 ZJDJDjyXp8lTHif1ObB1VVF7iGxazSzZoljAZQXeObNh1+Df8uDAm1SZdt+J6OedQ+
	 t8rJJhEpggK+ehdsJHWXmOZ6Z7dieAQs8rAzRVFqBQ7fH19nFLZmiLcL9e08XsQh9T
	 klCbUvBFKYAs7qd4gqzqe6Rbd0U/Kk+ghwBmg/tyhOZ418RzRikBSXqMdtwOrZHeJ1
	 6QNo6WGwVdZyA==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-25e14bf05e5so202684fac.1;
        Tue, 09 Jul 2024 09:30:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU1BPUth0zOSmv6BtaqcG+P+zXcwX66qfRltKLhoYAsmrvFo7iEqWYpK+ILGqxYz5FJJ7JscXVbX6man8nbPqm7PjRZhLI7FUURbWxds2qk0l9ImgTVftxR3AyVfAUjW4pj0WIMKg8=
X-Gm-Message-State: AOJu0YzMDvoo2QRDRe2xkjynmdMBL1aPFjpmbfPUH5eHE+07Pv23+Dup
	N43PbpbB/uK+DfAHwO7w7OuF3q6zU1koQKnamLXvlwClYGggwAcQz7g1aBFKShMHAi4p6PhI8u3
	ce6jv7bxe+G39mW1kd3VhcmO1PGk=
X-Google-Smtp-Source: AGHT+IFg4SGPhvte9A3/r95e5Z76zMscbdv+0BmKg1Frjs8YNDDKJG7v4RzwM/VDlXhKkuThdheXwyeWn/39T483/SA=
X-Received: by 2002:a05:6871:24d5:b0:254:ecbd:1815 with SMTP id
 586e51a60fabf-25eaece08f4mr2668644fac.5.1720542659073; Tue, 09 Jul 2024
 09:30:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703055445.125362-1-rui.zhang@intel.com> <CAJZ5v0gVFPNK=_=Tnr0QJ-yBWfSWc+wuJrE079Fz+Ba1P57TmA@mail.gmail.com>
 <20240709021917.GA1891@ranerica-svr.sc.intel.com>
In-Reply-To: <20240709021917.GA1891@ranerica-svr.sc.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 9 Jul 2024 18:30:47 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jTfayK6GbiQWYOVt7OxxyzcFduCiGgNEVNodmoC==88w@mail.gmail.com>
Message-ID: <CAJZ5v0jTfayK6GbiQWYOVt7OxxyzcFduCiGgNEVNodmoC==88w@mail.gmail.com>
Subject: Re: [PATCH] Thermal: intel: hfi: Give HFI instances package scope
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, rafael.j.wysocki@intel.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 4:13=E2=80=AFAM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> On Wed, Jul 03, 2024 at 01:33:03PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Jul 3, 2024 at 7:55=E2=80=AFAM Zhang Rui <rui.zhang@intel.com> =
wrote:
> > >
> > > The Intel Software Developer's Manual defines the scope of HFI (regis=
ters
> > > and memory buffer) as package. Use package scope* in the software
> >
> > "as a package"
> >
> > > representation of an HFI instance.
> > >
> > > Using die scope in HFI instances has the effect of creating multiple,
> > > conflicting, instances for the same package: each instance allocates =
its
> > > own memory buffer and configures the same package-level registers.
> > > Specifically, only one of the allocated memory buffers can be set in =
the
> > > MSR_IA32_HW_FEEDBACK_PTR register. CPUs get incorrect HFI data from t=
he
> > > table.
> > >
> > > The problem does not affect current HFI-capable platforms because the=
y
> > > all have single-die processors.
> > >
> > > * We used die scope for HFI instances because there have been process=
ors
> > > in which packages where enumerated as dies. None of those systems sup=
port
> >
> > "were"
> >
> > > HFI. If such a system emerged we would need to quirk it.
> > >
> > > Co-developed-by: Chen Yu <yu.c.chen@intel.com>
> > > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> >
> > Ricardo, any concerns?
>
> No concerns. IMO, it is important to document why we were using die scope
> before. Rui has done it.
>
> This patch looks good to me.
>
> FWIW, Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

Applied as 6.11 material, thanks!

