Return-Path: <linux-pm+bounces-27031-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F225CAB2BF4
	for <lists+linux-pm@lfdr.de>; Mon, 12 May 2025 00:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7322E3B995F
	for <lists+linux-pm@lfdr.de>; Sun, 11 May 2025 22:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046BF262FEE;
	Sun, 11 May 2025 22:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="GDpWYBME"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127A326156E;
	Sun, 11 May 2025 22:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747002836; cv=none; b=PMU7UZ6j7O2uS2fMHtRk1RsnEDyJFf2E2/rDyCVKjMxRjT1kz5v52IQOul+9bMko/U6SuemXVqH8Q9mcmdd8hV8TvVWWZIqWj1H+kD8i0CyUlczLTmRBU58oTSDsGiqRfI+8Oq75mp4qxNzCs9p0Yic4rWIf/EdTAMpo4AhdN3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747002836; c=relaxed/simple;
	bh=ER0N6bH41WRr745tGcPE6MlthWyflWusLPiW21xpnQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZsetzuSsgt4G4A9uIOwW7x93klc3vPJyy1fbmVl0PTD9+a6+JOXUyY4smmht94LU5KJ8pNij8NXbHPTdUV6YJibRRWzpYsq1yUEVIBUb7bzz2qX5PifobFhZqNH9rq6gA7hIGfKwJlzDVuHnEr5DSaUMdV5lfj/k5IZLC9BlLKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=GDpWYBME; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1747002829; x=1747607629; i=w_armin@gmx.de;
	bh=gQ24rytmNTcd6LvYJKQeYrV2HnY/+YLZa39tllVCGkw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GDpWYBMEjxSnEoDRN/2bmm2vXCrGdJrA8IoK4zFc9b1EnxBGBEvOFpmwv4SgYoLa
	 uP5zfkq1JyRT4zh93dMRTkm4mnyX/tsKvNLHteC7PazUx9/4bTurwyl/C0Azjsp8Z
	 UQqXRwOm7+X0iJwolirW7dqqINqcjcX8dOc9trer6l62PYhXOLw63IaoDCp0L0jzv
	 kQ5PgKV+BHEKNbzyRYYvd9xC3C4Wko4Ob3t4WFuGs7pxU3DLKf/5lUHzcmRiYAm0T
	 r1ieYr4YRLO23JUjTPVK+MqkRUwufiRhqfDK2odf2NclnRbGj5gIoNqK4bzHzYIb5
	 ouYhl7BTmM5VTrajbg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7K3i-1uLxwX22fs-006Ugd; Mon, 12
 May 2025 00:33:49 +0200
