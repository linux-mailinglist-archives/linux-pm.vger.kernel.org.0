Return-Path: <linux-pm+bounces-18401-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AF69E1353
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 07:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD0B8B2314A
	for <lists+linux-pm@lfdr.de>; Tue,  3 Dec 2024 06:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46FA186284;
	Tue,  3 Dec 2024 06:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gvy1Hggo"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDF0175D39;
	Tue,  3 Dec 2024 06:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733207267; cv=none; b=OYuLL/cn0m+p6wTFLHf8lhxoTuGitoZWVSawzMvFUpU/lIbtWE08t4Z9KZgqrUiBNu/lgOmS2pbak71rPidPCFw2du7FUFCSJvxRiSik+f4sJJpTzpM7UizC8fGXhPu1tNUp7IrVw3IgUAKoEg4qVpXP4LP1mbKaVwHJ4fb4Sxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733207267; c=relaxed/simple;
	bh=LI/bonBsqvquoshTE87tvCOY90A7OExsftR71f3wPjM=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=ncH1ZM0wfp4sIY39qtstO/UnR1bYJbfJofbvpZHjLJ3zdKPR1XPI8xTYoABCANZS6kISbZn1dhpdJgffPzkVRMy7Pi06HVrH+Rq6zZsoe1wuOFhmNsQt+9Uki18EhH+gNPk/eXvozulQvD2JvZhDWiVTAI+eZx/HL/gKMMib4v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gvy1Hggo; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-434a852bb6eso47081985e9.3;
        Mon, 02 Dec 2024 22:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733207264; x=1733812064; darn=vger.kernel.org;
        h=mime-version:date:user-agent:references:organization:in-reply-to
         :subject:cc:to:from:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cfaUDncBTB/saygoiCBUucbasvqwkrGhdBOChCTXkTY=;
        b=Gvy1HggoNxUsFSk7hMrdkoqQjnTBNxrWCyaGOcxHuJr0XEYod+s+i/kMyixlntHtEo
         hHxqBuELFgijASr1Umm+Xm/mxw36jBrT3KJRqNaao0MkkA7OqAGgawKlphW0bxu/D6Rf
         +KWwh9Fqc5i6KWsQiuwKDSCSVDrPtUGo6nnv+m6TdGfYYAMibK/jI2C2pPaa3NcV8gE0
         +BvRSS/8rmXAdSYbXt1Era2GDH4QWKBhawvHXfz4/2CLEBXoO4mzb8lUDpvr7ApTfHE0
         BpOEqqoQDsJrK22W+F2rwpHfHwlFopKszG2K4hPnh1emiHz0lw/zqZ9iT6ZnigMUUf3l
         UlYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733207264; x=1733812064;
        h=mime-version:date:user-agent:references:organization:in-reply-to
         :subject:cc:to:from:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cfaUDncBTB/saygoiCBUucbasvqwkrGhdBOChCTXkTY=;
        b=HZZE9QSoOWA0ZyGyRV+nYa1a2D9JkSi4V3hlf2it9bEE9ERgN6oFC0l8o4eDvTMjqu
         EUn/Eq9SZ56CnvrXR+i5Qn5WFj7uoal5s6PDAwNP2qsq+d4U88jQ2GXZVmjr7Jef7k3c
         8rHDv29eTQrZeZUc6zOE/hbHub81U9K3JZ9L3+Vl9qU5x0d7wjdzsG2v0mX7UhfSkRWR
         qBmEf6/ppanDJhb13+YisPxF5JDY1nEIUg0RhdItI3n8DqgdWVyEQrRitYUyslD8BCpW
         2tcF97fw6TN/z1p0VcuMTK3+cHtVs0j5wQNV3CUGrDEnYUNb3/dGydOYywRXYbkWuaFo
         nd7w==
X-Forwarded-Encrypted: i=1; AJvYcCUXXIytEsDnCB/Jgi9WBht3KY3bvNqTpbFSw+jMfisBRIpAhvncaLMrga/JWtOgl9+EjjqHPskDtiY=@vger.kernel.org, AJvYcCWQd85PI1q8WsGsv1qnTlu+m0b1fLDT81UuLeVIrgS1PjuvAogPtDZrbiWVJVpbO2HARWDCW8EtfO+9mN1h@vger.kernel.org, AJvYcCXHj1km9xqSM7rXr7YRB/DdxKid04Fxssih/Wt1xHP6pDhtuJLduMMaFC/y8Tz06L9ocp4MiYVvVCC4ie0A@vger.kernel.org
X-Gm-Message-State: AOJu0YwvgwDUVQlYbTyUoK5Hwlm75nEPLlavsQrRUJ2biS2OyxtvTub6
	6UCEw6jVw0MizOlYWic28HrN5lG7N5PFZpAq8LHkeU7CHM7+k7uiC3NAMYtR5ys=
X-Gm-Gg: ASbGnct5co8enb3j7TZ9SV3fSwL1j3RagwtcuFxIcQGHnMGOf7rYZzidiTNAZp9PSii
	WQgbqHxQPQl3EAbkN9snjc6g5Wk1q5qxaTobd3aSmec7SPu7gMV4wIwpVYROvNk1fHLPodfqdQ/
	2jkyteBtLhol0GLJA24ZteWb5pzl26UcWiKEaQpynucDsILugQoz/nM43oymlDD+iB+CK2VxmEz
	qKWKJBbUsTB7gD/S/TVJh269/3YUgDSm980i5kBjGQ=
X-Google-Smtp-Source: AGHT+IGuHt+3Pvww4jjY7YZ11SceLJODY3ecrNnlpQylq6OxA2KJZ8/VpIw+iK75ibA8pdU/IeCQng==
X-Received: by 2002:a05:6000:156f:b0:37c:d23f:e464 with SMTP id ffacd0b85a97d-385fd421500mr998989f8f.38.1733207263992;
        Mon, 02 Dec 2024 22:27:43 -0800 (PST)
