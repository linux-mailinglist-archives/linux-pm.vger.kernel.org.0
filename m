Return-Path: <linux-pm+bounces-360-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F0D7FBB37
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 14:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 547081C21500
	for <lists+linux-pm@lfdr.de>; Tue, 28 Nov 2023 13:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F37F57889;
	Tue, 28 Nov 2023 13:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ooncuayP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF636D60
	for <linux-pm@vger.kernel.org>; Tue, 28 Nov 2023 05:17:33 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c8879a1570so69687181fa.1
        for <linux-pm@vger.kernel.org>; Tue, 28 Nov 2023 05:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701177452; x=1701782252; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QAr4/m2ajzddsi7hfMwi2CwtuYecaq14RypvJQRLzWo=;
        b=ooncuayPGnED46h4taFDaLZ6RaEp4EmYKsYftkvLlRSjvg6XoGlo+r39yXQpKILfmV
         h0lgAnpY6/Gqy+NfqieijAjV7+6XyaOE5Nm4OHgfT3lVz5SRpdZrOU9Q3DXLoh15Luho
         AVitj5G98OaFAL86JjkX5ewgRxB1F4mHzSvRhk0EYQiWsWk+mIWq25iqLSzXa2RZN5y1
         YNvN7Xqc7lqkhQcvLFTTe6chiw3e3gTvzbJ3AWG+QfDAIL4Oe1RLr1MdLTsGwpCvQ6jc
         3CsHUuaio59RcIg1a+RN3GXQ3xGps4H5AJFgLrcSmZbcRVai6lcd/2TRbTVqQSW7+prL
         pdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701177452; x=1701782252;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QAr4/m2ajzddsi7hfMwi2CwtuYecaq14RypvJQRLzWo=;
        b=r5MdOjHn04RQDMHnXMJrjXUPFS5dCTvDfHnoCbIn8cDMMbBOR8hneKRnrXFpZFK6XQ
         lKhBV1+yo9YeDBhhYxq7cOiIpVCbVQBwM0YjhVnkAkZlEqq+M6Jp0a3PFFo7Yp4F5Miu
         XQFisgpvN/a43YfB0dbVYx/lUAKwOcLor3LyiyWLSg5V39U6PFegTIcBpZRfoakmMgEN
         Y1mE8tpXBvLSDsVNoHF4xbadPDLr1Yt8UFs1H13RgLIs0wTpXvyoOWDlGnSkB5j1WsjM
         t9BbEhALs22MvC/0/baWUmiAUG2aWhR+PJmPC2+xjQgIgSnuyqzcX5A2rCUpJMUv38pt
         CHfw==
X-Gm-Message-State: AOJu0YzCg0Jz1x3N5ei6zqwXjG4oZZot256L499bEvXF/6uPr98eyTD1
	6YOBHO0/YZLOfvW+r4Gt/XeNIA==
X-Google-Smtp-Source: AGHT+IGVxWPP0V55ZOwwGMT/RGUBPGkfdgvpKvOQb9OJayj/M/2NUiUPahV+CyCvHpaWlYuulUl4pw==
X-Received: by 2002:a2e:9b4d:0:b0:2c9:b4c6:a7ff with SMTP id o13-20020a2e9b4d000000b002c9b4c6a7ffmr1015094ljj.40.1701177452153;
        Tue, 28 Nov 2023 05:17:32 -0800 (PST)
Received: from ?IPV6:2001:14ba:a0db:1f00::227? (dzdqv0yyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::227])
        by smtp.gmail.com with ESMTPSA id t7-20020a2e9547000000b002b657f10b78sm1707226ljh.58.2023.11.28.05.17.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 05:17:31 -0800 (PST)
Message-ID: <c0ffb1bf-9a3a-4a6e-a62c-a7777c3458a0@linaro.org>
Date: Tue, 28 Nov 2023 15:17:30 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/12] arm64: dts: qcom: qcm2290: Hook up interconnects
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
 <20231125-topic-rb1_feat-v2-9-979b28f35e4a@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20231125-topic-rb1_feat-v2-9-979b28f35e4a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/11/2023 17:28, Konrad Dybcio wrote:
> Add interconnect provider nodes and hook up interconnects to consumer
> devices, including bwmon.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/qcm2290.dtsi | 248 ++++++++++++++++++++++++++++++++++
>   1 file changed, 248 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry


