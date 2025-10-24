Return-Path: <linux-pm+bounces-36804-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C97C07B95
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 20:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1255D4F8CA1
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 18:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B35A26B765;
	Fri, 24 Oct 2025 18:23:31 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68FD2AE90;
	Fri, 24 Oct 2025 18:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761330211; cv=none; b=fq4/f5XAWoFHN5UwcQttdr1FIjQAYyCgcaRfWndK6BniudGcP58MwqU/mTLft2cczCUTuuMmzihErnG05tzsV5PQWcbrIknTPlTiZNtiZguv1IMX2mK62gJ5d0z9qxGeHnGdlY+9a5qLmnAnoZnQrT/Ko4w271ffZhqaIqvDrGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761330211; c=relaxed/simple;
	bh=/MSNyjWRDD3YzCX1FouuQQA62Z6fLohdWhuoECKRWmg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I3QxcncDuKb84VvO+SUhnxPVlet2GZ0mKTQEgK9MXkdSNzjGNbh+DdnkY0qTiHpu7QF2Exm9AA9row5GSGI3HBhUrogdW7z1zR2tkwn08RbdzLf84CfjdVg/E7Iyqu9PPgUqbsaSNL6f6ySLQzoPXXfd/b1NXx2dbyPFNJlNYJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 24472C0B51;
	Fri, 24 Oct 2025 18:23:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf12.hostedemail.com (Postfix) with ESMTPA id 0152117;
	Fri, 24 Oct 2025 18:23:16 +0000 (UTC)
Message-ID: <df0d47c9ca7e984a38f56c6f0ca4696cd4ff1b21.camel@perches.com>
Subject: Re: [PATCH v2 2/2] add check for pointers with __free attribute
 initialized to NULL
From: Joe Perches <joe@perches.com>
To: dan.j.williams@intel.com, Ally Heev <allyheev@gmail.com>, Dwaipayan Ray	
 <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Andy Whitcroft <apw@canonical.com>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
 David Hunter <david.hunter.linux@gmail.com>, Shuah Khan
 <skhan@linuxfoundation.org>, Viresh Kumar	 <vireshk@kernel.org>, Nishanth
 Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,  linux-pm
 <linux-pm@vger.kernel.org>
Date: Fri, 24 Oct 2025 11:23:15 -0700
In-Reply-To: <68fbc211c59b9_10e910034@dwillia2-mobl4.notmuch>
References: 
	<20251024-aheev-checkpatch-uninitialized-free-v2-0-16c0900e8130@gmail.com>
	 <20251024-aheev-checkpatch-uninitialized-free-v2-2-16c0900e8130@gmail.com>
	 <769268a5035b5a711a375591c25d48d077b46faa.camel@perches.com>
	 <68fbc211c59b9_10e910034@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 0152117
X-Stat-Signature: mjfmqzay7tyk3ntiegbu4n9f4k3mjjxr
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18KVGxGmlsb4tZqFRtfiJBadsZk3OPVlWU=
X-HE-Tag: 1761330196-434792
X-HE-Meta: U2FsdGVkX192d3BDzlMobZNHHEVGN/8sWiztRDnoFAoPw3ygGHyxFsxMblTDupkEH/Mki5PwO2r1oyugbBT5EYKFZ+suR/n50HwKJYvNhxYkibadKbmh1sg0Gg7hAnRqeRYmT3uHlN4w3xQ+SUNbmHax+gG+GdcorBq7MyWZJ9LrL14y+7nL57rHVfCupYZeFOFnpaNb1/jl4vMvOCnURajTmGLcpOiNUjKAGrMepkydrJt5SP6rCL9y6ix3fBgPphIP/MW0uR1uVoxo9EoPe0i7lHX4w8KbbTRvyJhEr9CHrmhtEptG/8e4aELg4CCGs9sXV0zndweeAraM4JoIFSDCt0O+vKfK/dEB5huQIzwtoOeogZEFFhgMGUeIApz0zAUjvLcmPyCLh18ydben4o0vZERHgkFK

On Fri, 2025-10-24 at 11:14 -0700, dan.j.williams@intel.com wrote:
> Joe Perches wrote:
> > On Fri, 2025-10-24 at 22:59 +0530, Ally Heev wrote:
> > > pointers with __free attribute initialized to NULL
> > > pose potential cleanup issues [1] when a function uses
> > > interdependent variables with cleanup attributes
> > >=20
> > > Link: https://docs.kernel.org/core-api/cleanup.html [1]
> > > Link: https://lore.kernel.org/all/68f7b830ec21a_10e910070@dwillia2-mo=
bl4.notmuch/
> > > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Ally Heev <allyheev@gmail.com>
> > []
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > []
> > > @@ -7728,6 +7728,12 @@ sub process {
> > >  			ERROR("UNINITIALIZED_PTR_WITH_FREE",
> > >  			      "pointer '$1' with __free attribute should be initialized\n=
" . $herecurr);
> > >  		}
> > > +
> > > +# check for pointers with __free attribute initialized to NULL
> > > +		while ($line =3D~ /\*\s*($Ident)\s+$FreeAttribute\s*=3D\s*NULL\b/g=
) {
> > > +			WARN("NULL_INITIALIZED_PTR_WITH_FREE",
> > > +			      "pointer '$1' with __free attribute should be initialized t=
o a non-NULL address\n" . $herecurr);
> > > +		}
> > >  	}
> >=20
> > I think this a poor idea as almost all the instances where this
> > initialization is done are fine.
> >=20
> > And there are a lot of them.
> >=20
> > $ git grep -P '\b__free\b.*=3D\s*NULL\s*;' | wc -l
> > 490
>=20
> That is significant. ...but you did say "almost" above. What about
> moving this from WARN level to CHK level?

I have no idea how many instances in the tree are inappropriate.
Do you? I believe it to be a difficult analysis problem.

But given the number is likely to be extremely low, I think it should
not be added to checkpatch even as a CHK.

If you can show that the reporting rate of defects is significant,
say >10%, then OK, but I rather doubt it's that high.

