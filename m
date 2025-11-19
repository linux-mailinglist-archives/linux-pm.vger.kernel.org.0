Return-Path: <linux-pm+bounces-38203-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D62C6CFBB
	for <lists+linux-pm@lfdr.de>; Wed, 19 Nov 2025 07:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1BDAB361CE5
	for <lists+linux-pm@lfdr.de>; Wed, 19 Nov 2025 06:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A42731B829;
	Wed, 19 Nov 2025 06:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6IhmAnZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F96E31B133
	for <linux-pm@vger.kernel.org>; Wed, 19 Nov 2025 06:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763535251; cv=none; b=SeenNwwGday4/ZD832WIHcsXWufKhQvvmzEgiqxcRqA6KrXBcjIkRfH9o8SVbguYod1Q4W+JBsCum37e/hZaHAr3EPUFtXM61cgcHCxQ+tonPxgO9QcWaLrt5DgT6BsiK6fsSiyx5jaTkyD1nr5uOMMMblnoV80aSIu8+MmLx+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763535251; c=relaxed/simple;
	bh=c6iEQjBee6A/wie6G8Q6LazEnH0UOGUalPNLQFibx5w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kyw3+angK/Z9V8LZfQqSSHXvorbEypCiH6V8nySJK5ySKnJprwd7roysYhRZnjnJssCM3N29eAOVTUlv7YDJR6L3hgeVg6RVsUpkcMXItZbfAvg+gIY+6itg0mFJ3XHOom05cH2nbx9a2WHVO1wqkZz9jqdm3tXA5VkFhOOEwuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6IhmAnZ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7aab061e7cbso7280605b3a.1
        for <linux-pm@vger.kernel.org>; Tue, 18 Nov 2025 22:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763535246; x=1764140046; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E38F5iOCPuww5nf63JyXNJFqV8JGs8VUEvNS436chC8=;
        b=M6IhmAnZhCmDAxJ6+rwatoxSzjmUIdQBjZTw6GmK94PahmrSO7LZX8/CajRVbiisr2
         8p9DhM81U80bxNk9lWQrQWoVuKIzQnX/TiyEpus6jxARGVcvyipeZeiSjq27mdYkd0v5
         xYed+LdrptsdyYOoKeUG9pMEwO7u5vzQkIN5NR8G4kIbirDHmrfX3mP7mge9Uwa9IG7e
         Jx/V6rydRS2nbNT19jVpxnth8vSrnmUi35EdZq0taDRKBob6aYILp6fWtXmeRMSG8Wlz
         Tce+b5YEsn5wK2ZL9E0DWvQbdaK+S8wMz7TgiMTUDHH6qnDaX+He2WLT+tzXvG8nwIqG
         gFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763535246; x=1764140046;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E38F5iOCPuww5nf63JyXNJFqV8JGs8VUEvNS436chC8=;
        b=tEwV3qglEY+gCEufOwbPlfpYOp2SuD4FTAZjPBNfGDwHf/VOObA0Di3MSIWVypN6DO
         uNLMX8soi7gXwF0+VktKs53iP3ZVNpITrwUS+3zp5MO/2Y5T3SXCW4MQrmwRswmnHYhi
         JmOd0o2y7gFmMijWwOBisCWPo9/Ie+d4efPKReGz4/nLbAhVfDOodTldK+Sn2jb9DI1j
         9+lyfdj0UCYJPaCcZ31eOR/Mssw1fTAfRtY/EmaMBJGe2vkmokTWUuLWbttgxVsT8M9+
         2ca25XNK6Ev8+P77UoUXkRWp8Y3whr76rnlwOxtNWdPPjzPaL/e0H9uR74qsYCDUPEXw
         rWsA==
X-Forwarded-Encrypted: i=1; AJvYcCVFJkGqy3vWZT75KusbbWCl2j+d6YIYJmopJI6uqsnUwgoHYLn6MXz0toCSSMBLl4osFR4S3HyDsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMm9UTpRKuR8M4tW5p+fbyFFz8DAI1kiwvNa5YgdProH60rAwr
	sNvw1X+CkG/aKsc0AiBEvgwD8vIw0abzErPUAvfeA/mGO8S9JrWboEu6
X-Gm-Gg: ASbGnctzix/1pnQ+ue4naiOpl2IPfzt60a8fm3IWyWM3cpN2Lpjy7r1w+Sn5JGUw3m7
	gRQm1y9Cjhy0VqD3VSpv57dbXrOoVJ4Ot3CTEWPpdxqTpiFo+drBMSE7nD0MY6qzcNqD/HPgvoO
	RWruZ7HF18e+j2TbBzC/xXkeUv3ItKJhBVhsa3vNt+QwDiXECf5n1dL1CKlMVlmUG3oRZ9d5qLG
	VowOZFsWbwjGvip1KpjXKhUzadA1AzG9eKaQnVNsI0/Kg6hg6IKg71ssIDplSVB+5VqNc1PJsRX
	+SmYUQqQ7XsHrsjz7GywtYff9ghlPsILHAm/T2k7cCYOLKYj0VxQX8V3YNTJc0KBCmdBY0jiXDY
	j8sOXcZo59vXrww7GFqKQlLwG62umfWotxQPx73PY4DpsTCH20gYAj/gJxaT63meq3BUTBwMg88
	qwRopwgDe2/+aps5YixEmwDz2IDV/YcxbeyG9LRwVqsS8noYaGoYnB