Message-ID: <e11b6c57-675b-4c81-bfb6-5133c8c245e7@gmx.de>
Date: Mon, 12 May 2025 00:33:48 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] power: supply: core: Add additional health status
 values
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 hdegoede@redhat.com
Cc: sre@kernel.org, platform-driver-x86@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250429003606.303870-1-W_Armin@gmx.de>
 <174700275600.13063.9398321342899509983.b4-ty@linux.intel.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <174700275600.13063.9398321342899509983.b4-ty@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qKs3HwdgrZXaw/Np+b3stUsqSq055NmDs/ugQW5AOqNyc3u1epW
 StkfqNeWKgP0ze216GWJiTf1E0Fub87dTj7i+Dv/5lrs8/dnsac1i/sRETWX54bUAN8Q4rQ
 X3PD6KR9RqNbcLXy8BetZU2F1YH2v3hdsmu6BhtnItHxUEB2TPzbjDW5rsIYZ50Etoy/KU0
 Me3vqmGK0EBJYSfEV2MYQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KWU/MuIuinw=;VT3PswBjoXI1uWAJyE5AnPODYO2
 Rx2ul8V5jBfvMlZ4dbEzsnMuB8TWhmsikiCF30odL845JdV68oXcrOr/phH+eB+LMssTOgj0G
 0ZIkMTduXApH4x9k7+2IeH8aOHhyKP2UcMiovbN3yUEQiHuWYH6HPOwV7ZL5/iAiMjKUf7If5
 1oDbJaVjTSO2MVF4vXr3u2vmqPqRi1sxv8JLYH7MrFV7o+tZiUsb9W66ZN1pDmBqu7g9o5qv8
 KP7mWxzxAOufuFsMEZgaC49TceFjKEBeL4byAHksOvlFHmM31Xo+0f6zVejn4daCg7WU5HPxg
 yUt0miIfQvynT7FyqbdA2/Dn7NxNXCbE08yYf0EINURBhrxrxmpxByEa05gZM001BSNo0jwRY
 cF+8y1D+cPXc8piOoqjVmZh2DI3c6YEWFTRT4E4R0614Dg80iTCJvV8/1InGcnolB9etHt74r
 HIe0DLgjww5mB85pIe5DEY4f9qUfuD6CSnYBdirbL2/3M8shraHJIG3xiF4kSxi9DYE2kQADD
 Ll6j00Z/fOTGFfl5TJen7ISE8JC500HCDc8/fj4ufKQeroEjIt27/8+Aom0NBSmJRNTsgZkxZ
 4/ucDmpM2RBMuPk2XISYtZ+U8zXTMbomIXE/iJVRROeDQY6NHI+4pHTO+EFgutvBF49r1jpVz
 SpHbJ6NqucT7pyrkeOe3U41f5uY7sHMg/PYj1K6B61hjJlneY0uny9xz8oa7MDuBgUndZejaI
 bRwNuTaLp/TK/li9EqSZh3Cjy2GteGIyZu6PKEdcxduQJiGVc7zKB8AQGgiD0vVsf1wMCIENX
 Cno5AQvfs7Fe9jo3uLBr90n7pdq6sXJ81qUM0O2Rex8CNJI0nv9d/kHnZFXb0MBlGrIBOvQIb
 BFrPGCOxk5dynQ+1boZq9ynmP9IhZNxeJQAaYllWqRhWLALk/cPFa94/3AR2IxCf6SgA738Qd
 en9MXvhXxt+YlefOlD19KYOFJDQ2WMym2q4ZCnJoRbPF4eOKJo8Gh3l17C4w+fpV+InkWXzbW
 EbwgIy3vMC9GyUd/gmhhsXyy1YcIClPq53xaVmRDZhIk+jUpqIjKzSm+GZQqKqayfpsB1isKg
 r9PkCdywLAP4le+yyLZaCVboOrOR/87gumh9BvPE2DcQbrSynHgxVLGeWzlMUvMV6NE4p6Lan
 aZ/RlpOZHwvUS4ZN6pnE5gHgvwc94u6ge9HKjBFQOTP0R1Kf+36m4IpQRngxLD+Gh6uXaW2ce
 W9fLlAYUwYKmvFuweSwctgewr+/zmH3CPSfYYW9xQcvVZ6jaUFvaTo5qfcLFod4SGHXgA3FZh
 J20mHWrFtn2pHygY1+ZKy54+gHEfQZq6p4rxcknQ8kyqMUv4LZV3ulXNNV4J7RTxU8Un6REiy
 iv7JkQAvUrwhJL90gE4S753ZAsw26LieZRcg1sVZUT3imJfcCpu44VdlLxKq6XclbpCO30N8S
 XnnYQXLYVZUy98Q7Kx3YRVTC5/O9t5TmuoKSh+ox+6aGKJem9mGRWDuubdN7T9nzV0kNc9fTc
 07TdW0UO1tkyf83RGXYhatp6aTqM6dZb5f2QMad+LjCb8oyku6axP1945mLoCbLcWhZCsaaNM
 Fp+T6q935hSHZYCO+2bjRDvvYM3J1Kdp9/xYncgfmAUjHye96eevyQq07Ws6DkVq1X1CtCgv1
 SVNMsUNpOl7GpNXNrM3fEnZx0fYMoT/GUmZaKri1l7PkhLRdq6mb75c0qhl0dLLP0ivYhc0ZZ
 gMenfByfoRVlqTdBbu5svqyaEZxhhgj/m8mf7DJUumO/emHvTbQtViU6kaMyK4PQCHdI15Euk
 gW4dzz8jPxdtXgBLLDX9xRUJ68jfnCDHJYuiyypLuTSh3mzQ+a82kB4eHVPeM1TLlYyaKPxlI
 O5PheIb9XxLGVvtwCgHnwsoF5F03k+SRX3rHPgRMIkkO5KsgLgDl1bE6wiC37X/ESLAg/R607
 Zi+5OfIg6x6FNQQ6dQsROYDXkK2NTYbN4KLnhLtiPaWhC9MTjNpaRE5GK4WXiz0b8VAnqhKcq
 CETeEFxqLPWsYlTqU2ybCxunjP1rSxvsi/bcwBijvrxjVpuqCE1cahorRuJQ8JfqCNb8/JE2j
 pAGahp1/s4qiZ38SLAzEq9l7D0J9X8YFfSj4i25npunpB+ZHReIcFTlEMU8wqur9Xrn+gj1Gv
 SWfALHezktsJaNCDUaU7J/ngnV03ioxvUYramTD+Cb+jqhQ1i6gxFA8rgvU2nWuMK4pIoLCzB
 mHJrV2FSzb6bsp6aBsR8GUQ0VgI46bWGbQ9t2ia1WdtO6Fe0Dr36JAeA5hBIr8dyE/Wd6l3bH
 0vJB4/h7oknPsXXrbFJt2eauRWD1o7lq1kLFdDYM8JYbg9gpaXH9B9xkInSqZ1tFIVJHljmn0
 1UDVPhRMm7s0KfADdVkSpkafQr20QzK28NTrTvDHU6NYKXE1uj6+xWGwZd/pV86ntQtE0ICIb
 TwEIkLacIZccBd9jWyPKdVmED5tp8Q2ZNx5gMDqqTyScf0RuehIG7aE1nGxmOsKPq0ciKwuPK
 xGnDxEJknDVK55QszgVHpyyyDbXPs/+sXrPOp3aibwF6GMvrjva4MFOova4Gy9UAzhXRH+k/v
 pnSrZTWm8amnWmabrS68TyQaqF9WwGJ+YnI+kSkBjQooWPUEYltQxutM40yyoB57rJEWusPnI
 SWW03Ynamt0PPl0huu9ihdfiQ+uGbSccd9a1eqCwagSk1Clbd1r/ruBiVetzG5auIC71TlJ87
 JptBca+0buQ2BxcCcBGst6QxZ6fj6CZoMdws1zI7B6qA8/Ork331K44eY1oT21tOmhMcYoY5u
 lQjKGx5lH/5bMugFRY+KosNXOCi8FOASztqBmFSKwKfLECEuqBON66R0rv4HnfVntZoC4VsI9
 A/ai1H9qJg23vOx+zg0LLSp0wwAaMi8psNxQE2kvWlWIdlB1c4UZNi0NJQP4QGZIUJlPXC17q
 DYFEoQf37sPeEGC566bI3SdubIyrCEIZtRe5dJhp/s2aXNA0G2EE9p8DaGTYUFR6rghxt9oYj
 cT/vPrS219poXFfJyMUbJHcBI0HAHzXGUBipqa2aOvuhdxy96Bl1XYp8Ptue1j24Tytx8LFJI
 31NAMveiH8ydOMJqYbZcgn5I8aBQWl49zusU7gXIqHlgmInwImAIfM/g==

