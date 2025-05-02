Return-Path: <linux-pm+bounces-26565-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 483F8AA6E1D
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 11:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E29CE3B4879
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 09:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A1B22F39C;
	Fri,  2 May 2025 09:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PIL1LPM3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4F822D78B
	for <linux-pm@vger.kernel.org>; Fri,  2 May 2025 09:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746178139; cv=none; b=LHs2YvOPM4Ul/0NQQcnL9mj3+dekbrBS1yM83GBjMkmqANMz958i3u5oQm+wp3ftedL0kU9TIpoevOKpDryCmm3dR8U4G0g6mGlQYqD+t/k4ZVECiuG0Go0FdG6yw2S1GYh07geJjW6NiDKTMVK2A7elLidRrkNooRjKrCu8e9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746178139; c=relaxed/simple;
	bh=MU5VnR8gfGuokKSR1cu55mBiw3QOCSy7dOGMpt+nFvU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DJXVDRemL/4RM+EIHQ/40GDYQy/nt/tdJUiaPZXYKYwQcu8ugFhYMS1AgJqcE55gptyB7h+UDrbhnkOr2pYf/IchQYbu+H+jIuoAiKkl+vHrJl/qvMrS17tCGjeCOjll2CmOYfpW48NqgxNneizj4AzIB6gCeW4Cln3TUtnjhIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PIL1LPM3; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so10684745e9.1
        for <linux-pm@vger.kernel.org>; Fri, 02 May 2025 02:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746178134; x=1746782934; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ViRvzjaLcZLigmLks7GcF1ISnVvCf8CLyjzMf6xzHz8=;
        b=PIL1LPM3CMCjd1O4DpA9B/NAZRAJ+LYuHwbXGejBp1WzL3ZB/lxOIiRP94SjHbnAoA
         I5v10LVQQUmnKQUV/mdVco01MbwN7xDT4x0FeGlA6N9v/nYvf+RjrJhxLEkvpXnBU8sj
         g2KHOTR0GngDTCk1xU8jb1jAZHVxvlmQ4cO0qabdXW5Zlr8oMZ1X2lmlRS6JnrqicOUt
         1FmJG2FaPZgrzgTQQKV4WK8Xp+7vcgEosL4wUCiZrj+6FXLekyXKBxTZ9KjKlLRr9Yek
         ayjND4cQDd3PoHW8BSiWJ0xyXJXyjf3KmEVcmwWK694KLeck/Ku2/u+UVuAlTwvx8bRB
         ZdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746178134; x=1746782934;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ViRvzjaLcZLigmLks7GcF1ISnVvCf8CLyjzMf6xzHz8=;
        b=KpFC2nBfHkZNw4sHzpQDBLrpHO8u5YmQ513Qzcssif8ybrSyZuPgO+ko5KvFsa/Y8a
         J6l+aGs5DLiTsG9PRDXRsT/ffmxefQa36X3lHMb7nAANfQKmWQWVzGuxlyWFfVAMta4H
         uotLw99umGwp4inWBrf1+r6NDRJ6AJjEYqd5E3ziW1YqYFUkg5biID/6YdymhnqsysP9
         jdnLOEG3J5Opmbjbu0I7VaRN8Vmy2b3WXTOICh5kCwI9qZ02RtvuhbNDTUFsvb7J0zqe
         bdrphQ63Fwg0mP1Q0fGW64E0ZYmbE2u5AyK6Q8gZRNtgHvTPaMAsVzVOw1IKAWwUCS3N
         3F+g==
X-Forwarded-Encrypted: i=1; AJvYcCV4BzTo6/DRekohvHwTow2T5AEm9xNfd8SKXV7ssNyO3iY6e1zqbD8qGNPK9SjE5D6pUCA3Q6dQiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzirxlw8GOymSy83fkF4jP/PRJhgyk5HjFYHcyqQJoVlyqPn80p
	NMG1oinqZ2Sz2h14zCInYw8Ish5Ddekuv8XJSQrDRW8pO32598sToO9T2eZilm8=
