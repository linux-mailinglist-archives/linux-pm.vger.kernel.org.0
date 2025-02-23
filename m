Return-Path: <linux-pm+bounces-22747-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E012CA40DF8
	for <lists+linux-pm@lfdr.de>; Sun, 23 Feb 2025 11:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A4BA3BA6EB
	for <lists+linux-pm@lfdr.de>; Sun, 23 Feb 2025 10:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A60A2045A5;
	Sun, 23 Feb 2025 10:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="pDAe4ucz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51DD1E871;
	Sun, 23 Feb 2025 10:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740305507; cv=none; b=qY6A7lZIkEPikW1T2SYTQ72n6d9UMdYak8h+fLI1l+oe4JzNNIChvGaatAVn19YhfsDSXIImh3g4Nu6Fr5G5Y4hxAxK1RX14R7G8K1cJ6jI9ukrfJvEuchmezp0Xgk/qDUZpkWjl4YpmK+ocAx+WS/l/nu4dU46ReGE52Gv6y3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740305507; c=relaxed/simple;
	bh=IiJYWfUzjvzO64rFYkVBgyFB2/WFf5T4phOFcLu6ucg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RiWgDDf9JCQA/cbeI0UUi8d7g4uyI9uO8cpCYWeIsNx7aP27U9pG3tMEU4Zh877cIj749v4YC2KAw7sx3XF9OAak437fhLpFTmnYXdqE2z2mw8tqn2A1ZAkFp25hWTLOt4kI+bwlEMpH+JenZYc+NnlJOAGaiEXsjgyXmEctFxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=pDAe4ucz; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740305497; x=1740910297; i=markus.elfring@web.de;
	bh=+n81tpsUZjiYF8TyqwTYd0MJyUxrzC5UmrBbfS3jvuk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=pDAe4uczsP/GplF5u56BqD6C71APc1fEGYJhyJEPE0b+2kTqHDoru1cUfHEHD13r
	 vcTzRtkZZzq2P4nLSDlypQFdJlNlDYhIgD3dj7frFRhQad07p50A8LSxI6LMwAPCB
	 5Obf1UY3EIuRzhv4PPVsrVClSPo+rC/sBbm4zpOcTsdkFozexB09Fq3Bg/vvWUDXd
	 NjHyRopkdahaEioZjyNi9pEXJkrtJaR7uQHMUeY9cGwZVpkXViJZ5mPZAaKSi2Efz
	 KD9m9PrqG6M0LRHgG3KB7E2R07j7L7uVy4Sisl0yuJVqAX8NeGEhByY1VRBOe7rQz
	 6y/3VBMEYSqcsDvtwg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.18]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MBjMM-1tcDLB1kdA-0017BQ; Sun, 23
 Feb 2025 11:11:37 +0100
Message-ID: <ebe9e9d5-2058-429e-b733-183c437ba154@web.de>
Date: Sun, 23 Feb 2025 11:11:35 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4?] thermal/debugfs: replace kzalloc() with kcalloc() in
 thermal_debug_tz_add()
To: Ethan Carter Edwards <ethan@ethancedwards.com>, linux-pm@vger.kernel.org,
 linux-hardening@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba
 <lukasz.luba@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>
