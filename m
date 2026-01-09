Return-Path: <linux-pm+bounces-40547-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 15838D0B469
	for <lists+linux-pm@lfdr.de>; Fri, 09 Jan 2026 17:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4110B301BB48
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jan 2026 16:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5147D36402E;
	Fri,  9 Jan 2026 16:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="auDnmJVW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TD3INxVB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC23E32A3C3
	for <linux-pm@vger.kernel.org>; Fri,  9 Jan 2026 16:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767976117; cv=none; b=KBqxdh0KG9OGT0bQKL3oHWVXyRR1uEn+3m0jB7dgFKr3R3AdeGJI+AXkvoWb/z/21M8ypg1prghLROp3M69HtkCYca4QIQAhdbqA3IqczIPfyA++h8C+odY8fl0jhyF162/idrIScLXyEh9yA8VCmh56X00QLEUW9BOv0FqTdUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767976117; c=relaxed/simple;
	bh=bxZLCafNweBkgW+FBFWr0lq4Zs+o+DuBk91XqavNxm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tRvLiYRhckloFMZvJjGr8ZLeDZlTG5G8ctch589Usl+LjKVzzpsqhXZhb68EGedrzbEZpzJfyazny3SO2iELGKPSz3hJipX/MyAuzDgHZAlEGb61hnXtnwwr/A6P2sQqRc29YxnLOpG0Tm1xy8rN0nkmrxt+GffXwC4yPMRQzOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=auDnmJVW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TD3INxVB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6099WbF93325194
	for <linux-pm@vger.kernel.org>; Fri, 9 Jan 2026 16:28:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t3gsNK0n+kxqkO2O5Y6qJa7uNbEWU4OWP81Jtn3Gl6I=; b=auDnmJVWhcQf3oJo
	JL8uymCSt392ezuBs0Va51CYfLzTl6z3nmOrLbaPNCD9V5fdp9uI9qEzkEbGPjNh
	MaGwhl3q7S20hU6QYuxJmTjplPXXWtCfnxBr6YdZhZPa1tDcjd3UXJm+bmBVa3TP
	ZM8Kvv04KvzfF4/M7lao8pCT5tYCBgT+eqmb32TXIC/aSB9ZH2T73VlzdnTs7e4D
	5CroGhjDBWNwddLxJn4Fq+xHJiFubZDrTFCVBTgGcUwWUjZH6uStAA/joNU858ll
	uR+QDtLW6Ez1/GIdI8+yrqOfGK4pxnxcqljH5DMgN2qFPORVl3ck7vK6VPaqBZUG
	s9wtPQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjrd6jfea-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 09 Jan 2026 16:28:35 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c1cffa1f2dso870704385a.1
        for <linux-pm@vger.kernel.org>; Fri, 09 Jan 2026 08:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767976114; x=1768580914; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t3gsNK0n+kxqkO2O5Y6qJa7uNbEWU4OWP81Jtn3Gl6I=;
        b=TD3INxVBTeszDfrxCSCouhd/kRJRTxbjWCKAG8iMkewcMvVCQ+tSWRkuTOqyE4ii3d
         XqdOrvXCUGb4JFTFFa761nccKn+f6kHn/UkVJaWAkPuoJ3d9ooKqwnL59un2OrwDpIIB
         6rTsy43MtjKBaA/XL/LuMn8DnMwqks2ep+x6geYAbU7/kH5lDY8608xZbPzaQGpEDID2
         CocO4s6on/VHnyC+yte7WHzU2x1qamLPIRy9GdCIGJvWxCKHBDcGwiUEm+pUAIJR4Epr
         8wYbvuVRr7DkwHE7ZKYYzFSPlGx7FhanF/uACeQ6bTbrrat0PQc3B1tLyMZRfVSytfoZ
         6q0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767976114; x=1768580914;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3gsNK0n+kxqkO2O5Y6qJa7uNbEWU4OWP81Jtn3Gl6I=;
        b=Ck8/01C+wcD4nkDQoGkSzlSJgSmjH3M2g5EkTVj1NVWNkWYf8ADNeDlwEfnmtohVZQ
         L+69KIsZXDWCV0OUt76G+ynMB0XlEoHbscKB+brWVmQXHCaTyilHFn6Qza5QtWJzyUqY
         YUbuKn5+ThHALhXmy6f4iozseHy5aB1tqjuIBUBjf+ygr67jXg7UZ08OeJu5VqKLeK1B
         eOulXMt0yhH9s0aLKE1ak0p2vGHyXz81YtagQYyRMsyyWDYUhC5vAWxSHRB2fJH6qAXb
         5jAS0wRECVku5AR8GR0WDRbxXx+BGMxyliuy4fnQlbpyh5Rltwh3yZWGrYDkfr9K+sAk
         XZvw==
