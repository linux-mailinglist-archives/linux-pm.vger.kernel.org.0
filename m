Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A889B145A52
	for <lists+linux-pm@lfdr.de>; Wed, 22 Jan 2020 17:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgAVQzA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Jan 2020 11:55:00 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45436 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgAVQy7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jan 2020 11:54:59 -0500
Received: by mail-wr1-f65.google.com with SMTP id j42so8041298wrj.12
        for <linux-pm@vger.kernel.org>; Wed, 22 Jan 2020 08:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DM1d73/VoF6vIcU47F5e8EsG7Wr6ebQt+4pVusl9w1Y=;
        b=vMRe/fAEtTSfL2cR5LPkRGc+1SQszNAIpIQ4UnKHnDnqxHeGVelwMucGC4rrO7n4db
         R5c1YaczIfS0lC8A6/4Xox1jdfI0LDiLfWukgKL2yVP6qKJDnGmpgv2F91PCauFNjNI2
         t0T7ZWqStLxb6dAS2Ni37KgdYqkmhXO8wZ5KSy5bAqnE5/RKRHyeDhoO1lhEqm94wXws
         UtaHkVzggIlZoc+chhb5jinfYgICgzEir+dJ8I4PGh+Sk4ZhAE9sjX54aTS7u7JHbXK/
         vUvlqgIPwucpfrz5/99La2K2aJqLzYCMrDDxlFrLbzhsJ05cMvpDZoQFOGFJXIRrpAR6
         /1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DM1d73/VoF6vIcU47F5e8EsG7Wr6ebQt+4pVusl9w1Y=;
        b=U/Lg9eTQCf2g/cBRIr3NiNc1UyeCj4Lc5vJe6+GgenPr/v6c7q5sZZjWJJRxfNoJLD
         89uCvrudCNOfXArlOA9UM+sRLenwREBYrqxXeHkLnbrY5vvp7eC8ptXOpVX/8XQRiGiF
         1BqOixpuPb3cz3TrF0H5rqxnu5ENpweheGW+b6NzQBuU9VpmwZw4BVP76Rw6oAkz6bCE
         QYglr2huv0FIfq92fQQudzz+bAPFfk/h2avL16Gayshx7cdxXJnVaGo2bZ5HhGtOvRsv
         +x756ww+Klcn3gQimeonoJ875uw2ysWAGOmoewZROhVi7rXjWkwAy/pa5HIrPS/gkkty
         wWUA==
X-Gm-Message-State: APjAAAUQXJwm8wKHtY0OnC8zpCTrqwUHxp3kb5nr9tNsAFMIgRkrfS4J
        BrQHTG8Sz6flY+521uvG9pgLUw==
X-Google-Smtp-Source: APXvYqx83qjv8lgIRz1T8W3VPyOCHXAj3czhH4MS6m3/mkUBnDcXqw3qig4Pczf6oz2NuqtJJW9X8A==
X-Received: by 2002:a5d:5234:: with SMTP id i20mr12869805wra.403.1579712097436;
        Wed, 22 Jan 2020 08:54:57 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id w8sm5276922wmm.0.2020.01.22.08.54.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jan 2020 08:54:56 -0800 (PST)
Subject: Re: [RFC PATCH v3 4/7] arm: dts: exynos: Add interconnect bindings
 for Exynos4412
To:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        leonard.crestez@nxp.com, m.szyprowski@samsung.com,
        b.zolnierkie@samsung.com, krzk@kernel.org
