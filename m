Return-Path: <linux-pm+bounces-17768-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D80AA9D2D3F
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 18:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9980C283580
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2024 17:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4631D2F66;
	Tue, 19 Nov 2024 17:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yjYGdAzO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC95D1D1F4B
	for <linux-pm@vger.kernel.org>; Tue, 19 Nov 2024 17:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732039010; cv=none; b=RRWqM0RQCDmVLpZox3D6avcIi/VyUYUI41oC/d1nNV84xiIfBzksq8q2zeqJoXsOHRJCW4v9Kh6NTi0MHbaAc4hEpDyUdmQgBeWSpRyvR4hq3WmuBPWlIKfmWjXDUz61o5dTuDV6QZWLQkNyBIYOhvs3pXqcDw/LBPbatc4Tfhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732039010; c=relaxed/simple;
	bh=2ruzXwfCkgxcdUn05ISNMLUdnKZHWZlM4S6yJkpiAMg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=F5BiP2wq3D4cG5dnCS7vT1+ILd+Irw3QhubNLLWLNMACnGBbq6Ah8qAE08yaMbRWvxRcGLo29Dhk48Qj/rZ+D/b4KKWB48WVijJ7ekka7vcXJSQQmhg0Zd982FYtjpBthSZzIoFrBEkBOTP+mAxX7MyiGVKrfcKDOx56o5RElpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yjYGdAzO; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43159c9f617so10337135e9.2
        for <linux-pm@vger.kernel.org>; Tue, 19 Nov 2024 09:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732039005; x=1732643805; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uphaw+yejvZqKI/ifvkmuNUdnhaCioyIuvDRQApoKB0=;
        b=yjYGdAzOaHaHcIu+3MH/gIW0enhdxC11ik/vRMDiD9xdapx1O/39J1yyCNljwAciOp
         RxeywSN/5Ri/J4qlZzPaKarMxBQdT7u6sS+OMWKF62gXsvLuXKfx+AFyY+Hrx4NVQi1v
         exQsqcLDvkuOvLHrlmemErVoU5vALBnGTyF4zUIONwwcfZ6L8SfeNcQhJYppL3jBv3iZ
         wSTPnwyCw/IWCHVlRLYxu7gw+8NHnGjKQKmhjU4/hcxYhPdgzs1VUanMIaqIbDddKCA6
         EG8OU1pVphEhB8FI27kHWH2Z5WATOBlTEndA78TWtxs0nM40unZIm7LBh66yPPYObhE4
         8/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732039005; x=1732643805;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uphaw+yejvZqKI/ifvkmuNUdnhaCioyIuvDRQApoKB0=;
        b=ZlaUMUFuD/jK/477UHGafp10TOAO3eu0oELaY6PUZq/kzacnCkoRGTq4Pzufk2tsVS
         CmHWpdm+NX5h3/3DRrkKRoUAdPpVTxz75U7EcB4eI5Hqf4wpXUsXGqItiTJERwNS3s79
         iTTimZJihmdj9JZxgipgAT/FiJBw4gotvlJGWmSdFS6X0rbvou7+zs8wOfcOVSlVBPjv
         9h6ymDCvHhlYWqDO3FgPdkh+THTdsGuvFD/M86e6Qr76dB/zU0IbrM4lJtt0HnwE0Dgp
         AH9fs1d+nZMnJzxHqeV8HogBS/VWmNMdrOavpq4yHGzIoVj8B42V/hsy6GVT881O+r1g
         kXyw==
X-Forwarded-Encrypted: i=1; AJvYcCWT6WK9m3J8Nkkx5/KRNISnl3+eIQBd75qia42gJSgSTblXuCjgxuqHbIaokbZHSDMwCYoNBiRE8w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMdJb/4E6jhyicIMVr5V8xNK4uuEbzgzPF+DjgSmnb1JdmU+0I
	Jld8g5sxKV7oZKvUEmKpGrtT19+uLLWqkyv7Zz00Ihh+wnZ0eeRVhdTJ9m5gSSQ=
X-Google-Smtp-Source: AGHT+IGu2MTuaLa2s2Osy0xPHtiOF5pvDD946JFIP7glWAUn0hOLR3LKLl+1yNNeHEwt9KRH8mDxjg==
X-Received: by 2002:a5d:47a4:0:b0:37d:4e74:684 with SMTP id ffacd0b85a97d-38225aa59f8mr12911539f8f.52.1732039005191;
        Tue, 19 Nov 2024 09:56:45 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da27fe68sm208302275e9.24.2024.11.19.09.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 09:56:44 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 00/11] drm/msm: adreno: add support for DDR bandwidth
 scaling via GMU
Date: Tue, 19 Nov 2024 18:56:35 +0100
Message-Id: <20241119-topic-sm8x50-gpu-bw-vote-v2-0-4deb87be2498@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFPRPGcC/42NTQ6CMBBGr0Jm7Zj+QAquuIdhUWCASZSSFiuGc
 HcrJ3D5XvK9b4dAninALdvBU+TAbk6gLhl0k51HQu4TgxIql1JqXN3CHYZnuRUCx+WF7RujWwm
 HgoRSAxmbG0jzxdPA25m+N4knDqvzn/Mpyp/9IxolCtRt2evKaGOrtn7wbL27Oj9CcxzHF7b+q
 lHBAAAA