References: <20250222-thermal_kcalloc-v1-1-9f7a747fbed7@ethancedwards.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250222-thermal_kcalloc-v1-1-9f7a747fbed7@ethancedwards.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ky02Zy49vEaQHUodvPB1zMlzETqh0IZFLRVNj+LsxYYM+qgqmx9
 Fi9pnUT6BChB4qVrV/EQcZk/NPM/f8ZULPfMAexBem6Po99MoZSpkjOux4Lj/heJqyMIH70
 PbhCMMw/R2VeA0cLMZqmeFE9K95PqTu/uJay/WVW5RVlGaUAOmpxSoDgTagnUOgbhJC2npb
 qLSUqrX9IUKCTtn3tUyyA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:66X98Lpb8ZY=;tAWMZY7AGEJNEZudrGY34EyO07c
 ON30F9mdVqIUBHfIvPnqOfXRcGCCRwU36UNJ3A3bZQxxSNbDs6jN8YbeyOyeQNygp6RrLasum
 quAkmwYXGX6QaTRJWxo6euC0QvEUiXpV714h/frms+jJASQGuIzd6E/XKSLmefZNyFkWROB9Z
 6eZ4W8uRnveh5IIxXV4CuPHLfhH6B36ewl7AW/QEL82n/C+6VDObj+q9YBA5gwvFYnFgqLyJS
 NsyVPxXvPpaTDBEJFebMZ8i7yG8Hb25fwYbN5XeW6e3Alh11ClF8ORXOF+g6tRCG9g5dVOYeV
 CgHweCJsPcbXqLXSCReFW7WlRs1GfPiDD8qe3As+x3BwMSpIJfVmOYQ1yffZuRytxvDx5qG8L
 fp1djDM62JXlHhR4Yrx5JEahJhcEPIIiZ5dKTmH3a/9+G73qVaHPssndD/vrondMLMbVhDcIS
 alsQ2v7vpuwTAWaPjdM+hqgwQO9EDxTSR/CRPFoa9Wie1CHfcn0y01j/LnlwtPjih4zK4UDgj
 VGlX9XgQmT20jR1NRti2dEE7udbQlcXVeG65mZlxP0XphpXI7VUmtqWF84kVA5o0a5U6vLfyR
 IKqabwC8fwZFXqOgdjxgEFgCA3+12G19bj018M6JFgclZZtdtJ04OgJf0mdmWdyA2v/unSEOP
 75xthdz2mEzbojY1xM/xTPadhM9d6jzSpRQ5xkV/8HVgR0L80qqntGjfdb3e4x1ygWTYuGI+i
 qyoBaE/pTxv8/BP0uCfgzKpDJjOyru9yg8sbNgJRY7gC2RbUJglAjbaHPebrhg45XYonhekkF
 wH2JO8Z/NvQ8hBVZD/J4i/INOcLcljyHd7YSuggP4ZIMontuz0oZo7YucuNO8nQW7ZOSrFPCo
 sbqJzu3QwIUlhRLxw9Tok9Nk5h7eaJDZfj5RFHrWvVyuGBHsXcKQth7ml/OvuZ5NetgsbTX9I
 +ylfsvUnPTUqkMEDGjT7pj/OPPT7y5jlLYNH8r17NrjH8b0KSHUr9qQhoCy9pY1+HvhTqDPKs
 9JfZthAQUr+YVcVFhjwuGcXIxACvhFEtwmZrld/P/STa+M8b2ja68TWyA0mFcu8PjSRmkL4Nb
 gOIC/GBv871Inyxu4FKJgqNYzCQsCeqkiFH9Tvw/wnIOpDcVfQgr1MHvft4DhWn2DYsTFc1Q/
 D8NF5vNs4Oinw8zFF1FapAvkKO2wCyfGNaMfRE4TyAnpkZx64cyFbfDLG+jFJAw+9yzGVvKHD
 zqyZAjNnd8LWrLcCLVppb7O3YATmd8Uqo3emA7J2DGdXGPcRAErhLebawYfaP1lkIjXHMVqmL
 6NvNo4qNO8IjweQZ5XlgJBt1C5Cdo48lvzvgaB51Ggzn/T3Ss31ydc4s/J7btMEqXEur75v76
 APIpNMH50SN29rMBWsHoxFCKQdVmPnBRHwcA+rBFqQt3duyz7YCNryzhZ7EGh8G+pDpYvzwul
 h5A9ohgXvcWBL7oDOmjpNhWpYMxE=

=E2=80=A6
> We are trying to get rid of all multiplications from allocation
> functions to prevent integer overflows[1]. =E2=80=A6

Is an imperative wording more desirable for such a change description?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.14-rc3#n94


=E2=80=A6
> ---
>  drivers/thermal/thermal_debugfs.c | 2 +-
=E2=80=A6

How do you think about to improve your version management?
https://lore.kernel.org/all/?q=3D%22This+looks+like+a+new+version+of+a+pre=
viously+submitted+patch%22
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.14-rc3#n780


=E2=80=A6
> +++ b/drivers/thermal/thermal_debugfs.c
> @@ -876,7 +876,7 @@ void thermal_debug_tz_add(struct thermal_zone_device=
 *tz)
>
>  	tz_dbg->tz =3D tz;
>
> -	tz_dbg->trips_crossed =3D kzalloc(sizeof(int) * tz->num_trips, GFP_KER=
NEL);
> +	tz_dbg->trips_crossed =3D kcalloc(tz->num_trips, sizeof(int), GFP_KERN=
EL);
=E2=80=A6

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv6.14-rc3#n941

Regards,
Markus

