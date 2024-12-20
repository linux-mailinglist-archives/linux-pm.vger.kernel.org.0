Return-Path: <linux-pm+bounces-19586-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA0C9F975B
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 18:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15AE416BC29
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2024 17:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C18921C9E8;
	Fri, 20 Dec 2024 17:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mwwe/O2z"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19212206B9
	for <linux-pm@vger.kernel.org>; Fri, 20 Dec 2024 17:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714039; cv=none; b=aEwHw5GaRDFRmo3NdRMFbyE2L/nyHAWr/E5nQNnxECfWt7py9AGm32+CyBbte6Gf3hlIzfH1S1Zfn172NTtqo2oBd/QqR4JnMaw9SWyLJ6Mvo/VvrtaGh4rdNM8pA2aj/iQhCgKuIRxtMHVnWPVIV5naRENHSzOq6/gDQvq+zL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714039; c=relaxed/simple;
	bh=IDIsEwpQxky8+42CT/WRnqpHWTdUYjOv/TDVr+kY0fw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Twb3MdFoG0V3vbuzJci3bMBjAj8dRvMLhbAP5pirhFz4P/SSLwsTl560C8a44g9qpYM8dz8Xpp1bq4S3pHH9ajh5LIg7SkPHTZbcJFmELNbazuYdrg+4QpbMs+GmTIVXblCKjWvp/tnnje9abzPg3v9K/Zprs+3N1zDwqXzx/MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mwwe/O2z; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4361f796586so23096345e9.3
        for <linux-pm@vger.kernel.org>; Fri, 20 Dec 2024 09:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734714036; x=1735318836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sK6y7RfwZKL78wz9SHO2m2rgbMAGzctH+wuLbcNhNAI=;
        b=Mwwe/O2zHcUi2MCxGNaNQL44tPelC80YalggECH6zpUd2ePUZAPZtih3juiZNXI8Hu
         DgjsJJ1T15nIXihEWCB2al+v1RNqY4slti+N7nQA6JYMnlZPZ1WAQzV9WrC4I7aJ6ubj
         YYW4LVyVNs3WZmJZuvLMbRnyHZsI5B5DxBUOx+zn49KlX6PJKInu9+LBYFBIVb9dDSCX
         5cg2zs0uLe17IS/dQzEeeSwj2sdvVyixsQ6WX9h5s4Cryh/4uoxqw4r6jeZ+B4H+r1Fm
         vCYdIZ+y6ETE8W0s/kqTY9G0xzCTELLU+GSRpMh4hFlUP9RD5uDUTY9A94jvy7dSpJlr
         fBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734714036; x=1735318836;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sK6y7RfwZKL78wz9SHO2m2rgbMAGzctH+wuLbcNhNAI=;
        b=eQNMryB33tb4XL8v3uZVXQ4QTPNzXl5rOccMnwmHF8oPts4ISnYoi5p/f3DmxHRQgV
         7WT9Wl1V6ViNV2bH1S4BqaypZGVNGwew+ZTtOPeWdT31onknORnBzsuF4OJEOu6SbnlY
         uuXCYGeQn8sEhFRTzkShDIw27wAv5yVCUcEui0f2y20IWXXJVsIGjtLNh+yEYIBPrH1F
         J9DDpkgmfYAU80JOoPS8ZeUKWqgWVBrpXnWFol42ooxJvTz5BUcIB/F1Dkbo9fY6nN5w
         5KvvimGzgsw1BrwhPZHddNqq3C7ZmrMHSZf5fW7FL27y/pnnidGdR0SK7RJBATSFdJR1
         9Ypw==
X-Forwarded-Encrypted: i=1; AJvYcCXrb0WQUqJiRigKPjZPyR31b1lMHxMKrbU8QeHpX0fX9owsx9jqzBZ0X2p2Asnrt31D8McbB8Q9bw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpSaIYqzbIUL3HzB9RIryYHQjqAH89W2A63uzCDTObuDmu9Sv/
	oXmJJ+VkC3zb/j0rVzjHJKrSLdpJCQPNQ/NM8hmsIiQteIwlq/VH9FBQiBqcGGA=
X-Gm-Gg: ASbGncsik6oBwed3LW044eT+Y7SfTVbCzGGmUauY3Ni2EpZHhALkrqhtbp2lARPfPpz
	eSjEBBonoBEMleLtDuFOM2yrSTZwkrZLGy71k97E2Uc0kZy+QfcQ6AltqBO5j4syAeq04aSX40P
	qc8EHGiThQHTNrBLlbPXJVJZP4nhe8xbJywp2wb1HLjjtlH4mMLye5tPUc6NOeYXOnMMuRpWBtP
	LpKgikFA6fjdBV8zO8ltMI3N1926yuryFx9IZZZn8Ile0gskF0slf8UMGtPZS4qfrJQaSqaeL4=
X-Google-Smtp-Source: AGHT+IEIow7W7jlzekjBM8yMzgTeUbMzT6YnQhflYonoeJCqHySWJS3rP+z9Y68z1AcuWg4pRLt9xA==
X-Received: by 2002:a05:600c:1d10:b0:434:ff45:cbbe with SMTP id 5b1f17b1804b1-4366864414amr38292285e9.18.1734714036167;
        Fri, 20 Dec 2024 09:00:36 -0800 (PST)
Received: from [192.168.68.114] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c832e31sm4437915f8f.33.2024.12.20.09.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 09:00:35 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org, 
 daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com, 
 andersson@kernel.org, konradybcio@kernel.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com
In-Reply-To: <20241219062839.747986-1-quic_mmanikan@quicinc.com>
References: <20241219062839.747986-1-quic_mmanikan@quicinc.com>
Subject: Re: (subset) [PATCH v10 0/7] Add TSENS support for IPQ5332,
 IPQ5424
Message-Id: <173471403487.224698.3739532865770865065.b4-ty@linaro.org>
Date: Fri, 20 Dec 2024 17:00:34 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Thu, 19 Dec 2024 11:58:32 +0530, Manikanta Mylavarapu wrote:
> IPQ5332 uses tsens v2.3.3 IP with combined interrupt for
> upper/lower and critical. IPQ5332 does not have RPM and
> kernel has to take care of TSENS enablement and calibration.
> 
> IPQ5424 also uses same tsens v2.3.3 IP and it's similar to IPQ5332
> (no RPM) hence add IPQ5424 support in this series itself.
> 
> [...]

Applied, thanks!

[2/7] dt-bindings: nvmem: Add compatible for IPQ5424
      commit: e976eb4479e967cb6dc86b6e46554648a3b8f37b

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


