Return-Path: <linux-pm+bounces-8596-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7489A8FBAD0
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 19:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 289F31F22111
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2024 17:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD47A14F9DC;
	Tue,  4 Jun 2024 17:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dZ3ClPgP"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0611014F129
	for <linux-pm@vger.kernel.org>; Tue,  4 Jun 2024 17:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717522975; cv=none; b=j36ZqrEw1v17UwutcvWxkZNg9fzjwe/mLHBjwYMS2bz+A0t6PaZNOWOPDfVMj2+AQdvM0I3uDDqBK4OVEkebvi70Mki7kAD7b58J1crujEd+fsTDY+gMtdbemdIn4pkHhHTDULNfOVWQJ6Im+gxubGKbN/sBB2HIBSVBXx5khdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717522975; c=relaxed/simple;
	bh=OLqVA6Lr6AXWA6PthG7ToqVqZCJe1M5rtwRfWlo6chI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dfUuaIm/7X7p2L/jbn8MIEDMOi6tpzovlVo9jNVMtLA3QWssi4WwZ2/kpPrrfF4AHNXhCipgoGCgjGzHuawItZ5cd7C+wkgZJNUybegWbYkp5k8tQczwS4dRh2dt3dvpEYVHednBcnanRndMhMTK6JwlZ3tJkjB6QgecaNgECN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dZ3ClPgP; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-35a264cb831so5336361f8f.2
        for <linux-pm@vger.kernel.org>; Tue, 04 Jun 2024 10:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717522972; x=1718127772; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CUDUkB0yPn3kyHBF8xhR/h1d7c4PgjXWcM1OaQiMS8E=;
        b=dZ3ClPgPlMkvZka/mvj1zRu0KZs9YYMnNkTGTXpXUiIKUAswye6mAaWB9iKPrgoii5
         INoKh2JwMTizK+BfPjr0hRsQpjlTDUPLNyTkgEyrzpkCaeG5AUnD0j0WsYThMJ0oN4Vn
         FhJUCzpUejU3mLCtTcZ0tVlDerl+gmzs/gaxJv+/0+GA5yDAgQ8jGASfiiDet0xxKVdy
         /b2DQQehKoCOukUEiQp3DgcW62OlQjKoiCdP2uQRUzUq/K0umH6YcZ6kem6YWv0Gzoga
         DYXJqH+Ycn9e6PqyNd+77U8I7/85jjP4CQuPHgULdrJstEVlovu1GWee1N+VH1aX5Frn
         +TDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717522972; x=1718127772;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CUDUkB0yPn3kyHBF8xhR/h1d7c4PgjXWcM1OaQiMS8E=;
        b=nwbc1pyzCu7a1tUmx1AqGvbEGx9txcl/S7gw9yvpbjlktHLh2qpe7MEMEXGNvxAGbN
         8GpqmxOYNe/sJJHxOEkRqwn+9J6PIAV5Fm+rhqmjv9u/3Do2wxfwo/7E/w1wNyYtKfN0
         ZTHBKlNbtNMIR2IA1BdD6buVU0TsZGkqIdWfuOICS78sCDqAO5CsLoLrlxOLy5hj/t4G
         fzkFrZAlnzhcVJeK/dOOgLWvs20TJmGojM6xJ3WoeQV2KcEV/H4w3lzqgytU1jFhA/5H
         4kitTDlhwgBJO8R+N1uVE+rtY6rbt8+fvaiERrMc8T6ZwTFkGNM0T5xpUKMSGNYN1RUW
         Aw8g==
X-Gm-Message-State: AOJu0Yz6n2vGUX/UaEE0FXE0IPLLq7jH9m3bLelqAIKd5qTysWTyRlMn
	c+CjPTmuOy1i9/VRhvrI3aCulBlA+Z/tw2GFSsC4Z8E9GPrqVhRE4uWeiREDJO4=
X-Google-Smtp-Source: AGHT+IGhKXEdUROFwRvvnHW7fRzNnhSf3T/ROeeU1mS/Kbg505utfgtM14I+vys8Mdd+aRFjeUo0sg==
X-Received: by 2002:a5d:64e4:0:b0:35e:8099:67f with SMTP id ffacd0b85a97d-35e840677edmr121290f8f.16.1717522972206;
        Tue, 04 Jun 2024 10:42:52 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:e559:5ee:5c4:82bc? ([2a05:6e02:1041:c10:e559:5ee:5c4:82bc])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-35dd0633791sm12267406f8f.72.2024.06.04.10.42.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 10:42:51 -0700 (PDT)
Message-ID: <44ec6537-7217-4fb5-af1c-900de7b2a97e@linaro.org>
Date: Tue, 4 Jun 2024 19:42:51 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] thermal/drivers/mediatek/lvts_thermal: Remove filtered
 mode for mt8188
To: Julien Panis <jpanis@baylibre.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Nicolas Pitre <npitre@baylibre.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240516-mtk-thermal-mt8188-mode-fix-v2-1-40a317442c62@baylibre.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240516-mtk-thermal-mt8188-mode-fix-v2-1-40a317442c62@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16/05/2024 12:44, Julien Panis wrote:
> Filtered mode is not supported on mt8188 SoC and is the source of bad
> results. Move to immediate mode which provides good temperatures.
> 
> Fixes: f4745f546e60 ("thermal/drivers/mediatek/lvts_thermal: Add MT8188 support")
> Reviewed-by: Nicolas Pitre <npitre@baylibre.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Julien Panis <jpanis@baylibre.com>
> ---
> Filtered mode was set by mistake and difficulties with the test setup
> prevented from catching this earlier. Use default mode (immediate mode)
> instead.
> ---

Applied for v6.10-rc3

Thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


