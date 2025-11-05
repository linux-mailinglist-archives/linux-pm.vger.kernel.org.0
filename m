Return-Path: <linux-pm+bounces-37429-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6F0C34D6D
	for <lists+linux-pm@lfdr.de>; Wed, 05 Nov 2025 10:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1EF17500F2B
	for <lists+linux-pm@lfdr.de>; Wed,  5 Nov 2025 09:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01C93093AD;
	Wed,  5 Nov 2025 09:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="LmF/OrBN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E5D3081C5;
	Wed,  5 Nov 2025 09:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334381; cv=none; b=RVavKTfWs9n1WYx51xfxjTC/XzjtZowIF9pcVjyijDEKqM2R3A3Thp2O4cNApN36Mprsv+SZc84oyqrtHdqcK8XuGfauENMRXH5CRmJgibgyCyS0suzSE+ajZAcf80GYY8TK8EIatx0+lkTZFK1izTN5Ownv1/0P+//fWjGcgqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334381; c=relaxed/simple;
	bh=FHc/5nnd3Oq3LqajaBYBvkHNMe+myVHABTLRTkNMEz8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=U+vLbiL95HYNTbplkzlxhRTAwwndSt9fa96MMMKNaALLPoLxVDHW2l+nQqb882Kqd37jYOmlYcDWDNYJmCt6zAHa/KsBILn2YodZrTKP7H2e0fUkNTQcGByWRhQWatSpFCLqXnuGX4n8NDbwxHFEHuIafVzuY2sX5wnyRRcARXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=LmF/OrBN; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762334295; x=1762939095; i=markus.elfring@web.de;
	bh=rNyaqEMzf5PwQFoAkll76PstcYetzrqPcbSL2Ppqlkw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LmF/OrBNsqq/qQAevCKPczPEtpmq48pErC0piPYrB6zBsDIbvVJdzSP0VB+yh7pN
	 Rn7CaBw7r96Ko6EKfLcc2c5YIJLJAcQR0xeO6JpX9XNk2wo3SXEqo6hdWSg7OxvTG
	 l7Mcq5+/Lj81MRkxgK9vNCqeO50o5J+gBsEZieC70i94QCE5akeQxzK8qu9du9o+t
	 TFpKwAcsLtbeb+xBL3a2Y6Agfm0PwEl/ICBsqdWNMv8zfFNokTYVsPby6t6Jlk5fe
	 t21JSVORX359t0zMXromEeTbhJgYR+fAgoQh8VVfctMJKyE/0W900/F1LwDFFKX7P
	 IJwB5r5WtHh8LtCmbA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.250]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MOUxu-1vayaH05U6-00Sz71; Wed, 05
 Nov 2025 10:18:15 +0100
Message-ID: <221c2b9b-4809-48d8-af7d-f290d1c2a7fa@web.de>
Date: Wed, 5 Nov 2025 10:18:12 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ally Heev <allyheev@gmail.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, linux-doc@vger.kernel.org,
 workflows@vger.kernel.org, Joe Perches <joe@perches.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
 Andy Whitcroft <apw@canonical.com>, Jonathan Corbet <corbet@lwn.net>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Dan Williams <dan.j.williams@intel.com>,
 David Hunter <david.hunter.linux@gmail.com>,
 Dwaipayan Ray <dwaipayanray1@gmail.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, Nishanth Menon <nm@ti.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Stephen Boyd <sboyd@kernel.org>,
 Viresh Kumar <vireshk@kernel.org>
