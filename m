Return-Path: <linux-pm+bounces-1158-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA51481363F
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 17:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A518B21AA2
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 16:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8DC5FEFA;
	Thu, 14 Dec 2023 16:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNtXOp5n"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F31C10F;
	Thu, 14 Dec 2023 08:29:34 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40c3f68b79aso64829785e9.0;
        Thu, 14 Dec 2023 08:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702571373; x=1703176173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzQGVhzK9qgzTVRhSljpGjlLUwC8cdffhqMfyCAFf7I=;
        b=SNtXOp5nnv5BJo0bBOZAfj2NldHoJzdqajP5NA6v6JVV/p8p2wSym8Wq52TcGK2kEd
         QYAOyHbVkzvayTW21trYPomyrTYGOdftVdyEwdWsh23fwqtRY4lnPqRTC2LVZP1bJenE
         DaK3rFt2YCqzCsTEttp+bKXuRi/sCN9kK1fqMBrrm684nwSx0hFSXlJcT0BHwH7njJ1p
         H6IPMnnc4xXkbfeoZ8aWBBj7wyEs7keFK+D8V/U2Es5bf4Sri9HKVEjH1cG7v5QUL7J2
         YW4tXGugE040x092hPJumTCoGJV1n93Fin7S4wlMd/Lupfe61LlA6tGSW5rzha9Dnd7l
         XomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702571373; x=1703176173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YzQGVhzK9qgzTVRhSljpGjlLUwC8cdffhqMfyCAFf7I=;
        b=ZKUhdAjYg3w0PqR5Tmzq4+Lx2TCS/Zrgc2cvOhW1rrqj/Z5J4PVREv36vbzeO5X+AS
         9uqhx7rapFKEeTm5I+XDEsDTWRCN+Pt8BxMreb5eYGp4NpjWjUIfLrmDWUPcxbt67Y4a
         oYnv3BP0re+lsErIH2vJUujYh2A59S3gf2cSPQNJHFiNZ5dCpHpRIMzDrceo8Y7aRUT/
         31sEdIBffys+D5Cw6mAF0rkCtsrHZyGkBd2l47F5D5W5ZjcbiSq0s/sLXKJ5LBIcwrcr
         rJdKA9Mc/WzhL3WckyKnQLIIb+WiQ03lyI1XdWedqUjJi99OKNiYG/kyMQFMb3LoFK77
         4xQw==
X-Gm-Message-State: AOJu0YwAMFcp9x+yxDTPOeC9ARxbwvWFTo1lyg0O1km+sWhl2yhL1jqM
	nnz8wg6q2e9GxLZsy8CSFHU=
X-Google-Smtp-Source: AGHT+IFN5ZJPrgJWQSUN0ieEOEfcOtwuEvWwJAPclnmbsShFkrfXSYtGFxx2cJxfVHSsuqkS0Ivihg==
X-Received: by 2002:a05:600c:d1:b0:40c:26f4:dda9 with SMTP id u17-20020a05600c00d100b0040c26f4dda9mr5404229wmm.187.1702571372498;
        Thu, 14 Dec 2023 08:29:32 -0800 (PST)
Received: from archlinux.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id m29-20020a05600c3b1d00b0040b3515cdf8sm25377092wms.7.2023.12.14.08.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 08:29:32 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Yangtao Li <tiny.windzz@gmail.com>,
 Brandon Cheo Fusi <fusibrandon13@gmail.com>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 Brandon Cheo Fusi <fusibrandon13@gmail.com>
Subject: Re: [PATCH 2/5] cpufreq: sun50i: Add D1 support
Date: Thu, 14 Dec 2023 17:29:30 +0100
Message-ID: <8351928.NyiUUSuA9g@archlinux>
In-Reply-To: <20231214103342.30775-3-fusibrandon13@gmail.com>
References:
 <20231214103342.30775-1-fusibrandon13@gmail.com>
 <20231214103342.30775-3-fusibrandon13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, December 14, 2023 11:33:39 AM CET Brandon Cheo Fusi wrote:
> Add support for D1 based devices to the Allwinner H6 cpufreq
> driver
> 
> Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
> ---
>  drivers/cpufreq/sun50i-cpufreq-nvmem.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> index 32a9c88f8..ccf83780f 100644
> --- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> @@ -160,6 +160,7 @@ static struct platform_driver sun50i_cpufreq_driver = {
>  
>  static const struct of_device_id sun50i_cpufreq_match_list[] = {
>  	{ .compatible = "allwinner,sun50i-h6" },
> +	{ .compatible = "allwinner,sun20i-d1" },

This is not needed, as there is no functionality change.

Best regards,
Jernej

>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, sun50i_cpufreq_match_list);
> 





