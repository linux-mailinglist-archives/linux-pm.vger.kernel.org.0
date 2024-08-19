Return-Path: <linux-pm+bounces-12410-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8112395668D
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 11:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A59841C21191
	for <lists+linux-pm@lfdr.de>; Mon, 19 Aug 2024 09:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FC515C12C;
	Mon, 19 Aug 2024 09:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gfbcVoDO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587892BB10
	for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2024 09:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724058938; cv=none; b=HEkcn0lQPtthJ0NiZ8gRi51WNhfOJ14zZRRcSHKxQBgLzgmuE5AaXy1AE6cWX7aSRb1qIFi7lFse4oIbB4OVVKGGgSilBwM7o/uAEruXMVlnC8tR0jo36GkdCS8c+FUinAzMADBJdW4kp7PDEuHbG8RGUV0zOK3SU4OwUjOjTks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724058938; c=relaxed/simple;
	bh=3q+GIOIELSHXV7WlVyAxrFLrS7xx1dFZLFmfG3Cl82E=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=I9bu4dmhorNMf2VMuXNlN/gUFfBYgX9MFdbzgWHGCn65Gb6TZ1mU1wmFtqYsIU0DJotJEgPwFQrnss2ugjMvqY6uAj8QTo9DNFDpEcnjD+Mpw3TIkNEgAQWB2CL+o5cd3Uwapvv3aTcc33GiPyPqhFF0+57ZsNIjLDaWl/lKmNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gfbcVoDO; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4280c55e488so21044485e9.0
        for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2024 02:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724058935; x=1724663735; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oXtnlW4Sq7mW/JKowxl/ZIPyqcaCGK4EvBTc/Fe9nUs=;
        b=gfbcVoDOPRm8IH81Bh9W0mKSoc9z6uk+K0fNlbEuFHcMFWgIO7HmUvWrO4jcDRnP9c
         nQM/abr7z2+0Ibexhd2xb2SCRlZz0UptJyIAg/dF+YdkweXAggHoKygW37IBsNJlKO62
         MfUyixkYeJ7haJ269Cgk1V7vLvQqkJsz0tLYqGHkbv3+OgNQd2lbLX+YVYV1DybWuqak
         YUxTTBDSTUn6XQ6LB6p8sy1brVOlpoPeaBmGXYg1oT8YGHcPdG2bXIlmdTS9C3KvbHCs
         9oprrjhWWLRJvTEvY8ADfzn2f1lX358HrnVjF46QM0bd9tl//XuiPI3/0lXHCZPWUNZy
         r1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724058935; x=1724663735;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oXtnlW4Sq7mW/JKowxl/ZIPyqcaCGK4EvBTc/Fe9nUs=;
        b=fmyRYdrLvQaGCsZU/LC3g/u5W0kRco+X0gJwlgAjyirjrg7gkRnNmUuFot2q0SfyUj
         4Jxl5WowzP2TJNrLm+jwRYFCmhWIx9abMzzD3ala0wOxeliJ3WsHZTHALrYcI7Ioqn5Z
         Zjj29QKQa1T7tYhxd8mOduD4NFKoRU3sM9df1AzsV8e80Bcc4vtBBGEVyQQQmtOmNgR/
         2UiNmGe5GfyuGBSiWY8mOfFKGCisU52LzPSkPq8O3TsVUf/uhLREL9K8wb4/JlHrmjsu
         6vlnzmu1+EPdSKO6o7Mk0K3GbjQ+9JH3PcY0s/TxbQeQ72XGRCTdM7zVuKNa6NXr7+JJ
         xxGA==
X-Forwarded-Encrypted: i=1; AJvYcCXbDy2Cb96C7/z2WJsCEEgRg6qTVlvDFwfiqEDYjGSMOH4fQbNmHqvyBdHHjuLv8peNWU1ZWEFvN014gvFDnahMukyhyRLbGHU=
X-Gm-Message-State: AOJu0YySy3hkIAn9GiFyb6QMMEg43pqs/RBxCVcaNCVRFnzHtlwswUao
	bwZnkk02R5WW+tBxCmr4Q0/ESiykJGtxpihV6jpqUDHRHxhyn9vdSNbNEJeRdtE=