References: <CAMuHMdV+12MoAGNHC9kf==Bt0cLuJ39Fs+W61DN67sE_p-u=og@mail.gmail.com>
Subject: Re: [PATCH RESEND v3] checkpatch: add uninitialized pointer with
 __free attribute check
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAMuHMdV+12MoAGNHC9kf==Bt0cLuJ39Fs+W61DN67sE_p-u=og@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DYJu9EGNAhrsI8v7EPsbfbDtutrl7wrenk3koINlfr+Y2C2mHIi
 Y+23WGB2WGkGXlA1/vg2g/i5Vr99GHiUh/FnQRYhUlGi/qFBe7qhOL8o52A7ipUSNRSmaPW
 OWvjIcgY8lvVTRMURV3MP5EtlFcnQf/hVzEZfp/VPfoDDcCbntwf9GSHdvz9+6CG7N9LxQ6
 jq9FMVQpRZMYAPlZm3dYg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OQWgR6Gh/20=;9zZvaQwKHS33FAH6LwWbrnG+oHV
 5/r2B80ulLauE2kP8rfNc4RpNChBwMa53HFOvHrFAtJIVCwssZ+xbUkUDkyJugd74X62bgJ7s
 lkA98PqxV+XFX1nDBz2eVhgqW2BtefeE4ywlg5iUsYK3TRr6MpKrRlUWzg7RRXILGBcaMWUjt
 NbYGNvt8bysYW2UIMG82g4o0Tul7qPFOUp0vD7JxGZ9yivKBPC0cES5orUVjoDEZjkajXRhCu
 ihmMs6Fy+vZLQQmsPIgEy9w/JYgqW9jeSoHp2iRC+w4ttvzjADIdU3KR9+bs7R3TZBKCD4ay8
 zXd9Z76UCb2zGNPQT+MYIanjOaN94iQLih0+AjYFwa/tgwKN1yaBqyETe/usePHdworurUsi3
 fa07+EQjHEACkbFxEzEa/Eg64pv1P4nDhHvLcIQmK3ETR88l/NC4YLqXNcSUsYHqnawAoOP+6
 Nkj6y/TCqNnFOLcWkusv8eCZFyU8VoBapWM7HnFdnElXauyenXjmChq7ETDr+zLSc/Qm/0tt5
 kKNX4lHOhacQREAthq1oBzgEW3WPhyXYJRx9hZL+e+UAUGw14cgCDtfw745RNpX2ywTQ5Jljk
 exEvbXOZYqtnIOCrHFdsUfJ9k5MqlkwIhm2+SjrGili6aToE6vxmw/oTBujc3fLhs7J5FLW1N
 P15UqQB0wmEi8LJXls9DZADSfWeICrQBDpGbm66nueRI5/o5hb1llUseF9nV2VlxHXs9PjJ5l
 djWVuZqaoqtNxdtNy46po+M75B9dt50Ywe0HDi1L+kdvq06XkiREBD5LmEC5oVqfR2BKlPdUq
 FAhQ5led6BNUV74Z2z84Vt1jf9KtDboW21zWIz5JmNxmxAi/r656oZeeBAGbB2XRU45JOVu58
 2dpwVSQHXr2f4U+ryYyKk9k4UFZKKJuvD5F1zmfybyMgIT5Vv7sQoh3s8gVs6QYBUtjN9CBNH
 9hKSaSJYIvstuXd5GZE23pw98NcfO+YXifC1Q0iLv4wXysaXs7bvq1FeLCyDuMPjuzCq3hD2P
 HzhWsngMA73Cm+dJBDnB86rjym/jf0FTpy7U4dL22EenVAy/I1HXKzdGvlx99B9TwCtII+ngU
 5GN5vasXhD6BNwffNHF6Pa7M6/0kCtoSvKgHGo0fJdsTFio0NAibubxG8PeMoQ1wEHEKojey1
 9fYg/wsKrcMWEXcGIrIHXk6+L0fcjQywJbB6/gRQXynpg4FcQiKPCwO9paPK7FhAlcFVCGsHp
 n5S11qRwNP557/rAC+jrqgYBzl3cILcOrO9doO/UwBnKkRFxfJIa/EcQgWMaUajmWA9Oy8xce
 PPemq0vlluaIpC0tJ0f/EhJTozU4/92muJURytk/25t06htmdfKajYn5sg+HkOn6l5B8xbCRm
 M3TuPk7ok8mcLWIvjguOQWmVSki0fr2sIrPYOnTOXc1Zv1beI2y0jb4N73CaM4MZQGbeWX+og
 9FUcuUhwKjRYT7PUMRuW4x6+/0AuoB4IJ4xitPXVKoEzLFThhmdYzJWuPhNTQDMGZEWEokSvj
 qU3NnWzqvct7TxhtsXF+GYyrB+jeJ6ljmYv1Se77hE5KB3Jv4VzoaGMt2mCmUU4CvVmxi2OaJ
 cXAPRPkXB5DTfU1kKozc4Irf1/bzhk+25Rg4sPsiSW4crSvGwMfSlLF6xYS1Wddunyr63hckx
 lI3iEGZ+2DkK10K80rAJwORzCLMwpdzYborpyhq656o4prDRHJKTfl0ahcOsaLdL1b3ENr8lQ
 CYI7WWb++Sp6c2JsDsC1uEPmw2W0pZRDz6hTRCZE7lY5APc2hgZ4N6yii0Mldq+RJWFzngygT
 R4z6fJLl99XqFPwpIdnvLC6pzlyOcQnP9Kn0ExQtFKIuh+hSUACBOvpd3P4ZZZv1Xq3L3vQQE
 6dU27NJ3rznvoJXBtWWKyeE9BRy05QHFVkn0pACO/AadJ8RU9J+WrdtG0gyn7TNYU2sEBKSNk
 0PmWRHTwK0IgtY7nhYnoCD/qihHPxSuPIGcUMbGw/s+dGarVmUaC/2MD+i7z+xgzQSci28giX
 rmE3VK3++RdBJsbV7fS58Od2J0Gjoj+yYRomDH7HhrQ8eO1TVcjI1S12Gf6zX8gRtmfdVGFlp
 MuymdTXV+Rbamx81YANesvmtfuAHjTTqoILi9oJ7DsansqwOQpRYxUG6Pj7eTj5mWBPtFw58h
 gz9UOmU847xDcfAoOqIhSUuUujGBpACW/brBKDZmcI1y5hUc0EjUDl+Adq+NHWU8bd60mUUwd
 qM2FluwFcajjn/uhs+oG/Ywz7yFPHwRZwJHuF/mwTOoxt+WW2tpAeOwqxE0O56fifbw1opDKp
 ZnOFHSTgIAob2yJpxj0uCDo9GOYcjtCFPmDxTa7TXoRy8AynjqoqvnZhU1zJ1gAbi0B656Uic
 luYxKmwktBhU7KKOPPpi+pXDuolzKl+Txm4ycu4FYtAeSaalx8yoNOgd78aqvr8Qc+fgUcDCH
 bCIzRZ8ZiUwrqdT7IrbZejfVMZkyPnRYTu8ZJcM4taqD3EkGGYxTTWxQ3NzKdylId9LmsGLgx
 2RZ+Ggnfb55x0btEsXch3ia8zp2AmJdtEAz37F3IjJgtqBzgfhxbpM7uVq+x/+90hwr5tVMnt
 CZNohGvhoZrC2oVH2ZycQIf2/i9u7vz+w7Ex3lUEKo68aEmnfMCRspuZtVdoRkhcPsZW9iMTg
 78zhKZyFbYpaB6iZoTRYETE31AJ6ecA9YoR3TrMqNYvCY/k7ZbDa9+nkzA+YkZU+vg5tTbLXG
 mjJexM66irLmgPQWAbiOhX2bdak+W0ZLEjy6BQhwCJ0xMxmKUKSzCZrlIrGv49sY0vEq52Mau
 6ULgvDDad0NkozeOZlPxfrIfF3BWQdqHwtHn3+VMOCyCJm9p62y9CYbPNGpnUGWjhwVxWYkkN
 3Ty9ddcdqAHr5qOJScIxIYZEK9Kna1ptpSSU+1VQFifmL4r3LFS14QtqaHRMiIHSzL+6w76eA
 v3KXfGmMn70EhyaHCXDmqDgp3ei4ZmdcS0Zu7VjzIJfALTnaRby1Gs3v+KI0aWid5mIClIIwP
 szuemnFCEU39mmAMvsGGNXbKkd0EauixM35PrXvKhSzAyA0PiHN6kZZphmWOg7vgVMTb6lLdU
 UB0oHQ71P2C4gubspXpM+nYXjm/luOvqg8MbxJPbY/bO+wo+kYdFMT7CYoQvzI7HsdQmF8Q7n
 DE2eRdv6jzxoMmHZRnPCJEqJ+0UYxOMQfACl6EtC29v0ygWc4sy8N6kuGucEn4qY3Bqinoylb
 fWH79cL0mWguWBsD61/qEYYC+eddSyJRqX6UF9DL48ksmVnIdJyAjxX454vFUKHPfO3BpumrC
 OTf+FhitR/hIs/N/+4HmdJOfUsT8sCroTauj5TtdFhFzgr3mEX18LBkxgrw65d8yInlMkSqWM
 fV6CcoVKO4tYdLtaDTLISz6AojYJ6JGZMQ8aJJxS+TCPSJyecu4pVz7vJbrZPl+P2ByZlUoav
 SdgFY40wJDaGVLQCnSKIRXWWZaozFlyLU7aQOV75wQcISjVLyiLkwDniSYUQA7a+hZgQQ+2hV
 YbAXv/Oo8X2Ns3UklGOWy4iaxWIOMt1nFGjJ+ZjafKiIU/z36JNjaWK9ZUbG/hJfvzLTLfBGK
 hZSwuV/JmpZOCwwlo2m4qTeZ3w1UL51PN/vtyPtZxV3v4S/SF2jqI7GNebyRFGwHV2reumYPU
 3NR6JybQFplKH52LAQsrPGhTHzKD0eghkB30XlpvpWn7LTkH0ZSkERy7On5fmBkNTSuRF6du7
 admbO40GMi8/P0D479gWt3c/WStGwZsR70TsZefvswmwjJ+Z4vXlyeiU4WyocNLJqRTqvF10a
 4mSOXX9SWyTWKWhqZFAifJKSbimO57g7goDz/uerI/DTRNWHtNtQTpGsxMAExsRtoiMwvGbBD
 g5D0XD/VXrQXESBKq+Qlq87Kz9M9dorzMjMFffVE64PIXwJxfvP4IInSUPmSTJkz+5BZZXshI
 2vLN6Q2ozBPbxPJVBa93yhBt7jWYyNy/r478UhvF6S/5IEThK0Sh7JyU7CPpyEI9BO7FXeIaw
 FIhHYC1dTcubJQDzC1jECd0GCyJVb6o30NI6w7lthOEvnLr8p84PXjqA/x0on/XcKMqnBd2L3
 ENZWICrnLdYSUk0f1hjPq5PkMwDsXFQYRE/BWKu7eTb5nrjtAK0/XFyG0ptX8GGID1VmMMlH8
 RVYSDfqxxg/lCQJXbwBxWZ24SE7dBl9fpOMQM1OLYdI4gPXvcTfEESp5o/+XQwYGyJJDCAK0o
 qE3rc1YlZXnjA8piBRATNrlkOyRBW53K/aijFiC2Y+6zao5HFeHW2VtCtXwwU/sqhv7NFEAiO
 kqqxMLEzhrkBervQUgoJG9WzP92w01TM/pM9F1KNVRKWens4ise1EEBjGOZjgPtsFhopGCFdj
 7tEn23IBLcnfUK2W/SqgxuPxVbWkZQfatqpRTjy9Ai6dwmr4xGIQDIO5Phq74JTRGZEJFWl0Q
 hO3mSKVkal8Xi1JrlxhCsCTarjxq5N1WTnSYMJDu63L6gImu8FuVuC71ZfS8XU33B0MIyDs6S
 YQ1QKMGVthuRaP+1r/5lciAZrX4jTwpDuTSh4TUtN15c8rJ2dNqwz5VLjRsHjQSZhqOkZ/sbg
 JjDJrg5NApdxdec0YbUlZpFviS1fxQCPgAx8+o8DMuCnsOZVqPaiVtUATR8ZJFdLJ6ayvfknS
 dwOSpiff6edD8vdqSCER4fb0rKstCWbtPMsmAQIy2ll1UbN1+OfoQcwRqfpLPHXQtZZbGwwbj
 gxQqD60piofebWxm3Uo0JVMMXkQ+g0LbdD3xqm15yJFrN6kFBwOna4Eh3uzzFBWKjbd2RwAGJ
 2Q9W9ALtlw0wjGAxI+W/Z5R5qBV9cLia+ogUaDvsd8hoUBOV1RjVQ/XIprvS6GZJsfu0fLD1A
 eChKHNy5c2pgAFvMDUKhp12bu0fV2pKw58+YSnAXRUnpX2XxrlqFE10wEW4p08ssqnnWzaJIM
 4Mey/ShNfftPRy1YKKhXNX8qJoveQO/RiW1M9nQ0qKUggH+kdiq76bVbVqv22XRw3ahb1O7tv
 kyiqdKg25RBwQ7DerL5gxkuXEQvR0LHswqSdJ9FxKOlvOxnWWW5Eg31cBqkgWG+/E5doqN41E
 ujjmSJSAA6Da2cr6A=

=E2=80=A6
> > +++ b/Documentation/dev-tools/checkpatch.rst
> > @@ -1009,6 +1009,11 @@ Functions and Variables
> >
> >        return bar;
> >
> > +  **UNINITIALIZED_PTR_WITH_FREE**
> > +    Pointers with __free attribute should be initialized. Not doing s=
o
> > +    may lead to undefined behavior as the memory allocated (garbage,
> > +    in case not initialized) to the pointer is freed automatically
> > +    when the pointer goes out of scope.
>=20
> I think this is misleading, and can be improved: if the pointer is
> uninitialized, no memory was allocated?

* Do corresponding source code analysis requirements indicate a need
  to perform data processing with other programming interfaces than regula=
r expressions?

* How do you think about to mention the possibility once more that scopes
  can be reduced for affected local variables?
  https://elixir.bootlin.com/linux/v6.18-rc4/source/include/linux/cleanup.=
h#L142-L146


Regards,
Markus