X-Forwarded-Encrypted: i=1; AJvYcCUCMUt8u9OcdNCxYS4IPYmf0ORXqykLg8p2EyTuwSR+MGEz5gEIlSZUExb7tU7eFxM9gMp3Yo+JIg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxmgZDNz5oEtgXMlUwZH4CQ8bjhPbQ8+yYKOFrfslP20S6Wm1OD
	kUekK3pFtRlWU4ofvXDfd5D29yEqeUIzaXUZkpoMZgvYjd3y8u64DR9Fg4pCqxn42jivuTWZHBU
	jNJoVKBRTlJaVy+kT1UxqEadRDv+y8O6tp7NfcLVI+rHJ220lMmm/ctxFIzTThA==
X-Gm-Gg: AY/fxX5PPRuZcdICjFsfLBk/oZw9teYNxFsez8SmSlSkNCPckZVCRWqXM4GKGaJBqU9
	EYf9cVo5RakI0SX9I9LXD9zZC7yEo96OMfOM9aVIi0oYb0HV2SIvcXX+U9MLVt0oifqPHUA2JYv
	UKSIa/R3Zez1ypX7HJq/+i9I+G0a9agi8/EznDW7kd18bhaGnI/MMLckYTbAQpKkZ85vb20MBwh
	AY1GJO38/2WoxgVn8NLNuKOgM3T1WcDmv1PzREIST7WgvwMnzTRpsTMQYBOLcWbgHnoHlwigSOW
	gSko6riF/uZDTH+DuQT0Odu41/ZPmcGZuYyNXRlNPMxCu7Jje4gTN7gE5OENl+/Gzcao7tJtD2I
	gSkujLuxzCGyDgh61xYdVVLMown0mKoSXf3aEsQ==
X-Received: by 2002:a05:620a:4806:b0:8b2:63ae:6343 with SMTP id af79cd13be357-8c37f51e983mr2081063685a.28.1767976112636;
        Fri, 09 Jan 2026 08:28:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFjr6Hlo/f6CAeSmB5peKaZZkzcXVDt14M9nd92QHPuF7V/gxrWpBy4OmUEIvthc/Tse5YQw==
X-Received: by 2002:a05:620a:4806:b0:8b2:63ae:6343 with SMTP id af79cd13be357-8c37f51e983mr2081046485a.28.1767976110721;
        Fri, 09 Jan 2026 08:28:30 -0800 (PST)
