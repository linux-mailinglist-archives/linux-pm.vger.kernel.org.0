Return-Path: <linux-pm+bounces-36800-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AA1C07A23
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 20:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07EB51C41E15
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 18:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE71334678A;
	Fri, 24 Oct 2025 18:01:45 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF63B303C8A;
	Fri, 24 Oct 2025 18:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761328905; cv=none; b=C29kkAD5v/iu8kMQrmy+OFGwlMY3zjBLnJWvmitqoh0Zr4BzSFWoEnVy8u0isdsurLMTvGEWWLRhB8wec8gKugDt3oZ+UfKSnSer9LOqS+7/NsNIUoS+Eu3vBKkUS11t0rkGMGVJZaB6pJEbWP1FRz+F+lUb0dWKONZyK4EtjZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761328905; c=relaxed/simple;
	bh=Xt+ETKSJFI97IrcpNY81LB6CRSBaom6ByUnewAJpqdU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jZldBD3K1UuR43aw1qmIasOlBR7rRhccAVj9tUhVRI9UI6apvW4WlC/VBVEaCUAT/SMOkJqWJxQ6JyQmNh/M46+eVspeQKxF/03IpUC0XLjGkBuQzdrAh7iFAQqFeGVpx0EZvOmLchLWGtSnlkDnpEBDyzEpAG6o9fqGwz1IqQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 4A00DBE731;
	Fri, 24 Oct 2025 18:01:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id CC96920037;
	Fri, 24 Oct 2025 18:01:36 +0000 (UTC)
Message-ID: <769268a5035b5a711a375591c25d48d077b46faa.camel@perches.com>
Subject: Re: [PATCH v2 2/2] add check for pointers with __free attribute
 initialized to NULL
From: Joe Perches <joe@perches.com>
To: Ally Heev <allyheev@gmail.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>,
  Lukas Bulwahn <lukas.bulwahn@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Andy Whitcroft <apw@canonical.com>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
 David Hunter <david.hunter.linux@gmail.com>, Shuah Khan
 <skhan@linuxfoundation.org>, Viresh Kumar	 <vireshk@kernel.org>, Nishanth
 Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,  linux-pm
 <linux-pm@vger.kernel.org>, dan.j.williams@intel.com
Date: Fri, 24 Oct 2025 11:01:35 -0700
In-Reply-To: <20251024-aheev-checkpatch-uninitialized-free-v2-2-16c0900e8130@gmail.com>
References: 
	<20251024-aheev-checkpatch-uninitialized-free-v2-0-16c0900e8130@gmail.com>
	 <20251024-aheev-checkpatch-uninitialized-free-v2-2-16c0900e8130@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: eb5s9q3uch3ku4my1dtojkfi97u8a4hi
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: CC96920037
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18IUFoqClvI0Rd89Cboqhy+chZzc4TgnUI=
X-HE-Tag: 1761328896-239519
X-HE-Meta: U2FsdGVkX1+4JucxezI4zqxHXyRDfDWSSyYrfAGxTKk8mizadDJ+RGINF8cu03EPljticeWNrB6iDzT2+0C4YgeNoi8DAnflRqiC4s8fx8N7zdEMEVO+99A5Z6Hg+Zy18erM2IxdJLx6BnVsNUGxN/VuOELJ2IvTLet7s+843+yU9h+CyWVLJMGhpcXOFP+DOEXme9vZ+r+b471C2gTKYzdGKGDuR0Nc2RUUGlPD6PCeUzHlJWWGZUwxrxefrgO6OGAu+UwGauY+iz36k02HO8XpbjJZiz7glJQx3qUheMVz9eE7BQ+KtjPPBHmyvwZV8DUDtP9D7n2DXvtZTBPvxwY5i/VIwEDATGKmyDjZCiPwZh0rnKr2b9rRuvxMjLOVNI+RbnOP3DoenSgUV6MElnyXWx1JG+Vx

On Fri, 2025-10-24 at 22:59 +0530, Ally Heev wrote:
> pointers with __free attribute initialized to NULL
> pose potential cleanup issues [1] when a function uses
> interdependent variables with cleanup attributes
>=20
> Link: https://docs.kernel.org/core-api/cleanup.html [1]
> Link: https://lore.kernel.org/all/68f7b830ec21a_10e910070@dwillia2-mobl4.=
notmuch/
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ally Heev <allyheev@gmail.com>
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -7728,6 +7728,12 @@ sub process {
>  			ERROR("UNINITIALIZED_PTR_WITH_FREE",
>  			      "pointer '$1' with __free attribute should be initialized\n" . =
$herecurr);
>  		}
> +
> +# check for pointers with __free attribute initialized to NULL
> +		while ($line =3D~ /\*\s*($Ident)\s+$FreeAttribute\s*=3D\s*NULL\b/g) {
> +			WARN("NULL_INITIALIZED_PTR_WITH_FREE",
> +			      "pointer '$1' with __free attribute should be initialized to a =
non-NULL address\n" . $herecurr);
> +		}
>  	}

I think this a poor idea as almost all the instances where this
initialization is done are fine.

And there are a lot of them.

$ git grep -P '\b__free\b.*=3D\s*NULL\s*;' | wc -l
490

And what about these uses that depend on struct path members
.mnt and .dentry being NULL.=20

$ git grep -P '\b__free\b.*=3D\s*\{.*\}\s*;'
fs/configfs/symlink.c:  struct path path __free(path_put) =3D {};
fs/fhandle.c:   struct path path __free(path_put) =3D {};
fs/file_attr.c: struct path filepath __free(path_put) =3D {};
fs/file_attr.c: struct path filepath __free(path_put) =3D {};
fs/namei.c:     struct path parent_path __free(path_put) =3D {};
fs/namei.c:     struct path parent_path __free(path_put) =3D {};
fs/namespace.c: struct path old_path __free(path_put) =3D {};
fs/namespace.c: struct path path __free(path_put) =3D {};
fs/namespace.c: struct path old_path __free(path_put) =3D {};
fs/namespace.c: struct path path __free(path_put) =3D {};
fs/namespace.c: struct path to_path __free(path_put) =3D {};
fs/namespace.c: struct path from_path __free(path_put) =3D {};
fs/namespace.c: struct path new __free(path_put) =3D {};
fs/namespace.c: struct path old __free(path_put) =3D {};
fs/namespace.c: struct path root __free(path_put) =3D {};
fs/namespace.c: struct klistmount kls __free(klistmount_free) =3D {};
fs/namespace.c: struct path fs_root __free(path_put) =3D {};
fs/nsfs.c:      struct path path __free(path_put) =3D {};
fs/nsfs.c:              struct path path __free(path_put) =3D {};
fs/nsfs.c:      struct path path __free(path_put) =3D {};
fs/overlayfs/params.c:  struct path layer_path __free(path_put) =3D {};
fs/overlayfs/params.c:          struct path path __free(path_put) =3D {};
fs/pidfs.c:     struct path path __free(path_put) =3D {};
include/linux/path.h: * struct path path __free(path_put) =3D {};
kernel/acct.c:  struct path internal __free(path_put) =3D {};     // in tha=
t order
kernel/trace/trace_uprobe.c:    struct path path __free(path_put) =3D {};

