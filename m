Return-Path: <linux-pm+bounces-19861-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4B29FEB4B
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2024 23:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EC2C161B8A
	for <lists+linux-pm@lfdr.de>; Mon, 30 Dec 2024 22:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E56B19D08F;
	Mon, 30 Dec 2024 22:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANOEQYIC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0985033C9;
	Mon, 30 Dec 2024 22:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735597549; cv=none; b=jgP4lU0k2B4yrgo5vBktNgsR7TNWWGU3NgsXv13lKz7vNG+2HfmG/6o9TJcXX4cPwCqnF195z89tBd168sJYascVGjRlQidCJPIL0tHEy+EcM5LYLNBZn8grKjTJSjkgYQ/CzTCQh0AwrX/ex1yzgBjswWdFR7KhrdGv9XdW20Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735597549; c=relaxed/simple;
	bh=seSfdDx4urL0UaGKOK2Me2hdCtSftuthkBmEb9T7lZQ=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=qWU2K+a5uPps/8jZEyiWsqEHjYzbQIRyqgD4K2hiK4YIqfkQ9jmgpFzblruSN50NCznXihlFt64q5yQSiwT4LpBuXqf/mxH/zciDF6pkZcvmGGKke2U/gbpkC3AC3Dz6g90QBPN4IntGPU/HphPIbr8dIMZ94/FuUnsgTDGAJ2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANOEQYIC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74186C4CED0;
	Mon, 30 Dec 2024 22:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735597548;
	bh=seSfdDx4urL0UaGKOK2Me2hdCtSftuthkBmEb9T7lZQ=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=ANOEQYICVHhXohQQekYt8/6lY9XvBPzzYfiSUkCf0hmSmqq9CoKFIpNGQPlsHXYGE
	 dS+38Y8sTewF26Z+ysMuYKDkNN9haQ9NdGhrLzp4+2CaF9xLTgMIvNAvnwZyPvUDBu
	 OD9IKo2CRbmoSkA8NzERg/naoSNh9MSrCldmtyHlrjY/xuLEVk+pAHSjc8ECeclHJm
	 D1+/2vNat6s+9s0CLaZy+guUl0x8CMGeJq5nkT+U8stCB9tEXNllCIngFNNiKX2mQh
	 +UUTmEvHARYVCLHJTF4ke8CQabO8AKbWV0oasIpGBIkosJ6l6JqlsZpubp4sFbchsl
	 DZYalSK3Vb3cA==
Date: Mon, 30 Dec 2024 16:25:47 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, devicetree@vger.kernel.org, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Simona Vetter <simona@ffwll.ch>, Sean Paul <sean@poorly.run>, 
 freedreno@lists.freedesktop.org, Bjorn Andersson <andersson@kernel.org>, 
 linux-pm@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Viresh Kumar <vireshk@kernel.org>, dri-devel@lists.freedesktop.org, 
 linux-arm-msm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, 
 Rob Clark <robdclark@gmail.com>, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konradybcio@kernel.org>, David Airlie <airlied@gmail.com>
To: Akhil P Oommen <quic_akhilpo@quicinc.com>
In-Reply-To: <20241231-gpu-acd-v3-4-3ba73660e9ca@quicinc.com>
References: <20241231-gpu-acd-v3-0-3ba73660e9ca@quicinc.com>
 <20241231-gpu-acd-v3-4-3ba73660e9ca@quicinc.com>
Message-Id: <173559754709.2660868.7488137827927170444.robh@kernel.org>
Subject: Re: [PATCH v3 4/6] dt-bindings: opp: Add v2-qcom-adreno vendor
 bindings


On Tue, 31 Dec 2024 02:41:05 +0530, Akhil P Oommen wrote:
> Add a new schema which extends opp-v2 to support a new vendor specific
> property required for Adreno GPUs found in Qualcomm's SoCs. The new
> property called "qcom,opp-acd-level" carries a u32 value recommended
> for each opp needs to be shared to GMU during runtime.
> 
> Also, update MAINTAINERS file include the new opp-v2-qcom-adreno.yaml.
> 
> Cc: Rob Clark <robdclark@gmail.com>
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> ---
>  .../bindings/opp/opp-v2-qcom-adreno.yaml           | 97 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 98 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml: ignoring, error parsing file
Traceback (most recent call last):
  File "/usr/bin/yamllint", line 33, in <module>
    sys.exit(load_entry_point('yamllint==1.29.0', 'console_scripts', 'yamllint')())
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3/dist-packages/yamllint/cli.py", line 228, in run
    prob_level = show_problems(problems, file, args_format=args.format,
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3/dist-packages/yamllint/cli.py", line 113, in show_problems
    for problem in problems:
  File "/usr/lib/python3/dist-packages/yamllint/linter.py", line 200, in _run
    for problem in get_cosmetic_problems(buffer, conf, filepath):
  File "/usr/lib/python3/dist-packages/yamllint/linter.py", line 137, in get_cosmetic_problems
    for problem in rule.check(rule_conf,
  File "/usr/lib/python3/dist-packages/yamllint/rules/indentation.py", line 583, in check
    yield from _check(conf, token, prev, next, nextnext, context)
  File "/usr/lib/python3/dist-packages/yamllint/rules/indentation.py", line 344, in _check
    if expected < 0:
       ^^^^^^^^^^^^
TypeError: '<' not supported between instances of 'NoneType' and 'int'
./Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml:97:1: did not find expected key
make[2]: *** Deleting file 'Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.example.dts'
Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.yaml:97:1: did not find expected key
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/opp/opp-v2-qcom-adreno.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1506: dt_binding_check] Error 2
make: *** [Makefile:251: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241231-gpu-acd-v3-4-3ba73660e9ca@quicinc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


