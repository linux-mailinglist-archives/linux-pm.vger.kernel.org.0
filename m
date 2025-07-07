Return-Path: <linux-pm+bounces-30291-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C71A4AFB46D
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 15:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5FEF1AA4E8A
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 13:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB19D298275;
	Mon,  7 Jul 2025 13:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gevcj9V9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA992980B4
	for <linux-pm@vger.kernel.org>; Mon,  7 Jul 2025 13:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751894613; cv=none; b=Vlr+Y7YzkCBtClzlSauODuX0pOIKxE/WcboadGbK5SbAsUQjz2dXUiJJY38YmJ8d79fhTXlM9kZ7wv16nHttBYyPCjYwQL8/AMOxVvpE6/9gKJM6YdY9+QcUMtPTb8HpQUGWMJ4HgRXebAEEVCTFoTbvcx7l9FdDPe3D5FXINnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751894613; c=relaxed/simple;
	bh=9XfDpieyU8b2140bQho6t1DhMkVdpW1ldUV4ZihuTTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WP1gLF7Som3IKjqKNZn2wsnSFL0LGh2nTMZ5uO2Q59N/yJlHj7UMMcbuJMkz5ibqyvIBZnQSqdRdhIfef1CDUL/7vdq58BWkczIQ4p4cyC655Iq/ecDL4/z25mDSx5YLPo7gHc6fQ4XRkhVKsHufdY39SQ/akizIo8DbqEoYc04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gevcj9V9; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a54690d369so3098110f8f.3
        for <linux-pm@vger.kernel.org>; Mon, 07 Jul 2025 06:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751894610; x=1752499410; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A1JkCspwJaFqJzSejsi2dTXNLAQ9s3FaAdM20lcOhVo=;
        b=Gevcj9V9EMw7bXaPKvYUKkie88kBByVNXW+lKU1EXPEP7LZnEfQUV3cn8x58bQVVwi
         DgvPnSK4Ricdtz+otQKqZyLyJ5TkD/C1qTC3MpneMBtyg2nhIg07TkqqxsG8eOLi9h/D
         nTQf2/HI/huOU+tN1ZB3FXviCoSl//+xlUS+96oCVHelxXpJE76qCWXJP7zxmA1Mzp2f
         dPjFXQJAWLFBcoWMt0XFh3iXIC+jYPUmceClcCnKCf79zK6AL36Sb8fUFUVQowvTuKu1
         akNZ5I/q+bfK3Vl+ju0teTttgLIrwM5838oQPUPhCAIxx8Y8ej81BimX9aQPl8nS8fnc
         Cf2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751894610; x=1752499410;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A1JkCspwJaFqJzSejsi2dTXNLAQ9s3FaAdM20lcOhVo=;
        b=kNBJvmwx0UlJEnd7y/5WFuasCYMBQB9wXgz8tAZWFA1HgQVU65czGarRxhMHoX0jcZ
         BqxKw5GFjl6XqDeZ8wEtH+Yqy+GgrSChfHzp6An0EOPFsyIotDXXaKutzQS0NUwIxCl9
         AhUIQMzo3DldoS1ib8mS3Zf+J26gOZSpUkjrucHxAiFIh8ye1oVIxXMbLazXj1q9MFC8
         NEoSPMFnrJyxj78/tVSaNaZhtj1Ybd72ae66qmlh5kqikPLK7bF3W/zZTsZF2ICi5LrG
         p1f9lVup5lCRtRzMFILtelCHZg/d1MO3stXiktc0a9z0oJsZE/5KVcOdlqx6fWlDmu6R
         mXwg==
X-Forwarded-Encrypted: i=1; AJvYcCVb/thDEv98RE0SOccsKjJMDQeOS06aYbtwy8MyHzLxsZR94kuMeUAjQtr8Nav0dordcsTOIUmPTg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOzH6MOfaiv3H6puH8R7Ys5EoaDYuH4iEdITn4PtVC/a2co+dv
	ZfhHBxUDofk1RBq2lwHuGEflqIMUbCyvQ2PL+mxikErYpElO3UGXvLnxe7RwBznBOts=