X-Gm-Gg: ASbGnctP2nzhrQ7Hoay9XhM3gygp2I3w8rd5e2CrRb4lh5fPJXuNHsDlSdAYrxO7lCG
	IvprDUMyPeFw0Wc8lIWk/khQAlBtNtK4CDMTACiTiyLHdGvfjtwSgAKZ7BKPD2nugdkMxzdu8Hg
	pc40afoFuq0t4kMn3ZWCMb8xIi/6qTVXHox5dKOjZqQauXBcB4eOaGRO/FkVBytkmAXjJVNnllv
	z42r9Q4eiI7OhEYOQs3tSG+soGjNz6kcruKeyotetq7UYiLoCLfSpFYqJ9mvJki4LrB4UAviyvw
	81SH0AoYVXuGM1dg/jmG2JhLhkyy9FmVugsKwcCMaRC9WeymioNXLiw3+C4WK4Tvl7TsC11kB7Q
	oXqXih4i1FLtdhCziKQ==
X-Google-Smtp-Source: AGHT+IFdzpFCq/AKM2M60tLarPzfNzRS71t1Qx6ljZBZ9X1pkBARCiAgk24b8LF0h/i54NmkF0IPyQ==
X-Received: by 2002:a05:600c:1d27:b0:43d:77c5:9c1a with SMTP id 5b1f17b1804b1-441bbea0d54mr15155615e9.4.1746178134562;
        Fri, 02 May 2025 02:28:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:161e:57b7:439b:f09f? ([2a01:e0a:3d9:2080:161e:57b7:439b:f09f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b89d150fsm38137425e9.15.2025.05.02.02.28.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 02:28:54 -0700 (PDT)
Message-ID: <9bf9b71f-e7d6-40ac-9fe8-a8396db0870e@linaro.org>
Date: Fri, 2 May 2025 11:28:53 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 4/9] soc: qcom: geni-se: Enable QUPs on SA8255p
 Qualcomm platforms
To: Praveen Talari <quic_ptalari@quicinc.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Cc: psodagud@quicinc.com, djaggi@quicinc.com, quic_msavaliy@quicinc.com,
 quic_vtanuku@quicinc.com, quic_arandive@quicinc.com,
 quic_mnaresh@quicinc.com, quic_shazhuss@quicinc.com
References: <20250502031018.1292-1-quic_ptalari@quicinc.com>
 <20250502031018.1292-5-quic_ptalari@quicinc.com>
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
In-Reply-To: <20250502031018.1292-5-quic_ptalari@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/05/2025 05:10, Praveen Talari wrote:
> On the sa8255p platform, resources such as clocks,interconnects
> and TLMM (GPIO) configurations are managed by firmware.
> 
> Introduce a platform data function callback to distinguish whether
> resource control is performed by firmware or directly by the driver
> in linux.
> 
> The refactor ensures clear differentiation of resource
> management mechanisms, improving maintainability and flexibility
> in handling platform-specific configurations.
> 
> Signed-off-by: Praveen Talari <quic_ptalari@quicinc.com>
> 
> v1 -> v2
> - changed datatype of i from int to unsigned int as per comment.
> ---
>   drivers/soc/qcom/qcom-geni-se.c | 77 +++++++++++++++++++++------------
>   1 file changed, 49 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
> index 4cb959106efa..0e3658b09603 100644
> --- a/drivers/soc/qcom/qcom-geni-se.c
> +++ b/drivers/soc/qcom/qcom-geni-se.c
> @@ -105,6 +105,8 @@ struct geni_wrapper {
>   struct geni_se_desc {
>   	unsigned int num_clks;
>   	const char * const *clks;
> +	int (*geni_se_rsc_init)(struct geni_wrapper *wrapper,
> +				const struct geni_se_desc *desc);
>   };
>   
>   static const char * const icc_path_names[] = {"qup-core", "qup-config",
> @@ -891,10 +893,44 @@ int geni_icc_disable(struct geni_se *se)
>   }
>   EXPORT_SYMBOL_GPL(geni_icc_disable);
>   
> +static int geni_se_resource_init(struct geni_wrapper *wrapper,
> +				 const struct geni_se_desc *desc)
> +{
> +	struct device *dev = wrapper->dev;
> +	int ret;
> +	unsigned int i;
> +
> +	wrapper->num_clks = min_t(unsigned int, desc->num_clks, MAX_CLKS);
> +
> +	for (i = 0; i < wrapper->num_clks; ++i)
> +		wrapper->clks[i].id = desc->clks[i];
> +
> +	ret = of_count_phandle_with_args(dev->of_node, "clocks", "#clock-cells");
> +	if (ret < 0) {
> +		dev_err(dev, "invalid clocks property at %pOF\n", dev->of_node);
> +		return ret;
> +	}
> +
> +	if (ret < wrapper->num_clks) {
> +		dev_err(dev, "invalid clocks count at %pOF, expected %d entries\n",
> +			dev->of_node, wrapper->num_clks);
> +		return -EINVAL;
> +	}
> +
> +	ret = devm_clk_bulk_get(dev, wrapper->num_clks, wrapper->clks);
> +	if (ret) {
> +		dev_err(dev, "Err getting clks %d\n", ret);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
>   static int geni_se_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
>   	struct geni_wrapper *wrapper;
> +	const struct geni_se_desc *desc;
>   	int ret;
>   
>   	wrapper = devm_kzalloc(dev, sizeof(*wrapper), GFP_KERNEL);
> @@ -906,36 +942,12 @@ static int geni_se_probe(struct platform_device *pdev)
>   	if (IS_ERR(wrapper->base))
>   		return PTR_ERR(wrapper->base);
>   
> -	if (!has_acpi_companion(&pdev->dev)) {
> -		const struct geni_se_desc *desc;
> -		int i;
> -
> -		desc = device_get_match_data(&pdev->dev);
> -		if (!desc)
> -			return -EINVAL;
> -
> -		wrapper->num_clks = min_t(unsigned int, desc->num_clks, MAX_CLKS);
> -
> -		for (i = 0; i < wrapper->num_clks; ++i)
> -			wrapper->clks[i].id = desc->clks[i];
> -
> -		ret = of_count_phandle_with_args(dev->of_node, "clocks", "#clock-cells");
> -		if (ret < 0) {
> -			dev_err(dev, "invalid clocks property at %pOF\n", dev->of_node);
> -			return ret;
> -		}
> +	desc = device_get_match_data(&pdev->dev);
>   
> -		if (ret < wrapper->num_clks) {
> -			dev_err(dev, "invalid clocks count at %pOF, expected %d entries\n",
> -				dev->of_node, wrapper->num_clks);
> +	if (!has_acpi_companion(&pdev->dev) && desc->geni_se_rsc_init) {
> +		ret = desc->geni_se_rsc_init(wrapper, desc);
> +		if (ret)
>   			return -EINVAL;
> -		}
> -
> -		ret = devm_clk_bulk_get(dev, wrapper->num_clks, wrapper->clks);
> -		if (ret) {
> -			dev_err(dev, "Err getting clks %d\n", ret);
> -			return ret;
> -		}
>   	}
>   
>   	dev_set_drvdata(dev, wrapper);
> @@ -951,6 +963,13 @@ static const char * const qup_clks[] = {
>   static const struct geni_se_desc qup_desc = {
>   	.clks = qup_clks,
>   	.num_clks = ARRAY_SIZE(qup_clks),
> +	.geni_se_rsc_init = geni_se_resource_init,
> +};
> +
> +static const struct geni_se_desc sa8255p_qup_desc = {
> +	.clks = NULL,
> +	.num_clks = 0,
> +	.geni_se_rsc_init = NULL,

Just don't specify it, it will be NULL by default, same for the other fields aswell.

Just declare an empty struct instead, maybe add a comment if you want the reader
to understand there's no clocks for this instance type.

Another much simpler way to implement this would be to just check for num_clks
along !has_acpi_companion(&pdev->dev) like:

if (!has_acpi_companion(&pdev->dev) && desc->num_clks) {

}

And you're done.

Neil

>   };
>   
>   static const char * const i2c_master_hub_clks[] = {
> @@ -960,11 +979,13 @@ static const char * const i2c_master_hub_clks[] = {
>   static const struct geni_se_desc i2c_master_hub_desc = {
>   	.clks = i2c_master_hub_clks,
>   	.num_clks = ARRAY_SIZE(i2c_master_hub_clks),
> +	.geni_se_rsc_init = geni_se_resource_init,
>   };
>   
>   static const struct of_device_id geni_se_dt_match[] = {
>   	{ .compatible = "qcom,geni-se-qup", .data = &qup_desc },
>   	{ .compatible = "qcom,geni-se-i2c-master-hub", .data = &i2c_master_hub_desc },
> +	{ .compatible = "qcom,sa8255p-geni-se-qup", .data = &sa8255p_qup_desc },
>   	{}
>   };
>   MODULE_DEVICE_TABLE(of, geni_se_dt_match);


