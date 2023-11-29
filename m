Return-Path: <linux-pm+bounces-511-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F30A7FDB58
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 16:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F9851C20B04
	for <lists+linux-pm@lfdr.de>; Wed, 29 Nov 2023 15:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FC838DF5;
	Wed, 29 Nov 2023 15:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NaUuA/z8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6EF199F
	for <linux-pm@vger.kernel.org>; Wed, 29 Nov 2023 07:26:21 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c9b7bd6fffso21767511fa.3
        for <linux-pm@vger.kernel.org>; Wed, 29 Nov 2023 07:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701271579; x=1701876379; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/MyM4IfQS+Dzj09XRcPbJN6APwuXnnue+rHLpk7D24A=;
        b=NaUuA/z8JUN8doWGcUvBfOd95lTiEbeXWapz80P909bXMxUYMUc/fJzaf3TnH4YLVC
         iVBx2W/hOtkgSPq4oyo4tMHbz9EOVNKbl2azsibB5/qcyLVu3wjjn13Ce2wB9udgVgaY
         2Zr8jB9wBJm7+/A6RhKG+JntbIOkyIJXoYuv+OV0AO+U6sRXGf2uNvg4H5w16JtZuNHt
         nFKi16GPR7+13wDHHqCD35YD/J/um9FCX4V1sKuIeCuPubSgOl/BrKKKUfIA8wQKf6pk
         C/fXwyrrWsTPjVNY/tko9nbT676w2A69hWs8Ab0eFAgM+KqmO9xQ/4chkNGOkVjSIaN+
         RfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701271579; x=1701876379;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/MyM4IfQS+Dzj09XRcPbJN6APwuXnnue+rHLpk7D24A=;
        b=EUBHWXUEEVdB6FA5qGTxMHEWoIu4U2OZH63gSD8vx5TiLOpumrmVsFH/Y711guUKFm
         drGvlAfxm4hct7Rh5XffdwDXFgx49VDcIAD/ReKd8A+dhJEAWGugO+TbpgsgiYMuBs+O
         McbVX4UjCEmpPhb6riGCM7/YYSSMJUeSomkf87KBCfCrouH6Cbl6cjcnAIdCPMylOip4
         UFwApihmijQlkDQHql2ZUbVsLl2qAocJRaASeNX0l1myNFnulroJtMSIFl5XZZfW5ckh
         krW5dIKEideLi5LnK/lFDZ4GOQ9tJRj1F6/XjJ8vvZef/ptVRU7maOvs99OgpCYultZf
         64ew==
X-Gm-Message-State: AOJu0YyXauAcQmBxOsuZDKDvLYGzT/XWGCQSAxN8BcsA8B4j1oEigH+e
	otpPEYSXP2lD6C/Yutk1WI7zaQ==
X-Google-Smtp-Source: AGHT+IFEzPTXAhffGcN6uSmni/T4wlbocmnSoSxuj2CbSVcyNNseiVePyIRac19jF7lpHUv5DmWk3Q==
X-Received: by 2002:a2e:9a14:0:b0:2c9:abae:d05e with SMTP id cy20-20020a2e9a14000000b002c9abaed05emr5621870ljb.13.1701271578787;
        Wed, 29 Nov 2023 07:26:18 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:38f1:13b7:9b7a:2d6b? ([2a05:6e02:1041:c10:38f1:13b7:9b7a:2d6b])
        by smtp.googlemail.com with ESMTPSA id g18-20020a5d5552000000b0032f7e832cabsm14788668wrw.90.2023.11.29.07.26.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 07:26:18 -0800 (PST)
Message-ID: <185c1c0e-c9f8-416b-8bcf-34070b1d8a37@linaro.org>
Date: Wed, 29 Nov 2023 16:26:17 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] thermal: trip: Drop a redundant check from
 thermal_zone_set_trip()
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
References: <12350772.O9o76ZdvQC@kreacher> <4897451.31r3eYUQgx@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <4897451.31r3eYUQgx@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29/11/2023 14:36, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> After recent changes in the thermal framework, a trip points array is
> required for registering a thermal zone that is not tripless, so the
> tz->trips pointer in thermal_zone_set_trip() is never NULL and the
> check involving it is redundant.  Drop that check.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


