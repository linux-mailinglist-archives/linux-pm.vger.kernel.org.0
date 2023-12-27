Return-Path: <linux-pm+bounces-1607-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DED681EF2F
	for <lists+linux-pm@lfdr.de>; Wed, 27 Dec 2023 14:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 078C11F220C1
	for <lists+linux-pm@lfdr.de>; Wed, 27 Dec 2023 13:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3138E44C90;
	Wed, 27 Dec 2023 13:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ESDRj752"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EBE44C8A
	for <linux-pm@vger.kernel.org>; Wed, 27 Dec 2023 13:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40d5336986cso35756555e9.1
        for <linux-pm@vger.kernel.org>; Wed, 27 Dec 2023 05:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703683531; x=1704288331; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XnuJFTcaPg+7yorCOh56XX3MuEjCkxA2g5o6RezlZqw=;
        b=ESDRj752ObjtkFdq5KOEttHEyz2Tk6YvlaZtXbq4j/Yk+B3hYcEVUhpobx0AmGZTI3
         vrR6L83Nxg1vWXwgczkm4na8n2mXQczQbXn45ZdcrNqfFIXvqekFLw/+izoWBIiqMqHH
         N6Pc+T288jG/C5dgOYHC5mOdx4dS6PCt5NABPk3obMbcSTPdy0GSKcPO64sYSRrfPAE7
         Tl0AikDibY9n+7RW1BQATyPf+/ZEZWderG2Y1RikX0JCUXyojDHCSGdMxmTwltPEKdd7
         nQzaTWg4MXC5V19pWk5+Se4+Ab6B1mvAAvLo3rg531kU2x9dYLluv3IIdeyASe5ZqZOz
         caHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703683531; x=1704288331;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XnuJFTcaPg+7yorCOh56XX3MuEjCkxA2g5o6RezlZqw=;
        b=UUwEIMGK6CBuryBpyPH7OVthE9E9mGW11Wch0tth0vUL55k8yRBUeF+B/mepxEJGrn
         2GdHDO34bVzKt2NX9QBmhkf8PR+lSMSriQckkbletPcBm7l016K7YUTY13Bbl6Er4QML
         e7J3reV1IEh1os5uJGmQ75wuXgKRSIHRvR7IylyGlkcoDo0n8aCJcfMR/oHPcZfRpHBy
         DCjwci3Krl2Al7k3AwfmXmLfoolrcbkiWxoYT1ubEVEizqpwXqYS1bGvngsN/yhGzmp+
         0TRSXRO1tA0SghmpSYEW8+e1cKsD6F9jlb5s2P4uME48dhdf5c+J2pEOC+OQV/imUesh
         DxXg==
X-Gm-Message-State: AOJu0YyurjKjbWMmzNBu2KK3eeUsqzPMmy3oJgquIM2LpZkJz04ii8cU
	d7rHEQ7SXQlNu1VDNHEW1/pQkD8JfUUKuQ==
X-Google-Smtp-Source: AGHT+IFlK4cgUWuU/jWJrceWJh4lJpVSMiBHpX1FYCBlQRbZHkzzg+ijYf8Tc5zNd9CVFokKROA8ng==
X-Received: by 2002:a05:600c:744:b0:40c:3508:b40e with SMTP id j4-20020a05600c074400b0040c3508b40emr4296673wmn.245.1703683530729;
        Wed, 27 Dec 2023 05:25:30 -0800 (PST)
Received: from linaro.org ([37.166.4.200])
        by smtp.gmail.com with ESMTPSA id n23-20020a05600c3b9700b0040d5aa03ee0sm5381059wms.34.2023.12.27.05.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 05:25:30 -0800 (PST)
Date: Wed, 27 Dec 2023 14:25:26 +0100
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Maksim Kiselev <bigunclemax@gmail.com>,
	Martin Botka <martin.botka@somainline.org>,
	Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	"open list:ALLWINNER THERMAL DRIVER" <linux-pm@vger.kernel.org>,
	"moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>,
	"open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] thermal: sun8i: extend H6 calibration function to
 support 4 sensors
Message-ID: <20231227132509.GA4121@linaro.org>
References: <20231217133637.54773-1-bigunclemax@gmail.com>
 <20231218111404.5f08a4c4@donnerap.manchester.arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231218111404.5f08a4c4@donnerap.manchester.arm.com>

On Mon, Dec 18, 2023 at 11:14:04AM +0000, Andre Przywara wrote:

[ ... ]

> I will incorporate this patch into the next submission of the H616 THS
> series, so there is no need to merge this patch as is.

Noted, thanks

  -- Daniel

[ ... ]
-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

