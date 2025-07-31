Return-Path: <linux-pm+bounces-31667-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DE1B16D1C
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 10:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80E627A25D5
	for <lists+linux-pm@lfdr.de>; Thu, 31 Jul 2025 08:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D7A1D618A;
	Thu, 31 Jul 2025 08:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M12HMhU/"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74ED35971;
	Thu, 31 Jul 2025 08:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753949050; cv=none; b=lBjFUU/VM+NZenNvCY0HeVLn6avl+2jyzVvnKyfqjQxE6A/mDN/Zl7XyHnhuSX3L1s2O22YEzsSYMkaR9lmJT+NEH8sjishU5U94aOCIDDS2hWpCf1OJp19pHlaRgQPTS+x/YgZCKtgbprVazK5R3nT3RZ6vg8pfPuW08ZzBWJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753949050; c=relaxed/simple;
	bh=AgbVh1CEz92NPUD6ZrmJ6p3hN4MYSqp+AJ+vqPcyZEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QBWMCA5WJxoqLbpnerdd3tIjBPBH29sIJxoTE41CArpvPEp2EJi3l5jVYGTw0ewN7axDABzak5faTMGPOTX/hsLqACUUxjJA+7hx1tgGUGh8jmQwHdfwzYnrJU2xfcrJh3QIAy5UbpB7JngVBYKt6vOaA3jbx6uY8kRp845e+zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M12HMhU/; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-455fdfb5d04so3013585e9.2;
        Thu, 31 Jul 2025 01:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753949047; x=1754553847; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:content-language:from:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AgbVh1CEz92NPUD6ZrmJ6p3hN4MYSqp+AJ+vqPcyZEY=;
        b=M12HMhU/oZfiMFRIfFbibH+53iNYvuKzMT9tGpd/dIMIHyTNzUZRALFCGzCQxCVSRi
         PdRm4BvywRss7KKZ73IDMoeduOH7EP1a9y1+M4jITJ8VWRMcau4fHhK0Ypq8PgxPKSoN
         /TrDhiLzMQ4JNWZiSksVJZxGoz/80+3q6WolwaP9OVg0HcZCam3DjFYmvo1hH5AUPwLc
         nvldhgB617tDF+qiEpo+9izAnL6/moty865RWYizoufF1sQ5IQF0rNKBi2DzXW/6wNAw
         5LY7077bHRscjD28M8Xvk5YKM94lpMDnkp6PCcaz0ECw4youCJIV06OS4oHolv1rHBPD
         AhKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753949047; x=1754553847;
        h=in-reply-to:autocrypt:content-language:from:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AgbVh1CEz92NPUD6ZrmJ6p3hN4MYSqp+AJ+vqPcyZEY=;
        b=TXCF2uoRYl6pOwkJR42ExKTr/N2dCY4WIM8oxrDa2vwi7WqHgnGuZCkoCN7AI8keVm
         h2cNi96I5iGm9VeaSm6HBjf4514MqZ5WOjQw1agEkOuENVkq+jvHwsLCd/exmwQWc1WL
         WhaR9FIp+Aeukv7VstuTbmkwdE2h5kUMmWF6oQfRCb7WWgFHYr8bZH4NkURR4bhft2du
         JWqkTXJQaUeq+ItK2bsMO9GLyGfOBzDdQJ9sg2k1pTvo2VRljuDepiQVlZJ0z8gTfgr+
         SBkEJsSHGDAoV+YWPa11MQcuOsU64d5Zj8F3pXs47nWFkRZQrT9oQMA0KcAyJyujvQUM
         JxZw==
X-Forwarded-Encrypted: i=1; AJvYcCUwGvmmZbKHw2madxVRHBaN9j71zBLwSpnL/YCicZeeh6KRHTjiYMjfzqj8ycB53Nsu7qhJShSSsbUZrbo=@vger.kernel.org, AJvYcCVV5JTO/a7TuFl9/MKi2q/dvDdk59/P2rxwieXqH4w9tvoQ+hxVBgrep+J4d2eRvqiUw07amDkdJ3Y=@vger.kernel.org, AJvYcCVgmg+6qmsowiVoC+5ZMy+hrEeuxM1bdfdfj8SlxMpL3pRI5iqxjwuNVye5WThBFVwGqXbAqBDQa/4Jgvw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn0NQaJyUz9V5qOpEijpEOSV7aQ+u93/qT5dPHp6o/Wpm8F1Cc
	8tkVtdOB+1otdWNCi4TBkI5CTeVn8E/9cbLjRZPtltUlvc4baiTgCM/tePZWS63ZMrMlNw==
