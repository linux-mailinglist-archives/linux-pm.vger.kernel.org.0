Return-Path: <linux-pm+bounces-359-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DFE7FBB27
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 14:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7A65B21266
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 13:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7429557867;
	Tue, 28 Nov 2023 13:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PcrMzjCG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7CF10E7
	for <linux-pm@vger.kernel.org>; Tue, 28 Nov 2023 05:16:18 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c8880fbb33so71054081fa.0
        for <linux-pm@vger.kernel.org>; Tue, 28 Nov 2023 05:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701177376; x=1701782176; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WmeGSvtEsOAwFPC0jalyYEqEza/s+5wNIdTIQtIdcwI=;
        b=PcrMzjCG+PCUYDXVVFIQ0EBfkvuPnkCgqM7PfIH72Zl6IKJ+8zWbqv++SsqVRKElru
         8M2w/F6wq+jUlWl0cBGq1W0R5bPuyTfVRH3FdoNbToeS/shpKThFF7f9JqpFFSeJ0FKY
         7jzdtdQvESiXKBsdZ3PWUiT1epKSYX5G/zu7EA3PxWNojw7mvV+dM75L8l25OuCIYmp6
         tnV6iRGAi2MY0klCC7s/gkbD4X0LPDubgeOGNUJNS2e3mJpo9iGmJaHGdq+G0Pn7rzoT
         c3ILKFSw9ZD5zdNg1WglU2Wv2d+1IYXdRyDwrHQOnAGAW3QJNo3KGgBft8aodfGFIgOw
         MNwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701177376; x=1701782176;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WmeGSvtEsOAwFPC0jalyYEqEza/s+5wNIdTIQtIdcwI=;
        b=p+X640/x+qzExpezYyNo7YhkS5iNcRBgqbAEPAaRRH3I4He2EKKBAEuUXV8ozzvrii
         xpQxSoWO3gTMimjw/zdUoLPhhs2DD7WXE0FISzviNfAD0mpXKPg6WFEBwcW9UE6S/xFj
         oHDbAALuHFYTaqORK5oLGonn6B3zYG3/l59OrZt7CWvIlp7feJkM1ZF7L962PMZBW2XJ
         TbkYU71sD7jConNWsrg+SGfd1QMbhq+k+WaYHCUzbPfh9UTN3MCeOgpDU89HNA0sslYp
         sDyegebr3gVttSb7Q4caWil0sO22mzebeSMydh4lYEdBjPeKiL9UkiFv1daBxD4pUWok
         qUkA==
X-Gm-Message-State: AOJu0YyzbFwHDesmuU+Y2hhJdESYh4zXAJQLaZRinYjoEPl7m6S6WkvA
	HA0Um6H8LmivCAQxzjpAI7dvdQ==
X-Google-Smtp-Source: AGHT+IFskJyn7Zq5NG/6PRdOGtYuywm3exL/CEYWZRl+u7wYVqyx+UY7EtVtNQLM/KOV4FpstpD10A==
X-Received: by 2002:a2e:958e:0:b0:2c9:b9f8:c51e with SMTP id w14-20020a2e958e000000b002c9b9f8c51emr194960ljh.22.1701177376551;
        Tue, 28 Nov 2023 05:16:16 -0800 (PST)
Received: from ?IPV6:2001:14ba:a0db:1f00::227? (dzdqv0yyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::227])
        by smtp.gmail.com with ESMTPSA id t7-20020a2e9547000000b002b657f10b78sm1707226ljh.58.2023.11.28.05.16.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 05:16:16 -0800 (PST)
Message-ID: <0ab17fbe-1247-4f79-9a48-50cb185154ee@linaro.org>
Date: Tue, 28 Nov 2023 15:16:15 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/12] arm64: dts: qcom: qrb2210-rb1: Set up HDMI
Content-Language: en-GB
To: Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Clark
 <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Loic Poulain <loic.poulain@linaro.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Andy Gross
 <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Georgi Djakov <djakov@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Robert Marko <robimarko@gmail.com>, Das Srinagesh <quic_gurus@quicinc.com>,
 cros-qcom-dts-watchers@chromium.org
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev
References: <20231125-topic-rb1_feat-v2-0-979b28f35e4a@linaro.org>
 <20231125-topic-rb1_feat-v2-10-979b28f35e4a@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20231125-topic-rb1_feat-v2-10-979b28f35e4a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/11/2023 17:28, Konrad Dybcio wrote:
> Add the required nodes to support display output via the HDMI port.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 86 ++++++++++++++++++++++++++++++++
>   1 file changed, 86 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry


