Return-Path: <linux-pm+bounces-24442-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33518A6D3E0
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 06:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC93C188A2CD
	for <lists+linux-pm@lfdr.de>; Mon, 24 Mar 2025 05:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200DC10A3E;
	Mon, 24 Mar 2025 05:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iHycOaRX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909083C17
	for <linux-pm@vger.kernel.org>; Mon, 24 Mar 2025 05:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742795300; cv=none; b=XfquSmBfWJ42FZxi4zdP0kbk5E89srPXtfwyzFvkLyGpl3+6Ee5N2FBmD0iFyKKXOXXXJkt4O2wx/7IXDRMyazrem0bcYivrno004jkzgR0zznWl5sC84qmxAse3khQmadNzZ6N1lBrjWdQdg2LCoIje+O45PZn4sKwsJaIIMK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742795300; c=relaxed/simple;
	bh=hFzwVsvlTm6FzsGdNshq6DKl0QckI85JLKWYGluazmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hM7WljZ5bkoO+SO2n8/3aEIuQzuHMTOZFJRMcFY/JFhovc9FN7ewljlXjYqDI6+MjFVzm0mJkWM+cMOKsEOV0fNudekP8yYBSIkgmDPi9ke54doug8ezKrxuA7mErg8EqK1xQYcJ9ef87qKAAJYCnD1Njju8mRikD8WEoyJVOfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iHycOaRX; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-224191d92e4so72281605ad.3
        for <linux-pm@vger.kernel.org>; Sun, 23 Mar 2025 22:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742795297; x=1743400097; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/R5x+1WOSlr2ATn0vFw3CXpQGRrxOjJ4eIn39P6K6yc=;
        b=iHycOaRXVSPS6yb6dEnf8W+4Q2WsAdhBQ1hpvlPa66apUY1Cuer/vKlWnnA6o2WZoT
         Uj/FI2HxeO+UnG9zHWSeLELuILRARVeXysqWha6+l3lQ4LsK3h7qnFz6ZxH7aP9DNRzx
         l8dOc9zbP+5MlASmu2XIC5FHv8xAMdq3NGHsnFwYMTiO86/gJfpmGkb3Ty/rQL2Pk13g
         7/YwgFdZ+f2BxNRgKRfW2/akKT6KOAJkg8Mcto0D5GnPSgHNGPwew0JkdIIXC36ItNke
         Szjw/Ku3NCMjbwbYX+tsuUYlSjnwW5t6fjzZz+ChfJd/wTP65DI/yGqjE3XCaWIR3hHA
         ucPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742795297; x=1743400097;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/R5x+1WOSlr2ATn0vFw3CXpQGRrxOjJ4eIn39P6K6yc=;
        b=u+PNyUGWnhB8CH51Oo6lMWZ3DUPtMUzIzDk9I+2HYgsaOW9jRxS+vf7MsQPEfMhaSa
         AaFDcAR8WxllcErDxQdxV7/noO4CJtgS/rAJasgc7zDd0MV4XXrMxnQ+R4jYtFF9XW8Y
         X0k1+O7HvGfcTNVrrvr39/0UdBba2YLOR/HwvsK9J76zcAO0TuuPYlBELW3LMksCYj+4
         hfJbtCFnE6oLxYrd/PbyU9YW0p3iS2vHe6exBDCcl069rJ7pt9NY0TXbl3CCXwMQ4+tl
         en7D8AxURQBn6FdLd+ao+aTDbMKRO07v/yvrpdMR/jdTtCp4dn0srD5L2iaKLQFFsW2v
         gfGg==
X-Forwarded-Encrypted: i=1; AJvYcCVePWDxKT9p76NEqQNPsSA6YoJQLCDnA7PBCQOph7BX0Aqw0kdTS+oYK+PRBSsz/P60iv26ogszTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr3FU6HzxYe+W8XSj9NYJTD2AA9Qpzklzg0VIo4ZRAh1HZs8vh
	emAx8hJaBqX8sDp5dFT9md5B1HV7rZGG6r9cedngg0IYTGggBPjCKhK2gtSxGwU=
X-Gm-Gg: ASbGncsP250Rh0jQBczxA9uVQUj2mYqOaFN8ul26bF2C5Y/dlpKVMGw34Ajr+A1H/zm
	SnB+gPySH0kuJYZ1+LT/mlpmPbeRhTTQNA8a0S62tioUlsk1ph2YkNLNOoiqSkSy/FztIJmA3rS
	gQ/JEve0OCGUXXK5qemS8A8xfGzAFpVIZndupbQiePTJtkVIAVBLYuVM8qzm2ONawv+4tcoh+4B
	LlaGQCN35urW2Oi4A4WULHJAjXnGpUXbTk0z+rjmhTYQU8XlXe0mxiD9GvZN47ry3Zy1p66eFWl
	9eNv2m/UJrdHDWAvly61usOzk+2B0doMstIA9dmcxW4ILQ==
X-Google-Smtp-Source: AGHT+IEjzOfTYFKH7m9L7KhblERHs6U5SD2x2kJlkL36nq/EuBvZ3tJQu+dClNO0tHh2wUcONaNzMw==
X-Received: by 2002:a05:6a00:b4e:b0:736:34a2:8a20 with SMTP id d2e1a72fcca58-73905a2300cmr18173268b3a.21.1742795296466;
        Sun, 23 Mar 2025 22:48:16 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73906158ef2sm7170982b3a.141.2025.03.23.22.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 22:48:15 -0700 (PDT)
Date: Mon, 24 Mar 2025 11:18:05 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc: Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Brandon Cheo Fusi <fusibrandon13@gmail.com>,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: sun50i: prevent out-of-bounds access
Message-ID: <20250324054805.3x3nwl4vtvf63rwj@vireshk-i7>
References: <20250320155557.211211-1-andre.przywara@arm.com>
 <2772067.mvXUDI8C0e@jernej-laptop>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2772067.mvXUDI8C0e@jernej-laptop>

On 22-03-25, 08:38, Jernej Škrabec wrote:
> Dne četrtek, 20. marec 2025 ob 16:55:57 Srednjeevropski standardni čas je Andre Przywara napisal(a):
> > A KASAN enabled kernel reports an out-of-bounds access when handling the
> > nvmem cell in the sun50i cpufreq driver:
> > ==================================================================
> > BUG: KASAN: slab-out-of-bounds in sun50i_cpufreq_nvmem_probe+0x180/0x3d4
> > Read of size 4 at addr ffff000006bf31e0 by task kworker/u16:1/38
> > 
> > This is because the DT specifies the nvmem cell as covering only two
> > bytes, but we use a u32 pointer to read the value. DTs for other SoCs
> > indeed specify 4 bytes, so we cannot just shorten the variable to a u16.
> > 
> > Fortunately nvmem_cell_read() allows to return the length of the nvmem
> > cell, in bytes, so we can use that information to only access the valid
> > portion of the data.
> > To cover multiple cell sizes, use memcpy() to copy the information into a
> > zeroed u32 buffer, then also make sure we always read the data in little
> > endian fashion, as this is how the data is stored in the SID efuses.
> > 
> > Fixes: 6cc4bcceff9a ("cpufreq: sun50i: Refactor speed bin decoding")
> > Reported-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> 
> Thanks for fixing that!
> 
> Reviewed-by: Jernej Škrabec <jernej.skrabec@gmail.com>

Applied. Thanks.

-- 
viresh