X-Google-Smtp-Source: AGHT+IEjnUsFYS10TLbM75bHXZXCUsiqQdjKngnrPrJ8OU9rffukFhVefJ8mrLpSM76VWL08dDLKJw==
X-Received: by 2002:a05:6a21:3397:b0:35d:cc9a:8bbb with SMTP id adf61e73a8af0-35dcc9a8d3emr15383274637.47.1763535245724;
        Tue, 18 Nov 2025 22:54:05 -0800 (PST)
Received: from ?IPv6:2401:4900:60d7:2218:52ea:a17:db14:a44? ([2401:4900:60d7:2218:52ea:a17:db14:a44])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc37507fc7bsm17221460a12.23.2025.11.18.22.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 22:54:05 -0800 (PST)
Message-ID: <24e675622cd33404f8717189205658b016332131.camel@gmail.com>
Subject: Re: [PATCH RESEND v4] checkpatch: add uninitialized pointer with
 __free attribute check
From: ally heev <allyheev@gmail.com>
To: Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn
	 <lukas.bulwahn@gmail.com>, Joe Perches <joe@perches.com>, Jonathan Corbet
	 <corbet@lwn.net>, Andy Whitcroft <apw@canonical.com>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
 David Hunter <david.hunter.linux@gmail.com>, Shuah Khan
 <skhan@linuxfoundation.org>, Viresh Kumar	 <vireshk@kernel.org>, Nishanth
 Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,  linux-pm
 <linux-pm@vger.kernel.org>, dan.j.williams@intel.com, Geert Uytterhoeven	
 <geert@linux-m68k.org>, James Bottomley
 <James.Bottomley@hansenpartnership.com>
Date: Wed, 19 Nov 2025 12:23:56 +0530
In-Reply-To: <20251117-aheev-checkpatch-uninitialized-free-v4-1-fbee16ffeab9@gmail.com>
References: 
	<20251117-aheev-checkpatch-uninitialized-free-v4-1-fbee16ffeab9@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+deb13u1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-11-17 at 08:40 +0530, Ally Heev wrote:
> uninitialized pointers with __free attribute can cause undefined
> behavior as the memory randomly assigned to the pointer is freed
> automatically when the pointer goes out of scope.
> add check in checkpatch to detect such issues.
>=20
> Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
> Link: https://lore.kernel.org/all/8a4c0b43-cf63-400d-b33d-d9c447b7e0b9@su=
swa.mountain/
> Acked-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ally Heev <allyheev@gmail.com>
> ---
> Testing:
> ran checkpatch.pl before and after the change on
> crypto/asymmetric_keys/x509_public_key.c, which has
> both initialized with NULL and uninitialized pointers
> ---
> Changes in v4:
> - fixed UNINITIALIZED_PTR_WITH_FREE description
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
> - add a new WARN for pointers initialized with NULL
> - NOTE: tried handling multiple declarations on a single line by splittin=
g
>         them and matching the parts with regex, but, it turned out to be
> 	complex and overkill. Moreover, multi-line declarations pose a threat
> - Link to v1: https://lore.kernel.org/r/20251021-aheev-checkpatch-uniniti=
alized-free-v1-1-18fb01bc6a7a@gmail.com
> ---
>  Documentation/dev-tools/checkpatch.rst | 5 +++++
>  scripts/checkpatch.pl                  | 6 ++++++
>  2 files changed, 11 insertions(+)
>=20
> diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-t=
ools/checkpatch.rst
> index d5c47e560324fb2399a5b1bc99c891ed1de10535..c61a3892a60c13f7c5ba89e96=
9e39a93a3dcd5bc 100644
> --- a/Documentation/dev-tools/checkpatch.rst
> +++ b/Documentation/dev-tools/checkpatch.rst
> @@ -1009,6 +1009,11 @@ Functions and Variables
> =20
>        return bar;
> =20
> +  **UNINITIALIZED_PTR_WITH_FREE**
> +    Pointers with __free attribute should be initialized. Not doing so
> +    may lead to undefined behavior as the memory assigned (garbage,
> +    in case not initialized) to the pointer is freed automatically
> +    when the pointer goes out of scope.
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
> -----BEGIN PGP SIGNATURE-----
>=20
> iHUEABYKAB0WIQQBFRpOLrIakF7DYvaWPaLUP9d7HAUCaQ2YPwAKCRCWPaLUP9d7
> HDkPAP9+gFqrD4O5qsYZzxGFwfXPAY7F8TM0lfYy7fLNxA2brAEAwLyLuyN0h7qg
> N7da1PWuOGK8tKeZ9dR4r3gFdlbZMAo=3D
> =3Dzo4P
> -----END PGP SIGNATURE-----

There's an ongoing discussion about making this rule global
https://lore.kernel.org/lkml/58fd478f408a34b578ee8d949c5c4b4da4d4f41d.camel=
@HansenPartnership.com/.
I will wait till weekend before making any more changes.

Also, CCing James Bottomley