References: <20191220115653.6487-1-a.swigon@samsung.com>
 <CGME20191220120144eucas1p119ececf161a6d45a6a194e432bbbd1f9@eucas1p1.samsung.com>
 <20191220115653.6487-5-a.swigon@samsung.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 mQINBFjTuRcBEACyAOVzghvyN19Sa/Nit4LPBWkICi5W20p6bwiZvdjhtuh50H5q4ktyxJtp
 1+s8dMSa/j58hAWhrc2SNL3fttOCo+MM1bQWwe8uMBQJP4swgXf5ZUYkSssQlXxGKqBSbWLB
 uFHOOBTzaQBaNgsdXo+mQ1h8UCgM0zQOmbs2ort8aHnH2i65oLs5/Xgv/Qivde/FcFtvEFaL
 0TZ7odM67u+M32VetH5nBVPESmnEDjRBPw/DOPhFBPXtal53ZFiiRr6Bm1qKVu3dOEYXHHDt
 nF13gB+vBZ6x5pjl02NUEucSHQiuCc2Aaavo6xnuBc3lnd4z/xk6GLBqFP3P/eJ56eJv4d0B
 0LLgQ7c1T3fU4/5NDRRCnyk6HJ5+HSxD4KVuluj0jnXW4CKzFkKaTxOp7jE6ZD/9Sh74DM8v
 etN8uwDjtYsM07I3Szlh/I+iThxe/4zVtUQsvgXjwuoOOBWWc4m4KKg+W4zm8bSCqrd1DUgL
 f67WiEZgvN7tPXEzi84zT1PiUOM98dOnmREIamSpKOKFereIrKX2IcnZn8jyycE12zMkk+Sc
 ASMfXhfywB0tXRNmzsywdxQFcJ6jblPNxscnGMh2VlY2rezmqJdcK4G4Lprkc0jOHotV/6oJ
 mj9h95Ouvbq5TDHx+ERn8uytPygDBR67kNHs18LkvrEex/Z1cQARAQABtChHZW9yZ2kgRGph
 a292IDxnZW9yZ2kuZGpha292QGxpbmFyby5vcmc+iQI+BBMBAgAoBQJY07kXAhsDBQkHhM4A
 BgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRCyi/eZcnWWUuvsD/4miikUeAO6fU2Xy3fT
 l7RUCeb2Uuh1/nxYoE1vtXcow6SyAvIVTD32kHXucJJfYy2zFzptWpvD6Sa0Sc58qe4iLY4j
 M54ugOYK7XeRKkQHFqqR2T3g/toVG1BOLS2atooXEU+8OFbpLkBXbIdItqJ1M1SEw8YgKmmr
 JlLAaKMq3hMb5bDQx9erq7PqEKOB/Va0nNu17IL58q+Q5Om7S1x54Oj6LiG/9kNOxQTklOQZ
 t61oW1Ewjbl325fW0/Lk0QzmfLCrmGXXiedFEMRLCJbVImXVKdIt/Ubk6SAAUrA5dFVNBzm2
 L8r+HxJcfDeEpdOZJzuwRyFnH96u1Xz+7X2V26zMU6Wl2+lhvr2Tj7spxjppR+nuFiybQq7k
 MIwyEF0mb75RLhW33sdGStCZ/nBsXIGAUS7OBj+a5fm47vQKv6ekg60oRTHWysFSJm1mlRyq
 exhI6GwUo5GM/vE36rIPSJFRRgkt6nynoba/1c4VXxfhok2rkP0x3CApJ5RimbvITTnINY0o
 CU6f1ng1I0A1UTi2YcLjFq/gmCdOHExT4huywfu1DDf0p1xDyPA1FJaii/gJ32bBP3zK53hM
 dj5S7miqN7F6ZpvGSGXgahQzkGyYpBR5pda0m0k8drV2IQn+0W8Qwh4XZ6/YdfI81+xyFlXc
 CJjljqsMCJW6PdgEH7kCDQRY07kXARAAvupGd4Jdd8zRRiF+jMpv6ZGz8L55Di1fl1YRth6m
 lIxYTLwGf0/p0oDLIRldKswena3fbWh5bbTMkJmRiOQ/hffhPSNSyyh+WQeLY2kzl6geiHxD
 zbw37e2hd3rWAEfVFEXOLnmenaUeJFyhA3Wd8OLdRMuoV+RaLhNfeHctiEn1YGy2gLCq4VNb
 4Wj5hEzABGO7+LZ14hdw3hJIEGKtQC65Jh/vTayGD+qdwedhINnIqslk9tCQ33a+jPrCjXLW
 X29rcgqigzsLHH7iVHWA9R5Aq7pCy5hSFsl4NBn1uV6UHlyOBUuiHBDVwTIAUnZ4S8EQiwgv
 WQxEkXEWLM850V+G6R593yZndTr3yydPgYv0xEDACd6GcNLR/x8mawmHKzNmnRJoOh6Rkfw2
 fSiVGesGo83+iYq0NZASrXHAjWgtZXO1YwjW9gCQ2jYu9RGuQM8zIPY1VDpQ6wJtjO/KaOLm
 NehSR2R6tgBJK7XD9it79LdbPKDKoFSqxaAvXwWgXBj0Oz+Y0BqfClnAbxx3kYlSwfPHDFYc
 R/ppSgnbR5j0Rjz/N6Lua3S42MDhQGoTlVkgAi1btbdV3qpFE6jglJsJUDlqnEnwf03EgjdJ
 6KEh0z57lyVcy5F/EUKfTAMZweBnkPo+BF2LBYn3Qd+CS6haZAWaG7vzVJu4W/mPQzsAEQEA
 AYkCJQQYAQIADwUCWNO5FwIbDAUJB4TOAAAKCRCyi/eZcnWWUhlHD/0VE/2x6lKh2FGP+QHH
 UTKmiiwtMurYKJsSJlQx0T+j/1f+zYkY3MDX+gXa0d0xb4eFv8WNlEjkcpSPFr+pQ7CiAI33
 99kAVMQEip/MwoTYvM9NXSMTpyRJ/asnLeqa0WU6l6Z9mQ41lLzPFBAJ21/ddT4xeBDv0dxM
 GqaH2C6bSnJkhSfSja9OxBe+F6LIAZgCFzlogbmSWmUdLBg+sh3K6aiBDAdZPUMvGHzHK3fj
 gHK4GqGCFK76bFrHQYgiBOrcR4GDklj4Gk9osIfdXIAkBvRGw8zg1zzUYwMYk+A6v40gBn00
 OOB13qJe9zyKpReWMAhg7BYPBKIm/qSr82aIQc4+FlDX2Ot6T/4tGUDr9MAHaBKFtVyIqXBO
 xOf0vQEokkUGRKWBE0uA3zFVRfLiT6NUjDQ0vdphTnsdA7h01MliZLQ2lLL2Mt5lsqU+6sup
 Tfql1omgEpjnFsPsyFebzcKGbdEr6vySGa3Cof+miX06hQXKe99a5+eHNhtZJcMAIO89wZmj
 7ayYJIXFqjl/X0KBcCbiAl4vbdBw1bqFnO4zd1lMXKVoa29UHqby4MPbQhjWNVv9kqp8A39+
 E9xw890l1xdERkjVKX6IEJu2hf7X3MMl9tOjBK6MvdOUxvh1bNNmXh7OlBL1MpJYY/ydIm3B
 KEmKjLDvB0pePJkdTw==
