Return-Path: <linux-pm+bounces-26330-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69498A9F98E
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 21:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7D8E179D65
	for <lists+linux-pm@lfdr.de>; Mon, 28 Apr 2025 19:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0761B423B;
	Mon, 28 Apr 2025 19:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSoMrtCG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646038C1E;
	Mon, 28 Apr 2025 19:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745868812; cv=none; b=jKsrYSt44mkI38jNNLXnNvUYbm8W33XowRPGzp1XCR2EMVifnEzRGkj8j32vZaIRHWtg5x98GukbE+6FrEHPxLdz5vtpq5JBby1GbDe84Z37ufajBiP9fjiT5b3cprV+6FuWou32YTNQO9v0ljD0NUtgiYLahIPj3QlssiSHQCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745868812; c=relaxed/simple;
	bh=fX3wJzMvCpmppQx9eX7xDgMDyv3PO2lJW4kBkq2APOo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KH9t1BHsIYcH2SaBRsm6jbpqCWGxlsjBHvCQdZOY5NVrRL3QrYCYvsTk6syRzwkhxxRjds5iAYyCjRfD6mYS2G1dfXA07NCTlF/c9OSKhedpGzl0GctEDV+B0cMAjFkiUZ4y3WOy7QVwpWM0OmNCMBHtOvWOvf2u4LeVNuyWJOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QSoMrtCG; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2cc57330163so3446007fac.2;
        Mon, 28 Apr 2025 12:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745868810; x=1746473610; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fX3wJzMvCpmppQx9eX7xDgMDyv3PO2lJW4kBkq2APOo=;
        b=QSoMrtCGNdtBduhY3i7WilJQWhs4BW8XVZBTg8CaMrpPTyk9xnluZMpPECzEc6HKPn
         Y/CtmXS1CYqT69jk4CfyH0Voob6JsvluS2l8kA7cKnkL7IJT8LWTbAnXB6TGm89r5F3b
         B8bW7X65/7Gcs81GFTNXMa7Nsu8xSOHn+5U0AXdv2r/JcPKRtO+WJZgKhbXccr6L3mCY
         Sff3+bByKaw1kHnSFTHKXO1dwcLtW1sDAbIaW7OhF/8rbYMRKuywunLAXKZHmQ5ihp6t
         B9ZniXwl7E2TWhNTX+vO5QiLOX26+yJt7ubi9+9buXoso58dA+MMkhVUNB8zvLm7/7nv
         SZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745868810; x=1746473610;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fX3wJzMvCpmppQx9eX7xDgMDyv3PO2lJW4kBkq2APOo=;
        b=bu7shPUZfKS+EQn7LIruBAmu3JYJAb2od1E3QyzkfRW6ZSjjtblbPI4rmkwSvXaA4a
         X64L9vKgrprNT/lu3PMl7SN1Eoprt95BGklYXCXhcuyCyjawQxMuDaucSBPeR3wr9Fds
         XGX70E8kMxKv6x6Ir703Nd6a0fH78ksM1746qA9TFN8HsiSSOihwHYkI0y5XVQYmLh62
         6iLgKvDFCZCz2pZ9RmjROtB/w8uR04GNxUhOtyUeljw5IhJd6JBZagFTWrPxFu3nLYyC
         ng8y14XEQ/x6+wBprKBMbS/s1esSPhLJVipfQbVECKZ9/3Yy/atLtd/uWbNMGiw8hOui
         2Tpg==
X-Forwarded-Encrypted: i=1; AJvYcCUusY3tlHe82ITnDvm6uNLnGdfADzXcBTSWbiyzVlyZiFcgOmUdbE4AC1l9nk4i8NED/KRPqZQY/ws=@vger.kernel.org, AJvYcCXQQWtScJM1c+xCQg0CgxrWhSr0x2ThiRWg9DMNDeEGF7drYzbAzlBO8D+jt2CbNISvpXZUHDsaL4gVOTM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp9OLSrvZZsX+RZz2K21sj3DP+ncD1Y82uyNWyAzmuG67cHlFF
	+tJ2UGnLRG4oHQR01Gsvc+I9DzPSQ9WLsPBNTVBGm6Uu2h1+b44x1K5J9g==
X-Gm-Gg: ASbGncsuBbWPUAQT/t2fL37Z8lH/y2n8V/T/Dl61cP8RSckju+LPdvfOTY9iWQ1ewBu
	WMWuHxvYmH5z58oSi0xR+VYT60vBgtfTMYIK0LRIxZKmAzDollofoQrggpCxqA/kBPqNp1wYtJc
	Y34XqdaOLXpbhnYD/x0ajachFYFC0rOCUvg7LQFJ9CR2pq/uBPbC6Hhef+b65LaSly5C36CR+LE
	Sd/CDsqMj1obq1o2Ny6OmI5pChozqvxbuxUCMBzMBCYsmpyOab06y1hVuYZ9IeOfVOk2bNfNW51
	+RPfgRd67TE24eJmSCkjFgURA0002N9LTAgBpm9RtA==
X-Google-Smtp-Source: AGHT+IFucS+go6LKq+JUwgvoDuptmo8PyOjo7aYF+zk9OasgwvP/cfm1kll04Xv8npNY6Lsr5M4vWA==
X-Received: by 2002:a05:6871:33a0:b0:2d4:d820:6d82 with SMTP id 586e51a60fabf-2da486a7c1bmr53271fac.26.1745868809865;
        Mon, 28 Apr 2025 12:33:29 -0700 (PDT)
Received: from debian ([200.92.175.161])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2d973736065sm2447490fac.16.2025.04.28.12.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 12:33:29 -0700 (PDT)
Date: Mon, 28 Apr 2025 13:34:01 -0600
From: Your Name <kike.correo99.f@gmail.com>
To: daniel.lezcano@linaro.org
Cc: glaroque@baylibre.com, rafael@kernel.org, rui.zhang@intel.com,
	lukasz.luba@arm.com, linux-pm@vger.kernel.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RESEND][PATCH] thermal: amlogic: Rename Uptat to uptat to follow
 kernel coding style
Message-ID: <aA_YKeU45ZTXYUes@debian.debian>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Daniel,

Apologies for my previous email being sent in an incorrect format.
Thank you for applying my patch! I’m trying to verify where it was merged.
Could you confirm if my commit below was merged into the `staging-testing` branch or another tree?

Commit hash: 84fe0cc6fddb6afcdca838d80756080f84cf9ecd

Best regards,
Enrique Vazquez

---
Signed-off-by: Enrique Vazquez <tu-correo@gmail.com>

