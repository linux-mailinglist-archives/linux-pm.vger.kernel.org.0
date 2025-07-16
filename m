Return-Path: <linux-pm+bounces-30954-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F26B07F6B
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 23:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBD127AE98B
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 21:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E8A28AAFB;
	Wed, 16 Jul 2025 21:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vcyz9C/6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739A123817C
	for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2025 21:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752700748; cv=none; b=Ri/oiOk5Cp+QzT/o1d1sBuRZPcuPAaQh8pYonrYz3Ci9C7Ij91mK7i3INqybNO5kv3X+MaipRJBFP4zVdzi26qx7p8nTSv97C77TrjQNCXe0tWkx/zDA0S7/RKEdoIu9ULqVFUx6QcQB2Eug9o2JwZ0X5PZiF25xb2gABaahT2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752700748; c=relaxed/simple;
	bh=ZnwNzz+9PWC+5EpZJVzc8FVsoS5xjjXuK6o5yM/GmnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7wXdg9lzbHufQsXV17ECQeZbdqsqeKd7wMFoq6Kkum+Q8SYuWwAWxOs6QQkIax3wp0zn1ib2Ozt//K/lneQnCSUZL2j+fJxUs7+35AQXjoDniqRUemCBuS6Pk/XQnu7I9lQMFRcS2Z1ByBkoLxnZEpxTMFs+HzCmhYyFrU7d9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vcyz9C/6; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4561ca74829so3267195e9.0
        for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2025 14:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752700744; x=1753305544; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gRKMCti2Ai/CuBdEyVpIY2yewXiU7F1sYeoCE/NOUlg=;
        b=vcyz9C/6W67eXML8/PbBQ1lbAZnoTHg2D8W7ja3ve2Gq2iptyKkCNce2CyQCIwILkm
         n/0UvayEUlSVkeR2p4Qc3o9EdtDBSTI2EPtBGfuR3jAzfB1s8/uCaWmkV//1WftrO/Xi
         wc8QfXrq3YOMf+iOgAie7O9yx8ERf8OLf7sEvYl/XuG6WupRn4vvXwDNjdvUwcmZIiAf
         y+CVgbJ+a/ZJFRbjxJzJzEZQROLhZp5HJ2I+197x/Y+kAkS9lM6LSxm2QIZMgYPDOaUM
         ++9/XwfCmEONTBrNltDXe/H5AbramJX+7CDVQII6SViW1vRJLl6xJ8owTjZsqM7y67F0
         ICug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752700744; x=1753305544;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gRKMCti2Ai/CuBdEyVpIY2yewXiU7F1sYeoCE/NOUlg=;
        b=nfZcvABsJge8sIJPukYFTaURjR4/ZllQe6fz7cO8aUxJg/VujeMklOG1eDSWSpXBv4
         7zHjZ3evI84JsABJ2dlbkEjjX3DjkgZQ9UmTxMJFet+0wIeYjHb3Qt8mxbPOnLvEvShO
         5T24mmjRE32uBSHK3oTwYR2oa2jIUQ0V6UxyWdZ0Uo9/3qCFwDKMJ5EIWLTqS+zszhXc
         ITubCvv+l/jQk74JckTUwlofaszq4/Wbg2iCqDmbEcWoYEH87VlW+YDgGFGFyjtYdzhE
         6zd+TM2rF0LvH135jhQY5HbYaGE+T1KJwDOZ50pkjA4dvxu7uodiQsDQKaokI9tJo9f5
         Sj/g==
X-Forwarded-Encrypted: i=1; AJvYcCXqjW4XeRodmmb6qaDOt1AbU7WMAT5W2DW0yfH1zsLhgfkdwXQVSiR67JGTB31Vj9UeA4QFOK6iBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1/Xaj/NbCnIxzwRE/HVi+UVNB0pb3xDQrW+CITYIDCeJZ8xqg
	M0Mw/PFuTNNwWoM+QCvtENlaXQ9+dHeHoZ6xPh6j8THZn95US6PmzGBmPYv6A2wF4Ak=
X-Gm-Gg: ASbGnctQVBjIKgGODOVVU1poIsqxfQEPYT7u0wsrU5HDZLLeYOAU48dy+Dw4djm6BO3
	vuTLTNOFONfNlrlpg2UhYBZZnJkMJMJn6qWmdBPR7P33fhoWnDYLfzfPgdZ4TFPbMKmEqOeZeET
	QWFcCdOqvMJx5nu4Xl4UVIvUamgpnJaw2IBUudl0AXoIsWim4Pe5e7/Z0kOeVhzEAYnhDtyVjGF
	YfU7lqXik5DvXRdCX6AYDtXlcZMlAuNkDRe95+hlqnjABnK4iRvUqp/eFUlczucWh8V+Jq10zFO
	mk/I7ZE4CrIZ7FEEuuAh4efSIFCYNlkEzw8HcYbG0PN+R2TrfNfEoRqtB9ArMd2gx+M6pBDBT+P
	vqBPOhQ4hSCMBTNp/sBjSKd/UThxzg0bqHns1cZLneEFNEFveMrKQ4sraaioT
X-Google-Smtp-Source: AGHT+IGU+ypDAJJxAGg8IJL70QMGqBYPckZVXPJfzPAtYPsw777vZbMiHPPbbkBp+5WtNr4iOtNXRw==
X-Received: by 2002:a05:600c:6097:b0:456:302:6dc3 with SMTP id 5b1f17b1804b1-4562e3c4b98mr33569505e9.26.1752700743650;
        Wed, 16 Jul 2025 14:19:03 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e7f4294sm31833045e9.3.2025.07.16.14.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 14:19:03 -0700 (PDT)
Date: Wed, 16 Jul 2025 23:19:01 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Mason Chang <mason-cw.chang@mediatek.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	Julien Panis <jpanis@baylibre.com>,
	Nicolas Pitre <npitre@baylibre.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Chen-Yu Tsai <wenst@chromium.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Frank Wunderlich <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>,
	Steven Liu <steven.liu@mediatek.com>,
	Sam Shih <sam.shih@mediatek.com>
Subject: Re: [PATCH 0/3] thermal/drivers/mediatek/lvts_thermal: add mt7988
 lvts commands
Message-ID: <aHgXRcyEWreMC_P-@mai.linaro.org>
References: <20250526102659.30225-1-mason-cw.chang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250526102659.30225-1-mason-cw.chang@mediatek.com>

On Mon, May 26, 2025 at 06:26:56PM +0800, Mason Chang wrote:
> Add the LVTS commands for Mediatek Filogic 880/MT7988.
> 
> This series fixes severely abnormal and inaccurate LVTS temperature
> readings when using the default commands.
> 
> Signed-off-by: Mason Chang <mason-cw.chang@mediatek.com>
> 
> Mason Chang (3):
>   thermal/drivers/mediatek/lvts_thermal: change lvts commands array to
>     static const
>   thermal/drivers/mediatek/lvts_thermal: add lvts commands and their
>     sizes to driver data
>   thermal/drivers/mediatek/lvts_thermal: add mt7988 lvts commands
> 
>  drivers/thermal/mediatek/lvts_thermal.c | 74 ++++++++++++++++++++-----
>  1 file changed, 61 insertions(+), 13 deletions(-)

Changes applied, thanks

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

