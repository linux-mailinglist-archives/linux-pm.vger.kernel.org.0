Return-Path: <linux-pm+bounces-648-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2C38022D1
	for <lists+linux-pm@lfdr.de>; Sun,  3 Dec 2023 12:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B352B209C8
	for <lists+linux-pm@lfdr.de>; Sun,  3 Dec 2023 11:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD13FB671;
	Sun,  3 Dec 2023 11:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v6yd0E2f"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FF1FF
	for <linux-pm@vger.kernel.org>; Sun,  3 Dec 2023 03:26:40 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50bc2e7f1e4so4853551e87.1
        for <linux-pm@vger.kernel.org>; Sun, 03 Dec 2023 03:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701602799; x=1702207599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRBX9qjaYScewEyAGN3ZWpm24vfD1L73uIHC1C0KO4Y=;
        b=v6yd0E2fG3g0sluCyynDyQNWieQPP+it6n392fqQzQXspBtgc1C6soPqFge8W6JHtP
         mVmF84TQMCBR1EyoxwtLnktpTDJfRfI3m0mfCVJgOwuTecDJVqzsOmOWTzuP+Cz9O0NS
         FZc/5BqdSg70JsdUTAqZa9phxzoKNt93BZHEPypXFB3y6pkiSRZn6nq0kqZkH+LuEk7T
         imuy+dJp4Xr2y1VAqBKlPB1coVx1kMUywIPffD4Q2faxDOhz1D8cNaqlHTBty/+jfW8E
         7rXDDxAP9Z+uT/OFRdYnjpVl2pzvgbOdvegCwxj3274Fi1FWVhjTxlawOFpmr2gipR5O
         wrvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701602799; x=1702207599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRBX9qjaYScewEyAGN3ZWpm24vfD1L73uIHC1C0KO4Y=;
        b=SYEI8zH+cijRjjJPy3yjf25JnL7Xdxz0Q+sKqzusauk2F/2xtWoH9+FI/58nPT7yp5
         cGtuOJJ2SvHoPexQrbctuIEkvrrVJKzbL0Zlk7sVdV/7KJEFDNRZmKS1UFXYg2Ch5UIK
         rfhK96sErPlJz1hWcUsUbUd0Zy1KKWXsh9rnP7NwdAoIOQnw9t8lvI+ljIxneFFYc/S4
         yO9vkxzxqECp6iihkKuBv8y5sWzAlXJf5Y9/t5vaWDEKsDItqsIX1gnFgh0zdwucrINp
         ZRJjGQunbgC/+Ebp501FPe5N8veyb8C6AKd/+pYK9R05rcXCIlAIHxYKF/4YHQY//qi7
         b3nA==
X-Gm-Message-State: AOJu0YwGQ4Duuf/xesZqNE71NDMMyl0VlbBYtp6YGPTpOoslAB6sJfEf
	Cr+77kiPMx2/CA9EQv+qyXP9nQ==
X-Google-Smtp-Source: AGHT+IEo2kVrDxKWsLCcwvE8hl19v/Tnab9g7q9epanULPqx4nYnbkuhxAF8ZygQf6iwFdwfxMYOiw==
X-Received: by 2002:ac2:442f:0:b0:50b:d764:6e9c with SMTP id w15-20020ac2442f000000b0050bd7646e9cmr1980872lfl.76.1701602798822;
        Sun, 03 Dec 2023 03:26:38 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id b9-20020ac25629000000b0050bf01760a1sm241224lff.295.2023.12.03.03.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 03:26:38 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sean Paul <sean@poorly.run>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Loic Poulain <loic.poulain@linaro.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Georgi Djakov <djakov@kernel.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Krishna Manikandan <quic_mkrishn@quicinc.com>,
	Robert Marko <robimarko@gmail.com>,
	Das Srinagesh <quic_gurus@quicinc.com>,
	cros-qcom-dts-watchers@chromium.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
	Rob Herring <robh@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v3 00/12] RB1/QCM2290 features
Date: Sun,  3 Dec 2023 14:26:23 +0300
Message-Id: <170160265544.1305159.7127586815591334441.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231125-topic-rb1_feat-v3-0-4cbb567743bb@linaro.org>
References: <20231125-topic-rb1_feat-v3-0-4cbb567743bb@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 29 Nov 2023 15:43:57 +0100, Konrad Dybcio wrote:
> This series brings:
> - interconnect plumbing
> - display setup
> 
> for QCM2290/QRB2210 and
> 
> - CAN bus controller
> - HDMI display
> - wifi fw variant name
> 
> [...]

Applied, thanks!

[01/12] dt-bindings: display: msm: qcm2290-mdss: Use the non-deprecated DSI compat
        https://gitlab.freedesktop.org/lumag/msm/-/commit/25daacc60394
[02/12] dt-bindings: display: msm: Add reg bus and rotator interconnects
        https://gitlab.freedesktop.org/lumag/msm/-/commit/a1ed5860efd3

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