Received: from localhost ([37.72.3.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385edb7f4a5sm6481806f8f.98.2024.12.02.22.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 22:27:42 -0800 (PST)
Message-ID: <674ea4de.5d0a0220.2b6490.1c9b@mx.google.com>
X-Google-Original-Message-ID: <87zfld702q.fsf@>
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mikisabate@gmail.com>
To: rafael@kernel.org
Cc: daniel.lezcano@linaro.org,  linux-arm-msm@vger.kernel.org,
  linux-pm@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuidle: Fix reference count on CPU node
In-Reply-To: <67359998.df0a0220.68005.0fc6@mx.google.com> ("Miquel
 =?utf-8?Q?Sabat=C3=A9=09Sol=C3=A0=22's?= message of "Thu, 14 Nov 2024
 07:32:54 +0100")
Organization: Linux Private Site
References: <20240917211325.639765-1-mikisabate@gmail.com>
	<66fc57ef.050a0220.27e956.af8d@mx.google.com>
	<6717a319.df0a0220.9b810.4bc5@mx.google.com>
	<67359998.df0a0220.68005.0fc6@mx.google.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 03 Dec 2024 07:27:41 +0100
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

On dj., de nov. 14 2024, Miquel Sabat=C3=A9 Sol=C3=A0 wrote:

> On dt., d=E2=80=99oct. 22 2024, Miquel Sabat=C3=A9 Sol=C3=A0 wrote:
>
>> On dt., d=E2=80=99oct. 01 2024, Miquel Sabat=C3=A9 Sol=C3=A0 wrote:
>>
>>> On dt., de set. 17 2024, Miquel Sabat=C3=A9 Sol=C3=A0 wrote:
>>>
>>>> For the qcom-spm driver, an early return was not calling the proper
>>>> of_node_put call for a previously acquired device node.
>>>>
>>>> Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mikisabate@gmail.com>
>>>> ---
>>>>  drivers/cpuidle/cpuidle-qcom-spm.c | 4 +++-
>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/cpuidle/cpuidle-qcom-spm.c b/drivers/cpuidle/cpui=
dle-qcom-spm.c
>>>> index 1fc9968eae19..d3608f47d02b 100644
>>>> --- a/drivers/cpuidle/cpuidle-qcom-spm.c
>>>> +++ b/drivers/cpuidle/cpuidle-qcom-spm.c
>>>> @@ -96,8 +96,10 @@ static int spm_cpuidle_register(struct device *cpui=
dle_dev, int cpu)
>>>>  		return -ENODEV;
>>>>
>>>>  	saw_node =3D of_parse_phandle(cpu_node, "qcom,saw", 0);
>>>> -	if (!saw_node)
>>>> +	if (!saw_node) {
>>>> +		of_node_put(cpu_node);
>>>>  		return -ENODEV;
>>>> +	}
>>>>
>>>>  	pdev =3D of_find_device_by_node(saw_node);
>>>>  	of_node_put(saw_node);
>>>
>>> Gently ping for a fix in the same spirit as [1].
>>>
>>> Could you take a look whenever you have some time?
>>>
>>> Thanks!
>>> Miquel
>>>
>>> [1] https://lore.kernel.org/all/20240917134246.584026-1-mikisabate@gmai=
l.com/
>>
>> Gently ping. Could someone take a look at this fix?
>>
>> Thanks,
>> Miquel
>
> Hello,
>
> This is most probably too late for 6.12, but might this be included for
> 6.13?
>
> Could you take a look?
>
> Thanks,
> Miquel

Hello,

Gently ping. Could you please take a look at this fix?

Thanks,
Miquel

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJJBAEBCgAzFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmdOpN0VHG1pa2lzYWJh
dGVAZ21haWwuY29tAAoJEJa+jG/YnWVlaqIP/R8tl643SQ35Lmb0nmO8eJvUl4BL
uBRali85PcRZdAg1q6rasoeLLEX5MtEylX+La6uCvrbkfZgULfHB9KAiwhZxhz7f
Oxb4TonDT/um1GhKNW8KJv6I55TrdMgpEVpi1jhCp2181cM/09VfS2OQdrDLvofG
Fr8vu3/6UhawAKCPwCE8hYZxCkidDLdUwZmGdGjPAVBpRClIQgZg133YojbCWSfF
yNHRjEA4EXiA8yccbz3zZmMV29n/Tnk5Kzs1+b2xxpnFTF2f/U4ll2eeCjnOON0y
An09y0+3u/ZrkTo9OTLBma+WRkbIeHRrjpoGLEGKZ4xAkdUmUxOz9G0LXEp6Al/x
CMYHHQ/lOyYsMyBMzf92t5T0u7GGzwVKJPGYg54feD9xaOZEMKBEg4mhCYpTES8V
1TkRB1ai0t/p7v/FPoiuMtxy0AJryXE6a7/xrJKivrj6fIS+4vZ05tp6qYBoBmvH
PqXF2t8FGEbQtgH3eu2HszHfZQPrN8Ju4mQoTYWaQRp878Ijf6fUFCtLn2lVEFT0
DNgAlIH+wa4kKEslOS4tijDmWnwojNrjDz8sKlmtvt4ZMiG9KX8e0c6fY7kbaUK9
OD6qzbF79rFTeF0VD7pFiMsK4Es/KsnaDz2OobhZp+X3lSuMfXKBxKa1MVJKPHga
SBzBT5ZtQzeVVRVL
=iEi8
-----END PGP SIGNATURE-----
--=-=-=--

