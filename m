Return-Path: <linux-pm+bounces-39169-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B246CA048F
	for <lists+linux-pm@lfdr.de>; Wed, 03 Dec 2025 18:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB33930D951F
	for <lists+linux-pm@lfdr.de>; Wed,  3 Dec 2025 17:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA16739A258;
	Wed,  3 Dec 2025 16:54:11 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5CD331227;
	Wed,  3 Dec 2025 16:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764780851; cv=none; b=A40Q5V6v0CfGDrSzUwk2kwZlyeSnH7RA14c5WoMK+z30QDs3tyvUr/hlEEl69Uz6hpcT0kqEUMUAFU2/9UPYUX2dkQbvUB1SruNrXVjK/dn1UTuAqYQ7rSKmQu+I9up/Rrm45h/CTvkznMbA6rZPgUayVndspLJLF4PDXj3E2Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764780851; c=relaxed/simple;
	bh=ZgsF0dqeDYDEvJwJJ16ITmUm/0fruGiVCAD3suoD2ko=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Itfgn8OU6xz4EJ7s/SkQYnZQgE5L17Et1gemHjbtzO2UBUm0SwB/s+lmrEyUfBSXUFkkR4xDl0QCZlm/bohZrLxc/aHklm4m9c0BQ1mYoMEli9M8/ImEwvOka/1Y3rsL1FcazTHmG+CkMDsJWfPSK/eeJMjhpKVo2Yu61qmq9EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 4CEA4C06C7;
	Wed,  3 Dec 2025 16:54:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id AF70A20024;
	Wed,  3 Dec 2025 16:53:59 +0000 (UTC)
Message-ID: <4f6a13c78311944f33b8391ea8a915d98be6f792.camel@perches.com>
Subject: Re: [PATCH v7] checkpatch: add uninitialized pointer with __free
 attribute check
From: Joe Perches <joe@perches.com>
To: Ally Heev <allyheev@gmail.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>,
  Lukas Bulwahn <lukas.bulwahn@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Andy Whitcroft <apw@canonical.com>,  Andrew Morton
 <akpm@linux-foundation.org>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
 David Hunter <david.hunter.linux@gmail.com>, Shuah Khan
 <skhan@linuxfoundation.org>, Viresh Kumar	 <vireshk@kernel.org>, Nishanth
 Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,  linux-pm
 <linux-pm@vger.kernel.org>, dan.j.williams@intel.com, Geert Uytterhoeven	
 <geert@linux-m68k.org>, James Bottomley
 <James.Bottomley@hansenpartnership.com>,  Krzysztof Kozlowski	
 <krzk@kernel.org>
Date: Wed, 03 Dec 2025 08:53:58 -0800
In-Reply-To: <20251203-aheev-checkpatch-uninitialized-free-v7-1-841e3b31d8f3@gmail.com>
References: 
	<20251203-aheev-checkpatch-uninitialized-free-v7-1-841e3b31d8f3@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: eqz11e8fb9kjqw535z7t77e71wh1h9pm
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: AF70A20024
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/f1fmNfLxInLO1IIzJWCUbEpupmbrVWh0=
X-HE-Tag: 1764780839-838249
X-HE-Meta: U2FsdGVkX1/I3qO8j4HJCRyuGjyZ4llUmwFuO9tzQOhFdJkOqDbxvHy6989G2mHijBAgxfyrujuWp+eX3XBXxBzcNVJbvJHX7fueDGT/pqDGQxUZtILCq6T8KAuoSo+87ijOMMzXbEZZwODxtN2gaofX6vYTwlR7/m1KWjONXtUgojkK/2UNm1U283l6FjIyWjS6JnK1uzNrnFkV8936T4zD7S7JL9TcyZVfL1/gR88juzmLPAXeW4dvbISpEjJk1q63rT8IbQc5L12/5SZuvFt3lWSc9wGO6qaVyC4YVTF2RDozV7zmllMyg2aFPPZfhbzWuUkmnX0JA9gPt5uy7+o3ZsKIH27EG7gFx/j8np3gvvw5AWuTEYqGGBODdsP0vnRfHTPzkny8qPcOjP/0Gj0NyxNQRv3Vgs26FuitZI4EYf/DClY47itEx3a8kfE5BtlZyJcv8kvnAXt2Vd7EY8jfcHiep+Vf1P4xloPNk+E/O6nT6MigdPl6/r9X5au1XxWL9EmSkuwZ88FleinCw2N1RXdumuuMXpG//wuf3ZmqezfLaTwP/KQcACxjWXoA

On Wed, 2025-12-03 at 20:58 +0530, Ally Heev wrote:
> uninitialized pointers with __free attribute can cause undefined
> behavior as the memory randomly assigned to the pointer is freed
> automatically when the pointer goes out of scope.
> add check in checkpatch to detect such issues.
>=20
> Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
> Link: https://lore.kernel.org/all/8a4c0b43-cf63-400d-b33d-d9c447b7e0b9@su=
swa.mountain/
> Link: https://lore.kernel.org/all/58fd478f408a34b578ee8d949c5c4b4da4d4f41=
d.camel@HansenPartnership.com/
> Acked-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Ally Heev <allyheev@gmail.com>

