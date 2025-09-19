Return-Path: <linux-pm+bounces-35051-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5C3B8A728
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 17:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C4763BE96B
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 15:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC81C31E89C;
	Fri, 19 Sep 2025 15:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zJN5yQZM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7762F270553
	for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758297354; cv=none; b=cG0WWVvKdTczjgnGhdOxkq9Q8zZvvgVJ6ntID+jBbf8AzViXq2AO5ShpWDGPidgX2LlS+1S7BWfchL1gN7NioIwp+U7WyclIjuDeMCmKRfpOVbu1EF+cJI8pe0HFqSXU5Ch4OdSUy+JPmkXBBt7xypKMs/pRONW9mA2a7ZN7an8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758297354; c=relaxed/simple;
	bh=u1c6nCIa+ln/6nkb438PUoWQZcIf7juEYcKr7Yqz1hI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gDTcL1Mp1pfZP1LENFFmM1RGqjlJfYOtOcvpCUQYim12f05bHPLLK4sEulkmVfSqCjhejZtyxwJRHLFwgAbLYz4FavZbeezB/1o6eJkSVgHhKeQAXD0hCxrHDhtat3tVycf6cFcc8FyZlezKqsbJ731YZtiYKlv0MuWfL3mnR4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zJN5yQZM; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45dde353b47so12362925e9.3
        for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 08:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758297350; x=1758902150; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BhZDrVrImTATkIwPwVSPaOLUpr64DrnZU8w+ycyCg88=;
        b=zJN5yQZMN2vC0/I+GKAMjxFTyF9oRfEZY5BX4wwP6x/wl9P0/rMB0VLRob6goZuNRK
         lNigmVhAHjWVaIhGY1y1YAOV7Cdj6BPcvUgIVhphjNqK3eGBB6e3+JiR9v29hZ8KXdIE
         Ngjq7d2AhUtA1y+KBvDGQH8CEme4uJN5bbP1l4ppDariOEMIJUn9yuuewvHw2g7Cr7Bk
         RUDRvd2guWK5VjRq1fK9nGq3FmAaa/DONYWGKDHzG2zxJuQJ5c/szQV/leYVFHic7zVN
         UbSHNlc4qADnHxLxUfgL/Dl/iOvdJucWfaJVbOLpWmiQRiZe8GBXSUQme4O2Q3TGP0Pj
         u/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758297350; x=1758902150;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BhZDrVrImTATkIwPwVSPaOLUpr64DrnZU8w+ycyCg88=;
        b=uaaS8HO/nr4VY2PRQLjenxVQJt1Fm12gbW8aeBZr2wNDPzsNxIIBgD/7OYYMjhHn0E
         /71WIUzRfATqd7NqwMKTeutJEstdLcWqcBoJt/q0cWeuE83TNuE/xdV2ehncKGtctQWQ
         V8jvSiDlWLW+Y/7bzPkwQn6HgAAsCNdgvVro26QV/Grilem5ZbweuaeW4vJxwH0FoON6
         3fwiuUSEOlDxb+UgN8FXpGcyazVUjIKsAFUCWRgPFs7+Y5+fg1sxYXaVkM5h6Me8nhmX
         iFNbX/s31+670wmG1rn+Kg1WTjrIvmocMkxiCUIBDXzMuISF0QlX2Oz02LCybYF3pjql
         A9jA==
X-Forwarded-Encrypted: i=1; AJvYcCX5xaorkOPFFFDRm7DEAxkXKLBB0BYacEYrIJOy2g3yXc5NoJprXbRCEJxw8QXtF8jkj8o3TZcehQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHltBW8q5wtDuyOs6Ne4yLV1zPXrUVhv3e8xHExpfDm6//pJ2I
	6UQdUqqJQaOlVO3e/TeZCvT+3mKYJmRTGCqVS6sE9RSFq0yRrDEopNUoDaoHADeDDMU=
X-Gm-Gg: ASbGncvS8DnPjmngXblgo+v5SHJzKvM0hQwABhXgetm9tXifur8uNNseRaAXPplBPiK
	sB+Rdiz6wR/2niuZaW9ofnmUQeJe3eFZKcWr3fYVF3wnS3h88kr5pmUBqYgzhK8zfeAyAdPVrS6
	NENuk/Uzs/YlMy4gGwmG28RbCmOwvZ7wwhAe8I6FzP9ZpwpsrJt9Gq54291O2Sdskc334SCKMmC
	ShoHXYdMT4nv683Ntwohxxq9SSv0J31vzlYD92Lq4DthZpunZrSwpicXGVBmKKedM78A+tgbnsk
	r9lJYND9tyvAMs0SKPG/msTvB9q4cd8gSXOBlmCN+V4aP9oYWe9YuTXgDFlo94uILD+uVwYQ8PT
	XlU8tAZ2A+pgH/LmGjJeVxCCSRlp1RCC1cu1PMPiuMxPL6lV/vPxV1SqnC4P0czWv5gOnEj5Xjg
	LXfA==
X-Google-Smtp-Source: AGHT+IEl+5i/c6BvX7hOfCLASA8xl2fHCvuhOjlzavUKXNsTQAa1+nFKeMdI1YW8d1Qlc7m1YSon4A==
X-Received: by 2002:a05:600c:548e:b0:456:18cf:66b5 with SMTP id 5b1f17b1804b1-467f205a5a1mr35666935e9.22.1758297349484;
        Fri, 19 Sep 2025 08:55:49 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:8ffd:205a:6719:49c1? ([2a05:6e02:1041:c10:8ffd:205a:6719:49c1])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3ee07411f4dsm8371825f8f.26.2025.09.19.08.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 08:55:48 -0700 (PDT)
Message-ID: <20f38803-ea03-49e5-ada1-9998eb815f84@linaro.org>
Date: Fri, 19 Sep 2025 17:55:48 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] thermal: rockchip: shut up GRF warning
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Heiko Stuebner <heiko@sntech.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
 Diederik de Haas <didi.debian@cknow.org>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 kernel@collabora.com
References: <20250820-thermal-rockchip-grf-warning-v2-0-c7e2d35017b8@kernel.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250820-thermal-rockchip-grf-warning-v2-0-c7e2d35017b8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20/08/2025 19:40, Sebastian Reichel wrote:
> Changes in v2:
> - Link to v1: https://lore.kernel.org/r/20250818-thermal-rockchip-grf-warning-v1-1-134152c97097@kernel.org
> - Add patch droping extra newlines in older chip info structures (Heiko)
> - Add patch updating DT bindings to make GRF either mandatory or unallowed (Heiko, Robin)
> - Update previous patch to only differntiate between mandatory and no GRF (Heiko, Robin)
> - Update struct documentation (kernel test robot)
> - Do not collect Tested-by from Diederik, as too much changed in this version
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---

Applied, patch 1,2

Thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

