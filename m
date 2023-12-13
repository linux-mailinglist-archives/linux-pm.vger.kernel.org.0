Return-Path: <linux-pm+bounces-1049-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B14810E58
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 11:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D669B20C2D
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 10:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F378224E8;
	Wed, 13 Dec 2023 10:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eEP5dEaB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601FA10D
	for <linux-pm@vger.kernel.org>; Wed, 13 Dec 2023 02:25:02 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40c2c5a8150so61885475e9.2
        for <linux-pm@vger.kernel.org>; Wed, 13 Dec 2023 02:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702463101; x=1703067901; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vQqqojXk0aiAP1brw8pMue6niPDLmrRewlYFgt6/ims=;
        b=eEP5dEaBOMN2t1V4TGiy6aVU0QBoe4XbEVcCLvwsnjVAAyWGN2mraUrat8mA7hrp5e
         VE2AmKgmP9K3agSLqVxTAyCB+QYfRYZ1zXLX33BpJJbJSiGgx5/qLRIjoMDCQMaW8SvS
         idlRbpgAtVOWhHgIyud001jw7ILz9ioEraOyQq8DYnhbM6zbUJJqvsfZgh2YyRZkW8bq
         XIvDKRUuXqR/+x7VwJrMsJIQJVQJgGLAc0DLk55HF6zca9xm3PnZE9UVDBZe9hXIT1+1
         s5k/k3FVWWWkEFnFSk/eF6IitkKKm/OJh5BaNnNWLtTdBrKBOxUGhoW7ykFl3lpestzC
         ldKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702463101; x=1703067901;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vQqqojXk0aiAP1brw8pMue6niPDLmrRewlYFgt6/ims=;
        b=ctOgpInnlUoQXwKjgXiQDO0HUxDtt2/qorYuuK+jeZgqq/g96R0x2P+cBSyRUg8IbF
         LNJZAFZDuqcbG425m6kBJnMxEcTnNh7s2m61MWEkZvFyDVZNZdwUZvmASHOQz/sFrQyD
         8xfkpaC3zYCjRScir0rOCO1fcPWNXzfc9+44nv3YXCWQTx7uUEgudAzsFUGtEtq+ACRn
         oGd57L1/1fOcRbuRK1fn50XfKgbRlZ/mTmkflyJQTuzSoFzTt/uyA2gn8w/rdmd5LISm
         23iFQaOkw+Sg80Zz01QUwDKnbaTEUJokjbhrLfap1kSU5WbD5mveXq2HMYFqFzVTWAP/
         PJfw==
X-Gm-Message-State: AOJu0YxKJKHBUWvbkYSNUSpILrK/njrN6OSubwwp3JMVq2MpxV7y5f45
	bEhjM7hAB8S5MhKGLSGP90fC/w==
X-Google-Smtp-Source: AGHT+IEPzbfJzr/BdclUpmYaPORvN85dIh7O66b3k4tt6I6WAd5SgTDBZuw+u0Hebr28LeFqG/jd/g==
X-Received: by 2002:a05:600c:2296:b0:40c:2b13:95ee with SMTP id 22-20020a05600c229600b0040c2b1395eemr3692466wmf.38.1702463100644;
        Wed, 13 Dec 2023 02:25:00 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id w7-20020a05600c474700b0040c41846919sm13705500wmo.41.2023.12.13.02.25.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 02:25:00 -0800 (PST)
Message-ID: <3312c21e-72a3-43ef-99a5-2f429ed21083@linaro.org>
Date: Wed, 13 Dec 2023 11:25:00 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] thermal: netlink: Use for_each_trip() in
 thermal_genl_cmd_tz_get_trip()
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lukasz Luba <lukasz.luba@arm.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
References: <5733564.DvuYhMxLoT@kreacher> <2912793.e9J7NaK4W3@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2912793.e9J7NaK4W3@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/12/2023 20:49, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make thermal_genl_cmd_tz_get_trip() use for_each_trip() instead of an open-
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