Received: from [192.168.1.29] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d865f84besm70896735e9.1.2026.01.09.08.28.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 08:28:30 -0800 (PST)
Message-ID: <c7007179-77af-44ee-ba8e-a16310fcc9ee@oss.qualcomm.com>
Date: Fri, 9 Jan 2026 17:28:26 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] clk: imx: imx27: Simplify with scoped for each OF
 child loop
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Nathan Chancellor
 <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar
 <alim.akhtar@samsung.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Nipun Gupta <nipun.gupta@amd.com>,
        Nikhil Agarwal <nikhil.agarwal@amd.com>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Vinod Koul <vkoul@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, llvm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-clk@vger.kernel.org, imx@lists.linux.dev,
        dmaengine@vger.kernel.org, linux-media@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20260105-of-for-each-compatible-scoped-v1-0-24e99c177164@oss.qualcomm.com>
 <20260105-of-for-each-compatible-scoped-v1-7-24e99c177164@oss.qualcomm.com>
 <20260106102146.00005bfb@huawei.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzTpLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQG9zcy5xdWFsY29tbS5jb20+wsGXBBMB
 CgBBFiEEm9B+DgxR+NWWd7dUG5NDfTtBYpsFAmkknB4CGwMFCRaWdJoFCwkIBwICIgIGFQoJ
 CAsCBBYCAwECHgcCF4AACgkQG5NDfTtBYpuCRw/+J19mfHuaPt205FXRSpogs/WWdheqNZ2s
 i50LIK7OJmBQ8+17LTCOV8MYgFTDRdWdM5PF2OafmVd7CT/K4B3pPfacHATtOqQFHYeHrGPf
 2+4QxUyHIfx+Wp4GixnqpbXc76nTDv+rX8EbAB7e+9X35oKSJf/YhLFjGOD1Nl/s1WwHTJtQ
 a2XSXZ2T9HXa+nKMQfaiQI4WoFXjSt+tsAFXAuq1SLarpct4h52z4Zk//ET6Xs0zCWXm9HEz
 v4WR/Q7sycHeCGwm2p4thRak/B7yDPFOlZAQNdwBsnCkoFE1qLXI8ZgoWNd4TlcjG9UJSwru
 s1WTQVprOBYdxPkvUOlaXYjDo2QsSaMilJioyJkrniJnc7sdzcfkwfdWSnC+2DbHd4wxrRtW
 kajTc7OnJEiM78U3/GfvXgxCwYV297yClzkUIWqVpY2HYLBgkI89ntnN95ePyTnLSQ8WIZJk
 ug0/WZfTmCxX0SMxfCYt36QwlWsImHpArS6xjTvUwUNTUYN6XxYZuYBmJQF9eLERK2z3KUeY
 2Ku5ZTm5axvlraM0VhUn8yv7G5Pciv7oGXJxrA6k4P9CAvHYeJSTXYnrLr/Kabn+6rc0my/l
 RMq9GeEUL3LbIUadL78yAtpf7HpNavYkVureuFD8xK8HntEHySnf7s2L28+kDbnDi27WR5kn
 u/POwU0EVUNcNAEQAM2StBhJERQvgPcbCzjokShn0cRA4q2SvCOvOXD+0KapXMRFE+/PZeDy
 fv4dEKuCqeh0hihSHlaxTzg3TcqUu54w2xYskG8Fq5tg3gm4kh1Gvh1LijIXX99ABA8eHxOG
 mLPRIBkXHqJYoHtCvPc6sYKNM9xbp6I4yF56xVLmHGJ61KaWKf5KKWYgA9kfHufbja7qR0c6
 H79LIsiYqf92H1HNq1WlQpu/fh4/XAAaV1axHFt/dY/2kU05tLMj8GjeQDz1fHas7augL4ar
 gt4e+jum3NwtyupodQBxncKAUbzwKcDrPqUFmfRbJ7ARw8491xQHZDsP82JRj4cOJX32sBg8
 nO2N5OsFJOcd5IE9v6qfllkZDAh1Rb1h6DFYq9dcdPAHl4zOj9EHq99/CpyccOh7SrtWDNFF
 knCmLpowhct95ZnlavBrDbOV0W47gO33WkXMFI4il4y1+Bv89979rVYn8aBohEgET41SpyQz
 7fMkcaZU+ok/+HYjC/qfDxT7tjKXqBQEscVODaFicsUkjheOD4BfWEcVUqa+XdUEciwG/SgN
 yxBZepj41oVqFPSVE+Ni2tNrW/e16b8mgXNngHSnbsr6pAIXZH3qFW+4TKPMGZ2rZ6zITrMi
 p+12jgw4mGjy5y06JZvA02rZT2k9aa7i9dUUFggaanI09jNGbRA/ABEBAAHCwXwEGAEKACYC
 GwwWIQSb0H4ODFH41ZZ3t1Qbk0N9O0FimwUCaBdQXwUJFpZbKgAKCRAbk0N9O0Fim07TD/92
 Vcmzn/jaEBcqyT48ODfDIQVvg2nIDW+qbHtJ8DOT0d/qVbBTU7oBuo0xuHo+MTBp0pSTWbTh
 LsSN1AuyP8wFKChC0JPcwOZZRS0dl3lFgg+c+rdZUHjsa247r+7fvm2zGG1/u+33lBJgnAIH
 5lSCjhP4VXiGq5ngCxGRuBq+0jNCKyAOC/vq2cS/dgdXwmf2aL8G7QVREX7mSl0x+CjWyrpF
 c1D/9NV/zIWBG1NR1fFb+oeOVhRGubYfiS62htUQjGLK7qbTmrd715kH9Noww1U5HH7WQzeP
 t/SvC0RhQXNjXKBB+lwwM+XulFigmMF1KybRm7MNoLBrGDa3yGpAkHMkJ7NM4iSMdSxYAr60
 RtThnhKc2kLIzd8GqyBh0nGPIL+1ZVMBDXw1Eu0/Du0rWt1zAKXQYVAfBLCTmkOnPU0fjR7q
 VT41xdJ6KqQMNGQeV+0o9X91X6VBeK6Na3zt5y4eWkve65DRlk1aoeBmhAteioLZlXkqu0pZ
 v+PKIVf+zFKuh0At/TN/618e/QVlZPbMeNSp3S3ieMP9Q6y4gw5CfgiDRJ2K9g99m6Rvlx1q
 wom6QbU06ltbvJE2K9oKd9nPp1NrBfBdEhX8oOwdCLJXEq83vdtOEqE42RxfYta4P3by0BHp
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20260106102146.00005bfb@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDEyNCBTYWx0ZWRfX7DAnC0QQELdr
 Czuok0JJ339k+S91KvKUZKU5TLwtefnyjs/9P+RSYF//Dpx0Z70LhoAscVNigbP4K3WqaLfId9q
 ixVdsPKbaP9QKXXeCge9b98IH3iEz2NUV2dl9cNla4j4mig6gTYz1Sr3dL/BIq3zSFUq/lnv4Kc
 TZ2Jb852RC3lj9DNps8SqqpAbsJ/tqaQxp4E4MDycFtawFV514+AYmnywxdX8tSMdGyQaxwpqnp
 mq8D5QQz6jxn3o/eCFXMatgjKE//gf1C7+ZnDmIW9UbKys6kBCr+2VWhtjYlXsZGEDExYIuQ9+c
 N2MeuxnvCo4dm3iMLSV9BOKr0foHsGcrpBMQ82rOizPR30xccIUPJxMuI+2LqaDmHP9Tjxh7Wcu
 jrAqcS6H8OUVtzhw3gudhBMZbVOd5BlIy/8TawcWyr59I+tJaBBDHvQQvj0a/fgi48MyolTMxps
 yx/IEnNGvtcQ9DvPVTg==
X-Proofpoint-GUID: WjJIomlm88DqLZs-ePzxMugiaQAdcbMH
X-Proofpoint-ORIG-GUID: WjJIomlm88DqLZs-ePzxMugiaQAdcbMH
X-Authority-Analysis: v=2.4 cv=Xtf3+FF9 c=1 sm=1 tr=0 ts=69612cb3 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=i0EeH86SAAAA:8
 a=TgEtEVTGrOTdQsgPiu4A:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_05,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601090124

On 06/01/2026 11:21, Jonathan Cameron wrote:
> On Mon, 05 Jan 2026 14:33:45 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com> wrote:
> 
>> Use scoped for-each loop when iterating over device nodes to make code a
>> bit simpler.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> This is one that had me thinking for a (short) while about what pattern
> required this double match was there for.  A comment would have been useful!

If I only knew. Since day one, both DTS and driver have and check for
two compatibles, so this could have been simple:
for_each_compatible_node(..., "fsl,imx-osc26m")

> 
> Ah well, nothing to do with your patch which is good.
> 

Best regards,
Krzysztof