X-Gm-Gg: ASbGncu1WQQ4KQtqutjy5T/tjFfZ1lgh1J2izOgXaN6MmsBb3u8lR/EpA8mYGjIT9oj
	9TyUKMrJKQHTXrEywE33eZlo0gR96ChIEKbQ5YZ+ytsaFfUqQcxgCZ6zYHvM0fvhD3K70VKUGVj
	zV/BIRGtoRi0tBrqmhqH6Fd9La8/CIQpp0wG8xF6Soz0Wob0pgk2XTCLfJZ7hS8L6loO+1TEsfv
	MZ7FuSB2DflTOY8sFY1BtYjIX04hWmYHDAazMNJ3LvZ44Z2G1fCu7piWyQiao5eq5fJCCXktVVz
	9nhNO7ssZfo6J7ct/rtUBKTIIQxMU7X6hzZqJqYq1ErKaZbjDYsrH1YhPRfqiC+3G/ylGHIpWVk
	Vw/1qSs0omk0CiPJmnQnQttmM5xTOdI4=
X-Google-Smtp-Source: AGHT+IHqvfoZlxqkZhFZeUbrhKra+ACvfYiFm+JNhrK5L5id15gKmlIVnrRthZyMexYFNceXyA6Kmg==
X-Received: by 2002:a5d:59c4:0:b0:3a3:6595:9209 with SMTP id ffacd0b85a97d-3b4970294afmr9707717f8f.36.1751894610045;
        Mon, 07 Jul 2025 06:23:30 -0700 (PDT)
Received: from [192.168.1.159] (p4fc3d4fa.dip0.t-ipconnect.de. [79.195.212.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a9be0bacsm138744515e9.32.2025.07.07.06.23.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 06:23:29 -0700 (PDT)
Message-ID: <06760125-4800-4068-8936-dddf27c28d17@linaro.org>
Date: Mon, 7 Jul 2025 15:23:28 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] pmdomain: qcom: rpmhpd: Add Milos power domains
To: Luca Weiss <luca.weiss@fairphone.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20250707-sm7635-rpmhpd-v2-0-b4aa37acb065@fairphone.com>
 <20250707-sm7635-rpmhpd-v2-2-b4aa37acb065@fairphone.com>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250707-sm7635-rpmhpd-v2-2-b4aa37acb065@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/7/25 12:18, Luca Weiss wrote:
> Add the power domains exposed by RPMH in the Qualcomm Milos platform.

\o/ codenames!

> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>   drivers/pmdomain/qcom/rpmhpd.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
> index 078323b85b5648e33dd89e08cf31bdc5ab76d553..e09552a469264f28952fc46c3ab8c125e87310da 100644
> --- a/drivers/pmdomain/qcom/rpmhpd.c
> +++ b/drivers/pmdomain/qcom/rpmhpd.c
> @@ -217,6 +217,24 @@ static struct rpmhpd gmxc = {
>   	.res_name = "gmxc.lvl",
>   };
>   
> +/* Milos RPMH powerdomains */

I can't find any public docs telling us which SoC is Milos (the only 
relevant result is Bjorn's email asking you to use that name instead of 
SM7635). So for the sake of future generations could you reference both 
names in a comment somewhere? Or even the commit message would be enough 
tbh.

Off-topic here, but maybe it would be a good idea to add some Qualcomm 
platform docs to the kernel with a table of all the publicly known names 
for each SoC? This would also be really helpful even ignoring codenames 
just to know that SM8550 is Snapdragon 8 Gen 2 for example.

Kind regards,
Casey (she/they)

> +static struct rpmhpd *milos_rpmhpds[] = {
> +	[RPMHPD_CX] = &cx,
> +	[RPMHPD_CX_AO] = &cx_ao,
> +	[RPMHPD_EBI] = &ebi,
> +	[RPMHPD_GFX] = &gfx,
> +	[RPMHPD_LCX] = &lcx,
> +	[RPMHPD_LMX] = &lmx,
> +	[RPMHPD_MSS] = &mss,
> +	[RPMHPD_MX] = &mx,
> +	[RPMHPD_MX_AO] = &mx_ao,
> +};
> +
> +static const struct rpmhpd_desc milos_desc = {
> +	.rpmhpds = milos_rpmhpds,
> +	.num_pds = ARRAY_SIZE(milos_rpmhpds),
> +};
> +
>   /* SA8540P RPMH powerdomains */
>   static struct rpmhpd *sa8540p_rpmhpds[] = {
>   	[SC8280XP_CX] = &cx,
> @@ -723,6 +741,7 @@ static const struct rpmhpd_desc qcs615_desc = {
>   };
>   
>   static const struct of_device_id rpmhpd_match_table[] = {
> +	{ .compatible = "qcom,milos-rpmhpd", .data = &milos_desc },
>   	{ .compatible = "qcom,qcs615-rpmhpd", .data = &qcs615_desc },
>   	{ .compatible = "qcom,qcs8300-rpmhpd", .data = &qcs8300_desc },
>   	{ .compatible = "qcom,qdu1000-rpmhpd", .data = &qdu1000_desc },
> 