X-Google-Smtp-Source: AGHT+IH+/bJh5xJJ+QT2txt2YE0xVYC102Lva0vs73xa+niumknhArjUDAYCwhN9wbWJfLDux7fhNg==
X-Received: by 2002:a05:600c:3581:b0:428:6ac:426e with SMTP id 5b1f17b1804b1-429e232bae5mr97082815e9.5.1724058934212;
        Mon, 19 Aug 2024 02:15:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f54e:4b0a:5175:5727? ([2a01:e0a:982:cbb0:f54e:4b0a:5175:5727])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed650735sm101794465e9.12.2024.08.19.02.15.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 02:15:33 -0700 (PDT)
Message-ID: <30dc4254-ff2b-4bd3-aea8-1be8da11fb8e@linaro.org>
Date: Mon, 19 Aug 2024 11:15:32 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/3] soc: qcom: pmic_glink: Fix race during initialization
To: Bjorn Andersson <quic_bjorande@quicinc.com>,
 Sebastian Reichel <sre@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, Chris Lew
 <quic_clew@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Stephen Boyd <swboyd@chromium.org>, Amit Pundir <amit.pundir@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 Johan Hovold <johan@kernel.org>, stable@vger.kernel.org
References: <20240818-pmic-glink-v6-11-races-v1-0-f87c577e0bc9@quicinc.com>
 <20240818-pmic-glink-v6-11-races-v1-1-f87c577e0bc9@quicinc.com>
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
In-Reply-To: <20240818-pmic-glink-v6-11-races-v1-1-f87c577e0bc9@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/08/2024 01:17, Bjorn Andersson wrote:
> As pointed out by Stephen Boyd it is possible that during initialization
> of the pmic_glink child drivers, the protection-domain notifiers fires,
> and the associated work is scheduled, before the client registration
> returns and as a result the local "client" pointer has been initialized.
> 
> The outcome of this is a NULL pointer dereference as the "client"
> pointer is blindly dereferenced.
> 
> Timeline provided by Stephen:
>   CPU0                               CPU1
>   ----                               ----
>   ucsi->client = NULL;
>   devm_pmic_glink_register_client()
>    client->pdr_notify(client->priv, pg->client_state)
>     pmic_glink_ucsi_pdr_notify()
>      schedule_work(&ucsi->register_work)
>      <schedule away>
>                                      pmic_glink_ucsi_register()
>                                       ucsi_register()
>                                        pmic_glink_ucsi_read_version()
>                                         pmic_glink_ucsi_read()
>                                          pmic_glink_ucsi_read()
>                                           pmic_glink_send(ucsi->client)
>                                           <client is NULL BAD>
>   ucsi->client = client // Too late!
> 
> This code is identical across the altmode, battery manager and usci
> child drivers.
> 
> Resolve this by splitting the allocation of the "client" object and the
> registration thereof into two operations.
> 
> This only happens if the protection domain registry is populated at the
> time of registration, which by the introduction of commit '1ebcde047c54
> ("soc: qcom: add pd-mapper implementation")' became much more likely.
> 
> Reported-by: Amit Pundir <amit.pundir@linaro.org>
> Closes: https://lore.kernel.org/all/CAMi1Hd2_a7TjA7J9ShrAbNOd_CoZ3D87twmO5t+nZxC9sX18tA@mail.gmail.com/
> Reported-by: Johan Hovold <johan@kernel.org>
> Closes: https://lore.kernel.org/all/ZqiyLvP0gkBnuekL@hovoldconsulting.com/
> Reported-by: Stephen Boyd <swboyd@chromium.org>
> Closes: https://lore.kernel.org/all/CAE-0n52JgfCBWiFQyQWPji8cq_rCsviBpW-m72YitgNfdaEhQg@mail.gmail.com/
> Fixes: 58ef4ece1e41 ("soc: qcom: pmic_glink: Introduce base PMIC GLINK driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>   drivers/power/supply/qcom_battmgr.c   | 16 ++++++++++------
>   drivers/soc/qcom/pmic_glink.c         | 28 ++++++++++++++++++----------
>   drivers/soc/qcom/pmic_glink_altmode.c | 17 +++++++++++------
>   drivers/usb/typec/ucsi/ucsi_glink.c   | 16 ++++++++++------
>   include/linux/soc/qcom/pmic_glink.h   | 11 ++++++-----
>   5 files changed, 55 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
> index 49bef4a5ac3f..df90a470c51a 100644
> --- a/drivers/power/supply/qcom_battmgr.c
> +++ b/drivers/power/supply/qcom_battmgr.c
> @@ -1387,12 +1387,16 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
>   					     "failed to register wireless charing power supply\n");
>   	}
>   
> -	battmgr->client = devm_pmic_glink_register_client(dev,
> -							  PMIC_GLINK_OWNER_BATTMGR,
> -							  qcom_battmgr_callback,
> -							  qcom_battmgr_pdr_notify,
> -							  battmgr);
> -	return PTR_ERR_OR_ZERO(battmgr->client);
> +	battmgr->client = devm_pmic_glink_new_client(dev, PMIC_GLINK_OWNER_BATTMGR,
> +						     qcom_battmgr_callback,
> +						     qcom_battmgr_pdr_notify,
> +						     battmgr);
> +	if (IS_ERR(battmgr->client))
> +		return PTR_ERR(battmgr->client);
> +
> +	pmic_glink_register_client(battmgr->client);
> +
> +	return 0;
>   }
>   
>   static const struct auxiliary_device_id qcom_battmgr_id_table[] = {
> diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
> index 9ebc0ba35947..58ec91767d79 100644
> --- a/drivers/soc/qcom/pmic_glink.c
> +++ b/drivers/soc/qcom/pmic_glink.c
> @@ -66,15 +66,14 @@ static void _devm_pmic_glink_release_client(struct device *dev, void *res)
>   	spin_unlock_irqrestore(&pg->client_lock, flags);
>   }
>   
> -struct pmic_glink_client *devm_pmic_glink_register_client(struct device *dev,
> -							  unsigned int id,
> -							  void (*cb)(const void *, size_t, void *),
> -							  void (*pdr)(void *, int),
> -							  void *priv)
> +struct pmic_glink_client *devm_pmic_glink_new_client(struct device *dev,
> +						     unsigned int id,
> +						     void (*cb)(const void *, size_t, void *),
> +						     void (*pdr)(void *, int),
> +						     void *priv)
>   {
>   	struct pmic_glink_client *client;
>   	struct pmic_glink *pg = dev_get_drvdata(dev->parent);
> -	unsigned long flags;
>   
>   	client = devres_alloc(_devm_pmic_glink_release_client, sizeof(*client), GFP_KERNEL);
>   	if (!client)
> @@ -85,6 +84,18 @@ struct pmic_glink_client *devm_pmic_glink_register_client(struct device *dev,
>   	client->cb = cb;
>   	client->pdr_notify = pdr;
>   	client->priv = priv;
> +	INIT_LIST_HEAD(&client->node);
> +
> +	devres_add(dev, client);
> +
> +	return client;
> +}
> +EXPORT_SYMBOL_GPL(devm_pmic_glink_new_client);
> +
> +void pmic_glink_register_client(struct pmic_glink_client *client)
> +{
> +	struct pmic_glink *pg = client->pg;
> +	unsigned long flags;
>   
>   	mutex_lock(&pg->state_lock);
>   	spin_lock_irqsave(&pg->client_lock, flags);
> @@ -95,11 +106,8 @@ struct pmic_glink_client *devm_pmic_glink_register_client(struct device *dev,
>   	spin_unlock_irqrestore(&pg->client_lock, flags);
>   	mutex_unlock(&pg->state_lock);
>   
> -	devres_add(dev, client);
> -
> -	return client;
>   }
> -EXPORT_SYMBOL_GPL(devm_pmic_glink_register_client);
> +EXPORT_SYMBOL_GPL(pmic_glink_register_client);
>   
>   int pmic_glink_send(struct pmic_glink_client *client, void *data, size_t len)
>   {
> diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
> index 1e0808b3cb93..e4f5059256e5 100644
> --- a/drivers/soc/qcom/pmic_glink_altmode.c
> +++ b/drivers/soc/qcom/pmic_glink_altmode.c
> @@ -520,12 +520,17 @@ static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
>   			return ret;
>   	}
>   
> -	altmode->client = devm_pmic_glink_register_client(dev,
> -							  altmode->owner_id,
> -							  pmic_glink_altmode_callback,
> -							  pmic_glink_altmode_pdr_notify,
> -							  altmode);
> -	return PTR_ERR_OR_ZERO(altmode->client);
> +	altmode->client = devm_pmic_glink_new_client(dev,
> +						     altmode->owner_id,
> +						     pmic_glink_altmode_callback,
> +						     pmic_glink_altmode_pdr_notify,
> +						     altmode);
> +	if (IS_ERR(altmode->client))
> +		return PTR_ERR(altmode->client);
> +
> +	pmic_glink_register_client(altmode->client);
> +
> +	return 0;
>   }
>   
>   static const struct auxiliary_device_id pmic_glink_altmode_id_table[] = {
> diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
> index 16c328497e0b..ac53a81c2a81 100644
> --- a/drivers/usb/typec/ucsi/ucsi_glink.c
> +++ b/drivers/usb/typec/ucsi/ucsi_glink.c
> @@ -367,12 +367,16 @@ static int pmic_glink_ucsi_probe(struct auxiliary_device *adev,
>   		ucsi->port_orientation[port] = desc;
>   	}
>   
> -	ucsi->client = devm_pmic_glink_register_client(dev,
> -						       PMIC_GLINK_OWNER_USBC,
> -						       pmic_glink_ucsi_callback,
> -						       pmic_glink_ucsi_pdr_notify,
> -						       ucsi);
> -	return PTR_ERR_OR_ZERO(ucsi->client);
> +	ucsi->client = devm_pmic_glink_new_client(dev, PMIC_GLINK_OWNER_USBC,
> +						  pmic_glink_ucsi_callback,
> +						  pmic_glink_ucsi_pdr_notify,
> +						  ucsi);
> +	if (IS_ERR(ucsi->client))
> +		return PTR_ERR(ucsi->client);
> +
> +	pmic_glink_register_client(ucsi->client);
> +
> +	return 0;
>   }
>   
>   static void pmic_glink_ucsi_remove(struct auxiliary_device *adev)
> diff --git a/include/linux/soc/qcom/pmic_glink.h b/include/linux/soc/qcom/pmic_glink.h
> index fd124aa18c81..aedde76d7e13 100644
> --- a/include/linux/soc/qcom/pmic_glink.h
> +++ b/include/linux/soc/qcom/pmic_glink.h
> @@ -23,10 +23,11 @@ struct pmic_glink_hdr {
>   
>   int pmic_glink_send(struct pmic_glink_client *client, void *data, size_t len);
>   
> -struct pmic_glink_client *devm_pmic_glink_register_client(struct device *dev,
> -							  unsigned int id,
> -							  void (*cb)(const void *, size_t, void *),
> -							  void (*pdr)(void *, int),
> -							  void *priv);
> +struct pmic_glink_client *devm_pmic_glink_new_client(struct device *dev,
> +						     unsigned int id,
> +						     void (*cb)(const void *, size_t, void *),
> +						     void (*pdr)(void *, int),
> +						     void *priv);
> +void pmic_glink_register_client(struct pmic_glink_client *client);
>   
>   #endif
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