Acked-by: Joe Perches <joe@perches.com>

> ---
> Testing:
> ran checkpatch.pl before and after the change on=20
> crypto/asymmetric_keys/x509_public_key.c, which has
> both initialized with NULL and uninitialized pointers
> ---
> Changes in v7:
> - RESEND. Also, added Reviewed-by trailer
> - Link to v6: https://lore.kernel.org/r/20251125-aheev-checkpatch-uniniti=
alized-free-v6-1-2f3a1d78f678@gmail.com
>=20
> Changes in v6:
> - added declaration at the place of use suggestion
> - Link to v5: https://lore.kernel.org/r/20251124-aheev-checkpatch-uniniti=
alized-free-v5-1-0c523b1a3f5a@gmail.com
>=20
> Changes in v5:
> - fixed checkpatch doc
> - Link to v4: https://lore.kernel.org/r/20251107-aheev-checkpatch-uniniti=
alized-free-v4-1-4822a6ac728f@gmail.com
>=20
> Changes in v4:
> - fixed UNINITIALIZED_PTR_WITH_FREE description=20
> - Link to v3: https://lore.kernel.org/r/20251025-aheev-checkpatch-uniniti=
alized-free-v3-1-a67f72b1c2bd@gmail.com
>=20
> Changes in v3:
> - remove $FreeAttribute
> - Link to v2: https://lore.kernel.org/r/20251024-aheev-checkpatch-uniniti=
alized-free-v2-0-16c0900e8130@gmail.com
>=20
> Changes in v2:
> - change cover letter and title to reflect new changes
> - fix regex to handle multiple declarations in a single line case
> - convert WARN to ERROR for uninitialized pointers
> - add a new WARN for pointers initialized with NULL=20
> - NOTE: tried handling multiple declarations on a single line by splittin=
g
>         them and matching the parts with regex, but, it turned out to be=
=20
> 	complex and overkill. Moreover, multi-line declarations pose a threat
> - Link to v1: https://lore.kernel.org/r/20251021-aheev-checkpatch-uniniti=
alized-free-v1-1-18fb01bc6a7a@gmail.com
> ---
>  Documentation/dev-tools/checkpatch.rst | 23 +++++++++++++++++++++++
>  scripts/checkpatch.pl                  |  6 ++++++
>  2 files changed, 29 insertions(+)
>=20
> diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-t=
ools/checkpatch.rst
> index d5c47e560324fb2399a5b1bc99c891ed1de10535..b6e02fb91e85710fecfc0a5e5=
c83a8e7f32d1d3c 100644
> --- a/Documentation/dev-tools/checkpatch.rst
> +++ b/Documentation/dev-tools/checkpatch.rst
> @@ -1009,6 +1009,29 @@ Functions and Variables
> =20
>        return bar;
> =20
> +  **UNINITIALIZED_PTR_WITH_FREE**
> +    Pointers with __free attribute should be declared at the place of us=
e
> +    and initialized (see include/linux/cleanup.h). In this case
> +    declarations at the top of the function rule can be relaxed. Not doi=
ng
> +    so may lead to undefined behavior as the memory assigned (garbage,
> +    in case not initialized) to the pointer is freed automatically when
> +    the pointer goes out of scope.
> +
> +    Also see: https://lore.kernel.org/lkml/58fd478f408a34b578ee8d949c5c4=
b4da4d4f41d.camel@HansenPartnership.com/
> +
> +    Example::
> +
> +      type var __free(free_func);
> +      ... // var not used, but, in future someone might add a return her=
e
> +      var =3D malloc(var_size);
> +      ...
> +
> +    should be initialized as::
> +
> +      ...
> +      type var __free(free_func) =3D malloc(var_size);
> +      ...
> +
> =20
>  Permissions
>  -----------
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 92669904eecc7a8d2afd3f2625528e02b6d17cd6..e697d81d71c0b3628f7b59807=
e8bc40d582621bb 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -7721,6 +7721,12 @@ sub process {
>  				ERROR("MISSING_SENTINEL", "missing sentinel in ID array\n" . "$here\=
n$stat\n");
>  			}
>  		}
> +
> +# check for uninitialized pointers with __free attribute
> +		while ($line =3D~ /\*\s*($Ident)\s+__free\s*\(\s*$Ident\s*\)\s*[,;]/g)=
 {
> +			ERROR("UNINITIALIZED_PTR_WITH_FREE",
> +			      "pointer '$1' with __free attribute should be initialized\n" . =
$herecurr);
> +		}
>  	}
> =20
>  	# If we have no input at all, then there is nothing to report on
>=20
> ---
> base-commit: 6548d364a3e850326831799d7e3ea2d7bb97ba08
> change-id: 20251021-aheev-checkpatch-uninitialized-free-5c39f75e10a1
>=20
> Best regards,

