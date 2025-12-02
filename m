Return-Path: <linux-pm+bounces-39085-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EF738C9C2CC
	for <lists+linux-pm@lfdr.de>; Tue, 02 Dec 2025 17:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E1AB54E13FD
	for <lists+linux-pm@lfdr.de>; Tue,  2 Dec 2025 16:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97DA274B4D;
	Tue,  2 Dec 2025 16:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiWb4MOK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4707274B23
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 16:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764692466; cv=none; b=ETxSXp5H5eEF6aUCOJsbSYfMEGTLDcquKu+oqUgMXfIGYqOQfV9oqz8GBWOFZ9wkX7BurnxthFvTbbBcG1jQsd6ky1wGfrfrMFDzn5LsKNfv0TIN0o1a7BMbiRFp4v1Rmfrwj2BvZ1xGvfbyWsBVxY/C4Xc9vFFRjsr3QH+/MB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764692466; c=relaxed/simple;
	bh=gfaG8daflZPQGqMnXYaAfv6hIBJXDWXpfTzY/OdP4z4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L0W4Ll/BIoaJNYMXRKv7jOgh/Z4O+WFnzKljqZIUpapvqulM1qy8ggpUmhMIhPR6XjnavGgBz3ywdxnEMswsyJnmwqs+vyP+xLflF+hB77axF1xuBWH31PaBpA+eANZ9XsegbfUdqf/o/mTbOMsm5iTSSKFEAnvZyUT+2JAXtAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiWb4MOK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E65C4CEF1
	for <linux-pm@vger.kernel.org>; Tue,  2 Dec 2025 16:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764692466;
	bh=gfaG8daflZPQGqMnXYaAfv6hIBJXDWXpfTzY/OdP4z4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hiWb4MOKWIy1/YB11i+RTw7opqM8N2dMELei1qKb3nXlKi1fVyxX+fMW2djmlzOV5
	 5jFnPOuxWgDgqfWSAdzPdgIKwmOTt78jAf/uVW5uKzsoprJkthpPyGg1bdAW8F0w+9
	 Gv/0U1CqLzJPdgrkO+q34DSxDUgAUteAhV1oP1j6Q6mzMTH3sFz4i3D+A04cPAkHss
	 UamUsuvVikzeftKfOjQPcF2Ml/JfMLONXDMNLzv2OJIipYLtfKDcBMHDq8MeitNKNn
	 YrVYiFX4W6QizAbOr0bV4NG2cSIfU58Em4VMkpZcJ150bG8xbAOWeWpUPNLIhB/MED
	 gSYBKup4bKOuA==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-3ec3cdcda4eso4026069fac.1
        for <linux-pm@vger.kernel.org>; Tue, 02 Dec 2025 08:21:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWvvGZuUyNBwGWKFsGHj8qht2GY0RTPCB/0m3w7d8uh8gm0kFOUvxuQeCR2+oTS7oQyM7PlInE4lg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkmmoMjy4QiM0riD5uEONbgrBONh5wIhSDn00peAZUPFFV0vpS
	1YeDDZW5Ris8wvViKfJYKZVWirMNZ6REk5ZnNkDz3ZEch4VGn4oEnTv+fTe11N0fE8A2g6WQ22p
	bcub0OoB0RuST0+AgByZ9YEXODPgXV5w=
X-Google-Smtp-Source: AGHT+IEAq6bXGaPRjLxyZ+YjoTaqSq9f4BTvJqWCvttJdXTyjcrDKVhlNS/wgZY2ahwQTGYjKj+wrH3w3FjmkY0IZe0=
X-Received: by 2002:a05:6808:1b22:b0:44f:e376:14db with SMTP id
 5614622812f47-4514e79dfccmr13187791b6e.44.1764692465703; Tue, 02 Dec 2025
 08:21:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113191609.28574-1-ehemily@amazon.de> <20251113191609.28574-2-ehemily@amazon.de>
 <CAJvTdK=_v9q2eGMB6qG3iaDhXMzQHz-EJ4NeDEfBe2fbv+wKfQ@mail.gmail.com>
 <BEYP281MB5509D3D7A01DEC1FAAEB9DBDBADCA@BEYP281MB5509.DEUP281.PROD.OUTLOOK.COM>
 <CAJvTdKnjreryLA9KuuobwJShbVseHOyujmXBAXRuSUDsCZxSVA@mail.gmail.com>
 <BEYP281MB550957A6BA42B6371400472FBADBA@BEYP281MB5509.DEUP281.PROD.OUTLOOK.COM>
 <CAJvTdK=Ty4W=5diU0D0JYHh70ZN4avKjodUoLhuz_D7+=3xcdA@mail.gmail.com>
 <CAJvTdKmr=AVo7UQP28EeD6oLzyeOM+vGCjZZMBo1bV=4n1pcmg@mail.gmail.com> <FR2P281MB268504A9A1DD29C5BB7F0241BAD8A@FR2P281MB2685.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To: <FR2P281MB268504A9A1DD29C5BB7F0241BAD8A@FR2P281MB2685.DEUP281.PROD.OUTLOOK.COM>
From: Len Brown <lenb@kernel.org>
Date: Tue, 2 Dec 2025 11:20:54 -0500
X-Gmail-Original-Message-ID: <CAJvTdKmLG8JUiDkEtB8Co8tLoEXi-BWnJnu8jPvQxZ8zZKC=7w@mail.gmail.com>
X-Gm-Features: AWmQ_bkWxuzraS4El1H2tDY_u-EJClHBktr1kEVTiNk1QfYWUCQVWkBO_5EzGG0
Message-ID: <CAJvTdKmLG8JUiDkEtB8Co8tLoEXi-BWnJnu8jPvQxZ8zZKC=7w@mail.gmail.com>
Subject: Re: [PATCH 2/2] tools/power/turbostat: Fix division by zero when TDP
 calculation fails
To: "Ehlert, Emily" <ehemily@amazon.de>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Emily Ehlert <ehemily@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 4:09=E2=80=AFAM Ehlert, Emily <ehemily@amazon.de> wr=
ote:

> -       if (msr_value =3D=3D 0)
> +       if (msr_value =3D=3D 0) {

Thanks!  (and sorry for that careless mistake!)

> Log output of turbostat with this patch applied:
...
> RAPL_PKG_ENERGY MSR(0x611) =3D=3D ZERO: disabling all RAPL MSRs

Looks good -- thanks!

-Len

