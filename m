Return-Path: <linux-pm+bounces-35438-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D88DBA25C7
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 06:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94B111C0225E
	for <lists+linux-pm@lfdr.de>; Fri, 26 Sep 2025 04:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D4526F2AB;
	Fri, 26 Sep 2025 04:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uohg4VZy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE3926E16A
	for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2025 04:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758859416; cv=none; b=jjgmY5vfdtQ4+Q8ru388eq1YKiVmrfwVWH7ufZzVA2lMun5Vs2FVkkPGxTUCd21Vg+DrInCPeza9vb0H773FTonpo9pGupZmJtEY4dYgSE/AOefPu1PsoomCFA573IF6g2liNRelYZlT7+x+X5GuEbUy1ZygjwmpIzeewoQ3O3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758859416; c=relaxed/simple;
	bh=aDhxeCkC8fJ1lKK66xBz3OEbwpp7thZqdmHZS7jPnLs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=m4vvu8a4bace6LMMaEyV7+NqQJUViEZ+D9AOZe6JY/xIvssTiouyZoBu7dkztNG/0TiDJN4yaQisfqGIoSTvo/G2+w8bYXvp+3ChqBvMM21Cku6gF+8FILaBCYFyJ3qvnsBHBBwy3t5JjlW4DVcSYctxbXbzaZ42CYsj9+dalVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Uohg4VZy; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-414f48bd5a7so177365f8f.2
        for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 21:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758859413; x=1759464213; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jAvxUIgiwZnoN4z0j99g7O5RjAHri0iT1cfvlyji2fc=;
        b=Uohg4VZySZa6WsDVV2omhDyY2sq4dHlJjpLPnFR0WZ/ZlCPIENZRYFszx7GJUsqNkH
         0J0Tf3Gv0brDRb8yogpe+WMhJ8tQ8gOCju5mMKuUgN1mAsq7U39It+1dWlZqqTtkT/Bj
         HRoQVstJHkZGIg3ddBmylNEx+fcgxhJQsIiyKZlhoRFNOc2M1u9u4zQMlUrILkOoX0Mu
         eV/KnAi9c+ijq3cvvwWoy0dBOWfxcOQ+hqaaP0m4Z0b3+Nv9hJPzaoRcbX+G7/cxDciz
         7Z2tjZ+6PFPeG2z7SimYbgAssrzbQUFgTJdqWLqbcu9E2YAOVYLm/O8FmukqRl+B/u51
         zC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758859413; x=1759464213;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jAvxUIgiwZnoN4z0j99g7O5RjAHri0iT1cfvlyji2fc=;
        b=hLtx5zCp8/LQoFRaK61Vu1Fsy4OfpeWeIinFZei7nTX6s5gh5GcofXwHvFptZCnpu8
         fGxJF2jF7yoNEFpZ2FALzIrU48UW7U+fXHpF/APXxtXS0/GcEceMyR1zr7IJJVSxVqJ8
         yJ5BIJPJUozLxSUxc+5WUff9WgwPe4PGP/ZWrVZEO5vqqU42o1ElrlXHSFr9vwNWxZj8
         NNiVRcokap0ZWjioUAzqsjH5XErwcIdRM4p9esTNPvZv1iZ1xpX/peFXKh25cx2ygeQA
         ccGu5ka6s5A6b/bVWw9iUh1RQETFCmvvmd9WIrUzAPY+z5tA0yuR3jUXVC3CPkMNrZdc
         sAoQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/RgfUX6oS5BgqGuG3/VHDfliFV0JhTnKHHAzhbY5z5RFtlMba1p9fbqLXM4UeEDn+UycUgIAMEA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBx7H+xKk1wG3cBx7GAm3N4hFa/GJb4pozuBqn3Tztgt6zJX4D
	V1LCSPw64cjsA4PV0a46ZevVt46C2p7fkIveDlO3+MKU54bhAL1aDUk71es70vFcjjM=
X-Gm-Gg: ASbGnctDUsoY5C5gY3NLVrEa98X4zucyiQ8/BybDEU3XAnirfkJ6X7clBIzmAdzrtV/
	GZog9ZHuLWA2FfYaKKRO0j+Ew3GihfxtJ+EfEGzYOTsgBO6iPhefH7yqmVIAQBJX2fRcCaQHds3
	kx/4WpS2MWK/p9JuG9IbkjD2V0wbr02Jp6SrzCjAt6bs7nAcDDxuJ/jGiN3YL5SlSRLygB7gTiB
	w56bC7zLKlFkwD47gfp3UkmeE7kPnMsOseQq3HYqwv9HWgv/IF2/rASQ4Lgp4F4ATWKKHMgnbYy
	VoQ82Cja+Aw1L1ao6jQMTg44dLc4ZoRrQWauxwDesT6rIdvxuStYz7l1f4u093IkTQxJC++jAfk
	jP8BiOhAV3Oz8k5l/D3UxfqAkjy1Sm4SI4pzBzcwdk3f3+nnfhQ==
X-Google-Smtp-Source: AGHT+IG5qSGA+zLmaSVai6Z0wqDL5M4a9N7yHXLm/VuFTKV5wrkMZ8mE7n7IYfhWmV2EMBcPnVktpQ==
X-Received: by 2002:adf:9bce:0:b0:411:3c14:3aac with SMTP id ffacd0b85a97d-4113c1440f0mr2029219f8f.7.1758859412949;
        Thu, 25 Sep 2025 21:03:32 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e33bf70b5sm56361345e9.21.2025.09.25.21.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 21:03:32 -0700 (PDT)
Date: Fri, 26 Sep 2025 07:03:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] pmdomain: thead: Fix error pointer vs NULL bug in
 th1520_pd_reboot_init()
Message-ID: <aNYQkVuVpP3Daq7x@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The devm_auxiliary_device_create() returns NULL on error.  It never
returns error pointers.  Using PTR_ERR_OR_ZERO() here means the function
always returns success.  Replace the PTR_ERR_OR_ZERO() call check with
a NULL check.

Fixes: 64581f41f4c4 ("pmdomain: thead: create auxiliary device for rebooting")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/pmdomain/thead/th1520-pm-domains.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/thead/th1520-pm-domains.c b/drivers/pmdomain/thead/th1520-pm-domains.c
index 5213994101a5..d7cb9633c7c8 100644
--- a/drivers/pmdomain/thead/th1520-pm-domains.c
+++ b/drivers/pmdomain/thead/th1520-pm-domains.c
@@ -179,8 +179,10 @@ static int th1520_pd_reboot_init(struct device *dev,
 	struct auxiliary_device *adev;
 
 	adev = devm_auxiliary_device_create(dev, "reboot", aon_chan);
+	if (!adev)
+		return -ENODEV;
 
-	return PTR_ERR_OR_ZERO(adev);
+	return 0;
 }
 
 static int th1520_pd_probe(struct platform_device *pdev)
-- 
2.51.0