X-Change-ID: 20241113-topic-sm8x50-gpu-bw-vote-f5e022fe7a47
To: Akhil P Oommen <quic_akhilpo@quicinc.com>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Connor Abbott <cwabbott0@gmail.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3706;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=2ruzXwfCkgxcdUn05ISNMLUdnKZHWZlM4S6yJkpiAMg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnPNFWISo88ZsLG6UgbcsukGsSBh5EXFE71ZgJjJ/e
 JtbsqaGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZzzRVgAKCRB33NvayMhJ0auSEA
 Cj6pb8Bb61UNiFQWCsXiHBPNtyQrTaimhWr+qgdF3wJyBzhE9/on548kB7KyxvJPqEtZCevcAfLBwr
 yxH1kDB9kEtRjsSFylPhAWEHPiqiJzEcHEM8vPLWp0sQMvL9ut3DT35hcyqmYgOUi0c4/qAjMxmPnE
 qTX3KznoURrRFC8cRuK/UzGNUfjO/UM8QJYZVKW092WvVsy0JmTwW0UpXBRY+qKeOsN/sQkfH9i91N
 Cpx9cSSva3E+VvUMStKUaPaUTjudKRNInMdg5wBKXCIs5DNCnij+HG/3a+2Gkck+lpSEqLaEVPq4bs
 UHSzsycYPlAEnnHbXd0mj3n3rgrp07WBIEYptulzGiaGVAk5xD5gUu8gvomB2O5rOis4zwIvm61/JW
 HkogfvJsk82SBPHAXB/+XZ/zkXYngr6W8UjVyQ1s0p1K3puEAQ2lRdRpDh7IhnHWycWPvzwfkRAZLX
 rE2y9/bsHW4qJEsFBPKrYsp70oP8oUPZCSzoNXU22Mi+xzgBqNmaSOY4m9srD9ACgEZiXf+ZjnncEw
 Y1N4JBD5dM7bn55yjwTUowNtfHcB8gcPQ8D/TI/jXl2jlL99TRDT+xIsR+9NO7e9NGITUhdgKuzYU2
 XLH07egPhFXLtHgQOxZZpYFZ3X+dbXbR6x7sPZSh32smNHUjRngzrJUz0sdw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The Adreno GMU Management Unit (GMU) can also vote for DDR Bandwidth
along the Frequency and Power Domain level, but by default we leave the
OPP core scale the interconnect ddr path.

While scaling the interconnect path was sufficient, newer GPUs
like the A750 requires specific vote parameters and bandwidth to
achieve full functionnality.

In order to get the vote values to be used by the GPU Management
Unit (GMU), we need to parse all the possible OPP Bandwidths and
create a vote value to be send to the appropriate Bus Control
Modules (BCMs) declared in the GPU info struct.
The added dev_pm_opp_get_bw() is used in this case.

The vote array will then be used to dynamically generate the GMU
bw_table sent during the GMU power-up.

Those entries will then be used by passing the appropriate
bandwidth level when voting for a GPU frequency.

This will make sure all resources are equally voted for a
same OPP, whatever decision is done by the GMU, it will
ensure all resources votes are synchronized.

Ran full vulkan-cts-1.3.7.3-0-gd71a36db16d98313c431829432a136dbda692a08 with mesa 25.0.0+git3ecf2a0518 on:
- QRD8550
- QRD8650
- HDK8650

Patchset is based on current msm-next including preemption support.

Any feedback is welcome.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- opp: rename to dev_pm_opp_get_bw, fix commit message and kerneldoc
- remove quirks that are features and move them to a dedicated .features bitfield
- get icc bcm kerneldoc, and simplify/cleanup a6xx_gmu_rpmh_bw_votes_init()
  - no more copies of data
  - take calculations from icc-rpmh/bcm-voter
  - move into a single cleaner function
- fix a6xx_gmu_set_freq() but not calling dev_pm_opp_set_opp() if !bw_index
- also vote for maximum bus bandwidth usage (AB)
- overall fix typos in commit messages
- Link to v1: https://lore.kernel.org/r/20241113-topic-sm8x50-gpu-bw-vote-v1-0-3b8d39737a9b@linaro.org

---
Neil Armstrong (11):
      opp: core: implement dev_pm_opp_get_bw
      drm/msm: adreno: rename quirks that are features
      drm/msm: adreno: move features bits in a separate variable
      drm/msm: adreno: add GMU_BW_VOTE feature flag
      drm/msm: adreno: add plumbing to generate bandwidth vote table for GMU
      drm/msm: adreno: dynamically generate GMU bw table
      drm/msm: adreno: find bandwidth index of OPP and set it along freq index
      drm/msm: adreno: request for maximum bus bandwidth usage
      drm/msm: adreno: enable GMU bandwidth for A740 and A750
      arm64: qcom: dts: sm8550: add interconnect and opp-peak-kBps for GPU
      arm64: qcom: dts: sm8650: add interconnect and opp-peak-kBps for GPU

 arch/arm64/boot/dts/qcom/sm8550.dtsi       |  11 ++
 arch/arm64/boot/dts/qcom/sm8650.dtsi       |  14 +++
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c  |  84 ++++++++-----
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c      | 181 ++++++++++++++++++++++++++++-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h      |  16 ++-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c      |   4 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h      |   1 +
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c      |  45 ++++++-
 drivers/gpu/drm/msm/adreno/a6xx_hfi.h      |   5 +
 drivers/gpu/drm/msm/adreno/adreno_device.c |   2 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h    |   9 +-
 drivers/opp/core.c                         |  25 ++++
 include/linux/pm_opp.h                     |   7 ++
 13 files changed, 358 insertions(+), 46 deletions(-)
---
base-commit: 86313a9cd152330c634b25d826a281c6a002eb77
change-id: 20241113-topic-sm8x50-gpu-bw-vote-f5e022fe7a47

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