X-Gm-Gg: ASbGncs9izZo/6fgdE7K/43O8lfQ7Gx7p/JMiUoV5CNrdNLjphb3Ax8qtnv/Ob6vEnP
	l9pbAryWiaZQHRSRPF/GCJnpH51/q2c085wj4H4e524eARq+Hu++VxfU05Wjhfiw9YxBey3ARpq
	PIFxfObwwq4wVnXpoYCIA419ffovAuKKZqZhlkkBhfL4Reo8pXNTA5TyJ45MIQcGG+Td+CgJ7d+
	ndw8Pywet+bwSSDgL5yNVuHHUeckHp2hh2KCCmq1swoQ/tHOSLSQftQbc/rXELONhlVA55hfY/K
	ku+2x9UabUBWX+lUj2DP6RHkKxNfcgWeysVI0zkb3ZNnM7BOlwSHKCmp3a9HcOyI2Rs9yt1Ndiv
	P+zwKAgEBnUnnlNSXaiS7HTQTxuM+25qPa1+t48Q=
X-Google-Smtp-Source: AGHT+IH1sb4ZSAyM5jNaon3LK0QzXCh5Q/LCPDPkv+eTSe46SNjJOSNE3tZFQULa/FHuTy5dp91Jcg==
X-Received: by 2002:a05:600c:6216:b0:456:12ad:ec30 with SMTP id 5b1f17b1804b1-4589e53eff8mr22911385e9.13.1753949046620;
        Thu, 31 Jul 2025 01:04:06 -0700 (PDT)
Received: from [192.168.1.248] ([87.254.0.133])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4588dd4d477sm62216185e9.2.2025.07.31.01.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 01:04:05 -0700 (PDT)
Message-ID: <0acab3ce-4053-48d4-8766-45f5841cd8a6@gmail.com>
Date: Thu, 31 Jul 2025 09:03:30 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] thermal: tegra: Fix dereference of pointer tz
 before it is null checked
To: Markus Elfring <Markus.Elfring@web.de>, linux-pm@vger.kernel.org,
 linux-tegra@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Lukasz Luba <lukasz.luba@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250730135441.2078022-1-colin.i.king@gmail.com>
 <cad798d5-fea5-49ea-8b27-8e05cd888806@web.de>
From: "Colin King (gmail)" <colin.i.king@gmail.com>
Content-Language: en-US
Autocrypt: addr=colin.i.king@gmail.com; keydata=
 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
 FVPMkxl2UyaayDvhrO9kNXvl1SKCpdzCMQ==
In-Reply-To: <cad798d5-fea5-49ea-8b27-8e05cd888806@web.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------gQ6809SG9iftMadf0pqSW8dk"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------gQ6809SG9iftMadf0pqSW8dk
Content-Type: multipart/mixed; boundary="------------06d9JEVvJG9bfwGMip9Hd0Lu";
 protected-headers="v1"
From: "Colin King (gmail)" <colin.i.king@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>, linux-pm@vger.kernel.org,
 linux-tegra@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Lukasz Luba <lukasz.luba@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <0acab3ce-4053-48d4-8766-45f5841cd8a6@gmail.com>
Subject: Re: [PATCH][next] thermal: tegra: Fix dereference of pointer tz
 before it is null checked
References: <20250730135441.2078022-1-colin.i.king@gmail.com>
 <cad798d5-fea5-49ea-8b27-8e05cd888806@web.de>
In-Reply-To: <cad798d5-fea5-49ea-8b27-8e05cd888806@web.de>

--------------06d9JEVvJG9bfwGMip9Hd0Lu
Content-Type: multipart/mixed; boundary="------------dm9VFblLET7VIJ8jVTf4pYlh"

--------------dm9VFblLET7VIJ8jVTf4pYlh
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

