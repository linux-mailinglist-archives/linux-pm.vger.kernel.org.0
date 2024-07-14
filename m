Return-Path: <linux-pm+bounces-11080-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C1E930C12
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2024 00:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA26628173E
	for <lists+linux-pm@lfdr.de>; Sun, 14 Jul 2024 22:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B1D13D8AC;
	Sun, 14 Jul 2024 22:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OMoU1fAT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74BD1411E6
	for <linux-pm@vger.kernel.org>; Sun, 14 Jul 2024 22:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720997986; cv=none; b=JKvZwh6eLi1pWQowSCZb8vr3X+1OG65upHZmwGqAotCCrzENBQVfRpAfRs/+rZvL51akIpRwDBrQpNrH7CZ+G3xT3vtebrJ83LNIybOy1sKxOPAIL9z4spsmlHtmR3bBI4hcoqxkFjwaEiGySUpS/2xguCDUbo+Kq6l5sY9+nkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720997986; c=relaxed/simple;
	bh=iZaP93pqsL/e4ZO1V2MFXka+cpqy07kfC00KnNYtiu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EasqDKjCfe2B5QVWaXLkpfOZstGFUYKPP9lelhnWyI3vqwqU9lE9wAySzpaFaiFHzrlLHRt4jsz7u8L+xyMUtPY/xhJ2u4VGiFdliSCJj24kJ6c1Y83Wr9pfbpYUwU3sBfCwHc/257DoXR52BoQiq3uelRpsxDG1Jtka4QQB7PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OMoU1fAT; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2eeb1ba0481so50095881fa.2
        for <linux-pm@vger.kernel.org>; Sun, 14 Jul 2024 15:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720997982; x=1721602782; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lxkrc6+6TVPqzcihhgsA9iKZjrsTDfg27sQkkNiyYqg=;
        b=OMoU1fATr6W++5l13+cYfccRSoskB8H/333Pkbjcj0C3lN7HjIJE+lwFtRBjdDK3d/
         WQW2O79zmrsFfCrL/xK1D9glVkERZ+1yjfSYEFCqmN3Ppy+b4v6/Se2g7bdxywQEM/GQ
         Vu9ysDeMIHifeLrcG08rfZz2nfDXRe7WtB/ODW6dydoSz/335o8mfJWUteAgO1HjSInr
         fQImo+OWCeHuor1xG1WkKkzXgxuu3U9kcHRGK6hFWapaMfoYkyo5TJkKYXLfyhw4IqgH
         tW8qwnHafTjGwW7LULXoymy7pqK15SYD/sTfAjFB2G/Pzy0qTplAii1x7jrSHwEvp6qM
         Zh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720997982; x=1721602782;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lxkrc6+6TVPqzcihhgsA9iKZjrsTDfg27sQkkNiyYqg=;
        b=aMQg6yTgNEOAmKTlEc8q3sQ68qEoHMWbI5v1qhmThx3FrmiDPK+zP1O3Jj3x5X3MCJ
         oGiJ3czofhNrSz6x9hAqDI3qUiuHQyQd9FATtHicKZRfKpQSOuzYTGVFdkLeBar6h04f
         wkql8Z+L1mUySUHipqbTGfEewIK8JQ1V7PRSw3AM+I6gTEoyFopuxNZRZA0hPA7EJCMS
         8bGDQSSpfgOiig8PBRsT+1UKK3dHSM076H/WP8Ge/n0qTHba0Yxc2o8gBt38WUyiMYhp
         RFi0y43tZlgkuT9DadmH5nop2eVu+flUoJmWEMha8reWyk9oejWfJwaWdRHcMzSU53H8
         U8xg==
X-Forwarded-Encrypted: i=1; AJvYcCXBRQQIp/+2B8uEH3PBG6ttXFTu3zlp7oADoY/Jk1lW+j6+kAMLJrKoyIZp98mafEWJ1NiJWd2wixM6VQPw7OD/NCrPOMR6FnE=
X-Gm-Message-State: AOJu0Yx+GQtlJSBxLOadtHUozY7GqoO35fwW1naRMyQEmTqXwAL9P7mw
	c4570wQh2xyZFEiowPz2fFluMqTfrSP8MQV7vwDBTSs4KJgXm8yVr5bifJ2Znis=
X-Google-Smtp-Source: AGHT+IFHDYk3nenxFNFWwLzmbKl9yj0hlT4FTQZqgKoJtWT6ZiQedTzwq/9ogD3RdaFnu3Ud30XhTw==
X-Received: by 2002:a2e:8544:0:b0:2ec:5061:d7d2 with SMTP id 38308e7fff4ca-2eeb30e5c4bmr107343131fa.18.1720997982016;
        Sun, 14 Jul 2024 15:59:42 -0700 (PDT)
Received: from [192.168.0.3] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5ef44a9sm64488965e9.40.2024.07.14.15.59.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jul 2024 15:59:41 -0700 (PDT)
Message-ID: <5bbe82b4-9784-4c62-84cd-7ce9550fc5a5@linaro.org>
Date: Sun, 14 Jul 2024 23:59:40 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] media: venus: use device managed APIs for power
 domains
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Len Brown <len.brown@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <1720763312-13018-1-git-send-email-quic_dikshita@quicinc.com>
 <1720763312-13018-3-git-send-email-quic_dikshita@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <1720763312-13018-3-git-send-email-quic_dikshita@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/07/2024 06:48, Dikshita Agarwal wrote:
> Use devres-enabled version of power domain attach APIs.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> ---
>   drivers/media/platform/qcom/venus/pm_helpers.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
> index 5028220..86221e0 100644
> --- a/drivers/media/platform/qcom/venus/pm_helpers.c
> +++ b/drivers/media/platform/qcom/venus/pm_helpers.c
> @@ -869,7 +869,7 @@ static int vcodec_domains_get(struct venus_core *core)
>   	if (!res->vcodec_pmdomains_num)
>   		goto skip_pmdomains;
>   
> -	ret = dev_pm_domain_attach_list(dev, &vcodec_data, &core->pmdomains);
> +	ret = devm_pm_domain_attach_list(dev, &vcodec_data, &core->pmdomains);
>   	if (ret < 0)
>   		return ret;
>   
> @@ -895,14 +895,11 @@ static int vcodec_domains_get(struct venus_core *core)
>   	return 0;
>   
>   opp_attach_err:
> -	dev_pm_domain_detach_list(core->pmdomains);
>   	return ret;
>   }
>   
>   static void vcodec_domains_put(struct venus_core *core)
>   {
> -	dev_pm_domain_detach_list(core->pmdomains);
> -
>   	if (!core->has_opp_table)
>   		return;
>   

Less is more.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

