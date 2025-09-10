Return-Path: <linux-pm+bounces-34345-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 831A7B512D5
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 11:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20CA1564325
	for <lists+linux-pm@lfdr.de>; Wed, 10 Sep 2025 09:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FBE3148B7;
	Wed, 10 Sep 2025 09:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lHSKzCSZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6CE306492
	for <linux-pm@vger.kernel.org>; Wed, 10 Sep 2025 09:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497277; cv=none; b=SCwPyoLwTwHa5oMoDf8ORxelS+8arZF3gKec/Bp/GPFaNzQIqlabpVFoPSAgogDLaYiI9Fgv48W7apLEar0ta1cF01snUYVE1QFqcrtOSzBDPJxyabCtEZ4dnJfkGKCJVyo44gDQLtf+/L1hhPHM8jWcd/OsAUno6RKS6eOtWGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497277; c=relaxed/simple;
	bh=iT6a/zPgyBzTF0XoggB8KlW7bpDBsu9wFGAHxlhXv7U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=q2CtRcs6HZow4Qp+tPfBkiFf0gBep7YF/Uz5c+co7LyLBOKhZgf7+YtXiAGbRIzgHEkGqAmyvibVIezxJn6vuFlaD2wQaRi1UDkMDQ6LbY6Yn/3Vkk9/UQhiq4TKh+sS8wUuH8Mg3fAzr/PWYVyumvmsvH2ZhYmCATcVDcJgdTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lHSKzCSZ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61eaa4f6784so1133416a12.3
        for <linux-pm@vger.kernel.org>; Wed, 10 Sep 2025 02:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757497273; x=1758102073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0SOuA/g/nVXdKYjh7EclBkYe4s8OIpHOm/5rpv34JIc=;
        b=lHSKzCSZoBSfplgHs2b1zbxD7ew72xpOmcWdm0omUOP7VhOk6JD8xrSK4504pKtvQK
         7BFHNwxgoN3uPVLYlJBh9TuwojPstdzFMS+Mlv8zSHSNZmtTUM+8R1z9jdE/xmJNuH0t
         JjIFlWQzwUKvqjA6e3w0l9FuNahuo33I8GpCedoU8odUAK36CQYI/pa5lNEFXUKHkb9K
         J2Gx9jr+eAY9AG/8aJbmDWM/+k0TnkBLKi8hIh7XjvibM130HrsSlmJ0riHH0pkSyqT1
         FPLMOp0M7JppOPy/x+HogbbghPr/6fyVnUeXHuyBL7ifVRnQn7MVacBEq9rgsHIuflLY
         NjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757497273; x=1758102073;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0SOuA/g/nVXdKYjh7EclBkYe4s8OIpHOm/5rpv34JIc=;
        b=dYytaFnedpirUL9DIM83OsyqykiRnxrAIxQUmOttOJDWzmu6CDtpWDkPd11Gw1sPL2
         Njmxe6vWblQQe+A1N7VtYp3wVZTjpfr6TdmwW2FP8PwDsdfbfujAzQRlYwRFWW+X0xdR
         rbz+pcsnjqv312KAYL5B67pbjjURjkmDMEzHlYk5rugUZQ1it7ijvLhAvAPaqRTIW9yn
         AlYsqguaJKTZVoOWNG2GDIkIhemzqx74vOrizXFgcYq4T19rMU6xTUE+CzD9Aq1fzxs+
         AatsP9B1yZ9IGKFqYj3fjKGnUx1QFpDqO9icklfWxPS4kwdW9Mo4J88hfVu6t86OFmfz
         jkXw==
X-Forwarded-Encrypted: i=1; AJvYcCUxmV743+6+OCU9Zg29etoepRdJ1sJ5kA3gMq0fI2sRm8q7CuyX1Laqp0mnY8KOSEOkDj0u8xNI0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwKoB8OM/HXOqKZkNV7mUICpibtBM4k+IOG7Gxm9tRSWKEfxJ5T
	v6CrmfKE6bsV5axHb8uXLYM+qVUmemomQoQVw5IfOj5f5oB8/HwYp48TcHMFCKMJJ9s=
X-Gm-Gg: ASbGncu/LsbHS23u6UsPDFGcNkrojLMmjhR1YNnxS1HSsSlFIvEiXGyh6EBrKl3N2WN
	M5t12/xrFnhqnQhyt2y61Z3ZLPwgfUavnqj8Jeyskq2tCZZ9rqCoLd08HIADQXIvqn8uj/Iv6aJ
	mrFwtYx4uaJZBEJrALvqry1KwiZDv6zqUZ4I5PBedCnf3hpWugUPWb6CKr+lJ3ozLju8rbQuU8p
	FLMS6jdNkMnAzGmb7AMrIQAH5D0r7lD59kssOMjVhaYBBBQpvG/zQYyO3wKPRc6r7EpEAwRzFUd
	k5gFisp9KIPl+n3c7mZsIX8xsuEr4gocAKOrBr+YQzVqp7aaqTzIeuGSVjONlvIiHw3lW1eU6vL
	nioPqhMYdYh8PXpoTk0zd1i7l6eiUHZSsbR13wEM=
X-Google-Smtp-Source: AGHT+IFFimeDDYyh9wXdVWxN7z2S4of6Ed5oLlealg+J5WJbf9k2XtQ+Zl7cp5trMu0jBLQkBELkhw==
X-Received: by 2002:a05:6402:325b:b0:62d:c7b9:b149 with SMTP id 4fb4d7f45d1cf-62dc7b9b348mr387259a12.2.1757497273537;
        Wed, 10 Sep 2025 02:41:13 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62c01bdb7e9sm3021590a12.48.2025.09.10.02.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 02:41:12 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Dmitry Osipenko <digetx@gmail.com>, 
 Aaron Kling <webgeek1234@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
In-Reply-To: <20250906-t210-actmon-v3-2-1403365d571e@gmail.com>
References: <20250906-t210-actmon-v3-0-1403365d571e@gmail.com>
 <20250906-t210-actmon-v3-2-1403365d571e@gmail.com>
Subject: Re: (subset) [PATCH v3 2/9] dt-bindings: memory: tegra210: emc:
 Document OPP table and interconnect
Message-Id: <175749727162.29308.12636309161261093675.b4-ty@linaro.org>
Date: Wed, 10 Sep 2025 11:41:11 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sat, 06 Sep 2025 15:16:52 -0500, Aaron Kling wrote:
> These are needed for dynamic frequency scaling of the EMC controller.
> 
> 

Applied, thanks!

[2/9] dt-bindings: memory: tegra210: emc: Document OPP table and interconnect
      https://git.kernel.org/krzk/linux-mem-ctrl/c/550faad18505aac40a1551a5b467e0a63bf2d639

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


