Return-Path: <linux-pm+bounces-8849-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA4C901DAE
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 11:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 654A71C21225
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jun 2024 09:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C67682862;
	Mon, 10 Jun 2024 08:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QsO458Bh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BE2823A9
	for <linux-pm@vger.kernel.org>; Mon, 10 Jun 2024 08:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718009963; cv=none; b=YFGo4qoNg2JbKtC2ZqbNyB2rQyMlPaMYiSu2v7+znpQAbj2f8PotGKwYGKVsyWPLlDYgez4X0XwzGbzw8tOhMEojRHUcOOVFjaJK7O5Nmd+efvc9z02CXRX7ju0CfOgbgJpdbntnpJL6961gLgoYSIkiWlOpaACZnwyQUVk7v7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718009963; c=relaxed/simple;
	bh=vHneDFUBNs0GqnfTI6Q7Qcn+foJQXhLeHMKZSlyD3T8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ViKNr7wBRjY9VVeH7XS89I8eB0tWGvWjZE9ejIIq1dQMIDpMrmHudOxlopCfftaYhul0rrisLljGaFP9TcAytqJhE/5KIcSLQsq0ZdNjMSlJ/0UAzUPwebWmGV7os0VI/m5r4Du3hCHVMGHZujx/ejzZz5t1vzxHFh6AmI5o4S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QsO458Bh; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42138eadf64so35871335e9.3
        for <linux-pm@vger.kernel.org>; Mon, 10 Jun 2024 01:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718009959; x=1718614759; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VvSu55HWnwB5FrLzdsKEOL90pn7dtAat3/WOLZaHz4c=;
        b=QsO458BhIkRDEeNxOpbXcA/hsD4PLvekklndhhaGCcmfSH5pNZ0l7F1edVIYHcYi2/
         b5SKvI8+Td75JjUkC62tFgdbhPhukYnZyBs2YVtTftdMErC5mFvp4yT4bU/wlLK58bgf
         XGLPn00idANzRESNoWr/gyrzqr7n4Soy1RiDC5tZ+Aju22/bHSqlryHL2y/mAvnDcLsO
         hbaVU2j61i+amhv0QvDbNpX6QgynLm/gZiVTegOI7zQl6VCDL07De47d13oV8MpKxSSm
         eeUW0TbyEKZu1p7fh4iDK83dRF8xCSFTwqCzP0c84MFsmT6/g6VEiSjhi208kWg1LFiF
         uQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718009959; x=1718614759;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VvSu55HWnwB5FrLzdsKEOL90pn7dtAat3/WOLZaHz4c=;
        b=k1caBW2onClw5GBE6tnnk1uZ9QyMPl4AdfBjhj02SiHdMXM3eA5QgwS2A6hb9wplKU
         h4ErtwHwhWkaC39cy+1U4XoBv8ZyDZHQ4duOpXW+E/wuEwNeiG8L4KdzuU2jvMI2zCJ0
         BiNR2MBMLlxZC8w5XCD1wT+db0vdApuY3Z2/ricb/WvqR5z3t/VUE+vlRii0f+E/2OkK
         CvQz/ZmERU6dgl8kctowZU8slwojx/Q38XJJ9WLVNub4mRNt7Da89b98DhLo5XILmJwp
         P8gHyGiJuCf8cY0eyfka3iyBJ1V6RocJqvhh3L9BGVHA+Eew4olEI5hhE1z0ymHF9Ngw
         4B2Q==
X-Forwarded-Encrypted: i=1; AJvYcCV6S45Zh1WxQBoBsvFAhB/yGhbYobNw2vNot5eY3+faCxwe/jdlqFq2fTgIN09dazyTsInmMf0Awe2+0wg72cpBEQLr5PGlUcg=
X-Gm-Message-State: AOJu0Yxhf9o9HIlsl5pELUtm+ss/APC0Bpn31L4zmppIkU6ZitWSxtPA
	Upb4tZNitCdvtvQ/DT95DIxv2DqWDiDs7cGboEt+AzcUbYVVk6OogOKqClwTfaM=
X-Google-Smtp-Source: AGHT+IHgamB6ykVfBUAH6mSf0Uvt0ewso3ix2AMmR+6+4Uj9SJGPp1d1Wu+SEngslWbR4dwQwvPXNg==
X-Received: by 2002:a05:600c:a01:b0:421:6475:abee with SMTP id 5b1f17b1804b1-42164a038b6mr68198995e9.23.1718009958670;
        Mon, 10 Jun 2024 01:59:18 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:bb3:9a3a:605f:c4c3? ([2a05:6e02:1041:c10:bb3:9a3a:605f:c4c3])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4215c2cd247sm138237425e9.40.2024.06.10.01.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 01:59:18 -0700 (PDT)
Message-ID: <ad4f1cfb-28f0-4d80-8c0b-dc42b01ecfa7@linaro.org>
Date: Mon, 10 Jun 2024 10:59:17 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] thermal/debugfs: Adjust check for trips without
 statistics in tze_seq_show()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <5794974.DvuYhMxLoT@kreacher> <8389302.T7Z3S40VBb@kreacher>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <8389302.T7Z3S40VBb@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/05/2024 16:57, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Initialize the trip_temp field in struct trip_stats to
> THERMAL_TEMP_INVALID and adjust the check for trips without
> statistics in tze_seq_show() to look at that field instead of
> comparing min and max.
> 
> This will mostly be useful to simplify subsequent changes.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


