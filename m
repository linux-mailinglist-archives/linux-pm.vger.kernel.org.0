Return-Path: <linux-pm+bounces-17532-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D03449C832F
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 07:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DE61281401
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 06:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E111632E7;
	Thu, 14 Nov 2024 06:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1ro2+O8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4875814A91;
	Thu, 14 Nov 2024 06:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731565980; cv=none; b=F/UCetUMhd/gr0A+rMi6z/Q7ovoMzXwACSIEZwR3sRAg50AF8EuPFe3u6Rnkxt/2/Db7QCkHrVBBBTpZG6h1mFSUsZlofGJvDoVID8AA5phMcDRwC/cGHUbStOA+EKFdbt+oIK/a1snj61NZ5b4VZHOcOCyT9s6JQIXvHWZ0dQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731565980; c=relaxed/simple;
	bh=n0Ot0L5+WMrV4KX7Rz2v201QtBNeqHjWR6bNjIll6GA=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=pRIQ1cSLYLeEew8kFq5oKTg8jFyQn2AAesK+fM3LNzj40xuoDXdeLN6xwjeTHb4+sea/W4S5YTo7gq76DOhBVv5VD6zZw4MUIl8YRGmvr1Q85INRLOBYMgNbuhjFJuBO7PbvwYVgHcTrxZGI+qtheDzv9sI1D6fqHqGg3Q3qNgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1ro2+O8; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3821df9779eso16883f8f.2;
        Wed, 13 Nov 2024 22:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731565977; x=1732170777; darn=vger.kernel.org;
        h=mime-version:date:user-agent:references:organization:in-reply-to
         :subject:cc:to:from:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6EPC2fVRBOeCo2+KoVcguN016XX5Vwvlt9Fv7/nIns4=;
        b=O1ro2+O8+hoD8L28NDcNk9Suiy8MoSGzvjp+I/IbU+4UbaaJz88oTJAqxbtmaX5RuU
         g7AYQhf0RgqHKCYeKUMQn5vd8oqp19Rg3FvAFQp3naG2PnuDYbf1LShLEc6eCQ7MMyIH
         S9yV5juOjo1Ypzrrk4PVpeF770Fpa+rhx1h0YhbKUwnyFcJbYXDTNtrxPkK6f/WAKMWv
         xA3KdJua0B1y3B+NMeVPjlUTvH7+Em7zSMS5r/cd5f4E09O8eVguByX4Uhpe/w8oYZc9
         R5tW5Hqy+5SOiWuKU/9e0KPS46oG8TneXp45AygimIUxolT7ZuV7juh0FePzaLsB2Mkh
         HoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731565977; x=1732170777;
        h=mime-version:date:user-agent:references:organization:in-reply-to
         :subject:cc:to:from:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6EPC2fVRBOeCo2+KoVcguN016XX5Vwvlt9Fv7/nIns4=;
        b=CpFZZlrtzUyMJIOt1Y3ZZj8py3MVuADIAnW7h+mNz5dLbea7JyTK2dbrZVU2AIc5k1
         B4T0RhxWpBcqIc9JpN/OsR6zl6SWppFuTeAVwqquQf6icVHvHWTNS3bxjkxoqG2gAqI/
         ZCTrNiOU5HI3JlUmzM23NmeAiF4GO2KgSuCY2fiDxMewwhYDyPzy1rZAl0UHY6XqJbMx
         uWfUIL/5KlUslEph34UD7lRXkZoPhRMJ19Piek/vri9eDicRstTLLokxuwogcLuJn5Pl
         ZEBk8zPrblBFKJ9dM5QLe2tnEvOB2xsBCPBVrOrcAUbIttwgS8YTptrTazbF/5w41f2f
         /LXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdbST8x0MV2eYsd37KsaPxQ94euzJFqXoyJQ57sF/slkmBqL8f6SJiPi9tWrZScI1t6JzbvXw/hyf3VeUB@vger.kernel.org, AJvYcCWyJRQHYXpPaLQmdJZcWHBlrQ59xVmE2H5e8AoN65ZPFcPnOkv1OxmOQ+WXPZpWGwUfvqAC3eUSQc2xWM6y@vger.kernel.org, AJvYcCXEl1lGEQsPXZHpAdnWykyFcVgXnjBtoHyn44dJa68IuK13tHzmuDGqn8kfQvAV3ebhAoe6oSr/wA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDX4HlgcOl9pgsGslobbzGVSfuErKBmlnfRIyIYhQ73fPLCz50
	Ez2JjjlRmlQ5zJWDZFKsfWIQyI730E74P/BCtSfwLsrN8HvgsKvo
X-Google-Smtp-Source: AGHT+IHrWRPpwtliuCqW2JGaN6ejoOsD4wZTB0AMCm90kjt3m5fBI8r/SkovIyxYTgWySZb6l2IO6g==
X-Received: by 2002:a05:6000:711:b0:382:13e2:acd1 with SMTP id ffacd0b85a97d-3821853cfa5mr736641f8f.53.1731565977338;
        Wed, 13 Nov 2024 22:32:57 -0800 (PST)
