Return-Path: <linux-pm+bounces-8913-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9023F903414
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 09:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E05EDB2A471
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jun 2024 07:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250ED172BD3;
	Tue, 11 Jun 2024 07:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jMz3hmWE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6926D172BB6
	for <linux-pm@vger.kernel.org>; Tue, 11 Jun 2024 07:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718091842; cv=none; b=mgxgH23ULsUXZUXyCeSLTx+DdCuHNR6YJbbBNU8RlNmwkdrmbQ7KB+K45FLNOwntHPu80ZKhvTxrxY0C4kkdUcntSKzc1ODh0jH//gfukta1EjPc6sOAMYxHKTa97zB0DF+jL7BB1Mu03HFFrcmWdXBxAscgJos4tH0IQjRDcqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718091842; c=relaxed/simple;
	bh=8m6jYm+p0unixwgfRSSCm6/2jtFbUYbvXevNZxEqCDQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=T1vJfUqYEcDVCqfjKiGlnly/2aekJjM3+Dt/9aGsDz6u1MLPW6lFouLVYce6yKHG7bTsEplJr6KlAsF+U/TMi8q9V+aCK9IOiVGscTUf081xiOoZRclH8SdT39Z4ppQ4L/Z8w0MB+ghKAxhvx0WiqBxSV2rvIY+ikSD4hvzMRpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jMz3hmWE; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-35f1e35156cso1983547f8f.1
        for <linux-pm@vger.kernel.org>; Tue, 11 Jun 2024 00:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718091839; x=1718696639; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WsHiHDrwj7KWTlL47RJPPmsPBBAjKyL5RmZO1AaRVKI=;
        b=jMz3hmWEkEpJS/ULIW0Bl6uyy5IRk7IA2NwyW+aZ6yIKxrYHwrzDHbuLQhxbzIL7lq
         YDO0Z2YY6z6tt2MqfaX0mZgAXaWz2Hq9imTGtVdiV36lTCveeFk0jrZbQHm+YypR+cxy
         wO8bEvehOXuZkP1gPuq8X0zoMTfP6N7Vsn4rV8gscIlllhhgFtKnNL1M94WktsZ/0rn5
         7iTF/ji/Oe2Jk/1MbXhyF+fV6SiJj2Xv8ZVHGXNYMyKS+mcDLcEJOleOgoGda36CLWqg
         wfgqVwzaSKSYCbSP9zKaM285udWX6/ZKLRBdZnP9ibikuhBwRtKWRY0J52fXLgIDR0S4
         UH2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718091839; x=1718696639;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WsHiHDrwj7KWTlL47RJPPmsPBBAjKyL5RmZO1AaRVKI=;
        b=lP3ARBvLA0I/rvogLQZokaQpYx6g30ykzSdoxCbHdkDGCxBIAX4b6XPkkNMssxdDSQ
         AcBCzME+AnwQgyjulrXB7aQ+JbQqSkBVz87SwiVNRjys1reHMeD2lxBoUlHQtpeNDqrc
         ryGFKTwdaRiIbswLcaQczko0pAGVUdJRKuMAj7RlGACghNHKqk7YHTsCtyTFokGtPZI6
         FxSJm7zQUJoROXxQ8GS5ExQIuxe61X09EewTkOUn2i39zgODvt62KVbYoljob+McHtFi
         mliTtH31Qr5PRY2ggdSF2lizFV0NVGwyCzBvhVZM+AAq2B3DAmQmkbz5mBAl5MABiRc+
         elCQ==
X-Gm-Message-State: AOJu0Yw3+reJ4D38yG171dh/i0i7f3yNwBnGFOzqjiDWORarOq5pGPm6
	m9oD3IGER58Nn1GTyPl6BPhhD3hoxcEa7HQKx2uVEHwkHTUkL+cUSUNeKy95HAE=
