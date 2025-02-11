Return-Path: <linux-pm+bounces-21785-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BE8A3054D
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 09:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D91BB1886456
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2025 08:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2081EE01A;
	Tue, 11 Feb 2025 08:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HHFYOwOW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D051EE7B9
	for <linux-pm@vger.kernel.org>; Tue, 11 Feb 2025 08:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739261437; cv=none; b=BS4Fhsj2wW5vLo6XdB7tmMbIVd7UUc4qphVB65WnbTICy4h6XmqTD1pLZIF2ai19arX4Y7nu79P6HXyMGsCFpxLJBobMRqR8GbvGIWUSTxn/XPbblN4tnx8C2RNRGaMJlQg6vNtX8A9pFshblHMMX1mKpPQsw2+7NVIp7W5kux4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739261437; c=relaxed/simple;
	bh=ymJbeUbw4hGpBCPEcJ+PlTo7IzTTXMUzLHzPuWmSnyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CnYFy6kfeY1jRjwHZ0RYSjRW1jNfh+9BIyMHOoo0Z8ESn9YTXukd29/gONNHZAhamOzYGZo5A4iQ+6bSr8u2UpO2qyhXhEXcU0oR5Md4J5HsYS/rG56HLnRfk+XE7YELjYrnW333YJr7qbT8WL5Gt3cOoxl56ZIdfZf0SkvM15U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HHFYOwOW; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43955067383so1408335e9.0
        for <linux-pm@vger.kernel.org>; Tue, 11 Feb 2025 00:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739261434; x=1739866234; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=78daTuQVz0FgeVjUA2ayAuQ5v2be1XKpu60xXrbYshs=;
        b=HHFYOwOWX8739IgeT2ifq2wHr+ovgtGupJPU78Eoj+f9vteJyW+/C8lIre+rVNs28U
         JX5xomrXzQG9ejcs3A4Ppd7un/FPt/CfP8QlFa5utrqlEvqRD5rQZlvzshLlMND1fhjd
         sr2euDjaLw21jm2m5ZwKuQ+5IZybqnIfzzM4CDqd3J9tBDG7x/mDL/pzMXmrikjVLgJ/
         CXf8upwDetrF5zOfxZN744A7vAF2ima0rrmED6tF+umqWAJW64RsI7PSqJvf7fibib2m
         jKKqXSxxKy95EpDyP+MVC3a/gpZGytjg6aq9tK+SLEOrLZKJPsbjjz9ggDA8G0MLrEu9
         lHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739261434; x=1739866234;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=78daTuQVz0FgeVjUA2ayAuQ5v2be1XKpu60xXrbYshs=;
        b=ZnY2O+YQ+V+1C9LFuDKAWIY0CNPe/S1xtai0EJynzUnUVG4CxDP57CioqDZePJ8Bid
         +p9JtxtOMEDjMBnmbpKrcNqldo7cSpNIQoIl4xu9BR43idDQ1Mnr9UVTIPZtxaUyCHkX
         2e61l0ZCchTc8xNkOEYCnPj5BtlEio1MjYLciacWHfx19Oo8pg3ipPtWLM85jDbnJ6I7
         H4oVCQgFNTILwhFh1XlvmE6dDEEfHhIrcdkZUQiwfiIvZV8NIBV4UMeLwacRonk+f+Bo
         RK1HqslOBl+15qJp2tVvJIRwAcTjKT/SlUPHA0f5DhS6WkR8vYvUKOLwEizsgAa05z9y
         sBcg==
X-Gm-Message-State: AOJu0YzXLYsvnDtu0CSJxfxmlQyZkit6uIEM6H6tmXPRbqDquk4iW3Vr
	GHW6jW48uBP499R0isDXpfX2atrw8vd+Vf35XOWOzsNdv4gHNzf9sHJcl+K3qDA=
X-Gm-Gg: ASbGncsk0Ayh1jfIuYKvJkLWdSeXnMmEsnAOmJ/GOvWPIC7fc1mckiAwYXnizZhOlOp
	8Jkx+psyLFwoS6zAOBXIA44YmEIOexDodpzzNnXIDoJAaJglRLw7QYT7ruD10wbXFq5czRRKO5s
	XaBel/khvvBpzKvZBOv9diQfTD7V6ZsS6tZpehK5Gs8BFFglDpKfWYZM8/RXGxJDKFZ9UuYp5G1
	IwCPQR/NckKbW3u0x7yNSihN12sYq7RMzptKQpZlydu9VT5VjK9xdKjKmMLKO2pQSoZzQgFF0uP
	VhxZqEOV2rQLto/F2s6+o/cd99F38TXrBeDm0UM/Gl3lAv9nQAbNzYQ=
X-Google-Smtp-Source: AGHT+IGLXEpFIAWJT7WvqNnDlD3lK/vfQpTxfAdtyharhsIDVFsFgpEKPN9BMWXc0m9HymMjl+wP1A==
X-Received: by 2002:a05:600c:4e8b:b0:436:1b08:4c78 with SMTP id 5b1f17b1804b1-4394c8693d0mr27743475e9.31.1739261434474;
        Tue, 11 Feb 2025 00:10:34 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4390db10b2fsm201248275e9.33.2025.02.11.00.10.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 00:10:33 -0800 (PST)
Message-ID: <eab96d3a-4daa-472d-a7c6-50b28b7afeeb@linaro.org>
Date: Tue, 11 Feb 2025 09:10:31 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: core: Remove duplicate struct declaration
To: xueqin Luo <luoxueqin@kylinos.cn>, rafael@kernel.org,
 rui.zhang@intel.com, lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250206081436.51785-1-luoxueqin@kylinos.cn>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250206081436.51785-1-luoxueqin@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/02/2025 09:14, xueqin Luo wrote:
> The struct thermal_zone_device is already declared on line 32, so the
> duplicate declaration has been removed.
> 
> Fixes: b1ae92dcfa8e ("thermal: core: Make struct thermal_zone_device definition internal")
> Signed-off-by: xueqin Luo <luoxueqin@kylinos.cn>
> ---

Applied, thanks for the fix !

   -- D.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

