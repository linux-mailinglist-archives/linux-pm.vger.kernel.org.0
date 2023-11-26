Return-Path: <linux-pm+bounces-239-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCAF7F930A
	for <lists+linux-pm@lfdr.de>; Sun, 26 Nov 2023 15:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A574DB20DB9
	for <lists+linux-pm@lfdr.de>; Sun, 26 Nov 2023 14:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828E56FB0;
	Sun, 26 Nov 2023 14:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RU4YCTGT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27D593
	for <linux-pm@vger.kernel.org>; Sun, 26 Nov 2023 06:17:36 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40b2ddab817so23609855e9.3
        for <linux-pm@vger.kernel.org>; Sun, 26 Nov 2023 06:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701008255; x=1701613055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QcndzPm7z338RHK94VwEZXvnKMZos/UvhLkmjn4xC/Q=;
        b=RU4YCTGTF3V7MB5nzdM43ikVnMAcZ/vxsb8cq99diNtWf6dyCDXUysxgjaectB4pEv
         oaGpOZ4oVkGhZQK1M7lja7sV3xFC9z6Foien+Fk7iabEYBxf74EUfy/13SWSYeIKzHAh
         7JvpMic+hlAoIt6gaArjyIy2d3lPIFycmaCmgdBXrmLBTyoUZjaoY1STxExXt5uJe3mw
         Ki2MT9dB1Ngt6o3gPCSBloaDGod6qcnYq1nre+r+0FPLcezacgVGdPG8M+eRHzlKn7ps
         KrKLX8+RbISecip3ISGSkiVsYsy3j5tS5OJi6eSfs2VKaqGbu85vinNKO3fnP6hI7rFD
         KLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701008255; x=1701613055;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QcndzPm7z338RHK94VwEZXvnKMZos/UvhLkmjn4xC/Q=;
        b=CvJPWVgRuhLYojNmCK+q7Y8bkr9HrGJl9AQwDZEyUB/iN2rSGJ8nt2UNk3JGk4JCQQ
         mlYVJBnL54x8q3PXNqKJQeDGwgu+9kIjGaK4XUaXMYUptp9wf+QStl1wh2oCGdqAv5G2
         R3hsHmzfVNXhJNjpdPoFCehCvVNWXZapruz9dysQ9CiBuQT4b+97vMd0PdfgkIOkisfx
         zRKUK+yIMOnM2mv2Mrtc6uNbBzfxiobuXWQ1vZ3rUFKOdJFzUMZ0qYb5JOfTAKA0o3EQ
         M+FdkRin/c8bPTcVNaSFN9/GnNAwz+Bp9VadvWDXJC4n/1DeHYUOgTUqUyABYjgT1PSx
         cvfg==
X-Gm-Message-State: AOJu0YwwrVM4UWtJJZqvEg937yasLeLJ4hNYhlfSNUngqWwqzBR7wrCC
	FW86mlJzYCXKAOQcM170eE3QdQ==
X-Google-Smtp-Source: AGHT+IGkk9pdn9r7g1J1o/fcsxC78jPge+mZy3lXPIb8wrgrQCxYQ08bQdBSvKnCzAF2mipxLo0QBg==
X-Received: by 2002:a05:600c:154f:b0:40b:3dbf:f39 with SMTP id f15-20020a05600c154f00b0040b3dbf0f39mr2924922wmg.37.1701008254426;
        Sun, 26 Nov 2023 06:17:34 -0800 (PST)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c19d100b004064cd71aa8sm10565101wmq.34.2023.11.26.06.17.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Nov 2023 06:17:33 -0800 (PST)
Message-ID: <1dce7a79-be67-4d44-b03f-63ef5cbb78e3@linaro.org>
Date: Sun, 26 Nov 2023 14:17:31 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] dt-bindings: display: msm: qcm2290-mdss: Use the
 non-deprecated DSI compat
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Clark
 <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Loic Poulain <loic.poulain@linaro.org>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Georgi Djakov <djakov@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Robert Marko <robimarko@gmail.com>, Das Srinagesh <quic_gurus@quicinc.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev
References: <20231125-topic-rb1_feat-v1-0-11d71b12b058@linaro.org>
 <20231125-topic-rb1_feat-v1-1-11d71b12b058@linaro.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20231125-topic-rb1_feat-v1-1-11d71b12b058@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/11/2023 14:17, Konrad Dybcio wrote:
> The "qcom,dsi-ctrl-6g-qcm2290" has been deprecated in commit 0c0f65c6dd44
> ("dt-bindings: msm: dsi-controller-main: Add compatible strings for every
> current SoC"), but the example hasn't been updated to reflect that.
> 
> Fix that.
> 
> Fixes: 0c0f65c6dd44 ("dt-bindings: msm: dsi-controller-main: Add compatible strings for every current SoC")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
> index 5ad155612b6c..3d82c00a9f85 100644
> --- a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
> @@ -56,7 +56,9 @@ patternProperties:
>   
>       properties:
>         compatible:
> -        const: qcom,dsi-ctrl-6g-qcm2290
> +        items:
> +          - const: qcom,qcm2290-dsi-ctrl
> +          - const: qcom,mdss-dsi-ctrl
>   
>     "^phy@[0-9a-f]+$":
>       type: object
> 
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