Am 12.05.25 um 00:32 schrieb Ilpo J=C3=A4rvinen:

> On Tue, 29 Apr 2025 02:36:03 +0200, Armin Wolf wrote:
>
>> Some batteries can signal when an internal fuse was blown. In such a
>> case POWER_SUPPLY_HEALTH_DEAD is too vague for userspace applications
>> to perform meaningful diagnostics.
>>
>> Additionally some batteries can also signal when some of their
>> internal cells are imbalanced. In such a case returning
>> POWER_SUPPLY_HEALTH_UNSPEC_FAILURE is again too vague for userspace
>> applications to perform meaningful diagnostics.
>>
>> [...]
>
> Thank you for your contribution, it has been applied to my local
> review-ilpo-next branch. Note it will show up in the public
> platform-drivers-x86/review-ilpo-next branch only once I've pushed my
> local branch there, which might take a while.

Thank you :)

> The list of commits applied:
> [1/4] power: supply: core: Add additional health status values
>        commit: e6b07a34038716e010d9fd1ac74c1d84a501f369
> [2/4] platform/x86: dell-ddv: Implement the battery matching algorithm
>        commit: 52e59cf1332dc4da5aecaa64c20f4a9f902e3186
> [3/4] platform/x86: dell-ddv: Expose the battery manufacture date to use=
rspace
>        commit: 366a50722c7071120a494aaf91c9193922e3d8f6
> [4/4] platform/x86: dell-ddv: Expose the battery health to userspace
>        commit: d5251eef71bab8bd0b9ea3fe0005ad3d2553c3bb
>
> --
>   i.
>

