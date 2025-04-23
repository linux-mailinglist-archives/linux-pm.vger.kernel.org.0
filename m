Return-Path: <linux-pm+bounces-26007-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB92A980BE
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 09:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11CFC1890A39
	for <lists+linux-pm@lfdr.de>; Wed, 23 Apr 2025 07:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BF026983E;
	Wed, 23 Apr 2025 07:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WJsYG4G5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037D6268FDA
	for <linux-pm@vger.kernel.org>; Wed, 23 Apr 2025 07:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745393222; cv=none; b=NL8PfbZ0ES+t3aoFzyvKGWC4HLDoK9VQb6ExvmhLptoR5S0XIUNUnnxSlUHhJvmyZsiSXf/9YuDz91AVgxcjNNAw9npfyh4Kfb5WWLGkUQKseTV96BOndWZgDD1BWnIuDbg07Ll1ddUbctypq//oIXxoM1W7P+xFWimi2b9G9nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745393222; c=relaxed/simple;
	bh=Jrbw0OKpQbJ1dFid4p4N4XtPsI8/qSLnEpsHW9bCCKg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=brIDoFNDZisqK835Zu37v7pW/pjI1GES6ZsgMeZ4WW7xw1YcgtWtgVlRyl+exyHqrdZOXSTmf1YQOzAils0FB3yCkX9NG0cmfsJ2qguGLrMrZqDOJdlNIWOPh+WRkFUVMltjanOrSgcN5VbtCI6+UPAwtSL0JfWbhrwOkz1GekA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WJsYG4G5; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43ed8d32a95so52500855e9.3
        for <linux-pm@vger.kernel.org>; Wed, 23 Apr 2025 00:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745393218; x=1745998018; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kn/kdeC0hIJ6fPjKrtocu5NnRgujubxfAbJ5Urbgh9w=;
        b=WJsYG4G5Le7NxcMduHBEdH1Cuadj5L7FAZjqaEd5mYiMF/Qi6ppXkTUuDDk22WovVY
         O7B5DQAXeTfnr8i6cS+KbgmElCDTMFYIy2ECwPXpJaB3JeoMNYQZ/2ll4krvLhDrl0ry
         XWWTUjEF+7PJnsDC+7ryWRsgboKsQww8oCHwjnyrsKXY0gIeOF3zFgeZ4kyZGKIkcSA/
         8PxE1bS7/EyDFy8xpBfc+BpcJI9Cro2kEeAw/dG8GeFSA4Ky0taUyAn5Rs/tCD4hcZAp
         J/CUYtr3Rlwo+y9zOka/9al+MhVV66wL+2jOPfBCVsxlMCkn7Y45wIQSBrCGS1BpJrx8
         qsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745393218; x=1745998018;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kn/kdeC0hIJ6fPjKrtocu5NnRgujubxfAbJ5Urbgh9w=;
        b=fKDjm4hGk3TeisKyMB6tWROkpd4ZQ92Isd6z4gSj/0wfIFNu867jO0x69H/U3XTckM
         bXrY+oXvfMLOVdhCC/GoDFqhzXZoEjU90r7RmzF3qauCcGM/r7wXlPvbUHAjOenX1zxY
         v43gQC+jiThBKr/qRWbQUoV0RQyfNiJfID+/JZYtaWGK2cP5FE2Qbgs8d6jUbLHCJIZq
         cr/75SWhOszlh31ielg+lyxGDwGUJ23gHbppAkx+NPCxkO+n+uKBe1OUNQK4l9cz7sC7
         FCxzWGKvexnMyF3qa/TQhprhCpqJshUbXKfF5OcCDOBt0skCIheZix0G5qFu7SgkNbmM
         NiQA==
X-Forwarded-Encrypted: i=1; AJvYcCVXPjDeNcswzOXakgWAc5zFGlx/GPl7daMLTnN+JIGGYd+uQ0MDPTIUoqB9WsqgyEtkvoH2Rv/vSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5E1gj0aDaEVC9rpE4XZJLl8Lifr1B4CPlFOxro2kS2TCH8zJQ
	s0weBQt7LeSLQleygmwR14yuYeExWoA3rPtj/lc1M9H4m9+1A9ors84s6RHkTYU=
X-Gm-Gg: ASbGnct3uKPh3z+DGLUlqBpEaP76mRfAKbCAfXTFhweZxWdjQ8sRHsbXrElsj0ST9XR
	UgNdz4/VaPK0wuUpnu9N4ERfvtd+Bv/Rw69dk1Kj6e9dE8GALGnUpN8IR0JY7YXvcFyJl6Nk0xn
	d40rQdFJ97LhIoVgWJYiIbtmuUE3p9DTdMQxEfatXCY0SMDSOSjZUtAFh/NncTlApuiDZeCEZRk
	7TcprABXDkIzVVg6yJWBNw944XGv2KJCgutKBWjoz847avqTzN/iOwZRrsTMDg3Xi5ROPtMAdfr
	u+kbccnfOc4QThC/MWecOuGdlYaKT7fosUZSgdyRxs2YepGxjHButIWyNREiqBhxXSgBfmKX/0u
	DIVoPyyhalzD/6DlJyQ==
X-Google-Smtp-Source: AGHT+IGQjZAyp9xHW8ASlQKrR9fCiGMeMbCakgAb3SkKNca/+Rt6CnnTlRW63K73V1hHmlOCRLIMvA==
X-Received: by 2002:a05:600c:1c8f:b0:43c:fe5e:f040 with SMTP id 5b1f17b1804b1-4406abffc5emr134620725e9.23.1745393218300;
        Wed, 23 Apr 2025 00:26:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:2835:c2f4:c226:77dd? ([2a01:e0a:3d9:2080:2835:c2f4:c226:77dd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-44092db2bd5sm15015645e9.26.2025.04.23.00.26.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 00:26:57 -0700 (PDT)
Message-ID: <283096ad-ae1b-42b8-8312-b192f735fc80@linaro.org>
Date: Wed, 23 Apr 2025 09:26:56 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 00/33] Add support for Qualcomm Snapdragon SM7150 SoC and
 Google Pixel 4a
To: Jens Reidel <adrian@mainlining.org>, Danila Tikhonov <danila@jiaxyga.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-watchdog@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-mmc@vger.kernel.org,
 netdev@vger.kernel.org, linux-scsi@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-remoteproc@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-hardening@vger.kernel.org, linux@mainlining.org,
 ~postmarketos/upstreaming@lists.sr.ht, Connor Mitchell <c.dog29@hotmail.com>
References: <20250422-sm7150-upstream-v1-0-bf9a9081631d@jiaxyga.com>
 <2ca2b774-fd7f-4612-b38d-f60e32ff6f9a@mainlining.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <2ca2b774-fd7f-4612-b38d-f60e32ff6f9a@mainlining.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 23/04/2025 00:07, Jens Reidel wrote:
> Hi everyone,
> 
> apologies for the mess this created. Danila's mail provider ratelimited him halfway through sending the series and the attempt to re-try sending the second half an hour later ended up with a new message ID (I think due to not using --in-reply-to).
> He asked me to let you know that this will be resolved later and the whole series will be re-sent once the problems are resolved.

The b4 web submission is a great alternative when the mail provider is rate limited:
https://b4.docs.kernel.org/en/latest/contributor/send.html#web-endpoint

Neil

> 
> Best regards,
> Jens


