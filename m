Return-Path: <linux-pm+bounces-837-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A983080A763
	for <lists+linux-pm@lfdr.de>; Fri,  8 Dec 2023 16:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FD701F21346
	for <lists+linux-pm@lfdr.de>; Fri,  8 Dec 2023 15:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AE730656;
	Fri,  8 Dec 2023 15:29:12 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB351732;
	Fri,  8 Dec 2023 07:29:10 -0800 (PST)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6d9d0d0e083so1500981a34.2;
        Fri, 08 Dec 2023 07:29:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702049350; x=1702654150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2To1yV3sBlyUIXX2dRxgZLUw8e5tQCWslY62gbS5zc=;
        b=uuSt5PVHIIv9XjMoynJbPC5N/Wdn+bYHEfO8B64NSRmjeMuZDSgSnt6t5K8TQl7jFM
         AgQpiJ8PYP+/0swiiDyLJ4BM63nOQm9YYp93gDLIjhGtuVGkpEWPYG2RlhV9kcx1w9H6
         as15tMOsfsScZv0kXRQHIqyB4l1RJo3i0f4JhWzglDv8Fj9pUPKDqN1JT7iQe/jYY/sk
         tV50T6LQNNgBR6Rz+jHDGBI4q6mL8I4Vegquhj5Wre+xsnGBi23t1zdtRhtPnysUWXjj
         geTycgN/DqaXJtQsVJZh4+0zK2m7+kF2WaHhVLTK9bnZ+xU2RhkD/k59WI5AaJKdF8mZ
         3M5A==
X-Gm-Message-State: AOJu0Yxi2uHxTEUTS/0LeTk+wgFUc9j7QB74SbIcl254z0nznV5qO+Lu
	g/ZAvBsgm5ZH5Qg7PvoxMg==
X-Google-Smtp-Source: AGHT+IHyKKjladIMN927leaaMAXflSx/bGCGRS95D1nFq54QptT3Wo+QdUF8jxOs29jg+9zj+WWbgg==
X-Received: by 2002:a05:6870:b69d:b0:1fb:75a:6d47 with SMTP id cy29-20020a056870b69d00b001fb075a6d47mr273275oab.110.1702049349884;
        Fri, 08 Dec 2023 07:29:09 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id lv18-20020a056871439200b001fb24a0c23csm434995oab.35.2023.12.08.07.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 07:29:09 -0800 (PST)
Received: (nullmailer pid 1380806 invoked by uid 1000);
	Fri, 08 Dec 2023 15:29:08 -0000
Date: Fri, 8 Dec 2023 09:29:08 -0600
From: Rob Herring <robh@kernel.org>
To: Alex Bee <knaerzche@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/5] pmdomain: rockchip: Add missing powerdomains for
 RK3128
Message-ID: <20231208152908.GA1378274-robh@kernel.org>
References: <20231202125144.66052-1-knaerzche@gmail.com>
 <20231202125144.66052-2-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231202125144.66052-2-knaerzche@gmail.com>

On Sat, Dec 02, 2023 at 01:51:40PM +0100, Alex Bee wrote:
> For RK3128 the powerdomains PD_PERI, PD_SYS and PD_CRYPTO are currently
> missing.
> Add them.
> 
> Signed-off-by: Alex Bee <knaerzche@gmail.com>
> ---
>  drivers/pmdomain/rockchip/pm-domains.c   | 13 ++++++++-----
>  include/dt-bindings/power/rk3128-power.h |  3 +++

Bindings (and DT headers are bindings) should be separate patch.

Rob

