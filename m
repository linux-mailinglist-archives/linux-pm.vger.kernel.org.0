Return-Path: <linux-pm+bounces-28727-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0662DADA3AE
	for <lists+linux-pm@lfdr.de>; Sun, 15 Jun 2025 22:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A299B16DB65
	for <lists+linux-pm@lfdr.de>; Sun, 15 Jun 2025 20:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98A527F74C;
	Sun, 15 Jun 2025 20:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.b="aAALW427"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F4A1DE8B3;
	Sun, 15 Jun 2025 20:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750020224; cv=none; b=cVs8LeIzKwz8fjkt4UvXGuRzS2OtA5ofsXoFxUwmPe1ELda8SUYB03hubqcpnsuFwjPP0wBDPT/AIE1Mj1fbgWh5gT9IEeVis6wP0+juxUEAItp1qy4wqtu3PrklWaFrtExhGSovJKdtndbSW3sANhwgJRsu8Ku6+FayrYhbA7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750020224; c=relaxed/simple;
	bh=BK+l2HO6viJZW2r4pfwwcFEhEL6waRkz7dHP6HyzD94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KN1N9J/GBWXhMAPYd0IHCkFouay7n0InaVOnxd4yhihNGLniabYBcQz1e5NAWNfxNIxIS19zHOIZ+TVuWhezZQQQO7PHA4z2lUuRaICzmdDzuvVcDSPDLwUpcolL9QIY1Mgd+C94kzvClzDTZKhvw4aXk4VlAxMhDhsaUjaTMBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oldschoolsolutions.biz; spf=pass smtp.mailfrom=oldschoolsolutions.biz; dkim=pass (2048-bit key) header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.b=aAALW427; arc=none smtp.client-ip=212.227.126.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oldschoolsolutions.biz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oldschoolsolutions.biz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oldschoolsolutions.biz; s=s1-ionos; t=1750020173; x=1750624973;
	i=jens.glathe@oldschoolsolutions.biz;
	bh=onUUPi4Wsm0wWvtRzn7J1Is1tHETTLIUY7qL9YrjcWs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=aAALW427wCiTHK39cJJv2kjo5O3E9Pc5agRqdW8bWA+LeGPYnK0+OoD+wSPbGNMs
	 a/bk8C+aLobCM408Blc7Y+YD5VqacRjTkSU24zOz9Kj5FHMA/mBtMhhmoQbGycgrk
	 tKEeGeP/NKcAmVjNZfpC4fpqsfyRFYhs4rWuQp+UByzpEVnljo4K7AOdFLRFnWr4t
	 t6VM5dzTGFyvp9zXYR2gRfAsS9DAy018Smyej00I3g/f9rUEYo8dt0lKNPVputYfC
	 ikij9RCwlYOlkf75sF5x9wMkSszH2JPLwnx/doEdtr0cKa/MO9PS2ePMRT6wa+pgE
	 /TjBIkhEtH8JRwbEXQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.0.174] ([62.226.41.128]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MqsGv-1vD7Bk1UkT-00lJbT; Sun, 15 Jun 2025 22:42:53 +0200
Message-ID: <df125ce9-c271-4cd2-b9ee-798d7b1c8648@oldschoolsolutions.biz>
Date: Sun, 15 Jun 2025 22:42:50 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 0/4] Support for Adreno X1-45 GPU
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20250611-x1p-adreno-v2-0-5074907bebbd@oss.qualcomm.com>
 <0e6fd97d-9a56-426b-8b98-dc8aa50d02d2@oldschoolsolutions.biz>
 <036e739c-54e4-4252-b6f0-c8eed5557d15@oss.qualcomm.com>