Message-ID: <747a1c94-8eee-f46a-fcc7-d111cd9df70d@linaro.org>
Date:   Wed, 22 Jan 2020 18:54:54 +0200
MIME-Version: 1.0
In-Reply-To: <20191220115653.6487-5-a.swigon@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Artur,

Thank you for your continuous work on this.

On 12/20/19 13:56, Artur Świgoń wrote:
> This patch adds the following properties to the Exynos4412 DT:
>   - exynos,interconnect-parent-node: to declare connections between
>     nodes in order to guarantee PM QoS requirements between nodes;

Is this DT property documented somewhere? I believe that there should be a patch
to document it somewhere in Documentation/devicetree/bindings/ before using it.

Thanks,
Georgi

>   - #interconnect-cells: required by the interconnect framework.
> 
> Note that #interconnect-cells is always zero and node IDs are not
> hardcoded anywhere.
> 
> Signed-off-by: Artur Świgoń <a.swigon@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> index 4ce3d77a6704..d9d70eacfcaf 100644
> --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> @@ -90,6 +90,7 @@
>  &bus_dmc {
>  	exynos,ppmu-device = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
>  	vdd-supply = <&buck1_reg>;
> +	#interconnect-cells = <0>;
>  	status = "okay";
>  };
>  
> @@ -106,6 +107,8 @@
>  &bus_leftbus {
>  	exynos,ppmu-device = <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
>  	vdd-supply = <&buck3_reg>;
> +	exynos,interconnect-parent-node = <&bus_dmc>;
> +	#interconnect-cells = <0>;
>  	status = "okay";
>  };
>  
> @@ -116,6 +119,8 @@
>  
>  &bus_display {
>  	exynos,parent-bus = <&bus_leftbus>;
> +	exynos,interconnect-parent-node = <&bus_leftbus>;
> +	#interconnect-cells = <0>;
>  	status = "okay";
>  };
>  
> 
