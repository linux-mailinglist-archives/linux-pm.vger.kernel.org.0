Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E85C84C1B
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2019 14:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbfHGMx7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Aug 2019 08:53:59 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38900 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbfHGMx6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Aug 2019 08:53:58 -0400
Received: by mail-lj1-f195.google.com with SMTP id r9so85362200ljg.5
        for <linux-pm@vger.kernel.org>; Wed, 07 Aug 2019 05:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c/zLwd8HNpguG/AbdpxIDoWAPn4KcVkLv5Fqa19DHlk=;
        b=Kq8FX4m+/2evCTbQm5MWBFIJRWSsGvSbCWAsr/KoKleFQzEM8+t7RdxtDegWrZXfLP
         yw4wwCJS43vwOznVEts+MsZWNwsGv46NOPf8zNhj07O88M69UBaIcNl/zmHo6i773x8Z
         5RJ8O8m1MhaarDlLymClWOS+kieGpDSK7gnbBuz61wwqNIb/pvF5rLbGSNjEy6UFnjji
         oBgxcNSK/sgTY0YvddITbGNajgCl9AihWKnYwur/K/nN7Fp6pnyW+biQIqYkfUVLMJAz
         o1ZLoOQcVSZ7sJl82QNd0U4J9HLaqAC7PAT561CEooxDw5JaZcGMDr4sHCDTXMHntIL7
         TFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c/zLwd8HNpguG/AbdpxIDoWAPn4KcVkLv5Fqa19DHlk=;
        b=L7/VGArZR5HtUPFjQ/JgSufB+UaMh6q0um1+P/Bc5s9CN8SxsdaYMLy+FckCUAsLmc
         F66XnBo/dUaC2dNrHBQ/lpqIsLqbBcYQoMA0pO0UEUuY3bUUNZEsuTx/d26L4qalerC4
         UQgQE3f7bu6GBm6K2FQ1lCaNlTOeoVdXMokqdqopzJpy+sO4N72nLXI3na5msyil1TF+
         x/UrrJUx+UPold+yKi8LsK7lrzL7274qOeOa5+ZI8S3y6F8dladug6yc20+QeZaGIdJy
         mDY+A/K9vEivccrl3PuDEij0ZPFTZ77xMqQjjiI0sipZ1e0ompW2gA3DZeoQMShr6vY6
         J7CA==
X-Gm-Message-State: APjAAAUcVzA4GIX0doFK8DxiYLxqeWLJ7D2/5ilNkAd5GN2MUn+bprsB
        AmbR9BeE/42K0CuhwXMIjwnvdQ==
X-Google-Smtp-Source: APXvYqwdybcHuc+v6ETpWhC3XlXosGokGrmeQ3U6Bnkfr00yR9FCdNxpMISI75jOwLzXZfbqej7OCA==
X-Received: by 2002:a2e:9b03:: with SMTP id u3mr4784867lji.15.1565182436201;
        Wed, 07 Aug 2019 05:53:56 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id v25sm449086lfg.77.2019.08.07.05.53.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 05:53:55 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] OPP: Add support for bandwidth OPP tables
To:     Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     vincent.guittot@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, adharmap@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>, sibis@codeaurora.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        kernel-team@android.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190726231558.175130-1-saravanak@google.com>
 <20190726231558.175130-3-saravanak@google.com>
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
Message-ID: <fc8e4a77-5544-0dd7-f103-147f87e44a28@linaro.org>
Date:   Wed, 7 Aug 2019 15:53:53 +0300
MIME-Version: 1.0
In-Reply-To: <20190726231558.175130-3-saravanak@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Saravana,

On 7/27/19 02:15, Saravana Kannan wrote:
> Not all devices quantify their performance points in terms of frequency.
> Devices like interconnects quantify their performance points in terms of
> bandwidth. We need a way to represent these bandwidth levels in OPP. So,
> add support for parsing bandwidth OPPs from DT.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/opp/of.c  | 41 ++++++++++++++++++++++++++++++++---------
>  drivers/opp/opp.h |  4 +++-
>  2 files changed, 35 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index b313aca9894f..ac73512f4416 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -523,6 +523,35 @@ void dev_pm_opp_of_remove_table(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
>  
> +static int _read_opp_key(struct dev_pm_opp *new_opp, struct device_node *np)
> +{
> +	int ret;
> +	u64 rate;
> +	u32 bw;
> +
> +	ret = of_property_read_u64(np, "opp-hz", &rate);
> +	if (!ret) {
> +		/*
> +		 * Rate is defined as an unsigned long in clk API, and so
> +		 * casting explicitly to its type. Must be fixed once rate is 64
> +		 * bit guaranteed in clk API.
> +		 */
> +		new_opp->rate = (unsigned long)rate;
> +		return 0;

So we can't have a single OPP table with both frequency and bandwidth?

> +	}
> +
> +	ret = of_property_read_u32(np, "opp-peak-KBps", &bw);
> +	if (ret)
> +		return ret;
> +	new_opp->rate = (unsigned long) bw;
> +
> +	ret = of_property_read_u32(np, "opp-avg-KBps", &bw);
> +	if (!ret)
> +		new_opp->avg_bw = (unsigned long) bw;
> +
> +	return 0;
> +}
> +
>  /**
>   * _opp_add_static_v2() - Allocate static OPPs (As per 'v2' DT bindings)
>   * @opp_table:	OPP table
> @@ -560,22 +589,16 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
>  	if (!new_opp)
>  		return ERR_PTR(-ENOMEM);
>  
> -	ret = of_property_read_u64(np, "opp-hz", &rate);
> +	ret = _read_opp_key(new_opp, np);
>  	if (ret < 0) {
>  		/* "opp-hz" is optional for devices like power domains. */
>  		if (!opp_table->is_genpd) {
> -			dev_err(dev, "%s: opp-hz not found\n", __func__);
> +			dev_err(dev, "%s: opp-hz or opp-peak-bw not found\n",

s/opp-peak-bw/opp-peak-kBps/

Thanks,
Georgi
