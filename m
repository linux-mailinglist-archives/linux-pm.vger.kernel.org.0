Return-Path: <linux-pm+bounces-36803-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 289C7C07ABC
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 20:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 427CF4EFC58
	for <lists+linux-pm@lfdr.de>; Fri, 24 Oct 2025 18:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F90347BC6;
	Fri, 24 Oct 2025 18:14:51 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9034347BB4;
	Fri, 24 Oct 2025 18:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329691; cv=none; b=cVyNzBZACHjhX3bY/w5kYa9kG0eeNq1T7bKyR9OR5K9lhnkq+NL19BDH8nB4GHJ6GJ1FS8knAW1o1jSjVq5SKvD3X6mxkM9y314skf93YVEHogytvowY2K6sF/AxX+blCrr8PYLdZwGNgTR6dXH+ONt4wy0iWD+VIhiQWJbGOJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329691; c=relaxed/simple;
	bh=A0V3V/e2yNsd1O9bG4H6npaxVoQcIcywg4cdGuqm9CU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rsrujd0Czp3sLGvpRDim8y+Ipbvhc+hXhcrP7zP/XuIydSlfgwVVlwHhHd98chVFHANHazINphq2KkyYRh5Tv3pvb7xuS3mRIYa+F6lbTgXmzXIxyhEtOldLdKPWl3QRLMWOYyJtR8f6lEm2t97VvXL0hjax6kp44N6XV4XTIkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 9A5511A0C7C;
	Fri, 24 Oct 2025 18:14:42 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf13.hostedemail.com (Postfix) with ESMTPA id 5D38C20012;
	Fri, 24 Oct 2025 18:14:38 +0000 (UTC)
Message-ID: <026a32413b0c9e4edb5d3ab411d18134078430d8.camel@perches.com>
Subject: Re: [PATCH v2 1/2] checkpatch: add uninitialized pointer with
 __free attribute check
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
Date: Fri, 24 Oct 2025 11:14:37 -0700
In-Reply-To: <20251024-aheev-checkpatch-uninitialized-free-v2-1-16c0900e8130@gmail.com>
References: 
	<20251024-aheev-checkpatch-uninitialized-free-v2-0-16c0900e8130@gmail.com>
	 <20251024-aheev-checkpatch-uninitialized-free-v2-1-16c0900e8130@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 5D38C20012
X-Stat-Signature: bnntop17rkdpnahmkoxe4muo965otuk7
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18pmwTROzMhPk1fVUGQEgB07jB4+DDeJw8=
X-HE-Tag: 1761329678-260882
X-HE-Meta: U2FsdGVkX1+ZGQKseISLtzr2zvl46MJ966LkrIgOznqTZ8MKQaZ34SUt81Ep27maSRrqPNNswPwx89IGMN2N/cFWsiwsl3gj7sl+q9r2InuBaA/d0j7roybqkAOgod6N2Mve8n0g5XZBXvW9ta3Y7Ucr6y8JsBaZA/skOT+woanctKW0SWHE4nd6WwammSooR3kHfYdbSmwRHQ+20yNYZsRdlJvSL+8AiIebnmhsOT+7UGy582ziR9IxHpeSnJ19Xh9JT1E1wUR9wG7bZqyfGOADus9oV7+z6cn6+LcdXC/RjIS+Rlee1YMkMvI8cMQmuyQSV1EWdDtKf00ZBgV01n+q6RFv8OFjZO9GcNbjFvEP0I/7X2AlR591a/QUgxuoJuWEDGF886nQ5LFI4Sib7ti1OKD+jOQ+vqpluFPki2hE29SOHs62Tu2+DbACBka/KjGT7eB1uYw=

On Fri, 2025-10-24 at 22:59 +0530, Ally Heev wrote:
> uninitialized pointers with __free attribute can cause undefined
> behaviour as the memory allocated to the pointer is freed
> automatically when the pointer goes out of scope.
> add check in checkpatch to detect such issues
>=20
> Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
> Link: https://lore.kernel.org/all/8a4c0b43-cf63-400d-b33d-d9c447b7e0b9@su=
swa.mountain/
> Acked-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ally Heev <allyheev@gmail.com>
> ---
>  Documentation/dev-tools/checkpatch.rst | 5 +++++
>  scripts/checkpatch.pl                  | 7 +++++++
>  2 files changed, 12 insertions(+)
>=20
> diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-t=
ools/checkpatch.rst
> index d5c47e560324fb2399a5b1bc99c891ed1de10535..1a304bf38bcd27e50bbb7cd43=
83b07ac54d20b0a 100644
> --- a/Documentation/dev-tools/checkpatch.rst
> +++ b/Documentation/dev-tools/checkpatch.rst
> @@ -1009,6 +1009,11 @@ Functions and Variables
> =20
>        return bar;
> =20
> +  **UNINITIALIZED_PTR_WITH_FREE**
> +    Pointers with __free attribute should be initialized. Not doing so
> +    may lead to undefined behavior as the memory allocated (garbage,
> +    in case not initialized) to the pointer is freed automatically
> +    when the pointer goes out of scope.
> =20
>  Permissions
>  -----------
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 92669904eecc7a8d2afd3f2625528e02b6d17cd6..1009a4a065e910143dabeee66=
40b3b3a4bd3fe06 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -509,6 +509,7 @@ our $InitAttributeData =3D qr{$InitAttributePrefix(?:=
initdata\b)};
>  our $InitAttributeConst =3D qr{$InitAttributePrefix(?:initconst\b)};
>  our $InitAttributeInit =3D qr{$InitAttributePrefix(?:init\b)};
>  our $InitAttribute =3D qr{$InitAttributeData|$InitAttributeConst|$InitAt=
tributeInit};
> +our $FreeAttribute =3D qr{__free\s*\(\s*$Ident\s*\)};

If you are really suggesting using this, and I don't think it's
particularly useful, please use

out $InitAttributeFree =3D qr{$InitAttributePrefix(?:free\s*\(\s*$Ident\s*\=
)};

> =20
>  # Notes to $Attribute:
>  # We need \b after 'init' otherwise 'initconst' will cause a false posit=
ive in a check
> @@ -7721,6 +7722,12 @@ sub process {
>  				ERROR("MISSING_SENTINEL", "missing sentinel in ID array\n" . "$here\=
n$stat\n");
>  			}
>  		}
> +
> +# check for uninitialized pointers with __free attribute
> +		while ($line =3D~ /\*\s*($Ident)\s+$FreeAttribute\s*[,;]/g) {
> +			ERROR("UNINITIALIZED_PTR_WITH_FREE",
> +			      "pointer '$1' with __free attribute should be initialized\n" . =
$herecurr);
> +		}
>  	}
> =20
>  	# If we have no input at all, then there is nothing to report on

