Return-Path: <linux-pm+bounces-803-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D92FC80910E
	for <lists+linux-pm@lfdr.de>; Thu,  7 Dec 2023 20:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93AE4281351
	for <lists+linux-pm@lfdr.de>; Thu,  7 Dec 2023 19:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4642C4F5E9;
	Thu,  7 Dec 2023 19:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DRqd+z8m"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42D410F9
	for <linux-pm@vger.kernel.org>; Thu,  7 Dec 2023 11:10:48 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c9f559b82cso13644301fa.0
        for <linux-pm@vger.kernel.org>; Thu, 07 Dec 2023 11:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701976246; x=1702581046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OfswJHbbaE8lthgCuxsCEF+7HdLrX0KCYICyRwFYL8Q=;
        b=DRqd+z8mWcy9cSBAJFc7XovxoM6gE47GuGITuKPQK4NkbBOVry5J6gPE5gfcD7lwWi
         WEbLXO3DL86Lbj9d5q23MNd9tTDTZC8Mr8KaAEt4r6uQvnySUNmNuu4RYzP6kJ4UI8mN
         XkqfyYS6hm7YZfnvTc4641eYzQ/UUuHa1xBsTOIe82yQ5BIS89bO3wIE+lPe0juZC6Jx
         rikzEimLdfdtjE5VLlpagn4OC1KYSVaV28sMGdmAXaYmO9++Hn7K7gSfPut3utapgvRL
         42WyR44zjJ+bsH8VtCk024ehGbooNIlnpJmAxokVqUTKRNgTYfPNOlRBMuAfJODG8F4C
         gpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701976246; x=1702581046;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OfswJHbbaE8lthgCuxsCEF+7HdLrX0KCYICyRwFYL8Q=;
        b=kPp/Q/1QazQ9LelvJXS5GhN8Mp1ntqO+oaqWcRKY2BtM4Z7+b2yLA2pDeDwxrdED24
         G0NZhuR4QQXRgUbQG52+qDOTwtANgj98jUdJuySFfJ+F+QHBJ1/Yt8BloVY7Wnq1CFIg
         t/zPVOhbp6ShNJLnEiVZpJaj/+fh7q2tOGrJbgomoPRpi/aRx0zaeAyCiyzCWn7q/qAi
         F9ODtYxi3jk3Uj01HdFQH9IPADn8pPag88EY5Hg5ZQPqxtlkn9Dpc5pNlLFHKr/L+93a
         twYUdzQjqZ1+tt1kd1dwwYia8wvjowKUzj9w1wnU4njmtSK4ZADXu2T/rtTFgYiSwFun
         dsng==
X-Gm-Message-State: AOJu0Yyw0cJDC0ofO5rsKirz/tIrUkcWHHDy8X0y2fpOfM7AUYWLye/p
	5UyILssOJm/NBlDKp6XTvTvZyQ==
X-Google-Smtp-Source: AGHT+IHHZzDwVjEoqj5L0COX7ANyUFp8QKEMmxG3cMwdjoXkbsmuUH84Uxh48VDZssIMNDNTOto8AQ==
X-Received: by 2002:a2e:9991:0:b0:2c9:c8f4:1c0c with SMTP id w17-20020a2e9991000000b002c9c8f41c0cmr1649768lji.32.1701976246456;
        Thu, 07 Dec 2023 11:10:46 -0800 (PST)
Received: from [172.30.205.181] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id o18-20020a2e9b52000000b002c9f75a48fcsm23408ljj.16.2023.12.07.11.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 11:10:45 -0800 (PST)
Message-ID: <014a4a44-0da2-49e9-ab1c-f4cc1ca2e218@linaro.org>
Date: Thu, 7 Dec 2023 20:10:41 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] interconnect: qcom: Add MSM8909 interconnect provider
 driver
To: kernel test robot <lkp@intel.com>,
 Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
 Georgi Djakov <djakov@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Adam Skladowski <a39.skl@gmail.com>
References: <20231206-icc-msm8909-v1-2-fe0dd632beff@kernkonzept.com>
 <202312071325.M9cg1wry-lkp@intel.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <202312071325.M9cg1wry-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/7/23 07:06, kernel test robot wrote:
> Hi Stephan,
> 
> kernel test robot noticed the following build errors:
(.remove -> .remove_new)

Konrad

