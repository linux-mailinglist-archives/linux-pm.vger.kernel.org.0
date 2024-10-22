Return-Path: <linux-pm+bounces-16222-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C3C9AA2BE
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 15:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BB061F2405F
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 13:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AAA19DF4F;
	Tue, 22 Oct 2024 13:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4agJvba"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E483A19C560;
	Tue, 22 Oct 2024 13:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729602334; cv=none; b=rzYhrqCz5FRM6YJy4uOjMqclsct8ZMw+Vn4kjh0/3YnwURiDw3iKablBURkvCDMk5E/rCkGrohIfu6bVUAjRxym9X4nJ5YudqgHeOrKM+So7uRV+WmqnAOyeiyhiGzfN8FMiq1UisYy5k2f7tCxOblLNJV+WP2WsbRcbnfs6NjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729602334; c=relaxed/simple;
	bh=GYElO7fLQ9SXczKd6rFScTpF4TePCHkBpeClolvf+Xs=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=WfNUhnC1LX+osCr1uC0dCoYSIUyEMQb0SDPKlS9Ke23RP7GaeeGFhBcrL4Zq7VwmGdgAsMfz37BRgWa1Gx1Fr7pGm0WnSVq4ySXRYhYobVy3E5nwV9nE8SnDO+lgQ+pL+tMSeyRaXI6qxLCLF3W3eiXuXO0rNEgy/Fut901GhNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4agJvba; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d4ac91d97so5399489f8f.2;
        Tue, 22 Oct 2024 06:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729602331; x=1730207131; darn=vger.kernel.org;
        h=mime-version:date:references:organization:in-reply-to:subject:cc:to
         :from:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CTtGwP6N4/w3oaR99NStC9Ft9FOAVIQw0MsHn1koshE=;
        b=E4agJvba8ZLSyyCPsWqiEnUCeRlGXYHLt9d3EiKGj0pOtzAehKxUdmZ8nkUApgtmry
         kv32n+ZnrG4XTh51kKV/Vu26QfmZYcnypj/LsgoHWBJ9zWV2F2mwUP2p2VjmTUgf3H8Y
         TzSoiGlRTaqKMMh1sseEXTqCwTnNdalR6T8YvGPYZfk2fHyFhqB8FUZP2OS/7sLQbg/9
         e9uklbvsMBD7/1naAQr9KRDhEj1NBuFucakWrQBGeIm2XCpH/TlMqdVJmxuSOw5Qz7zX
         UdSN6fu6m2/KYXd3zF9bLrrYir2Sxc1Gvo4D+zyfvIu+RCGRB73lS2oBW5aW6DGyKkdJ
         T/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729602331; x=1730207131;
        h=mime-version:date:references:organization:in-reply-to:subject:cc:to
         :from:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTtGwP6N4/w3oaR99NStC9Ft9FOAVIQw0MsHn1koshE=;
        b=sg0jId0qjoE+4HvIxeb+r5YW7pDctNdes6I5Naodus0gTmX40yltNfWQzxoJEa9qkv
         1GHPreUOqHC7LGTi4m6BmPJquShtN6HkbX6qPpIU+qfjbBVcdo+S3pxE0m94FnN6I4hH
         BCGIB5Ezpg+H1cKFbZanKuYmvyB0V+CDALHsczSk/SgA18AIKN19bSR/5eLlFA2z3hnX
         VtiU70qFyp+4LQFoHQ6WnEwIL0dvCYu9+pqQhAHerFSb6Ni+4KyBl8t7FJAS9xqAWsiR
         ugl6TFly+kuAdCwj1HA6d5us+RL3TglFQAuPjN0iC/KKm7FlMQyRRnYE2pdXU5CHvjcQ
         eMwA==
X-Forwarded-Encrypted: i=1; AJvYcCUettmBnsD4lfCqMqi/C2Ahf7HI4dwaudqKRF5kGieaSRCv53S6m+0AU9twRrkCN3zYC8ye7Sw1jxH7CY45@vger.kernel.org, AJvYcCUpdIsRDRxVptaSKfmGGbrCozvZ8ytKVjFhKruzSI6bvJF+cadv4I3HHcyIUu1kMMYOAjxKr7Vj3CZ2XwAF@vger.kernel.org, AJvYcCWz4nv820ITgTEduyJ51u+8kketD/Rfnlb6udDVMGfWQ5IIR7vfRRiNmkErL/bviNblVt6GcwE3dJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWIs9xvQNFoISC097F9UUHvYTK1ee/wWnYuRCoboY9maVC3bEO
	0DTer+1noEoIRV6wlDMajslf8hGngj11214zlxuC1LzpR4NhTOT8w635Mg==
X-Google-Smtp-Source: AGHT+IFMNt1FAG23KL5PRAg+Fcc9lV8eLt2m4nerG4ZP6nNLVnj86k2lC4zHLqPdcrU2IJB8Djtl6A==
X-Received: by 2002:adf:ffc9:0:b0:37d:3e6d:6a00 with SMTP id ffacd0b85a97d-37eab75555emr13573649f8f.47.1729602330805;
        Tue, 22 Oct 2024 06:05:30 -0700 (PDT)
Received: from localhost ([37.72.3.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b94346sm6624211f8f.86.2024.10.22.06.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 06:05:29 -0700 (PDT)
Message-ID: <6717a319.df0a0220.9b810.4bc5@mx.google.com>
X-Google-Original-Message-ID: <87ed48thif.fsf@>
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mikisabate@gmail.com>
To: rafael@kernel.org
Cc: daniel.lezcano@linaro.org,  linux-arm-msm@vger.kernel.org,
  linux-pm@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuidle: Fix reference count on CPU node
In-Reply-To: <66fc57ef.050a0220.27e956.af8d@mx.google.com> ("Miquel
 =?utf-8?Q?Sabat=C3=A9=09Sol=C3=A0=22's?= message of "Tue, 01 Oct 2024
 22:13:33 +0200")
Organization: Linux Private Site
References: <20240917211325.639765-1-mikisabate@gmail.com>
	<66fc57ef.050a0220.27e956.af8d@mx.google.com>
Date: Tue, 22 Oct 2024 15:05:28 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On dt., d=E2=80=99oct. 01 2024, Miquel Sabat=C3=A9 Sol=C3=A0 wrote:

> On dt., de set. 17 2024, Miquel Sabat=C3=A9 Sol=C3=A0 wrote:
>
>> For the qcom-spm driver, an early return was not calling the proper
>> of_node_put call for a previously acquired device node.
>>
>> Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mikisabate@gmail.com>
>> ---
>>  drivers/cpuidle/cpuidle-qcom-spm.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpuidle/cpuidle-qcom-spm.c b/drivers/cpuidle/cpuidl=
e-qcom-spm.c
>> index 1fc9968eae19..d3608f47d02b 100644
>> --- a/drivers/cpuidle/cpuidle-qcom-spm.c
>> +++ b/drivers/cpuidle/cpuidle-qcom-spm.c
>> @@ -96,8 +96,10 @@ static int spm_cpuidle_register(struct device *cpuidl=
e_dev, int cpu)
>>  		return -ENODEV;
>>=20=20
>>  	saw_node =3D of_parse_phandle(cpu_node, "qcom,saw", 0);
>> -	if (!saw_node)
>> +	if (!saw_node) {
>> +		of_node_put(cpu_node);
>>  		return -ENODEV;
>> +	}
>>=20=20
>>  	pdev =3D of_find_device_by_node(saw_node);
>>  	of_node_put(saw_node);
>
> Gently ping for a fix in the same spirit as [1].
>
> Could you take a look whenever you have some time?
>
> Thanks!
> Miquel
>
> [1] https://lore.kernel.org/all/20240917134246.584026-1-mikisabate@gmail.=
com/

Gently ping. Could someone take a look at this fix?

Thanks,
Miquel

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJJBAEBCgAzFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmcXoxgVHG1pa2lzYWJh
dGVAZ21haWwuY29tAAoJEJa+jG/YnWVl3B8QAKCIccWGVrbRZXgOT2VsW2G6ONcX
6XUtziowTvDcQJUcdRjkgXBiQHa4UpcZpOTIu7HS5/cYHfSK9U6jylcTafDNVbYr
Ry0bwgrzRzi7oLPo9cPE0Dp7YouK1dRZ70m9dOQlmaI3P7nIVOY/VxyxhKAn3q96
cfIAPXJ6nxGHa/AiSHBoCsIumJk5GshJkF4fvfVUWtBLcbtFZIOtiwWKPE7o53e5
SB4M1/RFd7U7BONpjx/a1sy54LT7tBwe+syb7qhSluNOpQDtd8JFHQu9wUv8aVgQ
N7MyWbjgHsAm/754PmbG+Tzvjovd1b827NLZPuo9F4Me2noXWF2FsE6rgTbBKCbk
cs8p1yy61m4JVJjakNC9UkobqXHHrakJ01agClVF8P/AIpGN2S+oueyeKvNa1NiF
hKKioymcUwvOYl9XHGgM9vtwbkj1EazsANAg4/21hxwDwZ6LZ+mKptVW1NwVfRKb
hm3dwiI1mStJJv7D92ZHLHZfs6SNZASnSSm4K4MSpeDyVAf5+9np4VDzSQzA79Fm
vA3GI0yEahyUiD74YG6HCOrAf7uOffWvI7JDwgye6Hoqfi3S+gwOHGwniyr54BoB
fDNRFi1alOuskUQ9m6F1z71G4IPiEVMOQY4WUFx+FHkyFi24MUiGbdDbrJWKB/Ye
3h6gl6oKry7NOzNn
=Vt1S
-----END PGP SIGNATURE-----
--=-=-=--

