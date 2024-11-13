Return-Path: <linux-pm+bounces-17501-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AC49C793C
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 17:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5045EB326DD
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2024 15:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DE5165EE8;
	Wed, 13 Nov 2024 15:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PP8ZEO5M"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7DF16190C
	for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2024 15:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731512923; cv=none; b=OvQX9SF91sOAsNWADsv7UKNZ47hmuoJUvhmQqPkpSQ6MWRACWrJBjJluMLdcbaIIBLiGxkpmNGns0hEbBD3xsHH7iThGFgBgJl1kk0eXgagpMoJNOijapCa69VfylyXS9G8a1jfNj+Lb/ukt+Lr/0/4etUJf1ZqNiaJKHBuoZ7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731512923; c=relaxed/simple;
	bh=S8er2zpAgkVlTHhkotrTwlgtCETFbiARMQlfIq+QwTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hyJII5HgpnKZn6VTN5gQa7wOvxquiXb+X2jeW9Lu5ybJ6ljIvGFKR6kXCLyIEv+kp0CPo3cpsg/LcZVeSjSiG8q99YonrYU/e5CFnOHk0Gz5BCRWKI4RFWZY4bdNDyqq7ju7SDI42yh5tgs4imL9H9QThIDOhjOKjNXe4JuCd3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PP8ZEO5M; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-431688d5127so57206695e9.0
        for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2024 07:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731512919; x=1732117719; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MYgorZqVj//jSCtpavrg/mr2FgdZEzdtGqebNEGgTJA=;
        b=PP8ZEO5Mzn9WlsqK0oISXuPaHQUbuALNLjr5nMC97B0vv7HXm3UipC6CwKaX3Q/XUP
         tkGxAjUh47t+M6i3f/cPLmnxVufVBAGcCrAczbkiIHMxaEjz7xmLXBdXraaC1Sll3g8T
         d8SpkUBb3h9iPGArMKsh1YXE0Hei/xQYFQm+P1X8YqjF932b5DTNbBs506zWBXw3rmyW
         ohhwKP3jWjGxLd1jidZyoRa3+0asMmfe40A+VMSvDuzIEPaO0oMT5sBHlIUFC3m/RcOu
         EHEVA/lCsAF+Q8zC3SIzydjXFj9I7IzI1Fj6XfyCs0WiCosIPbMh5hyaeU6d4TVyEXhL
         WWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731512919; x=1732117719;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MYgorZqVj//jSCtpavrg/mr2FgdZEzdtGqebNEGgTJA=;
        b=YAMgNqIOgIWHvowftd3ctDA6JJRLJrM8DWzXqvXlVo8gOKw3Hr03yq03d6+YB4MFxr
         KFDly1bgXRyqQaZeGDlRC128P+GHkEz9VtGDByOhJKKUAMnQHX8CTEkONlp9Whi2mhhF
         KpKgSVnsN7ioE8ZmdqcNwq+fvnbjxAqybibMEwR7H+Tv57HFj9rov2zXpaUn2uLKajWQ
         9FkRkfNJWXuNUY9ipRj8g0TV8Dm72fOoP2T25fVrzBz+XJudDwuCpFwcv1MTFSH7LLFS
         Y5u2kQKk1cn4/KYQ0QLPbdL3e+8pEuK0NEUcVD/Do4Vyh7aN3YaC3KIxYY5LZpRKho8U
         ITrA==
X-Forwarded-Encrypted: i=1; AJvYcCVRLE5m/Z39RXcv12LV0n92GrfYjdS/RMkkSNix+xpP9EX5pX5v65gyOSoEmbBS0lWhPpvovzY17A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXkbV1mtmrgsjTRg/svM+do7ex8GBLaIPYta/MMt36LiUM8osd
	jsSRuwTay6mVsuw7LSDJkiJ0w+qK8SaQn3MPq+T9FyETJ8x8DKc1bJUV++2Lk7U=