U2hhbGwgSSBzZW5kIGEgVjIsIG9yIGNhbiB0aGlzIGJlIGZpeGVkIHVwIHdoZW4gaXQncyBh
cHBsaWVkPw0KDQpPbiAzMC8wNy8yMDI1IDE4OjQzLCBNYXJrdXMgRWxmcmluZyB3cm90ZToN
Cj4+IEN1cnJlbnRseSBwb2ludGVyIHR6IGlzIGRlcmVmZXJlbmNlZCBiZWZvcmUgaXQgaXMg
YmVpbmcgbnVsbCBjaGVja2VkDQo+PiBsZWFkaW5nIHRvIGEgcG90ZW50aWFsIG51bGwgcG9p
bnRlciBkZWZlcmVybmNlIGlzc3VlLiBGaXggdGhpcyBieQ0KPiDigKYNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGVyZWZlcmVuY2U/DQo+IA0KPiBSZWdh
cmRzLA0KPiBNYXJrdXMNCg0K
--------------dm9VFblLET7VIJ8jVTf4pYlh
Content-Type: application/pgp-keys; name="OpenPGP_0x68C287DFC6A80226.asc"
Content-Disposition: attachment; filename="OpenPGP_0x68C287DFC6A80226.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBE6TJCgBEACo6nMNvy06zNKj5tiwDsXXS+LhT+LwtEsy9EnraKYXAf2xwazc
ICSjX06efanlyhB0figzQO0n/tP7BcfMVNG7n1+DC71mSyRK1ZERcG1523ajvdZO
xbBCTvTitYOy3bjs+LXKqeVMhK3mRvdTjjmVpWnWqJ1LL+Hn12ysDVVfkbtuIm2N
oaSEC8Ae8LSSyCMecd22d9PnLR4UeFgrWEkQsqROq6ZDJT9pBLGe1ZS0pVGhkRyB
P9GP65oPev39SmfAx9R92SYJygCy0pPvBMWKvEZS/7bpetPNx6l2xu9UvwoeEbpz
UvH26PHO3DDAv0ynJugPCoxlGPVf3zcfGQxy3otydNTWkP6Wh3Q85m+AlifgKZud
jZLrO6c+fAw/jFu1UMjNuyhgShtFU7NvEzL3RqzFf9O1qM2muj83IeFQ1FZ65QAi
CdTa3npz1vHc7N4uEQBUxyXgXfCI+A5yDnjHwzU0Y3RYS52TA3nfa08yLGPLTf5w
yAREkFYou20vh5vRvPASoXx6auVf1MuxokDShVhxLpryBnlKCobs4voxN54BUO7m
zuERXN8kadsxGFzItAyfKYzEiJrpUB1yhm78AecDyiPlMjl99xXk0zs9lcKriaBy
VUv/NsyJFQj/kmdxox3XHi9K29kopFszm1tFiDwCFr/xumbZcMY17Yi2bQARAQAB
zSdDb2xpbiBJYW4gS2luZyA8Y29saW4uaS5raW5nQGdtYWlsLmNvbT7CwZEEEwEI
ADsCGwMFCwkIBwMFFQoJCAsFFgIDAQACHgECF4AWIQRwYtqk8AG5xmFnAM9owoff
xqgCJgUCY8GcawIZAQAKCRBowoffxqgCJtd/EACIWcaxfVt/MH4qqo5ELsjCFPVp
+RhVpQDWy8v9Np2YbTcZ4AY2Zj4Pq/HrZ3F/Bh02v85C6mNv8BDTKev6Qcq3BYw0
iqw6/xLNvRcSFHM81mQI9xtnAWIWfI9k5hpX19QooPIIP3GOMdMc1uRUGTxTgTFA
AsAswRY3kMzo6k7arQnUs9zbiZ9SmS43qWOIxzGnvneekHHDAcomc/oho7kgj6rK
p/f9qRrhForkgVQwdj6iBlW934yRXzeFVF3wr7Lk5GQNIEkJiNQPZs54ojBS/Kx6
3UTLT1HgOp6UY9RPEi9wubmUR+J6YjLRZMr5PCcA86EYmRoysnnJ8Q/SlBVD8npp
GVEcuvrbH3MBfhmwOPDc3RyLkEtKfSTB92k1hsmRkx9zkyuUzhcSnqQnpWGJD+xt
KHvcHRT7Uxaa+SDwUDM36BjkyVcZQy8c+Is2jA55uwNgPpiA7n82pTeT+FRGd+7i
CLQHaryu6FO6DNDv09RbPBjIiC/q814aeKJaSILP1ld9/PEBrLPdm+6lG6OKOt9D
DV6jPmfR96FydjxcmI1cgZVgPomSxv2JB1erOggB8rmX4hhWYsVQl1AXZs3LdEpJ
6clmCPspn/ufZxHslgR9/WR1EvPMQc8XtssF55p8ehRIcVSXDRcMFr3ZuqMTXcL6
8YbDmv5OGS95O1Gs4c0iQ29saW4gS2luZyA8Y29saW4ua2luZ0B1YnVudHUuY29t
PsLBdwQTAQgAIQUCTwq47wIbAwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgAAKCRBo
woffxqgCJo1bD/4gPIQ0Muy5TGHqTQ/bSiQ9oWjS5rAQvsrsVwcm2Ka7Uo8LzG8e
grZrYieJxn3Qc22b98TiT6/5+sMa3XxhxBZ9FvALve175NPOz+2pQsAV88tR5NWk
5YSzhrpzi7+klkWEVAB71hKFZcT0qNlDSeg9NXfbXOyCVNPDJQJfrtOPEuutuRuU
hrXziaRchqmlhmszKZGHWybmPWnDQEAJdRs2Twwsi68WgScqapqd1vq2+5vWqzUT
JcoHrxVOnlBq0e0IlbrpkxnmxhfQ+tx/Sw9BP9RITgOEFh6tf7uwly6/aqNWMgFL
WACArNMMkWyOsFj8ouSMjk4lglT96ksVeCUfKqvCYRhMMUuXxAe+q/lxsXC+6qok
Jlcd25I5U+hZ52pz3A+0bDDgIDXKXn7VbKooJxTwN1x2g3nsOLffXn/sCsIoslO4
6nbr0rfGpi1YqeXcTdU2Cqlj2riBy9xNgCiCrqrGfX7VCdzVwpQHyNxBzzGG6JOm
9OJ2UlpgbbSh6/GJFReW+I62mzC5VaAoPgxmH38g0mA8MvRT7yVpLep331F3Inmq
4nkpRxLd39dgj6ejjkfMhWVpSEmCnQ/Tw81z/ZCWExFp6+3Q933hGSvifTecKQlO
x736wORwjjCYH/A3H7HK4/R9kKfL2xKzD+42ejmGqQjleTGUulue8JRtpM1AQ29s
aW4gSWFuIEtpbmcgKEludGVsIENvbGluIElhbiBLaW5nIGtleSkgPGNvbGluLmtp
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
=3DQKm6
-----END PGP PUBLIC KEY BLOCK-----

--------------dm9VFblLET7VIJ8jVTf4pYlh--

--------------06d9JEVvJG9bfwGMip9Hd0Lu--

--------------gQ6809SG9iftMadf0pqSW8dk
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEcGLapPABucZhZwDPaMKH38aoAiYFAmiLI1IFAwAAAAAACgkQaMKH38aoAiZS
Hw/+M2Q70PjQnxTeCWeyEcv8Cjfdx+NN4Nkz2W0sYlrEZ+M5264pAfj4dPXGDeSnO/bUR0A1bboU
oGXjGyD0AXuR5R3sRnr5up0JM6SfUQGdJZUIHSQxqsxr2JgIAXHruf6U9UEfkVuKBzlipnCbaFtt
dzb5NoEwyAox3yzymOBPSMAZ76GzOWx3GsjgYYodW0MrO/kotT1rDmGx/xXxfI+EjogowCfUzpzK
J73qsay/W5R5uo3ZM9TxgDOYEnIlcBEnXj1yltJvRYxwkxMaKTFZuyyAbuFusJ8Goh+yUdAGiwv1
L89DBBU+71mRhFhnmBoNQm7UJKycz3Eis8zIfv/oy+e8oAF/st46/9ECEAgIb+m1wmc8d6IuEk5v
IcGyMaMLZh8CP10qRlfAD0XNxTAsQsOvGi1BVMvzQhXIwvfpL9L0TgErTbYVUAyGZ/ynhBrR/mjl
sbXQukeVW3AaIdUrctRBOyPu1JbK3VMWiEnOHm5gTKBC+3hnBm5xyYq0UCT7ZxJyff5YdUhR75ny
6l6xwiqXzkN1wMvbHCxKGS2XqPaPr9du9N3FW3PGU4b8sM9Do6KmAhxtAVBJS+jb9PW88iaNWnyN
nBnRnupylchHGub61LxdC1Od5uEiWmChdR4RdrBS3xtJNIhW0cvTfl+9f0rezJmAYmeRaRY4Oqv2
wyA=
=mswx
-----END PGP SIGNATURE-----

--------------gQ6809SG9iftMadf0pqSW8dk--

