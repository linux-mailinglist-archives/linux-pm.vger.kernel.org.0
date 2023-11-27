Return-Path: <linux-pm+bounces-302-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2907F7FA917
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 19:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACAC3281870
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 18:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918EC36AEA;
	Mon, 27 Nov 2023 18:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2981B5;
	Mon, 27 Nov 2023 10:40:18 -0800 (PST)
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6d8162ca490so951305a34.0;
        Mon, 27 Nov 2023 10:40:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701110418; x=1701715218;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YVywRnjvKfc8s710BUTyZQrNkS90y58RpBYg6vLXBw8=;
        b=CnhGsVoh7hkw47c33W2xXP6NBSRp7aK0Rh6+bh8EIAhgwpCTlbxO6/ZoRtayuKcC6p
         zmGsUHbT/NIy5GSDrKAXkHAE5mqkX8v72m+A/bzrbirqytnnNLbmkqMuRUETzY6lx2Kp
         f797gxEFiXtRMfF0/+YwJ+H+TrYTWye99qJJFVdjjFjHDQ3lK2gJuJHKuOouOGZ89SSD
         tangQUH3YudxUlfJ2xs0oIe4eaSXiNxUWs4Nxg9p2CXohdHJCGy1a2/2Q8pJL2x0kNrV
         yzDowVUAIJMS5K4mABRADFDB17IkAmsWMqEUpPuTS3keEvkjZPPGMk+ZIFV0yYSTr01z
         XM6Q==
X-Gm-Message-State: AOJu0YyiiIJ9lNKGqIC1Bc2OeGqHVZnyUVndk2w71PVCAiUZ4u3nXRMn
	DZA62lz/+e3Dh1WWqnhnPQ==
X-Google-Smtp-Source: AGHT+IGHvWxLgKw7dql3sJyA5cZNuv1wzTmsB/VlB7zUtFnIdhq8vigkguuW5My1RrnY70l0VypYTQ==
X-Received: by 2002:a05:6830:7183:b0:6cd:9b5:f07f with SMTP id el3-20020a056830718300b006cd09b5f07fmr9899391otb.8.1701110418184;
        Mon, 27 Nov 2023 10:40:18 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z18-20020a9d7a52000000b006cd09ba046fsm1415622otm.61.2023.11.27.10.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 10:40:17 -0800 (PST)
Received: (nullmailer pid 2283504 invoked by uid 1000);
	Mon, 27 Nov 2023 18:40:13 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: iommu@lists.linux.dev, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, linux-kernel@vger.kernel.org, 
	Marijn Suijten <marijn.suijten@somainline.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Loic Poulain <loic.poulain@linaro.org>, 
	Andy Gross <agross@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-pm@vger.kernel.org, 
	Maxime Ripard <mripard@kernel.org>, Sean Paul <sean@poorly.run>, 
	linux-arm-kernel@lists.infradead.org, 
	Krishna Manikandan <quic_mkrishn@quicinc.com>, Das Srinagesh <quic_gurus@quicinc.com>, 
	Robert Marko <robimarko@gmail.com>, Rob Clark <robdclark@gmail.com>, 
	dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>, 
	Georgi Djakov <djakov@kernel.org>, Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, 
	freedreno@lists.freedesktop.org, Will Deacon <will@kernel.org>, 
	Daniel Vetter <daniel@ffwll.ch>, "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org, 
	Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231125-topic-rb1_feat-v1-4-11d71b12b058@linaro.org>
References: <20231125-topic-rb1_feat-v1-0-11d71b12b058@linaro.org>
 <20231125-topic-rb1_feat-v1-4-11d71b12b058@linaro.org>
Message-Id: <170111041311.2283445.17798398754881124107.robh@kernel.org>
Subject: Re: [PATCH 04/12] dt-bindings: display: msm: sm8450-mdss: Allow 3
 interconnects
Date: Mon, 27 Nov 2023 12:40:13 -0600


On Sat, 25 Nov 2023 15:17:32 +0100, Konrad Dybcio wrote:
> In addition to MDP01, the cpu-cfg interconnect is also necessary.
> Allow it.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.example.dtb: display-subsystem@ae00000: interconnects: [[4294967295, 14, 0, 4294967295, 3, 0], [4294967295, 14, 0, 4294967295, 3, 0]] is too short
	from schema $id: http://devicetree.org/schemas/display/msm/qcom,sm8450-mdss.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,sm8450-mdss.example.dtb: display-subsystem@ae00000: interconnect-names: ['mdp0-mem', 'mdp1-mem'] is too short
	from schema $id: http://devicetree.org/schemas/display/msm/qcom,sm8450-mdss.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231125-topic-rb1_feat-v1-4-11d71b12b058@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