Received: from localhost ([37.72.3.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821adbd6d6sm541292f8f.55.2024.11.13.22.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 22:32:56 -0800 (PST)
Message-ID: <67359998.df0a0220.68005.0fc6@mx.google.com>
X-Google-Original-Message-ID: <874j4a72ax.fsf@>
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mikisabate@gmail.com>
To: rafael@kernel.org
Cc: daniel.lezcano@linaro.org,  linux-arm-msm@vger.kernel.org,
  linux-pm@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuidle: Fix reference count on CPU node
In-Reply-To: <6717a319.df0a0220.9b810.4bc5@mx.google.com> ("Miquel
 =?utf-8?Q?Sabat=C3=A9=09Sol=C3=A0=22's?= message of "Tue, 22 Oct 2024
 15:05:28 +0200")
Organization: Linux Private Site
References: <20240917211325.639765-1-mikisabate@gmail.com>
	<66fc57ef.050a0220.27e956.af8d@mx.google.com>
	<6717a319.df0a0220.9b810.4bc5@mx.google.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 14 Nov 2024 07:32:54 +0100
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

On dt., d=E2=80=99oct. 22 2024, Miquel Sabat=C3=A9 Sol=C3=A0 wrote:

> On dt., d=E2=80=99oct. 01 2024, Miquel Sabat=C3=A9 Sol=C3=A0 wrote:
>
>> On dt., de set. 17 2024, Miquel Sabat=C3=A9 Sol=C3=A0 wrote:
>>
>>> For the qcom-spm driver, an early return was not calling the proper
>>> of_node_put call for a previously acquired device node.
>>>
>>> Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mikisabate@gmail.com>
>>> ---
>>>  drivers/cpuidle/cpuidle-qcom-spm.c | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/cpuidle/cpuidle-qcom-spm.c b/drivers/cpuidle/cpuid=
le-qcom-spm.c
>>> index 1fc9968eae19..d3608f47d02b 100644
>>> --- a/drivers/cpuidle/cpuidle-qcom-spm.c
>>> +++ b/drivers/cpuidle/cpuidle-qcom-spm.c
>>> @@ -96,8 +96,10 @@ static int spm_cpuidle_register(struct device *cpuid=
le_dev, int cpu)
>>>  		return -ENODEV;
>>>
>>>  	saw_node =3D of_parse_phandle(cpu_node, "qcom,saw", 0);
>>> -	if (!saw_node)
>>> +	if (!saw_node) {
>>> +		of_node_put(cpu_node);
>>>  		return -ENODEV;
>>> +	}
>>>
>>>  	pdev =3D of_find_device_by_node(saw_node);
>>>  	of_node_put(saw_node);
>>
>> Gently ping for a fix in the same spirit as [1].
>>
>> Could you take a look whenever you have some time?
>>
>> Thanks!
>> Miquel
>>
>> [1] https://lore.kernel.org/all/20240917134246.584026-1-mikisabate@gmail=
.com/
>
> Gently ping. Could someone take a look at this fix?
>
> Thanks,
> Miquel

Hello,

This is most probably too late for 6.12, but might this be included for
6.13?

Could you take a look?

Thanks,
Miquel

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJJBAEBCgAzFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmc1mZYVHG1pa2lzYWJh
dGVAZ21haWwuY29tAAoJEJa+jG/YnWVl9NIP/jma5QpuMU5FeJv1pgiZxqNcQ18d
oS/U4tAh8CO3jmabXKi/Q0p15Nk55Phs2LcwtrHLZCssgNWg0yAARBRU1xQR6pnX
UiOXcM3EMOheulUupWJXWUDq0lA9V9+GbKWUD2efHZRFlZ5+QPHRPq7bEEnIAInz
osoiFZhCp5QBh9CFiomq2fsx2XfB1upOAQLQG4Jw+WvCtRJA6T+CiBJK16uDSKOX
dGhKvEhxix+cu8UVCyWXOOIaT2J2ooUBcsh6O6ioZdjjcfN0ywyIG5wbhwwJHAtO
gNfxnA2GvyViAiP53u7x/cp+BgbrcqxohrvjLs+5At6scKa7BOnd8p6ZKH+4oEie
Esa6h8LIxVvp9fuujbWOBoFOOT7zi/pnmOlue/IrQtUG+iGdUCB4UBbKMFdIFJ8x
4HkAyvJ3X2JfHeHeBCQ7MIkj/+dViILliFOppJHfUf4Bh4IdIQVqhrxPLtmLKY3m
3iufLcVzzF5zrd83d7z4BQCK5oqozmASwQQB6uQDfNhfjh7cTQpUxuEjIa8Xp5cB
gQcah5IYlbRxanGtk6+dAmqel/LWmOU/dStEQ8W7RGHYWHVes6Ej8QhQhIWBae5V
q+55jOfgQ6blzOVfe6fnuNcNx7FbXIzMNGDrNRSXC437LdZfh1jC1S+Q5Ou+Pal2
YCfq++43gy/wIr2U
=gfCp
-----END PGP SIGNATURE-----
--=-=-=--

