Return-Path: <linux-pm+bounces-3955-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C59AD8563EB
	for <lists+linux-pm@lfdr.de>; Thu, 15 Feb 2024 14:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 649551F272D1
	for <lists+linux-pm@lfdr.de>; Thu, 15 Feb 2024 13:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E510912F399;
	Thu, 15 Feb 2024 13:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DOvo74tt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2AE12BF06
	for <linux-pm@vger.kernel.org>; Thu, 15 Feb 2024 13:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708002197; cv=none; b=RP+exhmeWyTPNq6nLvjgNeXMbyW401iAjKxqJO3HQkZJMTL7gR6bVgJvmXx1tpdT30KcnRm10wukRAQqUqTGqqlUoVMVfEB1svBasPdFiB5MjraT/faTN9P2PPHH7Io74PE7rrtuTrpkWe6o9M89XuCmMjq5R+Ouy10+EDki09I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708002197; c=relaxed/simple;
	bh=wvApUvfsPpkye9qYeykoXI5vL0JTgpBbmDj74OcOvPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DNUo4veQo4TUjb2qtcQ+pKw052oYa8q0ez7AiXQOPBi2AV6fMpZfqAQKYlk6YEjeUsN7ZjrmWAFNCcdyresclGYGh7XYa9Ty/OnMPiyO4gCbpWx2H2yo9VnvKMKb7F129XPE1e+Q4z4EqROBnDSiNf5aV7MrmGZX6xeu4jkepjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DOvo74tt; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-561587ce966so1639662a12.1
        for <linux-pm@vger.kernel.org>; Thu, 15 Feb 2024 05:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708002194; x=1708606994; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n8gYmBFcHw+PMY96x5bP3A9cd014PWA82CxsQ116n3w=;
        b=DOvo74ttYJXFE5QYwDSwhbdcE6tiAKN52LHK4SPzIqCYyP3lq0FQPoYn5LREmZS00n
         Ia87DTYD02PzLVSg0/u8AL4R2D2sOMCTiQqfux5ad0+aMOAKKrvz0SNmcMwTUfnt+cFJ
         g9CSRXosQDmO+q4AprRoLPek8JpOVHXC8n3UuZ/SOv8LHg/oYy5biLPTJvqfXmHEHRMZ
         sbZSQMXT1io0mrzI+bNkaKKOERyc+GWQD6iiwatZlNqw9cOwLf5uAewCjkaIuSib6SEK
         V/hzwaLCiaWN85VbT35XqceVp52+b+eJXNtEvHkGNdp58nuw1U2C7Ifz7vieoGYGe+fw
         SVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708002194; x=1708606994;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n8gYmBFcHw+PMY96x5bP3A9cd014PWA82CxsQ116n3w=;
        b=csjkHtNG4wNaArqFFAtC4YkzIiCt4d0ZkESwdA8ry8xEFoavq9uvQUvcW3hTlRmvZP
         dbIzMYCktbQZRnK4i0RKLL+wFRoyvDP+B6RRbqhSFUPaczdOwcWa43zDRocbyHxnbmAY
         vKm0O07bEzoPUnv+yDCBZxJsmVAR27zKtxi7wNJc7ELXbNGoY5BH20kSd4PyOmXyn7yE
         UbsU9CPURZXO9nh1x7BTVNg82nPrbiFzTkNfXSB4WyNDP+x7sLqPO/qQ+HcavW18Zcv0
         j6Q/6n4lDTwF3WGeRFb9Mpw/whs6TECW8Oa6+kUKkOUclskqUkr7wVvQ1+2D4hiAxRYe
         fiiw==
X-Gm-Message-State: AOJu0YzIg1xyLpSrY7mtNnXYpt5wHTlO1itKroXQZZjOSkTMZFcRgYv4
	oj1bAvWQP2aa82u7klkQrJhVihNqmDVBlS7IwVYWYUtYEoc3NeoKvH64arfqs/cSiPX35avkDhy
	l
X-Google-Smtp-Source: AGHT+IEb+RndYySUvLziRX7ktIL1fHsO13e6I5nTzg2PeebZxffYPxzn2nhNVF5dHx9ZFPWdwJfmzA==
X-Received: by 2002:a05:600c:3591:b0:412:41:bb3d with SMTP id p17-20020a05600c359100b004120041bb3dmr1648825wmq.3.1708002181939;
        Thu, 15 Feb 2024 05:03:01 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id fc10-20020a05600c524a00b004120c78fc39sm2387969wmb.3.2024.02.15.05.03.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 05:03:01 -0800 (PST)
Message-ID: <00d0beb5-6800-418d-be1a-89e32b867fb3@linaro.org>
Date: Thu, 15 Feb 2024 14:03:00 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] thermal: Drop spaces before TABs
Content-Language: en-US
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <480478a53fd42621e97b2db36e181903cc0f53e3.1708001426.git.geert+renesas@glider.be>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <480478a53fd42621e97b2db36e181903cc0f53e3.1708001426.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/02/2024 13:51, Geert Uytterhoeven wrote:
> There is never a need to have a space before a TAB, but it hurts the
> eyes of vim users.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>    - Drop change to removed drivers/thermal/st/st_thermal_syscfg.c.
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


