Return-Path: <linux-pm+bounces-301-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 507237FA910
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 19:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 813531C209B5
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 18:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EE435883;
	Mon, 27 Nov 2023 18:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA702D5A;
	Mon, 27 Nov 2023 10:40:16 -0800 (PST)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-58d533268e6so1414394eaf.1;
        Mon, 27 Nov 2023 10:40:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701110416; x=1701715216;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NK5WhS88OI6KCb7Lk1NPWEaX1+G+RAfAiUrHgwT/t+E=;
        b=vZjCOECpu/iw+T0jO6YOhcNYO5h94CcSWdd4VU883AA+37Z77P7nMTIl1qVMqvq1jp
         ONoZCUab4FDg4QDYM1Um6ulJVsUrxQF+txrKMQuCldRm4LA/6iXGP/3Lkrqpa7DxdrNd
         xnKhYWGn2tfaZPZjptWt+hXLmeUjGlmFy2Nam28jjuMLTicpgCL+TwUAYsPQWhbEVdtg
         H0Sx7z1GDRspMT0RsFeg5L6l+0rRV+/RLs+FfKrdhQllRmfU6m0pBjqbXiYB/zuWINul
         VYzs/f1BMAKnMAlFKMv+MaNWiJOdRi6XHJfVOmJ7hA922+D+bKtutQzp1kip1347fMP9
         Qw8A==
X-Gm-Message-State: AOJu0YwslvZq6baeiF5pzf9QPRjIMctYB9OegPF2gjRPUtxKbgY5ZuxZ
	Ytp94JdpiEd4Tn5pTCftuaXVxcvMCw==
X-Google-Smtp-Source: AGHT+IFryMql4axrRLjSO6lgZP7+RrOYihlOCdtksjZ7JOF1OJch6kZaFVxi0oP2Hqvh20Dhi6avdA==
X-Received: by 2002:a05:6820:16aa:b0:58d:981e:bc5c with SMTP id bc42-20020a05682016aa00b0058d981ebc5cmr2953014oob.7.1701110415941;
        Mon, 27 Nov 2023 10:40:15 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e4-20020a056820060400b00573a0631d98sm381569oow.34.2023.11.27.10.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 10:40:14 -0800 (PST)
Received: (nullmailer pid 2283499 invoked by uid 1000);
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
Cc: linux-pm@vger.kernel.org, Marijn Suijten <marijn.suijten@somainline.org>, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	Andy Gross <agross@kernel.org>, Will Deacon <will@kernel.org>, Robert Marko <robimarko@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Daniel Vetter <daniel@ffwll.ch>, 
	Robin Murphy <robin.murphy@arm.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Clark <robdclark@gmail.com>, 
	Georgi Djakov <djakov@kernel.org>, Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, linux-arm-kernel@lists.infradead.org, 
	David Airlie <airlied@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, Krishna Manikandan <quic_mkrishn@quicinc.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-arm-msm@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Loic Poulain <loic.poulain@linaro.org>, Das Srinagesh <quic_gurus@quicinc.com>
In-Reply-To: <20231125-topic-rb1_feat-v1-3-11d71b12b058@linaro.org>
References: <20231125-topic-rb1_feat-v1-0-11d71b12b058@linaro.org>
 <20231125-topic-rb1_feat-v1-3-11d71b12b058@linaro.org>
Message-Id: <170111041242.2283353.8776249687864558738.robh@kernel.org>
Subject: Re: [PATCH 03/12] dt-bindings: display: msm: qcm2290-mdss: Allow 2
 interconnects
Date: Mon, 27 Nov 2023 12:40:13 -0600


On Sat, 25 Nov 2023 15:17:31 +0100, Konrad Dybcio wrote:
> In addition to MDP0, the cpu-cfg interconnect is also necessary.
> Allow it.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.example.dtb: display-subsystem@5e00000: interconnects: [[4294967295, 1, 4294967295, 6]] is too short
	from schema $id: http://devicetree.org/schemas/display/msm/qcom,qcm2290-mdss.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.example.dtb: display-subsystem@5e00000: interconnect-names: ['mdp0-mem'] is too short
	from schema $id: http://devicetree.org/schemas/display/msm/qcom,qcm2290-mdss.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231125-topic-rb1_feat-v1-3-11d71b12b058@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


