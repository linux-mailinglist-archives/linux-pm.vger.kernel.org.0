Return-Path: <linux-pm+bounces-748-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E792A806E19
	for <lists+linux-pm@lfdr.de>; Wed,  6 Dec 2023 12:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D55A1F215D9
	for <lists+linux-pm@lfdr.de>; Wed,  6 Dec 2023 11:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA9A321AD;
	Wed,  6 Dec 2023 11:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qTEqmaQl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4E1DE
	for <linux-pm@vger.kernel.org>; Wed,  6 Dec 2023 03:35:33 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-33338c67d20so628073f8f.0
        for <linux-pm@vger.kernel.org>; Wed, 06 Dec 2023 03:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701862532; x=1702467332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YFi3RIKaDzGCbVA6KICHAZ/fzez2DnzNL78+4AOaMUg=;
        b=qTEqmaQl4jQyV1WEhUon5myflgy8sP2JOUSQ6KuBtPZkZ+M5SRZLG1dAkN+1RI8M3a
         rNn1R9eB53QSvSYt5eG/ESGyOTDkGs4UyWf88zocXArcpjjgDLx+PvqMkRHParzXLOSf
         ECDF3iPULQvsthKH9zsAzHSHRtrhVWQKm2KLIRPEi56K8d1idqS7SpRIp5F8Qz4rJNOS
         stFERw5W/XfGslakE7wblcBg5CO22HNgh3N/EKBYvJ905hJ/rBTOO7vPf3EdckG9LfWM
         3Qjgx/MtZq05kFBNPJU9KaHnflTue0JZpQHK79VOTsK49qWYf919vjBRQCoAOv0aQaBf
         d4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701862532; x=1702467332;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YFi3RIKaDzGCbVA6KICHAZ/fzez2DnzNL78+4AOaMUg=;
        b=aPO/k/KUt49Me9f0tP2oDEShGRJ4e0QuoEU1F89MCY4MZaoRcGUqYF0erwfMNOetEU
         fep2X+MRMYaGT78SPSvM9pkQKbMczav2YABaqpLPWJTXIun7VoPQ4tXEpbTMU+JuNj5V
         6KfAH5CsUAUJt/TIviTHwsNZ72KXWmCPJW+SXVrJFIm8cgNqLRnKXtVK210Rti4BXpqA
         OSD8ybFD3O9DmTG45s7CnE6rRcSFGVDrNriKzDPLyEcg0/rTB6z2sYuXXjUDYersgjwN
         /SLBErh7H+EGLl85maE8IqXKq2LPaTL5gXq+LXBXrW+t3q1VzY3q5vy9fGu5cJ7k2u76
         sgWQ==
X-Gm-Message-State: AOJu0Yx84A7F8V+RCQNGbFBL8G1UfE8XqE+m9I0qj4KTl+QAycGcZlqA
	EM0sl4yvAvpYeh1zVO31Fx2x8A==
X-Google-Smtp-Source: AGHT+IG1WDr950Oeo2ODHgV1WggcJ9DJetRbXRF39Itxtkz7EB5G09m3ExKEKMIjKUuFuvii6q+nHw==
X-Received: by 2002:adf:f686:0:b0:333:5446:922a with SMTP id v6-20020adff686000000b003335446922amr432257wrp.32.1701862531641;
        Wed, 06 Dec 2023 03:35:31 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id q18-20020a05600000d200b003334041c3edsm9983744wrx.41.2023.12.06.03.35.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 03:35:31 -0800 (PST)
Message-ID: <54af71bb-60e8-4f9c-84d5-0d741e6964c8@linaro.org>
Date: Wed, 6 Dec 2023 12:35:30 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] thermal: sysfs: Rework the reading of trip point
 attributes
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lukasz Luba <lukasz.luba@arm.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
References: <12337662.O9o76ZdvQC@kreacher> <4854305.GXAFRqVoOG@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <4854305.GXAFRqVoOG@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/12/2023 13:26, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Rework the _show() callback functions for the trip point temperature,
> hysteresis and type attributes to avoid copying the values of struct
> thermal_trip fields that they do not use and make them carry out the
> same validation checks as the corresponding _store() callback functions.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v3 -> v4: Don't check trip_id against boundaries in the _show routines
>            for trip type, temperature and hysteresis (Daniel).
> 
> v2 -> v3: Drop a redundant 'ret' check at the end of trip_point_hyst_show.
> 
> v1 -> v2: Do not drop thermal zone locking from the _store() callback functions.
> 
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