Content-Language: en-US
From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
In-Reply-To: <036e739c-54e4-4252-b6f0-c8eed5557d15@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NPypNcwQLw4G4JWfH5eQewUs1fAhXA4gnmLwZKj+YXP2JQCVDLw
 hHHaFiRxV8yKAi8HhsY8i7ZxODi73S6CjKM9nVFccdGkPhfkB5pOrBOyVW9yaBNN4b0H+Ns
 dg9kfLxx2wyWiBgoyv/B9zEcXS+CPe57RHvxQpv2+5cF8Zfq1sB+eFs/1EV0GqXTBh6gg++
 +pqFx1RAv2flOXyJR+vlg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:klnQglAAmwE=;E6ZFj467byVMRokAgVi3n9DEdRR
 N1m/VSAojUu+ULxgCdZ4o+cCjlVmxVqa/sFULgrw6SEKsIo2NNWw35rUEyudvLLsVmQK4Z3p9
 591we6xn+bjnbhuu92332R/BK6nyJg75u8PVumSroAKebZIVkhWrNbtqyL4RCzEamfJlIsHg3
 Q1An5m81MgIKuU59h6/exUcKN3r0iMrAs50XrEeUQeLDrYY9E+53WzWLlq2fC6NA2KjrX8JaC
 gZOw95SRi5w/ifsbqET4WItvnvvSPuEniYP4n5heEBpB1vHXrmElJhhtN4BRiuBwL5OqFEdS5
 NZGYR1ut3tvw4AaLB72JrG5VlIpTo+opklz68zFKwM38VZx/MabOGpv/umwEkMfcNvjlG/pjo
 rESxS3yShxjydsx9s2Ns/tZz/8gc+ikVEQCYyq6vk1pUaooWxZA5vMJjMuHKEdyw4e498DCor
 WG8X17Pi3eXakotXfmGvHB6AWJRWKIsHNC8+vOWJfSm8Y4m/O0PtuZnhnvWyD92CVMeKu4XQF
 yWCK++uPU1Zm3TDk0tEHCewFA9Vq52o7yywfM9/S3tlTZykC614j+z6R1DJ1RNyJc4dEqZmtg
 B+OwBWNJiShSqxaPQlg/6oeuujHaFFfz++nU6Xf0pOEMWPpPqsxzoAzAkIyafeZyrk/Q5rmFr
 1fRo+JJIAzSVVyyc6MvlIMvA1u5sdgT94lJaiEXBl+R1PMa/fCs/7GRVfH/MUNhQewq1pHxNO
 tJivuh+YxIiRvz/HgkfbrSG8gK4MycVAiN8T+rRFG5+0rM+fKbjaDyxWo++mucpT3G75rGtq2
 wfdXKfA4euhbu8XN8lEpe7XQJu2zkNy8NlzZgBApFiw6EtuGXAEZZp85P6AKyZ8ExF4/HQaKd
 xZ9fgizegncf77vAwsnWhBykpNH6a9whTFOhRp4TwiRIzfEOb+IshEj9XF++voXK44mQhwOZF
 6tdBL0StGxlPuziwMhDjfSaoDaTY8xTVMgIaefvlBhHIHOpQJHicXlZPGLsnspzpzrgDcZ32/
 sFOGfjHxA5lPFtseLVEaLrZQzK9OSDEheJNc9hd85+vCHwr2zqnWFaAa88Xa/NEyvK1De3A3G
 hRlpE1fkiCpoaee8Qw9jJxHHBBwi3uCZYkrkLH4XBA67ydVj5WK7MEDsw7UVe0O/aY35bq4Mw
 rlvKdCFwtLAtvqOnIfYj6NslmMJTqHS3655lLfIILocFlIl83vmvO8HYdyzB8Ywr4IqPEwq+N
 oXYgPcyehI67+KnUBn2wkBNlBUhy/Jk4/5BtEEhmfnj+nbYP42HYRGD3g6VRB1iher4rXqrjf
 HGT7hQ349cRxaVSkYw9HPNyXbw0MV7fBQmGZBd1w1+0/SDtHhcaca40bKnvADp28METqZVpa0
 XzZAMSDylIKBf0zvqJe7mfrDIev7ODjahDP1ZNbB+/b1VZcgienlG8PIOp

On 12.06.25 23:19, Akhil P Oommen wrote:
> Hi Jens,
>
> Could you please try the below patch?
>
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> index 2db748ce7df5..7748f92919b8 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
> @@ -1510,7 +1510,8 @@ static const struct adreno_info a7xx_gpus[] =3D {
>                          { 0,   0 },
>                          { 294, 1 },
>                          { 263, 2 },
> -                       { 141, 3 },
> +                       { 233, 3 },
> +                       { 141, 4 },
>                  ),
>          }
>   };
>
> With this, you should see 1107Mhz as the GPU Fmax.
>
jglathe@tb16-jg:~$ cat /sys/class/devfreq/*gpu*/available_frequencies
280000000 380000000 550000000 666000000 720000000 825000000 940000000=20
1014000000 1107000000

Looking good. Thanks!

Tested-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>

with best regards

Jens