X-Google-Smtp-Source: AGHT+IHVUWQPU0XLKI8clLjC5hscIpVdt5ZDQarh9E7gq2k1Q6gIf/HvwxVroSXFwFVrLN4v0Tr2cg==
X-Received: by 2002:a05:6000:1291:b0:35f:22d5:da72 with SMTP id ffacd0b85a97d-35f22d5dbbamr3080168f8f.50.1718091838847;
        Tue, 11 Jun 2024 00:43:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:5a4:3b2:c750:ef5c? ([2a01:e0a:982:cbb0:5a4:3b2:c750:ef5c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f25dc3f07sm4013408f8f.79.2024.06.11.00.43.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 00:43:58 -0700 (PDT)
Message-ID: <c0013295-c7de-4118-99dc-12074002c5fd@linaro.org>
Date: Tue, 11 Jun 2024 09:43:57 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] pmdomain: amlogic: add missing MODULE_DESCRIPTION()
 macros
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <20240610-md-drivers-pmdomain-amlogic-v1-1-b49ddb1a8bdf@quicinc.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20240610-md-drivers-pmdomain-amlogic-v1-1-b49ddb1a8bdf@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/06/2024 01:13, Jeff Johnson wrote:
> On x86, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pmdomain/amlogic/meson-gx-pwrc-vpu.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pmdomain/amlogic/meson-ee-pwrc.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro to all
> files which have a MODULE_LICENSE().
> 
> This includes meson-secure-pwrc.c which, although it did not produce a
> warning with the x86 allmodconfig configuration, may cause this
> warning with other configurations where CONFIG_MESON_SM is enabled.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>   drivers/pmdomain/amlogic/meson-ee-pwrc.c     | 1 +
>   drivers/pmdomain/amlogic/meson-gx-pwrc-vpu.c | 1 +
>   drivers/pmdomain/amlogic/meson-secure-pwrc.c | 1 +
>   3 files changed, 3 insertions(+)
> 
> diff --git a/drivers/pmdomain/amlogic/meson-ee-pwrc.c b/drivers/pmdomain/amlogic/meson-ee-pwrc.c
> index fcec6eb610e4..fbb2b4103930 100644
> --- a/drivers/pmdomain/amlogic/meson-ee-pwrc.c
> +++ b/drivers/pmdomain/amlogic/meson-ee-pwrc.c
> @@ -648,4 +648,5 @@ static struct platform_driver meson_ee_pwrc_driver = {
>   	},
>   };
>   module_platform_driver(meson_ee_pwrc_driver);
> +MODULE_DESCRIPTION("Amlogic Meson Everything-Else Power Domains driver");
>   MODULE_LICENSE("GPL v2");
> diff --git a/drivers/pmdomain/amlogic/meson-gx-pwrc-vpu.c b/drivers/pmdomain/amlogic/meson-gx-pwrc-vpu.c
> index 33df520eab95..6028e91664a4 100644
> --- a/drivers/pmdomain/amlogic/meson-gx-pwrc-vpu.c
> +++ b/drivers/pmdomain/amlogic/meson-gx-pwrc-vpu.c
> @@ -376,4 +376,5 @@ static struct platform_driver meson_gx_pwrc_vpu_driver = {
>   	},
>   };
>   module_platform_driver(meson_gx_pwrc_vpu_driver);
> +MODULE_DESCRIPTION("Amlogic Meson GX Power Domains driver");
>   MODULE_LICENSE("GPL v2");
> diff --git a/drivers/pmdomain/amlogic/meson-secure-pwrc.c b/drivers/pmdomain/amlogic/meson-secure-pwrc.c
> index 4d5bda0d60fc..b50e5678abe3 100644
> --- a/drivers/pmdomain/amlogic/meson-secure-pwrc.c
> +++ b/drivers/pmdomain/amlogic/meson-secure-pwrc.c
> @@ -355,4 +355,5 @@ static struct platform_driver meson_secure_pwrc_driver = {
>   	},
>   };
>   module_platform_driver(meson_secure_pwrc_driver);
> +MODULE_DESCRIPTION("Amlogic Meson Secure Power Domains driver");
>   MODULE_LICENSE("Dual MIT/GPL");
> 
> ---
> base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
> change-id: 20240610-md-drivers-pmdomain-amlogic-f117930600ea
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil

