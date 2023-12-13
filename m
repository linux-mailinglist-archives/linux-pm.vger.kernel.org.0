Return-Path: <linux-pm+bounces-1048-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA6B810E56
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 11:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCF05281B2A
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 10:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2562224DF;
	Wed, 13 Dec 2023 10:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Voitf75r"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF36CD
	for <linux-pm@vger.kernel.org>; Wed, 13 Dec 2023 02:24:23 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40c2db2ee28so71100085e9.2
        for <linux-pm@vger.kernel.org>; Wed, 13 Dec 2023 02:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702463061; x=1703067861; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sdrs03dZMZiQjD0oDQJ6lCq5E+UmKxE9fUWhvfdFRB0=;
        b=Voitf75rAfwH4wQjCm+dU8nY0YYtgZAAqqPR6+RkOCfXRI5/QPzwPkeOYQFD1nIz66
         wjfEiTmXd2ZtiHPqYLl/XlFPDP4jYublBjmEDMf7stg/wXSwgvOeIwqipl1H9ELBO5Qv
         sKx7M6rY9hxKct1i0GHGFYz4yGLHvHuJF0ANAiN19KpgsDw88oFHbr8Bd+FPNlNYvE34
         vJ8dU+l9t4q5F8zsignRSOPQIJS8CyStrNOszV3AQGDYC6GgzgUOmF73O8d1Vzi0bsd/
         cIFepa1jghrKKYffbAjBWzQUth1Ft6+Gp3Vq1q5kWpN9GW1vrZE1q32JJfztGcPu1uvc
         DFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702463061; x=1703067861;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sdrs03dZMZiQjD0oDQJ6lCq5E+UmKxE9fUWhvfdFRB0=;
        b=tKDCm3zjb0t+942+lc4OBA89lB9Fd0z0DCSwPESxMOBa3tvTZ0sKYkD5kAHIs4EsCJ
         Xa18ZeXs/rrAylxRqkjRhbKmvTM5imRKuuiFXgqaEEeFEyowdgxX16HLsL8+N9uEsH0Q
         RReorwdUMO/6rOh8peTBBZ+vqm1orObCENs0RAW3bVqMUJnzPwPoGsXW4nqHEnMSOcNA
         5AyGLq4NzamqgCO3s/fZx129LbZ5L0RQ5TsuyO0a+UrzlHEpUAwUG0/xtVi+F+RvXwhK
         uApRrk+4kGAO/LLuGHkxa/wwzwdLc+x0XloXBCfMIHS2fadxZzN9zP1MKQEBGoFORY+y
         gNjg==
X-Gm-Message-State: AOJu0Yyr/WaCfejNwZ9t66oCvPwBQhTduToZ2x5B5JcfSYERYM2eMKtv
	AhmBzATCxHrgnPgGnsOZ+N4GZg==
X-Google-Smtp-Source: AGHT+IFX4fs4ufacmpEdPsPXZ/eEfffGxElU825KC7qFU3UvOmmnsGFuPVBISkJvfQdybiOSxXEV6Q==
X-Received: by 2002:a05:600c:4711:b0:40b:5e21:dd36 with SMTP id v17-20020a05600c471100b0040b5e21dd36mr3800419wmo.100.1702463061580;
        Wed, 13 Dec 2023 02:24:21 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id w7-20020a05600c474700b0040c41846919sm13705500wmo.41.2023.12.13.02.24.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 02:24:21 -0800 (PST)
Message-ID: <5b76f719-2e19-4e73-8635-081974bf0c01@linaro.org>
Date: Wed, 13 Dec 2023 11:24:21 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] thermal: helpers: Use for_each_trip() in
 __thermal_zone_get_temp()
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lukasz Luba <lukasz.luba@arm.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
References: <5733564.DvuYhMxLoT@kreacher> <1871840.tdWV9SEqCh@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <1871840.tdWV9SEqCh@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/12/2023 20:46, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make __thermal_zone_get_temp() use for_each_trip() instead of an open-
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


