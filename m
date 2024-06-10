Return-Path: <linux-pm+bounces-8861-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 757BC901F74
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 12:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C0E71C20F0A
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 10:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C831578C7F;
	Mon, 10 Jun 2024 10:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qjrlVTFi"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5CA2C190
	for <linux-pm@vger.kernel.org>; Mon, 10 Jun 2024 10:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718015595; cv=none; b=iy7rgLQZHwCB7J8WASgQS9MNjNahn0vri5GGgXni/m7/+d+uL220CgKZ0nf5BNXqmTzu8hUknwKM7jE56hE2u+E9quK7rpKvMA/qydjximQt3lfjUeBVPB7AbeugBikJAW7L/7vPDIf7n4MxBOt2B3D95P0agZznsq322EJj8Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718015595; c=relaxed/simple;
	bh=EkPIbkjarwpfgELEUyotr9GR0hLk3jsKg0qKrAx7zHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JJC35Dfc+Y/wTDv9aQwFqZ7JudsNNRmAoMJ6qi/jkU9L3uUvd6Ufy7OsrbqSykPjk/I44bm3iPUdSDubwEuOwgWo7rqaey7FcJfWsE7+Y9QU7zxidraCeLR5DtVWgobWRmG+UTUC5OyNiNEVeL+bK5TVucgRpcMS9ho8Zhz/NUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qjrlVTFi; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-35f1dc4ab9aso1122620f8f.3
        for <linux-pm@vger.kernel.org>; Mon, 10 Jun 2024 03:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718015591; x=1718620391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TDdtAXRXBuNi1V9L3rXEpKUonTyInwdTZxeIaRFlTPs=;
        b=qjrlVTFizKQwfJBqnaV2BBKTwS5o0ihKcNf67kDGOePNEp7UGQ2qp84crvQdgUnmDD
         oahDjRRbwMa12LYjjGYzHklqQVb+MkVlzEGkMvaPHKFpo7nL/pBhFj6qUlKKTUx9ZGpG
         UzJJLp69+iVA5/Zz8D0S0ne5GfZ60LhiOIklhHHp4CT2Xg0j5J3DAMSrFyfp1FjMLRL3
         JyH/Gwvxt5oeta14GAHsTYERfTiZr6aaq8ktpLMV1fkHVu64oLVYNPYNv4EyVaSSMSSC
         jvlNLnuAQNnrBZxlMnBTdRDZ8hqAyLD0zASWIQcGGRspHc9ognt/38FocEkLTR0CQh5g
         NvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718015591; x=1718620391;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TDdtAXRXBuNi1V9L3rXEpKUonTyInwdTZxeIaRFlTPs=;
        b=BfxwDHvA6RZ7vmkGiwZtG8AAz6gcaZlyiejBAkCnofsecPX0ncSUjZ6tBj3YJCwbnH
         jVj5uM9onaaLHCrTPBEvRM35sDgWBxuQiMZu6gsqtBH3oWl3f178zs5pCyUr9sTkTprf
         SoLxe2e84u0dM4KboAUpjO2ZBQYb6PXsKPmqU5nEpfzKzT3yGKnVJAJ104Wn49yIk9bH
         gbYsr4gz5lsY93wnKZddHN4mp1ItwPekxXkgdibgQPL0+i+bNtGb+XkI3M7+j+EmfR0O
         bcTN9Rrr5WpaOk5TREpNFlQlys3elNaL6ddj6/4Zy+k68P1s0iShM/12gaiQwsgEoWlq
         WN4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVqnF4z133gfnMWkmWb93DNs8GaqJSFM5YYg20+ecRuR61e6szWEAwMvnDYDFd98DtcKkdHMwBYYj4FT7n71SLd8DVICIw09U8=
X-Gm-Message-State: AOJu0Yx73zhocdcSY2FmFsxQRqPbsPeL3R6v26yNWMuZolDS0pUeMybZ
	rsIRryRmzJMCbEKAYUnUVOgQHd8fdhSE7M2qBXK1/o8FriLjkck6W/Ky4qGZ2oaOlpAfPwvdM3v
	4
X-Google-Smtp-Source: AGHT+IEunBvI1y6Ruwh6t/2MgDUUPlPhj4yUhiC+IYUlaEH4Q/v8giidh9vTQPWqGBGgF1Yvxln4ig==
X-Received: by 2002:a5d:59a5:0:b0:35f:2947:e30a with SMTP id ffacd0b85a97d-35f2947e34bmr564545f8f.46.1718015591312;
        Mon, 10 Jun 2024 03:33:11 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:bb3:9a3a:605f:c4c3? ([2a05:6e02:1041:c10:bb3:9a3a:605f:c4c3])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-35f1f109346sm3913873f8f.27.2024.06.10.03.33.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 03:33:10 -0700 (PDT)
Message-ID: <901c5f6e-b873-4540-8238-2eb21b85689c@linaro.org>
Date: Mon, 10 Jun 2024 12:33:10 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] thermal/debugfs: Compute maximum temperature for
 mitigation episode as a whole
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <5794974.DvuYhMxLoT@kreacher> <2279190.iZASKD2KPV@kreacher>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2279190.iZASKD2KPV@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/05/2024 16:58, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Notice that the maximum temperature above the trip point must be the
> same for all of the trip points involved in a given mitigation episode,
> so it need not be computerd for each of them separately.
> 
> It is sufficient to compute the maximum temperature for the mitigation
> episode as a whole and print it accordingly, so do that.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Indeed... :)

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


