Return-Path: <linux-pm+bounces-6937-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5198AEB20
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 17:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF39C1C21D0D
	for <lists+linux-pm@lfdr.de>; Tue, 23 Apr 2024 15:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB9A13BC33;
	Tue, 23 Apr 2024 15:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vNNfGft1"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B93013776F
	for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2024 15:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713886258; cv=none; b=sV/bENyNm0z0qUGWqmNZE+SINOlHNRJprh7xws75hMmr0w634TQVMypQ97qODTHR29TEnNT6DO/LRloUtA+Uel0VIFEQnNFA+O3KTBU+GBThKpdGN+IbbgJD9UUoI2cIzIcVel/x9OaXFDfYA5DYprg6ZNP4eby/4AH4YHrzhxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713886258; c=relaxed/simple;
	bh=NWSeoGq1TEN1U+n1nyMzbI0fbW1qDCiduKMQPey7Iv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kRQrYzbjbZ14w4UhQpmTMly7HAIM8QqrfxpIaKWdyM5TcZUXGmDHsae0gVGSZ5KIjfSqy/eWM8sSQQuZSz0rfvdnpk97H6vxP5wSyeNW9QM5HuBJT5tABDPfIBIkny1zyG5ez4iCfKqgBql8mz9th6O2zKFNoEM13sFaDmAX32M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vNNfGft1; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41ae95468efso423285e9.2
        for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2024 08:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713886256; x=1714491056; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wunMT8BtUYunQ5ZQ9XvrfL95oO+APrTWziOgsDUBArs=;
        b=vNNfGft1kwAmqpanj16khBEdFnVLTnAYJuj5fsvT5N/vT41n42o7cDHHx13InhJ45V
         aV1heUKJB7Bf5DOoXnknm0LvgN+EF2PxbJoKLqkv5qzSGpOvL/SnxEmPfe4RlY6qte5X
         yjiVvohIU08y1C8ocy6IaOWmBJW/dqYNgzcrLTktzO/y5Cq7OXHSN97VbIcuRPzMtOrE
         VOeTLMyxzHdPBPwf7QICV8ViOHXVLs5yeqYqBjtL47g8zGMsw16C0UI/oVyon0GWUiM7
         CtBfja6DYTw5CvMR15jWN/gSmYzo2/STDTIxnZ0NtzF+zN1cOeAmldLOFExD/MyVnGRH
         PSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713886256; x=1714491056;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wunMT8BtUYunQ5ZQ9XvrfL95oO+APrTWziOgsDUBArs=;
        b=ZHutguiydF243hXnamB7eCcKoiDm3F9y5eq3J6hSEUdmHMgUIRisXGv6DHmHt8pYjc
         63E6AQhWWyTTNatRGa/9sHw+ehQLPtn9ZnCKLnoVI4kvZF0Q1k8jUVX/BE2w9+ZcCvBU
         U8v+YUJe8RFi8AI1zVZIp79OKieMzknfyxTGcW7t25HxkVNe+K/WeXEXOVY1muuLXFkB
         Xv9qEMxBlobtzBaKuOyKFM+fekFdpW6i7Wn/em2Ai89WuiGSIvtnHq3UGDCFmf9ea+Vr
         vk0kEitTwuZasfJilq7s81LfVv4IK6d4sdLyyjwwgiRSIPO5mSxksRMo8kMg4PR5EvOi
         RZKA==
X-Forwarded-Encrypted: i=1; AJvYcCX9PTSYCJWpCEWBRnskquPddbvQOTZXIZS7aBHE+vYrMI+K3MzlmIxRBPG3p8/pYH1fM5GIbLz/RW0bNMii0DqEQDJ0jEQj+WU=
X-Gm-Message-State: AOJu0YwdL4HtYGbPI/461bmIirvOgF8K9Ph25E16PU8iOsbD8zf2pdna
	H1BVmeBTTgA9bZQGQPB/Kc02Hwvn1DF3dYMjh6CZud917vmvuQafFoxXyJrJCYo=
X-Google-Smtp-Source: AGHT+IHiY2iju4KbgBOmWnX+VMAd7oFJfls98P6TP28t6iV+8wPaeKtS5pYAkfLDbQno8M9mZMyVyg==
X-Received: by 2002:a05:600c:4fce:b0:41a:4819:ebf4 with SMTP id o14-20020a05600c4fce00b0041a4819ebf4mr6383611wmq.39.1713886255729;
        Tue, 23 Apr 2024 08:30:55 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id w17-20020a05600c475100b004162d06768bsm24418293wmo.21.2024.04.23.08.30.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 08:30:39 -0700 (PDT)
Message-ID: <dc6c32fd-89b2-4494-ac26-588adb3ee578@linaro.org>
Date: Tue, 23 Apr 2024 17:30:32 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] thermal/debugfs: Rename
 thermal_debug_update_temp() to thermal_debug_update_trip_stats()
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <4918025.31r3eYUQgx@kreacher> <2937506.e9J7NaK4W3@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2937506.e9J7NaK4W3@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/04/2024 15:11, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Rename thermal_debug_update_temp() to thermal_debug_update_trip_stats()
> which is a better match for the purpose of the function.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