X-Google-Smtp-Source: AGHT+IHeLTMxkPgSACljqc19ZYiCIniT4Dacaxb+WTFPif5Ms5xZ/QJCxJ5pXbokuRv4jP8Z850fGg==
X-Received: by 2002:a05:600c:1d20:b0:426:5e91:3920 with SMTP id 5b1f17b1804b1-432b751dec4mr174729075e9.29.1731512919454;
        Wed, 13 Nov 2024 07:48:39 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d54f772asm28445345e9.18.2024.11.13.07.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 07:48:38 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 13 Nov 2024 16:48:28 +0100
Subject: [PATCH RFC 2/8] drm/msm: adreno: add GMU_BW_VOTE quirk
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-topic-sm8x50-gpu-bw-vote-v1-2-3b8d39737a9b@linaro.org>
References: <20241113-topic-sm8x50-gpu-bw-vote-v1-0-3b8d39737a9b@linaro.org>
In-Reply-To: <20241113-topic-sm8x50-gpu-bw-vote-v1-0-3b8d39737a9b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1182;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=S8er2zpAgkVlTHhkotrTwlgtCETFbiARMQlfIq+QwTc=;
 b=owEBbAKT/ZANAwAKAXfc29rIyEnRAcsmYgBnNMpQOeiIcMjqHR2KvYcUx08gX1tb63FMLKPWSCxz
 PVAGLauJAjIEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZzTKUAAKCRB33NvayMhJ0fKID/
 YwgWibEuUTJ4sILD3uV52lDBr3oWa3ORvTaszDNR0MHQTEveaGOCWjCV/Zl9BiMuwBZY0wu2tUPHhy
 MSAjEQp0JQkCj2m2gvhYUpwSGDX7bzR87ruDfpiiZmjJRhN9r94KBrVFl5oA3yBMJcJLoG17XCh+Ud
 yaybWbNp6y48tEoABElb9M8ZmJW9Z/UIh5AsozPYOXbZ1WbC354GZf8N838tWoHJ35iSiLc7edKChn
 +96jymC/FEZw8h91/M96pXZolXOGArIcqXqePSfIxZrpl2APnIzGf5vpYrFwGZC7j2facSMWmZc2+R
 qKJ2KrSUBYJehIlH24P2xGHM4AOVoX1PauBn+4Fmyill1eUxc2U2Wy6VNwwBOXBRsF0QtAka97UI4J
 HTcUmKrctleegagPq6fy4SwKU1hgoHB6QoeqHXz+9AK3D3aFoVTRcRsGAWjZgYfk+pJonq8FqIC2wY
 dbZ0ZdIsPDCpKrmAiqEQeDVq3Pcp2geUZdXyrMNCR5qEuGnGMWwwxM7qxU3wSfi/FWcdUXO9u7AfOW
 XJa1E5fNvj5OQmb0Bv8jbVFehhfB5SdUSLm+Y6uFg00VaIGiNQ9DP0cYF8CGbZOPoNw0k6J5UUrYM2
 dLhTa6yvbDshQPNFneSeN2/HE98u/TH7HDrVZTtys/ai9GvabHdLR+E0kP
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The Adreno GMU Management Unit (GNU) can also scale the DDR Bandwidth
along the Frequency and Power Domain level, but by default we leave the
OPP core vote for the interconnect ddr path.

While scaling via the interconnect path was sufficient, newer GPUs
like the A750 requires specific vote paremeters and bandwidth to
achieve full functionality.

Add a new Quirk enabling DDR Bandwidth vote via GMU.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index e71f420f8b3a8e6cfc52dd1c4d5a63ef3704a07f..20b6b7f49473d42751cd4fb4fc82849be42cb807 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -57,6 +57,7 @@ enum adreno_family {
 #define ADRENO_QUIRK_HAS_HW_APRIV		BIT(3)
 #define ADRENO_QUIRK_HAS_CACHED_COHERENT	BIT(4)
 #define ADRENO_QUIRK_PREEMPTION			BIT(5)
+#define ADRENO_QUIRK_GMU_BW_VOTE		BIT(6)
 
 /* Helper for formating the chip_id in the way that userspace tools like
  * crashdec expect.

-- 
2.34.1


