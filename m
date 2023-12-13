Return-Path: <linux-pm+bounces-1047-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F79E810E4E
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 11:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A16691F2102D
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 10:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E228224DF;
	Wed, 13 Dec 2023 10:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r/UsN1Nk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09418A7
	for <linux-pm@vger.kernel.org>; Wed, 13 Dec 2023 02:23:48 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40c31f18274so62916555e9.0
        for <linux-pm@vger.kernel.org>; Wed, 13 Dec 2023 02:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702463026; x=1703067826; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b3Y9AepTBicceLfnJXPPiR6HbdagL0klZXMtneHZgEA=;
        b=r/UsN1NkObBWRt9DDlw33Zp/fs1afWlKXvbwJ297/668VxK4nre4vK6uH3Y3hxT409
         Z/1bILcr0e3+QWiNO7zvmybEg36I6VspE+xkRnKnUR10VGppMK0Idwc3T3q4T76nHQYY
         z5eA8ZRAAURXhh890mUDvqqW4WSOGHeHvdTqQucNvslViPlBNFj32nKPg711DlaH0zul
         N/4oInv2FD9H1cOlimiNc84IHHPmF7TkZa1BLALVKz+gt7Qzj4XB+rD9aMaQy6meFSgo
         hs7Q7nSxplOxw74jcljIhVblsLfOFuILxavBZKRJf8BEernSp34UxZMK1+FiseMsovBF
         hymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702463026; x=1703067826;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b3Y9AepTBicceLfnJXPPiR6HbdagL0klZXMtneHZgEA=;
        b=FWOiCTvJzfJppyIZn7qcE3sEhoKjpOjOyOSWfPjgduOLJO2X09KXLQOFLfJ3cEQ/zV
         Xf6+sOEM2nF40Wqofkafw7OEYFWYtg8bIfdfE3DlFtrR+KQbj5HtBIP3FTUDV3bqaVjL
         gpsjEX2eXFkKAwNLq4Cq50OMEVKuFa1xP7kEklu6nbAghhdOP2MKWJwLu94B3qGvTpUy
         er74P+sD/LGDz7uF1qQdBqinoDKfu4OqJ6o06JVVbHuMIuJ0e0vB1cxZVqhDRdlzpsJR
         NIpQMjdXgOpm6SkOyTVzZ7rTFhUlJT1QoOf0Zxwan2hgmaCt/1QVLhaAmnh+lUhb76Xl
         bAlg==
X-Gm-Message-State: AOJu0Yw+EqTngMSmLUwcIVBsUmO79hjQc6zeK85ptxDdY/t6PZ+AIkA+
	AweyXZ1XS+jBDgIdEsCZ1hmLQQ==
X-Google-Smtp-Source: AGHT+IEz4V8GZSQ/AfMq4yvzuJpArw/WSEoHiOgbrqLDihJh2QPp+nNsBtbNXyYBc4Jka6RFeZfPpQ==
X-Received: by 2002:a05:600c:181b:b0:40c:3dce:b02c with SMTP id n27-20020a05600c181b00b0040c3dceb02cmr3357917wmp.156.1702463026390;
        Wed, 13 Dec 2023 02:23:46 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id w7-20020a05600c474700b0040c41846919sm13705500wmo.41.2023.12.13.02.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 02:23:46 -0800 (PST)
Message-ID: <08788c2a-38c3-4cdd-8cff-e6681481cbef@linaro.org>
Date: Wed, 13 Dec 2023 11:23:45 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] thermal: trip: Use for_each_trip() in
 __thermal_zone_set_trips()
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lukasz Luba <lukasz.luba@arm.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
References: <5733564.DvuYhMxLoT@kreacher> <4529720.LvFx2qVVIh@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <4529720.LvFx2qVVIh@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/12/2023 20:41, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make __thermal_zone_set_trips() use for_each_trip() instead of an open-
> coded loop over trip indices.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


