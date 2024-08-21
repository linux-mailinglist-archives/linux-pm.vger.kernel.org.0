Return-Path: <linux-pm+bounces-12641-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A95D5959E90
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 15:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D84BE1C21DE8
	for <lists+linux-pm@lfdr.de>; Wed, 21 Aug 2024 13:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16220199939;
	Wed, 21 Aug 2024 13:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g7hqRFNR"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A013196C86
	for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 13:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724246634; cv=none; b=RGy/FSXKUdq7skDyHqijFgYlkciYMqEtrwTMSwgX/p1jAJ7zTkh2w3p6BauRoIQZnCQMnw4NbhMqbZUOP1l8sXX822dT7a1GzHLZ9cHmaj/q1sULV6uIBqbXdR2tWjmFf0sr9ayoZrKuYoIWiZGdtZeDDubRW9kEJ16PiEoqCLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724246634; c=relaxed/simple;
	bh=1pr66jIBS64x70arVwnLavlWAlzk36uz+N67v9T/qus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EDmKgRNg59msTX2c6YXEbJRrl3YdUci5exjoKMBtNT1FivBhRhhHeH1EFmInXWJCisUMe1ejUVBYvDq6v0fANVQf2mMs1VnJmA3ZlQPGYWKJ5MLfiDjNrTobkRUN01SfBFFjR2vItGel1HxpYICKxOczCBWZH/UHo0LdOVPw9jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g7hqRFNR; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-371afae614aso2586792f8f.0
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2024 06:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724246631; x=1724851431; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VCciJi7JxhAf6KSqjag5dJ/2hYHxSDXbm3lJCm4J8IQ=;
        b=g7hqRFNRd1AL9Sev+8ZwnH+uqlTSSDS85vIUDwUGA7hLQeaVRJnC9PII29LFZMQarq
         iQ2oUBKGmplLUzJJ+0mVZk/HvL3il+gz67yLTwODdJJx/rj+h30Zr6vuQ29dMkClFWGx
         bxBuZykdIKsDZ7k0AzQ1ftT4IPtQvKnFtQ+CoAUZIgm+caZSCTDM5ic+/M6IURr4/lOg
         YvTqBOBamAN+nSKUEN/udGOkFy2tZWQdOQjezCqHC/LL81CcxZnE9Rmlxo5j6I4t0CYa
         ybwj+HPqbuVC6KADV38djuOeBk0VpU138PKPWrrMvOULfZ5By8p39bbGMFUrFm9imoM3
         q7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724246631; x=1724851431;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VCciJi7JxhAf6KSqjag5dJ/2hYHxSDXbm3lJCm4J8IQ=;
        b=UhCvKMeE14odao73GXgSqlTesRYh3sJZ8RDuCpEhyGDrkZBF+UosVy4VUwGzYH+AV4
         qSz6Ywt73pEWZdsFIh+IRL21N0GvHHw8xw0G8FxthngIx7EGIdyAFdJBzgTM2vxD8IWb
         9QKHLHHNfyuGXdLvIX1JP/+mrQovgeQLy8/vCZbp8KhaG3Ljm3alb1zfrwVjqayj3sH1
         MJY9vj2gySmUA2lijzNAtEQRqJ9VuV6IxgiMk9VCrXdGTilerYAVPukzZCril+uiI/iH
         hj7p88BUXvGgVro0G89HIuHR0N/p50VTaRT1zhqsCRW1OSIx7EG8bDPKIjUpCzutKpa0
         21JA==
X-Forwarded-Encrypted: i=1; AJvYcCWJIklJM+J1yroxldR8kRzwRnIwRKH0Sqb2z9SwPdiq/WIqr6I9nyjcLzWz3omKBYVGDh56FqA4ig==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5HnuLtCMaTx4pvWUcyjY719s25i5soZDQIEK5WhKA3tGrc2bm
	ERcj9KkIX5CCawx5bmSIJ2SM45yzuxZCDmd8et7tKnFIEfRfdjMvNPCgWP5xXO2+PEH25R8dMd9
	s
X-Google-Smtp-Source: AGHT+IFGE/94UIJXOsrMVfuezmbmwIz0XQedE5AWhGbI7EeyHlwUXExDdcnc2vdbCQ3Aes/LvDehyg==
X-Received: by 2002:adf:e6c4:0:b0:371:8db9:939e with SMTP id ffacd0b85a97d-372fd82f0f2mr1355829f8f.51.1724246630296;
        Wed, 21 Aug 2024 06:23:50 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37189856b07sm15710219f8f.50.2024.08.21.06.23.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 06:23:49 -0700 (PDT)
Message-ID: <da3edca6-dc7a-4ec4-8cde-3bdc95cea48d@linaro.org>
Date: Wed, 21 Aug 2024 15:23:49 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/14] thermal: core: Unexport
 thermal_bind_cdev_to_trip() and thermal_unbind_cdev_from_trip()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Zhang Rui <rui.zhang@intel.com>
References: <2205737.irdbgypaU6@rjwysocki.net>
 <3512161.QJadu78ljV@rjwysocki.net>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3512161.QJadu78ljV@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/08/2024 18:05, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Since thermal_bind_cdev_to_trip() and thermal_unbind_cdev_from_trip()
> are only called locally in the thermal core now, they can be static,
> so change their definitions accordingly and drop their headers from
> the global thermal header file.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

