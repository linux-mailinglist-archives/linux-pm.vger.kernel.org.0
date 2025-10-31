Return-Path: <linux-pm+bounces-37183-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CBFC25369
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 14:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA8AB4F7D8A
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 13:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DDE34B1B0;
	Fri, 31 Oct 2025 13:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUUtjtw5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF412E6CA8
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 13:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761916128; cv=none; b=HxjRJTPTUvDaNlAmYVHqJsB183IZGB2vcPkL8S+IAifV40pIxQbonLTyzLisff51nkPFGDIMO34fdaWGL+RrnW1bfJ41S/f3qS8S1CPc9t/YlbKoLa4zeg1lNELCgdCHFtdn+sh8QH5eAbHmzDJIWuDh4TRBwIvJ8eELO9cmIVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761916128; c=relaxed/simple;
	bh=EosaKghg3U4iEB4VNfXlrr7R7XRj9cKNCldq2SnVuGE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JFNFiPIFkHWZ0147/bglUGllyv9veGsii2CAnnkulRebo0MZXkR3cpcdF2b4gNb75wwDJWd5AYpleoc+9//uKAZGHE4Vp3ZVA3GJL4ronaLqdWfOHUu0Qjr02Eb/oAC1urGMJE94LR/6M2B7rxWuKYl9uEUjKdatRjuR6nXxhWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUUtjtw5; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-475db4ad7e4so8737895e9.3
        for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 06:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761916125; x=1762520925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hqRNM8UJyFRHPSXkcGPHCYH6LJDeMorOhD5X06t/AfM=;
        b=QUUtjtw5Bec6TU6z6eMOw6xB/T/fzPCeGN83/L2GqjzbyYPbbc81gytTCP0UeHUCFc
         q1YTUM4MlAQSnRDq5HRH3GO/suyhruk7cAuGS7ZnbrhSlGBUk780+PrBO4H59GW/GnH3
         P9FtsLuOBeWm6BFagci/EaunN6LkzbXdZSXtVkUbTuxG3xUfjX1K/ORlMZTm7Bqlb9ue
         lvtJeP5LACp8/pHJELgey4lkd9LtR2wFDQ/JC1G9GCCsr0e6iiy3hgtIZi4orPKuYHtW
         JPSKj0zOV4NkE4ANQU36pP1aPlESoHuHKGzErU/nSv1YhWpDVJGFEzZwSocCzuNsHi0p
         bQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761916125; x=1762520925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hqRNM8UJyFRHPSXkcGPHCYH6LJDeMorOhD5X06t/AfM=;
        b=XieTbXt9RxqgNLXKXRu5jWOmkLkB7G5+204yKg1/AinS+q9E5OBU7bJO5S1yAcAaO4
         0xJ5EUMtIy0uN2CIOyx0iZ50PbvIGZ0GXA+i5IvEU8VU6BFnwRR43dihQ4aFhBLryzXg
         XvsbpMB1VJ4AmxOiVYrYdzdVnl3/zxyGBSbLojqvTMo9d8IFu3+SDSk2DW1veI8o/E0m
         St/+BLKXmsM5laPxAg4kjtdHw3yKNAUF6aTzJiHZP0Ruk5Coojr95gArf2NfJxowfhI1
         Oujs7LjbxccgdP7XfPWE+4eFOZ0I2p1nf8dLu0MghaRnWLJXwlWda41MYshnXyaUWL/h
         I2Kw==
X-Forwarded-Encrypted: i=1; AJvYcCXVj1BlXSdCnv7c/u7qYUxsjT3yVdbWnnhLFDFzCO4e26/5hzam7x+6eNt3rmzJk6rheRDxHAjXMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/KJXTLxfzEG0nKF/8QqGx+wdMP9xO8QTlU/IpPbHYFwvAfwap
	L/gwgx3kKMhq+GVvop/uMQjMeUt1abviC58/2ppTHs2ANxl5ghrOlfb/
X-Gm-Gg: ASbGncstiVOIMvOHh6QA8Oq/qlKqTXByNM1H642fRxeaq6kILl26rp/RyK+4mkaAk7v
	iGuDZLgb21GbFLFcDNQEwWqHz9wL0c03uUsqAQBPxqDVB63V3m4fL/di44Mrzmz9pHfbIXImfkn
	CkoEouMBcQCQoFYB+nSt1KZg+2wI4KaZJxT9Pzl01HHaQADYEgVy7+r3xdRx2XxLiududeu5vkN
	hsLZ0mkSwI/vtp9utsh7n/4zhucANDu7mJ0s50zjYdx9DBNPPNECJIIK4RGTQW2GKS2FBt2CRAu
	rVGCypFB/bIZB8TImT+I65rToTjZMxR3JO8vpEYLNKEfSiUwANsUlHVZxnRRml5yWeXcy4jHH4p
	j89REBJryOEkLWm+qKSFnuWDum/n5Xqlw4Eh0fOBd2nkdoQWsjiyNI6FGcNdyTwlELdrtwwV8a7
	KawmgWYcXSthe0KWsWger7dXQlMUjRvBQLQmivk8Wd
X-Google-Smtp-Source: AGHT+IEoNfiwO1WHuUv2jGPlp9HRKqmIwSQeCnw3J3BsUZNvSFpBuq37GRGL35QSzOpJZZmZcOGadg==
X-Received: by 2002:a05:600c:6304:b0:477:be4:7a52 with SMTP id 5b1f17b1804b1-477308e11bfmr29796555e9.39.1761916125271;
        Fri, 31 Oct 2025 06:08:45 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-477289adc18sm98339815e9.6.2025.10.31.06.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 06:08:44 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ilia Lin <ilia.lin@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Raag Jadav <raag.jadav@intel.com>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] err.h: add INIT_ERR_PTR macro
Date: Fri, 31 Oct 2025 14:08:32 +0100
Message-ID: <20251031130835.7953-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031130835.7953-1-ansuelsmth@gmail.com>
References: <20251031130835.7953-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add INIT_ERR_PTR macro to initialize static variables with error
pointers. This might be useful for specific case where there is a static
variable initialized to an error condition and then later set to the
real handle once probe finish/completes.

This is to handle compilation problems like:

error: initializer element is not constant

where ERR_PTR can't be used.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 include/linux/err.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/err.h b/include/linux/err.h
index 1d60aa86db53..8c37be0620ab 100644
--- a/include/linux/err.h
+++ b/include/linux/err.h
@@ -41,6 +41,14 @@ static inline void * __must_check ERR_PTR(long error)
 	return (void *) error;
 }
 
+/**
+ * INIT_ERR_PTR - Init a const error pointer.
+ * @error: A negative error code.
+ *
+ * Like ERR_PTR(), but usable to initialize static variables.
+ */
+#define INIT_ERR_PTR(error) ((void *)(error))
+
 /* Return the pointer in the percpu address space. */
 #define ERR_PTR_PCPU(error) ((void __percpu *)(unsigned long)ERR_PTR(error))
 
-- 
2.51.0


